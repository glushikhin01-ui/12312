-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

if SERVER then
	AddCSLuaFile()
end

DEFINE_BASECLASS("tfa_nade_base")

-- For some reason adding this fixes vmanip. Adding SWEP.ViewModelElements doesn't work! 
SWEP.VElements = {
	
}

SWEP.CookTimer = 3
SWEP.CookDelay = 0.6
SWEP.Cookable = false
SWEP.ThrowSpin = false
SWEP.Primary.SpreadBiasPitch = 1
SWEP.Primary.SpreadBiasYaw = 1
SWEP.StatCache_Blacklist = {
	["Primary.SpreadBiasPitch"] = true,
	["Primary.SpreadBiasYaw"] = true,
}

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	
	self:NetworkVarTFA("Bool", "Cooking")
	self:NetworkVarTFA("Bool", "Detonated")
	self:NetworkVarTFA("Float", "HeldTime")
	self:NetworkVarTFA("Float", "Breathe")
end

function SWEP:Initialize()
	BaseClass.Initialize(self)

	self:SetCooking(false)
	self:SetHeldTime(0)
	self:SetBreathe(0)
	self.Shrink = CurTime()
end

function SWEP:Deploy()
	self:SetCooking(false)
	self:ResetCrosshair()

	return BaseClass.Deploy(self)
end

--[Start the clock]--
function SWEP:PrimaryAttack()
	if self.Cookable then
		self:SetCooking(true)
		self:SetHeldTime(CurTime() + self.CookTimer + self.CookDelay)
	end

	return BaseClass.PrimaryAttack(self)
end

--[Stop the clock]--
function SWEP:ThrowStart()
	self:SetCooking(false)
	self:ResetCrosshair()
	
	return BaseClass.ThrowStart(self)
end

--[Ticking timebomb]-- sorry if this is really ugly, its all i could think of
function SWEP:Think2()
	BaseClass.Think2(self)

	local stat = self:GetStatus()
	if self:GetCooking() and stat == TFA.Enum.STATUS_GRENADE_READY then --shrink crosshair
		if self.Shrink <= CurTime() then --not having a curtime loop caused it to be affected by ping (idk why)
			self:SetStatRawL("Primary.SpreadBiasPitch", self:GetStatRawL("Primary.SpreadBiasPitch") / 1.012)
			self:SetStatRawL("Primary.SpreadBiasYaw", self:GetStatRawL("Primary.SpreadBiasYaw") / 1.012)
			self.Shrink = CurTime() + 0.01 --not using networkvar since it looked bad on highping
		end
		
		if self:GetBreathe() <= CurTime() then --reset every 1 second
			self:ResetCrosshair()
			self:SetBreathe(CurTime() + 1)
		end
		
		if self:GetHeldTime() ~= 0 and self:GetHeldTime() <= CurTime() then --kaboom
			self:SelfDefense()
		end
	end
end

--[Shooting w/ heldtime]--
function SWEP:PreSpawnProjectile(ent)
	ent.Cooked = self:GetHeldTime() + 0.1 --here
	return BaseClass.PreSpawnProjectile(ent)
end

--[Reset crosshair]--
function SWEP:ResetCrosshair()
	self:SetStatRawL("Primary.SpreadBiasPitch", 1) --reset to default
	self:SetStatRawL("Primary.SpreadBiasYaw", 1) --reset to default
end

--[Blowup Owner]--
function SWEP:SelfDefense()
	if not self:GetDetonated() then
		ParticleEffect("ww2_m203_explosion", self:GetPos(), Angle( -90, 0, 0 ))
		self:SetDetonated(true)
	end
	util.BlastDamage( self, self.Owner, self:GetPos(), 200, 150 )
	util.ScreenShake(self:GetPos(), 15, 255, 1, 350)
end

--[Speeeeen]--
function SWEP:PostSpawnProjectile(ent)
	if self.ThrowSpin then
		local angvel = Vector(math.random(-2000,-500),math.random(-500,-2000),math.random(-500,-2000)) //The positive z coordinate emulates the spin from a right-handed overhand throw
		angvel:Rotate(-1*ent:EyeAngles())
		angvel:Rotate(Angle(0,self.Owner:EyeAngles().y,0))

		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:AddAngleVelocity(angvel)
		end
	end
end

--[Ammo Pickup Sounds]-- Credit to yurie from crysis 2 sweps
if SERVER then
	function SWEP:OwnerChanged(...)
		if self.Primary.PickupSoundOnDraw then
			if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() then
				local pickupsnd = self:GetStat("Primary.PickupSound")

				if pickupsnd and pickupsnd ~= "" then
					self:EmitSound(pickupsnd)
				end
			end
		end
		return BaseClass.OwnerChanged(self, ...)
	end
	
	function SWEP:EquipAmmo(ply, ...)
		local pickupsnd = self:GetStat("Primary.PickupSound")

		if pickupsnd and pickupsnd ~= "" then
			self:EmitSound(pickupsnd)
		end

		return BaseClass.EquipAmmo(self, ply, ...)
	end
end
