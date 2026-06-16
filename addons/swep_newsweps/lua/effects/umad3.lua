--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

local MaterialGlow		= Material( "sprites/light_glow02_add" )

local time = 0.5
local timeinv = 1/time

include("includes/koxleta_aleksandra_martynasmalec.lua")

function EFFECT:Init( data )

	self.Position = data:GetOrigin()
	self.Normal = data:GetNormal()
	self.LifeTime = CurTime() + time

	if data:GetFlags() < 1 then
		self.Normal = Vector(0,0,0)
	end

	local kolxeta = koxlette.GetKoxletaBasedOnNumber(data:GetColor())
	self.Colore = kolxeta[math.random(1, #kolxeta)]

	local BRIGHT_DEFINE_ELO = 2
	self.Colore2 = Color(self.Colore.r * BRIGHT_DEFINE_ELO + 50, self.Colore.g * BRIGHT_DEFINE_ELO + 50, self.Colore.b * BRIGHT_DEFINE_ELO + 50)
	-- particles no co ty kurwa nie powiesz
		
	for i = 1,40 do
		local normal = ( self.Normal * 3 + VectorRand()):GetNormal()

		local ef = EffectData()
		ef:SetOrigin(self:GetPos() + normal * 10)
		ef:SetNormal(normal)
		ef:SetMagnitude(math.random(100, 200))

		util.Effect("silverethernet2021", ef)
	end

	self.Particles = {}
	for i = 1, 100 do
		local normal = ( self.Normal * 0.5 + VectorRand()):GetNormal() * math.random(100, 200) * 3
		self.Particles[i] = {
			pos = normal,
			size = bit.band(i * 100010717, 15) + 16,
			color = Either(bit.band(i * 100010717, 31) > 16, self.Colore, self.Colore2)
		}
	end
	
	local light = DynamicLight( 0 )
	if( light ) then

		light.Pos = self.Position
		light.Size = 128
		light.Decay = 156
		light.R = self.Colore.r
		light.G = self.Colore.g
		light.B = self.Colore.b
		light.Brightness = 3
		light.DieTime = CurTime() + time
	end
end


function EFFECT:Think()
	return self.LifeTime > CurTime()
end

function EFFECT:Render()
	local normaltime = (self.LifeTime - CurTime()) * timeinv
	local coisine = normaltime * normaltime

	local sinus = math.sin(normaltime * 3.14159265)

	render.SetMaterial(MaterialGlow)
	render.DrawSprite(self:GetPos(),512 * coisine, 512 * coisine,self.Colore)

	local sizemul = 1-normaltime
	for k, v in ipairs(self.Particles) do
		render.DrawSprite(self:GetPos() + v.pos * sizemul, v.size * coisine, v.size * coisine, v.color)
	end
end


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
