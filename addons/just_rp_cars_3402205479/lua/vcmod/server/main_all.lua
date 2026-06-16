--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

// Copyright © 2012-2018 VCMod (freemmaann). All Rights Reserved. if you have any complaints or ideas contact me: steam - steamcommunity.com/id/freemmaann/ or email - freemmaann@gmail.com.

util.AddNetworkString("VCMsg")
util.AddNetworkString("VCPopup")

if !VC.PlayerGlobalData then VC.PlayerGlobalData = {} end

function VCMsg(msg, ply) if type(msg) != table then msg = {msg} end for _, PM in pairs(msg) do if type(PM) != string then PM = tostring(PM) end net.Start("VCMsg") net.WriteString(PM) if IsValid(ply) then net.Send(ply) else net.Broadcast() end end end
function VCEffect(pos, effect) local effectdata = EffectData() effectdata:SetOrigin(pos) util.Effect(effect or "cball_explode", effectdata) end
-- function VCPEffect(pos, effect) local effectdata = EffectData() effectdata:SetOrigin(pos) util.Effect(effect or "VC_Crash", effectdata) end
function VCEffect_Trace(ent, spos, epos) local eff = EffectData() eff:SetEntity(ent) eff:SetStart(spos) eff:SetOrigin(epos) eff:SetScale(5) util.Effect("ToolTracer", eff) end
function VCPopup(ply, msg, ttype, length) if !msg then msg = "" end if !length then length = 2 end if !ttype then ttype = "check" end if type(msg) != "string" then msg = tostring(msg) end net.Start("VCPopup") net.WriteString(msg) net.WriteString(ttype) net.WriteInt(length, 8) if ply then net.Send(ply) else net.Broadcast() end end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
