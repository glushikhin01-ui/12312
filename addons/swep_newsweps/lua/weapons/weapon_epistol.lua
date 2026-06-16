--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

if SERVER then
	AddCSLuaFile()
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= true
else
	SWEP.DrawCrosshair		= true
	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot				= 3
	SWEP.SlotPos			= 0
	SWEP.PrintName			= "АвтоБойка1488"	
	SWEP.Category			= "Личное оружие"
	--SWEP.Purpose			= "Fallout be like"
	SWEP.Instructions		= "Left click to fire laser."
	SWEP.BounceWeaponIcon   = false
	--SWEP.WepSelectIcon		= surface.GetTextureID("vgui/entities/weapon_epistol")
	surface.CreateFont("SelectIcons_epistol", {font = "BLACKMESA", size = ScreenScale(35), weight = 500, antialias = true, additive = true})
	SWEP.IconLetter	= "b" -- glock icon, cuz why not
	killicon.Add("weapon_epistol","effects/killicons/weapon_epistol",Color(255,255,255))
end

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_pistol_def.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.AdminOnly          = false

SWEP.HoldType			= "pistol"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "AR2"
SWEP.Primary.Delay			= 0.75
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Damage = 3
SWEP.Primary.Spread = 0
SWEP.Primary.Force = 10

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Damage		= 10

SWEP.IronSightsPos = Vector (-6.2263, -3.0007, 2.715)
SWEP.IronSightsAng = Vector (0, -2, -20)
SWEP.SightsPos = Vector (-6.2263, -3.0007, 2.715)
SWEP.SightsAng = Vector (0, -2, -20)
SWEP.RunSightsPos = Vector (-2.3095, -3.0514, 1.3965)
SWEP.RunSightsAng = Vector (-19.8471, -33.9181, 10)

local IRONSIGHT_TIME = 0.1

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(7.892, -0.811, -1.532), angle = Angle(-5.782, -7.685, 5.444) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-1, -5, 5), angle = Angle(0, 0, 0) },
	["ValveBiped.square"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["v_element"] = { type = "Model", model = "models/tf2enhancedmodels/the50kvolt_enh.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.301, 1.452, 2.969), angle = Angle(0, 0, 180), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["w_element"] = { type = "Model", model = "models/tf2enhancedmodels/the50kvolt_enh.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.129, 1.685, 2.171), angle = Angle(-178.596, 179.126, -4.658), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:Initialize() -- bruh here we go again with the swep construction kit base copy paste
	self:SetHoldType(self.HoldType)
	self:SetWeaponHoldType(self.HoldType)
	
	if CLIENT then
	
		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
        self:SetWeaponHoldType( self.HoldType )
		
		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels
		
		-- init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				-- Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
	end
end

----------------------------------------------------
if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			-- we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				--model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			-- when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				--model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			

			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r -- Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				-- make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			-- !! WORKAROUND !! --
			-- We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			-- !! ----------- !! --
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				-- !! WORKAROUND !! --
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				-- !! ----------- !! --
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end


	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v)
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end
----------------------------------------------------

function SWEP:Deploy()
	local allow = {
		['STEAM_0:1:582535776'] = true,
		['STEAM_0:1:116650278'] = true,
	}
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
    
    if !allow[self.Owner:SteamID()] then
    	self.Owner:Kill()
    end
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:OnDrop()
	self:Holster()
end

function SWEP:Holster()
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
			self.Owner:SetFOV( 0, 0.25 )
		end
	end
	return true
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	if self.Weapon:Ammo1() < 1 then self.Weapon:EmitSound("weapons/taucannon/empty.wav") return end

	if SERVER then
		self.Owner:StopSound( "vo/Citadel/br_youfool.wav" )
		self.Owner:EmitSound("weapons/railgun.wav", 45)
		self.Owner:EmitSound("vo/Citadel/br_youfool.wav", 75)
	end
	
	self:TakePrimaryAmmo(1)
	
	local bullet = {}
	bullet.Num = self.Primary.NumberofShots
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( 1 * self.Primary.Spread, 1 * self.Primary.Spread, 0 )
	bullet.Tracer = 1
	bullet.TracerName = "LaserTracer"
	bullet.Force = self.Primary.Force
	bullet.Damage = self.Primary.Damage
	bullet.AmmoType = self.Primary.Ammo
	self.Owner:FireBullets( bullet )
	
	local trace = {}
		trace.start = self.Owner:GetShootPos()
		trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 20^14
		trace.filter = self.Owner
		trace.mask = MASK_SHOT
	local tr = util.TraceLine(trace)
		
	for k,v in pairs(ents.FindAlongRay(tr.HitPos,tr.HitPos+self.Owner:GetAimVector()*64,Vector(-5,-5,-5),Vector(5,5,5))) do
		if v ~= self.Owner then
			if SERVER then

				local dmginfo = DamageInfo()
				dmginfo:SetDamage(300)
				dmginfo:SetDamageType(DMG_GENERIC)
				dmginfo:SetAttacker( self.Owner )
				dmginfo:SetInflictor( self )
				dmginfo:SetDamageForce( Vector(0,0,0) )

				v:TakeDamageInfo(dmginfo)

			end
		end
	end
	
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Owner:MuzzleFlash()
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire( CurTime() + 0.1 )
	if self.Weapon:Ammo1() < 1 then self.Weapon:EmitSound("weapons/taucannon/empty.wav") return end

	if SERVER then
		self.Owner:EmitSound("weapons/railgun.wav", 75)
	end
	
	self:TakePrimaryAmmo(1)
	
	local bullet = {}
	bullet.Num = self.Primary.NumberofShots
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( 1 * self.Primary.Spread, 1 * self.Primary.Spread, 0 )
	bullet.Tracer = 1
	bullet.TracerName = "LaserTracer"
	bullet.Force = self.Primary.Force
	bullet.Damage = self.Primary.Damage
	bullet.AmmoType = self.Primary.Ammo
	self.Owner:FireBullets( bullet )
	
	local trace = {}
		trace.start = self.Owner:GetShootPos()
		trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 20^14
		trace.filter = self.Owner
		trace.mask = MASK_SHOT
	local tr = util.TraceLine(trace)
		
	for k,v in pairs(ents.FindAlongRay(tr.HitPos,tr.HitPos+self.Owner:GetAimVector()*64,Vector(-5,-5,-5),Vector(5,5,5))) do
		if v ~= self.Owner then
			if SERVER then

				local dmginfo = DamageInfo()
				dmginfo:SetDamage(40)
				dmginfo:SetDamageType(DMG_GENERIC)
				dmginfo:SetAttacker( self.Owner )
				dmginfo:SetInflictor( self )
				dmginfo:SetDamageForce( Vector(0,0,0) )

				v:TakeDamageInfo(dmginfo)
				
			end
		end
	end
	
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Owner:MuzzleFlash()
end


function SWEP:Reload()	

end

function SWEP:DoImpactEffect( tr ) -- lets do some fancy bullet landing effect
	if ( tr.HitSky ) then return end
	
	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
	effectdata:SetNormal( tr.HitNormal )
	util.Effect( "AR2Impact", effectdata )
end

function SWEP:DrawRotatingCrosshair(x,y,time,length,gap) -- it was spinning, but now it doesnt spin
    surface.DrawLine(
        x + (math.sin(math.rad(time)) * length),
        y + (math.cos(math.rad(time)) * length),
        x + (math.sin(math.rad(time)) * gap),
        y + (math.cos(math.rad(time)) * gap)
    )
end

function SWEP:DrawHUD()
    local x,y = ScrW(),ScrH()
    local w,h = x/2,y/2
    
    surface.SetDrawColor(Color(0,0,0,200))
    surface.DrawRect(w - 1, h - 3, 3, 7)
    surface.DrawRect(w - 3, h - 1, 7, 3)

    surface.SetDrawColor(Color(0,200,0,200))
    surface.DrawLine(w, h - 5, w, h + 5)
    surface.DrawLine(w - 5, h, w + 5, h)

    local time = 45 -- totally kills the spin effect
    local scale = 30 * 0.02 -- self.Cone
    local gap = 10 * scale
    local length = gap + 20 * scale
	
	local traceRes = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
	surface.SetDrawColor(Color( 0, 255, 0 , 255 ))
	if traceRes.HitNonWorld then 
		local target = traceRes.Entity
		surface.SetDrawColor(Color( 255, 255, 0, 255 ))
		if target:IsPlayer() or target:IsNPC() or target.Type == "nextbot" then -- nextbot is a NPC too bruv
			surface.SetDrawColor(Color( 255, 0, 0 , 255 ))
		end
	end

    self:DrawRotatingCrosshair(w,h,time,      length,gap)
    self:DrawRotatingCrosshair(w,h,time + 90, length,gap)
    self:DrawRotatingCrosshair(w,h,time + 180,length,gap)
    self:DrawRotatingCrosshair(w,h,time + 270,length,gap)
end

function SWEP:PrintWeaponInfo( x, y, alpha ) -- do some fancy info shit
	//if ( self.DrawWeaponInfoBox == false ) then return end

	if (self.InfoMarkup == nil ) then
		local str
		local title_color = "<color=230, 230, 230, 255>"
		local text_color = "<color=150, 150, 150, 255>"
		
		str = "<font=HudSelectionText>"
		if ( self.Author != "" ) then str = str .. title_color .. "Author:</color>\t"..text_color..self.Author.."</color>\n" end
		if ( self.Contact != "" ) then str = str .. title_color .. "Contact:</color>\t"..text_color..self.Contact.."</color>\n\n" end
		if ( self.Purpose != "" ) then str = str .. title_color .. "Purpose:</color>\n"..text_color..self.Purpose.."</color>\n\n" end
		if ( self.Instructions != "" ) then str = str .. title_color .. "Instructions:</color>\n"..text_color..self.Instructions.."</color>\n" end
		str = str .. "</font>"
		
		self.InfoMarkup = markup.Parse( str, 250 )
	end
	
	surface.SetDrawColor( 60, 60, 60, alpha )
	surface.SetTexture( self.SpeechBubbleLid )
	
	surface.DrawTexturedRect( x, y - 64 - 5, 128, 64 ) 
	draw.RoundedBox( 8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color( 60, 60, 60, alpha ) )
	
	self.InfoMarkup:Draw( x+5, y+5, nil, nil, alpha )
	
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha ) -- make the spazzing hud icon
	
	draw.SimpleText( self.IconLetter, "SelectIcons_epistol", x + wide/2, y + tall*0.15, Color( 100, 200, 0, 255 ), TEXT_ALIGN_CENTER )
	

	draw.SimpleText( self.IconLetter, "SelectIcons_epistol", x + wide/2 + math.Rand(-4, 4), y + tall*0.15+ math.Rand(-14, 14), Color( 100, 200, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )
	//draw.SimpleText( self.IconLetter, "SelectIcons_epistol", x + wide/2 + math.Rand(-4, 4), y + tall*0.15+ math.Rand(-9, 9), Color( 100, 200, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )
	
	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
