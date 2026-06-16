--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

if CLIENT then
	SWEP.BounceWeaponIcon	= false 
	SWEP.WepSelectIcon = surface.GetTextureID( "vgui/entities/wiz_wizard_pistol.vtf" )
end

--todo:
--make it so autoaim tracers work in singleplayer. shouldnt be hard, just lazy

SWEP.PrintName = "Wizard Pistol"
    
SWEP.Author = "splet"
SWEP.Purpose = "Harass Thy Enemy"
SWEP.Instructions = "Click to shoot; keep your foes within the large reticle-circle to fire seeking rounds. Wizard bullets are very effective against Wizard shielding"
SWEP.Category = "Организация магов"
SWEP.Spawnable= true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"

SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 125
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"  -- Убрана зависимость от маны
SWEP.Primary.Delay = 0.09

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Slot = 1
SWEP.SlotPos = 4
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.Weight = 1
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/c_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"
SWEP.UseHands           = true

SWEP.FiresUnderwater = true

SWEP.BaseSpread			= 0.125
SWEP.FocusSpread		= 0.01
SWEP.MaxBurstyness		= 5
SWEP.Burstyness			= 0

SWEP.TrackingArea		= 0.3

SWEP.LastShot			= CurTime()
SWEP.InReload			= false
SWEP.ReloadTimer		= CurTime()
SWEP.ManaFatigue		= 2
SWEP.AcquireRange		= 3500

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
	self:SetHoldType( "pistol" )
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
	self.InReload = false
	return false
end

function SWEP:Holster(wep)
	self.InReload = false	
	return true
end

function SWEP:DoDrawCrosshair(x, y)
	if CLIENT then
		local xhairpos = Vector(x, y)
		surface.SetDrawColor( 255, 250, 100, 175)
		
		local scalar = ((ScreenScale(self.BaseSpread * 2.1 * LocalPlayer():GetFOV()))*1.6)/(ScreenScale(640)/ScreenScaleH(480))

		local center = Vector( xhairpos.x, xhairpos.y, 0 )
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

function SWEP:DrawHUDBackground()
	--[[
	local ourMat = Material( "effects/blueflare1" )
	surface.SetDrawColor( 220, 220, 150, 50 ) -- Set the drawing color
	surface.SetMaterial( ourMat ) -- Use our cached material
	
	local tgt_table = ents.FindInSphere(self.Owner:GetPos(), self.AcquireRange)
	for id, ent in ipairs(tgt_table) do
		local entpos = self:LookForCenter(ent)
		
		if self.Owner:IsLineOfSightClear(entpos) and ((ent:IsNPC() and ent:Health() > 0) or (ent:IsPlayer() and ent:Alive() and ent != self.Owner)) then
			local entposforreal = entpos:ToScreen()
			local texsize = math.Rand(28, 36)
			
			surface.DrawTexturedRect(entposforreal.x - texsize/2, entposforreal.y - texsize/2, texsize, texsize)
		end
	end]]
end

function SWEP:LookForCenter(tgt)
	local bone = tgt:LookupBone("ValveBiped.Bip01_Spine1")
	local tarPos =  tgt:GetPos()
	if tgt:GetClass() == "npc_fastzombie" then
		tarPos = tgt:GetBonePosition( 13 )
	elseif bone == nil then
		tarPos = tgt:GetBonePosition( 0 )
		
		if tarPos == nil then
			tarPos = tgt:GetPos()
		end
	else
		tarPos = tgt:GetBonePosition( bone )
	end
	return tarPos
end

function SWEP:PrimaryAttack()
	if self.LastShot < CurTime() and self:Clip1() >= 1 and !self.InReload then
		if ( self.Owner:IsPlayer() ) then
			self.Owner:SetViewPunchAngles( Angle(0, 0, 0))
			self.Owner:ViewPunch( Angle(math.Rand(-0.45, -0.55), math.Rand(-0.4, 0.4), 0))
		end
	
		if ( self:GetOwner():IsPlayer() ) then
			self:GetOwner():LagCompensation( true )
		end
		
		local trace = self.Owner:GetEyeTrace()
		local aimbotTarget = NULL
		local trackAngle = Vector(1, self.TrackingArea, 0):GetNormalized():Angle()
		
		local trackAngCos = math.cos(math.rad(trackAngle.y/2))
		
		
		--find a target in the cone
		local boxmins = self.Owner:GetPos() + Vector(self.AcquireRange, self.AcquireRange, self.AcquireRange)
		local boxmaxs = self.Owner:GetPos() - Vector(self.AcquireRange, self.AcquireRange, self.AcquireRange)
		
		local directionAngCos = trackAngCos
		local aimVector = self.Owner:GetAimVector()	
		-- The vector that goes from the player's shoot pos to the entity's position
		
		local tgt_table = ents.FindInSphere(self.Owner:GetPos(), self.AcquireRange)
		for id, ent in ipairs(tgt_table) do
			local entpos = self:LookForCenter(ent)
			local entVector = entpos - self.Owner:GetShootPos() 
			local angCos = aimVector:Dot(entVector) / entVector:Length()
			
			if angCos >= directionAngCos and self.Owner:IsLineOfSightClear(entpos) and !aimbotTarget:IsValid() and ((ent:IsNPC() and ent:Health() > 0) or (ent:IsPlayer() and ent:Alive() and ent != self.Owner)) then
				aimbotTarget = ent
				break
			end
		end
		
		--"fx_wizard_blt_homing" is the homing bullet
		
		--handle shooting. if we don't have a target, shoot a real bullet; if we do have a target, fake it
		if !aimbotTarget:IsValid() then
			local function BulletCallback(attacker, trace, dmginfo)
				dmginfo:SetDamageType(DMG_SONIC)
			end
			local bullet = {}
			bullet.Attacker = self.Owner
			bullet.Damage = 16	--pretty much chip damage, but what it does to shields is really powerful 
			bullet.Force = 2
			bullet.HullSize = 2
			bullet.Num = 1
			bullet.Callback = BulletCallback
			bullet.TracerName = "fx_wizard_blt"
			bullet.Dir = trace.Normal
			bullet.Spread = Vector(self.BaseSpread, self.BaseSpread, 0)
			bullet.Src = self.Owner:GetShootPos()
			bullet.IgnoreEntity = self.Owner
			
			self:FireBullets(bullet)
			self:EmitSound(Sound"wizpistol/alyx_gun_fire"..tostring(math.random(3,4))..".wav", 120, math.random(90, 110), 1, CHAN_STATIC)
			self:EmitSound(Sound"weapons/airboat/airboat_gun_energy"..tostring(math.random(1,2))..".wav", 120, math.random(90, 110), 0.25, CHAN_STATIC)
		elseif aimbotTarget:IsValid() then
			local function GetTracerShootPos( Position, Ent, Attachment )
				if ( !IsValid( Ent ) ) then return Position end
				if ( !Ent:IsWeapon() ) then return Position end
				-- Shoot from the viewmodel
				if CLIENT then
					if ( Ent:IsCarriedByLocalPlayer() && !LocalPlayer():ShouldDrawLocalPlayer() ) then
						local ViewModel = LocalPlayer():GetViewModel()
						if ( ViewModel:IsValid() ) then
							local att = ViewModel:GetAttachment( Attachment )
							if ( att ) then
								Position = att.Pos
							end
						end
					end
				else -- Shoot from the world model
					local att = Ent:GetAttachment( Attachment )
					if ( att ) then
						Position = att.Pos
					end
				end
				return Position
			end
		
			local tgt_pos = self:LookForCenter(aimbotTarget)
			local dmginfo = DamageInfo()
			dmginfo:SetDamage(16)
			dmginfo:SetDamageType(DMG_SONIC)
			dmginfo:SetInflictor(self)
			dmginfo:SetAttacker(self.Owner)
			dmginfo:SetDamagePosition(tgt_pos)
			
			local bonepos = self:GetBonePosition(0)
			if bonepos == self:GetPos() then
				bonepos = self:GetBoneMatrix(0):GetTranslation()
			end
			local att = GetTracerShootPos(bonepos, self, self:LookupAttachment( "muzzle" ))
			
			local varvec = (self.Owner:GetEyeTrace().Normal) + VectorRand(-0.15, 0.15)
			effectdata = EffectData()
			effectdata:SetOrigin(tgt_pos)
			effectdata:SetStart(att)
			effectdata:SetNormal(varvec)
			util.Effect("fx_wizard_blt_homing", effectdata)
			if aimbotTarget:IsPlayer() and aimbotTarget:GetNWBool("WizardryWizMovementSuite") and aimbotTarget:Armor() != 0 then
				effectdata:SetEntity(aimbotTarget)
				util.Effect("fx_wizard_suite_hit", effectdata)
			end
			if SERVER then aimbotTarget:TakeDamageInfo(dmginfo) end
			aimbotTarget = NULL	--cull
			self:EmitSound(Sound"wizpistol/alyx_gun_fire"..tostring(math.random(3,4))..".wav", 120, math.random(90, 110), 1, CHAN_STATIC)
			self:EmitSound(Sound"weapons/airboat/airboat_gun_energy"..tostring(math.random(1,2))..".wav", 120, math.random(90, 110), 0.15, CHAN_STATIC)
			self:EmitSound(Sound"weapons/crossbow/bolt_fly4.wav", 120, math.random(90, 110), 0.30, CHAN_STATIC)
		end
		
		if ( self:GetOwner():IsPlayer() ) then
			self:GetOwner():LagCompensation( false )
		end
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self:TakePrimaryAmmo( 1 )
		self.Burstyness = self.Burstyness + 1
		if self.Burstyness >= self.MaxBurstyness then
			self.LastShot = CurTime() + self.Primary.Delay * 2.2
			self:EmitSound("npc/scanner/combat_scan2.wav", 150, math.random(145, 155), 0.4, CHAN_STATIC)
		else
			self.LastShot = CurTime() + self.Primary.Delay
		end
	end
	
	if self.LastShot < CurTime() and self:Clip1() < 3 and !self.InReload then
		self:Reload()
	end
end

function SWEP:Reload()
	if self.InReload then return end
	
	if self:Clip1() < self.Primary.ClipSize and self:GetOwner():GetAmmoCount( self.Primary.Ammo ) > 0 then
		self.InReload = true
		self:DefaultReload(ACT_VM_RELOAD)
		timer.Simple(self:SequenceDuration(), function()
			if self.InReload then
				self:EmitSound("buttons/blip1.wav", 150, 240, 0.3, CHAN_STATIC)
				self.Owner:SetNWFloat("WizardryManaFatigue", math.max(CurTime() + self.ManaFatigue, self.Owner:GetNWFloat("WizardryManaFatigue"))) 
				self.InReload = false
			end
		end)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	-- УДАЛЕНЫ ВСЕ СТАРЫЕ ПРОВЕРКИ (self.Owner:Kill() и IsMag)
	-- Теперь проверка только в Deploy
	
	--force bursts of five
	if !self.Owner:KeyDown(IN_ATTACK) or self.Burstyness >= self.MaxBurstyness then
		self.Burstyness = 0
	end
	
	--force player to click to reload
	if self:Clip1() < 1 then
		self.Primary.Automatic = false
	else self.Primary.Automatic = true end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher