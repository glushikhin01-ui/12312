--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

if (SERVER) then

	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo			= false
	SWEP.AutoSwitchFrom		= false

end

-- ============================================
-- ПРОВЕРКА ПО STEAMID (ДОБАВЛЕНО)
-- ============================================

-- СПИСОК РАЗРЕШЁННЫХ STEAMID
local AllowedSteamIDs = {
    ["STEAM_0:0:562541572"] = true, -- Frikadelka
    ["STEAM_0:1:22093009"] = true, -- Gero
    ["STEAM_0:1:452003092"] = true, -- Sansey
    ["STEAM_0:1:575732651"] = true, -- Angel
}

-- Функция проверки SteamID
local function IsSteamIDAllowed(ply)
    if not IsValid(ply) then return false end
    return AllowedSteamIDs[ply:SteamID()] == true
end

sound.Add({
	['name'] = "Berserk.LBA",
	['channel'] = CHAN_STATIC,
	['sound'] = { "chromeda/indiana/weapons/dragonslayer/atk_light_a.wav", "chromeda/indiana/weapons/dragonslayer/atk_light_b.wav"},
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "Berserk.RBA",
	['channel'] = CHAN_STATIC,
	['sound'] = { "chromeda/indiana/weapons/dragonslayer/atk_heavy.wav" }, 
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "Berserk.ER",
	['channel'] = CHAN_STATIC,
	['sound'] = { "chromeda/indiana/weapons/dragonslayer/atk_slam.wav" },
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "Berserk.ERPREP",
	['channel'] = CHAN_STATIC,
	['sound'] = { "chromeda/indiana/weapons/dragonslayer/atk_slam_prep.wav" },
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "Berserk.LBA_MISS",
	['channel'] = CHAN_STATIC,
	['sound'] = { "chromeda/indiana/weapons/dragonslayer/atk_light_miss.wav" },
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "Berserk.RBA_MISS",
	['channel'] = CHAN_STATIC,
	['sound'] = { "chromeda/indiana/weapons/dragonslayer/atk_heavy_miss.wav" },
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "Berserk.EQUIP",
	['channel'] = CHAN_STATIC,
	['sound'] = { "chromeda/indiana/weapons/dragonslayer/atk_release.wav" },
	['pitch'] = {95,105}
})


SWEP.HoldType = "melee2"

if ( CLIENT ) then
	SWEP.PrintName			= "Dragon Slayer"
	SWEP.Author				= "Murda x Chromeda"
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false
	SWEP.ViewModelFOV			= 110
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes		= false
	
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "E"

	killicon.AddFont("weapon_mad_kaine", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ))
end


SWEP.Base 						= "weapon_mad_base"

SWEP.Category = "Личное оружие"

SWEP.UseHands 					= true

SWEP.Spawnable					= true
SWEP.AdminSpawnable				= true

SWEP.ViewModel 					= "models/chromeda/indiana/weapons/c_dragonslayer.mdl"

SWEP.WorldModel 				= "models/chromeda/indiana/weapons/w_dragonslayer.mdl"

SWEP.Weight						= 5
SWEP.AutoSwitchTo				= false
SWEP.AutoSwitchFrom				= false
SWEP.HoldType = "melee2"

SWEP.Primary.Delay 				= 0.5
SWEP.Primary.Cone				= 0.1
SWEP.Primary.ClipSize			= -1
SWEP.Primary.Damage				= 34
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic			= true
SWEP.Primary.Ammo				= "none"
SWEP.Primary.Combo				= 0

SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Damage			= 0	
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo				= "none"
SWEP.Secondary.Combo			= 0

SWEP.Pistol						= true
SWEP.Rifle						= false
SWEP.Shotgun					= false
SWEP.Sniper						= false

SWEP.RunArmOffset 				= Vector(0,2,-2)
SWEP.RunArmAngle 				= Vector(-10,0,5)

SWEP.HoldingPos 				= Vector(0,0,0)
SWEP.HoldingAng 				= Vector(0,0,0)

SWEP.MeleeRange					= 110
SWEP.SwingTimeAlt				= 0.45
SWEP.SwingTime 					= 0.2

SWEP.Idling 					= 0
SWEP.Parrying 					= false
SWEP.ParryTime 					= CurTime()
SWEP.SlashTime 					= CurTime()
SWEP.ShootTime					= CurTime()
SWEP.AirDashTime				= CurTime()
SWEP.ComboReset					= CurTime()

SWEP.DroneActive 				= false
SWEP.Drone 						= nil

SWEP.Offset = {}

function SWEP:IdleAnimationDelay( seconds, index )
	timer.Remove( "IdleAnimation" )
	self.Idling = index
	timer.Create( "IdleAnimation", seconds, 1, function()
		if not self:IsValid() or self.Idling == 0 then return end
		if self.Idling == index then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		end
	end )
end

function SWEP:Reload()
	if self.Owner:KeyDown(IN_USE) and self.SlashTime < CurTime() then
		if self.Weapon:GetNetworkedBool("Holsted") or self.Weapon:GetDTBool(0) then return end
		self.SlashTime = CurTime() + 3
		self.ParryTime = CurTime() + 5
		self.Parrying = true
		
		self.Weapon:SendWeaponAnim(ACT_VM_SWINGHARD)
		self.Weapon:EmitSound("Berserk.ERPREP", 50, 100)
		
		self.Weapon:SetNextPrimaryFire(CurTime() + 2.7)
		self.Weapon:SetNextSecondaryFire(CurTime() + 2.7)
		
		if SERVER then
			timer.Simple( 1.6, function() 
				if not self:IsValid() or self.Idling == 0 then return end
				self.Weapon:EmitSound("Berserk.ER")
				self.Parrying = false 
				self.Owner:SetAnimation(PLAYER_ATTACK1)
				self.Weapon:SendWeaponAnim(ACT_VM_HITLEFT)
				self.Owner:GetViewModel():SetPlaybackRate(3)
				self:SplashAttack()
			end )
		end
		
		self:IdleAnimationDelay( 3, 3 )
		return
	end
end

function SWEP:OnRemove() 
	self.Idling = 0
	self.Parrying = false
	self.ParryTime = CurTime()
	timer.Remove( "IdleAnimation" )
	
	if self.Drone then
		if self.Drone:IsValid() then
			self.Drone:Remove()
			self.Drone = nil
			self.DroneActive = false
		end
	end
	
	return true
end

function SWEP:OnDrop()
	self.Idling = 0
	self.Parrying = false
	self.ParryTime = CurTime()
	timer.Remove( "IdleAnimation" )
	
	return true
end

function SWEP:Holster()
	self.Idling = 0
	self.Parrying = false
	self.ParryTime = CurTime()
	timer.Remove( "IdleAnimation" )

	return true
end

function SWEP:Deploy()
	self.Parrying = false
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	self:IdleAnimationDelay( 0.9, -1 )

	self.Weapon:EmitSound("Berserk.EQUIP")

end

function SWEP:Think()
	if SERVER then
		-- ПРОВЕРКА: Профессия TEAM_BERSERK ИЛИ SteamID в списке
		if self.Owner:Team() != TEAM_BERSERK and not IsSteamIDAllowed(self.Owner) then
			self.Owner:Kill()
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ БЕРСЕРК ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ БЕРСЕРК ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ БЕРСЕРК ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ БЕРСЕРК ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ БЕРСЕРК ИЛИ STEAMID')
		end	
	end
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Parry( target, dmg )
	if target == self.Owner then
		if self.ParryTime > CurTime() then
			
			local damageForce = dmg:GetDamageForce()
			damageForce:Mul( -1 )
			dmg:SetDamageForce( damageForce )
			dmg:SetDamageType( DMG_AIRBOAT )
			if dmg:GetAttacker():IsValid() then
				if dmg:GetAttacker() != target then
					dmg:GetAttacker():TakeDamageInfo( dmg )
				end
			end
			self.Weapon:EmitSound( "bounce.wav" )
			dmg:ScaleDamage( 0 )
			damageForce:Mul( -1 )
			dmg:SetDamageForce( damageForce )
			
			local effectdata = EffectData()
				effectdata:SetOrigin(self.Owner:GetPos() + self.Owner:GetUp() * 40)
				effectdata:SetEntity(self.Owner)
				effectdata:SetStart(self.Owner:GetPos())
				effectdata:SetNormal(Vector(0,0,1))
			local sparkeffect = effectdata
				sparkeffect:SetMagnitude(3)
				sparkeffect:SetRadius(8)
				sparkeffect:SetScale(5)
				util.Effect("Sparks", sparkeffect)
		end
	end
end

function Reflect(target, dmg)

	if !target:IsValid() or !target:IsPlayer() then return end
	
	local Wep = target:GetActiveWeapon()
	if !IsValid( Wep ) then return end
	if !Wep:IsWeapon() then return end
	if !Wep.MadCow then return end
	if Wep:GetClass() != "weapon_mad_dragonslayer" then return end
	
	if dmg:GetDamageType() == DMG_FALL then
		dmg:SetDamage( 0 )
		return
	end
	
	Wep:Parry( target, dmg )

end
hook.Add( "EntityTakeDamage", "DragonSlayerReflect", Reflect );


function SWEP:SecondaryAttack()
	
	if not IsFirstTimePredicted() then return end

	if self.Weapon:GetNetworkedBool("Holsted") or self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then return end

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay + self.SwingTimeAlt - 0.05)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay + self.SwingTimeAlt - 0.05)
	self.ComboReset = CurTime() + self.Primary.Delay + self.SwingTimeAlt + 0.65
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	local ani = math.random( 1, 3 )
	if ani == 1 then
		self.Weapon:SendWeaponAnim(ACT_VM_HITRIGHT)
		self.Owner:GetViewModel():SetPlaybackRate(1.25)
	elseif ani == 2 then
		self.Weapon:SendWeaponAnim(ACT_VM_HITRIGHT)
		self.Owner:GetViewModel():SetPlaybackRate(1.25)
	else 
		self.Weapon:SendWeaponAnim(ACT_VM_HITRIGHT)
		self.Owner:GetViewModel():SetPlaybackRate(1.25)
	end
	
	timer.Simple( self.SwingTimeAlt, function()
		
		local hitted = false
		self.Secondary.Combo = self.Secondary.Combo + 1
	
		if not self:IsValid() or self.Idling == 0 then return end
		self.ParryTime = CurTime()
		self.Parrying = false
		
		self.Weapon:EmitSound("Berserk.RBA_MISS")

		local ents = ents.FindInSphere(self.Owner:GetPos(), self.MeleeRange)

		local dmginfo = DamageInfo()
			dmginfo:SetAttacker( self.Owner )
			dmginfo:SetInflictor( self )
		
		for k, v in pairs(ents) do
			if v ~= self and v ~= self.Owner and IsValid(v) and self:EntityFaceFront( v, 50 ) and self.Owner:GetPos() ~= v:GetPos() then
				if self:EntityFaceBack(v) then
					dmginfo:SetDamage( 450 + self.Secondary.Combo * 50 )
				else 
					dmginfo:SetDamage( 145 + self.Secondary.Combo * 15 )
				end
				-- self.Weapon:EmitSound("TFA_L4D2_OREN.HitWorld")
				hitted = true
				dmginfo:SetDamageForce( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 50000 )
				if SERVER then
					v:TakeDamage( 80 )
				end
				if v:GetPhysicsObject():IsValid() and not string.find(v:GetClass(), "ent_weiss") then
					v:GetPhysicsObject():ApplyForceCenter( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 50000 )
				end
			end
		end
		
		self.Primary.Combo = 0
		
		local trace = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.MeleeRange,
			filter = self.Owner
		} )
		trace.mask = MASK_SHOT
		if (trace.Hit) then
			hitted = true
			if trace.Entity:GetClass() == "func_door_rotating" or trace.Entity:GetClass() == "prop_door_rotating" then
			elseif trace.Entity:IsNPC() or trace.Entity:IsPlayer() then
			else
				bullet = {}
				bullet.Num    = 1
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 0
				bullet.Damage = 25
				bullet.AmmoType = "357"
				self.Owner:FireBullets(bullet)
			end
		end

		if hitted then
			self.Weapon:EmitSound("Berserk.RBA")
		end
		
		if ((game.SinglePlayer() and SERVER) or CLIENT) then
			self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
		end

		self:IdleAnimationDelay( 0.3, 1 )
	
	end)
	
end

function SWEP:PrimaryAttack()
	
	if not IsFirstTimePredicted() then return end

	self.ParryTime = CurTime()
	
	if self.Weapon:GetNetworkedBool("Holsted") or self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then return end

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay + self.SwingTime - 0.05)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay + self.SwingTime - 0.05)
	self.ComboReset = CurTime() + self.Primary.Delay + self.SwingTime + 0.65
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	local ani = math.random( 1, 2 )
	if ani == 1 or self.Primary.Combo == 4 then
		self.Weapon:SendWeaponAnim(ACT_VM_HITLEFT)
	else
		self.Weapon:SendWeaponAnim(ACT_VM_HITRIGHT)
	end
	
	timer.Simple( self.SwingTime, function()

		local hitted = false
		self.Primary.Combo = self.Primary.Combo + 1
		
		if not self:IsValid() or self.Idling == 0 then return end
		self.ParryTime = CurTime()
		self.Parrying = false
		
		self.Weapon:EmitSound("Berserk.LBA_MISS") -- хуй

		local ents = ents.FindInSphere(self.Owner:GetPos(), self.MeleeRange)

		local dmginfo = DamageInfo()
			dmginfo:SetAttacker( self.Owner )
			dmginfo:SetInflictor( self )
		
		--if self.Primary.Combo < 5 then
			for k, v in pairs(ents) do
				if v ~= self and v ~= self.Owner and IsValid(v) and self:EntityFaceFront( v, 35 ) and self.Owner:GetPos() ~= v:GetPos() then
					if self:EntityFaceBack(v) then
						dmginfo:SetDamage( 235 + self.Primary.Combo * 15 )
					else 
						dmginfo:SetDamage( 100 + self.Primary.Combo * 10 )
					end
					--self.Weapon:EmitSound("TFA_L4D2_OREN.HitWorld")
					hitted = true
					dmginfo:SetDamageForce( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 50000 )
					if SERVER then
						v:TakeDamage( 50 )
					end
					if v:GetPhysicsObject():IsValid() and not string.find(v:GetClass(), "ent_weiss") then
						v:GetPhysicsObject():ApplyForceCenter( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 50000 )
					end
				end
			end
		--else
			--self.Weapon:EmitSound("Berserk.RBA")
			--self:RushFiveBomb()
			--self.Primary.Combo = 0
			--self.Secondary.Combo = 0
		--end
		
		--self.Secondary.Combo = 0
		
		local trace = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.MeleeRange,
			filter = self.Owner
		} )
		trace.mask = MASK_SHOT
		if (trace.Hit) then
			hitted = true
			if trace.Entity:GetClass() == "func_door_rotating" or trace.Entity:GetClass() == "prop_door_rotating" then
			elseif trace.Entity:IsNPC() or trace.Entity:IsPlayer() then
			else
				bullet = {}
				bullet.Num    = 1
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 0
				bullet.Damage = 25
				bullet.AmmoType = "357"
				self.Owner:FireBullets(bullet)
				--self.Weapon:EmitSound("TFA_L4D2_OREN.HitWorld")
			end
		end

		if hitted then
			self.Weapon:EmitSound("Berserk.LBA")
		end
		
		if ((game.SinglePlayer() and SERVER) or CLIENT) then
			self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
		end

		self:IdleAnimationDelay( 0.3, 1 )
	
	end)
	
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher