if CLIENT then return end

util.AddNetworkString("SendDuelRequest")
util.AddNetworkString("DuelSend")
util.AddNetworkString("GetDuelRequest")
util.AddNetworkString("Duels_OpenMenu")

local function EndDuel(winner, loser, arenaIdx, isDraw)
	if not IsValid(winner) or not IsValid(loser) then return end

	local bet   = winner.duel_bet
	local isDon = winner.duel_bool

	if not isDraw then
		if isDon then
			winner:AddIGSFunds( bet,  "Победа в дуэли: "   .. loser:Name())
			loser:AddIGSFunds( -bet,  "Проигрыш в дуэли: " .. winner:Name())
		else
			winner:AddMoney( bet)
			loser:AddMoney(-bet)
		end
		winner:ChatPrint("Вы победили в дуэли с " .. loser:Name()  .. " и получили "  .. bet .. (isDon and " донат-валюты!" or " $!"))
		loser:ChatPrint( "Вы проиграли в дуэли с " .. winner:Name() .. " и потеряли " .. bet .. (isDon and " донат-валюты." or " $."))
		net.Start("DuelSend") net.WriteBool(true) net.WriteBool(true)  net.Send(winner)
		net.Start("DuelSend") net.WriteBool(true) net.WriteBool(false) net.Send(loser)
	else
		winner:ChatPrint("Ничья в дуэли с " .. loser:Name())
		loser:ChatPrint( "Ничья в дуэли с " .. winner:Name())
		net.Start("DuelSend") net.WriteBool(true) net.WriteBool(false) net.Send(winner)
		net.Start("DuelSend") net.WriteBool(true) net.WriteBool(false) net.Send(loser)
	end

	if rp.duels.arenas[arenaIdx] then
		rp.duels.arenas[arenaIdx].ready = false
		net.Start("SendDuelRequest")
		net.WriteUInt(arenaIdx, 8)
		net.WriteBool(false)
		net.Broadcast()
	end

	timer.Remove("duel" .. winner:SteamID64())
	winner:StripWeapons() loser:StripWeapons()

	for _,p in ipairs({winner, loser}) do
		p.dueltarget = nil
		p.duel_bet   = nil
		p.duel_bool  = nil
	end

	timer.Simple(1.5, function()
		if IsValid(loser)  then loser:Spawn()  end
		if IsValid(winner) then winner:Spawn() end
	end)

	if nlr and nlr.deactivateZone then nlr.deactivateZone(winner) end
end

function StartDuel(answer, ent, ply, target)
	if not IsValid(ply) or not IsValid(target) then return end

	if not answer then
		ply:ChatPrint(target:Name() .. " отклонил предложение дуэли")
		target.arena = nil
		return
	end

	local bet   = ply.duel_bet
	local isDon = ply.duel_bool
	local arena = ply.arena

	if not bet or not arena then return end
	if rp.duels.arenas[arena].ready then
		ply:ChatPrint("Арена занята") target:ChatPrint("Арена занята") return
	end

	local hasEnough = isDon
		and (ply:IGSFunds() >= bet and target:IGSFunds() >= bet)
		or  (ply:GetMoney() >= bet and target:GetMoney() >= bet)

	if not hasEnough then
		ply:ChatPrint("У вас или игрока не хватает средств")
		target:ChatPrint("У вас или игрока не хватает средств")
		return
	end

	ply:ChatPrint(target:Name() .. " принял предложение дуэли!")

	rp.duels.arenas[arena].ready = true
	net.Start("SendDuelRequest") net.WriteUInt(arena, 8) net.WriteBool(true) net.Broadcast()

	net.Start("DuelSend") net.WriteBool(false) net.Send(ply)
	net.Start("DuelSend") net.WriteBool(false) net.Send(target)

	ply:Freeze(true)    target:Freeze(true)
	ply:SetPos(rp.duels.arenas[arena].pos1)
	target:SetPos(rp.duels.arenas[arena].pos2)
	ply:SetHealth(100)  target:SetHealth(100)
	ply:SetArmor(100)   target:SetArmor(100)
	ply:StripWeapons()  target:StripWeapons()

	timer.Simple(3, function()
		if not IsValid(ply) or not IsValid(target) then
			rp.duels.arenas[arena].ready = false
			net.Start("SendDuelRequest") net.WriteUInt(arena, 8) net.WriteBool(false) net.Broadcast()
			return
		end

		ply:Freeze(false)  target:Freeze(false)
		ply:Give(ply.duelwep)
		target:Give(target.duelwep)

		ply.dueltarget    = target
		target.dueltarget = ply

		ply.duel_bet    = bet    target.duel_bet    = bet
		ply.duel_bool   = isDon  target.duel_bool   = isDon

		ply:ChatPrint("Началась дуэль с " .. target:Name())
		target:ChatPrint("Началась дуэль с " .. ply:Name())

		timer.Create("duel" .. ply:SteamID64(), 120, 1, function()
			if IsValid(ply) and IsValid(target)
			   and ply.dueltarget == target and target.dueltarget == ply then
				EndDuel(ply, target, arena, true)
			end
		end)
	end)
end

net.Receive("GetDuelRequest", function(_, pl)
	local isDon  = net.ReadBool()
	local bet    = net.ReadUInt(32)
	local target = net.ReadEntity()
	local arena  = net.ReadUInt(8)
	local wep    = net.ReadString()

	if not IsValid(target) or target == pl then return end

	local minBet = isDon and 50 or 100000
	local maxBet = isDon and pl:IGSFunds() or pl:GetMoney()
	bet = math.Clamp(bet, minBet, math.max(minBet, maxBet))

	if isDon then
		if pl:IGSFunds() < bet or target:IGSFunds() < bet then
			pl:ChatPrint("У вас или игрока не хватает средств") return
		end
	else
		if pl:GetMoney() < bet or target:GetMoney() < bet then
			pl:ChatPrint("У вас или игрока не хватает средств") return
		end
	end

	if (pl.nextduel or 0) > CurTime() then
		pl:ChatPrint("Вы можете отправить запрос через " .. math.ceil((pl.nextduel or 0) - CurTime()) .. " сек.")
		return
	end

	if target.dueltarget then
		pl:ChatPrint("Этот игрок уже участвует в дуэли")
		return
	end

	if not rp.duels.arenas[arena] then return end

	if rp.duels.arenas[arena].ready then
		pl:ChatPrint("Арена занята игроками")
		return
	end

	pl.duel_bet    = bet
	pl.duel_bool   = isDon
	pl.duelwep     = wep
	target.duelwep = wep
	pl.arena       = arena
	pl.nextduel    = CurTime() + 30

	local currency = isDon and "донат-валюта" or "$"
	local wepName  = (rp.duels.weapons[wep] and rp.duels.weapons[wep].name) or wep

	GAMEMODE.ques:Create(
		string.format("Вызов на дуэль!\nОт: %s\nОружие: %s\nСтавка: %s %s\nАрена: %s",
			pl:Name(), wepName, bet, currency, rp.duels.arenas[arena].name),
		"duel" .. pl:SteamID64(),
		target, 15,
		StartDuel, pl, target
	)

	pl:ChatPrint("Запрос дуэли отправлен игроку " .. target:Name())
end)

hook.Add("DoPlayerDeath", "Duels_HandleDeath", function(target, attacker)
	if not IsValid(attacker) or not attacker:IsPlayer() then return end
	if attacker.dueltarget ~= target or target.dueltarget ~= attacker then return end
	EndDuel(attacker, target, attacker.arena)
end)

hook.Add("PlayerDisconnected", "Duels_HandleDisconnect", function(ply)
	local opponent = ply.dueltarget
	if not IsValid(opponent) then return end
	EndDuel(opponent, ply, opponent.arena)
end)

hook.Add("NLRShouldIgnore", "Duels_NLRIgnore", function(pl)
	if pl.dueltarget then return true end
end)
