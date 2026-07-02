AddCSLuaFile()


//			ActMod For Gmod
//		Creator: AhmedMake400
//
//	Is it permissible to amend or republish it ?  NO
//
//	Please do not follow anyone who tries to hack my work.
//	It is never allowed for anyone to modify or Re-publish.
//
//	If you have something or want to do something, just tell me, I listen to everyone.
//
//	Don't do a bad job
//	انا احب من يحترمني


if SERVER then
	resource.AddWorkshop("2538387266") -- ActMod
	resource.AddWorkshop("2615656036") -- Base Anim-AM4
	MsgC(Color( 100, 220, 255 ),"\n\nServer: " ,Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"] Loading ...\n" )
else
	MsgC(Color( 240, 240, 100 ),"\nClient: " ,Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"] Loading ...\n" )
end

A_AM = A_AM or {}
A_AM.ActMod = A_AM.ActMod or {}
A_AM.ActMod.Mounted = A_AM.ActMod.Mounted or {}
A_AM.ActMod.Mounted[ "Version ActMod" ] = "9.8"
A_AM.ActMod.GetMSS_Tab = A_AM.ActMod.GetMSS_Tab or {}
A_AM.ActMod.GTabActO = A_AM.ActMod.GTabActO or {}
A_AM.ActMod.GTabActWlk = A_AM.ActMod.GTabActWlk or {}
A_AM.ActMod.GTabActCoop = A_AM.ActMod.GTabActCoop or {}
A_AM.ActMod.GGMap = game.GetMap()
if CLIENT then
	A_AM.ActMod.clo_IMeun_Num = A_AM.ActMod.clo_IMeun_Num or 0
	A_AM.ActMod.clo_IMeun_inx = A_AM.ActMod.clo_IMeun_inx or 0
	A_AM.ActMod.clo_Select_Bace = A_AM.ActMod.clo_Select_Bace or 0
	A_AM.ActMod.GetMSS_Tab_cl = A_AM.ActMod.GetMSS_Tab_cl or {}
	A_AM.ActMod.GRTSYS = A_AM.ActMod.GRTSYS or {POS = Vector(0, 0, 0) ,ANG = Angle(0, 0, 0) ,TMDL ={}}
	A_AM.ActMod.AdScrpt = A_AM.ActMod.AdScrpt or {}
	A_AM.ActMod.AdScrptPDraw = A_AM.ActMod.AdScrptPDraw or {}
	A_AM.ActMod.AdScrptPDrawO = A_AM.ActMod.AdScrptPDrawO or {}
end
A_AM.ActMod.OneSutep = false
A_AM.ActMod.SetChfg = false
A_AM.ActMod.Sutep_Done1 = false
A_AM.ActMod.Sutep_Done2 = false
A_AM.ActMod.Sutep_Done3 = false
A_AM.ActMod.Sutep_DoneR = 0
A_AM.ActMod.Sutep_Error = 0
A_AM.ActMod.HookThinkSv = false
A_AM.ActMod.HookThinkCl = 0
A_AM.ActMod.GFilszFld = nil
A_AM.ActMod.msaf = 70
A_AM.ActMod.Blacklist = A_AM.ActMod.Blacklist or {}
A_AM.ActMod.GFilszRvie = A_AM.ActMod.GFilszRvie or {}
A_AM.ActMod.GFilszRvie2 = A_AM.ActMod.GFilszRvie2 or {}
A_AM.ActMod.aTabDa_RunCyc = A_AM.ActMod.aTabDa_RunCyc or {}
A_AM.ActMod.AdScrptActSV = A_AM.ActMod.AdScrptActSV or {}
A_AM.ActMod.TDCustom = A_AM.ActMod.TDCustom or {}
A_AM.ActMod.Actbtk_sv = A_AM.ActMod.Actbtk_sv or {}
A_AM.ActMod.GestureSystem = A_AM.ActMod.GestureSystem or {}
A_AM.ActMod.Aadons = A_AM.ActMod.Aadons or {"ActMod Commission Hub","More Emotes Fortnite"}
A_AM.ActMod.Aedons = A_AM.ActMod.Aedons or {"zeigxy"}
A_AM.ActMod.GAllowIDAdd = {["2615656036"] = true,["2916561591"] = true,["2143558752"] = true,["2651961599"] = true}

A_AM.ActMod.GFilsz = {
	["LuaBas"] = ""
	,["LuaAct"] = ""
	,["LuaEnt"] = ""
	,["LuaAvs"] = ""
	,["LuaFon"] = ""
	,["LuaHok"] = ""
	,["LuaLan"] = ""
	,["LuaSha"] = ""
	,["LuaVgi"] = ""
	,["LuaOri"] = "True"
}

A_AM.ActMod.Settings = {
    ["IconsActs"] = "actmod/iacto"
}

A_AM.ActMod.TNSav = {["savemots"] = "sav_emots",["savefvit"] = "sav_favorite",["saveenew"] = "sav_tnew"}

A_AM.ActMod.Tabs_for_SkipHooks = {
	["PlayerCanPickupWeapon"] = {
		["ActMod"] = {3,6,false}
	}
	,["HUDWeaponPickedUp"] = {
		["ActMod_NSw"] = {3,10,false}
	}
	,["CalcView"] = {
		["ActMod_CalcView"] = {3,15,false}
		,["VManip_Cam"] = {1,10,false}
		,["entities/hl_camera"] = {1,18,false}
	}
	,["UpdateAnimation"] = {
		["ActMod_SlowDownAnim"] = {3,24,false}
	}
	,["CalcMainActivity"] = {
		["ActMod_Animations"] = {3,22,false}
	}
}


local function ACrConV_cs(a1,...) if not ConVarExists(a1) then CreateConVar(a1,...) end end
ACrConV_cs("actmod_sv_enabled", 1 , { FCVAR_REPLICATED, FCVAR_NOTIFY } )
ACrConV_cs("actmod_sv_a_move", 0 , { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
ACrConV_cs("actmod_sv_a_crouching", 0 , { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
ACrConV_cs("actmod_sv_a_ground", 1 , { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
ACrConV_cs("actmod_sv_a_vehicles", 1 , { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
ACrConV_cs("actmod_sv_a_weapact", 1 , { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
ACrConV_cs("actmod_sv_enabled_addef", 1 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE,FCVAR_NOTIFY} )
ACrConV_cs("actmod_sv_enabled_addso", 1 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE,FCVAR_NOTIFY})
ACrConV_cs("actmod_sv_avs", 1 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} )
ACrConV_cs("actmod_sv_soundlevel", 100 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} ,"min: 5  /  max: 100" ,5,100 )
ACrConV_cs("actmod_sv_syrhook", 3 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE,FCVAR_NOTIFY} ,"[Reload]: (0): none  | (1): hooks.Call  |  (2): hooks.Add  |  (3): hooks.(Call/Add)" ,0,3 )
ACrConV_cs("actmod_sv_typmovecl", 1 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} )
ACrConV_cs("actmod_sv_alowangcl", 1 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} )
ACrConV_cs("actmod_sv_alowdsyn", 1 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} )
ACrConV_cs("actmod_sv_showhisyn", 1 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} )
ACrConV_cs("actmod_sv_ondcklpos", 0 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} )
ACrConV_cs("actmod_sv_alowacop", 0 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} )
ACrConV_cs("actmod_sv_rangecam", 100 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} ,"min: 50  /  max: 2000" ,10,2000 )
ACrConV_cs("actmod_sv_syflex", 2 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} ,"min: 0  /  max: 3" ,0,3 )
ACrConV_cs("actmod_sv_shofcl", 0 ,{FCVAR_REPLICATED,FCVAR_ARCHIVE} ,"min: 0  /  max: 1" ,0,1 )


if A_AM.ActMod.GSetuphook == true then A_AM.ActMod:StartSutEp(0) end

function A_AM.ActMod:GetTestRive(aDdon, folder)
	local SAddonSearCache = {}
	local files, folders = file.Find( folder .. "*", aDdon )
	if ( !files ) then MsgN( "Warning! Not opening >" .. folder .. "< because we cannot search in it!"  ) return false end
	for k, v in pairs( files ) do
		if ( string.EndsWith( v, ".mdl" ) ) then
			local found = folder..v
			found = string.lower(found)
			A_AM.ActMod.GFilszRvie[found] = aDdon
			SAddonSearCache[found] = aDdon
			continue
		else continue
		end
	end
	for k, v in pairs( folders ) do 
		A_AM.ActMod:GetTestRive( aDdon, folder .. v .. "/" )
	end
	return SAddonSearCache
end
function A_AM.ActMod:BeginSearching()
	for _, addOn in SortedPairsByMemberValue( engine.GetAddons(), "title" ) do
		if addOn.mounted and addOn.downloaded then
			A_AM.ActMod:GetTestRive(addOn.title, "models/")
		end
	end
end

function A_AM.ActMod:AGetSearch(target)
	local result = A_AM.ActMod.GFilszRvie[target]
	for _, addoN in pairs( engine.GetAddons() ) do
		if result == addoN.title then
			print("[GMA]: ".. addoN.file .."  |/| Addon Name: " .. addoN.title .."  |/|  OK")
		end
	end
end

function A_AM.ActMod:CalcTabS(tbl,visi)
	visi = visi or {}
	if visi[tbl] then return 0 end
	visi[tbl] = true
	local ts = 0
	for k,v in pairs(tbl) do
		local tk = type(k)
		if tk == "string" then
			ts = ts + #k
		else
			ts = ts + #tostring(k)
		end
		local t = type(v)
		if t == "string" then
			ts = ts + #v
		elseif t == "number" then
			ts = ts + #tostring(v)
		elseif t == "function" then
			local du = string.dump(v)
			ts = ts + #du
		elseif t == "table" then
			ts = ts + A_AM.ActMod:CalcTabS(v,visi)
		elseif t == "boolean" then
			ts = ts + (v and 4 or 5)
		elseif t == "nil" then
			ts = ts + 3
		end
	end
	return ts
end

local function recurseListContents(path, addon, direct, pattern)
	local files, dirs = file.Find(path.."*", addon)
	local matchedFiles = {}
	if files then
		for _, v in ipairs(files) do
			local fullPath = path..v
			if not pattern or string.match(fullPath, pattern) then
				table.insert(matchedFiles, fullPath)
			end
		end
	end
	if direct then return matchedFiles end
	if dirs then
		for _, dir in ipairs(dirs) do
			local subFiles = recurseListContents(path..dir.."/", addon, false, pattern)
			for _, file in ipairs(subFiles) do
				table.insert(matchedFiles, file)
			end
		end
	end
	return matchedFiles
end
function FindContentInAddon(the_special_content, in_a_specific_addon)
	local addons = engine.GetAddons()
	if not the_special_content then
		for _, addon in ipairs(addons) do
			local title = addon.title
			recurseListContents("", title, false)
		end
		return
	end
	local found = {}
	for _, addon in ipairs(addons) do
		local title = in_a_specific_addon or addon.title
		local path = addon.file
		local iD = addon.wsid
		local pattern = the_special_content:gsub("%*", ".*")
		local files = recurseListContents("", title, false, pattern)
		if #files > 0 then
			table.insert(found, {title, files, path, iD})
		end
		if in_a_specific_addon then break end
	end
	if #found > 0 then
		for k, v in ipairs(found) do
			local matches = #v[2]
			for kf, filePath in ipairs(v[2]) do
				A_AM.ActMod.GFilszRvie2[the_special_content.."|"..k] = { ["k_file"] = kf ,["matches"] = matches ,["Name"] = v[1] ,["path"] = v[3] ,["ID"] = v[4]}
			end
		end
	end
end

function A_AM.ActMod:RSearGMd()
	A_AM.ActMod.GFSMd = {}
	A_AM.ActMod:BeginSearching()
	local annn_m,annn_f,annn_t = 0,0,{}
	FindContentInAddon("models/m_anm.mdl")
	FindContentInAddon("models/f_anm.mdl")
	local result_m = A_AM.ActMod.GFilszRvie["models/m_anm.mdl"]
	local result_f = A_AM.ActMod.GFilszRvie["models/f_anm.mdl"]
	for k, addoN in pairs( engine.GetAddons() ) do
		if result_m == addoN.title and result_f == addoN.title then
			annn_m = annn_m + 1 annn_f = annn_f + 1 annn_t[addoN.wsid] = true
			A_AM.ActMod.GFSMd["fm|"..annn_m.."|"..k] = { ["fm"] = "fm" ,["file"] = addoN.file ,["Name"] = addoN.title ,["ID"] = addoN.wsid }
		else
			if result_m == addoN.title then
				annn_m = annn_m + 1
				annn_t[addoN.wsid] = true
				A_AM.ActMod.GFSMd["m|"..annn_m.."|"..k] = { ["fm"] = "m" ,["file"] = addoN.file ,["Name"] = addoN.title ,["ID"] = addoN.wsid }
			end
			if result_f == addoN.title then
				annn_f = annn_f + 1
				annn_t[addoN.wsid] = true
				A_AM.ActMod.GFSMd["f|"..annn_f.."|"..k] = { ["fm"] = "f" ,["file"] = addoN.file ,["Name"] = addoN.title ,["ID"] = addoN.wsid }
			end
		end
	end
	for k, addoN in pairs( A_AM.ActMod.GFilszRvie2 ) do
		if not annn_t[addoN.ID] then
			if string.find(k, "models/m_anm.mdl|") then
				annn_m = annn_m + 1
				A_AM.ActMod.GFSMd["m|"..annn_m.."|"..k] = { ["fm"] = "m" ,["file"] = addoN.path ,["Name"] = addoN.Name ,["ID"] = addoN.ID }
			end
			if string.find(k, "models/f_anm.mdl|") then
				annn_f = annn_f + 1
				A_AM.ActMod.GFSMd["f|"..annn_f.."|"..k] = { ["fm"] = "f" ,["file"] = addoN.path ,["Name"] = addoN.Name ,["ID"] = addoN.ID }
			end
		end
	end
	for k, aN_1 in pairs( A_AM.ActMod.GFSMd ) do
		if string.find(k, "m|") then
			for k2, aN_2 in pairs( A_AM.ActMod.GFSMd ) do
				if string.find(k2, "f|") and aN_1.ID == aN_2.ID then
					A_AM.ActMod.GFSMd["f"..k] = aN_1
					A_AM.ActMod.GFSMd["f"..k]["fm"] = "fm"
					A_AM.ActMod.GFSMd[k] = nil
					A_AM.ActMod.GFSMd[k2] = nil
				end
			end
		end
	end
end

local gNTabl = {["GetMDLSeq_AM4"] = 1,["GetMDLSeq_Dyn"] = 2,["GetMDLSeq_xdR"] = 3,["GetMDLSeq_wOS"] = 4,["GetPackAnimV"] = 5,["GetPackSounds"] = 6,["GetORG"] = 7}
function A_AM.ActMod:GetNwInt(pl,txt)
	if CLIENT and isstring(pl) and pl == "cl" and istable(A_AM.ActMod.GetMSS_Tab_cl) then
		return A_AM.ActMod.GetMSS_Tab_cl[txt]
	elseif IsValid(pl) then
		local atXt = pl:GetNW2String("A_ActMod.GetMSS_Tab","")
		if atXt ~= "" then
			local TtXt = string.Explode("|", atXt, true)
			if TtXt and istable(TtXt) and TtXt[6] then
				if gNTabl[txt] then
					return TtXt[ gNTabl[txt] ]
				end
			end
		end
	end
	return 0
end

function A_AM.ActMod:PlayerDisconnect_(ply)
	if A_AM.ActMod.LuaBas then A_AM.ActMod:A_ActMod_OffActing( ply ) end
	ply.OffActMod = true
	ply.ActMod_GestureData = nil
end
function A_AM.ActMod:PlayerInitialSpawn_(ply)
	ply:SetNWBool( "A_AM.ActMod.IsAct", false )
	ply:SetNWString("A_ActMod.OneStart1","_")
	ply:SetNWString("A_ActMod.OneStart2","_")
	ply:SetNWString("A_ActMod.OneStart3","_")
	ply:SetNWString("A_ActMod.OneStart6","_")
end

hook.Add("PlayerInitialSpawn","A_AM_Initial",function(ply) A_AM.ActMod:PlayerInitialSpawn_(ply) end)
hook.Add( "PlayerDisconnect", "AN_Disconnect", function(ply) A_AM.ActMod:PlayerDisconnect_(ply) end)
hook.Add( "PlayerDisconnected", "AN_Disconnected", function(ply) A_AM.ActMod:PlayerDisconnect_(ply) end)

local atb = {"RCgFg","bTActO","bTSond","aTActO","aTSond","aATSct"}
function A_AM.ActMod:AOri()
	local FGa = true
	if istable(A_AM.ActMod.GFilsz) and not table.IsEmpty(A_AM.ActMod.GFilsz) then
		if CLIENT and game.IsDedicated() then
			for k, v in pairs(A_AM.ActMod.GFilsz) do
				if k ~= "LuaOri" and table.HasValue( atb, k ) and v ~= "True" then FGa = false break end
			end
		else
			for k, v in pairs(A_AM.ActMod.GFilsz) do
				if k ~= "LuaOri" and v ~= "True" then FGa = false break end
			end
		end
	else
		return false
	end
	return FGa
end

function A_AM.ActMod:aRSeq()

	local GMdl = "models/player/kleiner.mdl"
	if file.Exists("models/player/d1anim_m.mdl", "GAME") then GMdl = "models/player/d1anim_m.mdl" end
	local ActEntDemo
	if SERVER then
		ActEntDemo = ents.Create("prop_dynamic")
	else
		ActEntDemo = ClientsideModel(GMdl, RENDERGROUP_OTHER)
	end
	if IsValid(ActEntDemo) then
		ActEntDemo:SetNoDraw( true )
		ActEntDemo:SetModel(GMdl)
	end
	local function Tast_Seq_restuo(sstr)
		if IsValid(ActEntDemo) then
			local seq = ActEntDemo:LookupSequence( sstr )
			if seq <= 0 then
				ActEntDemo:ResetSequence(ActEntDemo:LookupSequence(sstr))
				local GetSeq_EACT = ActEntDemo:GetSequenceInfo( ActEntDemo:GetSequence() ).label
				return GetSeq_EACT == sstr
			else
				return true
			end
		else
			return false
		end
	end
	
	local amTab = {
		["GetMDLSeq_AM4"] = {"models/m_anm_am4.mdl","am4_enabled"}
		,["GetMDLSeq_Dyn"] = {"models/player/wiltos/anim_dynamic_maleptr.mdl","_dynamic_wiltos_enabled_"}
		,["GetMDLSeq_xdR"] = {"models/m_xda.mdl","xdreanims_enabled"}
		,["GetMDLSeq_wOS"] = {"models/player/wiltos/anim_base.mdl","_base_wiltos_enabled_"}
		,["GetPackAnimV"] = {"models/player/ani_am4/ani_base.mdl","am4_enabled_v15"}
		,["GetPackAnimVA"] = {"models/player/ani_am4/ani_base.mdl","Amod_Fortnite_Studs"}
		,["GetPackSounds"] = {"sound/actmod/i_act/am4/amod_LF_1.mp3"}
	}
	local TabOK = {["GetMDLSeq_AM4"] = 0,["GetMDLSeq_Dyn"] = 0,["GetMDLSeq_xdR"] = 0,["GetMDLSeq_wOS"] = 0,["GetPackAnimV"] = 0,["GetPackAnimVA"] = 0,["GetPackSounds"] = 0}
	
	for kN ,vM in pairs(amTab) do
		if file.Exists( vM[1], "GAME") then
			TabOK[kN] = 1
			if vM[2] and Tast_Seq_restuo(vM[2]) == true then
				TabOK[kN] = 2
			end
		else
			if vM[2] and Tast_Seq_restuo(vM[2]) == true then
				TabOK[kN] = 4
			else
				TabOK[kN] = 0
			end
		end
	end
	
	if IsValid(ActEntDemo) then ActEntDemo:Remove() end
	
	TabOK["GetORG"] = A_AM.ActMod:AOri() and 1 or 0
	
	if TabOK["GetMDLSeq_Dyn"] == 2 then
		TabOK[ "GetSetBase" ] = "Dyn"
	elseif TabOK["GetMDLSeq_AM4"] == 2 then
		TabOK[ "GetSetBase" ] = "AM4"
	elseif TabOK["GetMDLSeq_xdR"] == 2 then
		TabOK[ "GetSetBase" ] = "xdR"
	elseif TabOK["GetMDLSeq_wOS"] == 2 then
		TabOK[ "GetSetBase" ] = "wOS"
	else
		TabOK[ "GetSetBase" ] = ""
	end
	
	return TabOK
end

local AlphaMap = {["0"] = "a", ["1"] = "z", ["2"] = "c", ["3"] = "x", ["4"] = "e",["5"] = "y", ["6"] = "g", ["7"] = "m", ["8"] = "i", ["9"] = "t"}
local ReverseAlphaMap = {}
for k, v in pairs(AlphaMap) do ReverseAlphaMap[v] = k end
function A_AM.ActMod:GUnTFt(trr,tx)
	trr = tostring(trr)
	if tx then
		trr = trr:gsub(".", function(d)
			return ReverseAlphaMap[d] or "x"
		end)
	else
		trr = trr:gsub(".", function(d)
			return AlphaMap[d] or "x"
		end)
	end
    return trr
end
function A_AM.ActMod:GUniqueFiName(ply,trr)
    if not IsValid(ply) or not ply:IsPlayer() then return "nil__invalid_player" end
    local sid64 = ply:SteamID64()
    if not sid64 then return "nil__no_steamid64" end
    return A_AM.ActMod:GUnTFt(sid64) .. ".dat"
end

function A_AM.ActMod:isValidNameENR(txt)
	return txt:match("^[A-Za-z0-9_]+$") ~= nil
end

function A_AM.ActMod:CTSkipHookThis(nhook,name)
	local TSkipHookThis = true
	if isstring(nhook) and isstring(name) and istable(A_AM.ActMod.Tabs_for_SkipHooks[nhook]) then
		for vname, vTab in pairs(A_AM.ActMod.Tabs_for_SkipHooks[nhook]) do
			local tname = tostring(name)
			if vTab[3] then
				tname = string.lower(tname)
				vname = string.lower(vname)
			end
			if vTab[1] == 1 and string.Left( tname, vTab[2] ) == vname or vTab[1] == 3 and string.Right( tname, vTab[2] ) == vname then
				TSkipHookThis = false
				break
			end
		end
	end
	return TSkipHookThis
end

function A_AM.ActMod:TableSafeMerge(dest, source)
    for k, v in pairs(source) do
        if dest[k] == nil then
            if istable(v) then
                dest[k] = table.Copy(v)
            else
                dest[k] = v
            end
        elseif istable(v) and istable(dest[k]) then
            A_AM.ActMod:TableSafeMerge(dest[k], v)
        end
    end
end

function A_AM.ActMod:aSTim(ABse,BBse,Start,sped,STim)
	if ABse and BBse then
		sped = sped or 1
		if STim then
			Start = Start or SysTime() - 0.5
			return Lerp( (SysTime() - Start )/sped, ABse, BBse)
		else
			Start = Start or CurTime() - 0.5
			return Lerp( (CurTime() - Start )/sped, ABse, BBse)
		end
	end
	return 0
end

function A_AM.ActMod:AG_BED(AY,txt) local Atxt = txt if AY == 1 then Atxt = util.Base64Encode( txt ) elseif AY == 2 then Atxt = util.Base64Decode( txt ) end return Atxt end

function A_AM.ActMod:IsVR(ply)
	return (IsValid(ply) and ply:IsPlayer() and vrmod and vrmod.IsPlayerInVR and vrmod.IsPlayerInVR(ply) or GetConVarNumber("actmod_cl_vr_tst") > 2) or false
end

function A_AM.ActMod:RIPng(st)
	if isstring(st) then
		local tttxt = A_AM.ActMod.Settings["IconsActs"] .. "/" .. st
		local ve = string.lower(A_AM.ActMod:ReString(st):gsub("%s+$", ""))
		local vt = "amod_cumact_".. ve
		vt = vt:gsub("%s+$", "")
		local GTabActO = A_AM.ActMod.GTabActO[vt]
		if istable(GTabActO) and GTabActO.GetName and isstring(GTabActO.ID_ACT) and GTabActO.ID_ACT == ve then
			tttxt = "actmod/cumact/".. st
		end
		return tttxt
	end
	return ""
end

local aw = util.JSONToTable(A_AM.ActMod:AG_BED(2,"eyIjQCI6Imh0IiwiIS4uIjoiQWhtZWRHaXRIdWI0MDAiLCJAIjoiLyIsIiEhIjoiLiIsIiMiOiIvIiwifHx8IjoiZ2l0aHVidXNlcmNvbnRlbnQiLCJ8fCI6ImFhbW1lZDQvZGF0YWMvcmVmcy9oZWFkcy9tYWluLyIsInwiOiJyYXciLCIhQCI6IjovLyIsIltbIjoidHBzIiwiISEhIjoiLmNvbSIsIiFtISI6Im1haW4iLCJ+Z3RgIjoiYU0wXyJ9"))
function A_AM.ActMod:FHTxt( str )
	local keys = {}
	for wr in pairs(aw) do table.insert(keys,wr) end
	table.sort(keys, function(a,b) return #a > #b end)
	for _,wr in ipairs(keys) do
		local co = aw[wr]
		str = string.Replace(str,wr,co)
	end
	return str
end

function A_AM.ActMod:GetEmoIcn( aN , A_0 )
	local aAutR = GetConVarNumber("actmod_cl_autoreimg") > 0
	if A_AM.ActMod.LuaVgi then
		local ActojiData_1,ActojiData_2
		if isstring(A_0) then
			local AMl1 = A_AM.ActMod:RIPng(A_0)
			local AMl2 = A_AM.ActMod:RIPng(A_AM.ActMod.AGetDitN[aN])
			if aAutR and AMl1 ~= "" and AMl2 ~= "" and Material(AMl1, "noclamp smooth"):IsError() then
				ActojiData_1 = Material(AMl2, "noclamp smooth")
				ActojiData_2 = A_AM.ActMod.AGetDitN[aN]
				local AMl = A_AM.ActMod:RIPng(ActojiData_2)
				if ActojiData_2 and AMl ~= "" and not Material(AMl, "noclamp smooth"):IsError() then
					A_AM.ActMod:ReAddEmts("savemots",{A_AM.ActMod:ActojTyp(aN),A_AM.ActMod.aNTyp[aN],ActojiData_2},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
				end
				return {ActojiData_1,ActojiData_2,AMl2}
			else
				local AMlr = A_AM.ActMod:RIPng(A_0)
				if AMlr ~= "" and (not aAutR or not Material(AMlr, "noclamp smooth"):IsError()) then
					ActojiData_1 = Material(AMlr, "noclamp smooth")
					ActojiData_2 = A_0
					return {ActojiData_1,ActojiData_2,AMlr}
				else
					A_AM.ActMod:GetEmoIcn( aN )
				end
			end
		else
			local AMlr = A_AM.ActMod:RIPng(A_AM.ActMod.AGetDitN[aN])
			if AMlr ~= "" and not Material(AMlr, "noclamp smooth"):IsError() then
				ActojiData_1 = Material(AMlr, "noclamp smooth")
				ActojiData_2 = A_AM.ActMod.AGetDitN[aN]
				local AMl = A_AM.ActMod:RIPng(ActojiData_2)
				if ActojiData_2 and not Material(AMl, "noclamp smooth"):IsError() then
					A_AM.ActMod:ReAddEmts("savemots",{A_AM.ActMod:ActojTyp(aN),A_AM.ActMod.aNTyp[aN],ActojiData_2},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
				end
				return {ActojiData_1,ActojiData_2,AMlr}
			end
		end
	else
		local AMlr = A_AM.ActMod.Settings["IconsActs"] .."/reference.png"
		return {Material(AMlr, "noclamp smooth"),"reference.png",AMlr}
	end
end

function A_AM.ActMod:TrgmaNams( txt )
	if isstring( txt ) then
		txt = string.lower(txt)
		if string.sub( txt, 5, 14 ) == "_fortnite_" then
			return "Fortnite"
		elseif string.sub( txt, 5, 12 ) == "_mixamo_" then
			return "Mixamo"
		elseif string.sub( txt, 5, 10 ) == "_pubg_" then
			return "PUBG"
		elseif string.sub( txt, 5, 9 ) == "_am4_" then
			return "AM4"
		elseif string.sub( txt, 5, 9 ) == "_mmd_" then
			return "MMD"
		elseif string.sub( txt, 5, 9 ) == "_cum_" then
			return "CUM"
		end
	end
	return "nil_"
end

function A_AM.ActMod:GetTableKeyType(tbl)
	if not tbl then return "none" end
    local hNKey,hSKey = false,false
    for k, _ in pairs(tbl) do if type(k) == "number" then hNKey = true elseif type(k) == "string" then hSKey = true end end
    if hNKey and not hSKey then return "number_keys" elseif hSKey and not hNKey then return "string_keys" elseif hNKey and hSKey then return "mixed_keys" end
    return "empty"
end

function A_AM.ActMod:RvString(ara)
    local ReName_ = ara
    if string.find(string.sub(ReName_, 1, 14), "amod_fortnite_") then
        ReName_ = string.Replace(ReName_, "amod_fortnite_", "")
    elseif string.find(string.sub(ReName_, 1, 10), "amod_pubg_") then
        ReName_ = string.Replace(ReName_, "amod_pubg_", "")
    elseif string.find(string.sub(ReName_, 1, 12), "amod_mixamo_") then
        ReName_ = string.Replace(ReName_, "amod_mixamo_", "")
    elseif string.find(string.sub(ReName_, 1, 9), "amod_mmd_") then
        ReName_ = string.Replace(ReName_, "amod_mmd_", "")
    elseif string.find(string.sub(ReName_, 1, 9), "amod_am4_") then
        ReName_ = string.Replace(ReName_, "amod_am4_", "")
    elseif string.find(string.sub(ReName_, 1, 12), "amod_cumact_") then
        ReName_ = string.Replace(ReName_, "amod_cumact_", "")
    elseif string.find(string.sub(ReName_, 1, 9), "amod_cum_") then
        ReName_ = string.Replace(ReName_, "amod_cum_", "")
    elseif string.find(string.sub(ReName_, 1, 5), "amod_") then
        ReName_ = string.Replace(ReName_, "amod_", "")
    end
    return ReName_
end

function A_AM.ActMod:ReString(st, tam4)
    local ReNamAct = st or "-_none_-"
    if string.find(ReNamAct, ".png") then ReNamAct = string.Replace(ReNamAct, ".png", "") end
    if string.find(ReNamAct, "._c1_.") then ReNamAct = string.Replace(ReNamAct, "._c1_.", "") end
    if string.find(ReNamAct, "._c2_.") then ReNamAct = string.Replace(ReNamAct, "._c2_.", "") end
    if string.find(ReNamAct, "._mo_.") then ReNamAct = string.Replace(ReNamAct, "._mo_.", "") end
    if string.find(ReNamAct, "._ef_.") then ReNamAct = string.Replace(ReNamAct, "._ef_.", "") end
    if string.find(ReNamAct, "._so_.") then ReNamAct = string.Replace(ReNamAct, "._so_.", "") end
    if tam4 then
		ReNamAct = A_AM.ActMod:RvString(ReNamAct)
    end
    return ReNamAct
end

function A_AM.ActMod:StartSutEp(ttr)
	if timer.Exists( "A_ActModInitPost" ) then timer.Remove( "A_ActModInitPost" ) end
	if ttr == 3 or ttr == 4 then
		A_AM.ActMod.Sutep_Done1 = false
		A_AM.ActMod.Sutep_Done2 = false
		A_AM.ActMod.Sutep_Done3 = false
		if ttr != 4 then
			A_AM.ActMod.Sutep_DoneR = 0
			A_AM.ActMod.Sutep_Error = 0
		end
		A_AM.ActMod.HookThinkSv = false
		A_AM.ActMod.HookThinkCl = 0
	end
	if not A_AM.ActMod.SetChfg then A_AM.ActMod.HookThinkCl = 0 end
	if CLIENT then LocalPlayer().AA_GThinktOne = nil end
	if A_AM.ActMod.LuaBas == true and A_AM.ActMod.LuaHok == true then
		if SERVER and (ttr == 0 or ttr == 3 or ttr == 4) then
			timer.Simple(0.1, function() A_AM.ActMod:ReTast_Seq_restuo() end)
		end
		if ttr == 0 or ttr == 1 or ttr == 3 or ttr == 4 then
			A_AM.ActMod:RemoveAllhook()
			timer.Create("A_AM_ActModSutp",0.3,1,function()
				if ttr == 0 or ttr == 3 or ttr == 4 then A_AM.ActMod:ReSutEp(true) else A_AM.ActMod:ReSutEp() end
			end)
		end
	end
end
function A_AM.ActMod:GetInfAddon(idW,Tty,prin)
	local ok = 0
	local txt = ""
	local txW = tostring(idW)
	local nbW = tonumber(idW)
	if txW == "2896053995" then
		txt = "GDiva"
	end
    for _, entry in ipairs(engine.GetAddons()) do
        if entry.wsid == txW then ok = 1
			if prin then
				print("[ Title ]: ", entry.title)
				print("[ Subscribed ]:",steamworks.IsSubscribed( nbW ) )
				print("[ mounted ]: ", entry.mounted)
			end
			if entry.mounted == true then ok = 2 end
        end
    end
	if txt == "GDiva" then
		if prin then print("[ lua GDiva ]: ",GDiva ) end
		if GDiva then ok = 3
		elseif file.Exists("autorun/client/cl_garrydiva.lua", "LUA") == true and ok > 0 then ok = 3
		end
	elseif Tty == nil and steamworks.IsSubscribed( nbW ) == true and ok > 0 then ok = 3
	elseif Tty and ok > 0 then ok = 3
	end
	if prin then MsgC(Color( 100, 255, 255 ),"[ ".. txt .." ]__" ,Color( 50, 200, 255 ),"Register ..._" )
		if ok == 3 then MsgC(Color( 100, 200, 150 ),"_ Done Register Successfully\n" )
		elseif ok == 2 then MsgC(Color( 210, 170, 180 ),"It is enable but it is not registered\n" )
		elseif ok == 1 then MsgC(Color( 200, 200, 150 ),"_ He is disabled\n" )
		elseif ok == 0 then MsgC(Color( 255, 50, 40 ),"_ Failed to register!\n" )
		end
	end
	return ok
end
function A_AM.ActMod:ReSutEp(ttr)
	if timer.Exists( "A_AM_ActModSutp" ) then timer.Remove( "A_AM_ActModSutp" ) end
	if timer.Exists( "A_AM_ActModSutp2" ) then timer.Remove( "A_AM_ActModSutp2" ) end
	if timer.Exists( "A_AM_ActModSutp3" ) then timer.Remove( "A_AM_ActModSutp3" ) end
	if timer.Exists( "A_AM_ActModShck" ) then timer.Remove( "A_AM_ActModShck" ) end
	if CLIENT then LocalPlayer().Aa_TimeFiledLod = CurTime() + 30 end
	if ttr then
		timer.Create("A_AM_ActModSutp2",0.3,1,function()
			if A_AM.ActMod.LuaHok == true then
				A_AM.ActMod:Setuphook()
			end
		end)
		if timer.Exists( "A_AM_ActModShck" ) then timer.Remove( "A_AM_ActModShck" ) end
		timer.Create("A_AM_ActModShck",4,1,function() A_AM.ActMod:ShckActMod() end)
	end
end
function A_AM.ActMod:FinshStup()
	A_AM.ActMod:ReSutEp()
	local FGa = A_AM.ActMod:AOri()
	if FGa == true then
		A_AM.ActMod.GFilsz["LuaOri"] = "False"
		FGa = nil
	end
	if A_AM.ActMod.Sutep_Error > 0 then
		print( "\n-------------------------------------" )
		print( "--_ ActMod completed successfully _--",A_AM.ActMod.Sutep_Error )
		print( "\n- A_AM.ActMod.Sutep_Done1 =  ",A_AM.ActMod.Sutep_Done1 )
		print( "- A_AM.ActMod.Sutep_Done2 =  ",A_AM.ActMod.Sutep_Done2 )
		print( "- A_AM.ActMod.Sutep_Done3 =  ",A_AM.ActMod.Sutep_Done3 )
		print( "- A_AM.ActMod.Sutep_DoneR =  ",A_AM.ActMod.Sutep_DoneR )
		print( "- A_AM.ActMod.Sutep_Error =  ",A_AM.ActMod.Sutep_Error )
		if SERVER then
			print( "- A_AM.ActMod.HookThinkSv =  ",A_AM.ActMod.HookThinkSv )
			print( "- A_AM.ActMod.HookThinkCl =  ",A_AM.ActMod.HookThinkCl )
		end
		print( "-------------------------------------\n\n" )
	end
end

local function ttfz(nsh)
	if SERVER then
		for _, pl in player.Iterator() do
			if IsValid(pl) and !pl:IsBot() then
				pl:ConCommand("actmod_wtc SToC_aya 4 \n")
			end
		end
	end
	A_AM.ActMod.Sutep_Error = A_AM.ActMod.Sutep_Error+1
	A_AM.ActMod:StartSutEp(4)
	if nsh then
		print( "- ActMod is reloading again" )
	else
		print( "- Failed to load everything, not everything may work !!" )
	end
end

function A_AM.ActMod:ShckActMod()
	if SERVER then
		local GNply = 0
		for _, pl in player.Iterator() do if IsValid(pl) and !pl:IsBot() then GNply = GNply + 1 end end
		if A_AM.ActMod.HookThinkSv == true then A_AM.ActMod.Sutep_Done2 = true end
		if A_AM.ActMod.HookThinkCl > 0 then A_AM.ActMod.Sutep_Done3 = true end
	end
	if A_AM.ActMod.Sutep_Done1 == false or A_AM.ActMod.Sutep_Done2 == false then
		print( "\n\n!!!!!!!!!!!!! Error in ActMod !!!!!!!!!!!!!" )
		print( "- A_AM.ActMod.Sutep_Done1 =  ",A_AM.ActMod.Sutep_Done1 )
		print( "- A_AM.ActMod.Sutep_Done2 =  ",A_AM.ActMod.Sutep_Done2 )
		print( "- A_AM.ActMod.Sutep_Done3 =  ",A_AM.ActMod.Sutep_Done3 )
		print( "- A_AM.ActMod.Sutep_DoneR =  ",A_AM.ActMod.Sutep_DoneR )
		print( "- A_AM.ActMod.Sutep_Error =  ",A_AM.ActMod.Sutep_Error )
		if SERVER then
			print( "- A_AM.ActMod.HookThinkSv =  ",A_AM.ActMod.HookThinkSv )
			print( "- A_AM.ActMod.HookThinkCl =  ",A_AM.ActMod.HookThinkCl )
		end
		if A_AM.ActMod.Sutep_Error < 2 then
			ttfz(1)
		else
			if A_AM.ActMod.Sutep_Error < 9 then
				timer.Create("A_AM_ActModSrr",A_AM.ActMod.Sutep_Error * 2,1,function() ttfz() end)
			end
		end
		if CLIENT then print( "- use  actmod_getlog  in Console to see the error" ) end
		print( "!!!!!!!!!!!!! Error in ActMod !!!!!!!!!!!!!\n\n" )
	else
		A_AM.ActMod:FinshStup()
	end
end

function A_AM.ActMod:IsNumbersOnly(str)
    return string.match(str, "^%d+$") ~= nil
end

function A_AM.ActMod:A_BED(ty,txt)
	ty = ty or 0
	local Atxt = txt
	if not isstring(Atxt) then Atxt = tostring(Atxt) end
	if Atxt ~= "" and string.len(Atxt) > 0 then
		if ty == 1 then
			Atxt = util.Base64Encode( txt )
		elseif ty == 2 then
			Atxt = util.Base64Decode( txt )
		end
		return Atxt
	end
	return ""
end
local metaa = FindMetaTable( "Player" )
function metaa:A_BED(ty,txt) return A_AM.ActMod:AG_BED(ty,txt) end

local function Chfg(txt,Gea,ez,nt,aCS)
	if file.Exists(txt, "LUA") then
		local fSize = SERVER and file.Size(txt, "LUA") > 5 or false
		if aCS then
			if SERVER and fSize then AddCSLuaFile(txt) end
		else
			if Gea and istable(ez) then
				if file.Size(txt, "LUA") == ez[1] and (not ez[2] or file.Time(txt, "LUA") == ez[2] or file.Time(txt, "LUA") == 1) then
					A_AM.ActMod.GFilsz[Gea] = "True"
				else
					A_AM.ActMod.GFilsz[Gea] = "False"
				end
			end
			if nt then
				if nt == 0 then
					if SERVER then include(txt) end
				elseif nt == 1 then
					if SERVER and fSize then AddCSLuaFile(txt) end
					if CLIENT then include(txt) end
				end
			else
				if SERVER and fSize then AddCSLuaFile(txt) end
				include(txt)
			end
		end
	end
end
function A_AM.ActMod:Chfg(txt,nt,aCS) Chfg(txt,nil,nil,nt,aCS) end


local function AG_RetChfg(tn)
	if istable(A_AM.ActMod.SDTabActO) and not table.IsEmpty(A_AM.ActMod.SDTabActO) then
		if isnumber(A_AM.ActMod.SDTabActO[tn]) then
			return A_AM.ActMod.SDTabActO[tn]
		end
	end
	return 0
end
function A_AM.ActMod:AGRCg(tn)
	return AG_RetChfg(tn)
end
local function A_aAMRCh()
	if istable(A_AM.ActMod.GTabActO) and not table.IsEmpty(A_AM.ActMod.GTabActO) and istable(A_AM.ActMod.SDTabActO) and not table.IsEmpty(A_AM.ActMod.SDTabActO)
	and ( not CLIENT or istable(A_AM.ActMod.HaseTablSounds) and not table.IsEmpty(A_AM.ActMod.HaseTablSounds) ) then
		A_AM.ActMod.GFilsz["RCgFg"] = "True"
		A_AM.ActMod.GFilsz["bTActO"] = AG_RetChfg("b_GTabActO") == 29350 and "True" or "False"
		A_AM.ActMod.GFilsz["bTSond"] = AG_RetChfg("b_HaseTablSounds") == 31307 and "True" or "False"
		A_AM.ActMod.GFilsz["aTActO"] = AG_RetChfg("a_GTabActO") == A_AM.ActMod:CalcTabS(A_AM.ActMod.GTabActO) and (A_AM.ActMod:CalcTabS(A_AM.ActMod.GTabActO) - AG_RetChfg("m_GTabActO")) == AG_RetChfg("b_GTabActO") and "True" or "False"
		if CLIENT then
			A_AM.ActMod.GFilsz["aTSond"] = AG_RetChfg("a_HaseTablSounds") == A_AM.ActMod:CalcTabS(A_AM.ActMod.HaseTablSounds) and (A_AM.ActMod:CalcTabS(A_AM.ActMod.HaseTablSounds) - AG_RetChfg("m_HaseTablSounds")) == AG_RetChfg("b_HaseTablSounds") and "True" or "False"
			if istable(A_AM.ActMod.AdScrpt) then
				A_AM.ActMod.GFilsz["aATSct"] = ((A_AM.ActMod:CalcTabS(A_AM.ActMod.AdScrpt) + AG_RetChfg("b_AdScrpt")) - AG_RetChfg("a_AdScrpt")) == AG_RetChfg("b_AdScrpt") and "True" or "False"
			end
		end
	else
		A_AM.ActMod.GFilsz["RCgFg"] = "False"
	end
	local FGa = A_AM.ActMod:AOri()
	A_AM.ActMod.GFilsz["LuaOri"] = FGa and "True" or "False"
	
	if istable(A_AM.ActMod.GetMSS_Tab) or istable(A_AM.ActMod.GetMSS_Tab_cl) then
		if SERVER then
			A_AM.ActMod.GetMSS_Tab["GetORG"] = FGa and 1 or 0
		else
			A_AM.ActMod.GetMSS_Tab_cl["GetORG"] = FGa and 1 or 0
		end
		if SERVER and A_AM.ActMod.bessys_1 then
			for k, v in player.Iterator() do
				if IsValid(v) and (v:GetNWBool("ActMod_Ply_IsReady",false) or v:IsConnected() or v:IsFullyAuthenticated()) then
					net.Start( "A_AM.ActMod.SvToCl_Tab",true ) net.WriteTable( {"SetTCl_MountedSV",A_AM.ActMod.GetMSS_Tab} ) net.Send(v)
				end
			end
		end
	end
end
local function A_AMaRetChfg()
	A_aAMRCh()
	if A_AM.ActMod.LuaAct then
		if A_AM.ActMod.GFilsz["LuaOri"] ~= "True" then
			A_AM.ActMod:aLoadAllTablAS(true)
			A_aAMRCh()
		end
		if A_AM.ActMod.GFilsz["LuaOri"] ~= "True" and (not A_AM.ActMod.GFilszFld or not istable(A_AM.ActMod.SDTabActO) or A_AM.ActMod.GFilszFld ~= A_AM.ActMod.SDTabActO["b_GTabActO"]) then
			A_AM.ActMod.GFilszFld = istable(A_AM.ActMod.SDTabActO) and A_AM.ActMod.SDTabActO["b_GTabActO"] or -1
			A_AM.ActMod:aLoadAllTablAS(true)
		elseif A_AM.ActMod.GFilsz["LuaOri"] == "True" and A_AM.ActMod.GFilszFld then
			A_AM.ActMod.GFilszFld = nil
			A_AM.ActMod:aLoadAllTablAS(true)
		end
	end
end
function A_AM.ActMod:RetChfg()
	A_AMaRetChfg()
end

local function SetChfg()
	Chfg("autorun/sutep_actmod.lua","LuaStp",{77874,1772993585},2)
	Chfg("actmod/am_actmod.lua","LuaBas",{56742,1776740076})
	Chfg("actmod/am_actmod_cam.lua","LuaCam",{23300,1776684057},1)
	Chfg("actmod/bessys/am_sys_1_sv.lua","LuaSs1",{52114,1776738931},0)
	Chfg("actmod/bessys/am_sys_1_cl.lua","Luasc1",{76037,1776641045},1)
	Chfg("actmod/am_actmod_act_base.lua","LuaActB",{90923,1775437659})
	Chfg("actmod/bessys/am_sys_2_sv.lua","LuaSs2",{40093,1776738873},0)
	Chfg("actmod/bessys/am_sys_2_cl.lua","Luasc2",{48214,1772914424},1)
	Chfg("actmod/bessys/am_gflex.lua","LuaGFlx",{18701,1770083226})
	Chfg("actmod/bessys/am_sysflex.lua","LuaSFlx",{22432,1773099116})
	Chfg("actmod/bessys/am_sysgestrue.lua","LuaSGtr",{24333,1772756219})
	Chfg("actmod/am_actmod_shr.lua","LuaSha",{12636,1772807394})
	Chfg("actmod/am_actmod_ent.lua","LuaEnt",{49944,1756254238})
	Chfg("actmod/am_actmod_avs.lua","LuaAvs",{83698,1772807597})
	Chfg("actmod/am_actmod_fon.lua","LuaFon",{34048,1773117447},1)
	Chfg("actmod/am_actmod_hok.lua","LuaHok",{61788,1776740551})
	Chfg("actmod/am_actmod_lan.lua","LuaLan",{19241,1772915090})
	Chfg("actmod/am_actmod_vgi.lua","LuaVgi",{95154,1776743073},1)
	Chfg("actmod/vgi/menu_emotes.lua","LMEPC",{74704,1772755626},1)
	Chfg("actmod/vgi/menu_emotes_vr.lua","LMEVR",{41271,1776742629},1)
	Chfg("actmod/vgi/menu_listerr.lua","LLister",{72028,1770739117},1)
	Chfg("actmod/vgi/menu_option.lua","LOption",{30957,1769892376},1)
	Chfg("actmod/vgi/menu_change.lua","LChange",{83512,1773518765},1)
	Chfg("actmod/vgi/menu_about.lua","LAbout",{26969,1772899096},1)
	Chfg("actmod/vgi/menu_ltd.lua","LaMuLTD",{80607,1758225152},1)
	Chfg("actmod/am_actmod_act.lua","LuaAct",{113293,1776740323})
	Chfg("actmod/am_act_fortnite_pack1.lua","LActFP1",{46144,1772991877})
	Chfg("actmod/am_act_pubg_pack1.lua","LActPP1",{2480,1747233766})
	Chfg("actmod/refix/a_base.lua")
	Chfg("actmod/refix/a_gluehua.lua")
	Chfg("actmod/refix/a_outfitter.lua")
	Chfg("actmod/refix/a_woswlimp.lua")
	Chfg("actmod/am_tmmd.lua")
	hook.Run( "InitLoadLuaActMod" )
end

if A_AM.ActMod.SetChfg or not A_AM.ActMod.OneSutep then SetChfg() end
function A_AM.ActMod:ARTmrRCh()
	timer.Create("A_AM_RetChfg",520,0,function() A_AM.ActMod:RetChfg() end)
end
timer.Create("A_AM_Stup",2,1,function() timer.Create("A_AM_Stup",1,1,function() timer.Create("A_AM_Stup",1,1,function()
	A_AM.ActMod.SetChfg = true SetChfg()
	if timer.Exists( "A_AM_RetChfg" ) then timer.Remove( "A_AM_RetChfg" ) end
timer.Create("A_AM_Stup",2,1,function() timer.Create("A_AM_Stup",1,1,function()
	A_AMaRetChfg() -- A_AM.ActMod:RetChfg()
	A_AM.ActMod:ARTmrRCh()
end) end) end) end) end)


local function fUt(v,s)
	local S1 = false
	if istable( v ) then
		for n, f in pairs( v ) do
			if ( n == s ) then S1 = true continue end
		end
	end
	if ( S1 == true ) then return true else return false end
end

if SERVER then
	util.AddNetworkString("ActModSutep_SvToCl")
	util.AddNetworkString("ActModSutep_ClToSv")
	net.Receive( "ActModSutep_ClToSv", function(len, ply)
		local tab = net.ReadTable()
		if istable(tab) then
			if IsValid( ply ) then
				if tab[1] == "GetLogs" then
					local aR = "!!!!!!!!!0".. tostring(A_AM.ActMod.Sutep_DoneR)
					local GNply,GH_1,GH_1_0,GH_1_1,GH_1_2,GH_2,GH_3,GH_4,GH_5,GH_6,GH_7,GH_8,GH_9,GH_9_1,GH_10 = 0,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false
					for _, pl in player.Iterator() do if IsValid(pl) and !pl:IsBot() then GNply = GNply + 1 end end
					for k, v in pairs(hook.GetTable()) do
						if k == "Think" then GH_1 = fUt(v,aR .."ActMod_ThinkSv") end
						if k == "DoAnimationEvent" then GH_2 = fUt(v,aR .."ActMod_DAE") end
						if k == "UpdateAnimation" then GH_3 = fUt(v,aR .."ActMod_SlowDownAnim") end
						if k == "CalcMainActivity" then GH_4 = fUt(v,aR .."ActMod_Animations") end
						if k == "Move" then GH_5 = fUt(v,aR .."ActMod_MoveDir") end
						if k == "PlayerSpawn" then GH_7 = fUt(v,aR .."ActMod_Spawn") end
						if k == "PlayerDeath" then GH_8 = fUt(v,aR .."ActMod_Death") end
						if k == "OnNPCKilled" then GH_9 = fUt(v,aR .."ActMod_Avs_KillNPC") end
						if k == "ActMod_OnNPCKilled_Sv" then
							GH_9_0 = true
							GH_9_1 = fUt(v,"ActMod_Avs_KNPC")
						end
						if k == "SetupMove" then GH_10 = fUt(v,aR .."ActMod_SetupMove") end
					end
					local tAbl = {
						["A_LuaBas"] = A_AM.ActMod.LuaBas ,["A_LuaBas_Done"] = A_AM.ActMod.LuaBas_Done
						,["A_LuaAct"] = A_AM.ActMod.LuaAct ,["A_LuaAct_Done"] = A_AM.ActMod.LuaAct_Done
						,["A_LuaEnt"] = A_AM.ActMod.LuaEnt ,["A_LuaEnt_Done"] = A_AM.ActMod.LuaEnt_Done
						,["A_LuaAvs"] = A_AM.ActMod.LuaAvs ,["A_LuaAvs_Done"] = A_AM.ActMod.LuaAvs_Done
						,["A_LuaHok"] = A_AM.ActMod.LuaHok ,["A_LuaHok_Done"] = A_AM.ActMod.LuaHok_Done
						,["A_LuaLan"] = A_AM.ActMod.LuaLan ,["A_LuaLan_Done"] = A_AM.ActMod.LuaLan_Done
						,["A_LuaSha"] = A_AM.ActMod.LuaSha ,["A_LuaSha_Done"] = A_AM.ActMod.LuaSha_Done
						,["A_bessys_1"] = A_AM.ActMod.bessys_1 ,["A_bessys_1_Done"] = A_AM.ActMod.bessys_1_Done
						,["A_bessys_2"] = A_AM.ActMod.bessys_2 ,["A_bessys_2_Done"] = A_AM.ActMod.bessys_2_Done
						,["A_GFilsz"] = A_AM.ActMod.GFilsz
						,["A_Sutep_Done1"] = A_AM.ActMod.Sutep_Done1
						,["A_Sutep_Done2"] = A_AM.ActMod.Sutep_Done2
						,["A_Sutep_Done3"] = A_AM.ActMod.Sutep_Done3
						,["A_Sutep_DoneR"] = A_AM.ActMod.Sutep_DoneR
						,["A_Sutep_Error"] = A_AM.ActMod.Sutep_Error
						,["A_GHookTinkSv"] = A_AM.ActMod.HookThinkSv
						,["A_GHookTinkCl"] = A_AM.ActMod.HookThinkCl
						,["A_GHookTinkRn"] = GNply
						,["A_Hook"] = {GH_1,GH_1_0,GH_1_1,GH_1_2,GH_2,GH_3,GH_4,GH_5,GH_6,GH_7,GH_8,GH_9,GH_9_0,GH_9_1,GH_10}
					}
					net.Start( "ActModSutep_SvToCl" ) net.WriteTable( {"Logs","a Logs",tAbl} ) net.Send(ply)
				elseif tab[1] == "ReLoadLua" and ply:IsSuperAdmin() then
					A_AM.ActMod:StartSutEp(3)
					net.Start( "ActModSutep_SvToCl" ) net.WriteTable( {"Logs","a Relod"} ) net.Send(ply)
				end
			end
		end
	end)
	
	concommand.Add("ianitactastp", function(ply, cmd, args)
		if not ply or not IsValid(ply) or not ply:IsPlayer() then return end
		if args and args[1] and args[1] == "ok" then
			if timer.Exists( "Aa_Aatup_SandOK"..ply:EntIndex() ) then timer.Remove( "Aa_Aatup_SandOK"..ply:EntIndex() ) end
		elseif not A_AM or not A_AM.ActMod or not A_AM.ActMod.DidInitPostE then
			if A_AM and A_AM.ActMod then
				ply:SetNWBool("A_ActMod_cl_Sound",true)
				ply:SetNWBool("A_ActMod_cl_Effects",true)
				ply:SetNWInt("A_ActMod_cl_Loop",2)
				A_AM.ActMod.DidInitPostE = true
				A_AM.ActMod:APlayerInitial(ply,0.3)
				ply:ConCommand("actmod_suc SToC_aya 0\n")
				timer.Create("Aa_Aatup_SandOK"..ply:EntIndex(),5,5,function() if IsValid(ply) then ply:ConCommand("actmod_suc SToC_aya 0\n") end end)
				timer.Create("Aa_Aatup_OKOK"..ply:EntIndex(),15,1,function() if IsValid(ply) then ply:SetNWBool("ActMod_Ply_IsReady",true) end end)
				A_AM.ActMod:StartSutEp(0)
			end
		else
			if A_AM and A_AM.ActMod then
				A_AM.ActMod:APlayerInitial(ply,0.3)
				ply:ConCommand("actmod_suc SToC_aya andS\n")
				timer.Create("Aa_Aatup_SandOK"..ply:EntIndex(),5,5,function() if IsValid(ply) then ply:ConCommand("actmod_suc SToC_aya andS\n") end end)
				timer.Create("Aa_Aatup_OKOK"..ply:EntIndex(),15,1,function() if IsValid(ply) then ply:SetNWBool("ActMod_Ply_IsReady",true) end end)
			end
		end
	end)
end


if CLIENT then
	A_AM.ActMod.Actoji = A_AM.ActMod.Actoji or {}
	local Actoji = A_AM.ActMod.Actoji
	A_AM.ActMod.A_ActMod_RedyUse = A_AM.ActMod.A_ActMod_RedyUse or false
	
	net.Receive( "ActModSutep_SvToCl", function()
		local tab = net.ReadTable()
		if tab[1] == "Logs" then
			if tab[2] == "a Logs" and istable(tab[3]) then
				if IsValid(A_AM.ActMod.AAmainLog) then A_AM.ActMod.AAmainLog:ChkActMod(tab[3]) end
			end
			if tab[2] == "a Relod" then A_AM.ActMod:StartSutEp(3) end
		end
	end )
	
	hook.Add("InitPostEntity", "ActMod_StLocalP", function()
		timer.Create("Aa_0Aatup",3,1,function() timer.Create("Aa_0Aatup",2,1,function() timer.Create("Aa_0Aatup",5,5,function()
			if IsValid(LocalPlayer()) and A_AM and A_AM.ActMod and A_AM.ActMod.LuaBas and not A_AM.ActMod.okaastp then
				RunConsoleCommand("ianitactastp")
				A_AM.ActMod.okaastp = true
				LocalPlayer().aactmod_camzm = 0
				LocalPlayer().aactmod_Zamsp = 0
				if timer.Exists( "re_aenforce_model" ) then timer.Remove( "re_aenforce_model" ) end
				timer.Create( "re_aenforce_model",0.5,0,function()
					if IsValid(ply) then
						net.Start("A_AM.ActMod.ClToSv_Tab",true)
						 net.WriteTable( {"ClToSv_aenforce_model",LocalPlayer():GetModel() or ""} )
						net.SendToServer()
					end
				end)
			end
		end) end) end)
	end)
	concommand.Add("actmod_suc", function(ply, cmd, args)
		if IsValid(ply) and ply:IsPlayer() and not ply.A_AM_ActMod_DoneSendSV then
			if args and args[1] and args[1] == "SToC_aya" then
				if timer.Exists( "Aa_0Aatup" ) then timer.Remove( "Aa_0Aatup" ) end
				if A_AM and A_AM.ActMod then
					ply.A_AM_ActMod_DoneSendSV = true
					A_AM.ActMod:StartSutEp(0)
					ply:ConCommand("ianitactastp ok\n")
				else
					timer.Create("Aa_Aatup",0.5,1,function()
						if IsValid(ply) then
							if A_AM and A_AM.ActMod then
								ply.A_AM_ActMod_DoneSendSV = true
								A_AM.ActMod:StartSutEp(0)
								ply:ConCommand("ianitactastp ok\n")
							end
						end
					end)
				end
			end
		end
	end)
	
	local function ActModOpenMenuLogs()
		local rtg = true
		if IsValid(A_AM.ActMod.AAmainLog) then
			A_AM.ActMod.AAmainLog:Remove() A_AM.ActMod.AAmainLog = nil ActModOpenMenuLogs() return
		else
			timer.Simple(0.5,function() if IsValid(A_AM.ActMod.AAmainLog) and rtg then A_AM.ActMod.AAmainLog:Remove() if A_AM.ActMod.AAmainLog then A_AM.ActMod.AAmainLog = nil end end end)
		end
		
		local AAmainLog
		local z1log,z2log = 170, 310
		AAmainLog = vgui.Create( "DFrame" )
		AAmainLog:SetSize( 720, 555 )
		AAmainLog:SetTitle( "" )
		AAmainLog:SetVisible( true )
		AAmainLog:ShowCloseButton( true )
		AAmainLog:MakePopup()
		AAmainLog:Center()	
		AAmainLog.btnMaxim:Hide()
		AAmainLog.btnMinim:Hide() 
		AAmainLog.btnClose:Hide()
		AAmainLog.Paint = function()
			surface.SetDrawColor( 50, 50, 50, 135 )
			surface.DrawOutlinedRect( 0, 0, AAmainLog:GetWide(), AAmainLog:GetTall() )
			surface.SetDrawColor( 0, 0, 0, 240 )
			surface.DrawRect( 1, 1, AAmainLog:GetWide() - 2, AAmainLog:GetTall() - 2 )
			surface.SetFont( "ActMod_a1" )
			surface.SetTextPos( AAmainLog:GetWide() / 2 - surface.GetTextSize( "Menu Logs Lua for ActMod" ) / 2, 2 ) 
			surface.SetTextColor( 255, 255, 255, 255 )
			surface.DrawText( "Menu Logs Lua for ActMod" )
		end
		
		local close = vgui.Create( "DButton", AAmainLog )
		close:SetPos( AAmainLog:GetWide() - 50, 0 )
		close:SetSize( 44, 22 )
		close:SetText( "" )
		
		local colorv = Color( 150, 150, 150, 250 )
		function PaintClose()
			if not AAmainLog then return end
			surface.SetDrawColor( colorv )
			surface.DrawRect( 1, 1, close:GetWide() - 2, close:GetTall() - 2 )	
			surface.SetFont( "ActMod_a6" )
			surface.SetTextColor( 255, 255, 255, 255 )
			surface.SetTextPos( 15, 0 ) 
			surface.DrawText( "X" )
			return true
		end
		close.Paint = PaintClose		
		close.OnCursorEntered = function() colorv = Color( 195, 75, 0, 250 ) PaintClose() end
		close.OnCursorExited = function() colorv = Color( 150, 150, 150, 250 ) PaintClose() end
		close.OnMousePressed = function() colorv = Color( 170, 0, 0, 250 ) PaintClose() end
		close.OnMouseReleased = function() if not LocalPlayer().InProgress then AAmainLog:Close() end end
		AAmainLog.OnClose = function() AAmainLog:Remove() if AAmainLog then AAmainLog = nil end end	
		
		if LocalPlayer():IsSuperAdmin() or LocalPlayer():SteamID() == "STEAM_0:1:612785828" then
			local Relod = vgui.Create( "DButton", AAmainLog )
			Relod:SetPos( 10, 2 )
			Relod:SetSize( 140, 20 )
			Relod:SetText( "" )
			Relod.Paint = function ( ste, w, h )
				if (LocalPlayer().aActmod_Relod or 0) > CurTime() then
					draw.RoundedBox( 6, 0, 0, w, h, Color( 255, 180, 50, 255 ) )
					draw.SimpleText( "R :   ".. math.Round(math.max(0, LocalPlayer().aActmod_Relod - CurTime())) , "ChatFont", 30, h/2, Color(0,50,100,255 ),0,1 )
				else
					draw.RoundedBox( 6, 0, 0, w, h, ste:IsHovered() and Color( 150, 120, 190, 255 ) or Color( 50, 50, 120, 255 ) )
					draw.SimpleText( "ReLoad Lua ActMod", "ChatFont", 5, h/2, Color(255,255,155,255 ),0,1 )
				end
			end
			Relod.DoClick = function ( s )
				if (LocalPlayer().aActmod_Relod or 0) < CurTime() then
					LocalPlayer().aActmod_Relod = CurTime() + 60
					surface.PlaySound("garrysmod/ui_click.wav")
					net.Start( "ActModSutep_ClToSv" ) net.WriteTable( {"ReLoadLua"} ) net.SendToServer()
					timer.Simple(0.1,function() if IsValid(LocalPlayer()) then LocalPlayer():ConCommand("actmod_getlog\n") end end)
				end
			end
		end
		
		local inside = vgui.Create( "DPanel", AAmainLog )
		inside:SetPos( 5, 27 )
		inside:SetSize( AAmainLog:GetWide() - 10, AAmainLog:GetTall() - 34 )
		inside.Paint = function()
			surface.SetDrawColor( 155, 255, 255, 255 )
			surface.DrawOutlinedRect( 0, 0, inside:GetWide(), inside:GetTall() )
			surface.SetDrawColor( 50, 100, 255, 250 )
			surface.DrawRect( 1, 1, inside:GetWide() - 2, inside:GetTall() - 2 )
		end
		
		
		local function CCVg(s1,s2,s3,s4,s5)
			local svlogs = vgui.Create( "DPanel" , inside )
			svlogs:SetSize( s3,s4 )
			svlogs:SetPos( s1,s2 )
			svlogs:SetText( s5 )
			svlogs.Paint = function() 
				surface.SetDrawColor( Color( 0, 0, 0, 250 ) )
				surface.DrawRect( 0, 0, svlogs:GetSize() )
			end
			return svlogs
		end
	
		local Clogs_1 = CCVg(5, 5,z1log,z2log,"Server Logs")
		local artx = vgui.Create( "RichText", Clogs_1 )
		artx:Dock( FILL )
		artx.Paint = function()
			artx.m_FontName = "CenterPrintText" artx:SetFontInternal( "CenterPrintText" )	
			artx:SetBGColor( Color( 0, 0, 0, 0 ) ) artx.Paint = nil
		end artx:InsertColorChange( 255, 255, 255, 255 )
		local function Artxappend( color, text )
			if artx:IsValid() and artx:IsVisible() then
				if type( color ) == "string" then
					artx:AppendText( color )
					return
				end
				if IsValid( artx ) then
					artx:InsertColorChange( color.r, color.g, color.b, color.a or 255 )
					artx:AppendText( text ) artx:InsertColorChange( 255, 255, 255, 255 )
				end
			end
		end
		
		local Clogs_2 = CCVg(Clogs_1:GetWide()+10, 5,z1log,z2log,"Client Logs")
		local acl_rtx = vgui.Create( "RichText", Clogs_2 )
		acl_rtx:Dock( FILL )
		acl_rtx.Paint = function()
			acl_rtx.m_FontName = "CenterPrintText" acl_rtx:SetFontInternal( "CenterPrintText" )	
			acl_rtx:SetBGColor( Color( 0, 0, 0, 0 ) ) acl_rtx.Paint = nil
		end acl_rtx:InsertColorChange( 255, 255, 255, 255 )
		local function cl_Artxappend( color, text )
			if acl_rtx:IsValid() and acl_rtx:IsVisible() then
				acl_rtx:InsertColorChange( color.r, color.g, color.b, color.a or 255 )
				acl_rtx:AppendText( text ) acl_rtx:InsertColorChange( 255, 255, 255, 255 )
			end
		end
		
		local z1logaa = 172
		local Clogs_3sv = CCVg(Clogs_1:GetWide()+Clogs_2:GetWide()+15, 5,z1logaa,z2log,"Original Logs")
		local afi_rtxsv = vgui.Create( "RichText", Clogs_3sv )
		afi_rtxsv:Dock( FILL )
		afi_rtxsv.Paint = function()
			afi_rtxsv.m_FontName = "ActMod_a4" afi_rtxsv:SetFontInternal( "ActMod_a4" )
			afi_rtxsv:SetBGColor( Color( 0, 0, 0, 0 ) ) afi_rtxsv.Paint = nil
		end afi_rtxsv:InsertColorChange( 255, 255, 255, 255 )
		local function fi_Artxappendsv( color, text )
			if afi_rtxsv:IsValid() and afi_rtxsv:IsVisible() then
				afi_rtxsv:InsertColorChange( color.r, color.g, color.b, color.a or 255 )
				afi_rtxsv:AppendText( text ) afi_rtxsv:InsertColorChange( 255, 255, 255, 255 )
			end
		end
		
		local Clogs_3cl = CCVg(Clogs_1:GetWide()+Clogs_2:GetWide()+Clogs_3sv:GetWide()+20, 5,z1logaa,z2log,"Original Logs")
		local afi_rtxcl = vgui.Create( "RichText", Clogs_3cl )
		afi_rtxcl:Dock( FILL )
		afi_rtxcl.Paint = function()
			afi_rtxcl.m_FontName = "ActMod_a4" afi_rtxcl:SetFontInternal( "ActMod_a4" )
			afi_rtxcl:SetBGColor( Color( 0, 0, 0, 0 ) ) afi_rtxcl.Paint = nil
		end afi_rtxcl:InsertColorChange( 255, 255, 255, 255 )
		local function fi_Artxappendcl( color, text )
			if afi_rtxcl:IsValid() and afi_rtxcl:IsVisible() then
				afi_rtxcl:InsertColorChange( color.r, color.g, color.b, color.a or 255 )
				afi_rtxcl:AppendText( text ) afi_rtxcl:InsertColorChange( 255, 255, 255, 255 )
			end
		end
		
		local Clogs_4 = CCVg(5, Clogs_1:GetTall()+10,AAmainLog:GetWide()-260,195,"Sutep Logs")
		local aai_rtx = vgui.Create( "RichText", Clogs_4 )
		aai_rtx:Dock( FILL )
		aai_rtx.Paint = function()
			aai_rtx:SetBGColor( Color( 0, 0, 0, 0 ) ) aai_rtx.Paint = nil
		end aai_rtx:InsertColorChange( 255, 255, 255, 255 )
		local function Artxs1( color, text )
			if aai_rtx:IsValid() and aai_rtx:IsVisible() then
				aai_rtx:InsertColorChange( color.r, color.g, color.b, color.a or 255 )
				aai_rtx:AppendText( text ) aai_rtx:InsertColorChange( 255, 255, 255, 255 )
			end
		end
		
		local Clogs_5 = CCVg(Clogs_4:GetWide()+10, Clogs_1:GetTall()+10,234,195,"Sutep Logs")
		local aai_rDon = vgui.Create( "RichText", Clogs_5 )
		aai_rDon:Dock( FILL )
		aai_rDon.Paint = function()
			aai_rDon:SetBGColor( Color( 0, 0, 0, 0 ) ) aai_rDon.Paint = nil
		end aai_rDon:InsertColorChange( 255, 255, 255, 255 )
		local function ArtxDon( color, text )
			if aai_rDon:IsValid() and aai_rDon:IsVisible() then
				aai_rDon:InsertColorChange( color.r, color.g, color.b, color.a or 255 )
				aai_rDon:AppendText( text ) aai_rDon:InsertColorChange( 255, 255, 255, 255 )
			end
		end
		
		Artxappend( Color( 155, 255, 255 ), "[--  SERVER " )
		Artxappend( Color( 255, 255, 255 ), "ActMod" )
		Artxappend( Color( 155, 255, 255 ), "  --]\n" )
		cl_Artxappend( Color( 255, 255, 155 ), "[--  CLIENT " )
		cl_Artxappend( Color( 255, 255, 255 ), "ActMod" )
		cl_Artxappend( Color( 255, 255, 155 ), "  --]\n" )
		fi_Artxappendsv( Color( 255, 150, 255 ), "[--  Original " )
		fi_Artxappendsv( Color( 155, 255, 255 ), "Server" )
		fi_Artxappendsv( Color( 255, 150, 255 ), " files  --]\n" )
		fi_Artxappendcl( Color( 255, 150, 255 ), "[--  Original " )
		fi_Artxappendcl( Color( 255, 255, 155 ), "Client" )
		fi_Artxappendcl( Color( 255, 150, 255 ), " files  --]\n" )
		
		local ncl,dcl = 0,0
		local nsv,dsv = 0,0
		local nfisv,nficl,dfisv,dficl = 0,0,0,0
		local wsv,wcl = "Failed","Failed"
		local function adldd(col,typ,tx1,g1,g2)
			Artxs1(col or Color( 150, 150, 180 ),tx1)
			if typ == 0 then
				Artxs1(Color( 180, 245, 255 ),"[ SERVER ]: ")
				if g1 == true then Artxs1(Color( 100, 245, 100 ),"true		") else Artxs1(Color( 255, 100, 100 ),"false		") end
			elseif typ == 1 then
				Artxs1(Color( 240, 240, 150 ),"[ CLIENT ]: ")
				if g1 then Artxs1(Color( 100, 245, 100 ),"true\n") else Artxs1(Color( 255, 100, 100 ),"false\n") end
			elseif typ == 2 then
				Artxs1(Color( 180, 245, 255 ),"[ SERVER ]: ")
				if g1 == true then Artxs1(Color( 100, 245, 100 ),"true		") else Artxs1(Color( 255, 100, 100 ),"false		") end
				Artxs1(Color( 240, 240, 150 ),"[ CLIENT ]: ")
				if g2 then Artxs1(Color( 100, 245, 100 ),"true\n") else Artxs1(Color( 255, 100, 100 ),"false\n") end
			end
		end
		local function CDnFd(Svr,txt,Gea,afil,asv)
			if afil then
				if asv then nfisv = nfisv+1 else nficl = nficl+1 end
				if Gea then
					if asv then dfisv = dfisv+1
						fi_Artxappendsv( Color( 200, 220, 200 ), "    [ ".. txt .." ]= " ) fi_Artxappendsv( Color( 100, 255, 120 ), "◎ORG\n" )
					else dficl = dficl+1
						fi_Artxappendcl( Color( 200, 220, 200 ), "    [ ".. txt .." ]= " ) fi_Artxappendcl( Color( 100, 255, 120 ), "◎ORG\n" )
					end
				else
					if asv then
						fi_Artxappendsv( Color( 220, 200, 200 ), "    [ ".. txt .." ]= " ) fi_Artxappendsv( Color( 255, 100, 80 ), "✱MOD\n" )
					else
						fi_Artxappendcl( Color( 220, 200, 200 ), "    [ ".. txt .." ]= " ) fi_Artxappendcl( Color( 255, 100, 80 ), "✱MOD\n" )
					end
				end
			elseif Svr then nsv = nsv+1
				if Gea then dsv = dsv+1
					Artxappend( Color( 200, 220, 200 ), "    [ ".. txt .." ]= " ) Artxappend( Color( 100, 255, 150 ), "Done\n" )
				else
					Artxappend( Color( 220, 200, 200 ), "    [ ".. txt .." ]= " ) Artxappend( Color( 255, 220, 100 ), "Failed\n" )
				end
			else ncl = ncl+1
				if Gea then dcl = dcl+1
					cl_Artxappend( Color( 200, 220, 200 ), "    [ ".. txt .." ]= " ) cl_Artxappend( Color( 100, 255, 150 ), "Done\n" )
				else
					cl_Artxappend( Color( 220, 200, 200 ), "    [ ".. txt .." ]= " ) cl_Artxappend( Color( 255, 220, 100 ), "Failed\n" )
				end
			end
		end
		function AAmainLog:ChkActMod(svr,afi)
		if !IsValid( AAmainLog ) or !IsValid( acl_rtx ) then return end
			if svr then
				Artxappend(Color( 180, 245, 255 ),"Checks ActMod :\n")
				Artxappend(Color( 180, 245, 255 ),"  [ Start ]\n")
				CDnFd(true,"LuaBas",svr["A_LuaBas"])
				CDnFd(true,"LuaAct",svr["A_LuaAct"])
				CDnFd(true,"LuaEnt",svr["A_LuaEnt"])
				CDnFd(true,"LuaAvs",svr["A_LuaAvs"])
				CDnFd(true,"LuaHok",svr["A_LuaHok"])
				CDnFd(true,"LuaLan",svr["A_LuaLan"])
				CDnFd(true,"LuaSha",svr["A_LuaSha"])
				if dsv >= nsv then wsv = "Done" end
				Artxappend(Color( 180, 245, 255 ),"  [ End ]>( ".. tostring(dsv) .." / ".. tostring(nsv) .." )> ".. wsv)
				
				fi_Artxappendsv(Color( 255, 150, 255 ),"Checks System/Files :\n")
				fi_Artxappendsv(Color( 255, 150, 255 ),"  [ Start ]\n")
				for k, v in pairs(svr["A_GFilsz"]) do if k ~= "LuaOri" then CDnFd(nil,k,v == "True",true,true) end end
				local wfi = "Failed"
				if dfisv >= nfisv then wfi = "Done" end
				fi_Artxappendsv(Color( 255, 150, 255 ),"  [ End ]>( ".. tostring(dfisv) .." / ".. tostring(nfisv) .." )> ".. wfi)
				
				adldd(nil,2,"Sutep_Done1 = 			",svr["A_Sutep_Done1"],A_AM.ActMod.Sutep_Done1)
				adldd(nil,2,"Sutep_Done2 = 			",svr["A_Sutep_Done2"],A_AM.ActMod.Sutep_Done2)
				adldd(nil,2,"Sutep_Done3 = 			",svr["A_Sutep_Done3"],A_AM.ActMod.Sutep_Done3)
				Artxs1(Color( 150, 150, 180 ),"Sutep_Error =			")
				Artxs1(Color( 180, 245, 255 ),"[ SERVER ]: ")
				if svr["A_Sutep_Error"] == 0 then Artxs1(Color( 100, 245, 100 ),tostring(svr["A_Sutep_Error"]) .."			") else Artxs1(Color( 255, 100, 100 ),tostring(svr["A_Sutep_Error"]) .."			") end
				Artxs1(Color( 240, 240, 150 ),"[ CLIENT ]: ")
				if A_AM.ActMod.Sutep_Error == 0 then Artxs1(Color( 100, 245, 100 ),tostring(A_AM.ActMod.Sutep_Error) .."\n") else Artxs1(Color( 255, 100, 100 ),tostring(A_AM.ActMod.Sutep_Error) .."\n") end
				Artxs1(Color( 150, 150, 180 ),"HookThinkSv =			")
				Artxs1(Color( 180, 245, 255 ),"[ SERVER ]: ")
				if svr["A_GHookTinkSv"] == true then Artxs1(Color( 100, 245, 100 ),"true\n") else Artxs1(Color( 255, 100, 100 ),"false\n") end
				if svr["A_GHookTinkCl"] == 0 then
					Artxs1(Color( 150, 150, 180 ),"HookThinkCl =			".. tostring(svr["A_GHookTinkCl"]))
				else
					Artxs1(Color( 150, 150, 180 ),"HookThinkCl =			")
					Artxs1(Color( 180, 245, 255 ),"[ SERVER ]: ")
					Artxs1(svr["A_GHookTinkCl"] >= 0 and Color( 100, 255, 200 ) or Color( 255, 150, 100 ),"[  ".. tostring(svr["A_GHookTinkCl"]) .." / ".. tostring(svr["A_GHookTinkRn"]) .."  ]")
				end

				adldd(nil,2,"\n\nLuaBas_Done = 			",svr["A_LuaBas_Done"],A_AM.ActMod.LuaBas_Done)
				adldd(nil,2,"LuaAct_Done = 			",svr["A_LuaAct_Done"],A_AM.ActMod.LuaAct_Done)
				adldd(nil,2,"LuaEnt_Done = 			",svr["A_LuaEnt_Done"],A_AM.ActMod.LuaEnt_Done)
				adldd(nil,2,"LuaAvs_Done = 			",svr["A_LuaAvs_Done"],A_AM.ActMod.LuaAvs_Done)
				adldd(nil,2,"LuaHok_Done = 			",svr["A_LuaHok_Done"],A_AM.ActMod.LuaHok_Done)
				adldd(nil,2,"LuaLan_Done = 			",svr["A_LuaLan_Done"],A_AM.ActMod.LuaLan_Done)
				adldd(nil,2,"LuaSha_Done = 			",svr["A_LuaSha_Done"],A_AM.ActMod.LuaSha_Done)
				adldd(nil,2,"bessys_1_Done = 			",svr["A_bessys_1_Done"],A_AM.ActMod.bessys_1_Done)
				adldd(nil,2,"bessys_2_Done = 			",svr["A_bessys_2_Done"],A_AM.ActMod.bessys_2_Done)
				adldd(nil,1,"LuaCam_Done = 			",A_AM.ActMod.LuaCam_Done)
				adldd(nil,1,"LuaCam_Done = 			",A_AM.ActMod.LuaCam_Done)
				adldd(nil,1,"LuaFon_Done = 			",A_AM.ActMod.LuaFon_Done)
				adldd(nil,1,"LuaVgi_Done = 			",A_AM.ActMod.LuaVgi_Done)
				adldd(nil,1,"LuaVgi_MListErr_Done = 			",A_AM.ActMod.LuaVgi_MListErr_Done)
				adldd(nil,1,"LuaVgi_MChange_Done = 			",A_AM.ActMod.LuaVgi_MChange_Done)
				adldd(nil,1,"LuaVgi_MAbout_Done = 			",A_AM.ActMod.LuaVgi_MAbout_Done)
				adldd(nil,1,"LuaVgi_MOption_Done = 			",A_AM.ActMod.LuaVgi_MOption_Done)
				adldd(nil,1,"LuaVgi_MEmote_Done = 			",A_AM.ActMod.LuaVgi_MEmote_Done)
				adldd(nil,1,"LuaVgi_MEmoteVR_Done = 			",A_AM.ActMod.LuaVgi_MEmoteVR_Done)
				adldd(nil,1,"LuaLTD_Menu_Done = 			",A_AM.ActMod.LuaLTD_Menu_Done)
				
				ArtxDon(Color( 180, 245, 255 ),"[ Hooks SERVER ]\n")
				ArtxDon(Color( 170, 235, 245 )," Think =  ")
				if svr["A_Hook"][1] == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 170, 235, 245 )," DoAnimationEvent =  ")
				if svr["A_Hook"][5] == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 170, 235, 245 )," UpdateAnimation =  ")
				if svr["A_Hook"][6] == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 170, 235, 245 )," CalcMainActivity =  ")
				if svr["A_Hook"][7] == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 170, 235, 245 )," Move =  ")
				if svr["A_Hook"][8] == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 170, 235, 245 )," PlayerSpawn =  ")
				if svr["A_Hook"][10] == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 170, 235, 245 )," PlayerDeath =  ")
				if svr["A_Hook"][11] == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 170, 235, 245 )," OnNPCKilled =  ")
				if svr["A_Hook"][12] == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 170, 235, 245 )," SetupMove =  ")
				if svr["A_Hook"][15] == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				
				local aR = "!!!!!!!!!0".. tostring(A_AM.ActMod.Sutep_DoneR)
				local GH_1,GH_2,GH_3,GH_4,GH_5,GH_6,GH_7,GH_8,GH_9,GH_10,GH_11,GH_12,GH_13 = false,false,false,false,false,false,false,false,false,false,false,false,false
				for k, v in pairs(hook.GetTable()) do
					if k == "Think" then GH_1 = fUt(v,aR .."ActMod_ThinkCl") end
					if k == "ActMod_Think_Cl" then
						GH_1_0 = true
						GH_1_1 = fUt(v,"ActMod_Cl_Base")
						GH_1_2 = fUt(v,"ActMod_Cl_Avs")
					end
					if k == "DoAnimationEvent" then GH_2 = fUt(v,aR .."ActMod_DAE") end
					if k == "UpdateAnimation" then GH_3 = fUt(v,aR .."ActMod_SlowDownAnim") end
					if k == "CalcMainActivity" then GH_4 = fUt(v,aR .."ActMod_Animations") end
					if k == "Move" then GH_5 = fUt(v,aR .."ActMod_MoveDir") end
					if k == "HUDWeaponPickedUp" then GH_6 = fUt(v,aR .."ActMod_NSw") end
					if k == "PlayerSpawn" then GH_7 = fUt(v,aR .."ActMod_Spawn") end
					if k == "PlayerDeath" then GH_8 = fUt(v,aR .."ActMod_Death") end
					if k == "PostRender" then GH_9 = fUt(v,aR .."ActMod_PRender") end
					if k == "PostPlayerDraw" then GH_13 = fUt(v,aR .."ActMod_PostPlayerDraw") end
					if k == "SetupMove" then GH_10 = fUt(v,aR .."ActMod_SetupMove") end
					if k == "PreRender" and game.SinglePlayer() then GH_11 = fUt(v,aR .."ActMod_PreRender") end
					if k == "PostDrawOpaqueRenderables" then GH_12 = fUt(v,aR .."ActMod_PostDrawOpaqueRenderables") end
				end
				
				ArtxDon(Color( 240, 240, 150 ),"\n[ Hooks CLIENT ]\n")
				ArtxDon(Color( 230, 230, 140 )," Think =  ")
				if GH_1 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," DoAnimationEvent =  ")
				if GH_2 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," UpdateAnimation =  ")
				if GH_3 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," CalcMainActivity =  ")
				if GH_4 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," Move =  ")
				if GH_5 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," HUDWeaponPickedUp =  ")
				if GH_6 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," PlayerSpawn =  ")
				if GH_7 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," PlayerDeath =  ")
				if GH_8 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				if game.SinglePlayer() then
					ArtxDon(Color( 230, 230, 140 )," PreRender =  ")
					if GH_11 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				end
				ArtxDon(Color( 230, 230, 140 )," PostRender =  ")
				if GH_9 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," PostPlayerDraw =  ")
				if GH_13 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," PostDrawOpaqueRenderables =  ")
				if GH_12 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				ArtxDon(Color( 230, 230, 140 )," SetupMove =  ")
				if GH_10 == true then ArtxDon(Color( 100, 245, 100 ),"true\n") else ArtxDon(Color( 255, 100, 100 ),"false\n") end
				
			else
				cl_Artxappend(Color( 240, 240, 150 ),"Checks ActMod :\n")
				cl_Artxappend(Color( 240, 240, 150 ),"  [ Start ]\n")
				CDnFd(nil,"LuaBas",A_AM.ActMod.LuaBas)
				CDnFd(nil,"LuaAct",A_AM.ActMod.LuaAct)
				CDnFd(nil,"LuaEnt",A_AM.ActMod.LuaEnt)
				CDnFd(nil,"LuaAvs",A_AM.ActMod.LuaAvs)
				CDnFd(nil,"LuaFon",A_AM.ActMod.LuaFon)
				CDnFd(nil,"LuaHok",A_AM.ActMod.LuaHok)
				CDnFd(nil,"LuaLan",A_AM.ActMod.LuaLan)
				CDnFd(nil,"LuaSha",A_AM.ActMod.LuaSha)
				CDnFd(nil,"LuaVgi",A_AM.ActMod.LuaVgi)
				if dcl >= ncl then wcl = "Done" end
				cl_Artxappend(Color( 240, 240, 150 ),"  [ End ]>( ".. tostring(dcl) .." / ".. tostring(ncl) .." )> ".. wcl)
				
				fi_Artxappendcl(Color( 255, 150, 255 ),"Checks System/Files :\n")
				fi_Artxappendcl(Color( 255, 150, 255 ),"  [ Start ]\n")
				if game.IsDedicated() then
					for k, v in pairs(A_AM.ActMod.GFilsz) do if k ~= "LuaOri" and table.HasValue( atb, k ) then CDnFd(nil,k,v == "True",true) end end
				else
					for k, v in pairs(A_AM.ActMod.GFilsz) do if k ~= "LuaOri" then CDnFd(nil,k,v == "True",true) end end
				end
				local wfi = "Failed"
				if dficl >= nficl then wfi = "Done" end
				fi_Artxappendcl(Color( 255, 150, 255 ),"  [ End ]>( ".. tostring(dficl) .." / ".. tostring(nficl) .." )> ".. wfi)
				
			end
		end

		AAmainLog:ChkActMod()
		local Rer = vgui.Create( "DButton", AAmainLog )
		Rer:SetPos( AAmainLog:GetWide() - 100, 0 )
		Rer:SetSize( 40, 22 )
		Rer:SetText( "" )
		Rer.Paint = function ( ste, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, ste:IsHovered() and Color( 170, 180, 190, 255 ) or Color( 50, 50, 120, 255 ) )
			draw.SimpleText( "(R)", "ActMod_a1", w/2, h/2, Color(255,255,155,255 ) ,1,1 )
		end
		Rer.DoClick = function ( s )
			surface.PlaySound("garrysmod/ui_click.wav")
			artx:SetText("")
			acl_rtx:SetText("")
			afi_rtxsv:SetText("")
			afi_rtxcl:SetText("")
			aai_rtx:SetText("")
			aai_rDon:SetText("")
			Artxappend( Color( 155, 255, 255 ), "[--  SERVER " )
			Artxappend( Color( 255, 255, 255 ), "ActMod" )
			Artxappend( Color( 155, 255, 255 ), "  --]\n" )
			cl_Artxappend( Color( 255, 255, 155 ), "[--  CLIENT " )
			cl_Artxappend( Color( 255, 255, 255 ), "ActMod" )
			cl_Artxappend( Color( 255, 255, 155 ), "  --]\n" )
			fi_Artxappendsv( Color( 255, 150, 255 ), "[--  Original " )
			fi_Artxappendsv( Color( 155, 255, 255 ), "Server" )
			fi_Artxappendsv( Color( 255, 150, 255 ), " files  --]\n" )
			fi_Artxappendcl( Color( 255, 150, 255 ), "[--  Original " )
			fi_Artxappendcl( Color( 255, 255, 155 ), "Client" )
			fi_Artxappendcl( Color( 255, 150, 255 ), " files  --]\n" )
			ncl,dcl = 0,0
			nsv,dsv = 0,0
			nfisv,nficl,dfisv,dficl = 0,0,0,0
			wcl = "Failed"
			wsv = "Failed"
			AAmainLog:ChkActMod()
			net.Start( "ActModSutep_ClToSv" ) net.WriteTable( {"GetLogs"} ) net.SendToServer()
		end
		rtg = nil
		A_AM.ActMod.AAmainLog = AAmainLog
	end
	concommand.Add("actmod_getlog", function(ply)
		ActModOpenMenuLogs()
		net.Start( "ActModSutep_ClToSv" ) net.WriteTable( {"GetLogs"} ) net.SendToServer()
	end)
	
	local function ACrConV_cl(a1,...) if !ConVarExists(a1) then CreateClientConVar(a1,...) end end
	ACrConV_cl("actmod_cl_showmasngerr", 1, true, false)
	ACrConV_cl("actmod_cl_eloading", 0, true, false)
	ACrConV_cl("actmod_cl_menuformat", 1, true, false)
	ACrConV_cl("actmod_cl_menuformat2", 1, true, false)
	ACrConV_cl("actmod_cl_loop", 2, true, false)
	ACrConV_cl("actmod_cl_effects", 1, true, false)
	ACrConV_cl("actmod_cl_sound", 1, true, false)
	ACrConV_cl("actmod_cl_thememenu", 1, true, false)
	ACrConV_cl("actmod_cl_stext", "dance", true, false)
	ACrConV_cl("actmod_cl_background", 1, true, false)
	ACrConV_cl("actmod_cl_asyn", 1, true, false)
	ACrConV_cl("actmod_cl_sortemote", 1, true, false)
	ACrConV_cl("actmod_cl_setcamera", 0, true, false)
	ACrConV_cl("actmod_cl_pageslot", 1, true, false)
	ACrConV_cl("actmod_cl_smshcam_on", 0, true, false)
	ACrConV_cl("actmod_cl_smshcam_sp", 5, true, false)
	ACrConV_cl("actmod_cl_showbhelp", 1, true, false)
	ACrConV_cl("actmod_cl_stibox", 1, true, false)
	ACrConV_cl("actmod_cl_lang", "none", true, false)
	ACrConV_cl("actmod_cl_cam180", 0, true, false)
	ACrConV_cl("actmod_cl_viewdis", 2100, true, false ,"min: 0  /  max: 9000" ,0,9000)
	ACrConV_cl("actmod_cl_automclose", 1, true, false)
	ACrConV_cl("actmod_cl_showslotss", 1, true, false)
	ACrConV_cl("actmod_cl_showiconsml", 1, true, false)
	ACrConV_cl("actmod_cl_showmsgavs", 1, true, false)
	ACrConV_cl("actmod_cl_showmsgavssnd", 1, true, false)
	ACrConV_cl("actmod_cl_vrslist", 1, true, false)
	ACrConV_cl("actmod_cl_vrjoin", 1, true, false)
	ACrConV_cl("actmod_cl_vr_tst", 0, false, false)
	ACrConV_cl("actmod_cl_smartomenu", 1, true, false)
	ACrConV_cl("actmod_cl_soundlevel", 100, true, false ,"min: 5  /  max: 100" ,5,100)
	ACrConV_cl("actmod_cl_soundlevelother", 100, false, false ,"min: 5  /  max: 100" ,5,100)
	ACrConV_cl("actmod_cl_sdwfix", 0, true, false)
	ACrConV_cl("actmod_cl_showarrow", 0, true, false)
	ACrConV_cl("actmod_cl_showsholightic", 1, true, false)
	ACrConV_cl("actmod_cl_showhisyn", 1, true, false)
	ACrConV_cl("actmod_cl_autoreimg", 0, true, false)
	ACrConV_cl("actmod_cl_q_ef", 2, true, false ,"min: 1  /  max: 4" ,1,4)
	ACrConV_cl("actmod_cl_g_hud_typ", 1, true, false ,"min: 0  /  max: 5" ,0,5)
	ACrConV_cl("actmod_sp_pause", 1, true, false ,"min: 0  /  max: 1" ,0,1)
	
	local function AdCCb(ply,strg,Nval)
		RunConsoleCommand("actmod_wts",strg,tostring(ply:EntIndex()),tostring(Nval))
	end
	
	cvars.RemoveChangeCallback("actmod_cl_sound", "actmod_cl_sound__1")
	cvars.AddChangeCallback("actmod_cl_sound", function(name, oldVal, newVal)
		if newVal == "1" then AdCCb(LocalPlayer(),"CToS_Sond",1) else AdCCb(LocalPlayer(),"CToS_Sond",0) end
	end,"actmod_cl_sound__1")

	cvars.RemoveChangeCallback("actmod_cl_effects", "actmod_cl_effects__1")
	cvars.AddChangeCallback("actmod_cl_effects", function(name, oldVal, newVal)
		if newVal == "1" then AdCCb(LocalPlayer(),"CToS_Effe",1) else AdCCb(LocalPlayer(),"CToS_Effe",0) end
	end,"actmod_cl_effects__1")

	cvars.RemoveChangeCallback("actmod_cl_asyn", "actmod_cl_asyn__1")
	cvars.AddChangeCallback("actmod_cl_asyn", function(name, oldVal, newVal)
		if newVal == "1" then AdCCb(LocalPlayer(),"CToS_ASyn",1) else AdCCb(LocalPlayer(),"CToS_ASyn",0) end
	end,"actmod_cl_asyn__1")

	cvars.RemoveChangeCallback("actmod_cl_loop", "actmod_cl_loop__1")
	cvars.AddChangeCallback("actmod_cl_loop", function(name, oldVal, newVal)
		if newVal == "1" then AdCCb(LocalPlayer(),"CToS_Loop",1)
		elseif newVal == "2" then AdCCb(LocalPlayer(),"CToS_Loop",2)
		else AdCCb(LocalPlayer(),"CToS_Loop",0)
		end
	end,"actmod_cl_loop__1")

	cvars.RemoveChangeCallback("actmod_cl_lang", "actmod_cl_lang__1")
	cvars.AddChangeCallback("actmod_cl_lang", function(name, oldVal, newVal)
		if A_AM.ActMod.Actoji and IsValid(A_AM.ActMod.Actoji.Underlay) then A_AM.ActMod.Actoji.Underlay:Remove() end
	end,"actmod_cl_lang__1")
	
	cvars.RemoveChangeCallback("actmod_cl_allowkey", "actmod_cl_allowkey__1")
	cvars.AddChangeCallback("actmod_cl_allowkey", function(name, oldVal, newVal)
		if newVal == "1" then
			if LocalPlayer().pgh_loked and IsValid(LocalPlayer().pgh_loked) and LocalPlayer().pgh_loked.loked and IsValid(LocalPlayer().pgh_loked.loked) then
				LocalPlayer().pgh_loked.loked:Remove()
				LocalPlayer().pgh_loked.loked = nil
			end
		else
			if LocalPlayer().pgh_loked and IsValid(LocalPlayer().pgh_loked) and (LocalPlayer().gh_Ti or 0) < CurTime() then
				LocalPlayer().gh_Ti = CurTime() + 0.2
				LocalPlayer().pgh_loked.ALoked()
			end
		end
	end,"actmod_cl_allowkey__1")
	
	cvars.RemoveChangeCallback("actmod_cl_allowkey2", "actmod_cl_allowkey2__1")
	cvars.AddChangeCallback("actmod_cl_allowkey2", function(name, oldVal, newVal)
		if newVal == "1" then
			if LocalPlayer().pgh_loked and IsValid(LocalPlayer().pgh_loked) and LocalPlayer().pgh_loked.loked2 and IsValid(LocalPlayer().pgh_loked.loked2) then
				LocalPlayer().pgh_loked.loked2:Remove()
				LocalPlayer().pgh_loked.loked2 = nil
			end
		else
			if LocalPlayer().pgh_loked and IsValid(LocalPlayer().pgh_loked) and (LocalPlayer().gh_Ti2 or 0) < CurTime() then
				LocalPlayer().gh_Ti2 = CurTime() + 0.2
				LocalPlayer().pgh_loked.ALoked(true)
			end
		end
	end,"actmod_cl_allowkey2__1")
	
	hook.Add("PopulateToolMenu", "A_ActMod_SOMenu", function()
		spawnmenu.AddToolMenuOption("Options", "Game Options (A)", "actmod_options", "ActMod", "", "", function(panel)
			panel:SetName(aR:T("AL_Optin"))
			panel:AddControl("Header", {Text = "",Description = "this ActMod by AhmedMake400 , (Version ".. A_AM.ActMod.Mounted[ "Version ActMod" ] ..")"})
			local aed_ty = {Options = {}, CVars = {}, Label = "the language", MenuButton = "2"}
			aed_ty.Options["1- English"] = {actmod_cl_lang = "en"}
			aed_ty.Options["2- Russian"] = {actmod_cl_lang = "ru"}
			aed_ty.Options["3- China"] = {actmod_cl_lang = "zh-CN"}
			aed_ty.Options["4- Germany"] = {actmod_cl_lang = "de"}
			aed_ty.Options["5- Turkish"] = {actmod_cl_lang = "tr"}
			panel:AddControl("ComboBox", aed_ty) aed_ty = nil
			if LocalPlayer():IsListenServerHost() then
				panel:AddControl("Label", {Text = aR:T("AL_SOS")})
				panel:AddControl("Checkbox", {Label = aR:T("AL_SOS_EA"),Command = "actmod_sv_enabled"})
				panel:AddControl("Checkbox", {Label = aR:T("AL_SOS_AF"),Command = "actmod_sv_enabled_addef"})
				panel:AddControl("Checkbox", {Label = aR:T("AL_SOS_AS"),Command = "actmod_sv_enabled_addso"})
				panel:AddControl("Checkbox", {Label = aR:T("LAchievements"),Command = "actmod_sv_avs"})
				panel:ControlHelp(aR:T("LAchievements_H")):DockMargin( 16, 4, 16, 8 )
				panel:AddControl("Label", {Text = ""})
			end
			panel:AddControl("Label", {Text = aR:T("AL_COS")})
			panel:AddControl("Checkbox", {Label = aR:T("AL_COS_EnLodng"),Command = "actmod_cl_eloading"})
			panel:ControlHelp(aR:T("AL_COS_EnLodng_hlp")):DockMargin( 16, 4, 16, 8 )
			panel:AddControl("Numpad", { Label = aR:T("AL_COS_Ky"), Command = "actmod_key_iconmenu" })
			panel:AddControl("Checkbox", {Label = aR:T("AL_COS_EH"),Command = "actmod_cl_showbhelp"})
			panel:AddControl("button", {Label = aR:T("LReplace_txt_Options"),Command = "actmod_cl_listoption"})
			if A_AM.ActMod.Mounted[ "Theatrical MMD" ] == true then
				panel:AddControl("Label", {Text = ""})
				panel:AddControl("Label", {Text = "--------------------------------"})
				panel:AddControl("Label", {Text = "--------------------------------"})
				panel:AddControl("Label", {Text = ""})
				panel:AddControl("Label", {Text = "Theatrical MMD by AhmedMake400 ,(Version ".. A_AM.ActMod.Mounted[ "Version TheatricalMMD" ] ..")"})
				if LocalPlayer():IsListenServerHost() then
					panel:AddControl("Label", {Text = aR:T("AL_SOS")})
					panel:AddControl("Checkbox", {Label = "Enable ActorBot",Command = "actent_sv_actorbot"})
					local aed_ty1 = {Options = {}, CVars = {}, Label = "selection for model:", MenuButton = "0"}
					aed_ty1.Options["0- Random"] = {actend_sv_smodel = 0}
					aed_ty1.Options["1- Manual"] = {actend_sv_smodel = 1}
					panel:AddControl("ComboBox", aed_ty1)
					panel:AddControl("TextBox", {Label = "Model Bot1 :", Description = "", MaxLength = 255, Text = "stuff", Command = "actend_sv_nmodelname1"})
					panel:AddControl("TextBox", {Label = "Model Bot2 :", Description = "", MaxLength = 255, Text = "stuff", Command = "actend_sv_nmodelname2"})
					panel:AddControl("TextBox", {Label = "Model Bot3 :", Description = "", MaxLength = 255, Text = "stuff", Command = "actend_sv_nmodelname3"})
					aed_ty1 = nil
				end
			end
		end)
	end)
end	


hook.Add( "InitLoadAnimations", "AM4.AddBaseAM4", function()
	wOS.DynaBase:RegisterSource({
		Name = "Base Anim AM4",
		Type =  WOS_DYNABASE.EXTENSION,
		Male = "models/player/ani_am4/ani_base_m.mdl",
		Female = "models/player/ani_am4/ani_base_f.mdl",
		Zombie = "models/player/ani_am4/ani_base_z.mdl",
	})
	if file.Exists( "models/m_xda.mdl", "GAME") then
		wOS.DynaBase:RegisterSource({
			Name = "xdReanimsBase (GMod)",
			Type =  WOS_DYNABASE.EXTENSION,
			Male = "models/xdreanims/m_anm_base.mdl",
			Female = "models/xdreanims/f_anm_base.mdl",
			Zombie = "models/xdreanims/z_anm_base.mdl",
		})
	end
end )
hook.Add( "PreLoadAnimations", "wOS.DynaBase.MountAM4Base", function( gender )
  if gender == WOS_DYNABASE.MALE then
    IncludeModel( "models/player/ani_am4/ani_base_m.mdl" )
  elseif gender == WOS_DYNABASE.FEMALE then
    IncludeModel( "models/player/ani_am4/ani_base_f.mdl" )
  elseif gender == WOS_DYNABASE.ZOMBIE then
    IncludeModel( "models/player/ani_am4/ani_base_z.mdl" )  
  end
end )


A_AM.ActMod.OneSutep = true

if SERVER then
	MsgC(Color( 100, 220, 255 ),"Server: " ,Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"] Done Load Successfully\n\n\n" )
else
	MsgC(Color( 240, 240, 100 ),"Client: " ,Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"] Done Load Successfully\n\n\n" )
end
