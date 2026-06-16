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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.DefaultModel = Model("models/weapons/w_eq_fraggrenade.mdl")
ENT.Delay = 3
ENT.Ammo = 1

function ENT:Initialize()
	local mdl = "models/weapons/tfa_codww2/usa_healthpack/w_usa_healthpack.mdl"

	self:SetModel(mdl)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
	
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetFriction(self.Delay)
	self:DrawShadow(true)
end

function ENT:Use(activator, caller)
	if CLIENT then return end
	if IsValid(activator) and activator:IsPlayer() then
		activator:Give("tfa_codww2k_healthkit", true)
		activator:GiveAmmo(self.Ammo, "Battery", false)
		activator:EmitSound("TFA_CODWW2_HEALTHPACK.Pickup")
		self:Remove()
	end
end
