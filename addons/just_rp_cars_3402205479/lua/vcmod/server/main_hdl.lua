--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

// Copyright © 2012-2018 VCMod (freemmaann). All Rights Reserved. if you have any complaints or ideas contact me: steam - steamcommunity.com/id/freemmaann/ or email - freemmaann@gmail.com.

concommand.Add("VC_Dev_Respawn_Vehicle", function(ply, cmd, arg)
	local ent = VC.GetVehicle(ply)
	if arg[1] and IsValid(ent) and !ent.VC_ExtraSeat and !ent.VC_IsAirboat then
	local SVh = ents.Create(ent:GetClass())
	SVh:SetModel(ent:GetModel())
	local KVal = ent:GetKeyValues()
	SVh:SetKeyValue("vehiclescript", "data/vcmod/handling/temp/"..arg[1]..".txt")
	SVh:SetAngles(ent:GetAngles())
	SVh:SetPos(ent:GetPos())
	SVh:SetMaterial(ent:GetMaterial())
	SVh:SetColor(ent:GetColor())
	SVh:SetSkin(ent:GetSkin())
	if VC.Initialize then VC.Initialize(SVh) end
	SVh.VC_Script = ent.VC_Script
	SVh:Spawn()
	if VC.ApplyBodyGroup then for Bg = 1, 20 do VC.ApplyBodyGroup(SVh, Bg, ent:GetBodygroup(Bg)) end end
	local SVPO, PVPO = SVh:GetPhysicsObject(), ent:GetPhysicsObject()
	if IsValid(PVPO) and IsValid(SVPO) then SVPO:SetVelocity(PVPO:GetVelocity()) SVPO:AddAngleVelocity(PVPO:GetAngleVelocity()) end
	undo.ReplaceEntity(ent, SVh)
	VCMsg("Vehicle applied successfully.", ply)
	local car = ply:GetVehicle() if !IsValid(car) then car = nil end
	local ACA = nil local TP = ent.GetThirdPersonMode and ent:GetThirdPersonMode()
		if car then
		ACA = ent:WorldToLocalAngles(ply:EyeAngles())
		if VC_OnVehicleExitStart then VC_OnVehicleExitStart(ply) end
		ply:ExitVehicle()
		end
	ent:Remove()
	SVh:SetThirdPersonMode(TP)
	if car then ply:EnterVehicle(SVh) ply:SetEyeAngles(ACA) end
	end
end)

util.AddNetworkString("VC_Dev_Script_Handling")

concommand.Add("VC_Dev_Handl_Get_Script", function(ply, cmd, arg)
local ent = VC.GetVehicle(ply)
	if IsValid(ent) then
	local KVal = ent:GetKeyValues() local VSrpt = KVal.VehicleScript
	if !file.Exists(VSrpt, "GAME") then VCMsg("Error: vehicles handling not found, respawn the car.") return end
	if VSrpt then net.Start("VC_Dev_Script_Handling") net.WriteString(VSrpt) if arg[1] then net.WriteInt(tonumber(arg[1]), 4) end net.Send(ply) end
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
