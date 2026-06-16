--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.AutomaticFrameAdvance = true
ENT.Model = "models/zerochain/props_christmas/snowballswep/zck_snowballcrate.mdl"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Snowball Crate"
ENT.Category = "Zeros Snowball Swep"
ENT.RenderGroup = RENDERGROUP_OPAQUE

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "UsedCrateCount")

	if SERVER then
		self:SetUsedCrateCount(0)
	end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
