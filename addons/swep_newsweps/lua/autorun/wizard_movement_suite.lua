--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

--howdy! thanks for rooting around in my mod! 
--this file handles all the hooks for the Wizard Movement Suite
-- -splet

AddCSLuaFile()

function WizMSDie( victim, inflictor, attacker )
	if SERVER and victim:GetNWBool("WizardryWizMovementSuite") == true then
		victim:EmitSound("items/suitchargeno1.wav")
		victim:EmitSound("items/medshotno1.wav")
		victim:SetNWBool("WizardryWizMovementSuite",false)
		victim:SetNWFloat("WizardryLastDamage", CurTime())
	end
end
hook.Add("PlayerDeath", "WizMS_Die",  WizMSDie )



--if we have armor this handles damage resistances and fx
function WizMSDMG( target, dmginfo )
	local function WizMSDMGFX(mag)
		local lastdmg = CurTime() - target:GetNWFloat("WizardryLastDamage")
		local dmgsoundfalloff = 0.25 --seconds
		local maxvolume = 0.8
		local impactvol = maxvolume
		if lastdmg < dmgsoundfalloff then
			impactvol = (maxvolume / dmgsoundfalloff) * lastdmg
		end
	
		target:EmitSound("movementsuite/hevimpact"..tostring(math.random(1,10))..".wav", 85, math.random(95, 105), impactvol)
		effectdata = EffectData()
		effectdata:SetMagnitude(mag)
		effectdata:SetEntity(target)
		util.Effect("fx_wizard_suite_hit", effectdata)
	end
	if target:IsPlayer() and target:GetNWBool("WizardryWizMovementSuite") == true and target:Alive() then
		if target:Armor() != 0 then
			if dmginfo:IsDamageType(DMG_SLASH + DMG_CLUB + DMG_GENERIC) then
				WizMSDMGFX(dmginfo:GetDamage())
				dmginfo:ScaleDamage(0.5)
			elseif dmginfo:IsDamageType(DMG_BULLET + DMG_BLAST + DMG_BURN + DMG_BUCKSHOT + DMG_AIRBOAT) then
				WizMSDMGFX(math.max(1, dmginfo:GetDamage()))
				dmginfo:ScaleDamage(0.25)
			elseif dmginfo:IsDamageType(DMG_CRUSH) then --physics damage, seems to cap out at 500
				--reduce damage by a lot. 20 from max physdamage, which happens more often than you'd think
				dmginfo:ScaleDamage(0.04)
				--spark effects and deflect object
				effectdata = EffectData()
				effectdata:SetEntity(dmginfo:GetInflictor())
				effectdata:SetMagnitude(dmginfo:GetDamage()*2)
				util.Effect("TeslaHitboxes", effectdata)
				
				WizMSDMGFX(dmginfo:GetDamage()*2)
				--actually deflect the damaging object
				local repulse = dmginfo:GetInflictor():GetVelocity() * -1
				if dmginfo:GetInflictor():GetPhysicsObject():IsValid() then
					dmginfo:GetInflictor():GetPhysicsObject():SetVelocity(repulse)
				end		
			elseif dmginfo:IsDamageType(DMG_SHOCK + DMG_SONIC) then --shock/mana (sonic) damage, take extra armor off!
				target:EmitSound("weapons/physcannon/superphys_small_zap"..tostring(math.random(1,4))..".wav", 85, math.random(95, 105), 0.5)
				target:EmitSound("weapons/airboat/airboat_gun_lastshot"..tostring(math.random(1,3))..".wav", 85, math.random(120, 150), 1)
				
				--strip armor equal to original damage
				target:SetArmor(target:Armor() - dmginfo:GetDamage())
				
				--reduce damage before applying to target
				dmginfo:ScaleDamage(0.20)
				--usual damage sparks
				WizMSDMGFX(dmginfo:GetDamage())
			end
		end
		--we were last hurt here. track it for armor regen
		target:SetNWFloat("WizardryLastDamage", CurTime())
	end
end
hook.Add("EntityTakeDamage", "WizMS_DMG",  WizMSDMG)

--remove fall damage
function WizMSFeatherFall( ply, spd )
	if ply:GetNWBool("WizardryWizMovementSuite") then
		return 0
	end
end
hook.Add("GetFallDamage", "WizMS_Fall",  WizMSFeatherFall)

local restore_delay = 0

--mana recharge, movement, armor regen
function WizMSMoveThink()
	--[[local allEnts = ents.GetAll()
	--for any entity of type player
	for k, v in ipairs( ents.FindByClass( "player" ) ) do
		ply = v
		--if they have any wizard weapon
		local hasWizWep = false
		for _, w in ipairs(ply:GetWeapons()) do
			if IsValid(w) and w:GetPrimaryAmmoType() == game.GetAmmoID("Wizardry_Mana") then
				hasWizWep = true
			end
		end
		if hasWizWep then
			if ply:GetNWFloat("WizardryManaFatigue") < CurTime() and ply:GetAmmoCount("Wizardry_Mana") < 100 and SERVER  then
				if ply:GetAmmoCount("Wizardry_Mana") >= 10 then
					ply:EmitSound("player/geiger1.wav", 80, ply:GetAmmoCount("Wizardry_Mana") * 2, 0.5)
				end
				ply:GiveAmmo(1, "Wizardry_Mana", true)
			end
			if ply:GetAmmoCount("Wizardry_Mana") > 100 then
				ply:SetAmmo(100, "Wizardry_Mana")
			end
		end
		
		--if they have the suite
		if ply:GetNWBool("WizardryWizMovementSuite") then
			--handle the suite movement
			if !ply:IsOnGround() and !ply:IsEFlagSet(EFL_NOCLIP_ACTIVE) then
				local isWizardMoving = false
				local velmod = Vector()
				if ply:KeyDown(IN_JUMP) then	--add a height cap!
					local start = ply:GetPos() + Vector(0, 0, -1) -- Adjust the starting position as needed
					local endpos = start - Vector(0, 0, 600) -- Adjust the length of the trace as needed

					local trace = util.TraceLine({
						start = start,
						endpos = endpos,
						entity = ply
					})

					local distfromground = trace.Fraction
					
					velmod:Add(ply:GetUp() * (20 - (16 * distfromground)))
					if ply:GetVelocity().z < 0 then
						velmod:Add(ply:GetUp() * -(ply:GetVelocity().z / 50))	--the harder we move down, the stronger the upwards impulse
					end
					isWizardMoving = true
				end			
				if ply:KeyDown(IN_FORWARD) then	--add super-responsive burst movement!
					velmod:Add(ply:GetForward() * 18)
					isWizardMoving = true
				end			
				if ply:KeyDown(IN_BACK) then
					velmod:Add(ply:GetForward() * -18)
					isWizardMoving = true
				end			
				
				ply:SetVelocity(ply:GetBaseVelocity() + velmod)
				
				if isWizardMoving then
					ply:EmitSound("resource/warning.wav", 80, math.max(ply:GetVelocity():Length()/10, 60), 0.03)
				end
			end
			
			--handle armor regeneration after downtime of 5 seconds
			if ply:GetNWFloat("WizardryLastDamage") < CurTime() - 5 and ply:Armor() < 100 and SERVER then
				if CurTime() < restore_delay then return end	
				ply:EmitSound("npc/dog/dog_idle3.wav", 80, ply:Armor()/2, 0.4, CHAN_STATIC)
				ply:SetArmor(ply:Armor() + 1)
				restore_delay = CurTime() + 0.15
			end
		end
	end]]
end
hook.Add("Think", "WizMS_MoveThink",  WizMSMoveThink )

--handle bhops. phoon is really too much for zblock
function WizMSHitGround(ply, inWater, onFloater, spd)
	if ply:GetNWBool("WizardryWizMovementSuite") and ply:GetVelocity():Length() >= 600 and not ply:KeyDown(IN_DUCK) then
		ply:SetVelocity(Vector(0, 0, 250))
		return true
    end
end
hook.Add("OnPlayerHitGround", "WizMS_BHop", WizMSHitGround)

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
