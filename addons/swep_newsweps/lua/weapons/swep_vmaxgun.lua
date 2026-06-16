--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()
AddCSLuaFile("includes/koxleta_aleksandra_martynasmalec.lua")
include("includes/koxleta_aleksandra_martynasmalec.lua")

-- ============================================
-- ПРОВЕРКА ПО STEAMID И ПРОФЕССИИ (TEAM_SOPMOD)
-- ============================================

-- СПИСОК РАЗРЕШЁННЫХ STEAMID (вставь свои)
local AllowedSteamIDs = {
    ["STEAM_0:0:562541572"] = true, -- Frikadelka
	["STEAM_0:1:22093009"] = true, -- Gero
	["STEAM_0:1:452003092"] = true, -- Sansey
	["STEAM_0:1:575732651"] = true,   -- Angel
}

-- Функция проверки (SteamID или профессия TEAM_SOPMOD)
local function IsAllowed(ply)
    if not IsValid(ply) then return false end
    
    -- Проверка по SteamID
    if AllowedSteamIDs[ply:SteamID()] then
        return true
    end
    
    -- Проверка по профессии TEAM_SOPMOD
    if ply:Team() == TEAM_SOPMOD then
        return true
    end
    
    return false
end

-- Функция наказания
local function Punish(ply)
    if not IsValid(ply) then return end
    ply:Kill()
    rp.Notify(ply, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ПО STEAMID ИЛИ ПРОФЕССИИ')
    rp.Notify(ply, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ПО STEAMID ИЛИ ПРОФЕССИИ')
    rp.Notify(ply, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ПО STEAMID ИЛИ ПРОФЕССИИ')
end

-- Перехват получения оружия (из Q меню)
hook.Add("PlayerSpawnedSWEP", "VmaxgunSteamCheck", function(ply, wep)
    if not IsValid(wep) then return end
    if wep:GetClass() ~= "swep_vmaxgun" then return end
    if not IsAllowed(ply) then
        ply:StripWeapon("swep_vmaxgun")
        Punish(ply)
    end
end)

-- Перехват поднятия с земли
hook.Add("PlayerCanPickupWeapon", "VmaxgunPickupCheck", function(ply, wep)
    if not IsValid(wep) then return nil end
    if wep:GetClass() == "swep_vmaxgun" and not IsAllowed(ply) then
        Punish(ply)
        return false
    end
    return nil
end)

-- Перехват когда оружие уже в руках
hook.Add("PlayerSwitchWeapon", "VmaxgunSwitchCheck", function(ply, oldWep, newWep)
    if not IsValid(newWep) then return end
    if newWep:GetClass() == "swep_vmaxgun" and not IsAllowed(ply) then
        timer.Simple(0.1, function()
            if IsValid(ply) then
                ply:StripWeapon("swep_vmaxgun")
                Punish(ply)
            end
        end)
    end
end)

-- ============================================
-- ОСНОВНОЙ КОД ОРУЖИЯ
-- ============================================

SWEP.Spawnable = true
SWEP.AdminOnly = false
 
SWEP.PrintName = "=DD"
SWEP.ViewModel = Model("models/weapons/c_smg1.mdl")
SWEP.WorldModel = Model("models/weapons/w_smg1.mdl")
SWEP.ViewModelFOV = 45
SWEP.DrawCrosshair = true
SWEP.UseHands = true
SWEP.Category = "Личное оружие"
 
SWEP.Slot = 3
SWEP.m_WeaponDeploySpeed = 3
SWEP.Primary.ClipSize = 50
SWEP.Secondary.ClipSize = 0
SWEP.Primary.Delay = 0.11
SWEP.Secondary.Delay = 2.5
SWEP.Primary.Automatic = true

SWEP.NextAmmoRegen = 0
SWEP.NextReload = 0
 
local ColorTable = {{"dobra","dobra","dobra"},{"eh","dobra","dobra"},{"dobra","dobra","dobra"}}

if SERVER then
	function SWEP:Initialize()
		self:SetNWInt("ColorType",math.random(1,4))// # operator dlugosci tablicy CZARYY
		self.HitPropsCarrierTb = {}

		self:SetClip1(self.Primary.ClipSize)

		//PrintTable(self:GetMaterials())

		self.Spreadation = 0
	end

	function SWEP:Think()

		if self.NextAmmoRegen < CurTime() && self:Clip1() < self.Primary.ClipSize then
			self:SetClip1(self:Clip1() + 1)
			self.NextAmmoRegen = CurTime() + 0.06
		end

		if self:GetNextPrimaryFire() < CurTime() && !self.Owner:KeyDown(IN_ATTACK) then
			self.Spreadation = math.Approach(self.Spreadation, 0, 4)
		end

	end
end


function SWEP:Deploy()
   -- self.Owner:DrawViewModel(false)
   -- local traceeffect = EffectData()
-- 	traceeffect:SetEntity(self.Weapon)
-- 	util.Effect("iceray_beam", traceeffect)

	self:SetWeaponHoldType("smg")
	
end

local husqvarna = [[IGID@D=IGID@D=IKLKLLIKIKKGIGDDGIIGID@D=IGID@D=IKLKLLIKIKKGIGIIKLPNPLGLDPNPLGLDPRSRSSPRPRRNPNKKNPPNPLGLDPNPLGLDPRSRSSPRPRRNPNKKNPIGID@D=IGID@D=
	IKLKLLIKIKKGIGDDGIIGID@D=IGID@D=IKLKLLIKIKKGIGIIKLPNPLGLDPNPLGLDPRSRSSPRPRRNPNKKNPPNPLGLDPNPLGLDPRSRSSPRPRRNPNKKNP]]
local djkamil = 1

function SWEP:Reload()
	if IsFirstTimePredicted() && self.NextReload < CurTime() && self.Owner:KeyPressed(IN_RELOAD) then
		local cur = self:GetNWInt("ColorType")
		local max = #koxlette.GetEntireKoxleta()

		self.NextReload = CurTime() + 0.2

		self:SetNWInt("ColorType", ((cur + 4) % max) + 1)
		self:EmitSound("buttons/lightswitch2.wav", 75, 100, 1, CHAN_AUTO)
	end
end

function SWEP:PrimaryAttack()
	self.NextAmmoRegen = CurTime() + 1
	if self:GetNextPrimaryFire() > CurTime() then return end

	if self:Clip1() < 1 then
		if self.Owner:KeyPressed(IN_ATTACK) && IsFirstTimePredicted() then
			djkamil = djkamil + 1
			local pitch = math.pow(2, (string.byte(husqvarna[djkamil % #husqvarna + 1]) + 10)/12)
			self:EmitSound("buttons/blip1.wav", 75, pitch)
			self:SetNextPrimaryFire(CurTime() + 0.09)
		end
	
		return
	end

	self:EmitSound("vmaxgun/44k/1firenew2.wav", 75, math.random(100,120))
	
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:ShootEffects()
   	
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:MuzzleFlash()

	if SERVER then
	  	local vball = ents.Create("entity_vball")
        
	   	local korekta

        if game.SinglePlayer() then
            korekta = 0
        else
            korekta = math.max((self.Owner:GetVelocity() * 0.2):Dot(self.Owner:GetRight()),0)
        end
        
        vball:SetPos(self.Owner:GetShootPos() + self.Owner:GetRight() * 10 - self.Owner:GetUp() * 8 + self.Owner:GetRight() * korekta)
	    
	    vball:SetAngles(self.Owner:GetAngles())
	    vball:SetOwner(self:GetOwner())
		vball:SetNWInt("ColorType",self:GetNWInt("ColorType"))
	    vball:Spawn()

	    local tocenter = (self:GetOwner():GetEyeTrace().HitPos - vball:GetPos()):GetNormalized()

	    vball:GetPhysicsObject():SetVelocity((tocenter * 35000) + VectorRand() * self.Spreadation)
	  	vball.LifeTime = CurTime() + 5
		vball.HitPropsTb = self.HitPropsCarrierTb

		self.Spreadation = math.Approach(self.Spreadation, 600, 20)
	end
	    
    if !self.Owner:IsNPC() then
        self.Owner:ViewPunch( Angle( math.random(-0.5,-1,0), Vector(-0.5,-1,0), Vector(-0.5,-1,0) ) )
    end
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetClip1(self:Clip1() - 1)
end

function SWEP:SecondaryAttack()
	if(self:GetNextSecondaryFire() > CurTime()) then return end
	self.NextAmmoRegen = CurTime() + 1
	
	if self:Clip1() < 15 then
		
		if self.Owner:KeyPressed(IN_ATTACK2) then
			djkamil = djkamil + 1
			local pitch = math.pow(2, (string.byte(husqvarna[djkamil % #husqvarna + 1]) + 10)/12)
			self:EmitSound("buttons/blip1.wav", 75, pitch)
		end
		
		self:SetNextSecondaryFire(CurTime() + 0.02)
		return
	end

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:MuzzleFlash()
	
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
   	if SERVER then
  	  	local vball = ents.Create("entity_vexplodoball")

        local korekta

        if game.SinglePlayer() then
            korekta = 0
        else
            korekta = math.max((self.Owner:GetVelocity() * 0.2):Dot(self.Owner:GetRight()),0)
        end
        
        vball:SetPos(self.Owner:GetShootPos() + self.Owner:GetRight() * 10 - self.Owner:GetUp() * 8 + self.Owner:GetRight() * korekta)
        
        vball:SetAngles(self.Owner:GetAngles())
        vball:SetOwner(self:GetOwner())
		vball:SetNWInt("ColorType",self:GetNWInt("ColorType"))
        vball:Spawn()
       	
        vball:GetPhysicsObject():SetVelocity((self:GetOwner():GetAimVector() * 900))
        vball.LifeTime = CurTime() + 1.5
    end

   	if !self.Owner:IsNPC() then
        self.Owner:ViewPunch( Angle( math.random(-1.5,-3), Vector(0,0,0), Vector(0,0,0) ) )
    end
	
	self:SetClip1(self:Clip1() - 15)
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
end

function SWEP:FireAnimationEvent( pos, ang, event, options )
	if(event == 21 || event == 22) then
		local effect = EffectData()
			effect:SetColor(self:GetNWInt("ColorType"))
			effect:SetEntity( self )
			effect:SetAttachment( 1 )
			util.Effect( "effect_muzzle", effect )
			return true
		elseif(event == 6001) then return true
	end
	
end

function SWEP:Holster(wep)
    if IsValid(wep) && IsValid(wep:GetOwner()) then
        local own = wep:GetOwner()
        local vm = own:GetViewModel()

        if IsValid(vm) then
            vm:SetSubMaterial(1, nil)
        end
    end

    return true
end

if CLIENT then
	function SWEP:CustomAmmoDisplay()
		local tbl = {}
		tbl.Draw = true
		tbl.PrimaryClip = self:Clip1()
		tbl.PrimaryAmmo = false
		tbl.SecondaryAmmo = false

		return tbl
	end

	function SWEP:Initialize()
		self:SetWeaponHoldType("smg")

		self.PrimaryInverse = 1/self.Primary.Delay
		self.AmmoInverse = 1/self.Primary.ClipSize
	end
	
	local viewpos = Vector(20, 0, 0)

	local matrxi = Matrix()
	matrxi:Identity()
	matrxi:SetScale(Vector(1,1,1) * 1.1)

	function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	    //draw.SimpleText( " A", "HL2MPTypeDeath", x + wide/2, y + tall*0.2, Color( 250,220,0, 225 ), TEXT_ALIGN_CENTER )
	    local ent = ClientsideModel("models/weapons/w_smg1.mdl")
	    viewpos.z = math.sin(CurTime() * 3) + 1 - 3
	    ent:SetPos(viewpos)
	    ent:SetAngles(Angle(0, CurTime() * 180, 0))
	    ent:SetNoDraw(true)

	    cam.Start3D(vector_origin, angle_zero, 70, x, y, wide, tall)

	    render.SetStencilWriteMask(255)
	    render.SetStencilTestMask(255)
	    render.SetStencilReferenceValue(0)
		render.SetStencilCompareFunction( STENCIL_ALWAYS )
		render.SetStencilPassOperation( STENCIL_KEEP )
		render.SetStencilFailOperation( STENCIL_KEEP )
		render.SetStencilZFailOperation( STENCIL_KEEP )
		render.SetStencilEnable(true)


		render.ClearStencil()

		render.SetStencilCompareFunction( STENCIL_NEVER )
		render.SetStencilFailOperation( STENCIL_REPLACE )
		render.SetStencilReferenceValue( 1 )

	    ent:DrawModel()

		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.SetStencilFailOperation( STENCIL_KEEP )

		local nomadcolor = (koxlette.GetKoxletaBasedOnNumber(self:GetNWInt("ColorType")) or {color_white})[1]
		cam.Start2D()
		surface.SetDrawColor(nomadcolor.r, nomadcolor.g, nomadcolor.b)
		surface.DrawRect(0, 0, wide, tall)
		cam.End2D()

	    render.SetStencilEnable( false )
	    cam.End3D()

	    ent:Remove()
	end

	function SWEP:PreDrawViewModel(vm, wep, ply)
		vm:SetSubMaterial(1, "silverethernet2021/hull")
	end

	local vector_red = Vector(0.1, 0.1, 0.1)

	function SWEP:GetNOMADColor()
		local nomadcolor = (koxlette.GetKoxletaBasedOnNumber(self:GetNWInt("ColorType")) or {color_white})[1]

		local y = math.max((self:GetNextPrimaryFire() - CurTime()), 0) * (self.PrimaryInverse or 0)
		local x = 2 + math.sin(CurTime() * 4) * 0.3 + 12 * y
		local z = 1 - self:Clip1() * self.AmmoInverse

		return LerpVector(z * z * z, (nomadcolor):ToVector(), vector_red) * x
	end

	matproxy.Add({
		name = "NOMAD_wannabe", 
		init = function( self, mat, values )
			self.ResultTo = values.resultvar
		end,
		bind = function( self, mat, ent )
			local ply = ent:GetOwner()

			if IsValid(ply) then
				local wep = ply:GetWeapon("swep_vmaxgun")

				if IsValid(wep) && wep.GetNOMADColor then
					mat:SetVector( self.ResultTo, wep:GetNOMADColor() )
				end
			end
		end 
	})
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher