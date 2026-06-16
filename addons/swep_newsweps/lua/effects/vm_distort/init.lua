--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()	
	self.Speed = data:GetMagnitude()
	self.Ent = data:GetEntity()

	self.Speed = self.Speed-0

	local emitter = ParticleEmitter(self.Position)
	self.particle = emitter:Add("Effects/strider_pinch_dudv", self.Position)

	self.particle:SetVelocity(Vector( 0, 0, 0))
	self.particle:SetAngleVelocity(Angle(7,0,0))
	self.particle:SetDieTime(1)
	self.particle:SetStartAlpha(255)
	self.particle:SetEndAlpha(255)
	self.particle:SetStartSize(5)
	self.particle:SetEndSize(75)
	emitter:Finish()
end

function EFFECT:Render()
end

function EFFECT:Think()
	return true
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
