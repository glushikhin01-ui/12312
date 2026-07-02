if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaBas = true
A_AM.ActMod.svOn = true
A_AM.ActMod.Develop = false



function A_AM.ActMod:ATabData( tbl, str ,hlp )
	if tbl and tbl != "false" then
		for k, v in pairs( tbl ) do
			if hlp then print("Search_"..k.."->" ,v) end
			if str and v == str then return true end
		end
	end
	return false
end


function A_AM.ActMod:ATabDataGNum( tbl ,hlp )
	local GNum = 0
	if tbl and tbl != "false" then
		for k, v in pairs( tbl ) do
			if hlp then print("Search_"..k.."->" ,v) end
			GNum = GNum+1
		end
	end
	return GNum
end


function AAct_CreateSound(plt,sound,SettoG,soundlevel,soundpitch,sounddsp,LSo)
	local Strg = plt:GetNWString("A_ActMod.Dir", "") or ""
	if not CLIENT and (not sound or (plt:IsPlayer() and (Strg == "" or Strg == nil))) then return end
	if istable(sound) then
		if #sound > 1 then
			sound = sound[math.random(1,#sound)]
		else
			sound = sound[1]
		end
	end
	if CLIENT then
		local onSnd
		if plt.ActMod_tAb and plt.ActMod_tAb[2] then onSnd = tostring(plt.ActMod_tAb[2]) else onSnd = "0" end
		local sous,afs,alevel = "-","0",soundlevel or 100
		if SettoG then sous = SettoG end
		if plt.SVAct_Svsound then afs = "1" end
		local Splt = 0
		if plt:IsPlayer() then
			Splt = tostring(plt:EntIndex())
		else
			Splt = plt
		end
		local args = {
			[1] = "wtc_StartSond"
			,[2] = Splt
			,[3] = tostring(sous)
			,[4] = tostring(sound)
			,[5] = tostring(alevel)
			,[6] = tostring(onSnd)
			,[7] = tostring(afs)
			,[8] = tostring(LSo)
		}
		A_AM.ActMod:Commt_Cl(plt,args)
	end
end

function AAct_STOPSOUND(ply,nor)
	if IsValid(ply) then
		if CLIENT then
			local onSnd
			local sous,afs = "-","0"
			if nor then sous = nor end
			local args = {
				[1] = "wts_StopSond"
				,[2] = tostring(ply:EntIndex())
				,[3] = tostring(sous)
				,[3] = tostring(afs)
			}
			A_AM.ActMod:Commt_Cl(plt,args)
		end
	end
end

function A_IsL4DA(av)
	if ( av:GetNWBool( "L4DA.IsHntrAttPly" ) == true or av:GetNWBool( "L4DA.IsChargerAttPly" ) == true
	or av:GetNWBool( "L4DA.IsJockeyAttPly" ) == true or av:GetNWBool( "L4DA.IsSmokerAttPly" ) == true ) then
		return true
	end
	return false
end

function A_AM.ActMod:aIsRdy(ply)
	if IsValid( ply ) then
		return (ply.ActMod_TimMenRe or 0) < CurTime() and (ply:GetNWInt( "A_AM.ActTime", 0 ) > CurTime()+0.25 or ply:GetNWInt( "A_AM.ActTime", 0 ) == 0 or ply:GetNWInt( "A_AM.ActTime", 0 ) == -2)
	else
		return false
	end
end


local meta = FindMetaTable( "Player" )

function meta:ActMod_QEffects() return GetConVarNumber("actmod_cl_q_ef") end
function meta:trueShowMld(pl2) if IsValid(pl2) and EyePos():Distance(pl2:GetPos()) < GetConVarNumber("actmod_cl_viewdis") then return true end return false end
function meta:aGetFPSMld(pl2)
	if not self.actmod_tpmFPS then self.actmod_tpmFPS = 60 end
	if (self.actmod_TimrFPS or 0) < CurTime() then
		self.actmod_TimrFPS = CurTime() + 0.3
		local gfps = (1 / FrameTime())
		self.actmod_tpmFPS = gfps
	end
	if self.actmod_tpmFPS > 65 then
		return 7
	elseif self.actmod_tpmFPS > 59 then
		return 6
	elseif self.actmod_tpmFPS > 49 then
		return 5
	elseif self.actmod_tpmFPS > 39 then
		return 4
	elseif self.actmod_tpmFPS > 29 then
		return 3
	elseif self.actmod_tpmFPS > 19 then
		return 2
	elseif self.actmod_tpmFPS > 9 then
		return 1
	end
	return 0
end
function meta:A_ActModSound() return self:GetNWBool( "A_ActMod_cl_Sound", true ) end
function meta:A_ActModEffects() return self:GetNWBool( "A_ActMod_cl_Effects", true ) end
function meta:A_ActModASync() return self:GetNWBool( "A_ActMod_cl_ASync", true ) end
function meta:A_ActModLoop() return self:GetNWInt( "A_ActMod_cl_Loop", 2 ) end
function meta:A_ActModString() return self:GetNWString("A_ActMod_cl_actLoop", "" ) end
function meta:A_ActMod_IsActing()
	if SERVER then
		if self:GetNWInt( "A_AM.ActTime", 0 ) == -2 then
			self:SetNWBool( "A_ActMod_IsActing", true )
			return true
		else
			self:SetNWBool( "A_ActMod_IsActing", self:GetNWInt( "A_AM.ActTime", 0 ) >= CurTime() )
			return self:GetNWInt( "A_AM.ActTime", 0 ) >= CurTime()
		end
	elseif CLIENT then
		return self:GetNWBool( "A_ActMod_IsActing", false )
	end
end

function meta:A_ActMod_RateAct() return self:GetNWInt( "A_AM.ActRate", 1 ) end
function meta:A_ActMod_CycleAct() return self:GetNWInt( "A_AM.ActCycle", 0 ) end
function meta:A_ActMod_GetIsAct() return self:GetNWBool( "A_AM.ActMod.IsAct", false ) end
function meta:A_ActMod_CamParent() return self:GetNWBool( "A_AM.ActMod.Cam_Parent", false ) end
function meta:A_ActMod_CamInLerp() return self:GetNWInt( "A_AM.ActMod.CamInLerp", 5.0 ) end
function meta:A_ActMod_OnButtons() return self:GetNWBool( "A_AM.ActMod.OnButtons", false ) end
function meta:A_ActMod_GetMoveDir() return self:GetNWInt( "A_ActMod.MoveDir", 0 ) end
function meta:A_ActMod_GetWeapAct()
	if GetConVarNumber("actmod_sv_a_weapact") == 0 then return true end
	if GetConVarNumber("actmod_sv_a_weapact") > 1 and A_AM.ActMod:IsVR(self) then return true end
	if GetConVarNumber("actmod_sv_a_vehicles") == 1 and self:InVehicle() then return true end
	if GetConVarNumber("actmod_sv_a_weapact") > 0 and (self:GetActiveWeapon() and self:GetActiveWeapon():IsValid() and self:GetActiveWeapon():GetClass() == "aact_weapact") then return true end
	return false
end


function meta:A_ActMod_GetActDir()
	local ReNamAct = self:GetNWString("A_ActMod.Dir", "")
	if string.find(ReNamAct, ".png") then ReNamAct = string.Replace(ReNamAct,".png","") self:SetNWString("A_ActMod.Dir", ReNamAct) end
	if string.find(ReNamAct, "._c1_.") then ReNamAct = string.Replace(ReNamAct,"._c1_.","") self:SetNWString("A_ActMod.Dir", ReNamAct) self:SetNWBool( "A_AM.ActMod.AddC1", true ) end
	if string.find(ReNamAct, "._c2_.") then ReNamAct = string.Replace(ReNamAct,"._c2_.","") self:SetNWString("A_ActMod.Dir", ReNamAct) self:SetNWBool( "A_AM.ActMod.AddC2", true ) end
	if string.find(ReNamAct, "._mo_.") then ReNamAct = string.Replace(ReNamAct,"._mo_.","") self:SetNWString("A_ActMod.Dir", ReNamAct) self:SetNWBool( "A_AM.ActMod.AddMo", true ) end
	if string.find(ReNamAct, "._ef_.") then ReNamAct = string.Replace(ReNamAct,"._ef_.","") self:SetNWString("A_ActMod.Dir", ReNamAct) self:SetNWBool( "A_AM.ActMod.AddEf", true ) end
	if string.find(ReNamAct, "._so_.") then ReNamAct = string.Replace(ReNamAct,"._so_.","") self:SetNWString("A_ActMod.Dir", ReNamAct) self:SetNWBool( "A_AM.ActMod.AddSo", true ) end
	if self:A_ActMod_GetWeapAct() then return ( self:GetNWString("A_ActMod.Dir", "") ) end
	return ""
end

function meta:A_ActMod_GetActString_old(st)
	local ReNamAct = st or "-_none_-"
	if string.find(ReNamAct, ".png") then ReNamAct = string.Replace(ReNamAct,".png","") end
	if string.find(ReNamAct, "._c1_.") then ReNamAct = string.Replace(ReNamAct,"._c1_.","") self:SetNWBool( "A_AM.ActMod.AddC1", true ) end
	if string.find(ReNamAct, "._c2_.") then ReNamAct = string.Replace(ReNamAct,"._c2_.","") self:SetNWBool( "A_AM.ActMod.AddC2", true ) end
	if string.find(ReNamAct, "._mo_.") then ReNamAct = string.Replace(ReNamAct,"._mo_.","") self:SetNWBool( "A_AM.ActMod.AddMo", true ) end
	if string.find(ReNamAct, "._ef_.") then ReNamAct = string.Replace(ReNamAct,"._ef_.","") self:SetNWBool( "A_AM.ActMod.AddEf", true ) end
	if string.find(ReNamAct, "._so_.") then ReNamAct = string.Replace(ReNamAct,"._so_.","") self:SetNWBool( "A_AM.ActMod.AddSo", true ) end
	return ReNamAct
end

function A_AM.ActMod:A_ActMod_GetActString( st )
	st = st or "-_none_-"
	local tBl,itsG = {0,0,0,0,0},false
	if string.find(st, ".png") then st = string.Replace(st,".png","") end
	if string.find(st, "._c1_.") then st = string.Replace(st,"._c1_.","") tBl[1] = 1 end
	if string.find(st, "._c2_.") then st = string.Replace(st,"._c2_.","") tBl[2] = 1 end
	if string.find(st, "._mo_.") then st = string.Replace(st,"._mo_.","") tBl[3] = 1 end
	if string.find(st, "._ef_.") then st = string.Replace(st,"._ef_.","") tBl[4] = 1 end
	if string.find(st, "._so_.") then st = string.Replace(st,"._so_.","") tBl[5] = 1 end
	
	local ve = string.lower(A_AM.ActMod:ReString(st):gsub("%s+$", ""))
	local vt = "amod_cumact_".. ve
	vt = vt:gsub("%s+$", "")
	local GTabActO = A_AM.ActMod.GTabActO[vt]
	if GTabActO and GTabActO["GetName"] and GTabActO["ID_ACT"] and GTabActO["ID_ACT"] == ve then
		st = vt
	end
	local GTabActO = A_AM.ActMod.GTabActO[ve]
	if GTabActO and isnumber(GTabActO["NoStop"]) and GTabActO["NoStop"] == 63 then
		itsG = true
	end
	
	return {txt = st ,tBl = tBl ,itsG = itsG}
end

function A_AM.ActMod:AddBlacklistedDance(danceID, note ,ply)
    if not danceID or danceID == "" then return false end
	local aply = IsValid(ply) and ply:IsPlayer()
    self.Blacklist[danceID] = {
        n = note or nil,
        b = aply and ply:Nick() or "SYSTEM",
        i = aply and ply:SteamID64() or nil,
        t = os.time()
    }
	net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {">GSBListD",A_AM.ActMod.Blacklist} ) net.Broadcast()
    return true
end

function A_AM.ActMod:RemoveBlacklistedDance(danceID)
    if not self.Blacklist[danceID] then return false end
    self.Blacklist[danceID] = nil
	net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {">GSBListD",A_AM.ActMod.Blacklist} ) net.Broadcast()
    return true
end

function A_AM.ActMod:IsDanceBlacklisted(danceID) return self.Blacklist[danceID] ~= nil end
function A_AM.ActMod:GetBlacklistedNote(danceID) return self.Blacklist[danceID] and self.Blacklist[danceID].n end


function A_AM.ActMod:A_ActMod_GPCoop( ply )
	local atok,btok ,aOnHs,bOnHs ,aGHJn,bGHJn ,atxt,btxt = false,false ,false,false ,0,0 ,ply:Nick(),""
	local aStr,bStr = ply:GetNWString( "A_ActMod.TmpDir","" ),""
	if aStr ~= "" and ply:GetNWBool( "A_AM.ActMod.OnHimself", false ) and ply:GetNWInt( "A_ActMod.GetNJoing" ,0 ) > 0 and A_AM.ActMod.GTabActCoop[aStr] and A_AM.ActMod.GTabActCoop[aStr]["rAng"] then
		atok = true btxt = ply:Nick()
	end 
	if not atok and IsValid(ply.actmod_Coop_Tply) then
		local gply = ply.actmod_Coop_Tply
		bStr = gply:GetNWString( "A_ActMod.TmpDir","" )
		if bStr ~= "" and gply:GetNWBool( "A_AM.ActMod.OnHimself", false ) and gply:GetNWInt( "A_ActMod.GetNJoing" ,0 ) > 0 and A_AM.ActMod.GTabActCoop[bStr] and A_AM.ActMod.GTabActCoop[bStr]["rAng"] then
			btok = true btxt = gply:Nick()
		end
	end
	return (atok or btok)
end

function A_AM.ActMod:A_ActMod_OffTGem( ply,tup,jyou )
	if tup then
		if ply.a_TabPlysGem and istable(ply.a_TabPlysGem) and not table.IsEmpty(ply.a_TabPlysGem) then
			for k, TP in pairs(ply.a_TabPlysGem) do
				if k ~= "" then
					local TtXt = string.Explode("_#._", k, true)
					if TtXt and istable(TtXt) and TtXt[2] then
						if TP["Ply"] and IsValid(TP["Ply"]) and TP["Ply"]:SteamID64() == TtXt[1] and TP["Ply"]:Nick() == TtXt[2] then
							if TP["all_stop"] then
								A_AM.ActMod:A_ActMod_OffActing( TP["Ply"] )
							end
							TP["Ply"].a_TabPlysTem[ply:SteamID64() .."_#._"..ply:Nick()] = nil
							TP["Ply"]:SetNWInt( "A_ActMod.GetNJoing" ,A_AM.ActMod:A_ActMod_AGPTem( TP["Ply"] ) )
							ply.a_TabPlysGem[k] = nil
						end
					end
				end
			end
		end
	else
		if ply.a_TabPlysTem and istable(ply.a_TabPlysTem) and not table.IsEmpty(ply.a_TabPlysTem) then
			for k, TP in pairs(ply.a_TabPlysTem) do
				if k ~= "" then
					local TtXt = string.Explode("_#._", k, true)
					if TtXt and istable(TtXt) and TtXt[2] then
						if TP["Ply"] and IsValid(TP["Ply"]) and TP["Ply"]:SteamID64() == TtXt[1] and TP["Ply"]:Nick() == TtXt[2] and (not jyou or jyou and ply == TP["Ply"] ) then
							A_AM.ActMod:A_ActMod_OffActing( TP["Ply"] )
							ply.a_TabPlysTem[k] = nil
						end
					end
				end
			end
		end
		if istable(ply.aGetPlyjoing) and ply.aGetPlyjoing["T"] and ply.aGetPlyjoing["pl1"] then
			local pl2 = ply.aGetPlyjoing["pl1"]
			if IsValid(pl2) and istable(pl2.aGetPlyjoing) and pl2.aGetPlyjoing["Y"] and istable(pl2.aGetPlyjoing["aTab"]) then
				if IsValid(pl2.aGetPlyjoing["pl2"]) then
					pl2.aGetPlyjoing["pl2"].aGetPlyjoing = nil
				elseif istable(pl2.aGetPlyjoing["pl2"]) then
					for k, PlV in pairs(table.Copy(pl2.aGetPlyjoing["pl2"])) do
						if PlV == ply then
							PlV.aGetPlyjoing = nil
							table.RemoveByValue(pl2.aGetPlyjoing["pl2"],PlV)
						end
					end
				end
			end
		end
	end
end

function A_AM.ActMod:A_ActMod_falallTPKey( ply )
	if IsValid(ply) and istable(ply.actmod_TabPKey) then
		for k, v in pairs(ply.actmod_TabPKey) do
			ply.actmod_TabPKey[k] = false
		end
	end
end

function A_AM.ActMod:A_ActMod_OffActing( ply,nstp,tabAgb,OnlySv )
	if ply:A_ActMod_GetIsAct() ~= true then return end
	
	hook.Run( "ActMod_RunStopAct" , ply )
	
	ply.ActMod_OPT_VR = {}
	ply.AGSped_f = 0
	ply.AGSped_b = 0
	ply.DEFiCycleWS = nil
	ply.ActMod_OneStart = nil
	ply.ActMod_CurTRun = nil
	ply.ActMod_ReaginRunAct = nil
	ply.aaThinTrue = nil
	ply.aaThinStrt = nil
	ply.aaBThinStrt = nil
	ply.SVAct_Tsound = nil
	ply.SVAct_Svsound = nil
	ply.ActMod_ROne = nil
	ply.ActMod_JOne = nil
	ply.ActMod_JOneed = nil
	ply.AalowAnim = nil
	ply.AalowAnim_MForward = nil
	ply.rOn_MForward = 0
	ply.aCSound2 = nil
	ply.actmod_PlayerLockAngles = nil
	ply.actmod_Coop_Tply = nil
	ply.actmod_Coop_ok = nil
	ply.ActMod_DontAlwAng = nil
	ply.AActNFfct = 0
	ply.ActmodTSavOneStart1 = ply:GetNWString("A_ActMod.OneStart1","")
	ply:SetNWString("A_ActMod.Dir", "")
	ply:SetNWString("A_ActMod.TmpDir", "")
	ply:SetNWString("A_ActMod_cl_actLoop", "")
	ply:SetNWString("ActMod_aAng","")
	ply:SetNWString("a_SEyeCuAngles","")
	ply:SetCycle(0)
	ply:SetNWInt("a_SRLAngMove", 0)
	ply:SetNWInt("A_ActMod.MoveDir", 0)
	ply:SetNWAngle("A_ActMod_cl_vrAM_int",Angle(0,0,0))
	ply:SetNWInt("A_ActMod_cl_SysAM_Time",0)
	ply:SetNWBool( "A_AM.ActMod.OnHimself", false )
	ply:SetNWBool( "A_AM.ActRAgin", false )
	if not OnlySv then
		ply:SetNWString("A_ActMod.OneStart2",tostring(CurTime()))
	end
	ply:SetNWVector( "ply.AGSped_vel", Vector(0,0,0) )

	if nstp then
		ply:SetNWInt("A_AM.ActTime", -2)
	else
		ply:SetNWInt("A_AM.ActTime", 0)
		ply:SetNWBool("A_AM.ActMod.IsAct", false)
	end
	
    local GEIx = ply:EntIndex()
	if timer.Exists( "AA_TEnd"..GEIx ) then timer.Remove( "AA_TEnd"..GEIx ) end
	if timer.Exists("AA_TJOne" .. GEIx) then timer.Remove("AA_TJOne" .. GEIx) end
	if timer.Exists("AA_TReSond" .. GEIx) then timer.Remove("AA_TReSond" .. GEIx) end
	if timer.Exists( "AA_TStratA0"..GEIx ) then timer.Remove( "AA_TStratA0"..GEIx ) end
	if timer.Exists("AA_TStratA" .. GEIx) then timer.Remove("AA_TStratA" .. GEIx) end
	if timer.Exists("AA_TReA" .. GEIx) then timer.Remove("AA_TReA" .. GEIx) end
	if timer.Exists("AA_TMov" .. GEIx) then timer.Remove("AA_TMov" .. GEIx) end
	if timer.Exists("AA_TSTr" .. GEIx) then timer.Remove("AA_TSTr" .. GEIx) end
	if timer.Exists("AA_RLoop" .. GEIx) then timer.Remove("AA_RLoop" .. GEIx) end
	if timer.Exists("AA_RLoopAnim" .. GEIx) then timer.Remove("AA_RLoopAnim" .. GEIx) end
	if timer.Exists("AA_RLoopSond" .. GEIx) then timer.Remove("AA_RLoopSond" .. GEIx) end
	if timer.Exists( "A_AM.Mdl_1"..GEIx ) then timer.Remove( "A_AM.Mdl_1"..GEIx ) end
	if timer.Exists( "A_AM.Mdl_2"..GEIx ) then timer.Remove( "A_AM.Mdl_2"..GEIx ) end
	if timer.Exists( "A_AM.Mdl_3"..GEIx ) then timer.Remove( "A_AM.Mdl_3"..GEIx ) end
	if timer.Exists( "A_AM.Mdl_4"..GEIx ) then timer.Remove( "A_AM.Mdl_4"..GEIx ) end
	if timer.Exists( "A_AM_Add_C_1"..GEIx ) then timer.Remove( "A_AM_Add_C_1"..GEIx ) end
	if timer.Exists( "A_AM_Add_C_2"..GEIx ) then timer.Remove( "A_AM_Add_C_2"..GEIx ) end
	if timer.Exists( "A_AM_Add_C_3"..GEIx ) then timer.Remove( "A_AM_Add_C_3"..GEIx ) end
	if timer.Exists( "A_AM_Add_C_4"..GEIx ) then timer.Remove( "A_AM_Add_C_4"..GEIx ) end
	if timer.Exists( "AA_ttst"..GEIx ) then timer.Remove( "AA_ttst"..GEIx ) end
	if timer.Exists( "AA_ttst1"..GEIx ) then timer.Remove( "AA_ttst1"..GEIx ) end
	if timer.Exists( "AA_ttst2"..GEIx ) then timer.Remove( "AA_ttst2"..GEIx ) end
    if timer.Exists("ActModAniLSW_|" .. GEIx) then timer.Remove("ActModAnimLSW_|" .. GEIx) end
    if timer.Exists("ActModAnimSSW_|" .. GEIx) then timer.Remove("ActModAnimSSW_|" .. GEIx) end
	
	if SERVER then
		ply.ActMod_GStrg = ""
		ply.ActMod_tAb = nil
		ply.ActMod_Oall = nil
		ply.actmod_sv_OnlyoneNext = nil
		ply.ActMod_SECuAng = {TOK = 0 ,S_pitch = 0 ,S_yaw = 0 ,pitch = 0 ,yaw = 0}

		if istable(tabAgb) and isnumber(tabAgb[1]) and isnumber(tabAgb[2]) then
			ply:SetEyeAngles(Angle(tabAgb[1],tabAgb[2],0))
		elseif isangle(ply.ActMod_GeetAng) then
			ply:SetEyeAngles(ply.ActMod_GeetAng)
		end
		ply.ActMod_GeetAng = nil
		ply.TimeGo_Attk = nil

		if not nstp then
			if ply:GetActiveWeapon() and ply:GetActiveWeapon():IsValid() then
				local wep = ply:GetActiveWeapon()
				if IsValid(wep) and wep:GetClass() == "aact_weapact" then
					wep.offweap = true
					wep.ply = nil
					wep.Weapon.ply = nil
					if ply.A_oldWeap then
						ply:SelectWeapon(ply.A_oldWeap)
						ply:SetNWString( "A_AM.ActMod.GetWeap", "" )
						ply.A_oldWeap = nil
					end
					ply:StripWeapon(wep:GetClass())
					if wep:IsValid() then
						wep:Remove()
					end
				end
			end
		end
		
		A_AM.ActMod:A_ActMod_OffTGem( ply )
		A_AM.ActMod:A_ActMod_OffTGem( ply,true )
		A_AM.ActMod:A_EndJoing( ply )
		
		ply.a_TabPlysTem = {}
		ply.a_TabPlysGem = {}
		ply:SetNWInt( "A_ActMod.GetNJoing" ,0 )
		ply.A_ActModOKAct = nil
		ply.A_ActModOKAct_r = nil
		for _, pl in pairs(player.GetAll()) do
			if IsValid(pl) and !pl:IsBot() then
				pl:ConCommand("actmod_wtc wtc_End ".. GEIx .."\n")
			end
		end
		A_AM.ActMod:A_ActMod_falallTPKey( ply )
	end
	
	if CLIENT then
		
		ply.cl_aNameAct = ""
		ply.actmodstr = nil
		ply.actmod_AM_timSnd = nil
		ply.ActMod_RLAng = 0
		ply.ActMod_AddTRuh_Enum = 0
		ply.actmod_AMholdNext = 0
		ply.actmod_AMtimeNext = 0
		ply.ActMod_Cam_SavAng = nil
		ply.ActMod_TimMenRe = CurTime() + 0.5
		ply.ActMod_cam_tisp = CurTime() + 0.2
		ply.ActMod_TSndJ = CurTime()
		if timer.Exists( "actmod_AutoRemoveNamePly2" ) then timer.Remove( "actmod_AutoRemoveNamePly2" ) end
		ply.ActMod_GkTPlyTJn = nil
		ply.ActMod_GPl2TSndJ = nil
		ply.ActMod_GNamTSndJ = ""
		ply.ActMod_SECuAng_cl = {TOK = 0 ,S_pitch = 0 ,S_yaw = 0 ,pitch = 0 ,yaw = 0}
		if ply == LocalPlayer() then
			A_AM.ActMod.a_actmod_wassed = false
			local cl_s,cl_e,cl_l,cl_y = 0,0,0,0
			
			if GetConVarNumber("actmod_cl_sound") == 1 then
				ply:SetNWBool("A_ActMod_cl_Sound", true)
				cl_s = 1
			else
				ply:SetNWBool("A_ActMod_cl_Sound", false)
			end

			if GetConVarNumber("actmod_cl_effects") == 1 then
				ply:SetNWBool("A_ActMod_cl_Effects", true)
				cl_e = 1
			else
				ply:SetNWBool("A_ActMod_cl_Effects", false)
			end

			if GetConVarNumber("actmod_cl_asyn") == 1 then
				ply:SetNWBool("A_ActMod_cl_ASync", true)
				cl_y = 1
			else
				ply:SetNWBool("A_ActMod_cl_ASync", false)
			end

			if GetConVarNumber("actmod_cl_loop") == 1 then
				ply:SetNWInt("A_ActMod_cl_Loop", 1)
				cl_l = 1
			elseif GetConVarNumber("actmod_cl_loop") == 2 then
				ply:SetNWInt("A_ActMod_cl_Loop", 2)
				cl_l = 2
			else
				ply:SetNWInt("A_ActMod_cl_Loop", 0)
			end
			
			net.Start( "A_AM.ActMod.ClToSv_Tab" )
			 net.WriteTable( {"ActMod.CToS_ST","CToS_",{"wts_SEL",cl_s,cl_e,cl_l,cl_y}} )
			net.SendToServer()
			
			if IsValid(A_AM.ActMod.TauntCamera) then A_AM.ActMod.TauntCamera:Remove() end
			A_AM.ActMod.TauntCamera = nil
			ply.A_ActMod_GetDir = nil
		end
		ply:SetCycle(0)
	end

	A_AM.ActMod:AA_RemoveAdd( ply )
end

function A_AM.ActMod:A_ActMod_GetOtherF( ply )
	if not ply:A_ActMod_GetWeapAct() then return true end
	if (prone and (ply:GetNW2Int("prone.AnimationState", 3) ~= 3 or ply:GetNWInt("prone.AnimationState", 3) ~= 3)) or (wOS and wOS.LastStand and ply:WOSGetIncapped()) or ply:GetNWBool( "wOS.LS.IsGetIncapped",false ) == true then return true end
	if ( ply:GetNWBool( "L4DA.IsHntrAttPly" ) == true or ply:GetNWBool( "L4DA.IsChargerAttPly" ) == true or ply:GetNWBool( "L4DA.IsJockeyAttPly" ) == true or ply:GetNWBool( "L4DA.IsSmokerAttPly" ) == true ) then return true end
	return false
end

function A_AM.ActMod:EndAct( ply )
	A_AM.ActMod:A_ActMod_OffActing( ply )
end

function A_AM.ActMod:A_ActMod_GetActC12(st)
	st = st or "-_none_-"
	local tBl = {0,0,0,0,0}
	if string.find(st, "._c1_.") then tBl[1] = 1 end
	if string.find(st, "._c2_.") then tBl[2] = 1 end
	if string.find(st, "._mo_.") then tBl[3] = 1 end
	if string.find(st, "._ef_.") then tBl[4] = 1 end
	if string.find(st, "._so_.") then tBl[5] = 1 end
	return tBl
end



function A_AM.ActMod:A_cshk( pl,pl2,aTab,aForward,aRight,calback )
	local aForward,aRight,addnum = 0,0,0
	if aTab["TryFixPos"] and istable(aTab["TryFixPos"]) then
		local ETab = aTab["TryFixPos"]
		local Angl = Angle(0,0,0)
		if aTab["rAng"] and aTab["r180"] then Angl = Angle(0,180,0) end
		local aPos1 = Vector(aForward,aRight,0)
		local aVtr,aAng,bVtr,bAng,aAni1,aAni2,aCyc,aBip1,aBip2 = Vector(0,0,0),Angle(0,0,0),Vector(0,0,0),Angle(0,0,0),"","",0,"",""
		if ETab["aVtr"] then aVtr = ETab["aVtr"] end if ETab["bVtr"] then bVtr = ETab["bVtr"] else bVtr = aPos1 end
		if ETab["aAng"] then aAng = ETab["aAng"] end if ETab["bAng"] then bAng = ETab["bAng"] else bAng = Angl end
		if ETab["Ani1"] then aAni1 = ETab["Ani1"] end if ETab["Ani2"] then aAni2 = ETab["Ani2"] end
		if ETab["Cycl"] then aCyc = ETab["Cycl"] end
		if ETab["Bip1"] then aBip1 = ETab["Bip1"] end if ETab["Bip2"] then aBip2 = ETab["Bip2"] end
		addnum = A_AM.ActMod:C2BoneAniDistance( pl,pl2 ,aVtr,aAng ,bVtr,bAng ,aAni1,aAni2,aCyc,aBip1,aBip2 ,nil,nil ,nil,nil,ETab["ShowFix"] )
		if ETab["+add"] then addnum = addnum+ETab["+add"] end
		if ETab["-add"] then addnum = addnum-ETab["-add"] end
		if ETab["/add"] then addnum = addnum/ETab["/add"] end
		if ETab["*add"] then addnum = addnum*ETab["*add"] end
		if ETab["add+"] then addnum = addnum+ETab["add+"] end
		local u = false
		if (A_AM.ActMod:AA_SubMF( pl,"M",u ) and A_AM.ActMod:AA_SubMF( pl2,"M",u )) or (A_AM.ActMod:AA_SubMF( pl,"F",u ) and A_AM.ActMod:AA_SubMF( pl2,"F",u )) then
			if ETab["add+_m"] then
				if A_AM.ActMod:AA_SubMF( pl,"M",u ) then addnum = addnum+ETab["add+_m"]*0.5 end
				if A_AM.ActMod:AA_SubMF( pl2,"M",u ) then addnum = addnum+ETab["add+_m"]*0.5 end
			end
			if ETab["add+_f"] then
				if A_AM.ActMod:AA_SubMF( pl,"F",u ) then addnum = addnum+ETab["add+_f"]*0.5 end
				if A_AM.ActMod:AA_SubMF( pl2,"F",u ) then addnum = addnum+ETab["add+_f"]*0.5 end
			end
		else
			if ETab["add+_m"] then
				if A_AM.ActMod:AA_SubMF( pl,"M",u ) then addnum = addnum+ETab["add+_m"] end
				if A_AM.ActMod:AA_SubMF( pl2,"M",u ) then addnum = addnum+ETab["add+_m"] end
			end
			if ETab["add+_f"] then
				if A_AM.ActMod:AA_SubMF( pl,"F",u ) then addnum = addnum+ETab["add+_f"] end
				if A_AM.ActMod:AA_SubMF( pl2,"F",u ) then addnum = addnum+ETab["add+_f"] end
			end
		end
		if ETab["add+_m_p1"] then if A_AM.ActMod:AA_SubMF( pl,"M",u ) then addnum = addnum+ETab["add+_m_p1"] end end
		if ETab["add+_m_p2"] then if A_AM.ActMod:AA_SubMF( pl2,"M",u ) then addnum = addnum+ETab["add+_m_p2"] end end
		if ETab["add+_f_p1"] then if A_AM.ActMod:AA_SubMF( pl,"F",u ) then addnum = addnum+ETab["add+_f_p1"] end end
		if ETab["add+_f_p2"] then if A_AM.ActMod:AA_SubMF( pl2,"F",u ) then addnum = addnum+ETab["add+_f_p2"] end end
		if ETab["AutoAdd"] then
			if istable(ETab["AutoAdd"]) then
				if ETab["AutoAdd"]["Type"] == "Distance and Length" then
					local CTab = ETab["AutoAdd"]
					local aAni,bAni,aCyc,bCyc,aBip1,bBip1,aBip2,bBip2 = "","" ,0,0 ,"","" ,"",""
					if CTab["aAni"] then aAni = CTab["aAni"] end if CTab["bAni"] then bAni = CTab["bAni"] end
					if CTab["aCyc"] then aCyc = CTab["aCyc"] end if CTab["bCyc"] then bCyc = CTab["bCyc"] end
					if CTab["aBip1"] then aBip1 = CTab["aBip1"] end if CTab["bBip1"] then bBip1 = CTab["bBip1"] end
					if CTab["aBip2"] then aBip2 = CTab["aBip2"] end if CTab["bBip2"] then bBip2 = CTab["bBip2"] end
					local aly1num = A_AM.ActMod:CBoneAniDistance( pl ,aAni,aCyc,aBip1,bBip1 )
					local aly2num = A_AM.ActMod:CBoneAniDistance( pl2 ,bAni,bCyc,aBip2,bBip2 )
					local alynum = Vector( 0,0,aly1num ):Distance( Vector( 0,0,aly2num ) )
					if aly1num ~= aly2num then
						if ETab["AutoAdd"]["p1<p2"] and aly1num < aly2num then
							addnum = addnum-( alynum* ETab["AutoAdd"]["p1<p2"] )
						elseif ETab["AutoAdd"]["p1>p2"] and aly1num > aly2num then
							addnum = addnum-( alynum* ETab["AutoAdd"]["p1>p2"] )
						end
					end
				end
			else
				if A_AM.ActMod:AA_SubMF( pl,"F" ) then
					if A_AM.ActMod:AA_SubMF( pl2,"F" ) then addnum = addnum/3 else addnum = addnum/4 end
				else
					if A_AM.ActMod:AA_SubMF( pl2,"F" ) then addnum = addnum/3 else addnum = addnum/4 end
				end
			end
		end
		if (A_AM.ActMod:AA_SubMF( pl,"F",u ) or A_AM.ActMod:AA_SubMF( pl2,"F",u )) then addnum = addnum*0.97 end
		if ETab["-Forward"] then aForward = aForward-addnum end
		if ETab["+Forward"] then aForward = aForward+addnum end
		if ETab["-Right"] then aRight = aRight-addnum end
		if ETab["+Right"] then aRight = aRight+addnum end
	end
	calback(aForward,aRight,addnum)
end

function A_AM.ActMod:A_AStupTab( ply )
	local GTabAct,aredy,aAllowOk
	if A_AM.ActMod.AGetDitN then
		GTabAct = A_AM.ActMod.AGetDitN[math.Round(math.Rand( 1, 37 ))]
	else
		GTabAct = "taunt_dance.png"
	end
	if ply:IsBot() then
		aredy = true
		aAllowOk = true
	else
		if ply.ActMod_TC_TblPly then
			aredy = ply.ActMod_TC_TblPly["GetReady"]
			aAllowOk = ply.ActMod_TC_TblPly["AllowOk"]
		else
			aredy = false
			aAllowOk = false
		end
	end
	ply.ActMod_TC_TblPly = {
		["Ply"] = ply
		,["GetReady"] = aredy
		,["AllowOk"] = aAllowOk
		,["NameAct"] = GTabAct
		,["GetTeamPly"] = ""
		,["GetTeamName"] = ""
		,["SetNameTeam"] = "n_o_n_e"
		,["id64Team"] = ""
		,["GetTabPlayers"] = {}
		,["GetTabPlysNow"] = {}
		,["GetTabGpsNow"] = {}
		,["SetLockTeam"] = false
		,["SetOwneTeam"] = false
		,["TouAre"] = "Main"
		,["TPly"] = ""
		,["TPly_ChAct"] = ""
		,["TPly_InTID"] = ""
	}
end

A_AM.ActMod.ActLck = {
	["Avs_a1_1"] = { ["T1"]= "amod_fortnite_rememberme.png" ,["T2"]= "" }
	,["Avs_a1_2"] = { ["T1"]= "amod_fortnite_tonal.png" ,["T2"]= "" }
	,["Avs_a1_3"] = { ["T1"]= "amod_fortnite_selenecobra.png" ,["T2"]= "un1412" }
	,["Avs_a2_1"] = { ["T1"]= "amod_fortnite_dance_distraction.png" ,["T2"]= "" }
	,["Avs_a2_2"] = { ["T1"]= "amod_fortnite_zebrascramble.png" ,["T2"]= "" }
	,["Avs_a2_3"] = { ["T1"]= "amod_fortnite_jumpstyledance.png" ,["T2"]= "" }
	,["Avs_a2_4"] = { ["T1"]= "amod_mmd_dance_nostalogic.png" ,["T2"]= "un421" }
	,["Avs_a2_5"] = { ["T1"]= "amod_mmd_s007.png" ,["T2"]= "unam421" }
	,["Avs_a2_6"] = { ["T1"]= "amod_mmd_phao2phuthon_p1.png" ,["T2"]= "" }
	,["Avs_a2_7"] = { ["T1"]= "amod_mmd_nyaarigato.png" ,["T2"]= "" }
	,["Avs_a2_8"] = { ["T1"]= "amod_fortnite_griddle.png" ,["C1"]= "amod_fortnite_griddle_walk.png" ,["T2"]= "" }
	,["Avs_a2_9"] = { ["T1"]= "amod_fortnite_walkywalk.png" ,["C1"]= "amod_fortnite_walkywalk_walk.png" ,["T2"]= "" }
	,["Avs_a3_1"] = { ["T1"]= "amod_fortnite_sunlit.png" ,["T2"]= "un85" }
	,["Avs_a3_2"] = { ["T1"]= "amod_mmd_ghostdance.png" ,["T2"]= "" }
	,["Avs_a3_3"] = { ["T1"]= "amod_mmd_chikichiki.png" ,["T2"]= "" }
	,["Avs_a3_4"] = { ["T1"]= "amod_am4_sambadancingfull.png" ,["T2"]= "" }
	,["Avs_a3_5"] = { ["T1"]= "amod_fortnite_canine.png" ,["T2"]= "" }
	,["Avs_a3_6"] = { ["T1"]= "amod_fortnite_dignified.png" ,["T2"]= "" }
	,["Avs_a3_7"] = { ["T1"]= "amod_pubg_seetinh.png" ,["T2"]= "" }
	,["Avs_a3_8"] = { ["T1"]= "amod_drip_01.png" ,["T2"]= "" }
	,["Avs_a3_9"] = { ["T1"]= "amod_mmd_drunkendutterfly.png" ,["T2"]= "" }
	,["Avs_a4_1"] = { ["T1"]= "amod_fortnite_studs.png" ,["T2"]= "" }
	,["Avs_a4_2"] = { ["T1"]= "amod_fortnite_ringer.png" ,["C1"]= "amod_fortnite_ringer_walk.png" ,["T2"]= "" }
	,["Avs_a4_3"] = { ["T1"]= "amod_mmd_pokedance.png" ,["T2"]= "" }
	,["Avs_a4_4"] = { ["T1"]= "amod_fortnite_patpat_intro.png" ,["T2"]= "" }
}

function A_AM.ActMod:BoneExists(ent, bone)
	if not IsValid(ent) then
		return nil
	end
	if isnumber(bone) then
		local boneCount = ent:GetBoneCount() or 0
		if bone >= 0 and bone < boneCount then
			return bone
		else
			return nil
		end
	end
	if isstring(bone) then
		local boneIndex = ent:LookupBone(bone)
		if boneIndex and boneIndex >= 0 then
			return ent:LookupBone(bone)
		else
			return nil
		end
	end
	return nil
end

function A_AM.ActMod:ConvertTimeToCycle(currentTime, animationDuration, isLooping)
    if animationDuration <= 0 then
        return 0
    end
    local cycle
    if isLooping then
        local timeInAnim = currentTime % animationDuration
        cycle = timeInAnim / animationDuration
    else
        cycle = math.Clamp(currentTime / animationDuration, 0, 1)
    end
    return cycle
end

function A_AM.ActMod:ConvertCycleToTime(cycle, animationDuration)
    if animationDuration <= 0 then
        return 0
    end
    cycle = math.Clamp(cycle, 0, 1)
    local time = cycle * animationDuration
    return time
end

function A_AM.ActMod:SortNumbers(tbl, reverse)
    table.sort(tbl, function(a, b) return reverse and a > b or a < b end)
    return tbl
end
function A_AM.ActMod:CopyAndSort(tbl, reverse)
	local copy = table.Copy(tbl)
	table.sort(copy, function(a, b) return reverse and a > b or a < b end)
	return copy
end

function A_AM.ActMod:GBonePosAng( ent,NBone )
	if not IsValid(ent) or not NBone then return end
	local bid,pos,ang = "",Vector(),Angle()
	if isstring(NBone) then bid = ent:LookupBone( NBone ) elseif isstring(NBone) then bid = ent:LookupBone( NBone ) end
	if not isnumber(bid) then return pos,ang,false end
	local m = ent:GetBoneMatrix(bid)
	if m then
		pos = m:GetTranslation()
		ang = m:GetAngles()
	else
		local tpos, tang = ent:GetBonePosition(bid)
		if tpos then
			pos = tpos
			ang = tang
		end
	end
	return pos,ang,true
end

function A_AM.ActMod:CBoneAniDistance( ply ,saq_,SCycle ,naP_1,naP_2 ,tuTab ,Autclmdl )
	SCycle = SCycle or 0
	local t1_1 = 0
	local entity_1
	local aID = string.format("saMd_%s_r%s|%s_c%s",ply:EntIndex(),math.Rand(-10,10),math.Rand(1,10),CurTime())
	local aamdl = ply:GetModel()
	if SERVER then
		if not Autclmdl and IsValid(ply) and ply:IsPlayer() and ply.aenforce_model then aamdl = ply.aenforce_model end
		entity_1 = ents.Create("base_anim")
		entity_1:SetModel(aamdl)
	else
		entity_1 = ClientsideModel(aamdl, RENDERGROUP_BOTH)
	end
	if IsValid(entity_1) then
		entity_1:DrawShadow( false ) entity_1:SetNoDraw( true )
		if CLIENT then
			A_AM.ActMod.GRTSYS.TMDL[aID .."|1"] = entity_1
			entity_1:SetColor(Color(0, 0, 0, 1)) entity_1:SetRenderMode(RENDERMODE_TRANSALPHA) entity_1:SetMaterial("Models/effects/vol_light001")
		end
		if timer.Exists( aID ) then timer.Remove( aID ) end
		timer.Create(aID,0.1,1,function() if IsValid( ply ) then if IsValid( entity_1 ) then entity_1:Remove() end end end)
		entity_1:SetCycle( SCycle ) entity_1:SetPlaybackRate( 0 )
		local seq0_1 = entity_1:LookupSequence( "reference" )
		local seq1_1 = entity_1:LookupSequence( saq_ or "nil_" )
		local seq_1 = seq1_1
		local tab = {}
		if seq1_1 <= 0 then seq_1 = seq0_1 end
		entity_1:ResetSequence(seq_1) entity_1:SetCycle( SCycle ) entity_1:SetPlaybackRate( 0 )
		if isstring(naP_1) and isstring(naP_2) then
			if naP_2 == "Vector()" then
				local PP_1 = entity_1:LookupBone(naP_1)
				if PP_1 then
					t1_1 = entity_1:GetBonePosition(PP_1):Distance( Vector() )
					if tuTab then
						tab["t1_1"] = t1_1
						tab["VectorUp_1-2"] = entity_1:GetBonePosition(PP_1):Distance( Vector(0,0,entity_1:GetBonePosition(PP_1).z) )
						tab["VectorUp_1-0"] = entity_1:GetBonePosition(PP_1):Distance( Vector(entity_1:GetBonePosition(PP_1).x,entity_1:GetBonePosition(PP_1).y,0) )
						tab["ang_1"] = ( entity_1:GetBonePosition(PP_1) - Vector() ):Angle()
						tab["ang_2"] = ( Vector() - entity_1:GetBonePosition(PP_1) ):Angle()
					end
				end
			else
				local PP_1,PP_2 = entity_1:LookupBone(naP_1),entity_1:LookupBone(naP_2)
				if PP_1 and PP_2 then
					t1_1 = entity_1:GetBonePosition(PP_1):Distance( entity_1:GetBonePosition(PP_2) )
					if tuTab then
						tab["t1_1"] = t1_1
						tab["ang_1"] = ( entity_1:GetBonePosition(PP_1) - entity_1:GetBonePosition(PP_2) ):Angle()
						tab["ang_2"] = ( entity_1:GetBonePosition(PP_2) - entity_1:GetBonePosition(PP_1) ):Angle()
					end
				end
			end
			if IsValid( entity_1 ) then entity_1:Remove() end
			if timer.Exists( aID ) then timer.Remove( aID ) end
			if tuTab then
				return tab
			else
				return t1_1
			end
		end
	end
	if IsValid( entity_1 ) then entity_1:Remove() end
	if timer.Exists( aID ) then timer.Remove( aID ) end
	if tuTab then return {} else return 0 end
end
local _1I1l=string.char;function A_AM.ActMod.DtDat(O0,O1) local lI=_G[_1I1l(117,116,105,108)][_1I1l(66,97,115,101,54,52,68,101,99,111,100,101)](O0) if not lI or lI==""then return nil end;local Il={};local l1=_G[_1I1l(115,116,114,105,110,103)][_1I1l(108,101,110)](O1);for II=1,_G[_1I1l(115,116,114,105,110,103)][_1I1l(108,101,110)](lI)do Il[II]=_1I1l(_G[_1I1l(98,105,116)][_1I1l(98,120,111,114)](_G[_1I1l(115,116,114,105,110,103)][_1I1l(98,121,116,101)](lI,II),_G[_1I1l(115,116,114,105,110,103)][_1I1l(98,121,116,101)](O1,((II-1)%l1)+1)))end;return _G[_1I1l(116,97,98,108,101)][_1I1l(99,111,110,99,97,116)](Il) end
function A_AM.ActMod.AGServro(ply,trry)
	trry = isnumber(trry) and trry + 1 or 0
	local ReHF = ""
	if trry == 0 then
		ReHF = A_AM.ActMod:FHTxt("ht[[!@|!!|||!!!#!..@VersionAddonsAM4#!m!#ActMod@DatAcMd_98")
	elseif trry == 1 then
		ReHF = A_AM.ActMod:FHTxt("ht[[!@|!!|||!!!#||actmod#da98")
	else
		ReHF = "https://bit.ly/aghb98"
	end
	http.Fetch(ReHF, function(body, _, _, code)
		if isstring(body) and string.len(body) > 10 then
			local tcommit = util.JSONToTable(body)
			if istable(tcommit) and isstring(tcommit.V) and isstring(tcommit.A) then
				local axt,commit = A_AM.ActMod.DtDat(tcommit.A,A_AM.ActMod:FHTxt("~gt`")),""
				if isstring(axt) then commit = util.JSONToTable(axt) end
				if istable(commit) and commit.V and isstring(commit.By) then
					if string.sub(commit.By, 1, 12) == "AhmedMake400" then
						if CLIENT then
							A_AM.ActMod.ClServroC(ply,commit)
						else
							if istable(commit.abtk) then
								A_AM.ActMod.Actbtk_sv = {}
								for k, v in pairs(commit.abtk) do A_AM.ActMod.Actbtk_sv[k] = v end
							end
						end
						if istable(commit.adons) then A_AM.ActMod.Aadons = commit.adons end
					else
						if trry < 2 then A_AM.ActMod.AGServro(ply,trry) elseif CLIENT then A_AM.ActMod.ClServroF(ply,true) end
					end
				else
					if trry < 2 then A_AM.ActMod.AGServro(ply,trry) elseif CLIENT then A_AM.ActMod.ClServroF(ply,true) end
				end
			else
				if trry < 2 then A_AM.ActMod.AGServro(ply,trry) elseif CLIENT then A_AM.ActMod.ClServroF(ply,true) end
			end
		else
			if trry < 2 then A_AM.ActMod.AGServro(ply,trry) elseif CLIENT then A_AM.ActMod.ClServroF(ply,true) end
		end
	end, function(a1,a2,a3)
		if trry < 2 then A_AM.ActMod.AGServro(ply,trry) elseif CLIENT then A_AM.ActMod.ClServroF(ply,true) end
	end )
end

function A_AM.ActMod:C2BoneAniDistance( ply,pl2 ,pos1,ang1,pos2,ang2 ,saq_,saq_2,SCycle ,naP_1,naP_2 ,Sc1,Sc2 ,tuTab,callback,tshowFix ,Autclmdl,Autclmdl2 )
	SCycle = SCycle or 0
	local t1_1 = 0
	local entity_1,entity_2
	local aID = string.format("saMdl_%s_r%s|%s_c%s",ply:EntIndex(),math.Rand(-10,10),math.Rand(1,10),CurTime())
	local aamdl = isstring(ply) and ply or ply:GetModel()
	local aamdl2 = isstring(pl2) and pl2 or pl2:GetModel()
	if SERVER then
		if not Autclmdl and IsValid(ply) and ply:IsPlayer() and ply.aenforce_model then aamdl = ply.aenforce_model end
		if not Autclmdl2 and IsValid(pl2) and pl2:IsPlayer() and pl2.aenforce_model then aamdl2 = pl2.aenforce_model end
		entity_1 = ents.Create("base_anim")
		entity_1:SetModel( aamdl )
		entity_2 = ents.Create("base_anim")
		entity_2:SetModel( aamdl2 )
	else
		entity_1 = ClientsideModel(aamdl, RENDERGROUP_BOTH)
		entity_2 = ClientsideModel(aamdl2, RENDERGROUP_BOTH)
	end
	if IsValid(entity_1) and IsValid(entity_2) then
		if Sc1 then entity_1:SetModelScale( Sc1 ) end if Sc2 then entity_2:SetModelScale( Sc2 ) end
		if CLIENT then
			A_AM.ActMod.GRTSYS.TMDL[aID .."|1"] = entity_1
			A_AM.ActMod.GRTSYS.TMDL[aID .."|2"] = entity_2
		end
		if timer.Exists( aID ) then timer.Remove( aID ) end
		timer.Create(aID ,((tshowFix and (callback and math.max(tshowFix,0.25) or not callback and tshowFix) or callback and 0.25) or 0.1),1,function() if IsValid( ply ) then
			if IsValid( entity_1 ) then entity_1:Remove() end
			if IsValid( entity_2 ) then entity_2:Remove() end
			if timer.Exists( aID ) then timer.Remove( aID ) end
		end end)
		if pos1 and isvector(pos1) then entity_1:SetPos(pos1) end if ang1 and isangle(ang1) then entity_1:SetAngles(ang1) end
		if pos2 and isvector(pos2) then entity_2:SetPos(pos2) end if ang2 and isangle(ang2) then entity_2:SetAngles(ang2) end
		if tshowFix then
			entity_1:DrawShadow( true ) entity_1:SetNoDraw( false ) entity_2:DrawShadow( true ) entity_2:SetNoDraw( false )
		else
			entity_1:DrawShadow( false ) entity_1:SetNoDraw( true ) entity_2:DrawShadow( false ) entity_2:SetNoDraw( true )
			entity_1:SetColor(Color(0, 0, 0, 1)) entity_1:SetRenderMode(RENDERMODE_TRANSALPHA) entity_1:SetMaterial("Models/effects/vol_light001")
			entity_2:SetColor(Color(0, 0, 0, 1)) entity_2:SetRenderMode(RENDERMODE_TRANSALPHA) entity_2:SetMaterial("Models/effects/vol_light001")
		end
		entity_1:SetCycle( SCycle ) entity_1:SetPlaybackRate( 0 )
		local tab = {}
		local seq0_1 = entity_1:LookupSequence( "reference" )
		local seq1_1 = entity_1:LookupSequence( saq_ )
		local seq_1 = seq1_1
		if seq1_1 <= 0 then seq_1 = seq0_1 end
		entity_2:SetCycle( SCycle ) entity_2:SetPlaybackRate( 0 )
		local seq0_2 = entity_2:LookupSequence( "reference" )
		local seq1_2 = entity_2:LookupSequence( saq_2 or saq_ )
		local seq_2 = seq1_2
		if seq1_2 <= 0 then seq_1 = seq0_2 end
		entity_1:ResetSequence(seq_1) entity_1:SetCycle( SCycle ) entity_1:SetPlaybackRate( 0 )
		entity_2:ResetSequence(seq_2) entity_2:SetCycle( SCycle ) entity_2:SetPlaybackRate( 0 )
		if naP_1 and naP_2 then
			local PP_1,PP_2 = entity_1:LookupBone(naP_1),entity_2:LookupBone(naP_2)
			if PP_1 and PP_2 then
				t1_1 = entity_1:GetBonePosition(PP_1):Distance( entity_2:GetBonePosition(PP_2) )
				if tuTab then
					tab["t1_1"] = t1_1
					tab["VectorUp_1-2"] = entity_1:GetBonePosition(PP_1):Distance( Vector(0,0,entity_1:GetBonePosition(PP_1).z) )
					tab["ang_1"] = ( entity_1:GetBonePosition(PP_1) - entity_2:GetBonePosition(PP_2) ):Angle()
					tab["ang_2"] = ( entity_2:GetBonePosition(PP_2) - entity_1:GetBonePosition(PP_1) ):Angle()
					local pos_1 = entity_1:GetBonePosition( PP_1 )
					local pos_2 = entity_2:GetBonePosition( PP_2 )
					if ( pos_1 == entity_1:GetPos() && entity_1:GetBoneMatrix( PP_1 ) ) then pos_1 = entity_1:GetBoneMatrix( PP_1 ):GetTranslation() end
					if ( pos_2 == entity_2:GetPos() && entity_2:GetBoneMatrix( PP_2 ) ) then pos_2 = entity_2:GetBoneMatrix( PP_2 ):GetTranslation() end
					tab["Matrix_pos_1"] = pos_1
					tab["Matrix_pos_2"] = pos_2
					tab["Matrix_t1_1"] = pos_1:Distance( pos_2 )
					tab["Matrix_ang_1"] = ( pos_1 - pos_2 ):Angle()
					tab["Matrix_ang_2"] = ( pos_2 - pos_1 ):Angle()
					if callback then
						timer.Create(aID.."_2" , 0.1,1,function() if IsValid( ply ) then
							if IsValid( entity_1 ) and IsValid( entity_2 ) then
								local pos_1 = entity_1:GetBonePosition( PP_1 )
								local pos_2 = entity_2:GetBonePosition( PP_2 )
								if ( pos_1 == entity_1:GetPos() && entity_1:GetBoneMatrix( PP_1 ) ) then pos_1 = entity_1:GetBoneMatrix( PP_1 ):GetTranslation() end
								if ( pos_2 == entity_2:GetPos() && entity_2:GetBoneMatrix( PP_2 ) ) then pos_2 = entity_2:GetBoneMatrix( PP_2 ):GetTranslation() end
								tab["Matrix_pos_1"] = pos_1
								tab["Matrix_pos_2"] = pos_2
								tab["Matrix_t1_1"] = pos_1:Distance( pos_2 )
								tab["Matrix_ang_1"] = ( pos_1 - pos_2 ):Angle()
								tab["Matrix_ang_2"] = ( pos_2 - pos_1 ):Angle()
								if IsValid( entity_1 ) then entity_1:Remove() end
								if IsValid( entity_2 ) then entity_2:Remove() end
								callback(tab)
							end
						end end)
					end
				end
			end
		end
		if tuTab then
			return tab
		else
			return t1_1
		end
	end
	if not tshowFix and not callback then
		if IsValid( entity_1 ) then entity_1:Remove() end
		if IsValid( entity_2 ) then entity_2:Remove() end
		if timer.Exists( aID ) then timer.Remove( aID ) end
	end
	if tuTab then return {} else return 0 end
end

function A_AM.ActMod:C2BoneAniDistanceFunct( ply,pl2 ,pos1,ang1,pos2,ang2 ,callback ,NoAutRemov,tshowFix )
	SCycle = SCycle or 0
	local trmov = true
	local entity_1,entity_2
	local aID = string.format("saMdl_%s_r%s|%s_c%s",ply:EntIndex(),math.Rand(-10,10),math.Rand(1,10),CurTime())
	local aamdl = isstring(ply) and ply or ply:GetModel()
	local aamdl2 = isstring(pl2) and pl2 or pl2:GetModel()
	if SERVER then
		if not Autclmdl and IsValid(ply) and ply:IsPlayer() and ply.aenforce_model then aamdl = ply.aenforce_model end
		if not Autclmdl2 and IsValid(pl2) and pl2:IsPlayer() and pl2.aenforce_model then aamdl2 = pl2.aenforce_model end
		entity_1 = ents.Create("base_anim")
		entity_1:SetModel( aamdl )
		entity_2 = ents.Create("base_anim")
		entity_2:SetModel( aamdl2 )
	else
		entity_1 = ClientsideModel(aamdl, RENDERGROUP_BOTH)
		entity_2 = ClientsideModel(aamdl2, RENDERGROUP_BOTH)
	end
	if IsValid(entity_1) and IsValid(entity_2) then
		if CLIENT then
			A_AM.ActMod.GRTSYS.TMDL[aID .."|1"] = entity_1
			A_AM.ActMod.GRTSYS.TMDL[aID .."|2"] = entity_2
		end
		if timer.Exists( aID ) then timer.Remove( aID ) end
		timer.Create(aID ,0.3,1,function() if trmov or not IsValid( entity_1 ) or not IsValid( entity_2 ) then
			if IsValid( entity_1 ) then entity_1:Remove() end
			if IsValid( entity_2 ) then entity_2:Remove() end
			if timer.Exists( aID ) then timer.Remove( aID ) end
		end end)
		if isvector(pos1) then entity_1:SetPos(pos1) end if isangle(ang1) then entity_1:SetAngles(ang1) end
		if isvector(pos2) then entity_2:SetPos(pos2) end if isangle(ang2) then entity_2:SetAngles(ang2) end
		if tshowFix then
			entity_1:DrawShadow( true ) entity_1:SetNoDraw( false ) entity_2:DrawShadow( true ) entity_2:SetNoDraw( false )
		else
			entity_1:DrawShadow( false ) entity_1:SetNoDraw( true ) entity_2:DrawShadow( false ) entity_2:SetNoDraw( true )
			entity_1:SetColor(Color(0, 0, 0, 1)) entity_1:SetRenderMode(RENDERMODE_TRANSALPHA) entity_1:SetMaterial("Models/effects/vol_light001")
			entity_2:SetColor(Color(0, 0, 0, 1)) entity_2:SetRenderMode(RENDERMODE_TRANSALPHA) entity_2:SetMaterial("Models/effects/vol_light001")
		end
		if callback then callback( entity_1 ,entity_2 ) end
		trmov = false
	end
	if isnumber(NoAutRemov) then
		aID = aID .."|".. NoAutRemov
		timer.Create(aID,NoAutRemov,1,function()
			if IsValid(entity_1) then entity_1:Remove() end
			if IsValid(entity_2) then entity_2:Remove() end
		end)
	end
	if not NoAutRemov then
		if IsValid( entity_1 ) then entity_1:Remove() end
		if IsValid( entity_2 ) then entity_2:Remove() end
		if timer.Exists( aID ) then timer.Remove( aID ) end
	end
end

function A_AM.ActMod:HMd( ply,mDl ,saq_1,saq_2,SCycle ,naP_1,naP_2 ,Sc1,Sc2 ,Autclmdl )
	SCycle = SCycle or 1
	local t1_1,t1_2,t2_1,t2_2,tk1,tk2,tk3,tk4,vw1,vw2,vt1,vt2 = 0,0,0,0,Vector(),Vector(),Vector(),Vector(),0,0,Vector(),Vector()
	local entity_1,entity_2
	local aamdl = ply:GetModel()
	if SERVER then
		if not Autclmdl and IsValid(ply) and ply:IsPlayer() and ply.aenforce_model then aamdl = ply.aenforce_model end
		entity_1 = ents.Create("base_anim")
		entity_1:SetModel(aamdl)
		entity_2 = ents.Create("base_anim")
		entity_2:SetModel(mDl)
	else
		entity_1 = ClientsideModel(aamdl, RENDERGROUP_BOTH)
		entity_2 = ClientsideModel(mDl, RENDERGROUP_BOTH)
	end
	local aID = string.format("saMdl_%s_r%s|%s_c%s",ply:EntIndex(),math.Rand(-10,10),math.Rand(1,10),CurTime())
	if timer.Exists( aID ) then timer.Remove( aID ) end
	timer.Create(aID,0.1,1,function()
		if IsValid( ply ) then
			if IsValid( entity_1 ) then entity_1:Remove() end
			if IsValid( entity_2 ) then entity_2:Remove() end
		end
	end)
	if entity_1 and IsValid(entity_1) and entity_2 and IsValid(entity_2) then
		if Sc1 then entity_1:SetModelScale( Sc1 ) end if Sc2 then entity_2:SetModelScale( Sc2 ) end
		entity_1:DrawShadow( false ) entity_1:SetNoDraw( true ) entity_2:DrawShadow( false ) entity_2:SetNoDraw( true )
		if CLIENT then
			A_AM.ActMod.GRTSYS.TMDL[aID .."|1"] = entity_1
			A_AM.ActMod.GRTSYS.TMDL[aID .."|2"] = entity_2
			entity_1:SetColor(Color(0, 0, 0, 1)) entity_1:SetRenderMode(RENDERMODE_TRANSALPHA) entity_1:SetMaterial("Models/effects/vol_light001")
			entity_2:SetColor(Color(0, 0, 0, 1)) entity_2:SetRenderMode(RENDERMODE_TRANSALPHA) entity_2:SetMaterial("Models/effects/vol_light001")
		end
		entity_1:SetCycle( SCycle ) entity_1:SetPlaybackRate( 0 ) entity_2:SetCycle( SCycle ) entity_2:SetPlaybackRate( 0 )
		local seq0_1 = entity_1:LookupSequence( "reference" )
		local seq1_1 = entity_1:LookupSequence( saq_1 )
		local seq_1 = seq1_1
		if seq1_1 <= 0 then seq_1 = seq0_1 end
		local seq0_2 = entity_2:LookupSequence( "reference" )
		local seq1_2 = entity_2:LookupSequence( saq_2 )
		local seq_2 = seq1_2
		if seq1_2 <= 0 then seq_2 = seq0_2 end
		entity_1:ResetSequence(seq_1) entity_2:ResetSequence(seq_2)
		entity_1:SetCycle( SCycle ) entity_1:SetPlaybackRate( 0 )
		entity_2:SetCycle( SCycle ) entity_2:SetPlaybackRate( 0 )
		if naP_1 and naP_2 then
			local PP_1,PP_2 = entity_1:LookupBone(naP_1),entity_2:LookupBone(naP_2)
			if PP_1 and PP_2 then
				t1_1 = entity_1:GetBonePosition(PP_1):Distance( entity_2:GetBonePosition(PP_2)*entity_2:GetModelScale() )
				vw1 = Vector(0,0,0):Distance( entity_1:GetBonePosition(PP_1) )
				vw2 = Vector():Distance( entity_2:GetBonePosition(PP_2) )
				vt1 = entity_1:GetBonePosition(PP_1)
				vt2 = entity_2:GetBonePosition(PP_2)
				tk1 = entity_1:GetBonePosition(PP_1) - entity_2:GetBonePosition(PP_2)
				tk2 = entity_2:GetBonePosition(PP_2) - entity_1:GetBonePosition(PP_1)
				local tpos_2 = entity_1:GetBonePosition(PP_2)
				entity_1:ResetSequence(0) entity_1:SetCycle( 0 )
				tk3 = entity_1:GetBonePosition(PP_2) - tpos_2
				tk4 = entity_1:GetBonePosition(PP_2)
				if IsValid( entity_1 ) then entity_1:Remove() end
				if IsValid( entity_2 ) then entity_2:Remove() end
				return {
					[1] = t1_1
					,[2] = t2_1
					,[3] = tk1
					,[4] = tk2
					,[5] = tk3
					,[6] = tk4
					,[7] = vw1
					,[8] = vw2
					,[9] = vt1
					,[10] = vt2
				}
			end
		end
	end
	if IsValid( entity_1 ) then entity_1:Remove() end
	if IsValid( entity_2 ) then entity_2:Remove() end
	if timer.Exists( aID ) then timer.Remove( aID ) end
	return {0}
end

function A_AM.ActMod:HMX( ply ,Autclmdl )
	local cFoot,cFoot0,cHand,cNeck,jHand,jHN,jHF1,jHF1_F0,j_,j0,j1,jHead,jOBMax,FtUArm,UHand,NiFarm,Hand_R_L = 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	local entity
	local aamdl = ply:GetModel()
	local aID = string.format("saMdl_%s_r%s|%s_c%s",ply:EntIndex(),math.Rand(-10,10),math.Rand(1,10),CurTime())
	if SERVER then
		if not Autclmdl and IsValid(ply) and ply:IsPlayer() and ply.aenforce_model then aamdl = ply.aenforce_model end
		entity = ents.Create("base_anim")
		entity:SetModel(aamdl)
	else
		entity = ClientsideModel(aamdl, RENDERGROUP_BOTH)
	end
	if IsValid(entity) then
		entity:DrawShadow( false ) entity:SetNoDraw( true )
		if CLIENT then
			A_AM.ActMod.GRTSYS.TMDL[aID .."|1"] = entity
			entity:SetColor(Color(0, 0, 0, 1)) entity:SetRenderMode(RENDERMODE_TRANSALPHA) entity:SetMaterial("Models/effects/vol_light001")
		end
		if timer.Exists( aID ) then timer.Remove( aID ) end
		timer.Create(aID,0.1,1,function() if IsValid( ply ) and IsValid( entity ) then entity:Remove() end end)
		entity:SetCycle( 1 ) entity:SetPlaybackRate( 0 )
		local seq0 = entity:LookupSequence( "reference" )
		local seq1 = entity:LookupSequence( "amod_fortniteidle" )
		local seq = seq1
		if seq1 <= 0 then seq = seq0 end
		entity:ResetSequence(seq)
		entity:SetCycle( 1 ) entity:SetPlaybackRate( 0 )
		if entity and IsValid(entity) then
			jOBMax = entity:OBBMaxs().z
			if jOBMax == 0 then
				local _,mmx = entity:GetModelBounds()
				if mmx.z == 0 then
					local _,rmx = entity:GetRenderBounds()
					if rmx.z ~= 0 then
						jOBMax = rmx.z
					end
				else
					jOBMax = mmx.z
				end
			end
			local bone0,bone1,bone2,bone3,bone3L = entity:LookupBone("ValveBiped.Bip01_Neck1") ,entity:LookupBone("ValveBiped.Bip01_R_UpperArm") ,entity:LookupBone("ValveBiped.Bip01_R_Forearm") ,entity:LookupBone("ValveBiped.Bip01_R_Hand") ,entity:LookupBone("ValveBiped.Bip01_L_Hand")
			local Abone_,Abone0,Abone1,Abone2,Abone3 = 0 ,entity:LookupBone("ValveBiped.Bip01_Pelvis") ,entity:LookupBone("ValveBiped.Bip01_R_Thigh") ,entity:LookupBone("ValveBiped.Bip01_R_Calf") ,entity:LookupBone("ValveBiped.Bip01_R_Foot")
			local bHF0,bHF1,bHead,ASpine,ASpine1 = entity:LookupBone("ValveBiped.Bip01_R_Finger0") ,entity:LookupBone("ValveBiped.Bip01_R_Finger1"),entity:LookupBone("ValveBiped.Bip01_Head1"),entity:LookupBone("ValveBiped.Bip01_Spine"),entity:LookupBone("ValveBiped.Bip01_Spine1")
			pcall(function()
				if Abone1 and Abone2 and Abone3 then
					cFoot = entity:GetBonePosition(Abone1):Distance( entity:GetBonePosition(Abone2) )
					cFoot = cFoot + entity:GetBonePosition(Abone2):Distance( entity:GetBonePosition(Abone3) )
				elseif Abone1 and Abone3 then
					cFoot = entity:GetBonePosition(Abone1):Distance( entity:GetBonePosition(Abone3) )
				else
					cFoot = cFoot + entity:GetBonePosition(Abone_).z
				end
				if Abone1 then
					cFoot0 = entity:GetPos():Distance( entity:GetBonePosition(Abone1) )
				else
					cFoot0 = entity:GetBonePosition(Abone_).z
				end
				if bone1 and bone2 and bone3 then
					cHand = entity:GetBonePosition(bone1):Distance( entity:GetBonePosition(bone2) )
					cHand = cHand + entity:GetBonePosition(bone2):Distance( entity:GetBonePosition(bone3) )
				elseif bone1 and bone3 then
					cHand = entity:GetBonePosition(bone1):Distance( entity:GetBonePosition(bone3) )
				end
				if bone1 and bone3 then
					UHand = entity:GetBonePosition(bone1):Distance( entity:GetBonePosition(bone3) )
				end
				if bone3 and bone3L then
					Hand_R_L = entity:GetBonePosition(bone3):Distance( entity:GetBonePosition(bone3L) )
				end
				if bone0 then cNeck = entity:GetBonePosition(bone0).z else cNeck = jOBMax end
				if bone3 and seq1 > 0 then jHand = entity:GetBonePosition(bone3).z else jHand = 36.5+(cHand-23.17)*0.8 end
				if Abone0 and bone0 then jHN = entity:GetBonePosition(Abone0):Distance( entity:GetBonePosition(bone0) ) end
				if bHF0 and bone3 then jHF1 = entity:GetBonePosition(bHF0):Distance( entity:GetBonePosition(bone3) ) end
				if bHF0 and bHF1 then jHF1_F0 = entity:GetBonePosition(bHF0):Distance( entity:GetBonePosition(bHF1) ) end
				if Abone3 and bone1 then
					FtUArm = entity:GetBonePosition(Abone3):Distance( entity:GetBonePosition(bone1) )
				elseif bone1 then
					FtUArm = entity:GetBonePosition(Abone_):Distance( entity:GetBonePosition(bone1) )
				end
				if bone0 and bone2 then
					NiFarm = entity:GetBonePosition(bone0):Distance( entity:GetBonePosition(bone2) )
				elseif ASpine and bone2 then
					NiFarm = entity:GetBonePosition(ASpine):Distance( entity:GetBonePosition(bone2) )
				elseif bone2 then
					NiFarm = entity:GetBonePosition(Abone_):Distance( entity:GetBonePosition(bone2) )
				end
				j_ = entity:GetPos():Distance( entity:GetBonePosition(Abone_) )
				if entity:LookupBone("ValveBiped.Bip01_Spine") then
					j0 = entity:GetPos():Distance( entity:GetBonePosition(entity:LookupBone("ValveBiped.Bip01_Spine")) ) else j0 = j_
				end
				if entity:LookupBone("ValveBiped.Bip01_Spine1") then
					j1 = entity:GetPos():Distance( entity:GetBonePosition(entity:LookupBone("ValveBiped.Bip01_Spine1")) ) else j1 = j_
				end
				if bHead then
					jHead = entity:GetPos():Distance( entity:GetBonePosition(bHead) )
				elseif bone0 then
					jHead = entity:GetPos():Distance( entity:GetBonePosition(bone0) ) else jHead = jOBMax
				end
			end)
		end
	end
	if IsValid( entity ) then entity:Remove() end
	if timer.Exists( aID ) then timer.Remove( aID ) end
	return {
		[1] = cFoot
		,[2] = cHand
		,[3] = cNeck
		,[4] = jHand
		,[5] = jHN
		,[6] = jHF1
		,[7] = jHF1_F0
		,[8] = j_
		,[9] = j0
		,[10] = j1
		,[11] = jHead
		,[12] = cFoot0
		,[13] = jOBMax
		,[14] = FtUArm
		,[15] = UHand
		,[16] = NiFarm
		,[17] = Hand_R_L
	}
end


local function str_iError(plA,str)
	if not plA:IsBot() then
		A_AM.ActMod:A_ActMod_OffActing( plA )
		net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"iError_cl",str} ) net.Send(plA)
	end
end

function A_AM.ActMod:CGoodStartCoop(pl,pl2)
	if not IsValid(pl) or not pl:IsPlayer() or not IsValid(pl2) or not pl2:IsPlayer() then return {false,""} end
	local TmD = pl2:GetNWString( "A_ActMod.TmpDir" ,"" )
	if GetConVarNumber("actmod_sv_alowdsyn") == 0 then
		str_iError(pl,"!M_.DiJothb") return {false,"DiJothb"}
	elseif not IsValid(pl) or not pl:IsPlayer() or not pl:Alive() or pl:GetObserverMode() ~= 0 or not IsValid(pl2) or not pl2:IsPlayer() or not pl2:Alive() or pl2:GetObserverMode() ~= 0 then
		return {false,""}
	elseif not pl2:A_ActModASync() then
		str_iError(pl,"!M_.heNotAllowASyn") return {false,"heNotAllowASyn"}
	elseif pl2:GetPos():Distance( pl:GetPos() ) > A_AM.ActMod.msaf*1.55 then
		str_iError(pl,"!M_.CaJoFrADi") return {false,"CaJoFrADi"}
	elseif A_AM.ActMod:A_GetNJoing( pl2 ) == false then
		str_iError(pl,"!M_.JoPoArCuFull") return {false,"JoPoArCuFull"}
	elseif A_AM.ActMod:hereIsGood( pl2,pl,nil,0 ) == false then
		str_iError(pl,"!M_.ThIsNoAGoodP") return {false,"ThIsNoAGoodP"}
	elseif GetConVarNumber("actmod_sv_a_vehicles") == 0 and pl:InVehicle() then
		str_iError(pl,"!M_.1iCantUse_inVehicle") return {false,"1iCantUse_inVehicle"}
	elseif GetConVarNumber("actmod_sv_a_ground") == 1 and not pl:OnGround() then
		str_iError(pl,"!M_.1iCantUse_notFloor") return {false,"1iCantUse_notFloor"}
	elseif GetConVarNumber("actmod_sv_a_crouching") == 0 and pl:Crouching() then
		str_iError(pl,"!M_.1iCantUse_Crouching") return {false,"1iCantUse_Crouching"}
	elseif (prone and (pl:GetNW2Int("prone.AnimationState", 3) ~= 3 or pl:GetNWInt("prone.AnimationState", 3) ~= 3)) then
		str_iError(pl,"!M_.1iCantUse_prone") return {false,"1iCantUse_prone"}
	elseif (wOS and wOS.LastStand and pl:WOSGetIncapped()) or pl:GetNWBool( "wOS.LS.IsGetIncapped",false ) then
		str_iError(pl,"!M_.1iCantUse_helpless") return {false,"1iCantUse_helpless"}
	elseif (wOS and wOS.RollMod and pl:wOSIsRolling()) then
		str_iError(pl,"!M_.1iCantUse_rolling") return {false,"1iCantUse_rolling"}
	elseif GetConVarNumber("actmod_sv_alowacop") <= 0 and TmD ~= "" and A_AM.ActMod.GTabActCoop[TmD] and not A_AM.ActMod.GTabActCoop[TmD]["joiningFPO"] and not pl2:GetNWBool( "A_AM.ActMod.OnHimself", false ) then
		str_iError(pl,"!M_.YoCanJoTSElse") return {false,"YoCanJoTSElse"}
	end
	return {true,"noError"}
end



if A_AM.ActMod.OneSutep == true and A_AM.ActMod.LuaBas_Done then
	local function Chfg(txt,svcl)
		if file.Exists(txt, "LUA") and ( not svcl or svcl and (svcl == 1 and SERVER or svcl == 0 and CLIENT) ) then
			include(txt)
		end
	end
	Chfg("actmod/bessys/am_sys_1_sv.lua",1)
	Chfg("actmod/bessys/am_sys_1_cl.lua",0)
	Chfg("actmod/am_actmod_act.lua")
	Chfg("actmod/bessys/am_sys_2_sv.lua",1)
	Chfg("actmod/bessys/am_sys_2_cl.lua",0)
	Chfg("actmod/am_actmod_ent.lua")
	Chfg("actmod/am_actmod_avs.lua")
	Chfg("actmod/am_actmod_fon.lua",0)
	Chfg("actmod/am_actmod_hok.lua")
	Chfg("actmod/am_actmod_lan.lua")
	Chfg("actmod/am_actmod_shr.lua")
	Chfg("actmod/am_actmod_vgi.lua",0)
end

A_AM.ActMod.LuaBas_Done = true
