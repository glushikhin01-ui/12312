if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.bessys_2 = true

function A_AM.ActMod:A_AddRemvPly( pl,Tply,adtimr )
	if A_AM.ActMod.a_TabPlysNoClp == nil or not istable(A_AM.ActMod.a_TabPlysNoClp) then A_AM.ActMod.a_TabPlysNoClp = {} end
	local TbS = A_AM.ActMod.a_TabPlysNoClp
	if TbS and istable(TbS) and Tply and IsValid(Tply) and Tply:IsPlayer() then
		local PTa = Tply:SteamID64() .."_#._"..Tply:Nick()
		if not TbS[PTa] then TbS[PTa] = { Name = Tply:Nick() ,Ply = Tply ,OK = false ,STimer = CurTime() } end
		if TbS[PTa] then
			if adtimr and isnumber(adtimr) then TbS[Tply:SteamID64() .."_#._"..Tply:Nick()]["+STimer"] = adtimr end
			if not TbS[PTa].CGroup then
				TbS[PTa].CGroup = Tply:GetCollisionGroup()
				TbS[PTa].Avoid = Tply:GetAvoidPlayers()
				TbS[PTa].GetCustom = Tply:GetCustomCollisionCheck()
			end
			Tply:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR ) Tply:SetAvoidPlayers( false ) Tply:SetCustomCollisionCheck( true )
		end
		if not table.HasValue(TbS.TTrRemvPly, Tply) then table.insert(TbS.TTrRemvPly,Tply) end
	end
end
function A_AM.ActMod:A_EndJoing( pl )
	if pl.aGetPlyjoing and istable(pl.aGetPlyjoing) and pl.aGetPlyjoing.T and IsValid(pl.aGetPlyjoing.pl1) then
		local pl2 = pl.aGetPlyjoing.pl1
		if pl2.aGetPlyjoing and istable(pl2.aGetPlyjoing) and pl2.aGetPlyjoing.Y then
			if istable(pl2.aGetPlyjoing.pl2) then
				local aaTabPly = {}
				for k, v in pairs( pl2.aGetPlyjoing.pl2 ) do
					if v == pl then table.insert(aaTabPly,v) end
				end
				for k, v in pairs( aaTabPly ) do
					if v == pl then table.RemoveByValue(pl2.aGetPlyjoing.pl2,v) end
				end
			else
				pl2.aGetPlyjoing = nil
			end
		end
	end
	if pl.aGetPlyjoing and istable(pl.aGetPlyjoing) and pl.aGetPlyjoing.Y and pl.aGetPlyjoing.pl2 then
		local pl2 = pl.aGetPlyjoing.pl2
		if istable(pl2) then
			local aaTabPly = {}
			for k, v in pairs( pl2 ) do
				if v ~= pl then table.insert(aaTabPly,v) end
			end
			for k, v in pairs( aaTabPly ) do
				if v ~= pl then
					v.aGetPlyjoing = nil
					table.RemoveByValue(pl2,v)
				end
			end
		elseif IsValid(pl2) then
			if pl2.aGetPlyjoing and istable(pl2.aGetPlyjoing) and pl2.aGetPlyjoing.pl1 and IsValid(pl2.aGetPlyjoing.pl1) and pl2.aGetPlyjoing.pl1 == pl then
				pl2.aGetPlyjoing = nil
			end
		end
	end
	pl:SetNWString("ActMod_aAng","")
	pl.aGetPlyjoing = nil
end

function A_AM.ActMod:hereIsGood( ply,ply2,ta2,ItS )
	if not IsValid(ply) or not IsValid(ply2) then return false end
	local aPos,aokpos = ply:GetPos(),false
	local aTab = table.Copy(A_AM.ActMod.GTabActCoop[ply:GetNWString( "A_ActMod.TmpDir","" )])
	if aTab and istable(aTab) then
		local aForward,aRight = 0,0
		if aTab["TPos"] then
			local TforNJn = 0
			if IsValid(ply2) and ply.a_TabPlysTem and istable(ply.a_TabPlysTem) and ply.a_TabPlysTem[ply2:SteamID64() .."_#._"..ply2:Nick()] and ply.a_TabPlysTem[ply2:SteamID64() .."_#._"..ply2:Nick()]["H"] then
				TforNJn = tonumber( ply.a_TabPlysTem[ply2:SteamID64() .."_#._"..ply2:Nick()]["Num"] )
			else
				TforNJn = tonumber(A_AM.ActMod:A_ActMod_AGeNumPTem( ply ))
			end
			if ItS and isnumber(ItS) and ItS == 0 and TforNJn == 0 then TforNJn = TforNJn + 1 end
			local NJn = TforNJn
			if aTab["TPos"][NJn] then
				if aTab["TPos"][NJn][1] then aForward = aTab["TPos"][NJn][1] end
				if aTab["TPos"][NJn][2] then aRight = aTab["TPos"][NJn][2] end
				aokpos = true
			end
		else
			if aTab["Forward"] then aForward = aTab["Forward"] end
			if aTab["Right"] then aRight = aTab["Right"] end
		end
		if aTab["TryFixPos"] then
			A_AM.ActMod:A_cshk( ply,ply2,aTab,aForward,aRight,function(a1,a2,addnum)
				aTab["Sav_TryFixPos"] = {}
				if aTab["TryFixPos"]["-Forward"] then aForward = aForward-addnum end
				if aTab["TryFixPos"]["+Forward"] then aForward = aForward+addnum end
				if aTab["TryFixPos"]["-Right"] then aRight = aRight-addnum end
				if aTab["TryFixPos"]["+Right"] then aRight = aRight+addnum end
				aForward = a1 aRight = a2 aokpos = true
			end)
		end
		if aTab["Ang_2To1"] then
			aPos = ply:GetPos() + ply:GetForward() * aForward + ply:GetRight() * aRight
			aokpos = true
		else
			local tbAng = ( ply2:GetPos() - ply:GetPos() ):Angle()
			tbAng.p = 0 tbAng.r = 0
			aPos = ply:GetPos() + tbAng:Forward() * aForward + tbAng:Right() * aRight
		end
	end
	local afilter
	if ta2 then
		afilter = function(ent)
			local aaw = true
			if ent:IsPlayer() then
				local TbS = A_AM.ActMod.a_TabPlysNoClp
				local EPly = ent:SteamID64() .."_#._"..ent:Nick()
				if ( TbS and TbS[EPly] ) or (ent == ply or ent == ply2) then aaw = false end
			end
			if aaw then return true end
		end
	else
		afilter = function(ent)
			local aaw = true
			if ent == ply then aaw = false end
			if ent:IsPlayer() then
				local TbS,TbT,TbP = ply.a_TabPlysTem,ent.a_TabPlysTem,ent.a_TabPlysGem
				local EPly,oPly = ent:SteamID64() .."_#._"..ent:Nick(),ply2:SteamID64() .."_#._"..ply2:Nick()
				if istable(TbT) then
					for tk,tv in pairs(TbT) do if istable(tv) and istable(tv) and tv.H and IsValid(tv.Ply) and tv.Ply == ply then aaw = false end end
				end
				if istable(TbP) then
					for tk,tv in pairs(TbP) do
						if istable(tv) and istable(tv) and tv.J and IsValid(tv.Ply) then
							local tTt = tv.Ply.a_TabPlysTem
							if istable(tTt) and tTt[EPly] then aaw = false end
						end
					end
				end
				if (TbS and TbS[EPly]) or (TbS and TbS[oPly]) or (ent == ply or ent == ply2) then aaw = false end
			end
			if aaw then return true end
		end
	end
	local Amins,Amaxs = ply:GetHull()
	Amaxs.z = Amaxs.z * 0.9
	local tr1 = util.TraceHull({start = ply:GetPos()+Vector(0,0,Amaxs.z*0.1), endpos = aPos+Vector(0,0,Amaxs.z*0.1),filter = afilter ,mins = Amins, maxs = Amaxs, mask = MASK_ALL }).Hit
	local tr2 = aokpos and util.TraceHull({start = ply:GetPos()+Vector(0,0,Amaxs.z*0.1), endpos = ply2:GetPos()+Vector(0,0,Amaxs.z*0.1),filter = afilter ,mins = Amins*0.9, maxs = Amaxs*0.9, mask = MASK_ALL}).Hit
	local tr3 = util.TraceHull({start = aPos+Vector(0,0,Amaxs.z*0.1), endpos = aPos+Vector(0,0,-Amaxs.z*0.1-3),filter = function(e) if e ~= ply and e ~= ply2 and e:GetOwner() ~= ply2 then return true end end ,mins = Amins, maxs = Amaxs, mask = MASK_SOLID }).Hit
	if not tr1 and not tr2 and tr3 then return true end
	return false
end

function A_AM.ActMod:A_ActMod_AGPTem( ply )
	local lnn = 0
	if ply.a_TabPlysTem and istable(ply.a_TabPlysTem) and not table.IsEmpty(ply.a_TabPlysTem) then
		for k, TP in pairs(ply.a_TabPlysTem) do
			if k ~= "" then
				local TtXt = string.Explode("_#._", k, true)
				if istable(TtXt) and TtXt[2] then
					if IsValid(TP["Ply"]) and TP["Ply"] ~= ply and TP["Ply"]:SteamID64() == TtXt[1] and TP["Ply"]:Nick() == TtXt[2] then
						lnn = lnn + 1
					end
				end
			end
		end
	end
	return lnn
end

function A_AM.ActMod:A_ActMod_AGeNumPTem( ply,sTbl,ply2 )
	local GANum = 10
	local lnn = 0
	local TyGNum = 0
	if sTbl and isnumber(sTbl) and sTbl == 1 then
		if sTbl == 1 then
			TyGNum = 1
		end
	end
	local isNmb
	local Tbok = {}
	for i = 1,GANum do
		Tbok[ string.format("%02d",math.max(i,1)) ] = 0
	end
	if TyGNum == 1 then
		lnn = A_AM.ActMod:A_ActMod_AGPTem( ply )
		if ply.a_TabPlysTem and istable(ply.a_TabPlysTem) and not table.IsEmpty(ply.a_TabPlysTem) then
			for k, v in pairs(ply.a_TabPlysTem) do
				if v["Num"] and Tbok[v["Num"]] then
					Tbok[v["Num"]] = 1
				end
			end
		end
	else
		lnn = A_AM.ActMod:A_ActMod_AGPTem( ply )
		if lnn > 0 then
			local Iok = 0
			if ply.a_TabPlysTem and istable(ply.a_TabPlysTem) and not table.IsEmpty(ply.a_TabPlysTem) then
				for k, v in pairs(ply.a_TabPlysTem) do
					if v["Num"] and Tbok[v["Num"]] then
						Tbok[v["Num"]] = 1
					end
				end
			end
			if Iok == 0 then
				for i = 1,GANum do
					local iT = string.format("%02d",math.max(i,1))
					if Tbok and Tbok[iT] and Tbok[iT] == 0 then
						Iok = i
						break
					end
				end
			end
			if Iok == 0 then
				for i = 1,GANum do
					if i ~= lnn then
						Iok = i
						break
					end
				end
			end
			if Iok > 0 then isNmb = math.max(Iok,0) end
		end
		if not isNmb then isNmb = lnn end
	end
	if TyGNum == 1 then
		return math.max(isNmb,1)
	elseif TyGNum == 2 then
		return math.max(isNmb,1)
	else
		return isNmb
	end
end

function A_AM.ActMod:A_ActMod_AJoing( pl1,pl2,TPosAng )
	if not IsValid(pl1) or not IsValid(pl2) then print("[ActMod]: Joining error!  They were not found") return end
	local gCGoodStartCoop = A_AM.ActMod:CGoodStartCoop(pl1,pl2)
	if gCGoodStartCoop[1] then
		local aDir = pl2:GetNWString( "A_ActMod.TmpDir" ,"" )
		if aDir ~= "" then
			local aTab = table.Copy(A_AM.ActMod.GTabActCoop[aDir])
			if not istable(aTab) or table.IsEmpty(aTab) and GetConVarNumber("actmod_sv_alowacop") > 0 then
				aTab = {ani_pl1=aDir,ani_pl2=aDir,Sync=true,SoundOne=true,joining=true}
			end
			if istable(aTab) and not table.IsEmpty(aTab) then
				A_AM.ActMod:A_EndJoing( pl1 )
				if istable(pl2.aGetPlyjoing) and pl2.aGetPlyjoing["T"] and pl2.aGetPlyjoing["pl1"] and IsValid( pl2.aGetPlyjoing["pl1"] ) and istable(pl2.aGetPlyjoing["pl1"].aGetPlyjoing) and pl2.aGetPlyjoing["pl1"].aGetPlyjoing["ajoiningFPO"] then
					pl2 = pl2.aGetPlyjoing["pl1"]
				elseif not aTab["joining"] and (not istable(pl2.aGetPlyjoing) or pl2.aGetPlyjoing["Y"] or pl2.aGetPlyjoing["pl2"] or not istable(pl2.aGetPlyjoing["pl2"]) or table.Count(pl2.aGetPlyjoing["pl2"]) == 0 or not IsValid(pl2.aGetPlyjoing["pl2"][1]) or pl2.aGetPlyjoing["aTab"]) then
					A_AM.ActMod:A_EndJoing( pl2 )
				end
				if aTab and aTab["ani_pl1"] then
					local P2_Sound,P2_Eff,P2_Loop = "0","0","0"
					if pl1.ActMod_tAb and istable(pl1.ActMod_tAb) then
						if pl1.ActMod_tAb[2] then P2_Sound = tostring(pl1.ActMod_tAb[2]) end
						if pl1.ActMod_tAb[3] then P2_Eff = tostring(pl1.ActMod_tAb[3]) end
						if pl1.ActMod_tAb[4] then P2_Loop = tostring(pl1.ActMod_tAb[4]) end
					end
					if aTab["AutoRepetition"] then P2_Loop = "3" end
					if aTab["NoRepetition"] then P2_Loop = "2" end
					if aTab["OnSound"] then P2_Sound = "1" end
					if aTab["NoSound"] or aTab["SoundOne"] then P2_Sound = "2" end
					if aTab["NoEffectP2"] then P2_Eff = "2" end
					if not pl2.a_TabPlysTem then pl2.a_TabPlysTem = {} end
					local GeNum = A_AM.ActMod:A_ActMod_AGeNumPTem( pl2 )
					GeNum = math.max(GeNum,1)
					local GeNumS = string.format("%02d",GeNum)
					pl2.a_TabPlysTem[pl1:SteamID64() .."_#._"..pl1:Nick()] = { ["Num"] = GeNumS ,["Name"] = pl1:Nick() ,["Ply"] = pl1 ,["H"] = true ,["all_stop"] = aTab["all_stop"] or false ,["Act"] = pl2:GetNWString( "A_ActMod.TmpDir" ,"" ) }
					if not pl1.a_TabPlysGem then pl1.a_TabPlysGem = {} end
					pl1.a_TabPlysGem[pl2:SteamID64() .."_#._"..pl2:Nick()] = { ["Num"] = GeNumS ,["Name"] = pl2:Nick() ,["Ply"] = pl2 ,["J"] = true ,["all_stop"] = aTab["all_stop"] or false ,["Act"] = pl2:GetNWString( "A_ActMod.TmpDir" ,"" ) }
					local GeNum2 = A_AM.ActMod:A_ActMod_AGPTem( pl2 )
					pl2:SetNWInt( "A_ActMod.GetNJoing" ,GeNum2 )
					local Aani,TSync = "","nil"
					if istable(aTab["ani_pl1"]) then
						local aTab_t = aTab["ani_pl1"][GeNum]
						if aTab_t then
							if istable(aTab_t) then
								if aTab_t["Ani"] then Aani = aTab_t["Ani"] end
								if aTab_t["Sync"] ~= nil then TSync = aTab_t["Sync"] end
							else
								Aani = aTab_t
							end
						end
					else
						Aani = aTab["ani_pl1"]
					end
					if aTab["joining"] then
						if isbool(TSync) and TSync == true or not isbool(TSync) and aTab["Sync"] then
							A_AM.ActMod:AAStart(pl1,Aani,{Aani,P2_Sound,P2_Eff,1,string.format("%s%s",3,pl2:EntIndex())},nil,nil,true)
						else
							A_AM.ActMod:AAStart(pl1,Aani,{Aani,P2_Sound,P2_Eff,1,string.format("%s%s",2,pl2:EntIndex())},nil,nil,true)
						end
						pl1.aGetPlyjoing = { ["T"] = true ,["pl1"] = pl2 ,["TPosAng"] = TPosAng }
						if istable(pl2.aGetPlyjoing) and pl2.aGetPlyjoing["Y"] and (pl2.aGetPlyjoing["pl2"] and istable(pl2.aGetPlyjoing["pl2"]) and table.Count(pl2.aGetPlyjoing["pl2"]) > 0 and IsValid(pl2.aGetPlyjoing["pl2"][1])) and pl2.aGetPlyjoing["aTab"] then
							table.insert(pl2.aGetPlyjoing["pl2"],pl1)
							pl2.aGetPlyjoing["Y"] = true
							pl2.aGetPlyjoing["ttPos"] = nil
							pl2.aGetPlyjoing["aTab"] = aTab
							pl2.aGetPlyjoing["ajoiningFPO"] = aTab["joiningFPO"]
						else
							pl2.aGetPlyjoing = { ["Y"] = true ,["pl2"] = {pl1} ,["aTab"] = aTab }
						end
					elseif aTab["ani_pl2"] then
						local sew = "idle_all_01"
						A_AM.ActMod:AAStart(pl1,sew,{"",2,2,2,string.format("%s%s",1,pl2:EntIndex())},nil,nil,true)
						local at,aps = 0.2,50
						pl1.aGetPlyjoing = { ["ReTimer"] = CurTime() ,["T"] = true ,["pl1"] = pl2 ,["ani_pl1"] = Aani ,["TPosAng"] = TPosAng }
						pl2.aGetPlyjoing = { ["ReTimer"] = CurTime() ,["Y"] = true ,["pl2"] = pl1 ,["ani_pl2"] = aTab["ani_pl2"] ,["ttPos"] = pl1:GetPos() ,["aTab"] = aTab }
						A_AM.ActMod:A_AddRemvPly( pl2,pl2 ) A_AM.ActMod:A_AddRemvPly( pl2,pl1 )
						if aTab["Time"] then pl2.aGetPlyjoing["Time"] = aTab["Time"] else pl2.aGetPlyjoing["Time"] = at end
						if aTab["Forward"] then pl2.aGetPlyjoing["Forward"] = aTab["Forward"] else pl2.aGetPlyjoing["Forward"] = aps end
						if aTab["r180"] then pl2.aGetPlyjoing["r180"] = aTab["r180"] end
					end
				else
					pl1:PrintMessage( 3,"[ActMod]: Joining error! (Incomplete data)")
				end
			else
				pl1:PrintMessage( 3,"[ActMod]: Joining error! (Invalid data)")
			end
		end
	else
		print("[ActMod]: Joining error! ([".. tostring(pl1:Nick()) .." >> ".. tostring(pl2:Nick()) .."])  |" ,aR:T(gCGoodStartCoop[2],"en"))
	end
end

function A_AM.ActMod:A_ActMod_AJoined( pl1,pl2,a1,a2 )
	local aTab = A_AM.ActMod.GTabActCoop[pl2:GetNWString( "A_ActMod.TmpDir","" )]
	if aTab then
		local P1_Sound,P1_Eff,P1_Loop ,P2_Sound,P2_Eff,P2_Loop = "0","0","0" ,"0","0","0"
		if pl1.ActMod_tAb and istable(pl1.ActMod_tAb) then
			if pl1.ActMod_tAb[2] then P2_Sound = tostring(pl1.ActMod_tAb[2]) end
			if pl1.ActMod_tAb[3] then P2_Eff = tostring(pl1.ActMod_tAb[3]) end
			if pl1.ActMod_tAb[4] then P2_Loop = tostring(pl1.ActMod_tAb[4]) end
		end
		if pl2.ActMod_tAb and istable(pl2.ActMod_tAb) then
			if pl2.ActMod_tAb[2] then P1_Sound = tostring(pl2.ActMod_tAb[2]) end
			if pl2.ActMod_tAb[3] then P1_Eff = tostring(pl2.ActMod_tAb[3]) end
			if pl2.ActMod_tAb[4] then P1_Loop = tostring(pl2.ActMod_tAb[4]) end
		end
		if aTab["AutoRepetition"] then P1_Loop = "3" P2_Loop = "3" end
		if aTab["NoRepetition"] then P1_Loop = "2" P2_Loop = "2" end
		if aTab["OnSound"] then P1_Sound = "1" P2_Sound = "1" end
		if aTab["NoSound"] then P1_Sound = "2" P2_Sound = "2" end
		if aTab["SoundOne"] then P2_Sound = "2" end
		if aTab["rP1"] then
			local GeNum2 = A_AM.ActMod:A_ActMod_AGPTem( pl2 )
			A_AM.ActMod:AAStart(pl2,a2,{a2,P1_Sound,P1_Eff,P1_Loop,2},nil,nil,true)
			pl2:SetNWInt( "A_ActMod.GetNJoing" ,GeNum2 )
		end
		if aTab["Sync"] then
			A_AM.ActMod:AAStart(pl1,a1,{a1,P2_Sound,"1",P2_Loop,string.format("%s%s",3,pl2:EntIndex())},nil,nil,true)
		else
			if aTab["so_2"] then
				A_AM.ActMod:AAStart(pl1,a1,{a1,P2_Sound,P2_Eff,P2_Loop,string.format("%s%s",2,pl2:EntIndex())},nil,nil,true)
			else
				A_AM.ActMod:AAStart(pl1,a1,{"",P2_Sound,P2_Eff,P2_Loop,string.format("%s%s",2,pl2:EntIndex())},nil,nil,true)
			end
		end
	end
end





local IsGzs = engine.ActiveGamemode() == "zs_am4" or engine.ActiveGamemode() == "zombiesurvival"

A_AM.ActMod.ActGrpP = A_AM.ActMod.ActGrpP or {}
A_AM.ActMod.ActGrpP.TabCTDance = A_AM.ActMod.ActGrpP.TabCTDance or { ["CrTeamDance"] = {},["TabPlysNow"] = {},["TabGpsNow"] = {} }

local function aSeta(GetTan)
	if A_AM.ActMod.ActGrpP.TabCTDance and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][GetTan["Ply"]:SteamID64()] then
		GetTan["TouAre"] = "OwTDance"
		GetTan["GetTeamPly"] = GetTan["Ply"]:SteamID64()
		GetTan["SetOwneTeam"] = true
	elseif A_AM.ActMod.ActGrpP.TabCTDance and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] and GetTan["id64Team"] != "" then
		local Getyn = false
		for k, v in pairs( A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] ) do
			if k == GetTan["id64Team"] then
				for k2, p in pairs( v["GetPlayers"] ) do
					if p["id64"] == GetTan["id64Team"] then
						Getyn = true
					end
				end
			end
		end
		if Getyn == true then
			GetTan["TouAre"] = "InTDance"
			GetTan["GetTeamPly"] = GetTan["id64Team"]
			GetTan["SetOwneTeam"] = false
		else
			GetTan["TouAre"] = "Main"
			GetTan["GetTeamPly"] = ""
			GetTan["SetOwneTeam"] = false
		end
	else
		GetTan["TouAre"] = "Main"
		GetTan["GetTeamPly"] = ""
		GetTan["SetOwneTeam"] = false
	end
	GetTan["Ply"].ActMod_TC_TblPly = GetTan
end
function A_AM.ActMod.ActGrpP:StupTabPly( ply )
	timer.Simple(0.2, function() if IsValid(ply) then
		A_AM.ActMod:A_AStupTab( ply )
	end end)
end
function A_AM.ActMod.ActGrpP:RemoveTabPly( ply )
	if ply.ActMod_TC_TblPly then
		ply.ActMod_TC_TblPly = nil
	end
	if A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][ply:SteamID64()] then
		A_AM.ActMod.ActGrpP:RemoveTeamDance(ply)
	end
end
local aA_retime = CurTime() + 5.5
hook.Add( "Think", "AGrpP_Think", function()
	if (aA_retime or 0) < CurTime() then
		aA_retime = CurTime() + 0.4
		for k, v in pairs( A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] ) do
			if v["GetPlayers"] then
				for k2, v2 in pairs( v["GetPlayers"] ) do
					if not IsValid(v2["Ply"]) then
						if v2["SetOwneTeam"] then
							for k3, v3 in pairs( v["GetPlayers"] ) do
								if v3["Ply"] and IsValid(v3["Ply"]) then
									A_AM.ActMod:A_AStupTab( v3["Ply"] )
									aSeta(v3["Ply"].ActMod_TC_TblPly)
									if not v3["Ply"]:IsBot() then
										net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"LTD.SvToCl","GetLisGpNow",v3["Ply"].ActMod_TC_TblPly} ) net.Send(v3["Ply"])
									end
								end
							end
							A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][k] = nil
						else
							A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][k]["GetPlayers"][k2] = nil
							for k3, v3 in pairs( v["GetPlayers"] ) do
								if v3["Ply"] and IsValid(v3["Ply"]) then
									v3["Ply"].ActMod_TC_TblPly["GetTeamName"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][k]["GetNameTeam"]
									v3["Ply"].ActMod_TC_TblPly["GetTabPlayers"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][k]
									aSeta(v3["Ply"].ActMod_TC_TblPly)
									if not v3["Ply"]:IsBot() then
										net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"LTD.SvToCl","ReYourListPly",v3["Ply"].ActMod_TC_TblPly} ) net.Send(v3["Ply"])
									end
								end
							end
						end
					end
				end
			end
		end
		for k, Ply in pairs(player.GetAll()) do
			if IsValid(Ply) and Ply.ActMod_TC_TblPly then
				local TC_TblPly = Ply.ActMod_TC_TblPly
				if TC_TblPly["id64Team"] != "" and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TC_TblPly["id64Team"]] then
					local TnoTD,TnoTD2 = false,false
					for k2, v2 in pairs( A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TC_TblPly["id64Team"]]["GetPlayers"] ) do
						if v2["SetOwneTeam"] and v2["Ply"] and not IsValid(v2["Ply"]) then
							TnoTD = true
						end
						if v2["id64"] and v2["id64"] == Ply:SteamID64() then
							TnoTD2 = true
						end
					end
					if TnoTD == true or TnoTD2 == false then
						A_AM.ActMod:A_AStupTab( Ply )
						aSeta(Ply.ActMod_TC_TblPly)
						if not Ply:IsBot() then
							net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"LTD.SvToCl","GetLisGpNow",Ply.ActMod_TC_TblPly} ) net.Send(Ply)
						end
					end
				elseif TC_TblPly["id64Team"] != "" then
					A_AM.ActMod:A_AStupTab( Ply )
				end
			end
		end
	end
end)
function A_AM.ActMod.ActGrpP:RemoveTeamDance( Ply )
	local TabCTDa = A_AM.ActMod.ActGrpP.TabCTDance
	if IsValid(Ply) and TabCTDa["CrTeamDance"] and TabCTDa["CrTeamDance"][Ply:SteamID64()] then
		for k, v in pairs( TabCTDa["CrTeamDance"][Ply:SteamID64()]["GetPlayers"] ) do
			if v["Ply"] and IsValid(v["Ply"]) then
				A_AM.ActMod:A_AStupTab( v["Ply"] )
				aSeta(v["Ply"].ActMod_TC_TblPly)
				if not v["Ply"]:IsBot() then
					net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"LTD.SvToCl","GetLisGpNow",v["Ply"].ActMod_TC_TblPly} ) net.Send(v["Ply"])
				end
			end
		end
		TabCTDa["CrTeamDance"][Ply:SteamID64()] = nil
	end
	A_AM.ActMod:A_AStupTab( Ply )
end
function A_AM.ActMod.ActGrpP:CrTeamDance( GetTan )
	local Ply = GetTan["Ply"]
	local GetOwn = false
	for k, v in pairs( A_AM.ActMod.ActGrpP.TabCTDance ) do
		if k == "CrTeamDance" then
			for k2, v2 in pairs( v ) do
				if k2 == Ply:SteamID64() then
					GetOwn = true
				end
			end
		end
	end
	if GetOwn == false then
		local GetTbl = {
			[Ply:SteamID64()] = {
				["Ply"] = Ply
				,["NamePly"] = Ply:Nick()
				,["id64"] = Ply:SteamID64()
				,["id64Team"] = Ply:SteamID64()
				,["NameAct"] = GetTan["NameAct"]
				,["GetReady"] = true
				,["IsBot"] = false
				,["LockAct"] = false
				,["SetOwneTeam"] = true
				,["Sound"] = 1
				,["Effects"] = 1
				,["Loop"] = 0
			}
		}
		local txtNameTeam = GetTan["SetNameTeam"]
		txtNameTeam = txtNameTeam:gsub("%s+$", "")
		for k, v in pairs( A_AM.ActMod.ActGrpP.TabCTDance ) do
			if k == "CrTeamDance" then
				v[Ply:SteamID64()] = {
					["GetNameTeam"] = txtNameTeam
					,["TimeGo"] = 0
					,["LockTeam"] = GetTan["SetLockTeam"]
					,["GetPlayers"] = {}
				}
				table.Add( A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][Ply:SteamID64()]["GetPlayers"], GetTbl )
			end
		end
		GetTan["GetTeamName"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][Ply:SteamID64()]["GetNameTeam"]
		GetTan["GetTabPlayers"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][Ply:SteamID64()]
	end
end
function A_AM.ActMod.ActGrpP:JoinToTDance( Ply,TPly,txt )
	local TabCTDa = A_AM.ActMod.ActGrpP.TabCTDance
	if IsValid(Ply) and IsValid(TPly) and (not IsGzs or ( Ply:IsBot() and Ply:Team() == TEAM_HUMAN or not Ply:IsBot() )) and TabCTDa["CrTeamDance"] and TabCTDa["CrTeamDance"][TPly:SteamID64()] and (txt == "JoinToTDance" or not TabCTDa["CrTeamDance"][TPly:SteamID64()]["LockTeam"]) then
		if not TabCTDa["CrTeamDance"][Ply:SteamID64()] and not TabCTDa["CrTeamDance"][TPly:SteamID64()]["GetPlayers"][Ply:SteamID64()] and ( Ply.ActMod_TC_TblPly and Ply.ActMod_TC_TblPly["id64Team"] == "" or not Ply.ActMod_TC_TblPly ) then
			local GetOwn,a_Na,a_GR,a_bot,a_aut = false,Ply.ActMod_TC_TblPly["NameAct"],true,false,0
			if Ply.ActMod_TC_TblPly and Ply.ActMod_TC_TblPly["NameAct"] != nil then a_Na = Ply.ActMod_TC_TblPly["NameAct"] end
			if Ply.ActMod_TC_TblPly and Ply.ActMod_TC_TblPly["GetReady"] != nil then a_GR = Ply.ActMod_TC_TblPly["GetReady"] end
			if Ply:IsBot() then a_aut = 2 a_GR = true end
			local GetTbl = {
				[Ply:SteamID64()] = {
					["Ply"] = Ply
					,["NamePly"] = Ply:Nick()
					,["id64"] = Ply:SteamID64()
					,["id64Team"] = TPly:SteamID64()
					,["NameAct"] = a_Na
					,["GetReady"] = a_GR
					,["IsBot"] = a_bot
					,["LockAct"] = false
					,["SetOwneTeam"] = false
					,["Sound"] = 2
					,["Effects"] = 1
					,["Loop"] = a_aut
				}
			}
			if A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TPly:SteamID64()] then
				table.Add( A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TPly:SteamID64()]["GetPlayers"], GetTbl )
				Ply.ActMod_TC_TblPly["id64Team"] = TPly:SteamID64()
				Ply.ActMod_TC_TblPly["GetTeamName"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TPly:SteamID64()]["GetNameTeam"]
				Ply.ActMod_TC_TblPly["GetTabPlayers"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TPly:SteamID64()]
				for k, v in pairs( TabCTDa["CrTeamDance"][TPly:SteamID64()]["GetPlayers"] ) do
					if v["Ply"] and IsValid(v["Ply"]) then
						v["Ply"].ActMod_TC_TblPly["GetTeamName"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TPly:SteamID64()]["GetNameTeam"]
						v["Ply"].ActMod_TC_TblPly["GetTabPlayers"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TPly:SteamID64()]
						aSeta(v["Ply"].ActMod_TC_TblPly)
						if not v["Ply"]:IsBot() then
							net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"LTD.SvToCl","ReYourListPly",v["Ply"].ActMod_TC_TblPly} ) net.Send(v["Ply"])
						end
					end
				end
			end
		end
	end
end
function A_AM.ActMod.ActGrpP:ChActTeamDance( GetTan,Optan )
	local Ply = GetTan["Ply"]
	local TPly = GetTan["TPly"]
	local TID = GetTan["TPly_InTID"]
	local TabCTDa = A_AM.ActMod.ActGrpP.TabCTDance
	if IsValid(Ply) and IsValid(TPly) and TabCTDa["CrTeamDance"] and TabCTDa["CrTeamDance"][TID] then
		local GetOwn,TAPly = false,{}
		for k, v in pairs( TabCTDa["CrTeamDance"] ) do
			if k == TID then
				if Optan == "ChOptan_Time" then
					v["TimeGo"] = GetTan["TPly_ChAct"]
					GetOwn = true
				elseif Optan == "ChOptan_Lock" then
					v["LockTeam"] = GetTan["TPly_ChAct"]
					GetOwn = true
				elseif Optan == "ChOptan_PosOne" then
					v["Pls_PosOne"] = GetTan["TPly_ChAct"]
					GetOwn = true
				else
					for k1, v1 in pairs( v["GetPlayers"] ) do if v1["id64"] == TID then TAPly = v1 end end
					for k2, v2 in pairs( v["GetPlayers"] ) do
						if Optan == "Duplicate_Sound" or Optan == "Duplicate_Effects" or Optan == "Duplicate_Loop" or Optan == "Duplicate_NameAct" then
							if v2["id64"] ~= Ply:SteamID64() and TAPly and not table.IsEmpty(TAPly) then
								if Optan == "Duplicate_Sound" then
									v2["Sound"] = TAPly["Sound"]
									GetOwn = true
								elseif Optan == "Duplicate_Effects" then
									v2["Effects"] = TAPly["Effects"]
									GetOwn = true
								elseif Optan == "Duplicate_Loop" then
									v2["Loop"] = TAPly["Loop"]
									GetOwn = true
								elseif Optan == "Duplicate_NameAct" then
									v2["NameAct"] = TAPly["NameAct"]
									GetOwn = true
								end
							end
						else
							if v2["id64"] == TPly:SteamID64() then
								if Optan == "ChOptan_TPly" then
									v2[GetTan["TPly_ChAct"][1]] = GetTan["TPly_ChAct"][2]
									GetOwn = true
								else
									v2["Ply"].ActMod_TC_TblPly["NameAct"] = GetTan["TPly_ChAct"]
									v2["NameAct"] = GetTan["TPly_ChAct"]
									GetOwn = true
								end
							end
						end
					end
				end
			end
		end
		if GetOwn == true then
			for k, v in pairs( TabCTDa["CrTeamDance"][TID]["GetPlayers"] ) do
				if v["Ply"] and IsValid(v["Ply"]) then
					v["Ply"].ActMod_TC_TblPly["GetTeamName"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TID]["GetNameTeam"]
					v["Ply"].ActMod_TC_TblPly["GetTabPlayers"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TID]
					aSeta(v["Ply"].ActMod_TC_TblPly)
					if not v["Ply"]:IsBot() then
						net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"LTD.SvToCl","ReYourListPly",v["Ply"].ActMod_TC_TblPly} ) net.Send(v["Ply"])
					end
				end
			end
		end
	end
end
function A_AM.ActMod.ActGrpP:unJoinToTDance( GetTan )
	local Ply = GetTan["Ply"]
	local TPly = GetTan["TPly"]
	local TID = GetTan["TPly_InTID"]
	local TabCTDa =A_AM.ActMod.ActGrpP.TabCTDance
	if TabCTDa["CrTeamDance"][TID] then
		for k, v in pairs( TabCTDa["CrTeamDance"] ) do
			if k == TID then
				for k2, p in pairs( v["GetPlayers"] ) do
					if p["id64"] == TPly:SteamID64() then
						table.Empty(p)
					end
				end
			end
		end
		A_AM.ActMod:A_AStupTab( TPly )
		GetTan = TPly.ActMod_TC_TblPly
		aSeta(TPly.ActMod_TC_TblPly)
		if not TPly:IsBot() then
			net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"LTD.SvToCl","GetLisGpNow",TPly.ActMod_TC_TblPly} ) net.Send(TPly)
		end
		for k, v in pairs( TabCTDa["CrTeamDance"][TID]["GetPlayers"] ) do
			if v["Ply"] and IsValid(v["Ply"]) then
				v["Ply"].ActMod_TC_TblPly["GetTeamName"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TID]["GetNameTeam"]
				v["Ply"].ActMod_TC_TblPly["GetTabPlayers"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][TID]
				if not v["Ply"]:IsBot() then
					net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"LTD.SvToCl","ReYourListPly",v["Ply"].ActMod_TC_TblPly} ) net.Send(v["Ply"])
				end
			end
		end
	end
end
function A_AM.ActMod.ActGrpP:ReLisPlyNow()
	local GetTbl = {}
	A_AM.ActMod.ActGrpP.TabCTDance["TabPlysNow"] = {}
	for _, Ply in pairs(player.GetAll()) do
		if IsValid(Ply) and Ply.ActMod_TC_TblPly and not A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][Ply:SteamID64()] and (IsGzs and ( Ply:IsBot() and Ply:Team() == TEAM_HUMAN and not Ply.OnIsBot or not Ply:IsBot() ) or not IsGzs ) then
			local TC_TblPly = Ply.ActMod_TC_TblPly
			local isbota,aRdy = false,false
			if TC_TblPly and TC_TblPly["AllowOk"] then aRdy = TC_TblPly["AllowOk"] end
			if Ply:IsBot() then isbota = true end
			if TC_TblPly["id64Team"] == "" and TC_TblPly["TouAre"] != "OwTDance" and TC_TblPly["TouAre"] != "InTDance" then
				local GTbl = {
					[Ply:SteamID64()] = {
						["Ply"] = Ply
						,["NamePly"] = Ply:Nick()
						,["id64"] = Ply:SteamID64()
						,["AllowOk"] = aRdy
						,["IsBot"] = isbota
					}
				}
				table.Add(GetTbl, GTbl)
			end
		end
	end
	A_AM.ActMod.ActGrpP.TabCTDance["TabPlysNow"] = GetTbl
end
function A_AM.ActMod.ActGrpP:GetLisPlyNow()
	A_AM.ActMod.ActGrpP:ReLisPlyNow()
	if A_AM.ActMod.ActGrpP.TabCTDance["TabPlysNow"] then
		return A_AM.ActMod.ActGrpP.TabCTDance["TabPlysNow"]
	end
	return {}
end
function A_AM.ActMod.ActGrpP:ReLisGpNow()
	local GetTbl = {}
	A_AM.ActMod.ActGrpP.TabCTDance["TabGpsNow"] = {}
	if A_AM.ActMod.ActGrpP.TabCTDance and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] then
		for k, v in pairs(A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"]) do
			if v["GetPlayers"][1]["Ply"] then
				local Ply = v["GetPlayers"][1]["Ply"]
				local GTbl = {
					[Ply:SteamID64()] = {
						["Ply"] = Ply
						,["NamePly"] = Ply:Nick()
						,["id64"] = Ply:SteamID64()
						,["GetNameTeam"] = v["GetNameTeam"]
						,["LockTeam"] = v["LockTeam"]
					}
				}
				table.Add(GetTbl, GTbl)
			end
		end
	end
	A_AM.ActMod.ActGrpP.TabCTDance["TabGpsNow"] = GetTbl
end
function A_AM.ActMod.ActGrpP:GetLisGpNow()
	A_AM.ActMod.ActGrpP:ReLisGpNow()
	if A_AM.ActMod.ActGrpP.TabCTDance["TabGpsNow"] then
		return A_AM.ActMod.ActGrpP.TabCTDance["TabGpsNow"]
	end
	return {}
end
function A_AM.ActMod.ActGrpP:StartTeamDance( GetTan,stoop )
	local Ply = istable(GetTan) and GetTan["Ply"]
	if not IsValid(Ply) or not Ply:IsPlayer() then return end
	local GID64 = Ply:SteamID64()
	if A_AM.ActMod.ActGrpP.TabCTDance.CrTeamDance and A_AM.ActMod.ActGrpP.TabCTDance.CrTeamDance[GID64] then
		local TCID64D = A_AM.ActMod.ActGrpP.TabCTDance.CrTeamDance[GID64]
		local IsPosOne = GetTan.GetTabPlayers and GetTan.GetTabPlayers.Pls_PosOne or false
		local GetTabPly = {}
		for k, v in pairs( TCID64D.GetPlayers ) do
			if isstring(k) then
				for _, pl in pairs(player.GetAll()) do
					if IsValid(pl) and pl:SteamID64() == k then
						table.insert(GetTabPly, pl)
					end
				end
			end
		end
		if IsPosOne then
			A_AM.ActMod:A_EndJoing( Ply )
			A_AM.ActMod:A_ActMod_OffTGem( Ply )
			A_AM.ActMod:A_ActMod_OffTGem( Ply,true )
		end
		local o4 = 0
		if tonumber(TCID64D.TimeGo) > 0 then o4 = tonumber(TCID64D.TimeGo) end
		local GTabPly,tnn = {},0
		for k, v in pairs( TCID64D.GetPlayers ) do
			if v and IsValid(v.Ply) then
				if stoop then
					A_AM.ActMod:A_ActMod_OffActing( v.Ply )
				else
					local o1,o2,o3 = 0,0,0
					if tonumber(v.Sound) > 0 then o1 = v.Sound end
					if tonumber(v.Effects) > 0 then o2 = v.Effects end
					if tonumber(v.Loop) > 0 then o3 = v.Loop end
					tnn = tnn+1
					GTabPly[tnn] = {v.Ply,v.NameAct,{v.NameAct,o1,o2,o3,1},true,o4}
					if IsPosOne and v.Ply ~= Ply then
						local Pl2 = v.Ply
						A_AM.ActMod:A_EndJoing( Pl2 )
						A_AM.ActMod:A_ActMod_OffTGem( Pl2 )
						A_AM.ActMod:A_ActMod_OffTGem( Pl2,true )
					end
				end
			end
		end
		if IsPosOne then
			local aCurTime = CurTime() + o4 + 0.3
			for k, v in pairs( GTabPly ) do
				if IsValid(v[1]) then
					A_AM.ActMod:A_AddRemvPly( Ply,v[1],o4+0.3 )
					if v[1] ~= Ply then v[1].aGetPlyjoing = { ReTimer = aCurTime ,SdPos = true,T = true ,pl1 = Ply } end
				end
			end
		end
		local aEntIndex = "aA_TStartOne_".. GID64
		if timer.Exists( aEntIndex ) then timer.Remove( aEntIndex ) end
		timer.Create( aEntIndex,0.3,1,function()
			if not IsValid(Ply) then return end
			local aaTabPly = {}
			for k, v in pairs( GTabPly ) do if IsValid(v[1]) and Ply ~= v[1] then table.insert(aaTabPly,v[1]) end end
			if IsPosOne then Ply.aGetPlyjoing = { ReTimer = CurTime() + o4 ,Y = true ,pl2 = aaTabPly ,aTab = { rPos = true,rAng = true ,Forward = 0 ,MaxDistance = 400 } } end
			for k, v in pairs( GTabPly ) do if IsValid(v[1]) then A_AM.ActMod:AAStart(v[1],v[2],v[3],v[4],v[5],true) end end
		end)
	end
end


function A_AM.ActMod:LTDClToSv( ply,GetStrg,GetTan )
	if IsValid(ply) and istable(GetTan) and IsValid(GetTan["Ply"]) and ply:IsPlayer() and GetTan["Ply"]:IsPlayer() and ply == GetTan["Ply"] then
		GetTan["Ply"].ActMod_TC_TblPly = GetTan
		if GetStrg == "LoadSutep" then
			aSeta(GetTan)
		elseif GetStrg == "CrTeamDance" then
			A_AM.ActMod.ActGrpP:CrTeamDance(GetTan)
			aSeta(GetTan)
		elseif GetStrg == "JoinToTDance" or GetStrg == "JoinToTeam" then
			A_AM.ActMod.ActGrpP:JoinToTDance(GetTan["TPly"],GetTan["TPly_InTID"],GetStrg)
			aSeta(GetTan)
			GetTan["TPly"] = ""
			GetTan["TPly_InTID"] = ""
		elseif GetStrg == "GetLisPlyNow" then
			GetTan["GetTabPlysNow"] = {}
			GetTan["GetTabPlysNow"] = A_AM.ActMod.ActGrpP:GetLisPlyNow()
		elseif GetStrg == "GetLisGpNow" then
			GetTan["GetTabGpsNow"] = {}
			local pTD,TnoTD,TnoTD2 = ply:SteamID64(),false,false
			if A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][pTD] and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][pTD]["GetPlayers"] then
				TnoTD = true
				for k2, v2 in pairs( A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][pTD]["GetPlayers"] ) do
					if v2["SetOwneTeam"] and v2["Ply"] and IsValid(v2["Ply"]) and v2["Ply"] == ply then
						TnoTD = true
					end
					if v2["id64"] and v2["id64"] == pTD then
						TnoTD2 = true
					end
				end
			end
			if TnoTD == false and TnoTD2 == false then
				GetTan["GetTabGpsNow"] = A_AM.ActMod.ActGrpP:GetLisGpNow()
			end
		elseif GetStrg == "Kick_TPly" then
			if A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][GetTan["TPly_InTID"]] then
				A_AM.ActMod.ActGrpP:unJoinToTDance(GetTan)
				GetTan = GetTan["Ply"].ActMod_TC_TblPly
			end
			GetTan["TPly"] = ""
			GetTan["TPly_InTID"] = ""
			aSeta(GetTan)
		elseif GetStrg == "StratAct" then
			A_AM.ActMod.ActGrpP:StartTeamDance(GetTan)
		elseif GetStrg == "StopAct" then
			A_AM.ActMod.ActGrpP:StartTeamDance(GetTan,true)
		elseif GetStrg == "RemoveTeamDance" then
			A_AM.ActMod.ActGrpP:RemoveTeamDance(GetTan["Ply"])
			aSeta(GetTan)
		elseif GetStrg == "ReYourListPly" then
			aSeta(GetTan)
			if A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][GetTan["GetTeamPly"]] then
				local Ply = GetTan["Ply"]
				local TnoTD,TnoTD2 = false,false
				local pTD = isstring(GetTan["id64Team"]) and GetTan["id64Team"] ~= "" and GetTan["id64Team"] or isstring(GetTan["GetTeamPly"]) and GetTan["GetTeamPly"] ~= "" and GetTan["GetTeamPly"] or ply:SteamID64()
				if pTD != "" and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][pTD] and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][pTD]["GetPlayers"] then
					for k2, v2 in pairs( A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][pTD]["GetPlayers"] ) do
						if v2["SetOwneTeam"] and v2["Ply"] and not IsValid(v2["Ply"]) then
							TnoTD = true
						end
						if v2["id64"] and v2["id64"] == Ply:SteamID64() then
							TnoTD2 = true
						end
					end
				end
				if TnoTD == false and TnoTD2 == true then
					if GetTan["id64Team"] ~= "" and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][GetTan["id64Team"]] then
						GetTan["GetTabPlayers"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][GetTan["id64Team"]]
					else
						GetTan["GetTabPlayers"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][GetTan["GetTeamPly"]]
					end
				elseif GetTan["id64Team"] ~= "" then
					GetTan["GetTabPlayers"] = {}
				end
			else
				GetTan["GetTabPlayers"] = {}
			end
			
		elseif GetStrg == "ReInListPly" then
			aSeta(GetTan)
			local pTD = isstring(GetTan["id64Team"]) and GetTan["id64Team"] ~= "" and GetTan["id64Team"] or isstring(GetTan["GetTeamPly"]) and GetTan["GetTeamPly"] ~= "" and GetTan["GetTeamPly"] or ply:SteamID64()
			if A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][pTD] then
				GetTan["GetTabPlayers"] = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][pTD]
			else
				GetTan["GetTabPlayers"] = {}
			end
			
		elseif GetStrg == "NameAct_TPly" or GetStrg == "ChOptan_TPly" or GetStrg == "ChOptan_Time" or GetStrg == "ChOptan_Lock" or GetStrg == "ChOptan_PosOne" or GetStrg == "Duplicate_Sound" or GetStrg == "Duplicate_Effects" or GetStrg == "Duplicate_Loop" or GetStrg == "Duplicate_NameAct" then
			aSeta(GetTan)
			if A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"] and A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][GetTan["TPly_InTID"]] then
				local CTPly,okallw = A_AM.ActMod.ActGrpP.TabCTDance["CrTeamDance"][GetTan["TPly_InTID"]]["GetPlayers"],false
				if istable(CTPly) and CTPly[1] and IsValid(CTPly[1]["Ply"]) and CTPly[1]["Ply"] == ply then
					okallw = true
				elseif GetStrg == "NameAct_TPly" then
					if istable(CTPly) then
						for k, v in pairs(CTPly) do
							if v and IsValid(v["Ply"]) and v["id64"] and v["id64"] == ply:SteamID64() then
								okallw = true
								break
							end
						end
					end
				end
				if okallw then
					A_AM.ActMod.ActGrpP:ChActTeamDance(GetTan,GetStrg)
				end
			end
			GetTan["TPly"] = ""
			GetTan["TPly_ChAct"] = ""
			GetTan["TPly_InTID"] = ""
		end
		GetTan["Ply"].ActMod_TC_TblPly = GetTan
			
		net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"LTD.SvToCl",GetStrg,GetTan} ) net.Send(GetTan["Ply"])
		
		GetTan["GetTabPlysNow"] = {}
		GetTan["GetTabGpsNow"] = {}
	end
end


function A_AM.ActMod:IsValidTPosition(ent)
    local pos = ent:GetPos()
    local ang = ent:GetRenderAngles()
    local seqinfo = ent:GetSequenceInfo(ent:GetSequence())
    if seqinfo.activityname:len() < 1 then seqinfo.activityname = "ACT_INVALID" end

    local mn = seqinfo.bbmin
    local mx = seqinfo.bbmax

    local corners = {
        Vector(mn.x, mn.y, mn.z),
        Vector(mn.x, mn.y, mx.z),
        Vector(mn.x, mx.y, mn.z),
        Vector(mn.x, mx.y, mx.z),
        Vector(mx.x, mn.y, mn.z),
        Vector(mx.x, mn.y, mx.z),
        Vector(mx.x, mx.y, mn.z),
        Vector(mx.x, mx.y, mx.z),
    }

    local wMins = Vector( math.huge,  math.huge,  math.huge)
    local wMaxs = Vector(-math.huge, -math.huge, -math.huge)

    for _, corner in ipairs(corners) do
        local w = LocalToWorld(corner, ang, pos, ang)
        if w.x < wMins.x then wMins.x = w.x end
        if w.y < wMins.y then wMins.y = w.y end
        if w.z < wMins.z then wMins.z = w.z end
        if w.x > wMaxs.x then wMaxs.x = w.x end
        if w.y > wMaxs.y then wMaxs.y = w.y end
        if w.z > wMaxs.z then wMaxs.z = w.z end
    end

    local aaup = Vector(0,0,ent:OBBMaxs().z/3)
    local tr = util.TraceHull({
        start  = pos+aaup,
        endpos = pos+aaup,
        mins   = (wMins - pos)/1.1,
        maxs   = (wMaxs - pos)/1.1,
        filter = ent,
        mask   = MASK_SOLID_BRUSHONLY
    })

    return not tr.Hit
end


A_AM.ActMod.bessys_2_Done = true
