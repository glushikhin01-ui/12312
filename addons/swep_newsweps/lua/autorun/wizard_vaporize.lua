--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

--howdy! thanks for rooting around in my mod! 
--this file handles vaporizing ragdolls, and all the networking string bs that requires
-- -splet
AddCSLuaFile()

if ( SERVER ) then
	util.AddNetworkString("ent_gets_wizneutrondissolve")
	util.AddNetworkString("ent_gets_wizlightningdissolve")
end

local function WizRagFinder(ent, rag)
	if (!game.SinglePlayer() and CLIENT) then
		timer.Simple( engine.ServerFrameTime(), function()
			WizCheckIfDissolving(ent, rag)
		end)
	else
		WizCheckIfDissolving(ent, rag)
	end
end
hook.Add( "CreateEntityRagdoll", "Wiz_RagFinder", WizRagFinder )
hook.Add( "CreateClientsideRagdoll", "Wiz_RagFinder", WizRagFinder )

function WizCheckIfDissolving(ent, rag)
	if ent:IsPlayer() then rag = ent:GetRagdollEntity() end
	if (ent:GetNWBool("wiz_neutrondissolve")) then
		for i = 0, rag:GetPhysicsObjectCount() - 1 do
			local phys = rag:GetPhysicsObjectNum( i )
			phys:EnableGravity(false)
			phys:SetDragCoefficient(500)
			phys:SetAngleDragCoefficient(500)
		end
		rag:SetColor(Color(160, 40, 110, 255))
		rag:SetMaterial("model_color")

		rag:DrawShadow(false)
		rag:SetCollisionGroup(COLLISION_GROUP_DISSOLVING)
		rag:SetRenderMode(RENDERMODE_GLOW)
		local dissolvetime = 1.5
		effectdata = EffectData()
		effectdata:SetOrigin(rag:GetPos())
		effectdata:SetEntity(rag)
		effectdata:SetMagnitude(dissolvetime)
		util.Effect("fx_wizard_neutrondissolve", effectdata)
		timer.Simple(dissolvetime, function()
			if rag:IsValid() and !ent:IsPlayer() then rag:Remove() else
				rag:SetNoDraw(true)
				rag:RemoveAllDecals()
			end
		end)
	elseif (ent:GetNWBool("wiz_lightningdissolve")) then
		if not IsValid(rag) then return end
		for i = 0, rag:GetPhysicsObjectCount() - 1 do
			local phys = rag:GetPhysicsObjectNum( i )
			phys:EnableGravity(false)
			phys:SetDragCoefficient(5000)
			phys:SetAngleDragCoefficient(5000)
			phys:Sleep()
		end
		rag:SetColor(Color(255, 110, 40, 255))
		rag:SetMaterial("model_color")

		rag:DrawShadow(false)
		rag:SetCollisionGroup(COLLISION_GROUP_DISSOLVING)
		rag:SetRenderMode(RENDERMODE_GLOW)
		local dissolvetime = 1
		effectdata = EffectData()
		effectdata:SetOrigin(rag:GetPos())
		effectdata:SetEntity(rag)
		effectdata:SetMagnitude(dissolvetime)
		util.Effect("fx_wizard_lightningdissolve", effectdata)
		timer.Simple(dissolvetime, function()
			if rag:IsValid() then
				if !ent:IsPlayer() then rag:Remove() else
					rag:SetNoDraw(true)
					rag:RemoveAllDecals()
				end
			end
		end)
	end
end

local function WizDissolveCheck(ent, dmg)
	if ent:IsValid() and dmg:GetInflictor():IsValid() then
		if dmg:GetInflictor():GetClass() == "wiz_neutronshard" then
			ent:SetNWBool("wiz_neutrondissolve", true)
			
			net.Start( "ent_gets_wizneutrondissolve" )
				net.WriteEntity(ent)
			net.Broadcast()
			--network this to the clientside
			
			if !ent:IsPlayer() then
				ent:SetShouldServerRagdoll(true)
			end
			--don't step on our own toes
			if !timer.Exists("NeutronDissolve"..tostring(ent:EntIndex())) then 
				timer.Create("NeutronDissolve"..tostring(ent:EntIndex()), FrameTime() * 8, 1,function()
					if ent:IsValid() then 
						ent:SetNWBool("wiz_neutrondissolve", false)
					end
				end)
			else
				timer.Start("NeutronDissolve"..tostring(ent:EntIndex()))
			end
		elseif dmg:GetInflictor():GetClass() == "wiz_lightning_caller" then
			ent:SetNWBool("wiz_lightningdissolve", true)
			
			net.Start( "ent_gets_wizlightningdissolve" )
				net.WriteEntity(ent)
			net.Broadcast()
			--network this to the clientside
			
			if !ent:IsPlayer() then
				ent:SetShouldServerRagdoll(true)
			end
			--don't step on our own toes
			if !timer.Exists("LightningDissolve"..tostring(ent:EntIndex())) then 
				timer.Create("LightningDissolve"..tostring(ent:EntIndex()), FrameTime() * 8, 1,function()
					if ent:IsValid() then 
						ent:SetNWBool("wiz_lightningdissolve", false)
					end
				end)
			else
				timer.Start("LightningDissolve"..tostring(ent:EntIndex()))
			end
		end
	end
end
hook.Add( "EntityTakeDamage", "Wiz_DissolveCheck", WizDissolveCheck)

net.Receive( "ent_gets_wizneutrondissolve", function( len, ply )
	local ent = net.ReadEntity()
	if ent:IsValid() and !ent:IsWorld() then
		ent:SetNWBool("wiz_neutrondissolve", true)
	end
end )

net.Receive( "ent_gets_wizlightningdissolve", function( len, ply )
	local ent = net.ReadEntity()
	if ent:IsValid() and !ent:IsWorld() then
		ent:SetNWBool("wiz_lightningdissolve", true)
	end
end )

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
