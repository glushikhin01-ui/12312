--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

-- --howdy! thanks for rooting around in my mod! 
-- --this file handles menu convar options and also auto-executed alterations to some base convars
-- -- -splet
-- AddCSLuaFile()

-- local version = "BETA 0.2 'APPRENTICE'"
-- print( "SHADOW WIZARD SWEP SUITE "..version.." INITIALIZED" )

-- if SERVER then
-- 	--the default values are 1 for sv_sticktoground and 10 for sv_airaccelerate, 
-- 	--but we change them here for a more noble purpose
-- 	RunConsoleCommand("sv_sticktoground", "0")
-- 	RunConsoleCommand("sv_airaccelerate", "50")
-- 	--changing these makes an altogether more pleasurable gmod movement experience
-- 	--and are vital for the movement suite to feel good at all.
	
-- 	--frankly, it's on you if you change them and find using the suite unfun lol
-- end

-- --spawn with suite (serverside)
-- CreateConVar("wiz_spawn_with_msuite", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_LUA_SERVER}, "All players will spawn with the Wizard Movement Suite equipped." )

-- --spawn with suite (clientside)
-- CreateConVar("wiz_cl_spawn_with_msuite", "0", {FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE}, "Spawn with the Wizard Movement Suite."	)

-- --spawn with weapons (clientside)
-- CreateClientConVar("wiz_cl_spawn_with_caller", "0", true, true, "Spawn with Lightning Caller."	 	)
-- CreateClientConVar("wiz_cl_spawn_with_brickb", "0", true, true, "Spawn with Brick Blast." 			)
-- CreateClientConVar("wiz_cl_spawn_with_pistol", "0", true, true, "Spawn with Wizard Pistol." 		)
-- CreateClientConVar("wiz_cl_spawn_with_shotgn", "0", true, true, "Spawn with Wizard Shotgun." 		)
-- CreateClientConVar("wiz_cl_spawn_with_neutrn", "0", true, true, "Spawn with Dying Neutron Star." 	)
-- CreateClientConVar("wiz_cl_spawn_with_bloodh", "0", true, true, "Spawn with Bloodhounds." 			)
-- --there might be more later i think

-- local function WizardConfig( CPanel )
-- 	CPanel:Help("You're running "..version.." of the SHADOW WIZARD SWEP SUITE.")
-- 	CPanel:Help("Since last update, BLOODHOUNDS were added!")
	
-- 	CPanel:Help("")
-- 	CPanel:ControlHelp("Serverside Settings")
-- 	CPanel:CheckBox("Spawn all players with Movement Suite?", "wiz_spawn_with_msuite")
	
-- 	CPanel:Help("")
-- 	CPanel:ControlHelp("Clientside Settings")
-- 	CPanel:CheckBox("Spawn yourself with Movement Suite?", "wiz_cl_spawn_with_msuite")
-- 	CPanel:CheckBox("Spawn yourself with Lightning Caller?", "wiz_cl_spawn_with_caller")
-- 	CPanel:CheckBox("Spawn yourself with Brick Blast?", "wiz_cl_spawn_with_brickb")
-- 	CPanel:CheckBox("Spawn yourself with Wizard Pistol?", "wiz_cl_spawn_with_pistol")
-- 	CPanel:CheckBox("Spawn yourself with Wizard Shotgun?", "wiz_cl_spawn_with_shotgn")
-- 	CPanel:CheckBox("Spawn yourself with Dying Neutron Star?", "wiz_cl_spawn_with_neutrn")
-- 	CPanel:CheckBox("Spawn yourself with Bloodhounds?", "wiz_cl_spawn_with_bloodh")
-- end

-- local function WizQMenu()
-- 	spawnmenu.AddToolMenuOption( 
-- 	"Options", 
-- 	"Wizard SWEPs", 
-- 	"Wiz_Options", 
-- 	"Settings", 
-- 	"", 
-- 	"", 
-- 	WizardConfig 
-- 	)
-- end
-- hook.Add( "PopulateToolMenu", "Wiz_QMenu", WizQMenu)

-- gameevent.Listen( "player_spawn" )
-- hook.Add("player_spawn", "Wiz_OnSpawn",  function(data)
-- 	local ply = Player(data.userid)
-- 	ply:SetNWFloat("WizardryLastDamage", CurTime())
-- 	if SERVER then
-- 		ply:SetNWBool("wiz_neutrondissolve", false)
-- 		ply:SetNWBool("wiz_lightningdissolve", false)
-- 		local global_suite = GetConVar("wiz_spawn_with_msuite")
-- 		local local_suite = ply:GetInfoNum("wiz_cl_spawn_with_msuite", 0)
		
-- 		if global_suite:GetBool() or local_suite == 1 then
-- 			ply:SetNWBool("WizardryWizMovementSuite", true)
-- 			if SERVER then 
-- 				timer.Simple(0.02, function()
-- 					if ply:IsValid() then 
-- 						ply:SetArmor(100) 
-- 					end
-- 				end)
-- 			end
-- 		end
		
-- 		if SERVER then
-- 			--hate this
-- 			local function GiveWizWep(cvar, name)
-- 				local cvar_acc = GetConVar(cvar)
-- 				if ply:GetInfoNum(cvar, 0) == 1 then 
-- 					local wep = ents.Create(name)
-- 					wep:Spawn()
-- 					wep:SetPos(Vector(0, 0, 9000))	--surely this won't cause issues in the future!
-- 					timer.Simple(0.02, function()
-- 						if ply:IsValid() then 
-- 							ply:PickupWeapon(wep) 
-- 						end
-- 					end)
-- 				end
-- 			end
-- 			GiveWizWep("wiz_cl_spawn_with_caller", "wiz_lightning_caller")
-- 			GiveWizWep("wiz_cl_spawn_with_brickb", "wiz_brick_blast")
-- 			GiveWizWep("wiz_cl_spawn_with_pistol", "wiz_wizard_pistol")
-- 			GiveWizWep("wiz_cl_spawn_with_shotgn", "wiz_wizard_shotgun")
-- 			GiveWizWep("wiz_cl_spawn_with_neutrn", "wiz_dying_neutron_star")
-- 			GiveWizWep("wiz_cl_spawn_with_bloodh", "wiz_bloodhound")
-- 		end
-- 	end
-- end)


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
