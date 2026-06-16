--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local tag = "LibFuse:PlayerFullyLoad"
local LibFuseLoadQ = {}

hook.Add( "PlayerInitialSpawn", tag, function( ply )
	LibFuseLoadQ[ ply ] = true
end)

hook.Add( "SetupMove", tag, function( ply, _, cmd )
	if LibFuseLoadQ[ ply ] and not cmd:IsForced() then
		LibFuseLoadQ[ ply ] = nil

		hook.Run(tag, ply)
	end
end )


local Tag = "KylDonate"
local toggleweaponnetwork = "LibFuse:ToggleWeapon"

util.AddNetworkString(Tag)
util.AddNetworkString(toggleweaponnetwork)
KylDonate = KylDonate or {}



--[[ 
    КОММЕТ НЕ СНИМАТЬ
    rp._Stats:Query("DROP TABLE KylDonate_Weapons")
    rp._Stats:Query("DROP TABLE KylDonate_Players")
    rp._Stats:Query("DROP TABLE KylDonate_BuyLogs")

    rp._Stats:Query("CREATE TABLE IF NOT EXISTS KylDonate_Weapons (id INT AUTO_INCREMENT PRIMARY KEY, SteamID TEXT, DItemID TEXT, toggle BOOLEAN) ")
    rp._Stats:Query("CREATE TABLE IF NOT EXISTS KylDonate_Players (SteamID VARCHAR(32) PRIMARY KEY, Balance INT)")
    rp._Stats:Query("CREATE TABLE IF NOT EXISTS KylDonate_BuyLogs (SteamID TEXT, DItemName TEXT, DItemID TEXT, DItemType TEXT, BuyTime TEXT)") 
]]--

KylDonate.BuyItem2DBWeapon = function(sid, id)
    rp._Stats:Query(string.format("INSERT INTO KylDonate_Weapons (SteamID, DItemID) VALUES ('%s', '%s')", sid, id))
end

KylDonate.AddBuyLog = function(sid, name, id, typer)
    rp._Stats:Query(string.format("INSERT INTO KylDonate_BuyLogs (SteamID, DItemName, DItemID, DItemType, BuyTime) VALUES (%s, %s, %s, %s, %s)", sql.SQLStr(sid), sql.SQLStr(name), sql.SQLStr(id), sql.SQLStr(typer), sql.SQLStr(tostring(os.time()))))
end

KylDonate.SetDonateCoins = function(sid, balance)
    local PL = player.GetBySteamID( sid )

    rp._Stats:Query(string.format("REPLACE INTO KylDonate_Players (SteamID, Balance) VALUES (%s, %d)", sql.SQLStr(sid), balance))
    if PL then
        PL:SetNWInt("kyl_balance", tonumber(balance))
    end
end

KylDonate.AddDonateCoins = function(sid, balance)
    local olx = player.GetBySteamID(sid)
    
    rp._Stats:Query( "SELECT Balance FROM KylDonate_Players WHERE SteamID = " .. sql.SQLStr( sid ) .. ";", function(data)
        if next(data) then
            local balik = data[1].Balance
            if not balik then balik = 0 end

            KylDonate.SetDonateCoins(sid, tonumber(balik + balance))

            if IsValid(olx) and olx:IsPlayer() then
                olx:SetNWInt("kyl_balance", tonumber(balik + balance))
            end
        else
            KylDonate.SetDonateCoins(sid, balance)
            if IsValid(olx) and olx:IsPlayer() then
                olx:SetNWInt("kyl_balance", balance)
            end
        end
    end)
end

KylDonate.HasItem = function(ply, item, cb)
    rp._Stats:Query(string.format("SELECT DItemID FROM KylDonate_BuyLogs WHERE SteamID = %s AND DItemID = %s;", sql.SQLStr(ply:SteamID()), SQLStr(item)), function(data)
        cb(data[1] and data[1].DItemID ~= nil or false)
    end)
end

KylDonate.GiveItem = function(sid, name, id, typer)
    if typer == "weapons" then
        KylDonate.BuyItem2DBWeapon(sid, id)
    end
    KylDonate.AddBuyLog(sid, name, id, typer)
end

net.Receive(Tag, function(len, ply)
    local id = net.ReadString()
    local ppp = net.ReadBool()
    local item

    if ppp then
        item = KylDonate.GetPermanentItemByID(id)
    else
        item = KylDonate.GetItemByID(id)
    end

    if not item then return end

    if KylDonate.CantBuy(item) then return ply:ChatPrint("Этот предмет запрещен к покупке.") end
    KylDonate.HasItem(ply, item.id, function(data)
        if data and not item.multibuy then 
            return ply:ChatPrint("у тебя уже есть этот донат.")
        else
            if KylDonate.CanAfford(ply, item.cost.def) then
        
                if item.type == "weapons" then
                    if not ply.KylDonateWeap then ply.KylDonateWeap = { [item.weaponclass] = true } else ply.KylDonateWeap[item.weaponclass] = true end
        
                    ply:SetNWBool(item.weaponclass, true)
                    ply:Give(item.weaponclass)
                    
                    KylDonate.BuyItem2DBWeapon(ply:SteamID(), item.weaponclass)
        
                elseif item.type == "usergroups" then
                    
                    if KylDonate.Settings["Ranks"][item.usergroup] <= KylDonate.Settings["Ranks"][ply:GetUserGroup()] then return ply:ChatPrint("Твой ранг выше.") end
                    
                    if item.permitem then
                        game.ConsoleCommand(string.format("ba setgroup %s %s\n", ply:SteamID(), item.usergroup))
                    else
                        game.ConsoleCommand(string.format("ba setgroup %s %s %s %s\n", ply:SteamID(), item.usergroup, "1mo", ply:GetUserGroup()))
                    end
        
                end
                
                if item.on_buy then item.on_buy(ply, item) end

                KylDonate.AddBuyLog(ply:SteamID(), item.name, item.id, item.type)
                KylDonate.SetDonateCoins(ply:SteamID(), ply:GetNWInt('kyl_balance') - item.cost.def)    
                ply:ChatPrint("У вас осталось ".. tostring(ply:GetNWInt('kyl_balance')))

                for k, v in ipairs(player.GetAll()) do
                    v:ChatPrint("Игрок ".. ply:Name() .. " купил донат " .. item.name)
                end

            else

                return ply:ChatPrint("нехватка бабла на " ..tostring(item.name).. " пополняй, цена: " .. tostring(item.cost.def) .. " id: " .. tostring(item.id))
            end
        end
    end)
end)

hook.Add("LibFuse:PlayerFullyLoad", "DonateInit", function(ply)

    rp._Stats:Query( "SELECT Balance FROM KylDonate_Players WHERE SteamID = " .. sql.SQLStr( ply:SteamID() ) .. ";", function(data)
        if next(data) then
            local coins = data[1].Balance
            ply:SetNWInt("kyl_balance", tonumber(coins))
        end
    end)
    

    rp._Stats:Query(string.format("SELECT DItemID, toggle FROM KylDonate_Weapons WHERE SteamID = %s;", sql.SQLStr(ply:SteamID())), function(data)
        if next(data) then
            local prikolweps = data

            if not prikolweps or prikolweps == nil then return end
            if not ply.KylDonateWeap then ply.KylDonateWeap = {} end 
        
            for k, v in pairs(prikolweps) do
                ply.KylDonateWeap[v.DItemID] = tobool(v.toggle)
                ply:SetNWBool(v.DItemID, tobool(v.toggle))
            end
        end
    end)

end)


net.Receive(toggleweaponnetwork, function(len, ply)
    local weap = net.ReadString()
    local state = net.ReadBool()

    if ply.KylDonateWeap[weap] ~= nil then
        ply.KylDonateWeap[weap] = state
        rp._Stats:Query(string.format("UPDATE `KylDonate_Weapons` SET toggle = %s WHERE SteamID = %s AND DItemID = %s;", state and 1 or 0, sql.SQLStr(ply:SteamID()), sql.SQLStr(weap)))
        ply:SetNWBool(weap, state)
    end
end)

hook.Add("PlayerLoadout", "GiveDonateGuns", function(ply)
    timer.Simple(0.5, function()
        if ply.KylDonateWeap then
            for k, v in pairs(ply.KylDonateWeap) do
                if v and not ply:IsArrested() and not ply:IsBanned() and not ply:IsJailed() then ply:Give(k) end
            end
        end
    end)
end)


otec = otec or {}

util.AddNetworkString('gay_note')
function otec.SendToChatAll( ... )
    local Ar = {...} 
    net.Start"gay_note"
        net.WriteTable(Ar)
    net.Broadcast()
end


local table_donate_colors = {
    ["qiwi"] = Color(255,153,0),
    ["card"] = Color(255,245,0),
    ["SKINS"] = Color(116,179,174)
}


local function checkdonates()
    http.Fetch('http://46.174.50.240:3000/gmod/checkdatabase/justrpfunwithloveurbanichka', function(body)
        srv = util.JSONToTable(body) -- its json with info
        for k, v in pairs(srv.donators) do
            local olx = player.GetBySteamID(k)
                KylDonate.AddDonateCoins(k, math.floor(v.coins))
                if IsValid(olx) and olx:IsPlayer() then
                    otec.SendToChatAll(Color(255,77,119), "[DONATE] ", olx:GetJobColor(), olx:Name() , Color(255,255,255), " пополнил счёт на ", Color(0,166,17), v.coins, Color(255,255,255), " RUB с помощью ", table_donate_colors[v.pay_service] or Color(107,169,230), string.upper(v.pay_service))
                else
                    otec.SendToChatAll(Color(255,77,119), "[DONATE] ", Color(1, 89, 224), k , Color(255,255,255), " пополнил счёт на ", Color(0,166,17), v.coins, Color(255,255,255), " RUB с помощью ", table_donate_colors[v.pay_service] or Color(107,169,230), string.upper(v.pay_service))
                end
            srv.donators[k] = nil
        end
    end)
end

timer.Create('lolsmeh!!!!!', 5, 0, checkdonates)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
