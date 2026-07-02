if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaCam = true

local isserverD = game.IsDedicated()

local function ASTC(ply,Atxt)
	RunConsoleCommand("actmod_wts","wts_SCTS",Atxt)
end

local function l_EyeOk(OkViw)
	local aok = 0
	if OkViw then aok = 1 end
	RunConsoleCommand("actmod_wts","wts_EyeOk",tostring(aok))
end

local function AScw(ply,cmd,ymove,yattk)
	if yattk then 
		if !ply.Aa_TGo_att1 and cmd:KeyDown( IN_ATTACK ) then
			ply.Aa_TGo_att1 = true
			if cmd:KeyDown( IN_SPEED ) then
				ASTC(ply,"E_ IN_ATTACKand")
			else
				ASTC(ply,"E_ IN_ATTACK")
			end
		elseif ply.Aa_TGo_att1 and !cmd:KeyDown( IN_ATTACK ) then
			ply.Aa_TGo_att1 = nil
		end
	end
end

local function VEye(ply,view,OkViw)
	if OkViw == true then
		local VGeyes = ply:LookupAttachment( "eyes" )
		if VGeyes > 0 then
			view.origin = ply:GetAttachment( VGeyes ).Pos
			view.angles = ply:GetAttachment( VGeyes ).Ang
		else
			local aBone = ply:LookupBone("ValveBiped.Bip01_Head1")
			if aBone then
				local apos,aang = ply:GetBonePosition(aBone)
				aang:RotateAroundAxis(aang:Right(), -90)
				aang:RotateAroundAxis(aang:Up(), -90)
				aang.p = aang.p - 10
				view.origin = apos + aang:Forward() * 3 + aang:Up() * 3
				view.angles = aang
			end
		end
	end
end

local BONE_WEIGHTS = {
    ["ValveBiped.Bip01_Pelvis"] = 0.4,
    ["ValveBiped.Bip01_Head1"] = 1.0,
    ["ValveBiped.Bip01_R_Hand"] = 0.5,
    ["ValveBiped.Bip01_L_Hand"] = 0.5,
    ["ValveBiped.Bip01_R_Foot"] = 0.8,
    ["ValveBiped.Bip01_L_Foot"] = 0.8,
}
function A_AM.ActMod:GetEntityBoneCenter(ent, boneNames)
    if not IsValid(ent) then return end
    boneNames = BONE_WEIGHTS or BONE_WEIGHTS
    local sum,count = Vector(0, 0, 0),0
    for kn, w in pairs(boneNames) do
        local boneID = ent:LookupBone(kn)
        if boneID then
            local pos = ent:GetBonePosition(boneID)
            if pos then
				local weight = w or 1
				sum = sum + (pos * weight)
				count = count + weight
            end
        end
    end
    if count == 0 then return ent:GetPos() end
    return sum / count
end

local function AGetAPos(ent)
	return A_AM.ActMod:GetEntityBoneCenter(ent, boneNames)
end

function A_AM.ActMod:CreateTauntCamera( endless ,ply ,o )

	local ply = LocalPlayer() or ply
	local CAM = {}

	local OkViw = GetConVarNumber("actmod_cl_setcamera") == 3 and true or false
	local CustomPos2,PlayerLockAngles
	local TiResAng,TiResAng1,TiResAng2 = CurTime(),0,0
	local GeyOn,WasOn = true,false
	local An180_x,An180_y,is180_x,is180_y,isCy = 180,0,0,0,false
	local InLerp,OutLerp,GCtLerp,GCtLerpZ,TarRLAng,SpRL = 0,1,0,0,0,3
	local GMovea,GRIGHT,GMovea_Sped,GRIGHT_Sped,GMovea_CTime,GMovea_CTim = 0,0,0,0,CurTime(),CurTime()
	local GRLAngMove = 0
	local SEyeOkViw = 0
	local sattCam,sTtCam,TtimUpdChkDAA = 0,CurTime(),CurTime()
	ply.ActMod_SECuAng_cl = {TOK = 0 ,S_pitch = 0 ,S_yaw = 0 ,pitch = 0 ,yaw = 0}
	ply.actmod_aeNt = {}
	ply.ActMod_AddTRuh = nil
	ply.ActMod_AddTRuh_Enum = 0
	ply.AalowAnim_MForward = nil
	ply.ActMod_Cam_SavAng = nil
	ply.ActMod_TRStopAct = CurTime()
	ply.ActMod_cam_tisp = CurTime() + 0.2
	if timer.Exists( "actmod_AutoRemoveNamePly2" ) then timer.Remove( "actmod_AutoRemoveNamePly2" ) end
	ply.ActMod_TSndJ = CurTime()+ 0.5
	ply.ActMod_GkTPlyTJn = nil
	ply.ActMod_GPl2TSndJ = nil
	ply.ActMod_GNamTSndJ = ""
	local WaitEyeOkViw = false
	
	local Asz = ply:GetModelScale()
	local hmax = A_AM.ActMod:HMX( ply )
	local PMaxs = hmax[13]
	local GSetPs = AGetAPos(ply) + Vector(0, 0, PMaxs*0.2)*Asz
	local GatLerp = GSetPs
	local GatLerp2 = 0
	

	local ZCustomAngles,ZCANbr = ply:EyeAngles(),0
	if timer.Exists( "A_AM_ZCustomAngles_"..ply:EntIndex() ) then timer.Remove( "A_AM_ZCustomAngles_"..ply:EntIndex() ) end
	timer.Create("A_AM_ZCustomAngles_"..ply:EntIndex(),0.2,3,function() if IsValid( ply ) then ZCustomAngles = ply:EyeAngles() ZCANbr = ZCANbr + 1 end end)
	local ZGetAngles = ply:GetAngles()
	ZGetAngles.p = 0
	local CustomAngles = Angle(ZCustomAngles.p,ZCustomAngles.y,0)
	local CustomAngles2 = Angle(ZCustomAngles.p,ZCustomAngles.y,0)
	local LCustomAngles = Angle(ZCustomAngles.p,ZCustomAngles.y,0)
	if (not o and GetConVarNumber("actmod_cl_cam180") == 1) then
		CustomAngles.p = -CustomAngles.p
		CustomAngles.y = CustomAngles.y + 180
		CustomAngles2.p = -CustomAngles2.p
		CustomAngles2.y = CustomAngles2.y + 180
		LCustomAngles.p = 0
		LCustomAngles.y = LCustomAngles.y + 180
	end
	
	ply.aactmod_Zamsp = math.Clamp(ply.aactmod_Zamsp , (-ply:OBBMaxs().z/3)*Asz, (ply:OBBMaxs().z/2.1)*Asz)
	if ply.aactmod_Zamsp ~= 0 then GCtLerpZ = ply.aactmod_Zamsp end
	
	

	CAM.Remove = function( self ) self = nil  return end
	CAM.ShouldDrawLocalPlayer = function( self, ply, on ) return on end
	CAM.CalcView = function( self, view, on )
		if ( PlayerLockAngles == nil ) then
			PlayerLockAngles = ply:EyeAngles()
			CustomAngles = ply:EyeAngles()
		end
		if !ply:Alive() then on = false end
		if ( PlayerLockAngles == nil ) then return end
		local aGLookAttBone = ply:LookupAttachment( "eyes" ) or ply:LookupBone("ValveBiped.Bip01_Head1")
		
		Asz = ply:GetModelScale()
		local GAGetAPos = AGetAPos(ply)
		local TargetOrigin = view.origin
		if (ply.ActMod_Trecamz or 0) < CurTime() and GetConVarNumber("actmod_sv_rangecam") < ply.aactmod_camzm then
			ply.ActMod_Trecamz = CurTime() + 2
			ply.aactmod_camzm = GetConVarNumber("actmod_sv_rangecam")
		end
		GCtLerp = Lerp( FrameTime() *3, GCtLerp, ply.aactmod_camzm )
		GCtLerpZ = Lerp( FrameTime() *3, GCtLerpZ, ply.aactmod_Zamsp )
		if GetConVarNumber("actmod_cl_setcamera") == 1 then
			TargetOrigin = GAGetAPos + Vector(0,0,(15-GCtLerpZ)*Asz) - CustomAngles:Forward() * (100+GCtLerp)*Asz
		elseif GetConVarNumber("actmod_cl_setcamera") == 2 then
			TargetOrigin = view.origin + Vector(0,0,-(7+GCtLerpZ)*Asz) - CustomAngles:Forward() * (120+GCtLerp)*Asz
		elseif GetConVarNumber("actmod_cl_setcamera") == 4 then
			local ggu = GAGetAPos + Vector(0, 0, PMaxs*0.35)
			GatLerp = LerpVector( RealFrameTime() * math.min(math.max((ggu.z-GatLerp.z)*2,1),15), GatLerp, ggu )
			GatLerp2 = Lerp( FrameTime() * math.min(math.max((ggu.z-GatLerp.z)*2,3),15), GatLerp2, (ggu.z-GatLerp.z)*2 )
			TargetOrigin = GatLerp + Vector(0,0,(17+GCtLerpZ+GatLerp2*0.5)*Asz) - CustomAngles:Forward() * (120+GCtLerp+GatLerp2*0.5)*Asz
		elseif GetConVarNumber("actmod_cl_setcamera") == 7 then
			TargetOrigin = (view.origin + Vector(0,0,(-15-GCtLerpZ+(GAGetAPos.z/2))*Asz) - CustomAngles:Forward() * (100+GCtLerp)*Asz)
		else
			if ply:A_ActMod_CamParent() then
				TargetOrigin = (GAGetAPos + Vector(0,0,(15-GCtLerpZ)*Asz) - CustomAngles:Forward() * (120+GCtLerp)*Asz)
			else
				TargetOrigin = view.origin + Vector(0,0,-(7+GCtLerpZ)*Asz) - CustomAngles:Forward() * (120+GCtLerp)*Asz
			end
		end
		
		local tr = util.TraceHull( { start = view.origin, endpos = TargetOrigin, mask = MASK_SHOT, filter = function(ent) if ent:IsWorld() or (ent:GetClass() == "prop_physics" or ent:GetClass() == "prop_dynamic" or ent:GetClass() == "prop_ragdoll") and ent:GetOwner() != ply then return true end end, mins = Vector( -8, -8, -8 ), maxs = Vector( 8, 8, 8 ) } )
		TargetOrigin = tr.HitPos + tr.HitNormal
		view.drawviewer = self:ShouldDrawLocalPlayer( ply, on )

		if ( InLerp < 1 ) then

			InLerp = InLerp + FrameTime() * ply:A_ActMod_CamInLerp()
			if GetConVarNumber("actmod_cl_setcamera") == 1 then view.origin = LerpVector( 0.8, view.origin + Vector(0,0,-(15+GCtLerpZ)*Asz) - CustomAngles:Forward() * 80*Asz, TargetOrigin )
			elseif GetConVarNumber("actmod_cl_setcamera") == 2 then view.origin = LerpVector( 0.8, view.origin + Vector(0,0,-(7+GCtLerpZ)*Asz) - CustomAngles:Forward() * 100*Asz, TargetOrigin )
			elseif GetConVarNumber("actmod_cl_setcamera") == 4 then
				local aeNt = ply.actmod_aeNt or {}
				local apcam = view.origin
				local vForward = CustomAngles:Forward()
				local vRight = CustomAngles:Right()
				if not aeNt.jone then aeNt.jone = true
					local PrevMins, PrevMaxs = ply:GetRenderBounds()
					aeNt.GSetPs = GAGetAPos + (vForward*(PrevMins:Distance(PrevMaxs)*1.2) + Vector(0,0, (PrevMins:Distance(PrevMaxs)*0.2)))*Asz
					aeNt.GDisCam = apcam:Distance(GAGetAPos)
					aeNt.GCtLerp = aeNt.GSetPs
					aeNt.PMins = PrevMins
					aeNt.PMaxs = PrevMaxs
				end
				if not aeNt.ttCam then aeNt.ttCam = CurTime() + 1 end
				if not aeNt.GDisCam then aeNt.GDisCam = apcam:Distance(GAGetAPos) end
				local angs,adis = 25,20
				local tstart = math.Clamp(CurTime()-aeNt.ttCam,0,1)
				local angt = (math.Clamp( angs*1.2 * math.sin(CurTime() * 0.4)^5 ,-angs,angs))*tstart
				local g2u = (math.Clamp(((apcam:Distance(GAGetAPos))-aeNt.GDisCam)*4,-adis,adis))
				local ggu = GAGetAPos + vForward * (aeNt.PMaxs.z*1.6) + Vector(0,0, aeNt.PMaxs.z*0.35)
				if not aeNt.GCtLerp2 then aeNt.GCtLerp2 = (ggu.z-aeNt.GCtLerp.z)*2 end
				aeNt.GCtLerp = LerpVector( RealFrameTime() * math.Clamp(g2u+(ggu.z-aeNt.GCtLerp.z)*2,1,15), aeNt.GCtLerp, ggu )
				aeNt.GCtLerp2 = Lerp( RealFrameTime() * math.Clamp(g2u+(ggu.z-aeNt.GCtLerp.z)*2,3,15), aeNt.GCtLerp2, (ggu.z-aeNt.GCtLerp.z)*2 )
				if not aeNt.GposyLrp then aeNt.GposyLrp = angt*2 end
				view.origin = aeNt.GCtLerp + vForward * (aeNt.GCtLerp2-math.abs(aeNt.GposyLrp*0.2)) + vRight * (aeNt.GposyLrp) + Vector(0,0,aeNt.GCtLerp2*0.5)
				aeNt.GposyLrp = Lerp( RealFrameTime() * math.Clamp(math.abs(angt*0.05),1,15), aeNt.GposyLrp, angt*2 )
			else
				if ply:A_ActMod_CamParent() then
					view.origin = LerpVector( InLerp, view.origin + Vector(0,0,-(15+GCtLerpZ)*Asz) - CustomAngles:Forward() * 80*Asz, TargetOrigin )
				else
					view.origin = LerpVector( InLerp, view.origin + Vector(0,0,-(7+GCtLerpZ)*Asz) - CustomAngles:Forward() * 100*Asz, TargetOrigin )
				end
			end
			CustomPos2 = Vector(view.origin.x,view.origin.y,view.origin.z)
			CustomAngles2 = Angle(CustomAngles.p,CustomAngles.y,0)
			view.angles = CustomAngles
			if ( ply:Alive() || IsValid( ply:GetViewEntity() ) || ply:GetViewEntity() != ply ) then
				VEye(ply,view,OkViw)
				ply.actmod_cl_tabPosAng = {view.origin,view.angles}
				return view
			end

		end

		
		if GetConVarNumber("actmod_cl_smshcam_on") ~= 4 and GetConVarNumber("actmod_cl_smshcam_on") > 0 and not (OkViw == true and aGLookAttBone ) then
			local camsp = GetConVarNumber("actmod_cl_smshcam_sp")
			CustomPos2 = LerpVector( FrameTime() * (camsp+math.Clamp(-15+math.abs(TargetOrigin:Distance(CustomPos2))*0.1,0,5)), CustomPos2, TargetOrigin )
			CustomAngles2.p = Lerp( FrameTime() * (camsp+1+math.Clamp(-13+math.abs(CustomAngles2.p - CustomAngles.p)*0.1,0,5)), CustomAngles2.p, CustomAngles.p )
			CustomAngles2.y = Lerp( FrameTime() * (camsp+1+math.Clamp(-13+math.abs(CustomAngles2.y - CustomAngles.y)*0.1,0,5)), CustomAngles2.y, CustomAngles.y )
			CustomAngles2.r = 0
			view.origin = CustomPos2
			view.angles = CustomAngles2
		else
			CustomPos2 = Vector(TargetOrigin.x,TargetOrigin.y,TargetOrigin.z)
			CustomAngles2 = Angle(CustomAngles.p,CustomAngles.y,0)
			view.origin = TargetOrigin
			view.angles = CustomAngles
		end
		VEye(ply,view,OkViw)
		ply.actmod_cl_tabPosAng = {view.origin,view.angles}
		return view
	end

	CAM.CreateMove = function( self, cmd, ply, on )
		local gIsVR = A_AM.ActMod:IsVR(ply)
		local MDir = ply:A_ActMod_GetMoveDir()
		
		if not WaitEyeOkViw then
			local atmr = not ply.ActMod_OneStart and 0 or math.Clamp( (CurTime() - (ply.ActMod_CurTStart or 0))/0.2 ,0,1)
			if math.floor(atmr) < 1 then
				local curAng = ply:GetRenderAngles()
				local GtAng = ply:EyeAngles()
				local smoothAng = LerpAngle(atmr, GtAng, Angle(0,ZCustomAngles.y,0))
				ply:SetEyeAngles(smoothAng)
			else
				WaitEyeOkViw = true
			end
		end
		

		if endless then
			if !ply.Aonpes and cmd:KeyDown( IN_DUCK ) then
				ply.Aonpes = true
				if OkViw == true then OkViw = false else OkViw = true end
			elseif ply.Aonpes and !cmd:KeyDown( IN_DUCK ) then
				ply.Aonpes = nil
			end
			
			if ply.ActMod_AddTRuh == true and (ply.ActMod_TRStopAct or 0) < CurTime() then
				ply.ActMod_TRStopAct = CurTime() + 2
			end
			if false and (ply.ActMod_TRStopAct or 0) < CurTime() and ply.ActMod_AddTRuh == true then
				ply.ActMod_TRStopAct = CurTime() + 2
				GeyOn = false
				if not ply.ActMod_Cam_SavAng then
					ply.ActMod_Cam_SavAng = true
					if OkViw == true then
						ply.ActMod_GeetAng = ply:EyeAngles()
					else
						if (not o and GetConVarNumber("actmod_cl_cam180") == 1) and is180_y == 0 and is180_x == 0 and not isCy then
							CustomAngles = CustomAngles + Angle(0,180,0)
						end
						ply.ActMod_GeetAng = CustomAngles
					end
				end
				ply.ActMod_AddTRuh_Enum = ply.ActMod_AddTRuh_Enum+1
				if ply.ActMod_AddTRuh_Enum and ply.ActMod_AddTRuh_Enum > 2 then
					if ply.ActMod_GeetAng then
						net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"CancelCamera",{ply.ActMod_GeetAng[1],ply.ActMod_GeetAng[2]}} ) net.SendToServer()
					else
						net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"CancelCamera"} ) net.SendToServer()
					end
				else
					if ply.ActMod_GeetAng then
						RunConsoleCommand("actmod_wts","wts_End",tostring(ply.ActMod_GeetAng[1]),tostring(ply.ActMod_GeetAng[2]))
					else
						RunConsoleCommand("actmod_wts","wts_End")
					end
				end
			end
		end
		
		if GeyOn == true then
			if ( !on ) then return end

			if ( PlayerLockAngles == nil ) then
				PlayerLockAngles = cmd:GetViewAngles()
				PlayerLockAngles.p = 0
				PlayerLockAngles.r = 0
			end
		
			if GetConVarNumber("actmod_sv_typmovecl") > 0 and (GetConVarNumber("actmod_sv_alowangcl") > 0 or (MDir == 1 or MDir == 2 or MDir == 5 or MDir == 8)) then
				local a,B = isserverD and 0.02 or 0.005, isserverD and 2 or 1.5
				local rft = 1.1
				if cmd:KeyDown( IN_MOVERIGHT ) then
					GRIGHT = 1
					if GRIGHT_Sped > 0 and cmd:KeyDown( IN_SPEED ) then
						GRIGHT_Sped = 0
					elseif cmd:KeyDown( IN_SPEED ) then
						GRIGHT_Sped = math.max(-B*rft*1.1,GRIGHT_Sped - 10)
					elseif cmd:KeyDown( IN_WALK ) then
						GRIGHT_Sped = math.max(-B*rft*0.2,GRIGHT_Sped - 0.8*rft*a)
					else
						GRIGHT_Sped = math.max(-B*rft*0.6,GRIGHT_Sped - 3*rft*a)
					end
				elseif cmd:KeyDown( IN_MOVELEFT ) then
					GRIGHT = 2
					if GRIGHT_Sped < 0 and cmd:KeyDown( IN_SPEED ) then
						GRIGHT_Sped = 0
					elseif cmd:KeyDown( IN_SPEED ) then
						GRIGHT_Sped = math.min(B*rft*1.1,GRIGHT_Sped + 10)
					elseif cmd:KeyDown( IN_WALK ) then
						GRIGHT_Sped = math.min(B*rft*0.2,GRIGHT_Sped + 0.8*rft*a)
					else
						GRIGHT_Sped = math.min(B*rft*0.6,GRIGHT_Sped + 3*rft*a)
					end
				else
					GRIGHT = 0
					if cmd:KeyDown( IN_SPEED ) then
						GRIGHT_Sped = 0
					else
						if GRIGHT_Sped > 0 then
							GRIGHT_Sped = math.max(0,GRIGHT_Sped - 20*rft*a*0.6)
						elseif GRIGHT_Sped < 0 then
							GRIGHT_Sped = math.min(0,GRIGHT_Sped + 20*rft*a*0.6)
						end
					end
				end
			end
			
			if MDir >= 1 then
				if GetConVarNumber("actmod_sv_typmovecl") > 0 then AScw(ply,cmd,nil,true)
					if MDir == 1 or MDir == 9 then
						GMovea = 1
					elseif MDir == 2 then
						GMovea = 2
					elseif MDir == 5 or MDir == 8 then
						if cmd:KeyDown( IN_FORWARD ) then
							GMovea = 1
							ply.AalowAnim_MForward = true
						elseif MDir == 8 and cmd:KeyDown( IN_BACK ) then
							GMovea = 2
						else
							ply.AalowAnim_MForward = false
							GMovea = 0
						end
						A_AM.ActMod:ThinkChingAni(ply)
					else
						GMovea = 0
					end
				elseif MDir == 5 or MDir == 15 then AScw(ply,cmd,1)
				elseif MDir == 6 then AScw(ply,cmd,1,true)
				elseif MDir == 7 then AScw(ply,cmd,nil,true)
				elseif MDir == 9 then AScw(ply,cmd,nil,true)
				elseif MDir == 8 then AScw(ply,cmd,2,true)
					if cmd:KeyDown( IN_FORWARD ) then
						GMovea = 1
					elseif cmd:KeyDown( IN_BACK ) then
						GMovea = 2
					else
						GMovea = 0
					end
				end
			elseif (ply.Aa_TGo_F or 0) > CurTime() then
				net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"ASTC","E_ StopFORWARD"} ) net.SendToServer()
				ply.Aa_TGo_F = CurTime()
			elseif ply.Aa_TGo_att1 then
				ply.Aa_TGo_att1 = nil
			end
			if MDir <= 0 then
				if GMovea ~= 0 then GMovea = 0 end
			elseif GetConVarNumber("actmod_sv_typmovecl") <= 0 then
				if MDir == 1 or MDir == 9 then
					GMovea = 1
				elseif MDir == 2 then
					GMovea = 2
				elseif MDir == 5 or MDir == 8 then
					if cmd:KeyDown( IN_FORWARD ) then
						GMovea = 1
					elseif MDir == 8 and cmd:KeyDown( IN_BACK ) then
						GMovea = 2
					else
						GMovea = 0
					end
				else
					GMovea = 0
				end
			end
			ply.actmod_GMovea = GMovea
			
			if (TtimUpdChkDAA or 0) < CurTime() then
				TtimUpdChkDAA = CurTime() + 0.1
				if A_AM.ActMod:A_ActMod_GPCoop( ply ) then
					ply.ActMod_DontAlwAng = true
					local atXt = ply:GetNWString("ActMod_aAng","")
					if atXt ~= "" then
						local TtXt = string.Explode("|", atXt, true)
						if TtXt and istable(TtXt) and TtXt[1] and TtXt[1] == "1" and TtXt[3] then
							PlayerLockAngles = Angle(TtXt[2],TtXt[3],0)
						end
					end
				else
					ply.ActMod_DontAlwAng = nil
				end
			end
			
			local IsUOKViw = cmd:KeyDown( IN_RELOAD ) and not OkViw == true or not cmd:KeyDown( IN_RELOAD ) and OkViw
			local SECuAng_cl = ply.ActMod_SECuAng_cl
			if IsUOKViw then
				local Rh_p_min,Rh_p_max = ply:GetPoseParameterRange("head_pitch")
				local Rh_Y_min,Rh_Y_max = ply:GetPoseParameterRange("head_yaw")
				SECuAng_cl.S_pitch = math.Clamp((SECuAng_cl.S_pitch + cmd:GetMouseY() * 0.04),Rh_p_min,Rh_p_max)
				SECuAng_cl.S_yaw = math.Clamp((SECuAng_cl.S_yaw + cmd:GetMouseX() * 0.03),Rh_Y_min,Rh_Y_max)
				sTtCam = CurTime() + 0.5
			else
				local a_TCam = math.Clamp((CurTime() - sTtCam) ,0,1)
				if a_TCam < 1 then
					SECuAng_cl.S_pitch = Lerp( math.ease.InExpo( a_TCam ), SECuAng_cl.S_pitch, 0 )
					SECuAng_cl.S_yaw = Lerp( math.ease.InExpo( a_TCam ), SECuAng_cl.S_yaw, 0 )
					SECuAng_cl.timR = CurTime() - 0.1
				else
					SECuAng_cl.S_pitch = 0
					SECuAng_cl.S_yaw = 0
				end
				LCustomAngles.pitch = math.Clamp(LCustomAngles.pitch + cmd:GetMouseY() * 0.04,-70,80)
				LCustomAngles.yaw = LCustomAngles.yaw - cmd:GetMouseX() * 0.04
				if (not o and GetConVarNumber("actmod_cl_cam180") == 1) and is180_x == 0 and is180_y == 0 then
					An180_y = math.Clamp((An180_y + cmd:GetMouseY() * 0.05),-70,80)
					An180_x = (An180_x - cmd:GetMouseX() * 0.05) % 360
					if An180_y > 40 or An180_y < -40 then is180_y = 1 else is180_y = 0 end
					if An180_x > 200 or An180_x < 160 then is180_x = 1 else is180_x = 0 end
				end
			end
			if GetConVarNumber("actmod_cl_smshcam_on") == 4 then
				if LCustomAngles.pitch ~= TiResAng1 or LCustomAngles.yaw ~= TiResAng2 then
					TiResAng = CurTime() + 0.02
					TiResAng1 = LCustomAngles.pitch
					TiResAng2 = LCustomAngles.yaw
				end
				local a_sped = math.Clamp(RealFrameTime() * (6+150*math.Clamp((CurTime() - TiResAng)/0.3 ,0,1)),0,1)
				CustomAngles.p = Lerp( a_sped, CustomAngles.p, LCustomAngles.p )
				CustomAngles.y = Lerp( a_sped, CustomAngles.y, LCustomAngles.y )
			else
				CustomAngles.pitch = LCustomAngles.pitch
				CustomAngles.yaw = LCustomAngles.yaw
			end
			if IsUOKViw and (SECuAng_cl.timRnow or 0) < CurTime() or (SECuAng_cl.timR or 0) < CurTime() then
				if not OkViw and not cmd:KeyDown( IN_RELOAD ) then SECuAng_cl.timR = CurTime() + 0.6 end
				SECuAng_cl.timRnow = CurTime() + 0.1
				if (not o and GetConVarNumber("actmod_cl_cam180") == 1) and ( is180_x == 0 and is180_y == 0 ) then
					ply.ActMod_GeetAng = CustomAngles + Angle(0,180,0)
				else
					ply.ActMod_GeetAng = CustomAngles
				end
				if ZCANbr > 2 and not isCy and ZCustomAngles ~= ply:EyeAngles() then isCy = true end
				net.Start( "A_AM.ActMod.ClToSv_Tab" ,true )
				 net.WriteTable( {"wts_SAng",SECuAng_cl.S_pitch,SECuAng_cl.S_yaw,ply.ActMod_GeetAng} )
				net.SendToServer()
			end
		
		end
		
		local GSRLAngMove = GetConVarNumber("actmod_sv_typmovecl") > 0 and not ply.ActMod_DontAlwAng and not ply.ActMod_DontAAng and GRIGHT_Sped or ply:GetNWInt("a_SRLAngMove",0)
		if ply.ActMod_OPT_VR and ply.ActMod_OPT_VR["CanMove"] then
		else
			if GeyOn == true or ply:A_ActMod_GetIsAct() then
				if gIsVR then
				elseif PlayerLockAngles then
					if GeyOn == false and ply.ActMod_GeetAng then
						cmd:SetViewAngles( Angle(ply.ActMod_GeetAng[1], ply.ActMod_GeetAng[2], 0) )
					else
						if GetConVarNumber("actmod_sv_typmovecl") > 0 then
							GSRLAngMove = GSRLAngMove * FrameTime() * 120
							if not ply.ActMod_DontAlwAng and not ply.ActMod_DontAAng then PlayerLockAngles = PlayerLockAngles + Angle(0, GSRLAngMove, 0) end
							cmd:SetViewAngles( PlayerLockAngles )
							if WaitEyeOkViw then ply:SetEyeAngles( PlayerLockAngles ) end
						else
							if WaitEyeOkViw then ply:SetEyeAngles( PlayerLockAngles + Angle(0, GSRLAngMove, 0) ) end
						end
					end
				end
			end
		end
		
		if gIsVR then
			local angles2 = vrmod.GetHMDAng(ply)
			cmd:SetViewAngles( angles2 )
			ply:SetEyeAngles( angles2 )
		elseif PlayerLockAngles and not GeyOn then
			cmd:SetViewAngles( PlayerLockAngles )
		end
		
		if GetConVarNumber("actmod_cl_sdwfix") > 0 and (ply.AAct_tFixShadow_Tim or 0) < CurTime() then
			ply.AAct_tFixShadow_Tim = CurTime() + 0.2
			local tPos = AGetAPos(ply)
			if not ply.AAct_tFixShadow_TmpSPos then ply.AAct_tFixShadow_TmpSPos = tPos end
			local GDistance = tPos:Distance(ply.AAct_tFixShadow_TmpSPos)
			ply.AAct_tFixShadow_TmpSPos = tPos
			if GDistance > 10 then
				ply.AAct_tFixShadow_Tim = CurTime() + 0.03
			end
			local tAngle = ply:EyeAngles()
			tAngle.p = 0 tAngle.r = 0
			cmd:SetViewAngles(tAngle + Angle(0,0.0001,0))
			cmd:SetViewAngles(tAngle - Angle(0,0.0001,0))
		end

		if ply.ActMod_OPT_VR and ply.ActMod_OPT_VR["CanMove"] then
		else
			cmd:ClearButtons()
			cmd:ClearMovement()
		end
		
		if ply:GetMoveType() == 2 and ply:GetObserverMode() == 0 and ( MDir == 1 or MDir == 5 or MDir == 8 or MDir == 9) then
			local Asz = ply:GetModelScale()
			if GMovea == 1 then
				GMovea_Sped = ply:GetNWInt( "A_AM.MoveSpeed" )
				ply.AalowAnim_MForward = true
			elseif GMovea == 2 then
				if ply:GetNWString("A_ActMod.Dir", "") == "zombie_run_fast" then
					GMovea_Sped = -math.min(ply:GetNWInt( "A_AM.MoveSpeed" ),40)
				else
					GMovea_Sped = -ply:GetNWInt( "A_AM.MoveSpeed" )
				end
			else
				GMovea_CTim = RealTime()
				GMovea_Sped = 0
				if ply.a_TmpMForward then ply.a_TmpMForward = nil A_AM.ActMod:ThinkChingAni(ply) end
				ply.AalowAnim_MForward = nil
			end
			if GMovea_Sped >= ply:GetWalkSpeed() then cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_SPEED)) end
			local spd = (GMovea_Sped*0.9)*Asz
			if spd < 7 then spd = spd + spd*(math.abs(Asz-1))*2.8 end
			cmd:SetForwardMove(spd)
			cmd:SetSideMove(0)
		elseif GMovea_Sped != 0 then
			GMovea_Sped = 0
		end 
		return true
	end

	return CAM
end

A_AM.ActMod.LuaCam_Done = true
