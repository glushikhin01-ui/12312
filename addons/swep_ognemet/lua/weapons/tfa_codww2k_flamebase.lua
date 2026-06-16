
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

--[Flamethrower]-- (credit to Mac & TFA)
DEFINE_BASECLASS("tfa_codww2k_base")

local ammoregen = GetConVar("sv_tfa_codww2k_flamethrower_regen")
local regendelay = GetConVar("sv_tfa_codww2k_flamethrower_regendelay")
local regendelayPaP = GetConVar("sv_tfa_codww2k_flamethrower_regendelayPaP")

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	
	self:NetworkVarTFA("Bool", "HasShot")
	self:NetworkVarTFA("Float", "NextAmmo")
	self:NetworkVarTFA("Float", "MaxAmmo")
end

function SWEP:PrimaryAttack(...)
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	local tr = util.QuickTrace(ply:GetShootPos(), ply:EyeAngles():Forward()*38, ply)
	if ply:IsPlayer() and tr.HitWorld then
	return end
	return BaseClass.PrimaryAttack(self, ...)
end

function SWEP:Initialize()
	BaseClass.Initialize(self)
	
	if engine.ActiveGamemode() == "nzombies" then
		self.StatCache_Blacklist["Primary.Damage"] = true
		self.Primary_TFA.Damage = 100
		self.Primary.Damage = 100
	end
	
	if ammoregen:GetBool() then
		self:SetNextAmmo(0)
		if engine.ActiveGamemode() == "nzombies" then
			self:SetMaxAmmo(self.Primary.MaxAmmo)
		else
			self:SetMaxAmmo(self.Primary.DefaultClip)
		end
	end
end

function SWEP:PostPrimaryAttack(...)
	if engine.ActiveGamemode() == "nzombies" or ammoregen:GetBool() then
		self:SetNextAmmo(CurTime() + 0.66)
	end
	
	return BaseClass.PostPrimaryAttack(self, ...)
end

function SWEP:Think2( ... )
	local stat = self:GetStatus()
	
	-- initial ignite sound, loopsounds dont play the base fire sadly so i had to come up with this hack-job
	if self:VMIV() and self:GetOwner():IsPlayer() then
		if stat == TFA.Enum.STATUS_SHOOTING and not self:GetHasShot() then
			if IsFirstTimePredicted() then
				self:EmitSound("TFA_CODWW2_M2FT.Start")
			end
			self:SetHasShot(true)
		elseif stat ~= TFA.Enum.STATUS_SHOOTING and self:GetHasShot() then
			self:SetHasShot(false)
		end
	end
	
	if engine.ActiveGamemode() == "nzombies" or ammoregen:GetBool() then
		-- npc compatibility
		if self:GetOwner():IsPlayer() then
		
			-- dont let ammo go over max
			if self:Ammo1() > self:GetMaxAmmo() then
				self:GetOwner():SetAmmo(math.Clamp(self:Ammo1(), 0, self:GetMaxAmmo()), self:GetPrimaryAmmoType(), true)
			end
			
			-- if idle and not shooting give +1 ammo, praying this is predicted and wont fall apart in mp
			if TFA.Enum.ReadyStatus[self:GetStatus()] and stat ~= TFA.Enum.STATUS_SHOOTING and self:Ammo1() < self:GetMaxAmmo() then
				if self:GetNextAmmo() ~= 0 and self:GetNextAmmo() < CurTime() then
					self:GetOwner():SetAmmo(math.Clamp(self:Ammo1() + 1, 0, self:GetMaxAmmo()), self:GetPrimaryAmmoType(), true)
					if self.Ispackapunched then
						self:SetNextAmmo(CurTime() + regendelayPaP:GetFloat())
					else
						self:SetNextAmmo(CurTime() + regendelay:GetFloat())
					end
				end
				if self:Ammo1() == self:GetMaxAmmo() and self:GetNextAmmo() > CurTime() then
					if IsFirstTimePredicted() then
						self:EmitSoundNet("TFA_CODWW2_SMOKE.GasOn")
					end
				end
			end
		end
	end
	
	return BaseClass.Think2(self,...)
end

function SWEP:PostSpawnProjectile(ent)
	local aimcone = 4
	local dir
	local ang = self:GetOwner():GetAimVector():Angle()
	ang:RotateAroundAxis(ang:Right(), -aimcone / 2 + math.Rand(0, aimcone))
	ang:RotateAroundAxis(ang:Up(), -aimcone / 2 + math.Rand(0, aimcone))
	dir = ang:Forward()
	
	ent:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
	local phys = ent:GetPhysicsObject()

	if IsValid(phys) then
		phys:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
	end
end



--[[
function SWEP:ImpactEffectFunc() return true end

local range
local bul = {}
local function cb( a, b, c )
	if b.HitPos:Distance( a:GetShootPos() ) > range then return end
	c:SetDamageType(DMG_BURN)
	if IsValid(b.Entity) and b.Entity.Ignite and not b.Entity:IsWorld() then
		b.Entity:Ignite( 5, 8 )
	end
end

function SWEP:ShootBullet()
	bul.Attacker = self.Owner
	bul.Distance = self.Primary.Range
	bul.HullSize = self.Primary.HullSize
	bul.Num = 1
	bul.Damage = self.Primary.Damage
	bul.Distance = self.Primary.Range
	bul.Tracer = 0
	bul.Callback = cb
	bul.Src = self.Owner:GetShootPos()
	bul.Dir = self.Owner:GetAimVector()
	range = bul.Distance
	self.Owner:FireBullets(bul)
end]]--