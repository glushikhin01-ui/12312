--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

	util.AddNetworkString("ba.openRatingPlayer")
	util.AddNetworkString("ba.closeRatingAdmin")
	net.Receive("ba.closeRatingAdmin", function(len, ply)
		if !ply.ratingUsing then return end
		local admsid = net.ReadString()
		local admname = net.ReadString()
		local admrate = net.ReadFloat()
		local db = ba.data.GetDB()
		if admrate == 0 or admrate > 5 then
			ply.ratingUsing = false
			return
		end
		if player.GetBySteamID( admsid ) then
			ba.notify(player.GetBySteamID( admsid ), "Игрок, которому вы разобрали жалобу оценил вас на " .. admrate .. " баллов!")
		end
		db:query('INSERT INTO ba_rating(steamid, nameid, rate) VALUES(' .. util.SteamIDTo64(admsid) .. ', "' .. admname .. '", ' .. admrate .. ') on DUPLICATE KEY UPDATE rate=rate+' .. admrate)
		db:query_ex('INSERT INTO ba_ratinglogs(a_steamid, rate, data, p_steamid) VALUES("?", "?", "?", "?")', {util.SteamIDTo64(admsid), admrate, os.time(), ply:SteamID64()})
		db:query([[UPDATE ba_rating SET reports = reports + 1 WHERE steamid = ']] ..util.SteamIDTo64(admsid).. [[']])

		ply.ratingUsing = false
	end)
	
	hook.Add("PostGamemodeLoaded", "DBCreateWow", function()
		local db = ba.data.GetDB()
        db:query([[CREATE TABLE IF NOT EXISTS `ba_ratinglogs` (
                    `a_steamid` bigint(50) NOT NULL,
                    `rate` tinyint(1) NOT NULL,
                    `data` bigint(50) NOT NULL,
                    `p_steamid` bigint(50) NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;]])
        db:query([[CREATE TABLE IF NOT EXISTS `ba_setgrouplogs` (
					`time` bigint(50) NOT NULL,
                    `steamid` bigint(50) NOT NULL,
					`nameid` varchar(255) NOT NULL,
                    `group` varchar(255) NOT NULL,
                    `s_steamid` bigint(50) NOT NULL,
					`s_nameid` varchar(255) NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;]])
        db:query([[CREATE TABLE IF NOT EXISTS `ba_rating` (
                    `steamid` bigint(50) NOT NULL,
                    `nameid` text NOT NULL,
                    `rate` bigint(50) NOT NULL DEFAULT '0'
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;]])
        db:query([[ALTER TABLE `ba_rating`
            ADD PRIMARY KEY (`steamid`);]])
        db:query([[CREATE TABLE IF NOT EXISTS `ba_warns` (
                    `steamid` bigint(50) NOT NULL,
                    `warns` int(1) NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;]])
       db:query([[ALTER TABLE `ba_warns`
            ADD PRIMARY KEY (`steamid`);]])
	end)
	
	concommand.Add("cleardbandcreate", function(ply, cmd, args)
        if not ply:IsRoot() then return end
		local db = ba.data.GetDB()
		print("Prep...")
        db:query([[DROP TABLE ba_ratinglogs;]])
		db:query([[DROP TABLE ba_rating;]])
		db:query([[DROP TABLE ba_warns;]])
        db:query([[CREATE TABLE IF NOT EXISTS `ba_ratinglogs` (
                    `a_steamid` bigint(50) NOT NULL,
                    `rate` tinyint(1) NOT NULL,
                    `data` bigint(50) NOT NULL,
                    `p_steamid` bigint(50) NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;]])
        db:query([[CREATE TABLE IF NOT EXISTS `ba_rating` (
                    `steamid` bigint(50) NOT NULL,
                    `nameid` text NOT NULL,
                    `rate` bigint(50) NOT NULL DEFAULT '0'
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;]])
        db:query([[ALTER TABLE `ba_rating`
            ADD PRIMARY KEY (`steamid`);]])
        db:query([[CREATE TABLE IF NOT EXISTS `ba_warns` (
                    `steamid` bigint(50) NOT NULL,
                    `warns` int(1) NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;]])
       db:query([[ALTER TABLE `ba_warns`
            ADD PRIMARY KEY (`steamid`);]])
		print("Ready!")
	end)
	
	hook.Add("PlayerDisconnected", "LeaveJaloba", function(ply)
		local targ = ply:GetBVar("StaffRequestAdmin")
		if not targ then return end
		if targ:IsAdmin() then 
			targ:SetBVar("StaffRequestAdmin", nil)
			net.Start("CloseMenusWow")
			net.Send( targ )
			ba.notify(targ, "Игрок, который подал жалобу вышел из сервера!")
			return
		end
		targ:SetBVar("StaffRequestAdmin", nil)
		net.Start 'ba.openRatingPlayer'
			net.WriteString( ply:Name() )
			net.WriteString( ply:SteamID() )
		net.Send( targ )
		net.Start("CloseMenusWow")
		net.Send( targ )
		targ.ratingUsing = true
	end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
