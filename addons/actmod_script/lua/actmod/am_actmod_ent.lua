if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaEnt = true

-- A_AdPa = {AddParticle = function(gN,gP) game.AddParticles(gN) for k,v in ipairs(gP) do PrecacheParticleSystem(v) end end}

-- A_AdPa.AddParticle("particles/portal_projectile.pcf",{
-- "portal_1_badsurface","portal_1_badsurface_","portal_1_badvolume","portal_1_badvolume_",
-- "portal_1_cleanser","portal_1_near","portal_1_near_in","portal_1_near_out","portal_1_near_warp",
-- "portal_1_nofit","portal_1_nofit_warp","portal_1_overlap","portal_1_overlap__","portal_1_overlap_glow",
-- "portal_1_overlap_glow_nomove","portal_1_overlap_oval","portal_1_overlap_warp","portal_1_overlap_warp_fast",
-- "portal_1_projectile_3rdperson","portal_1_projectile_ball","portal_1_projectile_ball_3rdperson","portal_1_projectile_fiber",
-- "portal_1_projectile_stream","portal_1_projectile_stream_pedestal","portal_1_projectile_trail","portal_1_success",
-- "portal_2_badsurface","portal_2_badsurface_","portal_2_badvolume","portal_2_badvolume_","portal_2_cleanser","portal_2_cleanser_old",
-- "portal_2_near","portal_2_near_in","portal_2_near_out","portal_2_nofit","portal_2_overlap","portal_2_overlap_",
-- "portal_2_projectile_3rdperson","portal_2_projectile_ball","portal_2_projectile_ball_3rdperson","portal_2_projectile_fiber",
-- "portal_2_projectile_stream","portal_2_projectile_stream_pedestal","portal_2_projectile_trail","portal_2_success"
-- })

-- A_AdPa.AddParticle("particles/portal_projectile.pcf",{
-- "portal_1_projectile_3rdperson","portal_1_projectile_ball"
-- ,"portal_2_projectile_3rdperson","portal_2_projectile_ball"
-- })



if CLIENT then

	local function aAlight(ent,a1,a2,a3,a4,a5,a6)
		if ent and IsValid(ent) then
			local dlight = DynamicLight( ent:EntIndex() )
			if ( dlight ) then
				dlight.pos = ent:GetPos() + ent:GetForward()*a1[1] + ent:GetRight()*a1[2] + ent:GetUp()*a1[3]
				dlight.r = a2[1]
				dlight.g = a2[2]
				dlight.b = a2[3]
				dlight.brightness = a3
				dlight.decay = a4
				dlight.size = a5
				dlight.dietime = CurTime() + a6
			end
		end
	end
	local function aRemovEff(TParticle)
		-- print("PEntity[-]",TParticle,TParticle and istable(TParticle))
		if TParticle and istable(TParticle) then
			-- PrintTable(TParticle)
			for k, v in pairs( TParticle ) do v:SetDieTime( 0 ) v:SetLifeTime( 5 ) end
		end
	end
	
local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0"..math.random(0,1),ent)
	self.Particle:SetVelocity( VectorRand() * 25 )
	self.Particle:SetAirResistance( math.Rand(50,100) ) 
	self.Particle:SetDieTime(math.random(0.2,0.4))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(2,4))
	self.Particle:SetEndSize(math.random(4,1))
	self.Particle:SetRoll( math.random(-90,90) )
	emitter:Finish()
	if math.random(3) == 2 then
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0"..math.random(0,3),ent)
	self.Particle:SetVelocity( VectorRand() * 20 )
	self.Particle:SetDieTime(math.random(0.1,0.4))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(1,6))
	self.Particle:SetEndSize(math.random(6,1))
	self.Particle:SetColor(math.random(255),math.random(255),math.random(255))
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_kpop_02_e1", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_ring_wave",ent)
	self.Particle:SetDieTime(0.5)
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(5)
	self.Particle:SetEndSize(10)
	self.Particle:SetColor(255,255,255)
	emitter:Finish()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_glow_02",ent)
	self.Particle:SetDieTime(0.2)
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(10)
	self.Particle:SetEndSize(5)
	self.Particle:SetColor(255,255,255)
	emitter:Finish()
	for i=1,math.random(10,20) do
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_glow_03",ent)
	self.Particle:SetVelocity( Vector( 0, 0, 30 ) + VectorRand() * 100 )
	self.Particle:SetAirResistance( math.Rand(200,600) ) 
	self.Particle:SetDieTime(math.random(0.4,0.6))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(2,10))
	self.Particle:SetEndSize(math.random(10,2))
	self.Particle:SetColor(math.random(255),math.random(255),math.random(255))
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetCollide( false )
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_kpop_02_e2" )

local EFFECT = {}
function EFFECT:Init(data)
	for i=1,math.random(2,6) do
	local ent = data:GetOrigin()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0"..math.random(0,1),ent)
	self.Particle:SetDieTime(0.4)
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(5)
	self.Particle:SetEndSize(6)
	emitter:Finish()
	if math.random(3) == 2 then
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0"..math.random(0,3),ent)
	self.Particle:SetVelocity( VectorRand() * 150 )
	self.Particle:SetAirResistance( math.Rand(200,600) )
	self.Particle:SetDieTime(math.random(0.1,0.4))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(1,6))
	self.Particle:SetEndSize(math.random(6,1))
	self.Particle:SetColor(math.random(255,255),math.random(200,255),math.random(200,255))
	self.Particle:SetRoll( math.random(-90,90) )
	emitter:Finish()
	end
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_kpop_02_e3", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0"..math.random(0,1),ent)
	self.Particle:SetVelocity( VectorRand() * 25 )
	self.Particle:SetAirResistance( math.Rand(50,100) ) 
	self.Particle:SetDieTime(math.random(0.2,0.4))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(2,4))
	self.Particle:SetEndSize(math.random(4,1))
	self.Particle:SetRoll( math.random(-90,90) )
	emitter:Finish()
	if math.random(3) == 2 then
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0"..math.random(0,3),ent)
	self.Particle:SetVelocity( VectorRand() * 20 )
	self.Particle:SetDieTime(math.random(0.2,0.4))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(1,6))
	self.Particle:SetEndSize(math.random(6,1))
	self.Particle:SetRoll( math.random(0,3) )
	self.Particle:SetColor(math.random(255),math.random(255),math.random(255))
	emitter:Finish()
	end
	if math.random(5) == 2 then
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_star_0"..math.random(1,4),ent)
	self.Particle:SetVelocity( VectorRand() * 5 )
	self.Particle:SetDieTime(math.random(0.3,0.5))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(1,6))
	self.Particle:SetEndSize(math.random(6,1))
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetColor(math.random(255),math.random(255),math.random(255))
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_kpop_04_e1", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_love_01",ent+Vector( 0, 0, -15 ))
	self.Particle:SetVelocity( Vector( 0, 0, 50 ) )
	self.Particle:SetDieTime(0.4)
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(2)
	self.Particle:SetEndSize(15)
	self.Particle:SetColor(255,255,255)
	emitter:Finish()
	for i=1,math.random(10,20) do
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0"..math.random(0,1),ent+Vector( 0, 0, -15 ))
	self.Particle:SetVelocity( Vector( 0, 0, 150 ) + VectorRand() * 200 )
	self.Particle:SetAirResistance( math.Rand(200,600) ) 
	self.Particle:SetDieTime(math.random(0.2,0.6))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(1,3))
	self.Particle:SetEndSize(math.random(3,1))
	self.Particle:SetColor(255,255,255)
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, 100 ) )
	self.Particle:SetCollide( false )
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_kpop_04_e2", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent)
	self.Particle:SetDieTime(0.3)
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(2)
	self.Particle:SetEndSize(8)
	self.Particle:SetColor(255,105,255)
	emitter:Finish()
	-- for i=1,math.random(2,4) do
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_glow_03",ent)
	self.Particle:SetVelocity( VectorRand() * 30 )
	self.Particle:SetAirResistance( math.Rand(200,400) ) 
	self.Particle:SetDieTime(math.Rand(0.4,0.5))
	self.Particle:SetStartAlpha(155)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(2,10))
	self.Particle:SetEndSize(math.random(10,2))
	self.Particle:SetColor(255,105,255)
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, 0 ) )
	self.Particle:SetCollide( false )
	emitter:Finish()
	-- end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_kpop_04_e3", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_ring_wave",ent)
	self.Particle:SetDieTime(0.5)
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(5)
	self.Particle:SetEndSize(20)
	self.Particle:SetColor(255,255,255)
	emitter:Finish()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_glow_02",ent)
	self.Particle:SetDieTime(0.2)
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(20)
	self.Particle:SetEndSize(5)
	self.Particle:SetColor(255,255,255)
	emitter:Finish()
	for i=1,math.random(10,20) do
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_glow_03",ent)
	self.Particle:SetVelocity( Vector( 0, 0, 30 ) + VectorRand() * 200 )
	self.Particle:SetAirResistance( math.Rand(200,600) ) 
	self.Particle:SetDieTime(math.random(0.4,0.6))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(2,10))
	self.Particle:SetEndSize(math.random(10,2))
	self.Particle:SetColor(math.random(255),math.random(255),math.random(255))
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, 100 ) )
	self.Particle:SetCollide( false )
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_kpop_04_e4", true )



local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	for i=1,math.random(1,2) do
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/shgr_"..math.random(1,2),ent)
	self.Particle:SetVelocity( Vector( 0, 0, 20 ) + VectorRand() * 50 )
	self.Particle:SetAirResistance( math.Rand(200,600) ) 
	self.Particle:SetDieTime(math.random(0.6,1.3))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
local sr = math.random(0.3,1.2)
	self.Particle:SetStartSize(sr)
	self.Particle:SetEndSize(sr)
	self.Particle:SetColor(math.random(50,80),math.random(50,60),20)
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, -100 ) )
	self.Particle:SetCollide( true )
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_chelead_e1", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	for i=1,math.random(3,7) do
		local emitter = ParticleEmitter(ent)
		if emitter and IsValid( emitter ) then
		self.Particle = emitter:Add("actmod/eff_particle/shgr_"..math.random(1,2),ent)
		self.Particle:SetVelocity( Vector( 0, 0, 30 ) + VectorRand() * 100 )
		self.Particle:SetAirResistance( math.Rand(200,600) ) 
		self.Particle:SetDieTime(math.random(0.4,0.6))
		self.Particle:SetStartAlpha(255)
		self.Particle:SetEndAlpha(0)
		local sr = math.random(0.3,1.2)
		self.Particle:SetStartSize(sr)
		self.Particle:SetEndSize(sr)
		self.Particle:SetColor(math.random(50,80),math.random(50,60),20)
		self.Particle:SetRoll( math.Rand(-1,1) )
		self.Particle:SetGravity( Vector( 0, 0, -100 ) )
		self.Particle:SetCollide( false )
		emitter:Finish()
		end
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_chelead_e2", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	for i=1,math.random(12,20) do
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("particles/smokey",ent)
	self.Particle:SetVelocity( Vector( 0, 0, 120 ) + VectorRand() * 60 )
	self.Particle:SetAirResistance( math.Rand(200,600) ) 
	self.Particle:SetDieTime(math.random(0.5,0.7))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(1,7))
	self.Particle:SetEndSize(math.random(8,1))
	self.Particle:SetColor(math.random(50,80),math.random(50,60),20)
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, -200 ) )
	self.Particle:SetCollide( true )
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_toudo_dance", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_00",ent)
	self.Particle:SetVelocity( Vector( 0, 0, 0 ) )
	self.Particle:SetDieTime(math.random(0.5,0.7))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(15)
	self.Particle:SetEndSize(3)
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, -20 ) )
	for i=1,math.random(12,20) do
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_glow_0"..math.random(1,2),ent)
	self.Particle:SetVelocity( Vector( 0, 0, 120 ) + VectorRand() * 60 )
	self.Particle:SetAirResistance( math.Rand(200,600) ) 
	self.Particle:SetDieTime(math.random(0.2,0.5))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(math.random(1,7))
	self.Particle:SetEndSize(math.random(8,1))
	self.Particle:SetColor(math.random(0,255),math.random(0,255),math.random(0,255))
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, -200 ) )
	self.Particle:SetCollide( true )
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_cerealbox", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	for i=1,math.random(1,3) do
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent)
	self.Particle:SetVelocity( Vector( 0, 0, -10 ) + VectorRand() * 30 )
	self.Particle:SetAirResistance( math.Rand(100,400) ) 
	self.Particle:SetDieTime(math.random(0.3,0.5))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(2)
	self.Particle:SetEndSize(1)
	self.Particle:SetColor(math.random(255,244),math.random(255,244),20)
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, -550 ) )
	self.Particle:SetCollide( true )
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_1cerealbox", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	for i=1,math.random(1,3) do
	local emitter = ParticleEmitter(ent)
	self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent)
	self.Particle:SetVelocity( Vector( 0, 0, 50 ) + VectorRand() * 30 )
	self.Particle:SetAirResistance( math.Rand(100,400) ) 
	self.Particle:SetDieTime(math.random(0.3,0.5))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(2)
	self.Particle:SetEndSize(1)
	self.Particle:SetColor(math.random(255,244),math.random(255,244),20)
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, -200 ) )
	self.Particle:SetCollide( true )
	emitter:Finish()
	end
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_2cerealbox", true )

local EFFECT = {}
function EFFECT:Init(data)
	local ent = data:GetOrigin()
	local emitter = ParticleEmitter(ent)
	local mat = "actmod/eff_particle/icmoney_v2"
	if math.random(1,2) == 2 then mat = "actmod/eff_particle/icmoney2_v2" end
	self.Particle = emitter:Add(mat,ent)
	self.Particle:SetVelocity( Vector( 0, 0, 140 ) + VectorRand() * 60 )
	self.Particle:SetAirResistance( math.Rand(200,600) ) 
	self.Particle:SetDieTime(math.random(0.7,1.5))
	self.Particle:SetStartAlpha(255)
	self.Particle:SetEndAlpha(0)
	self.Particle:SetStartSize(3)
	self.Particle:SetEndSize(3)
	self.Particle:SetRoll( math.Rand(-1,1) )
	self.Particle:SetGravity( Vector( 0, 0, -550 ) )
	self.Particle:SetCollide( true )
	emitter:Finish()
end function EFFECT:Think() end function EFFECT:Render() end
effects.Register( EFFECT, "am_f_make_rain_v2", true )



	local EFFECT = {}
	function EFFECT:Init(ed)
		local vOrig = ed:GetOrigin()
		self.Emitter = ParticleEmitter(vOrig)
		for i=1,7 do
			local sparks = self.Emitter:Add("effects/spark", vOrig)
			if (sparks) then
				sparks:SetColor(100, 200, 255)
				sparks:SetVelocity(Vector(math.random(-130, 130),math.random(-130, 130),math.random(50, 100)))
				sparks:SetDieTime(math.Rand(0.3, 0.7))
				sparks:SetLifeTime(math.Rand(0.4, 0.4))
				sparks:SetStartSize(6)
				sparks:SetStartAlpha(255)
				sparks:SetStartLength(13)
				sparks:SetEndLength(5)
				sparks:SetEndSize(5)
				sparks:SetEndAlpha(255)
				sparks:SetGravity(Vector(0,0,-150))
			end
		end
		local sparks2 = self.Emitter:Add("effects/strider_muzzle", vOrig)
		if (sparks2) then
			sparks2:SetVelocity(Vector(-1,0,0))
			sparks2:SetColor(150, 200, 255)
			sparks2:SetDieTime(0.1)
			-- sparks2:SetLifeTime(0)
			sparks2:SetStartSize(10)
			sparks2:SetStartAlpha(255)
			sparks2:SetEndSize(25)
			sparks2:SetEndAlpha(0)
			sparks2:SetRoll( math.Rand(-1,1) )
		end
	end
	function EFFECT:Think() return false end
	function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_elecfle2_01", true )
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetOrigin()
		local emitter = ParticleEmitter(ent)
		self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent)
		self.Particle:SetDieTime(0.2)
		self.Particle:SetStartAlpha(255)
		self.Particle:SetEndAlpha(0)
		self.Particle:SetStartSize(8)
		self.Particle:SetEndSize(1)
		self.Particle:SetColor(100,200,255)
		emitter:Finish()
		for i=1,math.random(2,5) do
		local emitter = ParticleEmitter(ent)
		self.Particle = emitter:Add("actmod/eff_particle/p_glow_03",ent)
		self.Particle:SetVelocity( VectorRand() * 10 )
		self.Particle:SetAirResistance( math.Rand(200,600) ) 
		self.Particle:SetDieTime(0.4)
		self.Particle:SetStartAlpha(155)
		self.Particle:SetEndAlpha(0)
		self.Particle:SetStartSize(math.random(2,10))
		self.Particle:SetEndSize(math.random(10,2))
		self.Particle:SetColor(150,200,255)
		emitter:Finish()
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_elecfle2_02", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetOrigin()
		for i=1,math.random(3,7) do
		local emitter = ParticleEmitter(ent)
		self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent)
		self.Particle:SetVelocity( Vector( 0, 0, 50 ) + VectorRand() * 130 )
		self.Particle:SetAirResistance( math.Rand(100,400) ) 
		self.Particle:SetDieTime(math.random(0.3,0.5))
		self.Particle:SetStartAlpha(255)
		self.Particle:SetEndAlpha(0)
		self.Particle:SetStartSize(math.Rand(3,5))
		self.Particle:SetEndSize(1)
		self.Particle:SetColor(math.random(100,130),math.random(200,230),255)
		self.Particle:SetGravity( Vector( 0, 0, -250 ) )
		self.Particle:SetCollide( true )
		emitter:Finish()
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_elecfle2_03", true )
	
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetOrigin()
		local emitter = ParticleEmitter(ent)
		self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent)
		self.Particle:SetDieTime(0.3)
		self.Particle:SetStartAlpha(255)
		self.Particle:SetEndAlpha(0)
		self.Particle:SetStartSize(8)
		self.Particle:SetEndSize(5)
		self.Particle:SetColor(255,155,255)
		emitter:Finish()
		for i=1,math.random(20,30) do
		local emitter = ParticleEmitter(ent)
		self.Particle = emitter:Add("actmod/eff_particle/p_glow_03",ent)
		self.Particle:SetVelocity( VectorRand() * 50 )
		self.Particle:SetAirResistance( math.Rand(200,600) ) 
		self.Particle:SetDieTime(math.random(0.1,0.3))
		self.Particle:SetStartAlpha(math.Rand(155,255))
		self.Particle:SetEndAlpha(0)
		self.Particle:SetStartSize(math.random(2,10))
		self.Particle:SetEndSize(math.random(20,10))
		self.Particle:SetColor(255,105,255)
		self.Particle:SetRoll( math.Rand(-1,1) )
		self.Particle:SetGravity( Vector( 0, 0, 20 ) )
		self.Particle:SetCollide( false )
		emitter:Finish()
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_poki_e1", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetOrigin()
		local emitter = ParticleEmitter(ent)
		self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent)
		self.Particle:SetDieTime(0.2)
		self.Particle:SetStartAlpha(255)
		self.Particle:SetEndAlpha(0)
		self.Particle:SetStartSize(5)
		self.Particle:SetEndSize(2)
		self.Particle:SetColor(255,255,255)
		emitter:Finish()
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_poki_e2", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetOrigin()
		for i=1,math.random(5,10) do
		local emitter = ParticleEmitter(ent)
		self.Particle = emitter:Add("actmod/eff_particle/p_glow_03",ent)
		self.Particle:SetVelocity( VectorRand() * 50 )
		self.Particle:SetAirResistance( math.Rand(200,600) ) 
		self.Particle:SetDieTime(math.random(0.4,0.3))
		self.Particle:SetStartAlpha(0)
		self.Particle:SetEndAlpha(255)
		self.Particle:SetStartSize(8)
		self.Particle:SetEndSize(0)
		self.Particle:SetColor(255,105,255)
		self.Particle:SetRoll( math.Rand(-1,1) )
		self.Particle:SetGravity( Vector( 0, 0, 20 ) )
		self.Particle:SetCollide( false )
		emitter:Finish()
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_poki_e3", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetOrigin()
		local emitter = ParticleEmitter(ent)
		self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent)
		self.Particle:SetDieTime(0.4)
		self.Particle:SetStartAlpha(255)
		self.Particle:SetEndAlpha(0)
		self.Particle:SetStartSize(15)
		self.Particle:SetEndSize(5)
		self.Particle:SetColor(255,255,255)
		emitter:Finish()
		for i=1,math.random(20,30) do
		local emitter = ParticleEmitter(ent)
		self.Particle2 = emitter:Add("actmod/eff_particle/p_glow_03",ent)
		self.Particle2:SetVelocity( Vector(0,0,math.Rand(100,-100)) )
		self.Particle2:SetAirResistance( math.Rand(200,600) ) 
		self.Particle2:SetDieTime(math.random(0.1,0.3))
		self.Particle2:SetStartAlpha(math.Rand(155,255))
		self.Particle2:SetEndAlpha(0)
		self.Particle2:SetStartSize(math.random(2,10))
		self.Particle2:SetEndSize(math.random(20,10))
		self.Particle2:SetColor(210,255,200)
		self.Particle2:SetRoll( math.Rand(-1,1) )
		self.Particle2:SetGravity( Vector( 0, 0, 20 ) )
		self.Particle2:SetCollide( false )
		emitter:Finish()
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_adoration1", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetEntity()
		local Ori = data:GetOrigin()
		if ent:LookupBone("ValveBiped.Bip01_L_Hand") then Ori = ent:GetBonePosition( ent:LookupBone("ValveBiped.Bip01_L_Hand") ) end -- + pl:GetForward()*
		for i=1,math.random(20,30) do
		local emitter = ParticleEmitter(Ori)
		self.Particle2 = emitter:Add("actmod/eff_particle/p_glow_03",Ori)
		self.Particle2:SetVelocity( Vector(0,0,math.Rand(100,-100)) )
		self.Particle2:SetAirResistance( math.Rand(200,600) ) 
		self.Particle2:SetDieTime(math.random(0.1,0.3))
		self.Particle2:SetStartAlpha(math.Rand(155,255))
		self.Particle2:SetEndAlpha(0)
		self.Particle2:SetStartSize(math.random(2,10))
		self.Particle2:SetEndSize(math.random(20,10))
		self.Particle2:SetColor(210,255,200)
		self.Particle2:SetRoll( math.Rand(-1,1) )
		self.Particle2:SetGravity( Vector( 0, 0, 20 ) )
		self.Particle2:SetCollide( false )
		emitter:Finish()
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_adoration2", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetOrigin()
		local afff = data:GetScale()
		local emitter = ParticleEmitter(ent)
		self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent)
		self.Particle:SetDieTime(0.2)
		self.Particle:SetStartAlpha(255)
		self.Particle:SetEndAlpha(0)
		self.Particle:SetStartSize(5)
		self.Particle:SetEndSize(2)
		self.Particle:SetColor(255,255,255)
		emitter:Finish()
		if afff and afff > 1 then
			for i=1,math.random(1,afff) do
				local emitter = ParticleEmitter(ent)
				self.Particle = emitter:Add("actmod/eff_particle/p_glow_03",ent)
				self.Particle:SetVelocity( VectorRand() * 150 )
				self.Particle:SetAirResistance( math.Rand(200,600) ) 
				self.Particle:SetDieTime(math.random(0.5,0.9))
				self.Particle:SetStartAlpha(0)
				self.Particle:SetEndAlpha(255)
				self.Particle:SetStartSize(8)
				self.Particle:SetEndSize(0)
				self.Particle:SetColor(235,255,255)
				self.Particle:SetRoll( math.Rand(-1,1) )
				self.Particle:SetGravity( Vector( 0, 0, -50 ) )
				self.Particle:SetCollide( true )
				emitter:Finish()
			end
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_sf_e1", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetOrigin()
		for i=1,math.random(4,8) do
			local emitter = ParticleEmitter(ent)
			self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",ent+Vector(math.random(-5,5),math.random(-5,5),math.random(2,5)))
			self.Particle:SetDieTime(math.random(1.5,2.5))
			self.Particle:SetStartAlpha(255)
			self.Particle:SetEndAlpha(0)
			self.Particle:SetStartSize(9)
			self.Particle:SetEndSize(1)
			self.Particle:SetColor(50,255,255)
			self.Particle:SetGravity( Vector( 0, 0, -1 ) )
			emitter:Finish()
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_sf_e2", true )

	local function erf(selfEO,DFRU,ARt,a3R,a4R,a5R,a6R,a7R,a8R,a9R,a10R,Colid,own)
		local self,ent,Ori,aMat = selfEO[1],selfEO[2],selfEO[3],selfEO[4]
		local emitter = ParticleEmitter(Ori)
		local a1Vector = Vector(0,0,DFRU[4])
		local a2sAr = ARt or 0
		local a3randw = a3R[1] or 0.5
		local a3_lifw = -1
		local a4randw = a4R[1] or 255
		local a5randw = a5R[1] or 0
		local a6randw = a6R[1] or 5
		local a7randw = a7R[1] or 1
		local a8col = a8R or {255,255,255}
		local a9randw = a9R or 0
		local a10randw = Vector( a10R[1], a10R[2], a10R[3] ) or Vector( 0, 0, 0 )
		local SColid = Colid or false
		if DFRU[5] then a1Vector = Vector(0,0,math.Rand(DFRU[4],DFRU[5])) end
		if a3R[2] and a3R[2] > -1 then a3randw = math.random(a3R[1],a3R[2]) end
		if a3R[3] then a3_lifw = a3R[3] end
		if a4R[2] then a4randw = math.random(a4R[1],a4R[2]) end
		if a5R[2] then a5randw = math.random(a5R[1],a5R[2]) end
		if a6R[2] then a6randw = math.random(a6R[1],a6R[2]) end
		if a7R[2] then a7randw = math.random(a7R[1],a7R[2]) end
		if a9R[2] then a9randw = math.Rand(a9R[1],a9R[2]) end
		if emitter then
		self.Particle = emitter:Add(aMat,Ori)
		if ent then
			self.Particle:SetVelocity( ent:GetForward()*DFRU[1] + ent:GetRight()*DFRU[2] + ent:GetUp()*DFRU[3] + a1Vector )
		else
			self.Particle:SetVelocity( Vector( DFRU[1], DFRU[2], DFRU[3] ) + a1Vector )
		end
		self.Particle:SetAirResistance( a2sAr ) 
		if a3_lifw > -1 then self.Particle:SetLifeTime(a3_lifw) end
		self.Particle:SetDieTime(a3randw)
		if a3R[4] then
			if a3R[4][1] then self.Particle:SetStartLength(a3R[4][1]) end
			if a3R[4][2] then self.Particle:SetEndLength(a3R[4][2]) end
		end
		if a3R[5] then self.Particle:SetRollDelta(a3R[5]) end
		
		self.Particle:SetStartAlpha(a4randw)
		self.Particle:SetEndAlpha(a5randw)
		self.Particle:SetStartSize(a6randw)
		self.Particle:SetEndSize(a7randw)
		self.Particle:SetColor(a8col[1],a8col[2],a8col[3])
		self.Particle:SetRoll( a9randw )
		self.Particle:SetGravity( a10randw )
		self.Particle:SetCollide( SColid )
		emitter:Finish()
		if own then return self.Particle else end
		end
	end
	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetEntity()
		if ent and IsValid(ent) and ent:LookupBone("ValveBiped.Bip01_L_Hand") then
			local Ori = ent:GetBonePosition( ent:LookupBone("ValveBiped.Bip01_L_Hand") )
			for i=1,math.random(25,50) do
				erf({self,ent,Ori,"actmod/eff_particle/p_i_ligtstar_00"},{math.random(35,150),math.random(50,-50),0,60,-60},math.random(100,200) ,{0.6,1.2} ,{255},{0} ,{1,2},{3,5} ,{200,255,255} ,{-1,1} ,{0,0,20},false)
			end
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_adoration3", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local Ori = data:GetOrigin()
		erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00"}
		,{0,0,0,0},0
		,{0.2,0.6}  ,{255},{0}  ,{4,3},{0.4,0.2}
		,{255,255,255} ,{-1,1} ,{0,0,-20},false)
		for i=1,math.random(10,5) do
			erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00"}
			,{math.random(50,-50),math.random(50,-50),math.random(50,-50),0},math.random(100,200)
			,{0.2,0.4}  ,{255},{0}  ,{2,1},{0.4,0.2}
			,{255,255,255} ,{-1,1} ,{0,0,-20},false)
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_hoist", true )
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local Ori = data:GetOrigin()
		erf({self,nil,Ori+Vector( math.random(-1,1), math.random(-1,1), math.random(-1,1) ),"actmod/eff_particle/p_i_ligtstar_00"}
		,{math.random(7,-7),math.random(7,-7),math.random(7,-7),0},math.random(10,50)
		,{0.2,0.4}  ,{255},{0}  ,{2,2.5},{0.5,0.2}
		,{math.random(100,255),math.random(0,200),255} ,{-1,1} ,{0,0,-10},false)
		for i=1,math.random(1,3) do
			erf({self,nil,Ori+Vector( math.random(-4,4), math.random(-4,4), math.random(-2,2) ),"actmod/eff_particle/p_i_ligtstar_00"}
			,{math.random(-50,50),math.random(-50,50),math.random(-50,50),0},math.random(150,200)
			,{0.2,0.6}  ,{255},{0}  ,{2,0.1},{0.1,2}
			,{math.random(100,255),math.random(0,200),255} ,{-1,1} ,{0,0,-20},false)
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_selene_1", true )
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local Ori = data:GetOrigin()
		local ent = data:GetEntity()
		self.PEntity = ent
		self.TParticle = {} --self.Particle
		erf({self,nil,Ori,"actmod/eff_particle/p_ring_wave"}
		,{0,0,0,0},0
		,{0.4,0.3}  ,{255},{0}  ,{15,18},{65,60}
		,{255,255,255} ,{-1,1} ,{0,0,-10},false)
		for i=1,math.random(50,30) do
			self.TParticle[i] = erf({self,nil,Ori+Vector( math.random(-2,2), math.random(-2,2), math.random(-1,1) ),"actmod/eff_particle/p_glow_03"}
			,{math.random(-200,200), math.random(-200,200), math.random(-200,200),math.random(-1,15)},math.random(100,200)
			,{4.5,5}  ,{255},{0}  ,{15,16},{0.4,0.1}
			,{math.random(100,255),math.random(0,200),255} ,{-1,1} ,{0,0,-90},false,true)
		end
		if IsValid(self.PEntity) then
			self.PEntity.TParticle = self.TParticle
			self.PEntity:CallOnRemove( "RemoveEnt", function( ent ) -- print("PEntity[-]",ent.TParticle,ent.TParticle and istable(ent.TParticle))
				if ent.TParticle and istable(ent.TParticle) then -- PrintTable(ent.TParticle)
					for k, v in pairs( ent.TParticle ) do
						-- if IsValid(v) then v:Remove() end
						v:SetDieTime( 0 )
					end
				end
			end)
		end
	end
	function EFFECT:Think()
		if self.PEntity then
			if IsValid(self.PEntity) then
			else
				if self.TParticle and istable(self.TParticle) then for k, v in pairs( self.TParticle ) do v:SetDieTime( 0 ) end end
			end
		end
	end
	function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_selene_2", true )
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local Ori = data:GetOrigin()
		erf({self,nil,Ori,"actmod/eff_particle/e_smok".. math.random(1,2)}
		,{0,0,0,0},0
		,{0.7,-1,0.5}  ,{150},{0}  ,{10,13},{19,15}
		,{255,255,255} ,{-1,1} ,{0,0,0},false)
		erf({self,nil,Ori,"actmod/eff_particle/e_bim"}
		,{0,0,0,0},0
		,{0.5}  ,{255},{0}  ,{10,13},{10,13}
		,{255,255,255} ,{-1,1} ,{0,0,0},false)
		
			-- local emitter = ParticleEmitter(Ori)
			-- self.Particle = emitter:Add("actmod/eff_particle/p_glow_01",Ori)
			-- self.Particle:SetDieTime(0.8)
			-- self.Particle:SetStartAlpha(255)
			-- self.Particle:SetEndAlpha(0)
			-- self.Particle:SetStartSize(9)
			-- self.Particle:SetEndSize(9)
			-- self.Particle:SetColor(50,255,255)
			-- self.Particle:SetGravity( Vector( 0, 0, -1 ) )
			-- self.Particle:SetNextThink( CurTime() ) -- Makes sure the think hook is used on all particles of the particle emitter
			-- self.Particle:SetThinkFunction( function( pa )
				-- pa:SetMaterial( "actmod/eff_particle/p_glow_0".. math.random( 0, 2 ) ) -- Randomize it
				-- pa:SetColor( math.random( 0, 255 ), math.random( 0, 255 ), math.random( 0, 255 ) ) -- Randomize it
				-- pa:SetStartSize( math.random( 1, 5 ) ) -- Randomize it
				-- pa:SetNextThink( CurTime() ) -- Makes sure the think hook is actually ran.
			-- end )
			-- emitter:Finish()
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_baom_1", true )
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local Ori = data:GetOrigin()
		erf({self,nil,Ori,"actmod/eff_particle/e_smok".. math.random(1,2)}
		,{0,0,0,0},0
		,{0.7,-1,0.5}  ,{150},{0}  ,{10,13},{19,15}
		,{255,255,255} ,{-1,1} ,{0,0,0},false)
		erf({self,nil,Ori,"actmod/eff_particle/e_bam"}
		,{0,0,0,0},0
		,{0.5}  ,{255},{0}  ,{10,13},{10,13}
		,{255,255,255} ,{-1,1} ,{0,0,0},false)
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_baom_2", true )
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local Ori = data:GetOrigin()
		erf({self,nil,Ori,"actmod/eff_particle/e_smok".. math.random(1,2)}
		,{0,0,0,0},0
		,{0.7,-1,0.5}  ,{150},{0}  ,{10,13},{19,15}
		,{255,255,255} ,{-1,1} ,{0,0,0},false)
		erf({self,nil,Ori,"actmod/eff_particle/e_boom"}
		,{0,0,0,0},0
		,{0.5}  ,{255},{0}  ,{10,13},{10,13}
		,{255,255,255} ,{-1,1} ,{0,0,0},false)
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_baom_3", true )
	
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local anum = data:GetScale() or 1
		local Ori = data:GetOrigin()
		local ent = data:GetEntity()
		
		local TParticle = {[1] = {}}
		
		TParticle[1][1] = erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00_2"}
		,{0,0,0,0},0
		,{0.7,0.5}  ,{255},{0}  ,{10,15},{5,7}
		,{50,150,200} ,{-1,1} ,{0,0,0},false,true)
		TParticle[1][2] = erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00_1"}
		,{0,0,0,0},0
		,{0.4,0.2,nil,nil,math.random(-10,10)}  ,{255},{0}  ,{10,15},{20,25}
		,{50,100,150} ,{-1,1} ,{0,0,0},false,true)
		TParticle[1][3] = erf({self,nil,Ori,"actmod/eff_particle/e_jagloss_e".. math.random(1,4)}
		,{0,0,0,0},0
		,{0.7,nil,nil,nil,math.random(0,0.2)}  ,{255},{0}  ,{10,12},{15,9}
		,{255,255,255} ,{-1,1} ,{0,0,0},false,true)
		TParticle[1][4] = erf({self,nil,Ori,"actmod/eff_particle/e_jagloss_".. tostring(anum)}
		,{0,0,0,0},0
		,{1}  ,{255},{0}  ,{5,6},{7,8}
		,{255,255,255} ,{0,0} ,{0,0,0},false,true)
		
		self.PEntity = ent
		
		if IsValid(self.PEntity) then
			self.PEntity.actmod_cl_TParticle = TParticle
			
			if not self.PEntity.wNum or self.PEntity.wNum > 10 then
				self.PEntity.wNum = 1
			else
				self.PEntity.wNum = self.PEntity.wNum + 1
			end
			
			local txtRE = "RemoveEnta__"..self.PEntity.wNum
			self.PEntity:RemoveCallOnRemove( txtRE )
			self.PEntity:CallOnRemove( txtRE, function( aent )
				if TParticle[1] and istable(TParticle[1]) then aRemovEff(TParticle[1]) end
				if TParticle[2] and istable(TParticle[2]) then aRemovEff(TParticle[2]) end
				if TParticle[3] and istable(TParticle[3]) then aRemovEff(TParticle[3]) end
				if TParticle[4] and istable(TParticle[4]) then aRemovEff(TParticle[4]) end
			end)
		end
		
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_jgloss_num", true )
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local anum = data:GetScale() or 1
		local Ori = data:GetOrigin()
		local ent = data:GetEntity()
		
		local TParticle = {[1] = {}}
		
		TParticle[1][1] = erf({self,nil,Ori,"actmod/eff_particle/p_ring_wave"}
		,{0,0,0,0},0
		,{0.6,0.4}  ,{255},{0}  ,{10,15},{30,40}
		,{math.random(0,100),math.random(150,255),255} ,{-1,1} ,{0,0,0},false,true)
		
		self.PEntity = ent
		
		if IsValid(self.PEntity) then
			self.PEntity.actmod_cl_TParticle = TParticle
			
			if not self.PEntity.wNum or self.PEntity.wNum > 10 then
				self.PEntity.wNum = 1
			else
				self.PEntity.wNum = self.PEntity.wNum + 1
			end
			
			local txtRE = "RemoveEnta__"..self.PEntity.wNum
			self.PEntity:RemoveCallOnRemove( txtRE )
			self.PEntity:CallOnRemove( txtRE, function( aent )
				if TParticle[1] and istable(TParticle[1]) then aRemovEff(TParticle[1]) end
				if TParticle[2] and istable(TParticle[2]) then aRemovEff(TParticle[2]) end
				if TParticle[3] and istable(TParticle[3]) then aRemovEff(TParticle[3]) end
				if TParticle[4] and istable(TParticle[4]) then aRemovEff(TParticle[4]) end
			end)
		end
		
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_jgloss_wev", true )
	
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local Ori = data:GetOrigin()
		erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00"}
		,{0,0,0,0},0
		,{0.2,0.6}  ,{255},{0}  ,{4,3},{0.4,0.2}
		,{155,255,255} ,{-1,1} ,{0,0,0},false)
		for i=1,math.random(20,10) do
			erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00"}
			,{math.random(50,-50),math.random(50,-50),math.random(50,-50),0},math.random(100,200)
			,{0.2,0.4}  ,{255},{0}  ,{2,1},{0.4,0.2}
			,{155,255,255} ,{-1,1} ,{0,0,0},false)
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_handsup", true )
	
	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetEntity()
		if ent and IsValid(ent) and ent:LookupBone("ValveBiped.Bip01_R_Hand") then
			local Ori = ent:GetBonePosition( ent:LookupBone("ValveBiped.Bip01_R_Hand") )
			Ori = Ori+ent:GetRight()*math.random(1,3)+Vector(0,0,2)
			if (ent.TrAimEff2 or 0) < CurTime() then
				ent.TrAimEff2 = CurTime() + math.random(0.2,0.5)
				erf({self,nil,Ori,"actmod/eff_particle/p_i_love_01"}
				,{0,0,0,60},700
				,{0.4,1.1}  ,{255},{0}  ,{2,0.7},{0.8,0.2}
				,{255,255,255} ,{-0.1,0.1} ,{0,0,20},false)
			end
			for i=1,math.random(4,1) do
				Ori = Ori+ent:GetRight()*math.random(1,3)+Vector(0,0,2)
				erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00"}
				,{math.random(15,-15),math.random(15,-15),0,50},math.random(400,200)
				,{0.2,0.4}  ,{255},{0}  ,{0.7,0.5},{0.4,0.2}
				,{255,255,255} ,{-1,1} ,{0,0,50},false)
			end
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_blueph", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetEntity()
		local Ori = data:GetOrigin()
		Ori = Ori+ent:GetForward()*-7+Vector(0,0,0)
		erf({self,nil,Ori+Vector( math.random(-1,1), math.random(-1,1), math.random(-1,1) ),"actmod/eff_particle/p_i_ligtstar_00"}
		,{math.random(7,-7),math.random(7,-7),math.random(7,-7),0},math.random(10,50)
		,{0.2,0.4}  ,{255},{0}  ,{2,2.5},{0.5,0.2}
		,{255,255,math.random(0,100)} ,{-1,1} ,{0,0,-10},false)
		for i=1,math.random(5,10) do
			erf({self,nil,Ori+Vector( math.random(-4,4), math.random(-4,4), math.random(-2,2) ),"actmod/eff_particle/p_i_ligtstar_00"}
			,{math.random(-50,50),math.random(-50,50),math.random(-50,50),0},math.random(150,200)
			,{0.2,0.6}  ,{255},{0}  ,{2,0.1},{0.1,2}
			,{255,255,math.random(0,100)} ,{-1,1} ,{0,0,-20},false)
		end
		for i=1,math.random(5,10) do
			erf({self,nil,Ori+Vector( math.random(-5,5), math.random(-5,5), math.random(-2,2) ),"actmod/eff_particle/e_smok2"}
			,{math.random(-50,50),math.random(-50,50),math.random(-50,50),0},800
			,{0.1,0.2}  ,{255},{0}  ,{10,5},{5,2}
			,{100,100,100} ,{-2,2} ,{0,0,4},false)
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_blveil_1", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetEntity()
		local Ori = data:GetOrigin()
		Ori = Ori+ent:GetForward()*1+ent:GetRight()*-0.5+ent:GetUp()*-1.7
		erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00"}
		,{0,0,0,0},0
		,{0.15}  ,{255},{0}  ,{1,2},{0.5}
		,{255,150,50} ,{-1,1} ,{0,0,0},false)
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_blveil_2", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local Ori = data:GetOrigin()
		erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_04"}
		,{0,0,0,0},0
		,{0.15}  ,{255},{0}  ,{5,3},{15}
		,{255,255,255} ,{-1,1} ,{0,0,0},false)
		for i=1,math.random(5,10) do
			erf({self,nil,Ori+Vector( math.random(-4,4), math.random(-4,4), math.random(-2,2) ),"particles/flamelet"..math.random(1,5)}
			,{math.random(-20,20),math.random(-20,20),math.random(-20,20),0},1000
			,{0.15,0.1}  ,{255},{0}  ,{5,7},{0.1,2}
			,{255,255,255} ,{-1,1} ,{0,0,2},false)
		end
		for i=1,math.random(5,3) do
			erf({self,nil,Ori+Vector( math.random(-1,1), math.random(-5,1), math.random(-1,1) ),"actmod/eff_particle/e_smok1"}
			,{math.random(-50,50),math.random(-50,50),math.random(-50,50),0},1800
			,{0.4,0.6}  ,{255},{0}  ,{6,7},{7,9}
			,{60,50,40} ,{-2,2} ,{0,0,4},false)
		end
	end function EFFECT:Think() end function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_blveil_3", true )

	local EFFECT = {}
	function EFFECT:Init(data)
		local ent = data:GetEntity()
		local S = 1
		if ent and IsValid(ent) then S = ent:GetModelScale() end
		local Ori = data:GetOrigin()
		local arnd = table.Random({"actmod/eff_particle/p_i_ligtstar_00_1","actmod/eff_particle/p_i_ligtstar_00_3"}) --print(arnd)
		self.PEntity = ent
		-- self.TParticle_0 = {} self.TParticle_1 = {} self.TParticle_2 = {} self.TParticle_3 = {}
		local TParticle = {
			[1] = {}
			,[2] = {}
			,[3] = {}
			,[4] = {}
		}
		-- print("actmod/eff_particle/p_i_ligtstar_00_"..math.random(1,5))
		
		-- aAlight(Ori,nil,{math.random(0,255),math.random(0,255),math.random(0,255)},5,250,250,1)
		
		local Or1 = Ori
		Or1 = Or1+ent:GetForward()*-1+ent:GetRight()*-0.3
		-- TParticle[1][1] = erf({self,nil,Or1,"actmod/eff_particle/p_i_ligtstar_00_2"}
		-- ,{0,0,0,0},800
		-- ,{1,1.5}  ,{255},{0}  ,{6.4*S},{3*S,1*S}
		-- ,{math.random(1,255),math.random(1,255),math.random(1,255)} ,{-21,21} ,{0,0,0},false,true)
		Or1 = Or1+ent:GetForward()*1.1
		TParticle[1][2] = erf({self,nil,Or1,"actmod/eff_particle/p_i_ligtstar_00_2"}
		,{0,0,0,0},800
		,{1,1.5}  ,{255},{0}  ,{6.4*S},{3*S,1*S}
		,{math.random(1,255),math.random(1,255),math.random(1,255)} ,{-21,21} ,{0,0,0},false,true)
		-- Or1 = Or1+ent:GetForward()*1
		-- TParticle[1][3] = erf({self,nil,Or1,"actmod/eff_particle/p_i_ligtstar_00_2"}
		-- ,{0,0,0,0},800
		-- ,{1,1.5}  ,{255},{0}  ,{5.4*S},{3*S,1*S}
		-- ,{math.random(1,255),math.random(1,255),math.random(1,255)} ,{-21,21} ,{0,0,0},false,true)
		for i=1,math.random(2,3) do
			TParticle[2][i] = erf({self,nil,Ori,arnd}
			,{0,0,0,0},800
			,{1,1.5}  ,{255},{0}  ,{4.7*S,5.1*S},{3*S,1*S}
			,{math.random(1,255),math.random(1,255),math.random(1,255)} ,{-21,21} ,{0,0,0},false,true)
		end
		Ori = Ori+ent:GetUp()*0.4
		for i=1,math.random(5,3) do
			TParticle[3][i] =erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00"}
			,{math.random(-50,50),math.random(-50,50),math.random(-50,50),0},500
			,{1,0.5}  ,{255},{0}  ,{1*S,2*S},{0.5*S,0.1*S}
			,{math.random(1,255),math.random(1,255),math.random(1,255)} ,{-21,21} ,{0,0,0},false,true)
		end
		local a = 4
		Ori = Ori+Vector( math.random(-a,a), math.random(-a,a), math.random(-a,a) )
		for i=1,math.random(2,3) do
			TParticle[4][i] = erf({self,nil,Ori,"actmod/eff_particle/p_i_ligtstar_00"}
			,{0,0,0,0},800
			,{1,1.5}  ,{255},{0}  ,{1.5*S,2*S},{0.5*S,1*S}
			,{math.random(1,255),math.random(1,255),math.random(1,255)} ,{-21,21} ,{0,0,0},false,true)
		end
		self.TParticle = TParticle
		if IsValid(self.PEntity) then
			-- self.PEntity.TParticle_0 = TParticle[1] --self.TParticle_0
			-- self.PEntity.TParticle_1 = TParticle[2] --self.TParticle_1
			-- self.PEntity.TParticle_2 = TParticle[3] --self.TParticle_2
			-- self.PEntity.TParticle_3 = TParticle[4] --self.TParticle_3
			if not self.PEntity.wNum or self.PEntity.wNum > 10 then
				self.PEntity.wNum = 1
			else
				self.PEntity.wNum = self.PEntity.wNum + 1
			end
			local txtRE = "RemoveEnta__"..self.PEntity.wNum
			self.PEntity:RemoveCallOnRemove( txtRE )
			self.PEntity:CallOnRemove( txtRE, function( aent )
				-- if aent.TParticle_0 and istable(aent.TParticle_0) then aRemovEff(aent.TParticle_0) end
				-- if aent.TParticle_1 and istable(aent.TParticle_1) then aRemovEff(aent.TParticle_1) end
				-- if aent.TParticle_2 and istable(aent.TParticle_2) then aRemovEff(aent.TParticle_2) end
				-- if aent.TParticle_3 and istable(aent.TParticle_3) then aRemovEff(aent.TParticle_3) end
				if TParticle[1] and istable(TParticle[1]) then aRemovEff(TParticle[1]) end
				if TParticle[2] and istable(TParticle[2]) then aRemovEff(TParticle[2]) end
				if TParticle[3] and istable(TParticle[3]) then aRemovEff(TParticle[3]) end
				if TParticle[4] and istable(TParticle[4]) then aRemovEff(TParticle[4]) end
			end)
		end
	end
	function EFFECT:Think()
		-- if self.TParticle and istable(self.TParticle) then
			-- for k1, v1 in pairs( self.TParticle ) do
				-- for k2, v2 in pairs( v1 ) do
					---- v2:SetDieTime( 0 )
					---- v2:SetPos( v2:GetPos() + VectorRand()*10 )
					-- v2:SetPos( v2:GetPos() + Vector(0,math.sin(CurTime()*2)*2,0)*10 )
				-- end
			-- end
		-- end
	end
	function EFFECT:Render() end
	effects.Register( EFFECT, "am_f_blveil_4", true )

end




function A_AM.ActMod:GetNameA(ply, callback)
	local steamid64
	if isstring(ply) or isnumber(ply) then
		if isnumber(ply) then
			steamid64 = tostring(ply)
		else
			steamid64 = ply
		end
	else
		steamid64 = ply:SteamID64()
	end
	local GnamE,GOnli = "nonE","nonE"
	http.Fetch("https://steamcommunity.com/profiles/".. steamid64 .."?xml=1", function(body, size, headers, code)
		if size == 0 or code < 200 or code > 299 then return callback(GnamE,GOnli) end
		local url = string.match(body, "<steamID><!%[CDATA%[(.*)%]%]></steamID>")
		local urlOn = string.match(body, "<stateMessage><!%[CDATA%[(.*)%]%]></stateMessage>")
        if url and url != nil and url != "" and url != "nil" then GnamE = tostring(url) end
        if urlOn and urlOn != nil and urlOn != "" and urlOn != "nil" then GOnli = tostring(urlOn) end
		callback(GnamE,GOnli)
	end, function() callback(GnamE,GOnli) end )
end

A_AM.ActMod.LuaEnt_Done = true

