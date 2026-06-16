--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local client_id = sReward.config["discord"]["client_id"]
local guild_id = sReward.config["discord"]["guild_id"]

if CLIENT then
    net.Receive("sR:DiscordIntegration", function()
        RunConsoleCommand("sreward_discordweb")
    end)
else
    util.AddNetworkString("sR:DiscordIntegration")

    sReward = sReward or {}
    sReward.discord = sReward.discord or {}
    sReward.discord.members = sReward.discord.members or {}
    sReward.discord.queue = sReward.discord.queue or {}

    local client_secret = sReward.config["discord"]["client_secret"]
    local bot_token = sReward.config["discord"]["bot_token"]

    local apiURL = "https://stromic.xyz/discord.php" --- We will get blocked by Cloudflare so we reverse proxy!

    local function handleQueue(sid)
        for k,v in pairs(sReward.discord.queue[sid]) do
            v()
            sReward.discord.queue[sid][k] = nil
        end
    end

    local function syncMember(sid)
        local uid = sReward.discord.members[sid] and sReward.discord.members[sid].id
        if !uid then return end
        http.Fetch(apiURL.."/guilds/"..guild_id.."/members/"..uid, function(json, len, headers, code)
            local data = util.JSONToTable(json)
            if data then
                sReward.discord.members[sid].joined = !!data.user
                sReward.discord.members[sid].boosting = !!data.premium_since

                handleQueue(sid)
            end
        end, nil, {
            ["Authorization"] = "Bot "..bot_token
        })
    end

    sReward.syncMember = syncMember

    local function storeuid(ply, code)
        local sid = ply:SteamID()
        
        HTTP({
            method = "post",
            url = apiURL.."/oauth2/token",
            parameters = {
                grant_type = "authorization_code",
                code = code,
                client_id = client_id,
                client_secret = client_secret,
            },
            headers	= {},
            success = function(code, body, headers)
                if (code == 200) then
                    local data = util.JSONToTable(body)
                    local token = data.access_token

                    if !token then
                        slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "discord_error_retrieving_data"), ply)
                    return end

                    http.Fetch(apiURL.."/users/@me", function(data)
                        local json = util.JSONToTable(data)
            
                        sReward.discord.members[sid].id = json and json.id

                        if !sReward.discord.members[sid] then
                            slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "discord_error_retrieving_data"), ply)
                            sReward.discord.members[sid] = nil
                        else
                            syncMember(sid)
                        end
                    end, function()
                        slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "discord_error_retrieving_data"), ply) 
                    end,{ --- Headers include token!    ​​   ​       
                        ["Authorization"] = "Bearer "..token
                    })
                else
                    slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "discord_error_retrieving_data"), ply)
                end
            end,
            failed = function(err)
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "discord_error_retrieving_data"), ply)
            end
        })
    end

    local function handleVerification(ply, key, type)
        local reward = sReward.config["rewards"][key]

        local sid = ply:SteamID()
        
        sReward.discord.members[sid] = sReward.discord.members[sid] or {}
        sReward.discord.queue[sid] = sReward.discord.queue[sid] or {}

        if sReward.discord.members[sid][type] then
            sReward.GiveReward(ply, key)
        return end

        local success = function()
            if sReward.discord.members[sid][type] then
                sReward.GiveReward(ply, key)
            else
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "failed_verification", reward.name), ply)
            end
        end

        if !sReward.discord.members[sid].id then            
            net.Start("sR:DiscordIntegration")
            net.Send(ply)

            ply.sR_RequestedAuth = true
        elseif !sReward.discord.members[sid][type] then
            syncMember(sid)
        end

        sReward.discord.queue[sid][type] = success

        slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "checking_wait", reward.name), ply)
    end

    sReward.VerifyDiscordJoin = function(ply, key)
        handleVerification(ply, key, "joined")
    end

    sReward.VerifyDiscordBoost = function(ply, key)
        handleVerification(ply, key, "boosting")
    end

    net.Receive("sR:DiscordIntegration", function(len, ply)
        local sid = ply:SteamID()
        if !ply.sR_RequestedAuth then return end
        ply.sR_RequestedAuth = nil

        local code = net.ReadString()

        if code == "" then return end
            
        storeuid(ply, code, v)
    end)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
