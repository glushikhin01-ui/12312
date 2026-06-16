--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

function EFFECT:Init( data )
self.Position = data:GetOrigin()

local pos = self.Position
local Emi = ParticleEmitter(pos)

for i=1,math.random(3,6) do
		local particle = Emi:Add("particle/particle_smokegrenade", pos)
		particle:SetVelocity(Vector(math.Rand(-4,4),math.Rand(-4,4),math.Rand(2,4))*math.random(5,10))
		particle:SetDieTime(math.Rand(4,6))
		particle:SetStartAlpha(math.Rand(140,200))
		particle:SetStartSize(math.Rand(10,15))
		particle:SetEndSize(20)
		particle:SetColor(255,255,255)
		particle:SetAirResistance(500)
		particle:SetRoll(math.Rand(150,180))
        particle:SetRollDelta(math.Rand(-1.6,1.6))
		particle:SetAirResistance(1)
		particle:SetGravity(Vector(0,0,math.random(-100,-50)))
end		
Emi:Finish()
end
	
function EFFECT:Think( )
return false
end
   
function EFFECT:Render()
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
