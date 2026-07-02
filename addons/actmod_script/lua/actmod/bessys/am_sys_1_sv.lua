if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.bessys_1 = true

util.AddNetworkString("A_AM.ActMod.SvToCl_Tab")
util.AddNetworkString("A_AM.ActMod.ClToSv_Tab")

function A_AM.ActMod:ReTast_Seq_restuo(clnt,ttrue,hidea)
	local function Tast_Seq_ShowT(s1,s2,ch)
		if s1 == "Base" then
			MsgC(Color( 90, 255, 255 ),"\n-> Base: ( ",Color( 210, 255, 240 ),"Dynamic",Color( 90, 255, 255 )," or ",Color( 210, 255, 240 ),"AM4",Color( 90, 255, 255 )," or ",Color( 210, 255, 240 ),"xdR",Color( 90, 255, 255 )," or ", Color( 210, 255, 240 ),"wOS",Color( 90, 255, 255 )," ) == ")
		else
			MsgC(Color( 90, 255, 255 ),"\n-> "..s1)
		end
		if s2 == "GetSetBase" or A_AM.ActMod.GetMSS_Tab[s2] == 2 then
			if ch == true then
				if A_AM.ActMod.GetMSS_Tab[ "GetSetBase" ] ~= "" then
					MsgC(Color( 255, 255, 255 ),"( " ,A_AM.ActMod.GetMSS_Tab[ "GetSetBase" ] == "wOS" and Color( 255, 200, 100 ) or Color( 150, 255, 200 ),A_AM.ActMod.GetMSS_Tab[ "GetSetBase" ],Color( 255, 255, 255 )," )")
				else
					MsgC(Color( 255, 255, 255 ),"( " ,Color( 90, 255, 150 ),(A_AM.ActMod.GetMSS_Tab["GetMDLSeq_Dyn"] == 2 and "Dynamic" or A_AM.ActMod.GetMSS_Tab["GetMDLSeq_xdR"] == 2 and "xdR" or A_AM.ActMod.GetMSS_Tab["GetMDLSeq_AM4"] == 2 and "AM4" or A_AM.ActMod.GetMSS_Tab["GetMDLSeq_wOS"] == 2 and "wOS" or "nil"),Color( 255, 255, 255 )," )")
				end
			else
				MsgC(Color( 90, 255, 150 ),"True")
			end
		elseif A_AM.ActMod.GetMSS_Tab[s2] == 1 then
			MsgC(Color( 150, 100, 50 ),"unknown")
		else
			MsgC(Color( 255, 100, 70 ),"False")
		end
	end
	local function Tast_Precache(pch,typ)
		for name, filename in pairs(file.Find(pch..(typ == "model" and "/*.mdl" or "/*.*") , "GAME")) do
			util.PrecacheModel(pch .."/".. string.lower(filename))
		end
	end

	A_AM.ActMod.GetMSS_Tab = A_AM.ActMod:aRSeq()

	timer.Simple(0.1, function()
	timer.Simple(0.2, function()
		Tast_Precache("models/actmod","model")
	timer.Simple(0.6, function()
		if ttrue and ttrue == "showMsg" and clnt and IsValid(clnt) and clnt:IsPlayer() then MsgC(Color( 90, 255, 255 ),"\n\nFrom Player : "..clnt:Nick()) end
		if not hidea then
			MsgC(Color( 100, 255, 255 ),"\n[ActMod]" ,Color( 90, 255, 255 ),"[ Start-> TastServer_Seq ] :")
			Tast_Seq_ShowT("Base","GetSetBase",true)
			Tast_Seq_ShowT("Base Anim-AM4 == ","GetMDLSeq_AM4")
			Tast_Seq_ShowT("AM4 Latest Animation Version == ","GetPackAnimV")
			MsgC(Color( 100, 255, 255 ),"\n[ActMod]" ,Color( 90, 255, 255 ),"[ End --> TastServer_Seq ]\n\n")
		end
	end) end) end)
end

timer.Create("AA_SReFrshAnim",20,0,function()
	if A_AM.ActMod.GetMSS_Tab["GetMDLSeq_AM4"] ~= 2 or A_AM.ActMod.GetMSS_Tab["GetPackAnimV"] ~= 2 then
		A_AM.ActMod:ReTast_Seq_restuo(nil,nil,true)
	end
end )


A_AM.ActMod.AGServro()
if timer.Exists( "AA_Reflsh_sv" ) then timer.Remove( "AA_Reflsh_sv" ) end
timer.Create("AA_Reflsh_sv",60,0,function() A_AM.ActMod.AGServro() end)



function A_AM.ActMod:GiveWeapAct( ply,GNewt,TiHoBase )
	local gonwh = false
	local function GivWo(nnw)
		if nnw then
			local actwep = ply:GetActiveWeapon()
			local giveweapatt = "aact_weapact"
			ply.A_oldWeap = IsValid(actwep) and actwep:GetClass()
			if ply.A_oldWeap then ply:SetNWString( "A_AM.ActMod.GetWeap", ply.A_oldWeap ) end
			if ply:HasWeapon(giveweapatt) then
				ply:SelectWeapon(giveweapatt)
			else
				local ent = ents.Create(giveweapatt)
				if IsValid(ent) then ply.A_oldWeap = IsValid(actwep) and actwep:GetClass()
				if ply.A_oldWeap then ply:SetNWString( "A_AM.ActMod.GetWeap", ply.A_oldWeap ) end
				ent:SetPos(ply:GetPos())
				ent.GiveTo = ply
				ent:Spawn()
				ent.GiveTo = ply
				ply:SelectWeapon(giveweapatt)
				timer.Simple(0.05, function() if IsValid(ply) then ply:SelectWeapon(giveweapatt)
				timer.Simple(0.01, function() if IsValid(ply) then ply:SelectWeapon(giveweapatt)
				timer.Simple(0.0, function() if IsValid(ply) then ply:SelectWeapon(giveweapatt) end end) end end) end end)
				end
				ply:SelectWeapon(giveweapatt)
			end
			
			timer.Simple(0.1, function()
				if IsValid(ply) then
					if GNewt and ply:GetActiveWeapon() and ply:GetActiveWeapon():IsValid() then
						for l, wep in pairs(ply:GetWeapons()) do
							if wep:IsValid() and wep:GetClass() == "aact_weapact" then
								gonwh = true
								wep:Onweap(ply,TiHoBase or 0.1)
							end
						end
					elseif ply:GetActiveWeapon() and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() == "aact_weapact" then
						gonwh = true
					end
					if gonwh == true then
						ply:SetNWBool( "A_AM.ActMod.IsAct", true )
					else
						net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"iError_cl","nwp"} ) net.Send(ply)
					end
				end
			end)

		else
		
			local actwep = ply:GetActiveWeapon()
			local giveweapatt = "aact_weapact"
			if actwep == NULL or actwep:GetClass() != giveweapatt then
				ply.A_oldWeap = IsValid(actwep) and actwep:GetClass()
				if ply.A_oldWeap then ply:SetNWString( "A_AM.ActMod.GetWeap", ply.A_oldWeap ) end
				if ply:HasWeapon(giveweapatt) then
					ply:SelectWeapon(giveweapatt)
				else
					ply:Give(giveweapatt)
					ply:SelectWeapon(giveweapatt)
				end
			elseif ply.A_oldWeap then
				ply:SelectWeapon(ply.A_oldWeap)
				ply:SetNWString( "A_AM.ActMod.GetWeap", "" )
				ply.A_oldWeap = nil
			end

			if GNewt and ply:GetActiveWeapon() and ply:GetActiveWeapon():IsValid() then
				for l, wep in pairs(ply:GetWeapons()) do
					if wep:IsValid() and wep:GetClass() == "aact_weapact" then
						gonwh = true
						wep:Onweap(ply,TiHoBase or 0.1)
					end
				end
			elseif ply:GetActiveWeapon() and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() == "aact_weapact" then
				gonwh = true
			end
			
			if gonwh == true then ply:SetNWBool( "A_AM.ActMod.IsAct", true ) else GivWo(true) end
		end
	end
	GivWo()
end



local function Act_Stop(pl_)
	A_AM.ActMod:A_ActMod_OffActing( pl_ )
end


local function Act_SGesture(ply,GStrg)
	if not IsValid( ply ) or not ply:IsPlayer() or (ply.ActMod_tcuGestr or 0) > CurTime() then return end
	ply.ActMod_tcuGestr = CurTime() + 0.2
	local NAct,NTim = GStrg,CurTime()
	local G_TEnd,G_In,G_Out,G_Speed,G_Cycle,G_Weight
	if NAct == "._" then else
		local GTabActO = A_AM.ActMod.GTabActO[GStrg]
		if istable(GTabActO) then
			if GTabActO.RNAnim then NAct = GTabActO.RNAnim end
			if GTabActO.G_In then G_In = GTabActO.G_In end
			if GTabActO.G_Out then G_Out = GTabActO.G_Out end
			if GTabActO.G_TEnd then G_TEnd = GTabActO.G_TEnd end
			if GTabActO.G_Rate then G_Speed = GTabActO.G_Rate end
			if GTabActO.G_Cycle then G_Cycle = GTabActO.G_Cycle end
			if GTabActO.G_Weight then G_Weight = GTabActO.G_Weight end
		end
	end
	local tt1 = string.format("%s|%s",GStrg,NTim)
	ply:SetNWString("A_ActMod.OneStart6",tt1)
	hook.Run( "ActMod_sv_StartAniGesture" , ply,GStrg,reanim )
	if A_AM.ActMod.GestureSystem and A_AM.ActMod.GestureSystem.PlayGesture then
		if NAct == "._" then
			A_AM.ActMod.GestureSystem:StopAllGestures(ply, 0.25)
		else
			A_AM.ActMod.GestureSystem:PlayGesture(ply, {animation = NAct,speed = G_Speed or 1 ,cycle = G_Cycle ,weight = G_Weight ,duration = G_TEnd ,fadeIn = G_In ,fadeOut = G_Out} )
		end
	end
end

function A_AM.ActMod:gostrt(ply,Strg,reS,aTab2)
	if istable(Strg) then
		if Strg.itsG then
			Act_SGesture(ply,Strg)
		else
			local tCT = CurTime()
			ply.ActMod_JOneed = true
			ply.aaThinTrue = true
			ply.aaBThinStrt = nil
			ply.rOn_MForward = 0
			local Trand,T1,T2,rrr,hld,TD,noRName,RDW_Snd = tostring(tCT),{"",0,0,0,0},Strg.tBl,0,0,false,false,""
			if ply.ActMod_tAb and istable(ply.ActMod_tAb) and not table.IsEmpty(ply.ActMod_tAb) then
				T1 = ply.ActMod_tAb
				ply.aaBThinStrt = tCT + 0.5
				if ply.aaBThinStrt then hld = ply.aaBThinStrt end
				TD = true
			end
			if not ply.ActMod_OneStart then
				ply.ActMod_OneStart = true
				ply.ActMod_CurTStart = tCT + 0.1
			end
			local GTabActO = istable(A_AM.ActMod.GTabActO) and A_AM.ActMod.GTabActO[Strg.txt]
			if istable(GTabActO) and istable(GTabActO.SndsC_) then
				local GERmSd = GTabActO.SndsC_
				if istable(GERmSd) and isnumber(GERmSd.n) and GERmSd.n > 1 then
					RDW_Snd = math.random(GERmSd.n)
				end
			end
			if reS then rrr = 1 end
			local tt1 = string.format("%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s",Strg.txt,Trand,T1[1],T1[2],T1[3],T1[4],T2[1],T2[2],T2[3],T2[4],T2[5],rrr,hld,"",T1[5],RDW_Snd)
			local Trnd = tostring("0|".. Trand)
			ply:SetNWString("A_ActMod.OneStart1",tt1)
			ply:SetNWString("A_ActMod.OneStart2",Trand)
			ply:SetNWString("A_ActMod.OneStart3",Trnd)
			if TD then
				net.Start( "A_AM.ActMod.SvToCl_Tab" ,true )
				 net.WriteTable( {"ActMod.SToC_ST","SToC_",{"aPlyEmot",ply:EntIndex(),tt1}} )
				net.Broadcast()
			end
			hook.Run( "ActMod_sv_StartAniAct" , ply,Strg.txt,tobool(rrr) )
			A_AM.ActMod:StartAniAct( ply,{Strg.txt,RDW_Snd},tobool(rrr),T1,T2,nil,T1[5] )
		end
	end
end

local function str_iError(plA,str)
	if not plA:IsBot() then
		net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"iError_cl",str} ) net.Send(plA)
	end
end

local function GHookMakeT(ply,txt)
	for name, func in pairs(hook.GetTable().UnallowUseActMod or {}) do
		local ok,msg,tmsg = func(ply, txt)
		if ok then
			if isstring(msg) and string.len(msg) > 0 then
				local tytxt = 1
				if isnumber(tmsg) then tytxt = math.Clamp(tmsg ,0,2) end
				if tytxt == 2 then
					ply:PrintMessage( 4,"(ActMod)!: ".. msg)
				elseif tytxt == 1 then
					ply:PrintMessage( 3,"(ActMod)!: ".. msg)
				else
					print( "(ActMod)!: ".. msg )
				end
			end
			return true
		end
	end
	return false
end
local function GHookMakeT_only(ply,txt)
    local GDt_ok,GDt_txt,GDt_ttx = hook.Call("UnallowUseActMod",nil,ply,txt)
    if GDt_ok ~= nil then
		if GDt_ok == true then
			return true
		else
			if isstring(GDt_txt) and string.len(GDt_txt) > 0 then
				local tytxt = 1
				if isnumber(GDt_ttx) then tytxt = math.Clamp(GDt_ttx ,0,2) end
				if tytxt == 2 then
					ply:PrintMessage( 4,"(ActMod)!: ".. GDt_txt)
				elseif tytxt == 1 then
					ply:PrintMessage( 3,"(ActMod)!: ".. GDt_txt)
				else
					print( "(ActMod)!: ".. GDt_txt )
				end
			end
			return false
		end
    else
		return true
    end
end

function A_AM.ActMod:ActMod_SSTr(ply,st_,reanim,aTab2)
	if IsValid(ply) then
		local ActMod_GStrg = st_
		if reanim then ply:SetNWBool( "A_AM.ActRAgin", reanim ) end
		
		local TTbl = A_AM.ActMod:A_ActMod_GetActString(st_)
		ActMod_GStrg = TTbl.txt
		ply.ActMod_GStrg = TTbl

		local seq,itsOK = ply:LookupSequence( ActMod_GStrg ),true
		local GTabActO = A_AM.ActMod.GTabActO[ActMod_GStrg]
		
		if not GTabActO and seq <= 0 then
			Act_Stop(ply) str_iError(ply,"sv_ntact_".. ActMod_GStrg)
			return
		end
		
		local IsGesture = false
		if GTabActO and isnumber(GTabActO["NoStop"]) and GTabActO["NoStop"] == 63 then
			ply.ActMod_GStrg.itsG = true
			IsGesture = true
		else
			ply.ActMod_GStrg.itsG = false
		end
		
		if not IsGesture and ply:IsPlayer() then
			if GetConVarNumber("actmod_sv_a_vehicles") == 0 and ply:InVehicle() then Act_Stop(ply) str_iError(ply,"!T_.1iCantUse_inVehicle") return end
			if GetConVarNumber("actmod_sv_a_ground") == 1 and not ply:OnGround() then Act_Stop(ply) str_iError(ply,"!T_.1iCantUse_notFloor") return end
			if GetConVarNumber("actmod_sv_a_crouching") == 0 and ply:Crouching() then Act_Stop(ply) str_iError(ply,"!T_.1iCantUse_Crouching") return end
			if (prone and (ply:GetNW2Int("prone.AnimationState", 3) ~= 3 or ply:GetNWInt("prone.AnimationState", 3) ~= 3)) then Act_Stop(ply) str_iError(ply,"!T_.1iCantUse_prone") return end
			if (wOS and wOS.LastStand and ply:WOSGetIncapped()) or ply:GetNWBool( "wOS.LS.IsGetIncapped",false ) == true then Act_Stop(ply) str_iError(ply,"!T_.1iCantUse_helpless") return end
			if (wOS and wOS.RollMod and ply:wOSIsRolling()) then Act_Stop(ply) str_iError(ply,"!T_.1iCantUse_rolling") return end
		end
		
		if istable(A_AM.ActMod.Actbtk_sv) and A_AM.ActMod.Actbtk_sv[ActMod_GStrg] then
			local NAct = A_AM.ActMod:ReNameAct(ActMod_GStrg)
			if isstring(A_AM.ActMod.Actbtk_sv[ActMod_GStrg]) then
				if string.sub(A_AM.ActMod.Actbtk_sv[ActMod_GStrg],1,3) == "!!!" then
					Act_Stop(ply) str_iError(ply,string.sub(A_AM.ActMod.Actbtk_sv[ActMod_GStrg],4).. NAct)
				else
					Act_Stop(ply) str_iError(ply,A_AM.ActMod.Actbtk_sv[ActMod_GStrg])
				end
			elseif isnumber(A_AM.ActMod.Actbtk_sv[ActMod_GStrg]) then
				if A_AM.ActMod.Actbtk_sv[ActMod_GStrg] == 1 then
					Act_Stop(ply) str_iError(ply,"(!): ".. NAct)
				end
			end
			return
		elseif GHookMakeT(ply,ActMod_GStrg) then
			Act_Stop(ply)
			if ply.ActMod_Strgi1 then str_iError(ply,"!S_.1".. ply.ActMod_Strgi1) ply.ActMod_Strgi1 = nil end
			if ply.ActMod_Strgi2 then str_iError(ply,"!S_.2".. ply.ActMod_Strgi2) ply.ActMod_Strgi2 = nil end
			if ply.ActMod_StrgError then str_iError(ply,ply.ActMod_StrgError .." ") ply.ActMod_StrgError = nil end
			return
		end

		if ActMod_GStrg != "ragdoll" and ActMod_GStrg != "reference" and string.sub(ActMod_GStrg,1,10 ) ~= "amod_am4t_" and string.sub(ActMod_GStrg,1,13 ) ~= "amod_cconfig_" and not string.find(ActMod_GStrg, "amod_cum_") and seq <= 0 then
			local BastTab = GTabActO and GTabActO["RNAnim"]
			if not isstring(BastTab) or ply:LookupSequence( BastTab ) <= 0 then
				itsOK = false
			end
		end
		if not itsOK then
			if (string.find(ActMod_GStrg, "amod_") or string.find(ActMod_GStrg, "amod_am4_") or string.find(ActMod_GStrg, "amod_mmd_") or string.find(ActMod_GStrg, "amod_pubg_") or string.find(ActMod_GStrg, "amod_mixamo_") or string.find(ActMod_GStrg, "amod_fortnite_")) then
				if A_AM.ActMod.GetMSS_Tab[ "GetMDLSeq_AM4" ] == 0 then Act_Stop(ply) str_iError(ply,"sv_bs_am4") return end
				if A_AM.ActMod.GetMSS_Tab[ "GetMDLSeq_AM4" ] == 1 then Act_Stop(ply) str_iError(ply,"sv_ubs_am4") return end
				if A_AM.ActMod.GetMSS_Tab[ "GetPackAnimV" ] == 0 then Act_Stop(ply) str_iError(ply,"sv_pk_am4") return end
				if A_AM.ActMod.GetMSS_Tab[ "GetPackAnimV" ] == 1 then Act_Stop(ply) str_iError(ply,"sv_upk_am4") return end
				if A_AM.ActMod.GetMSS_Tab[ "GetSetBase" ] == "" then Act_Stop(ply) str_iError(ply,"bse") return end
			end
			Act_Stop(ply) str_iError(ply,ply:IsPlayer() and (game.SinglePlayer() or ply:IsListenServerHost()) and "!T_.0iCantUse_missing2" or "!T_.0iCantUse_missing")
			return
		end

		if IsGesture then
			Act_SGesture(ply,ActMod_GStrg)
			return
		end
		
		if reanim then
			ply:SetNWBool( "A_AM.ActRAgin", true )
			A_AM.ActMod:gostrt(ply,ply.ActMod_GStrg,true,aTab2)
		else
			if ply:A_ActMod_GetWeapAct() or GetConVarNumber("actmod_sv_a_weapact") == 0 or GetConVarNumber("actmod_sv_a_weapact") == 1 and GetConVarNumber("actmod_sv_a_vehicles") == 1 and ply:InVehicle() or GetConVarNumber("actmod_sv_a_weapact") > 1 and A_AM.ActMod:IsVR(ply) then
				A_AM.ActMod:gostrt(ply,ply.ActMod_GStrg,nil,aTab2)
			else
				local GetTBase = "non"
				local TiHoBase
				if ply:GetActiveWeapon() and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() != "aact_weapact" then
					GetTBase = ply:GetActiveWeapon().Base or "non"
				end
				if GetTBase != "non" then
					pcall(function()
						if GetTBase == "arccw_base" then TiHoBase = 0.4 + (0.25 *ply:GetActiveWeapon():GetBuff_Mult("Mult_HolsterTime"))
						elseif string.find( GetTBase, "arc9_base*" ) then TiHoBase = 1.8
						elseif string.find( GetTBase, "mg_base*" ) then TiHoBase = 0.8
						elseif string.find( GetTBase, "base_iw4" ) or string.find( GetTBase, "base_iw3" ) then
							TiHoBase = 1.5 + (ply:GetActiveWeapon():GetStat("ProceduralHolsterTime") / ply:GetActiveWeapon():GetAnimationRate(ACT_VM_HOLSTER))
						elseif string.find( GetTBase, "tfa_*" ) then
							TiHoBase = 0.5 + (ply:GetActiveWeapon():GetStat("ProceduralHolsterTime") / ply:GetActiveWeapon():GetAnimationRate(ACT_VM_HOLSTER))
						end
					end)
					if not TiHoBase then TiHoBase = 2.5 end
				else
					TiHoBase = 0.3
				end
				if TiHoBase then TiHoBase = TiHoBase+1 end
				GetTBase = nil
				if timer.Exists( "AA_TStratA"..ply:EntIndex() ) then timer.Remove( "AA_TStratA"..ply:EntIndex() ) end
				A_AM.ActMod:GiveWeapAct( ply,true,TiHoBase )
				if TiHoBase != nil then
					timer.Create("AA_TStratA"..ply:EntIndex(),TiHoBase,1,function() if IsValid( ply ) then
						A_AM.ActMod:gostrt(ply,ply.ActMod_GStrg,nil,aTab2)
						TiHoBase = nil
					end end)
				else
					timer.Create("AA_TStratA"..ply:EntIndex(),0.2,1,function() if IsValid( ply ) then
						A_AM.ActMod:gostrt(ply,ply.ActMod_GStrg,nil,aTab2)
					end end)
				end
			end
		end
	end
end


function A_AM.ActMod:APlayerInitial(ply,tim)
	ply.ActMod_Table_Ply = {}
	ply.AGSped_f = 0  ply.AGSped_b = 0
	ply:SetNWString("a_SEyeCuAngles","")
	ply:SetNWInt("a_SRLAngMove", 0)
	ply:SetNWInt( "A_ActMod.GetNJoing" ,0 )
	ply:SetNWAngle("A_ActMod_cl_vrAM_int",Angle(0,0,0))
	ply:SetNWInt("A_ActMod_cl_SysAM_Time",0)
	ply:SetNWBool( "A_AM.ActMod.OnHimself", false )
	ply:SetNWVector( "ply.AGSped_vel", Vector(0,0,0) )
	timer.Create("AA_PlayerInitialSpawn",tim or 4,1,function()
		if IsValid(ply) and !ply:IsBot() then
			local ttx = ""
			if ply:IsListenServerHost() then ttx = "isHost" end
			net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"SvToCl_restuo",ttx} ) net.Send(ply)
		end
	end)
end

local function AClToSv(ply,txt)
	if IsValid( ply ) then
		if txt == "AddThink_Ply" then A_AM.ActMod.HookThinkCl = A_AM.ActMod.HookThinkCl + 1
		elseif txt == "E_ IN_ATTACK" then A_AM.ActMod:ChingAni(ply)
		elseif txt == "E_ IN_ATTACKand" then A_AM.ActMod:ChingAni(ply,3)
		elseif string.sub(txt,1,10) == "CHangeMap_" and ply:IsListenServerHost() then
			RunConsoleCommand("changelevel",string.sub(txt,12))
		end
	end
end

local aattx = {"actmod_sv_soundlevel","actmod_sv_syrhook","actmod_sv_a_weapact","actmod_sv_a_vehicles","actmod_sv_a_ground","actmod_sv_a_crouching","actmod_sv_a_move","actmod_sv_typmovecl","actmod_sv_alowangcl","actmod_sv_alowdsyn","actmod_sv_showhisyn","actmod_sv_alowacop","actmod_sv_rangecam","actmod_cl_sdwfix"}

local function T_ClToSv_Tab(ply,Tab)
	if ply and IsValid( ply ) and not table.IsEmpty(Tab) then
		local GTab = tostring(Tab[1])
		if GTab == "ActMod.CToS_ST" then
			local str = Tab[2]
			local tbl = Tab[3]
			if str == "CToS_" then
				if IsValid(ply) then
					A_AM.ActMod:Commt_Sv(ply,tbl)
				end
			end
		elseif GTab == "i_MenuTErr" then
			if Tab[2] == "GetAllErrTabAct" then
				local t = util.Compress( util.TableToJSON( A_AM.ActMod.GetAllErrTabAct ) )
				local n = #t
				net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"i_MenuTErr","SGTab"} ) net.WriteUInt(n,32) net.WriteData(t,n) net.Send(ply)
			end
		elseif GTab == "SandDataKeysTSV" then
			if Tab[2] and istable(Tab[2]) then
				local plT = Tab[2][1]
				local Dat = Tab[2][2]
				if plT and IsValid( plT ) and plT == ply and Dat and istable(Dat) then
					A_AM.ActMod:A_ActMod_SDataKeys( plT,Dat )
				end
			end
		elseif GTab == "avs_SetTabPly" then
			local tab = Tab[2]
			if istable( tab ) then ply.GetTable_Avs = tab end
		elseif GTab == "aLAT" then
			if ply:IsListenServerHost() then
				A_AM.ActMod:aLoadAllTablAS()
				for _, pl in player.Iterator() do if IsValid(pl) and pl ~= ply and !pl:IsBot() then net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"aLAT"} ) net.Send(pl) end end
			end
		elseif GTab == "ClToSv_NWBool" then
			if istable(A_AM.ActMod.GetMSS_Tab) and not table.IsEmpty(A_AM.ActMod.GetMSS_Tab) then
				net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"SetTCl_MountedSV",A_AM.ActMod.GetMSS_Tab} ) net.Send(ply)
			end
		elseif GTab == "ClToSv_restuo" then
			local gstr = Tab[2]
			if istable( gstr ) then
				local allonms = {
					["GetMDLSeq_AM4"] = {1,0}
					,["GetMDLSeq_Dyn"] = {2,0}
					,["GetMDLSeq_xdR"] = {3,0}
					,["GetMDLSeq_wOS"] = {4,0}
					,["GetPackAnimV"] = {5,0}
					,["GetPackSounds"] = {6,0}
					,["GetORG"] = {7,0}
				}
				local aggg = {[1] = 0,[2] = 0,[3] = 0,[4] = 0,[5] = 0,[6] = 0,[7] = 0}
				for k ,v in pairs(gstr) do
					if allonms[k] and isnumber( v ) then
						local vtab = allonms[k]
						if istable( vtab ) then
							aggg[vtab[1]] = v
						end
					end
				end
				local ttab = string.format("%s|%s|%s|%s|%s|%s",aggg[1],aggg[2],aggg[3],aggg[4],aggg[5],aggg[6],aggg[7])
				ply:SetNW2String( "A_ActMod.GetMSS_Tab", ttab )
			end
		elseif GTab == "CToS_Loop" then
			ply:SetNWInt("A_ActMod_cl_Loop",tonumber(Tab[2]))
		elseif GTab == "CToS_ASyn" then
			ply:SetNWBool("A_ActMod_cl_ASync",tobool(Tab[2]))
		elseif GTab == "CToS_Effe" then
			ply:SetNWInt("A_ActMod_cl_Effects",tobool(Tab[2]))
		elseif GTab == "CToS_Sond" then
			ply:SetNWInt("A_ActMod_cl_Sound",tobool(Tab[2]))
			if not Tab[3] or Tab[3] and tobool(Tab[3]) ~= true then
				A_AM.ActMod:C_StopSond(ply,"1") A_AM.ActMod:C_StopSond(ply,"2") A_AM.ActMod:C_StopSond(ply,"3")
			end
		elseif GTab == "ClToSv_ReTast" then
			local ttrue = ""
			if Tab[2] then ttrue = tostring(Tab[2]) end
			A_AM.ActMod:ReTast_Seq_restuo(ply,ttrue)
		elseif GTab == "AngEyeP" then
			if ply:A_ActMod_GetIsAct() then
				if Tab[2] then ply.ActMod_GeetAng = Tab[2] end
			end
		elseif GTab == "ASTC" and isstring(Tab[2]) and Tab[2] ~= "" then
			AClToSv(ply,Tab[2])
		elseif GTab == "G|.BListD" then
			net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {">GSBListD",A_AM.ActMod.Blacklist} ) net.Send(ply)
		elseif GTab == "SCVCom" and (ply:IsListenServerHost() or ply:IsSuperAdmin()) and isstring(Tab[2]) and Tab[2] ~= "" and Tab[3] then
			if Tab[2] == "+|.BListD" then
				A_AM.ActMod:AddBlacklistedDance(Tab[3], Tab[4] ,ply)
				net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {">GSBListD",A_AM.ActMod.Blacklist} ) net.Send(ply)
			elseif Tab[2] == "-|.BListD" then
				A_AM.ActMod:RemoveBlacklistedDance(Tab[3])
				net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {"-SBListD",Tab[3]} ) net.Send(ply)
			elseif Tab[2] == "S|.BListD" then
				A_AM.ActMod:SaveBlacklisted()
				net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {"SLSBListD","S"} ) net.Send(ply)
			elseif Tab[2] == "L|.BListD" then
				A_AM.ActMod:LoadBlacklisted()
				net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {"SLSBListD","L"} ) net.Send(ply)
			else
				if table.HasValue(aattx, Tab[2]) then
					RunConsoleCommand(Tab[2],Tab[3])
				end
			end
		elseif GTab == "CHangeMap" and ply:IsListenServerHost() and isstring(Tab[2]) and Tab[2] ~= "" then
			RunConsoleCommand("changelevel",Tab[2])
		elseif GTab == "CancelCamera" then
			local able = {}
			if Tab[2] and istable(Tab[2]) then able = Tab[2] end
			if ply:A_ActMod_GetIsAct() then
				if able then
					A_AM.ActMod:A_ActMod_OffActing( ply,able )
				else
					A_AM.ActMod:A_ActMod_OffActing( ply )
				end
			end
		elseif GTab == "EndActSV" then
			A_AM.ActMod:A_ActMod_OffActing( ply,nil,nil,true )
		elseif GTab == "LTD.ClToSv" then
			A_AM.ActMod:LTDClToSv( ply,Tab[2],Tab[3] )
		elseif GTab == "ClToSv_OkAct" then
			ply.A_ActModOKAct = true
		elseif GTab == "ClToSv_PlyP_ToSv" then
			if Tab[2] and istable(Tab[2]) then
				local GTab = Tab[2]
				local ply = GTab[1]
				local ply2 = GTab[2]
				local txt = GTab[3] or ""
				local RTable = GTab[4] or {}
				local STxt,ToPly
				if IsValid( ply ) and IsValid( ply2 ) and txt and RTable then
					if txt == "GetTableFromPly" then  STxt = "GetTableFromPly_ToPly2"  ToPly = ply2
					elseif txt == "GetTableFromPly_ToPly1" then STxt = "GetTableFromPly_ToPly1_Finsh"  ToPly = ply
					elseif txt == "GetTabiPly_1To2_Start" then STxt = "GetTabiPly_1To2"  ToPly = ply2
					elseif txt == "GetTabiPly_2To1" then STxt = "GetTabiPly_Finsh"  ToPly = ply
					elseif txt == "GetTabiPly_Avs_Get_1To2" then STxt = "GetTabiPly_Avs_Get_Start"  ToPly = ply2
					elseif txt == "GetTabiPly_Avs_Get_2To1" then STxt = "GetTabiPly_Avs_Get_Finsh"  ToPly = ply
					elseif txt == "GetTabiPly_Avs_Set_1To2" then STxt = "GetTabiPly_Avs_Set_Start"  ToPly = ply2
					elseif txt == "GetTabiPly_Avs_Set_2To1" then STxt = "GetTabiPly_Avs_Set_Finsh"  ToPly = ply
					end
					if STxt then
						net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"SC_T_PlyP_ToCl",ply,ply2,STxt,RTable} ) net.Send(ToPly)
					end
				end
			end
		elseif GTab == "ClToSv_aenforce_model" then
			local txtmdl = Tab[2]
			if IsValid(ply) and txtmdl and isstring(txtmdl) and txtmdl ~= "" and file.Exists(txtmdl,"GAME") then
				ply.aenforce_model = txtmdl
			else
				ply.aenforce_model = nil
			end
		elseif GTab == "wts_SAng" then
			if ply:A_ActMod_GetIsAct() then
				local ang_p = Tab[2]
				local ang_y = Tab[3]
				if isangle(Tab[4]) then ply.ActMod_GeetAng = Tab[4] end
				if ang_p and ang_y then
					if isnumber(ang_p) and isnumber(ang_y) then
						local AngY = ply:EyeAngles().y
						local atXt = ply:GetNWString("ActMod_aAng","")
						if atXt ~= "" then
							local TtXt = string.Explode("|", atXt, true)
							if TtXt and istable(TtXt) and TtXt[1] and TtXt[1] == "1" and TtXt[3] then
								AngY = TtXt[3]
							end
						end
						ply:SetNWString("a_SEyeCuAngles",string.format("%s|%s|%s",ang_p,ang_y,AngY))
					end
				end
			end
		end
	end
end
net.Receive("A_AM.ActMod.ClToSv_Tab", function(len, ply)
	T_ClToSv_Tab(ply,net.ReadTable())
end )


local function achackPlyOther(ply)
	if istable(ply.aGetPlyjoing) then
		if ply.aGetPlyjoing["Y"] and ply.aGetPlyjoing["pl2"] then
			local pl2 = ply.aGetPlyjoing["pl2"]
			if istable(pl2) or isentity(pl2) then
				if IsValid(pl2) then
					A_AM.ActMod:A_ActMod_OffTGem( pl2 )
					A_AM.ActMod:A_ActMod_OffTGem( pl2,true )
					A_AM.ActMod:A_ActMod_OffActing( pl2 )
				elseif istable(pl2) then
					for k, v in pairs( pl2 ) do
						if v ~= ply then
							A_AM.ActMod:A_ActMod_OffTGem( v )
							A_AM.ActMod:A_ActMod_OffTGem( v,true )
							A_AM.ActMod:A_ActMod_OffActing( v )
						end
					end
				end
			end
		end
		if ply.aGetPlyjoing["T"] and ply.aGetPlyjoing["pl1"] and IsValid(ply.aGetPlyjoing["pl1"]) then
			local pl2 = ply.aGetPlyjoing["pl1"]
			A_AM.ActMod:A_ActMod_OffTGem( pl2,nil,true )
		end
	end
end

function A_AM.ActMod:AAStart(ply,GetStrg,tAb,Oall,GHold,isRunSu)
	
	if A_AM.ActMod:IsDanceBlacklisted(GetStrg) then
		if ply:IsPlayer() and not ply:IsBot() then ply:PrintMessage( 3,"(ActMod)!: [ ".. A_AM.ActMod:ReNameAct(A_AM.ActMod:ReString(GetStrg)) .." ]> ".. aR:T("Ltxt_Blocked")) end
		return
	end
	
	local txtNAct = A_AM.ActMod:A_ActMod_GetActString(GetStrg)
	local GTabActO = A_AM.ActMod.GTabActO[txtNAct.txt]
	if GTabActO and isnumber(GTabActO["NoStop"]) and GTabActO["NoStop"] == 63 then
		hook.Run( "ActMod_sv_RunStartGesture" , ply,GetStrg,tAb,Oall,GHold,isRunSu )
		if GetStrg == "._" then
			Act_SGesture(ply,ActMod_GStrg)
		else
			if hook.Call("ActMod_sv_DontStartGesture",nil,ply,GetStrg,tAb,GHold,"SV_RunStartGesture") == true then return end
			A_AM.ActMod:ActMod_SSTr(ply,GetStrg)
		end
		return
	end
	
	hook.Run( "ActMod_sv_RunStartAct" , ply,GetStrg,tAb,Oall,GHold,isRunSu )
	if hook.Call("ActMod_sv_DontStartAct",nil,ply,GetStrg,tAb,GHold,"SV_RunStartAct") == true then return end
	
	ply.AGSped_f = 0 ply.AGSped_b = 0 ply.afixAng3 = CurTime()
	ply.aCSound2 = nil ply.AActNFfct = 0
	ply.actmod_sv_OnlyoneNext = nil
	ply.DEFiCycleWS = nil
	ply.rOn_MForward = 0
	ply.ActMod_ReaginRunAct = nil
	if not isRunSu then achackPlyOther(ply) end
	
	local EIndx = ply:EntIndex()
	if timer.Exists( "AA_TReA" .. EIndx ) then timer.Remove( "AA_TReA" .. EIndx ) end
	if timer.Exists( "AA_TMov" .. EIndx ) then timer.Remove( "AA_TMov" .. EIndx ) end
	if timer.Exists( "AA_TSTr" .. EIndx ) then timer.Remove( "AA_TSTr" .. EIndx ) end
	if timer.Exists( "AA_ttst".. EIndx ) then timer.Remove( "AA_ttst".. EIndx ) end
	if timer.Exists( "AA_ttst1".. EIndx ) then timer.Remove( "AA_ttst1".. EIndx ) end
	if timer.Exists( "AA_ttst2".. EIndx ) then timer.Remove( "AA_ttst2".. EIndx ) end
	if timer.Exists( "ActModAnimLSW_|".. EIndx ) then timer.Remove( "ActModAnimLSW_|".. EIndx ) end
	if timer.Exists( "ActModAnimSSW_|".. EIndx ) then timer.Remove( "ActModAnimSSW_|".. EIndx ) end
	ply.actmod_WaitNxt = CurTime() + 0.2
	ply.ActMod_CurTRun = CurTime()
	
	if not ply:A_ActMod_GetIsAct() then
		ply.actmod_PlayerLockAngles = nil
		ply:SetNWString("a_SEyeCuAngles","")
		ply:SetNWInt("a_SRLAngMove", 0)
		ply.A_ActMod_GetHldOffTPK = CurTime() + 0.3
		ply.ActMod_CurTStart = CurTime()
		A_AM.ActMod:A_ActMod_falallTPKey( ply )
	end
	
	ply:SetNWInt( "A_ActMod.GetNJoing" ,0 )
	ply:SetNWAngle("A_ActMod_cl_vrAM_int",Angle(0,0,0))
	ply:SetNWInt("A_ActMod_cl_SysAM_Time",0)
	ply:SetNWVector( "ply.AGSped_vel", Vector(0,0,0) )
	ply:SetNWBool( "A_AM.ActRAgin", false )
	ply:SetNWBool( "A_AM.ActMod.OnHimself", false )
	
	local aank = true
	if tAb then
		ply.ActMod_tAb = tAb
		if tAb[5] and tonumber(tAb[5]) ~= 0 then aank = false end
	else
		ply.ActMod_tAb = nil
	end
	if aank then
		ply.TimeGo_Attk = nil
		A_AM.ActMod:A_ActMod_OffTGem( ply )
		A_AM.ActMod:A_ActMod_OffTGem( ply,true )
	end
	
	ply.SVAct_Svsound = nil
	if Oall then ply.ActMod_Oall = Oall else ply.ActMod_Oall = nil end
	if GHold and isnumber(GHold) and GHold > 0 then
		if Oall and ply:A_ActMod_GetIsAct() == false or not Oall then A_AM.ActMod:ActMod_SSTr(ply,"idle_all_02") end
		if timer.Exists( "AA_TStratA0".. EIndx ) then timer.Remove( "AA_TStratA0".. EIndx ) end
		timer.Create("AA_TStratA0".. EIndx,GHold,1,function()
			if IsValid( ply ) then
				ply:SetNWString("A_ActMod_cl_actLoop",GetStrg)
				A_AM.ActMod:ActMod_SSTr(ply,GetStrg)
			end
		end)
	else
		ply:SetNWString("A_ActMod_cl_actLoop",GetStrg)
		A_AM.ActMod:ActMod_SSTr(ply,GetStrg)
	end
end


local function Commt_Sv(ply,args)
	if A_AM.ActMod.Develop then print("[["..ply:Nick().."]]Commt_Sv  ",args[1],args[2],args[3],args[4]) end
	if args[1] == "wts" then
		if IsValid( ply ) and (ply.ActMod_CurTRun or 0) < CurTime() - 0.15 and (args[2] ~= ply:GetNWString("A_ActMod_cl_actLoop","") or (ply.ActMod_CurTRun or 0) < CurTime()-0.9) then
			ply:SetNWBool("A_ActMod_cl_Sound", args[3] and args[3] == "1" or false)
			ply:SetNWBool("A_ActMod_cl_Effects", args[4] and args[4] == "1" or false)
			if args[5] then
				local cacc = tostring( args[5] )
				if cacc == "1" then
					ply:SetNWInt("A_ActMod_cl_Loop", 1)
				elseif cacc == "2" then
					ply:SetNWInt("A_ActMod_cl_Loop", 2)
				else
					ply:SetNWInt("A_ActMod_cl_Loop", 0)
				end
			else
				ply:SetNWInt("A_ActMod_cl_Loop", 0)
			end
			ply:SetNWBool("A_ActMod_cl_ASync", args[6] and args[6] == "1" or false)
			local TmpNwLt = string.format("<%s|%s|%s|%s|%s>",tostring(args[2]),tostring(args[3]),tostring(args[4]),tostring(args[5]),tostring(args[7]))
			if not ply.ActMod_TmpSStrLst or ply.ActMod_TmpSStrLst ~= TmpNwLt then
				ply.ActMod_TmpSStrLst = TmpNwLt
				A_AM.ActMod:AAStart(ply,args[2])
			end
		end
	elseif args[1] == "stpg" then
		Act_SGesture(ply,"._")
	elseif args[1] == "CToS_SvCTSvr" then
		local pl = Entity( args[2] )
		local npr = tonumber(args[3]) or 0
		if IsValid(pl) then pl.ActMod_TabTSrvr = npr end
	elseif args[1] == "wts_SCTS" then AClToSv(ply,args[2])
	elseif args[1] == "SetRAnim_SPly" then
		local pl = Entity( args[2] )
		local plT = Entity( args[3] )
		if IsValid(pl) and IsValid(plT) then
			net.Start( "A_AM.ActMod.SvToCl_Tab" )
			 net.WriteTable( {"ActMod.SToC_ST","SToC_",{"SetRAnim_TPly",plT:EntIndex(),pl:EntIndex()}} )
			net.Send(plT)
		end
	elseif args[1] == "SetRAnim_KPly" then
		local pl = Entity( args[2] )
		if IsValid(pl) then
			net.Start( "A_AM.ActMod.SvToCl_Tab" )
			 net.WriteTable( {"ActMod.SToC_ST","SToC_",{"SetRAnim_DPly",pl:EntIndex()}} )
			net.Send(pl)
		end
	elseif args[1] == "wts_SEL" then
		local Se_1,Se_2,Se_3,Se_4 = false,false,0,false
		if args[2] then Se_1 = tobool(args[2]) end
		if args[3] then Se_2 = tobool(args[3]) end
		if args[4] then Se_3 = tonumber(args[4]) end
		if args[5] then Se_4 = tobool(args[5]) end
		ply:SetNWBool("A_ActMod_cl_Sound",Se_1)
		ply:SetNWBool("A_ActMod_cl_Effects",Se_2)
		ply:SetNWInt("A_ActMod_cl_Loop",Se_3)
		ply:SetNWBool("A_ActMod_cl_ASync",Se_4)
	elseif args[1] == "CToS_Sond" then
		local pl = Entity( args[2] )
		if IsValid(pl) then
			pl:SetNWBool("A_ActMod_cl_Sound",tobool(args[3]))
			for _, pla in player.Iterator() do if IsValid(pla) and !pla:IsBot() then pla:ConCommand("actmod_wtc CToS_Sond ".. args[2] .."\n") end end
		end
	elseif args[1] == "CToS_AJoing" then
		local pl = Entity( args[2] )
		local pl2 = Entity( args[3] )
		if IsValid(pl) and pl:IsPlayer() and (ply:IsSuperAdmin() or pl == ply) and pl:Alive() and pl:GetObserverMode() == 0 and IsValid(pl2) and pl2:IsPlayer() and pl2:A_ActModASync() and pl2:Alive() and pl2:GetObserverMode() == 0 then
			local Tab = args[4]
			local txtmdl = args[5]
			if txtmdl and isstring(txtmdl) and txtmdl ~= "" and file.Exists(txtmdl,"GAME") then pl.aenforce_model = txtmdl else pl.aenforce_model = nil end
			if A_AM.ActMod:CGoodStartCoop(pl,pl2)[1] then
				if (pl ~= ply and ply:IsSuperAdmin() or not pl:A_ActMod_GetIsAct()) then A_AM.ActMod:A_ActMod_AJoing( pl,pl2,Tab ) end
			else
				pl:ConCommand("actmod_wtc SToC_AJoingF ".. tostring(args[2]) .." ".. tostring(args[3]) .."\n")
			end
		end
	elseif args[1] == "CToS_Effe" then ply:SetNWBool("A_ActMod_cl_Effects",tobool(args[3]))
	elseif args[1] == "CToS_Loop" then ply:SetNWInt("A_ActMod_cl_Loop",tonumber(args[3]))
	elseif args[1] == "CToS_ASyn" then ply:SetNWBool("A_ActMod_cl_ASync",tobool(args[3]))
	elseif args[1] == "wts_End" then
		if args[2] and args[3] then
			if args[2] == "TrStop" then
				if args[3] ~= "" and string.sub(args[3],1,1) == "[" and string.sub(args[3],-1) == "]" then
					local aa = string.sub(args[3],2,-2)
					if aa == ply:GetNWString("A_ActMod.OneStart1","") then
						A_AM.ActMod:A_ActMod_OffActing( ply )
					end
				end
			else
				A_AM.ActMod:A_ActMod_OffActing( ply ,nil,{tonumber( args[2] ),tonumber( args[3] )} )
			end
		else
			A_AM.ActMod:A_ActMod_OffActing( ply )
		end
	elseif args[1] == "wts_SAng" then
		local ang_p = args[2]
		local ang_y = args[3]
		if ang_p and ang_y then
			if isnumber(tonumber(ang_p)) and isnumber(tonumber(ang_y)) then
				local AngY = ply:EyeAngles().y
				local atXt = ply:GetNWString("ActMod_aAng","")
				if atXt ~= "" then
					local TtXt = string.Explode("|", atXt, true)
					if TtXt and istable(TtXt) and TtXt[1] and TtXt[1] == "1" and TtXt[3] then
						AngY = TtXt[3]
					end
				end
				ply:SetNWString("a_SEyeCuAngles",string.format("%s|%s|%s",ang_p,ang_y,AngY))
			end
		end
	elseif args[1] == "wts_EyeOk" then
		local TOK = args[2]
		if TOK then
			if not ply.ActMod_SECuAng then ply.ActMod_SECuAng = {TOK = 0 ,S_pitch = 0 ,S_yaw = 0 ,pitch = 0 ,yaw = 0} end
			if ply.ActMod_SECuAng then
				ply.ActMod_SECuAng.TOK = tonumber(TOK)
				if ply.ActMod_SECuAng.TOK <= 0 then
					ply.ActMod_SECuAng.S_pitch = 0
					ply.ActMod_SECuAng.S_yaw = 0
				end
				ply:SetNWString("a_SEyeCuAngles",string.format("%s|%s",ply.ActMod_SECuAng.S_pitch,ply.ActMod_SECuAng.S_yaw))
			end
		end
	end
end

function A_AM.ActMod:Commt_Sv(ply,tbl)
	Commt_Sv(ply,tbl)
end

concommand.Add("actmod_wts", function(ply, cmd, args)
	if IsValid(ply) and ply:IsPlayer() then
		Commt_Sv(ply,args)
	end
end)

local function aa__BStrt(pl)
	local atXt = pl:GetNWString("A_ActMod.OneStart1","")
	if atXt ~= "" then
		local TtXt = string.Explode("|", atXt, true)
		if TtXt and istable(TtXt) and TtXt[2] then
			local Tab1,Tab2,rrr = {"",0,0,0},{0,0,0,0,0},0
			if TtXt[3] and TtXt[6] then Tab1 = {TtXt[3],TtXt[4],TtXt[5],TtXt[6]} end
			if TtXt[7] and TtXt[11] then Tab2 = {TtXt[7],TtXt[8],TtXt[9],TtXt[10],TtXt[11]} end
			local Strg2 = ""
			if TtXt[14] and TtXt[14] ~= "" then Strg2 = TtXt[14] end
			if TtXt[1] and TtXt[2] then
				pl:SetNWAngle("A_ActMod_cl_vrAM_int",Angle(0,0,0))
				A_AM.ActMod:StartAniAct( pl,TtXt[1],tobool(rrr),Tab1,Tab2,Strg2,TtXt[15] )
			end
		end
	end
end


function A_AM.ActMod:Remove_TabPlysNoClp(pl,aLl)
	if pl.a_TabPlysNoClp and istable(pl.a_TabPlysNoClp) and not table.IsEmpty(pl.a_TabPlysNoClp)
	and ( aLl or pl.a_TabPlysNoClp["TTrRemvPly"] and istable(pl.a_TabPlysNoClp["TTrRemvPly"]) ) then
		for k, TP in pairs(pl.a_TabPlysNoClp) do
			if k ~= "" then
				local TtXt = string.Explode("_#._", k, true)
				if TtXt and istable(TtXt) and TtXt[2] then
					if TP["Ply"] and IsValid(TP["Ply"]) and TP["Ply"]:SteamID64() == TtXt[1] and TP["Ply"]:Nick() == TtXt[2] then
						local tr1 = NULL
						if not aLl then
							tr1 = util.TraceHull({
								start = TP["Ply"]:GetPos(), endpos = TP["Ply"]:GetPos() + Vector( 0, 0, 0 )
								,filter = function(ent) if ent:IsPlayer() and ent ~= TP["Ply"] and A_AM.ActMod:ATabData( pl.a_TabPlysNoClp["TTrRemvPly"], ent ) == true then return true end end
								,mins = TP["Ply"]:OBBMins(), maxs = TP["Ply"]:OBBMaxs()
							}).Entity
						end
						if aLl or (not tr1 or tr1 == NULL) and A_AM.ActMod:ATabData( pl.a_TabPlysNoClp.TTrRemvPly, TP["Ply"] ) == true then
							if isnumber(TP.CGroup) then TP.Ply:SetCollisionGroup( TP["CGroup"] ) else TP.Ply:SetCollisionGroup( COLLISION_GROUP_PLAYER ) end
							if isbool(TP.Avoid) then TP.Ply:SetAvoidPlayers( TP.Avoid ) end
							if isbool(TP.GetCustom) then TP.Ply:SetCustomCollisionCheck( TP["GetCustom"] ) else TP.Ply:SetCustomCollisionCheck( false ) end
							if istable(pl.a_TabPlysNoClp.TTrRemvPly) then table.RemoveByValue(pl.a_TabPlysNoClp.TTrRemvPly,TP.Ply) end
							local ePl = pl:SteamID64() .."_#._"..pl:Nick()
							if not pl.T_TabPly12SNoClp then pl.T_TabPly12SNoClp = {} end
							if not TP.Ply.T_TabPly12SNoClp then TP.Ply.T_TabPly12SNoClp = {} end
							TP.Ply.T_TabPly12SNoClp[ePl] = nil
							pl.T_TabPly12SNoClp[k] = nil
							pl.a_TabPlysNoClp[k] = nil
						end
					end
				end
			end
		end
	end
end
function A_AM.ActMod:ASrv_TabPlysNoClp(aLl)
	if A_AM.ActMod.a_TabPlysNoClp == nil or not istable(A_AM.ActMod.a_TabPlysNoClp) then A_AM.ActMod.a_TabPlysNoClp = {} end
	local TbS = A_AM.ActMod.a_TabPlysNoClp
	if not TbS.TTrRemvPly then TbS.TTrRemvPly = {} end
	if TbS and istable(TbS) and not table.IsEmpty(TbS) and ( aLl or TbS.TTrRemvPly and istable(TbS.TTrRemvPly) ) then
		for k, TP in pairs(TbS) do
			if k ~= "" then
				local TtXt = string.Explode("_#._", k, true)
				if TtXt and istable(TtXt) and TtXt[2] then
					if TP.Ply and ( TP.STimer and ( TP["+STimer"] and TP.STimer + TP["+STimer"] or TP.STimer ) < CurTime()-1 or not TP.STimer ) then
						if IsValid(TP.Ply) and TP.Ply:SteamID64() == TtXt[1] and TP.Ply:Nick() == TtXt[2] then
							local PlT = TP.Ply
							local tr1 = NULL
							if not aLl then
								tr1 = util.TraceHull({
									start = PlT:GetPos(), endpos = PlT:GetPos() + Vector( 0, 0, 0 )
									,filter = function(ent) if ent:IsPlayer() and ent ~= PlT and ent:Alive() and A_AM.ActMod:ATabData( TbS.TTrRemvPly, ent ) == true then return true end end
									,mins = PlT:OBBMins(), maxs = PlT:OBBMaxs()
								}).Entity
							end
							if aLl or (not tr1 or tr1 == NULL or not PlT:Alive()) and A_AM.ActMod:ATabData( TbS.TTrRemvPly, PlT ) == true then
								if isnumber(TP.CGroup) then PlT:SetCollisionGroup( TP.CGroup ) else PlT:SetCollisionGroup( COLLISION_GROUP_PLAYER ) end
								if isbool(TP.Avoid) then PlT:SetAvoidPlayers( TP.Avoid ) end
								if isbool(TP.GetCustom) then PlT:SetCustomCollisionCheck( TP.GetCustom ) else PlT:SetCustomCollisionCheck( false ) end
								if istable(TbS.TTrRemvPly) then table.RemoveByValue(TbS.TTrRemvPly,PlT) end
								TbS[k] = nil
							end
						elseif not IsValid(TP.Ply) then
							if TbS.TTrRemvPly then table.RemoveByValue(TbS.TTrRemvPly,PlT) end
							TbS[k] = nil
						end
					end
				end
			end
		end
		if table.Count(TbS) == 1 and TbS.TTrRemvPly and #TbS.TTrRemvPly > 0 then TbS.TTrRemvPly = {} end
	end
end

local function aa__STabPls(Tab,aTab,aPos,pl,pl2)
	if aTab.rPos and (Tab.ReTimer or 0) > CurTime() -1.2 and A_AM.ActMod:hereIsGood( pl,pl2,istable(Tab.pl2),1 ) == false then Tab.ReTimer = Tab.ReTimer - 1.5 end
	if (Tab.ReTimer or 0) > CurTime() -1.2 then
		local T2ab = IsValid(pl2) and pl2.aGetPlyjoing
		local OBi,OBa = pl:OBBMins(),pl:OBBMaxs()
		local OBz = OBa.z*0.1
		OBa.z = OBa.z*0.9
		local goodtp = not util.TraceHull({
			start = pl2:GetPos()+Vector(0,0,OBz), endpos = pl:GetPos() ,mins = OBi ,maxs = OBa
			,filter = function(ent)
				local ata = true
				if ent:IsPlayer() and ent:Alive() and (ent == pl2 or ent == pl or (IsValid(pl.aGetPlyjoing.pl2) and pl.aGetPlyjoing.pl2 == pl2 or istable(pl.aGetPlyjoing.pl2) and A_AM.ActMod:ATabData( pl.aGetPlyjoing.pl2, ent ))) then ata = false end
				if ata then return true end
			end
		}).Hit
		if aTab["rPos"] then
			local aForward,aRight,aPmax = 0,0,28
			if aTab["TPos"] then
				local TforNJn = pl.a_TabPlysTem and istable(pl.a_TabPlysTem) and pl.a_TabPlysTem[pl2:SteamID64() .."_#._"..pl2:Nick()] and tonumber(pl.a_TabPlysTem[pl2:SteamID64() .."_#._"..pl2:Nick()]["Num"])
				local NJn = TforNJn or 0
				if aTab["TPos"][NJn] then
					if aTab["TPos"][NJn][1] then aForward = aTab["TPos"][NJn][1] end
					if aTab["TPos"][NJn][2] then aRight = aTab["TPos"][NJn][2] end
				end
			else
				if aTab["Forward"] then aForward = aTab["Forward"] end
				if aTab["Right"] then aRight = aTab["Right"] end
			end
			if aTab["Sav_TryFixPos"] then
				if aTab["Sav_TryFixPos"]["Forward"] then aForward = aTab["Sav_TryFixPos"]["Forward"] end
				if aTab["Sav_TryFixPos"]["Right"] then aRight = aTab["Sav_TryFixPos"]["Right"] end
			else
				A_AM.ActMod:A_cshk( pl,pl2,aTab,aForward,aRight,function(a1,a2,addnum)
					aTab["Sav_TryFixPos"] = {}
					if aTab.TryFixPos then
						if aTab.TryFixPos["-Forward"] then aForward = aForward-addnum aTab.Sav_TryFixPos.Forward = aForward end
						if aTab.TryFixPos["+Forward"] then aForward = aForward+addnum aTab.Sav_TryFixPos.Forward = aForward end
						if aTab.TryFixPos["-Right"] then aRight = aRight-addnum aTab.Sav_TryFixPos.Right = aRight end
						if aTab.TryFixPos["+Right"] then aRight = aRight+addnum aTab.Sav_TryFixPos.Right = aRight end
					end
					aForward = a1 aRight = a2
				end)
			end
			if aTab.PAng then
				if not aTab.PAng_ok or (Tab.ReTimer or 0) <= CurTime() -0.8 then
					aTab.PAng_ok = true
					local aAng,bAng = Angle(0,0,0),Angle(0,0,0)
					aAng = ( pl2:GetPos() - pl:GetPos() ):Angle()
					bAng = ( pl:GetPos() - pl2:GetPos() ):Angle()
					pl:SetEyeAngles(Angle(0,aAng.y,0))
					pl2:SetEyeAngles(Angle(0,bAng.y,0))
					pl2:SetNWString("ActMod_aAng",string.format("1|%s|%s",aAng.p,aAng.y))
					pl:SetNWString("ActMod_aAng",string.format("1|%s|%s",bAng.p,bAng.y))
				end
			end
			if aTab.Ang_2To1 then
				aPos = LerpVector( math.Clamp((CurTime() - Tab.ReTimer )/Tab.Time ,0,1), pl2:GetPos(), pl:GetPos() + pl:GetForward() * aForward + pl:GetRight() * aRight )
			else
				local tbAng = ( pl2:GetPos() - pl:GetPos() ):Angle()
				tbAng.p = 0 tbAng.r = 0
				Tab.GoPos = pl:GetPos() + tbAng:Forward() * aForward + pl:GetRight() * aRight
				aPos = LerpVector( math.Clamp((CurTime() - Tab.ReTimer )/Tab.Time ,0,1), pl2:GetPos(), Tab.GoPos )
			end
			local Tmins,Tmaxs = pl2:GetHull()
			local Amaxs = Tmaxs.z * 0.9
			Tmaxs.z = Tmaxs.z * 0.2
			local trPos = util.TraceHull({
				start = aPos+Vector(0,0,Amaxs*0.2), endpos = aPos,
				filter = function(ent)
					local aaw = true
					if ent:IsPlayer() then
						local TbS = pl.a_TabPlysTem
						local EPly = ent:SteamID64() .."_#._"..ent:Nick()
						if ( TbS and TbS[EPly] ) or (ent == pl or ent == pl2) then aaw = false end
					end
					if aaw then return true end
				end, mask = MASK_ALL, mins = Tmins, maxs = Tmaxs
			})
			if Tab.ReTimer > CurTime() - 0.81 then
				if goodtp then
					if istable(T2ab) and T2ab.SdPos then
						pl2:SetPos(trPos.HitPos) pl2:SetLocalVelocity(Vector(0,0,0))
					else
						pl2:SetLocalPos(trPos.HitPos)
						pl2:SetLocalVelocity(pl:GetVelocity())
					end
				end
			else
				if not Tab["PosDone"] and trPos.HitPos:Distance(pl2:GetPos()) ~= 0 then
					Tab["PosDone"] = true
					Tab["PosDone2"] = (Tab["PosDone2"] or 0) + 1
					if goodtp then pl2:SetPos(trPos.HitPos) end
				end
			end
		else
			if istable(T2ab) and T2ab.TPosAng and not T2ab.TPosAng_ok then
				T2ab.TPosAng_ok = true
				if goodtp and T2ab.TPosAng[1] then
					pl2:SetLocalPos(T2ab.TPosAng[1]) pl2:SetLocalVelocity(Vector(0,0,0))
				end
				if T2ab.TPosAng[2] then pl2:SetEyeAngles(Angle(0,T2ab.TPosAng[2].y,0)) end
			end
		end
		if aTab["rAng"] then
			if Tab["ReTimer"] > CurTime() - 0.81 then
				local aAng,bAng = Angle(0,0,0),Angle(0,0,0)
				if istable(T2ab) and T2ab.SdPos then
					aAng.y = pl:EyeAngles().y
					pl2:SetEyeAngles(Angle(0,aAng.y,0))
					pl2:SetNWString("ActMod_aAng",string.format("1|%s|%s",aAng.p,aAng.y))
					return
				end
				if aTab["r180"] then
					aAng = ( pl:GetPos() - pl2:GetPos() ):Angle()
					if aTab["Ang_2To1"] or not Tab["GoPos"] then
					else
						bAng = ( Tab["GoPos"] - pl:GetPos() ):Angle()
					end
				else
					aAng = pl:EyeAngles()
					if not aTab["Ang_2To1"] then bAng = pl2:EyeAngles() end
				end
				aAng.p = 0 aAng.r = 0
				if isnumber(aTab.AddAngY_P2) then aAng.y = aAng.y + aTab.AddAngY_P2 end
				if isnumber(aTab.AddAngY_P1) then bAng.y = bAng.y + aTab.AddAngY_P1 end
				pl2:SetEyeAngles(Angle(0,aAng.y,0))
				pl2:SetNWString("ActMod_aAng",string.format("1|%s|%s",aAng.p,aAng.y))
				if aTab["Ang_2To1"] then
					bAng = pl:EyeAngles()
					bAng.p = 0 bAng.r = 0
					if isnumber(aTab.AddAngY_P1) then bAng.y = bAng.y + aTab.AddAngY_P1 end
					pl:SetEyeAngles(Angle(0,bAng.y,0))
					pl:SetNWString("ActMod_aAng",string.format("1|%s|%s",bAng.p,bAng.y))
				else
					bAng.p = 0 bAng.r = 0
					pl:SetEyeAngles(Angle(0,bAng.y,0))
					pl:SetNWString("ActMod_aAng",string.format("1|%s|%s",bAng.p,bAng.y))
				end
			end
		end
	end
end

function A_AM.ActMod:SaveBlacklisted()
	if not file.Exists("actmod", "DATA") then file.CreateDir("actmod") end
	local data = util.TableToJSON(A_AM.ActMod.Blacklist)
	file.Write("actmod/banned_dances.txt", data)
end
function A_AM.ActMod:LoadBlacklisted()
	if not file.Exists("actmod", "DATA") then file.CreateDir("actmod") end
	if file.Exists("actmod/banned_dances.txt", "DATA") then
		local data = file.Read("actmod/banned_dances.txt", "DATA")
		local BannedDances = util.JSONToTable(data) or {}
		if istable(BannedDances) then
			A_AM.ActMod.Blacklist = BannedDances
			net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {">GSBListD",A_AM.ActMod.Blacklist} ) net.Broadcast()
		end
	end
end
A_AM.ActMod:LoadBlacklisted()

function A_AM.ActMod:Think()
	for _, pl in player.Iterator() do
		if IsValid(pl) then
			if pl:A_ActMod_IsActing() then
				if GetConVarNumber("actmod_sv_a_ground") == 1 and not pl:OnGround() then A_AM.ActMod:A_ActMod_OffActing( pl ) end
				if pl.aaBThinStrt and pl.aaBThinStrt < CurTime() then aa__BStrt(pl) end
				if pl.AalowAnim then A_AM.ActMod:ThinkChingAni(pl) end
				if pl.AAct_Eff then
					for k, v in pairs(pl.AAct_Eff) do
						if v["ents"] and v["ents"] != NULL and IsValid(v["ents"]) then
							v["ents"]:SetPos( pl:GetBonePosition(v["B_"]) )
						end
					end
				end
				if A_AM.ActMod:A_ActMod_GetOtherF( pl ) == true then A_AM.ActMod:EndAct( pl ) end
				if GetConVarNumber("actmod_sv_ondcklpos") > 0 and (pl.aarrSVTPt or 0) < CurTime() and not A_AM.ActMod:IsValidTPosition(pl) then
					pl.aarrSVTPt = CurTime()+0.5
					A_AM.ActMod:A_ActMod_OffActing( pl )
					pl:PrintMessage( 3,"(ActMod)!: ".. aR:T("ThIsNoAGoodP"))
					continue
				end
				if pl.aGetPlyjoing and istable(pl.aGetPlyjoing) and pl.aGetPlyjoing["Y"] and pl.aGetPlyjoing["pl2"] and ( istable(pl.aGetPlyjoing["pl2"]) or IsValid(pl.aGetPlyjoing["pl2"])
				and pl.aGetPlyjoing["pl2"].aGetPlyjoing and istable(pl.aGetPlyjoing["pl2"].aGetPlyjoing) and pl.aGetPlyjoing["pl2"].aGetPlyjoing["T"] and pl.aGetPlyjoing["pl2"].aGetPlyjoing["pl1"] and IsValid(pl.aGetPlyjoing["pl2"].aGetPlyjoing["pl1"]) ) then
					local Tab = pl.aGetPlyjoing
					local pl2,aPos = Tab["pl2"],pl:GetPos()
					local aTab = Tab["aTab"]
					if not Tab["Time"] then Tab["Time"] = 0.4 end
					if not Tab["ReTimer"] then Tab["ReTimer"] = CurTime() end
					if aTab and istable(aTab) and pl2 and (istable(pl2) or isentity(pl2)) then
						local addDistance = aTab["MaxDistance"] or 0
						if IsValid(pl2) then
							aa__STabPls(Tab,aTab,aPos,pl,pl2)
							local GDir = pl2:GetNWString("A_ActMod.Dir", "")
							if pl.aGetPlyjoing["ani_pl2"] and not aTab["joining"] and not pl.aGetPlyjoing["AJoined"] and not pl2.aGetPlyjoing["AJoined"] and pl2:A_ActMod_IsActing() == true and (GDir == "amod_fortnite_idle" or GDir == "idle_all_01") then
								pl.aGetPlyjoing["AJoined"] = true
								pl2.aGetPlyjoing["AJoined"] = true
								A_AM.ActMod:A_ActMod_AJoined( pl2,pl ,pl2.aGetPlyjoing["ani_pl1"] ,pl.aGetPlyjoing["ani_pl2"] )
							end
							if aPos:Distance( pl2:GetPos() ) > (A_AM.ActMod.msaf*1.6 + addDistance) then
								A_AM.ActMod:A_ActMod_OffActing( pl2 )
							end
						elseif istable(pl2) then
							for k, v in pairs( pl2 ) do
								if IsValid(v) and v ~= pl then
									aa__STabPls(Tab,aTab,aPos,pl,v)
									if aPos:Distance( v:GetPos() ) > (A_AM.ActMod.msaf*1.6 + addDistance) then
										A_AM.ActMod:A_ActMod_OffActing( v )
									end
								end
							end
						end
					end
				elseif pl.aGetPlyjoing and istable(pl.aGetPlyjoing) and pl.aGetPlyjoing["Y"] then
					A_AM.ActMod:A_EndJoing( pl )
					pl.aGetPlyjoing = nil
				end
			else
				if istable(pl.ActMod_GStrg) and not table.IsEmpty(pl.ActMod_GStrg) then
					if GetConVarNumber("actmod_sv_a_weapact") > 1 and A_AM.ActMod:IsVR(pl) then
						if not pl.ActMod_JOneed then
							if timer.Exists( "AA_TStratA"..pl:EntIndex() ) then timer.Remove( "AA_TStratA"..pl:EntIndex() ) end
							if not pl.aaThinTrue then A_AM.ActMod:gostrt(pl,pl.ActMod_GStrg,nil,aTab2) end
						end
						if pl.aaBThinStrt and pl.aaBThinStrt < CurTime() then aa__BStrt(pl) end
					elseif GetConVarNumber("actmod_sv_a_weapact") >= 1 and pl:GetActiveWeapon() and pl:GetActiveWeapon():IsValid() and pl:HasWeapon("aact_weapact") then
						if pl:GetActiveWeapon():GetClass() == "aact_weapact" then
							if not pl.ActMod_JOneed then
								if timer.Exists( "AA_TStratA"..pl:EntIndex() ) then timer.Remove( "AA_TStratA"..pl:EntIndex() ) end
								if not pl.aaThinTrue then A_AM.ActMod:gostrt(pl,pl.ActMod_GStrg,nil,aTab2) end
							end
							if pl.aaBThinStrt and pl.aaBThinStrt < CurTime() then aa__BStrt(pl) end
						elseif pl:GetActiveWeapon():GetClass() != "aact_weapact" then
							pl:SelectWeapon("aact_weapact")
							if pl:GetActiveWeapon():GetClass() == "aact_weapact" then
								if not pl.ActMod_JOneed then
									if timer.Exists( "AA_TStratA"..pl:EntIndex() ) then timer.Remove( "AA_TStratA"..pl:EntIndex() ) end
									if not pl.aaThinTrue then A_AM.ActMod:gostrt(pl,pl.ActMod_GStrg,nil,aTab2) end
								end
								if pl.aaBThinStrt and pl.aaBThinStrt < CurTime() then aa__BStrt(pl) end
							end
						end
					end
				end
			end
			if A_AM.ActMod.SpSysGesture then A_AM.ActMod.GestureSystem:UpdateGestures(pl) end
		end
	end
	A_AM.ActMod:ASrv_TabPlysNoClp()
end

A_AM.ActMod.bessys_1_Done = true
