--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

if CLIENT then
	SWEP.BounceWeaponIcon	= false 
	SWEP.WepSelectIcon = surface.GetTextureID( "vgui/entities/wiz_lightning_caller.vtf" )
end

SWEP.PrintName = "Lightning Caller"
    
SWEP.Author = "splet"
SWEP.Purpose = "Smite Thy Enemy"
SWEP.Instructions = "Click to strike a column at your cursor with holy lightning. Will lock onto an entity if you click on them accurately"
SWEP.Category = "Организация магов"
SWEP.Spawnable= true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1  -- Бесконечные патроны
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"  -- Убрана зависимость от маны

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Slot = 3
SWEP.SlotPos = 4
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.Weight = 1
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 58
SWEP.ViewModel			= "models/weapons/c_wizardry_caller.mdl"
SWEP.WorldModel			= ''
SWEP.UseHands           = true

SWEP.FiresUnderwater = true

SWEP.LastShot			= CurTime()
SWEP.LastSpark			= CurTime()
SWEP.WindingUp			= false
SWEP.WindUpIntensity	= 1
SWEP.LastFired			= false
SWEP.AnticipationFired = false
SWEP.Target				= nil
SWEP.ManaFatigue		= 4
SWEP.ManaCost			= 85

-- ============================================
-- ПРОВЕРКА ПО STEAMID И ПРОФЕССИИ TEAM_ARCHIMAG
-- ============================================

-- ТОЛЬКО ЭТИ 4 STEAMID
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
	sound.Add({
		name = "callerThunder",
		sound = "caller/wizardry_thunder.wav",
		level = 500
	})
	sound.Add({
		name = "callerZoomp",
		sound = "caller/wizardry_thunderimpact.wav",
		level = 500
	})
	self:SetHoldType( 'normal' )
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

function SWEP:DoDrawCrosshair(x, y)
	if CLIENT then
		surface.SetDrawColor( 100, 255, 255, 175)
		
		local center = Vector(x, y, 0 )
		local scalar = ((ScreenScale(0.02 * LocalPlayer():GetFOV()))*1.6)/(ScreenScale(640)/ScreenScaleH(480))
		
		local scale = Vector( scalar, scalar, 0 )
		
		local segmentdist = 360	/ ( 2 * math.pi * math.max( scale.x, scale.y ) / 2 )
		for a = 0, 365 - segmentdist, segmentdist do
			surface.DrawLine( center.x + math.cos( math.rad( a ) ) * scale.x, center.y - math.sin( math.rad( a ) ) * scale.y, center.x + math.cos( math.rad( a + segmentdist ) ) * scale.x, center.y - math.sin( math.rad( a + segmentdist ) ) * scale.y )
		end
		
		surface.DrawLine(x, y + 4, x, y - 4)
		surface.DrawLine(x + 4, y, x - 4, y)
	end
	return true
end

function SWEP:PlayerSwitchWeapon(ply, oldWeapon, newWeapon)
	if self.WindingUp or self.LastFired then
		return true
	else
		return false
	end
end

function SWEP:Holster(wep)
	if self.WindingUp or self.LastFired then
		return false
	else
		return true
	end
end

function SWEP:PrimaryAttack()
	-- Убираем проверку на патроны
	if self.LastShot < CurTime() then
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		--lag compensate our eye tracer
		if ( self:GetOwner():IsPlayer() ) then
			self:GetOwner():LagCompensation( true )
		end
		local pos = self.Owner:GetEyeTrace().HitPos
		local entfound = self.Owner:GetEyeTrace().Entity
		if entfound and entfound:IsValid() then
			pos = entfound:GetPos()
			self.Target = entfound
		end
		if ( self:GetOwner():IsPlayer() ) then
			self:GetOwner():LagCompensation( false )
		end
		
		local strikeDelay = 0.40
		
		if SERVER then
			timer.Simple(strikeDelay - 0.52,function()
				if self:IsValid() then
					self:EmitSound("callerThunder", 500)
				end
			end)
			
			timer.Simple(strikeDelay - 0.12,function()
				if self:IsValid() then
					self:EmitSound("callerZoomp", 500)
				end
			end)

		end
		--local and server calls
		self.WindingUp = true
		self.LastShot = CurTime() + 3.6
		
		timer.Simple(strikeDelay - 0.15,function()
			self.AnticipationFired = true
		end)
		
		timer.Simple(strikeDelay,function()
			if self:IsValid() then
				self:EmitSound("ambient/explosions/exp2.wav", 500)
				self.WindingUp = false
				self.WindUpIntensity = 1
				self.LastSpark = CurTime()
				self.LastFired = true
				-- Убрана проверка на патроны и ману
				self.Owner:SetNWFloat("WizardryManaFatigue", math.max(CurTime() + self.ManaFatigue, self.Owner:GetNWFloat("WizardryManaFatigue"))) 
			end
		end)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	-- УДАЛЕНЫ ВСЕ СТАРЫЕ ПРОВЕРКИ (self.Owner:Kill() и IsMag)
	-- Теперь проверка только в Deploy
	
	local pos = self.Owner:GetEyeTrace().HitPos
	local entfound = self.Owner:GetEyeTrace().Entity
	
	--override pos with target origin
	if entfound and entfound:IsValid() then
		pos = entfound:GetPos()
	end
	
	--if we clicked on a target first, override pos and entfound
	if self.Target and self.Target:IsValid() then
		entfound = self.Target
		pos = self.Target:GetPos()
	end
	
	--this makes us and the target spark & plays the sound (убрана проверка на патроны)
	if util.SharedRandom("sparkServerClientA", 0, 1) > 0.95 and self.LastSpark < CurTime() and self.LastShot < CurTime() then
		local function passive_spark(tgt)
			if CLIENT and IsValid(tgt) then
				local dlight = DynamicLight(math.random(1, 1000))
				if ( dlight ) then
					dlight.pos = tgt:GetPos() + Vector(0, 0, 50)
					dlight.r = 207
					dlight.g = 255
					dlight.b = 250
					dlight.brightness = 2
					dlight.decay = 1000
					dlight.size = 150
					dlight.dietime = CurTime() + 1
				end
			end
			if IsValid(tgt) then
				tgt:EmitSound(Sound"ambient/energy/spark"..tostring(math.random(1,6))..".wav", 100, 100, 0.25)
				local effectdata = EffectData()
				effectdata:SetEntity(tgt)
				effectdata:SetMagnitude(6)
				util.Effect( "TeslaHitboxes", effectdata )	
				if tgt:IsRagdoll() then
					for i=0, tgt:GetPhysicsObjectCount() - 1 do
						--twitch
						local phys = tgt:GetPhysicsObjectNum(i)
						if IsValid(phys) then
							phys:ApplyForceCenter(Vector(math.random(-250, 250),math.random(-250, 250),math.random(-250, 250)))
						end
					end
				end
			end
		end
		
		passive_spark(self.Owner)
		
		if entfound and entfound:IsValid() then
			passive_spark(entfound)
		end
		self.LastSpark = CurTime() + 1.6
	end
	
	if self.WindingUp then
		--windup zaps
		if math.random() > 0.6 - (self.WindUpIntensity*5) then
			local function windup_lights(tgt)
				if CLIENT then
					local dlight = DynamicLight(math.random(1, 1000))
					if ( dlight ) then
						dlight.pos = tgt
						dlight.r = 130
						dlight.g = 160
						dlight.b = 255
						dlight.brightness = 1
						dlight.decay = 1000
						dlight.size = 50 * self.WindUpIntensity
						dlight.dietime = CurTime() + 1
					end
				end
			end
			local function windup_tesla(tgt)
				if IsValid(tgt) then
					effectdata = EffectData()
					effectdata:SetEntity(tgt)
					effectdata:SetMagnitude(self.WindUpIntensity/2)
					util.Effect("TeslaHitboxes", effectdata)
					if tgt:IsRagdoll() then
						for i=0, tgt:GetPhysicsObjectCount() - 1 do
							local phys = tgt:GetPhysicsObjectNum(i)
							if IsValid(phys) then
								phys:ApplyForceCenter(Vector(math.random(-250, 250),math.random(-250, 250),math.random(-250, 250)))
							end
						end
					end
				end			
			end
			
			if CLIENT then
				if entfound and entfound:IsValid() then
					windup_lights(entfound:GetPos())
				else
					windup_lights(pos)
				end
				windup_lights(self.Owner:GetPos())
			end
			windup_tesla(self.Owner)
			if entfound and entfound:IsValid() then
				windup_tesla(entfound)
			end
			
			self.WindUpIntensity = self.WindUpIntensity + 0.25
			
		end
		--tracer sparks
		if self.Target == nil and !entfound:IsValid()  then
			if math.random() > 0.8 then
				local effectdata = EffectData()
				effectdata:SetOrigin(pos)
				util.Effect("StunstickImpact", effectdata)
			end
		end
	end
	
	--anticipation
	if self.AnticipationFired then
		if SERVER then
			local ES = ents.Create("env_sprite")
			ES:SetKeyValue("model", "sprites/blueflare1.spr")
			ES:SetKeyValue("scale", "0")
			ES:SetKeyValue("rendermode", "9")
			ES:SetPos(pos)
			ES:Spawn()
			ES:Fire("Alpha","170",0)
			ES:Fire("Color","60 90 255",0)
			ES:Fire("Kill","",0.15)
			for i = 0.15,0.01,-0.01
			do
				ES:Fire("SetScale",tostring(0+(i*300)), i)
				ES:SetPos(pos)
			end	
			self.AnticipationFired = false
		end
		if CLIENT then
			self.AnticipationFired = false
		end
	end
	
	--cast follows mouse
	if self.LastFired then
		if SERVER then
			local xplo = ents.Create("env_explosion")
			xplo:SetPos(pos)
			xplo:SetKeyValue("iMagnitude","0")
			xplo:SetKeyValue("iRadiusOverride","0")
			xplo:SetKeyValue("spawnflags", 64 + 512)
			xplo:Spawn()
			xplo:Fire("Explode",0,0)	
			--boom fx at caster
			local xplo = ents.Create("env_explosion")
			xplo:SetPos(self.Owner:GetPos())
			xplo:SetKeyValue("iMagnitude","0")
			xplo:SetKeyValue("iRadiusOverride","0")
			xplo:SetKeyValue("spawnflags", 1 + 4 + 64 + 512)
			xplo:Spawn()
			xplo:Fire("Explode",0,0)	
			
			--apply lots of decals
			util.Decal("Scorch", pos, pos + Vector(0, 0, -10), player.GetAll())
			for i = 1, 5 do
				util.Decal("Scorch", pos + Vector(math.Rand(-2, 2) * 25, math.Rand(-2, 2) * 25 , 50), pos + Vector(math.Rand(-2, 2) * 25, math.Rand(-2, 2) * 25 , -50), player.GetAll())
			end				

			local effectdata = EffectData()
			effectdata:SetOrigin(pos)
			effectdata:SetScale(1)
			effectdata:SetMagnitude(8)
			effectdata:SetNormal(Vector(0, 0, 1))
			effectdata:SetRadius(100)
			util.Effect( "Sparks", effectdata )										
			
			local zapdamage = DamageInfo()
			zapdamage:SetAttacker(self.Owner)
			zapdamage:SetInflictor(self)
			zapdamage:SetDamage(2048)
			zapdamage:SetMaxDamage(8192)
			zapdamage:SetDamageType(DMG_SHOCK)
			
			--main hit damage
			util.BlastDamageInfo(zapdamage, pos + Vector(0, 0, 100), 80)
			util.BlastDamageInfo(zapdamage, pos + Vector(0, 0, 50), 80)
			util.BlastDamageInfo(zapdamage, pos , 80)
			
			--bolt damage
			zapdamage:SetDamage(1024)
			for i = -50, 250 do
				util.BlastDamageInfo(zapdamage, pos + Vector(0, 0, i * 200), 80)
			end
			
			--gib combine constructs
			for i = 1, 10 do
				util.BlastDamage(self, self.Owner, pos, 1, 1024)
			end
			
			
			--screenshake
			local function ShakeScreen()
				local screenshake = ents.Create("env_shake")
				screenshake:SetKeyValue("amplitude", 1000)
				screenshake:SetKeyValue("duration", 2)
				screenshake:SetKeyValue("radius", 400)
				screenshake:SetKeyValue("frequency", 255)
				screenshake:Spawn()
				screenshake:SetPos(pos)
				screenshake:Activate()
				screenshake:Fire("StartShake", "", 0)
				screenshake:Fire("Kill","",0)
			end
			local function ShakeGlobal()
				local screenshake = ents.Create("env_shake")
				screenshake:SetKeyValue("amplitude", 1000)
				screenshake:SetKeyValue("duration", 2)
				screenshake:SetKeyValue("radius", 600)
				screenshake:SetKeyValue("spawnflags", "4, 8, 16")
				screenshake:SetKeyValue("frequency", 255)
				screenshake:Spawn()
				screenshake:SetPos(pos)
				screenshake:Activate()
				screenshake:Fire("StartShake", "", 0)
				screenshake:Fire("Kill","",0)
			end			
			for i = 1, 65 do
				ShakeScreen()
			end
			for i = 1, 2 do
				ShakeGlobal()
			end
			
			--steam at bolt
			local ES = ents.Create("env_steam")
			ES:SetKeyValue("initialstate", "1")
			ES:SetKeyValue("angles", "270 0 0 ")
			ES:SetKeyValue("type", "1")
			ES:SetKeyValue("spreadspeed", "5")
			ES:SetKeyValue("speed", "40")
			ES:SetKeyValue("startsize", "30")
			ES:SetKeyValue("endsize", "1")
			ES:SetKeyValue("rate", "20")
			ES:SetKeyValue("jetlength", "90")
			ES:SetKeyValue("rollspeed", "50")
			ES:SetKeyValue("renderamt", "200")
			ES:SetPos(pos)
			ES:Spawn()
			ES:Fire("TurnOn","",0)
			ES:Fire("TurnOff","",3)
			ES:Fire("Kill","",5)
			for i = 2,0.5,-0.5
			do
				ES:Fire("speed",tostring(40-(i*30)), i)
			end						
			
			--steam at caster
			local ES = ents.Create("env_steam")
			ES:SetKeyValue("initialstate", "1")
			ES:SetKeyValue("angles", "270 0 0 ")
			ES:SetKeyValue("type", "1")
			ES:SetKeyValue("spreadspeed", "5")
			ES:SetKeyValue("speed", "40")
			ES:SetKeyValue("startsize", "30")
			ES:SetKeyValue("endsize", "1")
			ES:SetKeyValue("rate", "20")
			ES:SetKeyValue("jetlength", "90")
			ES:SetKeyValue("rollspeed", "50")
			ES:SetKeyValue("renderamt", "200")
			ES:SetPos(self.Owner:GetPos())
			ES:Spawn()
			ES:Fire("TurnOn","",0)
			ES:Fire("TurnOff","",3)
			ES:Fire("Kill","",5)
			for i = 2,0.5,-0.5
			do
				ES:Fire("speed",tostring(40-(i*30)), i)
			end
			
			--bolt proper
			local function bolt(offset)
				local ES = ents.Create("env_sprite")
				ES:SetKeyValue("model", "sprites/bluelight1.spr")
				ES:SetKeyValue("scale", "75")
				ES:SetKeyValue("rendermode", "5")
				ES:SetKeyValue("disablereceiveshadows", "true")
				ES:SetPos(pos + Vector(0, 0, offset))
				ES:Spawn()
				ES:Fire("Kill","",0.50)
				for i = 0.50,0.01,-0.01
				do
					ES:SetPos(pos + Vector(0, 0, i*18000) + Vector(0, 0, offset))
					ES:Fire("SetScale",tostring(75-(i*250)), i)
				end	
			end
			for i = -5, 5, 1 do
				bolt(i*1000)
			end
			
			--glow around bolt
			local ES = ents.Create("env_sprite")
			ES:SetKeyValue("model", "sprites/blueflare1.spr")
			ES:SetKeyValue("scale", "180")
			ES:SetKeyValue("rendermode", "9")
			ES:SetPos(pos)
			ES:Spawn()
			ES:Fire("Alpha","200",0)
			ES:Fire("Color","150 200 255",0)
			ES:Fire("Kill","",0.20)
			for i = 0.20,0.01,-0.01
			do
				ES:Fire("SetScale",tostring(180-(i*800)), i)
			end				
			
			--glow around the caster 
			local ES = ents.Create("env_sprite")
			ES:SetKeyValue("model", "sprites/blueflare1.spr")
			ES:SetKeyValue("scale", "40")
			ES:SetKeyValue("rendermode", "9")
			ES:SetPos(self.Owner:GetPos() + Vector(0, 0, 75))
			ES:Spawn()
			ES:Fire("Alpha","170",0)
			ES:Fire("Color","50 70 255",0)
			ES:Fire("Kill","",0.20)
			for i = 0.20,0.01,-0.01
			do
				ES:Fire("SetScale",tostring(40-(i*500)), i)
			end						
			
		end
		self.Target = nil
		self.LastFired = false
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher