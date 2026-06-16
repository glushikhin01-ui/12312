--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

if SERVER then
	function SWEP:SplashAttack()

		local explosioneffect = ents.Create( "prop_combine_ball" ) explosioneffect:SetPos(self.Owner:GetPos()) explosioneffect:Spawn() explosioneffect:Fire( "explode", "", 0 )
		
		for k, v in pairs ( ents.FindInSphere( self.Owner:GetPos(), 120 ) ) do
			if v:IsValid() and v != self.Owner then
				v:TakeDamage( 150 )
			end	
		end
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
