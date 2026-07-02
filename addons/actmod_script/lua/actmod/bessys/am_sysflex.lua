if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.StSysFlexs = true

local function ACrConV_cs(a1,...) if not ConVarExists(a1) then CreateConVar(a1,...) end end
ACrConV_cs("actmod_sv_huddebug", 0 , { FCVAR_REPLICATED, FCVAR_NOTIFY } )

A_AM.ActMod.FacialSyncs = A_AM.ActMod.FacialSyncs or {}
A_AM.ActMod.FacialSyncs.FlexCache = A_AM.ActMod.FacialSyncs.FlexCache or {}
A_AM.ActMod.FacialSyncs.TFlexs = A_AM.ActMod.FacialSyncs.TFlexs or {}
A_AM.ActMod.FacialSyncs.TmpSavPlyFw = A_AM.ActMod.FacialSyncs.TmpSavPlyFw or {}

if CLIENT then
	A_AM.ActMod.FacialSyncs.aaHUD_Data = A_AM.ActMod.FacialSyncs.aaHUD_Data or {}
	A_AM.ActMod.FacialSyncs.aaHUD_Data_fps = A_AM.ActMod.FacialSyncs.aaHUD_Data_fps or {}
end


local function CacheModelData(modelPath, modelType, bestTableName)
	A_AM.ActMod.FacialSyncs.FlexCache[modelPath] = A_AM.ActMod.FacialSyncs.FlexCache[modelPath] or {}
	A_AM.ActMod.FacialSyncs.FlexCache[modelPath].modelType = modelType
	A_AM.ActMod.FacialSyncs.FlexCache[modelPath].bestTableName = bestTableName
	A_AM.ActMod.FacialSyncs.FlexCache[modelPath].dances = A_AM.ActMod.FacialSyncs.FlexCache[modelPath].dances or {}
end

local function CacheDanceFlexTable(modelPath, danceName, flexTable)
	A_AM.ActMod.FacialSyncs.FlexCache[modelPath] = A_AM.ActMod.FacialSyncs.FlexCache[modelPath] or {}
	A_AM.ActMod.FacialSyncs.FlexCache[modelPath].dances = A_AM.ActMod.FacialSyncs.FlexCache[modelPath].dances or {}
	A_AM.ActMod.FacialSyncs.FlexCache[modelPath].dances[danceName] = {
		flexTable = flexTable,
		createdAt = os.time()
	}
end

local function GetCachedDance(modelPath, danceName)
	if not A_AM.ActMod.FacialSyncs.FlexCache[modelPath] then return nil end
	return A_AM.ActMod.FacialSyncs.FlexCache[modelPath].dances and A_AM.ActMod.FacialSyncs.FlexCache[modelPath].dances[danceName]
end


local function BuildValidFlexTable(ent, TabFlexDat ,useKeyAsFallback)
	local result = {}
	for key, aliases in pairs(TabFlexDat) do
		local id = ent:GetFlexIDByName(key)
		if id and id ~= -1 then
			result[key] = { i = id ,n = key ,s = "key" }
		else
			local found = false
			for _, flexName in ipairs(aliases) do
				local fid = ent:GetFlexIDByName(flexName)
				if fid and fid ~= -1 then
					result[key] = { i = fid ,n = flexName ,s = "alias" }
					found = true
					break
				end
			end
			if useKeyAsFallback and not found then
				result[key] = { i = -1 ,n = key ,s = "fallback" }
			end
		end
	end
	return result
end


local function ScoreFlexTable(ent, flexTable)
	local score,flexCount = 0,0
	for key, aliases in pairs(flexTable) do
		local keyID = ent:GetFlexIDByName(key)
		if keyID ~= -1 then
			score = score + 2
			flexCount = flexCount + 1
		else
			for _, name in ipairs(aliases) do
				local id = ent:GetFlexIDByName(name)
				if id ~= -1 then
					score = score + 1
					flexCount = flexCount + 1
					break
				end
			end
		end
	end
	return score, flexCount
end

local function ScoreFlexTableByDance(ent, flexTable, danceFlexList)
	local score,foundCount = 0,0
	for key, _ in pairs(danceFlexList) do
		if ent:GetFlexIDByName(key) ~= -1 then
			score = score + 2
			foundCount = foundCount + 1
		else
			local aliases = flexTable[key] or {}
			for _, name in ipairs(aliases) do
				if ent:GetFlexIDByName(name) ~= -1 then
					score = score + 1
					foundCount = foundCount + 1
					break
				end
			end
		end
	end

	return score, foundCount
end


local function PickBestFlexTable(ent)
	local bestType = nil
	local bestTable = nil
	local bestScore = -1
	local bestFlexCount = -1
	for modelType, flexTable in pairs(A_AM.ActMod.FlexDatabase) do
		local score, flexCount = ScoreFlexTable(ent, flexTable)
		if score > bestScore or (score == bestScore and flexCount > bestFlexCount) then
			bestScore = score
			bestFlexCount = flexCount
			bestType = modelType
			bestTable = flexTable
		end
	end
	return bestType, bestTable, bestScore, bestFlexCount
end

local function PickBestFlexTableForDance(ent, danceFlexList)
	local bestType, bestTable, bestScore, bestFound = nil, nil, -1, -1
	for modelType, flexTable in pairs(A_AM.ActMod.FlexDatabase) do
		local score, found = ScoreFlexTableByDance(ent, flexTable, danceFlexList)
		if score > bestScore or (score == bestScore and found > bestFound) then
			bestScore = score
			bestFound = found
			bestType = modelType
			bestTable = flexTable
		end
	end
	return bestType, bestTable, bestScore, bestFound
end


local function InitFaceFlexes(ent, danceName, flexDet)
	local FlexType = flexDet.TypeFlex or ""
	local useDanceFlexList = flexDet.allFlexNames
	local modelPath = ent:GetModel()

	local cached = GetCachedDance(modelPath, danceName)
	if cached then
		return {
			modelType = A_AM.ActMod.FacialSyncs.FlexCache[modelPath].modelType,
			flexTable = cached.flexTable,
			cached = true
		}
	end

	local modelType, flexTable

	if useDanceFlexList and next(useDanceFlexList) then
		modelType, flexTable = PickBestFlexTableForDance(ent, useDanceFlexList)
	else
		modelType, flexTable = PickBestFlexTable(ent)
	end

	local ValidFlexes = BuildValidFlexTable(ent, FlexType ~= "" and istable(A_AM.ActMod.FlexDatabase[FlexType]) and A_AM.ActMod.FlexDatabase[FlexType] or flexTable or A_AM.ActMod.FlexDatabase["MMD_v2"])

	CacheModelData(modelPath, modelType, FlexType ~= "" and FlexType or modelType)
	CacheDanceFlexTable(modelPath, danceName, ValidFlexes)

	return {modelType = modelType,flexTable = ValidFlexes,cached = false}
end




local function NormalizeFaceFlexData( tbl,sff )
	if not istable( tbl ) then return false end
	local frames = {}
	local allFlexNames = {}
	local maxFrame = 0
	local TypeFlex = ""
	for k, Tb in ipairs( tbl ) do
		local frame = tonumber( Tb.frame )
		if k == 1 and Tb.TypeFlex then TypeFlex = Tb.TypeFlex end
		if ( !frame or frame < 0 ) then continue end
		maxFrame = math.max( maxFrame, frame )
		local names = istable( Tb.flex_name ) and Tb.flex_name or {}
		local values = istable( Tb.value ) and Tb.value or {}
		local f = {}
		for i, name in ipairs( names ) do
			if ( !isstring( name ) ) then continue end
			allFlexNames[ name ] = true
			local v = tonumber( values[ i ] )
			if v == nil then v = 0 end
			f[ name ] = math.Clamp( v, 0, 1 )
		end
		frames[ frame ] = f
	end
	return maxFrame > 0,{ allFlexNames = allFlexNames ,maxFrame = #frames ,TmpmaxFrame = maxFrame ,frames = frames ,TypeFlex = TypeFlex }
end

local function NormalizeFaceFlexData_TF(tbl)
	if not istable(tbl) or not istable(tbl.tf) then return false end
	local frames = {}
	local allFlexNames = {}
	local TallFlexNames = {}
	local numsTF = 0
	local TypeFlex = tbl.TypeFlex or ""
	local By = tbl.by or ""
	if istable(tbl.flexes) then
		for k, name in ipairs(tbl.flexes) do
			if isstring(name) then
				allFlexNames[name] = true
				TallFlexNames[k] = name
			end
		end
	end
	if istable(tbl.tf) then
		for Knum, fr in ipairs(tbl.tf) do
			local frame = tonumber(Knum)
			numsTF = math.max(numsTF, frame)
			local f = {{},{}}
			if istable(fr[1]) and istable(fr[2]) then
				if fr[1][1] and fr[1][2] then
					f[1] = {fr[1][1],fr[1][2]}
				end
				if not table.IsEmpty(fr[2]) then
					for Numk, nv in pairs(fr[2]) do
						local Gv = tonumber(nv) or 0
						local Gn = TallFlexNames[Numk]
						if Gn then f[2][Numk] = Gv end
					end
				end
			end
			frames[frame] = f
		end
	end
	return numsTF > 0, {
		allFlexNames = allFlexNames,
		allFlexNames_Bum = TallFlexNames,
		MaxTF = numsTF,
		numsTF = #frames,
		tf = frames,
		IsTF = true,
		TypeFlex = TypeFlex,
		by = By
	}
end

local function NormalizeFaceFlexData_V1(tbl)
	if not istable(tbl) or not istable(tbl.frames) then return false end
	local frames = {}
	local allFlexNames = {}
	local TallFlexNames = {}
	local maxFrame = 0
	local TypeFlex = tbl.TypeFlex or ""
	local atype = tbl.schema or ""
	if istable(tbl.flexes) then
		for k, name in ipairs(tbl.flexes) do
			if isstring(name) then
				allFlexNames[name] = true
				TallFlexNames[k-1] = name
			end
		end
	end
	if istable(tbl.frames) then
		for Knum, fr in ipairs(tbl.frames) do
			local frame = tonumber(Knum-1)
			maxFrame = math.max(maxFrame, frame)
			local f = {}
			if istable(fr) then
				for Numk, nv in pairs(fr) do
					local Gv = tonumber(nv) or 0
					local Gn = TallFlexNames[Numk]
					if Gn then f[Gn] = math.Clamp(math.Round(Gv,3), 0,1) end
				end
			end
			frames[frame] = f
		end
	end
	return maxFrame > 0, {
		allFlexNames = allFlexNames,
		allFlexNames_Bum = TallFlexNames,
		maxFrame = #frames,
		TmpmaxFrame = maxFrame,
		TypeFlex = TypeFlex,
		frames = frames,
		type = atype
	}
end
local function NormalizeFaceFlexData_V2(tbl)
	if not istable(tbl) or not istable(tbl.flexes) or not istable(tbl.frames) then return false end
	local frames = {}
	local allFlexNames = {}
	local maxFrame = #tbl.frames
	local TypeFlex = tbl.TypeFlex or ""
	local atype = tbl.schema or ""
	if istable(tbl.flexes) then
		for _, name in ipairs(tbl.flexes) do
			if isstring(name) then allFlexNames[name] = true end
		end
	end
	if istable(tbl.frames) then
		for frameIndex, frameData in ipairs(tbl.frames) do
			local frame = tonumber(frameIndex-1)
			local indices = frameData[1]
			local values  = frameData[2]
			if not istable(indices) or not istable(values) then continue end
			local f = {}
			for i = 1, #indices do
				local flexIndex = indices[i]
				local v = tonumber(values[i]) or 0
				local flexName = tbl.flexes[flexIndex + 1]
				if flexName then f[flexName] = math.Clamp(v, 0, 1) end
			end
			frames[frame] = f
		end
	end
	return maxFrame > 0, {
		allFlexNames = allFlexNames,
		maxFrame = maxFrame,
		TmpmaxFrame = maxFrame,
		TypeFlex = TypeFlex,
		frames = frames,
		type = atype
	}
end

local function GTyNFaceFlexData(tbl)
	if tbl.tf then
		return NormalizeFaceFlexData_TF( tbl )
	end
	local attyp = ""
	if tbl.schema then attyp = tbl.schema end
	if attyp == "flex_anim_v3" then
		return NormalizeFaceFlexData_V2( tbl )
	elseif attyp == "flex_anim_v2" then
		return NormalizeFaceFlexData_V1( tbl )
	else
		return NormalizeFaceFlexData( tbl )
	end
end


local function BuildFlexIDMap( ent,flexDet )
	local map = {}
	if flexDet.allFlexNames then
		for flexName, _ in pairs( flexDet.allFlexNames ) do
			if ( !ent.GetFlexIDByName ) then break end
			local id = ent:GetFlexIDByName( flexName )
			if ( isnumber( id ) and id >= 0 ) then
				map[ flexName ] = id
			end
		end
	end
	return map
end

local function ALoadDat( path,nam,sff,fps )
	if not isstring(path) or not isstring( nam ) then return false end
	local json = file.Read( "data_static/".. path, "GAME" )
	if ( json and #json > 0 ) then
		local tbl = util.JSONToTable( json )
		if istable(tbl) and not table.IsEmpty(tbl) then
			local DatOK,Dat = GTyNFaceFlexData( tbl )
			if istable(Dat) and Dat.allFlexNames and (Dat.frames or Dat.IsTF and Dat.tf) then
				local tTbl = { allFlexNames = Dat.allFlexNames }
				if Dat.IsTF then
					if Dat.tf then
						tTbl.tf = Dat.tf
						tTbl.IsTF = true
						tTbl.maxFrame = 1
						if Dat.numsTF then tTbl.numsTF = Dat.numsTF end
						if Dat.TypeFlex and Dat.TypeFlex ~= "" then tTbl.TypeFlex = Dat.TypeFlex end
						if Dat.allFlexNames_Bum then tTbl.allFlexNames_Bum = Dat.allFlexNames_Bum end
					end
				else
					if Dat.frames then
						tTbl.frames = Dat.frames
						if Dat.maxFrame then tTbl.maxFrame = Dat.maxFrame end
						if Dat.TmpmaxFrame then tTbl.TmpmaxFrame = Dat.TmpmaxFrame end
						if Dat.TypeFlex and Dat.TypeFlex ~= "" then tTbl.TypeFlex = Dat.TypeFlex end
						if Dat.type and Dat.type ~= "" then tTbl.type = Dat.type end
						if sff then tTbl.AddS = sff end
						if fps then tTbl.FPS = fps end
					end
				end
				tTbl.source = path .. ""
				if tTbl.frames or tTbl.IsTF and tTbl.tf then
					A_AM.ActMod.FacialSyncs.TFlexs[nam] = tTbl
				end
				print( "[ActMod-flex] Loaded face flex data from " .. tostring(tTbl.source) .. " (frames: " .. tostring((tTbl.IsTF and Dat.numsTF) or not tTbl.IsTF and (tTbl.maxFrame .." |".. tTbl.TmpmaxFrame)) .. ")" )
				return true
			end
		end
	end
	return false
end
function A_AM.ActMod.Flex_LoadFileDat( pa,na,fp,as )
	local isDone = ALoadDat( pa,na,as,fp )
	return isDone
end

function A_AM.ActMod.FacialSyncs:Start(ply,emoteName)
	if GetConVarNumber("actmod_sv_syflex") == 0 or not IsValid(ply) then return end
	if CLIENT and ply == LocalPlayer() then A_AM.ActMod.FacialSyncs.aaHUD_Data = {} A_AM.ActMod.FacialSyncs.aaHUD_Data_fps = {} end
	if GetConVarNumber("actmod_sv_syflex") == 2 and SERVER and not ply:HasFlexManipulatior() and not A_AM.ActMod.FacialSyncs.TmpSavPlyFw[ply:SteamID64()] then
		for i = 0, 95 do if ply:GetFlexName(i) then ply:SetFlexWeight(i, ply:GetFlexWeight(i)) end end
		A_AM.ActMod.FacialSyncs.TmpSavPlyFw[ply:SteamID64()] = true
		return
	end
	local gT = A_AM.ActMod.FacialSyncs.TFlexs[emoteName]
	if not istable(gT) then
		if A_AM.ActMod.FacialSyncs[ply] then
			for i = 0, ply:GetFlexNum() - 1 do ply:SetFlexWeight(i, 0) end
			for i = 0, 95 do ply:SetFlexWeight(i, 0) end
			A_AM.ActMod.FacialSyncs[ply] = nil
		end
		return
	end
	A_AM.ActMod.FacialSyncs[ply] = { Active = true ,Agin = false ,LinkedEmote = emoteName ,TmpGetFlexs = {} ,IsTF = gT.IsTF }
end

function A_AM.ActMod.FacialSyncs:Stop( ply )
	if not IsValid(ply) then return end
	if CLIENT and ply == LocalPlayer() then A_AM.ActMod.FacialSyncs.aaHUD_Data = {} A_AM.ActMod.FacialSyncs.aaHUD_Data_fps = {} end
	if not A_AM.ActMod.FacialSyncs[ply] then A_AM.ActMod.FacialSyncs[ply] = nil return end
	for i = 0, ply:GetFlexNum() - 1 do ply:SetFlexWeight(i, 0) end
	for i = 0, 95 do ply:SetFlexWeight(i, 0) end
	A_AM.ActMod.FacialSyncs[ply] = nil
end

local function CalcFrame( ent,fps,gmaxFrame )
	local cycle = nil
	if ent.GetCycle then cycle = ent:GetCycle() else return 0 end
	local maxFrame = gmaxFrame or math.floor( (ent:SequenceDuration() or 0)*(fps or 30) )
	return math.floor( math.Clamp( cycle, 0, 1 ) * maxFrame + 1 + 1e-4 )
end

local function ApplyFrame( ent, s, flexDet,frame )
	local frameData = flexDet.frames and flexDet.frames[ frame+(flexDet.AddS or 0) ] or {}
	local mdl = ent:GetModel()
	
	if s.lastModel ~= mdl then
		for i = 0, ent:GetFlexNum() - 1 do ent:SetFlexWeight(i,0) end
		for i = 0, 95 do ent:SetFlexWeight(i, 0) end
		s.lastModel = mdl
		s.TmpGetFlexs = {}
		if CLIENT then A_AM.ActMod.FacialSyncs.aaHUD_Data = {} end
	end
	
	local faceData = InitFaceFlexes(ent, s.LinkedEmote ,flexDet)
	if faceData and faceData.flexTable then
		for k, VTb in pairs( faceData.flexTable ) do
			if VTb.n and VTb.i then
				local Name,id = VTb.n,VTb.i
				local w = frameData[ k ] or 0
				ent:SetFlexWeight( id, w )
				if not s.TmpGetFlexs then s.TmpGetFlexs = {} end
				s.TmpGetFlexs[id] = w
				if CLIENT and ent == LocalPlayer() then A_AM.ActMod.FacialSyncs.aaHUD_Data[Name] = {w,id} end
			end
		end
	end
	if CLIENT and ent == LocalPlayer() then A_AM.ActMod.FacialSyncs.aaHUD_Data_fps = {frame = frame ,maxFrame = flexDet.maxFrame ,RFFrame = flexDet.AddS and -flexDet.AddS or nil} end
end


local function A_AMFlex_TmpGF( ply,state )
	if not IsValid(ply) then return end
	local GMdl = ply:GetModel()
	local TmpGetFlexs = state.TmpGetFlexs
	if state.lastModel and state.lastModel == GMdl or istable(TmpGetFlexs) or table.IsEmpty(TmpGetFlexs) then
		for i = 0, ply:GetFlexNum() - 1 do
			local iv = TmpGetFlexs and TmpGetFlexs[i]
			if iv then ply:SetFlexWeight(i, iv) print(i,iv) end
		end
	end
end

local function GetPreviousFlexValue(flexDefs, currentIndex, flexN ,Agin)
	local aaa = not Agin and currentIndex == 1 and 0 or Agin and currentIndex == 1 and table.Count(flexDefs) or currentIndex - 1
	if aaa ~= 0 then
		local prev = flexDefs[aaa]
		if prev and prev[2] and prev[2][flexN] then
			return prev[2][flexN]
		end
	end
	return 0
end
local function SysThinkRn_v1(ent,state)
	if not ent.GetCycle then return end
	local mdl = ent:GetModel()
	local cycle = ent:GetCycle()
	local flexDefs = A_AM.ActMod.FacialSyncs.TFlexs[state.LinkedEmote]
	if not istable(flexDefs) or flexDefs.isTF or not istable(flexDefs.tf) then return end
	if state.lastModel ~= mdl then
		for i = 0, ent:GetFlexNum() - 1 do ent:SetFlexWeight(i,0) end
		for i = 0, 95 do ent:SetFlexWeight(i, 0) end
		state.lastModel = mdl
		state.TmpGetFlexs = {}
		if CLIENT then A_AM.ActMod.FacialSyncs.aaHUD_Data = {} end
	end
	local faceData = InitFaceFlexes(ent, state.LinkedEmote ,flexDefs)
	for i, def in ipairs(flexDefs.tf) do
		local defc = def[1]
		if cycle >= defc[1] and cycle < defc[2] then
			if i >= 2 then state.Agin = true end
			for kn, val in ipairs(def[2]) do
				local NumName = flexDefs.allFlexNames_Bum[kn]
				if faceData and faceData.flexTable then
					for k, VTb in pairs( faceData.flexTable ) do
						if VTb.n and VTb.i then
							local Name,id = VTb.n,VTb.i
							if Name ~= NumName then continue end
							local progress = (cycle - defc[1]) / (defc[2] - defc[1])
							progress = math.Clamp(progress, 0, 1)
							local from = GetPreviousFlexValue(flexDefs.tf, i, kn ,state.Agin)
							local new = Lerp(progress, from, val)
							ent:SetFlexWeight(id, new)
							if not state.TmpGetFlexs then state.TmpGetFlexs = {} end
							state.TmpGetFlexs[id] = new
							if CLIENT and ent == LocalPlayer() then A_AM.ActMod.FacialSyncs.aaHUD_Data[Name] = {new,id} end
							break
						end
					end
				end
			end
			break
		end
	end
	if CLIENT and ent == LocalPlayer() then A_AM.ActMod.FacialSyncs.aaHUD_Data_fps = {frame = cycle ,maxFrame = 1} end
end

local function SysThinkRn_v2(ply,state)
	if not ply.GetCycle then return end
	if not state.Active or not ply:A_ActMod_GetIsAct() then A_AM.ActMod.FacialSyncs:Stop(ply) return end
	local flexDet = A_AM.ActMod.FacialSyncs.TFlexs[state.LinkedEmote]
	if flexDet then
		local frame = CalcFrame( ply,flexDet.FPS or 30 )
		if not state.lastFrame or frame ~= state.lastFrame then
			ApplyFrame( ply, state, flexDet,frame )
			state.lastFrame = frame
		end
	end
end

function A_AM.ActMod.Flex_ThinkPly( ply )
	if SERVER and (GetConVarNumber("actmod_sv_syflex") == 0 or GetConVarNumber("actmod_sv_syflex") == 2) then return end
	if CLIENT and (GetConVarNumber("actmod_sv_syflex") == 0 or GetConVarNumber("actmod_sv_syflex") == 1) then return end
	if not IsValid(ply) then return end
	local state = A_AM.ActMod.FacialSyncs[ply]
	if istable(state) then
		if state.IsTF then SysThinkRn_v1(ply,state) else SysThinkRn_v2(ply,state) end
	end
end

function A_AM.ActMod.Flex_Think()
	if SERVER and (GetConVarNumber("actmod_sv_syflex") == 0 or GetConVarNumber("actmod_sv_syflex") == 2) then return end
	if CLIENT and (GetConVarNumber("actmod_sv_syflex") == 0 or GetConVarNumber("actmod_sv_syflex") == 1) then return end
	for k, ply in pairs(player.GetAll()) do
		if ply:A_ActMod_GetIsAct() then
			local state = A_AM.ActMod.FacialSyncs[ply]
			if istable(state) and state.Active then
				if state.IsTF then SysThinkRn_v1(ply,state) else SysThinkRn_v2(ply,state) end
			end
		end
	end
end

if SERVER then
	hook.Add("ActMod_sv_StartAniAct", "actmd_FacialSyncs", function(pl,atXt,tst) A_AM.ActMod.FacialSyncs:Start(pl,atXt) end)
end
if CLIENT then
	hook.Add("ActMod_cl_StartAniAct_A", "actmd_FacialSyncs", function(pl,atXt,tst) A_AM.ActMod.FacialSyncs:Start(pl,atXt) end)
	hook.Add("ActMod_cl_RunaPlyEmot", "actmd_FacialSyncs", function(pl) A_AM.ActMod.FacialSyncs:Stop(pl) end)
end
hook.Add("ActMod_RunStopAct", "actmd_FacialSyncs", function(pl) A_AM.ActMod.FacialSyncs:Stop(pl) end)

if CLIENT then
	local function DrawTableHUD(data, x, y, fp)
		local rowHeight = 16
		local barWidth  = 100
		local spacing   = 4
		if fp and data.frame and data.maxFrame then
			local fraction = math.Clamp(data.frame / (data.RFFrame and data.maxFrame-data.RFFrame or data.maxFrame), 0, 1)
			barWidth = barWidth*1.5 + (data.RFFrame and 50 or 0)
			surface.SetDrawColor(40, 40, 40, 200)
			surface.DrawRect(x, y, barWidth, rowHeight+2)
			surface.SetDrawColor(0, 170, 255, 220)
			surface.DrawRect(x, y, barWidth * fraction, rowHeight+2)
			draw.SimpleText(math.Round(fraction * 100) .. "%  ( ".. math.Round(data.frame,8) .. " / " .. (data.RFFrame and data.maxFrame+data.RFFrame.. " [".. data.maxFrame .."] " or data.maxFrame) ..")","DermaDefaultBold",x + barWidth / 2,y + rowHeight / 2,color_white,1,1)
			draw.SimpleText("FPS / Frames","ChatFont",x+barWidth*1.05,y + rowHeight / 2,color_white,0,1)
			return
		end
		
		local i = 0
		for key, T in SortedPairs(data) do
			i = i + 1
			local value = math.Clamp(T[1], 0, 1)
			local rowY = y + (i - 1) * (rowHeight + spacing)
			surface.SetDrawColor(40, 40, 40, 200)
			surface.DrawRect(x, rowY, barWidth, rowHeight)
			surface.SetDrawColor(0, 170, 255, 220)
			surface.DrawRect(x, rowY, barWidth * value, rowHeight)
			draw.SimpleText(math.Round(value * 100) .. "%","DermaDefaultBold",x + barWidth / 2,rowY + rowHeight / 2,color_white,1,1)
			draw.SimpleText(T[2],"TargetID",x-2,rowY + rowHeight / 2,color_white,2,1)
			draw.SimpleText(key,"TargetID",x+barWidth*1.05,rowY + rowHeight / 2,color_white,0,1)
		end
	end

	hook.Add("HUDPaint", "Draw_Table_HUD", function()
		if GetConVarNumber("actmod_sv_huddebug") == 0 then return end
		if GetConVarNumber("actmod_sv_huddebug") == 1 then
			if A_AM.ActMod.FacialSyncs.aaHUD_Data_fps then DrawTableHUD(A_AM.ActMod.FacialSyncs.aaHUD_Data_fps, 30, 15 ,true) end
			if A_AM.ActMod.FacialSyncs.aaHUD_Data then DrawTableHUD(A_AM.ActMod.FacialSyncs.aaHUD_Data, 35, 40) end
		end
		if GetConVarNumber("actmod_sv_huddebug") > 1 then
			local LT = LocalPlayer():GetEyeTrace().Entity
			if IsValid(LT) then
				draw.SimpleText( "GetFlexScale: " .. LT:GetFlexScale() , "TargetID", 100, 16, color_white )
				for i=0, LT:GetFlexNum() - 1 do
					draw.SimpleText( tostring( i ) .. " - " .. LT:GetFlexName( i ) , "TargetID", 100, 30 + i * 12, color_white )
					draw.SimpleText( ("%0.3f"):format( LT:GetFlexWeight( i ) ), "TargetID", 300, 30 + i * 12, color_white )
				end
			end
		end
	end)
end
