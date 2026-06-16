--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

function EFFECT:Init( data )
	
	self.Position = data:GetOrigin()	
	self.Speed = data:GetMagnitude()

	self.Speed = self.Speed-0

	local emitter = ParticleEmitter(self.Position)
	local particle = emitter:Add("Effects/strider_pinch_dudv", self.Position)

	particle:SetVelocity(Vector( 0, 0, 0))
	particle:SetAngleVelocity(Angle(-7,0,0))
	particle:SetDieTime(1.25)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(255)
	particle:SetStartSize(75)
	particle:SetEndSize(5)
	emitter:Finish()
end

function EFFECT:Render()
end

function EFFECT:Think()
	return false	
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
