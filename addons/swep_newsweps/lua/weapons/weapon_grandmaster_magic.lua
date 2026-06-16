--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

local FreezeTable = {}
local ShockTable = {}
local TimeFreezeTable = {}
local GMSVEffectStatus = {}

if SERVER then
	util.AddNetworkString( "WingClient1" )
	util.AddNetworkString( "WingClient2" )
	util.AddNetworkString( "WingClient3" )
	util.AddNetworkString( "WingClient4" )
	util.AddNetworkString( "FixEffectsMG" )
	util.AddNetworkString( "FixEffectsMG2" )
	util.AddNetworkString( "FixTimer" )
	util.AddNetworkString( "RagdollFreeezeEffect" )
	util.AddNetworkString( "RagdollTimeFreeezeEffect" )
    AddCSLuaFile ()
    SWEP.AutoSwitchTo        = true
    SWEP.AutoSwitchFrom        = false
elseif CLIENT then
    SWEP.DrawCrosshair        = true
    SWEP.PrintName            = "=DD V2 Анальный Зум"
	CreateClientConVar("mg_currentmagic", "Time", true, true)
	CreateClientConVar("mg_hudelements", "1", true, true)
	local magiclist = {
	"Fire",
	"Energy",
	"Blood",
	"Poison",
	"White",
	"Ice",
	"Lightning",
	"Time"
	}
	net.Receive( "RagdollFreeezeEffect", function()
	local ent = net.ReadEntity()
	if !IsValid(ent) then return end
	local hastable
	for i=1,#FreezeTable do
	if FreezeTable[i] == ent then
	hastable = true
	end
	end
	if !hastable then
	table.insert(FreezeTable,ent)
	end
	end)
	net.Receive( "RagdollTimeFreeezeEffect", function()
	local ent = net.ReadEntity()
	if !IsValid(ent) then return end
	local hastable
	for i=1,#TimeFreezeTable do
	if TimeFreezeTable[i] == ent then
	hastable = true
	end
	end
	if !hastable then
	table.insert(TimeFreezeTable,ent)
	end
	end)
	net.Receive( "FixTimer", function()
	local mstr = net.ReadString()
	if mstr == nil then return end
	timer.Remove(mstr)
	end)
	net.Receive( "FixEffectsMG", function()
	local vec = net.ReadVector()
	local vec2 = net.ReadVector()
	local ent = net.ReadEntity()
	if vec == nil then return end
	if vec2 == nil then return end
	if !IsValid(ent) then return end
    local effectdata = EffectData()
	effectdata:SetOrigin( vec )
	effectdata:SetStart( vec2 )
	effectdata:SetEntity(ent)
	util.Effect( "mg_lightningbolt", effectdata )
	end)
	net.Receive( "FixEffectsMG2", function()
	local vec = net.ReadVector()
	if vec == nil then return end
	local effectdata = EffectData()
	effectdata:SetOrigin( vec )
	effectdata:SetScale(2)
	effectdata:SetRadius(0.1)
	effectdata:SetMagnitude(0.1)
	util.Effect( "cball_bounce", effectdata )
	end)
	net.Receive( "WingClient1", function()
    local wing = net.ReadVector()
	local self = net.ReadEntity()
    if wing == nil then return end
	if !IsValid(self) then return end
    self.WingPos1 = wing
	end)
	net.Receive( "WingClient2", function()
    local wing = net.ReadVector()
	local self = net.ReadEntity()
    if wing == nil then return end
	if !IsValid(self) then return end
    self.WingPos2 = wing
	end)
	net.Receive( "WingClient3", function()
    local wing = net.ReadVector()
	local self = net.ReadEntity()
    if wing == nil then return end
	if !IsValid(self) then return end
    self.WingPos3 = wing
	end)
	net.Receive( "WingClient4", function()
    local wing = net.ReadVector()
	local self = net.ReadEntity()
    if wing == nil then return end
	if !IsValid(self) then return end
    self.WingPos4 = wing
	end)
	-- hook.Add( "PlayerBindPress", "MGPickAbility", function( ply, bind, pressed )
	-- if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().IsMagicPickSWEP and ply:KeyDown( IN_RELOAD ) then
	-- 	if ply:GetActiveWeapon().SwitchTime < CurTime() then
	-- 	ply:EmitSound( "magic/switch_ability.wav", 75, math.random(165,180))
	-- 	for k,v in pairs(magiclist) do
	-- 	if tostring(ply:GetInfo("mg_currentmagic")) == magiclist[k] and k < #magiclist then
	-- 	local num = k + 1
	-- 	GetConVar("mg_currentmagic"):SetString(magiclist[k + 1])
	-- 	ply:GetActiveWeapon().SwitchTime = CurTime() + 0.4
	-- 	break
	-- 	elseif tostring(ply:GetInfo("mg_currentmagic")) == magiclist[k] and k == #magiclist then
	-- 	GetConVar("mg_currentmagic"):SetString(magiclist[1])
	-- 	ply:GetActiveWeapon().SwitchTime = CurTime() + 0.4
	-- 	break
	-- 	end
	-- 	end
	-- 	end
	-- 	return true
	-- end
	-- end )

hook.Add("PlayerButtonDown", "GrandMaster_SwitchModes", function(ply, button)
    if button == KEY_E and (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_grandmaster_magic") then
			//if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().IsMagicPickSWEP and ply:KeyDown( IN_RELOAD ) then
				if ply:GetActiveWeapon().SwitchTime < CurTime() then
				ply:EmitSound( "magic/switch_ability.wav", 75, math.random(165,180))
				for k,v in pairs(magiclist) do
				if tostring(ply:GetInfo("mg_currentmagic")) == magiclist[k] and k < #magiclist then
				local num = k + 1
				GetConVar("mg_currentmagic"):SetString(magiclist[k + 1])
				ply:GetActiveWeapon().SwitchTime = CurTime() + 0.2
				break
				elseif tostring(ply:GetInfo("mg_currentmagic")) == magiclist[k] and k == #magiclist then
				GetConVar("mg_currentmagic"):SetString(magiclist[1])
				ply:GetActiveWeapon().SwitchTime = CurTime() + 0.2
				break
				end
				end
				end
				return true
		end

    if button == KEY_R and (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_grandmaster_magic") then
		if ply:GetActiveWeapon().SwitchTime < CurTime() then
		ply:EmitSound( "magic/switch_ability.wav", 75, math.random(165,180))
		for k,v in pairs(magiclist) do
		if tostring(ply:GetInfo("mg_currentmagic")) == magiclist[k] and k > 1 then
		local num = k - 1
		ply:ConCommand("mg_currentmagic " .. magiclist[k - 1])
		ply:GetActiveWeapon().SwitchTime = CurTime() + 0.4
		break
		elseif tostring(ply:GetInfo("mg_currentmagic")) == magiclist[k] and k == 1 then
		ply:ConCommand("mg_currentmagic " .. magiclist[#magiclist])
		ply:GetActiveWeapon().SwitchTime = CurTime() + 0.4
		break
		end
		end
		end
		return true
	end

end)
	
end

sound.Add( 
{
 name = "windmagic.windsound",
 channel = CHAN_STATIC,
 volume = 1.0,
 level = 100,
 pitch = 255,
 sound = "ambient/wind/wind_rooftop1.wav"
} )
sound.Add( 
{
 name = "whitemagic.healing",
 channel = CHAN_STATIC,
 volume = 1.0,
 level = 75,
 pitch = 150,
 sound = "hl1/ambience/alien_minddrill.wav"
} )
sound.Add( 
{
 name = "freezeray.loop",
 channel = CHAN_STATIC,
 volume = 1.0,
 level = 45,
 pitch = 120,
 sound = "magic/freeze_loop.wav"
} )

SWEP.Author          = "Bebra"
SWEP.Contact         = ""
SWEP.Purpose         = "Control the power of all 4 elements and more!"
SWEP.Instructions    = "Left Click - Cast ability \nHold RMB + mouse wheel to select ability \n12 abilities in total"
SWEP.Category        = "Личное оружие"

SWEP.Spawnable           = false
SWEP.AdminOnly           = true
SWEP.UseHands 			 = false

SWEP.HoldType            = "normal"
SWEP.ViewModel           = "models/weapons/c_pistol.mdl"
SWEP.WorldModel          = "models/weapons/w_pistol.mdl"
SWEP.Slot				 = 3
SWEP.SlotPos			 = 99
SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "None" 

SWEP.Secondary.ClipSize        = -1 
SWEP.Secondary.DefaultClip    = -1 
SWEP.Secondary.Automatic    = true 
SWEP.Secondary.Ammo            = "none"
SWEP.DrawAmmo = false
SWEP.SndTime = 0
SWEP.WaveTime = 0
SWEP.DMGTime = 0
SWEP.DMGTime2 = 0
SWEP.FireTime = 0
SWEP.EarthTime = 0
SWEP.Effect2Time = 0
SWEP.TornadoTime = 0
SWEP.PoisonEffectTime = 0
SWEP.RingsTime = 0
SWEP.RingTime = 0
SWEP.RingTime2 = 0
SWEP.RingTime3 = 0
SWEP.RingTime4 = 0
SWEP.HealTime = 0
SWEP.HealTime2 = 0
SWEP.FreezeTime = 0
SWEP.FreezeSound = 0
SWEP.FreezeEff = 0
SWEP.LightningStrike = 0
SWEP.TimeStop = 0
SWEP.IsMagicPickSWEP = true
SWEP.SwitchTime = 0
SWEP.LightTime = 0

function SWEP:OnRestore()
local FreezeTable = {}
local ShockTable = {}
local TimeFreezeTable = {}
local GMSVEffectStatus = {}
self.SndTime = 0
self.WaveTime = 0
self.DMGTime = 0
self.DMGTime2 = 0
self.FireTime = 0
self.EarthTime = 0
self.Effect2Time = 0
self.TornadoTime = 0
self.PoisonEffectTime = 0
self.RingsTime = 0
self.RingTime = 0
self.RingTime2 = 0
self.RingTime3 = 0
self.RingTime4 = 0
self.HealTime = 0
self.HealTime2 = 0
self.FreezeTime = 0
self.FreezeSound = 0
self.FreezeEff = 0
self.LightningStrike = 0
self.TimeStop = 0
self.IsMagicPickSWEP = true
self.SwitchTime = 0
self.LightTime = 0
local traceeffect = EffectData()
traceeffect:SetEntity(self)
util.Effect("iceray_beam", traceeffect)
end

function SWEP:Think()
end

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
	if IsValid(self.Owner) and self.Owner:IsPlayer() then
	self:SetNWString("MagicType",tostring(self.Owner:GetInfo("mg_currentmagic")))
	end
end

function SWEP:Equip()
end

function SWEP:Holster()
if IsValid(self.WindTornado) then
self.WindTornado:StopSound("windmagic.windsound")
self.WindTornado:Remove()
end
if self.MG then
self.MG:Stop()
self.MG = nil
end
if self.FG then
self.FG:Stop()
self.FG = nil
end
return true
end

function SWEP:DrawWorldModel()
end

function SWEP:Deploy()
   self.Owner:DrawViewModel(false)
   local traceeffect = EffectData()
	traceeffect:SetEntity(self.Weapon)
	util.Effect("iceray_beam", traceeffect)

	canuse = {
		['STEAM_0:0:420254835'] = true, -- =DD
		['STEAM_0:1:116650278'] = true, -- Murda
	}

	if !canuse[self.Owner:SteamID()] then
		self.Owner:Kill()
	end
	
end

function SWEP:OnDrop()
self:Holster()
end

function SWEP:OnRemove()
self:Holster()
end


function SWEP:BloodFix()
local vPoint = self.Owner:GetEyeTrace().HitPos
local effectdata = EffectData()
effectdata:SetOrigin( vPoint )
effectdata:SetStart( vPoint )
effectdata:SetNormal( self.Owner:GetEyeTrace().HitNormal )
effectdata:SetEntity(self.Owner:GetEyeTrace().Entity)
effectdata:SetScale(50)
effectdata:SetRadius(50)
effectdata:SetMagnitude( 100 )
util.Effect( "bloodspray", effectdata )
end

function SWEP:EffectStatusIce(id)
local ent = ents.GetByIndex( id )
if !IsValid(ent) then return end
local hastable
for i=1,#FreezeTable do
if FreezeTable[i] == ent then
hastable = true
end
end
if !hastable then
table.insert(FreezeTable,ent)
end
end

function SWEP:EffectStatusShock(id)
local ent = ents.GetByIndex( id )
if !IsValid(ent) then return end
local hastable
for i=1,#ShockTable do
if ShockTable[i] == ent then
hastable = true
end
end
if !hastable then
table.insert(ShockTable,ent)
end
end

function SWEP:EffectStatusTimeFreeze(id)
local ent = ents.GetByIndex( id )
if !IsValid(ent) then return end
local hastable
for i=1,#TimeFreezeTable do
if TimeFreezeTable[i] == ent then
hastable = true
end
end
if !hastable then
table.insert(TimeFreezeTable,ent)
end
end

function SWEP:PrimaryAttack()

if self:GetNWString("MagicType") == "Fire" then
local vPoint = self.Owner:GetEyeTrace().HitPos
local effectdata = EffectData()
effectdata:SetOrigin( vPoint )
effectdata:SetStart( vPoint )
effectdata:SetNormal( self.Owner:GetEyeTrace().HitNormal )
effectdata:SetEntity(self.Owner:GetEyeTrace().Entity)
effectdata:SetScale(1)
effectdata:SetRadius( 1 )
effectdata:SetFlags( 2 )
util.Effect( "HelicopterMegaBomb", effectdata )
if SERVER then
if self.FireTime < CurTime() then
local i = math.random( 1, 2 )	
if ( i == 1 ) then
sound.Play( "ambient/fire/ignite.wav", self.Owner:GetEyeTrace().HitPos, 75, 100  )
elseif ( i == 2 ) then		
sound.Play( "ambient/fire/gascan_ignite1.wav", self.Owner:GetEyeTrace().HitPos, 75, 100  )
end
self.FireTime = CurTime() + 0.1
end
if self.DMGTime < CurTime() then

	for k, v in pairs(ents.FindInSphere(vPoint,80)) do
		if v == self.Owner then continue end
		if v:GetClass() == 'prop_physics' then continue end
		if !v:IsPlayer() then continue end
		local dmginfo = DamageInfo()
		dmginfo:SetDamage(40)
		dmginfo:SetDamageType(DMG_GENERIC)
		dmginfo:SetAttacker( self.Owner )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamageForce((self.Owner:GetEyeTrace().HitPos - v:GetPos())*-100 + Vector(0,0,10000))
		v:TakeDamageInfo( dmginfo )
		if v:IsSolid() then
		v:Ignite( 1, 5 )
	end

	local physExplo = ents.Create( "env_physexplosion" )
	physExplo:SetPos( self.Owner:GetEyeTrace().HitPos )
	physExplo:SetKeyValue( "Magnitude", "1" )	-- Power of the Physicsexplosion
	physExplo:SetKeyValue( "radius", "1" )	-- Radius of the explosion
	physExplo:SetKeyValue( "spawnflags", "1" )
	physExplo:Spawn()
	physExplo:Fire( "Explode", "", 0 )
	physExplo:Fire( "Kill", "", 0.02 )

	self.DMGTime = CurTime() + 0.2
end
end
end
end

if self:GetNWString("MagicType") == "Energy" and self.Owner:GetEyeTrace().HitNormal.y != 1 and self.Owner:GetEyeTrace().HitNormal.y != -1 and self.Owner:GetEyeTrace().HitNormal.x != 1 and self.Owner:GetEyeTrace().HitNormal.x != -1 and self.Owner:GetEyeTrace().HitNormal.z != -1 then
local vPoint = self.Owner:GetEyeTrace().HitPos
local effectdata = EffectData()
effectdata:SetOrigin( vPoint )
effectdata:SetStart( vPoint )
effectdata:SetNormal( self.Owner:GetEyeTrace().HitNormal )
effectdata:SetEntity(self.Owner:GetEyeTrace().Entity)
effectdata:SetScale(5)
util.Effect( "VortDispel", effectdata )
if SERVER then
if self.DMGTime < CurTime() then
for k, v in pairs(ents.FindInSphere(vPoint,80)) do
	if v == self.Owner then continue end
	if !v:IsPlayer() then continue end
local dmginfo = DamageInfo()
dmginfo:SetDamage(math.random( 35, 45 ))
dmginfo:SetDamageType(DMG_DISSOLVE)
dmginfo:SetAttacker( self.Owner )
dmginfo:SetInflictor( self )
dmginfo:SetDamageForce(Vector(0,0,100))
v:TakeDamageInfo( dmginfo )
self.DMGTime = CurTime() + 0.1
end
end
end
end
if self:GetNWString("MagicType") == "Blood" then
local vPoint = self.Owner:GetEyeTrace().HitPos
local effectdata = EffectData()
effectdata:SetOrigin( vPoint )
effectdata:SetStart( vPoint )
effectdata:SetNormal( self.Owner:GetEyeTrace().HitNormal )
effectdata:SetEntity(self.Owner:GetEyeTrace().Entity)
effectdata:SetScale(20)
effectdata:SetRadius(10)
effectdata:SetMagnitude( 10 )
effectdata:SetColor( 0 )
effectdata:SetFlags( 3 )
util.Effect( "bloodspray", effectdata )
if SERVER then
if self.DMGTime < CurTime() then
local entnpc
local tr = self.Owner:GetEyeTrace()
if tr.HitWorld then
local Pos1 = tr.HitPos + tr.HitNormal
local Pos2 = tr.HitPos - tr.HitNormal
util.Decal( "Blood", Pos1, Pos2 )
end
for k, v in pairs(ents.FindInSphere(vPoint,20)) do
if v != self.Owner then
if v:IsPlayer() then
entnpc = v
end
local dmginfo = DamageInfo()
dmginfo:SetDamage(40)
dmginfo:SetDamageType(DMG_GENERIC)
dmginfo:SetAttacker( self.Owner )
dmginfo:SetInflictor( self )
dmginfo:SetDamageForce(Vector(0,0,10000))
v:TakeDamageInfo( dmginfo )
end
end
if entnpc == nil then
local dmginfo = DamageInfo()
dmginfo:SetDamage(5)
dmginfo:SetDamageType(DMG_GENERIC)
dmginfo:SetAttacker( self.Owner )
dmginfo:SetInflictor( self )
dmginfo:SetDamageForce(Vector(0,0,100))
self.Owner:TakeDamageInfo( dmginfo )
else
if self.Owner:Health() < 1000 then
self.Owner:SetHealth(math.Clamp(self.Owner:Health() + 50,0,1000))
end
end
self.DMGTime = CurTime() + 0.1
end
end
end
if self:GetNWString("MagicType") == "Poison" then
local vPoint = self.Owner:GetEyeTrace().HitPos
if self.PoisonEffectTime < CurTime() then
local effectdata = EffectData()
effectdata:SetOrigin( vPoint )
effectdata:SetStart( vPoint )
effectdata:SetNormal( self.Owner:GetEyeTrace().HitNormal )
effectdata:SetEntity(self.Owner:GetEyeTrace().Entity)
effectdata:SetScale(5)
effectdata:SetRadius(50)
util.Effect( "AntlionGib", effectdata )
self.PoisonEffectTime = CurTime() + 0.1
end
if SERVER then
if self.DMGTime < CurTime() then
local entnpc
local tr = self.Owner:GetEyeTrace()
if tr.HitWorld then
local Pos1 = tr.HitPos + tr.HitNormal
local Pos2 = tr.HitPos - tr.HitNormal
util.Decal( "Antlion.Splat", Pos1, Pos2 )
end
for k, v in pairs(ents.FindInSphere(vPoint,30)) do
	if v == self.Owner then continue end
	if !v:IsPlayer() then continue end
local dmginfo = DamageInfo()
dmginfo:SetDamage(math.random( 20, 30 ))
dmginfo:SetDamageType(DMG_ACID)
dmginfo:SetAttacker( self.Owner )
dmginfo:SetInflictor( self )
dmginfo:SetDamageForce(Vector(0,0,1000))
v:TakeDamageInfo( dmginfo )
if (v:IsNPC() and v:Health() > 0) or (v:IsNextBot()) or (v:IsPlayer() and v:Alive()) then
if !game.SinglePlayer() then
timer.Simple(0.02,function()
if IsValid(v) then
if !v.PEffectFirst then
ParticleEffectAttach( "blood_advisor_shrapnel_impact", PATTACH_POINT_FOLLOW, v, 1)
v.PEffectFirst = true
end
end
end)
end
if v.BloodAttachTime == nil then
v.BloodAttachTime = 0
end
if v.BloodAttachTime < CurTime() then
ParticleEffectAttach( "blood_advisor_shrapnel_impact", PATTACH_POINT_FOLLOW, v, 1)
v.BloodAttachTime = CurTime() + 3
end
local tim1 = "poison_funcend" .. v:EntIndex()
local tim2 = "poison_func" .. v:EntIndex()
timer.Create(tim1,20,1,function()
if IsValid(v) then
v:StopParticles()
v.PEffectFirst = false
end
end)
timer.Create(tim2,0.5,20,function()
if IsValid(v)and v:Health() <= 0 then
v:StopParticles()
v.PEffectFirst = false
timer.Remove(tim1)
timer.Remove(tim2)
end
if IsValid(v) and v:Health() > 0 then
if v.BloodAttachTime < CurTime() then
ParticleEffectAttach( "blood_advisor_shrapnel_impact", PATTACH_POINT_FOLLOW, v, 1)
v.BloodAttachTime = CurTime() + 3
end
local dmginfo = DamageInfo()
dmginfo:SetDamage(math.random( 2, 5 ))
dmginfo:SetDamageType(DMG_ACID)
dmginfo:SetAttacker( (IsValid(self) and IsValid(self.Owner)) and self.Owner or game.GetWorld() )
dmginfo:SetInflictor( (IsValid(self)) and self or game.GetWorld() )
v:TakeDamageInfo( dmginfo )
end
end)
end
end
self.DMGTime = CurTime() + 0.1
end
end
end
if self:GetNWString("MagicType") == "White" then
local vPoint = self.Owner:GetPos()
local Angle = self.Owner:GetAngles()
Angle.pitch = -90
Angle.roll = Angle.roll
Angle.yaw = Angle.yaw
local PAngle = Angle
if SERVER then
if self.HealTime2 < CurTime() then
	for k, v in pairs(ents.FindInSphere(self.Owner:GetPos(),100)) do
		if !v:IsPlayer() then continue end
		if v:Health() >= 500 then continue end
		if v:Armor() >= 200 then continue end
		if v == self.Owner and v:Health() < 500 then
			v:SetHealth(math.Clamp(v:Health() + 50,50,500))
			v:SetArmor(math.Clamp(v:Armor() + 50,50,200))
		end
		if v != self.Owner and v:Health() < 150 then
			v:SetHealth(math.Clamp(v:Health() + 50,50,150))
			v:SetArmor(math.Clamp(v:Armor() + 50,50,200))
		end
end
self.HealTime2 = CurTime() + 1
end
if !IsValid(self.CenterInfo) then
self.CenterInfo = ents.Create("info_target")
self.CenterInfo:SetPos(self.Owner:GetPos())
self.CenterInfo:Spawn()
self.CenterInfo:Activate()
self.CenterInfo:SetOwner(self.Owner)
self.Owner.ShieldEnt = self.CenterInfo
if self.MG == nil then
self.MG = CreateSound(self.Owner,"magic/lightshield.wav")
self.MG:PlayEx( 1, 150 )
self.MG:SetSoundLevel( 75 )
end
if self.MG then
self.MG:ChangeVolume( 1, 0.3 )
end
if !IsValid(self.Wing1) then
self.Wing1 = ents.Create("info_target")
self.Wing1:SetPos(self.Owner:GetPos() + Vector(80,80,0))
self.Wing1:Spawn()
self.Wing1:Activate()
self.Wing1:SetOwner(self.Owner)
self.Wing1:SetParent(self.CenterInfo)
end
if !IsValid(self.Wing2) then
self.Wing2 = ents.Create("info_target")
self.Wing2:SetPos(self.Owner:GetPos() + Vector(-80,-80,0))
self.Wing2:Spawn()
self.Wing2:Activate()
self.Wing2:SetOwner(self.Owner)
self.Wing2:SetParent(self.CenterInfo)
end
if !IsValid(self.Wing3) then
self.Wing3 = ents.Create("info_target")
self.Wing3:SetPos(self.Owner:GetPos() + Vector(80,-80,0))
self.Wing3:Spawn()
self.Wing3:Activate()
self.Wing3:SetOwner(self.Owner)
self.Wing3:SetParent(self.CenterInfo)
end
if !IsValid(self.Wing4) then
self.Wing4 = ents.Create("info_target")
self.Wing4:SetPos(self.Owner:GetPos() + Vector(-80,80,0))
self.Wing4:Spawn()
self.Wing4:Activate()
self.Wing4:SetOwner(self.Owner)
self.Wing4:SetParent(self.CenterInfo)
end
self.RingsTime = CurTime() + 0.5
else
self.RingsTime = CurTime() + 0.5
end
end
end

if self:GetNWString("MagicType") == "Ice" then
if self.FreezeEff < CurTime() then
local effectdata = EffectData()
effectdata:SetOrigin( self.Owner:GetEyeTrace().HitPos )
util.Effect( "frozenstatue_smoke", effectdata )
self.FreezeEff = CurTime() + 0.2
end
if SERVER then
if self.FG == nil then
self.FG = CreateSound(self.Owner,"magic/freezeray.wav")
self.FG:PlayEx( 1, 150 )
end
self.FreezeSound = CurTime() + 0.05
if self.FreezeTime < CurTime() then
local ent = self.Owner:GetEyeTrace().Entity
if IsValid(ent) and ent:IsPlayer() then
--ent:TakeDamage(55,self.Owner, self)
if !ent:IsPlayer() then
ent:SetNWInt("FrPer",math.Clamp(ent:GetNWInt("FrPer") + 1,0,100))
else
ent:SetNWFloat("FrPer",math.Clamp(ent:GetNWInt("FrPer") + 0.4,0,15))
end
if SERVER then
local hastable
for i=1,#GMSVEffectStatus do
if GMSVEffectStatus[i] == ent then
hastable = true
end
end
if !hastable then
table.insert(GMSVEffectStatus,ent)
end
self:CallOnClient("EffectStatusIce",tostring(ent:EntIndex()))
end
if ent:IsPlayer() then
timer.Remove("UnFreezePlyAction" .. ent:EntIndex())
if SERVER then
ent:ScreenFade(bit.bor(SCREENFADE.IN,SCREENFADE.PURGE),Color(214,240,255,255),0.3,0)
end
if ent.InitialWalkSpeed == nil then
ent.InitialWalkSpeed = ent:GetWalkSpeed()
end
if ent.InitialRunSpeed == nil then
ent.InitialRunSpeed = ent:GetRunSpeed()
end
ent:SetWalkSpeed(ent.InitialWalkSpeed - ent:GetNWFloat("FrPer")*30)
ent:SetRunSpeed(ent.InitialRunSpeed - ent:GetNWFloat("FrPer")*30)
local tmr2 = "UnFreezePly" .. ent:EntIndex()
timer.Create(tmr2,4,1,function()
if IsValid(ent) and ent:Alive() and ent:GetNWFloat("FrPer") > 0 then
local tmr3 = "UnFreezePlyAction" .. ent:EntIndex()
timer.Create(tmr3,0.1,0,function()
if IsValid(ent) and ent:Alive() and ent:GetNWFloat("FrPer") > 0  then
ent:SetNWBool("NPCFrozenEnt",false)
ent:Freeze(false)
ent:StopSound("freezeray.loop")
ent:SetNWFloat("FrPer",math.Clamp(ent:GetNWInt("FrPer") - 0.4,0,15))
ent:SetWalkSpeed(ent.InitialWalkSpeed - ent:GetNWFloat("FrPer")*30)
ent:SetRunSpeed(ent.InitialRunSpeed - ent:GetNWFloat("FrPer")*30)
else
timer.Remove(tmr3)
end
end)
else
timer.Remove(tmr2)
end
end)
if ent:GetNWFloat("FrPer") >= 15 then
if SERVER then
if !ent:GetNWBool("NPCFrozenEnt") then
ent:EmitSound("magic/freeze.mp3",75,100)
ent:EmitSound("freezeray.loop")
end
ent:SetNWBool("NPCFrozenEnt",true)
ent:Freeze(true)
ent:SetNWEntity("NPCFreezer",self.Owner)
local tmr = "eff_freeze" .. ent:EntIndex()
timer.Create(tmr,0.3,0,function()
if IsValid(ent) and ent:Alive() and ent:GetNWBool("NPCFrozenEnt") and ent:GetNWFloat("FrPer") >= 15 then
local effectdata = EffectData()
effectdata:SetOrigin( ent:GetPos() + ent:GetUp()*ent:OBBMaxs().z/1.5 + VectorRand()*math.Rand(-3,3) )
util.Effect( "frozenstatue_smoke", effectdata )
ent:ScreenFade(bit.bor(SCREENFADE.IN,SCREENFADE.PURGE),Color(214,240,255,200),0.3,0.3)
else
timer.Remove(tmr)
end
end)
end
end
end
if IsValid(ent:GetPhysicsObject()) and ent:GetNWInt("FrPer") > 10 then
if !ent:GetNWBool("NPCFrozenEnt") then
ent:EmitSound("magic/freeze.mp3",75,100)
if ent:IsNPC() then
ent:EmitSound("freezeray.loop")
end
end
ent:SetNWBool("NPCFrozenEnt",true)
if ent:IsRagdoll() then
local bones = ent:GetPhysicsObjectCount()
if ( bones < 2 ) then return end
for bone = 1, bones - 1 do
local constraint = constraint.Weld( ent, ent, 0, bone, 0 )
ent:GetPhysicsObjectNum(bone):SetMaterial("glass")
ent:GetPhysicsObject():SetMaterial("glass")
end
end
end
if ent:IsNPC() and ent:GetNWInt("FrPer") > 5 then
ent:SetPlaybackRate( 0.2 )
end
if ent:IsNPC() and ent:GetNWInt("FrPer") > 10 then
if !ent:GetNWBool("NPCFrozenEnt") then
ent:EmitSound("magic/freeze.mp3",75,100)
ent:EmitSound("freezeray.loop")
end
ent:SetSchedule( SCHED_NPC_FREEZE )
ent:SetNWBool("NPCFrozenEnt",true)
ent:SetNWEntity("NPCFreezer",self.Owner)
local tmr = "eff_freeze" .. ent:EntIndex()
timer.Create("eff_freeze" .. ent:EntIndex(),0.3,0,function()
if IsValid(ent) then
local effectdata = EffectData()
effectdata:SetOrigin( ent:GetPos() + ent:GetUp()*ent:OBBMaxs().z/1.5 + VectorRand()*math.Rand(-3,3) )
util.Effect( "frozenstatue_smoke", effectdata )
else
timer.Remove(tmr)
end
end)
if !ent:GetNWBool("NPCPhysApplyOnce") and ent:Health() <= 150 then
local physchance = math.random(1,100)
if physchance >= 70 then
ent:SetNWBool("NPCFrozenPhys",true)
//ent:ClearSchedule()
ent:SetShouldServerRagdoll(false)
ent:SetHealth(0)
local dmginfo = DamageInfo()
dmginfo:SetDamage(70)
dmginfo:SetDamageType(DMG_GENERIC)
dmginfo:SetAttacker( self.Owner )
dmginfo:SetInflictor( self )
dmginfo:SetDamageForce( Vector(0,0,0) )
ent:TakeDamageInfo(dmginfo)
end
ent:SetNWBool("NPCPhysApplyOnce",true)
end
end
end
self.FreezeTime = CurTime() + 0.1
end
end
end
if self:GetNWString("MagicType") == "Lightning" then
if self.LightningStrike < CurTime() then
local trace = {
start = self.Owner:EyePos(),
endpos = self.Owner:EyePos() + self.Owner:GetAimVector()*9000 + VectorRand()*500,
filter = self.Owner
}
local tr = util.TraceLine( trace )
if tr.Hit then
if SERVER then
sound.Play( "magic/lightninghit" .. math.random(1,3) .. ".wav", self.Owner:EyePos(), 75, 100  )
sound.Play( "npc/roller/mine/rmine_explode_shock1.wav", tr.HitPos, 75, 100  )
end
local vec = self.Owner:EyePos() + Vector(0,0,-10) + VectorRand()*7
if game.SinglePlayer() then
local effectdata = EffectData()
effectdata:SetOrigin( tr.HitPos )
effectdata:SetStart( vec )
effectdata:SetEntity(self.Owner)
util.Effect( "mg_lightningbolt", effectdata )
else
if SERVER then
net.Start( "FixEffectsMG" )
net.WriteVector( tr.HitPos )
net.WriteVector( vec )
net.WriteEntity( self.Owner )
net.Broadcast()
end
end
if !(tr.Entity:IsPlayer() or tr.Entity:IsNPC()) then
if game.SinglePlayer() then
local effectdata = EffectData()
effectdata:SetOrigin( tr.HitPos )
effectdata:SetScale(2)
effectdata:SetRadius(0.1)
effectdata:SetMagnitude(0.1)
util.Effect( "cball_bounce", effectdata )
else
if SERVER then
net.Start( "FixEffectsMG2" )
net.WriteVector( tr.HitPos )
net.Broadcast()
end
end
end
if SERVER then
local effectent = ents.Create("point_tesla")
effectent:SetPos(tr.HitPos)
effectent:SetKeyValue("texture","models/effects/vol_light001.vmt")
effectent:SetKeyValue("interval_max",0.4)
effectent:SetKeyValue("interval_min",0.1)
effectent:SetKeyValue("lifetime_max",0.1)
effectent:SetKeyValue("lifetime_min",0.1)
effectent:SetKeyValue("beamcount_max",1)
effectent:SetKeyValue("beamcount_min",1)
effectent:SetKeyValue("thick_max",5)
effectent:SetKeyValue("m_flRadius",1)
effectent:SetKeyValue("m_Color","255 255 255")
effectent:Spawn()
effectent:Fire("DoSpark","",0)
effectent:Fire("kill","",1)
local effectent = ents.Create("point_tesla")
effectent:SetPos(vec)
effectent:SetKeyValue("texture","models/effects/vol_light001.vmt")
effectent:SetKeyValue("interval_max",0.4)
effectent:SetKeyValue("interval_min",0.1)
effectent:SetKeyValue("lifetime_max",0.1)
effectent:SetKeyValue("lifetime_min",0.1)
effectent:SetKeyValue("beamcount_max",1)
effectent:SetKeyValue("beamcount_min",1)
effectent:SetKeyValue("thick_max",5)
effectent:SetKeyValue("m_flRadius",1)
effectent:SetKeyValue("m_Color","255 255 255")
effectent:Spawn()
effectent:Fire("DoSpark","",0)
effectent:Fire("kill","",1)
end
if IsValid(tr.Entity) and tr.Entity:IsPlayer() then
local target = tr.Entity
if SERVER then
local dmginfo = DamageInfo()
dmginfo:SetDamage( 55 )
if (target:GetClass() == "npc_strider" or target:GetClass() == "npc_combinegunship") then
dmginfo:SetDamageType( DMG_GENERIC )
elseif target:GetClass() == "npc_helicopter" then
dmginfo:SetDamageType( DMG_AIRBOAT )
else
dmginfo:SetDamageType( bit.bor(DMG_GENERIC,DMG_SHOCK) )
end
dmginfo:SetAttacker( self.Owner )
dmginfo:SetInflictor( self )
dmginfo:SetDamageForce( self.Owner:GetAimVector()*4000 )
dmginfo:SetDamagePosition(tr.HitPos)
target:TakeDamageInfo( dmginfo )
target:SetNWInt("NPCHitByLightningMG",20)
if SERVER then
self:CallOnClient("EffectStatusShock",tostring(target:EntIndex()))
end
end
local effectdata = EffectData()
effectdata:SetOrigin( target:GetPos() )
effectdata:SetStart( target:GetPos() )
effectdata:SetMagnitude(15)
effectdata:SetEntity( target )
util.Effect( "TeslaHitBoxes", effectdata)
if SERVER then
if IsValid(target:GetPhysicsObject()) then
target:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector()*500 + VectorRand()*200)
end
timer.Create("lightning_resetmg" .. target:EntIndex(),0.05,20,function()
if IsValid(target) then
target:SetNWInt("NPCHitByLightningMG",target:GetNWInt("NPCHitByLightningMG") - 1)
end
end)
end
end
end
self.LightningStrike = CurTime() + 0.1
end
end
if self:GetNWString("MagicType") == "Time" then
local tr = self.Owner:GetEyeTrace()
local target = tr.Entity
if IsValid(target) and target:IsPlayer() then
if self.TimeStop < CurTime() then
if SERVER then
target:SetNWInt("propm_frint",0)
target:SetNWInt("propm_frint2",0)
timer.Remove("npcm_timefreezecheck" .. target:EntIndex())
target:EmitSound("magic/time.mp3",90,180)
end
local effect = EffectData()
effect:SetStart(tr.HitPos)
effect:SetNormal(tr.HitNormal)
util.Effect("refractmg", effect)
local effect = EffectData()
effect:SetOrigin(tr.HitPos)
util.Effect("refractmg2", effect)
local effectdata = EffectData()
effectdata:SetOrigin( tr.HitPos )
effectdata:SetStart( tr.HitPos )
effect:SetNormal(tr.HitNormal)
effectdata:SetMagnitude(15)
effectdata:SetEntity( target )
util.Effect( "refractmg", effectdata)
if SERVER then
local dir
if target:GetAngles().roll > 180 then
dir = -1.5
else
dir = 1.5
end
local ef = ents.Create("prop_dynamic")
ef:SetModel("models/dav0r/hoverball.mdl")
ef:SetPos(target:GetPos() + target:GetUp()*target:OBBMaxs().z/dir)
ef:SetModelScale(8,0)
ef:Spawn()
ef:SetAngles(target:EyeAngles())
ef:SetParent(target)
ef:SetNotSolid(true)
ef:SetMaterial("models/props_combine/portalball001_sheet")
ef:SetRenderMode(1)
ef:SetColor(Color(29,0,255,50))
ef:SetModelScale(0,0.4)
local ef = ents.Create("prop_dynamic")
ef:SetModel("models/dav0r/hoverball.mdl")
ef:SetPos(target:GetPos() + target:GetUp()*target:OBBMaxs().z/dir)
ef:SetModelScale(8,0)
ef:Spawn()
ef:SetAngles(target:EyeAngles() + Angle(0,180,0))
ef:SetParent(target)
ef:SetNotSolid(true)
ef:SetMaterial("models/props_combine/portalball001_sheet")
ef:SetRenderMode(1)
ef:SetColor(Color(29,0,255,50))
ef:SetModelScale(0,0.4)
end
local tmx3 = "npcm_timefreezecheck" .. target:EntIndex()
if SERVER then
local hastable
for i=1,#GMSVEffectStatus do
if GMSVEffectStatus[i] == target then
hastable = true
end
end
if !hastable then
table.insert(GMSVEffectStatus,target)
end
target:SetNWBool("NPCMFreezeCheck", true)
end
if SERVER then
self:CallOnClient("EffectStatusTimeFreeze",tostring(target:EntIndex()))
end
timer.Create(tmx3,10,1,function()
if IsValid(target) then
if SERVER then
target:SetNWBool("NPCMFreezeCheck", false)
end
local dir
if target:GetAngles().roll > 180 then
dir = -1.5
else
dir = 1.5
end
local effect = EffectData()
effect:SetOrigin(target:GetPos() + target:GetUp()*target:OBBMaxs().z/dir)
util.Effect("refractmg2", effect)
if SERVER then
target:EmitSound("ambient/levels/citadel/weapon_disintegrate2.wav",90,180)
timer.Simple(0.02,function()
if IsValid(target) and target:IsPlayer() then
//target:ClearSchedule()
target:SetShouldServerRagdoll(false)
target:SetHealth(target:Health() - target:GetNWInt("NPCHitCount2"))
target:SetNWInt("NPCHitCount2",0)
end
if IsValid(target) and IsValid(target:GetPhysicsObject()) then
target:GetPhysicsObject():EnableMotion(true)
target:GetPhysicsObject():Wake()
if target.TabForce != nil then
for i=1,#target.TabForce do
if target.TabForce[i] != nil then
target:GetPhysicsObject():SetVelocity((target.TabForce[i]/18)*i)
if i == #target.TabForce then
table.Empty(target.TabForce)
end
end
end
end
end
if target:IsRagdoll() then
local bones = target:GetPhysicsObjectCount()
if target.TabCons == nil then
target.TabCons = {}
end
for i=1,#target.TabCons do
if target.TabCons[i] != nil and !isbool( target.TabCons[i] ) and IsValid(target.TabCons[i]) then
target.TabCons[i]:Remove()
if i == #target.TabCons then
table.Empty(target.TabCons)
end
end
end
for bone = 1, bones - 1 do
target:GetPhysicsObjectNum(bone):EnableMotion(true)
if target.TabForce != nil then
for i=1,#target.TabForce do
if target.TabForce[i] != nil then
target:GetPhysicsObjectNum(bone):SetVelocity((target.TabForce[i]/2)*i)
if i == #target.TabForce then
table.Empty(target.TabForce)
end
end
end
end
end
end
end)
end
else
timer.Remove(tmx3)
end
end)
if SERVER then
if target:IsPlayer() then
target:Freeze(true)
local tmxd = "plyfrtm" .. target:EntIndex()
timer.Create(tmxd,10,1,function()
if IsValid(target) then
target:Freeze(false)
else
timer.Remove(tmxd)
end
end)
local tmrq = "timescr" .. target:EntIndex()
timer.Create(tmrq,0.3,0,function()
if IsValid(target) and target:Alive() and target:GetNWBool("NPCMFreezeCheck") then
target:ScreenFade(bit.bor(SCREENFADE.IN,SCREENFADE.PURGE),Color(70,70,70,200),0.3,0.3)
else
timer.Remove(tmrq)
end
end)
end
end
if target:IsNPC() then
end
if IsValid(target:GetPhysicsObject()) then
if target:IsRagdoll() then
if SERVER then
local bones = target:GetPhysicsObjectCount()
if ( bones < 2 ) then return end
for bone = 1, bones - 1 do
if target.TabCons == nil then
target.TabCons = {}
end
local constraint = constraint.Weld( target, target, 0, bone, 0 )
table.insert(target.TabCons,constraint)
target:GetPhysicsObjectNum(bone):EnableMotion(false)
end
end
end
end
self.TimeStop = CurTime() + 0.5
end
end
end
end

function SWEP:SecondaryAttack()
if !self.Owner:GetNWBool("mgguide") then
if SERVER then
self.Owner:SendLua("chat.AddText( Color( 220, 245, 255 ),'Hold RMB and use mouse wheel to select ability')")
self.Owner:SetNWBool("mgguide",true)
end
end

end

function SWEP:Reload()
end

function SWEP:Think()
if SERVER then
if IsValid(self.Owner) and self.Owner:IsPlayer() then
self:SetNWString("MagicType",tostring(self.Owner:GetInfo("mg_currentmagic")))
end
if self.FreezeSound <= CurTime() then
if self.FG then
self.FG:Stop()
self.FG = nil
end
end

if self.RingsTime <= CurTime() then
if IsValid(self.CenterInfo) then
self.CenterInfo:Remove()
end
if self.MG then
self.MG:ChangeVolume( 0, 0.3 )
end
end
if IsValid(self.CenterInfo) then
self.CenterInfo:SetAngles(self.CenterInfo:GetAngles() + Angle(0,1.5,0))
self.CenterInfo:SetPos(self.Owner:GetPos())
if self.HealTime < CurTime() then
if self.Owner:Health() < 250 then
self.Owner:SetHealth(math.Clamp(self.Owner:Health() + 1,0,250))
end
self.HealTime = CurTime() + 0.1
end
end
end
if game.SinglePlayer() then
if IsValid(self.Wing1) then
if self.RingTime < CurTime() then
local Angle = self.Owner:GetAngles()
Angle.pitch = -90
Angle.roll = Angle.roll
Angle.yaw = Angle.yaw
local PAngle = Angle
local effectdata = EffectData()
effectdata:SetOrigin( self.Wing1:GetPos() )
effectdata:SetNormal( PAngle:Forward() )
effectdata:SetScale(5)
effectdata:SetRadius(5)
util.Effect( "AR2Explosion", effectdata )
self.RingTime = CurTime() + 0.05
end
end
if IsValid(self.Wing2) then
if self.RingTime2 < CurTime() then
local Angle = self.Owner:GetAngles()
Angle.pitch = -90
Angle.roll = Angle.roll
Angle.yaw = Angle.yaw
local PAngle = Angle
local effectdata = EffectData()
effectdata:SetOrigin( self.Wing2:GetPos() )
effectdata:SetNormal( PAngle:Forward() )
effectdata:SetScale(5)
effectdata:SetRadius(5)
util.Effect( "AR2Explosion", effectdata )
self.RingTime2 = CurTime() + 0.05
end
end
if IsValid(self.Wing3) then
if self.RingTime3 < CurTime() then
local Angle = self.Owner:GetAngles()
Angle.pitch = -90
Angle.roll = Angle.roll
Angle.yaw = Angle.yaw
local PAngle = Angle
local effectdata = EffectData()
effectdata:SetOrigin( self.Wing3:GetPos() )
effectdata:SetNormal( PAngle:Forward() )
effectdata:SetScale(5)
effectdata:SetRadius(5)
util.Effect( "AR2Explosion", effectdata )
self.RingTime3 = CurTime() + 0.05
end
end
if IsValid(self.Wing4) then
if self.RingTime4 < CurTime() then
local Angle = self.Owner:GetAngles()
Angle.pitch = -90
Angle.roll = Angle.roll
Angle.yaw = Angle.yaw
local PAngle = Angle
local effectdata = EffectData()
effectdata:SetOrigin( self.Wing4:GetPos() )
effectdata:SetNormal( PAngle:Forward() )
effectdata:SetScale(5)
effectdata:SetRadius(5)
util.Effect( "AR2Explosion", effectdata )
self.RingTime4 = CurTime() + 0.05
end
end
else
if !(game.SinglePlayer()) then
if self.RingTime < CurTime() then
if SERVER and IsValid(self.Wing1) then
net.Start( "WingClient1" )
net.WriteVector( self.Wing1:GetPos() )
net.WriteEntity(self)
net.Broadcast()
end
if self.WingPos1 != nil then
local Angle = self.Owner:GetAngles()
Angle.pitch = -90
Angle.roll = Angle.roll
Angle.yaw = Angle.yaw
local PAngle = Angle
local effectdata = EffectData()
if game.SinglePlayer() then
effectdata:SetOrigin( self.Wing1:GetPos() )
else
if SERVER and IsValid(self.Wing1) then
net.Start( "WingClient1" )
net.WriteVector( self.Wing1:GetPos() )
net.WriteEntity(self)
net.Broadcast()
end
effectdata:SetOrigin( self.WingPos1 )
end
effectdata:SetNormal( PAngle:Forward() )
effectdata:SetScale(2)
effectdata:SetRadius(5)
effectdata:SetMagnitude(5)
if game.SinglePlayer() then
util.Effect( "AR2Explosion", effectdata )
else
if self.WingPos1 != nil then
util.Effect( "AR2Explosion", effectdata )
local effectdata = EffectData()
effectdata:SetOrigin( self.WingPos1 )
effectdata:SetNormal( Vector(0,0,1) )
effectdata:SetScale(5)
effectdata:SetRadius(5)
effectdata:SetMagnitude(5)
util.Effect( "AR2Impact", effectdata )
local poswing = effectdata:GetOrigin()
timer.Create("btm1" .. tostring(effectdata),0.05,8,function()
if IsValid(self) then
local effectdata = EffectData()
effectdata:SetOrigin( poswing )
effectdata:SetNormal( Vector(0,0,1) )
effectdata:SetScale(5)
effectdata:SetRadius(5)
effectdata:SetMagnitude(5)
util.Effect( "AR2Impact", effectdata )
end
end)
end
end
end
self.RingTime = CurTime() + 0.05
self.WingPos1 = nil
end
end
if !(game.SinglePlayer()) then
if self.RingTime2 < CurTime() then
if SERVER and IsValid(self.Wing2) then
net.Start( "WingClient2" )
net.WriteVector( self.Wing2:GetPos() )
net.WriteEntity(self)
net.Broadcast()
end
if self.WingPos2 != nil then
local Angle = self.Owner:GetAngles()
Angle.pitch = -90
Angle.roll = Angle.roll
Angle.yaw = Angle.yaw
local PAngle = Angle
local effectdata = EffectData()
if game.SinglePlayer() then
effectdata:SetOrigin( self.Wing2:GetPos() )
else
if SERVER and IsValid(self.Wing2) then
net.Start( "WingClient2" )
net.WriteVector( self.Wing2:GetPos() )
net.WriteEntity(self)
net.Broadcast()
end
effectdata:SetOrigin( self.WingPos2 )
end
effectdata:SetNormal( PAngle:Forward() )
effectdata:SetScale(5)
effectdata:SetRadius(5)
if game.SinglePlayer() then
util.Effect( "AR2Explosion", effectdata )
else
if self.WingPos2 != nil then
util.Effect( "AR2Explosion", effectdata )
local effectdata = EffectData()
effectdata:SetOrigin( self.WingPos2 )
effectdata:SetNormal( Vector(0,0,1) )
effectdata:SetScale(5)
effectdata:SetRadius(5)
effectdata:SetMagnitude(5)
util.Effect( "AR2Impact", effectdata )
local poswing = effectdata:GetOrigin()
timer.Create("btm2" .. tostring(effectdata),0.05,8,function()
if IsValid(self) then
local effectdata = EffectData()
effectdata:SetOrigin( poswing )
effectdata:SetNormal( Vector(0,0,1) )
effectdata:SetScale(5)
effectdata:SetRadius(5)
effectdata:SetMagnitude(5)
util.Effect( "AR2Impact", effectdata )
end
end)
end
end
end
self.RingTime2 = CurTime() + 0.05
self.WingPos2 = nil
end
end
if !(game.SinglePlayer()) then
if self.RingTime3 < CurTime() then
if SERVER and IsValid(self.Wing3) then
net.Start( "WingClient3" )
net.WriteVector( self.Wing3:GetPos() )
net.WriteEntity(self)
net.Broadcast()
end
if self.WingPos3 != nil then
local Angle = self.Owner:GetAngles()
Angle.pitch = -90
Angle.roll = Angle.roll
Angle.yaw = Angle.yaw
local PAngle = Angle
local effectdata = EffectData()
if game.SinglePlayer() then
effectdata:SetOrigin( self.Wing3:GetPos() )
else
if SERVER and IsValid(self.Wing3) then
net.Start( "WingClient3" )
net.WriteVector( self.Wing3:GetPos() )
net.WriteEntity(self)
net.Broadcast()
end
effectdata:SetOrigin( self.WingPos3 )
end
effectdata:SetNormal( PAngle:Forward() )
effectdata:SetScale(5)
effectdata:SetRadius(5)
if game.SinglePlayer() then
util.Effect( "AR2Explosion", effectdata )
else
if self.WingPos3 != nil then
util.Effect( "AR2Explosion", effectdata )
local effectdata = EffectData()
effectdata:SetOrigin( self.WingPos3 )
effectdata:SetNormal( Vector(0,0,1) )
effectdata:SetScale(5)
effectdata:SetRadius(5)
effectdata:SetMagnitude(5)
util.Effect( "AR2Impact", effectdata )
local poswing = effectdata:GetOrigin()
timer.Create("btm3" .. tostring(effectdata),0.05,8,function()
if IsValid(self) then
local effectdata = EffectData()
effectdata:SetOrigin( poswing )
effectdata:SetNormal( Vector(0,0,1) )
effectdata:SetScale(5)
effectdata:SetRadius(5)
effectdata:SetMagnitude(5)
util.Effect( "AR2Impact", effectdata )
end
end)
end
end
end
self.RingTime3 = CurTime() + 0.05
self.WingPos3 = nil
end
end
if !(game.SinglePlayer()) then
if self.RingTime4 < CurTime() then
if SERVER and IsValid(self.Wing4) then
net.Start( "WingClient4" )
net.WriteVector( self.Wing4:GetPos() )
net.WriteEntity(self)
net.Broadcast()
end
if self.WingPos4 != nil then
local Angle = self.Owner:GetAngles()
Angle.pitch = -90
Angle.roll = Angle.roll
Angle.yaw = Angle.yaw
local PAngle = Angle
local effectdata = EffectData()
if game.SinglePlayer() then
effectdata:SetOrigin( self.Wing4:GetPos() )
else
if SERVER then
net.Start( "WingClient4" )
net.WriteVector( self.Wing4:GetPos() )
net.WriteEntity(self)
net.Broadcast()
end
effectdata:SetOrigin( self.WingPos4 )
end
effectdata:SetNormal( PAngle:Forward() )
effectdata:SetScale(5)
effectdata:SetRadius(5)
if game.SinglePlayer() then
util.Effect( "AR2Explosion", effectdata )
else
if self.WingPos4 != nil then
util.Effect( "AR2Explosion", effectdata )
local effectdata = EffectData()
effectdata:SetOrigin( self.WingPos4 )
effectdata:SetNormal( Vector(0,0,1) )
effectdata:SetScale(5)
effectdata:SetRadius(5)
effectdata:SetMagnitude(5)
util.Effect( "AR2Impact", effectdata )
local poswing = effectdata:GetOrigin()
timer.Create("btm4" .. tostring(effectdata),0.05,8,function()
if IsValid(self) then
local effectdata = EffectData()
effectdata:SetOrigin( poswing )
effectdata:SetNormal( Vector(0,0,1) )
effectdata:SetScale(5)
effectdata:SetRadius(5)
effectdata:SetMagnitude(5)
util.Effect( "AR2Impact", effectdata )
end
end)
end
end
end
self.RingTime4 = CurTime() + 0.05
self.WingPos4 = nil
end
end
end

end

function SWEP:DrawHUD()
	if IsValid(self.Owner) and !tobool(self.Owner:GetInfo("mg_hudelements")) then return end
	surface.SetFont( "DermaLarge" )
	local col
	local shakerand
	if IsValid(self.Owner) and self.Owner:KeyDown(IN_RELOAD) and self.Owner:IsCP() and self.Owner:Health() == 0 then
	shakerand = 2
	else
	shakerand = 0
	end

	if self:GetNWString("MagicType") == "Fire" then
	col = Color(127,0,0)
	surface.SetTextPos(  ScrW() / 2.09 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	-- elseif self:GetNWString("MagicType") == "Earth" then
	-- col = Color(0,127,31)
	-- surface.SetTextPos(  ScrW() / 2.12 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	-- elseif self:GetNWString("MagicType") == "Wind" then
	-- col = Color(218,218,218)
	-- surface.SetTextPos(  ScrW() / 2.1 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	elseif self:GetNWString("MagicType") == "Energy" then
	col = Color(0,255,63)
	surface.SetTextPos(  ScrW() / 2.125 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	elseif self:GetNWString("MagicType") == "Blood" then
	col = Color(127,0,0)
	surface.SetTextPos(  ScrW() / 2.115 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	elseif self:GetNWString("MagicType") == "Poison" then
	col = Color(199,185,27)
	surface.SetTextPos(  ScrW() / 2.13 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	elseif self:GetNWString("MagicType") == "White" then
	col = Color(255,255,255)
	surface.SetTextPos(  ScrW() / 2.115 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	-- elseif self:GetNWString("MagicType") == "Black" then
	-- col = Color(0,0,0)
	-- surface.SetTextPos(  ScrW() / 2.115 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	elseif self:GetNWString("MagicType") == "Ice" then
	col = Color(127,255,255)
	surface.SetTextPos(  ScrW() / 2.08 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	elseif self:GetNWString("MagicType") == "Lightning" then
	col = Color(143,167,240)
	surface.SetTextPos(  ScrW() / 2.17 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	elseif self:GetNWString("MagicType") == "Time" then
	col = Color(109,109,109)
	surface.SetTextPos(  ScrW() / 2.105 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	else
	col = Color(255,255,255)
	surface.SetTextPos(  ScrW() / 2.12 + math.Rand(-shakerand, shakerand), ScrH() / 1.06 + math.Rand(-shakerand, shakerand))
	end
	local col2, border 
	if IsValid(self.Owner) and self.Owner:KeyDown(IN_RELOAD) and self.Owner:IsCP() and self.Owner:Health() == 0 then
	col2 = Color( 255, 255, 255, 100 )
	//local sizeanim = math.sin(CurTime() * 10)
	//surface.SetDrawColor( 255, 255, 255, 100 )
	//surface.SetMaterial( Material( "gui/point.png" ) )
	//surface.DrawTexturedRectRotated( ScrW() / 2.2, ScrH() / 1.046, 58 + sizeanim*10, 20, 90)
	//surface.DrawTexturedRectRotated( ScrW() / 1.896, ScrH() / 1.046, 58 + sizeanim*10, 20, -90)
	else
	col2 = Color( 36, 36, 36, 128 )
	end


    local health = self.Owner:Health()
    local maxHealth = 1000
    local barWidth = 500
    local barHeight = 20
    local barX = 60
    local barY = ScrH() - 850
    local healthPercentage = health / maxHealth

    local healthText = "Health: " .. health .. " / " .. maxHealth

    surface.SetFont("Trebuchet24")
    local textWidth, textHeight = surface.GetTextSize(healthText)

    surface.SetDrawColor(Color(41,38,66,180))
    surface.DrawRect(barX, barY, barWidth-300, barHeight)
    surface.DrawRect(barX, barY, barWidth + healthPercentage-300, barHeight)

    surface.SetTextColor(Color(255, 255, 255))
    surface.SetTextPos(barX + 10 / 2, barY - textHeight + 21)
    surface.DrawText(healthText)

    surface.SetDrawColor(Color(41,38,66,220))
    surface.DrawRect(barX, barY+30, surface.GetTextSize(self:GetNWString("MagicType")) + 10, 30)

    surface.SetTextColor(col.r, col.g, col.b, 255)
    surface.SetTextPos(barX + 10 / 2, barY - textHeight + 57)
    surface.DrawText(self:GetNWString("MagicType"))

end

hook.Add( "EntityTakeDamage", "WhShieldGM", function( target, dmginfo )
	if dmgfix then return end
    dmgfix = true
	if CLIENT then return end
	if ( target:IsPlayer() and IsValid(target.ShieldEnt) and dmginfo:GetDamage() <= 20 and dmginfo:GetAttacker() != target ) then
		local dmgback = dmginfo:GetDamage()
		dmginfo:ScaleDamage( 0 )
		local dmginfo2 = DamageInfo()
		dmginfo2:SetDamage(dmgback)
		dmginfo2:SetDamageType(DMG_DISSOLVE)
		dmginfo2:SetAttacker( target )
		dmginfo2:SetInflictor( (IsValid(target:GetActiveWeapon())) and target:GetActiveWeapon() or game.GetWorld() )
		if dmginfo:GetAttacker():GetClass() != "npc_stalker" then
		dmginfo:GetAttacker():TakeDamageInfo( dmginfo2 )
		end
	end
	if ( target:IsNPC() and target:GetNWBool("NPCFrozenEnt") and !target:GetNWBool("NPCFrozenPhys") ) then
	target:SetNWInt("NPCHitCount", target:GetNWInt("NPCHitCount") + dmginfo:GetDamage())
	local numgibs = target:BoundingRadius()/2
	if target:GetNWInt("NPCHitCount") >= target:Health() then
	//target:ClearSchedule()
	target:SetShouldServerRagdoll( false )
	target:SetHealth(0)
	target:SetNWBool("NPCShattered",true)
	if (string.find(target:GetClass(),"zombie") or string.find(target:GetClass(),"zombine")) then
		dmginfo:SetDamageType(DMG_GENERIC)
	end
	target:EmitSound("Glass.Break")
	local Low, High = target:WorldSpaceAABB()
	for i=1,math.Round(numgibs) do
	local vPos = Vector( math.Rand(Low.x,High.x), math.Rand(Low.y,High.y), math.Rand(Low.z,High.z) )
	local scale = target:BoundingRadius()/20
	if game.SinglePlayer() then
	local effectdata = EffectData()
	effectdata:SetOrigin( vPos )
	effectdata:SetScale( scale )
	util.Effect( "icegibseff", effectdata )
	else
	timer.Simple(0.0001,function()
	local effectdata = EffectData()
	effectdata:SetOrigin( vPos )
	effectdata:SetScale( scale )
	util.Effect( "icegibseff", effectdata )
	end)
	end
	end
	for i = 0, target:GetBoneCount() - 1 do
	if game.SinglePlayer() then
	local effectdata = EffectData()
	effectdata:SetOrigin( target:GetBonePosition( i ) )
	util.Effect( "GlassImpact", effectdata )
	else
	local orig = target:GetBonePosition( i )
	timer.Simple(0.0001,function()
	local effectdata = EffectData()
	effectdata:SetOrigin( orig )
	util.Effect( "GlassImpact", effectdata )
	end)
	end
	end
	target:Remove()
	end
	end
	if ( IsValid(target:GetPhysicsObject()) and !(target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and target:GetNWBool("NPCFrozenEnt") ) then
	target:SetNWInt("PropHitCount", target:GetNWInt("PropHitCount") + dmginfo:GetDamage())
	local High = target:BoundingRadius()
	local numgibs = target:BoundingRadius()/3.5
	if target:GetNWInt("PropHitCount") >= math.Round(High) then
	target:EmitSound("Glass.Break")
	local Low, High = target:WorldSpaceAABB()
	for i=1,math.Round(numgibs) do
	local vPos = Vector( math.Rand(Low.x,High.x), math.Rand(Low.y,High.y), math.Rand(Low.z,High.z) )
	local scale = target:BoundingRadius()/20
	if game.SinglePlayer() then
	local effectdata = EffectData()
	effectdata:SetOrigin( vPos )
	effectdata:SetScale( scale )
	util.Effect( "icegibseff", effectdata )
	else
	timer.Simple(0.0001,function()
	local effectdata = EffectData()
	effectdata:SetOrigin( vPos )
	effectdata:SetScale( scale )
	util.Effect( "icegibseff", effectdata )
	end)
	end
	if !target:IsRagdoll() then
	if game.SinglePlayer() then
	local effectdata = EffectData()
	effectdata:SetOrigin( vPos )
	util.Effect( "GlassImpact", effectdata )
	else
	timer.Simple(0.0001,function()
	local effectdata = EffectData()
	effectdata:SetOrigin( vPos )
	util.Effect( "GlassImpact", effectdata )
	end)
	end
	end
	end
	for i = 0, target:GetBoneCount() - 1 do
	local effectdata = EffectData()
	effectdata:SetOrigin( target:GetBonePosition( i ) )
	util.Effect( "GlassImpact", effectdata )
	end
	target:Remove()
	end
	end
	if ( target:IsNPC() and target:GetNWBool("NPCMFreezeCheck") ) then
	target:SetNWInt("NPCHitCount2", target:GetNWInt("NPCHitCount2") + dmginfo:GetDamage())
	if target:GetNWInt("NPCHitCount2") >= target:Health() then
	target:SetNWBool("FreezeRag", true)
	//target:ClearSchedule()
	target:SetHealth(0)
	if (string.find(target:GetClass(),"zombie") or string.find(target:GetClass(),"zombine")) then
	dmginfo:SetDamageType(DMG_GENERIC)
	end
	local dmginfo2 = DamageInfo()
	dmginfo2:SetDamage(target:GetNWInt("NPCHitCount2"))
	if (string.find(target:GetClass(),"zombie") or string.find(target:GetClass(),"zombine")) then
	dmginfo:SetDamageType(DMG_GENERIC)
	else
	dmginfo2:SetDamageType(dmginfo:GetDamageType())
	end
	dmginfo2:SetAttacker( dmginfo:GetAttacker() )
	dmginfo2:SetInflictor( dmginfo:GetInflictor())
	dmginfo2:SetDamageForce( dmginfo:GetDamageForce())
	target:TakeDamageInfo( dmginfo2 )
	end
	end
	if ( IsValid(target:GetPhysicsObject()) and target:GetNWBool("NPCMFreezeCheck") ) then
	if target.TabForce == nil then
	target.TabForce = {}
	end
	table.insert(target.TabForce,dmginfo:GetDamageForce())
	end
	dmgfix = false
end)

if SERVER then
hook.Add("CreateEntityRagdoll","ragfrez_gm",function(target,rag)
if target:GetNWBool("NPCShattered") and IsValid(rag) then
rag:Remove()
end
if target:GetNWBool("NPCFrozenPhys") and IsValid(rag) then
local bones = rag:GetPhysicsObjectCount()
if ( bones < 2 ) then return end
local tmr = "eff_freeze" .. rag:EntIndex()
timer.Create("eff_freeze" .. rag:EntIndex(),0.3,0,function()
if IsValid(rag) then
local dir
if rag:GetPhysicsObjectNum(0):GetAngles().roll > 180 then
dir = -2
else
dir = 2
end
local effectdata = EffectData()
effectdata:SetOrigin( rag:GetPos() + rag:GetUp()*rag:OBBMaxs().z/dir + VectorRand()*math.Rand(-3,3) )
util.Effect( "frozenstatue_smoke", effectdata )
else
timer.Remove(tmr)
end
end)
rag:EmitSound("freezeray.loop")
rag:SetNWBool("NPCFrozenEnt",true)
rag:SetNWInt("FrPer",100)
if SERVER then
local hastable
for i=1,#GMSVEffectStatus do
if GMSVEffectStatus[i] == rag then
hastable = true
end
end
if !hastable then
table.insert(GMSVEffectStatus,rag)
end
if game.SinglePlayer() then
net.Start( "RagdollFreeezeEffect" )
net.WriteEntity(rag)
net.Broadcast()
else
timer.Simple(0.001,function()
if IsValid(rag) then
net.Start( "RagdollFreeezeEffect" )
net.WriteEntity(rag)
net.Broadcast()
end
end)
end
end
local randtime = math.Rand(0.5,1.5)
for bone = 1, bones - 1 do
local constraint = constraint.Weld( rag, rag, 0, bone, 0 )
rag:GetPhysicsObjectNum(bone):EnableMotion(false)
rag:GetPhysicsObjectNum(bone):SetMaterial("glass")
rag:GetPhysicsObject():SetMaterial("glass")
timer.Simple(randtime,function()
if IsValid(rag) and bone != nil then
rag:GetPhysicsObjectNum(bone):Wake()
rag:GetPhysicsObjectNum(bone):EnableMotion(true)
rag:GetPhysicsObjectNum(bone):SetPos(rag:GetPhysicsObjectNum(bone):GetPos() + Vector(0,0,5))
rag:GetPhysicsObjectNum(bone):SetAngleVelocity(Vector(0,-1100,-1100))
rag:GetPhysicsObjectNum(bone):SetVelocity(rag:GetPhysicsObjectNum(bone):GetAngles():Forward()*-10 + Vector(0,0,70))
end
end)
end
end
if target:GetNWBool("FreezeRag") and IsValid(rag) then
local bones = rag:GetPhysicsObjectCount()
if ( bones < 2 ) then return end
rag:SetNWBool("NPCMFreezeCheck", true)
if SERVER then
local hastable
for i=1,#GMSVEffectStatus do
if GMSVEffectStatus[i] == rag then
hastable = true
end
end
if !hastable then
table.insert(GMSVEffectStatus,rag)
end
if game.SinglePlayer() then
net.Start( "RagdollTimeFreeezeEffect" )
net.WriteEntity(rag)
net.Broadcast()
else
timer.Simple(0.001,function()
if IsValid(rag) then
net.Start( "RagdollTimeFreeezeEffect" )
net.WriteEntity(rag)
net.Broadcast()
end
end)
end
end
for bone = 1, bones - 1 do
if rag.TabCons == nil then
rag.TabCons = {}
end
local constraint = constraint.Weld( rag, rag, 0, bone, 0 )
table.insert(rag.TabCons,constraint)
rag:GetPhysicsObjectNum(bone):EnableMotion(false)
end
timer.Create("npcm_timefreezecheck" .. rag:EntIndex(),5,1,function()
if IsValid(rag) then
local bones = rag:GetPhysicsObjectCount()
rag:SetNWBool("NPCMFreezeCheck", false)
rag:EmitSound("ambient/levels/citadel/weapon_disintegrate2.wav",90,180)
local dir
if rag:GetPhysicsObjectNum(0):GetAngles().roll > 180 then
dir = -2
else
dir = 2
end
local effect = EffectData()
effect:SetOrigin(rag:GetPos() + rag:GetUp()*rag:OBBMaxs().z/dir)
util.Effect("refractmg2", effect)
if rag.TabCons == nil then
rag.TabCons = {}
end
for i=1,#rag.TabCons do
if rag.TabCons[i] != nil and !isbool(rag.TabCons[i]) and IsValid(rag.TabCons[i]) then
rag.TabCons[i]:Remove()
if i == #rag.TabCons then
table.Empty(rag.TabCons)
end
end
end
for bone = 1, bones - 1 do
rag:GetPhysicsObjectNum(bone):EnableMotion(true)
if rag.TabForce != nil then
for i=1,#rag.TabForce do
if rag.TabForce[i] != nil then
rag:GetPhysicsObjectNum(bone):SetVelocity((rag.TabForce[i]/2)*i)
if i == #rag.TabForce then
table.Empty(rag.TabForce)
end
end
end
end
end
end
end)
end
end)

hook.Add( "PlayerSpawn", "plydf_gm", function(ply)
if ply.HasDarkEffect then
ply:SetColor(Color(255,255,255,255))
end
if ply:GetNWBool("NPCFrozenEnt") and SERVER then
ply:Freeze(false)
end
ply:SetNWBool("NPCMFreezeCheck",false)
ply:SetNWBool("NPCFrozenEnt",false)
ply:SetNWInt("FrPer",0)
ply:SetNWFloat("FrPer",0)
ply.InitialWalkSpeed = nil
ply.InitialRunSpeed = nil
end)

hook.Add( "PlayerDeath", "plydf2_gm", function(ply,infl,att)
if ply:GetNWBool("NPCMFreezeCheck") then
if IsValid(ply:GetRagdollEntity()) then
ply:GetRagdollEntity():Remove()
local plypos={}
for i=0, 70 do
	if ply:GetBoneMatrix(i) then
		table.insert(plypos, {i,ply:GetBoneMatrix(i)})
	end
end
-- local serrag=ents.Create("prop_ragdoll") -- пизда
-- serrag:SetPos(ply:GetPos())
-- serrag:SetAngles(ply:GetAngles() - Angle(ply:GetAngles().p,0,0))
-- serrag:SetModel(ply:GetModel())
-- serrag:Spawn()
-- serrag.IsPlyRagdoll = true
-- serrag:SetNWBool("NPCMFreezeCheck",true)
-- if SERVER then
-- local hastable
-- for i=1,#GMSVEffectStatus do
-- if GMSVEffectStatus[i] == serrag then
-- hastable = true
-- end
-- end
-- if !hastable then
-- table.insert(GMSVEffectStatus,serrag)
-- end
-- if game.SinglePlayer() then
-- net.Start( "RagdollTimeFreeezeEffect" )
-- net.WriteEntity(serrag)
-- net.Broadcast()
-- else
-- -- timer.Simple(0.001,function()
-- -- if IsValid(rag) then
-- -- net.Start( "RagdollTimeFreeezeEffect" )
-- -- net.WriteEntity(serrag)
-- -- net.Broadcast()
-- -- end
-- -- end)
-- end
-- end

//ply.SVRagdoll = serrag

-- for k,v in pairs(plypos) do
-- 	serrag:SetBoneMatrix(v[1], v[2])
-- end
	
-- local force=ply:GetVelocity()
	
-- for i = 0, serrag:GetPhysicsObjectCount() - 1 do
	
-- 	local Phys = serrag:GetPhysicsObjectNum( i )
		
-- 	local Pos, Ang = ply:GetBonePosition( ply:TranslatePhysBoneToBone( i ) )
		
-- 	if ( Pos && Ang ) then
-- 		Phys:SetPos( Pos )
-- 		Phys:SetAngles( Ang )
-- 		Phys:SetVelocity( force * 1.5  )
-- 	end
-- end
-- local rag = serrag
-- local bones = rag:GetPhysicsObjectCount()
-- if ( bones < 2 ) then return end
-- rag:SetNWBool("NPCMFreezeCheck", true)
-- if SERVER then
-- local hastable
-- for i=1,#GMSVEffectStatus do
-- if GMSVEffectStatus[i] == rag then
-- hastable = true
-- end
-- end
-- if !hastable then
-- table.insert(GMSVEffectStatus,rag)
-- end
-- if game.SinglePlayer() then
-- net.Start( "RagdollTimeFreeezeEffect" )
-- net.WriteEntity(rag)
-- net.Broadcast()
-- else
-- timer.Simple(0.001,function()
-- if IsValid(rag) then
-- net.Start( "RagdollTimeFreeezeEffect" )
-- net.WriteEntity(rag)
-- net.Broadcast()
-- end
-- end)
-- end
-- end
-- for bone = 1, bones - 1 do
-- if rag.TabCons == nil then
-- rag.TabCons = {}
-- end
-- local constraint = constraint.Weld( rag, rag, 0, bone, 0 )
-- table.insert(rag.TabCons,constraint)
-- rag:GetPhysicsObjectNum(bone):EnableMotion(false)
-- end
-- timer.Create("npcm_timefreezecheck" .. rag:EntIndex(),5,1,function()
-- if IsValid(rag) then
-- local bones = rag:GetPhysicsObjectCount()
-- rag:SetNWBool("NPCMFreezeCheck", false)
-- rag:EmitSound("ambient/levels/citadel/weapon_disintegrate2.wav",90,180)
-- local dir
-- if rag:GetPhysicsObjectNum(0):GetAngles().roll > 180 then
-- dir = -2
-- else
-- dir = 2
-- end
-- local effect = EffectData()
-- effect:SetOrigin(rag:GetPos() + rag:GetUp()*rag:OBBMaxs().z/dir)
-- util.Effect("refractmg2", effect)
-- if rag.TabCons == nil then
-- rag.TabCons = {}
-- end
-- for i=1,#rag.TabCons do
-- if rag.TabCons[i] != nil and !isbool(rag.TabCons[i]) and IsValid(rag.TabCons[i]) then
-- rag.TabCons[i]:Remove()
-- if i == #rag.TabCons then
-- table.Empty(rag.TabCons)
-- end
-- end
-- end
-- for bone = 1, bones - 1 do
-- rag:GetPhysicsObjectNum(bone):EnableMotion(true)
-- if rag.TabForce != nil then
-- for i=1,#rag.TabForce do
-- if rag.TabForce[i] != nil then
-- rag:GetPhysicsObjectNum(bone):SetVelocity((rag.TabForce[i]/2)*i)
-- if i == #rag.TabForce then
-- table.Empty(rag.TabForce)
-- end
-- end
-- end
-- end
-- end
-- end
-- end)
	
//ply:SpectateEntity(serrag)
ply:Spectate(OBS_MODE_CHASE)
end
end
if ply:GetNWBool("NPCFrozenEnt") and ply:GetNWFloat("FrPer") >= 15 then
if IsValid(ply:GetRagdollEntity()) then
	ply:EmitSound("Glass.Break")
	local numgibs = ply:BoundingRadius()/2
	local Low, High = ply:WorldSpaceAABB()
	for i=1,math.Round(numgibs) do
	local vPos = Vector( math.Rand(Low.x,High.x), math.Rand(Low.y,High.y), math.Rand(Low.z,High.z) )
	local scale = ply:BoundingRadius()/20
	if game.SinglePlayer() then
	local effectdata = EffectData()
	effectdata:SetOrigin( vPos + Vector(0,0,-20) )
	effectdata:SetScale( scale )
	util.Effect( "icegibseff", effectdata )
	else
	timer.Simple(0.0001,function()
	local effectdata = EffectData()
	effectdata:SetOrigin( vPos + Vector(0,0,-20) )
	effectdata:SetScale( scale )
	util.Effect( "icegibseff", effectdata )
	end)
	end
	end
	for i = 0, ply:GetBoneCount() - 1 do
	if game.SinglePlayer() then
	local effectdata = EffectData()
	effectdata:SetOrigin( ply:GetBonePosition( i ) )
	util.Effect( "GlassImpact", effectdata )
	else
	local orig = ply:GetBonePosition( i )
	timer.Simple(0.0001,function()
	local effectdata = EffectData()
	effectdata:SetOrigin( orig )
	util.Effect( "GlassImpact", effectdata )
	end)
	end
	end
ply:GetRagdollEntity():Remove()
end
end
if ply.HasDarkEffect then
ply:SetColor(Color(255,255,255,255))
end
if ply:GetNWBool("NPCFrozenEnt") and SERVER then
ply:Freeze(false)
end
if ply:GetNWBool("NPCMFreezeCheck") and SERVER then
ply:Freeze(false)
end
if SERVER then
net.Start( "FixTimer" )
net.WriteString( "npcm_timefreezecheck" .. ply:EntIndex() )
net.Broadcast()
end
timer.Remove("npcm_timefreezecheck" .. ply:EntIndex())
ply:SetNWBool("NPCMFreezeCheck",false)
ply:SetNWBool("NPCFrozenEnt",false)
ply:SetNWInt("FrPer",0)
ply:SetNWFloat("FrPer",0)
ply:StopSound("freezeray.loop")
end)

hook.Add("EntityRemoved","FixFRSound",function(ent)
ent:StopSound("freezeray.loop")
end)

hook.Add("OnNPCKilled","FIXNPCEFLGM",function(npc,attacker,inflictor)
if npc:GetNWInt("NPCHitByLightningMG") > 0 then
npc:SetNWInt("NPCHitByLightningMG",0)
npc:SetNWBool("NPCLK",true)
end
if npc:GetNWBool("NPCMFreezeCheck") then
npc:SetNWBool("NPCMFreezeCheck",false)
end
end)

hook.Add("Tick","FIXNPCFRGM",function()
for k,v in pairs(GMSVEffectStatus) do
if IsValid(v) then
if v:IsNPC() and v:GetNWBool("NPCFrozenEnt") then
v:SetSchedule( SCHED_NPC_FREEZE )
end
if v:IsNPC() and v:GetNWBool("NPCMFreezeCheck") then
v:SetSchedule( SCHED_NPC_FREEZE )
v:SetShouldServerRagdoll(false)
end
if IsValid(v:GetPhysicsObject()) and !v:IsRagdoll() and v:GetNWBool("NPCMFreezeCheck") then 
v:GetPhysicsObject():EnableMotion(false)
end
end
end
end)
end

if CLIENT then
function freezestatue()
for k,v in pairs(FreezeTable) do
if (IsValid(v) and !v:IsPlayer() and v:GetNWInt("FrPer") > 0) or (IsValid(v) and v:IsPlayer() and v:GetNWFloat("FrPer") > 0 and v:Alive()) then
				render.SetColorModulation( 1, 1, 1 )
				if !v:IsPlayer() then
				render.SetBlend( v:GetNWInt("FrPer")/10 )
				else
				render.SetBlend( v:GetNWFloat("FrPer")/10 )
				end
				render.MaterialOverride(Material("sprites/skin_freeze"))
 
				v:DrawModel()
 
				render.SetColorModulation( 1, 1, 1 )
				render.SetBlend( 1 )
				render.MaterialOverride()
end
end
for k,v in pairs(ShockTable) do
if (IsValid(v) and !v:IsPlayer() and v:GetNWInt("NPCHitByLightningMG") > 0 and !v:GetNWBool("NPCLK")) or (IsValid(v) and v:IsPlayer() and v:Alive() and v:GetNWInt("NPCHitByLightningMG") > 0 and !v:GetNWBool("NPCLK")) then
				if !(v:IsNPC() and v:GetMoveType() == MOVETYPE_NONE) then
				render.SetColorModulation( 1, 1, 1 )
				render.SetBlend( v:GetNWInt("NPCHitByLightningMG")/10 )
				render.MaterialOverride(Material("models/alyx/emptool_glow"))
 
				v:DrawModel()
 
				render.SetColorModulation( 1, 1, 1 )
				render.SetBlend( 1 )
				render.MaterialOverride()
				end
end
end
for k,v in pairs(TimeFreezeTable) do
if (IsValid(v) and !v:IsPlayer() and v:GetNWBool("NPCMFreezeCheck")) or (IsValid(v) and v:IsPlayer() and v:Alive() and v:GetNWBool("NPCMFreezeCheck")) then
				render.SetColorModulation( 0.56862745098, 0.56862745098, 0.56862745098 )
				render.SetBlend( 0.9 )
				render.MaterialOverride(Material("metal2"))
 
				v:DrawModel()
 
				render.SetColorModulation( 1, 1, 1 )
				render.SetBlend( 1 )
				render.MaterialOverride()
end
end
end
hook.Add("PostDrawOpaqueRenderables", "freezestatueb_gm", freezestatue)

local LaserMaterial = Material( "effects/laser_citadel1" );

local MuzzleMaterial = CreateMaterial( "FreezeSprite", "UnlitGeneric",
{
    ["$basetexture"] = "sprites/egonburn",
    ["$vertexcolor"] = 1,
    ["$vertexalpha"] = 1,
    ["$additive"] = 1,
	["$translucent"] = 1
} );
local MuzzleMaterial2 = CreateMaterial( "LaserGunMuzzle3", "UnlitGeneric",
{
    ["$basetexture"] = "sprites/yellowflare",
    ["$vertexcolor"] = 1,
    ["$vertexalpha"] = 1,
    ["$additive"] = 1
} );
local MuzzleMaterial4 = CreateMaterial( "LaserGunMuzzle5", "UnlitGeneric",
{
    ["$basetexture"] = "effects/exit1",
    ["$vertexcolor"] = 1,
    ["$vertexalpha"] = 1,
    ["$additive"] = 1
} );
local MuzzleMaterialhit = CreateMaterial( "LaserGunMuzzle6", "UnlitGeneric",
{
    ["$basetexture"] = "sprites/yellowflare",
    ["$vertexcolor"] = 1,
    ["$vertexalpha"] = 1,
    ["$additive"] = 1
} );

local MuzzleColor = Color( 0, 0, 255 );
local EFFECT={}

function EFFECT:Init(data)
self.WeaponEnt = data:GetEntity()
if IsValid(self.WeaponEnt:GetOwner()) and self.WeaponEnt:GetOwner():Alive() then
self.Gmoder = self.WeaponEnt:GetOwner()
end
self.WeaponEnt.NextHitEffect = 0
end

function EFFECT:Think()
if IsValid(self.WeaponEnt) and IsValid(self.Gmoder) and self.Gmoder:Alive() and IsValid(self.Gmoder:GetActiveWeapon()) and self.Gmoder:GetActiveWeapon()==self.WeaponEnt then
local tr = self.Gmoder:GetEyeTraceNoCursor();
self.WeaponEnt:SetRenderBoundsWS( self.Gmoder:EyePos() + Vector(0,0,-10), tr.HitPos );
self:SetRenderBoundsWS( self.Gmoder:EyePos() + Vector(0,0,-10), tr.HitPos );
return true
end
end

function EFFECT:Render( )
if IsValid(self.WeaponEnt) and self.WeaponEnt:GetNWString("MagicType") == "Ice" and IsValid(self.Gmoder) and self.Gmoder:Alive() and IsValid(self.Gmoder:GetActiveWeapon()) and self.Gmoder:GetActiveWeapon()==self.WeaponEnt and self.Gmoder:KeyDown(IN_ATTACK) then
    local tr = self.Gmoder:GetEyeTrace()
	if self.WeaponEnt.LightTime < CurTime() then
	local dlight = DynamicLight( self:EntIndex()+1)
        if ( dlight ) then
			dlight.Pos = tr.HitPos
            dlight.r = 127
            dlight.g = 255
            dlight.b = 255
            dlight.Brightness = 4
            dlight.Size =100
            dlight.Decay = 100*5
            dlight.DieTime = CurTime() + 0.2
        end
	self.WeaponEnt.LightTime = CurTime() + 0.02
	end
	local tr = self.Gmoder:GetEyeTraceNoCursor();
	self.WeaponEnt:SetRenderBoundsWS( self.Gmoder:EyePos() + Vector(0,0,-10), tr.HitPos );
	self:SetRenderBoundsWS( self.Gmoder:EyePos() + Vector(0,0,-10), tr.HitPos );
    
    MuzzleColor.a = 255;
    
    local muzzleSize = 16 + math.Rand( -1, 1 );
    if IsValid(self.Gmoder) and self.Gmoder:KeyDown(IN_ATTACK) then
        
        muzzleSize = muzzleSize * 2;
        
    end
    
    
    local muzzlePos = self.Gmoder:EyePos() + Vector(0,0,-10)
    
    if IsValid(self.Gmoder) and self.Gmoder:KeyDown(IN_ATTACK) then
        
		render.SetMaterial( MuzzleMaterial );
		render.DrawSprite( muzzlePos, 8, 8, Color(255, 255, 255) );
		render.DrawSprite( muzzlePos, 8, 8, Color(255, 255, 255) );
        render.DrawSprite( tr.HitPos + tr.HitNormal*3, math.random(16,64), math.random(16,64), Color(255, 255, 255) );
        render.DrawSprite( tr.HitPos + tr.HitNormal*3, math.random(16,64), math.random(16,64), Color(255, 255, 255) );
		render.SetMaterial( MuzzleMaterial2 );
		render.DrawSprite( tr.HitPos, math.random(16,32), math.random(16,32), Color(127, 255, 255) );
        render.DrawSprite( tr.HitPos, math.random(16,32), math.random(16,32), Color(127, 255, 255) );
	    render.DrawSprite( muzzlePos, muzzleSize/2, muzzleSize/2,Color(127, 255, 255) );
        render.DrawSprite( muzzlePos, muzzleSize/2, muzzleSize/2, Color(127, 255, 255) );
				render.SetMaterial( MuzzleMaterialhit );
		render.DrawSprite( tr.HitPos, math.random(12,24), math.random(12,24), color_white );
        render.DrawSprite( tr.HitPos, math.random(12,24), math.random(12,24), color_white );
        
        render.SetMaterial( LaserMaterial );
        render.DrawBeam( muzzlePos, tr.HitPos, math.random(5,10), CurTime()*200, CurTime()*200, Color(127, 255, 255) );
        render.DrawBeam( muzzlePos, tr.HitPos,  math.random(5,10), CurTime()*200, CurTime()*200, Color(127, 255, 255) );
        
        local increment = tr.HitPos - muzzlePos;
        local distance = increment:Length();
        local num = math.Clamp( math.floor( distance / 40 ), 8, 100 );
        
        increment:Normalize();
        increment:Mul( distance / num );
        
        render.StartBeam( num + 1 );
            
            // don't add a wiggle to the first cp
            render.AddBeam( muzzlePos, 5, 1 );
            
            for i = 1, num do
                
                local vectorRand = VectorRand();
                vectorRand:Mul( 1.1 );
                
                muzzlePos:Add( increment );
                render.AddBeam( muzzlePos + vectorRand, 5, 1 );
                
            end
            
        render.EndBeam();
        
        if( CurTime() > self.WeaponEnt.NextHitEffect ) then
            
            self.WeaponEnt.NextHitEffect = CurTime() + 0.01;
            
        end
        
    end
end 
end

effects.Register(EFFECT, "iceray_beam", true)
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
