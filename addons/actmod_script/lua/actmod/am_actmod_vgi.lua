if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaVgi = true
A_AM.ActMod.TablEditSounds = A_AM.ActMod.TablEditSounds or {}

if SERVER then return end

local Actoji = A_AM.ActMod.Actoji
A_AM.ActMod.FindIt = {}
if Actoji and IsValid(Actoji.Underlay) then
	if IsValid(Actoji.Underlay.modelmenu) then Actoji.Underlay.modelmenu:Remove() end
	Actoji.Underlay:Remove()
end

A_AM.ActMod.TLang = {"en", "ru", "zh-CN", "de", "tr"}
local function RoundDT(num) return math.floor(num / 10) * 10 end
local w,h = ScrW() / 1.08 ,ScrH() / 1.08
if w > h then w = h else h = w end
local ActMod_a4_SC = A_AM.ActMod:CGFont("ActMod_a4_SC", {font = "Roboto Regular",size = w*0.016})

A_AM.ActMod.GetIDNames = A_AM.ActMod.GetIDNames or {}
local GetIDNames = A_AM.ActMod.GetIDNames

local function ReString(st, tam4)
    return A_AM.ActMod:ReString(st, tam4)
end

local function RvString(ara)
    return A_AM.ActMod:RvString(ara)
end

function A_AM.ActMod:ExistsMaterial(path) local mat = Material(path) return mat and not mat:IsError() end

function A_AM.ActMod:Mar_TabDat(tbl, str, hlp)
    if tbl and tbl ~= "false" then
        for k, v in pairs(tbl) do
            if hlp then print("Get_", str, "-> ", v, "==", str, v == str) end
            if str and v == str then return true end
        end
    end
    return false
end
local function Mar_TabDat(tbl, str, hlp)
	return A_AM.ActMod:Mar_TabDat(tbl, str, hlp)
end

function A_AM.ActMod:RefshEmot(aSlot)
	if Actoji and Actoji.Frame and IsValid(Actoji.Frame) and Actoji.Frame.TabEmots and istable(Actoji.Frame.TabEmots) then
		local TblIc = Actoji.Frame.TabEmots
		if TblIc[aSlot] and IsValid(TblIc[aSlot]) then
			TblIc = TblIc[aSlot]
			local TActData = A_AM.ActMod:GetEmoIcn( aSlot,A_AM.ActMod:ActaLoed(A_AM.ActMod:ActojTyp(aSlot),A_AM.ActMod.aNTyp[aSlot]) )
			if TActData and istable(TActData) and TActData[1] and TActData[2] then
				TblIc.Material = TActData[1]
				TblIc.Actoji = TActData[2]
				TblIc.Alptxt = A_AM.ActMod:ReNameAct(ReString(TblIc.Actoji))
				TblIc.txtMat = TActData[3]
				if GetConVarNumber("actmod_cl_showsholightic") > 0 then TblIc.WMaterial = A_AM.ActMod:GetWMaterial(TblIc.txtMat, 128, 128) end
			end
			if type(TblIc.Material) ~= "IMaterial" or TblIc.Material:IsError() then TblIc.Material = Material("actmod/imenu/p_none.png","noclamp smooth") TblIc.MatE = true else TblIc.MatE = false end
			local shv = ReString(TblIc.Actoji)
			local IsBLocd = A_AM.ActMod:IsDanceBlacklisted(TblIc.Actoji)
			local vt = "amod_cumact_".. shv
			local GTabActO = A_AM.ActMod.GTabActO[shv]
			local GTabActO_CTA = A_AM.ActMod.GTabActO[vt]
			local si_CTA_Other = GTabActO_CTA and GTabActO_CTA["class"]
			TblIc.IMeNum = isnumber(si_CTA_Other) and (si_CTA_Other > 40 and si_CTA_Other < 50 and "actmod/imenu/dcomn.png" or si_CTA_Other > 0 and si_CTA_Other < 10 and "actmod/imenu/is_cm.png" or si_CTA_Other > 60 and istable(A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)]) and isstring(A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)].i) and A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)].i ~= "" and A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)].i)
			TblIc.isG = (GTabActO_CTA and isnumber(GTabActO_CTA["NoStop"]) and GTabActO_CTA["NoStop"] == 63) or (GTabActO and isnumber(GTabActO["NoStop"]) and GTabActO["NoStop"] == 63)
			TblIc.IsBLocd = IsBLocd
			if IsBLocd and not TblIc.SCurr then TblIc.SCurr = true TblIc:SetCursor("arrow") elseif not IsBLocd and TblIc.SCurr then TblIc.SCurr = false TblIc:SetCursor("hand") end
			TblIc.txtwa = A_AM.ActMod.aGetTextSize(TblIc.MatE and shv or TblIc.Alptxt,ActMod_a4_SC)			
		end
	end
end

local function ActLoadIcons()
    Actoji.Valid = {}
	for i = 1 , 74 do
		table.insert(Actoji.Valid, A_AM.ActMod.AGetDitN[i])
	end
end
ActLoadIcons()


local function AtabValid(a)
	local ATDa = Actoji.Valid[a]
	if Actoji and istable(Actoji.table) and isstring(Actoji.table[a]) and not Material(A_AM.ActMod:RIPng(Actoji.table[a]), "noclamp smooth"):IsError() then ATDa = Actoji.table[a] end
	return ATDa
end


local function SanitizeIconTable(tbl, maxCount)
    if not istable(tbl) then return false end
    maxCount = maxCount or 8
    local num = 0
    local TmpTab = table.Copy(tbl)
    for k, v in ipairs(TmpTab) do
		num = num + 1
        if num > maxCount or not isstring(v) then tbl[k] = nil end
    end
	TmpTab = nil
	return true
end
local function ToIndexedTable(tbl,maxCount)
    local newTable,nn = {},0
    for kk, value in SortedPairs(tbl) do
		if not isstring(value) then continue end nn = nn + 1
		if isnumber(maxCount) and kk > maxCount then break else table.insert(newTable, value) end
    end
    return newTable
end
local function SanitizeIconsAllTable(tbl)
    if not istable(tbl) then return false end
	local TmpTab = table.Copy(tbl)
	for Gk, Gv in pairs(TmpTab) do
		if (Gk ~= "ActModBy" and Gk ~= "ActModDataV" and Gk ~= "DatU" and Gk ~= "DatF" and Gk ~= "Actojifavo" and Gk ~= "ActojiDNew1" and Gk ~= "TimeString") and istable(Gv) then
			local num,maxCount = 0,8
			if Gk == "ActojiDialh" then maxCount = 10 end
			tbl[Gk] = ToIndexedTable(tbl[Gk],maxCount)
		end
    end
	TmpTab = nil
	return true
end

function A_AM.ActMod:LCImagePanel(parent, images, vertical, startX, startY, imgSize, spacing ,align)
    if not IsValid(parent) or type(images) ~= "table" then return end
    imgSize = imgSize or 48
    spacing = spacing or 6
    offsetX = startX or 0
    offsetY = startY or 0
    local imgs = {}
    local function updatePositions()
        if not IsValid(parent) then return end
        local pw, ph = parent:GetWide(), parent:GetTall()
        local count = #imgs
        if count == 0 then return end
        local total = count * imgSize + (count - 1) * spacing
        if vertical then
            local baseX = math.floor((pw - imgSize) / 2) + offsetX
            local startY = math.floor((ph - total) / 2) + offsetY
            local off = 0
            for i, img in ipairs(imgs) do
                if IsValid(img) then img:SetPos(baseX, startY + off) end
                off = off + imgSize + spacing
            end
        else
            local baseY = math.floor((ph - imgSize) / 2) + offsetY
            local startX = math.floor((pw - total) / 2) + offsetX
            local off = 0
            for i, img in ipairs(imgs) do
                if IsValid(img) then img:SetPos(startX + off, baseY) end
                off = off + imgSize + spacing
            end
        end
    end
    for _, path in ipairs(images) do
        local d = vgui.Create("DImage", parent)
        d:SetImage(path)
        d:SetSize(imgSize, imgSize)
        d:SetMouseInputEnabled(false)
        table.insert(imgs, d)
    end
    if not parent.__center_lists_hooked then
        parent.__center_lists_hooked = true
        parent.__center_lists = parent.__center_lists or {}
        local oldOnSize = parent.OnSize
        parent.OnSize = function(s, w, h)
            if oldOnSize then oldOnSize(s, w, h) end
            for _, fn in ipairs(s.__center_lists or {}) do
                pcall(fn)
            end
        end
    end
    table.insert(parent.__center_lists, updatePositions)
    updatePositions()
    return {
        images = imgs,
        update = updatePositions,
        destroy = function()
            for _, d in ipairs(imgs) do if IsValid(d) then d:Remove() end end
            if IsValid(parent) and parent.__center_lists then
                for i = #parent.__center_lists, 1, -1 do
                    if parent.__center_lists[i] == updatePositions then
                        table.remove(parent.__center_lists, i)
                    end
                end
            end
        end
    }
end
function A_AM.ActMod:IsMouseInPanel(p,ax,ay,aw,ah)
    local mx, my = gui.MousePos()
    local x, y = p:LocalToScreen(0, 0)
    local w, h = p:GetSize()
	if ax then x = x + ax end
	if ay then y = y + ay end
	if aw then w = aw end
	if ah then h = ah end
    return mx >= x and mx <= x + w and my >= y and my <= y + h
end

function A_AM.ActMod:ListGInfoAct(IDName)
	if not isstring(IDName) then return end
	local shv = ReString(IDName)
	local ActName,NSeq = A_AM.ActMod:ReNameAct(shv),shv
	local kt,TabAbut,GTabActO,Aimages,iskt = string.lower(shv):gsub("%s+$", ""),{},{},{},false
	if istable(A_AM.ActMod.GTabActO) then
		if istable(A_AM.ActMod.GTabActO[kt]) and not table.IsEmpty(A_AM.ActMod.GTabActO[kt]) then GTabActO = A_AM.ActMod.GTabActO[kt] iskt = true end
		if not iskt then
			kt = "amod_cumact_".. shv
			if istable(A_AM.ActMod.GTabActO[kt]) and not table.IsEmpty(A_AM.ActMod.GTabActO[kt]) then GTabActO = A_AM.ActMod.GTabActO[kt] end
		end
		if istable(A_AM.ActMod.HaseTablSounds[kt]) or istable(A_AM.ActMod.HaseTablSounds[shv]) then table.insert(Aimages,"icon16/sound.png") end
		local ok_Mov = false
		if not table.IsEmpty(GTabActO) then
			if GTabActO then
				if isstring(GTabActO.GetName) then ActName = GTabActO.GetName end
				if isstring(GTabActO.RNAnim) then NSeq = GTabActO.RNAnim end
				if istable(GTabActO.TabInclusion) and istable(GTabActO.TabInclusion.Models) or istable(A_AM.ActMod.AdScrpt) and (isfunction(A_AM.ActMod.AdScrpt[kt]) or isfunction(A_AM.ActMod.AdScrpt[shv])) then table.insert(Aimages,"actmod/imenu/ic_star_01.png") end
				if GTabActO.MoveDir then ok_Mov = true end
				if A_AM.ActMod.clo_IMeun_Num == 15 then TabAbut.Class = GTabActO.class end
				if istable(GTabActO.About) and isstring(GTabActO.About.Author) then
					TabAbut.Author = GTabActO.About.Author
					if isstring(GTabActO.About.S64) then TabAbut.S64 = GTabActO.About.S64 end
					if isstring(GTabActO.About.Version) then TabAbut.Version = GTabActO.About.Version end
				end
			end
		else
			if istable(A_AM.ActMod.AdScrpt) and (isfunction(A_AM.ActMod.AdScrpt[kt]) or isfunction(A_AM.ActMod.AdScrpt[shv])) then table.insert(Aimages,"actmod/imenu/ic_star_01.png") end
		end
		if istable(A_AM.ActMod.GTabActCoop[kt]) and (A_AM.ActMod.GTabActCoop[kt].ani_pl1 or A_AM.ActMod.GTabActCoop[kt].ani_pl1) or istable(A_AM.ActMod.GTabActCoop[shv]) and (A_AM.ActMod.GTabActCoop[shv].ani_pl1 or A_AM.ActMod.GTabActCoop[shv].ani_pl1) then table.insert(Aimages,"icon16/group.png") end
		if istable(A_AM.ActMod.FacialSyncs.TFlexs[kt]) or istable(A_AM.ActMod.FacialSyncs.TFlexs[shv]) then table.insert(Aimages,"icon16/emoticon_grin.png") end
		if ok_Mov or istable(A_AM.ActMod.GTabActWlk[kt]) and A_AM.ActMod.GTabActWlk[kt].walk or istable(A_AM.ActMod.GTabActWlk[shv]) and A_AM.ActMod.GTabActWlk[shv].walk then table.insert(Aimages,"actmod/imenu/ic_traversal.png") end
	end
	if IsValid(A_AM.ActMod.LAboit) then A_AM.ActMod.LAboit:Remove() end
	A_AM.ActMod.LAboit = vgui.Create("DFrame")
	local LAboit = A_AM.ActMod.LAboit
	local aMaterial = Material(A_AM.ActMod:RIPng(IDName), "noclamp smooth")
	if aMaterial:IsError() then aMaterial = Material("actmod/imenu/p_none.png", "noclamp smooth") end
	LAboit:SetSize(570, 300)
	LAboit:SetPos(ScrW()/2 -LAboit:GetWide()/2, ScrH()/2 - LAboit:GetTall()/2)
	LAboit:MakePopup() LAboit:SetTitle("ActMod:   ".. ActName)
	LAboit.tkkl = 0
	LAboit.tkklMax = 600
	LAboit.li = vgui.Create("DPanel", LAboit)
	LAboit.li:Dock(FILL)
	LAboit.li.NAuthor = istable(GetIDNames) and isstring(GetIDNames[TabAbut.Author]) and GetIDNames[TabAbut.Author] or TabAbut.Author or "_?nil"
	LAboit.li.sNA1 = A_AM.ActMod.aGetTextSize(LAboit.li.NAuthor,"ActMod_a3")
	LAboit.li.sNA2 = A_AM.ActMod.aGetTextSize(LAboit.li.NAuthor,"ActMod_a5")
	LAboit.li.txt0 = aR:T("LGPly_NoneAuthor")
	LAboit.li.txt1 = aR:T("LGPly_Author")
	LAboit.li.txt2 = aR:T("LGPly_Version")
	LAboit.li.nnam = aR:T("LAchievements_Name")
	LAboit.li.qnam = "Sequence :"
	local aamax = 323
	LAboit.li.txtwa = A_AM.ActMod.aGetTextSize(ActName,"ActMod_a2")
	LAboit.li.txtseq = A_AM.ActMod.aGetTextSize(NSeq,"ActMod_a2")
	local sm1,sm2 = A_AM.ActMod.aGetTextSize(aR:T("LAchievements_Name"),"ActMod_a1")
	local qm1,qm2 = A_AM.ActMod.aGetTextSize(LAboit.li.qnam,"ActMod_a1")
	local function att(anme,a2,a4,a5)
		local Butt = LAboit.li:Add("DButton") Butt:SetText("")
		Butt:SetSize(a4+12,a5+6) Butt:SetAlpha(0)
		timer.Simple(0.05,function() Butt:SetPos(LAboit.li:GetWide()/2-Butt:GetWide()/2+LAboit.li:GetTall()/2,a2) Butt:SetAlpha(255) end)
		Butt.Paint = function(p, w, h)
			draw.SimpleText(anme, "ActMod_a1", w/2, h/2, Color(255, 255, 255), 1, 1)
			if p:IsHovered() then surface.SetDrawColor(p:IsDown() and Color(50,50,200) or Color(0,50,150)) surface.DrawOutlinedRect(0, 0, w, h, 3) end
		end
		return Butt
	end
	local Butt = att(LAboit.li.nnam,10,sm1,sm2)
	Butt.DoClick = function(s) SetClipboardText(ActName) A_AM.ActMod:aShowCopy(s) end
	local Butt2 = att(LAboit.li.qnam,80,qm1,qm2)
	Butt2.DoClick = function(s) SetClipboardText(NSeq) A_AM.ActMod:aShowCopy(s) end
	local function att(pan,w,h,hh,ActName,sss,bt)
		local mw,mh,wa = w/2+h/2,hh,math.min(sss+8,aamax)
		draw.RoundedBox(0, mw-wa/2, mh-12,wa+2,24, bt:IsDown() and Color(50,50,200) or bt:IsHovered() and Color(0,50,150) or Color(0,0,0,100))
		if sss > aamax then
			draw.ScrollingText(ActName, "ActMod_a2", mw-wa/2,mh, Color(255,255,255), 0,1 ,wa,pan,2)
		else
			draw.SimpleText(ActName, "ActMod_a2", mw,mh, Color(255,255,255),1,1)
		end
	end
	LAboit.li.amov1 = 0
	LAboit.li.amov2 = 0
	LAboit.li.INIP = false
	LAboit.li.Paint = function(s, w, h)
		s.INIP = s:IsHovered() and A_AM.ActMod:IsMouseInPanel(s,10,10,h-20,h-20)
		if iskt then
			draw.SimpleText("AhmedMake400", "ActMod_a3", w/2+h/2,h-40, Color(255, 255, 155), 1, 1)
		elseif TabAbut.Author then
			local mw,mh,wa,ff = h+10+(TabAbut.S64 and 40 or 0), h-40 ,(TabAbut.S64 and s.sNA2 or s.sNA1) ,TabAbut.S64 and "ActMod_a5" or "ActMod_a3"
			draw.SimpleText(s.txt1 .." :", "ActMod_a3", h+2, h-70, Color(255, 255, 255), 0, 1)
			if wa > 240 then
				draw.ScrollingText(s.NAuthor,ff, mw,mh, color_white,0,1 ,wa,s,2)
			elseif wa > 175 then
				draw.SimpleText(s.NAuthor,"ActMod_a5", mw,mh,color_white,0,1)
			else
				draw.SimpleText(s.NAuthor,"ActMod_a3", mw,mh+8,color_white,0,1)
			end
			if TabAbut.Version then
				draw.SimpleText(s.txt2 ..": ".. TabAbut.Version, "ActMod_a4", w-10, h-17, Color(200, 200, 255), 2, 1)
			end
		else
			draw.SimpleText(s.txt0, "ActMod_a5", w/2+h/2,h-40, Color(255, 255, 155), 1, 1)
		end
		draw.RoundedBox(4, 2, 2, w-4, h-4, Color(20,60,255,70))
		draw.RoundedBox(0, 10, 10, h-20, h-20, Color(255,255,255,30))
		att(s,w,h,55,ActName,s.txtwa,Butt)
		att(s,w,h,125,NSeq,s.txtseq,Butt2)
		local aRFT = RealFrameTime()
		if s.INIP then s.amov1 = math.Round(Lerp(15 * aRFT, s.amov1+0.001, 100),3) else s.amov1 = math.Round(Lerp(14 * aRFT, s.amov1-0.001, 0),3) end
		if s.amov1 > 0 then
			local aa = math.Clamp((LAboit.tkkl*1.5-LAboit.tkklMax*0.8)/255,0,1)
			if aa == 1 then
				surface.SetDrawColor(Color(140,200,255,255))
				surface.SetMaterial(Material("gui/gradient_up", "noclamp smooth"))
				surface.DrawTexturedRect(10, 10, h-20, h-20)
			else
				surface.SetDrawColor(Color(255,255,255,255*(1-aa))) surface.SetMaterial(aMaterial) surface.DrawTexturedRect(10, 10, h-20, h-20)
				surface.SetDrawColor(Color(140,200,220,math.Clamp(LAboit.tkkl*2-LAboit.tkklMax*0.9,0,255)))
				surface.SetMaterial(Material("gui/gradient_up", "noclamp smooth"))
				surface.DrawTexturedRect(10, 10+(h-20)*(1-aa), h-20, (h-20)*aa)
			end
		else
			surface.SetDrawColor(Color(255,255,255,255)) surface.SetMaterial(aMaterial) surface.DrawTexturedRect(10, 10, h-20, h-20)
		end
	end
	
	timer.Simple(0.05,function() A_AM.ActMod:LCImagePanel(LAboit.li, Aimages, false, LAboit.li:GetTall()/2,40,20,10) end)
	
	
	if TabAbut.Author and TabAbut.S64 then
		local avatar = LAboit.li:Add('AvatarImage')
		avatar:SetSteamID(TabAbut.S64, 32)
		avatar:SetSize(40, 40) avatar:SetPos(LAboit:GetWide()/2-15, LAboit:GetTall()-85)
		local Bava = avatar:Add('DButton')
		Bava:Dock(FILL) Bava:SetText("")
		Bava.DoClick = function(p) gui.OpenURL("https://steamcommunity.com/profiles/" .. TabAbut.S64) end
		Bava.Paint = function(p, w, h)
			if p:IsHovered() then
				surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
				surface.DrawOutlinedRect(0, 0, w, h, 3 + (2 * math.sin(CurTime() * 4)))
			end
		end
		A_AM.ActMod:GetNameA(TabAbut.S64, function(Gname, Gonln)
			if IsValid(LAboit.li) and Gname ~= "nonE" then
				GetIDNames[TabAbut.Author] = Gname
				LAboit.li.NAuthor = Gname
				LAboit.li.sNA1 = A_AM.ActMod.aGetTextSize(LAboit.li.NAuthor,"ActMod_a3")
				LAboit.li.sNA2 = A_AM.ActMod.aGetTextSize(LAboit.li.NAuthor,"ActMod_a5")
			end
		end)
	end
	
	LAboit.aanu = vgui.Create("DLabel", LAboit.li)
	LAboit.aanu:SetSize(LAboit.li:GetTall()-20, LAboit.li:GetTall()-20)
	LAboit.aanu:SetPos(10, 10)
	timer.Simple(0.05,function() LAboit.aanu:SetSize(LAboit.li:GetTall()-20, LAboit.li:GetTall()-20) LAboit.aanu:SetAlpha(255) end)
	LAboit.aanu:SetText("")
	LAboit.aanu.OnRemove = function(self) if IsValid(LAboit.modelmenu) then LAboit.modelmenu:Remove() end end
	LAboit.aanu.Paint = function( ste, w, h )
		if LAboit.li.INIP or LocalPlayer().ActMod_cl_MisDragging then
			if LAboit.modelmenu and IsValid(LAboit.modelmenu) and LAboit.modelmenu:GetEntity() then
				LAboit.tkkl = math.min(LAboit.tkkl + RealFrameTime() * 500,LAboit.tkklMax)
				if LAboit.tkkl >= LAboit.tkklMax and not LAboit.t22 then LAboit.t22 = true
					LAboit.modelmenu:SetVisible(true) LAboit.modelmenu:ChangePage()
				end
				local ent = LAboit.modelmenu:GetEntity()
				local bx, by = LAboit:LocalToScreen( 0, 0 )
				local zw, zh = LAboit:GetSize()
				ent.pbase = {bx, by}
				ent.zbase = {zw, zh}
				local zw, zh = LAboit.li:GetSize()
				local bx, by = LAboit.li:LocalToScreen( 0, 0 )
				zw,zh = zw-20,zh-20
				bx,by = bx+10,by+10
				LAboit.modelmenu.pbase = {bx, by}
				LAboit.modelmenu.zbase = {zw, zh}
			elseif LAboit.noR then
				LAboit.tkkl = math.max(LAboit.tkkl - RealFrameTime() * 500,0)
			elseif not LAboit.noR then
				if IsValid(LAboit.modelmenu) then LAboit.modelmenu:Remove() end
				LAboit.modelmenu = vgui.Create("AM4_DModelPreview", LAboit.aanu)
				local aModelmenu = LAboit.modelmenu
				aModelmenu:Dock(FILL)
				aModelmenu.EMMus = true
				aModelmenu.aanu = LAboit.aanu.rh
				local zw, zh = LAboit.li:GetSize()
				local bx, by = ScrW()/2-zw/2 ,ScrH()/2-zh/2 - 5
				aModelmenu.pbase = {bx, by}
				aModelmenu.zbase = {zw, zh}
				aModelmenu.Panelbase = LAboit
				aModelmenu.Dled = LAboit.Dled
				aModelmenu.OnRemove = function(self)
					if IsValid(self.Entity) then self.Entity:Remove() end
					if IsValid(self.EntityT) then self.EntityT:Remove() end
					if IsValid(aModelmenu.aanu) then aModelmenu.aanu:Remove() end
					hook.Remove("Think", aModelmenu.LIndex)
					LocalPlayer().ActMod_cl_MisDragging = nil
				end
				LAboit.modelmenu = aModelmenu
				aModelmenu:SetVisible(false)
				function aModelmenu:ChangePage(ActAnime)
					if not isstring(shv) or shv == "" then return end
					local ent = aModelmenu:GetEntity()
					if ( !IsValid( ent ) ) then return end
					ent:ResetSequence("idle_all_02")
					ent:SetCycle(0)
					ent:SetPlaybackRate(0)
					ent.GLast = LAboit
					local bx, by = LAboit:LocalToScreen( 0, 0 )
					local zw, zh = LAboit:GetSize()
					ent.pbase = {bx, by}
					ent.zbase = {zw, zh}
					ent.Panelbase = LAboit
					timer.Create("AA_irunAnm",0.4,1,function() if IsValid( ent ) then
						local RDW_Snd
						local TTbl = A_AM.ActMod:A_ActMod_GetActString(IDName)
						local GAO = istable(A_AM.ActMod.GTabActO) and A_AM.ActMod.GTabActO[TTbl.txt]
						if istable(GAO) and istable(GAO.SndsC_) and isnumber(GAO.SndsC_.n) and GAO.SndsC_.n > 1 then RDW_Snd = math.random(GAO.SndsC_.n) end
						A_AM.ActMod:StartAniAct(ent,{TTbl.txt,RDW_Snd},nil,{"",1,1,2},TTbl.tBl)
					end end)
				end
			end
		elseif not LAboit.li.INIP and not LocalPlayer().ActMod_cl_MisDragging then
			if LAboit.t22 then LAboit.t22 = false LAboit.noR = nil LAboit.tkkl = 0
			elseif LAboit.tkkl > 0 then LAboit.tkkl = 0
			end
			if IsValid(LAboit.modelmenu) and LAboit.modelmenu:GetEntity() then
				if IsValid(LAboit.modelmenu) then LAboit.modelmenu:Remove() end
				LAboit.modelmenu = nil
			end
		end
	end
end
local function CFileEmts(NFile,TData,Atable,callback)
	if NFile and isstring(NFile) then
		if Atable and istable(Atable) or TData then
			if !file.Exists("actmod","DATA") then file.CreateDir("actmod") end
			local OKSav = 0
			local ATData = {}
			if NFile == A_AM.ActMod.TNSav["saveenew"] then
				ATData = {
					["ActModBy"] = "AhmedMake400"
					,["ActojiDNew1"] = { A_AM.ActMod.Mounted["Version ActMod"] }
					,["DatF"] = {
						["Timestamp"] = os.time()
						,["TimeString"] = os.date( "%I:%M:%S %p  - %Y/%m/%d" , os.time() )
					}
					,["DatU"] = {
						["Timestamp"] = os.time()
						,["TimeString"] = os.date( "%I:%M:%S %p  - %Y/%m/%d" , os.time() )
					}
					,["ActModDataV"] = A_AM.ActMod.Mounted["Version ActMod"]
				}
			elseif NFile == A_AM.ActMod.TNSav["savefvit"] then
				ATData = {
					["ActModBy"] = "AhmedMake400"
					,["Actojifavo"] = {}
					,["DatF"] = {
						["Timestamp"] = os.time()
						,["TimeString"] = os.date( "%I:%M:%S %p  - %Y/%m/%d" , os.time() )
					}
					,["DatU"] = {
						["Timestamp"] = os.time()
						,["TimeString"] = os.date( "%I:%M:%S %p  - %Y/%m/%d" , os.time() )
					}
					,["ActModDataV"] = A_AM.ActMod.Mounted["Version ActMod"]
				}
			elseif NFile == A_AM.ActMod.TNSav["savemots"] then
				ActLoadIcons()
				ATData = {
					["ActModBy"] = "AhmedMake400"
					,["ActojiDial"] = {
						[1] = AtabValid(1) ,[2] = AtabValid(2) ,[3] = AtabValid(3) ,[4] = AtabValid(4)
						,[5] = AtabValid(5) ,[6] = AtabValid(6) ,[7] = AtabValid(7) ,[8] = AtabValid(8)
					}
					,["ActojiDial2"] = {
						[1] = AtabValid(9) ,[2] = AtabValid(10) ,[3] = AtabValid(11) ,[4] = AtabValid(12)
						,[5] = AtabValid(13) ,[6] = AtabValid(14) ,[7] = AtabValid(15) ,[8] = AtabValid(16)
					}
					,["ActojiDial3"] = {
						[1] = AtabValid(22) ,[2] = AtabValid(23) ,[3] = AtabValid(24) ,[4] = AtabValid(25)
						,[5] = AtabValid(26) ,[6] = AtabValid(27) ,[7] = AtabValid(28) ,[8] = AtabValid(29)
					}
					,["ActojiDial4"] = {
						[1] = AtabValid(30) ,[2] = AtabValid(31) ,[3] = AtabValid(32) ,[4] = AtabValid(33)
						,[5] = AtabValid(34) ,[6] = AtabValid(35) ,[7] = AtabValid(36) ,[8] = AtabValid(37)
					}
					,["AVRDal5"] = {
						[1] = AtabValid(38) ,[2] = AtabValid(39) ,[3] = AtabValid(40) ,[4] = AtabValid(41)
						,[5] = AtabValid(42) ,[6] = AtabValid(43) ,[7] = AtabValid(44) ,[8] = AtabValid(45)
					}
					,["AVRDal6"] = {
						[1] = AtabValid(46) ,[2] = AtabValid(47) ,[3] = AtabValid(48) ,[4] = AtabValid(49)
						,[5] = AtabValid(50) ,[6] = AtabValid(51) ,[7] = AtabValid(52) ,[8] = AtabValid(53)
					}
					,["AVRDal7"] = {
						[1] = AtabValid(54) ,[2] = AtabValid(55) ,[3] = AtabValid(56) ,[4] = AtabValid(57)
						,[5] = AtabValid(58) ,[6] = AtabValid(59) ,[7] = AtabValid(60) ,[8] = AtabValid(61)
					}
					,["AVRDal8"] = {
						[1] = AtabValid(62) ,[2] = AtabValid(63) ,[3] = AtabValid(64) ,[4] = AtabValid(65)
						,[5] = AtabValid(66) ,[6] = AtabValid(67) ,[7] = AtabValid(68) ,[8] = AtabValid(69)
					}
					,["ActojiDialh"] = {
						[1] = AtabValid(17) ,[2] = AtabValid(18) ,[3] = AtabValid(19) ,[4] = AtabValid(20) ,[5] = AtabValid(21)
						,[6] = AtabValid(70) ,[7] = AtabValid(71) ,[8] = AtabValid(72) ,[9] = AtabValid(73) ,[10] = AtabValid(74)
					}
					,["DatF"] = {
						["Timestamp"] = os.time()
						,["TimeString"] = os.date( "%I:%M:%S %p  - %Y/%m/%d" , os.time() )
					}
					,["DatU"] = {
						["Timestamp"] = os.time()
						,["TimeString"] = os.date( "%I:%M:%S %p  - %Y/%m/%d" , os.time() )
					}
					,["ActModDataV"] = A_AM.ActMod.Mounted["Version ActMod"]
				}
			end
			if Atable then ATData = Atable end
			file.Write("actmod/".. NFile ..".json",util.TableToJSON(ATData,true))
			timer.Create( "RunSavFile0", 0.3, 1, function()
				if file.Exists("actmod/".. NFile ..".json","DATA") then OKSav = 1 end
				if callback then callback(NFile,OKSav) end
			end)
		else
			if callback then callback(NFile,false) end
		end
	end
end

function A_AM.ActMod:ReAddEmts(NFile,TData,Atable,callback)
	if !file.Exists("actmod","DATA") then file.CreateDir("actmod") end
	if NFile and isstring(NFile) then
		NFile = A_AM.ActMod.TNSav[NFile]
		if file.Exists("actmod/".. NFile ..".json", "DATA") then
			local aFile
			local ATData = {}
			pcall(function() aFile = file.Read("actmod/".. NFile ..".json", "DATA") end)
			if (aFile != nil) then
				pcall(function() if istable(util.JSONToTable(aFile)) then ATData = util.JSONToTable(aFile) end end)
				if istable(Atable) or istable(TData) and (TData[1] and TData[2] or istable(TData[1]) and TData[2] == "tab") then
					if ATData and not table.IsEmpty(ATData) then
						local OKSav,tsf = 0,false
						if Atable then
							ATData = Atable
						else
							if TData[3] then
								if istable(TData[1]) and TData[2] == "tab" then
									for k1,v1 in pairs(TData[1]) do
										if v1[2] == 0 then ATData[v1[1]] = v1[3] else ATData[v1[1]][v1[2]] = v1[3] end
									end
								else
									if TData[2] == 0 then ATData[TData[1]] = TData[3] else ATData[TData[1]][TData[2]] = TData[3] end
								end
							else
								if istable(TData[1]) and TData[2] == "tab" then
									for k1,v1 in pairs(TData[1]) do table.insert(ATData[v1[1]], v1[2]) end
								else
									table.insert(ATData[TData[1]], TData[2])
								end
							end
						end
						ATData["DatU"]["Timestamp"] = os.time()
						ATData["DatU"]["TimeString"] = os.date( "%I:%M:%S %p  - %Y/%m/%d" , os.time() )
						SanitizeIconsAllTable(ATData)
						file.Write("actmod/".. NFile ..".json",util.TableToJSON(ATData,true))
						timer.Create( "RunSavFile1", 0.3, 1, function()
							if file.Exists("actmod/".. NFile ..".json","DATA") then OKSav = 2 end
							if callback then callback(NFile,OKSav) end
						end)
					else
						if callback then callback(NFile,false) end
					end
				else
					if callback then callback(NFile,false) end
				end
			else
				CFileEmts(NFile,TData,Atable,function(OKSav) if callback then callback(NFile,OKSav) end end)
			end
		else
			CFileEmts(NFile,TData,Atable,function(OKSav) if callback then callback(NFile,OKSav) end end)
		end
	end
end


A_AM.ActMod.aNTyp = {
	[1] = 1,[2] = 2,[3] = 3,[4] = 4,[5] = 5,[6] = 6,[7] = 7,[8] = 8
	,[9] = 1,[10] = 2,[11] = 3,[12] = 4,[13] = 5,[14] = 6,[15] = 7,[16] = 8
	,[17] = 1,[18] = 2,[19] = 3,[20] = 4,[21] = 5
	,[70] = 6,[71] = 7,[72] = 8,[73] = 9,[74] = 10
	,[22] = 1,[23] = 2,[24] = 3,[25] = 4,[26] = 5,[27] = 6,[28] = 7,[29] = 8
	,[30] = 1,[31] = 2,[32] = 3,[33] = 4,[34] = 5,[35] = 6,[36] = 7,[37] = 8
	,[38] = 1,[39] = 2,[40] = 3,[41] = 4,[42] = 5,[43] = 6,[44] = 7,[45] = 8
	,[46] = 1,[47] = 2,[48] = 3,[49] = 4,[50] = 5,[51] = 6,[52] = 7,[53] = 8
	,[54] = 1,[55] = 2,[56] = 3,[57] = 4,[58] = 5,[59] = 6,[60] = 7,[61] = 8
	,[62] = 1,[63] = 2,[64] = 3,[65] = 4,[66] = 5,[67] = 6,[68] = 7,[69] = 8
}

function A_AM.ActMod:GetSTabEts()
	local NFile = A_AM.ActMod.TNSav["savemots"]
	if file.Exists("actmod/".. NFile ..".json", "DATA") then
		local aFile
		local ATData = {}
		pcall(function() aFile = file.Read("actmod/".. NFile ..".json", "DATA") end)
		if aFile then
			pcall(function() if istable(util.JSONToTable(aFile)) then ATData = util.JSONToTable(aFile) end end)
			if istable(ATData) and not table.IsEmpty(ATData) then
				local Addd = {}
				for k, v in pairs(ATData) do
					if (k=="ActojiDial"or k=="ActojiDial2"or k=="ActojiDial3"or k=="ActojiDial4"or k=="AVRDal5"or k=="AVRDal6"or k=="AVRDal7"or k=="AVRDal8") then
						Addd[k] = v
					end
				end
				return Addd
			end
			return
		end
		return
	end
	return
end

function A_AM.ActMod:ActojTyp(aN)
	if (aN >= 17 and aN <= 21) or (aN >= 70 and aN <= 74) then
		return "ActojiDialh"
	elseif aN >= 62 then
		return "AVRDal8"
	elseif aN >= 54 then
		return "AVRDal7"
	elseif aN >= 46 then
		return "AVRDal6"
	elseif aN >= 38 then
		return "AVRDal5"
	elseif aN >= 30 then
		return "ActojiDial4"
	elseif aN >= 22 then
		return "ActojiDial3"
	elseif aN >= 9 then
		return "ActojiDial2"
	end
	return "ActojiDial"
end
function A_AM.ActMod:LoadEmts(NFile,TData,callback)
	if isstring(NFile) then
		NFile = A_AM.ActMod.TNSav[NFile]
		if file.Exists("actmod/".. NFile ..".json", "DATA") then
			local aFile
			local ATData = {}
			pcall(function() aFile = file.Read("actmod/".. NFile ..".json", "DATA") end)
			if aFile != nil then
				pcall(function() if istable(util.JSONToTable(aFile)) then ATData = util.JSONToTable(aFile) end end)
				if istable(TData) and TData[1] then
					if istable(ATData) and not table.IsEmpty(ATData) then
						SanitizeIconsAllTable(ATData)
						if ATData[TData[1]] and ATData[TData[1]][TData[2]] then
							if callback then callback(NFile,1) end return ATData[TData[1]][TData[2]]
						elseif ATData[TData[1]] then
							if callback then callback(NFile,1) end return ATData[TData[1]]
						else
							if callback then callback(NFile,0) end return "n_"
						end
					else
						if callback then callback(NFile,false) end
						return "n_"
					end
				else
					if callback then callback(NFile,false) end
					return "n_"
				end
			else
				if callback then callback(NFile,false) end
				return "n_"
			end
		else
			if callback then callback(NFile,false) end
			return "n_"
		end
	end
end

function A_AM.ActMod:AddToFvite(AName)
	local ATData = {}
    local ATDataNew = A_AM.ActMod:LoadEmts("savefvit",{"Actojifavo"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
    if ATDataNew and istable(ATDataNew) then ATData = ATDataNew end
	if ATData and A_AM.ActMod:ATabData(ATData, AName) == true then
		table.RemoveByValue(ATData, AName)
		A_AM.ActMod:ReAddEmts("savefvit",{"Actojifavo",0,ATData},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
	else
		surface.PlaySound("actmod/s/button9.mp3")
		table.insert(ATData, AName)
		A_AM.ActMod:ReAddEmts("savefvit",{"Actojifavo",0,ATData},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
	end
	ATData = nil ATDataNew = nil
end
function A_AM.ActMod:RemveFvite(AName)
	local ATData = {}
    local ATDataNew = A_AM.ActMod:LoadEmts("savefvit",{"Actojifavo"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
    if ATDataNew and istable(ATDataNew) then ATData = ATDataNew end
	if ATData and A_AM.ActMod:ATabData(ATData, AName) == true then
		surface.PlaySound("actmod/s/s2.mp3")
		table.RemoveByValue(ATData, AName)
		A_AM.ActMod:ReAddEmts("savefvit",{"Actojifavo",0,ATData},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
	end
	ATData = nil ATDataNew = nil
end




local function aShowCopy(s)
	surface.PlaySound("actmod/s/copy2.mp3")
	if IsValid(s.trh) then s.trh:Remove() end
	s.trh = vgui.Create("DLabel", s)
	s.trh:SetSize(s:GetWide(), s:GetTall())
	s.trh:SetPos(0, 0)
	s.trh:SetText("")
	s.trh:SetAlpha(255)
	s.trh:AlphaTo(0, 0.5, 0.3, function(sa) if IsValid(s.trh) then s.trh:Remove() end end)
	s.trh.ttxt = aR:T("LReplace_txt_Copy")
	s.trh.Paint = function(s, w, h)
		draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(20, 90, 200, 255))
		draw.SimpleText(s.ttxt, "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end
function A_AM.ActMod:aShowCopy(s)
	aShowCopy(s)
end

function A_AM.ActMod:sStNewDat(pl, Sstr)
    local TmpData = {}
    local ActDataNew = A_AM.ActMod:LoadEmts("saveenew",{"ActojiDNew1"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
    if ActDataNew and istable(ActDataNew) then
        local TActDataNew = ActDataNew

        if TActDataNew[1] and TActDataNew[1] == A_AM.ActMod.Mounted["Version ActMod"] then
            TmpData = TActDataNew
        else
            TActDataNew = {}
            table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
            TmpData = TActDataNew
			A_AM.ActMod:ReAddEmts("saveenew",{"ActojiDNew1",0,TmpData},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
        end
        TActDataNew = nil
	else
		local TActDataNew = {}
		table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
		TmpData = TActDataNew
		A_AM.ActMod:ReAddEmts("saveenew",{"ActojiDNew1",0,TmpData},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
		TActDataNew = nil
    end

    if A_AM.ActMod:ATabData(TmpData, Sstr) == false and A_AM.ActMod:ATabData(A_AM.ActMod.ActNewV, Sstr) == true then
        table.insert(TmpData, Sstr)
		A_AM.ActMod:ReAddEmts("saveenew",{"ActojiDNew1",0,TmpData},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
    end

    TmpData = nil
    ActDataNew = nil
end
local function sStNewDat(pl, Sstr)
	return A_AM.ActMod:sStNewDat(pl, Sstr)
end

function A_AM.ActMod:RCFi(txt,teta)
	if not teta then
		CFileEmts(txt,true,nil,function(t,OKSav)
			local oka = "Failed"
			if OKSav and OKSav == 1 then oka = "Done" end
			print("-{ActMod > Error[".. txt .."] > Reinstall = ",oka,t)
		end)
	end
end


local function WrapText(text, font, maxWidth)
    surface.SetFont(font)
    local words = string.Explode(" ", text)
    local lines = {}
    local currentLine = ""
    for i, word in ipairs(words) do
        local testLine = currentLine == "" and word or currentLine .. " " .. word
        local width = surface.GetTextSize(testLine)
        if width > maxWidth then
            table.insert(lines, currentLine)
            currentLine = word
        else
            currentLine = testLine
        end
    end
    if currentLine ~= "" then table.insert(lines, currentLine) end
    return lines
end

local function SplitTextByWords(text, maxWidth, font)
    surface.SetFont(font)
    local finalLines = {}
    local manualLines = string.Explode("\n", text)
    for _, rawLine in ipairs(manualLines) do
        local words = string.Explode(" ", rawLine)
        local currentLine = ""
        for i = 1, #words do
            local word = words[i]
            local testLine = currentLine == "" and word or currentLine .. " " .. word

            local width = surface.GetTextSize(testLine)

            if width > maxWidth then
                if currentLine ~= "" then
                    table.insert(finalLines, currentLine)
                end
                currentLine = word
            else
                currentLine = testLine
            end
        end
        if currentLine ~= "" then table.insert(finalLines, currentLine) end
    end
    return finalLines
end


local scrollingTexts = {}
timer.Create("A_AM_ClCleanupOldData",13,0,function() for k, v in pairs(scrollingTexts) do if SysTime() - v.lastUsed > 10 then scrollingTexts[k] = nil end end end)
function draw.ScrollingText(text,font,x,y,color,al1,al2,maxWidth,panel,animMode,uniqueID,ttst)
    uniqueID = uniqueID or (text .. font .. x .. y)
    animMode = animMode or 1
    surface.SetFont(font)
    local textWidth, textHeight = surface.GetTextSize(text)
    if not isnumber(maxWidth) or textWidth <= maxWidth then
        draw.SimpleText(text,font,x,y,color,al1,al2)
        return textWidth
    end
	textWidth = textWidth+5
    local data = scrollingTexts[uniqueID]
    local curTime = SysTime()
    if not data then
        data = {
            offset = 0, state = 3,
            waitUntil = curTime + 2, lastUpdate = curTime, lastUsed = curTime,
            drion = 1, mode = animMode
        }
        scrollingTexts[uniqueID] = data
    end
    if data.mode ~= animMode then
        data.mode = animMode
        data.state = 3
        data.offset = 0
        data.drion = 1
        data.waitUntil = curTime + 2
    end
    data.lastUsed = curTime
    local dt = curTime - data.lastUpdate
    data.lastUpdate = curTime
    local scrollSpeed = 40
    local fadeSpeed = 3
    if animMode == 2 then
        if data.state == 3 then
            if curTime >= data.waitUntil then
                data.state = 4
                data.offset = data.drion == 1 and 0 or (textWidth - maxWidth)
            end
        elseif data.state == 4 then
			data.offset = data.offset + (scrollSpeed * dt * data.drion)
            if data.drion == 1 and data.offset >= (textWidth - maxWidth) then
                data.offset = textWidth - maxWidth
                data.state = 3
                data.waitUntil = curTime + 2
                data.drion = -1
            elseif data.drion == -1 and data.offset <= 0 then
                data.offset = 0
                data.state = 3
                data.waitUntil = curTime + 2
                data.drion = 1
            end
        end
    else
		if data.state == 3 then
			if curTime >= data.waitUntil then
				data.state = 4
				data.offset = 0
			end
		elseif data.state == 4 then
			data.offset = data.offset + (scrollSpeed * dt)
			if data.offset >= (textWidth - maxWidth + 50) then
				data.state = 2
				data.fadeAlpha = 1
			end
		elseif data.state == 2 then
			data.fadeAlpha = math.max(0, (data.fadeAlpha or 1) - (fadeSpeed/2 * dt))
			if data.fadeAlpha <= 0 then
				data.state = 1
				data.offset = 0
				data.fadeAlpha = 0
			end
		elseif data.state == 1 then
			data.fadeAlpha = math.min(1, (data.fadeAlpha or 0) + (fadeSpeed * dt))
			if data.fadeAlpha >= 1 then
				data.state = 3
				data.waitUntil = curTime + 2
			end
		end
	end
    local alpha = color.a or 255
    if data.state == 2 or data.state == 1 then alpha = alpha * (data.fadeAlpha or 1) end
    local drawColor = Color(color.r, color.g, color.b, alpha)
    local screenX, screenY = x, y
    if panel and panel.LocalToScreen then screenX, screenY = panel:LocalToScreen(x, y) end
    local oldScissor = DisableClipping(false)
    render.SetScissorRect(al1 == 1 and screenX-maxWidth/2 or screenX, al2 == 1 and screenY-textHeight/2 or screenY  ,al1 == 1 and screenX + maxWidth/2 or screenX + maxWidth, al2 == 1 and (screenY + textHeight/2+2) or (screenY + textHeight), true)
	if ttst then draw.RoundedBox(0,0,0,ScrW(),ScrH(),Color(0,255,0,100)) end
    draw.SimpleText(text, font, x-data.offset, y, drawColor, al1,al2)
    render.SetScissorRect(0, 0, 0, 0, false)
    DisableClipping(oldScissor)
    return maxWidth
end


function A_AM.ActMod:CTxtMos(Ow, IsH, Ty, txt, txf, aup, useSTBW)
    if IsH or Ow:IsHovered() then
        if IsValid(Ow.CTxg) then
			Ow.CTxg.TimRemov = CurTime() + 0.3
			local addtt = 6
            if aup then
                local addTl = Ow.CTxg:GetTall()
				if useSTBW then
					addTl = 20
				end
				if aup == -1 then
					Ow.CTxg:SetPos(gui.MouseX() - Ow.CTxg:GetWide(), gui.MouseY() - (addTl + addtt))
				elseif aup == -2 then
					Ow.CTxg:SetPos(gui.MouseX() - Ow.CTxg:GetWide(), gui.MouseY() + (addTl + addtt))
				elseif aup == 10 then
					Ow.CTxg:SetPos(gui.MouseX() - (Ow.CTxg:GetWide() / 2), gui.MouseY() + (addTl + addtt))
				elseif aup == 11 then
					Ow.CTxg:SetPos(gui.MouseX() - (Ow.CTxg:GetWide() / 3), gui.MouseY() + (addTl + addtt))
				elseif aup == 15 then
					Ow.CTxg:SetPos(gui.MouseX() - (Ow.CTxg:GetWide() / 2), gui.MouseY() - (addTl + addtt))
				elseif aup == 16 then
					Ow.CTxg:SetPos(gui.MouseX() - (Ow.CTxg:GetWide() / 3), gui.MouseY() - (addTl + addtt))
				else
					Ow.CTxg:SetPos(gui.MouseX() - (Ow.CTxg:GetWide() / 3), gui.MouseY() - (addTl + addtt))
				end
            else
                Ow.CTxg:SetPos(gui.MouseX() + 2, gui.MouseY() + (Ow.CTxg:GetTall() + addtt))
            end
        else
            Ow.CTxg = vgui.Create("DLabel")
			if useSTBW then
				Ow.CTxg:SetText("")
				Ow.CTxg:SetSize(20, 10)
			else
				Ow.CTxg:SetText(" " .. txt .. " ")
				Ow.CTxg:SetFont(txf) Ow.CTxg:SetTextColor( Color(255,255,255) )
				Ow.CTxg:SizeToContents()
			end
            Ow.CTxg:SetDrawOnTop(true)
            Ow.CTxg:SetAlpha(0)
            Ow.CTxg:AlphaTo(255, 0.3, 0.3)
            Ow.CTxg:SetPos(gui.MouseX(), gui.MouseY() - (Ow.CTxg:GetTall() + 5))
            Ow.CTxg.TimRemov = CurTime() + 1
			
			if useSTBW then
				Ow.CTxg.MyText = tostring(txt)
				Ow.CTxg:SetWrap(false)
			end
			
            Ow.CTxg.Paint = function(s, w, h)
				if useSTBW then
					if not s.lines or not s.lineHeight then
						if useSTBW == 1 then
							s.lines = WrapText(s.MyText, txf, w - 10)
						else
							s.lines = SplitTextByWords(s.MyText, 500 , txf)
						end
						surface.SetFont(txf)
						local _, lineHeight = surface.GetTextSize("Test")
						s.lineHeight = lineHeight
						local zw,zh = 10,20
						for i, line in ipairs(s.lines) do
							surface.SetFont(txf)
							local aw, ah = surface.GetTextSize(line)
							zw = math.max(aw,zw)
							zh = math.max(i * s.lineHeight,zh)
						end
						s:SetSize(zw+10, zh+3)
					end
				end
                local amov = math.Clamp(1 * math.sin(CurTime() * 1), 0,1)
                if Ty then
                    draw.RoundedBox(0, 0, 0, w, h, Color(Ty[1]*amov, Ty[2]*amov, Ty[3]*amov, 255))
                else
                    draw.RoundedBox(0, 0, 0, w, h, Color(70*amov, 60*amov, 155*amov, 255))
                end
				surface.SetDrawColor(Color(0, 255, 255, 255))
				surface.DrawOutlinedRect(0, 0, w, h, 1 )
				if useSTBW and s.lines and s.lineHeight then
					for i, line in ipairs(s.lines) do
						draw.SimpleTextOutlined(line, txf, 5, (i - 1) * s.lineHeight, Color(255,255,255, 255), 0, 0, 1, Color(0, 0, 255, 255))
					end
				elseif not useSTBW then
					draw.SimpleTextOutlined(" " .. txt .. " ", txf, 0, 0, Color(0, 0, 0, 0), 0, 0, 1, Color(0, 0, 255, 255))
				end
            end
            Ow.CTxg.Think = function(s)
                if not Ow or not IsValid(Ow) or Ow and Ow.GetDisabled and Ow:GetDisabled() == true or s.TimRemov < CurTime() then s:Remove() end
            end
        end
    else
        if IsValid(Ow.CTxg) then
            Ow.CTxg:Remove()
        end
    end
end
local function CTxtMos(Ow, IsH, Ty, txt, txf, aup, useSTBW)
	A_AM.ActMod:CTxtMos(Ow, IsH, Ty, txt, txf, aup, useSTBW)
end

function A_AM.ActMod:ASa(gg)
	surface.PlaySound("actmod/s/lock.mp3")

	if IsValid(gg.trh) then gg.trh:Remove() end

	gg.trh = vgui.Create("DLabel", gg)
	gg.trh:SetSize(gg:GetWide(), gg:GetTall())
	gg.trh:SetPos(0, 0)
	gg.trh:SetText("")
	gg.trh:SetAlpha(255)
	gg.trh:AlphaTo(0, 0.5, 0.6, function(s)
		if IsValid(gg.trh) then
			gg.trh:Remove()
		end
	end)
	gg.trh.Think = function(s) s:SetSize(gg:GetWide(), gg:GetTall()) end
	gg.trh.Paint = function(s, w, h)
		draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(100, 50, 10, 255))
		draw.SimpleText(aR:T("LReplace_txt_Lock"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

function A_AM.ActMod:BTt1(bs, px, ph, zx, zh, txt)
    local SButX = vgui.Create("DButton", bs)
    SButX:SetText(txt == "R2" and "R" or txt)
    SButX:SetFont("ActMod_a1")
    SButX:SetAlpha(0)
    SButX:SetTextColor(Color(20, 5, 5))
    SButX:SetPos(px, ph)
    SButX:SetSize(zx, zh)
    SButX:AlphaTo(255, 0.9)
    SButX.Paint = function(ss, w, h)
        if IsValid(bs) and (txt == "R" and bs.tt == false or txt == "R2" and bs.tt2 == false) then
            draw.RoundedBox(4, 0, 0, w, h, Color(30, 30, 50, 255))
        else
            if ss:IsHovered() then
                if txt == "R" or txt == "R2" then
                    draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 85, 255))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
                end
            else
                if txt == "R" or txt == "R2" then
                    draw.RoundedBox(4, 0, 0, w, h, Color(200, 200, 200, 255))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
                end
            end
        end
        if txt == "R" or txt == "R2" then
            CTxtMos(ss, nil, {100, 100, 50, 140}, aR:T("LButt_LB_txt3"), "CreditsText", 1)
        end
    end

    SButX.DoClick = function()
        if IsValid(bs) and (txt == "R" and bs.tt == false or txt == "R2" and bs.tt2 == false) then return end
        surface.PlaySound("garrysmod/balloon_pop_cute.wav")
        if txt == "X" then
            if IsValid(bs) then
                bs:Remove()
            end
        elseif txt == "R" and bs.tt == true then
            local t = "actmod_keyo_"
            bs.tt = false
            LocalPlayer():ConCommand(t .. "h " .. tostring(KEY_LALT) .. "\n")
            LocalPlayer():ConCommand(t .. "1 " .. tostring(KEY_1) .. "\n")
            LocalPlayer():ConCommand(t .. "2 " .. tostring(KEY_2) .. "\n")
            LocalPlayer():ConCommand(t .. "3 " .. tostring(KEY_3) .. "\n")
            LocalPlayer():ConCommand(t .. "4 " .. tostring(KEY_4) .. "\n")
            LocalPlayer():ConCommand(t .. "5 " .. tostring(KEY_5) .. "\n")
            timer.Simple(0.3, function() if IsValid(bs) then bs.tt = true bs.ASpow() end end)
        elseif txt == "R2" and bs.tt2 == true then
            local t = "actmod_keyo_"
            bs.tt2 = false
            LocalPlayer():ConCommand(t .. "h2 " .. tostring(KEY_X) .. "\n")
            LocalPlayer():ConCommand(t .. "6 " .. tostring(KEY_1) .. "\n")
            LocalPlayer():ConCommand(t .. "7 " .. tostring(KEY_2) .. "\n")
            LocalPlayer():ConCommand(t .. "8 " .. tostring(KEY_3) .. "\n")
            LocalPlayer():ConCommand(t .. "9 " .. tostring(KEY_4) .. "\n")
            LocalPlayer():ConCommand(t .. "10 " .. tostring(KEY_5) .. "\n")
            timer.Simple(0.3, function() if IsValid(bs) then bs.tt2 = true bs.ASpow2() end end)
        end
    end

    return SButX
end
local function BTt1(bs, px, ph, zx, zh, txt) return A_AM.ActMod:BTt1(bs, px, ph, zx, zh, txt) end

function A_AM.ActMod:AC_butCh(Gw, Gh, Zw, Zh, es, txt, alp)
    local buton = vgui.Create("DBinder", es)
    buton:SetPos(Gw, Gh)
    buton:SetSize(Zw, Zh)

    if alp then
        buton:SetAlpha(0)

        if alp[2] ~= 0 then
            buton:AlphaTo(255, alp[1], alp[2])
        else
            buton:AlphaTo(255, alp[1])
        end
    end

    buton:SetValue(GetConVar(txt[1]):GetInt())
    buton:SetFont(txt[2]) buton:SetTextColor( Color(255,255,255) )
    buton.kyT = false
    buton.Paint = function(self, w, h)
        if buton.kyT == true then
            draw.RoundedBox(10, 0, 0, w, h, Color(math.max(200 + (55 * math.sin(CurTime() * 7)), 200), 150, 80, 255))
        else
            draw.RoundedBox(10, 0, 0, w, h, Color(120, 140, 180, 255))
        end
    end

    function buton:OnChange(num)
        if num == 66 or num == 83 or num == 107 or num == 108 or num == 109 or num == 112 or num == 113 or num == GetConVar("actmod_key_iconmenu"):GetInt() then
            buton:SetText(aR:T("AL_COS_CKy"))
            buton.kyT = true
        else
            buton.kyT = false
            RunConsoleCommand(txt[1], num)
        end
    end

    return buton
end
local function AC_butCh(Gw, Gh, Zw, Zh, es, txt, alp) return A_AM.ActMod:AC_butCh(Gw, Gh, Zw, Zh, es, txt, alp) end

function A_AM.ActMod:aSatLang(self)
	self.LitLang = vgui.Create("DButton")
	self.LitLang:SetText("")
	self.LitLang:SetSize(ScrW(), ScrH())
	self.LitLang:SetCursor("arrow") self.LitLang:MakePopup()
	self.LitLang:SetKeyboardInputEnabled(false)
	self.LitLang:Center() self.LitLang:SetAlpha(0) self.LitLang:AlphaTo(255, 0.2)
	self.LitLang.Tamodwn = CurTime() + 0.3
	self.LitLang.Tamodwn2 = CurTime() + 1.4
	self.LitLang.Tamodwn3 = CurTime() + 2.2
	self.LitLang.nV = A_AM.ActMod.numV
	self.LitLang.Paint = function(ste, aw, ah)
		draw.RoundedBox(0, 0, 0, aw, ah, Color(0, 0, 50, 210))
		local aup = 70
		local atmr3_t = math.Clamp( (CurTime() - ste.Tamodwn3)/0.6 ,0,1)
		if atmr3_t >= 1 then
			draw.SimpleText("ActMod", "CloseCaption_Normal", aw / 2 -35, aup-20, Color(220, 255, 255, 255), 1, 1)
			draw.SimpleText("v".. ste.nV or "v9.7", "CloseCaption_Normal", aw / 2 + 35, aup-20, Color(220, 255, 255, 255), 1, 1)
			draw.SimpleText("AhmedMake400", "CloseCaption_BoldItalic", aw-50, ah-100, Color(200, 255, 255, 255), 2, 1)
		else
			local atmr = aup*math.ease.OutElastic( math.Clamp( (CurTime() - ste.Tamodwn) ,0,1) )
			local atmr2_t = math.Clamp( (CurTime() - ste.Tamodwn2)/0.6 ,0,1)
			local atmr2 = 35*atmr2_t
			draw.SimpleText("ActMod", "CloseCaption_Normal", aw / 2 -(atmr2), atmr-20, Color(220, 255, 255, 255), 1, 1)
			draw.SimpleText("v".. ste.nV or "v9.7", "CloseCaption_Normal", aw / 2 + atmr2, aup-20, Color(220, 255, 255, 255*math.ease.InExpo(atmr2_t)), 1, 1)
			draw.SimpleText("AhmedMake400", "CloseCaption_BoldItalic", aw-50, ah-100, Color(200, 255, 255, 255*atmr3_t), 2, 1)
		end
	end
	self.LitLang.DoClick = function(s)
		if IsValid(self.PanelLoadigAnimSy) then self.PanelLoadigAnimSy:Remove() end
		if IsValid(self.Frame) then self.Frame:Remove() end
	end
	self.LitLang.DoRightClick = function(s)
		if IsValid(self.PanelLoadigAnimSy) then self.PanelLoadigAnimSy:Remove() end
		if IsValid(self.Frame) then self.Frame:Remove() end
	end


	local Tl = ""
	local DPa_ = vgui.Create("DPanel", self.LitLang)
	DPa_:SetSize(200, 120)
	DPa_:Center()
	DPa_:MakePopup()
	DPa_.Paint = function(ste, aw, ah)
		draw.RoundedBox(0, 0, 0, aw, ah, Color(70, 90, 100, 255))
		draw.RoundedBox(5, 5, 5, aw - 10, ah - 10, Color(50, 60, 70, 255))

		if Tl == "en" then
			draw.SimpleText("Welcome", "ActMod_a1", aw / 2, ah / 2, Color(220, 255, 255, 255), 1, 1)
		elseif Tl == "ru" then
			draw.SimpleText("Приветствуем", "ActMod_a1", aw / 2, ah / 2, Color(220, 255, 255, 255), 1, 1)
		elseif Tl == "zh-CN" then
			draw.SimpleText("欢迎光临", "ActMod_a1", aw / 2, ah / 2, Color(220, 255, 255, 255), 1, 1)
		elseif Tl == "de" then
			draw.SimpleText("Willkommen", "ActMod_a1", aw / 2, ah / 2, Color(220, 255, 255, 255), 1, 1)
		elseif Tl == "tr" then
			draw.SimpleText("Hoş geldin", "ActMod_a1", aw / 2, ah / 2, Color(220, 255, 255, 255), 1, 1)
		end
	end

	local Tmp = ""
	local Tmp2 = ""
	local DButCh = vgui.Create("DComboBox", DPa_)
	DButCh:SetSize(180, 25)
	DButCh:SetPos(10, 10)
	DButCh:SetText(aR:T("ALanguage"))
	DButCh:AddChoice("1- English", "en", false, "flags16/gb.png")
	DButCh:AddChoice("2- China", "zh-CN", false, "flags16/cn.png")
	DButCh:AddChoice("3- Russian", "ru", false, "flags16/ru.png")
	DButCh:AddChoice("4- Germany", "de", false, "flags16/de.png")
	DButCh:AddChoice("5- Turkish", "tr", false, "flags16/tr.png")
	DButCh.OnSelect = function(pl, index, value, data)
		surface.PlaySound("garrysmod/ui_return.wav")
		Tl = data

		if data == "en" then
			Tmp = "    ==>  English  <==  "
			Tmp2 = "OK"
		elseif data == "ru" then
			Tmp = "    ==>  Russian  <==  "
			Tmp2 = "ок"
		elseif data == "zh-CN" then
			Tmp = "    ==>  China  <==  "
			Tmp2 = "好的"
		elseif data == "de" then
			Tmp = "    ==>  Germany  <==  "
			Tmp2 = "OK"
		elseif data == "tr" then
			Tmp = "    ==>  Turkish  <==  "
			Tmp2 = "TAMAM"
		end

		DButCh:SetText(Tmp)
	end

	local DBu_1 = vgui.Create("DButton", DPa_)
	DBu_1:SetSize(90, 25)
	DBu_1:SetPos(DPa_:GetWide() / 2 - DBu_1:GetWide() / 2, 80)
	DBu_1:SetText("")
	DBu_1.Think = function()
		if Tl ~= "" then
			DBu_1:SetDisabled(false)
		else
			DBu_1:SetDisabled(true)
		end
	end
	DBu_1.DoClick = function(s)
		surface.PlaySound("garrysmod/content_downloaded.wav")
		aR:R_T(Tl, true)
		if IsValid(self.LitLang) then self.LitLang:Remove() end
		self:Close(true)
	end
	DBu_1.Paint = function(ste, w, h)
		if Tmp == "" then
			draw.RoundedBox(5, 0, 0, w, h, Color(70, 30, 20, 255))
			draw.SimpleText("---", "ActMod_a5", w / 2, h / 2, Color(220, 255, 255, 255), 1, 1)
		else
			if ste:IsDown() then
				draw.RoundedBox(5, 0, 0, w, h, Color(150, 130, 80, 255))
				draw.SimpleText(Tmp2, "ActMod_a1", w / 2, h / 2, Color(255, 255, 155, 255), 1, 1)
				surface.SetDrawColor(Color(100, 255, 255, math.max(155 + (100 * math.sin(CurTime() * 15)), 0)))
				surface.DrawOutlinedRect(0, 0, w, h, 1)
			elseif ste:IsHovered() then
				draw.RoundedBox(5, 0, 0, w, h, Color(70, 122, 40, 255))
				draw.SimpleText(Tmp2, "ActMod_a5", w / 2, h / 2, Color(155, 255, 155, 255), 1, 1)
			else
				draw.RoundedBox(5, 0, 0, w, h, Color(30, 80, 120, math.max(200 + (155 * math.sin(CurTime() * 7)), 0)))
				draw.SimpleText(Tmp2, "ActMod_a5", w / 2, h / 2, Color(220, 255, 255, 255), 1, 1)
			end
		end
	end
end
local function aSatLang(self) A_AM.ActMod:aSatLang(self) end

function A_AM.ActMod:DBtO(Gw, Gh, es, NBt)
    local pgh = vgui.Create("DPanel", es)
    pgh:SetSize(110, 170)
    pgh:SetPos(Gw, Gh)
    pgh.Paint = function(ste, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(10, 20, 70, 255))
        draw.SimpleText("V", "ActMod_a6", w / 2, 45, Color(255, 255, 255, 255), 1, 1)
    end
    AC_butCh(5, 5, 100, 30, pgh, {"actmod_keyo_" .. NBt, "ChatFont"}, {0.5})
    return pgh
end
local function DBtO(Gw, Gh, es, NBt) return A_AM.ActMod:DBtO(Gw, Gh, es, NBt) end


local ASettings = A_AM.ActMod.Settings

local function ActojiDefault()
	Actoji.table = {}
	if istable(Actoji.Valid) then
		for k, v in pairs(Actoji.Valid or {}) do
			table.insert(Actoji.table, v)
		end
	end
end
ActojiDefault()

local function ActaChick()
	if file.Exists("actmod/".. A_AM.ActMod.TNSav["savemots"] ..".json", "DATA") then
		local aFile
		local ATData = {}
		pcall(function() aFile = file.Read("actmod/".. A_AM.ActMod.TNSav["savemots"] ..".json", "DATA") end)
		if (aFile != nil) then
			if istable(util.JSONToTable(aFile)) then ATData = util.JSONToTable(aFile) end
			if ATData and ATData["ActojiDial"] and ATData["ActojiDial2"] and ATData["ActojiDial3"] and ATData["ActojiDial4"] and ATData["AVRDal5"] and ATData["AVRDal6"] and ATData["AVRDal7"] and ATData["AVRDal8"] and ATData["ActojiDialh"] and ATData["ActModBy"] then return true end
		end
	end
	return false
end
function A_AM.ActMod:ActaLoed(a1,a2)
	local aaa = A_AM.ActMod:LoadEmts("savemots",{a1,a2},function(t,g) A_AM.ActMod:RCFi(t,g) end)
	if aaa ~= "n_" then return aaa end
	return A_AM.ActMod.AGetDitN[a2]
end

local function ActojiLoed(rrr)
	if not rrr and file.Exists("actmod/".. A_AM.ActMod.TNSav["savemots"] ..".json", "DATA") and ActaChick() then
		local addn = 0
		for i = 1 , 8 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("ActojiDial",addn) end
		addn = 0
		for i = 9 , 16 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("ActojiDial2",addn) end
		addn = 0
		for i = 17 , 21 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("ActojiDialh",addn) end
		addn = 0
		for i = 22 , 29 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("ActojiDial3",addn) end
		addn = 0
		for i = 30 , 38 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("ActojiDial4",addn) end
		addn = 0
		for i = 39 , 47 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("AVRDal5",addn) end
		addn = 0
		for i = 48 , 56 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("AVRDal6",addn) end
		addn = 0
		for i = 57 , 65 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("AVRDal7",addn) end
		addn = 0
		for i = 66 , 74 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("AVRDal8",addn) end
		addn = 5
		for i = 70 , 74 do addn = addn + 1 Actoji.table[i] = A_AM.ActMod:ActaLoed("ActojiDialh",addn) end
	else
		A_AM.ActMod:ReAddEmts("savemots",true,nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
	end
end
ActojiLoed()

function A_AM.ActMod:ActojiClear()
	if file.Exists("actmod/".. A_AM.ActMod.TNSav["saveenew"] ..".json","DATA") then
		file.Delete("actmod/".. A_AM.ActMod.TNSav["saveenew"] ..".json")
	end
	if file.Exists("actmod/".. A_AM.ActMod.TNSav["savefvit"] ..".json","DATA") then
		file.Delete("actmod/".. A_AM.ActMod.TNSav["savefvit"] ..".json")
	end
    ActLoadIcons()
    ActojiDefault()
	ActojiLoed(true)
end

concommand.Add("actmod_resetactoj", function(ply, cmd, args)
	if ply and IsValid(ply) and ply:IsPlayer() then
		A_AM.ActMod:ActojiClear()
	end
end)

Actoji.ButtonSize = 135

Actoji.Close = function(self, reset ,vrShow ,CKeyA)
    local ply = LocalPlayer()
	local TTruevr,CKeyAct = false,false
    if ply.CKeyAct_UseMenu_VR and ply.CKeyAct_UseMenu_VR == true or A_AM.ActMod:IsVR(ply) then TTruevr = true end
    if CKeyA or ply.CKeyAct_UseMenu then CKeyAct = true end
    ply.ActMod_MousePos = {gui.MouseX(), gui.MouseY()}
	if IsValid(self.ess2) then self.ess2:Remove() end
    if reset and reset == "nOw" then
		if IsValid(Actoji.Frame) then Actoji.Frame:Remove() end
		timer.Simple(0.1, function()
			if IsValid(ply) and (input.IsKeyDown(GetConVar("actmod_key_iconmenu"):GetInt()) or CKeyAct) then
				Actoji:Open(CKeyAct ,TTruevr)
			end
		end)
    else
		if IsValid(Actoji.Frame) then
			if A_AM.ActMod.Truevr then
				if IsValid(Actoji.Frame) then Actoji.Frame:Remove() end
				timer.Simple(0.1, function() if reset then Actoji:Open(CKeyAct ,TTruevr) end end)
			else
				Actoji.Frame:AlphaTo(0, 0.1, 0, function(t, s)
					if IsValid(s) then s:Remove() end
					if IsValid(Actoji.Frame) then Actoji.Frame:Remove() end
					timer.Simple(0.1, function() if reset then Actoji:Open(CKeyAct ,TTruevr) end end)
				end)
			end
		end
	end
	ply.CKeyAct_UseMenu = nil
	A_AM.ActMod.Truevr = false
	ply.CKeyAct_UseMenu_VR = nil
end

local ttHuDA,ttHuDASt,ttHuDAnbb,ZDAnbb = 0,SysTime(),1,60

hook.Add("HUDPaint", "ActMod_Hud", function()
    local ply = LocalPlayer()
    if GetConVarNumber("actmod_cl_eloading") ~= 0 and A_AM.ActMod.clo_IMeun_Num > 0 and not A_AM.ActMod.A_ActMod_RedyUse and not ply.ActMod_UseMenu then
		local WiDl
		local ZW, ZH = 380, 80
		local SW, SH = ScrW() / 2 - ZW / 2, 50
		local PSho = A_AM.ActMod.A_ActMod_RedyUse_Num or 1
		draw.RoundedBox(15, SW + 0, SH - 20, ZW, ZH + 20, Color(50, 70, 90, 150))
		draw.RoundedBox(15, SW + 0, SH - 20, ZW, 30, Color(20, 30, 50, 100))
		draw.SimpleText("ActMod  " .. aR:T("wndSetup") .. "AhmedMake400 )  V" .. A_AM.ActMod.Mounted["Version ActMod"], "ActMod_a3", SW + ZW / 2, SH - 5, Color(180, 235, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(aR:T("wndSetup_Checks"), "ActMod_a6", SW + 2, SH + 25, Color(180, 255, 200, 255), nil, TEXT_ALIGN_CENTER)
		draw.SimpleText(PSho .. "%", "ActMod_a6", SW + ZW - 57, SH + 25, Color(180, 255, 200, 255), nil, TEXT_ALIGN_CENTER)
		draw.RoundedBox(10, SW + 10, SH + 40, ZW - 20, 30, Color(20, 20, 20, 150))
		draw.RoundedBox(10, SW + 10, SH + 40, math.Remap( PSho, 0, 100, 0, ZW-20 ), 30, Color(20, 150, 100, 150))

        if PSho >= 100 then
            WiDl = aR:T("wndSetupL_HBComp")
        elseif PSho >= 95 then
            WiDl = aR:T("wndSetupL_Effects")
        elseif PSho >= 91 then
            WiDl = aR:T("wndSetupL_Background")
        elseif PSho >= 66 then
            WiDl = aR:T("wndSetupL_Emotes")
        elseif PSho >= 35 then
            WiDl = aR:T("wndSetupL_Sounds")
        elseif PSho >= 30 then
            WiDl = aR:T("wndSetupL_AaCing") .. "..."
        elseif PSho >= 16 then
            WiDl = aR:T("wndSetupL_AaCing") .. ".."
        elseif PSho >= 4 then
            WiDl = aR:T("wndSetupL_AaCing") .. "."
        else
            WiDl = aR:T("wndSetupL_Please")
        end

        draw.SimpleText(WiDl, "ActMod_a5", SW + ZW / 2, SH + 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif GetConVarNumber("actmod_cl_eloading") == 0 and A_AM.ActMod.clo_IMeun_Num > 0 and not A_AM.ActMod.A_ActMod_RedyUse then
		local ZW, ZH = 100, 50
		local SW, SH = 10, 100
		local PSho = A_AM.ActMod.A_ActMod_RedyUse_Num or 1
		draw.RoundedBox(10, SW + 0, SH - 10, ZW, 30, Color(20, 30, 50, 140))
		draw.SimpleText("ActMod", "ActMod_a3", SW + 6, SH - 10, Color(180, 255, 200, 255))
		draw.SimpleText(PSho .. "%", "ActMod_a4", SW + ZW - 5, SH - 6, Color(180, 255, 200, 255), 2)
		draw.RoundedBox(0, SW + 5, SH + 9, ZW - 10, 6, Color(20, 20, 20, 150))
		draw.RoundedBox(0, SW + 5, SH + 9, math.Remap( PSho, 0, 100, 0, ZW - 10 ), 6, Color(20, 200, 100, 180))

	else
		if GetConVarNumber("actmod_sv_alowdsyn") <= 0 or GetConVarNumber("actmod_sv_showhisyn") <= 0 or GetConVarNumber("actmod_cl_showhisyn") <= 0 or not ply:Alive() or ply:GetObserverMode() ~= 0 then return end
		local TolPl2,TolPl2OK = false,false
		local Pl2 = ply.ActMod_TSndJ_LookTPly
		if (ply.ActMod_tLtok or 0) < CurTime() then ply.ActMod_tLtok = CurTime() + 0.2 ply.ActMod_TSndJ_LookTPly_tok = A_AM.ActMod:aGetLookTPly( ply ) end
		local Pl2_ok = ply.ActMod_TSndJ_LookTPly_tok
		
		if ply.ActMod_TRStopAct and ply.ActMod_TRStopAct > CurTime()+0.5 and ply.ActMod_TRStopAct-CurTime() < 1.8 and ply:A_ActMod_GetIsAct() then
			if ttHuDAnbb == 1 then ttHuDASt = SysTime() ttHuDAnbb = 2 end
			ttHuDA = math.Round( Lerp( (SysTime() - ttHuDASt )/0.3, ttHuDA, 255) )
		elseif IsValid(Pl2) or IsValid(ply.ActMod_GPl2TSndJ) then
			if ttHuDAnbb == 1 then ttHuDASt = SysTime() ttHuDAnbb = 2 end
			ttHuDA = math.Round( Lerp( (SysTime() - ttHuDASt )/0.3, ttHuDA, 255) )
			if ttHuDA < 255 then ttHuDA = math.Round( Lerp( (SysTime() - ttHuDASt )/0.3, ttHuDA, 255) ) end
		else
			if ttHuDAnbb == 2 then ttHuDASt = SysTime() ttHuDAnbb = 1 end
			if ttHuDA > 0 then ttHuDA = math.Round( Lerp( (SysTime() - ttHuDASt )/0.1, ttHuDA, 0) ) end
		end
		TolPl2 = IsValid(Pl2_ok) and (IsValid(Pl2) and Pl2 == Pl2_ok and IsValid(ply.ActMod_GkTPlyTJn) and ply.ActMod_GkTPlyTJn == Pl2_ok)
		TolPl2OK = IsValid(Pl2_ok) and (IsValid(Pl2) and Pl2 == Pl2_ok and IsValid(ply.ActMod_GkTPlyTJn) and ply.ActMod_GkTPlyTJn == Pl2_ok and IsValid(ply.ActMod_GPl2TSndJ) and ply.ActMod_GPl2TSndJ == ply.ActMod_GkTPlyTJn)
		
		
		if ply:Alive() and ply:GetObserverMode() == 0 and ttHuDA > 0 then
			local WiDl
			local aiSVR = A_AM.ActMod:IsVR(ply)
			local ZW ,ZH ,Za = 60 ,15 ,70
			Za = Za + ttHuDA*0.1
			if aiSVR then
				ZH = ZH*1.4
			end
			
			local Tx1,Tx2,Tx3,Tx4,Tx5
			local zTxt1,zTxt2,zTxt3,zTxt4,zTxt5 = 0,0,0,0,0
			if (ply.ActMod_TSndJ or 0) < CurTime() and ply.ActMod_TRStopAct and ply.ActMod_TRStopAct > CurTime() -0.2 and ply:A_ActMod_GetIsAct() then
				Tx1,Tx2 = "[>] Stopping " ,"    ".. string.rep("•", math.Round((CurTime()*6)%4))
				zTxt1 = A_AM.ActMod.aGetTextSize(Tx1,"ActMod_a3")
				zTxt2 = A_AM.ActMod.aGetTextSize(" .......","ActMod_a1")
				local zTxt = math.min(zTxt1+zTxt2,170)
				ZW = ZW + zTxt
			elseif (ply.ActMod_TSndJ or 0) > CurTime() then
				Tx1,Tx2,Tx3 = "→  " ,(ply.ActMod_GNamTSndJ or "...") ,"    ".. string.rep("»", math.Round((CurTime()*6)%4))
				zTxt1 = A_AM.ActMod.aGetTextSize(Tx1,"ActMod_a3")
				zTxt2 = A_AM.ActMod.aGetTextSize(Tx2,"ActMod_a3")
				zTxt3 = A_AM.ActMod.aGetTextSize("  .......","ActMod_a1")
				local zTxt = math.min(zTxt1+zTxt2+zTxt3,400)
				ZW = ZW + zTxt
			elseif not ply:A_ActMod_GetIsAct() and IsValid(Pl2) then
				if aiSVR then
					Tx1,Tx2,Tx3 = " " ,"[ B ]  /  [ Reload ]" ,"     ⤵"
					zTxt1 = A_AM.ActMod.aGetTextSize(Tx1,"ActMod_a6")
					zTxt2 = A_AM.ActMod.aGetTextSize(Tx2,"ActMod_a6")
					zTxt3 = A_AM.ActMod.aGetTextSize(Tx3,"ActMod_a6")
					local zTxt = math.min(zTxt1+zTxt2+zTxt3,400)
					ZW = ZW + zTxt
				else
					Tx1,Tx2,Tx3,Tx4,Tx5 = " " ,"[ SHIFT ]" ,"  +  " ,"[ E ]" ,"     ⤵"
					zTxt1 = A_AM.ActMod.aGetTextSize(Tx1,"ActMod_a3")
					zTxt2 = A_AM.ActMod.aGetTextSize(Tx2,"ActMod_a3")
					zTxt3 = A_AM.ActMod.aGetTextSize(Tx3,"ActMod_a3")
					zTxt4 = A_AM.ActMod.aGetTextSize(Tx4,"ActMod_a3")
					zTxt5 = A_AM.ActMod.aGetTextSize(Tx5,"ActMod_a3")
					local zTxt = math.min(zTxt1+zTxt2+zTxt3+zTxt4+zTxt5,400)
					ZW = ZW + zTxt
				end
			end
			local ZWSpd = 20
			if ttHuDAnbb == 1 then ZWSpd = 35 end
			if ttHuDA < 255 then
				ZDAnbb = Lerp( math.Remap(255-ttHuDA,0,255,0,1), ZDAnbb, ZW)
			else
				ZDAnbb = Lerp( FrameTime()*ZWSpd, ZDAnbb, ZW)
			end
			local ZW,ZAH = ZDAnbb,25
			if aiSVR then ZAH = 31 end
			local SW, SH = ScrW() / 2 - ZW / 2, ScrH() - 160
			local PSho = A_AM.ActMod.A_ActMod_RedyUse_Num or 2
			draw.RoundedBox(15, SW + 0, SH - 20 +Za, ZW, ZH + 20, Color(50, 70, 90, math.min(ttHuDA,150)))
			local amov = math.max(60 + (40 * math.sin(CurTime() * 6)), 0)
			
			if not ply.atrky then ply.atrky = 0 end
			if not aiSVR then
				if not ply:KeyDown(IN_USE) and not ply:KeyDown(IN_SPEED) then
					ply.atrky = 0
				else
					if not ply:KeyDown(IN_USE) and ply:KeyDown(IN_SPEED) then ply.atrky = 0 end
					if ply:KeyDown(IN_USE) and not ply:KeyDown(IN_SPEED) and ply.atrky == 0 then ply.atrky = -1 end
					if ply:KeyDown(IN_SPEED) and ply.atrky == 0 then ply.atrky = 1 end
				end
			end
			
			if ply.atrky == 1 and TolPl2OK and ply:KeyDown(IN_SPEED) and ply:KeyDown(IN_USE) then
				if (ply.ActMod_TSndJ or 0) > CurTime() then
					draw.RoundedBox(10, SW + 10, SH - 13.5 +Za, ZW - 20, ZAH, Color(100, 100, 100, math.min(ttHuDA,180 + (50 * math.sin(CurTime() * 6)))))
				else
					draw.RoundedBox(10, SW + 10, SH - 13.5 +Za, ZW - 20, ZAH, Color(100, 150, 100, math.min(ttHuDA,180 + (50 * math.sin(CurTime() * 6)))))
				end
			elseif ply.atrky == -1 and TolPl2 and ply:KeyDown(IN_SPEED) and ply:KeyDown(IN_USE) then
				local lo1,lo2 = (1 * math.sin(CurTime() * 50)) ,(-1 * math.sin(CurTime() * 42))
				draw.RoundedBox(10, SW + 10 +lo1, SH - 13.5 +Za +lo2, ZW - 20, ZAH, Color(150, 70, 40, math.min(ttHuDA,180 + (50 * math.sin(CurTime() * 6)))))
			else
				if ply.atrky == -1 then
					draw.RoundedBox(10, SW + 10, SH - 13.5 +Za, ZW - 20, ZAH, Color(amov, amov-50, amov-50, math.min(ttHuDA,180 + (50 * math.sin(CurTime() * 6)))))
				elseif ply.atrky == 1 and TolPl2 and ply:KeyDown(IN_SPEED) then
					draw.RoundedBox(10, SW + 10, SH - 13.5 +Za, ZW - 20, ZAH, Color(amov-50, amov, amov, math.min(ttHuDA,180 + (50 * math.sin(CurTime() * 6)))))
				else
					draw.RoundedBox(10, SW + 10, SH - 13.5 +Za, ZW - 20, ZAH, Color(amov, amov, amov, math.min(ttHuDA,180 + (50 * math.sin(CurTime() * 6)))))
				end
			end

			if Tx1 and Tx2 then
				local asp,sza = 30, SH + Za - 11
				if (ply.ActMod_TRStopAct or 0) > CurTime()-0.2 and ply:A_ActMod_GetIsAct() then
					draw.SimpleText(Tx1, aiSVR and "ActMod_a6" or "ActMod_a3", SW + asp, sza, Color(255, 255, math.min(ttHuDA,100 + (100 * math.sin(CurTime() * 30))), ttHuDA), 0, 0)
					draw.SimpleText(Tx2, "ActMod_a1", SW + asp + zTxt1, sza, Color(255, 255, 255, ttHuDA), 0, 0)
				elseif (ply.ActMod_TSndJ or 0) > CurTime() then
					draw.SimpleText(Tx1, aiSVR and "ActMod_a6" or "ActMod_a3", SW + asp, sza, Color(255, 255, 255, ttHuDA), 0, 0)
					draw.SimpleText(Tx2, aiSVR and "ActMod_a6" or "ActMod_a3", SW + asp + zTxt1, sza, Color(150, 255, 255, math.min(ttHuDA,180 + (120 * math.sin(CurTime() * 8)))), 0, 0)
					draw.SimpleText(Tx3, "ActMod_a1", SW + asp + zTxt1 + zTxt2, sza, Color(255, 255, 255, ttHuDA), 0, 0)
				else
					if aiSVR then
						draw.SimpleText(Tx1, "ActMod_a6", SW + asp, sza, Color(255, 255, 255, ttHuDA), 0, 0)
						draw.SimpleText(Tx2, "ActMod_a6", SW + asp + zTxt1, sza, ply:KeyDown(IN_RELOAD) and Color(100, 255, 200, ttHuDA) or Color(255, 255, 100, math.min(ttHuDA,180 + (120 * math.sin(CurTime() * 8)))), 0, 0)
						draw.SimpleText(Tx3, "ActMod_a6", SW + asp + zTxt1 + zTxt2, sza, Color(255, 255, 255, ttHuDA), 0, 0)
					else
						draw.SimpleText(Tx1, "ActMod_a3", SW + asp, sza, Color(255, 255, 255, ttHuDA), 0, 0)
						draw.SimpleText(Tx2, "ActMod_a3", SW + asp + zTxt1, sza, TolPl2 and ply:KeyDown(IN_SPEED) and ply.atrky ~= -1 and Color(100, 255, 200, ttHuDA) or TolPl2 and ply:KeyDown(IN_USE) and ply.atrky == -1 and Color(255, 255, 100, ttHuDA) or Color(255, 255, 100, math.min(ttHuDA,180 + (120 * math.sin(CurTime() * 8)))), 0, 0)
						draw.SimpleText(Tx3, "ActMod_a3", SW + asp + zTxt1 + zTxt2, sza, Color(255, 255, 255, ttHuDA), 0, 0)
						if ply.atrky == -1 then
							local lo1,lo2 = (1 * math.sin(CurTime() * 50)) ,(-1 * math.sin(CurTime() * 42))
							draw.SimpleText(Tx4, "ActMod_a3", SW +lo1 + asp + zTxt1 + zTxt2 + zTxt3, sza +lo2,  Color(255, 200, 100, ttHuDA), 0, 0)
						else
							draw.SimpleText(Tx4, "ActMod_a3", SW + asp + zTxt1 + zTxt2 + zTxt3, sza, TolPl2OK and ply:KeyDown(IN_USE) and Color(100, 255, 200, ttHuDA) or TolPl2 and not ply:KeyDown(IN_USE) and ply:KeyDown(IN_SPEED) and Color(255, 255, 100, math.min(ttHuDA,180 + (120 * math.sin(CurTime() * 8)))) or Color(155, 155, 50, ttHuDA), 0, 0)
						end
						draw.SimpleText(Tx5, "ActMod_a3", SW + asp + zTxt1 + zTxt2 + zTxt3 + zTxt4, sza, Color(255, 255, 255, ttHuDA), 0, 0)
					end
					if IsValid(Pl2) and Pl2:IsPlayer() then
						WiDl = Pl2:Nick()
						if Pl2.ActMod_TextNameAct then draw.SimpleTextOutlined(Pl2.ActMod_TextNameAct,"ChatFont",SW + ZW/2, SH +Za + (aiSVR and 46 or 34),Color(155, 255, 255, 255*ttHuDA),1,1,2,Color(0, 0, 0, 150*ttHuDA)) end
						if isnumber(Pl2.ActMod_tActGetNJoing) and Pl2.ActMod_tActGetNJoing > 0 then draw.SimpleTextOutlined(Pl2:GetNWInt( "A_ActMod.GetNJoing",0) .." /".. Pl2.ActMod_tActGetNJoing,"ChatFont",SW + ZW -19, SH +Za - (aiSVR and 35 or 23),Color(155, 255, 255, 255*ttHuDA),1,1,1,Color(0, 0, 0, 150*ttHuDA)) end
					else WiDl = ""
					end
					draw.SimpleText(WiDl, aiSVR and "ActMod_a1" or "ActMod_a4", SW + ZW -19+1, SH +Za + (aiSVR and 31 or 19), Color(0, 0, 0, ttHuDA), 2, 1)
					draw.SimpleText(WiDl, aiSVR and "ActMod_a1" or "ActMod_a4", SW + ZW -19, SH +Za + (aiSVR and 30 or 18), Color(255, 255, 255, ttHuDA), 2, 1)
				end
				draw.SimpleText("AcrMod", aiSVR and "ActMod_a1" or "ActMod_a4", SW + 18+1, SH +Za-(aiSVR and 24 or 21), Color(0, 0, 0, ttHuDA), 0, 1)
				draw.SimpleText("AcrMod", aiSVR and "ActMod_a1" or "ActMod_a4", SW + 18, SH +Za-(aiSVR and 23 or 20), Color(155, 255, 255, ttHuDA), 0, 1)

			end
		end
    end
	local TPly = ply.ActMod_TSndJ_LookTPly
	if not IsValid(TPly) then return end
	local pulse = (1 + math.sin(CurTime() * 8))*0.5
	halo.Add({TPly}, Color(80,200,225,255*pulse), 2, 2, 1, true, true)
end)




function A_AM.ActMod:GetReadyFUse(ply)
    if not GetConVar("actmod_sv_enabled"):GetBool() or ply ~= LocalPlayer() or not ply:Alive() or A_AM.ActMod.clo_IMeun_Num == 0 then return false end
    if GetConVarNumber("actmod_sv_a_vehicles") == 0 and ply:InVehicle() then return false end
    if GetConVarNumber("actmod_sv_a_move") ~= 0 and (ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT)) then return false end
    if GetConVarNumber("actmod_sv_a_ground") == 1 and not ply:OnGround() then return false end
    if GetConVarNumber("actmod_sv_a_crouching") == 0 and ply:Crouching() then return false end
    if prone and (ply:GetNW2Int("prone.AnimationState", 3) ~= 3 or ply:GetNWInt("prone.AnimationState", 3) ~= 3) then return false end
    if ply:GetNWBool("wOS.LS.IsGetIncapped", false) then return false end
    if (wOS and wOS.RollMod and ply:wOSIsRolling()) or ply:GetNWBool("wOS.LS.IsRolling", false) then return false end
    if ply:GetNWBool("L4DA.IsChargerAttPly", false) or ply:GetNWBool("L4DA.IsSmokerAttPly", false) or ply:GetNWBool("L4DA.IsHntrAttPly", false) or ply:GetNWBool("L4DA.IsJockeyAttPly", false) then return false end
    return true
end
local function GetReadyFUse(ply)
	return A_AM.ActMod:GetReadyFUse(ply)
end


function A_AM.ActMod:LokTabData(pl, tbl, str, hlp)
    if pl.GetTable_Avs and tbl then
        for k, v in pairs(tbl) do
            if (ReString(v["T1"]) == str or v["C1"] and ReString(v["C1"]) == str ) and pl.GetTable_Avs[k] and pl.GetTable_Avs[k]["ok"] ~= "Done" then
                if hlp then print("Search_" .. k .. "->", v, pl.GetTable_Avs[k]["ok"]) end
                return true
            end
        end
    end
    return false
end

include("actmod/vgi/menu_change.lua")
include("actmod/vgi/menu_emotes.lua")
include("actmod/vgi/menu_emotes_vr.lua")
include("actmod/vgi/menu_listerr.lua")
include("actmod/vgi/menu_option.lua")

Actoji.Open = function(self,CKeyAct,vrShow)
    local ply = LocalPlayer()
	if not IsValid(self.Frame) then
		ply.CKeyAct_UseMenu_VR = nil
		ply.CKeyAct_UseMenu = CKeyAct
		if vrShow then
			Actoji:OpenEmoteVR(vrShow)
		else
			Actoji:OpenEmote(vrShow)
		end
	end
end

Actoji.TScaleIconsDEG = {[1] = 100 ,[2] = 121 ,[3] = 153 ,[4] = 207}
Actoji.ScaleIconsDEG = 121

local function ShowM_LgsUpd(self, Ty)
    if not IsValid(self.OptMenu) then return end
    if IsValid(self.ShowMenuiA) then self.ShowMenuiA:Remove() end

    self.ShowMenuiA = vgui.Create("DFrame")
    self.ShowMenuiA:SetTitle("")
    self.ShowMenuiA:SetSize(380, 300)
    self.ShowMenuiA:SetAlpha(0)
    self.ShowMenuiA:Center()
    self.ShowMenuiA:MakePopup()
    self.ShowMenuiA:ShowCloseButton(false)
    self.ShowMenuiA:SetDraggable(false)
    self.ShowMenuiA:MoveTo(ScrW() / 2 + 150 - self.ShowMenuiA:GetWide() / 2, ScrH() / 2 - self.ShowMenuiA:GetTall() / 2, 0.3)
    self.ShowMenuiA:AlphaTo(255, 0.2)
    self.ShowMenuiA.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(110, 139, 155, 250))
        draw.RoundedBox(6, 5, 5, w - 10, h - 10, Color(20, 20, 20, 250))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(Material("actmod/imenu/p_yn.png", "noclamp smooth"))
        surface.DrawTexturedRect(15, 15, 40, 40)
    end

    local Stxt = vgui.Create("DLabel", self.ShowMenuiA)
    Stxt:SetPos(60, 15)
    if GetIDNames and GetIDNames[Ty.name] then
        Stxt:SetText(" " .. GetIDNames[Ty.name] .. " ")
    else
        Stxt:SetText(" " .. Ty.name .. " ")
    end

    Stxt:SetFont("ActMod_a1")
    Stxt:SetTextColor(Color(255, 255, 215))
    Stxt:SizeToContents()
    Stxt.Paint = function(s, w, h) draw.RoundedBox(6, 0, 0, w, h, Color(70, 80, 50, 250)) end

    local SButX = vgui.Create("DButton", self.ShowMenuiA)
    SButX:SetText("X")
    SButX:SetFont("ActMod_a1")
    SButX:SetAlpha(0)
    SButX:SetTextColor(Color(20, 5, 5))
    SButX:SetPos(self.ShowMenuiA:GetWide() - 40, -40)
    SButX:SetSize(30, 30)
    SButX:AlphaTo(255, 0.5, 0.3)
    SButX:MoveTo(self.ShowMenuiA:GetWide() - 40, 10, 0.3, 0.3)
    SButX.Paint = function(ss, w, h)
        if ss:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
        end
    end
    SButX.DoClick = function()
        surface.PlaySound("garrysmod/balloon_pop_cute.wav")
        if IsValid(self.ShowMenuiA) then self.ShowMenuiA:Remove() end
    end
end



Actoji.HelpFixActMod = function(self)	
    if IsValid(self.ShowMenuHowFix) then self.ShowMenuHowFix:Remove() end

    self.ShowMenuHowFix = vgui.Create("DFrame")
    self.ShowMenuHowFix:SetTitle("")
    self.ShowMenuHowFix:SetSize(500, 370)
    self.ShowMenuHowFix:SetPos(10, ScrH() / 2 - self.ShowMenuHowFix:GetTall() / 2)
    self.ShowMenuHowFix:SetAlpha(0)
    self.ShowMenuHowFix:MakePopup()
    self.ShowMenuHowFix:SetDraggable(false)
    self.ShowMenuHowFix:MoveTo(ScrW() / 2 - self.ShowMenuHowFix:GetWide() / 2, ScrH() / 2 - self.ShowMenuHowFix:GetTall() / 2, 0.3)
    self.ShowMenuHowFix:AlphaTo(255, 0.2)
    self.ShowMenuHowFix.txt1 = aR:T("htfixani_tit")
    self.ShowMenuHowFix.txt2 = aR:T("htfixani_tith")
    self.ShowMenuHowFix.txt3 = aR:T("htfixani_dwksp")
    self.ShowMenuHowFix.txt4 = aR:T("htfixani_txt1")
    self.ShowMenuHowFix.txt5 = aR:T("htfixani_txt2")
    self.ShowMenuHowFix.txt6 = aR:T("htfixani_txt3")
    self.ShowMenuHowFix.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(110, 139, 155, 250))
        draw.RoundedBox(4, 4, 4, w - 8, h - 8, Color(20, 20, 20, 250))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(Material("actmod/imenu/p_yn.png", "noclamp smooth"))
        surface.DrawTexturedRect(8, 13, 29, 29)
		draw.SimpleText(s.txt1, "ActMod_a3", 39, 20, Color(255, 255, 200, 255), 0, 1)
		draw.SimpleText(s.txt2, "ActMod_a4", 39, 36, Color(255, 255, 200, 255), 0, 1)
		draw.SimpleText(s.txt3, "ActMod_a3", 10, 85, Color(155, 255, 255, 255), 0, 1)
		draw.SimpleText(s.txt4, "ActMod_a2", w/2, 250, Color(255, 255, 255, 255), 1, 1)
		draw.SimpleText(s.txt5, "ActMod_a2", w/2, 275, Color(255, 255, 255, 255), 1, 1)
		draw.SimpleText(s.txt6, "ActMod_a2", w/2, 300, Color(255, 255, 255, 255), 1, 1)
    end
	
    local SButX = vgui.Create("DButton", self.ShowMenuHowFix)
    SButX:SetText("") SButX:SetAlpha(0) SButX:SetDisabled(true)
	SButX.DTurRe = true SButX.TimRe = CurTime() + 2
    SButX:SetPos(self.ShowMenuHowFix:GetWide() - 40, 70)
    SButX:SetSize(20, 20) SButX:AlphaTo(255, 0.5, 0.3)
    SButX.Paint = function(ss, w, h)
        if ss.DTurRe and (ss.TimRe or 0) < CurTime() then
			SButX.DTurRe = false SButX:SetDisabled(false)
		end
		local aap = ss:GetDisabled() and 50 or 255
        if ss:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, Color(20, 100, 30, aap))
        end
        surface.SetDrawColor(Color(255, 255, 255, aap))
        surface.SetMaterial(Material("icon16/arrow_refresh.png", "noclamp smooth"))
        surface.DrawTexturedRect(0,0,w,h)
    end
	
	self.ShowMenuHowFix.aframe = vgui.Create('DPanel', self.ShowMenuHowFix)
	local Bsef = self.ShowMenuHowFix.aframe
	Bsef:SetPos(10, 100)
	Bsef:SetSize(self.ShowMenuHowFix:GetWide() - 20, self.ShowMenuHowFix:GetTall()/2.75)
	Bsef.Paint = function(p, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(110, 139, 255, 150))
		if (Bsef.plist and IsValid(Bsef.plist) and not Bsef.plist.TJOne or not IsValid(Bsef.plist) or not Bsef.plist) then
			draw.SimpleText("nothing." , "ActMod_a6", w/2, h/2, Color(240, 255, 255, 255), 1, 1)
		end
	end
	
	Bsef.plist = vgui.Create('DScrollPanel', Bsef)
	local plist = Bsef.plist
	plist:Dock(FILL)
	plist.TimeTh = CurTime() + 0.1
	plist.TTbl = {}
	plist.Paint = function(p, w, h) end
	
    SButX.DoClick = function()
        surface.PlaySound("actmod/s/copy1.mp3")
		SButX.DTurRe = true SButX:SetDisabled(true) SButX.TimRe = CurTime() + 5
		if plist and IsValid(plist) then
			for _, child in pairs(plist.TTbl) do if IsValid(child) then child:Remove() end end
			plist.TTbl = {}
		end
		A_AM.ActMod:RSearGMd()
    end

	plist.Think = function()
		if ( plist.TimeTh or 0 ) > CurTime() or not A_AM.ActMod.GFSMd or ( A_AM.ActMod.GFSMd and table.IsEmpty(A_AM.ActMod.GFSMd)) then return end
		plist.TimeTh = CurTime() + 1
		for id, daTa in pairs(A_AM.ActMod.GFSMd) do
			if plist.TTbl[id] and IsValid(plist.TTbl[id]) then
			else
				if istable(daTa) then
					plist.TJOne = true
					plist.TTbl[id] = plist:Add('DButton')
					local SButX = plist.TTbl[id]
					SButX:SetText('')
					SButX:Dock(TOP)
					SButX:DockMargin(5, 0, 5, 1) SButX:SetTall(35)
					SButX:SetAlpha(0)
					SButX:SetTextColor(Color(20, 5, 5))
					SButX:AlphaTo(255, 0.5, 0.1)
					SButX.Paint = function(ss, w, h)
						if ss:IsHovered() then
							draw.RoundedBox(2, 0, 0, w, h, A_AM.ActMod.GAllowIDAdd[tostring(daTa.ID)] and Color(100, 170, 140, 255) or Color(200, 150, 85, 255))
						else
							draw.RoundedBox(5, 0, 0, w, h, A_AM.ActMod.GAllowIDAdd[tostring(daTa.ID)] and Color(100, 150, 120, 105) or Color(200, 50, 0, 255))
						end
						surface.SetDrawColor(Color(255, 255, 255, aap))
						surface.SetMaterial(SButX.mat or Material("icon16/information.png", "noclamp smooth"))
						surface.DrawTexturedRect(2,2,h-4,h-4)
						if daTa.Name then draw.SimpleText(daTa.Name , "ActMod_a3", h+10, h/2-7, Color(240, 255, 255, 255), 0, 1) end
						if daTa.file then draw.SimpleText(daTa.file .."  (".. (daTa.fm == "m" and "Male" or daTa.fm == "fm" and "Male|Female" or "Female") ..")" , "ActMod_a4", h+10, h/2+8, Color(255, 255, 255, 255), 0, 1) end
					end
					SButX.DoClick = function()
						surface.PlaySound("actmod/s/s2.mp3")
						if daTa["ID"] then
							steamworks.ViewFile( daTa["ID"] )
						end
					end
					if daTa["ID"] then
						steamworks.FileInfo(daTa["ID"], function(addonInfo)
							if addonInfo then
								if addonInfo.previewurl then
									steamworks.Download( addonInfo.previewid, true, function( cache )
										if not cache then return end
										SButX.mat = AddonMaterial(cache)
										local baseTex = ( SButX.mat and SButX.mat:GetTexture("$basetexture") ) or nil
										if baseTex == nil then SButX.mat = AddonMaterial(cache) end
									end )
								end
							else
								print("Addon with ID " .. daTa["ID"] .. " not found.")
							end
						end)
					end
				end
			end
		end
	end
    self.ShowMenuHowFix.SButXo = vgui.Create("DButton", self.ShowMenuHowFix)
	local SButX = self.ShowMenuHowFix.SButXo
    SButX:SetText(aR:T("htfixani_butt"))
    SButX:SetFont("ActMod_a1")
    SButX:SetAlpha(0)
    SButX:SetTextColor(Color(20, 5, 5))
    SButX:SetSize(200, 30)
    SButX:SetPos(self.ShowMenuHowFix:GetWide()/2 - SButX:GetWide()/2, self.ShowMenuHowFix:GetTall() -40)
    SButX:AlphaTo(255, 0.5, 0.5)
    SButX.Paint = function(ss, w, h)
        if ss:IsHovered() then
            draw.RoundedBox(8, 0, 0, w, h, Color(180, 200, 100, 255))
        else
            draw.RoundedBox(8, 0, 0, w, h, Color(100, 120, 50, 255))
        end
    end
    SButX.DoClick = function()
        surface.PlaySound("actmod/s/s2.mp3")
		steamworks.ViewFile( 2535949423 )
    end
	A_AM.ActMod:RSearGMd()
end
concommand.Add("actmod_cl_showbanim", function(ply, cmd, args)
	if IsValid(ply) and ply:IsPlayer() then
		Actoji:HelpFixActMod()
	end
end)


local function TableToString(tbl, indent)
    indent = indent or 0
    local text = ""
    local prefix = string.rep("       ", indent)
    for k, v in pairs(tbl) do
        local key
        if type(k) == "string" then
            key = string.format("[\"%s\"]", k)
        else
            key = string.format("[%s]", tostring(k))
        end
        if type(v) == "table" then
            text = text .. string.format("%s%s = {\n", prefix, key)
            text = text .. TableToString(v, indent + 1)
            text = text .. string.format("%s},\n", prefix)
        elseif type(v) == "string" then
            text = text .. string.format("%s%s = \"%s\",\n", prefix, key, v)
        else
            text = text .. string.format("%s%s = %s,\n", prefix, key, tostring(v))
        end
    end
    return text
end

concommand.Add("actmod_cl_showbterr", function(ply, cmd, args)
	if IsValid(ply) and ply:IsPlayer() then
		if IsValid(Actoji.i_MenuTErr) then
			Actoji.i_MenuTErr:Remove()
		else
			local aaSV = false
			if args[1] ~= nil and args[1] ~= "" then aaSV = true end
			Actoji.i_MenuTErr = vgui.Create("DFrame")
			Actoji.i_MenuTErr:SetTitle("Data for all embeds for registered custom animations:")
			Actoji.i_MenuTErr:SetSize(500, 480)
			Actoji.i_MenuTErr:Center()
			Actoji.i_MenuTErr:MakePopup()
			Actoji.i_MenuTErr:SetAlpha(0)
			Actoji.i_MenuTErr:AlphaTo(255, 0.5)
			Actoji.i_MenuTErr:SetSizable( true )
			Actoji.i_MenuTErr:SetMinWidth( 410 )
			Actoji.i_MenuTErr:SetMinHeight( 200 )
			Actoji.i_MenuTErr.btnMaxim:Hide()
			Actoji.i_MenuTErr.btnMinim:Hide()
			Actoji.i_MenuTErr.aaSV = aaSV
			Actoji.i_MenuTErr.Gtxt = "Loading... .. ."
			Actoji.i_MenuTErr.Paint = function(s, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50, 60, 100, 255))
			end
			function Actoji.i_MenuTErr:TGTbl( GTbl )
				if istable(GTbl) then
					local ann_log_done,ann_log_fils = 0,0
					for k, v in pairs(GTbl["log"]) do
						for k2, v2 in pairs(v) do
							if v[6] and istable(v2) then
								for k3, v3 in pairs(v2) do
									if v3 == "[3-3]( Act )> Done" then
										ann_log_done = ann_log_done + 1
									end
								end
							end
						end
					end
					local ann_err = 0
					for k, v in pairs(GTbl["Errors"]) do
						for k2, v2 in pairs(v) do
							if istable(v2) then
								for k3, v3 in pairs(v2) do
									if v2[1] then
										ann_err = ann_err + 1
									end
								end
							end
						end
					end
					local tbb = "Count: {\n   (Total Files.lua)> ".. table.Count(GTbl["log"]) .."\n   (Successful Inclusions)> ".. ann_log_done .."\n   (Errors): {\n      (From Files.lua)> ".. table.Count(GTbl["Errors"]) .."\n      (Unsuccessful Inclusions)> ".. ann_err .."\n   }\n}\n\n"
					Actoji.i_MenuTErr.Gtxt = tbb .. TableToString(GTbl)
				else
					Actoji.i_MenuTErr.Gtxt = "none_"
				end
				if IsValid(Actoji.i_MenuTErr.riText) then
					Actoji.i_MenuTErr.riText:SetText("")
					if Actoji.i_MenuTErr.aaSV then
						Actoji.i_MenuTErr.riText:InsertColorChange( 155, 255, 255, 255 )
					else
						Actoji.i_MenuTErr.riText:InsertColorChange( 255, 255, 155, 255 )
					end
					Actoji.i_MenuTErr.riText:AppendText(Actoji.i_MenuTErr.Gtxt)
				end
			end
			
			local copyBtn = vgui.Create("DButton", Actoji.i_MenuTErr)
			copyBtn:SetSize(65,17)
			copyBtn:SetPos(Actoji.i_MenuTErr:GetWide() - 120,3)
			copyBtn:SetText("Copy Text")
			copyBtn.DoClick = function() SetClipboardText(Actoji.i_MenuTErr.Gtxt) surface.PlaySound("buttons/button15.wav") end
			copyBtn.Think = function() copyBtn:SetPos(Actoji.i_MenuTErr:GetWide() - 120,3) end
			Actoji.i_MenuTErr.riText = vgui.Create("RichText", Actoji.i_MenuTErr)
			Actoji.i_MenuTErr.riText:Dock(FILL)
			Actoji.i_MenuTErr.riText:InsertColorChange( 255, 255, 255, 255 )
			Actoji.i_MenuTErr.riText:AppendText(Actoji.i_MenuTErr.Gtxt)
			function Actoji.i_MenuTErr.riText:PerformLayout() self:SetFontInternal("DermaDefault") end
			Actoji.i_MenuTErr.riText.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 20, 255)) end
			if aaSV then
				net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"i_MenuTErr","GetAllErrTabAct"} ) net.SendToServer()
			else
				Actoji.i_MenuTErr:TGTbl( istable(A_AM.ActMod.GetAllErrTabAct) and table.Copy(A_AM.ActMod.GetAllErrTabAct) or false )
			end
		end
	end
end)



Actoji.Crt_MenuPly = function(self, ply2)
    if IsValid(self.i_MenuPly) then
        self.i_MenuPly:Remove()
    end

    local Pl = LocalPlayer()
    local S_Pos1, S_Pos2, S_Siz1, S_Siz2 = ScrW() / 2, ScrH() / 5, 500, 250

    local function Ri_Table_Ply(Ply, Ret)
        Ply.GetR_i = Ret and Ply.GetR_i or {
            ["P_iFPS"] = "nil_",
            ["P_Ping"] = "nil_",
            ["P_Health"] = "nil_",
            ["P_HealthMax"] = "nil_",
            ["P_ddd"] = "nil_",
            ["P_Pos"] = "nil_",
            ["P_Ang"] = "nil_",
            ["P_Length"] = "nil_",
            ["P_Weap"] = "nil_"
        }
    end

    Ri_Table_Ply(ply2)

    local function CButt1(vch, ps1, ps2, sz1, zs2, txt)
        local SButton = vgui.Create("DButton", vch)
        SButton:SetText(txt or "")
        SButton:SetFont("ActMod_a1")
        SButton:SetAlpha(80)
        SButton:SetTextColor(Color(120, 215, 255))
        SButton:SetPos(ps1, ps2)
        SButton:SetSize(sz1, zs2)

        return SButton
    end

    local function Bdt(ps1, ps2, tcon)
        local ZZ, pp, N_mat, N_txt, N_fnt = self.i_MenuPly:GetWide() - 230, 35, "icon16/control_repeat_blue.png", "None :: ", "ActMod_a1"

        if tcon == "fps" then
            ZZ = 135
            N_mat = "icon16/control_repeat_blue.png"
            N_txt = "Fps : "
        elseif tcon == "Ping" then
            ZZ = 130
            N_mat = "icon16/transmit_blue.png"
            N_txt = "Ping : "
        elseif tcon == "ddd" then
            N_mat = "icon16/time.png"
            N_txt = "TimePlayer : "
        elseif tcon == "Health" then
            N_mat = "icon16/heart.png"
            N_txt = "Health : "
        elseif tcon == "Pos" then
            N_mat = "icon16/arrow_in.png"
            N_txt = "Pos : "
        elseif tcon == "Ang" then
            N_mat = "icon16/arrow_rotate_clockwise.png"
            N_txt = "Angle : "
        elseif tcon == "Length" then
            N_mat = "icon16/arrow_right.png"
            N_txt = "Velocity : "
        elseif tcon == "Weap" then
            N_mat = "icon16/gun.png"
            N_txt = "Weapon : "
        end

        local rh = vgui.Create("DButton", self.i_MenuPly)
        rh:SetPos(ps1, ps2)
        rh:SetSize(ZZ, 25)
        rh:SetText("")
        rh:SetAlpha(255)
        rh.ttaa = false
        rh.Paint = function(s, w, h)
            if not IsValid(ply2) then return end
            if s:IsHovered() then
                draw.RoundedBox(10, 0, 0, w, h, Color(70, 70, 60, 255))
            else
                draw.RoundedBox(10, 0, 0, w, h, Color(30, 40, 40, 255))
            end
            draw.SimpleText(N_txt, N_fnt, pp, 0, color_white)
            surface.SetDrawColor(color_white)
            surface.SetMaterial(Material(N_mat, "noclamp smooth"))
            surface.DrawTexturedRect(5, 0, 25, 25)
            if tcon == "fps" then
                draw.SimpleText(ply2.GetR_i["P_iFPS"], N_fnt, w - 10, 0, Color(200, 220, 255, 255), 2)
            elseif tcon == "Ping" then
                draw.SimpleText(ply2.GetR_i["P_Ping"], N_fnt, w - 10, 0, Color(200, 220, 255, 255), 2)
            elseif tcon == "Health" then
                draw.SimpleText(ply2.GetR_i["P_Health"] .. " / " .. ply2.GetR_i["P_HealthMax"], N_fnt, w - 10, 0, Color(255, 235, 215, 255), 2)
            elseif tcon == "ddd" then
                draw.SimpleText(ply2.GetR_i["P_ddd"], N_fnt, w - 10, 0, Color(255, 235, 215, 255), 2)
            elseif tcon == "Pos" then
                draw.SimpleText(ply2.GetR_i["P_Pos"], "ActMod_a4", w - 10, 6, Color(255, 235, 215, 255), 2)
            elseif tcon == "Ang" then
                draw.SimpleText(ply2.GetR_i["P_Ang"], "ActMod_a5", w - 10, 4, Color(255, 235, 215, 255), 2)
            elseif tcon == "Length" then
                draw.SimpleText(ply2.GetR_i["P_Length"], N_fnt, w - 10, 0, Color(255, 235, 215, 255), 2)
            elseif tcon == "Weap" then
                draw.SimpleText(ply2.GetR_i["P_Weap"], "ActMod_a5", w - 10, 3, Color(255, 235, 215, 255), 2)
            end
        end
		rh.DoClick = function()
			surface.PlaySound("actmod/s/copy1.mp3")
			if tcon == "fps" then
				SetClipboardText(ply2.GetR_i["P_iFPS"])
			elseif tcon == "Ping" then
				SetClipboardText(ply2.GetR_i["P_Ping"])
			elseif tcon == "Health" then
				SetClipboardText(ply2.GetR_i["P_Health"] .. " / " .. ply2.GetR_i["P_HealthMax"])
			elseif tcon == "ddd" then
				SetClipboardText(ply2.GetR_i["P_ddd"])
			elseif tcon == "Pos" then
				SetClipboardText(ply2.GetR_i["P_Pos"])
			elseif tcon == "Ang" then
				SetClipboardText(ply2.GetR_i["P_Ang"])
			elseif tcon == "Length" then
				SetClipboardText(ply2.GetR_i["P_Length"])
			elseif tcon == "Weap" then
				SetClipboardText(ply2.GetR_i["P_Weap"])
			end
		end
        rh.Think = function()
            if IsValid(ply2) and (self.i_MenuPly.TimeR or 0) < CurTime() then
                self.i_MenuPly.TimeR = CurTime() + 0.5
				net.Start( "A_AM.ActMod.ClToSv_Tab",true ) net.WriteTable( {"ClToSv_PlyP_ToSv",{Pl,ply2,"GetTabiPly_1To2_Start",ply2.GetR_i}} ) net.SendToServer()
            end
        end
    end

    self.i_MenuPly = vgui.Create("DFrame")
    self.i_MenuPly:SetTitle(ply2:Nick() or "None")
    self.i_MenuPly:MakePopup()
    self.i_MenuPly:ShowCloseButton(false)
    self.i_MenuPly:SetSize(S_Siz1, S_Siz2)
    self.i_MenuPly:SetPos(S_Pos1 - S_Siz1 / 2, S_Pos2)
    self.i_MenuPly:SetAlpha(0)
    self.i_MenuPly:AlphaTo(255, 0.5)
    self.i_MenuPly.TimeR = CurTime() + 0.7
    self.i_MenuPly.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 60, 80, 255))
    end

    local CB1 = CButt1(self.i_MenuPly, self.i_MenuPly:GetWide() - 25, -25, 20, 20, "X")
    CB1:AlphaTo(255, 0.7, 0.5)
    CB1:MoveTo(self.i_MenuPly:GetWide() - 25, 5, 0.4, 0.5)
    CB1.Paint = function(SS, w, h)
        if SS:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
        end
    end
    CB1.DoClick = function()
        surface.PlaySound("garrysmod/balloon_pop_cute.wav")

        if IsValid(self.i_MenuPly) then
            self.i_MenuPly:Remove()
        end
    end

    local CB2 = CButt1(self.i_MenuPly, self.i_MenuPly:GetWide() - 50, -25, 20, 20, "-")
    CB2:AlphaTo(255, 0.7, 0.6)
    CB2:MoveTo(self.i_MenuPly:GetWide() - 50, 5, 0.4, 0.6)
    CB2.B_a = false
    CB2.Paint = function(SS, w, h)
        if CB2.B_a == true then
            if SS:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, Color(70, 70, 80, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(30, 20, 20, 255))
            end
        elseif SS:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 255))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(70, 70, 80, 255))
        end
    end
    CB2.DoClick = function()
        if CB2.B_a == false then
            CB2.B_a = true
            surface.PlaySound("bot/a.wav")
            self.i_MenuPly:AlphaTo(140, 0.2)

            if IsValid(self.i_MenuPly) then
                self.i_MenuPly:SetKeyboardInputEnabled(false)
                self.i_MenuPly:SetMouseInputEnabled(false)
            end
        else
            CB2.B_a = false
            surface.PlaySound("bot/b.wav")
            self.i_MenuPly:AlphaTo(255, 0.2)

            if IsValid(self.i_MenuPly) then
                self.i_MenuPly:SetKeyboardInputEnabled(true)
                self.i_MenuPly:SetMouseInputEnabled(true)
            end
        end
    end

    local AAvatar = vgui.Create("AvatarImage", self.i_MenuPly)
    local zz = 210
    AAvatar:SetSize(zz, zz)
    AAvatar:SetPos(10, 20)
    AAvatar:SetPlayer(ply2, zz)
    local hh, adh = 30, 30
    Bdt(zz + 10, hh, "fps")
    Bdt(zz + 150, hh, "Ping")
    hh = hh + adh
    Bdt(zz + 10, hh, "ddd")
    hh = hh + adh
    Bdt(zz + 10, hh, "Health")
    hh = hh + adh
    Bdt(zz + 10, hh, "Pos")
    hh = hh + adh
    Bdt(zz + 10, hh, "Ang")
    hh = hh + adh
    Bdt(zz + 10, hh, "Length")
    hh = hh + adh
    Bdt(zz + 10, hh, "Weap")
    hh = hh + adh
end

Actoji.HelpActMod = function(self)
	A_AM.ActMod:MListHlp()
end

A_AM.ActMod.LuaVgi_Done = true
