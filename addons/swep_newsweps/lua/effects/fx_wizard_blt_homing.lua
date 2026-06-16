--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

--thank you to garry's mod for being open source. this saved me a headache
AddCSLuaFile()
AddCSLuaFile( "effects/fx_wizard_base.lua" )
include( "effects/fx_wizard_base.lua" )

EFFECT.ParticleCast = false

--demand a 
--Normal,
--Origin,
--Start

function EFFECT:Init( data )
	self.Position = data:GetStart()
	self.EndPos = data:GetOrigin()
	self.Normal = data:GetNormal()
	
	self.LifeTime = 0.5

	self.LifeTime = CurTime() + self.LifeTime
end

function EFFECT:Think()

	if ( !self.ParticleCast ) then
		self.MyTracer = CreateParticleSystem( 
			self, 
			"wizard_blt_homing", 
			0, 
			0, 
			Vector( 0, 0, 0 ) 
		)

		self.MyTracer:SetControlPoint(0, self.Position)
		self.MyTracer:SetControlPointForwardVector(0, self.Normal:GetNormalized())
		self.MyTracer:SetControlPoint(1, self.EndPos)
		self.ParticleCast = true
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
