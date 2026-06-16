
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
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Fire"

--[Parameters]--
ENT.Delay = 0.4

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar("Angle", 0, "Roll")
end

local x = Vector(4,4,4)
function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()

	if GetConVarNumber("developer") > 0 then
		render.DrawWireframeBox(self:GetPos(), self:GetAngles(), x, -x, color_white, false ) -- draws the box 
	end
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		util.Decal("Dark", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)
	end
	self:SetNW2Bool("Impacted", true)
	local Velocity = data.OurOldVelocity
	self:SetRoll(Velocity:Angle())
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)
	
	self:SetRoll(self:GetAngles())
	self:DrawShadow(false)
	self:SetMaterial("null.vmt")
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	
	self.killtime = CurTime() + self.Delay

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(true)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	if CLIENT then return end
	self:SetTrigger(true)
end

local drawdlight = GetConVar("cl_tfa_codww2k_dlights")

function ENT:Think()
	if CLIENT and drawdlight:GetBool() then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.dir = self:GetPos()
			dlight.r = 235
			dlight.g = 75
			dlight.b = 15
			dlight.brightness = 1
			dlight.Decay = 2000
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.2
		end
	end
	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
		if not self:IsInWorld() then
			self:Remove()
		end
		local phys = self:GetPhysicsObject()
		if IsValid(phys) and self:GetNW2Bool("Impacted") then
			phys:SetVelocity(phys:GetVelocity()*0.88)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:StartTouch(ent)
	if !ent:IsWorld() and self:Visible(ent) then
		if ent == self:GetOwner() then return end
		if not IsValid(self.Inflictor) then self.Inflictor = self end
		self.Damage = self.mydamage or self.Damage
		damage = DamageInfo()
		damage:SetDamage(self.Damage)
		damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
		damage:SetInflictor(self.Inflictor)
		damage:SetDamageType(bit.bor(DMG_BURN, DMG_AIRBOAT))
		ent:TakeDamageInfo(damage)
		ent:Ignite(3)
	end
end
