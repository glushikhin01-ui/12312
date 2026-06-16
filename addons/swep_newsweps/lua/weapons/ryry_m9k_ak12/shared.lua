--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

-- Variables that are used on both client and server
SWEP.Gun = ("ryry_m9k_ak12") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Ryry's Assault Rifles" --Category where you will find your weapons
SWEP.Author					= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.PrintName				= "AK-12"		-- Weapon name (Shown on HUD)	
SWEP.Slot					= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 101			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight					= 30		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_ryryak12.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base					= "ryry_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater 		= true

SWEP.Primary.Sound				= Sound("ryak.single")		-- Script that calls the primary fire sound
SWEP.Primary.RPM				= 740			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 35		-- Size of a clip
SWEP.Primary.DefaultClip		= 350		-- Bullets you start with
SWEP.Primary.KickUp				= 0.1		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.1		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.1		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "smg1"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. 
--Use AirboatGun for a light metal peircing shotgun pellets

SWEP.SelectiveFire			= true

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.Damage		  = 50	-- Base damage per bullet
SWEP.Primary.Spread		  = .023	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .013 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(-1.68, -0.489, 0.458)
SWEP.SightsAng = Vector(-0.002, 0.629, 0)
SWEP.RunSightsPos = Vector(4, -8.332, -0.315)
SWEP.RunSightsAng = Vector(0.028, 70, 0)

SWEP.WElements = {
	["ryak12w"] = { type = "Model", model = "models/weapons/w_ryryak12.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.435, 1.458, 2.799), angle = Angle(-15.285, 0, -180), size = Vector(1.151, 1.151, 1.151), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
