--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

if CLIENT then
	SWEP.BounceWeaponIcon	= false 
	SWEP.WepSelectIcon = surface.GetTextureID( "vgui/entities/wiz_wizard_shotgun.vtf" )
end

SWEP.PrintName = "Wizard Shotgun"
    
SWEP.Author = "splet"
SWEP.Purpose = "Blast Thyself Waywards"
SWEP.Instructions = "Click to shoot; Alt-Fire will fire a more forceful volley. Wizard bullets are very effective against Wizard shielding"
SWEP.Category = "Организация магов"
SWEP.Spawnable= true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"

SWEP.Primary.ClipSize = 36
SWEP.Primary.DefaultClip = 136
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"  -- Убрана зависимость от маны
SWEP.Primary.Delay = 0.75

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 1.2

SWEP.Slot = 3
SWEP.SlotPos = 4
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.Weight = 1
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/c_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.UseHands           = true

SWEP.FiresUnderwater = true

SWEP.BaseSpread			= 0.05

SWEP.LastShot			= CurTime()
SWEP.InReload			= false
SWEP.ReloadTimer		= CurTime()
SWEP.IsPumping			= false
SWEP.ManaFatigue		= 1.75

-- ============================================
-- ПРОВЕРКА ПО STEAMID И ПРОФЕССИИ TEAM_ARCHIMAG
-- ============================================

-- ТОЛЬКО ЭТИ 4 STEAMID
local AllowedSteamIDs = {
    ["STEAM_0:0:562541572"] = true, -- Frikadelka
    ["STEAM_0:1:22093009"] = true, -- Gero
    ["STEAM_0:1:452003092"] = true, -- Sansey
    ["STEAM_0:1:575732651"] = true, -- Angel
}

-- Функция проверки доступа
local function HasAccess(ply)
    if not IsValid(ply) then return false end
    if AllowedSteamIDs[ply:SteamID()] then return true end
    if ply:Team() == TEAM_ARCHIMAG then return true end
    return false
end

function SWEP:Initialize()
	self:SetHoldType( "shotgun" )
	self:SendWeaponAnim( ACT_VM_DRAW )
end

function SWEP:Deploy()
	if SERVER then
		if not HasAccess(self.Owner) then
			self.Owner:Kill()
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ АРХИМАГ ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ АРХИМАГ ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ АРХИМАГ ИЛИ STEAMID')
			self:Remove()
			return false
		end
	end
	return true
end

function SWEP:PlayerSwitchWeapon(ply, oldWeapon, newWeapon)
	self.IsPumping = false
	self.InReload = false
	return false
end

function SWEP:Holster(wep)
	self.IsPumping = false
	self.InReload = false
	return true
end

function SWEP:DoDrawCrosshair(x, y)
	if CLIENT then
		surface.SetDrawColor( 255, 250, 100, 175)
		
		local center = Vector(x, y, 0 )
		local scalar = ((ScreenScale(self.BaseSpread * 2.1 * LocalPlayer():GetFOV()))*1.6)/(ScreenScale(640)/ScreenScaleH(480))
		
		local scale = Vector( scalar, scalar, 0 )
		
		local segmentdist = 360 / ( 2 * math.pi * math.max( scale.x, scale.y ) / 2 )
		for a = 0, 365 - segmentdist, segmentdist do
			surface.DrawLine( center.x + math.cos( math.rad( a ) ) * scale.x, center.y - math.sin( math.rad( a ) ) * scale.y, center.x + math.cos( math.rad( a + segmentdist ) ) * scale.x, center.y - math.sin( math.rad( a + segmentdist ) ) * scale.y )
		end
		
		surface.DrawLine(x, y + 4, x, y - 4)
		surface.DrawLine(x + 4, y, x - 4, y)
	end
	return true
end

function SWEP:PrimaryAttack()
	--testing
	if self.LastShot < CurTime() and self:Clip1() >= 6 and not self.InReload then
		if self.Owner:IsPlayer() then
			self.Owner:SetViewPunchAngles( Angle(0, 0, 0))
			self.Owner:ViewPunch( Angle(math.Rand(-1.4, -1.8), math.Rand(-1.2, 1.2), 0))
		end
		
		if self:GetOwner():IsPlayer() then
			self:GetOwner():LagCompensation( true )
		end
		local trace = self.Owner:GetEyeTrace()
		
		--handle shooting
		local function BulletCallback(attacker, trace, dmginfo)
			dmginfo:SetDamageType(DMG_SONIC)
		end
		local bullet = {}
		bullet.Attacker = self.Owner
		bullet.Damage = 7
		bullet.Force = 8
		bullet.HullSize = 1
		bullet.Num = 18
		bullet.Callback = BulletCallback
		bullet.TracerName = "fx_wizard_shotgun_pellet"
		bullet.Dir = trace.Normal
		bullet.Spread = Vector(self.BaseSpread, self.BaseSpread, 0)
		bullet.Src = self.Owner:GetShootPos()
		bullet.IgnoreEntity = self.Owner
		
		self:FireBullets(bullet)
		
		if self:GetOwner():IsPlayer() then
			self:GetOwner():LagCompensation( false )
		end
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self:TakePrimaryAmmo( 6 )
		
		self:EmitSound(Sound"weapons/shotgun/shotgun_fire6.wav", 150, math.random(90, 110), 0.8, CHAN_STATIC)
		self:EmitSound(Sound"weapons/airboat/airboat_gun_energy"..tostring(math.random(1,2))..".wav", 150, math.random(90, 110), 1, CHAN_STATIC)
		
		self.IsPumping = true
		local pumpdelay = 0.25
		timer.Simple(pumpdelay, function()
			if self:IsValid() and self.Owner:GetActiveWeapon():IsValid() and self.Owner:GetActiveWeapon():GetClass() == self:GetClass() then
				self:EmitSound(Sound"npc/scanner/scanner_scan4.wav", 110, 100, 0.6)
				self.Owner:SetAnimation( ACT_SHOTGUN_PUMP )
				self:SendWeaponAnim( ACT_SHOTGUN_PUMP )
				timer.Simple(0.2, function()
					if self:IsValid() and self.Owner:GetActiveWeapon():IsValid() and self.Owner:GetActiveWeapon():GetClass() == self:GetClass() then
						self.IsPumping = false
					end
				end)
			end
		end)
		self.LastShot = CurTime() + self.Primary.Delay
	end
	
	if self.LastShot < CurTime() and self:Clip1() < 6 and not self.InReload then
		self:StartReload()
	end
end

function SWEP:SecondaryAttack()
	if self.LastShot < CurTime() and self:Clip1() > 6 and not self.InReload then
		if self.Owner:IsPlayer() then
			self.Owner:SetViewPunchAngles( Angle(0, 0, 0))
			self.Owner:ViewPunch( Angle(math.Rand(-4, -3), math.Rand(-2.1, 2.1), 0))
		end
		
		if self:GetOwner():IsPlayer() then
			self:GetOwner():LagCompensation( true )
		end
		local trace = self.Owner:GetEyeTrace()
		
		--handle shooting
		local function BulletCallback(attacker, trace, dmginfo)
			dmginfo:SetDamageType(DMG_SONIC)
		end
		local bullet = {}
		bullet.Attacker = self.Owner
		bullet.Damage = 7
		bullet.Force = 8
		bullet.HullSize = 1
		bullet.Num = 3 * math.min(18, self:Clip1())
		bullet.Callback = BulletCallback
		bullet.TracerName = "fx_wizard_shotgun_pellet"
		bullet.Dir = trace.Normal
		bullet.Spread = Vector(self.BaseSpread * 1.5, self.BaseSpread * 1.5, 0)
		bullet.Src = self.Owner:GetShootPos()
		bullet.IgnoreEntity = self.Owner
		
		self:FireBullets(bullet)
		
		if self:GetOwner():IsPlayer() then
			self:GetOwner():LagCompensation( false )
		end
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
		self:TakePrimaryAmmo(math.min(18, self:Clip1()))
		
		self:EmitSound(Sound"weapons/shotgun/shotgun_dbl_fire.wav", 150, math.random(95, 105), 0.8, CHAN_STATIC)
		self:EmitSound(Sound"npc/sniper/sniper1.wav", 150, math.random(90, 110), 1, CHAN_STATIC)
		self:EmitSound(Sound"npc/combine_gunship/attack_start2.wav", 150, math.random(90, 110), 1, CHAN_STATIC)

		self.IsPumping = true
		local pumpdelay = 0.5
		timer.Simple(pumpdelay, function()
			if self:IsValid() and self.Owner:GetActiveWeapon():IsValid() and self.Owner:GetActiveWeapon():GetClass() == self:GetClass() then
				self:EmitSound(Sound"npc/scanner/scanner_scan2.wav", 110, 100, 0.4)
				self.Owner:SetAnimation( ACT_SHOTGUN_PUMP )
				self:SendWeaponAnim( ACT_SHOTGUN_PUMP )
				timer.Simple(0.2, function()
					if self:IsValid() and self.Owner:GetActiveWeapon():IsValid() and self.Owner:GetActiveWeapon():GetClass() == self:GetClass() then
						self.IsPumping = false
					end
				end)
			end
		end)
		self.LastShot = CurTime() + self.Secondary.Delay
	end
	
	if self.LastShot < CurTime() and self:Clip1() < 6 and not self.InReload then
		self:StartReload()
	end
end

function SWEP:Reload()
   if self.InReload or self.IsPumping then return end

   if self:Clip1() < self.Primary.ClipSize then
      if self:StartReload() then
         return
      end
   end
end

function SWEP:StartReload()
   if self.InReload then
      return false
   end

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   local ply = self:GetOwner()

   if not ply then
      return false
   end

   local wep = self

   if wep:Clip1() >= self.Primary.ClipSize then
      return false
   end

   wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

   self.ReloadTimer = CurTime() + wep:SequenceDuration()

   self.InReload = true

   return true
end

function SWEP:PerformReload()
	local ply = self:GetOwner()

	-- prevent normal shooting in between reloads
	self.LastShot = CurTime() + self.Primary.Delay

	if not ply then return end

	if self:Clip1() >= self.Primary.ClipSize then return end

	self:EmitSound(Sound"weapons/shotgun/shotgun_reload"..tostring(math.random(1,3))..".wav", 80, math.random(90, 110), 0.5)
	timer.Simple(0.2, function()
		if self.InReload == true then
			--load as much ammo as possible
			local maxload = math.min(12, self.Primary.ClipSize - self:Clip1())
			self:SetClip1( self:Clip1() + maxload )
			
			self:EmitSound("buttons/blip1.wav", 90, 80 * self:Clip1()/12, 0.3, CHAN_STATIC)
			self.Owner:SetNWFloat("WizardryManaFatigue", math.max(CurTime() + self.ManaFatigue, self.Owner:GetNWFloat("WizardryManaFatigue"))) 
		end
	end)

	self:SendWeaponAnim(ACT_VM_RELOAD)

	self.ReloadTimer = CurTime() + self:SequenceDuration()
end

function SWEP:FinishReload()
   self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
   self.InReload = false
   self.ReloadTimer = CurTime() + self:SequenceDuration()
end

function SWEP:Think()
	-- УДАЛЕНЫ ВСЕ СТАРЫЕ ПРОВЕРКИ (self.Owner:Kill() и IsMag)
	-- Теперь проверка только в Deploy
	
	--handle reload repetition
	if self.InReload then
      if (self.Owner:KeyDown(IN_ATTACK) or self.Owner:KeyDown(IN_ATTACK2)) and self:Clip1() > 0 then
         self:FinishReload()
         return
      end

      if self.ReloadTimer <= CurTime() then
         if self:Clip1() < self.Primary.ClipSize then
            self:PerformReload()
         else
            self:FinishReload()
         end
         return
      end
   end
   
   	--force player to click to reload
	if self:Clip1() < 6 then
		self.Primary.Automatic = false
		self.Secondary.Automatic = false
	else 
		self.Primary.Automatic = true 
		self.Secondary.Automatic = true
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher