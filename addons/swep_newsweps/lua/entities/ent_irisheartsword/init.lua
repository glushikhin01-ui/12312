--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/weapons/irissword/w_irissword.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 50
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 180
	local ent = ents.Create("ent_irisheartsword")
		ent:SetPos(SpawnPos)
		ent:SetAngles(SpawnAng)
	ent:Spawn()
	ent:Activate()
	return ent
end
 
function ENT:Use( activator, caller )
    return
end

function ENT:Touch( entity )
	if entity:IsPlayer() or entity:IsNPC() or entity.Type == "nextbot" or entity:GetClass() == "prop_ragdoll" then
		if timer.TimeLeft( "barb_damage" ) == nil then
			entity:EmitSound( "weapons/samurai/tf_katana_slice_0" .. math.random(1, 3) .. ".wav")
			entity:EmitSound( "phx/epicmetal_hard" .. math.random(1, 7) .. ".wav")
			local dmgInfo = DamageInfo()
			dmgInfo:SetAttacker(self)
			dmgInfo:SetInflictor(self)
			dmgInfo:SetDamageType(DMG_SLASH)
			dmgInfo:SetDamage(2500)
			dmgInfo:SetDamagePosition(self:GetPos())
			entity:TakeDamageInfo(dmgInfo)
			timer.Create( "barb_damage", 0.25, 1, function() end )	
		end
	end
end

function ENT:PhysicsCollide(data, phys)
	if data.DeltaTime > 0.2 then
		self:EmitSound("phx/epicmetal_hard" .. math.random(1, 7) .. ".wav")
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
