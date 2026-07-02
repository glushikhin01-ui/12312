if not SERVER then return end

util.AddNetworkString("DonateDiscord.RequestLink")
util.AddNetworkString("DonateDiscord.OpenLink")

DonateDiscord = DonateDiscord or {}
DonateDiscord.Config = DonateDiscord.Config or {
    ClientID = "1431676108008329228",
    RedirectURI = "http://212.22.93.35/discord",
    Scope = "identify guilds",
    ServerID = 1,

    SharedSecret = "CHANGE_ME",

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

function DonateDiscord.MarkLinked(steamid64, discordID, roleSynced)
    sql.Query(string.format(
        "REPLACE INTO donate_discord_users (steamid64, discord_id, role_synced, linked_time) VALUES (%s, %s, %d, %d);",
        sql.SQLStr(tostring(steamid64)),
        sql.SQLStr(tostring(discordID or "")),
        roleSynced and 1 or 0,
        os.time()
    ))

    for _, ply in ipairs(player.GetAll()) do
        if ply:SteamID64() ~= tostring(steamid64) then continue end

        ply:SetNWBool("DonateDiscord.Linked", true)
        ply:SetNWString("DonateDiscord.ID", tostring(discordID or ""))
        ply:SetNWBool("DonateDiscord.RoleSynced", roleSynced == true)

        ply:ChatPrint("[Discord] Аккаунт Discord успешно привязан.")
    end
end

function DonateDiscord.MarkUnlinked(steamid64)
    sql.Query(string.format("DELETE FROM donate_discord_users WHERE steamid64 = %s;", sql.SQLStr(tostring(steamid64))))

    for _, ply in ipairs(player.GetAll()) do
        if ply:SteamID64() ~= tostring(steamid64) then continue end

        ply:SetNWBool("DonateDiscord.Linked", false)
        ply:SetNWString("DonateDiscord.ID", "")
        ply:SetNWBool("DonateDiscord.RoleSynced", false)

        ply:ChatPrint("[Discord] Привязка Discord сброшена.")
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

net.Receive("DonateDiscord.RequestLink", function(_, ply)
    local authURL = DonateDiscord.GenerateAuthURL(ply)

    if authURL == "" then
        ply:ChatPrint("[Discord] Не настроена ссылка авторизации. Проверь настройки в discord.lua")
        return
    end

    net.Start("DonateDiscord.OpenLink")
        net.WriteString(authURL)
    net.Send(ply)
end)

function DonateDiscord.SyncPlayer(ply)
    if not IsValid(ply) then return end
    local steamid64 = ply:SteamID64()

    local row = sql.QueryRow(string.format("SELECT * FROM donate_discord_users WHERE steamid64 = %s;", sql.SQLStr(steamid64)))
    if row and row.discord_id and row.discord_id ~= "" then
        ply:SetNWBool("DonateDiscord.Linked", true)
        ply:SetNWString("DonateDiscord.ID", tostring(row.discord_id))
        ply:SetNWBool("DonateDiscord.RoleSynced", tonumber(row.role_synced) == 1 or row.role_synced == "true")
    else
        ply:SetNWBool("DonateDiscord.Linked", false)
        ply:SetNWString("DonateDiscord.ID", "")
        ply:SetNWBool("DonateDiscord.RoleSynced", false)
    end
end

hook.Add("PlayerInitialSpawn", "DonateDiscord.SyncOnJoin", function(ply)
    timer.Simple(5, function()
        if not IsValid(ply) then return end
        DonateDiscord.SyncPlayer(ply)
    end)
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