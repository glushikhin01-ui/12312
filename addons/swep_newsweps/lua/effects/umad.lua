--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

include("includes/koxleta_aleksandra_martynasmalec.lua")

local time = 0.3
local time_inv = 1/time

function EFFECT:Init( data )
	self:SetPos(data:GetOrigin())
	self:SetRenderBounds(Vector(-16,-16,-16), Vector(16,16,16))
	self.Normal = data:GetNormal()
	self.LifeTime = CurTime() + time
	self.Scale = data:GetScale()

	local kolxeta = koxlette.GetKoxletaBasedOnNumber(data:GetColor()) // || 1 ratuje przed nilem
	self.Colore = kolxeta[math.random(1, #kolxeta)]
	
	-- particles
	local emitter = ParticleEmitter( self:GetPos() )
	if( emitter ) then
		
		for i = 1, 6 do

			local particle = emitter:Add( "sprites/blueflare1_noz_gmod.vmt", self:GetPos() + self.Normal * 2 )
			particle:SetVelocity( ( self.Normal + VectorRand()):GetNormal() * math.Rand( 75, 125 ) )
			particle:SetDieTime( math.Rand( 3,4 ) )
			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( math.Rand( 0.8,1.5 ) )
			particle:SetEndSize( 0 )
			particle:SetColor(self.Colore:Unpack())
			particle:SetGravity( Vector( 0, 0, -250 ) )
			particle:SetCollide( true )
			
			particle:SetBounce( 0.3 )
			particle:SetAirResistance( 5 )

		end

		emitter:Finish()

	end

	local light = DynamicLight( 0 )
	if( light ) then

		light.Pos = self:GetPos()
		light.Size = 128
		light.Decay = 64
		light.R = self.Colore.r
		light.G = self.Colore.g
		light.B = self.Colore.b
		light.Brightness = 0.1
		light.DieTime = CurTime() + 0.1
	end
end


function EFFECT:Think()
	return self.LifeTime > CurTime()
end

local MaterialGlow		= Material( "sprites/light_glow02_add" )

function EFFECT:Render()
	local xyzman = (self.LifeTime - CurTime()) * time_inv * self.Scale
	render.SetMaterial(MaterialGlow)
	render.DrawQuadEasy(self:GetPos() + self.Normal, self.Normal, 64 * xyzman, 64 * xyzman, self.Colore)
end


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
