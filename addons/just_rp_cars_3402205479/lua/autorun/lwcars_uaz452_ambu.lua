--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local V = {
			Name = "UAZ 452 Ambulance", 
			Class = "prop_vehicle_jeep",
			Category = "LW Russian Vehicles",
			Author = "lonewolfie",
			Information = "Driveable UAZ 452 by lonewolfie",
			Model = "models/lonewolfie/uaz_452_ambu.mdl",
			
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/lwcars/uaz_452.txt"
							}
			}
list.Set("Vehicles", "uaz_452_ambu_lw", V)

if SERVER then include("lwcars_partmover.lua")

	LWCPartHook( 0.005, "doors_opening", "uaz_452_ambu", IN_SPEED, string.lower(V.Model) )
	
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
