--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Fart"
ENT.Spawnable = false
ENT.Category = "Frasiu's R&D"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
AccessorFunc( ENT, "m_iClass", "NPCClass" )

if (SERVER) then
	function ENT:Initialize() 
		
		self:SetModel("models/props_lab/huladoll.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		self:SetNoDraw(true)
		self:EmitSound("vmaxgun/44k/rocketfart_fly_loop.wav")
		self.InflictionTimer = 0
		self.Owner = self:GetOwner()
		
		self:Fire("Kill", "", 15)
		self:EmitSound("hilarious/44k/fart.wav")
		
		local waking = self:GetPhysicsObject()
	    if waking:IsValid() then
	        waking:Wake()
	        waking:EnableGravity(false)
	    end
	end


	function ENT:Think()
		for k,v in pairs(ents.FindInSphere(self:GetPos(),50)) do
			--print(v:GetClass())
			
			if IsValid(v:GetPhysicsObject()) && string.find(v:GetClass(),"prop") != nil then
		    		v:GetPhysicsObject():SetVelocity(self:GetVelocity())
		    end
			
			if v:GetClass() == "player" && v != self:GetOwner() then
		    	local pos1 = self:GetPos()
		    	local pos2 = v:GetPos()
		    	local lerped = LerpVector(0.2, pos2, pos1)
		    	v:SetPos(lerped - Vector(0,0,0))
		    end
		end
		
		if self.InflictionTimer < CurTime() then
			self.InflictionTimer = CurTime() + 0.8
			
			for k,v in pairs(ents.FindInSphere(self:GetPos(),250)) do
				--print(v)

				if v:IsPlayer() && v != self:GetOwner() then
					
					v:ViewPunch( Angle( math.random(-10,10), math.random(-10,10), math.random(-10,10) ) )
					v:TakeDamage(8,self,self)
					if math.random(1,10) == 1 then 
						
						v:EmitSound("ambient/voices/cough"..math.random(1,4)..".wav")
					end
				elseif v:IsNPC() then
					v:TakeDamage(8,self,self)
				end
			end
		end
	self:NextThink(CurTime() + 0.01) return true
	end
end

if (CLIENT) then
	function ENT:Initialize()
		self.CloudTime = 0
	end
	
	function ENT:Think()
		
		if self.CloudTime < CurTime() then
			
			local emitter = ParticleEmitter(self:GetPos(), false)
			
			for i = 1, math.random(2,5) do


				local particle = emitter:Add("effects/blood_puff",self:GetPos())
				particle:SetVelocity(VectorRand() * 80)
				particle:SetColor(100,200,100)
				particle:SetStartSize(30)
				particle:SetDieTime(2)
				particle:SetEndSize(1)
			end
			emitter:Finish()

			self.CloudTime = CurTime() + 0.05
		end
	end
end


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
