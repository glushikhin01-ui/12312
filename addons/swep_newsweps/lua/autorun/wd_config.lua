--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

wd_Config = {}

if CLIENT then

-- The time is a bit weird, here are some presets: 10 is 8 seconds, 20 is 4 seconds, 40 is 2 seconds, 80 is 1 second, 160 is 0.5 seconds (there is a pattern).

wd_Config["Time"] = 120 -- 120 is 0.75 seconds
wd_Config["InnerColor"] = Color(20,20,20,255)
wd_Config["OuterColor"] = Color(255,255,255,25)
wd_Config["HilightColor"] = Color(255,255,255,255)
wd_Config["DrawLines"] = true

--

-- Below you add the name of any entity which is hackable, the name that should appear next to it and the vector offset (only change the third value).

wdEntInfo = {}
wdEntInfo["keypad"] = {"Кейпад", Vector(0, 0, 20)}
wdEntInfo["gmod_button"] = {"Кнопка", Vector(0, 0, 20)}
wdEntInfo["gmod_lamp"] = {"Лампа", Vector(0, 0, 20)}
wdEntInfo["gmod_light"] = {"Свет", Vector(0, 0, 20)}
wdEntInfo["player"] = {"Человек", Vector(0, 0, 100)}
wdEntInfo["gmod_cameraprop"] = {"Камера", Vector(0, 0, 20)}

wdEntList = {}

for k, v in pairs(wdEntInfo) do
	table.insert(wdEntList, k)
end

-- Defining these after so they don't get classes as hackable ents.
wdEntInfo["wd_signal_amplifier"] = {"Signal Amplifier", Vector(0, 0, 20)}
wdEntInfo["wd_power_booster"] = {"Power Booster", Vector(0, 0, 20)}

end

wd_Config["HackRange"] = 400

if SERVER then

wd_Config["Time"] = 0.75 -- Set according to the clientside time.
wd_Config["HackCooldown"] = 30 -- The cooldown when hacking
wd_Config["EmpCooldown"] = 100 -- The cooldown for the emp

-- Below you add the name of any entity which is hackable and the code that it should run on the server if successful.

wdEntInfo = {}

local function ExplodeEnt( ent, ply, rds, dmg, remove )
	ent:EmitSound("weapons/c4/c4_beep1.wav", 100, 100)
	timer.Simple(2, function()

		if not ent:IsValid() then return end

		local effectdata = EffectData()
		effectdata:SetOrigin(ent:GetPos())
		util.Effect("HelicopterMegaBomb", effectdata)
		util.Effect("Explosion", effectdata)
		util.BlastDamage(ent, ply, ent:GetPos(), rds, dmg)
		
		if remove == true then
			ent:Remove()
		end
	end)
end

wdEntInfo["keypad"] = function( ent, ply )
	ent:Process(ent.KeypadData.Password)

	local vPoint = ent:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("cball_explode", effectdata)

	ent:EmitSound("buttons/button19.wav", 100, 100)
end

wdEntInfo["gmod_button"] = function( ent, ply )
	ent:Toggle( !ent:GetOn() )

	local vPoint = ent:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("cball_explode", effectdata)

	ent:EmitSound("buttons/button19.wav", 100, 100)
end

wdEntInfo["gmod_light"] = function( ent, ply )
	ent:Toggle( !ent:GetOn() )

	local vPoint = ent:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("cball_explode", effectdata)

	ent:EmitSound("buttons/button19.wav", 100, 100)
end

wdEntInfo["gmod_lamp"] = function( ent, ply )
	ent:Toggle( !ent:GetOn() )

	local vPoint = ent:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("cball_explode", effectdata)

	ent:EmitSound("buttons/button19.wav", 100, 100)
end

wdEntInfo["player"] = function( ent, ply )
	ply:SetMoveType( MOVETYPE_OBSERVER )
	net.Start("wd_camera_hack")
		net.WriteEntity( ent )
	net.Send( ply )
end

wdEntInfo["gmod_cameraprop"] = function( ent, ply )

	if ent.wd_Hacker != nil then
		if ent.wd_Hacker:IsPlayer() then
			net.Start("start_wd_cooldown")
				net.WriteInt(wd_Config["HackCooldown"], 32)
			net.Send( ply )
			return
		end
	end

	ply:SetMoveType( MOVETYPE_OBSERVER )
	ent.wd_Hacker = ply
	net.Start("wd_camera_hack")
		net.WriteEntity( ent )
	net.Send( ply )
	table.insert(cameraHackers, {ply, ent})
end

wdEntInfo["wd_signal_amplifier"] = function( ent, ply )

end

wdEntInfo["wd_power_booster"] = function( ent, ply )

end

wdEntList = {}

for k, v in pairs(wdEntInfo) do
	table.insert(wdEntList, k)
end

end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
