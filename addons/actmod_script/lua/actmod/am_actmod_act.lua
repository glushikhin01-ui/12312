local function arint( tx1,tx2,tx3,tpe )
	if isstring(tx1) and (isstring(tx2) or isstring(tx3) and isstring(tpe)) and (not tx3 or isstring(tx3)) then
		local pt = tpe or "log"
		if not A_AM.ActMod.GetAllErrTabAct then A_AM.ActMod.GetAllErrTabAct = {} end
		if not A_AM.ActMod.GetAllErrTabAct[pt] then A_AM.ActMod.GetAllErrTabAct[pt] = {} end
		if not A_AM.ActMod.GetAllErrTabAct[pt][tx1] then A_AM.ActMod.GetAllErrTabAct[pt][tx1] = {} end
		if not isstring(tx2) then
			table.insert(A_AM.ActMod.GetAllErrTabAct[pt][tx1] , tx3)
		else
			if tx3 then
				if not A_AM.ActMod.GetAllErrTabAct[pt][tx1][tx2] then A_AM.ActMod.GetAllErrTabAct[pt][tx1][tx2] = {} end
				table.insert(A_AM.ActMod.GetAllErrTabAct[pt][tx1][tx2] , tx3)
			else
				table.insert(A_AM.ActMod.GetAllErrTabAct[pt][tx1] , tx2)
			end
		end
	end
end

local function sysTN(T,T_1,T_2,T_3)
	if istable(T_1) then
		if istable(T_1.Sound) then
			local TypTab = A_AM.ActMod:GetTableKeyType(T_1.Sound)
			if TypTab == "number_keys" then
				T[T_2] = {}
				for k,v in ipairs(T_1.Sound) do if isstring(v) then table.insert(T[T_2],v) end end
			elseif TypTab == "string_keys" then
				T[T_2] = {}
				for k,v in pairs(T_1.Sound) do if isstring(v) then table.insert(T[T_2],v) end end
			end
		elseif isstring(T_1.Sound) then
			T[T_2] = T_1.Sound
		end
		if T[T_2] and isnumber(T_1.Delay) then T[T_3] = T_1.Delay end
	end
end

local function sa2(T) return isstring(T) and {T} or T end
local function aaGetTaDaSnds(k,vSounds,isV)
	if istable(vSounds.Start) and (isstring(vSounds.Start.Sound) or istable(vSounds.Start.Sound)) then
		local tTab,ktab,itab = {},{},{}
		sysTN(tTab,vSounds.Start,"s_1","d_1")
		sysTN(tTab,vSounds.StartExtra,"s_2","d_2")
		sysTN(tTab,vSounds.Repeat,"s_3","d_3")
		if not table.IsEmpty(tTab) then
			if tTab.s_2 and tTab.s_3 then
				ktab = { sa2(tTab.s_2),tTab.d_2 ,sa2(tTab.s_3),tTab.d_3 ,sa2(tTab.s_1),tTab.d_1 }
			elseif tTab.s_3 then
				ktab = { sa2(tTab.s_1),tTab.d_1 ,sa2(tTab.s_3),tTab.d_3 }
			else
				ktab = { sa2(tTab.s_1),tTab.d_1 }
			end
			if isV then
				local t_1,t_2
				if vSounds.Time1 then t_1 = vSounds.Time1 end
				if vSounds.Time2 then t_2 = vSounds.Time2 end
				if t_1 or t_2 then itab = {t_1,t_2} end
			end
			return ktab,itab
		end
	end
end
local function IsLuaFileOnlyReturnTable(path)
    local contt = file.Read(path, "LUA")
    if not contt then return false, "file not found" end
    if contt:sub(1,3) == "\239\187\191" then contt = contt:sub(4) end
    local lines = string.Explode("\n", contt)
    local cld,alFuFi,reR,Ogr,AUSIz = {},false,false,false,#contt
    local crr,Trr
    for _, line in ipairs(lines) do
        local trimmed = string.Trim(line)
        if not reR and trimmed:StartWith("//") then
            local authLine = string.Trim(trimmed:sub(3))
            local parts = string.Explode("|", authLine)
            if #parts >= 3 then
                local size,secret,typp = tonumber(parts[2]),parts[3],parts[4]
                if isstring(typp) and typp ~= "" then Trr = typp end
                if isnumber(size) and isstring(secret) and size == AUSIz and (isstring(Trr) and Trr == "Il" or istable(A_AM.ActMod.Aedons) and table.HasValue(A_AM.ActMod.Aedons,A_AM.ActMod:GUnTFt(secret))) then
					crr = secret Ogr = true
					if not Trr or isstring(Trr) and Trr ~= "Il" then alFuFi = true break end
                end
            end
        end
        if trimmed:match("^return%s") then reR = true end
        if trimmed ~= "" and not trimmed:StartWith("--") and not trimmed:StartWith("//") then
            table.insert(cld, trimmed)
        end
    end
    if alFuFi then return true, "authorized full lua file",crr,Trr,Ogr end
    local finalContt = table.concat(cld, " ")
    if finalContt:match("^return%s*%b{}%s*$") then
        local bt = { "function%s*%(","CompileString%s*%(","RunString%s*%(","RunStringEx%s*%(","setmetatable%s*%(","getmetatable%s*%(","setfenv%s*%(","getfenv%s*%(","debug%.","include%s*%(","require%s*%(","AddCSLuaFile%s*%(","_G%s*%[","%.%.%(" }
        for _, pt in ipairs(bt) do if finalContt:match(pt) then return false, "executable code not allowed" ,-2 end end
        return true, "return table only",crr,Trr,Ogr
    end
    return false, "not authorized and not a pure return table"
end


function A_AM.ActMod:GetNumMax(tbl,a1,a2)
    local m
    for k, v in pairs(tbl) do
        if a1 and isnumber(k) and (not m or k > m) then m = k end
        if (a2 == nil or a2) and isnumber(v) and (not m or v > m) then m = v end
    end
    return m
end

local function AA_JetAllAddTabCAct( ata )
	A_AM.ActMod.TDCustom = {}
	if not A_AM.ActMod.GetAllAddTabAct then A_AM.ActMod.GetAllAddTabAct = {} end
	A_AM.ActMod.GetAllAddTabAct["Act"] = {}
	A_AM.ActMod.GetAllAddTabAct["Sounds"] = {}
	A_AM.ActMod.ActNewVCustom = A_AM.ActMod.ActNewVCustom or {}
	if not A_AM.ActMod.GetAllErrTabAct then A_AM.ActMod.GetAllErrTabAct = {} end
	A_AM.ActMod.GetAllErrTabAct["log"] = {}
	A_AM.ActMod.GetAllErrTabAct["Errors"] = {}
	A_AM.ActMod.GetAllErrTabAct["Act"] = {}
	A_AM.ActMod.GetAllErrTabAct["Sounds"] = {}
	local files, directories = file.Find( "actmod/am_animc/*", "LUA" )
	for _k, afile in pairs(files) do
		if string.sub(afile,-4) == ".lua" and file.Exists( "actmod/am_animc/".. afile, "LUA") then
			local ok,err,crr,Trr,Ogr = IsLuaFileOnlyReturnTable("actmod/am_animc/".. afile, "LUA")
			if ata and not A_AM.ActMod.GFilszFld then
				if SERVER and ok or CLIENT and (not crr or crr ~= -2) then
					local GDfile = include("actmod/am_animc/".. afile) arint(afile,"[0] Reading file ...")
					if GDfile and istable(GDfile) and not table.IsEmpty(GDfile) then arint(afile,"[1] Checking current and previous data ...")
						local Gtb_1,Gtb_2 = A_AM.ActMod.GTabActO, A_AM.ActMod.GetAllAddTabAct["Act"]
						if istable(Gtb_1) or istable(Gtb_2) then arint(afile,"[2] Validating data table ...")
							local aaTAB,aok = { ["Act"] = {} ,["Sounds"] = {} },true
							if istable(GDfile) then arint(afile,"[3] Reading table data ...")
								for k, v in pairs(GDfile) do
									k = tostring(k) k = k:gsub("%s+$", "") k = string.lower(k)
									local kt = "amod_cumact_".. k
									if not istable(v) or table.IsEmpty(v) then arint(afile,k,"Error table Base","Errors") arint(afile,"[1][ Error ]: table Base is invalid") continue end
									if not istable(v.Config) or table.IsEmpty(v.Config) then arint(afile,k,"Error table Config","Errors") arint(afile,"[1][ Error ]: table Config is invalid") continue end
									if not isstring(v.Config.Name) then arint(afile,k,"Error Name","Errors") arint(afile,"[1][ Error ]: Name is invalid") continue end
									if not isstring(v.Config.Anim) or v.Config.Anim:gsub("%s+$", "") == "" then arint(afile,k,"Error Anim","Errors") arint(afile,"[1][ Error ]: Anim is invalid") continue end
									local vClass,itimp = (v.Config.class ~= nil and v.Config.class or v.Config.Class ~= nil and v.Config.Class),false
									arint(afile,k,"Check for mismatches with previous or basic data ...")
									if k ~= "" and A_AM.ActMod:isValidNameENR(k) and (not istable(Gtb_1) or not Gtb_1[k] and not Gtb_1[kt]) and (not istable(Gtb_2) or not Gtb_2[k] and not Gtb_2[kt]) then arint(afile,k,"[3-1] Validate table data ...")
										if (not vClass or isnumber(vClass) and (vClass == -1 or math.Clamp(vClass,1,8) > 0 and math.Clamp(vClass,1,8) < 9)) and A_AM.ActMod:isValidNameENR(k) then arint(afile,k,"[3-2] Fetching data ...")
											local itsA,itFu = false,false
											if istable(v.Config.CList) and not table.IsEmpty(v.Config.CList) and isstring(v.Config.CList.Title) and v.Config.CList.Title:gsub("%s+$", "") ~= "" then
												if not vClass then vClass = 1 end
												local IName = v.Config.CList.Title:gsub("%s+$", "")
												local tName = string.lower(IName)
												if isstring(Trr) and Trr == "Il" and Ogr then itsA = true end
												if isstring(err) and isstring(crr) and err == "authorized full lua file" and istable(A_AM.ActMod.Aadons) and table.HasValue(A_AM.ActMod.Aadons, IName) then
													itsA = true
													if v.Config.CList.OFtn then itFu = true end
													if not table.HasValue(A_AM.ActMod.Aedons,A_AM.ActMod:GUnTFt(crr)) then
														arint(afile,k,"Error file","Errors")
														arint(afile,"[1][ Error ]: Advanced table not registered")
														continue
													end
												end
												if not itsA and table.HasValue(A_AM.ActMod.Aadons, IName) then
													arint(afile,k,"Error file","Errors")
													arint(afile,"[1][ Error ]: Restricted Title Content")
													continue
												end
												if itsA then itimp = true end
												if itFu then
													if not istable(A_AM.ActMod.TDCustom[40]) then
														A_AM.ActMod.TDCustom[40] = { t = "ActMod Commission Hub" }
													end
													vClass = vClass + 40
													if A_AM.ActMod.TDCustom[40].N then
														if not table.HasValue(A_AM.ActMod.TDCustom[40].N , vClass) then
															table.insert(A_AM.ActMod.TDCustom[40].N , vClass)
														end
													else
														A_AM.ActMod.TDCustom[40].N = {vClass}
													end
													if isfunction(v.Scrpt) then
														local goT, GScrpt = pcall(v.Scrpt)
														if goT and istable(GScrpt) then
															if not A_AM.ActMod.GetAllAddTabAct.Scrpts then A_AM.ActMod.GetAllAddTabAct.Scrpts = {} end
															A_AM.ActMod.GetAllAddTabAct.Scrpts[kt] = {}
															if isfunction(GScrpt.SCpt) or isstring(GScrpt.SCpt) then A_AM.ActMod.GetAllAddTabAct.Scrpts[kt].F_S = GScrpt.SCpt end
															if isfunction(GScrpt.SDrw) or isstring(GScrpt.SDrw) then A_AM.ActMod.GetAllAddTabAct.Scrpts[kt].F_D = GScrpt.SDrw end
															if isfunction(GScrpt.SDrwO) or isstring(GScrpt.SDrwO) then A_AM.ActMod.GetAllAddTabAct.Scrpts[kt].F_DO = GScrpt.SDrwO end
															arint(afile,k,"[3-2]( Scrpt )> Done")
														end
													end
												else
													local tthr
													for i,n in pairs(A_AM.ActMod.TDCustom) do if isstring(n.t) and n.t == IName then tthr = i break end end
													if isnumber(tthr) and istable(A_AM.ActMod.TDCustom[tthr]) then
														if not istable(A_AM.ActMod.TDCustom[tthr].b) then A_AM.ActMod.TDCustom[tthr].b = {} end
														if not istable(A_AM.ActMod.TDCustom[tthr].c) then A_AM.ActMod.TDCustom[tthr].c = {} end
														if A_AM.ActMod.TDCustom[tthr].N then
															if not table.HasValue(A_AM.ActMod.TDCustom[tthr].N , vClass) then table.insert(A_AM.ActMod.TDCustom[tthr].N , vClass) end
														else
															A_AM.ActMod.TDCustom[tthr].N = {vClass}
														end
														vClass = vClass + tthr
														if isstring(v.Config.CList.Icon) and not A_AM.ActMod.TDCustom[tthr].i then A_AM.ActMod.TDCustom[tthr].i = v.Config.CList.Icon end
														if isstring(v.Config.CList.Background) and not A_AM.ActMod.TDCustom[tthr].b[vClass] then A_AM.ActMod.TDCustom[tthr].b[vClass] = v.Config.CList.Background end
														if IsColor(v.Config.CList.BColor) and not A_AM.ActMod.TDCustom[tthr].c[vClass] then A_AM.ActMod.TDCustom[tthr].c[vClass] = v.Config.CList.BColor end
													else
														local tll = A_AM.ActMod:GetNumMax(A_AM.ActMod.TDCustom,true,false)
														if not isnumber(tll) or tll < 30 then tll = 70 else tll = tll + 10 end
														if not istable(A_AM.ActMod.TDCustom[tll]) then
															A_AM.ActMod.TDCustom[tll] = { t = IName ,N = {vClass} ,b = {} ,c = {} }
															vClass = vClass + tll
															if isstring(v.Config.CList.Icon) then A_AM.ActMod.TDCustom[tll].i = v.Config.CList.Icon end
															if isstring(v.Config.CList.Background) then A_AM.ActMod.TDCustom[tll].b[vClass] = v.Config.CList.Background end
															if IsColor(v.Config.CList.BColor) then A_AM.ActMod.TDCustom[tll].c[vClass] = v.Config.CList.BColor end
														else
															arint(afile,k,"Error file","Errors")
															arint(afile,"[1][ Error ]: Error creating table (Table exists but is suspicious)")
															continue
														end
													end
												end
											end
											local ATab,STab = { ID_ACT = k ,NoStop = 4 ,RNAnim = v.Config.Anim ,RNAnim_RDuration = true ,GetName = v.Config.Name ,class = (isnumber(vClass) and vClass or 1) },{}
											if isbool(v.Config.DontAllowAng) then ATab.DontAlwAng = v.Config.DontAllowAng end
											if istable(A_AM.ActMod.tmpE) then A_AM.ActMod.tmpE[k] = {kt,v.Config.Name} end
											if isbool(v.Config.isNew) and v.Config.isNew then A_AM.ActMod.ActNewVCustom[k] = {kt,v.Config.Name} elseif A_AM.ActMod.ActNewVCustom[k] then A_AM.ActMod.ActNewVCustom[k] = nil end
											if istable(v.About) and isstring(v.About.Author) and v.About.Author:gsub("%s+$", "") ~= "" then
												local tName = string.lower(v.About.Author:gsub("%s+$", ""))
												if itimp or tName ~= "ahmedmake400" and not string.find(tName,"ahmedmake400") and tName ~= "am4" then
													ATab.About = { Author = v.About.Author:gsub("%s+$", "") }
													if isstring(v.About.S64) and v.About.S64:gsub("%s+$", "") ~= "" and string.sub(v.About.S64,1,1) ~= "0" then
														local tnum = tonumber(v.About.S64)
														if isnumber(tnum) and tnum > 0 and (itimp or v.About.S64 ~= "76561199185837385") then
															ATab.About.S64 = v.About.S64
														end
													end
													if isstring(v.About.Version) then
														if A_AM.ActMod:IsNumbersOnly(v.About.Version) then
															ATab.About.Version = string.sub(v.About.Version,1,5)
														else
															local tnum = tonumber(v.About.Version)
															if isnumber(tnum) then ATab.About.Version = tostring(string.sub(tostring(tnum),1,5)) end
														end
													elseif isnumber(v.About.Version) then
														ATab.About.Version = tostring(string.sub(tostring(v.About.Version),1,5))
													end
												end
											end
											if istable(v.Flex) then
												if isstring(v.Flex.Path) and v.Flex.Path ~= "" then
													A_AM.ActMod.TablsAFlexs[kt] = {Path = v.Flex.Path}
													local fps,adds
													if isnumber(v.Flex.SetFPS) then A_AM.ActMod.TablsAFlexs[kt].fps = v.Flex.SetFPS end
													if isnumber(v.Flex.AddSpace) and v.Flex.AddSpace ~= 0 then A_AM.ActMod.TablsAFlexs[kt].adds = -v.Flex.AddSpace end
													arint(afile,k,"[3-2]( Flex )> Done")
												else
													arint(afile,k,"[3-2]( Flex )> Filed")
												end
											end
											if v.Config.Infinity then ATab.NoStop = 0 end
											if v.Config.Gesture then
												ATab.NoStop = 63
												if istable(v.Gesture) then
													if isnumber(v.Gesture.In) then ATab.G_In = v.Gesture.In end
													if isnumber(v.Gesture.Out) then ATab.G_Out = v.Gesture.Out end
													if isnumber(v.Gesture.TimeEnd) then ATab.G_TEnd = v.Gesture.TimeEnd end
													if isnumber(v.Gesture.Rate) then ATab.G_Rate = v.Gesture.Rate end
													if isnumber(v.Gesture.Cycle) then ATab.G_Cycle = v.Gesture.Cycle end
													if isnumber(v.Gesture.Weight) then ATab.G_Weight = v.Gesture.Weight end
												end
												if not table.IsEmpty(ATab) then
													aaTAB["Act"][kt] = ATab 
													arint(afile,k,"[3-3]( Act <Gesture> )> Done")
												else
													arint(afile,k,"[3-3]( Act <Gesture> )> Filed")
													arint(afile,k,"[-][Failed to include]: ".. k)
												end
												continue
											end
											if isnumber(v.Config.Duration) and v.Config.Duration > 0 then ATab["time"] = v.Config.Duration end
											if isnumber(v.Config.Cycle) then ATab["Cycle"] = v.Config.Cycle end
											if isnumber(v.Config.Rate) then ATab["Rate"] = v.Config.Rate end
											if istable(v.Camera) then
												if v.Camera.Follow then ATab["CamParent"] = v.Camera.Follow end
												if isnumber(v.Camera.Transition) then ATab["CamInLerp"] = v.Camera.Transition end
											end
											if istable(v.Custom) then
												local tTab = {}
												local GTab = istable(v.Custom.Anim) and v.Custom.Anim
												if GTab then
													if isnumber(GTab["Time1"]) then tTab["A_Time1"] = GTab["Time1"] end
													if isnumber(GTab["Time2"]) then tTab["A_Time2"] = GTab["Time2"] end
													if isnumber(GTab["Cycle"]) then tTab["A_Cycle"] = GTab["Cycle"] end
												end
												local GTab = istable(v.Custom.Sound) and v.Custom.Sound
												if GTab then
													if isnumber(GTab["Time1"]) then tTab["S_Time1"] = GTab["Time1"] end
													if isnumber(GTab["Time2"]) then tTab["S_Time2"] = GTab["Time2"] end
												end
												if not table.IsEmpty(tTab) then
													local CSTab,aaok = {},false
													if tTab["A_Time1"] or tTab["A_Time2"] or tTab["A_Cycle"] then
														CSTab["C_Anim"] = { ["Time1"] = tTab["A_Time1"] ,["Time2"] = tTab["A_Time2"] ,["Cycle"] = tTab["A_Cycle"] }
														aaok = true
													end
													if tTab["S_Time1"] or tTab["S_Time2"] then
														CSTab["C_Sound"] = { ["Time1"] = tTab["S_Time1"] ,["Time2"] = tTab["S_Time2"] }
														aaok = true
													end
													if aaok then
														arint(afile,k,"[3-2]>(Custom)> Done")
														ATab["C_"] = CSTab
														ATab["NoStop"] = 9
													else
														arint(afile,k,"[3-2]>(Custom)> failure")
													end
												end
											else
												if v.Config.Repeat and ATab["NoStop"] == 4 then
													ATab["NoStop"] = nil
													ATab["AutoReAnim"] = true
												end
											end
											
											if ATab["NoStop"] == 4 and not v.Config.Repeat then
												ATab["NoStop"] = nil
												ATab["noRAgain"] = true
											end
											
											if istable(v.Movement) then
												if isnumber(v.Movement.Type) and isnumber(v.Movement.Speed) then
													arint(afile,k,"[3-2]>(Movement)> Done")
													local GTab = v.Movement
													local tt_MoveDir = math.Clamp(math.Round(GTab.Type),1,3)
													ATab["MoveDir"] = tt_MoveDir == 3 and 5 or tt_MoveDir
													ATab["MoveSpeed"] = GTab.Speed
													if not A_AM.ActMod.GTabActWlk[kt] and GTab.Motion and tt_MoveDir == 3 and GTab.Motion.Walk and GTab.Motion.Static then
														local awalk,astatic = GTab.Motion.Walk,GTab.Motion.Static
														if (isstring(awalk) or istable(awalk)) and (isstring(astatic) or istable(astatic)) then
															if isstring(awalk) then awalk = awalk:gsub("%s+$", "") end
															if isstring(astatic) then astatic = astatic:gsub("%s+$", "") end
															if (isstring(awalk) and awalk ~= "" or istable(awalk) and awalk.Anim) and (isstring(astatic) and astatic ~= "" or istable(astatic) and astatic.Anim) then
																A_AM.ActMod.GTabActWlk[kt] = { static = astatic ,walk = awalk }
																ATab["AalowAnim"] = true
															end
														end
													end
												else
													arint(afile,k,"[3-2]>(Movement)> failure")
												end
											end
											if istable(v.Coop) then
												if not A_AM.ActMod.GTabActCoop[kt] then
													local GTab = v.Coop
													A_AM.ActMod.GTabActCoop[kt] = {
														["ani_pl1"] = GTab.OtherAnim or kt
														,["ani_pl2"] = isstring(GTab.YourAnim) and GTab.YourAnim:gsub("%s+$", "") ~= "" and string.lower(GTab.YourAnim) or nil
														,["rP1"] = GTab.ReplaySelf
														,["NoRepetition"] = GTab.NoRepetition
														,["Sync"] = GTab.Sync
														,["SoundOne"] = true
														,["joining"] = true
														,["AlPly"] = isnumber(GTab.MaxPlayers) and GTab.MaxPlayers > 0 and GTab.MaxPlayers or nil
														,["MaxDistance"] = GTab.MaxDist
													}
													if GTab.Reverse or GTab.Forward or GTab.Right or istable(GTab.TryFixPos) then
														A_AM.ActMod.GTabActCoop[kt].rPos = GTab.RPos == nil and true or GTab.RPos
														A_AM.ActMod.GTabActCoop[kt].rAng = GTab.RAng == nil and true or GTab.RAng
														if GTab.Reverse then A_AM.ActMod.GTabActCoop[kt].r180 = GTab.Reverse end
														if isnumber(GTab.Forward) then A_AM.ActMod.GTabActCoop[kt].Forward = GTab.Forward end
														if isnumber(GTab.Right) then A_AM.ActMod.GTabActCoop[kt].Right = GTab.Right end
														if isnumber(GTab.AddAngY_You) then A_AM.ActMod.GTabActCoop[kt].AddAngY_P1 = GTab.AddAngY_You end
														if isnumber(GTab.AddAngY_Other) then A_AM.ActMod.GTabActCoop[kt].AddAngY_P2 = GTab.AddAngY_Other end
														if GTab.Ang_OToY then A_AM.ActMod.GTabActCoop[kt].Ang_2To1 = GTab.Ang_OToY end
														if istable(GTab.TryFixPos) and A_AM.ActMod.GTabActCoop[kt]["AlPly"] and A_AM.ActMod.GTabActCoop[kt]["AlPly"] == 1 then
															A_AM.ActMod.GTabActCoop[kt].joining = nil
															A_AM.ActMod.GTabActCoop[kt].TryFixPos = GTab.TryFixPos
														end
													end
													if GTab.SoundOther then
														A_AM.ActMod.GTabActCoop[kt].SoundOne = nil
														A_AM.ActMod.GTabActCoop[kt].OnSound = true
														A_AM.ActMod.GTabActCoop[kt].all_stop = true
														A_AM.ActMod.GTabActCoop[kt].so_2 = true
													end
													arint(afile,k,"[3-2]>(Coop)> Done")
												else
													arint(afile,k,"[3-2]>(Coop)> failure  (No duplication allowed)")
												end
											end
											if false and istable(v.Sounds) and istable(v.Sounds.Start) and isstring(v.Sounds.Start.Sound) then
												local tTab = {}
												local GTab = v.Sounds.Start
												if GTab then
													tTab["1_sound"] = GTab["Sound"]
													if isnumber(GTab["Delay"]) then tTab["1_Dtime"] = GTab["Delay"] end
												end
												local GTab = istable(v.Sounds.StartExtra) and v.Sounds.StartExtra
												if GTab then
													if isstring(GTab["Sound"]) then tTab["2_sound"] = GTab["Sound"] end
													if isnumber(GTab["Delay"]) then tTab["2_Dtime"] = GTab["Delay"] end
												end
												local GTab = istable(v.Sounds.Repeat) and v.Sounds.Repeat
												if GTab then
													if isstring(GTab["Sound"]) then tTab["3_sound"] = GTab["Sound"] end
													if isnumber(GTab["Delay"]) then tTab["3_Dtime"] = GTab["Delay"] end
												end
												if not table.IsEmpty(tTab) then
													arint(afile,k,"[3-2]>(Sounds)> Done")
													if tTab["2_sound"] and tTab["3_sound"] then
														STab = { {tTab["2_sound"]},tTab["2_Dtime"] ,{tTab["3_sound"]},tTab["3_Dtime"] ,{tTab["1_sound"]},tTab["1_Dtime"] }
													elseif tTab["3_sound"] then
														STab = { {tTab["1_sound"]},tTab["1_Dtime"] ,{tTab["3_sound"]},tTab["3_Dtime"] }
													else
														STab = { {tTab["1_sound"]},tTab["1_Dtime"] }
													end
												else
													arint(afile,k,"[3-2]>(Sounds)> failure")
												end
											end
											if istable(v.Sounds) then
												local TypTabSnds = A_AM.ActMod:GetTableKeyType(v.Sounds)
												if TypTabSnds == "number_keys" then
													local tTab,cTab = {},{}
													for _,vT in ipairs(v.Sounds) do
														if istable(vT) then
															local ggg,tTiSnds = aaGetTaDaSnds(k,vT,true)
															if istable(ggg) then
																table.insert(tTab,ggg)
																if istable(tTiSnds) and not table.IsEmpty(tTiSnds) then table.insert(cTab,tTiSnds) end
															end
														end
													end
													if not table.IsEmpty(tTab) then
														STab.ts = tTab
														if not istable(ATab.SndsC_) then ATab.SndsC_ = {} end
														if not table.IsEmpty(cTab) then ATab.SndsC_.t = cTab end
														ATab.SndsC_.n = #tTab
														arint(afile,k,"[3-2]>(Sounds)> Done")
													else
														arint(afile,k,"[3-2]>(Sounds)> failure")
													end
												else
													local ggg = aaGetTaDaSnds(k,v.Sounds,true)
													if istable(ggg) and not table.IsEmpty(ggg) then
														STab = ggg
														arint(afile,k,"[3-2]>(Sounds)> Done")
													else
														arint(afile,k,"[3-2]>(Sounds)> failure")
													end
												end
											end
											if istable(v.Models) and not table.IsEmpty(v.Models) then
												local GTab,n_i,taddok = v.Models,0,false
												for i = 1,4 do
													if istable(GTab[i]) and not table.IsEmpty(GTab[i]) and isstring(GTab[i].Model) then
														if not ATab["TabInclusion"] or not ATab["TabInclusion"]["Models"] then ATab["TabInclusion"] = { ["Models"] = {} } end
														n_i = n_i + 1
														local Tab_pos,Tab_ang,TBone = {0,0,0},{0,0,0},false
														if isstring(GTab[i].Bone) then TBone = true end
														if istable(GTab[i]["Vector"]) and isnumber(GTab[i]["Vector"][1]) then Tab_pos[1] = GTab[i]["Vector"][1] end
														if istable(GTab[i]["Vector"]) and isnumber(GTab[i]["Vector"][2]) then Tab_pos[2] = GTab[i]["Vector"][2] end
														if istable(GTab[i]["Vector"]) and isnumber(GTab[i]["Vector"][3]) then Tab_pos[3] = GTab[i]["Vector"][3] end
														if istable(GTab[i]["Angle"]) and isnumber(GTab[i]["Angle"][1]) then Tab_ang[1] = GTab[i]["Angle"][1] end
														if istable(GTab[i]["Angle"]) and isnumber(GTab[i]["Angle"][2]) then Tab_ang[2] = GTab[i]["Angle"][2] end
														if istable(GTab[i]["Angle"]) and isnumber(GTab[i]["Angle"][3]) then Tab_ang[3] = GTab[i]["Angle"][3] end
														ATab["TabInclusion"]["Models"][n_i] = {
															["v_mdl"] = n_i
															,["model"] = GTab[i].Model
															,["Material"] = isstring(GTab[i].Material) and GTab[i].Material or nil
															,["TypAtta"] = TBone and 3 or -1
															,["LookupBone"] = TBone and GTab[i].Bone or nil
															,["Vector"] = GTab[i].AVector or Vector()
															,["pos_F"] = Tab_pos[1] ,["pos_R"] = Tab_pos[2] ,["pos_U"] = Tab_pos[3]
															,["Angle"] = GTab[i].AAngle or Angle()
															,["ang_p"] = Tab_ang[1] ,["ang_y"] = Tab_ang[2] ,["ang_r"] = Tab_ang[3]
															,["Size"] = isnumber(GTab[i].Size) and GTab[i].Size or nil
															,["Skin"] = isnumber(GTab[i].Skin) and GTab[i].Skin or nil
															,["Bodygroup"] = istable(GTab[i].Bodygroup) and GTab[i].Bodygroup or nil
															,["NAtosize"] = GTab[i].AutoSize or false
														}
														taddok = true
													end
												end
												if taddok then
													arint(afile,k,"[3-2]>(Models)> Done")
												else
													arint(afile,k,"[3-2]>(Models)> failure")
												end
											end
										
											if not table.IsEmpty(ATab) then
												aaTAB["Act"][kt] = ATab 
												arint(afile,k,"[3-3]( Act )> Done")
												if not table.IsEmpty(STab) and A_AM.ActMod.GetAllAddTabAct["Sounds"] and not A_AM.ActMod.GetAllAddTabAct["Sounds"][kt] then
													aaTAB["Sounds"][kt] = STab
													arint(afile,k,"[3-3]( Sounds )> Done")
												else
													arint(afile,k,"[3-3]( Sounds )> Filed")
												end
											else
												arint(afile,k,"[3-3]( Act )> Filed")
												arint(afile,k,"[-][Failed to include]: ".. k)
											end
										else
											arint(afile,k,"Error in Table","Errors")
											arint(afile,k,"[-][Error]: The data is invalid or incorrect.")
										end
									else
										if k == "" or not A_AM.ActMod:isValidNameENR(k) then
											arint(afile,k,"Error name","Errors")
											arint(afile,k,"[-][Error]: Invalid name")
										elseif Gtb_1[k] or Gtb_1[kt] or Gtb_2[k] or Gtb_2[kt] then
											arint(afile,k,"Repetition","Errors")
											arint(afile,k,"[-][Error]: Replacement not allowed")
										else
											arint(afile,k,"Error unknown","Errors")
											arint(afile,k,"[-][Error]: unknown")
										end
									end
								end
							end
							arint(afile,"[4]  | ".. tostring(aaTAB) .." | ".. tostring(not table.IsEmpty(aaTAB)))
							if not table.IsEmpty(aaTAB) then
								table.Merge( A_AM.ActMod.GetAllAddTabAct, aaTAB )
								arint(afile,"[5][ Finished reading successfully ]")
							else
								arint(afile,nil,"Error in save Table","Errors")
								arint(afile,"[5][ Error ]: Embedding not completed")
							end
						end
					else
						arint(afile,k,"Error file","Errors")
						arint(afile,"[1][ Error ]: The file does not contain a table or the table is invalid")
					end
				else
					arint(afile,k,err,"Errors")
				end
			elseif not ata and ok then
				A_AM.ActMod:Chfg("actmod/am_animc/".. afile,nil,true)
			end
		else
			arint(afile,k,"file not lua","Errors")
		end
	end
end
if SERVER then AA_JetAllAddTabCAct() end

if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaAct = true

local function aDist(pl,taa)
	if pl == LocalPlayer() or LocalPlayer():GetPos():Distance(pl:GetPos()) < taa then
		return true
	end
	return false
end

local function AA_AdModelSet( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4 )
	if SERVER then
		net.Start("A_AM.ActMod.SvToCl_Tab") net.WriteTable( {"ActMod.AddMdl",ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4} ) net.Broadcast()
	else
		A_AM.ActMod:AddCrMdl(ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4)
	end
end

local function AA_AdModelRemov( ply,txt )
	if SERVER then
		net.Start("A_AM.ActMod.SvToCl_Tab") net.WriteTable( {"ActMod.AddRemove",ply,txt} ) net.Broadcast()
	else
		A_AM.ActMod:RemoveCrMdl( ply,txt )
	end
end

function A_AM.ActMod:GetSubModelsFor(modelPath)
	if not isstring(modelPath) or modelPath == "" then return {} end
	local ent
	if SERVER then
		ent = ents.Create("base_anim")
		ent:SetModel(modelPath)
	else
		ent = ClientsideModel(modelPath, RENDERGROUP_OTHER)
	end
	if not IsValid(ent) then return {} end
	ent:DrawShadow( false ) ent:SetNoDraw( true )
	local success, result = pcall(function() return ent:GetSubModels() or {} end)
	ent:Remove()
	return success and result or {}
end


function A_AM.ActMod:AA_SubMF( ply,mf,useout )
	mf = string.lower(tostring(mf)) or "m"
	local Tabmdl = {}
	if IsValid(ply) then
		if not useout and ply.aenforce_model and ply.aenforce_model ~= "" then
			Tabmdl = A_AM.ActMod:GetSubModelsFor(ply.aenforce_model)
			if not istable(Tabmdl) or table.IsEmpty(Tabmdl) or not Tabmdl[1] or not Tabmdl[1]["name"] then Tabmdl = ply:GetSubModels() end
		else
			Tabmdl = ply:GetSubModels()
		end
	else
		Tabmdl = A_AM.ActMod:GetSubModelsFor(tostring(ply))
	end
	if Tabmdl and Tabmdl[1] and Tabmdl[1]["name"] then
		if mf == "f" and Tabmdl[1]["name"] == "models/f_anm.mdl" then
			return true
		elseif mf == "m" and Tabmdl[1]["name"] == "models/m_anm.mdl" then
			return true
		end
	end
	return false
end

local function CrMdl(ply,mdl_,mat_,UseAtta_,attm_ ,pos_,pfo_,prl_,pup_ ,ang_,anp_,any_,anr_ ,size_,NAtosize,TabScrpt,TimeRemove,Scolr_,Skin_,Bodygroup_)
	local Tmdl = {}
	if istable(ply) then
		Tmdl["mdl"] = ply[2] or "models/props_junk/TrafficCone001a.mdl"
		Tmdl["Mat"] = ply[3] or nil
		Tmdl["SColor"] = ply[18] or nil
		Tmdl["TypAtta"] = ply[4] or 1
		Tmdl["attm"] = ply[5] or "ValveBiped.Bip01_R_Hand"
		Tmdl["pos"] = ply[6] or Vector(0,0,0)
		Tmdl["pos_fo"],Tmdl["pos_ri"],Tmdl["pos_up"] = ply[7] or 0 ,ply[8] or 0 ,ply[9] or 0 
		Tmdl["ang"] = ply[10] or Angle(0,0,0)
		Tmdl["ang_p"],Tmdl["ang_y"],Tmdl["ang_r"] = ply[11] or 0 ,ply[12] or 0 ,ply[13] or 0
		Tmdl["size"] = ply[14] or 1
		Tmdl["NAtosize"] = ply[15] or false
		Tmdl["TabScrpt"] = ply[16] or {}
		Tmdl["TimeRemove"] = ply[17]
		Tmdl["Skin"] = ply[19]
		Tmdl["BGrp"] = ply[20]
	else
		Tmdl["mdl"] = mdl_ or "models/props_junk/TrafficCone001a.mdl"
		Tmdl["Mat"] = mat_ or nil
		Tmdl["SColor"] = Scolr_ or nil
		Tmdl["TypAtta"] = UseAtta_ or 1
		Tmdl["attm"] = attm_ or "ValveBiped.Bip01_R_Hand"
		Tmdl["pos"] = pos_ or Vector(0,0,0)
		Tmdl["pos_fo"],Tmdl["pos_ri"],Tmdl["pos_up"] = pfo_ or 0 ,prl_ or 0 ,pup_ or 0 
		Tmdl["ang"] = ang_ or Angle(0,0,0)
		Tmdl["ang_p"],Tmdl["ang_y"],Tmdl["ang_r"] = anp_ or 0 ,any_ or 0 ,anr_ or 0
		Tmdl["size"] = size_ or 1
		Tmdl["NAtosize"] = NAtosize or false
		Tmdl["TabScrpt"] = TabScrpt or {}
		Tmdl["TimeRemove"] = TimeRemove
		Tmdl["Skin"] = Skin_
		Tmdl["BGrp"] = Bodygroup_
	end
	return Tmdl
end
function A_AM.ActMod:AA_functOther( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4,CFuncton )
	local md_1,md_2,md_3,md_4
	if Strg and A_AM.ActMod.GTabActO[Strg] and A_AM.ActMod.GTabActO[Strg]["TabInclusion"] and istable(A_AM.ActMod.GTabActO[Strg]["TabInclusion"]) then
		local BastTab = A_AM.ActMod.GTabActO[Strg]["TabInclusion"]
		if BastTab["Models"] and istable(BastTab["Models"]) then
			for k, vTab in pairs( BastTab["Models"] ) do
				local v_mdl = vTab["v_mdl"]
				if istable(vTab) and isnumber(v_mdl) then
					local Tab = vTab
					if Tab["model"] and isstring(Tab["model"]) then
						local mat_,Scolr_,UseAtta_,attm_ ,pos_,pfo_,prl_,pup_ ,ang_,anp_,any_,anr_ ,size_,NAtosize,TabScrpt,TimeRemove,skin_,bgrp_
						if Tab["Material"] then mat_ = Tab["Material"] end
						if Tab["SColor"] then Scolr_ = Tab["SColor"] end
						if Tab["TypAtta"] then UseAtta_ = Tab["TypAtta"] end
						if Tab["LookupBone"] then attm_ = Tab["LookupBone"] end
						if Tab["Vector"] then pos_ = Tab["Vector"] end
						if Tab["pos_F"] then pfo_ = Tab["pos_F"] end  if Tab["pos_R"] then prl_ = Tab["pos_R"] end  if Tab["pos_U"] then pup_ = Tab["pos_U"] end
						if Tab["Angle"] then ang_ = Tab["Angle"] end
						if Tab["ang_p"] then anp_ = Tab["ang_p"] end  if Tab["ang_y"] then any_ = Tab["ang_y"] end  if Tab["ang_r"] then anr_ = Tab["ang_r"] end
						if Tab["Size"] then size_ = Tab["Size"] end
						if Tab["Skin"] then skin_ = Tab["Skin"] end
						if Tab["Bodygroup"] then bgrp_ = Tab["Bodygroup"] end
						if Tab["NAtosize"] then NAtosize = Tab["NAtosize"] end
						if Tab["TimeRemove"] then TimeRemove = Tab["TimeRemove"] end
						if Tab["TabScrpt"] then TabScrpt = Tab["TabScrpt"] end
						local aa = {ply,Tab["model"],mat_,UseAtta_,attm_, pos_,pfo_,prl_,pup_, ang_,anp_,any_,anr_ ,size_,NAtosize,TabScrpt,TimeRemove,Scolr_,skin_,bgrp_}
						if v_mdl == 1 then md_1 = CrMdl(aa) elseif v_mdl == 2 then md_2 = CrMdl(aa) elseif v_mdl == 3 then md_3 = CrMdl(aa) elseif v_mdl == 4 then md_4 = CrMdl(aa) end
					end
				end
			end
		end
	end
	CFuncton(md_1,md_2,md_3,md_4)
end
local function AA_functOther( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4,CFuncton )
	A_AM.ActMod:AA_functOther( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4,CFuncton )
end

function A_AM.ActMod:AA_AddModel( ply,strg,agin )
	local Strg = strg or ply:GetNWString("A_ActMod.Dir", "") or ""
	if string.find(string.sub(Strg,0 ,2), "f_") and !string.find(Strg, "amod") then Strg = string.Replace(Strg,"f_","") end
	if timer.Exists( "A_AM.Mdl_1"..ply:EntIndex() ) then timer.Remove( "A_AM.Mdl_1"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Mdl_2"..ply:EntIndex() ) then timer.Remove( "A_AM.Mdl_2"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Mdl_3"..ply:EntIndex() ) then timer.Remove( "A_AM.Mdl_3"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Mdl_4"..ply:EntIndex() ) then timer.Remove( "A_AM.Mdl_4"..ply:EntIndex() ) end
	local Tmd1,Tmd2,Tmd3,Tmd4 = {},{},{},{}

	if Strg == "epic_sax_guy" then
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") then local hmax = A_AM.ActMod:HMX( ply ) Tmd1 = CrMdl(ply,"models/actmod/mdl_sax.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,-1,-2,-hmax[4]*0.5+hmax[5]*0.1, nil,0,-160,-190 ,0.65,true) end
	elseif Strg == "rock_guitar" then
		if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd1 = CrMdl(ply,"models/actmod/guitar_metal.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,2.5,5,-2.5, nil,70,60,-16 ,0.7,true) end
	elseif Strg == "amod_fortnite_glowstickdance" then
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") then Tmd1 = CrMdl(ply,"models/actmod/mdl_stick.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,-0.5,1.6,2, nil,4,-75,15 ,0.7,true) end
		if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd2 = CrMdl(ply,"models/actmod/mdl_stick.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,-0.5,1.5,-3.5, nil,4,75,15 ,0.7,true) end
	elseif Strg == "amod_fortnite_cheerleader" then
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") then Tmd1 = CrMdl(ply,"models/actmod/mdl_shrub.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,0,2,3, nil,0,90,0 ,0.4,true) end
		if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd2 = CrMdl(ply,"models/actmod/mdl_shrub.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,0,2,3, nil,0,90,0 ,0.4,true) end
	elseif Strg == "touchdown_dance" then
		if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd1 = CrMdl(ply,"models/actmod/mdl_afootball.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,5,3,-5, nil,0,0,0 ,1)
			timer.Create("A_AM.Mdl_1"..ply:EntIndex(),0.935,1,function() if IsValid( ply ) then
				local ef_ = EffectData()
				ef_:SetOrigin( ply:GetPos()+ply:GetForward()*15+ply:GetRight()*5+ply:GetUp()*5 ) util.Effect("am_f_toudo_dance",ef_, true, true)
				AA_AdModelRemov( ply,"mdl1" )
			end end)
		end
	elseif Strg == "cowbell" then
		local hmax = A_AM.ActMod:HMX( ply )
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") then Tmd1 = CrMdl(ply,"models/props_phx/misc/potato_launcher.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,3,1,-hmax[2]*0.6, nil,0,20,0 ,0.15,true) end
		if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd2 = CrMdl(ply,"models/props_phx/wheelaxis.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,3.5,2,-0.5, nil,0,-10,-0 ,0.35,true) end
	elseif Strg == "make_it_rain_v2" then
		if ply:LookupBone("ValveBiped.Bip01_L_Hand") then
			if agin then
				Tmd1 = CrMdl(ply,"models/actmod/Money_v2.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,4.5,0,1.5, nil,80,15,5 ,1,true)
			else
				timer.Create("A_AM.Mdl_1"..ply:EntIndex(),0.25,1,function() if IsValid( ply ) then
					Tmd1 = CrMdl(ply,"models/actmod/Money_v2.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,4.5,0,1.5, nil,80,15,5 ,1,true)
					AA_AdModelSet( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4 )
				end end)
			end
		end
	elseif Strg == "guitar_walk" then
		if ply:LookupBone("ValveBiped.Bip01_L_Hand") then Tmd1 = CrMdl(ply,"models/actmod/guitar_metal.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,1.8,5,-2.5, nil,50,60,-46 ,0.7,true) end
	elseif Strg == "amod_fortnite_cerealbox" then
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") then
			if agin then
				Tmd1 = CrMdl(ply,"models/actmod/chocorings.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,1.6,5,-7.5, nil,0,0,20 ,0.5,true)
			else
				timer.Create("A_AM.Mdl_1"..ply:EntIndex(),0.4,1,function() if IsValid( ply ) then
					Tmd1 = CrMdl(ply,"models/actmod/chocorings.mdl",nil,0,"", nil,22,-16,-22.5, nil,90,0,90 ,0.5,true)
					AA_AdModelRemov( ply,"*" ) AA_AdModelSet( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4 )
				timer.Create("A_AM.Mdl_1"..ply:EntIndex(),1.06,1,function() if IsValid( ply ) then
					Tmd1 = CrMdl(ply,"models/actmod/chocorings.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,1.6,5,-7.5, nil,0,0,20 ,0.5,true)
					AA_AdModelRemov( ply,"*" ) AA_AdModelSet( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4 )
				end end) end end)
			end
		end
	elseif Strg == "amod_fortnite_cyclone" then
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") then
			Tmd1 = CrMdl(ply,"models/actmod/mic.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,-3.5,-1.5,-10, nil,-10,201,0 ,0.9,true)
		end
	elseif Strg == "amod_fortnite_intermission" then
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") and ply:LookupBone("ValveBiped.Bip01_L_Hand") then
			local hmax = A_AM.ActMod:CBoneAniDistance( ply ,Strg,0.10087719559669 ,"ValveBiped.Bip01_R_Hand","ValveBiped.Bip01_L_Hand" )
			if A_AM.ActMod:AA_SubMF( ply,"F" ) then
				Tmd1 = CrMdl(ply,"models/actmod/prop/banner_afk.mdl",nil,2,"ValveBiped.Bip01_R_Hand", nil,hmax*0.21,-hmax*0.51,0, Angle(-5,-7,180),nil,nil,nil ,hmax*0.052)
			else
				Tmd1 = CrMdl(ply,"models/actmod/prop/banner_afk.mdl",nil,2,"ValveBiped.Bip01_R_Hand", nil,hmax*0.19,-hmax*0.51,0, Angle(-5,-18,180),nil,nil,nil ,hmax*0.055)
			end
		end
	elseif Strg == "amod_fortnite_thrive" then
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") and ply:LookupBone("ValveBiped.Bip01_L_Hand") then
			local Bmax = A_AM.ActMod:HMX( ply )
			local hmax = Bmax[4]
			local fmax = (Bmax[2]-23.17)
			local rlmax = (Bmax[17]-28.45)
			if A_AM.ActMod:AA_SubMF( ply,"F" ) then
				Tmd1 = CrMdl(ply,"models/actmod/prop/thrive.mdl",nil,-1,"", nil,fmax*0.4,fmax*0.5-rlmax*0.3,hmax*0.015-fmax*0.3, nil,nil,nil,nil ,hmax*1.174+fmax*0.5)
			else
				Tmd1 = CrMdl(ply,"models/actmod/prop/thrive.mdl",nil,-1,"", nil,fmax*0.5,fmax*0.5-rlmax*0.4,hmax*0.01-fmax*0.3, nil,nil,nil,nil ,hmax*1.176+fmax*0.5)
			end
		end
	elseif Strg == "amod_fortnite_indigoapple" then
		if ply:LookupBone("ValveBiped.Bip01_Head1") then
			local hmax = A_AM.ActMod:HMX( ply )
			local px,py,pz = 20,10,10
			Tmd1 = CrMdl(ply,"models/actmod/propani_01.mdl",nil,-1,"", nil,2-hmax[3]*0.05,nil,nil, nil,nil,nil,nil ,1)
			Tmd2 = CrMdl(ply,"models/actmod/prop/cell_phone.mdl",nil,-2,"", nil,nil,nil,nil, nil,nil,nil,nil ,hmax[3]*0.02)
		end
	elseif Strg == "amod_fortnite_adoration" then
		if ply:LookupBone("ValveBiped.Bip01_R_Hand") and ply:LookupBone("ValveBiped.Bip01_L_Hand") then
		local aat = 13
		if agin then aat = aat-0.5 end
			timer.Create("A_AM.Mdl_1"..ply:EntIndex(),aat,1,function() if IsValid( ply ) then
				local px,py,pz = 20,10,10
			timer.Create("A_AM.Mdl_1"..ply:EntIndex(),0.1,1,function() if IsValid( ply ) then
				local px,py,pz = 0,1.7,2.2
				Tmd1 = CrMdl(ply,"models/actmod/Bow_v1.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,pz-py*2,px,py, nil,90,-10,0 ,0.8)
				local px,py,pz = -12, 0, -2.5
				Tmd2 = CrMdl(ply,"models/actmod/Arrow_v1.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,pz-py*2,px,py, nil,0,-15,-134 ,1)
				AA_AdModelSet( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4 )
			timer.Create("A_AM.Mdl_1"..ply:EntIndex(),1.8,1,function() if IsValid( ply ) then
				AA_AdModelRemov( ply,"*" )
			end end) end end) end end)
		end
	elseif Strg == "amod_fortnite_snowfall" then
		local hmax = A_AM.ActMod:HMX( ply )
		local tmin = math.max( (-15 + math.Round(hmax[2],2)) ,0)
		local fixm = math.min( (18.85 - math.Round(hmax[16],2)) ,tmin)
		Tmd1 = CrMdl(ply,"models/actmod/prop/snow_fall.mdl",nil,-1,"", nil,nil,fixm,nil, Angle(0,90,0),nil,nil,nil ,hmax[14]*0.825)
	elseif Strg == "amod_fortnite_chickenleg" then
		local dhRL = A_AM.ActMod:CBoneAniDistance( ply ,Strg,0.4 ,"ValveBiped.Bip01_R_Hand","ValveBiped.Bip01_L_Hand" )
		local dhand = A_AM.ActMod:CBoneAniDistance( ply ,Strg,0.4 ,"ValveBiped.Bip01_R_Hand","ValveBiped.Bip01_R_UpperArm" )
		local Tdmax = A_AM.ActMod:CBoneAniDistance( ply ,Strg,0.4 ,"ValveBiped.Bip01_R_Hand","Vector()" ,true )
		local Pelvis = A_AM.ActMod:CBoneAniDistance( ply ,Strg,0.4 ,"ValveBiped.Bip01_Pelvis","Vector()" ,true )["VectorUp_1-0"] or 0
		local Umax = Tdmax["VectorUp_1-0"] or 0
		if A_AM.ActMod:AA_SubMF( ply,"F" ) then
			Umax = Umax+((dhRL-21.666)*0.5)
			dhand = math.Round(dhand-15.390,3)
			Pelvis = math.Round(Pelvis-33.924610137939,5)
		else
			Umax = Umax+((dhRL-21.590)*0.5)
			dhand =  math.Round(dhand-15.637,3)
			Pelvis = math.Round(Pelvis-34.483993530273,5)
		end
		Umax = Umax+dhand*1.1
		local aa2 = math.Round(math.Clamp(Umax*0.99/Pelvis*0.1,0,Pelvis),5)
		local aZ = Umax*0.99-Pelvis*0.5
		local aF = dhand*0.9+Pelvis*0.1+aa2*1.5
		Tmd1 = CrMdl(ply,"models/actmod/prop/chicken_leg.mdl",nil,-1,"", Vector(0,0,aZ*0.8+aa2),math.Clamp(aF,-Umax*0.25,Umax*0.25),nil,nil, Angle(0,90,0),nil,nil,nil ,aZ )
		AA_AdModelSet( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4 )
	elseif Strg == "amod_fortnite_selenecobra" then
		local Tdmax = A_AM.ActMod:CBoneAniDistance( ply ,Strg,0.045945946127176 ,"ValveBiped.Bip01_R_Hand","Vector()" ,true )
		local dmax = Tdmax["t1_1"] or 0
		local dmax1 = Tdmax["VectorUp_1-2"] or 0
		local dmax2 = A_AM.ActMod:CBoneAniDistance( ply ,Strg,0.045945946127176 ,"ValveBiped.Bip01_R_Hand","ValveBiped.Bip01_R_UpperArm" ) or 0
		local addf = 0
		if A_AM.ActMod:AA_SubMF( ply,"F" ) then
			addf = dmax*0.02
			dmax = dmax*0.98
			dmax1 = dmax1-8.174
			dmax2 = dmax2-21.921
		else
			dmax1 = dmax1-8.172
			dmax2 = dmax2-20.006
			addf = math.Round(-dmax1*0.1,3)
		end
		dmax1 = math.Round(dmax1*(dmax2*0.5),3)
		Tmd1 = CrMdl(ply,"models/actmod/prop/selene_cobra.mdl",nil,-1,"", Vector(0,0,addf),dmax2*0,nil,nil, Angle(0,90,-dmax1*0.1+addf*0.2),nil,nil,nil ,dmax*0.515 )

	elseif Strg == "amod_fortnite_blazerveil" then
		local Tdmax = A_AM.ActMod:CBoneAniDistance( ply ,Strg,0.40106952190399 ,"ValveBiped.Bip01_L_Hand","Vector()" ,true )
		local dmax = Tdmax["t1_1"] or 0
		local dmax1 = Tdmax["VectorUp_1-2"] or 0
		local dmax2 = A_AM.ActMod:CBoneAniDistance( ply ,Strg,0.40106952190399 ,"ValveBiped.Bip01_R_Hand","ValveBiped.Bip01_L_Hand" ) or 0
		local dmax3 = A_AM.ActMod:C2BoneAniDistance( ply,"models/actmod/prop/blazerveil_gadget.mdl" ,Vector(0,0,0),Angle(0,0,0),aPos1,aAng ,Strg,"BlazerVeil",0.40106952190399 ,"ValveBiped.Bip01_L_Hand","JNT_safe" ,nil,nil ,nil,nil,nil )
		if A_AM.ActMod:AA_SubMF( ply,"F" ) then
			dmax = dmax-54.14796921063
			dmax1 = dmax1-11.865662958369
			dmax2 = dmax2-28.302803369083
			dmax3 = dmax3-18.348118781569
		else
			dmax = dmax-54.40482445569
			dmax1 = dmax1-10.337544456625
			dmax2 = dmax2-29.148667632198
			dmax3 = dmax3-19.420268990608
		end
		local dmax1_t = math.Round(dmax*0.3,5)
		dmax = math.Round(dmax,5)
		dmax1 = math.Round(dmax1*0.015,5)
		dmax2 = math.Round(-dmax2*0.0,5)
		dmax3 = math.Round(-dmax3*1,5)
		Tmd1 = CrMdl(ply,"models/actmod/prop/blazerveil_gadget.mdl",nil,-1,"", Vector(0,0,0),0,0,nil, Angle(0,0,0),nil,nil,nil ,1+dmax1 )
		Tmd2 = CrMdl(ply,"models/actmod/prop/blazerveil_remote.mdl",nil,3,"ValveBiped.Bip01_R_Hand", Vector(0,0,0),-4.5,1.5,-1.5, Angle(0,0,0),-90,-20,180 ,1+dmax1 )
		
	elseif Strg == "amod_fortnite_iconic" then
		local hmax = A_AM.ActMod:CBoneAniDistance( ply,Strg,0.16702702641487,"ValveBiped.Bip01_Pelvis","Vector()" )
		local hfot = A_AM.ActMod:CBoneAniDistance( ply,Strg,0.16702702641487,"ValveBiped.Bip01_R_Foot","Vector()" )
		if A_AM.ActMod:AA_SubMF( ply,"F" ) then hmax = hmax*1.1 hfot = hfot*0.9 end
		Tmd1 = CrMdl(ply,"models/actmod/prop/chair_talk.mdl",nil,-1,"", Vector(0,0,-hmax*0.02),-hfot*0.3,nil,nil, Angle(0,180,0),nil,nil,nil ,hmax*0.038)
	elseif Strg == "amod_fortnite_chairtime" then
		local hmax = A_AM.ActMod:CBoneAniDistance( ply,Strg,0.26432433724403,"ValveBiped.Bip01_Pelvis","Vector()" )
		local hfot = A_AM.ActMod:CBoneAniDistance( ply,Strg,0.26432433724403,"ValveBiped.Bip01_R_Foot","Vector()" )
		if A_AM.ActMod:AA_SubMF( ply,"F" ) then hmax = hmax*1.03 hfot = hfot*0.9 end
		Tmd1 = CrMdl(ply,"models/actmod/propani_01.mdl",nil,-1,"", nil,hfot*0.0,nil,nil, nil,nil,nil,nil ,1)
		Tmd2 = CrMdl(ply,"models/actmod/prop/chair_talk.mdl",nil,-2,"", nil,nil,nil,nil, nil,nil,nil,nil ,hmax*0.038)
	elseif Strg == "amod_fortnite_hoist" then
		local hmax = A_AM.ActMod:HMX( ply )
		Tmd1 = CrMdl(ply,"models/actmod/prop/gadgets_hoist.mdl",nil,-1,"", Vector(0,0,hmax[4]*1.18),nil,nil,nil, Angle(0,90,0),nil,nil,nil ,1+(hmax[2]-23.17)*0.01,true)
	elseif Strg == "amod_fortnite_abstractmirror" then
		local hmax = A_AM.ActMod:HMX( ply )
		local px,py,pz = hmax[2]*0.13,hmax[6]*0.035,hmax[6]*0.095
		Tmd1 = CrMdl(ply,"models/actmod/prop/abstract_mirror.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,pz-py*2,px,py, nil,-10,-10,45 ,1,true)
	elseif Strg == "amod_fortnite_epicsaxguy" then
		if A_AM.ActMod:AA_SubMF( ply,"F" ) then
			Tmd1 = CrMdl(ply,"models/actmod/prop/sm_epic_sax.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,0,-4.5,4.3, nil,-25,180,90 ,1,true)
		else
			Tmd1 = CrMdl(ply,"models/actmod/prop/sm_epic_sax.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,1,-3.5,5.5, nil,-24,180,110 ,1,true)
		end
	elseif Strg == "amod_am4_epicsaxguy" then
		local hmax = A_AM.ActMod:HMX( ply )
		if A_AM.ActMod:AA_SubMF( ply,"F" ) then
			Tmd1 = CrMdl(ply,"models/actmod/mdl_sax.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,-0.8,-3.2,(1-hmax[4]*0.5+hmax[5]*0.1), nil,-10,-175,140 ,0.65,true)
		else
			Tmd1 = CrMdl(ply,"models/actmod/mdl_sax.mdl",nil,3,"ValveBiped.Bip01_R_Hand", nil,-1.1,-2.6,(1-hmax[4]*0.5+hmax[5]*0.1), nil,-10,-175,155 ,0.65,true)
		end
	elseif Strg == "amod_fortnite_troops" then
		local hmax = A_AM.ActMod:HMX( ply )
		Tmd1 = CrMdl(ply,"models/actmod/prop/troops_gadget.mdl",nil,-1,"", nil,nil,nil,nil, Angle(0,90,0),nil,nil,nil ,43.0019,true)
	elseif Strg == "amod_fortnite_handsup" then
		local hmax = A_AM.ActMod:HMX( ply )
		Tmd1 = CrMdl(ply,"models/actmod/prop/handsup_planets.mdl",nil,-1,"", Vector(0,0,hmax[4]*1.18),hmax[1]*0.5,nil,nil, Angle(0,90,0),nil,nil,nil ,43.0023,true)
	elseif Strg == "amod_fortnite_marionette1" then
		local hmax = A_AM.ActMod:HMX( ply )
		local hmax2 = A_AM.ActMod:HMd( ply,"models/actmod/prop/marionette_lead_guitar_gadget.mdl" ,Strg,"LeadGuitar_Prop",0 ,"ValveBiped.Bip01_R_Hand","JNT_global_guitar" )
		Tmd1 = CrMdl(ply,"models/actmod/prop/marionette_lead_guitar_gadget.mdl",nil,-1,"", Vector(0,0,0),nil,nil,nil, Angle(0,90,0),nil,nil,nil ,hmax2[1]/hmax[3]*hmax[3]*1.45)
	elseif Strg == "aaaaa" then
		local pos_,px,py,pz = ply:GetBonePosition( ply:LookupBone("ValveBiped.Bip01_L_Hand") ) ,3.1,-1.5,-2
		Tmd1 = CrMdl(ply,"models/actmod/prop/abstract_mirror.mdl",nil,3,"ValveBiped.Bip01_L_Hand", nil,pz-py*2,px,py, nil,-5,-5,45 ,1)
		timer.Create("A_AM.Mdl_1"..ply:EntIndex(),10,1,function() if IsValid( ply ) then AA_AdModelRemov( ply,"*" ) end end)
	else
		AA_functOther( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4,function( md_1,md_2,md_3,md_4 )
			if md_1 then Tmd1 = md_1 end
			if md_2 then Tmd2 = md_2 end
			if md_3 then Tmd3 = md_3 end
			if md_4 then Tmd4 = md_4 end
		end)
	end
	if Tmd1 or Tmd2 or Tmd3 or Tmd4 then
		if Tmd1 and Tmd1["TimeRemove"] then timer.Create("A_AM.Mdl_1"..ply:EntIndex(),math.max(Tmd1["TimeRemove"],0),1,function() if IsValid( ply ) then AA_AdModelRemov( ply,"mdl1" ) end end) end
		if Tmd2 and Tmd2["TimeRemove"] then timer.Create("A_AM.Mdl_2"..ply:EntIndex(),math.max(Tmd2["TimeRemove"],0),1,function() if IsValid( ply ) then AA_AdModelRemov( ply,"mdl2" ) end end) end
		if Tmd3 and Tmd3["TimeRemove"] then timer.Create("A_AM.Mdl_3"..ply:EntIndex(),math.max(Tmd3["TimeRemove"],0),1,function() if IsValid( ply ) then AA_AdModelRemov( ply,"mdl3" ) end end) end
		if Tmd4 and Tmd4["TimeRemove"] then timer.Create("A_AM.Mdl_4"..ply:EntIndex(),math.max(Tmd4["TimeRemove"],0),1,function() if IsValid( ply ) then AA_AdModelRemov( ply,"mdl4" ) end end) end
		AA_AdModelSet( ply,Strg,Tmd1,Tmd2,Tmd3,Tmd4 )
	end
end

function A_AM.ActMod:AA_AddEffects( ply,agin,Strg )
	--print("AA_AddEffects",ply,agin,Strg)
end


local function AAEffect( Td,Te,ply,Tab,adis )
	if not ply:A_ActModEffects() then return end
	if adis and not aDist(ply,adis) then return end
	if IsValid(ply) and istable(Tab) then
		local Tc,T_1 = CurTime(),false
		if not istable(ply.TAEf_tab) then ply.TAEf_tab = { [1] = 0 ,[2] = 0 ,[3] = 0 ,[4] = 0 } end
		if (ply.TAEf_tab[Td] or 0) < Tc then T_1 = true end
		if T_1 then
			for k, v in pairs(Tab) do
				local ef = EffectData()
				if v["Scale"] then ef:SetScale( tonumber(v["Scale"]) ) end
				local aps = {0,0,0,0}
				if v["APoS"] then
					if v["APoS"][1] then aps[1] = v["APoS"][1] end
					if v["APoS"][2] then aps[2] = v["APoS"][2] end
					if v["APoS"][3] then aps[3] = v["APoS"][3] end
				end
				if v["PoS"] then
					if v["PoS"][1] then aps[1] = v["PoS"][1] end
					if v["PoS"][2] then aps[2] = v["PoS"][2] end
					if v["PoS"][3] then aps[3] = v["PoS"][3] end
					if v["PoS"][4] then aps[4] = v["PoS"][4] end
				end
				local pss,ENt
				if v["Mdl"] and IsValid(v["Mdl"]) then ENt = v["Mdl"] else ENt = ply end
				if ENt and IsValid(ENt) then
					if v["Bone"] and ( isstring(v["Bone"]) and ENt:LookupBone(v["Bone"]) or isnumber(v["Bone"]) ) then
						local IDBne = isnumber(v["Bone"]) and v["Bone"] or ENt:LookupBone(v["Bone"])
						local ok, bm = pcall(function() return ENt:GetBoneMatrix(IDBne) end)
						if not ok or not bm then
							local ok2, tpos, tang = pcall(function() return ENt:GetBonePosition(IDBne) end)
							if ok2 then pss = tpos end
						else
							pss = bm:GetTranslation()
						end
						if v["APoS"] then
							pss = Vector( aps[1], aps[2], aps[3] )
						elseif v["PoS"] then
							pss = pss + ENt:GetForward()*aps[1] + ENt:GetRight()*aps[2] + ENt:GetUp()*aps[3] + Vector( 0, 0, aps[4] )
						end
					end
					if v["Entity"] then
						if isentity(v["Entity"]) and IsValid(v["Entity"]) then
							if pss then ef:SetOrigin( pss ) end
							ef:SetEntity(v["Entity"]) util.Effect(v["nam"],ef)
						else
							if pss then ef:SetOrigin( pss ) end
							ef:SetEntity(ply) util.Effect(v["nam"],ef)
						end
					else
						if pss then
							ef:SetOrigin( pss ) util.Effect(v["nam"],ef)
						end
					end
				end
			end
			if istable(ply.TAEf_tab) and ply.TAEf_tab[Td] then ply.TAEf_tab[Td] = Tc + Te end
		end
	end
end
function A_AM.ActMod:AAEffect( Td,Te,ply,Tab )
	AAEffect( Td,Te,ply,Tab )
end
A_AM.ActMod.aTabDa_RunCyc["AAEffect"] = AAEffect

function A_AM.ActMod:GBoneMatrx( entity,boneID )
	local pos,ang = Vector(),Angle()
	if boneID then
		local boneMatrix = entity:GetBoneMatrix(boneID)
		if boneMatrix then
			pos = boneMatrix:GetTranslation()
			ang = boneMatrix:GetAngles()
		else
			local tpos, tang = entity:GetBonePosition(boneID)
			if tpos then
				pos = tpos
				ang = tang
			end
		end
	end
	return pos,ang
end

local function AASond( Td,Te,ply,Tab )
	if not ply.aa_aOSodAct then return end
	if ply and IsValid(ply) and Tab and istable(Tab) then
		local Tc = CurTime()
		local T_1
		Te = Te or 0.4
		if Td == 1 then T_1 = (ply.TASo_2 or 0) < Tc
		elseif Td == 2 then T_1 = (ply.TASo_3 or 0) < Tc
		else T_1 = (ply.TASo_1 or 0) < Tc
		end
		if T_1 then
			A_AM.ActMod:C_StopSond(ply,tostring(Td))
			A_AM.ActMod:A_aSond(ply,Tab["Sound"],tostring(Td),Tab["Volume"] or 70,Tab["onSnd"] or "0f")
			if Td == 1 then ply.TASo_2 = Tc + Te
			elseif Td == 2 then ply.TASo_3 = Tc + Te
			else ply.TASo_1 = Tc + Te
			end
		end
	end
end
A_AM.ActMod.aTabDa_RunCyc["AASond"] = AASond


function A_AM.ActMod:AA_GetFramCyc( pl,aCt,cyc )
	cyc = cyc or pl:GetCycle()
	local SeqD = pl:SequenceDuration(pl:LookupSequence(aCt))
	return {math.floor(( cyc*(SeqD*30) )+0.001),math.floor( cyc*(SeqD*30) ),math.Round( cyc*(SeqD*30) ),math.Round( cyc*(SeqD*30) + 0.5 )}
end

local function aSGetInfoPl(ent,p1,trmdl)
	if IsValid( ent ) then
		if trmdl then
			if trmdl > 1 then
				if p1:GetObserverMode() == 4 or p1:GetObserverMode() == 5 or p1:GetObserverMode() == 6 then
					local mdlname = p1:GetInfo( "cl_playermodel" )
					local mdlpath = player_manager.TranslatePlayerModel( mdlname )
					ent:SetModel(tostring(mdlpath)) else ent:SetModel(p1:GetModel())
				end
			end
			
			if trmdl > 0 then
				local skin = p1:GetInfoNum( "cl_playerskin", 0 )
				ent:SetSkin( skin )
				local groups = p1:GetInfo( "cl_playerbodygroups" )
				if ( groups == nil ) then groups = "" end
				local groups = string.Explode( " ", groups )
				for k = 0, ent:GetNumBodyGroups() - 1 do
					local v = tonumber( groups[ k + 1 ] ) or 0
					ent:SetBodygroup( k, v )
				end
			end
		end
		ent.GetPlayerColor = function() return p1:GetPlayerColor() end
	end
end
A_AM.ActMod.aTabDa_RunCyc["aSGetInfoPl"] = aSGetInfoPl

local function aSizeRp(a0,a1,a2 ,a3,a4)
	return math.Remap(math.min(a0-a1,a2),0,a2,a3,a4)
end
A_AM.ActMod.aTabDa_RunCyc["aSizeRp"] = aSizeRp

local function aSizeRp2(a1,a2 ,a3,a4)
	return math.Remap(math.min((CurTime()-a1)/a2,a2),0,a2,a3,a4)
end
A_AM.ActMod.aTabDa_RunCyc["aSizeRp2"] = aSizeRp2

local function aAlight(ide,ent,a1,a2,a3,a4,a5,a6)
	ide = ide or 1
	if ent and IsValid(ent) then
		local dlight = DynamicLight( ent:EntIndex()+ide )
		if ( dlight ) then
			dlight.pos = ent:GetPos() + ent:GetForward()*a1[1] + ent:GetRight()*a1[2] + ent:GetUp()*a1[3]
			dlight.r = a2[1]
			dlight.g = a2[2]
			dlight.b = a2[3]
			dlight.brightness = a3
			dlight.decay = a4
			dlight.size = a5
			dlight.dietime = CurTime() + a6
		end
	end
end
A_AM.ActMod.aTabDa_RunCyc["aAlight"] = aAlight


local function WrapFrom(base, max, val)
	return ((val - base) % max) + base
end

local function aTAlight(Td,Te,ply,Tab)
	Td = Td or 3
	if IsValid(ply) and istable(Tab) then
		local Tc = CurTime()
		local T_1
		if Td == 1 then T_1 = (ply.TAlig_1 or 0) < Tc
		elseif Td == 2 then T_1 = (ply.TAlig_2 or 0) < Tc
		else T_1 = (ply.TAlig_1 or 0) < Tc
		end
		if T_1 then
			for k, v in pairs(Tab) do
				local aps = {0,0,0,0}
				if v["PoS"] then
					if v["PoS"][1] then aps[1] = v["PoS"][1] end
					if v["PoS"][2] then aps[2] = v["PoS"][2] end
					if v["PoS"][3] then aps[3] = v["PoS"][3] end
					if v["PoS"][4] then aps[4] = v["PoS"][4] end
				end
				local pss,ENt
				if v["Entity"] and isentity(v["Entity"]) and IsValid(v["Entity"]) then
					ENt = v["Entity"]
				elseif v["Mdl"] and IsValid(v["Mdl"]) then
					ENt = v["Mdl"]
				else
					ENt = ply
				end
				if IsValid(ENt) then
					if v["Bone"] and ( isstring(v["Bone"]) and ENt:LookupBone(v["Bone"]) or isnumber(v["Bone"]) ) then
						local IDBne = isnumber(v["Bone"]) and v["Bone"] or ENt:LookupBone(v["Bone"])
						local ok, bm = pcall(function() return ENt:GetBoneMatrix(IDBne) end)
						if not ok or not bm then
							local ok2, tpos, tang = pcall(function() return ENt:GetBonePosition(IDBne) end)
							if ok2 then pss = tpos end
						else
							pss = bm:GetTranslation()
						end
						if v["PoS"] then
							if pss then
								pss = pss + ENt:GetForward()*aps[1] + ENt:GetRight()*aps[2] + ENt:GetUp()*aps[3] + Vector( 0, 0, aps[4] )
							else
								pss = ENt:GetPos() + ENt:GetForward()*aps[1] + ENt:GetRight()*aps[2] + ENt:GetUp()*aps[3] + Vector( 0, 0, aps[4] )
							end
						end
					end
					if pss then
						local EntTd = ply:EntIndex()+ENt:EntIndex()+Td + k
						local TimDie = CurTime() + v["dietime"]
						local dlight = DynamicLight( WrapFrom(1, 32, EntTd) )
						if ( dlight ) then
							dlight.pos = pss
							dlight.r = v["rgb"][1]
							dlight.g = v["rgb"][2]
							dlight.b = v["rgb"][3]
							dlight.brightness = v["brightness"]
							dlight.decay = v["decay"]
							dlight.size = v["size"]
							dlight.dietime = TimDie
						end
						
					end
				end
			end
			if Td == 1 then ply.TAlig_1 = Tc + Te
			elseif Td == 2 then ply.TAlig_2 = Tc + Te
			else ply.TAlig_1 = Tc + Te
			end
		end
	end
end
A_AM.ActMod.aTabDa_RunCyc["aTAlight"] = aTAlight

local function aSetSubMat(a1,a2,a3)
	if IsValid(a1) then
		local Mats = a1:GetMaterials()
		if Mats and istable(Mats) and Mats[a2+1] and isstring(a3) then
			a1:SetSubMaterial( a2, a3 )
		end
	end
end
A_AM.ActMod.aTabDa_RunCyc["aSetSubMat"] = aSetSubMat

local function aPsund( txt ,aID )
	if not A_AM.ActMod.aPsoud then A_AM.ActMod.aPsoud = {} end
	if txt then
		local GiD = 1
		if aID then
			GiD = aID else GiD = math.random(1,99)
		end
		if A_AM.ActMod.aPsoud[GiD] then
			A_AM.ActMod.aPsoud[GiD]:Stop() A_AM.ActMod.aPsoud[GiD] = nil
		end
		A_AM.ActMod.aPsoud[GiD] = CreateSound(LocalPlayer(), txt)
		if A_AM.ActMod.aPsoud[GiD] then
			A_AM.ActMod.aPsoud[GiD]:SetSoundLevel(1)
			A_AM.ActMod.aPsoud[GiD]:Play() A_AM.ActMod.aPsoud[GiD]:PlayEx(1,1)
			A_AM.ActMod.aPsoud[GiD]:Stop() A_AM.ActMod.aPsoud[GiD] = nil
		end
	end
end
A_AM.ActMod.aTabDa_RunCyc["aPsund"] = aPsund

local function aPmdl( txt ,aID )
	if not A_AM.ActMod.aPmdl then A_AM.ActMod.aPmdl = {} end
	if txt then
		local GiD = 1
		if aID then
			GiD = aID else GiD = math.random(1,99)
		end
		if A_AM.ActMod.aPmdl[GiD] then
			A_AM.ActMod.aPmdl[GiD]:Stop() A_AM.ActMod.aPmdl[GiD] = nil
		end
		A_AM.ActMod.aPmdl[GiD] = ClientsideModel(txt, RENDERGROUP_BOTH)
		if A_AM.ActMod.aPmdl[GiD] and IsValid(A_AM.ActMod.aPmdl[GiD]) then
			A_AM.ActMod.aPmdl[GiD]:SetNoDraw( true )
			A_AM.ActMod.aPmdl[GiD]:Remove()
			A_AM.ActMod.aPmdl[GiD] = nil
		end
	end
end
A_AM.ActMod.aTabDa_RunCyc["aPmdl"] = aPmdl

function A_AM.ActMod:AA_TActSV( ply,txt,agIn,TmpGetSel )
	local BastTab = A_AM.ActMod.GTabActO[txt] and A_AM.ActMod.GTabActO[txt]["TabInclusion"] and A_AM.ActMod.GTabActO[txt]["TabInclusion"]["TabScrptSV"]
	if BastTab and A_AM.ActMod.AdScrptActSV[txt] and (agIn and BastTab["AollwAgIn"] or not agIn) then
		A_AM.ActMod.AdScrptActSV[txt](ply,txt,TmpGetSel)
	end
end

function A_AM.ActMod:AA_RunCyc( pl )
	if not pl.aa_aOEffAct and not pl.aa_aOSodAct then return end
	if pl ~= LocalPlayer() and not LocalPlayer():trueShowMld(pl) then return end
	local aCt,aCt0,cyc = pl:GetNWString("A_ActMod.Dir", "" ),pl:GetNWString("A_ActMod.TmpDir", "" ),pl:GetCycle()
	local BastTab = A_AM.ActMod.AdScrpt
	if istable(BastTab) and BastTab[aCt0] then BastTab[aCt0](pl,cyc,A_AM.ActMod:AA_GetFramCyc( pl,aCt,cyc )) end
end

local function aLoadTablsAFlexs(itsChk)
	if istable(A_AM.ActMod.TablsAFlexs) and not table.IsEmpty(A_AM.ActMod.TablsAFlexs) then
		for k, v in pairs(A_AM.ActMod.TablsAFlexs) do
			if istable(v) and isstring(v.Path) and v.Path ~= "" then
				local fps,adds
				if isnumber(v.fps) then fps = v.fps end
				if isnumber(v.adds) and v.adds ~= 0 then adds = v.adds end
				local aitsChk = not itsChk or not istable(A_AM.ActMod.FacialSyncs.TFlexs) or not A_AM.ActMod.FacialSyncs.TFlexs[k]
				if aitsChk then
					local Gok = A_AM.ActMod.Flex_LoadFileDat( v.Path,k,fps,adds )
					if Gok then
						local Tact = A_AM.ActMod.GetAllAddTabAct["Act"][k]
						if Tact then
							Tact.Flex_Path = v.Path
							Tact.Flex_FPS = fps
							Tact.Flex_AddSpace = adds
						end
					end
				end
			end
		end
	end
end

local function aLoadTablsScrpts()
	if istable(A_AM.ActMod.GetAllAddTabAct.Scrpts) and not table.IsEmpty(A_AM.ActMod.GetAllAddTabAct.Scrpts) then
		for k,T in pairs(A_AM.ActMod.GetAllAddTabAct.Scrpts) do
			if istable(T) then
				if isfunction(T.F_S) then A_AM.ActMod.AdScrpt[k] = T.F_S end
				if isfunction(T.F_D) then A_AM.ActMod.AdScrptPDraw[k] = T.F_D end
				if isfunction(T.F_DO) then A_AM.ActMod.AdScrptPDrawO[k] = T.F_DO end
			end
		end
		for k,T in pairs(A_AM.ActMod.GetAllAddTabAct.Scrpts) do
			if istable(T) then
				if isstring(T.F_S) then A_AM.ActMod.AdScrpt[k] = A_AM.ActMod.AdScrpt[T.F_S] end
				if isstring(T.F_D) then A_AM.ActMod.AdScrptPDraw[k] = A_AM.ActMod.AdScrptPDraw[T.F_D] end
				if isstring(T.F_DO) then A_AM.ActMod.AdScrptPDrawO[k] = A_AM.ActMod.AdScrptPDrawO[T.F_DO] end
			end
		end
	end
end

local function aaRLoadlu(Ltxt) if file.Exists(Ltxt, "LUA") and (SERVER and file.Size(Ltxt, "LUA") > 5 or CLIENT) then include(Ltxt) end end
local function aRLoadTabsAct(itsChk)
	A_AM.ActMod.GetAllAddTabAct = {}
	A_AM.ActMod.GTabActO = {}
	if not A_AM.ActMod.SDTabActO then A_AM.ActMod.SDTabActO = {} end
	if not A_AM.ActMod.TablsAFlexs then A_AM.ActMod.TablsAFlexs = {} end
	if CLIENT then A_AM.ActMod.AdScrpt = {} end
	aaRLoadlu("actmod/am_actmod_act_base.lua")
	aaRLoadlu("actmod/am_act_fortnite_pack1.lua")
	aaRLoadlu("actmod/am_act_pubg_pack1.lua")
	A_AM.ActMod.SDTabActO["b_GTabActO"] = istable(A_AM.ActMod.GTabActO) and A_AM.ActMod:CalcTabS(A_AM.ActMod.GTabActO) or -1
	if CLIENT then
		A_AM.ActMod.SDTabActO["b_AdScrpt"] = istable(A_AM.ActMod.AdScrpt) and A_AM.ActMod:CalcTabS(A_AM.ActMod.AdScrpt) or -1
	end
	AA_JetAllAddTabCAct( true,itsChk )
	aLoadTablsAFlexs(itsChk)
	if CLIENT then aLoadTablsScrpts() end
	if istable(A_AM.ActMod.GetAllAddTabAct) and A_AM.ActMod.GetAllAddTabAct["Act"] then
		A_AM.ActMod:TableSafeMerge(A_AM.ActMod.GTabActO, A_AM.ActMod.GetAllAddTabAct["Act"])
	end
	A_AM.ActMod.SDTabActO["a_GTabActO"] = istable(A_AM.ActMod.GTabActO) and A_AM.ActMod:CalcTabS(A_AM.ActMod.GTabActO) or -1
	A_AM.ActMod.SDTabActO["m_GTabActO"] = math.max(math.abs(A_AM.ActMod.SDTabActO["a_GTabActO"]-A_AM.ActMod.SDTabActO["b_GTabActO"]),0)
	if CLIENT then
		A_AM.ActMod.SDTabActO["a_AdScrpt"] = istable(A_AM.ActMod.AdScrpt) and A_AM.ActMod:CalcTabS(A_AM.ActMod.AdScrpt) or -1
		A_AM.ActMod.SDTabActO["m_AdScrpt"] = math.max(math.abs(A_AM.ActMod.SDTabActO["b_AdScrpt"]-A_AM.ActMod.SDTabActO["a_AdScrpt"]),0)
	end
end

local function aLoadTablSounds()
	local TTABL = {}
	if not A_AM.ActMod.SDTabActO then A_AM.ActMod.SDTabActO = {} end
	if A_AM.ActMod.GTabSd_AM4_O then A_AM.ActMod:TableSafeMerge( TTABL, A_AM.ActMod.GTabSd_AM4_O ) end
	if A_AM.ActMod.GTabSd_AM4_F then A_AM.ActMod:TableSafeMerge( TTABL, A_AM.ActMod.GTabSd_AM4_F ) end
	if A_AM.ActMod.GTabSd_AM4_P then A_AM.ActMod:TableSafeMerge( TTABL, A_AM.ActMod.GTabSd_AM4_P ) end
	if A_AM.ActMod.GTabSd_AM4_MMD then A_AM.ActMod:TableSafeMerge( TTABL, A_AM.ActMod.GTabSd_AM4_MMD ) end
	A_AM.ActMod.SDTabActO["b_HaseTablSounds"] = istable(TTABL) and A_AM.ActMod:CalcTabS(TTABL) or -1
	if A_AM.ActMod.GetAllAddTabAct and A_AM.ActMod.GetAllAddTabAct["Sounds"] then
		A_AM.ActMod:TableSafeMerge(TTABL, A_AM.ActMod.GetAllAddTabAct["Sounds"])
	end
	A_AM.ActMod.SDTabActO["a_HaseTablSounds"] = istable(TTABL) and A_AM.ActMod:CalcTabS(TTABL) or -1
	A_AM.ActMod.SDTabActO["m_HaseTablSounds"] = math.max(math.abs(A_AM.ActMod.SDTabActO["a_HaseTablSounds"]-A_AM.ActMod.SDTabActO["b_HaseTablSounds"]),0)
	if CLIENT then A_AM.ActMod.HaseTablSounds = {} A_AM.ActMod.HaseTablSounds = TTABL end
	TTABL = nil
end

function A_AM.ActMod:aLoadAllTablAS(itsChk)
	A_AM.ActMod.SDTabActO = {}
	A_AM.ActMod.TablsAFlexs = {}
	A_AM.ActMod.GetAllAddTabAct = {}
	aRLoadTabsAct(itsChk)
	aLoadTablSounds()
	A_AM.ActMod.GetAllAddTabAct = {}
	if CLIENT and A_AM.ActMod.ClearWMaterialCache then A_AM.ActMod:ClearWMaterialCache(true) end
end
A_AM.ActMod:aLoadAllTablAS()

local tTim = CurTime() + 10
concommand.Add("actmod_reloadact", function(ply, cmd, args)
	if tTim < CurTime() then
		tTim = CurTime() + 5
		if IsValid(ply) and ply:IsPlayer() and ply:IsListenServerHost() and !ply:IsBot() then
			A_AM.ActMod:aLoadAllTablAS()
			if SERVER then
				for _, pl in player.Iterator() do if IsValid(pl) and !pl:IsBot() then net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"aLAT"} ) net.Send(pl) end end
			else
				net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"aLAT"} ) net.SendToServer()
			end
			ply:PrintMessage( 3,"[ActMod]: Reload All Tables(Emotes/Dances)")
		elseif SERVER then
			A_AM.ActMod:aLoadAllTablAS()
			for _, pl in player.Iterator() do if IsValid(pl) and !pl:IsBot() then net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"aLAT"} ) net.Send(pl) end end
			print("[ActMod]: Reload All Tables(Emotes/Dances)")
		elseif !ply:IsBot() then
			ply:PrintMessage( 3,"[ActMod]: This only works with the host.")
		end
	else
		if IsValid(ply) and ply:IsPlayer() and !ply:IsBot() then
			ply:PrintMessage( 3,"[ActMod]: Cant Do it now!")
		else
			print("[ActMod]: Reload All Tables(Emotes/Dances)")
		end
	end
end)


local function AeTabData( tbl, str ,hlp )
	if tbl then
		for k, v in pairs( tbl ) do
			if hlp then print("Search_   "..k.."  ->" ,v ,k == str) end
			if str and k == str then return true end
		end
	end
	return false
end

local function OnTaba( ply, aaData, Strg,agin,LSo ,AddC1,TESt,SRdw )
	if not aaData[Strg] and A_AM.ActMod.GTabActO[Strg] and A_AM.ActMod.GTabActO[Strg]["RNAnim_AutoSound"] then
		for k, v in pairs( A_AM.ActMod.GTabActO ) do
			if v["RNAnim"] and v["RNAnim"] == Strg then
				Strg = k
				break
			end
		end
	end
	if istable(aaData[Strg]) and istable(aaData[Strg].ts) then aaData[Strg] = aaData[Strg].ts[isnumber(SRdw) and SRdw or 1] end
	if TESt then
		return aaData[Strg]
	else
		if aaData[Strg] and IsValid( ply ) and (not ply:IsPlayer() or ply:A_ActMod_GetIsAct()) then
			if not agin and aaData[Strg][7] and aaData[Strg][7] > 0 or aaData[Strg][8] and aaData[Strg][8] > 0 then
				local aTbACt = A_AM.ActMod:GetTAniAct( ply,Strg )
				local C_s_1 = aTbACt and aTbACt["C_Sound_1"] or nil
				local tim1,tim2
				if aaData[Strg][7] and tonumber( aaData[Strg][7] ) > 0 then tim1 = tonumber( aaData[Strg][7] ) end
				if aaData[Strg][8] and tonumber( aaData[Strg][8] ) > 0 then tim2 = tonumber( aaData[Strg][8] ) end
				if not tim1 or tim1 <= 0 then if C_s_1 then tim1 = tonumber( C_s_1 ) end end
				if tim1 and tim1 > 0 then A_AM.ActMod:RLoopSond( ply,Strg,agin,tim1,tim2,nil,nil,SRdw ) end
			end
			if aaData[Strg][3] then
				if agin then
					if aaData[Strg][4] then
						timer.Create("A_AM.So_1"..ply:EntIndex(),aaData[Strg][4],1,function()
						if IsValid( ply ) then AAct_CreateSound(ply,aaData[Strg][3],1,nil,nil,nil,LSo) end end )
					else
						AAct_CreateSound(ply,aaData[Strg][3],1,nil,nil,nil,LSo)
					end
				else
					if aaData[Strg][2] then
						timer.Create("A_AM.So_1"..ply:EntIndex(),aaData[Strg][2],1,function()
						if IsValid( ply ) then AAct_CreateSound(ply,aaData[Strg][1],1,nil,nil,nil,LSo) end end )
					else
						AAct_CreateSound(ply,aaData[Strg][1],1,nil,nil,nil,LSo)
					end
				end
			else
				if aaData[Strg][2] then
					timer.Create("A_AM.So_1"..ply:EntIndex(),aaData[Strg][2],1,function()
					if IsValid( ply ) then AAct_CreateSound(ply,aaData[Strg][1],1,nil,nil,nil,LSo) end end )
				else
					AAct_CreateSound(ply,aaData[Strg][1],1,nil,nil,nil,LSo)
				end
			end
			if not agin and aaData[Strg][5] then
				if aaData[Strg][6] then
					timer.Create("A_AM.So_2"..ply:EntIndex(),aaData[Strg][6],1,function()
					if IsValid( ply ) then AAct_CreateSound(ply,aaData[Strg][5],2,nil,nil,nil,LSo) end end )
				else
					AAct_CreateSound(ply,aaData[Strg][5],2,nil,nil,nil,LSo)
				end
			end
		end
	end
end

function A_AM.ActMod:AA_AddSdTbl(ply,Strg,agin,LSo,AddC1,TESt,SRdw)
	if AddC1 then Strg = Strg .."_C1" end
	local GtoTyp = table.Copy(A_AM.ActMod.HaseTablSounds)
	if GtoTyp then
		if TESt then
			return OnTaba( ply, GtoTyp, Strg,agin,LSo ,AddC1,TESt,SRdw )
		else
			OnTaba( ply, GtoTyp, Strg,agin,LSo ,AddC1,TESt,SRdw )
		end
	end
end

local function AA_AddSound( ply,Str,agin,LSo,tBL,TESt,SRdw )
	if not TESt and SERVER then return end
	local Strg = ""
	if ply:IsPlayer() then
		Strg = Str or ply:GetNWString("A_ActMod.Dir", "")
	elseif CLIENT then
		local seqinfo = ply:GetSequenceInfo( ply:GetSequence() )
		Strg = Str or seqinfo.label
	end
	local AddC1 = tBL and tBL[1] and tobool(tBL[1]) or false
	if ply and Strg != (nil or "") then
		if timer.Exists( "A_AM.So_1"..ply:EntIndex() ) then timer.Remove( "A_AM.So_1"..ply:EntIndex() ) end
		if timer.Exists( "A_AM.So_2"..ply:EntIndex() ) then timer.Remove( "A_AM.So_2"..ply:EntIndex() ) end
		if TESt then
			return A_AM.ActMod:AA_AddSdTbl(ply,Strg,agin,LSo,AddC1,TESt,SRdw)
		else
			A_AM.ActMod:AA_AddSdTbl(ply,Strg,agin,LSo,AddC1,TESt,SRdw)
		end
	end
end
function A_AM.ActMod:AA_AddSound(ply,Str,agin,LSo,tBL,TESt,SRdw)
	if TESt then
		return AA_AddSound( ply,Str,agin,LSo,tBL,TESt,SRdw )
	else
		AA_AddSound( ply,Str,agin,LSo,tBL,TESt,SRdw )
	end
end

function A_AM.ActMod:AA_RemoveAdd( ply,nmdl,nma )
	if SERVER and not nma then
		net.Start("A_AM.ActMod.SvToCl_Tab") net.WriteTable( {"ActMod.AddRemove",ply,"*"} ) net.Broadcast()
	end
	if ply.AAct_Eff then
		for k, v in pairs(ply.AAct_Eff) do if v["ents"] and v["ents"] != NULL and IsValid(v["ents"]) then v["ents"]:Fire("kill",0,0) end end
		ply.AAct_Eff = nil
	end
	if not nmdl then AAct_STOPSOUND(ply) end
	if timer.Exists( "AA_TSond"..ply:EntIndex() ) then timer.Remove( "AA_TSond"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.So_1"..ply:EntIndex() ) then timer.Remove( "A_AM.So_1"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.So_2"..ply:EntIndex() ) then timer.Remove( "A_AM.So_2"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Ef_1"..ply:EntIndex() ) then timer.Remove( "A_AM.Ef_1"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Ef_2"..ply:EntIndex() ) then timer.Remove( "A_AM.Ef_2"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Ef_3"..ply:EntIndex() ) then timer.Remove( "A_AM.Ef_3"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Ef_4"..ply:EntIndex() ) then timer.Remove( "A_AM.Ef_4"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Mdl_1"..ply:EntIndex() ) then timer.Remove( "A_AM.Mdl_1"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Mdl_2"..ply:EntIndex() ) then timer.Remove( "A_AM.Mdl_2"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Mdl_3"..ply:EntIndex() ) then timer.Remove( "A_AM.Mdl_3"..ply:EntIndex() ) end
	if timer.Exists( "A_AM.Mdl_4"..ply:EntIndex() ) then timer.Remove( "A_AM.Mdl_4"..ply:EntIndex() ) end
	ply:StopParticles()
end


function A_AM.ActMod:AA_TableBool( tbl, str,ss,hlp )
	if not str or str == "" then return false end
	for k, v in pairs( tbl ) do
		if hlp then print("Search_   "..v.."  ->  ".. str ,v == str ,string.find( v, str )) end
		if (ss and v == str) or string.find( v, str ) then return true end
	end
	return false
end


function A_AM.ActMod:GetAniFromOneStart1(ply)
	local atXt = ply:GetNWString("A_ActMod.OneStart1","")
	if atXt ~= "" then
		local TtXt = string.Explode("|", atXt, true)
		if TtXt and istable(TtXt) and TtXt[1] and TtXt[1] ~= "" and TtXt[2] then
			return TtXt[1]
		end
	end
	local atXt = ply:GetNWString("A_ActMod.TmpDir","")
	if atXt ~= "" then
		return atXt
	end
	return ""
end

local function SetCAniForSW(ply,t,Tani)
    if not IsValid(ply) then return end
    local timerID = "ActModAnimLSW_|" .. ply:EntIndex()
    local StimerID = "ActModAnimSSW_|" .. ply:EntIndex()
    if timer.Exists(timerID) then timer.Remove(timerID) end
    if timer.Exists(StimerID) then timer.Remove(StimerID) end
    if istable(Tani) then
        if istable(Tani) and (istable(Tani.walk) or istable(Tani.static)) then
            local CMtn = Tani[t]
            if istable(CMtn) then
                local animName = CMtn.Anim
                local cycleStart = CMtn.Cycle or 0
                local playbackRate = CMtn.Rate or 1
                local startFromCycle = CMtn.SFCycle
                local enableResume = CMtn.Resume
                if not animName then return end
                local seq = ply:LookupSequence(animName)
                if seq == -1 then return end
                local sequenceDuration = ply:SequenceDuration(seq)
                local loopTime = CMtn.Time or sequenceDuration
                ply:SetNWString("A_ActMod.Dir", animName)
                local finalCycle = cycleStart
                local T_SLP = sequenceDuration-(loopTime/playbackRate)
                if enableResume and ply.ActMod_CurTRun and sequenceDuration > 0 then
                    local elapsedTime = CurTime() - ply.ActMod_CurTRun
                    local elapsedCycles = (elapsedTime * playbackRate) / sequenceDuration
                    local startCycle = ply.DEFiCycleWS or startFromCycle or cycleStart
                    local currentCycle = startCycle + elapsedCycles
                    finalCycle = currentCycle % 1.0
                    if not ply.DEFiCycleWS then ply.DEFiCycleWS = startCycle end
                elseif startFromCycle then
                    finalCycle = startFromCycle
                end
                ply:ResetSequence(seq) ply:SetCycle(finalCycle) ply:SetPlaybackRate(playbackRate)
                if loopTime and loopTime > 0 then
                    local cyclesToNext
                    if finalCycle < cycleStart then
                        cyclesToNext = cycleStart - finalCycle
                    else
                        cyclesToNext = (1.0 - finalCycle) + cycleStart
                    end
                    local tTNLoop = (cyclesToNext * sequenceDuration) / playbackRate
                    timer.Create(StimerID,math.max(tTNLoop-T_SLP,0),1, function()
                        if not IsValid(ply) then return end
                        if ply:GetNWString("A_ActMod.Dir") == animName then
                            ply:SetCycle(cycleStart)
                            timer.Create(timerID, loopTime / playbackRate, 0, function()
                                if IsValid(ply) and ply:A_ActMod_GetIsAct() then
									if ply:GetNWString("A_ActMod.Dir") == animName then ply:SetCycle(cycleStart) end
                                else
                                    timer.Remove(timerID)
                                end
                            end)
                        end
                    end)
                end
            else
                ply:SetNWString("A_ActMod.Dir", isstring(CMtn) and CMtn or "")
                local seq = ply:LookupSequence(CMtn)
                if seq > -1 then
					ply:ResetSequence(seq) ply:SetCycle(0) ply:SetPlaybackRate(1)
				end
            end
        else
            ply:SetNWString("A_ActMod.Dir", Tani[t])
        end
    end
end

function A_AM.ActMod:ThinkChingAni(ply)
	if IsValid(ply) and (not ply:IsPlayer() or ply:A_ActMod_GetIsAct()) then
		local GDir = A_AM.ActMod:GetAniFromOneStart1(ply)
		if GDir ~= "" and istable(A_AM.ActMod.GTabActWlk) and A_AM.ActMod.GTabActWlk[GDir] then
			local GDirNow,aw,as = ply:GetNWString("A_ActMod.Dir", ""),"",""
			local anim = A_AM.ActMod.GTabActWlk[GDir]
			if istable(anim) then
				if istable(anim.walk) and isstring(anim.walk.Anim) then
					aw = anim.walk.Anim
				elseif isstring(anim.walk) then
					aw = anim.walk
				end
				if istable(anim.static) and isstring(anim.static.Anim) then
					as = anim.static.Anim
				elseif isstring(anim.static) then
					as = anim.static
				end
				if ply.AalowAnim_MForward and aw ~= "" and (ply.rOn_MForward ~= 1 or GDirNow ~= aw) then
					ply.rOn_MForward = 1 SetCAniForSW(ply,"walk",anim)
				elseif ply.rOn_MForward > 0 and not ply.AalowAnim_MForward and as ~= "" and (ply.rOn_MForward ~= 2 or GDirNow ~= as) then
					ply.rOn_MForward = 2 SetCAniForSW(ply,"static",anim)
				end
			end
		end
	end
end


function A_AM.ActMod:SRCycleAni(ply,cy)
	ply:SetCycle( cy )
	if SERVER then
		ply:SetNWString("A_ActMod.OneStart3",tostring(cy) .."|".. tostring(CurTime()))
	end
end

function A_AM.ActMod:SCAni(ply,aCt)
	if SERVER then
		ply:SetNWString( "A_ActMod.Dir" ,aCt )
		ply:SetNWString("A_ActMod.OneStart4",aCt .."|".. tostring(CurTime()))
	elseif CLIENT then
		ply.cl_aNameAct = aCt
	end
end

			
function A_AM.ActMod:ChingAni(ply,OnBUt)
	local EIx = ply:EntIndex()
	local gCurTim = CurTime()
	local GTDir = ply:GetNWString( "A_ActMod.TmpDir" ,"" )
	if GTDir ~= "" and (not OnBUt or OnBUt == 3) and !timer.Exists( "AA_TReA"..EIx ) and (ply.TimeGo_Attk or 0) < gCurTim then
		local aTab = A_AM.ActMod.GTabActO[GTDir] and A_AM.ActMod.GTabActO[GTDir]["CCAni"]
		if istable(aTab) and (istable(aTab["CK1"]) or istable(aTab["CK2"])) then
			local GDir = ply:GetNWString( "A_ActMod.Dir", "" )
			local SetT = OnBUt and OnBUt == 3 and istable(aTab["CK2"]) and "CK2" or "CK1"
			if istable(aTab[SetT]) then
				for k,vTab in ipairs(aTab[SetT]) do
					local GetDir = vTab["GetDir"]
					if isstring(GetDir) and GetDir == GDir or istable(GetDir) and (string.sub(GetDir[1],GetDir[2]) == GetDir[3] and (not GetDir[6] or string.sub(GDir,GetDir[4],GetDir[5]) == GetDir[6])) then
						local time,STxT,timeEnd,addTab = 0,"",-1,false
						if isnumber(vTab["TimeHold"]) then
							time = vTab["TimeHold"]
						elseif istable(vTab["TimeHold"]) and isnumber(vTab["TimeHold"][1]) then
							if vTab["TimeHold"][2] == true then
								time = vTab["TimeHold"][1] + ply:SequenceDuration(ply:LookupSequence(ChDir))
							else
								time = vTab["TimeHold"][1]
							end
						elseif vTab["TimeHold"] == true then
							time = ply:SequenceDuration(ply:LookupSequence(ChDir))
						end
						if isstring(vTab["SetDir"]) then
							STxT = vTab["SetDir"]
						elseif istable(vTab["SetDir"]) and isstring(vTab["SetDir"][1]) then
							STxT = vTab["SetDir"][1]
							if isnumber(vTab["SetDir"][2]) then
								timeEnd = vTab["SetDir"][2]
							elseif vTab["SetDir"][2] == true then
								timeEnd = ply:SequenceDuration(ply:LookupSequence(STxT))
								if isnumber(vTab["SetDir"][3]) then
									timeEnd = timeEnd*vTab["SetDir"][3]
								end
							end
							if istable(vTab["SetDir"][4]) then addTab = vTab["SetDir"][4] end
						end
						ply.TimeGo_Attk = gCurTim + time
						if STxT ~= "" then
							if isnumber(vTab["Cycle"]) then A_AM.ActMod:SRCycleAni(ply,vTab["Cycle"]) end
							if isnumber(vTab["Rate"]) then ply:SetNWInt( "A_AM.ActRate", vTab["Rate"] ) end
							ply:SetNWString( "A_ActMod.Dir", STxT )
						end
						if timeEnd >= 0 then
							if timeEnd == 0 then
								A_AM.ActMod:A_ActMod_OffActing( ply )
							else
								timer.Create("AA_TReA"..EIx,math.max(timeEnd,0),1,function()
									if istable(addTab) then
										if isnumber(addTab["Cycle"]) then A_AM.ActMod:SRCycleAni(ply,addTab["Cycle"]) end
										if isnumber(addTab["Rate"]) then ply:SetNWInt( "A_AM.ActRate", addTab["Rate"] ) end
										if isstring(addTab["Dir"]) then ply:SetNWString( "A_ActMod.Dir", addTab["Dir"] ) end
										if isnumber(addTab["TRmov"]) then timer.Create("AA_TReA"..EIx,math.max(addTab["TRmov"],0),1,function() if IsValid( ply ) then A_AM.ActMod:A_ActMod_OffActing( ply ) end end) end
									else
										if IsValid( ply ) then A_AM.ActMod:A_ActMod_OffActing( ply ) end
									end
								end)
							end
						end
						break
					end
				end
			end
		end
	end
end



local function RLoopSond( ply,Strg,agin,time,time2,Tab2,Tab1,SRdw )
	local EIx = "AA_RLoopSond"..ply:EntIndex()
	if timer.Exists( EIx ) then timer.Remove( EIx ) end
	if agin and time2 then time = time2 end
	if time > 0 then
		timer.Create(EIx,time,1,function() if IsValid( ply ) and (not ply:IsPlayer() or ply:A_ActMod_GetIsAct()) then
			local OnSnd,OnEff
			if Tab1 and istable(Tab1) and Tab1[1] and string.len(Tab1[1]) > 4 then
				if tonumber(Tab1[2]) ~= 0 then OnSnd = tonumber(Tab1[2]) end
				if tonumber(Tab1[3]) ~= 0 then OnEff = tonumber(Tab1[3]) end
			end
			if (not ply:IsPlayer() and GetConVarNumber("actmod_cl_sound") == 1 and not LocalPlayer():A_ActMod_GetIsAct() or GetConVarNumber("actmod_sv_enabled_addso") == 1 and ply:IsPlayer() and (OnSnd and OnSnd == 1 or !OnSnd)) then
				AA_AddSound( ply,Strg,true,nil,Tab2,nil,SRdw )
			end
			RLoopSond( ply,Strg,true,time,time2,Tab2,Tab1,SRdw )
		end end )
	else
		local OnSnd,OnEff
		if Tab1 and istable(Tab1) and Tab1[1] and string.len(Tab1[1]) > 4 then
			if tonumber(Tab1[2]) ~= 0 then OnSnd = tonumber(Tab1[2]) end
			if tonumber(Tab1[3]) ~= 0 then OnEff = tonumber(Tab1[3]) end
		end
		if (not ply:IsPlayer() and GetConVarNumber("actmod_cl_sound") == 1 and not LocalPlayer():A_ActMod_GetIsAct() or GetConVarNumber("actmod_sv_enabled_addso") == 1 and ply:IsPlayer() and (OnSnd and OnSnd == 1 or !OnSnd)) then
			AA_AddSound( ply,Strg,true,nil,Tab2,nil,SRdw )
		end
		RLoopSond( ply,Strg,true,time,time2,Tab2,Tab1,SRdw )
	end
end
function A_AM.ActMod:RLoopSond( ply,Strg,agin,time,time2,Tab2,Tab1,SRdw )
	RLoopSond( ply,Strg,agin,time,time2,Tab2,Tab1,SRdw )
end

local function RLoopAnim( ply,agin,time,timeRAnim,CycleRAnim,ResetSequ )
	CycleRAnim = CycleRAnim or 0
	local EIx = "AA_RLoop"..ply:EntIndex()
	if timer.Exists( EIx ) then timer.Remove( EIx ) end
	if agin and timeRAnim and timeRAnim > 0 then time = timeRAnim end
	timer.Create(EIx,time,1,function() if IsValid( ply ) then
		local timerID = "ActModAnimLSW_|" .. ply:EntIndex()
		local StimerID = "ActModAnimSSW_|" .. ply:EntIndex()
		if not timer.Exists(timerID) and not timer.Exists(StimerID) then
			if ResetSequ then ply:ResetSequenceInfo() end
			ply:SetCycle( CycleRAnim )
		end
		RLoopAnim( ply,true,time,timeRAnim,CycleRAnim,ResetSequ )
	end end )
end

local function atC_TReA( GTab,ply,AA_T,EIx,Dtime,time )
	local ttim = 0.2
	if isstring(GTab["T"]) then
		if GTab["T"] == "Dtime" then ttim = Dtime
		elseif GTab["T"] == "time" then ttim = time
		else ttim = GTab["T"]
		end
	else
		ttim = GTab["T"]
	end
	if GTab["Dtime"] then ttim = Dtime end
	if GTab["time*"] then ttim = ttim * GTab["time*"] end
	if GTab["time+"] then ttim = ttim + GTab["time+"] end
	if GTab["time-"] then ttim = ttim - GTab["time-"] end
	timer.Create(AA_T .. EIx,ttim,1,function()
		if IsValid( ply ) then
			if GTab["RNAnim"] then
				if ply:IsPlayer() then
					ply:SetNWString( "A_ActMod.Dir" ,GTab["RNAnim"] )
				elseif CLIENT then
					ply:ResetSequence( ply:LookupSequence( GTab["RNAnim"] ) )
				end
			end
			if GTab["Rate"] then
				if ply:IsPlayer() then
					if CLIENT then ply.cl_aRateAct = GTab["Rate"] end
					ply:SetNWInt( "A_AM.ActRate", GTab["Rate"] )
				elseif CLIENT then
					ply:SetPlaybackRate(GTab["Rate"])
				end
			end
			if GTab["ResetAni"] then ply:ResetSequenceInfo() end
			if GTab["ResetMainAni"] and SERVER then ply:AnimRestartMainSequence() end
			if GTab["CycleAni"] then ply:SetCycle( GTab["CycleAni"] ) end
			if GTab["MoveDir"] then ply:SetNWInt( "A_ActMod.MoveDir", GTab["MoveDir"] ) end
			if GTab["MoveSpeed"] then ply:SetNWInt( "A_AM.MoveSpeed", GTab["MoveSpeed"] ) end
			if GTab["AalowAnim"] then ply.AalowAnim = GTab["AalowAnim"] end
			if GTab["LoopSound"] then ply.ALoopSOund = GTab["LoopSound"] end
			if GTab["MoveX"] and GTab["MoveX"][3] then
				timer.Create("AA_TMov"..EIx,GTab["MoveX"][2],GTab["MoveX"][1],function() if IsValid( ply ) then
					ply:SetNWInt( "A_AM.MoveSpeed", ply:GetNWInt( "A_AM.MoveSpeed", 0 ) + GTab["MoveX"][3] )
				end end)
			end
		end
	end)
end

function A_AM.ActMod:A_GetNJoing( pl )
	if IsValid( pl ) then
		local tmD = pl:GetNWString( "A_ActMod.TmpDir","" )
		if pl:GetNWString( "A_ActMod.TmpDir" ,"" ) ~= "" then
			local aTab = A_AM.ActMod.GTabActCoop[tmD]
			if aTab and aTab["AlPly"] and aTab["AlPly"] > 0 then
				local aN = aTab["AlPly"] <= pl:GetNWInt( "A_ActMod.GetNJoing" ,0 )
				if aN then return false else return true end
			end
		end
	end
	return true
end




local OW_PR_RA,OV_RA = 70,10
local function A_FindDanceOwner(jPly, afn, tracerPos)
    if jPly:GetNWBool("A_AM.ActMod.OnHimself", false) then return jPly, 0 end
    local bOwner,bDist = nil,math.huge
    for _, p in player.Iterator() do
        if p == jPly then continue end
        if not p:A_ActMod_IsActing() or not p:A_ActModASync() then continue end
        if not p:GetNWBool("A_AM.ActMod.OnHimself", false) then continue end
        local dTJoined = p:GetPos():Distance(jPly:GetPos())
        if dTJoined < bDist then
            bDist = dTJoined
            bOwner = p
        end
    end
    return bOwner, bestDist
end
local function A_SPOwner(hitEnt, owner, ownerD, tPos)
    if ownerD <= OV_RA then return true end
    if ownerD <= OW_PR_RA then
        if tPos:Distance(owner:GetPos()) <= tPos:Distance(hitEnt:GetPos()) + 15 then return true end
        if ownerD > OW_PR_RA * 0.5 then return false end
        return true
    end
    local ownerPos,hitPos = owner:GetPos(),hitEnt:GetPos()
    local localPos = WorldToLocal(hitPos, angle_zero, ownerPos, angle_zero)
    local oMins,oMaxs = owner:GetHull()
    oMins = isvector(oMins) and oMins or Vector(-16, -16, 0)
    oMaxs = isvector(oMaxs) and oMaxs or Vector(16, 16, 72)
    return localPos.x >= oMins.x and localPos.x <= oMaxs.x and localPos.y >= oMins.y and localPos.y <= oMaxs.y and localPos.z >= oMins.z and localPos.z <= oMaxs.z
end
function A_AM.ActMod:aGetLookTPly( ply )
    if not IsValid(ply) then return NULL end
    if not ply:A_ActMod_IsActing() then
        local a1,a2,a2
        local AGHN,AGHM = ply:GetHull()
        local Amins,Amaxs = Vector(-10,-10,0),Vector(10,10,15)
        if isvector(AGHN) then Amins = AGHN end
        if isvector(AGHM) then Amaxs = AGHM end
        Amins.z = Amins.z/2  Amaxs.z = Amaxs.z/2
        if istable(tps) then
            if tps[1] then a1 = tps[1] end
            if tps[2] then a2 = tps[2] end
        end
        local afn,start,AACop = A_AM.ActMod.msaf*1.5,a1 or ply:EyePos(),GetConVarNumber("actmod_sv_alowacop") > 0
        local endpos = a2 or start + ply:GetForward() * afn
        local afilter = function(ent)
            if IsValid(ent) and not ent:IsPlayer() then return true end
            if IsValid(ent) and (ent ~= ply and ent:GetOwner() ~= ply) and (ent ~= target and ent:GetOwner() ~= target)
            and ent:IsPlayer() and ent:A_ActModASync() and ent:A_ActMod_IsActing() and ply:GetPos():Distance(ent:GetPos()) < afn then
                local TbS,p2TmpDir,EPly = ent.a_TabPlysTem,ent:GetNWString( "A_ActMod.TmpDir" ,"" ),ply:SteamID64() .."_#._".. ply:Nick()
                if (AACop or p2TmpDir ~= "" and A_AM.ActMod.GTabActCoop and A_AM.ActMod.GTabActCoop[p2TmpDir] and (A_AM.ActMod.GTabActCoop[p2TmpDir]["joiningFPO"] or ent:GetNWBool( "A_AM.ActMod.OnHimself", false ) == true)) and (not istable(TbS) or TbS[EPly] and TbS[EPly]["H"]) then
                    return true else return false
                end
            end
        end
        local tr = util.TraceHull({ start = start, endpos = endpos, mins = Amins/4, maxs = Amaxs/4, filter = afilter })
        if IsValid(tr.Entity) and tr.Entity:IsPlayer() then
            local hitEnt = tr.Entity
            if not hitEnt:GetNWBool("A_AM.ActMod.OnHimself", false) then
                local owner, ownerD = A_FindDanceOwner(hitEnt, afn, start)
                if IsValid(owner) then
                    if A_SPOwner(hitEnt, owner, ownerD, start) then return owner end
                    local p2TDi = hitEnt:GetNWString("A_ActMod.TmpDir", "")
                    if (AACop and (p2TDi == "" or not A_AM.ActMod.GTabActCoop[p2TDi]) or
                        p2TDi ~= "" and A_AM.ActMod.GTabActCoop and A_AM.ActMod.GTabActCoop[p2TDi] and
                        A_AM.ActMod:A_GetNJoing(hitEnt) == true and
                        (A_AM.ActMod.GTabActCoop[p2TDi]["joiningFPO"] or
                        hitEnt:GetNWBool("A_AM.ActMod.OnHimself", false) == true)) then
                        return hitEnt
                    end
                    return owner
                end
            end
            return hitEnt
        end

        for _, target in player.Iterator() do
			if target == ply or not target:A_ActMod_IsActing() or not target:A_ActModASync() or target:GetPos():Distance(ply:GetPos()) > afn then continue end
			for _, hitbox in ipairs({0, 1, 4, 5, 6, 7}) do
				local bone = target:GetHitBoxBone(hitbox, target:GetHitboxSet())
				if bone then
					local bonePos = target:GetBonePosition(bone)
					local dist = util.DistanceToLine(start, endpos, bonePos)
					if dist < 20 then
						if IsValid(target) and target:IsPlayer() then
							local nfilter = function(ent)
								if not IsValid(ent) then return false end
								if ent == ply or ent:GetOwner() == ply or ent == target or ent:GetOwner() == target then return false end
								if ent:IsPlayer() and ent:A_ActMod_IsActing() then if ent:GetPos():Distance(target:GetPos()) <= OV_RA then return false end end
								return true
							end
							local GH1 = util.TraceHull({ start = start, endpos = bonePos, filter = afilter, mins = Amins/3, maxs = Amaxs/3, mask = MASK_SHOT_HULL })
							local GH2 = util.TraceHull({ start = ply:GetPos(), endpos = target:GetPos(), filter = nfilter, mins = Amins/4, maxs = Amaxs/4, mask = MASK_SOLID })
							if not GH1.Hit and not GH2.Hit then
								local cEnt,rOwner = target,nil
								if not target:GetNWBool("A_AM.ActMod.OnHimself", false) then
									local owner, ownerD = A_FindDanceOwner(target, afn, start)
									if IsValid(owner) then rOwner = owner cEnt = owner end
								end
								local p2TDi = cEnt:GetNWString("A_ActMod.TmpDir", "")
								local isEligible = (AACop and (p2TDi == "" or not A_AM.ActMod.GTabActCoop[p2TDi]) or p2TDi ~= "" and A_AM.ActMod.GTabActCoop and A_AM.ActMod.GTabActCoop[p2TDi] and A_AM.ActMod:A_GetNJoing(cEnt) == true and (A_AM.ActMod.GTabActCoop[p2TDi]["joiningFPO"] or cEnt:GetNWBool("A_AM.ActMod.OnHimself", false) == true))
								if isEligible then
									if IsValid(rOwner) then
										if A_SPOwner(target, rOwner, target:GetPos():Distance(rOwner:GetPos()), start) then return rOwner end
										return target
									end
									return target
								end
							end
						end
					end
				end
			end
		end
    end
    return NULL
end



local function aS_CR( ply,Str,agg )
	if Str == "Rate" then
		if ply:IsPlayer() then ply:SetNWInt( "A_AM.ActRate", agg ) elseif CLIENT then ply:SetPlaybackRate( agg ) end
	elseif Str == "Cycle" then
		if ply:IsPlayer() then ply:SetCycle( agg ) elseif CLIENT then ply:SetCycle( agg ) end
	end
end

local function alfxSound( ply,Strg,agIn,time,timeRSond,Tab2,Tab1,SRdw )
	if CLIENT then
		local aaData = A_AM.ActMod.HaseTablSounds
		if not aaData[Strg] then for k, v in pairs( A_AM.ActMod.GTabActO ) do if v["RNAnim"] and v["RNAnim"] == Strg then Strg = k break end end end
		if aaData[Strg] then
			if not agin and aaData[Strg][7] and aaData[Strg][7] > 0 or aaData[Strg][8] and aaData[Strg][8] > 0 then
				local aTbACt = A_AM.ActMod:GetTAniAct( ply,Strg )
				local C_s_1 = aTbACt and aTbACt["C_Sound_1"] or nil
				local tim1,tim2
				if aaData[Strg][7] and tonumber( aaData[Strg][7] ) > 0 then tim1 = tonumber( aaData[Strg][7] ) end
				if aaData[Strg][8] and tonumber( aaData[Strg][8] ) > 0 then tim2 = tonumber( aaData[Strg][8] ) end
				if not tim1 or tim1 <= 0 then if C_s_1 then tim1 = tonumber( C_s_1 ) end end
				if tim1 and tim1 > 0 then A_AM.ActMod:RLoopSond( ply,Strg,agin,tim1,tim2,Tab2,Tab1,SRdw ) end
			else
				RLoopSond( ply,Strg,agIn,time,timeRSond,Tab2,Tab1,SRdw )
			end
		end
	end
end


function A_AM.ActMod:StartAniAct( ply,TStr,rres,Tab1,Tab2,Strg2,RCoop,JGet,isH )
	local gCurTim = CurTime()
	local Strg,Rate,Cycle,Cyclesv,timeRAnim,CycleRAnim,Dtime,time,ReAnimCycle,MoveDir,MoveSpeed,CamParent,CamInLerp,LoopSond,agIn,AalowAnim = "",1,0,0,0,0,0,0,0,0,0,false,5,-1,false,false
	local Rtime,RtimeAnim,RNAnim,aResetAni,AutoReAnim,OnSyne = false,false,"",false,false,false
	local GetTabAct,NoStop,timeRSond,StrgRe,Strgtrue,CTimeStop,ResetMainAni,SRdw,CSti_t1,CSti_t2
	local Str = ""
	if istable(TStr) then
		if isstring(TStr[1]) then Str = TStr[1] end
		if isnumber(TStr[2]) then SRdw = TStr[2] end
	elseif isstring(TStr) then Str = TStr
	end
	Strg = Str
	rres = rres or false
	isH = isH or false
	if IsValid(ply) then ply.ActMod_ReaginRunAct = rres end
	if istable(A_AM.ActMod.GTabActO) then GetTabAct = A_AM.ActMod.GTabActO[Str] end
	if Str ~= "" and ply and ( IsValid( ply ) or JGet and isstring(ply) ) then
		local EIx
		if isentity(ply) then
			EIx = ply:EntIndex()
		else
			EIx = string.format("sEIx_%s_r%s|%s_c%s",tostring(ply),math.Rand(-10,10),math.Rand(1,10),gCurTim)
		end
		if not JGet then
			if Tab1 and istable(Tab1) and Tab1[1] and string.len(Tab1[1]) > 4 and Tab1[2] and Tab1[3] and Tab1[4] then
				ply.ActMod_tAb = Tab1 else ply.ActMod_tAb = nil
			end
			if timer.Exists( "AA_TStratA"..ply:EntIndex() ) then timer.Remove( "AA_TStratA"..ply:EntIndex() ) end
			if timer.Exists( "AA_TReA"..ply:EntIndex() ) then timer.Remove( "AA_TReA"..ply:EntIndex() ) end
			if timer.Exists( "AA_TMov"..ply:EntIndex() ) then timer.Remove( "AA_TMov"..ply:EntIndex() ) end
			if timer.Exists( "AA_TSTr"..ply:EntIndex() ) then timer.Remove( "AA_TSTr"..ply:EntIndex() ) end
			if timer.Exists( "AA_TEnd"..ply:EntIndex() ) then timer.Remove( "AA_TEnd"..ply:EntIndex() ) end
			if timer.Exists( "AA_RLoop"..ply:EntIndex() ) then timer.Remove( "AA_RLoop"..ply:EntIndex() ) end
			if timer.Exists( "AA_RLoopAnim"..ply:EntIndex() ) then timer.Remove( "AA_RLoopAnim"..ply:EntIndex() ) end
			if timer.Exists( "AA_RLoopSond"..ply:EntIndex() ) then timer.Remove( "AA_RLoopSond"..ply:EntIndex() ) end
			if timer.Exists( "A_AM_Add_C_1"..ply:EntIndex() ) then timer.Remove( "A_AM_Add_C_1"..ply:EntIndex() ) end
			if timer.Exists( "A_AM_Add_C_2"..ply:EntIndex() ) then timer.Remove( "A_AM_Add_C_2"..ply:EntIndex() ) end
			if timer.Exists( "A_AM_Add_C_3"..ply:EntIndex() ) then timer.Remove( "A_AM_Add_C_3"..ply:EntIndex() ) end
			if timer.Exists( "A_AM_Add_C_4"..ply:EntIndex() ) then timer.Remove( "A_AM_Add_C_4"..ply:EntIndex() ) end
			ply.AalowAnim = false
			ply.ALoopSOund = false
			ply.aa_aOEffAct = false
			ply.aa_aOSodAct = false
			ply.aaBThinStrt = nil
			ply.actmod_Coop_Tply = nil
			ply.actmod_Coop_ok = nil
			ply.ActMod_DontAAng = nil
			ply.ActMod_DontAlwAng = nil
			if isstring(RCoop) then
				if (string.sub( RCoop, 1,1 ) == "1" or string.sub( RCoop, 1,1 ) == "2" or string.sub( RCoop, 1,1 ) == "3") and string.sub( RCoop, 2 ) ~= "" then
					local AGPLy = tonumber(string.sub( RCoop, 2 ))
					if isnumber(AGPLy) then
						ply.actmod_Coop_ok = true
						local pl2 = Entity(AGPLy)
						if pl2 and IsValid(pl2) and pl2 ~= ply then
							ply.actmod_Coop_Tply = pl2
						end
					end
				end
				RCoop = tonumber(RCoop)
			end
			ply:SetNWString( "A_ActMod.TmpDir" ,Str )
			if ply:IsPlayer() then
				ply:SetNWBool( "A_AM.ActMod.OnHimself", false )
			elseif CLIENT then
				ply:ResetSequenceInfo()
				ply:ResetSequence( ply:LookupSequence( Str ) )
				ply:SetCycle(0)
				ply:SetPlaybackRate(0)
			end
			Dtime = ply:SequenceDuration(ply:LookupSequence(Str))
			time = Dtime
		else
			local entity_1
			local aID = string.format("sGetTAct_%s_r%s|%s_c%s",EIx,math.Rand(-10,10),math.Rand(1,10),gCurTim)
			if SERVER then
				entity_1 = ents.Create("base_anim")
				if entity_1 and IsValid(entity_1) then entity_1:SetModel(isentity(ply) and ply:GetModel() or tostring(ply)) end
			else
				entity_1 = ClientsideModel(isentity(ply) and ply:GetModel() or tostring(ply), RENDERGROUP_BOTH)
			end
			if entity_1 and IsValid(entity_1) then
				entity_1:DrawShadow( false ) entity_1:SetNoDraw( true )
				timer.Create(aID , 0.1,1,function() if IsValid( entity_1 ) then entity_1:Remove() entity_1 = nil end end)
				Dtime = entity_1:SequenceDuration(entity_1:LookupSequence(Str))
				time = Dtime
				ply = entity_1
			end
		end
		if Strg == "amod_dance_gangnamstyle" then
			AutoReAnim = true
			if rres then time = 29.2
				if not JGet then
					timer.Create("AA_TReA"..EIx,0.2,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.2 )
					timer.Create("AA_TReA"..EIx,3.7,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.16 )
					timer.Create("AA_TReA"..EIx,4.1,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 0.9 )
					timer.Create("AA_TReA"..EIx,5,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.23 ) end end) end end) end end) end end)
					timer.Create("AA_TMov"..EIx,14.2,1,function() if IsValid( ply ) then aS_CR( ply,"Cycle", 0 )
					timer.Create("AA_TReA"..EIx,0.2,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.2 )
					timer.Create("AA_TReA"..EIx,3.7,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.16 )
					timer.Create("AA_TReA"..EIx,4.1,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 0.85 )
					timer.Create("AA_TReA"..EIx,5,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 0.85 ) end end) end end) end end) end end) end end)
				end
			else time = 30.5  Rate = 0.2 CamInLerp = 0.28
				if not JGet then
					timer.Create("AA_TReA"..EIx,1.1,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.2 )
					timer.Create("AA_TReA"..EIx,3.7,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.16 )
					timer.Create("AA_TReA"..EIx,4.1,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 0.9 )
					timer.Create("AA_TReA"..EIx,5,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 0.82 ) end end) end end) end end) end end)
					timer.Create("AA_TSTr"..EIx,15.7,1,function() if IsValid( ply ) then aS_CR( ply,"Cycle", 0 ) aS_CR( ply,"Rate", 0.2 )
					timer.Create("AA_TReA"..EIx,0.2,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.2 )
					timer.Create("AA_TReA"..EIx,3.7,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.16 )
					timer.Create("AA_TReA"..EIx,4.1,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 0.9 )
					timer.Create("AA_TReA"..EIx,5,1,function() if IsValid( ply ) then aS_CR( ply,"Rate", 1.0 ) end end) end end) end end) end end) end end)
				end
			end
		elseif GetTabAct then
			local GTab = GetTabAct
			local Alwn = RCoop and ( RCoop == 1 or RCoop == 2 and not GTab["noRNAnim"] or RCoop == 0 ) or not RCoop
			if GTab["AutoReAnim"] then AutoReAnim = GTab["AutoReAnim"] end
			if GTab["DontAlwAng"] then ply.ActMod_DontAAng = true end
			if GTab["AddC1"] and Tab2 and Tab2[1] and tobool(Tab2[1]) then
				GTab = GTab["AddC1"]
			end
			if rres and GTab["rres"] and istable(GTab["rres"]) then
				GTab = GTab["rres"]
			end
			if GTab["RNAnim"] and Alwn then
				Strg = GTab["RNAnim"]
				StrgRe = Str
				Strgtrue = true
				if ply:IsPlayer() then
					ply:SetNWString( "A_ActMod.Dir" ,Strg )
				elseif CLIENT then
					ply:ResetSequence( ply:LookupSequence( Strg ) )
				end
				if CLIENT then ply.cl_aNameAct = Strg end
				if GTab["RNAnim_RDuration"] then 
					StrgRe = Str
					Dtime = ply:SequenceDuration(ply:LookupSequence(Strg))
					time = Dtime
				end
			else
				if GTab["RNAnim"] then
					StrgRe = Str Strgtrue = true
					if GTab["RNAnim_RDuration"] then
						Strg = GTab["RNAnim"]
						StrgRe = Str
						Dtime = ply:SequenceDuration(ply:LookupSequence(Strg))
						time = Dtime
					end
				else
					StrgRe = Strg
				end
			end
			if RCoop and isnumber(RCoop) and string.sub( RCoop, 1,1 ) == "3" then
				local pl2 = ply.actmod_Coop_Tply
				if pl2 and IsValid(pl2) then
					Cycle = pl2:GetCycle()
					time = time - math.Remap(Cycle,0,1 ,0,Dtime)
					OnSyne = true
				end
			end
			if Alwn and (not rres or isH) then ply:SetNWBool( "A_AM.ActMod.OnHimself", true ) isH = true end
			if GTab["RTimeAnim"] then time = ply:SequenceDuration(ply:LookupSequence(Strg)) end
			if GTab["CTimeStop"] then CTimeStop = GTab["CTimeStop"] end
			if GTab["LoopSond"] then LoopSond = GTab["LoopSond"] end
			if GTab["AutoReAnim"] then AutoReAnim = GTab["AutoReAnim"] end
			if GTab["Agin"] then agIn = GTab["Agin"] end
			if GTab["LoopSound"] then ply.ALoopSOund = GTab["LoopSound"] end
			if GTab["NoStop"] and not GTab["noRAgain"] and (Alwn or RCoop and isnumber(RCoop) and RCoop > 3 and GTab["NoStop"] == 9 or not RCoop) then NoStop = GTab["NoStop"] end
			if GTab["CamParent"] then CamParent = GTab["CamParent"] end
			if GTab["CamInLerp"] then CamInLerp = GTab["CamInLerp"] end
			if GTab["time*"] then time = time * GTab["time*"] end
			if GTab["time+"] then time = time + GTab["time+"] end
			if GTab["time-"] then time = time - GTab["time-"] end
			if GTab["time"] then time = GTab["time"] end
			if GTab["Cycle"] then Cycle = GTab["Cycle"] end
			if GTab["Rate"] then Rate = GTab["Rate"] end
			if GTab["timeRSond"] then timeRSond = GTab["timeRSond"] end
			if GTab["timeRAnim"] then timeRAnim = GTab["timeRAnim"] end
			if GTab["CycleRAnim"] then CycleRAnim = GTab["CycleRAnim"] end
			if GTab["CycleAni"] then ply:SetCycle( GTab["CycleAni"] ) end
			if GTab["MoveDir"] then MoveDir = GTab["MoveDir"] end
			if GTab["MoveSpeed"] then MoveSpeed = GTab["MoveSpeed"] end
			if GTab["AalowAnim"] then ply.AalowAnim = GTab["AalowAnim"] end
			if GTab["ResetAni"] then aResetAni = true end
			if GTab["ResetMainAni"] then ResetMainAni = true end
			if GTab["tC_TReA"] and GTab["tC_TReA"]["T"] then
				atC_TReA( GTab["tC_TReA"],ply,"AA_TMov",EIx,Dtime,time )
			end
			if GTab["tC_TReA2"] and GTab["tC_TReA2"]["T"] then
				atC_TReA( GTab["tC_TReA2"],ply,"AA_TSTr",EIx,Dtime,time )
			end
			if GTab["tC_TReA_CycleAni"] and GTab["tC_TReA_CycleAni"][3] then
				local ttim = 0.1
				if istable(GTab["tC_TReA_CycleAni"][1]) then
					if GTab["tC_TReA_CycleAni"][1]["_time"] and GTab["tC_TReA_CycleAni"][1]["_time"] == "Dtime" then ttim = Dtime end
				else
					ttim = GTab["tC_TReA_CycleAni"][1]
				end
				if not JGet then
					timer.Create("AA_TReA"..EIx,ttim,GTab["tC_TReA_CycleAni"][2],function()
						if IsValid( ply ) then ply:SetCycle( GTab["tC_TReA_CycleAni"][3] ) end
					end)
				end
			end
			if GTab["Rtime"] then time = Dtime end
		else
			local GTab = GetTabAct
			if not JGet and (not rres or isH) then ply:SetNWBool( "A_AM.ActMod.OnHimself", true ) isH = true end
			if RCoop and isnumber(RCoop) and string.sub( RCoop, 1,1 ) == "3" then
				local pl2 = ply.actmod_Coop_Tply
				if pl2 and IsValid(pl2) then
					Cycle = pl2:GetCycle()
					if GTab and GTab["Rate"] then
						time = Dtime / GTab["Rate"]
					end
					time = time - math.Remap(Cycle,0,1 ,0,Dtime)
					OnSyne = true
					NoStop = 3
				end
			end
		end
		
		if not StrgRe then StrgRe = Strg end
		if aResetAni then ply:ResetSequenceInfo() end
		if ResetMainAni then ply:AnimRestartMainSequence() end
		ply:SetCycle( Cycle )
		local PlySLoop = 0
		if ply:IsPlayer() then
			PlySLoop = ply:A_ActModLoop()
		elseif CLIENT then
			PlySLoop = GetConVarNumber("actmod_cl_loop")
		end
		if ply and IsValid(ply) then
			if JGet then
				if not ply:IsPlayer() and IsValid( ply ) then ply:Remove() ply = nil end
				local TC_A_1,TC_A_2 = time,timeRAnim
				local TC_S_1,TC_S_2 = time,timeRSond
				local aaGTab = GetTabAct
				if aaGTab and aaGTab["C_"] then
					aaGTab = aaGTab["C_"]
					if aaGTab["C_Sound"] then
						if aaGTab["C_Sound"]["Time1"] then TC_S_1 = aaGTab["C_Sound"]["Time1"] end
						if aaGTab["C_Sound"]["Time2"] then TC_S_2 = aaGTab["C_Sound"]["Time2"] end
					end
					if aaGTab["C_Anim"] then
						if aaGTab["C_Anim"]["Time1"] then TC_A_1 = aaGTab["C_Anim"]["Time1"] end
						if aaGTab["C_Anim"]["Time2"] then TC_A_2 = aaGTab["C_Anim"]["Time2"] end
					end
				end
				return { ["time"] = time ,["AgIn"] = agIn ,["timeRSond"] = timeRSond ,["timeRAnim"] = timeRAnim ,["CycleRAnim"] = CycleRAnim ,["C_Sound_1"] = TC_S_1,["C_Sound_2"] = TC_S_2 ,["C_Anim_1"] = TC_A_1,["C_Anim_2"] = TC_A_2 }
			else
				local aG1,aG2 = false,false
				if GetTabAct and (ply:IsPlayer() and A_AM.ActMod:IsVR(ply) or not ply:IsPlayer()) then
					if GetTabAct["VR_NoAni"] then aG1 = true end
					if GetTabAct["VR_CanMove"] then aG2 = true end
				end
				if not ply.ActMod_OPT_VR then ply.ActMod_OPT_VR = {} end
				ply.ActMod_OPT_VR["NoAni"] = aG1
				ply.ActMod_OPT_VR["CanMove"] = aG2
				if AnimationSWEP and AnimationSWEP.Toggle then AnimationSWEP:Toggle(ply, false) end
				if ply:GetNWInt( "A_ActMod.GetNJoing" ,0 ) > 0 and ply.actmod_Coop_Tply and A_AM.ActMod.GTabActCoop[Str] and A_AM.ActMod.GTabActCoop[Str]["rAng"] then
					ply.ActMod_DontAlwAng = true
				end
				if ply:IsPlayer() then
					ply:SetNWBool( "A_AM.ActMod.OnButtons", false )
					ply:SetNWBool( "A_AM.ActMod.AddC1", false ) ply:SetNWBool( "A_AM.ActMod.AddC2", false )
					ply:SetNWBool( "A_AM.ActMod.AddMo", false ) ply:SetNWBool( "A_AM.ActMod.AddEf", false ) ply:SetNWBool( "A_AM.ActMod.AddSo", false )
					ply:SetNWString( "A_ActMod.Dir", Strg ) ply:SetNWBool( "A_AM.ActMod.IsAct", true ) ply:SetNWInt( "A_AM.ActRate", Rate )
					ply:SetNWInt( "A_ActMod.MoveDir", MoveDir ) ply:SetNWInt( "A_AM.MoveSpeed", MoveSpeed )
					ply:SetNWBool( "A_AM.ActMod.Cam_Parent", CamParent ) ply:SetNWInt( "A_AM.ActMod.CamInLerp", CamInLerp )
					if NoStop then
						ply:SetNWInt( "A_AM.ActTime", -2 )
					else
						ply:SetNWInt( "A_AM.ActTime", gCurTim + time + 0.5 )
					end
					if SERVER then ply.ActMod_JOne = true end
				elseif CLIENT then
					timer.Create("AA_Taat"..ply:EntIndex(),0.01,1,function() if IsValid( ply ) then
						ply:ResetSequenceInfo()
						ply:ResetSequence( ply:LookupSequence( Strg ) )
						ply:SetCycle( Cycle )
						ply:SetPlaybackRate(Rate)
					end end)
				end
				if CLIENT then
					ply.cl_aNameAct = Strg
					local OnSnd,OnEff
					if Tab1 and istable(Tab1) and Tab1[1] and string.len(Tab1[1]) > 4 then
						if tonumber(Tab1[2]) ~= 0 then OnSnd = tonumber(Tab1[2]) end
						if tonumber(Tab1[3]) ~= 0 then OnEff = tonumber(Tab1[3]) end
					end
					if (not ply:IsPlayer() and GetConVarNumber("actmod_cl_sound") == 1 and not LocalPlayer():A_ActMod_GetIsAct() or GetConVarNumber("actmod_sv_enabled_addso") == 1 and ply:IsPlayer() and (OnSnd and OnSnd == 1 or !OnSnd) and LoopSond == -1 or LoopSond ~= -1 and not rres) then
						AA_AddSound( ply,StrgRe,rres,LoopSond,Tab2,nil,SRdw )
						ply.aa_aOSodAct = true
					end
					if ply:IsPlayer() then
						if StrgRe and GetConVarNumber("actmod_sv_enabled_addef") == 1 and ((OnEff and OnEff == 1) or !OnEff and ply:A_ActModEffects() == true) then
							A_AM.ActMod:AA_AddModel( ply,StrgRe,rres ) A_AM.ActMod:AA_AddEffects( ply,StrgRe,rres )
							ply.aa_aOEffAct = true
						end
					else
						A_AM.ActMod:AA_AddModel( ply,StrgRe,rres ) A_AM.ActMod:AA_AddEffects( ply,StrgRe,rres )
						ply.aa_aOEffAct = true
					end
				end
				if CTimeStop then
					if ply:IsPlayer() then
						if SERVER then
							timer.Create("AA_TEnd"..ply:EntIndex(),math.max(CTimeStop,0),1,function() if IsValid( ply ) then
								A_AM.ActMod:A_ActMod_OffActing( ply )
							end end)
						end
					end
				end
				if SERVER then A_AM.ActMod:AA_TActSV( ply,StrgRe,agIn ) end
				if NoStop then
					if SRdw and istable(GetTabAct.SndsC_) and istable(GetTabAct.SndsC_.t) and GetTabAct.SndsC_.t[SRdw] then
						CSti_t1 = GetTabAct.SndsC_.t[SRdw][1]
						CSti_t2 = GetTabAct.SndsC_.t[SRdw][2]
					end
					if NoStop == 0 then
					elseif NoStop == 3 then
						if LoopSond == -1 then alfxSound( ply,StrgRe,agIn,CSti_t1 or time,CSti_t2 or timeRSond,Tab2,Tab1,SRdw ) end
						if OnSyne then
							RLoopAnim( ply ,agIn ,time ,Dtime ,CycleRAnim or Cycle ,aResetAni )
						else
							RLoopAnim( ply,agIn,time,timeRAnim,CycleRAnim,aResetAni )
						end
					elseif NoStop == 4 then
						if LoopSond == -1 then alfxSound( ply,StrgRe,agIn,CSti_t1 or time,CSti_t2 or timeRSond,Tab2,Tab1,SRdw ) end
					elseif NoStop == 9 then
						local TGTab = GetTabAct
						if TGTab["C_"] then
							local GTab = TGTab["C_"]
							if GTab["C_Sound"] then
								local GTb = GTab["C_Sound"]
								if LoopSond == -1 then alfxSound( ply,StrgRe ,GTb["AgIn"] or agIn ,CSti_t1 or GTb["Time1"] or time ,CSti_t2 or GTb["Time2"] or timeRSond ,Tab2,Tab1,SRdw ) end
							end
							if GTab["C_Anim"] then
								local GTb = GTab["C_Anim"]
								local GTiMr_1 ,GTiMr_2 = time ,Dtime
								if GTb["Time1"] then GTiMr_1 = GTb["Time1"] end
								if OnSyne then GTiMr_1 = time end
								if TGTab["Rate"] then GTiMr_2 = Dtime / TGTab["Rate"] end
								RLoopAnim( ply ,GTb["AgIn"] or agIn ,GTiMr_1 ,GTb["Time2"] or (timeRAnim ~= 0 and timeRAnim or OnSyne and GTiMr_2 or timeRAnim) ,GTb["Cycle"] or CycleRAnim,aResetAni )
							end
						end
					end
				else
					timer.Create("AA_TEnd"..ply:EntIndex(),math.max(time,0),1,function() if IsValid( ply ) and (not ply:IsPlayer() or ply:A_ActMod_GetIsAct()) then
						local OnLoop
						if Tab1 and istable(Tab1) and Tab1[1] and string.len(Tab1[1]) > 4 and tonumber(Tab1[4]) ~= 0 then OnLoop = tonumber(Tab1[4]) end
						if ply:IsPlayer() and (not PlySLoop or PlySLoop == 0) then PlySLoop = ply:A_ActModLoop() end
						local GTab = GetTabAct
						local GokLoop = OnLoop and (OnLoop == 1 or OnLoop == 3) or not OnLoop and (PlySLoop == 1 or PlySLoop == 2) or istable(GTab) and GTab["noRAgain"]
						if (not istable(GTab) or not GTab["noRAgain"] or not isnumber(GTab["noRAgain"])) and ( (OnLoop and (OnLoop == 1 or OnLoop == 3 and AutoReAnim)) or not OnLoop and (PlySLoop == 1 or PlySLoop == 2 and AutoReAnim) ) then
							A_AM.ActMod:StartAniAct(ply, TStr ,true,Tab1,Tab2 ,nil,nil,nil,isH)
						else
							if ply:IsPlayer() then
								if SERVER then A_AM.ActMod:A_ActMod_OffActing( ply ) end
							else
								if CLIENT and ply.GLast and IsValid(ply.GLast) then
									ply.noR = true
									ply.GLast.noR = true
								end
							end
						end
					end end )
				end
			end
		end
	end
end

function A_AM.ActMod:GetTAniAct( ply,Str,rres )
	return A_AM.ActMod:StartAniAct( ply,Str,rres,nil,nil,nil,nil,true )
end

A_AM.ActMod.LuaAct_Done = true
