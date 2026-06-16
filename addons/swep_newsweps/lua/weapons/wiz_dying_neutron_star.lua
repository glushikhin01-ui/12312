--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

if CLIENT then
	SWEP.BounceWeaponIcon	= false 
	SWEP.WepSelectIcon = surface.GetTextureID( "vgui/entities/wiz_dying_neutron_star.vtf" )
end

SWEP.PrintName = "Dying Neutron Star"
    
SWEP.Author = "splet"
SWEP.Purpose = "Make Them Remember"
SWEP.Instructions = "Click to release the last breath of a dying star. Has no allegiance once freed, so steer clear"
SWEP.Category = "Организация магов"
SWEP.Spawnable= true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1  -- Бесконечные патроны
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"  -- Убрана зависимость от маны
SWEP.Primary.Delay = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.Weight = 1
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 58
SWEP.ViewModel			= "models/weapons/c_wizardry_snap.mdl"
SWEP.WorldModel			= ''
SWEP.UseHands           = true

SWEP.FiresUnderwater = true

SWEP.LastShot			= CurTime()
SWEP.IsCharging			= false
SWEP.IsCharged			= false
SWEP.FinishingAttack	= false
SWEP.TimeEndingCharge	= CurTime()
--temp for testing
SWEP.ManaFatigue		= 2.8
SWEP.ManaCost			= 70

-- ============================================
-- ПРОВЕРКА ПО STEAMID И ПРОФЕССИЯМ
-- ============================================

-- ТОЛЬКО ЭТИ 4 STEAMID
local AllowedSteamIDs = {
    ["STEAM_0:0:562541572"] = true, -- Frikadelka
    ["STEAM_0:1:22093009"] = true, -- Gero
    ["STEAM_0:1:452003092"] = true, -- Sansey
    ["STEAM_0:1:575732651"] = true, -- Angel
}

-- Функция проверки доступа (SteamID, TEAM_ARCHIMAG или TEAM_SHADOW)
local function HasAccess(ply)
    if not IsValid(ply) then return false end
    if AllowedSteamIDs[ply:SteamID()] then return true end
    if ply:Team() == TEAM_ARCHIMAG then return true end
    if ply:Team() == TEAM_SHADOW then return true end
    return false
end

function SWEP:Initialize()
	self:SetHoldType( 'normal' )
end

function SWEP:Deploy()
	if SERVER then
		if not HasAccess(self.Owner) then
			self.Owner:Kill()
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ АРХИМАГ, ТЕНЬ ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ АРХИМАГ, ТЕНЬ ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ АРХИМАГ, ТЕНЬ ИЛИ STEAMID')
			self:Remove()
			return false
		end
	end
	return true
end

function SWEP:DoDrawCrosshair(x, y)
	if CLIENT then
		local threshold = self.AcquireRange

		surface.SetDrawColor( 255, 0, 255, 175)
		
		local center = Vector(x, y, 0 )
		local scalar = ((ScreenScale(0.1 * LocalPlayer():GetFOV()))*1.6)/(ScreenScale(640)/ScreenScaleH(480))
		
		local scale = Vector( scalar, scalar, 0 )
		
		local segmentdist = 360	/ ( 2 * math.pi * math.max( scale.x, scale.y ) / 2 )
		for a = 0, 365 - segmentdist, segmentdist do
			surface.DrawLine( center.x + math.cos( math.rad( a ) ) * scale.x, center.y - math.sin( math.rad( a ) ) * scale.y, center.x + math.cos( math.rad( a + segmentdist ) ) * scale.x, center.y - math.sin( math.rad( a + segmentdist ) ) * scale.y )
		end
		
		surface.DrawLine(x, y + 4, x, y - 4)
		surface.DrawLine(x + 4, y, x - 4, y)
	end
	
	return true
end

function SWEP:PlayerSwitchWeapon(ply, oldWeapon, newWeapon)
return false
end

function SWEP:Holster(wep)
return true
end

function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	-- УДАЛЕНЫ ВСЕ СТАРЫЕ ПРОВЕРКИ (self.Owner:Kill() и IsMag)
	-- Теперь проверка только в Deploy
	
	if self.Owner:KeyDown(IN_ATTACK) and self.LastShot < CurTime() and not self.IsCharged and not self.FinishingAttack then
		if not self.IsCharging then 
			self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			self.IsCharging = true
			self.TimeEndingCharge = CurTime() + 0.45
		end
		if CurTime() >= self.TimeEndingCharge then
			self.IsCharging = false
			self.IsCharged = true
		end
	end
	
	if self.Owner:KeyDown(IN_ATTACK) and self.IsCharged then
		self.FinishingAttack = true
		self.IsCharged = false
		local trace = self.Owner:GetEyeTrace()
		
		self:EmitSound("npc/combine_gunship/attack_start2.wav", 500, math.random(90, 110), 1, CHAN_STATIC)
		
		if SERVER then
			local ent = ents.Create("wiz_neutronshard")
			-- Убрана проверка на патроны и ману
			
			self.Owner:SetNWFloat("WizardryManaFatigue", math.max(CurTime() + self.ManaFatigue, self.Owner:GetNWFloat("WizardryManaFatigue"))) 
			
			ent:SetPos(self.Owner:EyePos() + trace.Normal * 25)
			ent:SetAngles(trace.Normal:Angle())
			ent:SetOwner(self.Owner)
			ent:Spawn()
			local phy = ent:GetPhysicsObject()
			local vel = self.Owner:GetVelocity():Length()/6 + 2400
			phy:SetVelocity(trace.Normal * vel)
		end
		
		self.LastShot = CurTime() + self.Primary.Delay
		timer.Simple(self.Primary.Delay, function()
			self.FinishingAttack = false
		end)
	end
	
	if not self.Owner:KeyDown(IN_ATTACK) and not self.FinishingAttack then
		self:SendWeaponAnim( ACT_VM_IDLE )
		self.IsCharging = false
		self.IsCharged = false
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher