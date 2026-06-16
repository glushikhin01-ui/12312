-- File: lua/autorun/server/z_badmin_warn_system.lua

if (SERVER) then
	util.AddNetworkString('ba.ViewWarns')
	util.AddNetworkString('ba.ManageWarn')
	util.AddNetworkString('ba.RefreshWarns')

	local function SendToDiscord(embed)
		if not Discord or not Discord.send then
			print("[Badmin Warn System] Discord.send не найден, логи только в консоль")
			return
		end
		
		local payload = {
			username = "Логи Варнов",
			avatar_url = "https://i.imgur.com/j3A4c9G.png",
			embeds = { embed },
			__webhook_override = Discord.warn_webhook
		}
		Discord.send(payload)
	end

	net.Receive("ba.ManageWarn", function(len, pl)
		if not pl:IsAdmin() then return end
		local action = net.ReadString()
		local warnID = net.ReadInt(32)
		
		if action == "remove" then
			local db = ba.data.GetDB()
			db:query_ex('DELETE FROM ba_warns WHERE id = ?', {warnID})
			
			local embed = { 
				title = "Варн был снят вручную", 
				color = 3066993, 
				timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"), 
				fields = { 
					{ name = "Действие выполнил", value = pl:Name() .. " (`" .. pl:SteamID() .. "`)", inline = false }, 
					{ name = "ID варна", value = warnID, inline = false } 
				} 
			}
			SendToDiscord(embed)
			net.Start("ba.RefreshWarns")
			net.Send(pl)
		end
		
		if action == "edit" then
			local newReason = net.ReadString()
			local db = ba.data.GetDB()
			db:query_ex('UPDATE ba_warns SET reason = "?" WHERE id = ?', {newReason, warnID})
			
			local embed = { 
				title = "Причина варна была изменена", 
				color = 1752220, 
				timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"), 
				fields = { 
					{ name = "Действие выполнил", value = pl:Name() .. " (`" .. pl:SteamID() .. "`)", inline = false }, 
					{ name = "ID варна", value = warnID, inline = false }, 
					{ name = "Новая причина", value = newReason, inline = false } 
				} 
			}
			SendToDiscord(embed)
			net.Start("ba.RefreshWarns")
			net.Send(pl)
		end
	end)

	ba.cmd.Create('Warn', function(pl, args)
		local targ = player.GetBySteamID64(ba.InfoTo64(args.target))
		local reason = args.reason or "Причина не указана"
		local target_steamid64 = ba.InfoTo64(args.target)
		
		if targ == pl then 
			pl:ChatPrint('Вы не можете выдать себе варн!') 
			return 
		end
		
		local db = ba.data.GetDB()
		db:query_ex('INSERT INTO ba_warns(steamid, admin_steamid, reason) VALUES(?, "?", "?")', {target_steamid64, (IsValid(pl) and pl:SteamID() or 'Console'), reason}, function()
			db:query_ex('SELECT COUNT(*) as warn_count FROM ba_warns WHERE steamid = ?', {target_steamid64}, function(data)
				local warn_count = tonumber(data and data[1] and data[1].warn_count) or 0
				
				ba.notify(pl, "Вы выдали варн игроку #", targ and targ:NameID() or ba.InfoTo32(args.target))
				if targ then 
					ba.notify(targ, "Вы получили варн от администратора #. Причина: " .. reason .. ". У вас " .. warn_count .. "/5 варнов.", IsValid(pl) and pl:NameID() or 'Console') 
				end
				
				print("[BAdmin] " .. pl:Name() .. " warned " .. (targ and targ:Name() or args.target) .. ". Reason: " .. reason .. " (" .. warn_count .. "/5)")
				
				local embed = { 
					title = "Выдан новый варн", 
					color = 15158332, 
					timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"), 
					fields = { 
						{ name = "Нарушитель", value = string.format("%s\n`%s`", targ and targ:Name() or "Не в сети", util.SteamIDFrom64(target_steamid64)), inline = true }, 
						{ name = "Администратор", value = string.format("%s\n`%s`", IsValid(pl) and pl:Name() or "Console", IsValid(pl) and pl:SteamID() or "Console"), inline = true }, 
						{ name = "Причина", value = reason, inline = false }, 
						{ name = "Всего варнов", value = warn_count .. "/5", inline = false } 
					} 
				}
				SendToDiscord(embed)
				
				if warn_count >= 5 then
					local steamid = util.SteamIDFrom64(target_steamid64)
					local target_name = targ and targ:Name() or steamid
					
					RunConsoleCommand("ba", "setgroup", steamid, "user")
					
					local message = string.format("Игрок %s был автоматически разжалован за достижение 5/5 варнов.", target_name)
					PrintMessage(HUD_PRINTTALK, message)
					ba.notify_all("Игрок # был автоматически разжалован за достижение 5/5 варнов.", target_name)
					
					print("[BAdmin] " .. target_name .. " was automatically demoted to user (5/5 warns)")
				end
			end)
		end)
	end)
	:AddParam('player_steamid', 'target')
	:AddParam('string', 'reason', true)
	:SetFlag('q')
	:SetHelp('Дать варн игроку')
	:AddAlias('warn')

	ba.cmd.Create('Unwarn', function(pl, args)
		local target_steamid64 = ba.InfoTo64(args.target)
		local db = ba.data.GetDB()
		
		db:query_ex('SELECT id FROM ba_warns WHERE steamid = ? ORDER BY id DESC LIMIT 1', {target_steamid64}, function(data)
			if not data or not data[1] then 
				ba.notify(pl, "У игрока # нет варнов.", util.SteamIDFrom64(target_steamid64)) 
				return 
			end
			
			local warn_id = data[1].id
			db:query_ex('DELETE FROM ba_warns WHERE id = ?', {warn_id}, function()
				local targ = player.GetBySteamID64(target_steamid64)
				
				ba.notify(pl, "Вы сняли последний варн с игрока #", targ and targ:NameID() or ba.InfoTo32(args.target))
				if targ then 
					ba.notify(targ, "Администратор # снял с вас последний варн.", IsValid(pl) and pl:NameID() or "Console") 
				end
				
				print("[BAdmin] " .. pl:Name() .. " removed last warn from " .. (targ and targ:Name() or args.target))
			end)
		end)
	end)
	:AddParam('player_steamid', 'target')
	:SetFlag('l')
	:SetHelp('Снять последний варн')
	:AddAlias('unwarn')

	ba.cmd.Create('View Warns', function(pl)
		local db = ba.data.GetDB()
		db:query('SELECT id, steamid, admin_steamid, reason, UNIX_TIMESTAMP(timestamp) as timestamp FROM ba_warns ORDER BY timestamp DESC', function(data)
			net.Start('ba.ViewWarns')
			net.WriteTable(data or {})
			net.Send(pl)
		end)
	end)
	:SetFlag('l')
	:SetHelp('Посмотреть все варны')
	:AddAlias('viewwarns')

	hook.Add("PostGamemodeLoaded", "DBCreateWarns", function()
		local db = ba.data.GetDB()
		db:query([[CREATE TABLE IF NOT EXISTS `ba_warns` ( 
			`id` int(11) NOT NULL AUTO_INCREMENT, 
			`steamid` bigint(50) NOT NULL, 
			`reason` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Причина не указана', 
			`admin_steamid` varchar(50) COLLATE utf8_unicode_ci NOT NULL, 
			`timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, 
			PRIMARY KEY (`id`) 
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;]])
		print("[BAdmin] Warns table created/verified")
	end)
end

if (CLIENT) then
	local fr
	net.Receive('ba.ViewWarns', function(len)
		local tbl = net.ReadTable()
		if (IsValid(fr)) then fr:Remove() end
		
		fr = vgui.Create('DFrame')
		fr:SetSize(900, 600)
		fr:SetTitle("Таблица всех варнов (ПКМ для управления)")
		fr:Center()
		fr:MakePopup()
		fr:SetDraggable(true)
		
		local list = vgui.Create('DListView', fr)
		list:Dock(FILL)
		list:SetMultiSelect(false)
		list:SetHeaderHeight(25)
		list:AddColumn('ID', nil, 50)
		list:AddColumn('Игрок', nil, 200)
		list:AddColumn('SteamID', nil, 150)
		list:AddColumn('Причина', nil, 250)
		list:AddColumn('Администратор', nil, 150)
		list:AddColumn('Дата', nil, 150)
		
		for k, v in pairs(tbl) do
			local ply_name = steamworks.GetPlayerName(v.steamid) or "Не в сети"
			local admin_name = v.admin_steamid == "Console" and "Console" or (steamworks.GetPlayerName(v.admin_steamid) or "Не в сети")
			local line = list:AddLine(v.id, ply_name, util.SteamIDFrom64(v.steamid), v.reason, admin_name, os.date('%d.%m.%Y %H:%M', v.timestamp))
			line.WarnID = v.id
		end
		
		list.OnRowRightClick = function(self, lineID, line)
			local warnID = line.WarnID
			if not warnID then return end
			
			local menu = DermaMenu()
			menu:AddOption("Снять этот варн (ID: " .. warnID .. ")", function() 
				net.Start("ba.ManageWarn")
				net.WriteString("remove")
				net.WriteInt(warnID, 32)
				net.SendToServer() 
			end)
			menu:AddOption("Изменить причину", function() 
				Derma_StringRequest("Изменение причины", "Введите новую причину для варна ID: " .. warnID, "", function(newReason) 
					net.Start("ba.ManageWarn")
					net.WriteString("edit")
					net.WriteInt(warnID, 32)
					net.WriteString(newReason)
					net.SendToServer() 
				end) 
			end)
			menu:Open()
		end
	end)
	
	net.Receive("ba.RefreshWarns", function() 
		RunConsoleCommand("ba", "viewwarns")
	end)
end