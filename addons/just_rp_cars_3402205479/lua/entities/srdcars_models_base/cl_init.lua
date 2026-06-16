--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

 
include('shared.lua')
local wireframe = Material("models/wireframe")
local function drawBox(vec1, vec2, car, ang)
	render.SetMaterial(wireframe)
	render.DrawBox(car:LocalToWorld(vec1), car:GetAngles(), Vector(), vec2-vec1, Color(255,0,0), true)
	render.DrawLine(car:LocalToWorld((vec1+vec2)*0.5), car:LocalToWorld((vec1+vec2)*0.5) + car:LocalToWorldAngles(ang):Right() * 25, Color(0, 255, 0), true)
end

function ENT:Draw()
	--self:DrawModel()
	if !self.DrawnModels then
		self.DrawnModels = {}
	end
	if !self.MatsTable then
		self.MatsTable = {}
	end
	if !self.nextmatschange then
		self.nextmatschange = {}
	end
	local car = self:GetParent()
	self:SetColor(car:GetColor())
	local tabl = SRDCarsSettings[car:GetModel():lower()]
	if tabl then
		if car.DebugType then
			if car.DebugID then
			local settings = tabl[car.DebugType][car.DebugId]
			local localvec1, localvec2 = Vector(settings.boxmax.x,settings.boxmax.y,settings.boxmax.z), Vector(settings.boxmin.x,settings.boxmin.y,settings.boxmin.z)
			
			drawBox(localvec1, localvec2, car, settings.hitang)
			else
				for k,v in pairs(tabl[car.DebugType])do
					local localvec1, localvec2 = Vector(v.boxmax.x,v.boxmax.y,v.boxmax.z), Vector(v.boxmin.x,v.boxmin.y,v.boxmin.z)
			
					drawBox(localvec1, localvec2, car, v.hitang)
				end
			end
		end
		if !self.LastUpdate or self.LastUpdate <= CurTime() then
			for k,v in pairs(tabl.Doors) do
				if !self.Doors then
					self.Doors = {}
				end
				if !self.Doors[k] and car:GetNWInt("HP_Doors_"..k, 100) > 0 then
					local ent = ents.CreateClientProp()--ClientsideModel(v.model)
					ent:SetNoDraw(true)
					ent:SetModel(v.model)
					ent:Spawn()
					ent.Veh = car
					ent.Type = "Doors"
					ent.ID = k
					self.Doors[k] = ent
					self.DrawnModels[#self.DrawnModels+1] = ent
				end
			end
			
			for k,v in pairs(tabl.Props) do
				if !self.Props then
					self.Props = {}
				end
				if !self.Props[k] and car:GetNWInt("HP_Props_"..k, 100) > 0 then
					local ent = ents.CreateClientProp()--ClientsideModel(v.model)
					ent:SetNoDraw(true)
					ent:SetModel(v.model)
					ent:Spawn()
					ent.Veh = car
					ent.Type = "Props"
					ent.ID = k
					self.Props[k] = ent
					self.DrawnModels[#self.DrawnModels+1] = ent
				end
			end
			self.LastUpdate = CurTime() + 1
		end
		for k,v in pairs(self.DrawnModels) do
			if !IsValid(v) then
				self.DrawnModels[k] = nil
			else
				local veh = v.Veh
				if !IsValid(veh) then
					v:Remove()
					self.DrawnModels[k] = nil
					if self.MatsTable[k] then
						self.MatsTable[k] = nil
					end
				else
					if !self.MatsTable[k] then
						self.MatsTable[k] = {mat = "", submats = {}, skin = 0}
					end
					local hp = veh:GetNWInt("HP_"..v.Type.."_"..v.ID, 100) or 100
					
					local objSettings = tabl[v.Type][v.ID]
					if objSettings.BodygroupsSettings then
						self:ProcessObjectsBodygroups(v, hp, objSettings.BodygroupsSettings)
					end
					
					if objSettings.FlexSettings then
						self:ProcessObjectsFlex(v, hp, objSettings.FlexSettings)
					end
					
					if hp <= 0 then
						if IsValid(v:GetParent()) then
							v:SetParent(nil)
							v:SetNoDraw(false)
							v:SetMoveType(MOVETYPE_VPHYSICS)
							v:PhysicsInit(SOLID_VPHYSICS)
							v:SetSolid(SOLID_VPHYSICS)
							v:Spawn()
							local phys = v:GetPhysicsObject() 
							phys:Wake()
							v:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
						end
					else
						
						if !self.nextmatschange[k] or self.nextmatschange[k] <= CurTime() then
							self.nextmatschange[k] = CurTime() + 1
							local tabl = SRDCarsSettings[veh:GetModel():lower()][v.Type][v.ID]
							
							if tabl.skins then
								local curSkin = self.MatsTable[k].skin
								local carSkin = veh:GetSkin()
								if tabl.skins[carSkin] and curSkin != tabl.skins[carSkin] then
									v:SetSkin(tabl.skins[carSkin])
									self.MatsTable[k].skin = tabl.skins[carSkin]
								end
							end
							
							if tabl.submaterials then
								for k2,v2 in pairs(tabl.submaterials) do
									if veh:GetSubMaterial(k2) != self.MatsTable[k].submats[v2] then
										v:SetSubMaterial(v2, veh:GetSubMaterial(k2))
										self.MatsTable[k].submats[v2] = veh:GetSubMaterial(k2)
									end
								end
							end
							
							if self.MatsTable[k].mat != veh:GetMaterial() then
								v:SetMaterial(veh:GetMaterial())
								self.MatsTable[k].mat = veh:GetMaterial()
							end
						end
						if v:GetParent() != veh then
							v:SetParent(veh)
							local tabl = SRDCarsSettings[veh:GetModel():lower()][v.Type][v.ID]
							v:SetPos(veh:LocalToWorld(tabl.pos))
							v:SetAngles(veh:LocalToWorldAngles(tabl.ang))
							v:SetMoveType(MOVETYPE_NONE)
							v:PhysicsInit(SOLID_NONE)
							v:SetCollisionGroup(COLLISION_GROUP_NONE)
							v:SetSolid(SOLID_NONE)
						end
						v:DrawModel()
					end
				end
			end
		end
	end
end
function ENT:ProcessObjectsBodygroups(ent, hp, settings)
	for k,v in pairs(settings) do
		local high = v.HP
		local low = 0
		if #settings > k then
			low = settings[k+1].HP
		end
		if hp <= high and hp > low then
			for k2,v in pairs(v.Bodygroups) do
				ent:SetBodygroup(k2, v)
			end
			break
		end
	end
end

function ENT:ProcessObjectsFlex(ent, hp, settings)
	if hp > settings.To then
		ent:SetFlexWeight(settings.FlexID, settings.Min)
	elseif hp < settings.From then
		ent:SetFlexWeight(settings.FlexID, settings.Max)
	else
		local dif = settings.To - settings.From
		local dif2 = settings.Max - settings.Min
		ent:SetFlexWeight(settings.FlexID, settings.Min + (hp-settings.From)/dif * dif2)
	end
end

function ENT:OnRemove()
	if self.DrawnModels then
		for k,v in pairs(self.DrawnModels) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end
end
 

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
