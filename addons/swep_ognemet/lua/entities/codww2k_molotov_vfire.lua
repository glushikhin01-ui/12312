
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

AddCSLuaFile()

--[Info]--
ENT.Base = "codww2k_molotov"
ENT.PrintName = "Contact Explosive"
ENT.HasTrail = true 

--[Sounds]--
ENT.BounceSound = Sound("TFA_CODWW2_MOLOTOV.Bounce")
ENT.LoopSound = Sound("TFA_CODWW2_MOLOTOV.Loop")
ENT.ShatterSound = Sound("TFA_CODWW2_MOLOTOV.Shatter")
ENT.ExplodeSound = Sound("TFA_CODWW2_MOLOTOV.Explode")
ENT.FizzleSound = Sound("TFA_CODWW2_MOLOTOV.End")

--[Parameters]--
ENT.Impacted = false
ENT.IsDetonated = false
ENT.TriggerSphere = false

DEFINE_BASECLASS(ENT.Base)

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	if self.HasTrail then
		self:CreateRocketTrail()
	end
end

local drawdlight = GetConVar("cl_tfa_codww2k_dlights")

function ENT:Think()
	local ply = self:GetOwner()
	-- Don't use dlight, vFire has its own dlight
	-- if CLIENT and self:GetNW2Bool("Impacted") and drawdlight:GetBool() then
	-- 	local dlight = DynamicLight(self:EntIndex())
	-- 	if (dlight) then
	-- 		dlight.pos = self:GetPos()
	-- 		dlight.dir = self:GetPos()
	-- 		dlight.r = 235
	-- 		dlight.g = 75
	-- 		dlight.b = 15
	-- 		dlight.brightness = 3
	-- 		dlight.Decay = 200
	-- 		dlight.Size = 400
	-- 		dlight.DieTime = CurTime() + 1
	-- 	end
	-- end
	if SERVER then
		if self:WaterLevel() > 0 then
			self:Remove()
			return false
		end

		if self:GetNW2Bool("TriggerSphere") then
			if not IsValid(self.Inflictor) then
				self.Inflictor = self
			end

			local tr = {
				start = self:GetPos(),
				filter = self,
				mask = MASK_SHOT_HULL
			}

			for k, v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
				if v:IsPlayer() or v:IsNPC() or v:IsNextBot() or v:IsVehicle() then
					tr.endpos = v:WorldSpaceCenter()
					local tr1 = util.TraceLine(tr)
					if tr1.HitWorld then continue end

					if v:GetPos():DistToSqr(self:GetPos()) < 150^2 then
						-- damage = DamageInfo()
						-- damage:SetDamage(math.random( 15, 22 ))
						-- damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
						-- damage:SetInflictor(self.Inflictor)
						-- damage:SetDamageType(DMG_BURN)
						-- v:TakeDamageInfo(damage)
						v:Ignite(5)
						local vel = self:GetUp() 
						local rad = 50
						local life = 1
						--CreateVFireEntFires(v, 30)
						-- for burningEnt, sameEnt in pairs (vFireGetBurningEntities()) do print(burningEnt) end
						CreateVFireBall(life, rad, self:GetPos() + (self:GetForward() * VectorRand() * rad) + (self:GetRight() * VectorRand() * rad), vel, self:GetOwner() or self.Owner or self)
					end
				end
			end
		end
	end
	
	if not self:GetNW2Bool("Impacted") then
		self:NextThink(CurTime())
	else
		self:NextThink( CurTime() + math.Rand( 0.2, 0.3 ) )
	end
	return true
end

function ENT:DoExplosionEffect()
	self:EmitSound(self.LoopSound)
	--ParticleEffect("ww2_molotov_explosion", self:GetPos(), Angle(-90,0,0))
end

function ENT:Explode()
	if not self:GetNW2Bool("TriggerSphere", false) then
		self:EmitSound(self.ShatterSound)
		self:EmitSound(self.ExplodeSound)
		self:SetNW2Bool("TriggerSphere", true)
		self:DoExplosionEffect()
	end
	
	if not IsValid(self.Inflictor) then
		self.Inflictor = self
	end
	-- local dmg = DamageInfo()
	-- dmg:SetInflictor(self.Inflictor)
	-- dmg:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	-- dmg:SetDamage(60)
	-- dmg:SetDamageType(bit.bor(DMG_BURN, DMG_SLOWBURN))
	-- util.BlastDamageInfo(dmg, self:GetPos(), 150)

	SafeRemoveEntityDelayed(self,20) --removal of nade

	-- print(self:BoundingRadius())
	local rad = 60

	local vel = self:GetUp() 
	local life = math.Rand(2, 4) * 3
	for i=1,25 do
		CreateVFireBall(life, rad, self:GetPos() + (self:GetForward() * VectorRand() * rad) + (self:GetRight() * VectorRand() * rad), vel, self:GetOwner() or self.Owner or self)
	end

	if CLIENT then
		CreateVFireExplosionEffect(self:GetPos(), 10)
	end
end