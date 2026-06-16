--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

game.AddParticles( "particles/drgbase.pcf") 
PrecacheParticleSystem("drg_plasma_ball")

SWEP.Author = "RandomPerson189"
SWEP.Instructions = "Left Click: Say Hakai (The target you're looking at will disintegrate)"
SWEP.Category = "Личное оружие"

SWEP.Spawnable = true 
SWEP.AdminSpawnable = true 
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/v_hands.mdl" 
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ShowWorldModel = false

SWEP.Primary.ClipSize = -1 
SWEP.Primary.DefaultClip = -1 
SWEP.Primary.Automatic = false 
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1  
SWEP.Secondary.DefaultClip = -1    
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none" 

SWEP.DrawAmmo = false

SWEP.HoldType = "normal"

if CLIENT then
	SWEP.PrintName = "Hakai Destruction"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.DrawCrosshair = true
	SWEP.WepSelectIcon = surface.GetTextureID("HUD/swepicons/weapon_hakai/icon")
	
	killicon.Add( "weapon_hakai", "weapons/weapon_hakai", Color(255, 255, 255) )
end

local HakaiSound = Sound ("weapons/hakai.wav")
local DissolveSound = Sound ("weapons/hl2dm_dissolve.wav")

-- ============================================
-- СПИСОК РАЗРЕШЁННЫХ STEAMID (ТОЛЬКО ПО НИМ ДОСТУП)
-- ============================================
local cantakehakay = {
    ["STEAM_0:0:562541572"] = true, -- Frikadelka
    ["STEAM_0:1:22093009"] = true, -- Gero
    ["STEAM_0:1:452003092"] = true, -- Sansey
    ["STEAM_0:1:575732651"] = true, -- Angel
}

function SWEP:Initialize()
	util.PrecacheSound( "weapons/hakai.wav" )
	util.PrecacheSound( "weapons/hl2dm_dissolve.wav" )
	
	self:SetHoldType(self.HoldType)
	self:SetWeaponHoldType(self.HoldType)
	
	if CLIENT then
		-- Create a new table for every weapon instance
		//self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
		
		-- init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
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

function SWEP:Deploy()
	self.Weapon:SetNoDraw( true )
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("admire"))
	vm:SetPlaybackRate( 2.3 )
end 

function SWEP:Reload() 
end 

function SWEP:Think()
	if SERVER then
		-- ПРОВЕРКА ТОЛЬКО ПО STEAMID
		if not cantakehakay[self.Owner:SteamID()] then
			if IsValid(self.Owner) and self.Owner:Alive() then
				self.Owner:Kill()
				rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО STEAMID')
				rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО STEAMID')
				rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО STEAMID')
			end
		end
	end
end

function SWEP:PreDrawViewModel( vm, wep, ply )
	vm:SetMaterial( "engine/occlusionproxy" )
end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:Holster()
	if !IsValid(self) then return end
	
	if ( IsValid( self.Owner ) && CLIENT && self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if ( IsValid( vm ) ) then
			vm:SetMaterial( "" )
		end
	end
	return true
end

function SWEP:PrimaryAttack()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("admire"))
	vm:SetPlaybackRate( 8 )
	
    self.Weapon:EmitSound(HakaiSound, 280)
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.3 )
	
	if CLIENT then return end
	
	self.Owner:PlayScene("scenes/nofuckoff.vcd")
	
	local trace = self.Owner:GetEyeTrace()
	local aimvector = self.Owner:GetAimVector()
	local target = NULL
	
	if trace.Entity:IsPlayer() then
		if !trace.Entity:IsWorld() and !trace.Entity:GetClass() != "worldspawn" then
			target = trace.Entity
		end
	end
	
	self:SetHoldType("magic")
	self:SetWeaponHoldType("magic")
	
 	timer.Simple(.1, function()
	if !IsValid(self) then return end
		self:SetHoldType(self.HoldType)
		self:SetWeaponHoldType(self.HoldType)
		local trace2 = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*1024,
			filter = self.Owner,
			mins = Vector( -8, -8, 8 ),
			maxs = Vector( 8, 8, 8 ),
			mask = MASK_SHOT_HULL,
		} )
		--local trace2 = self.Owner:GetEyeTrace()
		
		if !IsValid(trace2.Entity) then
			for k,v in pairs(ents.FindAlongRay(trace2.HitPos,self.Owner:GetShootPos(),Vector(-8,-8,-8),Vector(8,8,8))) do
				if IsValid(v) and v ~= self.Owner then
					if v:IsPlayer() then
						target = v
					end
				end
			end
		else
			if trace2.Entity:IsPlayer() then
				target = trace2.Entity
			end
		end
		
		if IsValid(target) then
			local ed = EffectData()
			ed:SetOrigin( target:GetPos() )
			ed:SetEntity( target )
			util.Effect( "entity_remove", ed, true, true )
			util.Effect( "entity_remove", ed, true, true )
			util.Effect( "entity_remove", ed, true, true )
			util.Effect( "entity_remove", ed, true, true )
	
			local damage = DamageInfo()
			damage:SetDamage( math.huge )
			damage:SetAttacker( self.Owner )
			damage:SetDamageType( DMG_DISSOLVE )
			damage:SetDamageForce( aimvector*10000 + Vector(0,0,-5000) )
			damage:SetDamagePosition(target:GetPos())
			target:TakeDamageInfo(damage)
			
			local dissolver = ents.Create("env_entity_dissolver")
			dissolver:SetKeyValue("dissolvetype", 1)
			dissolver:SetKeyValue("magnitude", 20)
			dissolver:SetPhysicsAttacker(self.Owner)
			dissolver:SetPos(target:GetPos())
			dissolver:Spawn()
			
			if target:IsPlayer() then
				dissolver:Fire("Dissolve", target:AccountID())
				dissolver:Fire("Kill", "", 0)
			else
				target:SetName("TARGET_NOFUCKOFF")
				
				dissolver:Fire("Dissolve", target:GetName())
				dissolver:Fire("Kill", "", 0)
			end
			
			if !target:GetClass():find("headcrab") and !target:GetClass():find("antlion")
			and !target:GetClass():find("hunter") and !target:GetClass():find("gonarch")
			and !target:GetClass():find("garg") and !target:GetClass():find("turret")
			and !target:GetClass():find("sentry") and !target:GetClass():find("scanner")
			and !target:GetClass():find("houndeye") and !target:GetClass():find("tentacle") then
				//sound.Play(BoomSound,target:GetPos() + Vector(0,0,16),80,100,0.5)
			else
				sound.Play(DissolveSound,target:GetPos() + Vector(0,0,16),70,100)
			end
		end
	end )
	
	local part = ents.Create("info_particle_system")
	part:SetKeyValue("effect_name", "drg_plasma_ball")
	part:SetKeyValue("start_active",tostring(1))
	part:SetLocalPos(self:GetPos())
	part:SetOwner(self)
	part:SetParent(self.Owner)
	part:SetLocalAngles(Angle(0,0,0))
	part:Fire("SetParentAttachment","anim_attachment_RH")
	part:Fire("kill","", 0.3)
	--part:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	part:Spawn()
	part:Activate()
	part:SetSolid(SOLID_NONE)
	part:AddEffects(EF_BONEMERGE)
	self:DeleteOnRemove(part)
end

function SWEP:SecondaryAttack()
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher