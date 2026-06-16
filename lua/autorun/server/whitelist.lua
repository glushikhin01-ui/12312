local WhitelistEnabled = true 

local Whitelist = {
    "76561199111731031", -- Angel
    "76561198004451747", -- Gero
	"76561199085348872", -- Frik
    "76561199781623734", -- Angel
    "76561199156650709", -- newliz
    "76561199430391633", -- bobr
    "76561199674713380", -- paradox
    "76561199681664660", -- kanatan
	"76561198864271913", -- Sansey

}

local function GetSteamID64(ply)
    return ply:SteamID64()
end

hook.Add("CheckPassword", "WhitelistCheck", function(steamID64, ipAddress, svPassword, clPassword, playerName)
    if not WhitelistEnabled then return end 
    
    for _, allowedID in ipairs(Whitelist) do
        if steamID64 == allowedID then
            return
        end
    end

    return false, "Сервер на тех.работах!\nВсе новости тут в дискорд сервере ."
end)

hook.Add("PlayerInitialSpawn", "WhitelistSpawnCheck", function(ply)
    if not WhitelistEnabled then return end 
    
    local steamID64 = GetSteamID64(ply)
    local isAllowed = false
    
    for _, allowedID in ipairs(Whitelist) do
        if steamID64 == allowedID then
            isAllowed = true
            break
        end
    end
    
    if not isAllowed then
        ply:Kick("Вы не в белом списке!")
    end
end)