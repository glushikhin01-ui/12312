--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

function EFFECT:Init( data )
	self.Position = data:GetOrigin()
	self.Entity = data:GetEntity()

	self.LifeTime = CurTime() + 0.1

	ParticleEffectAttach( "wiz_suite_hit", PATTACH_ABSORIGIN_FOLLOW, self.Entity, 0 ) 
end

function EFFECT:Think()
	return ( self.LifeTime > CurTime() ) 
end

function EFFECT:Render()
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
