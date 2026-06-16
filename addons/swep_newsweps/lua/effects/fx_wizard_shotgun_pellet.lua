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

function EFFECT:Init( data )
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	-- Keep the start and end pos - we're going to interpolate between them
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()
	self.LifeTime = 0.5

	self.LifeTime = CurTime() + self.LifeTime
end

function EFFECT:Think()

	if ( !self.ParticleCast ) then
		util.ParticleTracerEx( 
			"wizard_shotgun_pellet", 	--particle system
			self.StartPos, 	--startpos
			self.EndPos, 	--endpos
			true, 			--do whiz effect
			-1, 			--entity index
			-1  			--attachment
		)
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
