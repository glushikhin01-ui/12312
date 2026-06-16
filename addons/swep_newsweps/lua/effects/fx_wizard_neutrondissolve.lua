--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

function EFFECT:Init( data )
	self.Position = data:GetOrigin()
	self.Entity = data:GetEntity()
	self.BaseLifeTime = data:GetMagnitude()

	self.LifeTime = CurTime() + self.BaseLifeTime

	ParticleEffectAttach( "neutron_dissolution_dust", PATTACH_ABSORIGIN_FOLLOW, self.Entity, 0 ) 
end

function EFFECT:Think()
	self.LifeLeftPct = (self.LifeTime - CurTime()) / self.BaseLifeTime

	if self.Entity:IsValid() then 
		self.Entity:SetColor(Color(160 * self.LifeLeftPct, 40 * self.LifeLeftPct, 110 * self.LifeLeftPct, 500 * self.LifeLeftPct))
	end
	return ( self.LifeTime > CurTime() ) 
end

function EFFECT:Render()
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
