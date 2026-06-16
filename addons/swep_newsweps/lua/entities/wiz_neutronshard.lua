--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

--seems functional in singleplayer!

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Dying Neutron Star"
ENT.Category		= "Wizardry"

ENT.Spawnable		= false
ENT.AdminSpawnable 	= false

ENT.Lifetime		= 2		--set to zero for infinite lifetime. use for scary homing missiles
ENT.Dietime			= CurTime()
ENT.MyModel			= "models/hunter/blocks/cube05x05x05.mdl"	--something else
ENT.TopSpeed		= 10000

ENT.Exploded		= false
ENT.HasBurst		= false
ENT.MyParticleSystem= "neutron_star"		--trail/tracer
ENT.MyTrail			= nil 

ENT.Loopsound1		= nil
ENT.Loopsound2		= nil
ENT.Loopsound3		= nil
ENT.Loopsound4		= nil

function ENT:Initialize()
	self.Dietime = CurTime() + self.Lifetime
	
	if SERVER then
		filter = RecipientFilter()
		filter:AddAllPlayers()
		--screech
		sound.Add({
			name = "NeutronLoop1",
			sound = "npc/combine_gunship/dropship_onground_loop1.wav",
			channel = CHAN_STATIC,
			level = 380,
		})
		self.Loopsound1 = CreateSound(self, "NeutronLoop1", filter)
		self.Loopsound1:PlayEx(1, 120)		
		--bass layers
		sound.Add({
			name = "NeutronLoop2",
			sound = "npc/combine_gunship/gunship_engine_loop3.wav",
			channel = CHAN_STATIC,
			level = 400,
		})
		self.Loopsound2 = CreateSound(self, "NeutronLoop2", filter)
		self.Loopsound2:Play()		
		sound.Add({
			name = "NeutronLoop3",
			sound = "npc/scanner/cbot_fly_loop.wav",
			channel = CHAN_STATIC,
			level = 500,
		})
		self.Loopsound3 = CreateSound(self, "NeutronLoop3", filter)
		self.Loopsound3:Play()		
		--danger close sound
		sound.Add({
			name = "NeutronLoop4",
			sound = "npc/manhack/mh_engine_loop2.wav",
			channel = CHAN_STATIC,
			level = 350,
		})
		self.Loopsound4 = CreateSound(self, "NeutronLoop4", filter)
		self.Loopsound4:PlayEx(1, 80)
		
		self:SetModel(self.MyModel)
		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(false)
		self:SetNoDraw(true)
		
		
		local phys = self:GetPhysicsObject()
		
		phys:EnableGravity(false)	
		phys:EnableDrag(true)	
		phys:SetDragCoefficient(0.3)
		phys:AddGameFlag(FVPHYSICS_WAS_THROWN)
		physenv.SetPerformanceSettings(self.TopSpeed)	--Let them fly.
	end
	ParticleEffectAttach(self.MyParticleSystem, PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:Think()

	local function ShakeScreen()
		local screenshake = ents.Create("env_shake")
		screenshake:SetKeyValue("amplitude", 1000)
		screenshake:SetKeyValue("duration", 2)
		screenshake:SetKeyValue("radius", 400)
		screenshake:SetKeyValue("frequency", 255)
		screenshake:Spawn()
		screenshake:SetPos(self:GetPos())
		screenshake:Activate()
		screenshake:Fire("StartShake", "", 0)
		screenshake:Fire("Kill","",0)
	end
	local function ShakeGlobal()
		local screenshake = ents.Create("env_shake")
		screenshake:SetKeyValue("amplitude", 1000)
		screenshake:SetKeyValue("duration", 2)
		screenshake:SetKeyValue("radius", 600)
		screenshake:SetKeyValue("spawnflags", "4, 8, 16")
		screenshake:SetKeyValue("frequency", 255)
		screenshake:Spawn()
		screenshake:SetPos(self:GetPos())
		screenshake:Activate()
		screenshake:Fire("StartShake", "", 0)
		screenshake:Fire("Kill","",0)
	end	

	if self.Loopsound1 != nil then
		self.Loopsound1:ChangePitch(self.Loopsound1:GetPitch() * 0.985)
	end	
	if self.Loopsound4 != nil then
		self.Loopsound4:ChangePitch(self.Loopsound4:GetPitch() * 1.055)
	end

	if self:IsValid() and self.Lifetime > 0 and self.Dietime <= CurTime() then
		if !self.HasBurst then
			if SERVER then
				self:EmitSound("common/warning.wav", 460, 100, 1, CHAN_STATIC)
				self:EmitSound("npc/scanner/combat_scan3.wav", 460, 100, 0.5, CHAN_STATIC)
			end
			if self.Loopsound1 != nil then
				self.Loopsound1:Stop()
			end			
			if self.Loopsound2 != nil then
				self.Loopsound2:FadeOut(0.2)
			end			
			if self.Loopsound3 != nil then
				self.Loopsound3:FadeOut(0.2)
			end			
			if self.Loopsound4 != nil then
				self.Loopsound4:Stop()
			end
					
			timer.Simple(0.4,function()
				self.Exploded = true
			end)
			if SERVER then
				local blastrad = 750
				timer.Simple(0.5,function()
					for i = 1, 65 do
						ShakeScreen()
					end
					for i = 1, 4 do
						ShakeGlobal()
					end
					self:EmitSound("ambient/explosions/citadel_end_explosion2.wav", 500, 100, 1, CHAN_STATIC)
					self:EmitSound("ambient/explosions/exp2.wav", 500, 100, 1, CHAN_STATIC)
					self:EmitSound("ambient/explosions/exp3.wav", 500, 100, 1, CHAN_STATIC)
					ParticleEffect("star_explosion_pulsar", self:GetPos(), Angle(0, 0, 0))
					local dmgInfo = DamageInfo()
					dmgInfo:SetAttacker(self.Owner)
					dmgInfo:SetInflictor(self)
					dmgInfo:SetDamage(1500)
					dmgInfo:SetMaxDamage(1500)
					dmgInfo:SetDamageType(DMG_MISSILEDEFENSE + DMG_SHOCK + DMG_BLAST)
					
					--main hit damage
					util.BlastDamageInfo(dmgInfo, self:GetPos(), blastrad)
				end)
				
				local phys = self:GetPhysicsObject()
				phys:SetVelocity(Vector(0, 0, 0))
				self:SetSolid(SOLID_NONE)	
				ParticleEffect("star_explosion", self:GetPos(), Angle(0, 0, 0))
				
				timer.Simple(5, function() 
					if self:IsValid() then
						self:Remove() 
					end
				end)
			end

			self.HasBurst = true
		end
		if self.Exploded then
			if CLIENT then
				timer.Simple(0.5,function()
					if self:IsValid() then
						local remaininglifeinseconds = self.Dietime - CurTime()
						local dlight = DynamicLight( self:EntIndex(), false)
						if dlight then
							local c = Color(255, 25, 225)

							local size = 10000 / math.max(math.abs(remaininglifeinseconds * 4), 1)
							local brght = 9
							
							dlight.Pos = self:GetPos()
							dlight.r = c.r
							dlight.g = c.g
							dlight.b = c.b 
							dlight.Brightness = brght
							dlight.Decay = size * 10
							dlight.Size = size
							dlight.DieTime = CurTime() + 0.1
						end
					end
				end)
			end
		end
	elseif CLIENT then
		local remaininglifeinseconds = self.Dietime - CurTime()
		local dlight = DynamicLight( self:EntIndex(), false)
		if dlight then
			local c = Color(255, 50, 255)

			local size = 4000 / remaininglifeinseconds
			local brght = 3
			
			dlight.Pos = self:GetPos()
			dlight.r = c.r / math.max(remaininglifeinseconds, 1)
			dlight.g = c.g / math.max(remaininglifeinseconds, 1)
			dlight.b = c.b - (200 / math.max(remaininglifeinseconds, 1))
			dlight.Brightness = brght
			dlight.Decay = size * 5
			dlight.Size = size
			dlight.Style = 6
			dlight.DieTime = CurTime() + 0.1
		end
	end
end

function ENT:Touch(Other)
	if ( CLIENT ) or self.HasHit then return end
	--this can predict collisions with nonworld entities
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
