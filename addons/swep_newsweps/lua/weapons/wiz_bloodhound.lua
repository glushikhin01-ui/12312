--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

if CLIENT then
	SWEP.BounceWeaponIcon	= false 
	SWEP.WepSelectIcon = surface.GetTextureID( "vgui/entities/wiz_bloodhound.vtf" )
end

SWEP.PrintName = "Bloodhounds"
    
SWEP.Author = "splet"
SWEP.Purpose = "Pressure Thy Enemy"
SWEP.Instructions = "Click to launch a burst of blood-seeking missiles at the nearest entity. Difficult to use on grounded targets, but excels against aerial foes"
SWEP.Category = "Организация магов"
SWEP.Spawnable= true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1  -- ИЗМЕНЕНО: бесконечные патроны
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"  -- ИЗМЕНЕНО: убрана зависимость от маны
SWEP.Primary.Delay = 0.025
SWEP.BlankDelay = 0.50

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Slot = 2
SWEP.SlotPos = 4
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.Weight = 1
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 62
SWEP.ViewModel			= ''
SWEP.WorldModel			= ''
SWEP.UseHands           = true

SWEP.FiresUnderwater = true

SWEP.LastShot			= CurTime()
SWEP.FireBrick			= false
SWEP.WindingUp			= false

SWEP.offsetimpacttrace	= {}
SWEP.offsetimpact		= {}
SWEP.trueangle 			= {}

SWEP.BaseSpread			= 0.1
SWEP.ManaFatigue		= 2.4

-- ============================================
-- ПРОВЕРКА ПО STEAMID И ПРОФЕССИИ TEAM_ARCHIMAG
-- ============================================

-- СПИСОК РАЗРЕШЁННЫХ STEAMID
local AllowedSteamIDs = {
    ["STEAM_0:0:562541572"] = true, -- Frikadelka
    ["STEAM_0:1:22093009"] = true, -- Gero
    ["STEAM_0:1:452003092"] = true, -- Sansey
    ["STEAM_0:1:575732651"] = true, -- Angel
}

-- Функция проверки доступа
local function HasAccess(ply)
    if not IsValid(ply) then return false end
    if AllowedSteamIDs[ply:SteamID()] then return true end
    if ply:Team() == TEAM_ARCHIMAG then return true end
    return false
end

function SWEP:Initialize()
	self:SetHoldType( 'fist' )
end

function SWEP:Deploy()
	if SERVER then
		if not HasAccess(self.Owner) then
			self.Owner:Kill()
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ АРХИМАГ ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ АРХИМАГ ИЛИ STEAMID')
			rp.Notify(self.Owner, NOTIFY_ERROR, 'СОСИУЙ ХУЙ ДОСТУП ТОЛЬКО ПО ПРОФЕССИИ АРХИМАГ ИЛИ STEAMID')
			self:Remove()
			return false
		end
	end
	return true
end

function SWEP:PlayerSwitchWeapon(ply, oldWeapon, newWeapon)
	return false
end

function SWEP:Holster(wep)
	return true
end

function SWEP:DoDrawCrosshair(x, y)
	surface.SetDrawColor( 200, 0, 0, 175)
	
	local center = Vector( x, y, 0 )
	local scalar = ((ScreenScale(self.BaseSpread * 2.5 * LocalPlayer():GetFOV()))*1.6)/(ScreenScale(640)/ScreenScaleH(480))
	local scale = Vector( scalar, scalar, 0 )
	local segmentdist = 360 / ( 2 * math.pi * math.max( scale.x, scale.y ) / 2 )
 
	for a = 0, 365 - segmentdist, segmentdist do
		surface.DrawLine( center.x + math.cos( math.rad( a ) ) * scale.x, center.y - math.sin( math.rad( a ) ) * scale.y, center.x + math.cos( math.rad( a + segmentdist ) ) * scale.x, center.y - math.sin( math.rad( a + segmentdist ) ) * scale.y )
	end
	surface.DrawLine(x, y + 4, x, y - 4)
	surface.DrawLine(x + 4, y, x - 4, y)
	
	return true
end

function SWEP:PrimaryAttack()
	-- Убираем проверку на патроны, стреляем всегда
	if self.LastShot < CurTime() then
		local tgt = NULL
	
		local tgt_table = ents.GetAll()
		for id, ent in ipairs(tgt_table) do
			local entDistSqr =  ent:GetPos():DistToSqr(self.Owner:GetPos())
			if tgt:IsValid() and ((ent:IsNPC() and ent:Health() > 0) or (ent:IsPlayer() and ent:Alive() and ent != self.Owner)) then 
				local tgtDistSqr =  tgt:GetPos():DistToSqr(self.Owner:GetPos())
				if entDistSqr < tgtDistSqr then
					tgt = ent
				end
			elseif ((ent:IsNPC() and ent:Health() > 0) or (ent:IsPlayer() and ent:Alive() and ent != self.Owner)) then
				tgt = ent
			end
		end
	
		local function LaunchBloodhound()
			oVA = math.random(-20, 20)
			oVB = math.random(0, 20)
			
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			if ( self.Owner:IsPlayer() ) then
				self.Owner:ViewPunch( Angle(-0.05, 0, 0))
			end
			
			local eyetrace = self.Owner:GetEyeTrace()

			local originvector = self.Owner:EyePos()
			
			local vector_offsetter = Vector(0, oVA, oVB)
			vector_offsetter:Normalize()
			vector_offsetter:Rotate(self.Owner:EyeAngles())
			vector_offsetter:Mul(50)
			
			originvector:Add(vector_offsetter)

			local aimpoint = self.Owner:GetAimVector()
			local randoff = Vector(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
			randoff:Normalize()
			randoff:Mul(self.BaseSpread)
			aimpoint:Add(randoff)
			
			self.offsetimpacttrace = util.GetPlayerTrace(self.Owner, aimpoint)
			self.offsetimpact =	util.TraceLine(self.offsetimpacttrace) 
				
			local tracedata = {}
			tracedata.start = originvector
			tracedata.endpos = self.offsetimpact.HitPos
			tracedata.filter = self.Owner
			
			self.trueangle = util.TraceLine(tracedata)		
			
			if SERVER then
				local modelEnt = ents.Create("wiz_bloodhound_missile")
				local transformedangle = Vector(0, 0, -1)
				local transformedpos = originvector
				
				modelEnt:SetPos(transformedpos)
				modelEnt:SetAngles(transformedangle:Angle())
				modelEnt:SetOwner(self.Owner)
				modelEnt:SetPhysicsAttacker(self.Owner, 5)
				if tgt:IsValid() then 
					modelEnt:SetNWEntity("Wiz_Target", tgt)
					modelEnt:SetNWVector("Wiz_Targetvec", eyetrace.HitPos)
				else
					modelEnt:SetNWEntity("Wiz_Target", game.GetWorld())
					modelEnt:SetNWVector("Wiz_Targetvec", eyetrace.HitPos)
				end
				modelEnt:Spawn()
				
				local transformedvel = self.trueangle.Normal
				transformedvel:Mul(1000)
				modelEnt:GetPhysicsObject():SetVelocity(transformedvel)
			end
			effectdata = EffectData()
			effectdata:SetOrigin(originvector)
			effectdata:SetNormal(self.trueangle.Normal)
			util.Effect("fx_wizard_bloodhounds_launch", effectdata)
		end
		
		-- Убрана проверка на патроны
		self.Owner:EmitSound("common/wpn_select.wav", 80, math.random(70, 80), 0.3)
		LaunchBloodhound() 
		
		self.Owner:SetNWFloat("WizardryManaFatigue", math.max(CurTime() + self.ManaFatigue, self.Owner:GetNWFloat("WizardryManaFatigue"))) 
		self.LastShot = CurTime() + self.Primary.Delay
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher