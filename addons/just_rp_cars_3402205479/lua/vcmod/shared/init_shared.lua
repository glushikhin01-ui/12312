--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

// Copyright © 2012-2018 VCMod (freemmaann). All Rights Reserved. if you have any complaints or ideas contact me: steam - steamcommunity.com/id/freemmaann/ or email - freemmaann@gmail.com.

if !VC.Loaded then VC.Loaded = {} end
local id = "shared" if VC.Loaded[id] then return end VC.Loaded[id] = CurTime()

file.CreateDir("vcmod") file.CreateDir("vcmod/data_lng")

local dir = "vcmod/languages" if file.Exists(dir, "DATA") then for k,v in pairs(file.Find(dir.."/*", "DATA")) do file.Delete(dir.."/"..v) end end file.Delete(dir)
local dir = "vcmod/lng" if file.Exists(dir, "DATA") then for k,v in pairs(file.Find(dir.."/*", "DATA")) do file.Delete(dir.."/"..v) end end file.Delete(dir)

if !VC.Settings then VC.Settings = {} end if !VC.Settings_Defaults then VC.Settings_Defaults = {} end
if !VC.GlobalData then VC.GlobalData = {} end

VC.Include("vcmod/shared/various_all.lua")
VC.Include("vcmod/shared/various_sf.lua")
VC.Include("vcmod/shared/overrides.lua")
VC.Include("vcmod/shared/compatibility.lua")

if SERVER then
	VC.Include("vcmod/server/main_all.lua")
	VC.Include("vcmod/server/main_shared_sf.lua")
	VC.Include("vcmod/server/entcode_main.lua")

	// Send client files to players for multiplayer
	local cl_files = {"vcmod/client/main_all.lua", "vcmod/client/data_gui.lua", "vcmod/client/data_menu_shared.lua", "vcmod/client/data_menu_sf.lua", "vcmod/client/main_shared_sf.lua", "vcmod/client/menu.lua", "vcmod/client/language_init.lua", "vcmod/client/language_main.lua", "vcmod/client/data_hud.lua", "vcmod/client/hud_pdtr.lua", "vcmod/client/entcode_main.lua"}
	for _, f in ipairs(cl_files) do if file.Exists(f, "LUA") then AddCSLuaFile(f) end end
else
	if !VC.ServerSettings then VC.ServerSettings = {} end if !VC.Color then VC.Color = {} end
	net.Receive("VC_SendToClient_Options_Public", function() VC.ServerSettings = net.ReadTable() VC.PrivilagesLevel = tonumber(VC.ServerSettings["PrivilagesLevel"]) end)
	net.Receive("VC_SendToClient_Override_Controls", function() VC.Override_Controls = net.ReadTable() if VC.Menu_Panel then VC.Menu_Panel.VC_Refresh_Panel = true end end)

	VC.Include("vcmod/client/main_all.lua")

	VC.Include("vcmod/client/data_gui.lua")
	VC.Include("vcmod/client/data_menu_shared.lua")
	VC.Include("vcmod/client/data_menu_sf.lua")

	VC.Include("vcmod/client/main_shared_sf.lua")

	VC.Include("vcmod/client/menu.lua")
	VC.Include("vcmod/client/language_init.lua")
	VC.Include("vcmod/client/language_main.lua")

	VC.Include("vcmod/client/data_hud.lua")

	VC.Include("vcmod/client/hud_pdtr.lua")
	VC.Include("vcmod/client/entcode_main.lua")
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
