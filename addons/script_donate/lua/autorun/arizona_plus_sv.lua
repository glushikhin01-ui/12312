local function HasArizona(pl)
return pl.HasPurchase and pl:HasPurchase("arizona_plus")
end
hook.Add("PlayerPayDay", "ArizonaPlus_Salary", function(pl, amount)
if HasArizona(pl) then return amount * 3 end
end)
local meta = FindMetaTable("Player")
local oldArrest = meta.Arrest
function meta:Arrest(actor, reason, arrestTime)
if HasArizona(self) then
arrestTime = math.max(math.ceil((tonumber(arrestTime) or 900) / 2), 10)
end
return oldArrest(self, actor, reason, arrestTime)
end
ArizonaCaseClaims = ArizonaCaseClaims or {}
local claims_file = "arizona_case_claims.txt"
local function LoadClaims()
if file.Exists(claims_file, "DATA") then
local raw = file.Read(claims_file, "DATA")
if raw and #raw > 0 then
local ok, tbl = pcall(util.JSONToTable, raw)
if ok and istable(tbl) then ArizonaCaseClaims = tbl return end
end
end
ArizonaCaseClaims = {}
end
local function SaveClaims()
file.Write(claims_file, util.TableToJSON(ArizonaCaseClaims or {}))
end
LoadClaims()
local function CanClaimCase(ply)
local sid = ply:SteamID64()
local last = ArizonaCaseClaims[sid] or 0
return (os.time() - last) >= 86400
end
local function ClaimCase(ply)
ArizonaCaseClaims[ply:SteamID64()] = os.time()
SaveClaims()
if ply.ub_addItem then ply:ub_addItem("Кейс Indiana") end
end
hook.Add("PlayerInitialSpawn", "ArizonaPlus_DailyCase", function(ply)
timer.Simple(5, function()
if !IsValid(ply) then return end
if !HasArizona(ply) then return end
if CanClaimCase(ply) then
ClaimCase(ply)
ply:ChatPrint("[Arizona+] Ежедневный кейс выдан! Следующий через 24 часа.")
end
end)
end)
timer.Create("ArizonaPlus_DailyCase_Timer", 600, 0, function()
for _, ply in ipairs(player.GetAll()) do
if HasArizona(ply) and CanClaimCase(ply) then
ClaimCase(ply)
ply:ChatPrint("[Arizona+] Ежедневный кейс выдан!")
end
end
end)
