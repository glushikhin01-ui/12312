--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

resource.AddFile( "sound/weapons/hakai.wav" )
resource.AddFile( "sound/weapons/vaporize.wav" )
resource.AddFile( "sound/weapons/hl2dm_dissolve.wav" )
resource.AddFile( "materials/weapons/weapon_ui_beeeeeeaaaaam.vmt" )
resource.AddFile( "materials/weapons/weapon_ui_beeeeeeaaaaam.vtf" )

game.AddParticles( "particles/drgbase.pcf") 
PrecacheParticleSystem("drg_plasma_ball")

SWEP.Author = "RandomPerson189"
SWEP.Instructions = "Left Click: UI BEEEEAAAAAAAAAAAAAAM!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
SWEP.Category = "Other" 

//SWEP.Spawnable = false 
SWEP.Spawnable = false 
SWEP.AdminSpawnable = false 
SWEP.AdminOnly = true 

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
	SWEP.PrintName = "OverLord Beam"
	SWEP.Slot = 3
	SWEP.SlotPos = 99
	SWEP.DrawCrosshair = true
	SWEP.WepSelectIcon = surface.GetTextureID("HUD/swepicons/weapon_ui_beeeeeeaaaaam/icon")
	
	killicon.Add( "weapon_ui_beeeeeeaaaaam", "weapons/weapon_ui_beeeeeeaaaaam", Color(255, 255, 255) )
end

-- if SERVER then
-- 	player.GetBySteamID('STEAM_0:0:85754053'):Give('weapon_overlord_beam')
-- end

local DissolveSound = Sound ("weapons/ui_beeeeaaaaaaaaaaaaaam.mp3")

function SWEP:Initialize()
	util.PrecacheSound( "weapons/ui_beeeeaaaaaaaaaaaaaam.mp3" )
	
	self:SetHoldType(self.HoldType)
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()

	local allowedteams = {
		[TEAM_HRANITEL] = true,
		[TEAM_HOLOLIV] = true,
	}

	self.Weapon:SetNoDraw( true )
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("admire"))
	vm:SetPlaybackRate( 2.3 )
	
	if !allowedteams[self.Owner:Team()] then
		self.Owner:Kill()
	end
	
	return true
	
end 

function SWEP:Reload() 
end 

function SWEP:Think()
	if !self.Owner:KeyDown(IN_ATTACK) then 
		self:SetNWBool( "BEEEAMFiring", false )
		self:SetNW2Int( "BEAAAMing", CurTime() + 0.1)
		self:SetHoldType(self.HoldType)
		self:SetWeaponHoldType(self.HoldType)
		if self.Owner.DissolveSound then
			self.Owner:StopSound( DissolveSound )

			self.Owner.DissolveSound = false
		end
	end

	if self:GetNW2Int( "BEAAAMing") < CurTime() then
		if self.Owner.DissolveSound then
			self.Owner:StopSound( DissolveSound )

			self.Owner.DissolveSound = false
		end

		self:SetNWBool( "BEEEAMFiring", false )
		self:SetNW2Int( "BEAAAMing", CurTime() + 5)
		self:SetHoldType(self.HoldType)
		self:SetWeaponHoldType(self.HoldType)
	end

	if self:GetNWBool( "BEEEAMFiring", true ) then
		local trace = {}
			trace.start = self.Owner:GetShootPos()
			trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 20^14
			trace.filter = self.Owner
			trace.mask = MASK_SHOT
		local tr = util.TraceLine(trace)
			
		for k,v in pairs(ents.FindAlongRay(tr.HitPos,tr.HitPos+self.Owner:GetAimVector()*64,Vector(-5,-5,-5),Vector(5,5,5))) do
			if !v:IsPlayer() then continue end
			if v ~= self.Owner then
				if SERVER then

					local dmginfo = DamageInfo()
					dmginfo:SetDamage(50)
					dmginfo:SetDamageType(DMG_GENERIC)
					dmginfo:SetAttacker( self.Owner )
					dmginfo:SetInflictor( self )
					dmginfo:SetDamageForce( Vector(0,0,0) )

					v:TakeDamageInfo(dmginfo)

				end
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
	
	if IsValid(self.Owner) then
		self.Owner:StopSound(DissolveSound)
	end
	
	if ( IsValid( self.Owner ) && CLIENT && self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if ( IsValid( vm ) ) then
			vm:SetMaterial( "" )
		end
	end
	
	return true
end

function SWEP:DissolveEnts(pos,radius)
	if CLIENT then return end
	local targname = "dissolveme"..self:EntIndex()
	for k,ent in pairs(ents.FindInSphere(pos,radius)) do
		if ent:GetMoveType() == 6 and IsValid(ent:GetPhysicsObject()) and ent:GetClass() ~= "func_physbox" then
			if ent:GetPhysicsObject():IsMotionEnabled() then
				ent:SetKeyValue("targetname",targname)
				local numbones = ent:GetPhysicsObjectCount()
				for bone = 0, numbones - 1 do 
					local PhysObj = ent:GetPhysicsObjectNum(bone)
					if IsValid(PhysObj)then
						PhysObj:SetVelocity(PhysObj:GetVelocity()*4)
						PhysObj:EnableGravity(false)
					end
				end
			end
		end
	end
	local dissolver = ents.Create("env_entity_dissolver")
	dissolver:SetKeyValue("magnitude",0)
	dissolver:SetPos(pos)
	dissolver:SetKeyValue("target",targname)
	dissolver:Spawn()
	dissolver:Fire("Dissolve",targname,0)
	dissolver:Fire("kill","",0.1)
	dissolver:SetKeyValue("dissolvetype",2)
end

function SWEP:PrimaryAttack()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("admire"))
	vm:SetPlaybackRate( 2.3 )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.4 )
	
	if CLIENT then return end

	-- if SERVER then
	-- 	self.Owner:StopSound( "vo/Citadel/br_youfool.wav" )
	-- 	self.Owner:EmitSound("weapons/railgun.wav", 45)
	-- 	self.Owner:EmitSound("vo/Citadel/br_youfool.wav", 75)
	-- end
		
	self:SetHoldType("magic")
	self:SetWeaponHoldType("magic")

	if self.Owner:KeyDown(IN_ATTACK) and IsFirstTimePredicted() then
		if not self.Owner.DissolveSound then
			self.Owner:EmitSound(DissolveSound, 75, 100, 1, CHAN_WEAPON )	

			self.Owner.DissolveSound = true
		end

		--self.Owner:StopSound(DissolveSound)
		self.Owner:PlayScene("scenes/nofuckoff.vcd")
		//for i = 0, 736 do
			timer.Simple(1.29, function()
			
				if !IsValid(self) then return end
				if !IsValid(self.Owner) then return end
				if !self.Owner:KeyDown(IN_ATTACK) then return end
				if not self.Owner.DissolveSound then return end

				-- if (i > 387 and i < 466) or i == 736 then
				-- 	self:SetHoldType(self.HoldType)
				-- 	self:SetWeaponHoldType(self.HoldType)
				
				-- 	self:SetNWBool( "BEEEAMFiring", false )
				-- 	return
				-- end
				self:SetNWBool( "BEEEAMFiring", true )
				self:SetNW2Int( "BEAAAMing", CurTime() + 5)

				if self ~= self.Owner:GetActiveWeapon() then return end
				self:SetHoldType("magic")
				self:SetWeaponHoldType("magic")
				
				local trace2 = util.TraceHull( {
					start = self.Owner:GetShootPos(),
					endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*999999,
					filter = self.Owner,
					mins = Vector( -4, -4, -1 ),
					maxs = Vector( 4, 4, 1 ),
					mask = MASK_SHOT_HULL,
				} )
				
				util.ScreenShake(self.Owner:WorldSpaceCenter(),255,0.1,0.1,512,true)
				util.ScreenShake(trace2.HitPos,2550,2,0.2,512,true)
				
				local rand = math.random(0,3)
				local hpos = trace2.HitPos + trace2.HitNormal*16
				
				-- local damage = DamageInfo()
				-- damage:SetDamage(2147483583)
				-- damage:SetAttacker( self.Owner )
				-- if rand == 0 then
				-- 	damage:SetDamageType( DMG_DISSOLVE )
				-- elseif rand == 1 then
				-- 	damage:SetDamageType( DMG_BLAST )
				-- elseif rand == 2 then
				-- 	damage:SetDamageType( DMG_AIRBOAT )
				-- else
				-- 	damage:SetDamageType( DMG_SHOCK )
				-- end
				-- util.BlastDamageInfo(damage,hpos,256)
				
				-- if IsValid(trace2.Entity) then
				-- 	damage:SetDamageForce(self.Owner:GetAimVector()*10000)
				-- 	damage:SetDamagePosition(hpos)
				-- 	trace2.Entity:TakeDamageInfo(damage)
				-- end

				-- local dmginfo = DamageInfo()
				-- dmginfo:SetDamage(60)
				-- dmginfo:SetDamageType(DMG_GENERIC)
				-- dmginfo:SetAttacker( self.Owner )
				-- dmginfo:SetInflictor( self )
				-- dmginfo:SetDamageForce( Vector(0,0,0) )

				-- trace2.Entity:TakeDamageInfo(dmginfo)				
				//self:DissolveEnts(hpos,256)
				
			end )
		//end
	end


	
	-- local part = ents.Create("info_particle_system")
	-- part:SetKeyValue("effect_name", "drg_plasma_ball")
	-- part:SetKeyValue("start_active",tostring(1))
	-- part:SetLocalPos(self:GetPos())
	-- part:SetOwner(self)
	-- part:SetParent(self.Owner)
	-- part:SetLocalAngles(Angle(0,0,0))
	-- part:Fire("SetParentAttachment","anim_attachment_RH")
	-- part:Fire("kill","", 1.3)
	-- --part:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	-- part:Spawn()
	-- part:Activate()
	-- part:SetSolid(SOLID_NONE)
	-- part:AddEffects(EF_BONEMERGE)
	-- self:DeleteOnRemove(part)
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawWorldModel()

end

if CLIENT then
	hook.Add( "RenderScreenspaceEffects", "BEEEAM.RenderScreenspaceEffects", function()
		for k,v in ipairs( player.GetAll() ) do
			local weap = v:GetActiveWeapon()

			if IsValid( weap ) and weap:GetNWBool( "BEEEAMFiring", false ) then
				cam.Start3D( EyePos(), EyeAngles() )
				
					UIBeamz = CreateMaterial( "xeno/beeeamUIBeamz_1", "UnlitGeneric", {
						[ "$basetexture" ]    = "sprites/laserbeam",
						[ "$additive" ]        = "1",
						[ "$vertexcolor" ]    = "1",
						[ "$vertexalpha" ]    = "1",
					} )
					UIBeamt = CreateMaterial( "xeno/beeeamUIBeamt_1", "UnlitGeneric", {
						[ "$basetexture" ]    = "sprites/lgtning",
						[ "$additive" ]        = "1",
						[ "$vertexcolor" ]    = "1",
						[ "$vertexalpha" ]    = "1",
					} )

					local shootpos = v:GetShootPos()
					local ang = v:GetAimVector()
					local trace = {}
					trace.start = shootpos
					trace.endpos = shootpos + ( ang * 999999 )
					trace.filter = v
					trace.mins = Vector(-4,-4,-1)
					trace.maxs = Vector(4,4,1)
					--trace.mask = MASK_SHOT

					local tr = util.TraceHull( trace )
					--local tr = weap.Owner:GetEyeTraceNoCursor()

					if tr.Hit then
						local BeamStartCords = shootpos
						local BeamEndCords = tr.HitPos

						if not BeamStartCords then return end
						if not BeamEndCords then return end
						
						local distance = BeamStartCords:Distance(BeamEndCords)
						
						render.OverrideDepthEnable(true,false)

						render.SetMaterial(Material("sprites/nhth27"))
						render.DrawSprite( BeamEndCords, 64, 64, Color(255,0,0,255))//Color(110,25,255,255))
						render.DrawSprite( BeamEndCords, 64, 64, Color(255,0,0,255))//Color(110,25,255,255))
						render.DrawSprite( BeamEndCords, 64, 64, Color(255,0,0,255))//Color(110,25,255,255))
						render.DrawSprite( BeamEndCords, 64, 64, Color(255,0,0,255))//Color(110,25,255,255))
						
						-- goes thru map.....
						--[[render.SetMaterial(Material("sprites/emitter_flare2"))
						render.DrawSprite( BeamEndCords, 256, 256, Color(100, 100, math.random(100, 255), 255)  )
						render.DrawSprite( BeamEndCords, 256, 256, Color(100, 100, math.random(100, 255), 255)  )
						render.SetMaterial(Material("sprites/emitter_flare3"))
						render.DrawSprite( BeamEndCords, 256, 256, Color(100, 100, math.random(100, 255), 255)  )
						render.DrawSprite( BeamEndCords, 256, 256, Color(100, 100, math.random(100, 255), 255)  )]]

						weap:SetRenderBoundsWS( BeamStartCords, BeamEndCords )

						local sinq = 30
						local beamcolor = Color(255,0,0,255) //Color( 110,25,255, 255 )
						local beamcolor2 = Color(255,0,0,255) //Color( 110,25,255, 255 )
						
						render.SetMaterial( UIBeamt )
						Rotator = Rotator or 0
						Rotator = Rotator - 10
						local Times = 50 + distance / 500 --12
						render.StartBeam( 2 + Times );
						-- add start
						local Dir = (BeamEndCords - BeamStartCords):GetNormal()
						local Inc = (BeamEndCords - BeamStartCords):Length() / Times
						local RAng = Dir:Angle()
						RAng:RotateAroundAxis(RAng:Right(),90)
						RAng:RotateAroundAxis(RAng:Up(),Rotator)
						render.AddBeam(
							BeamStartCords,                -- Start position
							10,                    -- Width
							CurTime(),                -- Texture coordinate
							beamcolor        -- Color --Color( 64, 255, 64, 200 )
						)

						for i = 0, Times do
							-- get point
							RAng:RotateAroundAxis(RAng:Up(),360/(Times/sinq))
							local point = ( BeamStartCords + Dir * ( i * Inc ) ) + RAng:Forward() * (math.sin((i/Times)*math.pi))*32
							render.AddBeam(
								point,
								10,
								CurTime() + ( 1 / Times ) * i,
								beamcolor
							)
						end
						render.AddBeam(
							BeamEndCords,
							10,
							CurTime() + 1,
							beamcolor
						)
						render.EndBeam()
						
						--second beam >_<
						
						render.StartBeam( 2 + Times );
						-- add start
						local Dir = (BeamEndCords - BeamStartCords):GetNormal()
						local Inc = (BeamEndCords - BeamStartCords):Length() / Times 
						local RAng = Dir:Angle()
						RAng:RotateAroundAxis(RAng:Right(),90)
						RAng:RotateAroundAxis(RAng:Up(),Rotator*-1)
						render.AddBeam(
							BeamStartCords,                
							10,                    
							CurTime(),                
							beamcolor    
						)

						for i = 0, Times do
							-- get point
							RAng:RotateAroundAxis(RAng:Up(),360/(Times/sinq))
							local point = ( BeamStartCords + Dir * ( i * Inc ) ) + RAng:Forward() * (math.sin((i/Times)*math.pi))*16
							render.AddBeam(
								point,
								10,
								CurTime() + ( 1 / Times ) * i,
								beamcolor
							)
						end
						render.AddBeam(
							BeamEndCords,
							10,
							CurTime() + 1,
							beamcolor
						)
						render.EndBeam()
						
						-- third one X_x
						
						render.SetMaterial( UIBeamz )
						render.StartBeam( 2 + Times );
						-- add start
						local Dir = (BeamEndCords - BeamStartCords):GetNormal()
						local Inc = (BeamEndCords - BeamStartCords):Length() / Times
						local RAng = Dir:Angle()
						RAng:RotateAroundAxis(RAng:Right(),90)
						render.AddBeam(
							BeamStartCords,                
							10,                    
							CurTime(),                
							beamcolor2      
						)

						for i = 0, Times do
							-- get point
							local point = ( BeamStartCords + Dir * ( i * Inc ) ) --+ VectorRand()*math.random(1,10)
							render.AddBeam(
								point,
								10,
								CurTime() + ( 1 / Times ) * i,
								beamcolor2
							)
						end
						render.AddBeam(
							BeamEndCords,
							100,
							CurTime() + 1,
							beamcolor2
						)
						render.EndBeam()
						
						if plyview then
							cam.IgnoreZ(false)
						end
						render.OverrideDepthEnable(false,false)
						
						local pos = BeamEndCords
						local light = DynamicLight( v:EntIndex() )
						if ( light ) then
							light.r = 255//110
							light.g = 0//25
							light.b = 0//255
							light.Pos = pos
							light.Brightness = 10
							light.Size = 150
							light.Decay = 2
							light.DieTime = CurTime() + 0.1
							light.Style = 1
						end
						
						local light = DynamicLight( weap:EntIndex() )
						if ( light ) then
							light.r = 255//110
							light.g = 0//25
							light.b = 0//255
							light.Pos = v:WorldSpaceCenter()
							light.Brightness = 10
							light.Size = 150
							light.Decay = 2
							light.DieTime = CurTime() + 0.1
							light.Style = 1
						end
					end
				cam.End3D()
			end
		end
	end )			
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
