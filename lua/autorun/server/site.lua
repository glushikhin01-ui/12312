VibeRP = VibeRP or {}

VibeRP.Config = {
    PanelURL            = "http://93.115.101.104:12968",
    Secret              = "Ejv3_LlTleubBTohgLmzppNAPFH_eNsrHl2xrHZdOIb-Wd-6LcuODhpuBlwW4HIm",
    OnlineSyncInterval  = 15,
    CommandPollInterval = 1,
    ModelCheckOnJoin    = true,
    CHSPSyncInterval    = 60,
    HttpRetries         = 3,
    HttpRetryDelay      = 2,
    IGSLoadWait         = 15,
    OnlineSyncVerbose   = false, 
    IGS_Method          = nil,
}

local function errLog(...)
    MsgC(Color(255, 80, 80), "[VibeRP ERROR] ", Color(255, 255, 255), string.format(...), "\n")
end
VibeRP.Err = errLog

local function SafePrint(fmt, ...)
    local args = {...}
    for i = 1, #args do
        if isstring(args[i]) then
            args[i] = string.gsub(args[i], "%%", "%%%%")
        end
    end
    print(string.format(fmt, unpack(args)))
end

local function GetPlayerIGS(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return 0 end

    local forced = VibeRP.Config.IGS_Method
    if forced and isstring(forced) then
        if string.StartWith(forced, "ply:") then
            local m = string.sub(forced, 5)
            if isfunction(ply[m]) then
                local ok, val = pcall(ply[m], ply)
                if ok and isnumber(val) then return math.max(0, math.floor(val)) end
            end
        elseif IGS and isfunction(IGS[string.gsub(forced, "^IGS%.", "")]) then
            local fn = IGS[string.gsub(forced, "^IGS%.", "")]
            local ok, val = pcall(fn, ply)
            if ok and isnumber(val) then return math.max(0, math.floor(val)) end
        end
    end

    if IGS and istable(IGS) then
        local tries = {
            function() if isfunction(IGS.GetBalance) then return IGS.GetBalance(ply) end end,
            function() if isfunction(IGS.GetPlayerBalance) then return IGS.GetPlayerBalance(ply) end end,
            function() if isfunction(IGS.PlayerBalance) then return IGS.PlayerBalance(ply) end end,
            function() if isfunction(IGS.GetCredits) then return IGS.GetCredits(ply) end end,
            function() if IGS.API and isfunction(IGS.API.GetPlayerBalance) then return IGS.API.GetPlayerBalance(ply) end end,
        }
        for _, fn in ipairs(tries) do
            local ok, val = pcall(fn)
            if ok and isnumber(val) then return math.max(0, math.floor(val)) end
        end
        if IGS.Players and istable(IGS.Players) then
            local sid = ply:SteamID64()
            local t = IGS.Players[sid]
            if t and istable(t) then
                local v = t.Balance or t.balance or t.Credits or t.credits
                if isnumber(v) then return math.max(0, math.floor(v)) end
            end
        end
    end

    -- Player meta IGS only
    local igsFns = { "IGS_GetBalance", "GetIGSBalance", "IGSGetBalance", "GetIGSCredits", "IGS_Balance" }
    for _, fnName in ipairs(igsFns) do
        if isfunction(ply[fnName]) then
            local ok, val = pcall(ply[fnName], ply)
            if ok and isnumber(val) then return math.max(0, math.floor(val)) end
        end
    end

    -- NW
    if isfunction(ply.GetNWInt) then
        local keys = { "IGS_Balance", "igs_balance", "IGS_Credits", "igs_credits", "IGS_Money", "igs_money" }
        for _, k in ipairs(keys) do
            local v = ply:GetNWInt(k, -1)
            if v >= 0 then return v end
        end
    end
    if isfunction(ply.GetNW2Int) then
        local keys = { "IGS_Balance", "igs_balance", "IGS_Credits", "igs_credits" }
        for _, k in ipairs(keys) do
            local v = ply:GetNW2Int(k, -1)
            if v >= 0 then return v end
        end
    end

    if isfunction(ply.GetPData) then
        for _, k in ipairs({ "igs_balance", "igs_credits", "IGS_Balance" }) do
            local ok, str = pcall(ply.GetPData, ply, k, "")
            if ok then local n = tonumber(str) if n then return math.max(0, math.floor(n)) end end
        end
    end

    return 0
end

local function httpGet(endpoint, params, callback, attempt)
    attempt = attempt or 1
    params = params or {}
    local url = VibeRP.Config.PanelURL .. endpoint
    local query = {}
    for k, v in pairs(params) do table.insert(query, k .. "=" .. tostring(v)) end
    if #query > 0 then url = url .. "?" .. table.concat(query, "&") end
    HTTP({
        url = url, method = "GET",
        headers = { ["X-API-Password"] = VibeRP.Config.Secret, ["Accept"] = "application/json" },
        success = function(code, body)
            if code >= 200 and code < 300 then
                local ok, data = pcall(util.JSONToTable, body)
                if ok and data then callback(data, code) else callback(nil, code) end
            else
                if attempt < VibeRP.Config.HttpRetries then timer.Simple(VibeRP.Config.HttpRetryDelay, function() httpGet(endpoint, params, callback, attempt + 1) end)
                else errLog("HTTP GET %s failed (code %d) after %d attempts", endpoint, code, attempt); callback(nil, code) end
            end
        end,
        failed = function(reason)
            if attempt < VibeRP.Config.HttpRetries then timer.Simple(VibeRP.Config.HttpRetryDelay, function() httpGet(endpoint, params, callback, attempt + 1) end)
            else errLog("HTTP GET %s failed: %s (after %d attempts)", endpoint, tostring(reason), attempt); callback(nil, 0) end
        end,
    })
end

local function httpPost(endpoint, payload, callback, attempt)
    attempt = attempt or 1
    payload = payload or {}
    payload.password = VibeRP.Config.Secret
    local url = VibeRP.Config.PanelURL .. endpoint
    HTTP({
        url = url, method = "POST", body = util.TableToJSON(payload), type = "application/json",
        headers = { ["X-API-Password"] = VibeRP.Config.Secret, ["Content-Type"] = "application/json", ["Accept"] = "application/json" },
        success = function(code, body)
            if code >= 200 and code < 300 then
                local ok, data = pcall(util.JSONToTable, body)
                if ok and data then if callback then callback(data, code) end else if callback then callback(nil, code) end end
            else
                if attempt < VibeRP.Config.HttpRetries then timer.Simple(VibeRP.Config.HttpRetryDelay, function() httpPost(endpoint, payload, callback, attempt + 1) end)
                else errLog("HTTP POST %s failed (code %d) after %d attempts", endpoint, code, attempt); if callback then callback(nil, code) end end
            end
        end,
        failed = function(reason)
            if attempt < VibeRP.Config.HttpRetries then timer.Simple(VibeRP.Config.HttpRetryDelay, function() httpPost(endpoint, payload, callback, attempt + 1) end)
            else errLog("HTTP POST %s failed: %s (after %d attempts)", endpoint, tostring(reason), attempt); if callback then callback(nil, 0) end end
        end,
    })
end

local function findPlayer(id)
    id = string.upper(tostring(id))
    for _, p in ipairs(player.GetAll()) do if IsValid(p) then if string.upper(p:SteamID() or "") == id then return p end if (p:SteamID64() or "") == id then return p end end end
    for _, p in ipairs(player.GetAll()) do if IsValid(p) and string.find(string.lower(p:Nick()), string.lower(id), 1, true) then return p end end
    return nil
end

local function findPlayerBySteamID32(sid32)
    if not sid32 or sid32 == "" then return nil end
    sid32 = string.upper(sid32)
    for _, p in ipairs(player.GetAll()) do if IsValid(p) and string.upper(p:SteamID() or "") == sid32 then return p end end
    return nil
end

-- ONLINE SYNC
local onlineSyncCounter = 0
local function syncOnline()
    local players = {}
    local sampleNick, sampleIGS = nil, nil
    for _, ply in ipairs(player.GetAll()) do
        if IsValid(ply) and not ply:IsBot() then
            local sid64 = ply:SteamID64() or ""
            if sid64 ~= "" then
                local igs = GetPlayerIGS(ply)
                players[sid64] = { nick = ply:Nick(), steamid = ply:SteamID(), online = true, ping = ply:Ping(), team = team.GetName(ply:Team()) or "", health = ply:Health(), armor = ply:Armor(), igs = igs }
                if not sampleNick then sampleNick = ply:Nick(); sampleIGS = igs end
            end
        end
    end
    onlineSyncCounter = onlineSyncCounter + 1
    if VibeRP.Config.OnlineSyncVerbose or onlineSyncCounter % 20 == 1 then
        SafePrint("[VibeRP] syncOnline: sending %d players. Sample: %s has %d IGS", table.Count(players), sampleNick or "N/A", sampleIGS or 0)
    end
    httpPost("/api/online", { data = players }, function(data, code)
        if VibeRP.Config.OnlineSyncVerbose then
            if data and data.ok then SafePrint("[VibeRP] syncOnline: server OK (players=%d)", data.count or 0)
            else SafePrint("[VibeRP] syncOnline: server response code=%s", tostring(code)) end
        end
    end)
end

local function markDone(cmdId) httpPost("/api/mark", { id = cmdId }) end

local function addWebAdminToReason(reason, sid64)
    sid64 = tostring(sid64 or "")
    reason = tostring(reason or "")
    if sid64 == "" or reason:find("__ARZWEB:%d+__", 1, false) then return reason end

    local marker = " __ARZWEB:" .. sid64 .. "__"
    if reason:sub(1, 1) == '"' and reason:sub(-1) == '"' then
        return reason:sub(1, -2) .. marker .. '"'
    end
    return reason .. marker
end

local function addWebAdminToBACommand(text, sid64)
    sid64 = tostring(sid64 or "")
    if sid64 == "" then return text end

    local prefix, reason = string.match(text, "^(ba%s+ban%s+%S+%s+%S+%s+)(.+)$")
    if prefix and reason then
        return prefix .. addWebAdminToReason(reason, sid64)
    end

    prefix, reason = string.match(text, "^(ba%s+perma%s+%S+%s+)(.+)$")
    if prefix and reason then
        return prefix .. addWebAdminToReason(reason, sid64)
    end

    return text
end

-- COMMAND EXECUTOR (models / weapons / jobs)
local function execCommand(cmd)
    local text = cmd.text or ""
    local cmdId = cmd.id or ""
    if cmd.type ~= "console" or text == "" then markDone(cmdId) return end

    local addSid32 = string.match(text, "^addmodel%s+(%S+)%s+")
    if addSid32 then local ply = findPlayerBySteamID32(addSid32) if IsValid(ply) then VibeRP.LoadPlayerModels(ply, true) end markDone(cmdId) return end
    local rmSid32 = string.match(text, "^removemodel%s+(%S+)%s+")
    if rmSid32 then local ply = findPlayerBySteamID32(rmSid32) if IsValid(ply) then VibeRP.LoadPlayerModels(ply, true) end markDone(cmdId) return end

    local addWepSid32 = string.match(text, "^giveweapon%s+(%S+)%s+")
    if addWepSid32 then local ply = findPlayerBySteamID32(addWepSid32) if IsValid(ply) then VibeRP.LoadPlayerWeapons(ply, false) end markDone(cmdId) return end
    local rmWepSid32 = string.match(text, "^removeweapon%s+(%S+)%s+")
    if rmWepSid32 then local ply = findPlayerBySteamID32(rmWepSid32) if IsValid(ply) then VibeRP.LoadPlayerWeapons(ply, false) end markDone(cmdId) return end

    local addJobSid32, addJobCmd = string.match(text, "^givejob%s+(%S+)%s+(%S+)")
    if addJobSid32 then local ply = findPlayerBySteamID32(addJobSid32) if IsValid(ply) then VibeRP.LoadPlayerJobs(ply) end markDone(cmdId) return end
    local rmJobSid32 = string.match(text, "^removejob%s+(%S+)%s+")
    if rmJobSid32 then local ply = findPlayerBySteamID32(rmJobSid32) if IsValid(ply) then VibeRP.LoadPlayerJobs(ply) end markDone(cmdId) return end

    -- SteamID64 админа с сайта, чтобы ba-команды не писали "Console".
    local webAdminSid64 = tostring(cmd.admin_steamid64 or cmd.admin_sid64 or "")
    if webAdminSid64 ~= "" then
        VibeRP.WebCommandAdminSteamID64 = webAdminSid64
        VibeRP.WebCommandAdminSteamID64Expire = CurTime() + 10
        text = addWebAdminToBACommand(text, webAdminSid64)
    end

    game.ConsoleCommand(text .. "\n")
    timer.Simple(10, function()
        if VibeRP and VibeRP.WebCommandAdminSteamID64 == webAdminSid64 then
            VibeRP.WebCommandAdminSteamID64 = nil
            VibeRP.WebCommandAdminSteamID64Expire = nil
        end
    end)
    markDone(cmdId)
end

local function pollCommands()
    httpGet("/api/get", { password = VibeRP.Config.Secret }, function(data)
        if not data or not istable(data) then return end
        for _, cmd in ipairs(data) do if istable(cmd) and cmd.id then execCommand(cmd) end end
    end)
end

VibeRP.PlayerModels = VibeRP.PlayerModels or {}
VibeRP.PlayerWeapons = VibeRP.PlayerWeapons or {}
VibeRP.PlayerJobs = VibeRP.PlayerJobs or {}

local function restoreJobModel(ply)
    if not IsValid(ply) then return end
    if DarkRP and ply.getJobTable then
        local jobTable = ply:getJobTable()
        if jobTable and jobTable.model then
            local model = jobTable.model
            if istable(model) then model = model[1] end
            if model and util.IsValidModel(model) then ply:SetModel(model) return end
        end
    end
    local defaultModel = player_manager.TranslatePlayerModel(ply:GetInfo("cl_playermodel") or "kleiner")
    if defaultModel and util.IsValidModel(defaultModel) then ply:SetModel(defaultModel) else ply:SetModel("models/player/kleiner.mdl") end
end

local function applyPlayerModel(ply)
    if not IsValid(ply) or ply:IsBot() then return end
    local sid64 = ply:SteamID64() if not sid64 then return end
    local models = VibeRP.PlayerModels[sid64]
    if not models or #models == 0 then restoreJobModel(ply) return end
    local mp = models[1].model_path
    if mp and mp ~= "" and util.IsValidModel(mp) then ply:SetModel(mp) end
end

local function givePlayerWeapons(ply)
    if not IsValid(ply) or ply:IsBot() then return end
    local sid64 = ply:SteamID64() if not sid64 then return end
    local weapons = VibeRP.PlayerWeapons[sid64]
    if not weapons or #weapons == 0 then return end
    for _, w in ipairs(weapons) do if w.weapon_class and w.weapon_class ~= "" then ply:Give(w.weapon_class) end end
end

function VibeRP.LoadPlayerModels(ply, applyAfter)
    if not IsValid(ply) or ply:IsBot() then return end
    local sid32 = ply:SteamID() if not sid32 or sid32 == "" then return end
    httpGet("/api/models_sync", { action = "list_player_models", steamid32 = sid32, password = VibeRP.Config.Secret }, function(data)
        if not data or not data.ok or not IsValid(ply) then return end
        VibeRP.PlayerModels[ply:SteamID64()] = data.items or {}
        if applyAfter then applyPlayerModel(ply) end
    end)
end

function VibeRP.LoadPlayerWeapons(ply, giveAfter)
    if not IsValid(ply) or ply:IsBot() then return end
    local sid32 = ply:SteamID() if not sid32 or sid32 == "" then return end
    httpGet("/api/weapons_sync", { action = "list_player_weapons", steamid32 = sid32, password = VibeRP.Config.Secret }, function(data)
        if not data or not data.ok or not IsValid(ply) then return end
        VibeRP.PlayerWeapons[ply:SteamID64()] = data.items or {}
        if giveAfter then givePlayerWeapons(ply) end
    end)
end

-- Jobs
function VibeRP.LoadPlayerJobs(ply)
    if not IsValid(ply) or ply:IsBot() then return end
    local sid32 = ply:SteamID() if not sid32 or sid32 == "" then return end
    httpGet("/api/jobs_sync", { action = "list_player_jobs", steamid32 = sid32, password = VibeRP.Config.Secret }, function(data)
        if not data or not data.ok or not IsValid(ply) then return end
        VibeRP.PlayerJobs[ply:SteamID64()] = data.items or {}
    end)
end

function VibeRP.GetPlayerJobs(ply)
    if not IsValid(ply) then return {} end
    return VibeRP.PlayerJobs[ply:SteamID64()] or {}
end

function VibeRP.HasJob(ply, jobCommand)
    if not IsValid(ply) then return false end
    for _, j in ipairs(VibeRP.PlayerJobs[ply:SteamID64()] or {}) do if j.job_command == jobCommand then return true end end
    return false
end

-- CHSP
VibeRP.CHSP = VibeRP.CHSP or {}; VibeRP.CHSP.Players = {}; VibeRP.CHSP.IPs = {}
function VibeRP.IsInCHSP(ply)
    if not IsValid(ply) then return false, "" end
    local entry = VibeRP.CHSP.Players[ply:SteamID64() or ""]
    if entry then return true, entry.reason or "" end
    local ip = string.gsub(ply:IPAddress() or "", ":%d+$", "")
    local ipEntry = VibeRP.CHSP.IPs[ip]
    if ipEntry then return true, ipEntry.reason or "" end
    return false, ""
end
function VibeRP.CheckCHSP(ply)
    if not IsValid(ply) or ply:IsBot() then return end
    local banned, reason = VibeRP.IsInCHSP(ply)
    if banned then ply:Kick(reason) end
end
local function syncCHSP()
    httpGet("/api/chsp_sync", { action = "list", password = VibeRP.Config.Secret }, function(data)
        if not data or not data.ok then return end
        VibeRP.CHSP.Players = {}
        for _, p in ipairs(data.players or {}) do if p.active and tonumber(p.active) ~= 0 then local sid64 = tostring(p.steamid64 or "") if sid64 ~= "" then VibeRP.CHSP.Players[sid64] = { reason = p.reason or "", added_by = p.added_by or "" } end end end
        VibeRP.CHSP.IPs = {}
        for _, ip in ipairs(data.ips or {}) do if ip.active and tonumber(ip.active) ~= 0 then local addr = tostring(ip.ip or "") if addr ~= "" then VibeRP.CHSP.IPs[addr] = { reason = ip.reason or "", added_by = ip.added_by or "" } end end end
        for _, ply in ipairs(player.GetAll()) do if IsValid(ply) and not ply:IsBot() then VibeRP.CheckCHSP(ply) end end
    end)
end

-- Hooks
hook.Add("Initialize", "VibeRP_Init", function()
    timer.Simple(VibeRP.Config.IGSLoadWait, function()
        SafePrint("[VibeRP] First online sync (IGS should be loaded by now)")
        syncOnline()
        timer.Create("VibeRP_OnlineSync", VibeRP.Config.OnlineSyncInterval, 0, syncOnline)
    end)
    timer.Simple(4, pollCommands)
    timer.Simple(5, syncCHSP)
    timer.Create("VibeRP_CommandPoll", VibeRP.Config.CommandPollInterval, 0, pollCommands)
    timer.Create("VibeRP_CHSPSync", VibeRP.Config.CHSPSyncInterval, 0, syncCHSP)
end)

hook.Add("PlayerInitialSpawn", "VibeRP_PlayerJoin", function(ply)
    timer.Simple(2, function()
        if not IsValid(ply) then return end
        VibeRP.CheckCHSP(ply)
        if VibeRP.Config.ModelCheckOnJoin then
            timer.Simple(1, function()
                if IsValid(ply) then
                    VibeRP.LoadPlayerModels(ply, true)
                    VibeRP.LoadPlayerWeapons(ply, true)
                    VibeRP.LoadPlayerJobs(ply)
                end
            end)
        end
    end)
end)

hook.Add("PlayerSpawn", "VibeRP_ModelOnSpawn", function(ply)
    if not IsValid(ply) or ply:IsBot() then return end
    timer.Simple(0.5, function()
        if IsValid(ply) then applyPlayerModel(ply) givePlayerWeapons(ply) end
    end)
end)

hook.Add("PlayerSetModel", "VibeRP_ModelOverride", function(ply, model)
    if not IsValid(ply) or ply:IsBot() then return end
    local sid64 = ply:SteamID64() if not sid64 then return end
    local models = VibeRP.PlayerModels[sid64]
    if models and #models > 0 and models[1].model_path then
        local mp = models[1].model_path
        if mp ~= "" and util.IsValidModel(mp) and model ~= mp then
            timer.Simple(0, function() if IsValid(ply) then ply:SetModel(mp) end end)
            return mp
        end
    end
end)

if DarkRP then
    hook.Add("OnPlayerChangedTeam", "VibeRP_ModelOnJobChange", function(ply, before, after)
        if not IsValid(ply) or ply:IsBot() then return end
        timer.Simple(1, function() if IsValid(ply) then applyPlayerModel(ply) givePlayerWeapons(ply) end end)
    end)
end

hook.Add("PlayerDisconnected", "VibeRP_PlayerLeave", function(ply)
    local sid64 = ply:SteamID64()
    if sid64 then VibeRP.PlayerModels[sid64] = nil VibeRP.PlayerWeapons[sid64] = nil VibeRP.PlayerJobs[sid64] = nil end
    timer.Simple(1, syncOnline)
end)

-- Console commands
concommand.Add("addmodel", function(ply, cmd, args, argStr)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    local sid32 = string.match(argStr or "", "(%S+)%s+")
    if not sid32 then return end
    local target = findPlayerBySteamID32(sid32) or findPlayer(sid32)
    if IsValid(target) then VibeRP.LoadPlayerModels(target, true) end
end)
concommand.Add("removemodel", function(ply, cmd, args, argStr)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    local sid32 = string.match(argStr or "", "(%S+)%s+")
    if not sid32 then return end
    local target = findPlayerBySteamID32(sid32) or findPlayer(sid32)
    if IsValid(target) then VibeRP.LoadPlayerModels(target, true) end
end)
concommand.Add("giveweapon", function(ply, cmd, args, argStr)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    local sid32 = string.match(argStr or "", "(%S+)%s+")
    if not sid32 then return end
    local target = findPlayerBySteamID32(sid32) or findPlayer(sid32)
    if IsValid(target) then VibeRP.LoadPlayerWeapons(target, false) end
end)
concommand.Add("removeweapon", function(ply, cmd, args, argStr)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    local sid32 = string.match(argStr or "", "(%S+)%s+")
    if not sid32 then return end
    local target = findPlayerBySteamID32(sid32) or findPlayer(sid32)
    if IsValid(target) then VibeRP.LoadPlayerWeapons(target, false) end
end)
concommand.Add("givejob", function(ply, cmd, args, argStr)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    local sid32 = string.match(argStr or "", "(%S+)%s+")
    if not sid32 then return end
    local target = findPlayerBySteamID32(sid32) or findPlayer(sid32)
    if IsValid(target) then VibeRP.LoadPlayerJobs(target) end
end)
concommand.Add("removejob", function(ply, cmd, args, argStr)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    local sid32 = string.match(argStr or "", "(%S+)%s+")
    if not sid32 then return end
    local target = findPlayerBySteamID32(sid32) or findPlayer(sid32)
    if IsValid(target) then VibeRP.LoadPlayerJobs(target) end
end)

concommand.Add("viberp_reloadmodels", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    if args[1] then local target = findPlayer(args[1]) if IsValid(target) then VibeRP.LoadPlayerModels(target, true) end
    else for _, p in ipairs(player.GetAll()) do if IsValid(p) and not p:IsBot() then VibeRP.LoadPlayerModels(p, true) end end end
end)
concommand.Add("viberp_reloadweapons", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    if args[1] then local target = findPlayer(args[1]) if IsValid(target) then VibeRP.LoadPlayerWeapons(target, true) end
    else for _, p in ipairs(player.GetAll()) do if IsValid(p) and not p:IsBot() then VibeRP.LoadPlayerWeapons(p, true) end end end
end)
concommand.Add("viberp_reloadjobs", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    if args[1] then local target = findPlayer(args[1]) if IsValid(target) then VibeRP.LoadPlayerJobs(target) end
    else for _, p in ipairs(player.GetAll()) do if IsValid(p) and not p:IsBot() then VibeRP.LoadPlayerJobs(p) end end end
end)

concommand.Add("viberp_testigs", function(ply)
    print("[VibeRP] === IGS QUICK TEST ===")
    for _, p in ipairs(player.GetAll()) do if IsValid(p) and not p:IsBot() then local igs = GetPlayerIGS(p) SafePrint("[VibeRP] %s (%s) -> %d IGS", p:Nick(), p:SteamID64(), igs) end end
    print("[VibeRP] === END ===")
    if IsValid(ply) then ply:ChatPrint("IGS quick test done. Check server console.") end
end)

concommand.Add("viberp_force_sync", function(ply)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    print("[VibeRP] Manual sync triggered")
    syncOnline()
end)

print("[VibeRP] Server module loaded. Panel: " .. VibeRP.Config.PanelURL)