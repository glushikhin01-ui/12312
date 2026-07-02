if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaHok = true

A_AM.ActMod.trgvsv = A_AM.ActMod.trgvsv or game.SinglePlayer() or (CLIENT and IsValid(LocalPlayer()) and LocalPlayer():IsListenServerHost()) or (SERVER and not game.IsDedicated() and IsValid(Entity(1)) and Entity(1):IsPlayer() and Entity(1):IsListenServerHost())
local trgvsv = true
local isserverD = game.IsDedicated()

local function aaStopGesture(ply)
	local tt1 = string.format("._|%s|0",CurTime())
	A_AM.ActMod.GestureSystem:StopAllGestures(ply,0)
	ply:SetNWString("A_ActMod.OneStart6",tt1)
	net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"ActMod.SToC_ST","SToC_",{"StpGtur",tt1}} ) net.Send(ply)
	ply:ConCommand("actmod_wtc StpGtur ".. tt1 .."\n")
end

if A_AM and A_AM.ActMod and A_AM.ActMod.SetChfg then
	hook.Add( "InitLoadAnimations", "ActMod_ReSt", function() if SERVER then timer.Simple(0.5, function() if ASvTag then A_AM.ActMod:ReTast_Seq_restuo() end end) end end )
	hook.Add( "ShutDown", "AN_ShutDown", function() A_AM.ActMod.svOn = false end)
	hook.Add("PlayerSpawn","A_AM_ActMod.P_Spawn",function(ply)
		A_AM.ActMod:A_ActMod_OffActing( ply ) aaStopGesture(ply)
		if CLIENT then
			if timer.Exists( "re_aenforce_model" ) then timer.Remove( "re_aenforce_model" ) end
			timer.Create( "re_aenforce_model",0.5,0,function()
				if IsValid(ply) then
					net.Start("A_AM.ActMod.ClToSv_Tab",true)
					 net.WriteTable( {"ClToSv_aenforce_model",LocalPlayer():GetModel() or ""} )
					net.SendToServer()
				end
			end)
		end
	end)
	hook.Add("PlayerDeath","A_AM_ActMod.P_Death",function(ply) A_AM.ActMod:A_ActMod_OffActing( ply ) aaStopGesture(ply) end)
	hook.Add("PlayerInitialSpawn","A_AM_Initial",function(ply) A_AM.ActMod:PlayerInitialSpawn_(ply) if A_AM.ActMod.bessys_2 then A_AM.ActMod.ActGrpP:StupTabPly( ply ) end end)
	hook.Add( "PlayerDisconnect", "AN_Disconnect", function(ply) A_AM.ActMod:PlayerDisconnect_(ply) if A_AM.ActMod.bessys_2 then A_AM.ActMod.ActGrpP:RemoveTabPly( ply ) end end)
	hook.Add( "PlayerDisconnected", "AN_Disconnected", function(ply) A_AM.ActMod:PlayerDisconnect_(ply) if A_AM.ActMod.bessys_2 then A_AM.ActMod.ActGrpP:RemoveTabPly( ply ) end end)
end

local function RmoveHook(k,v)
	hook.Remove(k,v)
end

local function aFixRAng(ply)
	if IsValid(ply) and ply:IsPlayer() then
		local atmr = not ply.ActMod_OneStart and 0 or math.Clamp( (CurTime() - (ply.ActMod_CurTStart or 0))/0.2 ,0,1)
		if math.floor(atmr) < 1 then
			local curAng = ply:GetRenderAngles()
			local targetAng = ply:EyeAngles()
			local smoothAng = LerpAngle(atmr, curAng, targetAng)
			local curYaw = ply:GetRenderAngles().y
			local targetYaw = ply:EyeAngles().y
			local newYaw = LerpAngle(atmr, Angle(0, curYaw, 0), Angle(0, targetYaw, 0))
			ply:SetRenderAngles(newYaw)
		else
			ply:SetRenderAngles( ply:EyeAngles() )
		end
		local Rh_p_min,Rh_p_max = ply:GetPoseParameterRange("head_pitch")
		local Rh_y_min,Rh_y_max = ply:GetPoseParameterRange("head_yaw")
		if isnumber(Rh_p_min) and isnumber(Rh_p_max) and isnumber(Rh_y_min) and isnumber(Rh_y_max) then
			local a_p,a_y,TtXt = 0,0,""
			local atXt = ply:GetNWString("a_SEyeCuAngles","")
			if atXt ~= "" then
				TtXt = string.Explode("|", atXt, true)
			end
			if SERVER or CLIENT and ply ~= LocalPlayer() then
				if TtXt and istable(TtXt) and TtXt[2] then
					if not ply.ActMod_SECuAng then ply.ActMod_SECuAng = {TOK = 0 ,S_pitch = 0 ,S_yaw = 0 ,pitch = 0 ,yaw = 0} end
					local SAng = ply.ActMod_SECuAng
					SAng.pitch = Lerp( FrameTime() * 10, SAng.pitch, TtXt[1] )
					SAng.yaw = Lerp( FrameTime() * 10, SAng.yaw, TtXt[2] )
					a_p = SAng.pitch
					a_y = -SAng.yaw
				end
			elseif CLIENT then
				if not ply.ActMod_SECuAng_cl then ply.ActMod_SECuAng_cl = {S_pitch = 0 ,S_yaw = 0 ,pitch = 0 ,yaw = 0} end
				local SAng = ply.ActMod_SECuAng_cl
				SAng.pitch = Lerp( FrameTime() * 20, SAng.pitch, SAng.S_pitch )
				SAng.yaw = Lerp( FrameTime() * 20, SAng.yaw, SAng.S_yaw )
				a_p = SAng.pitch
				a_y = -SAng.yaw
			end
			if isnumber(atmr) and math.floor(atmr) < 1 then
				ply:SetPoseParameter( "head_pitch" ,Lerp( atmr ,math.Remap( ply:GetPoseParameter("head_pitch") ,0,1 ,Rh_p_min,Rh_p_max ) ,a_p ) )
				ply:SetPoseParameter( "head_yaw" ,Lerp( atmr ,math.Remap( ply:GetPoseParameter("head_yaw") ,0,1 ,Rh_y_min,Rh_y_max ) ,a_y ) )
			else
				ply:SetPoseParameter( "head_pitch" , a_p )
				ply:SetPoseParameter( "head_yaw" , a_y )
			end
		end
	end
end

function A_AM.ActMod:A_ActMod_SetPKey( ply,akey,DKey,tra )
	if ply and IsValid(ply) and ply:IsPlayer() and akey then
		if not ply.actmod_TabPKey then ply.actmod_TabPKey = {} end
		if A_AM.ActMod:AGDataKeys( ply,akey,DKey ) then
			ply.actmod_TabPKey[DKey] = tra
		end
	end
end
function A_AM.ActMod:A_ActMod_GetPKey( ply ,akey )
	if ply.actmod_TabPKey and ply.actmod_TabPKey[akey] and ply.actmod_TabPKey[akey] == true then
		return true
	end
	return false
end
function A_AM.ActMod:A_ActMod_ResPKey( ply )
	if ply.actmod_TabPKey and istable(ply.actmod_TabPKey) then
		for k,v in pairs( ply.actmod_TabPKey ) do
			ply.actmod_TabPKey[k] = false
		end
	end
end

function A_AM.ActMod:RemoveAllhook(Jst,typa,nR)
	local function fUt(k,v)
		if istable( v ) then
			for n, f in pairs( v ) do
				if isstring(n) then
					if (typa and isstring(typa)) or string.find(n, "ActMod") then
						if n == typa or not typa then if nR then print(k,n) else RmoveHook(k,n) end end
					end
				end
			end
		else
			if (typa and isstring(typa) and v == typa) then
				if nR then print(k,v) else RmoveHook(k,v) end
			end
		end
	end
	for k, v in pairs(hook.GetTable()) do
		if Jst and isstring(Jst) then
			if k == Jst then fUt(k,v) end
		else
			if SERVER then
				if k == "OnNPCKilled" then fUt(k,v) end
			end
			if CLIENT then
				if k == "HUDWeaponPickedUp" then fUt(k,v) end
			end
			if k == "PlayerSpawn" then fUt(k,v) end
			if k == "PlayerDeath" then fUt(k,v) end
			if k == "Think" then fUt(k,v) end
			if k == "DoAnimationEvent" then fUt(k,v) end
			if k == "UpdateAnimation" then fUt(k,v) end
			if k == "CalcMainActivity" then fUt(k,v) end
			if k == "Move" then fUt(k,v) end
		end
	end
end

function A_AM.ActMod:SetupStartAct()
	if CLIENT then
		local aR = "!!!!!!!!!0".. tostring( A_AM.ActMod.Sutep_DoneR )
		hook.Add( "CalcView", aR .."ActMod_CalcView", function( ply, origin, angles, fov )
			if not ply:A_ActMod_GetIsAct() then return end
			if not A_AM.ActMod.TauntCamera then return end
			if A_AM.ActMod:IsVR(ply) then return end
			if ( ply:Alive() and IsValid( ply:GetViewEntity() ) and ply:GetViewEntity() == ply ) then
				return A_AM.ActMod.TauntCamera:CalcView( { origin = origin, angles = angles, fov = fov }, true )
			end
		end )
		hook.Add( "CreateMove", aR .."ActMod_CreateMove", function( cmd )
			local ply = LocalPlayer()
			if not IsValid(ply) then return end
			if not ply:A_ActMod_GetIsAct() then return end
			if not A_AM.ActMod.TauntCamera then return end
			return A_AM.ActMod.TauntCamera:CreateMove( cmd, LocalPlayer(), true )
		end )
	end
end

function A_AM.ActMod:SetupStopAct()
	if CLIENT then
		local aR = "!!!!!!!!!0".. tostring( A_AM.ActMod.Sutep_DoneR )
		RmoveHook("CalcView",aR .."ActMod_CalcView")
		RmoveHook("CreateMove",aR .."ActMod_CreateMove")
	end
end


function A_AM.ActMod:Setuphook()
	local yR = "!!!!!!!!!0".. tostring(A_AM.ActMod.Sutep_DoneR)
	local aallow = false
	if A_AM.ActMod.GSetuphook then
		if SERVER then
			RmoveHook("Think",yR .."ActMod_ThinkSv")
			RmoveHook("OnNPCKilled",yR .."ActMod_Avs_KillNPC")
			RmoveHook("ActMod_CStart",yR .."ActMod_StartAct")
			RmoveHook("ShouldCollide",yR .."ActMod_CustomCollisions")
			RmoveHook("PlayerButtonDown",yR .."ActMod_PlayerButtonDown")
			RmoveHook("PlayerButtonUp",yR .."ActMod_PlayerButtonUp")
			RmoveHook("PlayerTick",yR .."ActMod_PlayerTick")
			RmoveHook("StartCommand",yR .."ActMod_StartCommand")
			RmoveHook("PlayerCanPickupWeapon",yR .."ActMod")
		elseif CLIENT then
			RmoveHook("DrawOverlay",yR .."ActMod_DrawOverlay")
			RmoveHook("Think",yR .."ActMod_ThinkCl")
			RmoveHook("HUDWeaponPickedUp",yR .."ActMod_NSw")
			RmoveHook("PostPlayerDraw",yR .."ActMod_PostPlayerDraw")
			RmoveHook("PrePlayerDraw",yR .."ActMod_PrePlayerDraw")
			RmoveHook("PreRender",yR .."ActMod_PreRender")
			RmoveHook("PostDrawOpaqueRenderables",yR .."ActMod_PostDrawOpaqueRenderables")
			RmoveHook("CreateMove",yR .."ActMod_CreateMove")
			RmoveHook("CalcView",yR .."ActMod_CalcView")
			RmoveHook("PlayerBindPress",yR .."ActMod_PlayerBindPress")
			RmoveHook("InputMouseApply",yR .."ActMod_InputMouseApply")
			RmoveHook("VRMod_Start",yR .."ActMod_VRMod_Start")
			RmoveHook("VRMod_Input",yR .."ActMod_VRMod_Input")
			RmoveHook("HUDDrawTargetID",yR .."ActMod_HUDDrawTargetID")
			RmoveHook("PostRender", yR .."ActMod_PRender")
			if game.SinglePlayer() then
				RmoveHook("ActMod_cl_StartAniAct_B", yR .."ActMod_SB")
				RmoveHook("ActMod_RunStopAct", yR .."ActMod_RSA")
				RmoveHook("PreRender", yR .."ActMod_PRder")
				RmoveHook("ShutDown", yR .."ActMod_ShDn")
			end
		end
		RmoveHook("PlayerSpawn",yR .."ActMod_Spawn")
		RmoveHook("PlayerDeath",yR .."ActMod_Death")
		RmoveHook("DoAnimationEvent" , yR .."ActMod_DAE")
		RmoveHook("UpdateAnimation", yR .."ActMod_SlowDownAnim")
		RmoveHook("CalcMainActivity", yR .."ActMod_Animations")
		RmoveHook("SetupMove", yR .."ActMod_SetupMove")
		RmoveHook("Move", yR .."ActMod_MoveDir")
		aallow = true
	else
		RmoveHook("PlayerSpawn","A_AM_ActMod.P_Spawn")
		RmoveHook("PlayerDeath","A_AM_ActMod.P_Death")
	end
	
	A_AM.ActMod.GSetuphook = true
	A_AM.ActMod.Sutep_Done1 = true
	
	if aallow == true then
		A_AM.ActMod.Sutep_DoneR = A_AM.ActMod.Sutep_DoneR + 1
		yR = "!!!!!!!!!0".. tostring(A_AM.ActMod.Sutep_DoneR)
	end

	if SERVER then
		local atimTReCfg,aReSndDBL = CurTime() + 30 ,CurTime() + 10
		hook.Add("Think", yR .."ActMod_ThinkSv", function()
			A_AM.ActMod:Think()
			A_AM.ActMod.ActMod_Sv_Avs()
			if atimTReCfg < CurTime() then atimTReCfg = CurTime() + 700 A_AM.ActMod:RetChfg() end
			if aReSndDBL < CurTime() then aReSndDBL = CurTime() + 20
				net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {">GSBListD",A_AM.ActMod.Blacklist} ) net.Broadcast()
			end
			if (GetConVarNumber("actmod_sv_syflex") == 1 or GetConVarNumber("actmod_sv_syflex") == 3) and A_AM.ActMod.StSysFlexs then A_AM.ActMod.Flex_Think() end
		end)
		hook.Add("OnNPCKilled", yR .."ActMod_Avs_KillNPC", function(a1, a2, a3) A_AM.ActMod.ActMod_Avs_KNPC(a1, a2, a3) end)
		hook.Add("ActMod_CStart", yR .."ActMod_StartAct", function(Tbl,tAb,Oall,GHold)
			if Tbl and istable(Tbl) then
				if Tbl[1] == "Player" and Tbl[2] and IsValid(Tbl[2]) and Tbl[2]:IsPlayer() then
					A_AM.ActMod:AAStart(Tbl[2],tAb[1],tAb,Oall,GHold)
				elseif Tbl[1] == "SetPlayers" and Tbl[2] then
					for _, pl in player.Iterator() do if IsValid(pl) and A_AM.ActMod:ATabData( Tbl[2], pl ) == true then A_AM.ActMod:AAStart(pl,tAb[1],tAb,Oall,GHold) end end
				elseif Tbl[1] == "AllPlayers" then
					for _, pl in player.Iterator() do if IsValid(pl) then A_AM.ActMod:AAStart(pl,tAb[1],tAb,Oall,GHold) end end
				end
			end
		end)
		
		hook.Add( "PlayerCanPickupWeapon", yR .."ActMod", function(ply, weap)
			if ply and IsValid(ply) and weap:GetClass() == "aact_weapact" then weap.GiveTo = ply return true end
		end)

		hook.Add( "ShouldCollide", yR .."ActMod_CustomCollisions", function( ent1, ent2 )
			if ( ent1:IsPlayer() and ent2:IsPlayer() ) then
				local TbS = A_AM.ActMod.a_TabPlysNoClp
				local ePl1 = ent1:SteamID64() .."_#._"..ent1:Nick()
				local ePl2 = ent2:SteamID64() .."_#._"..ent2:Nick()
				if TbS and ( TbS[ePl2] and TbS[ePl1] ) then
					return false
				end
			end
			return
		end )
		hook.Add( "PlayerButtonDown", yR .."ActMod_PlayerButtonDown", function( ply, button )
			if (ply.A_ActMod_GetHldOffTPK or 0) < CurTime() and ply:A_ActMod_GetIsAct() and (ply:A_ActMod_GetMoveDir() ~= 0 or ply:A_ActMod_GetMoveDir() != 7) then
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+moveright",true )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+moveleft",true )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+forward",true )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+back",true )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+speed",true )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+walk",true )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+jump",true )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+attack",true )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+attack2",true )
				if A_AM.ActMod:AGDataKeys( ply,button,"+jump" ) and ( not ply.ActmodTSavOneStart1 or ply.ActmodTSavOneStart1 ~= ply:GetNWString("A_ActMod.OneStart1","")) then
					if hook.Call("ActMod_DontStopAct",nil,ply,"SV_KeyStopAct") ~= true then
						ply.ActmodTSavOneStart1 = ply:GetNWString("A_ActMod.OneStart1","")
						A_AM.ActMod:A_ActMod_OffActing( ply )
					end
				end
			end
		end)
		hook.Add( "PlayerButtonUp", yR .."ActMod_PlayerButtonUp", function( ply, button )
			if (ply.A_ActMod_GetHldOffTPK or 0) < CurTime() and ply:A_ActMod_GetIsAct() and (ply:A_ActMod_GetMoveDir() ~= 0 or ply:A_ActMod_GetMoveDir() != 7) then
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+moveright",false )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+moveleft",false )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+forward",false )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+back",false )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+speed",false )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+walk",false )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+jump",false )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+attack",false )
				A_AM.ActMod:A_ActMod_SetPKey( ply ,button,"+attack2",false )
			end
		end)

		local truSVCAng = false
		hook.Add("PlayerTick", yR .."ActMod_PlayerTick", function(ply)
			if truSVCAng and (ply.actmod_TimPTick or 0) < CurTime() then
				ply.actmod_TimPTick = CurTime() + 0.2
				if not ply.ActMod_SECuAng then ply.ActMod_SECuAng = {TOK = 0 ,S_pitch = 0 ,S_yaw = 0 ,pitch = 0 ,yaw = 0} end
				if ply.ActMod_SECuAng and ply.ActMod_SECuAng.TOK then
					local SAng = ply.ActMod_SECuAng
					if SAng.TOK <= 0 then
						SAng.S_pitch = 0
						SAng.S_yaw = 0
					end
					ply:SetNWString("a_SEyeCuAngles",string.format("%s|%s|%s",SAng.S_pitch,SAng.S_yaw,ply:GetAngles().y))
				end
			end
		end)
		hook.Add( "StartCommand", yR .."ActMod_StartCommand", function( ply, cmd )
			if ply:Alive() and ply:A_ActMod_GetIsAct() then
				if GetConVarNumber("actmod_sv_typmovecl") <= 0 or ply:IsBot() then
					if truSVCAng then
						if not ply.actmod_SveMus then ply.actmod_SveMus = 0 end
						local GetMouseXY = cmd:GetMouseX()+cmd:GetMouseY()
						if ply.actmod_SveMus ~= GetMouseXY then
							ply.actmod_SveMus = GetMouseXY
							if not ply.ActMod_SECuAng then ply.ActMod_SECuAng = {TOK = 0 ,S_pitch = 0 ,S_yaw = 0 ,pitch = 0 ,yaw = 0} end
							if ply.ActMod_SECuAng and ply.ActMod_SECuAng.TOK then
								local SAng = ply.ActMod_SECuAng
								if SAng.TOK > 0 then
									SAng.S_pitch = math.Clamp((SAng.S_pitch + cmd:GetMouseY() * 0.08),-60,60)
									SAng.S_yaw = math.Clamp((SAng.S_yaw + cmd:GetMouseX() * 0.07),-75,75)
								else
									SAng.S_pitch = 0
									SAng.S_yaw = 0
								end
								ply:SetNWString("a_SEyeCuAngles",string.format("%s|%s|%s",SAng.S_pitch,SAng.S_yaw,ply:GetAngles().y))
							end
						end
					end
				end
				if ply.ActMod_OPT_VR and ply.ActMod_OPT_VR["CanMove"] then
				else
					local atXt = ply:GetNWString("ActMod_aAng","")
					if atXt ~= "" then
						local TtXt = string.Explode("|", atXt, true)
						if TtXt and istable(TtXt) and TtXt[1] and TtXt[1] == "1" and TtXt[3] then
							ply.actmod_PlayerLockAngles = Angle(TtXt[2],TtXt[3],0)
						end
					end
					if ply.actmod_PlayerLockAngles then
						if A_AM.ActMod:A_ActMod_GPCoop( ply ) then
							ply:SetEyeAngles( ply.actmod_PlayerLockAngles )
							cmd:SetViewAngles( ply.actmod_PlayerLockAngles )
						elseif GetConVarNumber("actmod_sv_typmovecl") <= 0 or ply:IsBot() then
							ply:SetEyeAngles( ply.actmod_PlayerLockAngles + Angle(0, ply:GetNWInt("a_SRLAngMove",0), 0) )
							cmd:SetViewAngles( ply.actmod_PlayerLockAngles + Angle(0, ply:GetNWInt("a_SRLAngMove",0), 0) )
						end
					end
					local MDir = ply:A_ActMod_GetMoveDir()
					cmd:ClearButtons()
					if MDir ~= 1 and MDir ~= 2 and MDir ~= 5 and MDir ~= 8 and MDir ~= 9 then cmd:ClearMovement() end
				end
			end
		end )
	end
	
	if CLIENT then
		A_AM.ActMod.Actoji = A_AM.ActMod.Actoji or {}
		local Actoji = A_AM.ActMod.Actoji
		
		if game.SinglePlayer() and ConVarExists("actmod_sp_pause") and GetConVarNumber("actmod_sp_pause") > 0 and ConVarExists("sv_pause_sp") then
			local wasVisible = false
			local dancing = false
			local dala = false
			local oldValue = nil
			cvars.RemoveChangeCallback("sv_pause_sp", "actmod_sv_pause_sp")
			cvars.AddChangeCallback("sv_pause_sp", function(name, oldVal, newVal)
				if not dala then oldValue = newVal end
			end,"actmod_sv_pause_sp")
			hook.Add("ActMod_cl_StartAniAct_B", yR .."ActMod_SB", function()
				dancing = true
				oldValue = GetConVar("sv_pause_sp"):GetInt()
			end)
			hook.Add("ActMod_RunStopAct", yR .."ActMod_RSA", function()
				dancing = false
				if oldValue ~= nil then
					dala = true
					RunConsoleCommand("sv_pause_sp", tostring(oldValue))
					oldValue = nil
					timer.Simple(0.01,function() dala = false end)
				end
			end)
			hook.Add("PreRender", yR .."ActMod_PRder", function()
				if not dancing or not LocalPlayer():A_ActMod_GetIsAct() then return end
				local visible = ta or gui.IsGameUIVisible()
				if visible and not wasVisible then
					dala = true
					RunConsoleCommand("sv_pause_sp", "0")
					timer.Simple(0.01,function() dala = false end)
				end
				wasVisible = visible
			end)
			hook.Add("ShutDown", yR .."ActMod_ShDn", function() 
				if oldValue ~= nil then RunConsoleCommand("sv_pause_sp", tostring(oldValue)) end
			end)
		end

		hook.Add( "HUDWeaponPickedUp", yR .."ActMod_NSw", function( we ) if we:GetClass() == "aact_weapact" then return false end end )
		
		local atimTReCfg = CurTime() + 30
		hook.Add("Think", yR .."ActMod_ThinkCl", function()
			local ply = LocalPlayer()
			A_AM.ActMod:Think(ply)
			A_AM.ActMod.ActMod_Cl_Avs(ply)
			if atimTReCfg < CurTime() then atimTReCfg = CurTime() + 700 A_AM.ActMod:RetChfg() end
		end)
		
		hook.Add( "InputMouseApply", yR .."ActMod_InputMouseApply", function( cmd )
			if LocalPlayer():A_ActMod_GetIsAct() then
				cmd:SetMouseX( 0 )
				cmd:SetMouseY( 0 )
				return true
			end
		end )
		
		hook.Add("HUDDrawTargetID",yR .."ActMod_HUDDrawTargetID", function()
			local ply = LocalPlayer()
			if ply:A_ActMod_GetIsAct() then
				return false
			end
		end)
		
		hook.Add("VRMod_Start",yR .."ActMod_VRMod_Start",function(ply)
			if ply == LocalPlayer() then
				ply.actmod_vr_t1mPMenu = CurTime()
				ply.actmod_vr_t2mPMenu = CurTime()
				hook.Add("VRMod_Input",yR .."ActMod_VRMod_Input",function( action, pressed )
					local ply = LocalPlayer()
					if GetConVarNumber("actmod_cl_vrslist") ~= 0 and action == "boolean_secondaryfire" and pressed then
						if ply.actmod_vr_t2mPMenu < CurTime() then
							if ply.actmod_vr_t1mPMenu > CurTime() then
								ply.actmod_vr_t2mPMenu = CurTime() + 0.5
								if ply.CKeyAct_UseMenu then ply.CKeyAct_UseMenu = nil else ply.CKeyAct_UseMenu = true end
							else
								ply.actmod_vr_t1mPMenu = CurTime() + 0.3
							end
						end
					elseif not ply:A_ActMod_GetIsAct() and GetConVarNumber("actmod_cl_vrjoin") ~= 0 and action == "boolean_reload" and pressed then
						local Pl2 = ply.ActMod_TSndJ_LookTPly
						if Pl2 and IsValid(Pl2) and Pl2:Alive() and Pl2:GetObserverMode() == 0 then
							local Pl2_ok = A_AM.ActMod:aGetLookTPly( ply )
							if Pl2_ok and IsValid(Pl2_ok) and Pl2 == Pl2_ok then
								ply.ActMod_cam_tisp = CurTime() + 2.6
								ply.ActMod_TSndJ = CurTime() + 2
								ply.ActMod_GPl2TSndJ = Pl2
								ply.ActMod_GNamTSndJ = Pl2:Nick()
								ply.ActMod_GkTPlyTJn = nil
								if timer.Exists( "actmod_AutoRemoveNamePly2" ) then timer.Remove( "actmod_AutoRemoveNamePly2" ) end
								timer.Create("actmod_AutoRemoveNamePly2",math.max(ply.ActMod_TSndJ - CurTime()-0.5,0),1,function() if IsValid(ply) then
									ply.ActMod_cam_tisp = CurTime() + 0.1
									ply.ActMod_GkTPlyTJn = nil
									ply.ActMod_GPl2TSndJ = nil
									ply.ActMod_GNamTSndJ = ""
								end end)
								A_AM.ActMod:cl_AdJoing( ply,Pl2,{ply:GetPos(),ply:GetAngles()} )
							end
						end
					elseif ply:A_ActMod_GetIsAct() then
						if action == "boolean_reload" and pressed then
							ply:ConCommand("actmod_wts wts_End\n")
						end
					end
				end)
			end
		end)
		
		local function CrMdl( model,params,pl )
			if not model or not IsValid(model) then return end
			if pl ~= LocalPlayer() and not LocalPlayer():trueShowMld(pl) then return end
			
			local size, pos, ang = 1, Vector(), Angle()
			if params and istable(params) and not table.IsEmpty(params) then
				if params["TypAtta"] == 1 then
					local attach_id = pl:LookupAttachment(params["attm"])
					if not attach_id then return end
					local attach = pl:GetAttachment(attach_id)
					if not attach then return end
					pos, ang = attach.Pos, attach.Ang
					pos = pos + (ang:Forward()*params["pos_fo"] +ang:Right()*params["pos_ri"] +ang:Up()*params["pos_up"])
					ang = ang + params["ang"]
					model:SetPos(pos)
					model:SetAngles(ang)
					model:SetRenderOrigin(pos)
					model:SetRenderAngles(ang)
					params["pos_ang"] = {pos,ang}
				elseif params["TypAtta"] == 2 then
					local bone1 = pl:LookupBone(params["attm"])
					if not bone1 then return end
					local pos, ang = pl:GetBonePosition(bone1)
					pos, ang = LocalToWorld(
						params["pos"] or Vector(),
						params["ang"] or Angle(),
						pos or pl:GetPos(),
						ang or pl:GetAngles()
					)
					local apos = pos + (ang:Forward() *params["pos_fo"]  +ang:Right() *params["pos_ri"] + ang:Up() *params["pos_up"])
					model:SetPos( apos )
					model:SetAngles(ang)
					params["pos_ang"] = {apos,ang}
				elseif params["TypAtta"] == 3 then
					local Asz = pl:GetModelScale()
					if A_AM.ActMod:IsVR(pl) and vrmod and params["attm"] == "ValveBiped.Bip01_L_Hand" then
						local position, angles = vrmod.GetLeftHandPose(pl)
						angles:RotateAroundAxis(angles:Forward(), params["ang_p"])
						angles:RotateAroundAxis(angles:Right(), params["ang_y"])
						angles:RotateAroundAxis(angles:Up(), params["ang_r"])
						local apos = position + (angles:Forward()*params["pos_fo"]*Asz +angles:Right()*params["pos_ri"]*Asz + angles:Up()*params["pos_up"]*Asz)
						model:SetPos( apos )
						model:SetAngles(angles)
						params["pos_ang"] = {apos,angles}
					else
						local bone1 = pl:LookupBone(params["attm"])
						if not bone1 then return end
						local position, angles = pl:GetBonePosition(bone1)
						angles:RotateAroundAxis(angles:Forward(), params["ang_p"])
						angles:RotateAroundAxis(angles:Right(), params["ang_y"])
						angles:RotateAroundAxis(angles:Up(), params["ang_r"])
						local apos = position + (angles:Forward()*params["pos_fo"]*Asz +angles:Right()*params["pos_ri"]*Asz + angles:Up()*params["pos_up"]*Asz)
						model:SetPos( apos )
						model:SetAngles(angles)
						params["pos_ang"] = {apos,angles}
					end
				elseif params["TypAtta"] == 5 then
					local bone1 = pl:LookupBone(params["attm"])
					if not bone1 then return end
					local mtxl = pl:GetBoneMatrix(bone1)
					local position,angles = Vector(),Angle()
					if mtxl then
						position = mtxl:GetTranslation()
						angles = mtxl:GetAngles()
					end
					angles:RotateAroundAxis(angles:Forward(), params["ang_p"])
					angles:RotateAroundAxis(angles:Right(), params["ang_y"])
					angles:RotateAroundAxis(angles:Up(), params["ang_r"])
					local apos = position + (angles:Forward() *params["pos_fo"]  +angles:Right() *params["pos_ri"] + angles:Up() *params["pos_up"])
					model:SetPos( apos )
					model:SetAngles(angles)
					params["pos_ang"] = {apos,angles}
				elseif params["TypAtta"] == 0 then
					local position, angles = pl:GetBonePosition(0)
					angles:RotateAroundAxis(angles:Forward(), params["ang_p"])
					angles:RotateAroundAxis(angles:Right(), params["ang_y"])
					angles:RotateAroundAxis(angles:Up(), params["ang_r"])
					local apos = position + (angles:Forward() *params["pos_fo"]  +angles:Right() *params["pos_ri"] + angles:Up() *params["pos_up"])
					model:SetPos( apos )
					model:SetAngles(angles)
					params["pos_ang"] = {apos,angles}
				elseif params["TypAtta"] == -1 then
					local angles = pl:GetRenderAngles()
					angles:RotateAroundAxis(angles:Forward(), params["ang_p"])
					angles:RotateAroundAxis(angles:Right(), params["ang_y"])
					angles:RotateAroundAxis(angles:Up(), params["ang_r"])
					local apos = pl:GetPos() + params["pos"] + (angles:Forward() *params["pos_fo"]  +angles:Right() *params["pos_ri"] + angles:Up() *params["pos_up"])
					model:SetPos( apos )
					if pl:IsPlayer() and pl:InVehicle() then
						if not model.etParent then
							model.etParent = true
							model:SetAngles(pl:GetVehicle():GetAngles() + Angle(0,90,0) + params["ang"])
							model:SetParent(pl)
						end
						local aang = Angle(model:GetParent():GetManipulateBoneAngles( 0 ).p ,model:GetParent():GetManipulateBoneAngles( 0 ).y ,0)
						model:ManipulateBoneAngles( 0 , aang )
						params["pos_ang"] = {apos,aang}
					else
						local aang = pl:GetRenderAngles() + params["ang"]
						model:SetAngles( aang )
						params["pos_ang"] = {apos,aang}
					end
				end
				size = params["size"]
			end
			model:SetModelScale(size*pl:GetModelScale())
			model:SetupBones()
			if params["SColor"] then render.SetColorModulation(params["SColor"][1],params["SColor"][2],params["SColor"][3]) end
			if params["Blend"] then render.SetBlend(params["Blend"]) end
			if not model.tHide then model:DrawModel() end
			if params["SColor"] then render.SetColorModulation(1,1,1) end
			if params["Blend"] then render.SetBlend( 1 ) end
			model:SetRenderOrigin()
			model:SetRenderAngles()
			if params and istable(params) and not table.IsEmpty(params) and params["Mat"] then model:SetMaterial(params["Mat"]) end
		end

		local function aDrwnMDLs(pl,iredr)
			if pl:Alive() and pl:A_ActMod_GetIsAct() and ( iredr or not iredr and (pl.AAct_rTimTmdls or 0) < CurTime() ) then
				local aCt0,cyc = pl:GetNWString("A_ActMod.TmpDir", "" ),pl:GetCycle()
				local model1,model2,model3,model4,r_SetColorM
				if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
				if pl.AAct_mdl2 then model2 = pl.AAct_mdl2 end
				if pl.AAct_mdl3 then model3 = pl.AAct_mdl3 end
				if pl.AAct_mdl4 then model4 = pl.AAct_mdl4 end
				if IsValid(model1) or IsValid(model2) or IsValid(model3) or IsValid(model4) then
					if iredr then
						if r_SetColorM then render.SetColorModulation(r_SetColorM[1],r_SetColorM[2],r_SetColorM[3]) end
						if model1 and IsValid(model1) then
							CrMdl( model1,pl.AAct_Tmdl1,pl )
							render.RenderFlashlights( function() CrMdl( model1,pl.AAct_Tmdl1,pl ) end )
						end
						if model2 and IsValid(model2) then
							CrMdl( model2,pl.AAct_Tmdl2,pl )
							render.RenderFlashlights( function() CrMdl( model2,pl.AAct_Tmdl2,pl ) end )
						end
						if model3 and IsValid(model3) then
							CrMdl( model3,pl.AAct_Tmdl3,pl )
							render.RenderFlashlights( function() CrMdl( model3,pl.AAct_Tmdl3,pl ) end )
						end
						if model4 and IsValid(model4) then
							CrMdl( model4,pl.AAct_Tmdl4,pl )
							render.RenderFlashlights( function() CrMdl( model4,pl.AAct_Tmdl4,pl ) end )
						end
						if r_SetColorM then render.SetColorModulation(1,1,1) end
					else
						pl.AAct_rTimTmdls = CurTime() + 0.5
						if model1 and IsValid(model1) then CrMdl( model1,pl.AAct_Tmdl1,pl ) end
						if model2 and IsValid(model2) then CrMdl( model2,pl.AAct_Tmdl2,pl ) end
						if model3 and IsValid(model3) then CrMdl( model3,pl.AAct_Tmdl3,pl ) end
						if model4 and IsValid(model4) then CrMdl( model4,pl.AAct_Tmdl4,pl ) end
					end
				end
				if iredr then
					local BastTab = A_AM.ActMod.AdScrptPDraw
					if istable(BastTab) and BastTab[aCt0] then BastTab[aCt0](pl,cyc ,model1,model2,model3,model4) end
				end
			end
		end
		
		hook.Add("PostPlayerDraw", yR .."ActMod_PostPlayerDraw", function(pl)
			aDrwnMDLs(pl,true)
			A_AM.ActMod:HUD_3D_TaSynPly()
			if (GetConVarNumber("actmod_sv_syflex") == 2 or GetConVarNumber("actmod_sv_syflex") == 3) and A_AM.ActMod.StSysFlexs then A_AM.ActMod.Flex_ThinkPly(pl) end
		end)
		
		local aamatar2 = Material("actmod/eff_particle/am_arrow01.png","noclamp smooth")
		local aamatar3 = Material("actmod/eff_particle/am_arrow02.png","noclamp smooth")
		hook.Add("PostDrawOpaqueRenderables", yR .."ActMod_PostDrawOpaqueRenderables", function(_,a1,a2)
			for _ ,pl in player.Iterator() do
				if not pl:Alive() or not pl:A_ActMod_GetIsAct() then continue end
				local aCt0,cyc = pl:GetNWString("A_ActMod.TmpDir", "" ),pl:GetCycle()
				if GetConVarNumber("actmod_cl_showarrow") ~= 0 and pl == LocalPlayer() then
					local amovF = false
					if not pl.actmod_TmrGMov then pl.actmod_TmrGMov = CurTime() end
					if isnumber(pl.actmod_GMovea) and pl.actmod_GMovea ~= 0 then
						pl.actmod_TmrGMov = CurTime() + 0.6
						if pl.actmod_GMovea == 1 then amovF = true end
					end
					local apos,aang,Asz,talp = pl:GetPos() ,pl:GetRenderAngles() ,1 ,math.Clamp( math.max((pl.actmod_TmrGMov - CurTime())/0.5,0) + math.max(-1+1.5*math.sin(CurTime()*5),0) ,0.1,1 )
					local traceH = util.TraceHull({
						start = apos + pl:GetUp()*10*Asz, endpos = apos
						,filter = function(ent) if ent:IsWorld() or (ent:GetClass() == "prop_physics" or ent:GetClass() == "prop_dynamic" or ent:GetClass() == "prop_ragdoll") and ent:GetOwner() != pl then return true end end
						,mins = Vector(-5, -5, -0.5)*Asz, maxs = Vector(5, 5, 0.5)*Asz
					})
					apos = traceH.HitPos + pl:GetUp()
					cam.Start3D2D(apos, Angle(0,aang.y,0), 0.2)
						surface.SetDrawColor(255, 255, 255, 255*talp)
						surface.SetMaterial(aamatar2)
						surface.DrawTexturedRectRotated(0, 0, 180*Asz, 180*Asz, -90)
						if amovF then
							local aatir = (CurTime()*5)%3
							surface.SetDrawColor(255, 255, 255, 255*math.Clamp( 1-aatir ,0,1 ))
							surface.SetMaterial(aamatar3)
							surface.DrawTexturedRectRotated(aatir*40, 0, 220*Asz, 220*Asz, -90)
						end
					cam.End3D2D()
				end
				local BastTab = A_AM.ActMod.AdScrptPDrawO
				if istable(BastTab) and BastTab[aCt0] then BastTab[aCt0](pl,cyc ,pl.AAct_mdl1,pl.AAct_mdl2,pl.AAct_mdl3,pl.AAct_mdl4) end
			end
		end)
		
		function A_AM.ActMod:aDrwnMDLs( pl ) aDrwnMDLs(pl) end

		local function A_StrtActC(pl,str)
			pl.ActMod_TimMenRe = CurTime() + 0.3
			if GetConVar("actmod_sv_enabled"):GetBool() then
				if hook.Call("ActMod_CantSCAct",nil,pl,"actmod_keyo_".. tostring(str)) == true then return end
				local Aca
				if isnumber(str) then
					local ActiData = A_AM.ActMod:LoadEmts("savemots",{"ActojiDialh"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
					if ActiData and istable(ActiData) then Actoji.table = ActiData end
					Aca = Actoji.table[str]
				else
					Aca = str
				end
				
				pl:SetNWString("A_ActMod_cl_actLoop",Aca) pl.AGSped_f = 0 pl.AGSped_b = 0
				local cl_s, cl_e, cl_l = "0", "0", "0"
				if GetConVarNumber("actmod_cl_sound") == 1 then cl_s = "1" end
				if GetConVarNumber("actmod_cl_effects") == 1 then cl_e = "1" end
				if GetConVarNumber("actmod_cl_loop") == 1 then cl_l = "1" elseif GetConVarNumber("actmod_cl_loop") == 2 then cl_l = "2" end
				A_AM.ActMod:CStart_cl(Aca,string.format("%s %s %s",cl_s,cl_e,cl_l))
			else
				A_AM.ActMod:SP_iError(pl,"nallow")
			end
		end
		local function AKstt(ply)
			if (ply == LocalPlayer() and ply:Alive()) and ( not gui.IsGameUIVisible() and not gui.IsConsoleVisible() ) then
				if GetConVarNumber("actmod_cl_allowkey") == 1 and input.IsKeyDown(GetConVar("actmod_keyo_h"):GetInt()) then
					if A_AM.ActMod:aIsRdy(ply) and A_AM.ActMod.clo_IMeun_Num ~= 0 then
						if input.WasKeyPressed(GetConVar("actmod_keyo_1"):GetInt()) then A_StrtActC(ply,1) return true
						elseif input.WasKeyPressed(GetConVar("actmod_keyo_2"):GetInt()) then A_StrtActC(ply,2) return true
						elseif input.WasKeyPressed(GetConVar("actmod_keyo_3"):GetInt()) then A_StrtActC(ply,3) return true
						elseif input.WasKeyPressed(GetConVar("actmod_keyo_4"):GetInt()) then A_StrtActC(ply,4) return true
						elseif input.WasKeyPressed(GetConVar("actmod_keyo_5"):GetInt()) then A_StrtActC(ply,5) return true
						end
					end
				end
				if GetConVarNumber("actmod_cl_allowkey2") == 1 and input.IsKeyDown(GetConVar("actmod_keyo_h2"):GetInt()) then
					if A_AM.ActMod:aIsRdy(ply) and A_AM.ActMod.clo_IMeun_Num ~= 0 then
						if input.WasKeyPressed(GetConVar("actmod_keyo_6"):GetInt()) then A_StrtActC(ply,6) return true
						elseif input.WasKeyPressed(GetConVar("actmod_keyo_7"):GetInt()) then A_StrtActC(ply,7) return true
						elseif input.WasKeyPressed(GetConVar("actmod_keyo_8"):GetInt()) then A_StrtActC(ply,8) return true
						elseif input.WasKeyPressed(GetConVar("actmod_keyo_9"):GetInt()) then A_StrtActC(ply,9) return true
						elseif input.WasKeyPressed(GetConVar("actmod_keyo_10"):GetInt()) then A_StrtActC(ply,10) return true
						end
					end
				end
			end
		end
		hook.Add("PlayerBindPress",yR .."ActMod_PlayerBindPress",function(ply,bind,pressed)
			if (ply.ActMod_AddTRu or 0) > CurTime() then
				if (bind == "-jump" or bind == "+jump") then return true end
			end
			if ply:A_ActMod_GetIsAct() then
				if (bind == "invprev" or bind == "invnext") and not ply.ActMod_UseMenu then
					if input.IsKeyDown(KEY_E) then
						if bind == "invprev" then
							if (ply.ActMod_cam_tisp or 0) < CurTime() then
								ply.ActMod_cam_tisp = CurTime() + 0.02
								if not ply.aactmod_Zamsp then ply.aactmod_Zamsp = 0 end
								ply.aactmod_Zamsp = math.Clamp(ply.aactmod_Zamsp - (input.IsKeyDown(KEY_LSHIFT) and 10 or input.IsKeyDown(KEY_LALT) and 1 or 5), -ply:OBBMaxs().z/4, ply:OBBMaxs().z/1.2)
							end
						else
							if (ply.ActMod_cam_tisp or 0) < CurTime() then
								ply.ActMod_cam_tisp = CurTime() + 0.02
								if not ply.aactmod_Zamsp then ply.aactmod_Zamsp = 0 end
								ply.aactmod_Zamsp = math.Clamp(ply.aactmod_Zamsp + (input.IsKeyDown(KEY_LSHIFT) and 10 or input.IsKeyDown(KEY_LALT) and 1 or 5), -ply:OBBMaxs().z/4, ply:OBBMaxs().z/1.2)
							end
						end
					elseif GetConVarNumber("actmod_cl_smshcam_on") > 0 and input.IsKeyDown(KEY_LALT) then
						if bind == "invprev" then
							if (ply.ActMod_cam_tisp or 0) < CurTime() then
								ply.ActMod_cam_tisp = CurTime() + 0.02
								ply:ConCommand("actmod_cl_smshcam_sp ".. math.Clamp(GetConVarNumber("actmod_cl_smshcam_sp") + 1, 1, 10) .."\n")
							end
						else
							if (ply.ActMod_cam_tisp or 0) < CurTime() then
								ply.ActMod_cam_tisp = CurTime() + 0.02
								ply:ConCommand("actmod_cl_smshcam_sp ".. math.Clamp(GetConVarNumber("actmod_cl_smshcam_sp") - 1, 1, 10) .."\n")
							end
						end
					else
						if bind == "invprev" then
							if (ply.ActMod_cam_tisp or 0) < CurTime() then
								ply.ActMod_cam_tisp = CurTime() + 0.01
								ply.aactmod_camzm = math.Clamp(ply.aactmod_camzm - (input.IsKeyDown(KEY_LSHIFT) and 20 or input.IsKeyDown(KEY_LALT) and 1 or 5), -115, GetConVarNumber("actmod_sv_rangecam"))
							end
						else
							if (ply.ActMod_cam_tisp or 0) < CurTime() then
								ply.ActMod_cam_tisp = CurTime() + 0.01
								ply.aactmod_camzm = math.Clamp(ply.aactmod_camzm + (input.IsKeyDown(KEY_LSHIFT) and 20 or input.IsKeyDown(KEY_LALT) and 1 or 5), -115, GetConVarNumber("actmod_sv_rangecam"))
							end
						end
					end
				elseif input.IsKeyDown(KEY_LALT) and input.WasMousePressed(MOUSE_RIGHT) then
						if GetConVarNumber("actmod_cl_smshcam_on") != 1 then
							ply:ConCommand("actmod_cl_smshcam_on 1 \n")
						else
							ply:ConCommand("actmod_cl_smshcam_on 0 \n")
						end
				elseif input.IsKeyDown(KEY_E) and input.WasMousePressed(MOUSE_RIGHT) then
						ply.aactmod_camzm = 0  ply.aactmod_Zamsp = 0
				
				elseif pressed == true then
					AKstt(ply)
				end
				
				if (ply.ActMod_AddTRu or 0) < CurTime() and not ( input.IsKeyDown(KEY_LALT) or input.IsKeyDown(KEY_E) ) and bind == "+jump" and pressed then
					ply.ActMod_AddTRu = CurTime() + 0.3
					if (ply.ActMod_CurTStart or 0) < CurTime() - 0.5 then
						ply.ActMod_AddTRuh = true
					end
					return true
				end
				
				if (bind == "invnext" or bind == "invprev" or bind:sub(1,4) == "slot") then return true end
				return
			else
				if (ply.ActMod_cam_tisp or 0) < CurTime() then
					ply.ActMod_GPl2TSndJ = nil
					ply.ActMod_GNamTSndJ = ""
				end
				if input.IsKeyDown(KEY_LSHIFT) or input.IsKeyDown(KEY_RSHIFT) then
					if (ply.ActMod_cam_tisp or 0) < CurTime() and (ply.ActMod_TSndJ or 0) < CurTime() then
						ply.ActMod_GPl2TSndJ = nil
						ply.ActMod_GNamTSndJ = ""
						if not ply:KeyDown(IN_SPEED) then ply.ActMod_GkTPlyTJn = ply.ActMod_TSndJ_LookTPly end
						local Pl2 = ply.ActMod_GkTPlyTJn
						if Pl2 and IsValid(Pl2) and Pl2:Alive() and Pl2:GetObserverMode() == 0 and (bind == "+use") then
							local Pl2_ok = A_AM.ActMod:aGetLookTPly( ply )
							if Pl2_ok and IsValid(Pl2_ok) and Pl2 == Pl2_ok then
								ply.ActMod_cam_tisp = CurTime() + 2.6
								ply.ActMod_TSndJ = CurTime() + 2
								ply.ActMod_GPl2TSndJ = Pl2
								ply.ActMod_GNamTSndJ = Pl2:Nick()
								ply.ActMod_GkTPlyTJn = nil
								if timer.Exists( "actmod_AutoRemoveNamePly2" ) then timer.Remove( "actmod_AutoRemoveNamePly2" ) end
								timer.Create("actmod_AutoRemoveNamePly2",math.max(ply.ActMod_TSndJ - CurTime()-0.5,0),1,function() if IsValid(ply) then
									ply.ActMod_cam_tisp = CurTime() + 0.1
									ply.ActMod_GkTPlyTJn = nil
									ply.ActMod_GPl2TSndJ = nil
									ply.ActMod_GNamTSndJ = ""
								end end)
								A_AM.ActMod:cl_AdJoing( ply,Pl2,{ply:GetPos(),ply:GetAngles()} )
							end
						end
					end
				end
				return AKstt(ply)
			end
		end)

		if not A_AM.ActMod.GRTSYS or not A_AM.ActMod.GRTSYS.GRT then
			A_AM.ActMod.GRTSYS.GRT = GetRenderTarget("actmod_tcmdl_rt", 32, 32, false)
			A_AM.ActMod.GRTSYS.POS = Vector(0, 0, 0)
			A_AM.ActMod.GRTSYS.ANG = Angle(0, 0, 0)
			A_AM.ActMod.GRTSYS.Tim = CurTime()
		end
		hook.Add("PostRender", yR .."ActMod_PRender", function()
			if A_AM.ActMod.GRTSYS and A_AM.ActMod.GRTSYS.GRT and istable(A_AM.ActMod.GRTSYS.TMDL) and not table.IsEmpty(A_AM.ActMod.GRTSYS.TMDL) then
				if (A_AM.ActMod.GRTSYS.Tim - 0.3 or 0) <= CurTime() then
					for k, pl in player.Iterator() do
						if not IsValid(pl) or not pl:A_ActMod_GetIsAct() then continue end
						A_AM.ActMod.GRTSYS.Tim = CurTime() + 1
					end
				end
				if (A_AM.ActMod.GRTSYS.Tim or 0) > CurTime() then
					for inm, cmdl in pairs(A_AM.ActMod.GRTSYS.TMDL) do
						if IsValid(cmdl) then
							render.PushRenderTarget(A_AM.ActMod.GRTSYS.GRT)
							render.Clear(0, 0, 0, 0)
							cam.Start3D(A_AM.ActMod.GRTSYS.POS, A_AM.ActMod.GRTSYS.ANG, 70, 0, 0, 512, 512)
								cmdl:DrawModel()
							cam.End3D()
							render.PopRenderTarget()
						else
							A_AM.ActMod.GRTSYS.TMDL[inm] = nil
						end
					end
				else
					for inm, cmdl in pairs(A_AM.ActMod.GRTSYS.TMDL) do
						if IsValid(cmdl) then A_AM.ActMod.GRTSYS.TMDL[inm]:Remove() end
						A_AM.ActMod.GRTSYS.TMDL[inm] = nil
					end
				end
			end
		end)
		
	end
	
	hook.Add("PlayerSpawn",yR .."ActMod_Spawn",function(ply) A_AM.ActMod:A_ActMod_OffActing( ply ) end)
	hook.Add("PlayerDeath",yR .."ActMod_Death",function(ply) A_AM.ActMod:A_ActMod_OffActing( ply ) end)
	hook.Add( "DoAnimationEvent" , yR .."ActMod_DAE" , function( ply, event, data )
		if not ply:A_ActMod_GetIsAct() or ply.ActMod_OPT_VR and ply.ActMod_OPT_VR["NoAni"] then return end
		local Wep
		if aIsPlayerHoldingOurSwep and isfunction(aIsPlayerHoldingOurSwep) then Wep = aIsPlayerHoldingOurSwep(ply) end
		if A_AM.ActMod.LuaSAnim and Wep ~= nil and (isfunction(Wep.GetNetworkVars)) and (Wep:GetState() > 0) then
			local validWep = aIsPlayerValidForAnimation(p)
			if (validWep ~= nil) then
				return ACT_INVALID
			end
		else
			if A_AM.ActMod.Mounted[ "Theatrical MMD" ] and event == PLAYERANIMEVENT_CUSTOM then
				local Strg = ply.AActEnt_GetActDir and ply:AActEnt_GetActDir() or ""
				local scya = ply.AActEnt_CycleAct and ply:AActEnt_CycleAct() or ""
				if data == 100110 then
					ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_GRENADE, ply:LookupSequence( "range_smg1" ), 5, true ) return ACT_INVALID
				elseif data == 102020 then
					local seq,setcyc
					seq = ply:LookupSequence( Strg )
					setcyc = scya
					if not seq or seq < 0 then return end
					ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_GRENADE, seq, setcyc, true ) 
					return ACT_INVALID
				end
			end
			if A_AM.ActMod.svOn == false or ply.OffActMod then return end
			if event == PLAYERANIMEVENT_CUSTOM then
				if data == 100010 then
					ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_GRENADE, ply:LookupSequence( "range_smg1" ), 5, true )
					return ACT_INVALID
				elseif data == 101020 then
					local seq,setcyc
					local Strg = ply:A_ActMod_GetActDir() or ""
					local scya = ply:A_ActMod_CycleAct() or ""
					seq = ply:LookupSequence( Strg )
					setcyc = scya
					if not seq or seq < 0 then return end
					ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_GRENADE, seq, setcyc, true ) 
					return ACT_INVALID
				end
			end
		end
	end )
	
	local function IsOutOfBounds(value)
		return value > 1 or value < -1
	end
	
	local function a_UpdateAnimation(ply,tlp)
		if tlp then print("-tlp:",tlp) end
		aFixRAng(ply)
		
		local Wep
		if aIsPlayerHoldingOurSwep and isfunction(aIsPlayerHoldingOurSwep) then Wep = aIsPlayerHoldingOurSwep(ply) end
		if A_AM.ActMod.LuaSAnim and Wep ~= nil and (isfunction(Wep.GetNetworkVars)) and (Wep:GetState() > 0) then
			hook.Call( "AM_UATheFirst" ,nil,ply)
		else
			if ply:A_ActMod_RateAct() ~= 1 then
				ply:SetPlaybackRate( ply:A_ActMod_RateAct() )
			else
				ply:SetPlaybackRate( 1 )
			end
			return true
		end
	end
	hook.Add( "UpdateAnimation", yR .."ActMod_SlowDownAnim", function(ply)
		if ply:A_ActMod_GetIsAct() and (ply.ActMod_OPT_VR and not ply.ActMod_OPT_VR["NoAni"] or not ply.ActMod_OPT_VR) then
			return a_UpdateAnimation(ply)
		end
	end )
	
	local function a_CalcMainActivity(ply,tlp)
		if tlp then print("-tlp:",tlp) end
		if CLIENT then A_AM.ActMod:AA_RunCyc( ply ) end
		local Wep
		if aIsPlayerHoldingOurSwep and isfunction(aIsPlayerHoldingOurSwep) then Wep = aIsPlayerHoldingOurSwep(ply) end
		if A_AM.ActMod.LuaSAnim and Wep ~= nil and (isfunction(Wep.GetNetworkVars)) and (Wep:GetState() > 0) then
			local act = ply:LookupSequence("walk_suitcase")
			return act, act
		else
			local seq = ply:A_ActMod_GetActDir()
			local seqid = ply:LookupSequence( seq or "" )
			if seqid == nil or seqid < 0 then return end
			if (not ply.actmod_Coop_Tply or ply.actmod_Coop_Tply and not IsValid(ply.actmod_Coop_Tply)) and not ply.ActMod_ReaginRunAct and ply.ActMod_CurTRun and (not ply.ActMod_CurTRun or ply.ActMod_TSavCurTRun ~= ply.ActMod_CurTRun) and (ply.ActMod_CurTRun < CurTime() - 2 and ply.ActMod_CurTRun > CurTime() - 30) and (ply.actmod_TCurSeq or 0) < CurTime() then
				ply.actmod_TCurSeq = CurTime() + 3
				local gTimSeq = ply:SequenceDuration(seqid)
				if gTimSeq > 30 then
					local curTime = A_AM.ActMod:ConvertCycleToTime(ply:GetCycle(), gTimSeq)
					local cycle = A_AM.ActMod:ConvertTimeToCycle(curTime, gTimSeq)
					local daaT = CurTime() - ply.ActMod_CurTRun
					local distT = daaT - curTime
					if IsOutOfBounds(distT) then
						local Fixcycle = A_AM.ActMod:ConvertTimeToCycle(daaT, gTimSeq)
						ply:SetCycle( Fixcycle )
						ply.ActMod_TSavCurTRun = ply.ActMod_CurTRun
					end
				else
					ply.ActMod_TSavCurTRun = ply.ActMod_CurTRun
				end
			end
			if ply:A_ActMod_RateAct() ~= 1 then
				ply:SetPlaybackRate( ply:A_ActMod_RateAct() )
			else
				ply:SetPlaybackRate( 1 )
			end
			return -1, seqid or nil
		end
	end
	hook.Add( "CalcMainActivity", yR .."ActMod_Animations", function( ply, velocity )
		if IsValid( ply ) and ply:A_ActMod_GetIsAct() and not A_IsL4DA(ply) then
			if ply.ActMod_OPT_VR and ply.ActMod_OPT_VR["NoAni"] then
			else
				return a_CalcMainActivity(ply)
			end
		else
			if glue then
				local component = glue:GetComponent( ply, "AnimationEvents" );
				if component then
					return component:CalcMainActivity( ply, velocity );
				end
			end
		end
	end )



	hook.Add( "SetupMove", yR .."ActMod_SetupMove", function( ply, mv, cmd )
		if ply:Alive() and ply:A_ActMod_GetIsAct() then
			local MDir = ply:A_ActMod_GetMoveDir()
			if GetConVarNumber("actmod_sv_typmovecl") <= 0 or ply:IsBot() then
				if not ply.actmod_TabPKey then ply.actmod_TabPKey = {} end
				if not ply.actmod_TabPKey.TarRLAng then ply.actmod_TabPKey.TarRLAng = 0 end
				local TarRLAng = ply.actmod_TabPKey.TarRLAng or 0
				local a = isserverD and 0.3 or 0.03
				local B = (isserverD and 7 or 3)
				if ply.ActMod_DontAlwAng or ply.ActMod_DontAAng then
					ply:SetNWFloat("a_SRLAngMove", 0)
				elseif MDir != 0 and MDir != 7 then
					if A_AM.ActMod:A_ActMod_GetPKey( ply ,"+moveright" ) then
						if TarRLAng > 0 and A_AM.ActMod:A_ActMod_GetPKey( ply ,"+speed" ) then
							TarRLAng = 0
						elseif A_AM.ActMod:A_ActMod_GetPKey( ply ,"+speed" ) then
							TarRLAng = math.max(-B*1.4,TarRLAng - 10*a)
						elseif A_AM.ActMod:A_ActMod_GetPKey( ply ,"+walk" ) then
							TarRLAng = math.max(-B*0.2,TarRLAng - 2*a)
						else
							TarRLAng = math.max(-B*0.6,TarRLAng - 3*a)
						end
					elseif A_AM.ActMod:A_ActMod_GetPKey( ply ,"+moveleft" ) then
						if TarRLAng < 0 and A_AM.ActMod:A_ActMod_GetPKey( ply ,"+speed" ) then
							TarRLAng = 0
						elseif A_AM.ActMod:A_ActMod_GetPKey( ply ,"+speed" ) then
							TarRLAng = math.min(B*1.4,TarRLAng + 10*a)
						elseif A_AM.ActMod:A_ActMod_GetPKey( ply ,"+walk" ) then
							TarRLAng = math.min(B*0.2,TarRLAng + 2*a)
						else
							TarRLAng = math.min(B*0.6,TarRLAng + 3*a)
						end
					else
						if TarRLAng > 0 then
							TarRLAng = math.max(0,TarRLAng - 20*a)
						elseif TarRLAng < 0 then
							TarRLAng = math.min(0,TarRLAng + 20*a)
						end
					end
					ply.actmod_TabPKey.TarRLAng = TarRLAng
					ply:SetNWFloat("a_SRLAngMove", (ply:GetNWFloat("a_SRLAngMove",0) + TarRLAng)%360)
				end
				local gIsVR = A_AM.ActMod:IsVR(ply)
				if not gIsVR then
					if not ply.actmod_PlayerLockAngles then
						ply.actmod_PlayerLockAngles = cmd:GetViewAngles()
					end
					local atXt = ply:GetNWString("ActMod_aAng","")
					if atXt ~= "" then
						local TtXt = string.Explode("|", atXt, true)
						if TtXt and istable(TtXt) and TtXt[1] and TtXt[1] == "1" and TtXt[3] then
							ply.actmod_PlayerLockAngles = Angle(TtXt[2],TtXt[3],0)
						end
					end
					if ply.actmod_PlayerLockAngles then
						if A_AM.ActMod:A_ActMod_GPCoop( ply ) then
							ply:SetEyeAngles( ply.actmod_PlayerLockAngles )
							cmd:SetViewAngles( ply.actmod_PlayerLockAngles )
						else
							ply:SetEyeAngles( ply.actmod_PlayerLockAngles + Angle(0, ply:GetNWInt("a_SRLAngMove",0), 0) )
							cmd:SetViewAngles( ply.actmod_PlayerLockAngles + Angle(0, ply:GetNWInt("a_SRLAngMove",0), 0) )
						end
					end
				end
			elseif GetConVarNumber("actmod_sv_typmovecl") > 0 then
				if not ply:IsBot() and (not A_AM.ActMod:IsVR(ply) or (not ply.ActMod_OPT_VR or not ply.ActMod_OPT_VR["VR_CanMove"])) then
					if ply:GetMoveType() == 2 and ply:GetObserverMode() == 0 and cmd:GetForwardMove() > 0 and ( MDir == 1 or MDir == 5 or MDir == 8 or MDir == 9) then
						if not ply.a_TmpMForward then ply.a_TmpMForward = true A_AM.ActMod:ThinkChingAni(ply) end
						ply.AalowAnim_MForward = true
					else
						ply.AalowAnim_MForward = nil
						if ply.a_TmpMForward then ply.a_TmpMForward = nil A_AM.ActMod:ThinkChingAni(ply) end
					end
				end
			end
			if ply.ActMod_OPT_VR and ply.ActMod_OPT_VR["CanMove"] then
			else
				cmd:ClearButtons()
				if MDir ~= 1 and MDir ~= 2 and MDir ~= 5 and MDir ~= 8 and MDir ~= 9 then cmd:ClearMovement() end
			end
		end
	end )

	local agggo_1,agggo_2 = 4,7
	hook.Add( "Move", yR .."ActMod_MoveDir", function( ply, mv )
		if ply:A_ActMod_GetIsAct() and ply:GetMoveType() == 2 and ply:GetObserverMode() == 0 then
			local OPVR = not A_AM.ActMod:IsVR(ply) or (not ply.ActMod_OPT_VR or not ply.ActMod_OPT_VR["VR_CanMove"])
			if not ply:IsBot() and ply:OnGround() and OPVR and GetConVarNumber("actmod_sv_typmovecl") > 0 then
			elseif ply:OnGround() and OPVR and (GetConVarNumber("actmod_sv_typmovecl") <= 0 or ply:IsBot()) then
				local vel,atr = mv:GetVelocity() ,false
				if SERVER then
					if ply:A_ActMod_GetMoveDir() == 1 or ply:A_ActMod_GetMoveDir() == 9 then atr = true vel = ply:GetForward() *(ply:GetNWInt( "A_AM.MoveSpeed" ))
					elseif ply:A_ActMod_GetMoveDir() == 2 then atr = true vel = ply:GetForward() *-(ply:GetNWInt( "A_AM.MoveSpeed" ))
					elseif ply:A_ActMod_GetMoveDir() == 3 then atr = true vel = ply:GetRight()*(ply:GetNWInt( "A_AM.MoveSpeed" ))
					elseif ply:A_ActMod_GetMoveDir() == 4 then atr = true vel = ply:GetRight()*-(ply:GetNWInt( "A_AM.MoveSpeed" ))
					elseif ply:A_ActMod_GetMoveDir() == 5 or ply:A_ActMod_GetMoveDir() == 6 then atr = true
						if A_AM.ActMod:A_ActMod_GetPKey( ply ,"+forward" ) and ( ply:A_ActMod_GetMoveDir() == 6 and (ply.TimeGo_Attk or 0) < CurTime() or ply:A_ActMod_GetMoveDir() != 6 ) then
							if ply.AalowAnim_MForward then
								if not ply.a_TmpMForward then ply.a_TmpMForward = true A_AM.ActMod:ThinkChingAni(ply) end
								ply.AGSped_f = math.min(ply:GetNWInt( "A_AM.MoveSpeed" ),ply.AGSped_f + ply:GetNWInt( "A_AM.MoveSpeed" )*5*FrameTime())
								vel = ply:GetForward() * ply.AGSped_f
							end
							ply.AalowAnim_MForward = true
						else
							if ply.AGSped_f > 0 then
								ply.AGSped_f = math.max(0,ply.AGSped_f - ply:GetNWInt( "A_AM.MoveSpeed" )*6*FrameTime())
								vel = ply:GetForward() * ply.AGSped_f
							end
							ply.AalowAnim_MForward = nil
							if ply.a_TmpMForward then ply.a_TmpMForward = nil A_AM.ActMod:ThinkChingAni(ply) end
						end
					elseif ply:A_ActMod_GetMoveDir() == 15 then atr = true
						if A_AM.ActMod:A_ActMod_GetPKey( ply ,"+forward" ) then
							if ply.AalowAnim_MForward then
								if not ply.a_TmpMForward then ply.a_TmpMForward = true A_AM.ActMod:ThinkChingAni(ply) end
								ply.AGSped_f = math.min(ply:GetNWInt( "A_AM.MoveSpeed" ),ply.AGSped_f + ply:GetNWInt( "A_AM.MoveSpeed" )*5*FrameTime())
								vel = ply:GetForward() * -ply.AGSped_f
							end
							ply.AalowAnim_MForward = true
						else
							if ply.AGSped_f > 0 then
								ply.AGSped_f = math.max(0,ply.AGSped_f - ply:GetNWInt( "A_AM.MoveSpeed" )*6*FrameTime())
								vel = ply:GetForward() * -ply.AGSped_f
								end
							ply.AalowAnim_MForward = nil
							if ply.a_TmpMForward then ply.a_TmpMForward = nil A_AM.ActMod:ThinkChingAni(ply) end
						end
					elseif ply:A_ActMod_GetMoveDir() == 8 then
					elseif ply:A_ActMod_GetMoveDir() == 18 then atr = true
						if A_AM.ActMod:A_ActMod_GetPKey( ply ,"+forward" ) then
							ply.AGSped_b = 0
							ply.AGSped_f = Lerp( 0.04, ply.AGSped_f, ply:GetNWInt( "A_AM.MoveSpeed" ) )
							vel = ply:GetForward() * ply.AGSped_f
						elseif A_AM.ActMod:A_ActMod_GetPKey( ply ,"+back" ) then
							ply.AGSped_f = 0
							if ply:GetNWString("A_ActMod.Dir", "") == "zombie_run_fast" then
								ply.AGSped_b = Lerp( 0.04, ply.AGSped_b, ply:GetNWInt( "A_AM.MoveSpeed" )/5 )
							else
								ply.AGSped_b = Lerp( 0.04, ply.AGSped_b, ply:GetNWInt( "A_AM.MoveSpeed" ) )
							end
							vel = ply:GetForward() * -ply.AGSped_b
						else
							if ply.AGSped_f > 0 then ply.AGSped_f = math.max(0,ply.AGSped_f - ply:GetNWInt( "A_AM.MoveSpeed" )*3*FrameTime()) vel = ply:GetForward() * ply.AGSped_f end
							if ply.AGSped_b > 0 then ply.AGSped_b = math.max(0,ply.AGSped_b - ply:GetNWInt( "A_AM.MoveSpeed" )*2.5*FrameTime()) vel = ply:GetForward() * -ply.AGSped_b end
						end
					end
					if vel and (vel[1] != 0 or vel[2] != 0 ) and atr == true then
						mv:SetVelocity( (isserverD and vel*1.3 or vel)+Angle(0,ply:EyeAngles().y,0):Forward() )
						if trgvsv then ply:SetNWVector( "ply.AGSped_vel", vel ) end
					end
				elseif CLIENT then
					if trgvsv then
						local gav = ply:GetNWVector( "ply.AGSped_vel", Vector(0,0,0) )
						if gav and gav ~= Vector(0,0,0) then
							mv:SetVelocity( gav + Angle(0,ply:EyeAngles().y,0):Forward() )
						end
					end
				end
			end
		end
	end )
	
	
	if SERVER then
		timer.Simple(11, function()
			if not A_AM.ActMod.OneEditForHook_sv then
				A_AM.ActMod.OneEditForHook_sv = true
				
				if GetConVarNumber("actmod_sv_syrhook") == 1 or GetConVarNumber("actmod_sv_syrhook") == 3 then
					local OriginalHookCall = hook.Call
					hook.Call = function(hookName, gamemode, ...)
						if hookName == "PlayerCanPickupWeapon" then
							local args = {...}
							if args[1] and IsValid(args[1]) and args[2]:GetClass() == "aact_weapact" then args[2].GiveTo = args[1] return true end
						elseif hookName == "UpdateAnimation" or hookName == "CalcMainActivity" then
							local args = {...}
							local ply = args[1]
							if ply:GetNWBool( "A_AM.ActMod.IsAct", false ) and (not ply.ActMod_OPT_VR or istable(ply.ActMod_OPT_VR) and not ply.ActMod_OPT_VR["NoAni"]) then
								return
							end
						end
						return OriginalHookCall(hookName, gamemode, ...)
					end
				end
				
				if GetConVarNumber("actmod_sv_syrhook") == 2 or GetConVarNumber("actmod_sv_syrhook") == 3 then
					local PCPWHooks = hook.GetTable().PlayerCanPickupWeapon or {}
					if istable(PCPWHooks) then
						for name, func in pairs(PCPWHooks) do
							if A_AM.ActMod:CTSkipHookThis("PlayerCanPickupWeapon",name) then
								hook.Remove("PlayerCanPickupWeapon", name)
								hook.Add("PlayerCanPickupWeapon", name, function(ply, weap, ...)
									if ply and IsValid(ply) and weap:GetClass() == "aact_weapact" then weap.GiveTo = ply return true end
									return func(ply, weap, ...)
								end)
							end
						end
					end
					
					local aUPHooks = hook.GetTable().UpdateAnimation or {}
					if istable(aUPHooks) then
						for name, func in pairs(aUPHooks) do
							if A_AM.ActMod:CTSkipHookThis("UpdateAnimation",name) then
								hook.Remove("UpdateAnimation", name)
								hook.Add("UpdateAnimation", name, function(ply, ...)
									if ply:GetNWBool( "A_AM.ActMod.IsAct", false ) and (not ply.ActMod_OPT_VR or istable(ply.ActMod_OPT_VR) and not ply.ActMod_OPT_VR["NoAni"]) then
										return a_UpdateAnimation(ply)
									else
										return func(ply, ...)
									end
								end)
							end
						end
					end
					
					local aCMAHooks = hook.GetTable().CalcMainActivity or {}
					if istable(aCMAHooks) then
						for name, func in pairs(aCMAHooks) do
							if A_AM.ActMod:CTSkipHookThis("CalcMainActivity",name) then
								hook.Remove("CalcMainActivity", name)
								hook.Add("CalcMainActivity", name, function(ply, ...)
									if ply:GetNWBool( "A_AM.ActMod.IsAct", false ) and (not ply.ActMod_OPT_VR or istable(ply.ActMod_OPT_VR) and not ply.ActMod_OPT_VR["NoAni"]) then
										return a_CalcMainActivity(ply)
									else
										return func(ply, ...)
									end
								end)
							end
						end
					end
				end
				
			end
		end)
	elseif CLIENT then
		timer.Simple(12, function()
			if not A_AM.ActMod.OneEditForHook_cl then
				A_AM.ActMod.OneEditForHook_cl = true
				
				if GetConVarNumber("actmod_sv_syrhook") == 1 or GetConVarNumber("actmod_sv_syrhook") == 3 then
					local aCMAHooks = hook.GetTable().CalcMainActivity or {}
					if istable(aCMAHooks) then
						for name, func in pairs(aCMAHooks) do
							if A_AM.ActMod:CTSkipHookThis("CalcMainActivity",name) then
								hook.Remove("CalcMainActivity", name)
								hook.Add("CalcMainActivity", name, function(ply, ...)
									if ply:GetNWBool( "A_AM.ActMod.IsAct", false ) and (not ply.ActMod_OPT_VR or istable(ply.ActMod_OPT_VR) and not ply.ActMod_OPT_VR["NoAni"]) then
										return a_CalcMainActivity(ply)
									else
										return func(ply, ...)
									end
								end)
							end
						end
					end
					
					local OriginalHookCall = hook.Call
					hook.Call = function(hookName, gamemode, ...)
						if hookName == "HUDWeaponPickedUp" then
							local args = {...}
							if args[1]:GetClass() == "aact_weapact" then return false end
						end
						if hookName == "CalcView" then
							local args = {...}
							local ply = args[1]
							if IsValid(ply) and ply:GetNWBool( "A_AM.ActMod.IsAct", false ) then return end
						elseif hookName == "UpdateAnimation" or hookName == "CalcMainActivity" then
							local args = {...}
							local ply = args[1]
							if ply:GetNWBool( "A_AM.ActMod.IsAct", false ) and (not ply.ActMod_OPT_VR or istable(ply.ActMod_OPT_VR) and not ply.ActMod_OPT_VR["NoAni"]) then
								return
							end
						end
						return OriginalHookCall(hookName, gamemode, ...)
					end
				end
				
				if GetConVarNumber("actmod_sv_syrhook") == 2 or GetConVarNumber("actmod_sv_syrhook") == 3 then
					local calcViewHooks = hook.GetTable().HUDWeaponPickedUp or {}
					if istable(calcViewHooks) then
						for name, func in pairs(calcViewHooks) do
							if A_AM.ActMod:CTSkipHookThis("HUDWeaponPickedUp",name) then
								hook.Remove("HUDWeaponPickedUp", name)
								hook.Add("HUDWeaponPickedUp", name, function(we, ...)
									if we:GetClass() == "aact_weapact" then return false end
									return func(we, ...)
								end)
							end
						end
					end
					
					local calcViewHooks = hook.GetTable().CalcView or {}
					if istable(calcViewHooks) then
						for name, func in pairs(calcViewHooks) do
							if A_AM.ActMod:CTSkipHookThis("CalcView",name) then
								hook.Remove("CalcView", name)
								hook.Add("CalcView", name, function(ply, ...)
									if ply:GetNWBool( "A_AM.ActMod.IsAct", false ) then return end
									return func(ply, ...)
								end)
							end
						end
					end
					
					local aUPHooks = hook.GetTable().UpdateAnimation or {}
					if istable(aUPHooks) then
						for name, func in pairs(aUPHooks) do
							if A_AM.ActMod:CTSkipHookThis("UpdateAnimation",name) then
								hook.Remove("UpdateAnimation", name)
								hook.Add("UpdateAnimation", name, function(ply, ...)
									if ply:GetNWBool( "A_AM.ActMod.IsAct", false ) and (not ply.ActMod_OPT_VR or istable(ply.ActMod_OPT_VR) and not ply.ActMod_OPT_VR["NoAni"]) then
										return a_UpdateAnimation(ply)
									else
										return func(ply, ...)
									end
								end)
							end
						end
					end
				end
				
			end
		end)
	end
end

if A_AM and A_AM.ActMod and A_AM.ActMod.SetChfg then
	A_AM.ActMod:Setuphook()
	A_AM.ActMod.SetuphookOK = true
end

if SERVER then
	A_AM.ActMod.ATabKaysForSV = A_AM.ActMod.ATabKaysForSV or {}
	function A_AM.ActMod:A_ActMod_SDataKeys( ply,DataKeys )
		if ply and IsValid(ply) and ply:IsPlayer() and not ply:IsBot() then
			local GIDPly = string.format("%s|#|%s",ply:Nick(),ply:SteamID64())
			if not A_AM.ActMod.ATabKaysForSV[GIDPly] then A_AM.ActMod.ATabKaysForSV[GIDPly] = {} end
			if DataKeys and istable(DataKeys) then
				A_AM.ActMod.ATabKaysForSV[GIDPly] = DataKeys
			end
		end
	end
	function A_AM.ActMod:AGDataKeys( ply,button,DKey )
		if ply and IsValid(ply) and ply:IsPlayer() and not ply:IsBot() then
			local GIDPly = string.format("%s|#|%s",ply:Nick(),ply:SteamID64())
			if button and DKey and A_AM.ActMod.ATabKaysForSV and A_AM.ActMod.ATabKaysForSV[GIDPly] then
				if A_AM.ActMod.ATabKaysForSV[GIDPly][button] == DKey then
					return true
				end
			end
		end
		return false
	end

elseif CLIENT then
	function A_AM.ActMod:SandDataKeysTSV( ply )
		A_AM.ActMod.ATabKaysForSV = {}
		local a_kays = { "+moveright","+moveleft","+forward","+back","+speed","+use","+walk","+jump","+attack","+attack2" }
		for n, k in pairs(a_kays) do
			local GKey = input.LookupBinding( k )
			if GKey then
				local Ckey = input.GetKeyCode(GKey) or nil
				if Ckey then
					if not A_AM.ActMod.ATabKaysForSV then A_AM.ActMod.ATabKaysForSV = {} end
					A_AM.ActMod.ATabKaysForSV[ Ckey ] = k
				end
			end
		end
		net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"SandDataKeysTSV",{ply,A_AM.ActMod.ATabKaysForSV}} ) net.SendToServer()
	end
	
	if A_AM.ActMod.LuaHok then A_AM.ActMod:SandDataKeysTSV( LocalPlayer() ) end
	
	
end

A_AM.ActMod.LuaHok_Done = true