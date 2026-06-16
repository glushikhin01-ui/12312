--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward = sReward or {}

sReward.VerifySteamGroup = function(ply, key)
    local reward = sReward.config["rewards"][key]
    http.Fetch( "https://api.steampowered.com/ISteamUser/GetUserGroupList/v1/?key="..sReward.config["steam"]["api_key"].."&steamid="..ply:SteamID64(),
        function(data)
            local result = false
            local err = false
            local tbl = util.JSONToTable(data)

            if !tbl then slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "steam_unsuccessfull"), ply) return end

            if tbl["response"]["error"] then
                err = true
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "steam_private"), ply)
            return end

            if tbl["response"] and tbl["response"]["groups"] then
                for k,v in pairs(tbl["response"]["groups"]) do
                    if v.gid == sReward.config["steam"]["group_id"] then
                        result = true
                    break end
                end
            end
            
            if !err then
                if result then
                    sReward.GiveReward(ply, key)
                else
                    slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "didnt_find_steamgroup"), ply)
                end
            end
        end, 
        function()
            slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "steam_unsuccessfull"), ply)
        end
    )
end

sReward.VerifySteamNameTag = function(ply, key)
    local reward = sReward.config["rewards"][key]
    local nick = isfunction(ply.SteamName) and ply:SteamName() or ply:Nick()
    local result = false

    for k, v in ipairs(sReward.config["steam"]["name_tag"]) do
        if string.find(nick, string.PatternSafe(v)) then result = true break end
    end

    if result then
        sReward.GiveReward(ply, key)
    else
        slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "failed_verification", reward.name), ply)
    end

    return result
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
