--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--спасибо Vall

if CLIENT then --шрифты сюда

surface.CreateFont( "FPaceSpeedoFont", {
	font = "Trebuchet24",
	size = 80,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "FPaceSpeedoFont2", {
	font = "Arial",
	size = 40,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "StingerSpeedoFont", {
	font = "Arial",
	size = 60,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "ModelXSpeedoFont", {
	font = "Arial",
	size = 90,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "XC90SpeedoFont", {
	font = "Arial",
	size = 100,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "XC90SpeedoFont2", {
	font = "Arial",
	size = 30,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "KaroqSpeedoFont", {
	font = "Arial",
	size = 80,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "KaroqSpeedoFont2", {
	font = "Arial",
	size = 20,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "SennaSpeedoFont", {
	font = "Arial",
	size = 90,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "RapidSpeedoFont", {
	font = "Arial",
	size = 115,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "RapidSpeedoFont2", {
	font = "Arial",
	size = 60,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "Civic17SpeedoFont", {
	font = "Arial",
	size = 100,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "Civic17SpeedoFont2", {
	font = "Arial",
	size = 30,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "RS6AvantSpeedoFont", {
	font = "Arial",
	size = 135,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "RS6AvantSpeedoFont2", {
	font = "Arial",
	size = 50,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "VitoSpeedoFont", {
	font = "Arial",
	size = 105,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "MustangGT18Font", {
	font = "Arial",
	size = 250,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "GLECoupeSpeedoFont", {
	font = "Arial",
	size = 95,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

surface.CreateFont( "Z4G29SpeedoFont", {
	font = "Arial",
	size = 70,
	weight = 600,
	scanlines = 1,
	antialias = true,

} )

end

if SERVER then 
return 
end 

local skorost = 0
hook.Add( "PostDrawOpaqueRenderables", "CrSkCifrovoiSpeedo", function()
    local Vehicle = LocalPlayer():GetVehicle()
    if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/jaguar/fpace_2016.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (63360/3600),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-18.33,22.13,51.92)),Vehicle:LocalToWorldAngles(Angle(0,0,75)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "FPaceSpeedoFont", -50, -10, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
				draw.SimpleText( "mph" , "FPaceSpeedoFont2", -50, 50, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
	if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/kia/stinger_gt_2018.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (63360/3600),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-19.58,28.35,44.54)),Vehicle:LocalToWorldAngles(Angle(0,0,75)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "StingerSpeedoFont", 20, -37, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
	if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/tesla/model_x_2015.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (63360/3600),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-18.58,12.2,53.21)),Vehicle:LocalToWorldAngles(Angle(0,0,75)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "ModelXSpeedoFont", 5, -50, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
	if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/volvo/xc90_t8_2015.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (63360/3600),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-22.45,9.87,52.47)),Vehicle:LocalToWorldAngles(Angle(0,0,80)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "XC90SpeedoFont", 15, -65, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
				draw.SimpleText( "Km/h" , "XC90SpeedoFont2", 15, 25, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
	if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/skoda/karoq_2018.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (63360/3600),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-14.11,18.3,47.1)),Vehicle:LocalToWorldAngles(Angle(0,0,85)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "KaroqSpeedoFont", 15, -65, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
				draw.SimpleText( "km/h" , "KaroqSpeedoFont2", 15, 7, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
	if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/mclaren/senna_2019.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (63360/3600),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-15.63,35.0,38.3)),Vehicle:LocalToWorldAngles(Angle(0,0,100)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "SennaSpeedoFont", 15, -65, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
		if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/skoda/rapid_2014.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (63360/3600),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-18.5,38.42,45.73)),Vehicle:LocalToWorldAngles(Angle(0,0,75)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "RapidSpeedoFont", 15, -85, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
				draw.SimpleText( "km/h" , "RapidSpeedoFont2", 15, 27, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
		if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/honda/civic_typer_fk8_2017.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (63360/3600),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-15.9,32.2,40.15)),Vehicle:LocalToWorldAngles(Angle(0,0,50)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "Civic17SpeedoFont", -35, -85, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
				draw.SimpleText( "km/h" , "Civic17SpeedoFont2", 70, -30, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
		if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/audi/rs6_avant_2016.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (4/3 * 10.936133),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-18.8,33.33,45.66)),Vehicle:LocalToWorldAngles(Angle(0,0,50)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "RS6AvantSpeedoFont", 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
				draw.SimpleText( "km/h" , "RS6AvantSpeedoFont2", 130, 60, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
		if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/audi/rs6_avant_2016_black.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (4/3 * 10.936133),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-18.8,33.33,45.66)),Vehicle:LocalToWorldAngles(Angle(0,0,50)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "RS6AvantSpeedoFont", 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
				draw.SimpleText( "km/h" , "RS6AvantSpeedoFont2", 130, 60, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
		if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/mercedes-benz/vito_panel_2014.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (4/3 * 10.936133),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-17.54,49.93,52.42)),Vehicle:LocalToWorldAngles(Angle(0,0,50)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "VitoSpeedoFont", 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
		if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/ford/mustang_gt_2018.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (4/3 * 10.936133),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-13.5,17.4,42.81)),Vehicle:LocalToWorldAngles(Angle(0,0,65)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "MustangGT18Font", 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
		if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/ford/mustang_rtr_2018.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (4/3 * 10.936133),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-13.5,17.4,42.81)),Vehicle:LocalToWorldAngles(Angle(0,0,65)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "MustangGT18Font", 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
    end
	if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/mercedes-benz/gle63s_coupe_amg_2015.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (4/3 * 10.936133),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-21.63,36.11,53.62)),Vehicle:LocalToWorldAngles(Angle(0,0,85)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "GLECoupeSpeedoFont", 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
	end
	if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/mercedes-benz/gle63s_coupe_amg_2015_black.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (4/3 * 10.936133),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-21.63,36.11,53.62)),Vehicle:LocalToWorldAngles(Angle(0,0,85)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "GLECoupeSpeedoFont", 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
	end
		if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/bmw/z4_m40i_g29_2019.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (4/3 * 10.936133),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-20.10,11.27,40.75)),Vehicle:LocalToWorldAngles(Angle(0,0,85)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "Z4G29SpeedoFont", 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
	end
	if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if Vehicle:GetModel() == "models/crsk_autos/bmw/z4_m40i_g29_2019_black.mdl" then --путь до модельки
			local skorost = math.Round(Vehicle:GetVelocity():Length() / (4/3 * 10.936133),0)
			cam.Start3D2D(Vehicle:LocalToWorld(Vector(-20.10,11.27,40.75)),Vehicle:LocalToWorldAngles(Angle(0,0,85)),0.0095) --положение 3д2д
				surface.SetDrawColor(0,255,0)
				draw.SimpleText( skorost , "Z4G29SpeedoFont", 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, 0)
			cam.End3D2D()
		end
	end
end )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
