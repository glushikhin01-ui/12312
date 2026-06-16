--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
function ENT:Initialize()
 
	--self:SetModel( "models/hunter/blocks/cube4x4x2.mdl" )
	self:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self:SetSolid( SOLID_NONE )         -- Toolbox
	local car = self:GetParent()
	if IsValid(car) and car:IsVehicle() and SRDCarsSettings and SRDCarsSettings[car:GetModel():lower()] then
		local tabl = SRDCarsSettings[car:GetModel():lower()]
		for k,v2 in pairs(SRDCarsSettings[car:GetModel():lower()]["Doors"]) do
			car:SetNWInt("HP_Doors_"..k, 100)
			//util.PrecacheModel(v2.model)
		end
		for k,v2 in pairs(SRDCarsSettings[car:GetModel():lower()]["Props"]) do
			car:SetNWInt("HP_Props_"..k, 100)
			//util.PrecacheModel(v2.model)
		end
	else
		SafeRemoveEntity(self)
	end

	self:DrawShadow(false)
end
 
function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
	local car = self:GetParent()
	if !IsValid(car) or !car:IsVehicle() then
		SafeRemoveEntity(self)
	end
end
 


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
