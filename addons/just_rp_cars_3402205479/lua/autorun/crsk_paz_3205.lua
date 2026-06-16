--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local PrVeh = "prop_vehicle_jeep"
local Cat = "CrSk — Commercial Vehicles"

local V = {
	-- Required information
	Name = "PAZ 3205",
	Model = "models/crsk_autos/paz/3205.mdl",
	Class = PrVeh,
	Category = Cat,

	-- Optional information
	Author = "CrushingSkirmish",
	Information = "",

	KeyValues = {
		vehiclescript = "scripts/vehicles/crsk_autos/crsk_paz_3205.txt"
	}
}
list.Set( "Vehicles", "crsk_paz_3205", V )

 if SERVER then
	hook.Add("Think", "CrskPaz3205_BusDoors", function()
		for _, ent in pairs(ents.FindByClass("prop_vehicle_jeep*")) do
				if ent:GetModel() == "models/crsk_autos/paz/3205.mdl" then
				local Doors = 0
			if IsValid(ent:GetDriver()) then
				if ent:GetDriver():KeyDown(IN_ATTACK) then 
					Doors = 1 
				end
				if ent:GetDriver():KeyPressed(IN_ATTACK) then ent:EmitSound("vehicles/_tails_/ikarus/door_open.ogg") end 
			end
			ent.BusDoors = Lerp(0.02, ent.BusDoors or 0, Doors)
			ent:SetPoseParameter("doors", ent.BusDoors)


			end
		end
	end)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
