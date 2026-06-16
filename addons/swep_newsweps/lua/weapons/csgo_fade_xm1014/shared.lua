--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

-- Variables that are used on both client and server
SWEP.Gun = ("csgo_fade_xm1014") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "( TFA/M9K ) Collection"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "( M9K )CSGO XM1014 Fade"		-- Weapon name (Shown on HUD)	
SWEP.Slot					= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 36			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"	-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_fade_xm1014.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_shot_xm1014.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base 				= "shotgun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("weapons/xm1014_fade/xm1014-1.wav")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 210		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 12		-- Size of a clip
SWEP.Primary.DefaultClip		= 270	-- Default number of bullets in a clip
SWEP.Primary.KickUp				= 0.9				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.8		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.7	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 
SWEP.ShellTime			= 0.55
SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 13		-- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage		= 9	-- Base damage per bullet
SWEP.Primary.Spread		= 0.08	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.08	-- Ironsight accuracy, should be the same for shotguns
-- Because irons don't magically give you less pellet spread!

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(-2.761, -1.326, 1.259)
SWEP.SightsAng = Vector(0.699, 0, 0)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-7.173, 41.436, -7.825)

SWEP.WElements = {
	["world_model"] = { type = "Model", model = "models/weapons/w_fade_xm1014.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.456, 0.619, 0.559), angle = Angle(-168.821, -180, 0), size = Vector(0.963, 0.963, 0.963), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
