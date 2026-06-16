--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

-- Variables that are used on both client and server
SWEP.Gun = ("avenger_xr2") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "M9K Custom Weapons" --Category where you will find your weapons
SWEP.Author				= "Paulchartres"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Left click to shoot. Right click to aim. Use + Right click for silencer."
SWEP.PrintName				= "Avenger XR2"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 99			-- Position in the slot
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
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_pew_axr2.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base				= "pauls_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("avenger_xr2_shoot")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound 	= Sound("avenger_xr2_silent")		-- Sound if the weapon is silenced
SWEP.Primary.RPM			= 825			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 40		-- Size of a clip
SWEP.Primary.DefaultClip		= 340		-- Bullets you start with
SWEP.Primary.KickUp				= 0.1		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.1		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.1		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. 
--Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= true

SWEP.Secondary.IronFOV			= 55		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.Damage		= 53	-- Base damage per bullet
SWEP.Primary.Spread		= .023	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .013 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(2.993, -2.05, 0.68)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0, 0, 0)	--Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector (2.993, -2.05, 0.68)
SWEP.SightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector(-1.19, -4.948, -0.979)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-0.005, -56.277, 7.892)	--Again, use the Swep Construction Kit

SWEP.WElements = {
	["pew_avgrxr2_model"] = { type = "Model", model = "models/weapons/w_pew_axr2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.354, 0, -0.588), angle = Angle(180, 180, 0), size = Vector(0.883, 0.883, 0.883), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
