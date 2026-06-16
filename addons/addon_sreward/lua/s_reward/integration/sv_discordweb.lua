--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward = sReward or {}
sReward.DiscordWeb = sReward.DiscordWeb or {}
sReward.DiscordWeb.links = sReward.DiscordWeb.links or {}

local api_url = "https://stromic.xyz/discord"

local sendOpenURL = function(ply, request_id)
    ply:SendLua([[gui.OpenURL("]]..api_url..[[?request_id=]]..request_id..[[")]])
end

sReward.DiscordWeb.StoreLinkData = function(sid64, sid, request_id, return_id)
    sReward.DiscordWeb.links[sid64] = {
        request_id = request_id,
        return_id = return_id,
        sid = sid,
        added = CurTime()
    }
end

sReward.DiscordWeb.GenerateLink = function(ply)
    local sid64 = ply:SteamID64()
    local sid = ply:SteamID()
    
    if sReward.DiscordWeb.links[sid64] then
        sendOpenURL(ply, sReward.DiscordWeb.links[sid64].request_id)
    return end
    
    slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "discord_webserver_started"), ply)

    http.Fetch(api_url.."?request_id=new", function(response)
        local json = util.JSONToTable(response)

        sReward.DiscordWeb.StoreLinkData(sid64, sid, json.request_id, json.return_id)

        if !IsValid(ply) then return end

        sendOpenURL(ply, json.request_id)
    end, function(errorMsg)
        if !IsValid(ply) then return end

        slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "discord_webserver_failed"), ply)
    end)
end

concommand.Add("sreward_discordweb", function(ply)
    sReward.DiscordWeb.GenerateLink(ply)
end)

timer.Create("sR:DiscordWebCheck", 2, 0, function()
    for k, v in pairs(sReward.DiscordWeb.links) do
        if CurTime() - v.added > 60 then
            sReward.DiscordWeb.links[k] = nil
        continue end

        http.Fetch(api_url.."/store.php?return_id="..v.return_id, function(response)
            local json = util.JSONToTable(response)

            if json and json.discord_id and json.discord_id != "" then
                sReward.discord.members[v.sid].id = json.discord_id
                sReward.DiscordWeb.links[k] = nil
                sReward.syncMember(v.sid)
            end
        end)
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
