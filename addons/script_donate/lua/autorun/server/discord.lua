if not SERVER then return end

util.AddNetworkString("DonateDiscord.RequestLink")
util.AddNetworkString("DonateDiscord.OpenLink")
util.AddNetworkString("DonateDiscord.SuccessLink")

DonateDiscord = DonateDiscord or {}
DonateDiscord.Config = DonateDiscord.Config or {
    ClientID = "1431676108008329228",
    RedirectURI = "http://93.115.101.104:12968/discord",
    Scope = "identify guilds",
    ServerID = 1,

    SharedSecret = "0ccf0ba379c1e016a0086afbd44f51aa2d6efa90d22e295f2c0c080cb00ede99",

    TokenLifetime = 600,
}

DonateDiscord.Pending = DonateDiscord.Pending or {}

sql.Query([[
    CREATE TABLE IF NOT EXISTS donate_discord_users (
        steamid64 VARCHAR(64) PRIMARY KEY,
        discord_id VARCHAR(64),
        role_synced INTEGER DEFAULT 0,
        linked_time INTEGER
    );
]])

sql.Query([[
    CREATE TABLE IF NOT EXISTS donate_discord_pending (
        hash VARCHAR(64) PRIMARY KEY,
        steamid64 VARCHAR(64),
        created INTEGER,
        expires INTEGER
    );
]])

local function urlEncode(str)
    str = tostring(str or "")
    str = string.gsub(str, "([^%w_~%-])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
    return str
end

function DonateDiscord.CreatePendingLink(ply)
    if not IsValid(ply) then return nil end

    local time_now = os.time()
    local steamid64 = ply:SteamID64()
    local serverId = tonumber(DonateDiscord.Config.ServerID) or 1
    local secret = tostring(DonateDiscord.Config.SharedSecret or "")
    local hash = util.MD5(steamid64 .. time_now .. serverId .. secret)

    DonateDiscord.Pending[hash] = {
        steamid64 = steamid64,
        name = ply:Name(),
        created = time_now,
        expires = time_now + (DonateDiscord.Config.TokenLifetime or 600),
    }

    sql.Query(string.format(
        "REPLACE INTO donate_discord_pending (hash, steamid64, created, expires) VALUES (%s, %s, %d, %d);",
        sql.SQLStr(hash),
        sql.SQLStr(steamid64),
        time_now,
        time_now + (DonateDiscord.Config.TokenLifetime or 600)
    ))

    return hash
end

function DonateDiscord.GetPending(token)
    local row = sql.QueryRow(string.format("SELECT * FROM donate_discord_pending WHERE hash = %s;", sql.SQLStr(tostring(token))))
    if row then
        if tonumber(row.expires) <= os.time() then
            sql.Query(string.format("DELETE FROM donate_discord_pending WHERE hash = %s;", sql.SQLStr(tostring(token))))
            DonateDiscord.Pending[token] = nil
            return nil
        end
        return {
            steamid64 = row.steamid64,
            created = tonumber(row.created),
            expires = tonumber(row.expires)
        }
    end

    local data = DonateDiscord.Pending[token]
    if not data then return nil end

    if data.expires <= os.time() then
        DonateDiscord.Pending[token] = nil
        return nil
    end

    return data
end

function DonateDiscord.GenerateAuthURL(ply)
    if not IsValid(ply) then return "" end
    if not DonateDiscord.Config.ClientID or DonateDiscord.Config.ClientID == "" then return "" end

    local time_now = os.time()
    local steamid64 = ply:SteamID64()
    local serverId = tonumber(DonateDiscord.Config.ServerID) or 1
    local secret = tostring(DonateDiscord.Config.SharedSecret or "")

    local hash = DonateDiscord.CreatePendingLink(ply)
    if not hash then return "" end

    local stateTable = {
        steamId64 = steamid64,
        time = time_now,
        hash = hash,
        serverId = serverId
    }
    local stateJson = util.TableToJSON(stateTable)

    local url = string.format(
        "https://discord.com/api/oauth2/authorize?client_id=%s&redirect_uri=%s&response_type=code&scope=%s&state=%s",
        urlEncode(DonateDiscord.Config.ClientID),
        urlEncode(DonateDiscord.Config.RedirectURI),
        urlEncode(DonateDiscord.Config.Scope or "identify guilds"),
        urlEncode(stateJson)
    )

    return url
end

function DonateDiscord.CleanSteamID(id)
    id = tostring(id or "")
    id = string.gsub(id, "[\"']", "")
    return string.Trim(id)
end

function DonateDiscord.GetPlayerDBRow(ply)
    if not IsValid(ply) then return nil end
    local sid64 = DonateDiscord.CleanSteamID(ply:SteamID64())
    local sid = DonateDiscord.CleanSteamID(ply:SteamID())
    local uid = DonateDiscord.CleanSteamID(ply:UniqueID())

    local query = string.format(
        "SELECT * FROM donate_discord_users WHERE TRIM(steamid64) = %s OR TRIM(steamid64) = %s OR TRIM(steamid64) = %s LIMIT 1;",
        sql.SQLStr(sid64),
        sql.SQLStr(sid),
        sql.SQLStr(uid)
    )
    return sql.QueryRow(query)
end

function DonateDiscord.MarkLinked(steamid64, discordID, roleSynced)
    steamid64 = DonateDiscord.CleanSteamID(steamid64)
    discordID = string.Trim(tostring(discordID or ""))

    sql.Query(string.format(
        "REPLACE INTO donate_discord_users (steamid64, discord_id, role_synced, linked_time) VALUES (%s, %s, %d, %d);",
        sql.SQLStr(steamid64),
        sql.SQLStr(discordID),
        roleSynced and 1 or 0,
        os.time()
    ))

    for _, ply in ipairs(player.GetAll()) do
        if DonateDiscord.CleanSteamID(ply:SteamID64()) == steamid64 or DonateDiscord.CleanSteamID(ply:SteamID()) == steamid64 then
            ply:SetNWBool("DonateDiscord.Linked", true)
            ply:SetNWString("DonateDiscord.ID", discordID)
            ply:SetNWBool("DonateDiscord.RoleSynced", roleSynced == true)
            net.Start("DonateDiscord.SuccessLink")
            net.Send(ply)
            ply:ChatPrint("[Discord] Аккаунт Discord успешно привязан.")
        end
    end
end

function DonateDiscord.MarkUnlinked(steamid64)
    steamid64 = DonateDiscord.CleanSteamID(steamid64)
    sql.Query(string.format("DELETE FROM donate_discord_users WHERE steamid64 = %s;", sql.SQLStr(steamid64)))

    for _, ply in ipairs(player.GetAll()) do
        if DonateDiscord.CleanSteamID(ply:SteamID64()) == steamid64 or DonateDiscord.CleanSteamID(ply:SteamID()) == steamid64 then
            ply:SetNWBool("DonateDiscord.Linked", false)
            ply:SetNWString("DonateDiscord.ID", "")
            ply:SetNWBool("DonateDiscord.RoleSynced", false)
            ply:ChatPrint("[Discord] Привязка Discord сброшена.")
        end
    end
end

concommand.Add("donate_discord_mark_linked", function(admin, _, args)
    if IsValid(admin) then return end

    local steamid64 = args[1]
    local discordID = args[2] or ""
    local roleSynced = tobool(args[3])

    if not steamid64 or steamid64 == "" then
        print("Usage: donate_discord_mark_linked <steamid64> <discord_id> [role_synced]")
        return
    end

    DonateDiscord.MarkLinked(steamid64, discordID, roleSynced)
    print("[DonateDiscord] Linked:", steamid64, discordID, roleSynced)
end)

concommand.Add("donate_discord_mark_unlinked", function(admin, _, args)
    if IsValid(admin) then return end

    local steamid64 = args[1]
    if not steamid64 or steamid64 == "" then
        print("Usage: donate_discord_mark_unlinked <steamid64>")
        return
    end

    DonateDiscord.MarkUnlinked(steamid64)
    print("[DonateDiscord] Unlinked:", steamid64)
end)

function DonateDiscord.CheckLinkedExternal(ply, callback)
    if not IsValid(ply) then return end
    local sid64 = DonateDiscord.CleanSteamID(ply:SteamID64())
    if not sid64 or sid64 == "" then
        if callback then callback(false, nil) end
        return
    end

    local baseURI = string.match(DonateDiscord.Config.RedirectURI or "", "^(https?://[^/]+)")
    if not baseURI or baseURI == "" then
        if callback then callback(false, nil) end
        return
    end

    local secret = DonateDiscord.Config.SharedSecret or "CHANGE_ME"
    local url = baseURI .. "/api/status?steamid64=" .. sid64 .. "&secret=" .. secret

    http.Fetch(url, function(body, len, headers, code)
        if not IsValid(ply) then return end
        if code == 200 and body then
            local data = util.JSONToTable(body)
            if data and data.ok and data.linked then
                local did = tostring(data.discord_id or "")
                sql.Query(string.format(
                    "REPLACE INTO donate_discord_users (steamid64, discord_id, role_synced, linked_time) VALUES (%s, %s, %d, %d);",
                    sql.SQLStr(sid64),
                    sql.SQLStr(did),
                    data.role_synced and 1 or 0,
                    os.time()
                ))
                ply:SetNWBool("DonateDiscord.Linked", true)
                ply:SetNWString("DonateDiscord.ID", did)
                ply:SetNWBool("DonateDiscord.RoleSynced", data.role_synced == true)
                net.Start("DonateDiscord.SuccessLink")
                net.Send(ply)
                if callback then callback(true, did) end
                return
            end
        end
        if callback then callback(false, nil) end
    end, function(err)
        if callback then callback(false, nil) end
    end)
end

net.Receive("DonateDiscord.RequestLink", function(_, ply)
    if not IsValid(ply) then return end

    if (ply.NextDiscordRequest or 0) > CurTime() then
        ply:ChatPrint("[Discord] Подождите перед повторной отправкой запроса.")
        return
    end
    ply.NextDiscordRequest = CurTime() + 10

    DonateDiscord.SyncPlayer(ply)

    if ply:GetNWBool("DonateDiscord.Linked", false) then
        ply:ChatPrint("[Discord] Ваш аккаунт уже привязан. Повторная привязка недоступна.")
        return
    end

    local row = DonateDiscord.GetPlayerDBRow(ply)
    if row then
        ply:SetNWBool("DonateDiscord.Linked", true)
        if row.discord_id then
            ply:SetNWString("DonateDiscord.ID", tostring(row.discord_id))
        end
        net.Start("DonateDiscord.SuccessLink")
        net.Send(ply)
        ply:ChatPrint("[Discord] Ваш аккаунт уже привязан к Discord" .. (row.discord_id and row.discord_id ~= "" and (" ID " .. tostring(row.discord_id)) or "") .. ". Повторная привязка недоступна.")
        return
    end

    DonateDiscord.CheckLinkedExternal(ply, function(isLinked, did)
        if not IsValid(ply) then return end
        if isLinked then
            ply:ChatPrint("[Discord] Ваш аккаунт уже привязан к Discord" .. (did and did ~= "" and (" ID " .. did) or "") .. ". Повторная привязка недоступна.")
            return
        end

        local authURL = DonateDiscord.GenerateAuthURL(ply)

        if authURL == "" then
            ply:ChatPrint("[Discord] Не настроена ссылка авторизации. Проверь настройки в discord.lua")
            return
        end

        net.Start("DonateDiscord.OpenLink")
            net.WriteString(authURL)
        net.Send(ply)
    end)
end)

function DonateDiscord.SyncPlayer(ply)
    if not IsValid(ply) then return end

    local row = DonateDiscord.GetPlayerDBRow(ply)
    if row then
        ply:SetNWBool("DonateDiscord.Linked", true)
        ply:SetNWString("DonateDiscord.ID", tostring(row.discord_id or ""))
        ply:SetNWBool("DonateDiscord.RoleSynced", tonumber(row.role_synced) == 1 or row.role_synced == "true")
    else
        DonateDiscord.CheckLinkedExternal(ply)
    end
end

hook.Add("PlayerInitialSpawn", "DonateDiscord.SyncOnJoin", function(ply)
    timer.Simple(5, function()
        if not IsValid(ply) then return end
        DonateDiscord.SyncPlayer(ply)
    end)
end)

hook.Add("Net_donOpen", "DonateDiscord.SyncOnMenuOpen", function(_, ply)
    if IsValid(ply) then DonateDiscord.SyncPlayer(ply) end
end)

timer.Create("DonateDiscord.SyncAllPlayers", 15, 0, function()
    for _, ply in ipairs(player.GetAll()) do
        if IsValid(ply) then DonateDiscord.SyncPlayer(ply) end
    end
end)

timer.Create("DonateDiscord.PendingCleanup", 60, 0, function()
    local now = os.time()
    sql.Query("DELETE FROM donate_discord_pending WHERE expires <= " .. now .. ";")
    for token, data in pairs(DonateDiscord.Pending) do
        if not data.expires or data.expires <= now then
            DonateDiscord.Pending[token] = nil
        end
    end
end)