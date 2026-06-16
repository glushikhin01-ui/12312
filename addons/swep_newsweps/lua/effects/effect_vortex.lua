--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

function EFFECT:Init(data)
	local matrix = Matrix()
	matrix:SetAngles(data:GetNormal():Angle())

	local emitter = ParticleEmitter(data:GetOrigin(), false)

	for i = 1, 16 do
		local ang = i * 0.125 * 6.28318530718 + CurTime() * 2

		local vec = matrix * Vector(0, math.cos(ang), math.sin(ang))

		local particle = emitter:Add("effects/blood_puff",data:GetOrigin() + vec * 32)
		particle:SetVelocity(VectorRand() * 64)
		particle:SetColor(100,200,100)
		particle:SetStartSize(15)
		particle:SetDieTime(1)
		particle:SetEndSize(1)
	end

	self:Remove()
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
