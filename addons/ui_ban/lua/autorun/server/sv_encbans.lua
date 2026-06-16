util.AddNetworkString("EncBans_BuyUnban")
util.AddNetworkString("EncBans_BuyUnbanResult")

local UNBAN_PRICE = 449
local pendingUnban = {}

local function sendResult(ply, success, reason)
    net.Start("EncBans_BuyUnbanResult")
    net.WriteBool(success)
    if not success then
        net.WriteString(reason)
    end
    net.Send(ply)
end

net.Receive("EncBans_BuyUnban", function(len, ply)
    if not IsValid(ply) then return end

    local sid = ply:SteamID64()

    if pendingUnban[sid] then
        sendResult(ply, false, "Покупка уже обрабатывается, подождите.")
        return
    end

    if not ply:IsBanned() then
        sendResult(ply, false, "Вы не в бане!")
        return
    end

    local balance = ply:IGSFunds()
    if balance < UNBAN_PRICE then
        sendResult(ply, false, "Недостаточно средств на балансе доната. Необходимо: " .. UNBAN_PRICE .. " руб., у вас: " .. balance .. " руб.")
        return
    end

    pendingUnban[sid] = true

    ply:AddIGSFunds(-UNBAN_PRICE)
    ba.bans.Unban(sid, "Покупка разбана")

    net.Start("OtecAndEncBans")
    net.WriteString("unban")
    net.Send(ply)

    sendResult(ply, true)

    print("[EncBans] " .. ply:Nick() .. " (" .. sid .. ") купил разбан за " .. UNBAN_PRICE .. " руб. IGS")
end)
