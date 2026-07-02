if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.bessys_1 = true
// A_AM.ActMod.Develop = true

A_AM.ActMod.Actoji = A_AM.ActMod.Actoji or {}
local Actoji = A_AM.ActMod.Actoji


local function A_ToMinutesSeconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	return string.format("%02d:%02d", minutes, math.floor(seconds))
end
local function A_ToMinutesSecondsCD(seconds)
	seconds = math.ceil(seconds)
	local minutes = math.floor(seconds / 60)
	local hs = math.floor(minutes / 60)
	seconds = seconds - minutes * 60
	minutes = minutes - hs * 60

	return string.format("%02d:%02d:%02d", hs, minutes, seconds)
end
local function A_ToMinutesSecondsMilliseconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	local milliseconds = math.floor(seconds % 1 * 100)

	return string.format("%02d:%02d.%02d", minutes, math.floor(seconds), milliseconds)
end

local function get_aage(tbl)
    local count = #tbl
    local sum = 0
    for i = 1, count do
        sum = sum + tbl[i]
    end
    return sum / count
end


function A_AM.ActMod:adEfFull( aent,neff, alow,unalow ,Apos,Afff )
	local ent
	if aent then
		if istable(aent) then
			ent = aent[1]
		elseif IsValid(aent) then
			ent = aent
		end
	end
	if not ent or not IsValid(ent) then return end
	for i = 0, ent:GetBoneCount() - 1 do
		local pos = ent:GetBonePosition( i )
		if ( pos == ent:GetPos() && ent:GetBoneMatrix( i ) ) then
			pos = ent:GetBoneMatrix( i ):GetTranslation()
		end
		
		if Apos and istable(Apos) then
			local aps = {0,0,0,0}
			if Apos[1] then aps[1] = Apos[1] end
			if Apos[2] then aps[2] = Apos[2] end
			if Apos[3] then aps[3] = Apos[3] end
			if Apos[4] then aps[4] = Apos[4] end
			pos = pos + pos:Angle():Forward()*aps[1] + pos:Angle():Right()*aps[2] + pos:Angle():Up()*aps[3] + Vector( 0, 0, aps[4] )
		end

		if ( ent:GetBoneName( i ) == "__INVALIDBONE__" ) then continue end
		if (alow and A_AM.ActMod:ATabData(alow, i) == false) then continue end
		if (unalow and A_AM.ActMod:ATabData(unalow, i) == true) then continue end
		if 1 == 2 and ent:GetBoneMatrix( i ) then
			cam.Start3D( EyePos(), EyeAngles() )
			for id, bone in pairs( ent:GetChildBones( i ) ) do
				local pos2 = ent:GetBonePosition( bone )
				if ( pos2 == ent:GetPos() && ent:GetBoneMatrix( bone ) ) then
					pos2 = ent:GetBoneMatrix( bone ):GetTranslation()
				end
				render.DrawLine( pos, pos2, Color( 255, 178, 64 ), false )
			end
			cam.End3D()
		end
		local ef = EffectData()
		if aent and istable(aent) and aent[2] then ef:SetEntity( ent ) end
		ef:SetOrigin( pos )
		if Afff and isnumber(Afff) then ef:SetScale( Afff ) end
		util.Effect(neff,ef)
	end
end

function A_AM.ActMod:cBonesScale( ent,vel, alow,unalow )
	if ent and vel then
		if isnumber(vel) then vel = Vector(1,1,1)*vel end
		for i = 0, ent:GetBoneCount() - 1 do
			if (alow and A_AM.ActMod:ATabData(alow, i) == false) then continue end
			if (unalow and A_AM.ActMod:ATabData(unalow, i) == true) then continue end
			ent:ManipulateBoneScale( i, vel )
		end
	end
end

function A_AM.ActMod:aBonesScale( ent,Aasize,vel,spd, alow,unalow )
	if Aasize and ent.Aasize and ent.Aasize[Aasize] and vel and spd then
		if not ent.Aasize[99] then ent.Aasize[99] = SysTime() end
		if spd == 0 then
			ent.Aasize[Aasize] = vel
		elseif spd == -1 then
			ent.Aasize[Aasize] = Lerp( SysTime() - ent.Aasize[99], ent.Aasize[Aasize], vel )
		else
			ent.Aasize[Aasize] = Lerp( FrameTime()*spd, ent.Aasize[Aasize], vel )
		end
		for i = 0, ent:GetBoneCount() - 1 do
			local mat = ent:GetBoneMatrix( i )
			if ( !mat ) then continue end
			if (alow and A_AM.ActMod:ATabData(alow, i) == false) then continue end
			if (unalow and A_AM.ActMod:ATabData(unalow, i) == true) then continue end
			ent:ManipulateBoneScale( i, Vector( 1, 1, 1 ) * ent.Aasize[Aasize] )
		end
	end
end

	
local function aSBodygroup( ent,atb )
	if IsValid(ent) and istable(atb) and not table.IsEmpty(atb) then
		for _, bg in pairs(atb) do
			if istable(bg) and (isstring(bg[1]) or isnumber(bg[1])) and isnumber(bg[2]) then
				local id, value = bg[1], bg[2]
				if isstring(id) then id = ent:FindBodygroupByName(id) end
				if id and id >= 0 then ent:SetBodygroup(id, value) end print(id, value)
			end
		end
	end
end

local function CMl( pl,Tabmd,nn )
	if table.Count(Tabmd) ~= 0 then
		local Tmd = table.Copy(Tabmd)
		local hmax = A_AM.ActMod:HMX( pl )[3]*0.0165
		if nn and nn > 0 and nn < 5 then
			if Tmd["NAtosize"] then Tmd["size"] = Tmd["size"]*hmax end
			if nn == 1 then
				if pl.AAct_mdl1 and IsValid(pl.AAct_mdl1) then
				else
					if pl.AAct_mdl1 then pl.AAct_mdl1:Remove() pl.AAct_mdl1 = nil end
					pl.AAct_mdl1 = ClientsideModel(Tmd["mdl"], RENDERGROUP_BOTH)
					if pl.AAct_mdl1 and IsValid(pl.AAct_mdl1) then
						if Tmd["Mat"] then pl.AAct_mdl1:SetMaterial(Tmd["Mat"]) end
						if Tmd["Skin"] then pl.AAct_mdl1:SetSkin(Tmd["Skin"]) end
						if Tmd["BGrp"] then aSBodygroup( pl.AAct_mdl1,Tmd["BGrp"] ) end
						pl.AAct_mdl1:SetNoDraw(true)
						pl.AAct_Tmdl1 = Tmd
					end
				end
			elseif nn == 2 then
				if pl.AAct_mdl2 and IsValid(pl.AAct_mdl2) then
				else
					if pl.AAct_mdl2 then pl.AAct_mdl2:Remove() pl.AAct_mdl2 = nil end
					pl.AAct_mdl2 = ClientsideModel(Tmd["mdl"], RENDERGROUP_BOTH)
					if pl.AAct_mdl2 and IsValid(pl.AAct_mdl2) then
						if Tmd["Mat"] then pl.AAct_mdl2:SetMaterial(Tmd["Mat"]) end
						if Tmd["Skin"] then pl.AAct_mdl2:SetSkin(Tmd["Skin"]) end
						if Tmd["BGrp"] then aSBodygroup( pl.AAct_mdl2,Tmd["BGrp"] ) end
						pl.AAct_mdl2:SetNoDraw(true)
						pl.AAct_Tmdl2 = Tmd
					end
				end
			elseif nn == 3 then
				if pl.AAct_mdl3 and IsValid(pl.AAct_mdl3) then
				else
					if pl.AAct_mdl3 then pl.AAct_mdl3:Remove() pl.AAct_mdl3 = nil end
					pl.AAct_mdl3 = ClientsideModel(Tmd["mdl"], RENDERGROUP_BOTH)
					if pl.AAct_mdl3 and IsValid(pl.AAct_mdl3) then
						if Tmd["Mat"] then pl.AAct_mdl3:SetMaterial(Tmd["Mat"]) end
						if Tmd["Skin"] then pl.AAct_mdl3:SetSkin(Tmd["Skin"]) end
						if Tmd["BGrp"] then aSBodygroup( pl.AAct_mdl3,Tmd["BGrp"] ) end
						pl.AAct_mdl3:SetNoDraw(true)
						pl.AAct_Tmdl3 = Tmd
					end
				end
			elseif nn == 4 then
				if pl.AAct_mdl4 and IsValid(pl.AAct_mdl4) then
				else
					if pl.AAct_mdl4 then pl.AAct_mdl4:Remove() pl.AAct_mdl4 = nil end
					pl.AAct_mdl4 = ClientsideModel(Tmd["mdl"], RENDERGROUP_BOTH)
					if pl.AAct_mdl4 and IsValid(pl.AAct_mdl4) then
						if Tmd["Mat"] then pl.AAct_mdl4:SetMaterial(Tmd["Mat"]) end
						if Tmd["Skin"] then pl.AAct_mdl4:SetSkin(Tmd["Skin"]) end
						if Tmd["BGrp"] then aSBodygroup( pl.AAct_mdl4,Tmd["BGrp"] ) end
						pl.AAct_mdl4:SetNoDraw(true)
						pl.AAct_Tmdl4 = Tmd
					end
				end
			end
		end
	end
end

function A_AM.ActMod:AddCrMdl( pl,str,Tmd1,Tmd2,Tmd3,Tmd4 )
	if pl and IsValid(pl) then
		pl.actmodstr = str
		CMl( pl,Tmd1,1 )
		CMl( pl,Tmd2,2 )
		CMl( pl,Tmd3,3 )
		CMl( pl,Tmd4,4 )
	end
end

function A_AM.ActMod:RemoveCrMdl( pl,t )
	if (not IsValid(pl.AAct_mdl1) and not IsValid(pl.AAct_mdl2) and not IsValid(pl.AAct_mdl3) and not IsValid(pl.AAct_mdl4) or t == "*") then
		if pl.actmodstr then
			pl.actmodstr = nil
		end
	end
	if (t == "mdl1" or t == "*") and pl.AAct_mdl1 and IsValid(pl.AAct_mdl1) then
		pl.AAct_mdl1:Remove()
		pl.AAct_mdl1 = nil
		pl.AAct_Tmdl1 = nil
	end 
	if (t == "mdl2" or t == "*") and pl.AAct_mdl2 and IsValid(pl.AAct_mdl2) then
		pl.AAct_mdl2:Remove()
		pl.AAct_mdl2 = nil
		pl.AAct_Tmdl2 = nil
	end 
	if (t == "mdl3" or t == "*") and pl.AAct_mdl3 and IsValid(pl.AAct_mdl3) then
		pl.AAct_mdl3:Remove()
		pl.AAct_mdl3 = nil
		pl.AAct_Tmdl3 = nil
	end 
	if (t == "mdl4" or t == "*") and pl.AAct_mdl4 and IsValid(pl.AAct_mdl4) then
		pl.AAct_mdl4:Remove()
		pl.AAct_mdl4 = nil
		pl.AAct_Tmdl4 = nil
	end 
end



concommand.Add("actmod_menu", function(ply, cmd, args) if ply.CKeyAct_UseMenu then ply.CKeyAct_UseMenu = nil else ply.CKeyAct_UseMenu = true end end)
concommand.Add("+actmod_menu", function(ply, cmd, args) if ply.CKeyAct_UseMenu != true then ply.CKeyAct_UseMenu = true end end)
concommand.Add("-actmod_menu", function(ply, cmd, args) if ply.CKeyAct_UseMenu then ply.CKeyAct_UseMenu = nil end end)

if !ConVarExists("actmod_cl_allowkey") then CreateClientConVar("actmod_cl_allowkey", 0, true, false) end
if !ConVarExists("actmod_cl_allowkey2") then CreateClientConVar("actmod_cl_allowkey2", 0, true, false) end
if !ConVarExists("actmod_key_iconmenu") then CreateClientConVar("actmod_key_iconmenu", tostring(KEY_H), true, false) end
if !ConVarExists("actmod_keyo_h") then CreateClientConVar("actmod_keyo_h", tostring(KEY_LALT), true, false) end
if !ConVarExists("actmod_keyo_h2") then CreateClientConVar("actmod_keyo_h2", tostring(KEY_X), true, false) end
if !ConVarExists("actmod_keyo_1") then CreateClientConVar("actmod_keyo_1", tostring(KEY_1), true, false) end
if !ConVarExists("actmod_keyo_2") then CreateClientConVar("actmod_keyo_2", tostring(KEY_2), true, false) end
if !ConVarExists("actmod_keyo_3") then CreateClientConVar("actmod_keyo_3", tostring(KEY_3), true, false) end
if !ConVarExists("actmod_keyo_4") then CreateClientConVar("actmod_keyo_4", tostring(KEY_4), true, false) end
if !ConVarExists("actmod_keyo_5") then CreateClientConVar("actmod_keyo_5", tostring(KEY_5), true, false) end
if !ConVarExists("actmod_keyo_6") then CreateClientConVar("actmod_keyo_6", tostring(KEY_1), true, false) end
if !ConVarExists("actmod_keyo_7") then CreateClientConVar("actmod_keyo_7", tostring(KEY_2), true, false) end
if !ConVarExists("actmod_keyo_8") then CreateClientConVar("actmod_keyo_8", tostring(KEY_3), true, false) end
if !ConVarExists("actmod_keyo_9") then CreateClientConVar("actmod_keyo_9", tostring(KEY_4), true, false) end
if !ConVarExists("actmod_keyo_10") then CreateClientConVar("actmod_keyo_10", tostring(KEY_5), true, false) end

local a_actmodkey_wassed = false
A_AM.ActMod.a_actmod_wassed = false

local function PUpdateColcted(pl)
if !pl or !IsValid(pl) or !pl.i_colcted then return end
    table.insert(pl.i_colcted.fps, (1 / FrameTime()))
    table.insert(pl.i_colcted.ping, LocalPlayer():Ping())
end
local function PResetColcted(pl)
    pl.i_colcted = { fps = {},ping = {} }
end PResetColcted(LocalPlayer())


local function trRemoveSoinds(pl,A_aSo)
	if IsValid(pl) and isstring(A_aSo) then
		local SL1,SL2 = "Sond_Lc","SMdl"
		local A_So
		if A_aSo == "2" then A_So = pl.AAct_S2
		elseif A_aSo == "3" then A_So = pl.AAct_S3
		else A_So = pl.AAct_S1 end
		if A_So and istable(A_So) then
			if A_So["Sond_Lc"] then
				print("CallOnRemove[-5-][Sond_Lc]:",A_So["Sond_Lc"]["_1"] ,type(A_So["Sond_Lc"]["_1"]) ,IsValid(A_So["Sond_Lc"]["_1"]))
				if type(A_So["Sond_Lc"]["_1"]) == "CSoundPatch" then A_So["Sond_Lc"]["_1"]:Stop() A_So["Sond_Lc"]["_1"] = nil end
			end
		end
		if A_So and A_So[SL1] and A_So[SL1][SL2] and IsValid(A_So[SL1][SL2]) then A_So[SL1][SL2]:Remove() end
		A_So = nil
		if A_aSo == "2" then
			if pl.AAct_S2 and pl.AAct_S2[SL1] and pl.AAct_S2[SL1][SL2] and IsValid(pl.AAct_S2[SL1][SL2]) then pl.AAct_S2[SL1][SL2]:Remove() end
			pl.AAct_S2 = nil
		elseif A_aSo == "3" then
			if pl.AAct_S3 and pl.AAct_S3[SL1] and pl.AAct_S3[SL1][SL2] and IsValid(pl.AAct_S3[SL1][SL2]) then pl.AAct_S3[SL1][SL2]:Remove() end
			pl.AAct_S3 = nil
		else
			if pl.AAct_S1 and pl.AAct_S1[SL1] and pl.AAct_S1[SL1][SL2] and IsValid(pl.AAct_S1[SL1][SL2]) then pl.AAct_S1[SL1][SL2]:Remove() end
			pl.AAct_S1 = nil
		end
	end
end

local function LLSond(pl,A_So,A_n,GtXt)
	if A_So and istable(A_So) then
		local gCurTim = CurTime()
		local tS = math.Clamp(100 * A_AM.ActMod:GetFinalTimeScale(), 0, 255)
		if A_So["Sond_Lc"] then
			if A_n and A_So["Sond_Lc"]["GtXt"] and A_So["Sond_Lc"]["GtXt"] ~= GtXt then
				trRemoveSoinds(pl,A_n)
			else
				if pl ~= LocalPlayer() and A_So["Sond_Lc"]["SMdl"] and IsValid(A_So["Sond_Lc"]["SMdl"]) then
					A_So["Sond_Lc"]["SMdl"]:SetPos( A_AM.ActMod:GetEntityBoneCenter(pl) )
				end
				if A_n and A_So["Sond_Lc"]["TimeEnd"] and A_So["Sond_Lc"]["TimeEnd"] > 0 and A_So["Sond_Lc"]["TimeEnd"] < gCurTim then
					A_AM.ActMod:C_StopSond(pl,A_n)
				else
					if (pl.actmod_tChangeVP or 0) < gCurTim or pl.actmod_tChangetS and pl.actmod_tChangetS ~= tS then
						pl.actmod_tChangeVP = gCurTim + 0.2
						pl.actmod_tChangetS = tS
						local kSond = A_So["Sond_Lc"]["_1"]
						if A_So["Sond_Lc"]["Volume"] then
							if kSond then
								local cSond,volume = 1,math.Remap( A_So["Sond_Lc"]["Volume"], 0, 100, 0, 1 )
								if pl == LocalPlayer() then
									cSond = math.Remap( GetConVarNumber("actmod_cl_soundlevel"), 0, 100, 0, 1 )
								else
									cSond = math.Remap( math.min(GetConVarNumber("actmod_cl_soundlevelother"),GetConVarNumber("actmod_sv_soundlevel")), 0, 100, 0, 1 )
								end
								kSond:PlayEx(math.min(volume,cSond),tS)
							end
						else
							if kSond then kSond:ChangePitch(tS) end
						end
					end
				end
			end
		end
	end
end

function A_AM.ActMod:aPlyEmot(pl,atXt,tst)
	if pl and IsValid(pl) then
		hook.Run( "ActMod_cl_RunaPlyEmot" , pl,atXt,tst )
		A_AM.ActMod:AA_RemoveAdd( pl,true )
		A_AM.ActMod:RemoveCrMdl( pl,"*" )
		local GEIx = pl:EntIndex()
		AAct_STOPSOUND(pl)
		pl.aCSound2 = nil pl.AActNFfct = 0
		pl.rOn_MForward = 0
		pl.ActMod_ReaginRunAct = nil
		pl.DEFiCycleWS = nil
		pl.ActMod_CurTRun = CurTime()
		if pl == LocalPlayer() then pl.actmod_AMholdNext = 0 pl.actmod_AMtimeNext = 0 end
		if pl.ActMod_Avs__a2_1_ing then pl.ActMod_Avs__a2_1_ing = nil pl.ActMod_Avs__a2_1_time = nil end
		if pl.ActMod_Avs__a3_6_ing then pl.ActMod_Avs__a3_6_ing = nil pl.ActMod_Avs__a3_6_time = nil end
		if timer.Exists( "ActModAnimLSW_|".. GEIx ) then timer.Remove( "ActModAnimLSW_|".. GEIx ) end
		if timer.Exists( "ActModAnimSSW_|".. GEIx ) then timer.Remove( "ActModAnimSSW_|".. GEIx ) end
		if not pl.ActMod_OneStart then
			pl.ActMod_OneStart = true
			pl.ActMod_CurTStart = CurTime()
		end
		if pl.aSysTab["OneStart1_ID"] ~= "" then
			local Tta = string.Explode("|", pl.aSysTab["OneStart1_ID"], true)
			if Tta and istable(Tta) and Tta[1] then aOld = Tta[1] end
		end
		local atXtOld = pl:GetNWString("A_ActMod.OneStart1","")
		atXt = atXt or atXtOld
		pl.aSysTab["RNBER"] = pl.aSysTab["RNBER"] +1
		pl.aSysTab["OneStart1_ID"] = atXt
		pl.aSysTab["OneStart1"] = atXt
		pl.aaBThinStrt = nil
		pl:SetCycle( 0 )
		if atXt ~= "" then
			local TtXt = string.Explode("|", atXt, true)
			if TtXt and istable(TtXt) and TtXt[2] then
				if TtXt[1] == aOld then pl:ResetSequenceInfo() end
				local Tab1,Tab2,rrr,SRdw = {"",0,0,0},{0,0,0,0,0},0,""
				pl.aSysTab["OneStart3_ID"] = tostring("0|".. TtXt[2])
				if TtXt[16] ~= "" then
					local aty = tonumber(TtXt[16])
					if aty > 1 then SRdw = aty end
				end
				if pl == LocalPlayer() then
					A_AM.ActMod:SetupStartAct()
					A_AM.ActMod:A_StCamer(TtXt[15] and isstring(TtXt[15]) and string.sub( TtXt[15], 1,1 ) == "3")
				end
				if TtXt[3] and TtXt[6] then Tab1 = {TtXt[3],TtXt[4],TtXt[5],TtXt[6]} end
				if TtXt[7] and TtXt[11] then Tab2 = {TtXt[7],TtXt[8],TtXt[9],TtXt[10],TtXt[11]} end
				if TtXt[1] and TtXt[2] then
					pl.ActMod_TextNameAct = A_AM.ActMod:ReNameAct(A_AM.ActMod:ReString(TtXt[1]))
					pl.ActMod_tActGetNJoing = nil
					if TtXt[1] ~= "" then
						local aTab = A_AM.ActMod.GTabActCoop[TtXt[1]]
						if aTab and aTab["AlPly"] and aTab["AlPly"] then pl.ActMod_tActGetNJoing = aTab["AlPly"] end
					end
					hook.Run( "ActMod_cl_StartAniAct_B" , pl,TtXt[1],tst )
					A_AM.ActMod:StartAniAct( pl,{TtXt[1],SRdw},tobool(rrr),Tab1,Tab2,nil,TtXt[15] )
					hook.Run( "ActMod_cl_StartAniAct_A" , pl,TtXt[1],tst )
				end
			end
		end
	end
end
function A_AM.ActMod:aStpEmot(pl)
	pl.aaB22tat = 0
	pl.aSysTab["RNBER"] = pl.aSysTab["RNBER"] +1
	pl.aSysTab["OneStart2_ID"] = pl:GetNWString("A_ActMod.OneStart2","")
	pl.aSysTab["OneStart2"] = pl:GetNWString("A_ActMod.OneStart2","")
	local args = {
		[1] = "wtc_End"
		,[2] = pl:EntIndex()
	}
	A_AM.ActMod:Commt_Cl(pl,args)
	if pl:A_ActMod_GetIsAct() then net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"EndActSV"} ) net.SendToServer() end
end
function A_AM.ActMod:aPlyGer(pl,atXt,TtXt)
	if isstring(atXt) and atXt ~= "" and istable(TtXt) and isstring(TtXt[1]) and TtXt[1] ~= "" and TtXt[2] then
		pl.aSysTab["OneStart6_ID"] = atXt
		pl.aSysTab["OneStart6"] = atXt
		if A_AM.ActMod.GestureSystem and A_AM.ActMod.GestureSystem.PlayGesture then
			if TtXt[1] == "._" then
				A_AM.ActMod.GestureSystem:StopAllGestures(pl, (TtXt[3] and tonumber(TtXt[3]) or 0.25))
			else
				local NAct = TtXt[1]
				local GTabActO = A_AM.ActMod.GTabActO[TtXt[1]]
				local G_TEnd,G_In,G_Out,G_Speed,G_Cycle,G_Weight,G_Mat
				if istable(GTabActO) then
					if GTabActO.RNAnim then NAct = GTabActO.RNAnim end
					if GTabActO.G_In then G_In = GTabActO.G_In end
					if GTabActO.G_Out then G_Out = GTabActO.G_Out end
					if GTabActO.G_TEnd then G_TEnd = GTabActO.G_TEnd end
					if GTabActO.G_Rate then G_Speed = GTabActO.G_Rate end
					if GTabActO.G_Cycle then G_Cycle = GTabActO.G_Cycle end
					if GTabActO.G_Weight then G_Weight = GTabActO.G_Weight end
				end
				if TtXt[1] ~= "" and TtXt[1] ~= "nil" then G_Mat = A_AM.ActMod:RvString(TtXt[1]) ..".png" end
				A_AM.ActMod.GestureSystem:PlayGesture(pl, {animation = NAct ,speed = G_Speed or 1 ,cycle = G_Cycle ,weight = G_Weight ,duration = G_TEnd ,fadeIn = G_In ,fadeOut = G_Out ,mat = G_Mat} )
			end
		end
	end
end


function A_AM.ActMod:aLLPly(ply)
	for k, pl in player.Iterator() do
		if not IsValid(pl) then continue end
		if not pl.aSysTab then
			pl.aSysTab = {
				["OneStart1"] = "_",["OneStart1_ID"] = "_" ,["OneStart2"] = "_",["OneStart2_ID"] = "_" ,["OneStart3"] = "_",["OneStart3_ID"] = "_"
				,["OneStart6"] = "_",["OneStart6_ID"] = "_" ,["OneStart7"] = "_" ,["OneStart7_ID"] = "_" ,["RNBER"] = 0
			}
		end
		if not pl.aSysTab["OneStart6_ID"] then
			pl.aSysTab["OneStart6"] = "_" pl.aSysTab["OneStart6_ID"] = "_" pl.aSysTab["OneStart7"] = "_" pl.aSysTab["OneStart7_ID"] = "_"
		end
		if pl:A_ActMod_GetIsAct() then
			if pl.aSysTab and pl.aSysTab["OneStart1_ID"] ~= pl:GetNWString("A_ActMod.OneStart1","") then
				local atXt = pl:GetNWString("A_ActMod.OneStart1","")
				if atXt ~= "" then
					local TtXt = string.Explode("|", atXt, true)
					if TtXt and istable(TtXt) and TtXt[2] then
						local TtXt_13
						if TtXt[13] then TtXt_13 = tonumber(TtXt[13]) end
						if isnumber(TtXt_13) and TtXt_13 > 0 then pl.aaBThinStrt = TtXt_13 else pl.aaBThinStrt = nil end
						if ( pl.aaBThinStrt and pl.aaBThinStrt < CurTime() or not pl.aaBThinStrt ) then
							A_AM.ActMod:aPlyEmot(pl)
						end
					end
				end
			end
			if pl.aSysTab and pl.aSysTab["OneStart3_ID"] ~= pl:GetNWString("A_ActMod.OneStart3","") then
				local atXt = pl:GetNWString("A_ActMod.OneStart3","")
				if atXt ~= "" then
					local TtXt = string.Explode("|", atXt, true)
					if TtXt and istable(TtXt) and TtXt[2] ~= "" then
						if (pl.aaBThinStrt and pl.aaBThinStrt < CurTime() or not pl.aaBThinStrt) then
							pl.aSysTab["OneStart3_ID"] = atXt
							pl:SetCycle( tonumber(TtXt[1]) )
						end
					end
				end
			end
			
			local GtXt = pl:GetNWString( "A_ActMod.TmpDir" ,"" )
			LLSond(pl,pl.AAct_S1,"1",GtXt)
			LLSond(pl,pl.AAct_S2,"2",GtXt)
			LLSond(pl,pl.AAct_S3,"3",GtXt)
			
			A_AM.ActMod:aDrwnMDLs( pl )
		else
			if pl.aSysTab and pl.aSysTab["OneStart2_ID"] ~= pl:GetNWString("A_ActMod.OneStart2","") then
				if not pl:A_ActMod_GetIsAct() then
					A_AM.ActMod:aStpEmot(pl)
				elseif ( pl.aaB22tit or 0) < CurTime() then
					pl.aaB22tit = CurTime() + 0.2
					if not pl.aaB22tat then pl.aaB22tat = 0 end
					if pl.aaB22tat > 10 then
						A_AM.ActMod:aStpEmot(pl)
						else
						pl.aaB22tat = pl.aaB22tat +1
					end
				end
			end
			
			if pl.AAct_S1 and istable(pl.AAct_S1) then trRemoveSoinds(pl,"1") end
			if pl.AAct_S2 and istable(pl.AAct_S2) then trRemoveSoinds(pl,"2") end
			if pl.AAct_S3 and istable(pl.AAct_S3) then trRemoveSoinds(pl,"3") end
			
		end
		
		if pl.aSysTab and pl.aSysTab["OneStart6_ID"] ~= pl:GetNWString("A_ActMod.OneStart6","") then
			local atXt = pl:GetNWString("A_ActMod.OneStart6","")
			if atXt ~= "" then
				local TtXt = string.Explode("|", atXt, true)
				if TtXt and istable(TtXt) and TtXt[1] ~= "" and TtXt[2] then
					local TtXt_2
					if TtXt[2] then TtXt_2 = tonumber(TtXt[2]) end
					if (pl.aaGThinStrt and pl.aaGThinStrt < CurTime() or not pl.aaGThinStrt) then
						if isnumber(TtXt_2) and TtXt_2 > 0 then pl.aaGThinStrt = TtXt_2 else pl.aaGThinStrt = nil end
						A_AM.ActMod:aPlyGer(pl,atXt,TtXt)
					end
				end
			end
		end
		if A_AM.ActMod.SpSysGesture then A_AM.ActMod.GestureSystem:UpdateGestures(pl) end
	end
end

local Lakey = input.LookupBinding("+actmod_menu")
local Lakey_t = CurTime() + 5
local LkEm = Lakey and input.GetKeyCode(Lakey) or -1
function A_AM.ActMod:Think(ply)
	if not IsValid(ply) then return end
	A_AM.ActMod:aLLPly(ply)

	if (ply.actmod_tiupLookTPly or 0) < CurTime() then
		ply.actmod_tiupLookTPly = CurTime() + 0.3
		local Pl2 = A_AM.ActMod:aGetLookTPly( ply )
		if Pl2 and IsValid(Pl2) and Pl2:Alive() and Pl2:GetObserverMode() == 0 and Pl2:A_ActModASync() then
			ply.actmod_tiupLookTPly = CurTime() + 0.01
			ply.ActMod_TSndJ_LookTPly = Pl2
		else
			ply.actmod_tiupLookTPly = CurTime() + 0.2
			ply.ActMod_TSndJ_LookTPly = nil
		end
		if not timer.Exists( "A_AM_RetChfg" ) then A_AM.ActMod:ARTmrRCh() end
	end
	if (ply.ToPnext_update or 0) > CurTime() then
		PUpdateColcted(ply)
		if (ply.Pnext_update or 0) < CurTime() then ply.Pnext_update = CurTime() + 0.2
			ply.ATT_Pi_fps = math.Round(get_aage(ply.i_colcted.fps))
			ply.ATT_Pi_ping = math.Round(get_aage(ply.i_colcted.ping))
			PResetColcted(ply)
		end
	end

	local aIsAct = ply:A_ActMod_GetIsAct()
	if aIsAct and A_AM.ActMod.a_actmod_wassed == false then
		A_AM.ActMod.a_actmod_wassed = true
	elseif !aIsAct and A_AM.ActMod.a_actmod_wassed == true then
		if not aIsAct then
			A_AM.ActMod.a_actmod_wassed = false
			ply.bTNoIsAct = 0
		elseif (ply.aTNoIsAct or 0) > CurTime() then
			ply.aTNoIsAct = CurTime() + 0.4
			if not ply.bTNoIsAct then ply.bTNoIsAct = 0 end
			if ply.bTNoIsAct > 6 then
				A_AM.ActMod.a_actmod_wassed = false
				ply.bTNoIsAct = 0
				net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"CancelCamera"} ) net.SendToServer()
			else
				ply.bTNoIsAct = ply.bTNoIsAct +1
			end
		end
	end
	if GetConVarNumber("actmod_sv_a_move") ~= 0 and (ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT)) then ply.ActMod_TimMenRe = CurTime() + 0.5 end

	if (ply == LocalPlayer()) and not gui.IsGameUIVisible() and not gui.IsConsoleVisible() then
		if Lakey_t < CurTime() then
			Lakey_t = CurTime() + 2
			Lakey = input.LookupBinding("+actmod_menu")
			if Lakey then LkEm = input.GetKeyCode(Lakey) end
		end
		local IGkey = false
		if Lakey and LkEm and LkEm ~= -1 and input.IsKeyDown(LkEm) then IGkey = true end
		if (IGkey or input.IsKeyDown(GetConVar("actmod_key_iconmenu"):GetInt()) or ply.CKeyAct_UseMenu == true) then
			if not vgui.GetKeyboardFocus() then
				if a_actmodkey_wassed == false and !(ply.ActMod_UseMenu or ply.GameCaC_UseMenu or ply.PutMark_UseMenu) then 
					if GetConVar("actmod_sv_enabled"):GetBool() then
						if IsValid(Actoji.Frame) then
						else
							Actoji:Open( ply.CKeyAct_UseMenu , GetConVarNumber("actmod_cl_vr_tst") > 1 or A_AM.ActMod:IsVR(ply) )
							ply.ActMod_cl_TOMenu = CurTime() + 0.25
						end
					else
						A_AM.ActMod:SP_iError(ply,"nallow")
					end
				end
			end
			a_actmodkey_wassed = true
		else
			if a_actmodkey_wassed == true and IsValid(Actoji.Frame) and !Actoji.OnDfind and (GetConVarNumber("actmod_cl_smartomenu") ~= 0 and (ply.ActMod_cl_TOMenu or 0) < CurTime() or GetConVarNumber("actmod_cl_smartomenu") == 0) then Actoji:Close() end
			a_actmodkey_wassed = false
		end
		if a_actmodkey_wassed == true and (IGkey or input.IsKeyDown(GetConVar("actmod_key_iconmenu"):GetInt())) and IsValid(Actoji.Frame) and ply.CKeyAct_UseMenu then ply.CKeyAct_UseMenu = false end
	else
		if (a_actmodkey_wassed == true or GetConVarNumber("actmod_cl_smartomenu") ~= 0) and IsValid(Actoji.Frame) and !Actoji.OnDfind then Actoji:Close() ply.CKeyAct_UseMenu = false end
		a_actmodkey_wassed = false
	end
	if ((A_AM.ActMod.A_ActMod_RedyUse_Num or 0) ~= 100 or not A_AM.ActMod.A_ActMod_RedyUse) and ply.Aa_TimeFiledLod and ply.Aa_TimeFiledLod < CurTime() then
		print( "\n*********** Time FiledLod ***********" )
		print( " ActMod> Failed to load" )
		print( "-- A_ActMod_RedyUse_Num :",A_AM.ActMod.A_ActMod_RedyUse_Num )
		print( "-- A_ActMod_RedyUse :",A_AM.ActMod.A_ActMod_RedyUse )
		print( "*********** Time FiledLod ***********\n" )
		ply.Aa_TimeFiledLod = CurTime() + 30
		A_AM.ActMod:ClRestuo()
	end
	if !ply.AA_GThinktOne then
		ply.AA_GThinktOne = true
		A_AM.ActMod.Sutep_Done2 = true
		A_AM.ActMod.Sutep_Done3 = true
		net.Start( "A_AM.ActMod.ClToSv_Tab" )
		 net.WriteTable( {"ActMod.CToS_ST","CToS_",{"wts_SCTS","AddThink_Ply"}} )
		net.SendToServer()
	end
	if ply.ActMod_AddTRuh == true and (ply.ActMod_TRStopAct or 0) > CurTime() and (ply.ActMod_TTRStopAct or 0) < CurTime() then
		ply.ActMod_TTRStopAct = CurTime() + 3
		ply:ConCommand("actmod_wts wts_End TrStop [".. ply:GetNWString("A_ActMod.OneStart1","") .."]\n")
	end
end



local function A_ResetBonePositions(pl,ts,ta,tp)
	if (!pl:GetBoneCount()) then return end
	for i=0, pl:GetBoneCount() do
		if ts == true then pl:ManipulateBoneScale( i, Vector(1, 1, 1) ) end
		if ta == true then pl:ManipulateBoneAngles( i, Angle(0, 0, 0) ) end
		if tp == true then pl:ManipulateBonePosition( i, Vector(0, 0, 0) ) end
	end
end

function A_AM.ActMod:A_StCamer(o)
	local ply = LocalPlayer()
	if IsValid(ply) and A_AM.ActMod.LuaCam then
		if not ply.aactmod_camzm then ply.aactmod_camzm = 0 end
		A_ResetBonePositions(ply,true,true,true)
		if AnimationSWEP and ply:GetNWBool("animationStatus") then ply:SetNWBool("animationStatus", false) ply:SetNWInt("deactivateOnMove", 0) end
		A_AM.ActMod.TauntCamera = A_AM.ActMod.TauntCamera or A_AM.ActMod:CreateTauntCamera( true ,ply ,o )
	end
end


function A_AM.ActMod:cl_AdJoing( ply,ply2,TPosAng )
	if GetConVarNumber("actmod_sv_alowdsyn") > 0 then
		local args = {
			[1] = "SToC_AJoing"
			,[2] = ply:EntIndex()
			,[3] = ply2:EntIndex()
			,[4] = TPosAng
		}
		A_AM.ActMod:Commt_Cl(ply,args)
	end
end



local function Tast_Precache(pch,typ)
	local aa1,aa2 = 0,0
	for name, filename in pairs(file.Find(pch..(typ == "model" and "/*.mdl" or "/*.*") , "GAME")) do
		if typ == "sound" then
			util.PrecacheSound(pch .."/".. string.lower(filename))
			aa1 = aa1+1
			local soundid = CreateSound(LocalPlayer(), string.gsub(pch, "sound/", "",1) .."/".. filename)
			if soundid then
				soundid:SetSoundLevel(10)
				soundid:PlayEx(1,100)
				soundid:Stop() soundid = nil
			end
		end
		if typ == "model" then
			local entity = ClientsideModel(pch .."/".. filename, RENDERGROUP_BOTH)
			if entity and IsValid(entity) then
				entity:SetNoDraw( true ) entity:Remove()
			end
		end
	end
end
local function Tast_PrecacheMaterial(pch,tyx,typ)
	if A_AM.ActMod.tastPMat and IsValid(A_AM.ActMod.tastPMat) then A_AM.ActMod.tastPMat:Remove() end
	local Thh = 10
	A_AM.ActMod.tastPMat = vgui.Create("DLabel")
	local Panel = A_AM.ActMod.tastPMat
	Panel:SetSize( 570, 550 ) Panel:SetAlpha(0.1)
	Panel.Paint = function ( s, w, h ) draw.RoundedBox( 10, 0, 0, w, h, Color(50,100,150,255) ) end

	Panel.Scroll = vgui.Create( "DScrollPanel", Panel )
	Panel.Scroll:SetPos( 5, 5 )
	Panel.Scroll:SetSize( Panel:GetWide()-10, Panel:GetTall()-10 )
	Panel.Scroll.Paint = function ( s, w, h ) end
	local b = Panel.Scroll:GetVBar() function b.btnUp:Paint( w, h ) end function b.btnDown:Paint( w, h ) end
	function b:Paint( w, h ) draw.RoundedBox( 0, w/2-2, 0, 5, h, Color( 0, 0, 0, 50 ) ) end
	function b.btnGrip:Paint( w, h ) draw.RoundedBox( 4, w/2-3, 0, 6, h, Color( 0, 0, 0, 200 ) ) end
	
	local AScale = 15
	local Buttons = {}
	Panel.List = vgui.Create( "DIconLayout", Panel.Scroll )
	Panel.List:SetPos( 0, 0 ) Panel.List:SetSize( Panel.Scroll:GetWide(), Panel.Scroll:GetTall() )
	Panel.List:SetSpaceY( AScale/4 ) Panel.List:SetSpaceX( AScale/4 )
	
	local function MakeaPanel(Name)
		Panel.ListItem = Panel.List:Add( "DPanel" )
		table.insert(Buttons, Panel.ListItem)
		Panel.ListItem:SetSize( AScale, AScale )
		Panel.ListItem:SetText("")
		Panel.ListItem.file = Name
		local ttmp
		if typ then ttmp = Material(pch.."/"..Name) else ttmp = Material(pch.."/"..Name, "noclamp smooth") end
		Panel.ListItem.Material = ttmp
		Panel.ListItem.Paint = function ( s, w, h )
			if !s.Material then return end
			surface.SetDrawColor(color_white)
			surface.SetMaterial( s.Material )
			surface.DrawTexturedRect(0, 0, w, h)
		end
		ttmp = nil
	end

	local Actimenu = {}
	for _,v in pairs(file.Find( typ and ("materials/"..pch.."/*.vmt") or ("materials/"..pch.."/*.png"), "GAME" )) do
		if !table.HasValue(Actimenu, v) then
		if tyx then
			local si_Gmod_Taunt = A_AM.ActMod:ATabData(A_AM.ActMod.ActGmod, A_AM.ActMod:ReString(v)) == true
			local si_AM4_Amod = (string.find(v, "amod_") or string.find(v, "amod_am4_") or string.find(v, "amod_m_")) and not string.find(v, "amod_pubg_") and not string.find(v, "amod_mixamo_") and not string.find(v, "amod_mmd_") and not string.find(v, "amod_fortnite_")
			local si_AM4_PUBG = string.find(v, "amod_pubg_")
			local si_AM4_Mixamo = string.find(v, "amod_mixamo_")
			local si_AM4_MMD = string.find(v, "amod_mmd_")
			local si_AM4_Fortnite = string.find(v, "amod_fortnite_")
			if tyx == "taunt_" and si_Gmod_Taunt then table.insert(Actimenu, v)
			elseif tyx == "amod_" and si_AM4_Amod then table.insert(Actimenu, v)
			elseif tyx == "amod_pubg_" and si_AM4_PUBG then table.insert(Actimenu, v)
			elseif tyx == "amod_mixamo_" and si_AM4_Mixamo then table.insert(Actimenu, v)
			elseif tyx == "amod_mmd_" and si_AM4_MMD then table.insert(Actimenu, v)
			elseif tyx == "amod_fortnite_" and si_AM4_Fortnite then table.insert(Actimenu, v)
			end
		else
			table.insert(Actimenu, v) end
		end
	end
	for k,v in pairs(Actimenu or {}) do MakeaPanel(v) end Actimenu = nil
	return Panel
end

local function Set_Seq_restuo(Tabs)
	net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"ClToSv_restuo",Tabs} ) net.SendToServer()
end
local function Get_net_NWBool()
	net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"ClToSv_NWBool"} ) net.SendToServer()
end

function A_AM.ActMod:Tast_SvToCl_restuo( ply,FaTime )
	if IsValid( ply ) then
		ply.Aa_TimeFiledLod = CurTime() + 30
		A_AM.ActMod.A_ActMod_RedyUse = false
		A_AM.ActMod.A_ActMod_RedyUse_Num = 0
		local bF = A_AM.ActMod.Settings["IconsActs"]
		local au = "aStupActMod_".. ply:EntIndex()
		if timer.Exists( au ) then timer.Remove( au ) end
		A_AM.ActMod.GetMSS_Tab_cl = A_AM.ActMod:aRSeq()
		
		local function TC_c3()
			if timer.Exists( au ) then timer.Remove( au ) end
			timer.Create(au,0.3,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 66
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 67
				ply.Tasti = Tast_PrecacheMaterial(bF,"taunt_")
			timer.Create(au,0.2,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 69
				if IsValid(ply.Tasti) then ply.Tasti:Remove() ply.Tasti = nil end
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 70
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 71
				ply.Tasti = Tast_PrecacheMaterial(bF,"amod_")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 75
				if IsValid(ply.Tasti) then ply.Tasti:Remove() ply.Tasti = nil end
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 76
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 77
				ply.Tasti = Tast_PrecacheMaterial(bF,"amod_pubg_")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 79
				if IsValid(ply.Tasti) then ply.Tasti:Remove() ply.Tasti = nil end
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 80
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 81
				ply.Tasti = Tast_PrecacheMaterial(bF,"amod_mixamo_")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 83
				if IsValid(ply.Tasti) then ply.Tasti:Remove() ply.Tasti = nil end
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 84
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 85
				ply.Tasti = Tast_PrecacheMaterial(bF,"amod_mmd_")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 87
				if IsValid(ply.Tasti) then ply.Tasti:Remove() ply.Tasti = nil end
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 88
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 89
				ply.Tasti = Tast_PrecacheMaterial(bF,"amod_fortnite_")
			timer.Create(au,0.1,1,function() if IsValid(ply) then
				if IsValid(ply.Tasti) then ply.Tasti:Remove() ply.Tasti = nil end A_AM.ActMod.A_ActMod_RedyUse_Num = 90
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 91
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 92
				ply.Tasti = Tast_PrecacheMaterial("actmod/imenu")
			timer.Create(au,0.2,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 94
				if IsValid(ply.Tasti) then ply.Tasti:Remove() ply.Tasti = nil end
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 95
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 96
				ply.Tasti = Tast_PrecacheMaterial("actmod/eff_particle",nil,true)
			timer.Create(au,0.2,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 99
				if IsValid(ply.Tasti) then ply.Tasti:Remove() ply.Tasti = nil end
			timer.Create(au,0.2,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 100
			timer.Create(au,0.8,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse = true
				if IsValid(Actoji.Frame) then Actoji:Close("nOw") end
			end end) end end) end end) end end) end end) end end) end end) end end) end end) end end) end end) end end)
			end end) end end) end end) end end) end end) end end) end end) end end) end end) end end) end end) end end)
			end end) end end)
		end
		local function TC_c2()
			if timer.Exists( au ) then timer.Remove( au ) end
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 40
				Tast_Precache("sound/actmod/i_menu","sound")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 42
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 43
				Tast_Precache("sound/actmod/i_act/am4","sound")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 47
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 49
				Tast_Precache("sound/actmod/i_act/am4/fortnite","sound")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 55
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 56
				Tast_Precache("sound/actmod/i_act/am4/pubg","sound")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 58
				Tast_Precache("sound/actmod/i_act/am4/mmd","sound")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 59
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 60
				Tast_Precache("models/actmod","model")
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 65
			timer.Create(au,0.2,1,function() if IsValid(ply) then TC_c3()
			end end) end end) end end) end end) end end) end end) end end) end end) end end) end end) end end) end end)
		end
		local function TC_c1()
			if timer.Exists( au ) then timer.Remove( au ) end
			timer.Create(au,0.2,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 1
			timer.Create(au,FaTime and 0.2 or 1.5,1, function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 2
				Get_net_NWBool()
			timer.Create(au,0.8,1, function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 4
			timer.Create(au,0.05,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 7
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 10
				Set_Seq_restuo(A_AM.ActMod.GetMSS_Tab_cl)
			timer.Create(au,FaTime and 0.5 or 2.5,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 16
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 18
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 20
				local TabOK = A_AM.ActMod.GetMSS_Tab_cl
				local ttab = string.format("%s|%s|%s|%s|%s|%s",TabOK["GetMDLSeq_AM4"],TabOK["GetMDLSeq_Dyn"],TabOK["GetMDLSeq_xdR"],TabOK["GetMDLSeq_wOS"],TabOK["GetPackAnimV"],TabOK["GetPackSounds"],TabOK["GetORG"])
				ply:SetNW2String( "A_ActMod.GetMSS_Tab", ttab )
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 23
			timer.Create(au,0.05,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 25
			timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 35
				if engine.ActiveGamemode() ~= "sandbox" or GetConVarNumber("actmod_cl_eloading") == 0 then
					timer.Create(au,0.1,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 98
					timer.Create(au,0.05,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse_Num = 100
					timer.Create(au,0.5,1,function() if IsValid(ply) then A_AM.ActMod.A_ActMod_RedyUse = true
						if IsValid(Actoji.Frame) then Actoji:Close("nOw") end
					end end) end end) end end)
				else
					TC_c2()
				end
			end end) end end) end end) end end) end end) end end) end end) end end) end end) end end) end end)
		end
		TC_c1()
	end
end


function A_AM.ActMod.ClServroC(ply,commit)
	ply.ActMod_Taburlcommit = commit
	if commit.iName and commit.iCo and commit.On then
		if not istable(ply.ActMod_TabS1) then ply.ActMod_TabS1 = {} end
		ply.ActMod_TabS1["SVAM4_Name"] = commit["iName"]
		ply.ActMod_TabS1["SVAM4_Connect"] = commit["iCo"]
		ply.ActMod_TabS1["SVAM4_On"] = commit["On"]
		if commit["On"] == "Active" then
			if commit["iName"] == "[AM4] ZS+Bots" then
				ply.ActMod_TabTSrvr = 1
				A_AM.ActMod.Aptmp["Avs_a1_1"]["png"] = "hud/killicons/default"
				A_AM.ActMod.Aptmp["Avs_a1_2"]["lng"] = "LAchievements_a1_m2"
			else
				ply.ActMod_TabTSrvr = 2
				A_AM.ActMod.Aptmp["Avs_a1_1"]["png"] = "entities/npc_zombie.png"
				A_AM.ActMod.Aptmp["Avs_a1_2"]["lng"] = "LAchievements_a1_m2_n1"
			end
		else
			ply.ActMod_TabTSrvr = 0
			A_AM.ActMod.Aptmp["Avs_a1_1"]["png"] = "entities/npc_zombie.png"
			A_AM.ActMod.Aptmp["Avs_a1_2"]["lng"] = "LAchievements_a1_m2_n1"
		end
	else
		ply.ActMod_TabTSrvr = 0
		ply.ActMod_TabS1 = {}
		A_AM.ActMod.Aptmp["Avs_a1_1"]["png"] = "entities/npc_zombie.png"
		A_AM.ActMod.Aptmp["Avs_a1_2"]["lng"] = "LAchievements_a1_m2_n1"
	end
	if istable(commit.ina) then
		A_AM.ActMod.ActuLck = {}
		for k, v in pairs(commit["ina"]) do A_AM.ActMod.ActuLck[k] = v end
		A_AM.ActMod.ActuLck["AM4_Avs"] = true
	end
	if istable(commit.adi) then
		A_AM.ActMod.ActuAck = {}
		for k, v in pairs(commit.adi) do A_AM.ActMod.ActuAck[k] = v end
		A_AM.ActMod.ActuAck["AM4_Avs"] = true
	end
	if istable(A_AM.ActMod.Actbtk_sv) and not table.IsEmpty(A_AM.ActMod.Actbtk_sv) then
		A_AM.ActMod.Actbtk_cl = A_AM.ActMod.Actbtk_sv
	else
		if istable(commit.abtk) then
			A_AM.ActMod.Actbtk_cl = {}
			for k, v in pairs(commit.abtk) do A_AM.ActMod.Actbtk_cl[k] = v end
		end
	end
	if commit.GTea then A_AM.ActMod.autDon = commit.GTea else A_AM.ActMod.autDon = nil end
	if commit.V then A_AM.ActMod.numV = commit.V else A_AM.ActMod.numV = 0 end
	if commit.RK then A_AM.ActMod.RKarm = tonumber(commit.RK) else A_AM.ActMod.RKarm = 0 end
	if commit.GHlpLTD_URLY then A_AM.ActMod.autLTD_URLY = commit.GHlpLTD_URLY else A_AM.ActMod.autLTD_URLY = nil end
	if commit.GHlpLTD_URLB then A_AM.ActMod.autLTD_URLB = commit.GHlpLTD_URLB else A_AM.ActMod.autLTD_URLB = nil end
	if commit.G_U then A_AM.ActMod.autDon_URL = commit.G_U else A_AM.ActMod.autDon_URL = nil end
	if commit.URLV_Y then A_AM.ActMod.autDon_URL_Y = commit.URLV_Y else A_AM.ActMod.autDon_URL_Y = nil end
	if commit.URLV_B then A_AM.ActMod.autDon_URL_B = commit.URLV_B else A_AM.ActMod.autDon_URL_B = nil end
	if commit.URLV_P then A_AM.ActMod.autDon_URL_P = commit.URLV_P else A_AM.ActMod.autDon_URL_P = nil end
	if commit.URLV_K then A_AM.ActMod.autDon_URL_K = commit.URLV_K else A_AM.ActMod.autDon_URL_K = nil end
	if commit.V then
		A_AM.ActMod.TVersion = commit.V
		A_AM.ActMod.HFGtrue = true
		if timer.Exists("ATmp_https") then timer.Remove("ATmp_https") end
	else
		A_AM.ActMod.TVersion = nil
	end
	ply:ConCommand("actmod_wts CToS_SvCTSvr ".. ply:EntIndex() .." ".. ply.ActMod_TabTSrvr .."\n")
end

function A_AM.ActMod.ClServroF(ply,t2)
	A_AM.ActMod.HFGtrue = nil
	A_AM.ActMod.ActuLck = nil
	A_AM.ActMod.ActuAck = nil
	A_AM.ActMod.TVersion = nil
	A_AM.ActMod.autDon = nil
	A_AM.ActMod.autDon_URL = nil
	A_AM.ActMod.autDon_URL_Y = nil
	A_AM.ActMod.autDon_URL_B = nil
	A_AM.ActMod.autDon_URL_P = nil
	A_AM.ActMod.autDon_URL_K = nil
	if IsValid(ply) then
		ply.ActMod_TabS1 = {}
		ply.ActMod_TabTSrvr = 0
		ply:ConCommand("actmod_wts CToS_SvCTSvr ".. ply:EntIndex() .." ".. ply.ActMod_TabTSrvr .."\n")
	end
	A_AM.ActMod.Aptmp["Avs_a1_1"]["png"] = "entities/npc_zombie.png"
	A_AM.ActMod.Aptmp["Avs_a1_2"]["lng"] = "LAchievements_a1_m2_n1"
end

function A_AM.ActMod.ClServro(ply)
	ply.ActMod_TabS1 = ply.ActMod_TabS1 or {}
	A_AM.ActMod.AGServro(ply)
end

function A_AM.ActMod:ClRestuo(ftim)
	local ply = LocalPlayer()
	A_AM.ActMod.Aatmp = [[{
	  "inopn": "ActMod [AM4]",
	  "IDPly": "]].. ply:SteamID64() ..[[",
	  "Avs_a1_1": {"ok": "no","ing": 0},
	  "Avs_a1_2": {"ok": "no","ing": 0},
	  "Avs_a1_3": {"ok": "no","ing": 0},
	  "Avs_a2_1": {"ok": "no","ing": 0},
	  "Avs_a2_2": {"ok": "no","ing": 0},
	  "Avs_a2_3": {"ok": "no","ing": 0},
	  "Avs_a2_4": {"ok": "no","ing": 0},
	  "Avs_a2_5": {"ok": "no","ing": 0},
	  "Avs_a2_6": {"ok": "no","ing": 0},
	  "Avs_a2_7": {"ok": "no","ing": 0},
	  "Avs_a2_8": {"ok": "no","ing": 0},
	  "Avs_a2_9": {"ok": "no","ing": 0},
	  "Avs_a3_1": {"ok": "no","ing": 0},
	  "Avs_a3_2": {"ok": "no","ing": 0},
	  "Avs_a3_3": {"ok": "no","ing": 0},
	  "Avs_a3_4": {"ok": "no","ing": 0},
	  "Avs_a3_9": {"ok": "no","ing": 0},
	  "Avs_a4_1": {"ok": "no","ing": 0},
	  "Avs_a4_2": {"ok": "no","ing": 0},
	  "Avs_a4_3": {"ok": "no","ing": 0},
	  "Avs_a4_4": {"ok": "no","ing": 0},
	  "V": "]].. A_AM.ActMod.Mounted[ "Version ActMod" ] ..[[",
	  "By": "AhmedMake400"
	}]]
	if IsValid( ply ) then
		A_AM.ActMod.clo_IMeun_Num = 1
		A_AM.ActMod.clo_Select_Bace = 1
		timer.Create("Acl_t1",1.5,1,function() if IsValid(ply) and A_AM.ActMod.Aatmp and A_AM.ActMod.Aptmp then A_AM.ActMod:A_ReGD() end end)
		local cl_s,cl_e,cl_l,cl_y = 0,0,0,0
		if GetConVarNumber("actmod_cl_asyn") == 1 then cl_y = 1 end
		if GetConVarNumber("actmod_cl_sound") == 1 then cl_s = 1 end
		if GetConVarNumber("actmod_cl_effects") == 1 then cl_e = 1 end
		if GetConVarNumber("actmod_cl_loop") == 1 then cl_l = 1 elseif GetConVarNumber("actmod_cl_loop") == 2 then cl_l = 2 end
		net.Start( "A_AM.ActMod.ClToSv_Tab" )
		 net.WriteTable( {"ActMod.CToS_ST","CToS_",{"wts_SEL",cl_s,cl_e,cl_l,cl_y}} )
		net.SendToServer()
		ply.ActMod_RLAng = 0
		ply.ActMod_TabTSrvr = 0
		ply.ActMod_TastAng = 0
		ply.A_ActMod_GetDir = nil
		PResetColcted(ply)
		ply.ActMod_Table_Ply = ply.ActMod_Table_Ply or {}
		A_AM.ActMod.ClServro(ply)
		if timer.Exists( "AA_Reflsh" ) then timer.Remove( "AA_Reflsh" ) end
		timer.Create("AA_Reflsh",60,0,function() if IsValid(ply) then A_AM.ActMod.ClServro(ply) end end)
		A_AM.ActMod.ClServro(ply)
		if ftim == "isHost" then ply.ActMod_PlyIsHost = true end
		timer.Create("AA_Sutp_restuo",0.3,1,function()
			if IsValid(ply) then
				A_AM.ActMod:Tast_SvToCl_restuo(ply,ftim == "true" and true)
			end
		end)
	end
end

local function CLPrint(Pl_,Tx1,Tx2,Gi)
	if Gi and Gi != 0 then
		if Gi == 1 then
			Pl_:PrintMessage( 3,Tx1)
		elseif Gi == 2 then
			Pl_:PrintMessage( 4,Tx1)
		elseif Gi == 4 then
			Pl_:PrintMessage( 3,"[ActMod]: ".. Tx1)
		end
	else
		Pl_:PrintMessage( 3," ") Pl_:PrintMessage( 3,"========(ActMod)==========")
		Pl_:PrintMessage( 3,Tx1) if Tx2 then Pl_:PrintMessage( 3,Tx2) end
		Pl_:PrintMessage( 3,"==========================") Pl_:PrintMessage( 3," ")
	end
end


function A_AM.ActMod:SP_iError( ply,strg )
	if strg == "sv_bg_bse" then CLPrint(ply,"The server must unsubscribe from:" , " wOS-Base (Full Version)")
	elseif strg == "bg_bse" then CLPrint(ply,"You must unsubscribe from:" , " wOS-Base (Full Version)")
	elseif strg == "sv_bse" then CLPrint(ply,"The server is not subscribed to any of:" , "( AM4-Base ) or ( Dyn-Base ) or ( xdR-Base )")
	elseif strg == "bse" then CLPrint(ply,"You have not subscribed to any of:" , "( AM4-Base ) or ( Dyn-Base ) or ( xdR-Base )")
	elseif strg == "bs_am4" then CLPrint(ply,"You did not subscribe to :" , "Base Anim-AM4")
	elseif strg == "eam4" then CLPrint(ply,"It is not recognized animation from :" , "Base Anim-AM4")
	elseif strg == "sv_bs_am4" then CLPrint(ply,"The Server not have :" , "Base Anim-AM4")
	elseif strg == "sv_ubs_am4" then CLPrint(ply,"The server did not recognize :" , "Base Anim-AM4")
	elseif strg == "pkam4" then CLPrint(ply,"You did not subscribe to :" , "ActMod")
	elseif strg == "epkam4" then CLPrint(ply,"It is not recognized animation from :" , "ActMod")
	elseif strg == "sv_pk_am4" then CLPrint(ply,"The Server not have :" , "ActMod")
	elseif strg == "sv_upk_am4" then CLPrint(ply,"The server did not recognize :" , "ActMod")
	elseif strg == "pkso" then CLPrint(ply,"Sound is missing!" , "Make sure you subscribe to the requirements correctly.")
	elseif strg == "nwp" then CLPrint(ply,"Something prevents it from being used!")
	elseif strg == "nallow" then CLPrint(ply,"The server prevents the use of ActMod!")
	elseif string.sub(strg,1 ,9) == "sv_ntact_" then CLPrint(ply,"[SV] This act is unknown:  ".. string.sub(strg,10))
	elseif string.sub(strg,1 ,9) == "cl_ntact_" then CLPrint(ply,"[CL] This act is unknown:  ".. string.sub(strg,10))
	else
		if string.find(string.sub(strg,1,4), "!S_.") then
			local tYp = string.sub(strg,5,5)
			local sY = string.Replace(strg,string.sub(strg,1,5),"")
			CLPrint(ply,sY,nil,tonumber(tYp))
		elseif string.find(string.sub(strg,1,4), "!T_.") then
			local tYp = string.sub(strg,5,5)
			local sY = string.Replace(strg,string.sub(strg,1,5),"")
			CLPrint(ply,aR:T(sY),nil,tonumber(tYp))
		elseif string.find(string.sub(strg,1,4), "!M_.") then
			local sY = string.Replace(strg,string.sub(strg,1,4),"")
			CLPrint(ply,aR:T(sY),nil,4)
		else CLPrint(ply,strg)
		end
	end
end

local function T_SvToCl_Tab(Tab)
	if IsValid( LocalPlayer() ) and not table.IsEmpty(Tab) then
		local pl,GTab = LocalPlayer(),tostring(Tab[1])
		if GTab == "ActMod.AddMdl" then
			local ply = Tab[2]
			local str = Tab[3]
			local Tmd1 = Tab[4]
			local Tmd2 = Tab[5]
			local Tmd3 = Tab[6]
			local Tmd4 = Tab[7]
			A_AM.ActMod:AddCrMdl(ply,str,Tmd1,Tmd2,Tmd3,Tmd4)
		elseif GTab == "StpGtur" then
			local tt1 = isstring(Tab[2]) and Tab[2] or string.format("._|%s|0",CurTime())
			if tt1 ~= "" then
				pl:SetNWString("A_ActMod.OneStart6",tt1)
				pl.aSysTab["OneStart6_ID"] = atXt
				pl.aSysTab["OneStart6"] = atXt pl.aaGThinStrt = nil
				A_AM.ActMod.GestureSystem:StopAllGestures(pl,0)
			end
		elseif GTab == "SvToCl_restuo" then
			A_AM.ActMod:ClRestuo(Tab[2])
		elseif GTab == "i_MenuTErr" and Tab[2] == "SGTab" then
			local n = net.ReadUInt( 32 )
			local c = net.ReadData( n )
			local t = util.JSONToTable( util.Decompress(c) )
			if istable(t) and IsValid(Actoji.i_MenuTErr) then Actoji.i_MenuTErr:TGTbl( t ) end
		elseif GTab == "aLAT" then
			A_AM.ActMod:aLoadAllTablAS()
		elseif GTab == "ActMod.AddRemove" then
			local ply = Tab[2]
			local t = Tab[3]
			if IsValid(ply) then
				A_AM.ActMod:RemoveCrMdl( ply,t )
			end
		elseif GTab == "AM_SvToCl_" then
			local txt = Tab[2]
			local stxt = Tab[3]
			if isstring( txt ) and isstring( stxt ) then
				A_AM.ActMod:avsSTC( txt,stxt )
			end
		elseif GTab == "SetTCl_MountedSV" then
			local strg = Tab[2]
			A_AM.ActMod.GetMSS_Tab = A_AM.ActMod.GetMSS_Tab or {}
			if istable(strg) then A_AM.ActMod.GetMSS_Tab = strg end
			A_AM.ActMod.GetMSS_Tab_cl = A_AM.ActMod:aRSeq()
		elseif GTab == "iError_cl" then
			local strg = Tab[2]
			A_AM.ActMod:SP_iError(pl,strg)
		elseif GTab == "ActMod.SToC_ST" then
			local str = Tab[2]
			local tbl = Tab[3]
			if str == "SToC_" then
				if tbl[1] == "CToS_Sond" or tbl[1] == "SetRAnim_TPly" or tbl[1] == "aPlyEmot" or tbl[1] == "SToC_AJoing" or tbl[1] == "SToC_AJoingF" or tbl[1] == "wtc_FildEnd" then
					A_AM.ActMod:Commt_Cl(ply,tbl)
				end
			end
		elseif GTab == ">GSBListD" and istable(Tab[2]) then
			A_AM.ActMod.Blacklist = Tab[2]
			local box = A_AM.ActMod.CLpanel_sv_panel2
			if IsValid(box) then box.TimeTh = CurTime() end
		elseif GTab == "SLSBListD" and Tab[2] ~= "" then
				local box = A_AM.ActMod.CLpanel_sv_panel2
				if IsValid(box) then box.EndWitL() end
		elseif GTab == "+SBListD" and Tab[2] ~= "" then
				A_AM.ActMod:AddBlacklistedDance(Tab[2], Tab[3] ,Tab[4])
				local box = A_AM.ActMod.CLpanel_sv_panel2
				if IsValid(box) then box.TimeTh = CurTime() end
		elseif GTab == "-SBListD" and Tab[2] ~= "" then
			A_AM.ActMod:RemoveBlacklistedDance(Tab[2])
			local box = A_AM.ActMod.CLpanel_sv_panel2
			if IsValid(box) and isfunction(box.GOnBDone) then box.GOnBDone(Tab[2]) end
		elseif GTab == "LTD.SvToCl" then
			A_AM.ActMod:LTDSvToCl( Tab[2],Tab[3] )
		elseif GTab == "SC_T_PlyP_ToCl" then
			local ply = Tab[2]
			local ply2 = Tab[3]
			local txt = Tab[4]
			local RTable = Tab[5]
			local STxt
			if IsValid( ply ) and IsValid( ply2 ) then
				if txt == "GetTableFromPly_ToPly2" then
					local asfa,asfa2
					local ActojiData = A_AM.ActMod:LoadEmts("savemots",{"ActojiDial"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
					local ActojiData2 = A_AM.ActMod:LoadEmts("savemots",{"ActojiDial2"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
					if ActojiData and istable(ActojiData) then asfa = ActojiData end
					if ActojiData2 and istable(ActojiData2) then asfa2 = ActojiData2 end
					RTable = {
						["GetRequirements"] = {
							["IMeun_Num"]= A_AM.ActMod.clo_IMeun_Num
							,["IMeun_Tiyp"]= A_AM.ActMod.clo_Select_Bace
							,["Base_Get"]= A_AM.ActMod.GetMSS_Tab_cl["GetSetBase"]
							,["Base_AM4"]= A_AM.ActMod.GetMSS_Tab_cl["GetMDLSeq_AM4"]
							,["Anim_AM4"]= A_AM.ActMod.GetMSS_Tab_cl["GetPackAnimV"] == 0 and 0 or A_AM.ActMod.GetMSS_Tab_cl["GetPackAnimV"] == 1 and 1 or A_AM.ActMod.GetMSS_Tab_cl["GetORG"] == 0 and 3 or 2
							,["Sound_AM4"]= A_AM.ActMod.GetMSS_Tab_cl["GetPackSounds"] == 1 and 2 or 0
						},
						["GetConCl"] = {
							["GetConN_actmod_cl_menuformat"]= GetConVarNumber("actmod_cl_menuformat")
							,["GetConN_actmod_cl_menuformat2"]= GetConVarNumber("actmod_cl_menuformat2")
							,["GetConN_actmod_cl_loop"]= GetConVarNumber("actmod_cl_loop")
							,["GetConN_actmod_cl_effects"]= GetConVarNumber("actmod_cl_effects")
							,["GetConN_actmod_cl_asyn"]= GetConVarNumber("actmod_cl_asyn")
							,["GetConN_actmod_cl_sound"]= GetConVarNumber("actmod_cl_sound")
							,["GetConN_actmod_cl_thememenu"]= GetConVarNumber("actmod_cl_thememenu")
							,["GetConN_actmod_cl_stext"]= GetConVarString("actmod_cl_stext")
							,["GetConN_actmod_cl_background"]= GetConVarNumber("actmod_cl_background")
							,["GetConN_actmod_cl_sortemote"]= GetConVarNumber("actmod_cl_sortemote")
							,["GetConN_actmod_cl_setcamera"]= GetConVarNumber("actmod_cl_setcamera")
							,["GetConN_actmod_cl_showbhelp"]= GetConVarNumber("actmod_cl_showbhelp")
						},
						["GetIcoUseCl"] = {
							["GetIco_1"]= (asfa and asfa[1]) or ""
							,["GetIco_2"]= (asfa and asfa[2]) or ""
							,["GetIco_3"]= (asfa and asfa[3]) or ""
							,["GetIco_4"]= (asfa and asfa[4]) or ""
							,["GetIco_5"]= (asfa and asfa[5]) or ""
							,["GetIco_6"]= (asfa and asfa[6]) or ""
							,["GetIco_7"]= (asfa and asfa[7]) or ""
							,["GetIco_8"]= (asfa and asfa[8]) or ""
							,["GetIco2_1"]= (asfa2 and asfa2[1]) or ""
							,["GetIco2_2"]= (asfa2 and asfa2[2]) or ""
							,["GetIco2_3"]= (asfa2 and asfa2[3]) or ""
							,["GetIco2_4"]= (asfa2 and asfa2[4]) or ""
							,["GetIco2_5"]= (asfa2 and asfa2[5]) or ""
							,["GetIco2_6"]= (asfa2 and asfa2[6]) or ""
							,["GetIco2_7"]= (asfa2 and asfa2[7]) or ""
							,["GetIco2_8"]= (asfa2 and asfa2[8]) or ""
						}
					}
					asfa = nil asfa2 = nil ActojiData = nil ActojiData2 = nil
					STxt = "GetTableFromPly_ToPly1"
				elseif txt == "GetTableFromPly_ToPly1_Finsh" then
					ply2.GetR_Table_Ply = RTable
				elseif txt == "GetTabiPly_1To2" then
					local pgaw = pl:GetActiveWeapon()
					pl.ToPnext_update = CurTime() + 0.7
					RTable = {
						["P_iFPS"] = pl.ATT_Pi_fps or "00"
						,["P_Ping"] = pl.ATT_Pi_ping or "00"
						,["P_Health"] = pl:Health()
						,["P_HealthMax"] = pl:GetMaxHealth()
						,["P_ddd"] = A_ToMinutesSecondsCD(CurTime())
						,["P_Pos"] = tostring(pl:GetPos())
						,["P_Ang"] = tostring(pl:EyeAngles())
						,["P_Length"] = math.Round(pl:GetVelocity():Length())
						,["P_Weap"] = pgaw and IsValid(pgaw) and pgaw:GetClass() or "nil"
					}
					STxt = "GetTabiPly_2To1"
				elseif txt == "GetTabiPly_Finsh" then
					ply2.GetR_i = RTable
				elseif txt == "GetTabiPly_Avs_Get_Start" then
					if ply2.GetTable_Avs then
						local ts1,ts2 = "nil_","nil_"
						for k, v in pairs(ply2.GetTable_Avs) do
							if v["ing"] then ts2 = v["ing"] end
							if v["ok"] then ts1 = v["ok"] end
							
							RTable[k] = { ["ok"]= ts1 ,["ing"]= ts2 }
							ts1 = nil ts2 = nil
						end
					end
					STxt = "GetTabiPly_Avs_Get_2To1"
				elseif txt == "GetTabiPly_Avs_Get_Finsh" then
					ply2.AvsGetR_i = RTable
				elseif txt == "GetTabiPly_Avs_Set_Start" then
					A_AM.ActMod:AG_DatA( RTable[1],RTable[2],RTable[3],RTable[4] )
				end
				
				if STxt then
					net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"ClToSv_PlyP_ToSv",{ply,ply2,STxt,RTable}} ) net.SendToServer()
				end
			end
		end
	end
end
net.Receive( "A_AM.ActMod.SvToCl_Tab", function()
	T_SvToCl_Tab(net.ReadTable())
end )



local function GActNewV(txt)
	return (not A_AM.ActMod.ActNewVCustom or istable(A_AM.ActMod.ActNewVCustom[txt])) or A_AM.ActMod:ATabData(A_AM.ActMod.ActNewV, txt) == true
end

function A_AM.ActMod:CStart_cl(tName,txt)
	local pl,tn = LocalPlayer(),tostring(A_AM.ActMod:ReString(tName))
	if GetConVarNumber("actmod_sv_avs") == 1 and A_AM.ActMod:LokTabData(pl, A_AM.ActMod.ActLck, tn) == true then
		A_AM.ActMod:SP_iError(pl,"!M_.LReplace_txt_Lock") return
	end
	
	local GTabActO = A_AM.ActMod.GTabActO[tn]
	local isGetr = false
    if istable(GTabActO) and GTabActO.NoStop and GTabActO.NoStop == 63 then isGetr = true end
	
    if not isGetr then
		if pl:A_ActModSound() == true then
			if string.sub(tn,1 ,5) == "amod_" or string.sub(tn,1 ,9) == "amod_am4_" or string.sub(tn,1 ,9) == "amod_mmd_" or string.sub(tn,1 ,10) == "amod_pubg_" or string.sub(tn,1 ,12) == "amod_mixamo_" or string.sub(tn,1 ,14) == "amod_fortnite_" then
				if A_AM.ActMod.GetMSS_Tab["GetMDLSeq_AM4"] == 0 then A_AM.ActMod:SP_iError(pl,"bs_am4") return end
				if A_AM.ActMod.GetMSS_Tab["GetMDLSeq_AM4"] == 1 then A_AM.ActMod:SP_iError(pl,"eam4") return end
				if A_AM.ActMod.GetMSS_Tab["GetPackAnimV"] == 0 then A_AM.ActMod:SP_iError(pl,"pkam4") return end
				if A_AM.ActMod.GetMSS_Tab["GetPackAnimV"] == 1 then A_AM.ActMod:SP_iError(pl,"epkam4") return end
			end
		end
	end
		
	if not A_AM.ActMod.cl_TmpDatanew then A_AM.ActMod.cl_TmpDatanew = {} end
	local ActDataNew = A_AM.ActMod:LoadEmts("saveenew",{"ActojiDNew1"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
	if ActDataNew and istable(ActDataNew) then
		local TActDataNew = ActDataNew

		if TActDataNew[1] and TActDataNew[1] == A_AM.ActMod.Mounted["Version ActMod"] then
			A_AM.ActMod.cl_TmpDatanew = TActDataNew
		else
			TActDataNew = {}
			table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
			A_AM.ActMod.cl_TmpDatanew = TActDataNew
			A_AM.ActMod:ReAddEmts("saveenew",{"ActojiDNew1",0,TActDataNew},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
		end
		TActDataNew = nil
	else
		local TActDataNew = {}
		table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
		A_AM.ActMod.cl_TmpDatanew = TActDataNew
		A_AM.ActMod:ReAddEmts("saveenew",{"ActojiDNew1",0,TActDataNew},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
		TActDataNew = nil
	end
	
	if not table.HasValue(A_AM.ActMod.cl_TmpDatanew, tn) and GActNewV(tn) then
		table.insert(A_AM.ActMod.cl_TmpDatanew, tn)
		A_AM.ActMod:ReAddEmts("saveenew",{"ActojiDNew1",tn},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
	end

	local cSTm = tostring(SysTime())
	local t_1,t_2,t_3,t_4 = "0","0","0","0"
	local TtXt = string.Explode(" ", txt, true)
	if TtXt and istable(TtXt) then
		if TtXt[1] then t_1 = tostring(TtXt[1]) end
		if TtXt[2] then t_2 = tostring(TtXt[2]) end
		if TtXt[3] then t_3 = tostring(TtXt[3]) end
		if TtXt[4] then t_4 = tostring(TtXt[4]) end
	end
	net.Start( "A_AM.ActMod.ClToSv_Tab",true ) net.WriteTable( {"ActMod.CToS_ST","CToS_",{"wts",tName,t_1,t_2,t_3,t_4,cSTm}} ) net.SendToServer()
	pl:ConCommand("actmod_wts wts ".. tostring(tName) .." ".. tostring(txt) .." ".. cSTm .." t\n")
end


function A_AM.ActMod:GetFinalTimeScale()
	local htsCvarValue = 1.0
	local htsCvar = GetConVar("host_timescale")
	if (htsCvar ~= nil) then
		local floatVal = htsCvar:GetFloat()
		if (floatVal ~= 0) then
			htsCvarValue = floatVal
		end
	end
	return htsCvarValue * game.GetTimeScale()
end


function A_AM.ActMod:C_GetTimSond(ent,SSond,GetTIm)
	A_AM.ActMod:C_AddSond(ent,nil,nil,nil,nil,SSond,0,nil,nil,GetTIm)
end
function A_AM.ActMod:C_AddSond(pl,SettoG,tyyp,nnm,soundid,SSond,TimeEnd,soundmdl,ALoopSOund,GetTIm,LtS,TSd,onSnd)
	if pl and IsValid(pl) and (tyyp and soundid or GetTIm) then
		TimeEnd = TimeEnd or 0
		if SSond and TimeEnd == 0 then
			sound.PlayFile("sound/".. SSond, "noplay",function(igac, errorId, errorName)
				if (IsValid(igac)) then
					local length = igac:GetLength()
					if IsValid(pl) then
						local at = CurTime() + length + 0.05
						if not ALoopSOund then
							if GetTIm then
								GetTIm(at,length)
							else
								if SettoG == "2" and pl.AAct_S2 then
									pl.AAct_S2[tyyp]["TimeEnd"] = at
									if pl.AAct_S2[tyyp]["SMdl"] then SafeRemoveEntityDelayed( pl.AAct_S2[tyyp]["SMdl"], length + 0.1 ) end
								elseif SettoG == "3" and pl.AAct_S3 then
									pl.AAct_S3[tyyp]["TimeEnd"] = at
									if pl.AAct_S3[tyyp]["SMdl"] then SafeRemoveEntityDelayed( pl.AAct_S3[tyyp]["SMdl"], length + 0.1 ) end
								elseif pl.AAct_S1 then
									pl.AAct_S1[tyyp]["TimeEnd"] = at
									if pl.AAct_S1[tyyp]["SMdl"] then SafeRemoveEntityDelayed( pl.AAct_S1[tyyp]["SMdl"], length + 0.1 ) end
								end
							end
						end
					end
				end
			end)
		end
		
		if GetTIm then
		else
			local GtXt = pl:GetNWString( "A_ActMod.TmpDir" ,"" )
			local aTab = {[tyyp] = {[nnm] = soundid ,["Volume"] = LtS[1] or 1 ,["TimeEnd"] = TimeEnd ,["TimeDoneRun"] = CurTime() ,["TimeStartRun"] = TSd ,["onSnd"] = onSnd ,["GtXt"] = GtXt ~= "" and GtXt or nil}}
			if tyyp == "Sond_Lc" and soundmdl and IsValid(soundmdl) and soundmdl ~= pl then aTab[tyyp]["SMdl"] = soundmdl soundmdl.noRmov = nil end
			if SettoG == "2" then
				pl.AAct_S2 = aTab
			elseif SettoG == "3" then
				pl.AAct_S3 = aTab
			else
				pl.AAct_S1 = aTab
			end
		end
	end
end

function A_AM.ActMod:C_StopSond(pl,A_aSo,nOStop)
	if pl and IsValid(pl) and A_aSo and isstring(A_aSo) then
		if A_aSo == "*" then
			A_AM.ActMod:C_StopSond(pl,"1",nOStop)
			A_AM.ActMod:C_StopSond(pl,"2",nOStop)
			A_AM.ActMod:C_StopSond(pl,"3",nOStop)
		end
		local SL1,SL2 = "Sond_Lc","SMdl"
		if nOStop then
			if A_aSo == "2" then
				if pl.AAct_S2 and pl.AAct_S2[SL1] and pl.AAct_S2[SL1][SL2] and IsValid(pl.AAct_S2[SL1][SL2]) then pl.AAct_S2[SL1][SL2]:Remove() end
				pl.AAct_S2 = nil
			elseif A_aSo == "3" then
				if pl.AAct_S3 and pl.AAct_S3[SL1] and pl.AAct_S3[SL1][SL2] and IsValid(pl.AAct_S3[SL1][SL2]) then pl.AAct_S3[SL1][SL2]:Remove() end
				pl.AAct_S3 = nil
			else
				if pl.AAct_S1 and pl.AAct_S1[SL1] and pl.AAct_S1[SL1][SL2] and IsValid(pl.AAct_S1[SL1][SL2]) then pl.AAct_S1[SL1][SL2]:Remove() end
				pl.AAct_S1 = nil
			end
		else
			local A_So
			if A_aSo == "2" then A_So = pl.AAct_S2
			elseif A_aSo == "3" then A_So = pl.AAct_S3
			else A_So = pl.AAct_S1 end
			if A_So and istable(A_So) then
				if A_So["Sond_Lc"] then
					if type(A_So["Sond_Lc"]["_1"]) == "CSoundPatch" then A_So["Sond_Lc"]["_1"]:Stop() A_So["Sond_Lc"]["_1"] = nil end
				end
			end
			if A_So and A_So[SL1] and A_So[SL1][SL2] and IsValid(A_So[SL1][SL2]) then A_So[SL1][SL2]:Remove() end
			A_So = nil
			if A_aSo == "2" then
				if pl.AAct_S2 and pl.AAct_S2[SL1] and pl.AAct_S2[SL1][SL2] and IsValid(pl.AAct_S2[SL1][SL2]) then pl.AAct_S2[SL1][SL2]:Remove() end
				pl.AAct_S2 = nil
			elseif A_aSo == "3" then
				if pl.AAct_S3 and pl.AAct_S3[SL1] and pl.AAct_S3[SL1][SL2] and IsValid(pl.AAct_S3[SL1][SL2]) then pl.AAct_S3[SL1][SL2]:Remove() end
				pl.AAct_S3 = nil
			else
				if pl.AAct_S1 and pl.AAct_S1[SL1] and pl.AAct_S1[SL1][SL2] and IsValid(pl.AAct_S1[SL1][SL2]) then pl.AAct_S1[SL1][SL2]:Remove() end
				pl.AAct_S1 = nil
			end
		end
	end
end


local function A_aSond(pl,SSond,SettoG,aLevel,onSnd,LSo,afs)
	aLevel = aLevel or 100
	A_AM.ActMod:C_StopSond(pl,SettoG or "1")
	
	if hook.Call("ActMod_bPlaySound",nil,pl,SSond,SettoG,aLevel,onSnd,LSo,afs) == true then
		return
	end
	
	if pl:IsPlayer() and GetConVarNumber("actmod_sv_enabled_addso") == 0 or not pl:IsPlayer() and GetConVarNumber("actmod_cl_sound") == 0 then return end
	if pl:IsPlayer() and A_AM.ActMod.OptSFPly and A_AM.ActMod.OptSFPly[pl:SteamID64()] and A_AM.ActMod.OptSFPly[pl:SteamID64()]["noSound"] then return end
	
	if not LSo or (LSo == "0" or LSo == "-1" or LSo == "nil") then
		local Tosoundmdl,soundmdl
		if pl:IsPlayer() then
			Tosoundmdl = pl
			if pl ~= LocalPlayer() then
				soundmdl = ClientsideModel("models/hunter/blocks/cube025x025x025.mdl", RENDERGROUP_BOTH)
				timer.Simple(0.2,function() if soundmdl and IsValid(soundmdl) and soundmdl.noRmov then soundmdl:Remove() end end)
				if soundmdl and IsValid(soundmdl) then
					soundmdl.noRmov = true
					soundmdl:SetPos( A_AM.ActMod:GetEntityBoneCenter(pl) )
					soundmdl:SetParent( pl ) soundmdl:DrawShadow( false ) soundmdl:SetNoDraw( true )
					Tosoundmdl = soundmdl
				end
			end
		else
			Tosoundmdl = LocalPlayer()
		end
		pl:CallOnRemove( "ActMod_RemoveMDLSound_".. tostring(SettoG), function( ent )
			A_AM.ActMod:C_StopSond(pl,"1") A_AM.ActMod:C_StopSond(pl,"2") A_AM.ActMod:C_StopSond(pl,"3")
			A_AM.ActMod:C_StopSond(ent,"1") A_AM.ActMod:C_StopSond(ent,"2") A_AM.ActMod:C_StopSond(ent,"3")
			if soundmdl and IsValid(soundmdl) then SafeRemoveEntity( soundmdl ) end
		end )
		local soundid = CreateSound(Tosoundmdl, SSond)
		if soundid then
			local LtS,LtM,TSd = 1,1,CurTime()
			if (onSnd == "1" or onSnd == "1f") or ((onSnd == "0" or onSnd == "0f") and (pl:IsPlayer() and pl:A_ActModSound() == true or pl:IsPlayer() and pl:IsBot() or not pl:IsPlayer())) then
				if not pl:IsPlayer() then
					soundid:SetSoundLevel(75)
					LtS = math.Remap( math.Clamp(math.min(aLevel/1.5, 45),1,45), 0, 100, 0, 1 )
				elseif pl == LocalPlayer() then
					soundid:SetSoundLevel(70)
					LtS = math.Remap( math.Clamp(math.min(aLevel,GetConVarNumber("actmod_cl_soundlevel")),5,100), 0, 100, 0, 1 )
				else
					soundid:SetSoundLevel(74)
					LtS = math.Remap( math.Clamp(math.min(aLevel,math.min(GetConVarNumber("actmod_cl_soundlevelother"),GetConVarNumber("actmod_sv_soundlevel"))),5,100), 0, 100, 0, 1 )
				end
				LtM = LtS
				soundid:PlayEx(LtS,math.Clamp(100 * A_AM.ActMod:GetFinalTimeScale(), 0, 255))
			else
				soundid:Stop()
				soundid = nil
			end
			A_AM.ActMod:C_AddSond(pl,SettoG,"Sond_Lc","_1",soundid,SSond,nil,soundmdl,LSo and LSo == "0" or pl.ALoopSOund ,nil,{aLevel,LtM},TSd) 
		end
	end
end

function A_AM.ActMod:A_aSond(pl,SSond,SettoG,aLevel,onSnd,LSo,afs)
	A_aSond(pl,SSond,SettoG,aLevel,onSnd,LSo,afs)
end



local function C_StopDance(pl)
	if not IsValid(pl) then return end
	hook.Run( "ActMod_RunStopAct_b" , pl )
    local GEIx = pl:EntIndex()
	if pl == LocalPlayer() then
		A_AM.ActMod:SetupStopAct()
		pl.ActMod_RLAng = 0
		pl.aaB22tat = 0
		if timer.Exists( "A_AM_ZCustomAngles_".. GEIx ) then timer.Remove( "A_AM_ZCustomAngles_".. GEIx ) end
		if IsValid(A_AM.ActMod.TauntCamera) then A_AM.ActMod.TauntCamera:Remove() end A_AM.ActMod.TauntCamera = nil
		pl:SetNWString("ActMod_aAng","")
		if isangle(pl.ActMod_GeetAng) then pl:SetEyeAngles(pl.ActMod_GeetAng) end
		pl.ActMod_GeetAng = nil
		pl.actmod_Coop_Tply = nil
		pl.actmod_Coop_ok = nil
		pl.AalowAnim_MForward = nil
		pl.rOn_MForward = 0
		pl.actmod_cl_tabPosAng = nil
		pl.ActMod_DontAlwAng = nil
		local cl_y,cl_s,cl_e,cl_l = 0,0,0,0
		if GetConVarNumber("actmod_cl_asyn") == 1 then cl_y = 1 end
		if GetConVarNumber("actmod_cl_sound") == 1 then cl_s = 1 end
		if GetConVarNumber("actmod_cl_effects") == 1 then cl_e = 1 end
		if GetConVarNumber("actmod_cl_loop") == 1 then cl_l = 1 elseif GetConVarNumber("actmod_cl_loop") == 2 then cl_l = 2 end
		net.Start( "A_AM.ActMod.ClToSv_Tab",true )
		 net.WriteTable( {"ActMod.CToS_ST","CToS_",{"wts_SEL",cl_s,cl_e,cl_l,cl_y}} )
		net.SendToServer()
		pl.AGSped_f = 0 pl.AGSped_b = 0
	end
	if pl.aSysTab and istable(pl.aSysTab) then pl.aSysTab["OneStart1"] = "_" pl.aSysTab["OneStart2"] = "_" pl.aSysTab["OneStart3"] = "_" end
	if timer.Exists( "AA_TEnd".. GEIx ) then timer.Remove( "AA_TEnd".. GEIx ) end
	if timer.Exists("AA_TJOne" .. GEIx) then timer.Remove("AA_TJOne" .. GEIx) end
	if timer.Exists("AA_TReSond" .. GEIx) then timer.Remove("AA_TReSond" .. GEIx) end
	if timer.Exists("AA_TStratA" .. GEIx) then timer.Remove("AA_TStratA" .. GEIx) end
	if timer.Exists("AA_TReA" .. GEIx) then timer.Remove("AA_TReA" .. GEIx) end
	if timer.Exists("AA_TMov" .. GEIx) then timer.Remove("AA_TMov" .. GEIx) end
	if timer.Exists("AA_TSTr" .. GEIx) then timer.Remove("AA_TSTr" .. GEIx) end
	if timer.Exists("AA_RLoop" .. GEIx) then timer.Remove("AA_RLoop" .. GEIx) end
	if timer.Exists("AA_RLoopAnim" .. GEIx) then timer.Remove("AA_RLoopAnim" .. GEIx) end
	if timer.Exists("AA_RLoopSond" .. GEIx) then timer.Remove("AA_RLoopSond" .. GEIx) end
	if timer.Exists( "A_AM.Mdl_1".. GEIx ) then timer.Remove( "A_AM.Mdl_1".. GEIx ) end
	if timer.Exists( "A_AM.Mdl_2".. GEIx ) then timer.Remove( "A_AM.Mdl_2".. GEIx ) end
	if timer.Exists( "A_AM.Mdl_3".. GEIx ) then timer.Remove( "A_AM.Mdl_3".. GEIx ) end
	if timer.Exists( "A_AM.Mdl_4".. GEIx ) then timer.Remove( "A_AM.Mdl_4".. GEIx ) end
    if timer.Exists("ActModAnimLSW_|" .. GEIx) then timer.Remove("ActModAnimLSW_|" .. GEIx) end
    if timer.Exists("ActModAnimSSW_|" .. GEIx) then timer.Remove("ActModAnimSSW_|" .. GEIx) end
	A_AM.ActMod:C_StopSond(pl,"1")
	A_AM.ActMod:C_StopSond(pl,"2")
	A_AM.ActMod:C_StopSond(pl,"3")
	A_AM.ActMod:RemoveCrMdl( pl,"*" )
	A_AM.ActMod:AA_RemoveAdd( pl,true )
	pl:SetCycle( 0 )
	pl.A_ActMod_GetDir = nil
	pl.aaBThinStrt = nil
	pl.ActMod_OneStart = nil
	pl.DEFiCycleWS = nil
	pl.ActMod_CurTRun = nil
	pl.ActMod_ReaginRunAct = nil
	pl.ActMod_TextNameAct = nil
	pl.ActMod_tActGetNJoing = nil
	hook.Run( "ActMod_RunStopAct" , pl )
end
function A_AM.ActMod.ChknOff(ply)
	C_StopDance(ply)
end

function A_AM.ActMod:Commt_Cl(ply,args)
	if A_AM.ActMod.Develop then print("[["..ply:Nick().."]]Commt_Cl  ",args[1],args[2],args[3],args[4]) end
	if args[1] == "SToC_aya" then
		if args[2] then
			A_AM.ActMod:StartSutEp(tonumber(args[2]))
			A_AM.ActMod.TablEditSounds = A_AM.ActMod:LoadifEdit()
		end
	elseif args[1] == "SetRAnim_TPly" then
		local pl = Entity( args[2] )
		local plT = Entity( args[3] )
		if pl and IsValid(pl) and pl:IsPlayer() then
			RunConsoleCommand( "r_flushlod" )
			local EIx = "AA_RAnim_KPly[TPly]"
			if timer.Exists( EIx ) then timer.Remove( EIx ) end
			timer.Create(EIx,0.5,1,function() if IsValid( pl ) then
			timer.Create(EIx,0.5,1,function() if IsValid( pl ) then
				A_AM.ActMod:Tast_SvToCl_restuo(pl, true)
			timer.Create(EIx,0.5,1,function() if IsValid( pl ) then
				if timer.Exists( EIx ) then timer.Remove( EIx ) end
				if IsValid(plT) and plT:IsPlayer() then
					net.Start( "A_AM.ActMod.ClToSv_Tab" )
					 net.WriteTable( {"ActMod.CToS_ST","CToS_",{"wts_SCTS","SetRAnim_KPly",plT:EntIndex()}} )
					net.SendToServer()
				end
			end end) end end) end end)
		end
	elseif args[1] == "SetRAnim_DPly" then
		local pl = LocalPlayer()
		local pll = Entity( args[2] )
		print(">Done[RAnim]_",pl,IsValid(pll) and pll)
		if IsValid(pl.Htxtrh) then pl.Htxtrh:Remove() end
	elseif args[1] == "aPlyEmot" then
		local pl = Entity( args[2] )
		if pl and IsValid(pl) and pl:IsPlayer() and args[3] and args[3] ~= "" then
			local atXt = args[3]
			if atXt ~= "" then
				local TtXt = string.Explode("|", atXt, true)
				if TtXt and istable(TtXt) and TtXt[2] then
					if atXt ~= "" then
						local TtXt = string.Explode("|", atXt, true)
						if TtXt and istable(TtXt) and TtXt[2] then
							pl:SetNWString("A_ActMod.Dir", TtXt[1]) pl:SetNWString("A_ActMod.TmpDir", TtXt[1])
							if TtXt[3] and TtXt[3] ~= "" then pl:SetNWString("A_ActMod_cl_actLoop", TtXt[3]) end
							pl:SetNWBool( "A_ActMod_IsActing", true )
							pl:SetNWString("A_ActMod.OneStart1",atXt)
							pl:SetNWString("A_ActMod.OneStart3",tostring("0|".. TtXt[2]))
							pl:SetNWString("A_ActMod.OneStart2",TtXt[2])
						end
					end
					pl.aaBThinStrt = nil
					if TtXt[13] and tonumber(TtXt[13]) > 0 then pl.aaBThinStrt = tonumber(TtXt[13]) end
					A_AM.ActMod:aPlyEmot(pl,atXt,1)
				end
			end
		end
	elseif args[1] == "aPlyGer" then
		local pl = Entity( args[2] )
		if pl and IsValid(pl) and pl:IsPlayer() and args[3] and args[3] ~= "" then
			local atXt = args[3]
			if atXt ~= "" then
				local TtXt = string.Explode("|", atXt, true)
				if TtXt and istable(TtXt) and TtXt[1] ~= "" and TtXt[2] then
					local TtXt_2
					if TtXt[2] then TtXt_2 = tonumber(TtXt[2]) end
					if (pl.aaGThinStrt and pl.aaGThinStrt < CurTime() or not pl.aaGThinStrt) then
						if isnumber(TtXt_2) and TtXt_2 > 0 then pl.aaGThinStrt = TtXt_2 else pl.aaGThinStrt = nil end
						A_AM.ActMod:aPlyGer(pl,atXt,TtXt)
					end
				end
			end
		end
	elseif args[1] == "SToC_SrCamr" then A_AM.ActMod:A_StCamer()
	elseif args[1] == "wtc_StartSond" then
		local pl
		if args[2] and isstring(args[2]) then pl = Entity( args[2] ) else pl = args[2] end
		if pl and IsValid(pl) then
			local SettoG,aLevel,onSnd = args[3],100,args[6] or "3"
			if args[5] then aLevel = tonumber(args[5]) end
			if SettoG == "-" then
				A_AM.ActMod:C_StopSond(pl,"1")
				A_AM.ActMod:C_StopSond(pl,"2")
				A_AM.ActMod:C_StopSond(pl,"3")
			end
			A_aSond(pl,args[4],SettoG,aLevel,onSnd,args[8],args[7])
		end
	elseif args[1] == "wts_StopSond" then
		local pl = Entity( args[2] )
		if pl and IsValid(pl) then
			local nor = args[3]
			if nor == "1" then A_AM.ActMod:C_StopSond(pl,"1")
			elseif nor == "2" then A_AM.ActMod:C_StopSond(pl,"2")
			elseif nor == "3" then A_AM.ActMod:C_StopSond(pl,"3")
			else A_AM.ActMod:C_StopSond(pl,"1") A_AM.ActMod:C_StopSond(pl,"2") A_AM.ActMod:C_StopSond(pl,"3")
			end
		end
	elseif args[1] == "CToS_Sond" then
		local pl = Entity( args[2] )
		if pl and IsValid(pl) and pl:IsPlayer() then
			A_AM.ActMod:C_StopSond(pl,"1")
			A_AM.ActMod:C_StopSond(pl,"2")
			A_AM.ActMod:C_StopSond(pl,"3")
		end
	elseif args[1] == "SToC_AJoing" then
		local pl = Entity( args[2] )
		local pl2 = Entity( args[3] )
		local Tab = args[4]
		if pl and IsValid(pl) and pl:IsPlayer() and pl2 and IsValid(pl2) and pl2:IsPlayer() then
			net.Start( "A_AM.ActMod.ClToSv_Tab" )
			 net.WriteTable( {"ActMod.CToS_ST","CToS_",{"CToS_AJoing",args[2],args[3],Tab,pl:GetModel()}} )
			net.SendToServer()
		end
	elseif args[1] == "SToC_AJoingF" then
		local pl = Entity( args[2] )
		local pl2 = Entity( args[3] )
		if pl and IsValid(pl) and pl:IsPlayer() then
			pl.ActMod_cam_tisp = CurTime() + 0.1
			pl.ActMod_TSndJ = CurTime() + 0.1
			pl.ActMod_GkTPlyTJn = nil
			pl.ActMod_GPl2TSndJ = nil
			pl.ActMod_GNamTSndJ = ""
		end
	elseif args[1] == "wtc_End" then
		local pl = Entity( args[2] )
		pl.ActMod_TimMenRe = CurTime() + 0.5
		if pl and IsValid(pl) and pl:IsPlayer() then
			C_StopDance(pl)
		end
	elseif args[1] == "wtc_FildEnd" then
		CLPrint(ply,"You can't stop now.")
	elseif args[1] == "StpGtur" then
		local tt1 = isstring(args[2]) and args[2] or string.format("._|%s|0",CurTime())
		if tt1 ~= "" then
			ply:SetNWString("A_ActMod.OneStart6",tt1)
			ply.aSysTab["OneStart6_ID"] = atXt
			ply.aSysTab["OneStart6"] = atXt ply.aaGThinStrt = nil
			A_AM.ActMod.GestureSystem:StopAllGestures(ply,0)
		end
	end
end

concommand.Add("actmod_wtc", function(ply, cmd, args)
	if IsValid(ply) and ply:IsPlayer() then
		local t = args[1]
		if t == "CToS_Sond" or t == "SetRAnim_TPly" or t == "SetRAnim_DPly" or t == "aPlyEmot" or t == "aPlyGer" or t == "SToC_AJoing" or t == "SToC_AJoingF" or t == "wtc_FildEnd" or t == "StpGtur" then
			A_AM.ActMod:Commt_Cl(ply,args)
		end
	end
end)

concommand.Add("actmod_stop", function(ply, cmd, args) if ply == LocalPlayer() then RunConsoleCommand("actmod_wts","wts_End") end end)
concommand.Add("actmod_stop_gesture", function(ply, cmd, args) if ply == LocalPlayer() and A_AM.ActMod.GestureSystem and A_AM.ActMod.GestureSystem.PlayGesture then RunConsoleCommand("actmod_wts","stpg") end end)

A_AM.ActMod.bessys_1_Done = true
