--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

// Copyright © 2012-2018 VCMod (freemmaann). All Rights Reserved. if you have any complaints or ideas contact me: steam - steamcommunity.com/id/freemmaann/ or email - freemmaann@gmail.com.

if !VC.Loaded then VC.Loaded = {} end
local id = "hdl" if VC.Loaded[id] then return end VC.Loaded[id] = CurTime()

VC.Versions.vcmod_hdl = 1.102 VCMod_Hdl = VC.Versions.vcmod_hdl vcmod_hdl = VC.Versions.vcmod_hdl

if SERVER then
VC.Include("vcmod/server/main_hdl.lua")
if file.Exists("vcmod/client/main_hdl.lua", "LUA") then AddCSLuaFile("vcmod/client/main_hdl.lua") end
else
VC.Include("vcmod/client/main_hdl.lua")
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
