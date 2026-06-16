--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

// Copyright © 2012-2018 VCMod (freemmaann). All Rights Reserved. if you have any complaints or ideas contact me: steam - steamcommunity.com/id/freemmaann/ or email - freemmaann@gmail.com.

// Force players to download this file
AddCSLuaFile()

// Which VCMod addon is this?
vcmod_hdl = true

-- Start the loading process
include("vcmod/init.lua")

// Handling Editor works in both SinglePlayer and Multiplayer

// Create some the Context menu
if CLIENT then
	hook.Add("PopulateToolMenu", "VC_Menu_Hdl", function()
		spawnmenu.AddToolMenuOption("VCMod", "Tools", "VC_Menu_Hdl", "Handling editor", "", "", function(Pnl)
			if VC.Menu_Items_P and VC.Menu_Items_P.Handling then VC.Menu_Items_P.Handling[2](Pnl, 600) end
		end)
	end)
end

// Define VC.Include if not already defined by VCMod Auto Updater
if !VC.Include then
function VC.Include(script, text, func) if file.Exists(script, "LUA") then if SERVER then AddCSLuaFile(script) end include(script) end end
end

// Send shared and handling files to clients for multiplayer
if SERVER then
	local files = {"vcmod/shared/init_shared.lua", "vcmod/shared/init_hdl.lua", "vcmod/shared/various_all.lua", "vcmod/client/init.lua", "vcmod/client/data_gui.lua", "vcmod/client/data_menu_shared.lua", "vcmod/client/menu.lua", "vcmod/client/language_init.lua", "vcmod/client/main_hdl.lua"}
	for _, f in ipairs(files) do if file.Exists(f, "LUA") then AddCSLuaFile(f) end end
end

// Load shared code directly (bypass other addons' VC.Include that may not find files)
if file.Exists("vcmod/shared/init_shared.lua", "LUA") then include("vcmod/shared/init_shared.lua") end

// Load Handling code
if file.Exists("vcmod/shared/init_hdl.lua", "LUA") then include("vcmod/shared/init_hdl.lua") end

// Finished all the loading processes
VCPrint("Handling editor has finished loading.")

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
