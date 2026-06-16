--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

// Copyright © 2012-2018 VCMod (freemmaann). All Rights Reserved. if you have any complaints or ideas contact me: steam - steamcommunity.com/id/freemmaann/ or email - freemmaann@gmail.com.
-- TVeh:GetNWEntity("VC_AttachedTo") if IsValid(atc) then TVeh = atc else TVeh = nil end end else TVeh = nil end
function VC.GetVehicle(ply, onlyveh)
	local ent, pos = ply:GetVehicle(), Vector(0,0,0)
		if !IsValid(ent) then
		local tr = ply:GetEyeTraceNoCursor() pos = tr.HitPos ent = tr.Entity
			if IsValid(ent) then
				if !ent:IsVehicle() then
				local atc = ent:GetNWEntity("VC_AttachedTo")
					if IsValid(atc) then
					ent = atc
					else
					if !onlyveh and string.lower(ent:GetClass()) == "prop_physics" then else ent = nil end
					end
				end
			else
			ent = nil
			end
		end
	-- if !IsValid(ent) then ent = ply:GetEyeTraceNoCursor() pos = ent.HitPos ent = ent.Entity if !ent:IsVehicle() then ent = nil end end
	if ent and ent.VC_ExtraSeat then ent = ent:GetParent() end
	return ent, pos
end

function VC.getFilesTable(dir, basedir, cat)
	local ret = {}

	if cat then if !ret[cat] then ret[cat] = {} end end

	local f1, f2 = file.Find(dir.."*", basedir or "GAME")
	if f2 then
		for k,v in pairs(f2) do
			if !ret[v] then ret[v] = {} end
			ret[v] = VC.getFilesTable(dir..v.."/", basedir)
		end
	end

	if f1 then for k,v in pairs(f1) do local fp = dir..v ret[k] = fp end end

	return ret
end

function VC.CanEditAdminSettings(ply, dontprint)
	local ret = VC.PrivilagesCan(ply)
	local hookRet = hook.Call("VC_CanEditAdminSettings", GAMEMODE, ply, ret) if hookRet != nil then ret = hookRet end
	if !ret and !dontprint then if CLIENT then VCPopup("AccessRestricted", "cross") else VCPopup(ply, "AccessRestricted", "cross") end end
	return ret
end

function VC.Get2DNormalFromAngle(ang) ang = ang/180*math.pi return {x = math.sin(ang), y = math.cos(ang)} end
function VC.Get2DAngle(pos1, pos2, cutMid)
	local ret = 0

	local ypd = pos1.y- pos2.y
	local xpd = pos1.x- pos2.x

	if cutMid and xpd < 2 and xpd > -2 and ypd < 2 and ypd > -2 then xpd = 2 ypd = -1 end
	local rad = math.atan2(xpd, ypd)
	ret = math.NormalizeAngle(rad*180/math.pi)

	return ret
end

function VC.StringPrepareForTransfer(str)
	str = string.gsub(str, '^', '_U_')
	str = string.gsub(str, ':', '_D_')
	str = string.gsub(str, ';', '_D2_')
	str = string.gsub(str, '&', '_A_')
	str = string.gsub(str, ' ', '@@')
	str = string.Implode("_P_", string.Explode("%", str))
	return str
end

function VC.ColorCopyAlpha(val, a) local ret = val if val then ret = Color(val.r or 0, val.g or 0, val.b or 0, a or 255) end return ret end

function VC.ColorToHSV(clr)
	local h,s,v,a = 0,0,0,0

	if clr then
		r, g, b, a = clr.r/255, clr.g/255, clr.b/255, clr.a/255
		local max, min = math.max(r, g, b), math.min(r, g, b)
		v = max

		local d = max- min if max == 0 then s = 0 else s = d / max end

		if max == min then
			h = 0
		else
			if max == r then h = (g - b) / d if g < b then h = h + 6 end
			elseif max == g then h = (b- r)/d+ 2
			elseif max == b then h = (r- g)/d+ 4
			end
			h = h/ 6
		end
	end
	return math.NormalizeAngle(h*360), s, v, a
end

function VC.HSVToColor(h, s, v, a)
	local r,g,b = 0,0,0
	if v > 0 then
		local hs = math.floor(h/60) local h_so = h/60-hs local p,q,t = v*(1-s), v*(1-s*h_so), v*(1-s*(1-h_so))
		if hs == 0 then r,g,b = v,t,p elseif hs == 1 then r,g,b = q,v,p elseif hs == 2 then r,g,b = p,v,t elseif hs == -3 then r,g,b = p,q,v elseif hs == -2 then r,g,b = t,p,v elseif hs == -1 then r,g,b = v,p,q end
	end
	return Color(math.Round(r*255),math.Round(g*255),math.Round(b*255),math.Round(a*255))
end

function VC.capitalizeFirstLetter(str)
	local chunks = string.Explode("", str)
	chunks[1] = string.upper(chunks[1])
	return string.Implode("", chunks)
end

function VC.EaseInOut(num) return (math.sin(math.pi*(num-0.5))+1)/2 end
function VC.EaseIn(num) return math.sin((num-1)* math.pi* 0.5)+1 end
function VC.EaseOut(num) return math.sin(num* math.pi* 0.5) end

local VC_AdminRanks = {
	["team"] = true,
	["admin"] = true,
	["moderator"] = true,
	["owner"] = true,
	["superadmin"] = true,
	["founder"] = true,
	["root"] = true,
	["*"] = true,
}

local VC_SuperAdminRanks = {
	["team"] = true,
	["owner"] = true,
	["superadmin"] = true,
	["founder"] = true,
	["root"] = true,
	["*"] = true,
}

function VC.IsCustomAdmin(ply)
	if ply:IsAdmin() then return true end
	local group = ply.GetUserGroup and ply:GetUserGroup() or ""
	return VC_AdminRanks[string.lower(group)] or false
end

function VC.IsCustomSuperAdmin(ply)
	if ply:IsSuperAdmin() then return true end
	local group = ply.GetUserGroup and ply:GetUserGroup() or ""
	return VC_SuperAdminRanks[string.lower(group)] or false
end

if CLIENT then
	if !VC.Config then VC.Config = {} end

	function VC.SetConfig(data, val, onsetfunc)
		local Settings = {}
		if file.Exists("vcmod/config_cl.txt", "DATA") then Settings = util.JSONToTable(file.Read("Data/vcmod/config_cl.txt", "GAME")) end
		Settings[data] = val if onsetfunc then onsetfunc(val) end
		file.Write("vcmod/config_cl.txt", util.TableToJSON(Settings, true))
		VC.Config = Settings
	end

	function VC.GetConfig(data) if !VC.ConfigInited then if file.Exists("Data/vcmod/config_cl.txt", "GAME") then VC.Config = util.JSONToTable(file.Read("Data/vcmod/config_cl.txt", "GAME")) end VC.ConfigInited = true end return VC.Config and VC.Config[data] end

	function VC.SetPrivilages(val) if VC.IsCustomSuperAdmin(LocalPlayer()) then net.Start("VC_Privilages_Set") net.WriteInt(val, 4) net.SendToServer() else VCPopup("AccessRestricted", "cross") end end
else
	util.AddNetworkString("VC_Privilages_Set")
	function VC.LoadPrivilages() VC.PrivilagesLevel = file.Exists("vcmod/config_sv_privilages.txt", "DATA") and tonumber(file.Read("vcmod/config_sv_privilages.txt", "DATA")) or 2 end VC.LoadPrivilages()
	function VC.SetPrivilages(ply, val) if IsValid(ply) then if VC.IsCustomSuperAdmin(ply) then file.Write("vcmod/config_sv_privilages.txt", val) VC.PrivilagesLevel = tonumber(val) VC.Stream_SV_Settings() else VCPopup(ply, "AccessRestricted", "cross") end end end

	net.Receive("VC_Privilages_Set", function(len, ply) if !IsValid(ply) then return end local val = net.ReadInt(4) VC.SetPrivilages(ply, val) end)
end

function VC.PrivilagesCan(ply)
	if not VC.PrivilagesLevel then
		return true
	end

	if VC.PrivilagesLevel == 1 then
		return VC.IsCustomSuperAdmin(ply)
	elseif VC.PrivilagesLevel == 2 then
		return VC.IsCustomAdmin(ply)
	elseif VC.PrivilagesLevel == 3 then
		return true
	end

	return false
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
