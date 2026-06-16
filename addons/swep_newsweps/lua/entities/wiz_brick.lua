--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Brick"
ENT.Category		= "Wizardry"

ENT.Spawnable		= false
ENT.AdminSpawnable 	= false

ENT.Lifetime		= 1.5		--set to zero for infinite lifetime. use for scary homing missiles
ENT.Dietime			= CurTime()
ENT.MyModel			= "models/props_junk/CinderBlock01a.mdl"
ENT.TopSpeed		= 16384

ENT.HasHit			= false
ENT.MyParticleSystem= "nil"		--trail/tracer
ENT.MyTrail			= nil 

function ENT:Initialize()
	if SERVER then
		self.Dietime = CurTime() + self.Lifetime
		self:SetModel(self.MyModel)
		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(false)
		
		self.MyTrail = util.SpriteTrail( 
			self, 							-- parent
			0, 								-- attachment ID
			Color( 200, 100, 50, 250 ), 	-- Color
			true, 								-- force additive rendering
			20, 								-- start width
			0, 								-- end width
			0.5,							-- lifetime
			0.1,								-- texture resulution
			"effects/beam_generic01" 		-- texture
		)
		local phys = self:GetPhysicsObject()
		
		--phys:EnableGravity(false)	
		--phys:EnableDrag(false)	
		phys:AddGameFlag(FVPHYSICS_WAS_THROWN)
		physenv.SetPerformanceSettings(self.TopSpeed)	--Let them fly.
	end
end

function ENT:Think()
	if SERVER then
		if self:IsValid() and self.Lifetime > 0 and self.Dietime <= CurTime() then
			effectdata = EffectData()
			effectdata:SetOrigin(self.Entity:GetPos())
			effectdata:SetEntity(self.Entity)
			util.Effect("entity_remove", effectdata, true, true)
			timer.Simple( 0.12, function() 
				if self:IsValid() then
					self:Remove() 
				end
			end )
		end
	end
end

function ENT:Touch(Other)
	if ( CLIENT ) or self.HasHit then return end
	--this can predict collisions with nonworld entities
end

function ENT:PhysicsCollide(colData, collider)
	if ( CLIENT ) or self.HasHit then return end
	--this happens when we slam into any collider, but includes the world i think
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
