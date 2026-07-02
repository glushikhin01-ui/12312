if not SERVER then return end

util.AddNetworkString("DonateDiscord.RequestLink")
util.AddNetworkString("DonateDiscord.OpenLink")

DonateDiscord = DonateDiscord or {}
DonateDiscord.Config = DonateDiscord.Config or {
    AuthBaseURL = "https://YOUR-DOMAIN.COM/discord/link",
    StatusApiURL = "",

    SharedSecret = "CHANGE_ME",

    TokenLifetime = 600,
}

DonateDiscord.Pending = DonateDiscord.Pending or {}

local function buildToken(ply)
    return string.format(
        "%s_%s_%s_%s",
        ply:SteamID64(),
        os.time(),
        math.random(100000, 999999),
        math.floor(SysTime() * 1000)
    )
end

local function buildAuthURL(ply, token)
    return string.format(
        "%s?token=%s&steamid64=%s",
        DonateDiscord.Config.AuthBaseURL,
        token,
        ply:SteamID64()
    )
end

function DonateDiscord.CreatePendingLink(ply)
    if not IsValid(ply) then return nil end

    local token = buildToken(ply)
    DonateDiscord.Pending[token] = {
        steamid64 = ply:SteamID64(),
        name = ply:Name(),
        created = os.time(),
        expires = os.time() + (DonateDiscord.Config.TokenLifetime or 600),
    }

    return token
end

function DonateDiscord.GetPending(token)
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
    if not DonateDiscord.Config.AuthBaseURL or DonateDiscord.Config.AuthBaseURL == "" then return "" end

    local token = DonateDiscord.CreatePendingLink(ply)
    if not token then return "" end

    return buildAuthURL(ply, token)
end

function DonateDiscord.MarkLinked(steamid64, discordID, roleSynced)
    for _, ply in ipairs(player.GetAll()) do
        if ply:SteamID64() ~= tostring(steamid64) then continue end

        ply:SetNWBool("DonateDiscord.Linked", true)
        ply:SetNWString("DonateDiscord.ID", tostring(discordID or ""))
        ply:SetNWBool("DonateDiscord.RoleSynced", roleSynced == true)

        ply:ChatPrint("[Discord] Аккаунт Discord успешно привязан.")
    end
end

function DonateDiscord.MarkUnlinked(steamid64)
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
        ply:ChatPrint("[Discord] Не настроена ссылка авторизации. Проверь sv_discord_link.lua")
        return
    end

    net.Start("DonateDiscord.OpenLink")
        net.WriteString(authURL)
    net.Send(ply)
end)

function DonateDiscord.SyncPlayer(ply)
    if not IsValid(ply) then return end
    if not DonateDiscord.Config.StatusApiURL or DonateDiscord.Config.StatusApiURL == "" then return end

    HTTP({
        url = DonateDiscord.Config.StatusApiURL,
        method = "GET",
        parameters = {
            steamid64 = ply:SteamID64(),
            secret = DonateDiscord.Config.SharedSecret,
        },
        success = function(code, body)
            if not IsValid(ply) then return end
            if code ~= 200 then return end

            local data = util.JSONToTable(body or "")
            if not istable(data) then return end

            ply:SetNWBool("DonateDiscord.Linked", data.linked == true)
            ply:SetNWString("DonateDiscord.ID", tostring(data.discord_id or ""))
            ply:SetNWBool("DonateDiscord.RoleSynced", data.role_synced == true)
        end,
        failed = function(err)
            print("[DonateDiscord] Sync failed:", err)
        end
    })
end

hook.Add("PlayerInitialSpawn", "DonateDiscord.SyncOnJoin", function(ply)
    timer.Simple(8, function()
        if not IsValid(ply) then return end
        DonateDiscord.SyncPlayer(ply)
    end)
end)

timer.Create("DonateDiscord.PendingCleanup", 60, 0, function()
    local now = os.time()
    for token, data in pairs(DonateDiscord.Pending) do
        if not data.expires or data.expires <= now then
            DonateDiscord.Pending[token] = nil
        end
    end
end)