--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


SRDCarsSettings = SRDCarsSettings or {}

local allowedtohit = {}
allowedtohit["prop_physics"] = true
allowedtohit["prop_vehicle_jeep"] = true
allowedtohit["prop_dynamic"] = true
allowedtohit["prop_static"] = true
allowedtohit["worldspawn"] = true

local function processTableCollide(ent, objects, nwVarName, hitData)
	local localedhitpos = ent:WorldToLocal(hitData.HitPos)
	for key, obj in pairs(objects) do
		local vec1, vec2 = Vector(obj.boxmax.x,obj.boxmax.y,obj.boxmax.z), Vector(obj.boxmin.x,obj.boxmin.y,obj.boxmin.z)
		OrderVectors(vec1, vec2)
		if localedhitpos:WithinAABox(vec1, vec2) then
			local hp = ent:GetNWInt("HP_"..nwVarName.."_"..key, 100) or 100
			if obj.model and hitData.HitEntity:GetModel():lower() == obj.model and hp <= 20 and hitData.HitEntity:GetClass() == "prop_physics" then
				ent:SetNWInt("HP_"..nwVarName.."_"..key, 100)
				hitData.HitEntity:Remove()
				hp = 100
			end
			local localToWorldAngles = ent:LocalToWorldAngles(obj.hitang)
			local vec = localToWorldAngles:Forward()
			local resvec = hitData.TheirOldVelocity + hitData.OurOldVelocity
			local ang = (resvec-vec):Angle()--yaw
			local hpsub = math.Clamp(math.cos(ang.p)*resvec:Length()*0.05, 0, 60)
			ent:SetNWInt("HP_"..nwVarName.."_"..key, math.Clamp(hp-hpsub,0,100))
		end
	end
end

local function hitCar(ent, data)
	local tabl = SRDCarsSettings[ent:GetModel():lower()]
	if (IsValid(data.HitEntity) and allowedtohit[data.HitEntity:GetClass():lower()]) or data.HitEntity:IsWorld() then
		processTableCollide(ent, tabl.Doors, "Doors", data)
		processTableCollide(ent, tabl.Props, "Props", data)
		if tabl.BodygroupZones then
			processTableCollide(ent, tabl.BodygroupZones, "BodygroupZones", data)
		end
		if tabl.FlexZones then
			processTableCollide(ent, tabl.FlexZones, "FlexZones", data)
		end
	end
end



local function processTableHit(ent, objects, nwVarName, dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local localedhitpos = ent:WorldToLocal(hitpos)
	for k,v in pairs(objects) do
		if dmginfo:IsBulletDamage() or dmginfo:IsDamageType(DMG_CLUB) or dmginfo:IsDamageType(DMG_CRUSH) then
			local vec1, vec2 = Vector(v.boxmax.x,v.boxmax.y,v.boxmax.z), Vector(v.boxmin.x,v.boxmin.y,v.boxmin.z)
			OrderVectors(vec1, vec2)
			if localedhitpos:WithinAABox(vec1, vec2) then
				local hp = ent:GetNWInt("HP_"..nwVarName.."_"..k, 100) or 100
				local mul = 1
				if dmginfo:IsBulletDamage() then
					mul = 5000
				end
				ent:SetNWInt("HP_"..nwVarName.."_"..k, math.Clamp(math.Round(hp-dmginfo:GetBaseDamage()*mul),0,100))
			end
		elseif dmginfo:IsExplosionDamage() then
			local dist = localedhitpos:Distance(v.pos)
			if dist <= 100 then
				local hp = ent:GetNWInt("HP_"..nwVarName.."_"..k, 100) or 100
				ent:SetNWInt("HP_"..nwVarName.."_"..k, math.Clamp(math.Round(hp-dmginfo:GetDamage()*50*dist),0,100))
			end
		end
	end
end

if SERVER then
	
	local nextUpdate = CurTime() + 1
	
	hook.Add("Think", "SRDDetectCars", function()
		if nextUpdate <= CurTime() then
		
			nextUpdate = CurTime() + 1
			
			for _,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
			
				if SRDCarsSettings[v:GetModel():lower()] then
					if !v.SRDCarsInitialized then
						v.SRDCarsInitialized = true
						local settings = SRDCarsSettings[v:GetModel():lower()]
						local base = ents.Create("srdcars_models_base")
						base:SetPos(v:LocalToWorld(settings.BoundingBox.offset))
						base:SetAngles(v:LocalToWorldAngles(settings.BoundingBox.offsetangle))
						base:SetModel(settings.BoundingBox.model)
						base:SetParent(v)
						base:Spawn()
						base:Activate()
						for key,v2 in pairs(settings["Doors"]) do
							v:SetNWInt("HP_Doors_"..key, 100)
							util.PrecacheModel(v2.model)
						end
						for key,v2 in pairs(settings["Props"]) do
							v:SetNWInt("HP_Props_"..key, 100)
							util.PrecacheModel(v2.model)
						end
						if settings.BodygroupZones then
							for key,v2 in pairs(settings["BodygroupZones"]) do
								v:SetNWInt("HP_BodygroupZones_"..key, 100)
							end
						end
						if settings.FlexZones then
							for key,v2 in pairs(settings["FlexZones"]) do
								v:SetNWInt("HP_FlexZones_"..key, 100)
							end
						end
						v:AddCallback("PhysicsCollide", hitCar)
					end
				end
			end
		end
	end)
	
	hook.Add("EntityTakeDamage", "SRDHitCar", function(ent, dmginfo)
		if ent:IsVehicle() and SRDCarsSettings[ent:GetModel():lower()] then
			local settings = SRDCarsSettings[ent:GetModel():lower()]
			processTableHit(ent, settings.Doors, "Doors", dmginfo)
			processTableHit(ent, settings.Props, "Props", dmginfo)
			if settings.BodygroupZones then
				processTableHit(ent, settings.BodygroupZones, "BodygroupZones", dmginfo)
			end
			if settings.FlexZones then
				processTableHit(ent, settings.FlexZones, "FlexZones", dmginfo)
			end
		end
	end)
end






--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
