--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile("includes/koxleta_aleksandra_martynasmalec.lua")
AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Ni99ammo"
ENT.Category = "Frasiu's R&D"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
//ENT.Editable = true

if(SERVER) then
	function ENT:Initialize()
		self:SetModel("models/Items/combine_rifle_ammo01.mdl")
		//self:SetNoDraw(false)
		self:PhysicsInitSphere(16, "metal_bouncy")
		self:SetMoveType(MOVETYPE_VPHYSICS)	

		self:GetPhysicsObject():SetMass(10000)
		self:GetPhysicsObject():EnableGravity(false)
		self:GetPhysicsObject():AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		self:DrawShadow(false)
		
		self.SmellyPlayersTb = {}
		self.ply = nil
		self:SetNWBool("TrailLatch",false)

		self.IsBeingAbsorbed = false
		self.FindInSphereSize = 400

		self.Zycie = 50
		self.SoundWindup = CreateSound(self,"vmaxgun/44k/explodoball_windup.wav")
		self.SoundWindup:Play()
		self:EmitSound("weapons/Irifle/irifle_fire2.wav",75,125)
		
		//self:SetOwner(nil) //fix na brak kolizji na ownerze PRZESTAW POZNIEJ !
		
		local ef = EffectData()
	        ef:SetEntity(self)
			ef:SetOrigin(self:GetPos())
			ef:SetScale(1)
			ef:SetColor(self:GetNWInt("ColorType"))
			util.Effect("explodobolffect", ef,true,true) // truetruefix

		if(IsValid(phys)) then
			phys:Wake()
		end

		self.LifeTime = self.LifeTime or (CurTime() + 3)
		self.Protection = CurTime() + 0.4
	end

	local TablicaUnweldu = {["entity_vexplodoball"] = 0.05} //tablica widoczna od miejsca zadeklarowania w dół cale te(kuba pryknal haha)

	function ENT:CreateDamage(dmg1)
		local dmg = DamageInfo();
		dmg:SetDamage(dmg1)
		dmg:SetDamageType(DMG_DISSOLVE)
		dmg:SetAttacker(self:GetOwner())
		dmg:SetInflictor(self:GetOwner())

		return dmg
	end
	
	function ENT:PhysicsCollide(coldata,collider)
		self.LastHit = coldata.HitPos	
		
		if coldata.Speed > 50 then
			self:SetNWBool("TrailLatch",true)
			
			self:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)

			local tr = util.TraceLine({
				start = self:GetPos(),
				endpos = self:GetPos() + (coldata.HitPos - self:GetPos()) * 2,
				filter = self
			})

			local ef2 = EffectData()
			ef2:SetOrigin(tr.HitPos)
			ef2:SetNormal(tr.HitNormal)
			ef2:SetScale(2)
			ef2:SetColor(self:GetNWInt("ColorType"))
			util.Effect("umad", ef2)
			//self:EmitSound("vmaxgun/44k/1fire_impact.wav")
		end
		
		if coldata.HitEntity:GetClass() != "entity_vball" then
			if math.random(1,10) == 1 then
				coldata.HitEntity:Ignite(5,10)
			end
		end
	end
	
	function ENT:Think()
		self:SetNWFloat("Zorro", self.FindInSphereSize * 2)
		self.SoundWindup:ChangePitch(255,4)
		
		if self.Protection < CurTime() then
			for k,v in pairs(ents.FindInSphere(self:GetPos(),(self.FindInSphereSize * 0.65))) do
				if k > 2 then continue end
				if IsValid(v:GetPhysicsObject()) then
					local force = TablicaUnweldu[v:GetClass()]

					if !force then
						if v:IsVehicle() then
							force = 10
						end
					end
					
					if v:IsPlayer() then
						if IsValid(v) and v:HasWeapon('swep_vmaxgun') then continue end
						//print(k)
						//if #v < 1 then
							v:SetVelocity( ((self:GetPos()) - (v:GetPos())) * 1.25 )
						//end
					elseif force then
						v:GetPhysicsObject():SetVelocity(v:GetPhysicsObject():GetVelocity() + ((self:GetPos()) - (v:GetPhysicsObject():GetPos())) * force)
					end
				end
			end
			for k,v in pairs(ents.FindInSphere(self:GetPos(),(self.FindInSphereSize * 2))) do
				if k > 2 then continue end

				if IsValid(v:GetPhysicsObject()) then
					if v:GetClass() == "entity_vball" && IsValid(v) then
						v:GetPhysicsObject():SetVelocity(v:GetPhysicsObject():GetVelocity() + ((self:GetPos()) - (v:GetPhysicsObject():GetPos())) * 1.6)
						//v:GetPhysicsObject():SetVelocity(v:GetPhysicsObject():GetVelocity() + ((self:GetPos()) - (v:GetPhysicsObject():GetPos())) * 1.8)
					end
				end
			end
		end

		if self.LifeTime < CurTime() then
			self:Explode()
		end
		
		self:NextThink(CurTime() + 0.01)
		return true // bez tego nie działa nexthink
	end
	
	function ENT:OnTakeDamage(dmginfo)
		self.Zycie = self.Zycie - dmginfo:GetDamage()

		if self.Zycie <= 0 then
			self:Explode()
		elseif self.Zycie < 40 then
			self:EmitSound("ambient/energy/zap"..math.random(1,9)..".wav") 
			self:GetPhysicsObject():SetVelocity((self:GetVelocity() + Vector(0,0,255) * 0.7))
			self.LifeTime = CurTime() + 0.5
		end
	end
	
	function ENT:Explode()
		self.SoundWindup:Stop()
		
		if !self.IsBeingAbsorbed then
			self:EmitSound("vmaxgun/44k/crazysplosion1.wav")
			for k,v in pairs(ents.FindInSphere(self:GetPos(),self.FindInSphereSize * 0.3)) do
				if TablicaUnweldu[v:GetClass()] then
					
					local Dissolver = ents.Create("env_entity_dissolver")
					Dissolver:SetPos(Vector(0, 0, 0))
					Dissolver:SetKeyValue("dissolvetype", "3")
					Dissolver:SetKeyValue("magnitude", "300")
					Dissolver:SetKeyValue("target", "to_dissolve")
					Dissolver:Spawn()
					Dissolver:SetOwner(self:GetOwner())
					Dissolver:Fire("Dissolve", "", 0)
					
					v:SetName("to_dissolve")
					Dissolver:Fire("Kill", "", 0.1)
				elseif v:IsPlayer() then
					if IsValid(v) and v:HasWeapon('swep_vmaxgun') then continue end
					v:TakeDamageInfo(self:CreateDamage(math.random(1000,5000)))
				end
			end
			for k,v in pairs(ents.FindInSphere(self:GetPos(),self.FindInSphereSize * 0.8)) do
				if IsValid(v:GetPhysicsObject()) then
					if v:IsPlayer() then
						if IsValid(v) and v:HasWeapon('swep_vmaxgun') then continue end
						v:SetVelocity( ((v:GetPos()) - (self:GetPos())) * 15 )
						v:TakeDamage(math.random(1000,5000),self:GetOwner(),self:GetOwner())
					elseif TablicaUnweldu[v:GetClass()] && v:GetClass() != "entity_vball" then 
						if math.random(1,20) == 1 then 
							v:Ignite(5,10)
						end
						
						//constraint.RemoveConstraints(v,"Weld")
						//v:GetPhysicsObject():SetVelocity( v:GetPhysicsObject():GetVelocity() + (((v:GetPhysicsObject():GetPos()) - (self:GetPos())) * 5)  )	
						//v:GetPhysicsObject():EnableMotion(true)
					elseif v:GetClass() == "entity_vball" then
						v:GetPhysicsObject():SetVelocity(v:GetPhysicsObject():GetVelocity() + ((self:GetPos()) - (v:GetPhysicsObject():GetPos())) * 5)
					end
				end
			end
			
			local norm
			local yuan_hit = 0

			if self.LastHit && self.LastHit:DistToSqr(self:GetPos()) < 40000 then
				local tr = util.TraceHull({
					start = self:GetPos(),
					endpos = self.LastHit,
					mins = Vector(-2,-2,-2),
					maxs = Vector(2,2,2),
					filter = self
				})
				yuan_hit = 1

				norm = tr.HitNormal
			else
				norm = self:GetPhysicsObject():GetVelocity():GetNormalized()
			end

			local ef2 = EffectData()
			ef2:SetOrigin(self:GetPos())
			ef2:SetScale(10)
			ef2:SetNormal(norm)
			ef2:SetFlags(yuan_hit)
			ef2:SetColor(self:GetNWInt("ColorType"))
			util.Effect("umad3", ef2)
		end

		self:Remove()
	end
end

if CLIENT then 
	function ENT:Draw()
											//puste - nie drawuj entyta
		//self:SetNoDraw(false) nie dzialal
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
