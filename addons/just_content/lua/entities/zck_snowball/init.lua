--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(true)
	end
end

function ENT:PhysicsCollide(data, phys)
	if IsValid(data.HitEntity) and data.HitEntity:IsPlayer() and data.HitEntity:Alive() then
		data.HitEntity:TakeDamage(zck.config.Swep.damage, self.Owner, self)
	end

	self:Explode()
end

function ENT:Explode()
	if vFireInstalled then
		for k, ent in pairs(ents.FindInSphere(self:GetPos(),100)) do
			ent:Extinguish()
		end
	end
	SafeRemoveEntityDelayed(self, 0.1)
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
