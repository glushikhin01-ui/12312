--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:Initialize()
	self.UsedCrateCount = 0
end

function ENT:Think()
	local used = self:GetUsedCrateCount()
	if self.UsedCrateCount ~= used then
		self:EmitSound("zck_snowball_pickup")
		ParticleEffect("zck_snowball_pickup", self:GetPos() + self:GetUp() * 15, Angle(0, 0, 0), NULL)
		self.UsedCrateCount = used
	end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
