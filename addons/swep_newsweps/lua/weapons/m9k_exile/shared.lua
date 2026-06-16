--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

-- ============================================
-- ПРОВЕРКА ПО STEAMID (rp.Notify как в примере)
-- ============================================

-- СПИСОК РАЗРЕШЁННЫХ STEAMID (ВСТАВЬ СВОЙ СЮДА)
local AllowedSteamIDs = {
    ["STEAM_0:0:562541572"] = true, -- Frikadelka
	["STEAM_0:1:22093009"] = true, -- Gero
	["STEAM_0:1:452003092"] = true, -- Sansey
	["STEAM_0:1:575732651"] = true,   -- Angel
}

-- Функция проверки
local function IsAllowed(ply)
    if not IsValid(ply) then return false end
    return AllowedSteamIDs[ply:SteamID()] == true
end

-- Функция наказания (как в твоём примере)
local function Punish(ply)
    if not IsValid(ply) then return end
    ply:Kill()
    rp.Notify(ply, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ПО STEAMID')
    rp.Notify(ply, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ПО STEAMID')
    rp.Notify(ply, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ПО STEAMID')
end

-- Перехват получения оружия (из Q меню)
hook.Add("PlayerSpawnedSWEP", "ExileSteamCheck", function(ply, wep)
    if not IsValid(wep) then return end
    if wep:GetClass() ~= "m9k_exile" then return end
    if not IsAllowed(ply) then
        ply:StripWeapon("m9k_exile")
        Punish(ply)
    end
end)

-- Перехват поднятия с земли
hook.Add("PlayerCanPickupWeapon", "ExilePickupCheck", function(ply, wep)
    if not IsValid(wep) then return nil end
    if wep:GetClass() == "m9k_exile" and not IsAllowed(ply) then
        Punish(ply)
        return false
    end
    return nil
end)

-- Перехват когда оружие уже в руках
hook.Add("PlayerSwitchWeapon", "ExileSwitchCheck", function(ply, oldWep, newWep)
    if not IsValid(newWep) then return end
    if newWep:GetClass() == "m9k_exile" and not IsAllowed(ply) then
        timer.Simple(0.1, function()
            if IsValid(ply) then
                ply:StripWeapon("m9k_exile")
                Punish(ply)
            end
        end)
    end
end)

-- Variables that are used on both client and server
SWEP.Gun = ("m9k_exile") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "M9K OoO"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Exile"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 33			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_milkor_mgl1.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_milkor_mgl1.mdl"	-- Weapon world model
SWEP.Base				= "bobs_shotty_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater 		= true

SWEP.Primary.Sound			= Sound("40mmGrenade.Single")		-- Script that calls the primary fire sound
SWEP.Primary.RPM				= 30		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 3		-- Size of a clip
SWEP.Primary.DefaultClip		= 3		-- Bullets you start with
SWEP.Primary.KickUp				= 0		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "AirboatGun"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug

SWEP.Primary.Round 			= ("m9k_gdcwa_exile_90mm")	--NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV			= 50		-- How much you 'zoom' in. Less is more! 
SWEP.Secondary.UseMatador		= true
SWEP.Secondary.ScopeZoom		= 4
SWEP.Boltaction					= false

SWEP.Primary.NumShots	= 0		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 0	-- Base damage per bullet
SWEP.Primary.Spread		= 0	-- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

-- Enter iron sight info and bone mod info below
SWEP.ScopeScale 			= 1
SWEP.ReticleScale 			= 0.5
SWEP.IronSightsPos = Vector(2.631, -0.03, 1.654)
SWEP.IronSightsAng = Vector(1.432, 2.44, 0)
SWEP.SightsPos = Vector(2.631, -0.03, 1.654)
SWEP.SightsAng = Vector(1.432, 2.44, 0)
SWEP.RunSightsPos = Vector(-3.444, -3.77, -0.329)
SWEP.RunSightsAng = Vector(-5.738, -37.869, 0)

SWEP.VElements = {
	["eotech"] = { type = "Model", model = "models/wystan/attachments/eotech557sight.mdl", bone = "body", rel = "", pos = Vector(13.578, -8.568, -0.717), angle = Angle(180, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- SWEP.WElements = {
	-- ["eotech"] = { type = "Model", model = "models/wystan/attachments/eotech557sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-5.834, 2.341, 7.204), angle = Angle(-164.762, -180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	-- ["milkor"] = { type = "Model", model = "models/weapons/w_milkor_mgl1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.232, 1.49, 0), angle = Angle(-169.639, -180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
-- }

--and now to the nasty parts of this swep...

function SWEP:PrimaryAttack()
	if self:CanPrimaryAttack() then
		self:FireRocket()
		self.Weapon:EmitSound("MATADORF.single")
		self.Weapon:TakePrimaryAmmo(1)
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Owner:MuzzleFlash()
		self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
	end
	self:CheckWeaponsAndAmmo()
end

function SWEP:FireRocket()
	local aim = self.Owner:GetAimVector()
	local pos = self.Owner:GetShootPos()

	if SERVER then
	local rocket = ents.Create(self.Primary.Round)
	if !rocket:IsValid() then return false end
	rocket:SetAngles(aim:Angle()+Angle(90,0,0))
	rocket:SetPos(pos)
	rocket:SetOwner(self.Owner)
	rocket:Spawn()
	rocket:Activate()
	util.ScreenShake(self.Owner:GetShootPos(), 1000, 10, 0.3, 500 )
	end
end

function SWEP:SecondaryAttack()
end	

function SWEP:CheckWeaponsAndAmmo()
	if SERVER and self.Weapon != nil and (GetConVar("M9KWeaponStrip"):GetBool()) then 
		if self.Weapon:Clip1() == 0 && self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) == 0 then
			timer.Simple(.1, function() if SERVER then
				if not IsValid(self.Owner) then return end
				self.Owner:StripWeapon(self.Gun)
			end end)
		end
	end
end

if GetConVar("M9KDefaultClip") == nil then
	print("M9KDefaultClip is missing! You may have hit the lua limit!")
else
	if GetConVar("M9KDefaultClip"):GetInt() != -1 then
		SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar("M9KDefaultClip"):GetInt()
	end
end

if GetConVar("M9KUniqueSlots") != nil then
	if not (GetConVar("M9KUniqueSlots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher