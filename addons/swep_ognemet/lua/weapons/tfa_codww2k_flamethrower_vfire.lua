SWEP.Base = "tfa_codww2k_flamethrower"
SWEP.Category = "TFA COD WW2 Kabyi"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Purpose = "12 Meter range"
SWEP.Manufacturer = "US Army Chemical Warfare Service"
SWEP.Type_Displayed = "Flamethrower"
SWEP.Author = "Olli, Fox, Mav"
SWEP.Slot = 4
SWEP.PrintName = "M2 Flamethrower (vFire)"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false

--[Gun Related]--
SWEP.Primary.Sound = Sound("TFA_CODWW2_M2FT.Start")
SWEP.Primary.LoopSound = Sound("TFA_CODWW2_M2FT.Loop")
SWEP.Primary.LoopSoundTail = Sound("TFA_CODWW2_M2FT.Stop")
SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.LMG"
SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.LMG"
SWEP.MuzzleFlashEffect = "tfa_codww2k_flamethrower_muzzle"
SWEP.Primary.Ammo = "AlyxGun"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 1000
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.RPM_Displayed = 700
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 150
SWEP.Primary.HullSize = 10
SWEP.Primary.DryFireDelay = 0.35
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

-- Default values are for single player
SWEP.ShootInterval = 0.03
SWEP.ShootLife = 2
SWEP.ShootFeed = 0.5

-- Decrease load on the server by increasing shoot interval and increasing size to make up for it
if !game.SinglePlayer() then
	SWEP.ShootInterval = 0.07
	SWEP.ShootLife = 2.15
	SWEP.ShootFeed = 1
end

function SWEP:PreSpawnProjectile(ent)
	self:ShootFire()
	local owner = self:GetOwner()
	ent:SetPos(owner:GetShootPos() + owner:GetForward()*35)
end


function SWEP:ShootFire()

	-- if !self:GetShooting() then

	-- 	self:SetShooting(true)

	-- 	local effectdata = EffectData()
	-- 	effectdata:SetEntity(self)
	-- 	util.Effect("vfirethrower_jet", effectdata, true, true)

	-- end

	if SERVER then

		local life = math.Rand(4, 8) * self.ShootLife
		local owner = self:GetOwner()

		-- Determine how far forward we should spawn the fireball (we wish to extend it by default for animation purposes)
		local forwardBoost = math.Rand(20, 40)
		local frac = owner:GetEyeTrace().Fraction
		-- We're looking into an obstacle, spawn the fireball exactly on the barrel
		if frac < 0.001245 then
			forwardBoost = 1
		end

		local forward = self:GetOwner():EyeAngles():Forward()
		local pos = self.Owner:GetShootPos() + forward * forwardBoost
		local vel = forward * math.Rand(900, 1000)
		local feedCarry = math.Rand(5, 10) * self.ShootFeed
		CreateVFireBall(life, feedCarry, pos, vel, owner)
	end

end