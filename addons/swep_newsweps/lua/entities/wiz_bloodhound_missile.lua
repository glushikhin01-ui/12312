--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

--seems fine in singleplayer!

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Bloodhound"
ENT.Category		= "Wizardry"

ENT.Spawnable		= false
ENT.AdminSpawnable 	= false

ENT.Lifetime		= 5		--set to zero for infinite lifetime. use for scary homing missiles
ENT.Dietime			= CurTime()
ENT.MyModel			= "models/hunter/blocks/cube025x025x025.mdl"
ENT.TopSpeed		= 16384

ENT.HasHit			= false
ENT.MyParticleSystem= "bloodhounds_seeker"	--trail/tracer
ENT.MyTrail			= nil 

ENT.TurningCoefficient	= 0.80	--turning speed
ENT.MinTurningCoefficient	= 0.2	--turning speed

ENT.MyTarget		= Entity(0)
ENT.MyTargetVec		= Vector(0, 0, 0)
ENT.ThinkDelay		= 0		--accurancy
ENT.Exploding		= false

ENT.Loopsound1		= nil
ENT.filter			= nil

function ENT:Initialize()
	self.MyTargetVec = self:GetNWVector("Wiz_Targetvec")
	self.MyTarget = self:GetNWEntity("Wiz_Target")
	
	if SERVER then
		sound.Add({
			name = "LoopBloodhound",
			channel = CHAN_STATIC,
			sound = "ambient/machines/machine_whine1.wav",
			level = 350,
		})
		self.filter = RecipientFilter()
		self.filter:AddAllPlayers()
		self.Loopsound1 = CreateSound(self, "LoopBloodhound", self.filter)
		self.Loopsound1:PlayEx(0.25, 60)
		
		self.Dietime = CurTime() + self.Lifetime
		self:SetModel(self.MyModel)
		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		
		self:PhysicsInitSphere(9, "default_silent")
		
		self:DrawShadow(false)
		self:SetNoDraw(true)
		
		local myColor = self.Owner:GetWeaponColor()
		
		--[[
		self.MyTrail = util.SpriteTrail( 
			self, 							-- parent
			0, 								-- attachment ID
			Color(255 * myColor.x, 255 * myColor.y, 255 * myColor.z, 100), 	-- Color
			true, 								-- force additive rendering
			5, 								-- start width
			0, 								-- end width
			0.5,							-- lifetime
			0.1,								-- texture resulution
			"effects/beam_generic01" 		-- texture
		)]]--
		
		local phys = self:GetPhysicsObject()
		
		phys:EnableGravity(false)	
		phys:EnableDrag(false)	
		phys:SetMass(4)
		phys:AddGameFlag(FVPHYSICS_WAS_THROWN, FVPHYSICS_NO_PLAYER_PICKUP)
		physenv.SetPerformanceSettings(self.TopSpeed)	--Let them fly.
		
		self:NextThink(CurTime() + self.ThinkDelay)
	end
	ParticleEffectAttach(self.MyParticleSystem, PATTACH_ABSORIGIN_FOLLOW, self, 0)
	
end

function ENT:LookForCenter(tgt)
	local bone = tgt:LookupBone("ValveBiped.Bip01_Spine1")
	local tarPos =  tgt:GetPos()
	if tgt:GetClass() == "npc_fastzombie" then
		tarPos = tgt:GetBonePosition( 13 )
	elseif bone == nil then
		tarPos = tgt:GetBonePosition( 0 )
		
		if tarPos == nil then
			tarPos = tgt:GetPos()
		end
	else
		tarPos = tgt:GetBonePosition( bone )
	end
	return tarPos
end

function ENT:Think()
	if self.Loopsound1 != nil then
		self.Loopsound1:ChangePitch(self.Loopsound1:GetPitch() * 1.007)	--pitch rise with lifetime
	end	

	if SERVER then
		local phys = self:GetPhysicsObject()
		local localOrigin = self:GetPos()
		local speed = self:GetVelocity():Length()
		local currentHeading = self:GetVelocity()
		local tgtOrigin = Vector()
		
		if !self.Exploding and !self.MyTarget:IsWorld() and self.MyTarget:IsValid() then
			tgtOrigin = self:LookForCenter(self.MyTarget)
		elseif !self.Exploding and self.MyTarget:IsWorld() and !self.MyTarget:IsValid() then
			tgtOrigin = Vector(self.MyTargetVec.x, self.MyTargetVec.y, self.MyTargetVec.z)
		elseif !self.Exploding and !self.MyTarget:IsValid() then
			tgtOrigin = nil
		end
		if tgtOrigin != nil then
			local targetHeading = (tgtOrigin - localOrigin)
			tgtWeight = math.abs(self.TurningCoefficient - 1)
			oriWeight = self.TurningCoefficient
			if self.TurningCoefficient > self.MinTurningCoefficient then
				self.TurningCoefficient = self.TurningCoefficient - 0.0020
			elseif self.TurningCoefficient < self.MinTurningCoefficient then
				self.TurningCoefficient = self.MinTurningCoefficient
			end
			currentHeading = currentHeading * oriWeight + targetHeading * tgtWeight
			currentHeading = currentHeading:GetNormalized() * speed * 1.028
			
			phys:SetVelocityInstantaneous(currentHeading)
		end
		
		if (self:IsValid() and self.Lifetime > 0 and self.Dietime <= CurTime()) then
			if self.Loopsound1 != nil then
				self.Loopsound1:Stop()
			end			
			self:Remove()
			self:EmitDissipate()
		end
		self:NextThink(CurTime() + self.ThinkDelay)
		return true
	end
end

function ENT:PhysicsCollide( data, phy )
	if data.HitEntity:GetClass() == "wiz_bloodhound_missile" then return end
	
	if !data.HitEntity:IsWorld() then
		self:Splode(data.HitEntity)
	else self:Decay() end
end

function ENT:OnTakeDamage( CTakeDamageInfo )
	self:Splode(game.GetWorld())
	return true
end

function ENT:EmitImpact()
	effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect("BloodImpact", effectdata)
	ParticleEffect("bloodhounds_impact", self:GetPos(), self:GetVelocity():Angle())
	self:EmitSound("physics/flesh/flesh_squishy_impact_hard"..tostring(math.random(1,4))..".wav", 85, math.random(90, 110), 0.4)
end

function ENT:EmitDissipate()
	ParticleEffect("bloodhounds_impact_glow", self:GetPos(), self:GetVelocity():Angle())
end

function ENT:Splode(enty)
	if self.Exploding then return end
	self:EmitImpact()
	if self.Loopsound1 != nil then
		self.Loopsound1:Stop()
	end			

	self.Exploding = true
	
	if enty:IsValid() and !enty:IsWorld() and (enty:IsNPC() or enty:IsPlayer()) then
	
		enty:EmitSound("npc/manhack/grind_flesh"..tostring(math.random(1,3))..".wav", 85, math.random(90, 110), 0.3)
		
		if ( SERVER ) then
			local dmginfo = DamageInfo()
			dmginfo:SetAttacker(self.Owner)
			dmginfo:SetInflictor(self)
			dmginfo:SetDamage(30)
			dmginfo:SetDamageType(DMG_SLASH)
			enty:TakeDamageInfo(dmginfo)
			
			self:Remove()
		end
	end
	if ( SERVER ) then self:Remove() end
end

function ENT:Decay()
	if self.Exploding then return end
	local phys = self:GetPhysicsObject()
	phys:SetVelocityInstantaneous(Vector(0, 0, 0))
	self.Exploded = true
	self:StopParticles()
	self:EmitImpact()
	
	timer.Simple(FrameTime(),function()
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)
		if ( SERVER ) then self:Remove() end
	end)
	
	self.Dietime = self.Dietime - self.Lifetime/2
	
	if self.Loopsound1 != nil then
		self.Loopsound1:Stop()
	end			

	self.Exploding = true
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
