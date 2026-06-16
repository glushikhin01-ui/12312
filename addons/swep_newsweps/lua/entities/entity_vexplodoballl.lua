--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile("includes/koxleta_aleksandra_martynasmalec.lua")
AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Niggammo2"
ENT.Category = "Frasiu's R&D"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
//ENT.Editable = true

if(SERVER) then
	function ENT:Initialize()
		self:SetModel("models/Items/combine_rifle_ammo01.mdl")
		//self:SetNoDraw(false)
		self:SetSkin("1")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)		
		self:GetPhysicsObject():SetMass(30)
		
		self.SmellyPlayersTb = {}
		self.ply = nil

		self.IsBeingAbsorbed = false
		self.FindInSphereSize = 400

		self.Zycie = 50
		
		self.dmg = DamageInfo();
		self.dmg:SetDamage(math.random(100,500))
		self.dmg:SetDamageType(DMG_DISSOLVE)
		self.dmg:SetAttacker(self:GetOwner())
		self.dmg:SetInflictor(self:GetOwner())
		self:SetOwner(nil) //fix na brak kolizji na ownerze PRZESTAW POZNIEJ !
		
		local ef = EffectData()
	        ef:SetEntity(self)
			ef:SetOrigin(self:GetPos())
			ef:SetScale(1)
			ef:SetColor(self:GetNWInt("ColorType"))
			util.Effect("explodobolffect", ef,true,true) // truetruefix

		if(IsValid(phys)) then
			phys:Wake()
		end
	end

	local TablicaUnweldu = {["prop_physics"] = true,["entity_vexplodoball"] = true,["entity_vball"] = true} //tablica widoczna od miejsca zadeklarowania w dół cale te(kuba pryknal haha)
	
	function ENT:PhysicsCollide(ColData,collider)
		self.LastHit = ColData.HitPos
		if ColData.Speed > 50 then
			
			self:GetPhysicsObject():SetVelocity(self:GetVelocity() * 0.5)

			local ef2 = EffectData()
			ef2:SetOrigin(self:GetPos())
			ef2:SetScale(1)
			ef2:SetColor(self:GetNWInt("ColorType"))
			util.Effect("umad", ef2)
			//self:EmitSound("vmaxgun/44k/1fire_impact.wav")
		end

		if math.random(1,10) == 1 then
			ColData.HitEntity:Ignite(5,10)
		end
	end
	
	function ENT:Think()
		self:SetNWFloat("Zorro", self.FindInSphereSize / 1.5)
		
		for k,v in pairs(ents.FindInSphere(self:GetPos(),(self.FindInSphereSize * 0.5))) do
			
			if v:IsPlayer() || v:IsNPC() then
				v:SetVelocity( ((self:GetPos()) - (v:GetPos())) * 0.2 )
			elseif TablicaUnweldu[v:GetClass()] && IsValid(v:GetPhysicsObject()) then
				v:GetPhysicsObject():SetVelocity(v:GetPhysicsObject():GetVelocity() + ((self:GetPos()) - (v:GetPhysicsObject():GetPos())) * 0.05)
			end
		end
		
		for k,v in pairs(ents.FindInSphere(self:GetPos(),(self.FindInSphereSize * 2))) do
			
			if v:GetClass() == "entity_vball" then
				v:GetPhysicsObject():SetVelocity(v:GetPhysicsObject():GetVelocity() + ((self:GetPos()) - (v:GetPhysicsObject():GetPos())) * 1.8)
			end
		end
		
		self:NextThink(CurTime())
		return true // bez tego nie działa nexthink
	end
	
	function ENT:OnTakeDamage(dmginfo)
		self.Zycie = self.Zycie - dmginfo:GetDamage()

		if self.Zycie <= 0 then
			self:Remove()
		elseif self.Zycie < 40 then
			self:EmitSound("ambient/energy/zap"..math.random(1,9)..".wav") 
			self:GetPhysicsObject():SetVelocity((self:GetVelocity() + Vector(0,0,255) * 0.7))
			self:Fire("Kill", "", 0.5)
		end
	end
	
	function ENT:OnRemove()
		//self.HissSound:Stop()
		if !self.IsBeingAbsorbed then
			/*self:EmitSound("vmaxgun/44k/crazysplosion1.wav")
			for k,v in pairs(ents.FindInSphere(self:GetPos(),self.FindInSphereSize * 0.3)) do
				
				if 	v:IsNPC() || TablicaUnweldu[v:GetClass()] then
					
					local Dissolver = ents.Create("env_entity_dissolver")
					Dissolver:SetPos(Vector(0, 0, 0))
					Dissolver:SetKeyValue("dissolvetype", "3")
					Dissolver:SetKeyValue("magnitude", "300")
					Dissolver:SetKeyValue("target", "to_dissolve")
					Dissolver:Spawn()
					Dissolver:Fire("Dissolve", "", 0)
					
					v:SetName("to_dissolve")
					Dissolver:Fire("Kill", "", 0.1)
				elseif v:IsPlayer() then
					v:TakeDamageInfo(self.dmg)
				end
			end
			for k,v in pairs(ents.FindInSphere(self:GetPos(),self.FindInSphereSize * 0.8)) do
				
				if v:IsPlayer() || v:IsNPC() then
					v:SetVelocity( ((v:GetPos()) - (self:GetPos())) * 15 )
					v:TakeDamage(math.random(50,100),self:GetOwner(),self:GetOwner())
				elseif TablicaUnweldu[v:GetClass()] && IsValid(v:GetPhysicsObject()) then
					
					constraint.RemoveConstraints(v,"Weld")
					v:GetPhysicsObject():SetVelocity( v:GetPhysicsObject():GetVelocity() + (((v:GetPhysicsObject():GetPos()) - (self:GetPos())) * 15)  )	
					v:GetPhysicsObject():EnableMotion(true)
					v:TakeDamage(math.random(5,50),self:GetOwner(),self:GetOwner())
				end
				
				//if math.random(1,20) == 1 then 
				//		v:Ignite(5,10)
				//end
			end*/

			

			local norm

			if self.LastHit && self.LastHit:DistToSqr(self:GetPos()) < 40000 then
				local tr = util.TraceHull({
					start = self:GetPos(),
					endpos = self.LastHit,
					mins = Vector(-2,-2,-2),
					maxs = Vector(2,2,2),
					filter = self
				})

				norm = tr.HitNormal
			else
				norm = self:GetPhysicsObject():GetVelocity():GetNormalized()
			end

			local ef2 = EffectData()
			ef2:SetOrigin(self:GetPos())
			ef2:SetNormal(norm)
			ef2:SetScale(10)
			ef2:SetColor(self:GetNWInt("ColorType"))
			util.Effect("umad3", ef2, true)
		end
	end
end

//if CLIENT then 
	//function ENT:Draw()
											//puste - nie drawuj entyta
		//self:SetNoDraw(false) nie dzialal
	//end
//end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
