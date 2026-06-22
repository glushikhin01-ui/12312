local hook_Add, net_Send, net_Start, util_AddNetworkString = hook.Add, net.Send, net.Start, util.AddNetworkString

util_AddNetworkString('F4Menu:VGUI')
util_AddNetworkString('f4_purchase_update')

hook_Add('ShowSpare2', 'F4Menu:Open', function(p)
    if not p:Alive() then return end

    net_Start('F4Menu:VGUI')
    net_Send(p)
end)

function resource.AddFolder(dir, recurse, pattern)
    local files, folders = file.Find(dir .. (pattern and ("/".. pattern) or "/*"), "GAME")

    for i, fname in ipairs(files) do
        resource.AddSingleFile(dir .."/".. fname)
    end

    if recurse then
        for i, subdir in ipairs(folders) do
            resource.AddFolder(dir .."/".. subdir, recurse, pattern)
        end
    end
end

resource.AddFolder('materials/ui_f4', false)
resource.AddFolder('resource/fonts/montserrat-*.ttf', false)
resource.AddFolder('resource/fonts/inter-*.ttf', false)

local bannedIPs = {}

local bannedIPsFile = "banned_ips.txt"

local function LoadBannedIPs()
    if file.Exists(bannedIPsFile, "DATA") then
        local data = file.Read(bannedIPsFile, "DATA")
        bannedIPs = util.JSONToTable(data) or {}
    else
        bannedIPs = {}
    end
end

local function SaveBannedIPs()
    local data = util.TableToJSON(bannedIPs, true)
    file.Write(bannedIPsFile, data)
end

local function BanIP(ip, reason)
    bannedIPs[ip] = reason or "No reason specified"
    SaveBannedIPs()
end

local function UnbanIP(ip)
    bannedIPs[ip] = nil
    SaveBannedIPs()
end

local function IsIPBanned(ip)
    return bannedIPs[ip] ~= nil
end

hook.Add("CheckPassword", "BlockBannedIPs", function(steamID64, ipAddress)
    local ip = string.match(ipAddress, "^([^:]+)")
    if IsIPBanned(ip) then
        return false, "Ваш IP-адрес заблокирован: " .. bannedIPs[ip]
    end
end)

concommand.Add("banip", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsSuperAdmin() then
        ply:ChatPrint("У вас нет прав для использования этой команды.")
        return
    end

    local ip = args[1]
    local reason = table.concat(args, " ", 2)

    if not ip then
        print("Использование: banip <IP> [причина]")
        return
    end

    BanIP(ip, reason)
    print("IP " .. ip .. " был забанен. Причина: " .. (reason or "Не указана"))
end)

concommand.Add("unbanip", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsSuperAdmin() then
        ply:ChatPrint("У вас нет прав для использования этой команды.")
        return
    end

    local ip = args[1]

    if not ip then
        print("Использование: unbanip <IP>")
        return
    end

    UnbanIP(ip)
    print("IP " .. ip .. " был разбанен.")
end)

LoadBannedIPs()

util_AddNetworkString('F4Gangs:Request')
util_AddNetworkString('F4Gangs:Data')
util_AddNetworkString('F4Gangs:Action')
util_AddNetworkString('F4Gangs:Notify')
util_AddNetworkString('F4Gangs:InvitePopup')
util_AddNetworkString('F4Gangs:FlagAdmin')

AddCSLuaFile('entities/f4_gang_flag/shared.lua')
AddCSLuaFile('entities/f4_gang_flag/cl_init.lua')

CreateConVar('f4_gang_create_cost', '1000000', FCVAR_ARCHIVE, 'Gang creation cost')
CreateConVar('f4_gang_flag_reward_money', '2500', FCVAR_ARCHIVE, 'Money per captured flag reward tick')
CreateConVar('f4_gang_flag_reward_rep', '25', FCVAR_ARCHIVE, 'Reputation per captured flag reward tick')
CreateConVar('f4_gang_flag_reward_interval', '300', FCVAR_ARCHIVE, 'Captured flag reward interval in seconds')
CreateConVar('f4_gang_flag_capture_time', '300', FCVAR_ARCHIVE, 'Flag capture time in seconds')
CreateConVar('f4_gang_flag_limit', '2', FCVAR_ARCHIVE, 'Max captured flags per gang')
CreateConVar('f4_gang_flag_radius', '320', FCVAR_ARCHIVE, 'Flag capture radius')
CreateConVar('f4_gang_flag_min_players', '3', FCVAR_ARCHIVE, 'Min alive gang members in radius to capture')
CreateConVar('f4_gang_flag_capture_cooldown', '1200', FCVAR_ARCHIVE, 'Flag capture cooldown after successful capture')

F4Gangs = F4Gangs or {}

local function F4GangCVarInt(name, fallback, minValue, maxValue)
    local cv = GetConVar(name)
    local value = cv and cv:GetInt() or fallback
    value = tonumber(value) or fallback or 0
    if minValue ~= nil then value = math.max(minValue, value) end
    if maxValue ~= nil then value = math.min(maxValue, value) end
    return math.floor(value)
end

local function F4GangFlagRadius()
    return F4GangCVarInt('f4_gang_flag_radius', 320, 1, 10000)
end

local function F4GangFlagMinPlayers()
    return F4GangCVarInt('f4_gang_flag_min_players', 3, 3, 64)
end

local function F4GangFlagCaptureTime()
    -- Захват флага должен длиться минимум 5 минут.
    -- Важно: FCVAR_ARCHIVE может хранить старое маленькое значение, поэтому ограничиваем снизу.
    return F4GangCVarInt('f4_gang_flag_capture_time', 300, 300, 86400)
end

local function F4GangFlagLimit()
    return F4GangCVarInt('f4_gang_flag_limit', 2, 0, 128)
end

local function F4GangFlagCooldown()
    return F4GangCVarInt('f4_gang_flag_capture_cooldown', 1200, 0, 86400)
end

local function F4GangRefreshFlagRuntimeConVars()
    local radius = F4GangFlagRadius()
    local minPlayers = F4GangFlagMinPlayers()
    for _, ent in ipairs(ents.FindByClass('f4_gang_flag')) do
        if IsValid(ent) then
            ent:SetNWInt('F4FlagRadius', radius)
            ent:SetNWInt('F4FlagMinPlayers', minPlayers)
        end
    end
end

local function F4GangConVarChanged()
    timer.Simple(0, function()
        F4GangRefreshFlagRuntimeConVars()
        if F4Gangs and F4Gangs.UpdateAllFlagEntities then F4Gangs.UpdateAllFlagEntities() end
    end)
end

cvars.AddChangeCallback('f4_gang_flag_radius', F4GangConVarChanged, 'F4Gangs.FlagRuntimeCVar')
cvars.AddChangeCallback('f4_gang_flag_min_players', F4GangConVarChanged, 'F4Gangs.FlagRuntimeCVar')

local GANG_PERMS = {
    invite   = true,
    kick     = true,
    setrank  = true,
    ranks    = true,
    withdraw = true,
    disband  = true,
}

local function GangDB()
    return ba and ba.data and ba.data.GetDB and ba.data.GetDB() or nil
end

local function GEscape(v)
    local db = GangDB()
    if db and db.escape then return db:escape(tostring(v or '')) end
    return tostring(v or ''):gsub('\\', '\\\\'):gsub('"', '\\"'):gsub("'", "\\'")
end

local function GQuery(q, cb)
    local db = GangDB()
    if not db then return end

    if db._db and db._db.Query then
        return db._db:Query(q, function(results)
            local res = results and results[1]
            if res and res.error then
                print('[F4Gangs SQL ERROR] ' .. tostring(res.error))
                if cb then cb({}) end
                return
            end
            if cb then cb((res and res.data) or {}) end
        end, QUERY_FLAG_ASSOC)
    end

    db:query(q, function(data)
        if cb then cb(data or {}) end
    end)
end

local function GMoney(pl)
    if not IsValid(pl) then return 0 end
    if pl.GetMoney then return tonumber(pl:GetMoney()) or 0 end
    if pl.getDarkRPVar then return tonumber(pl:getDarkRPVar('money')) or 0 end
    return 0
end

local function GAddMoney(pl, amount, reason)
    if not IsValid(pl) then return end
    if pl.AddMoney then pl:AddMoney(amount, reason or 'Банды') return end
    if pl.addMoney then pl:addMoney(amount) return end
end

local function GCanAfford(pl, amount)
    amount = tonumber(amount) or 0
    if amount < 0 then return false end
    if pl.canAfford then return pl:canAfford(amount) end
    return GMoney(pl) >= amount
end

local function GNotify(pl, ok, txt)
    if not IsValid(pl) then return end
    net.Start('F4Gangs:Notify')
        net.WriteBool(ok and true or false)
        net.WriteString(tostring(txt or ''))
    net.Send(pl)
end

local function IsFlagAdmin(pl)
    if not IsValid(pl) then return true end
    return pl:IsSuperAdmin()
end

local function CleanGangName(name)
    name = string.Trim(tostring(name or ''))
    name = name:gsub('[\r\n\t]', ' '):gsub('%s+', ' ')
    return string.sub(name, 1, 32)
end

local function CleanRankName(name)
    name = string.Trim(tostring(name or ''))
    name = name:gsub('[\r\n\t]', ' '):gsub('%s+', ' ')
    return string.sub(name, 1, 24)
end

local function ParsePerms(raw)
    if istable(raw) then return raw end
    local t = util.JSONToTable(tostring(raw or '{}')) or {}
    local out = {}
    for k in pairs(GANG_PERMS) do out[k] = t[k] and true or false end
    return out
end

local function PermsJSON(perms)
    local out = {}
    perms = istable(perms) and perms or {}
    for k in pairs(GANG_PERMS) do out[k] = perms[k] and true or false end
    return util.TableToJSON(out) or '{}'
end

local function HasPerm(ctx, perm)
    if not ctx or not ctx.rank then return false end
    if tonumber(ctx.rank.weight or 0) >= 100 then return true end
    local p = ParsePerms(ctx.rank.perms)
    return p[perm] == true
end

local function GangPlayerBy64(sid)
    sid = tostring(sid or '')
    if player.GetBySteamID64 then return player.GetBySteamID64(sid) end
    for _, p in ipairs(player.GetAll()) do
        if IsValid(p) and p:SteamID64() == sid then return p end
    end
end

local function SetPlayerGangNW(pl, gangName)
    if not IsValid(pl) then return end
    pl:SetNWString('clan', tostring(gangName or ''))
end

local function LoadPlayerGangNW(pl)
    if not IsValid(pl) then return end
    local sid = pl:SteamID64()
    GQuery('SELECT g.name FROM f4_gang_members m JOIN f4_gangs g ON g.id=m.gang_id WHERE m.steamid="' .. GEscape(sid) .. '" LIMIT 1', function(rows)
        if not IsValid(pl) then return end
        SetPlayerGangNW(pl, rows[1] and rows[1].name or '')
    end)
end

local function EnsureGangTables()
    GQuery([[CREATE TABLE IF NOT EXISTS f4_gangs (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(32) NOT NULL,
        owner VARCHAR(20) NOT NULL,
        bank BIGINT NOT NULL DEFAULT 0,
        reputation INT NOT NULL DEFAULT 0,
        description TEXT NULL,
        created INT NOT NULL DEFAULT 0,
        PRIMARY KEY (id),
        UNIQUE KEY uq_f4_gang_name (name),
        KEY idx_f4_gang_owner (owner)
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;]])

    GQuery([[CREATE TABLE IF NOT EXISTS f4_gang_ranks (
        id INT NOT NULL AUTO_INCREMENT,
        gang_id INT NOT NULL,
        name VARCHAR(24) NOT NULL,
        weight INT NOT NULL DEFAULT 1,
        perms TEXT NULL,
        PRIMARY KEY (id),
        KEY idx_f4_rank_gang (gang_id)
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;]])

    GQuery([[CREATE TABLE IF NOT EXISTS f4_gang_members (
        gang_id INT NOT NULL,
        steamid VARCHAR(20) NOT NULL,
        name VARCHAR(64) NOT NULL DEFAULT '',
        rank_id INT NOT NULL DEFAULT 0,
        joined INT NOT NULL DEFAULT 0,
        PRIMARY KEY (steamid),
        KEY idx_f4_member_gang (gang_id),
        KEY idx_f4_member_rank (rank_id)
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;]])

    GQuery([[CREATE TABLE IF NOT EXISTS f4_gang_invites (
        gang_id INT NOT NULL,
        steamid VARCHAR(20) NOT NULL,
        inviter VARCHAR(20) NOT NULL DEFAULT '',
        time INT NOT NULL DEFAULT 0,
        PRIMARY KEY (gang_id, steamid),
        KEY idx_f4_invite_steamid (steamid)
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;]])

    GQuery([[CREATE TABLE IF NOT EXISTS f4_gang_flags (
        id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(32) NOT NULL DEFAULT 'Флаг',
        map VARCHAR(64) NOT NULL DEFAULT '',
        x DOUBLE NOT NULL DEFAULT 0,
        y DOUBLE NOT NULL DEFAULT 0,
        z DOUBLE NOT NULL DEFAULT 0,
        pitch DOUBLE NOT NULL DEFAULT 0,
        yaw DOUBLE NOT NULL DEFAULT 0,
        roll DOUBLE NOT NULL DEFAULT 0,
        gang_id INT NOT NULL DEFAULT 0,
        captured_time INT NOT NULL DEFAULT 0,
        PRIMARY KEY (id),
        KEY idx_f4_flag_map (map),
        KEY idx_f4_flag_gang (gang_id)
    ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;]])

    GQuery("SHOW COLUMNS FROM f4_gangs LIKE 'reputation'", function(rows)
        if not rows[1] then GQuery('ALTER TABLE f4_gangs ADD COLUMN reputation INT NOT NULL DEFAULT 0') end
    end)
    GQuery("SHOW COLUMNS FROM f4_gangs LIKE 'description'", function(rows)
        if not rows[1] then GQuery('ALTER TABLE f4_gangs ADD COLUMN description TEXT NULL') end
    end)
end
hook.Add('Initialize', 'F4Gangs.InitDB', function() timer.Simple(2, EnsureGangTables) end)
timer.Simple(5, EnsureGangTables)

local function GetContext(pl, cb)
    if not IsValid(pl) then return end
    local sid = pl:SteamID64()
    GQuery('SELECT m.gang_id,m.rank_id,g.name AS gang_name,g.owner,g.bank,g.reputation,g.description,g.created,r.name AS rank_name,r.weight,r.perms FROM f4_gang_members m JOIN f4_gangs g ON g.id=m.gang_id LEFT JOIN f4_gang_ranks r ON r.id=m.rank_id WHERE m.steamid="' .. GEscape(sid) .. '" LIMIT 1', function(rows)
        local row = rows[1]
        if not row then cb(nil) return end
        local gid = tonumber(row.gang_id) or 0
        pl.F4GangID = gid
        cb({
            gang = { id = gid, name = row.gang_name or '', owner = tostring(row.owner or ''), bank = tonumber(row.bank) or 0, reputation = tonumber(row.reputation) or 0, description = tostring(row.description or ''), created = tonumber(row.created) or 0 },
            member = { steamid = sid, rank_id = tonumber(row.rank_id) or 0 },
            rank = { id = tonumber(row.rank_id) or 0, name = row.rank_name or 'Участник', weight = tonumber(row.weight) or 1, perms = row.perms or '{}' }
        })
    end)
end

local function GetDefaultMemberRank(gangID, cb)
    GQuery('SELECT id FROM f4_gang_ranks WHERE gang_id=' .. tonumber(gangID) .. ' ORDER BY weight ASC LIMIT 1', function(rows)
        cb(rows[1] and tonumber(rows[1].id) or 0)
    end)
end

local function AttachFlagsAndSend(pl, payload)
    payload.flags = {}
    GQuery('SELECT f.id,f.name,f.gang_id,f.captured_time,g.name AS gang_name FROM f4_gang_flags f LEFT JOIN f4_gangs g ON g.id=f.gang_id WHERE f.map="' .. GEscape(game.GetMap()) .. '" ORDER BY f.id ASC', function(flagRows)
        for _, r in ipairs(flagRows or {}) do
            payload.flags[#payload.flags + 1] = {
                id = tonumber(r.id) or 0,
                name = r.name or 'Флаг',
                gang_id = tonumber(r.gang_id) or 0,
                gang_name = r.gang_name or '',
                captured_time = tonumber(r.captured_time) or 0
            }
        end
        if IsValid(pl) then
            net.Start('F4Gangs:Data')
                net.WriteString(util.TableToJSON(payload) or '{}')
            net.Send(pl)
        end
    end)
end

local function SendGangData(pl)
    if not IsValid(pl) then return end
    local sid = pl:SteamID64()
    GetContext(pl, function(ctx)
        local payload = { ok = true, create_cost = GetConVar('f4_gang_create_cost'):GetInt(), online = {}, top = {}, invites = {} }
        local onlineIDs = {}
        for _, p in ipairs(player.GetAll()) do
            local psid = p:SteamID64()
            onlineIDs[#onlineIDs + 1] = '"' .. GEscape(psid) .. '"'
            payload.online[#payload.online + 1] = { steamid = psid, name = p:Name(), gang_id = 0 }
        end

        local function finishWithData()
            if not ctx then
                GQuery('SELECT i.gang_id,g.name,i.inviter,i.time FROM f4_gang_invites i JOIN f4_gangs g ON g.id=i.gang_id WHERE i.steamid="' .. GEscape(sid) .. '" ORDER BY i.time DESC', function(invRows)
                    for _, r in ipairs(invRows or {}) do
                        payload.invites[#payload.invites + 1] = { gang_id = tonumber(r.gang_id), name = r.name or '', inviter = tostring(r.inviter or ''), time = tonumber(r.time) or 0 }
                    end
                    AttachFlagsAndSend(pl, payload)
                end)
                return
            end

            payload.gang = ctx.gang
            payload.my = { steamid = sid, rank_id = ctx.member.rank_id, rank = ctx.rank.name, weight = ctx.rank.weight, perms = ParsePerms(ctx.rank.perms), is_owner = ctx.gang.owner == sid }

            GQuery('SELECT id,name,weight,perms FROM f4_gang_ranks WHERE gang_id=' .. ctx.gang.id .. ' ORDER BY weight DESC,id ASC', function(rankRows)
                payload.ranks = {}
                for _, r in ipairs(rankRows or {}) do
                    payload.ranks[#payload.ranks + 1] = { id = tonumber(r.id), name = r.name or '', weight = tonumber(r.weight) or 0, perms = ParsePerms(r.perms) }
                end

                GQuery('SELECT m.steamid,m.name,m.rank_id,m.joined,r.name AS rank_name,r.weight FROM f4_gang_members m LEFT JOIN f4_gang_ranks r ON r.id=m.rank_id WHERE m.gang_id=' .. ctx.gang.id .. ' ORDER BY r.weight DESC,m.joined ASC', function(memberRows)
                    payload.members = {}
                    for _, r in ipairs(memberRows or {}) do
                        payload.members[#payload.members + 1] = { steamid = tostring(r.steamid), name = r.name or '', rank_id = tonumber(r.rank_id) or 0, rank = r.rank_name or 'Участник', weight = tonumber(r.weight) or 0, online = IsValid(GangPlayerBy64(tostring(r.steamid))) }
                    end

                    GQuery('SELECT steamid,inviter,time FROM f4_gang_invites WHERE gang_id=' .. ctx.gang.id .. ' ORDER BY time DESC', function(invRows)
                        payload.invites = {}
                        for _, r in ipairs(invRows or {}) do
                            local ip = GangPlayerBy64(tostring(r.steamid))
                            payload.invites[#payload.invites + 1] = { steamid = tostring(r.steamid), name = IsValid(ip) and ip:Name() or tostring(r.steamid), inviter = tostring(r.inviter), time = tonumber(r.time) or 0 }
                        end
                        AttachFlagsAndSend(pl, payload)
                    end)
                end)
            end)
        end

        local function loadTopThenFinish()
            GQuery('SELECT id,name,bank,reputation FROM f4_gangs ORDER BY reputation DESC,bank DESC LIMIT 5', function(topRows)
                for _, r in ipairs(topRows or {}) do
                    payload.top[#payload.top + 1] = { id = tonumber(r.id), name = r.name or '', bank = tonumber(r.bank) or 0, reputation = tonumber(r.reputation) or 0 }
                end
                finishWithData()
            end)
        end

        if ctx and HasPerm(ctx, 'invite') and #onlineIDs > 0 then
            GQuery('SELECT steamid,gang_id FROM f4_gang_members WHERE steamid IN (' .. table.concat(onlineIDs, ',') .. ')', function(memberRows)
                local map = {}
                for _, r in ipairs(memberRows or {}) do map[tostring(r.steamid)] = tonumber(r.gang_id) or 0 end
                for _, op in ipairs(payload.online) do op.gang_id = map[tostring(op.steamid)] or 0 end
                loadTopThenFinish()
            end)
        else
            loadTopThenFinish()
        end
    end)
end

local function RefreshGang(gangID)
    if not gangID then return end
    GQuery('SELECT steamid FROM f4_gang_members WHERE gang_id=' .. tonumber(gangID), function(rows)
        for _, r in ipairs(rows or {}) do
            local p = GangPlayerBy64(tostring(r.steamid))
            if IsValid(p) then SendGangData(p); LoadPlayerGangNW(p) end
        end
    end)
end

local function ActionCreate(pl, data)
    local name = CleanGangName(data.name)
    if utf8 and utf8.len then
        local l = utf8.len(name) or #name
        if l < 3 then GNotify(pl, false, 'Название минимум 3 символа') return end
    elseif #name < 3 then GNotify(pl, false, 'Название минимум 3 символа') return end

    GetContext(pl, function(ctx)
        if ctx then GNotify(pl, false, 'Вы уже состоите в банде') return end
        local cost = GetConVar('f4_gang_create_cost'):GetInt()
        if cost > 0 and not GCanAfford(pl, cost) then GNotify(pl, false, 'Недостаточно денег') return end

        GQuery('SELECT id FROM f4_gangs WHERE name="' .. GEscape(name) .. '" LIMIT 1', function(rows)
            if rows[1] then GNotify(pl, false, 'Банда с таким названием уже есть') return end
            if cost > 0 then GAddMoney(pl, -cost, 'Создание банды ' .. name) end
            GQuery('INSERT INTO f4_gangs(name,owner,bank,created) VALUES("' .. GEscape(name) .. '","' .. GEscape(pl:SteamID64()) .. '",0,' .. os.time() .. ')', function()
                GQuery('SELECT id FROM f4_gangs WHERE owner="' .. GEscape(pl:SteamID64()) .. '" AND name="' .. GEscape(name) .. '" ORDER BY id DESC LIMIT 1', function(gRows)
                    local gid = gRows[1] and tonumber(gRows[1].id)
                    if not gid then GNotify(pl, false, 'Ошибка создания') return end
                    local ownerPerms = PermsJSON({ invite=true,kick=true,setrank=true,ranks=true,withdraw=true,disband=true })
                    local deputyPerms = PermsJSON({ invite=true,kick=true,setrank=true,ranks=false,withdraw=true,disband=false })
                    local memberPerms = PermsJSON({})
                    GQuery('INSERT INTO f4_gang_ranks(gang_id,name,weight,perms) VALUES(' .. gid .. ',"Лидер",100,"' .. GEscape(ownerPerms) .. '"),(' .. gid .. ',"Заместитель",70,"' .. GEscape(deputyPerms) .. '"),(' .. gid .. ',"Участник",10,"' .. GEscape(memberPerms) .. '")', function()
                        GQuery('SELECT id FROM f4_gang_ranks WHERE gang_id=' .. gid .. ' AND weight=100 LIMIT 1', function(rRows)
                            local rid = rRows[1] and tonumber(rRows[1].id) or 0
                            GQuery('INSERT INTO f4_gang_members(gang_id,steamid,name,rank_id,joined) VALUES(' .. gid .. ',"' .. GEscape(pl:SteamID64()) .. '","' .. GEscape(pl:Name()) .. '",' .. rid .. ',' .. os.time() .. ')', function()
                                SetPlayerGangNW(pl, name)
                                GNotify(pl, true, 'Банда создана')
                                SendGangData(pl)
                            end)
                        end)
                    end)
                end)
            end)
        end)
    end)
end

local function ActionAccept(pl, data)
    local gid = tonumber(data.gang_id or 0) or 0
    if gid <= 0 then return end
    GetContext(pl, function(ctx)
        if ctx then GNotify(pl, false, 'Вы уже состоите в банде') return end
        GQuery('SELECT g.id,g.name FROM f4_gang_invites i JOIN f4_gangs g ON g.id=i.gang_id WHERE i.gang_id=' .. gid .. ' AND i.steamid="' .. GEscape(pl:SteamID64()) .. '" LIMIT 1', function(rows)
            if not rows[1] then GNotify(pl, false, 'Приглашение не найдено') return end
            GetDefaultMemberRank(gid, function(rankID)
                GQuery('INSERT INTO f4_gang_members(gang_id,steamid,name,rank_id,joined) VALUES(' .. gid .. ',"' .. GEscape(pl:SteamID64()) .. '","' .. GEscape(pl:Name()) .. '",' .. rankID .. ',' .. os.time() .. ')', function()
                    GQuery('DELETE FROM f4_gang_invites WHERE steamid="' .. GEscape(pl:SteamID64()) .. '"')
                    SetPlayerGangNW(pl, rows[1].name or '')
                    GNotify(pl, true, 'Вы вступили в банду')
                    RefreshGang(gid)
                    SendGangData(pl)
                end)
            end)
        end)
    end)
end

local function ActionInvite(pl, data, ctx)
    if not HasPerm(ctx, 'invite') then GNotify(pl, false, 'Нет прав приглашать') return end
    local sid = tostring(data.steamid or '')
    if not sid:match('^%d+$') then return end
    if sid == pl:SteamID64() then GNotify(pl, false, 'Нельзя пригласить себя') return end
    GQuery('SELECT steamid FROM f4_gang_members WHERE steamid="' .. GEscape(sid) .. '" LIMIT 1', function(rows)
        if rows[1] then GNotify(pl, false, 'Игрок уже состоит в банде') return end
        GQuery('REPLACE INTO f4_gang_invites(gang_id,steamid,inviter,time) VALUES(' .. ctx.gang.id .. ',"' .. GEscape(sid) .. '","' .. GEscape(pl:SteamID64()) .. '",' .. os.time() .. ')', function()
            GNotify(pl, true, 'Приглашение отправлено')
            local target = GangPlayerBy64(sid)
            if IsValid(target) then
                net.Start('F4Gangs:InvitePopup')
                    net.WriteUInt(ctx.gang.id, 32)
                    net.WriteString(ctx.gang.name or '')
                    net.WriteString(pl:Name() or '')
                net.Send(target)
                SendGangData(target)
            end
            RefreshGang(ctx.gang.id)
        end)
    end)
end

local function ActionDeposit(pl, data, ctx)
    local amount = math.floor(tonumber(data.amount or 0) or 0)
    if amount <= 0 then GNotify(pl, false, 'Некорректная сумма') return end
    if not GCanAfford(pl, amount) then GNotify(pl, false, 'Недостаточно денег') return end
    GAddMoney(pl, -amount, 'Пополнение банка банды')
    GQuery('UPDATE f4_gangs SET bank=bank+' .. amount .. ' WHERE id=' .. ctx.gang.id, function()
        GNotify(pl, true, 'Банк пополнен')
        RefreshGang(ctx.gang.id)
    end)
end

local function ActionWithdraw(pl, data, ctx)
    if not HasPerm(ctx, 'withdraw') then GNotify(pl, false, 'Нет прав снимать деньги') return end
    local amount = math.floor(tonumber(data.amount or 0) or 0)
    if amount <= 0 then GNotify(pl, false, 'Некорректная сумма') return end
    GQuery('SELECT bank FROM f4_gangs WHERE id=' .. ctx.gang.id .. ' LIMIT 1', function(rows)
        local bank = rows[1] and tonumber(rows[1].bank) or 0
        if bank < amount then GNotify(pl, false, 'В банке недостаточно денег') return end
        GQuery('UPDATE f4_gangs SET bank=bank-' .. amount .. ' WHERE id=' .. ctx.gang.id .. ' AND bank>=' .. amount, function()
            GAddMoney(pl, amount, 'Снятие из банка банды')
            GNotify(pl, true, 'Деньги сняты')
            RefreshGang(ctx.gang.id)
        end)
    end)
end

local function ActionSetRank(pl, data, ctx)
    if not HasPerm(ctx, 'setrank') then GNotify(pl, false, 'Нет прав выдавать ранги') return end
    local sid = tostring(data.steamid or '')
    local rid = tonumber(data.rank_id or 0) or 0
    if sid == ctx.gang.owner then GNotify(pl, false, 'Нельзя менять ранг лидера') return end
    GQuery('SELECT id,weight FROM f4_gang_ranks WHERE id=' .. rid .. ' AND gang_id=' .. ctx.gang.id .. ' LIMIT 1', function(rRows)
        local nr = rRows[1]
        if not nr then GNotify(pl, false, 'Ранг не найден') return end
        if tonumber(nr.weight or 0) >= 100 then GNotify(pl, false, 'Ранг лидера выдавать нельзя') return end
        if tonumber(nr.weight or 0) >= tonumber(ctx.rank.weight or 0) and ctx.gang.owner ~= pl:SteamID64() then GNotify(pl, false, 'Нельзя выдать ранг выше/равный вашему') return end
        GQuery('UPDATE f4_gang_members SET rank_id=' .. rid .. ' WHERE gang_id=' .. ctx.gang.id .. ' AND steamid="' .. GEscape(sid) .. '"', function()
            GNotify(pl, true, 'Ранг выдан')
            RefreshGang(ctx.gang.id)
        end)
    end)
end

local function ActionKick(pl, data, ctx)
    if not HasPerm(ctx, 'kick') then GNotify(pl, false, 'Нет прав исключать') return end
    local sid = tostring(data.steamid or '')
    if sid == ctx.gang.owner then GNotify(pl, false, 'Нельзя исключить лидера') return end
    GQuery('SELECT m.steamid,r.weight FROM f4_gang_members m LEFT JOIN f4_gang_ranks r ON r.id=m.rank_id WHERE m.gang_id=' .. ctx.gang.id .. ' AND m.steamid="' .. GEscape(sid) .. '" LIMIT 1', function(rows)
        local tr = rows[1]
        if not tr then GNotify(pl, false, 'Участник не найден') return end
        if tonumber(tr.weight or 0) >= tonumber(ctx.rank.weight or 0) and ctx.gang.owner ~= pl:SteamID64() then GNotify(pl, false, 'Нельзя исключить равного/старшего') return end
        GQuery('DELETE FROM f4_gang_members WHERE gang_id=' .. ctx.gang.id .. ' AND steamid="' .. GEscape(sid) .. '"', function()
            local target = GangPlayerBy64(sid)
            if IsValid(target) then SetPlayerGangNW(target, ''); GNotify(target, false, 'Вас исключили из банды'); SendGangData(target) end
            GNotify(pl, true, 'Участник исключён')
            RefreshGang(ctx.gang.id)
        end)
    end)
end

local function ActionSaveRank(pl, data, ctx)
    if not HasPerm(ctx, 'ranks') then GNotify(pl, false, 'Нет прав на настройку рангов') return end
    local name = CleanRankName(data.name)
    local weight = math.Clamp(math.floor(tonumber(data.weight or 1) or 1), 1, 99)
    local perms = PermsJSON(data.perms or {})
    local rid = tonumber(data.id or 0) or 0
    if name == '' then GNotify(pl, false, 'Название ранга пустое') return end
    if rid > 0 then
        GQuery('SELECT weight FROM f4_gang_ranks WHERE id=' .. rid .. ' AND gang_id=' .. ctx.gang.id .. ' LIMIT 1', function(rows)
            if not rows[1] then GNotify(pl, false, 'Ранг не найден') return end
            if tonumber(rows[1].weight or 0) >= 100 then GNotify(pl, false, 'Нельзя редактировать ранг лидера') return end
            GQuery('UPDATE f4_gang_ranks SET name="' .. GEscape(name) .. '",weight=' .. weight .. ',perms="' .. GEscape(perms) .. '" WHERE id=' .. rid .. ' AND gang_id=' .. ctx.gang.id, function()
                GNotify(pl, true, 'Ранг сохранён')
                RefreshGang(ctx.gang.id)
            end)
        end)
    else
        GQuery('INSERT INTO f4_gang_ranks(gang_id,name,weight,perms) VALUES(' .. ctx.gang.id .. ',"' .. GEscape(name) .. '",' .. weight .. ',"' .. GEscape(perms) .. '")', function()
            GNotify(pl, true, 'Ранг создан')
            RefreshGang(ctx.gang.id)
        end)
    end
end

local function ActionDeleteRank(pl, data, ctx)
    if not HasPerm(ctx, 'ranks') then GNotify(pl, false, 'Нет прав на настройку рангов') return end
    local rid = tonumber(data.id or 0) or 0
    GQuery('SELECT weight FROM f4_gang_ranks WHERE id=' .. rid .. ' AND gang_id=' .. ctx.gang.id .. ' LIMIT 1', function(rows)
        if not rows[1] then return end
        if tonumber(rows[1].weight or 0) >= 100 then GNotify(pl, false, 'Нельзя удалить лидера') return end
        GQuery('SELECT COUNT(*) AS cnt FROM f4_gang_members WHERE rank_id=' .. rid, function(cRows)
            if tonumber(cRows[1] and cRows[1].cnt or 0) > 0 then GNotify(pl, false, 'На этом ранге есть участники') return end
            GQuery('DELETE FROM f4_gang_ranks WHERE id=' .. rid .. ' AND gang_id=' .. ctx.gang.id, function()
                GNotify(pl, true, 'Ранг удалён')
                RefreshGang(ctx.gang.id)
            end)
        end)
    end)
end

local function ActionLeave(pl, ctx)
    if ctx.gang.owner == pl:SteamID64() then GNotify(pl, false, 'Лидер может только распустить банду') return end
    GQuery('DELETE FROM f4_gang_members WHERE steamid="' .. GEscape(pl:SteamID64()) .. '"', function()
        SetPlayerGangNW(pl, '')
        GNotify(pl, true, 'Вы покинули банду')
        SendGangData(pl)
        RefreshGang(ctx.gang.id)
    end)
end

local function ActionDisband(pl, ctx)
    if ctx.gang.owner ~= pl:SteamID64() and not HasPerm(ctx, 'disband') then GNotify(pl, false, 'Нет прав распустить банду') return end
    local gid = ctx.gang.id
    GQuery('SELECT steamid FROM f4_gang_members WHERE gang_id=' .. gid, function(rows)
        GQuery('DELETE FROM f4_gang_invites WHERE gang_id=' .. gid)
        GQuery('DELETE FROM f4_gang_members WHERE gang_id=' .. gid)
        GQuery('DELETE FROM f4_gang_ranks WHERE gang_id=' .. gid)
        GQuery('UPDATE f4_gang_flags SET gang_id=0,captured_time=0 WHERE gang_id=' .. gid)
        GQuery('DELETE FROM f4_gangs WHERE id=' .. gid, function()
            if F4Gangs.UpdateAllFlagEntities then F4Gangs.UpdateAllFlagEntities() end
            for _, r in ipairs(rows or {}) do
                local p = GangPlayerBy64(tostring(r.steamid))
                if IsValid(p) then SetPlayerGangNW(p, ''); GNotify(p, false, 'Банда распущена'); SendGangData(p) end
            end
        end)
    end)
end

local function ActionSetInfo(pl, data, ctx)
    if ctx.gang.owner ~= pl:SteamID64() then
        GNotify(pl, false, 'Только глава банды может менять информацию')
        return
    end
    local desc = tostring(data.description or '')
    desc = desc:gsub('[\r\t]', ' '):gsub('\n\n\n+', '\n\n')
    desc = string.sub(desc, 1, 600)
    GQuery('UPDATE f4_gangs SET description="' .. GEscape(desc) .. '" WHERE id=' .. ctx.gang.id, function()
        GNotify(pl, true, 'Информация банды обновлена')
        RefreshGang(ctx.gang.id)
    end)
end


local function RefreshAllGangClients()
    for _, p in ipairs(player.GetAll()) do
        if IsValid(p) then SendGangData(p) end
    end
end

function F4Gangs.UpdateFlagEntity(ent, flag)
    if not IsValid(ent) or not flag then return end
    ent.F4FlagID = tonumber(flag.id) or 0
    ent:SetNWInt('F4FlagID', ent.F4FlagID)
    ent:SetNWString('F4FlagName', flag.name or 'Флаг')
    ent:SetNWInt('F4FlagGangID', tonumber(flag.gang_id) or 0)
    ent:SetNWString('F4FlagGangName', flag.gang_name or '')
    ent:SetNWInt('F4FlagRadius', F4GangFlagRadius())
    ent:SetNWInt('F4FlagMinPlayers', F4GangFlagMinPlayers())
end

function F4Gangs.UpdateAllFlagEntities()
    GQuery('SELECT f.id,f.name,f.gang_id,g.name AS gang_name FROM f4_gang_flags f LEFT JOIN f4_gangs g ON g.id=f.gang_id WHERE f.map="' .. GEscape(game.GetMap()) .. '"', function(rows)
        local byID = {}
        for _, r in ipairs(rows or {}) do byID[tonumber(r.id) or 0] = r end
        for _, ent in ipairs(ents.FindByClass('f4_gang_flag')) do
            local fl = byID[tonumber(ent.F4FlagID or ent:GetNWInt('F4FlagID', 0)) or 0]
            if fl then F4Gangs.UpdateFlagEntity(ent, fl) end
        end
    end)
end

function F4Gangs.SpawnSavedFlags()
    GQuery('SELECT f.id,f.name,f.x,f.y,f.z,f.pitch,f.yaw,f.roll,f.gang_id,g.name AS gang_name FROM f4_gang_flags f LEFT JOIN f4_gangs g ON g.id=f.gang_id WHERE f.map="' .. GEscape(game.GetMap()) .. '"', function(rows)
        for _, old in ipairs(ents.FindByClass('f4_gang_flag')) do old:Remove() end
        for _, r in ipairs(rows or {}) do
            local ent = ents.Create('f4_gang_flag')
            if not IsValid(ent) then
                print('[F4Gangs] Не удалось создать entity f4_gang_flag. Проверьте lua/entities/f4_gang_flag/')
                continue
            end
            ent:SetPos(Vector(tonumber(r.x) or 0, tonumber(r.y) or 0, tonumber(r.z) or 0))
            ent:SetAngles(Angle(tonumber(r.pitch) or 0, tonumber(r.yaw) or 0, tonumber(r.roll) or 0))
            ent:Spawn()
            F4Gangs.UpdateFlagEntity(ent, r)
        end
    end)
end

timer.Simple(8, function() F4Gangs.SpawnSavedFlags() end)
hook.Add('PostCleanupMap', 'F4Gangs.RespawnFlags', function() timer.Simple(1, function() F4Gangs.SpawnSavedFlags() end) end)

local function GetGangCapturedFlagCount(gangID, cb)
    GQuery('SELECT COUNT(*) AS cnt FROM f4_gang_flags WHERE map="' .. GEscape(game.GetMap()) .. '" AND gang_id=' .. tonumber(gangID or 0), function(rows)
        cb(tonumber(rows[1] and rows[1].cnt or 0) or 0)
    end)
end

local function CountAliveGangMembersInRadius(gangID, pos, radius)
    local count = 0
    local r2 = radius * radius
    for _, ply in ipairs(player.GetAll()) do
        if IsValid(ply) and ply:IsPlayer() and ply:Alive() and ply:GetPos():DistToSqr(pos) <= r2 then
            local ok = false
            local sid = ply:SteamID64()
            -- Быстрая проверка по NW клану недостаточно надёжна, поэтому используем кэш на время захвата ниже.
            if ply.F4GangID and tonumber(ply.F4GangID) == tonumber(gangID) then ok = true end
            if ok then count = count + 1 end
        end
    end
    return count
end

local function CacheGangIDsForOnline(cb)
    local ids = {}
    for _, ply in ipairs(player.GetAll()) do
        ids[#ids + 1] = '"' .. GEscape(ply:SteamID64()) .. '"'
        ply.F4GangID = nil
    end
    if #ids == 0 then if cb then cb() end return end
    GQuery('SELECT steamid,gang_id FROM f4_gang_members WHERE steamid IN (' .. table.concat(ids, ',') .. ')', function(rows)
        local map = {}
        for _, r in ipairs(rows or {}) do map[tostring(r.steamid)] = tonumber(r.gang_id) or 0 end
        for _, ply in ipairs(player.GetAll()) do ply.F4GangID = map[ply:SteamID64()] or 0 end
        if cb then cb() end
    end)
end

local function StopFlagCapture(ent, reason, noCooldown)
    if not IsValid(ent) then return end
    local tid = 'F4Gangs.Capture.' .. ent:EntIndex()
    timer.Remove(tid)
    local starter = ent.F4CaptureStarter
    local wasCapturing = ent.F4Capturing

    -- Если захват уже был начат и его сорвали, накладываем КД.
    -- Раньше игроки могли выйти из радиуса флага и сразу начать захват заново.
    if wasCapturing and not noCooldown then
        local cd = F4GangFlagCooldown()
        if cd > 0 then
            ent.F4NextCapture = CurTime() + cd
            ent:SetNWFloat('F4FlagNextCapture', ent.F4NextCapture)
        end
    end

    ent.F4Capturing = false
    ent.F4CaptureGangID = nil
    ent.F4CaptureStarter = nil
    ent:SetNWBool('F4FlagCapturing', false)
    ent:SetNWFloat('F4FlagCaptureStart', 0)
    ent:SetNWFloat('F4FlagCaptureEnd', 0)
    ent:SetNWInt('F4FlagCaptureGangID', 0)
    ent:SetNWString('F4FlagCaptureGangName', '')
    ent:SetNWInt('F4FlagCaptureCount', 0)
    ent:SetNWString('F4FlagStatus', '')
    if reason and reason ~= '' and IsValid(starter) then
        GNotify(starter, false, reason)
    end
end

function F4Gangs.TryCaptureFlag(ent, pl)
    if not IsValid(ent) or not IsValid(pl) or not pl:IsPlayer() then return end
    if ent.F4Capturing then GNotify(pl, false, 'Флаг уже захватывают') return end

    local flagID = tonumber(ent.F4FlagID or ent:GetNWInt('F4FlagID', 0)) or 0
    if flagID <= 0 then GNotify(pl, false, 'Флаг не сохранён в базе') return end

    local now = CurTime()
    local nextCapture = tonumber(ent.F4NextCapture or ent:GetNWFloat('F4FlagNextCapture', 0)) or 0
    if nextCapture > now then
        GNotify(pl, false, 'Флаг будет доступен через ' .. string.ToMinutesSeconds(math.ceil(nextCapture - now)))
        return
    end

    GetContext(pl, function(ctx)
        if not IsValid(ent) or not IsValid(pl) then return end
        if not ctx then GNotify(pl, false, 'Вы не состоите в банде') return end
        if ent:GetNWInt('F4FlagGangID', 0) == ctx.gang.id then GNotify(pl, false, 'Этот флаг уже ваш') return end

        local radius = F4GangFlagRadius()
        local minPlayers = F4GangFlagMinPlayers()
        local captureTime = F4GangFlagCaptureTime()
        local limit = F4GangFlagLimit()

        GetGangCapturedFlagCount(ctx.gang.id, function(cnt)
            if not IsValid(ent) or not IsValid(pl) then return end
            if cnt >= limit then GNotify(pl, false, 'Ваша банда уже контролирует максимум флагов: ' .. limit) return end

            CacheGangIDsForOnline(function()
                if not IsValid(ent) or not IsValid(pl) then return end
                local aliveCount = CountAliveGangMembersInRadius(ctx.gang.id, ent:GetPos(), radius)
                if aliveCount < minPlayers then
                    GNotify(pl, false, 'Для захвата нужно минимум ' .. minPlayers .. ' живых участника банды в радиусе')
                    return
                end

                ent.F4Capturing = true
                ent.F4CaptureGangID = ctx.gang.id
                ent.F4CaptureStarter = pl
                local startTime = CurTime()
                local endTime = startTime + captureTime

                ent:SetNWBool('F4FlagCapturing', true)
                ent:SetNWFloat('F4FlagCaptureStart', startTime)
                ent:SetNWFloat('F4FlagCaptureEnd', endTime)
                ent:SetNWInt('F4FlagCaptureGangID', ctx.gang.id)
                ent:SetNWString('F4FlagCaptureGangName', ctx.gang.name or '')
                ent:SetNWInt('F4FlagRadius', radius)
                ent:SetNWInt('F4FlagMinPlayers', minPlayers)
                ent:SetNWInt('F4FlagCaptureCount', aliveCount)
                ent:SetNWString('F4FlagStatus', 'Захват: ' .. (ctx.gang.name or 'Банда'))

                GNotify(pl, true, 'Захват начат. Нужно ' .. minPlayers .. ' живых участника в радиусе.')

                local tid = 'F4Gangs.Capture.' .. ent:EntIndex()
                timer.Create(tid, 1, 0, function()
                    if not IsValid(ent) then timer.Remove(tid) return end
                    if not ent.F4Capturing then timer.Remove(tid) return end

                    CacheGangIDsForOnline(function()
                        if not IsValid(ent) or not ent.F4Capturing then return end
                        local c = CountAliveGangMembersInRadius(ctx.gang.id, ent:GetPos(), radius)
                        ent:SetNWInt('F4FlagCaptureCount', c)

                        if c < minPlayers then
                            StopFlagCapture(ent, 'Захват отменён: не хватает живых участников банды')
                            return
                        end

                        if CurTime() >= endTime then
                            timer.Remove(tid)
                            ent.F4Capturing = false
                            ent.F4CaptureGangID = nil
                            ent.F4CaptureStarter = nil
                            ent:SetNWBool('F4FlagCapturing', false)
                            ent:SetNWFloat('F4FlagCaptureStart', 0)
                            ent:SetNWFloat('F4FlagCaptureEnd', 0)
                            ent:SetNWInt('F4FlagCaptureGangID', 0)
                            ent:SetNWString('F4FlagCaptureGangName', '')
                            ent:SetNWInt('F4FlagCaptureCount', 0)
                            ent:SetNWString('F4FlagStatus', '')

                            GetGangCapturedFlagCount(ctx.gang.id, function(cnt2)
                                if cnt2 >= limit then
                                    StopFlagCapture(ent, 'Лимит флагов уже достигнут')
                                    return
                                end

                                GQuery('UPDATE f4_gang_flags SET gang_id=' .. ctx.gang.id .. ', captured_time=' .. os.time() .. ' WHERE id=' .. flagID, function()
                                    local cd = F4GangFlagCooldown()
                                    ent.F4NextCapture = CurTime() + cd
                                    ent:SetNWFloat('F4FlagNextCapture', ent.F4NextCapture)
                                    GNotify(pl, true, 'Флаг захвачен')
                                    F4Gangs.UpdateAllFlagEntities()
                                    RefreshAllGangClients()
                                end)
                            end)
                        end
                    end)
                end)
            end)
        end)
    end)
end

hook.Add('PlayerDeath', 'F4Gangs.CancelFlagOnDeathCheck', function()
    timer.Simple(0, function()
        for _, ent in ipairs(ents.FindByClass('f4_gang_flag')) do
            if IsValid(ent) and ent.F4Capturing and ent.F4CaptureGangID then
                CacheGangIDsForOnline(function()
                    if not IsValid(ent) or not ent.F4Capturing then return end
                    local radius = F4GangFlagRadius()
                    local minPlayers = F4GangFlagMinPlayers()
                    local c = CountAliveGangMembersInRadius(ent.F4CaptureGangID, ent:GetPos(), radius)
                    ent:SetNWInt('F4FlagCaptureCount', c)
                    if c < minPlayers then
                        StopFlagCapture(ent, 'Захват отменён: участники умерли')
                    end
                end)
            end
        end
    end)
end)

function F4Gangs.GiveFlagRewards()
    local money = GetConVar('f4_gang_flag_reward_money'):GetInt()
    local rep = GetConVar('f4_gang_flag_reward_rep'):GetInt()
    GQuery('SELECT gang_id,COUNT(*) AS cnt FROM f4_gang_flags WHERE map="' .. GEscape(game.GetMap()) .. '" AND gang_id>0 GROUP BY gang_id', function(rows)
        for _, r in ipairs(rows or {}) do
            local gid = tonumber(r.gang_id) or 0
            local cnt = tonumber(r.cnt) or 0
            if gid > 0 and cnt > 0 then
                GQuery('UPDATE f4_gangs SET bank=bank+' .. (money * cnt) .. ', reputation=reputation+' .. (rep * cnt) .. ' WHERE id=' .. gid, function()
                    RefreshGang(gid)
                end)
            end
        end
    end)
end

timer.Create('F4Gangs.FlagRewards', math.max(60, GetConVar('f4_gang_flag_reward_interval'):GetInt()), 0, function()
    F4Gangs.GiveFlagRewards()
end)

local function F4GangsCreateFlag(pl, name)
    if not IsFlagAdmin(pl) then GNotify(pl, false, 'Нет прав ставить флаги') return end
    EnsureGangTables()

    name = CleanGangName(name or '')
    if name == '' then name = 'Флаг' end

    local pos = Vector(0, 0, 0)
    local ang = Angle(0, 0, 0)
    if IsValid(pl) then
        local tr = pl:GetEyeTrace()
        pos = tr and tr.HitPos or pl:GetPos()
        ang = Angle(0, pl:EyeAngles().y, 0)
    end

    GQuery('INSERT INTO f4_gang_flags(name,map,x,y,z,pitch,yaw,roll,gang_id,captured_time) VALUES("' .. GEscape(name) .. '","' .. GEscape(game.GetMap()) .. '",' .. pos.x .. ',' .. pos.y .. ',' .. pos.z .. ',' .. ang.p .. ',' .. ang.y .. ',' .. ang.r .. ',0,0)', function()
        F4Gangs.SpawnSavedFlags()
        RefreshAllGangClients()
        if IsValid(pl) then GNotify(pl, true, 'Флаг создан') else print('[F4Gangs] Flag created') end
    end)
end

local function F4GangsRemoveFlag(pl)
    if not IsFlagAdmin(pl) then GNotify(pl, false, 'Нет прав удалять флаги') return end
    if not IsValid(pl) then print('Use in-game looking at flag') return end
    local ent = pl:GetEyeTrace().Entity
    if not IsValid(ent) or ent:GetClass() ~= 'f4_gang_flag' then GNotify(pl, false, 'Посмотрите на флаг') return end
    local id = tonumber(ent.F4FlagID or ent:GetNWInt('F4FlagID', 0)) or 0
    if id <= 0 then ent:Remove() return end
    GQuery('DELETE FROM f4_gang_flags WHERE id=' .. id, function()
        ent:Remove()
        RefreshAllGangClients()
        GNotify(pl, true, 'Флаг удалён')
    end)
end

concommand.Add('f4_flag_add', function(pl, _, args)
    F4GangsCreateFlag(pl, table.concat(args or {}, ' '))
end)

concommand.Add('f4_flag_remove', function(pl)
    F4GangsRemoveFlag(pl)
end)

net.Receive('F4Gangs:FlagAdmin', function(_, pl)
    local act = net.ReadString()
    if act == 'add' then
        F4GangsCreateFlag(pl, net.ReadString())
    elseif act == 'remove' then
        F4GangsRemoveFlag(pl)
    end
end)

net.Receive('F4Gangs:Request', function(_, pl)
    SendGangData(pl)
end)

net.Receive('F4Gangs:Action', function(_, pl)
    if not IsValid(pl) then return end
    local action = net.ReadString()
    local data = util.JSONToTable(net.ReadString() or '{}') or {}

    if action == 'create' then ActionCreate(pl, data) return end
    if action == 'accept' then ActionAccept(pl, data) return end
    if action == 'decline' then
        GQuery('DELETE FROM f4_gang_invites WHERE gang_id=' .. (tonumber(data.gang_id or 0) or 0) .. ' AND steamid="' .. GEscape(pl:SteamID64()) .. '"', function() SendGangData(pl) end)
        return
    end

    GetContext(pl, function(ctx)
        if not ctx then GNotify(pl, false, 'Вы не состоите в банде') SendGangData(pl) return end
        if action == 'invite' then ActionInvite(pl, data, ctx)
        elseif action == 'deposit' then ActionDeposit(pl, data, ctx)
        elseif action == 'withdraw' then ActionWithdraw(pl, data, ctx)
        elseif action == 'setrank' then ActionSetRank(pl, data, ctx)
        elseif action == 'kick' then ActionKick(pl, data, ctx)
        elseif action == 'saverank' then ActionSaveRank(pl, data, ctx)
        elseif action == 'deleterank' then ActionDeleteRank(pl, data, ctx)
        elseif action == 'leave' then ActionLeave(pl, ctx)
        elseif action == 'setinfo' then ActionSetInfo(pl, data, ctx)
        elseif action == 'disband' then ActionDisband(pl, ctx)
        else GNotify(pl, false, 'Неизвестное действие') end
    end)
end)

hook.Add('PlayerInitialSpawn', 'F4Gangs.LoadNW', function(pl)
    timer.Simple(5, function() if IsValid(pl) then LoadPlayerGangNW(pl) end end)
end)