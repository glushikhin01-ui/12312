--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Ni99ammo"
ENT.Category = "Frasiu's R&D"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

if(SERVER) then
	function ENT:Initialize()
		self:SetModel("models/Items/Flare.mdl")
		self:SetSkin("1")
		self:PhysicsInitSphere(0.5)

		self:GetPhysicsObject():SetMass(1)
		self:GetPhysicsObject():EnableGravity(false)
		self:DrawShadow(false)
		self:GetPhysicsObject():AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		
		self.endflight = false
		self.SmellyPlayersTb = {}
		self.ply = nil
		self.Owner2 = self:GetOwner()
		
		self.Zycie = 10
		self.YuanHit = 2

		local ef = EffectData()
        ef:SetEntity(self)
		ef:SetOrigin(self:GetPos() + Vector(0,0,0))
		ef:SetScale(1)
		ef:SetColor(self:GetNWInt("ColorType"))
		util.Effect("bolloffect", ef,true,true)
		
		if(IsValid(phys)) then
			phys:Wake()
		end

	end

	local TablicaUnweldu = {["prop_physics"] = true, ["prop_vehicle_jeep"] = true}
	
	function ENT:PhysicsCollide(coldata,collider)
		local dmg = DamageInfo(); // zrob zeby nie kolidowalo z explodoball pamietaj pamietaj
		dmg:SetDamage(50)
		dmg:SetDamageType(DMG_DISSOLVE)
		dmg:SetAttacker(self.Owner2)
		dmg:SetInflictor(self.Owner2)

		if !self.endflight then
			self:EmitSound("vmaxgun/44k/crazyimpact1.wav") 
			local tr = util.TraceLine({
				start = self:GetPos(),
				endpos = self:GetPos() + (coldata.HitPos - self:GetPos()) * 2,
				filter = self
			})

			local ef2 = EffectData()
			ef2:SetOrigin(tr.HitPos)
			ef2:SetScale(1)
			ef2:SetNormal(tr.HitNormal)
			ef2:SetColor(self:GetNWInt("ColorType"))
			util.Effect("umad", ef2)

			self.endflight = true
		end
		
		if coldata.HitEntity:IsPlayer() && !self.SmellyPlayersTb[coldata.HitEntity:EntIndex()] then
			if coldata.HitEntity != self:GetOwner() && coldata.HitEntity:GetClass() != "entity_vexplodoball" then
				self.ply = coldata.HitEntity	
				
				if math.random(1,10) == 1 then
					self.ply:Ignite(5,10)
				end
				timer.Simple(0.01, function()
					if !IsValid(self) then return end
					
					self:SetPos(coldata.HitPos)
					self:SetParent(coldata.HitEntity)
				end)

				self.ply:TakeDamageInfo(dmg)
				
				self.SmellyPlayersTb[coldata.HitEntity:EntIndex()] = true
			end
		elseif TablicaUnweldu[coldata.HitEntity:GetClass()] then
			self.prop = coldata.HitEntity

			if math.random(1,10) == 1 then
				coldata.HitEntity:Ignite(5,10)
			end
			self.prop:TakeDamageInfo(dmg)
			
			if(self.HitPropsTb[self.prop:EntIndex()]) then 
				self.HitPropsTb[self.prop:EntIndex()].hits = self.HitPropsTb[self.prop:EntIndex()].hits + 1 
			else 	
				self.HitPropsTb[self.prop:EntIndex()] = {hits = 1} 
			end

			if self.HitPropsTb[self.prop:EntIndex()].hits > 199 then
				
				local Dissolver = ents.Create("env_entity_dissolver")
				Dissolver:SetPos(Vector(0, 0, 0))
				Dissolver:SetKeyValue("dissolvetype", "3")
				Dissolver:SetKeyValue("magnitude", "300")
				Dissolver:SetKeyValue("target", "to_dissolve")
				Dissolver:Spawn()
				Dissolver:Fire("Dissolve", "", 0)
				Dissolver:Fire("Kill", "", 0.1)
				
				self.prop:SetName("to_dissolve")
				self.HitPropsTb[self.prop:EntIndex()] = nil
			end
			
			timer.Simple(0.01, function()
				if !IsValid(self) then return end
				self:SetPos(coldata.HitPos)
				self:SetParent(coldata.HitEntity)
			end)
		end
	end
	
	function ENT:Think()
		if IsValid(self:GetParent()) && self:GetParent():Health() < 1 && self:GetParent():GetMaxHealth() > 1 then
			self:Remove()
			self:SetParent(nil)
			self:GetPhysicsObject():EnableGravity(true)
		end
		
		if self.endflight then
			self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
			self:GetPhysicsObject():EnableGravity(true)
		end
		
		if IsValid(self.ply) && self.ply:Health() < 1 then
			self:SetParent(nil)
			self:GetPhysicsObject():EnableMotion(true)
		end

		if self.LifeTime < CurTime() then
			self:Explode()
		end
		
		self:NextThink(CurTime())
	end
	
	function ENT:OnTakeDamage(dmginfo)
		self.Zycie = self.Zycie - dmginfo:GetDamage()
		
		if self.Zycie <= 0 then
			self:Remove()
		end
	end
	
	function ENT:Explode()
		local dmg = DamageInfo();
		dmg:SetDamage(60)
		dmg:SetDamageType(DMG_DISSOLVE)
		dmg:SetAttacker(self.Owner2)
		dmg:SetInflictor(self.Owner2)
		
		self:EmitSound("vmaxgun/44k/1fire_smallexplode.wav")
		for k,v in pairs(ents.FindInSphere(self:GetPos(),80)) do
			if IsValid(v) and v:IsPlayer() and v:HasWeapon('swep_vmaxgun') then continue end
			v:TakeDamageInfo(dmg)
		end

		local ef2 = EffectData()
		ef2:SetOrigin(self:GetPos())
		ef2:SetScale(5)
		ef2:SetColor(self:GetNWInt("ColorType"))
		util.Effect("umad2", ef2)

		self:Remove()
	end
end

if CLIENT then
	function ENT:Initialize()
	end

	function ENT:Draw()
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
