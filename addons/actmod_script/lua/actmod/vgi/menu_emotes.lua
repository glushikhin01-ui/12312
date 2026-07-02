if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaVgi_MEmote = true

if SERVER then return end

local Actoji = A_AM.ActMod.Actoji
local TLang = A_AM.ActMod.TLang

local function Mar_TabDat(tbl, str, hlp) return A_AM.ActMod:Mar_TabDat(tbl, str, hlp) end
local function aShowCopy(s) A_AM.ActMod:aShowCopy(s) end
local function sStNewDat(pl, Sstr) return A_AM.ActMod:sStNewDat(pl, Sstr) end
local function CTxtMos(Ow, IsH, Ty, txt, txf, aup) A_AM.ActMod:CTxtMos(Ow, IsH, Ty, txt, txf, aup) end
local function GetReadyFUse(ply) return A_AM.ActMod:GetReadyFUse(ply) end
local function ReString(st, tam4) return A_AM.ActMod:ReString(st, tam4) end
local function RvString(ara) return A_AM.ActMod:RvString(ara) end
local function AC_butCh(Gw, Gh, Zw, Zh, es, txt, alp) return A_AM.ActMod:AC_butCh(Gw, Gh, Zw, Zh, es, txt, alp) end
local function aSatLang(self) A_AM.ActMod:aSatLang(self) end
local function DBtO(Gw, Gh, es, NBt) return A_AM.ActMod:DBtO(Gw, Gh, es, NBt) end
local function BTt1(bs, px, ph, zx, zh, txt) return A_AM.ActMod:BTt1(bs, px, ph, zx, zh, txt) end
local function RoundDT(num) return math.floor(num / 10) * 10 end

local function DrawColorCircles(x, y,baseRadius,count,spacing,thickness,speed,colorMode,manualColor,alpha)
	alpha = alpha or 255
	thickness = thickness or 0

	local t = CurTime() * speed

	for i = 0, count - 1 do
		local radius = baseRadius + i * spacing
		local r, g, b
		if colorMode == 1 and manualColor then
			r, g, b = manualColor.r, manualColor.g, manualColor.b
		else
			local offset = (colorMode == 3) and (i * 0.6) or 0
			local time = t + offset
			r = (math.sin(time) + 1) * 127.5
			g = (math.sin(time + 2) + 1) * 127.5
			b = (math.sin(time + 4) + 1) * 127.5
		end
		if thickness > 0 then
			for t2 = 0, thickness do
				surface.DrawCircle(x, y, radius - t2, r, g, b, alpha)
			end
		else
			surface.DrawCircle(x, y, radius, r, g, b, alpha)
		end
	end
end

A_AM.ActMod.wMatCache = A_AM.ActMod.wMatCache or {}
function A_AM.ActMod:GetWMaterial(matPath, width, height)
    width = width or 64
    height = height or 64
    local cacheKey = matPath .. "_|_" .. width .. "x" .. height
    if A_AM.ActMod.wMatCache[cacheKey] then return A_AM.ActMod.wMatCache[cacheKey] end
    local rtName = "am4_w_rt_" .. string.gsub(matPath, "[^%w]", "_") .. "_" .. string.Replace(tostring(CurTime()), ".", "_")
    local rt = GetRenderTarget(rtName, width, height, false)
    local originalMat = Material(matPath)
    local tempRT = GetRenderTarget(rtName .. "_temp", width, height, false)
    render.PushRenderTarget(tempRT)
        render.Clear(0, 0, 0, 0, true, true)
        cam.Start2D()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(originalMat)
            surface.DrawTexturedRect(0, 0, width, height)
        cam.End2D()
    render.PopRenderTarget()
    render.PushRenderTarget(tempRT)
        render.CapturePixels()
        local pixels = {}
        for y = 0, height - 1 do
            for x = 0, width - 1 do
                local r, g, b, a = render.ReadPixel(x, y)
                if a > 0 then
                    pixels[#pixels + 1] = {x, y, 255, 255, 255, a}
                end
            end
        end
    render.PopRenderTarget()
    render.PushRenderTarget(rt)
        render.Clear(0, 0, 0, 0, true, true)
        cam.Start2D()
            surface.SetDrawColor(255, 255, 255, 255)
            for i = 1, #pixels do
                local p = pixels[i]
                surface.SetDrawColor(p[3], p[4], p[5], p[6])
                surface.DrawRect(p[1], p[2], 1, 1)
            end
        cam.End2D()
    render.PopRenderTarget()
    local whiteMat = CreateMaterial(
        "am4_w_mat_" .. rtName,
        "UnlitGeneric",
        {
            ["$basetexture"] = rtName
            ,["$translucent"] = 1
            ,["$vertexcolor"] = 1
            ,["$vertexalpha"] = 1
        }
    )
    A_AM.ActMod.wMatCache[cacheKey] = whiteMat
    return whiteMat
end
function A_AM.ActMod:ClearWMaterialCache(ata)
	if not ata then
		for name, _ in pairs(hook.GetTable()["HUDPaint"] or {}) do
			if string.StartWith(name, "awmat_|") then hook.Remove("HUDPaint", name) end
		end
    end
    A_AM.ActMod.wMatCache = {}
	collectgarbage()
end
A_AM.ActMod:ClearWMaterialCache()


function A_AM.ActMod:LShowSOpKes(aelf,DBu)
	if IsValid(DBu.pgh) then
		DBu.pgh:Remove()
		DBu.pgh = nil
	else
		local txt1 = aR:T("LButt_LB_txt1")
		local aZtxt1 = A_AM.ActMod:AZtxt(txt1, "ChatFont")
		local aa_self = vgui.Create("DButton")
		aa_self:SetSize(ScrW(), ScrH())
		aa_self:SetText("")
		aa_self:MakePopup()
		aa_self:SetCursor( "arrow" )
		aa_self:Center()
		aa_self:SetAlpha(0)
		aa_self.DoClick = function () if IsValid(DBu.pgh) then DBu.pgh:Remove() end end
		DBu.pgh = vgui.Create("DFrame", aelf.Frame)
		local pgh = DBu.pgh
		pgh:MakePopup()
		pgh:SetSize(638, 450)
		pgh:SetPos(ScrW()/2 - pgh:GetWide()/2, ScrH()/2 - pgh:GetTall()/2)
		gui.SetMousePos(ScrW()/2 - pgh:GetWide()/2.01, ScrH()/2 - pgh:GetTall()*0.022)
		pgh:SetTitle("")
		pgh:SetDraggable(false)
		pgh:ShowCloseButton(false)
		pgh.tt = true
		pgh.tt2 = true
		pgh.OnRemove = function() if IsValid(aa_self) then aa_self:Remove() end end
		pgh.Paint = function(ste, w, h)
			draw.RoundedBox(10, 0, 0, w, h, Color(90, 100, 200, 255))
			draw.RoundedBox(10, 5, 30, w - 10, h*0.4, Color(50, 50, 100, 255))
			draw.RoundedBox(10, 5, 260, w - 10, h*0.4, Color(50, 50, 100, 255))
			draw.SimpleText(txt1, "ChatFont", 30, 15, Color(255, 255, 155, 255),0,1)
			draw.SimpleText(aR:T("LButt_LB_txt2"), "ChatFont", 140 + aZtxt1, 15, Color(255, 255, 155, 255),0,1)
			draw.SimpleText("-----------------------------------------------", "CloseCaption_Bold", w/2, h/2.025, Color(255, 255, 155, 255),1,1)
			draw.SimpleText(txt1, "ChatFont", 30, h*0.545, Color(255, 255, 155, 255),0,1)
			draw.SimpleText(aR:T("LButt_LB_txt2"), "ChatFont", 140 + aZtxt1, h*0.545, Color(255, 255, 155, 255),0,1)
		end

		local DBuBox = vgui.Create("DCheckBoxLabel", pgh)
		DBuBox:SetPos(10, 8) DBuBox:SetSize(15, 15)
		DBuBox:SetText("") DBuBox:SetConVar("actmod_cl_allowkey")
		

		local DBuBox2 = vgui.Create("DCheckBoxLabel", pgh)
		DBuBox2:SetPos(10, pgh:GetTall()*0.53) DBuBox2:SetSize(15, 15)
		DBuBox2:SetText("") DBuBox2:SetConVar("actmod_cl_allowkey2")

		if GetConVarNumber("actmod_cl_allowkey") ~= 0 then pgh.xt = BTt1(pgh, pgh:GetWide() - 35, 5, 25, 20, "X") end

		pgh.rt = BTt1(pgh, pgh:GetWide() - 65, 5, 25, 20, "R")
		pgh.rt2 = BTt1(pgh, pgh:GetWide() - 35, pgh:GetTall()*0.525, 25, 20, "R2")
		local aa, ga_w, ga_h, ea, z, va = 15, 127, 100, pgh, 100, 65

		pgh.ASpow = function(s)
			if pgh.tt == false then return end
			if IsValid(pgh.bH) then pgh.bH:Remove() pgh.bH = nil end
			pgh.bH = AC_butCh(aZtxt1 + 35, 8, 100, 15, pgh, {"actmod_keyo_h", "ChatFont"})
			if IsValid(pgh.ASp1) then pgh.ASp1:Remove() pgh.ASp1 = nil end
			pgh.ASp1 = DBtO(aa - 5, ga_h - va, pgh, 1)
			if IsValid(pgh.ASp2) then pgh.ASp2:Remove() pgh.ASp2 = nil end
			pgh.ASp2 = DBtO(aa - 5 + ga_w, ga_h - va, pgh, 2)
			if IsValid(pgh.ASp3) then pgh.ASp3:Remove() pgh.ASp3 = nil end
			pgh.ASp3 = DBtO(aa - 5 + ga_w * 2, ga_h - va, pgh, 3)
			if IsValid(pgh.ASp4) then pgh.ASp4:Remove() pgh.ASp4 = nil end
			pgh.ASp4 = DBtO(aa - 5 + ga_w * 3, ga_h - va, pgh, 4)
			if IsValid(pgh.ASp5) then pgh.ASp5:Remove() pgh.ASp5 = nil end
			pgh.ASp5 = DBtO(aa - 5 + ga_w * 4, ga_h - va, pgh, 5)
			aelf.MakeButton(aa, ga_h, ea, z, 17 ,true)
			aelf.MakeButton(aa + ga_w, ga_h, ea, z, 18 ,true)
			aelf.MakeButton(aa + ga_w * 2, ga_h, ea, z, 19 ,true)
			aelf.MakeButton(aa + ga_w * 3, ga_h, ea, z, 20 ,true)
			aelf.MakeButton(aa + ga_w * 4, ga_h, ea, z, 21 ,true)
			pgh.tt = true
		end
		pgh.ASpow()

		local aa, ga_w, ga_h, ea, z, va = 15, 127, 330, pgh, 100, 65
		pgh.ASpow2 = function(s)
			if pgh.tt2 == false then return end
			if IsValid(pgh.bH2) then pgh.bH2:Remove() pgh.bH2 = nil end
			pgh.bH2 = AC_butCh(aZtxt1 + 35, pgh:GetTall()*0.53, 100, 15, pgh, {"actmod_keyo_h2", "ChatFont"})
			if IsValid(pgh.ASp21) then pgh.ASp21:Remove() pgh.ASp21 = nil end
			pgh.ASp21 = DBtO(aa - 5, ga_h - va, pgh, 6)
			if IsValid(pgh.ASp22) then pgh.ASp22:Remove() pgh.ASp22 = nil end
			pgh.ASp22 = DBtO(aa - 5 + ga_w, ga_h - va, pgh, 7)
			if IsValid(pgh.ASp23) then pgh.ASp23:Remove() pgh.ASp23 = nil end
			pgh.ASp23 = DBtO(aa - 5 + ga_w * 2, ga_h - va, pgh, 8)
			if IsValid(pgh.ASp24) then pgh.ASp24:Remove() pgh.ASp24 = nil end
			pgh.ASp24 = DBtO(aa - 5 + ga_w * 3, ga_h - va, pgh, 9)
			if IsValid(pgh.ASp25) then pgh.ASp25:Remove() pgh.ASp25 = nil end
			pgh.ASp25 = DBtO(aa - 5 + ga_w * 4, ga_h - va, pgh, 10)
			aelf.MakeButton(aa, ga_h, ea, z, 70 ,true)
			aelf.MakeButton(aa + ga_w, ga_h, ea, z, 71 ,true)
			aelf.MakeButton(aa + ga_w * 2, ga_h, ea, z, 72 ,true)
			aelf.MakeButton(aa + ga_w * 3, ga_h, ea, z, 73 ,true)
			aelf.MakeButton(aa + ga_w * 4, ga_h, ea, z, 74 ,true)
			pgh.tt2 = true
		end
		pgh.ASpow2()

		pgh.ALoked = function(at)
			local txt1 = aR:T("LButt_LB_txt4")
			local aZtxt1 = A_AM.ActMod:AZtxt(txt1, "CloseCaption_Bold")
			if at then pgh.loked2 = vgui.Create("DPanel", pgh) else pgh.loked = vgui.Create("DPanel", pgh) end
			local Dloked = at and pgh.loked2 or pgh.loked
			Dloked:SetPos(0, at and pgh:GetTall()*0.52 or 4)
			Dloked:SetSize(pgh:GetWide(), pgh:GetTall()*0.47)
			if IsValid(pgh) then LocalPlayer().pgh_loked = pgh end
			Dloked.Paint = function(ste, w, h)
				draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 70, 200))
				draw.SimpleText(">", "CloseCaption_Bold", w / 2 - (aZtxt1 / 2 + 20 + 20 + (20 * math.sin(CurTime() * 7))), h / 2 + 18, Color(200, 255, 255, 255), 1, 1)
				draw.SimpleText("<", "CloseCaption_Bold", w / 2 + (aZtxt1 / 2 + 20 + 20 + (20 * math.sin(CurTime() * 7))), h / 2 + 18, Color(200, 255, 255, 255), 1, 1)
			end
			local DBa = vgui.Create("DButton", Dloked)
			DBa:SetSize(15 + aZtxt1, 40)
			DBa:SetPos(pgh:GetWide() / 2 - DBa:GetWide() / 2, Dloked:GetTall() / 2)
			DBa:SetText("")
			DBa.Paint = function(ste, w, h)
				draw.RoundedBox(15, 0, 0, w, h, Color(100, 150, 100, 200))
				draw.RoundedBox(10, 0, 0, w, h, ste:IsDown() and Color(100, 130, 100, 255) or ste:IsHovered() and Color(100, 150, 200, 200) or Color(100, 100, 100, 200))
				draw.SimpleText(txt1, "CloseCaption_Bold", w / 2, h / 2, Color(200, 255, 255, 255), 1, 1)
			end
			DBa.DoClick = function(s)
				if at then
					LocalPlayer():ConCommand("actmod_cl_allowkey2 1\n")
				else
					LocalPlayer():ConCommand("actmod_cl_allowkey 1\n")
				end
				if IsValid(pgh) then LocalPlayer().pgh_loked = pgh end
			end
			if IsValid(pgh.xt) then pgh.xt:Remove() pgh.xt = nil end
			pgh.xt = BTt1(pgh, pgh:GetWide() - 35, 5, 25, 20, "X")
		end

		if GetConVarNumber("actmod_cl_allowkey") == 0 then pgh.ALoked() end
		if GetConVarNumber("actmod_cl_allowkey2") == 0 then pgh.ALoked(true) end
		if IsValid(pgh) then LocalPlayer().pgh_loked = pgh end
	end
end

local function SwapEmoteSlots(slotA, slotB)
	local iconA = Actoji.table[slotA] or A_AM.ActMod.AGetDitN[slotA]
	local iconB = Actoji.table[slotB] or A_AM.ActMod.AGetDitN[slotB]
	Actoji.table[slotA] = iconB
	Actoji.table[slotB] = iconA
	A_AM.ActMod:ReAddEmts("savemots",{{{A_AM.ActMod:ActojTyp(slotA),A_AM.ActMod.aNTyp[slotA],iconB},{A_AM.ActMod:ActojTyp(slotB),A_AM.ActMod.aNTyp[slotB],iconA}},"tab",true},nil, function(t,g) A_AM.ActMod:RCFi(t,g) end)
	timer.Simple(0, function() A_AM.ActMod:RefshEmot(slotA) A_AM.ActMod:RefshEmot(slotB) end)
end

Actoji.OpenEmote = function(self,vrShow)
	
    local ply,w,h = LocalPlayer() ,ScrW() / 1.08 ,ScrH() / 1.08
    ply.ActMod_UseMenu = true

    if w > h then w = h else h = w end
	
	local ActMod_a4_SC = A_AM.ActMod:CGFont("ActMod_a4_SC", {font = "Roboto Regular",size = w*0.016})
	local ActMod_a8_SC = A_AM.ActMod:CGFont("ActMod_a8_SC", {font = "Roboto Regular",size = w*0.04})

    if not vrShow and ply.ActMod_MousePos then gui.SetMousePos(ply.ActMod_MousePos[1], ply.ActMod_MousePos[2]) end
	if GetConVarNumber("actmod_cl_pageslot") < 1 or GetConVarNumber("actmod_cl_pageslot") > 8 then ply:ConCommand("actmod_cl_pageslot 1\n") end

    local EndFrameA = vgui.Create("DButton")
    EndFrameA:SetSize(ScrW(), ScrH())
    EndFrameA:SetText("")
    EndFrameA:SetCursor("arrow")
    EndFrameA:Center()
    EndFrameA:SetAlpha(0)
    EndFrameA.DoClick = function(s)
        if IsValid(self.PanelLoadigAnimSy) then self.PanelLoadigAnimSy:Remove() end
        if IsValid(self.Frame) then self.Frame:Remove() end
    end
    EndFrameA.Paint = function(ste, aw, ah) end
	
	if IsValid(self.PanelLoadigAnimSy) then self.PanelLoadigAnimSy:Remove() end
    self.PanelLoadigAnimSy = vgui.Create("DPanel")
    self.PanelLoadigAnimSy:SetText("")
	self.PanelLoadigAnimSy.atxt = "Loading... " self.PanelLoadigAnimSy.ztxt = A_AM.ActMod.aGetTextSize(self.PanelLoadigAnimSy.atxt,"ActMod_a3")
	self.PanelLoadigAnimSy:SetSize(self.PanelLoadigAnimSy.ztxt + 60, 30) self.PanelLoadigAnimSy:SetPos(ScrW() - self.PanelLoadigAnimSy:GetWide()-10, 10)
    self.PanelLoadigAnimSy.Paint = function(ste, aw, ah) end
	local PASY = self.PanelLoadigAnimSy
    PASY.Plist = vgui.Create("DButton",PASY)
    PASY.OnRemove = function(pan) if IsValid(PASY.Plist) then PASY.Plist:Remove() end end
    PASY.Plist:SetText("") PASY.Plist:Dock(FILL) PASY.Plist:SetCursor( "arrow" ) PASY.Plist:SetAlpha(0)
    PASY.Plist.isLoding = false PASY.Plist:SetDisabled(false) PASY.Plist.GLoding = 0
    PASY.Plist.Paint = function(ste, aw, ah)
		local PSho = aAC_Lta and aAC_Lta.nUm or 0
		if PSho > 0 and PSho < 100 then
			if not ste.isLoding then
				ste.isLoding = true ste:SetAlpha(0) ste:AlphaTo(255, 0.3)
				if IsValid(self.PanelLoadigAnimSy) then self.PanelLoadigAnimSy:SetDisabled(false) end
				if ste.isFrameH and not IsValid(self.Frame) then self.PanelLoadigAnimSy:Remove() end
				ste:SetDisabled(false)
			end
			ste.GLoding = PSho
			CTxtMos(ste, nil, {100, 100, 50, 140}, "Loading Custom Animation", "CreditsText", -2)
		elseif ste.isLoding then
			ste.isLoding = false
			ste:AlphaTo(0, 0.5,0.5,function()
				if self.PanelLoadigAnimSy and IsValid(self.PanelLoadigAnimSy) then self.PanelLoadigAnimSy:SetDisabled(true) end
				if ste and IsValid(ste) then ste:SetDisabled(true) end
			end)
		end
		draw.RoundedBox(5, 0, 0, aw, ah, Color(20, 50, 255, 200))
		draw.RoundedBox(10, 5, ah - 9, aw-10, 6, Color(0, 0, 0, 150))
		draw.RoundedBox(10, 5, ah - 9, math.Remap( ste.GLoding, 0, 100, 0, aw-10 ), 6, Color(60, 255, 255, 200))
		draw.SimpleText(PASY.atxt .. math.Round(ste.GLoding,2) .. "%", "ActMod_a3", 2, ah/2-5, Color(180, 255, 255, 255), 0, 1)
	end
	PASY.Plist.DoClick = function(s)
	end
	
    self.Frame = vgui.Create("DPanel")
    self.Frame:SetText("") PASY.Plist.isFrameH = true
    self.Frame.OnRemove = function(pan)
        ply.ActMod_UseMenu = nil
		ply.CKeyAct_UseMenu = nil
        if IsValid(self.PanelLoadigAnimSy) then self.PanelLoadigAnimSy:Remove() end
        if IsValid(self.Loding) then self.Loding:Remove() end
		if IsValid(self.LitHelp) then self.LitHelp:Remove()end
        if IsValid(EndFrameA) then EndFrameA:Remove() end
        if IsValid(self.LitLang) then self.LitLang:Remove() end
        if self.Frame.dragState then if IsValid(self.Frame.dragState.ghostPanel) then self.Frame.dragState.ghostPanel:Remove() end self.Frame.dragState.pendingCrossPage = nil end
        if IsValid(self.Underlay) then
			if IsValid(self.Underlay.DButCh) then self.Underlay.DButCh:CloseMenu() end
			if self.Underlay.TDComboBox then for k, v in pairs(self.Underlay.TDComboBox) do if IsValid(v) then v:CloseMenu() end end end
			if IsValid(self.Underlay.Cmenu) then self.Underlay.Cmenu:Remove() end
			if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
			self.Underlay:SetVisible(false)
		end
    end
	if vrShow and isnumber(vrShow) then
		self.Frame:SetPaintedManually(true)
	end
	A_AM.ActMod.Truevr = vrShow or false
	self.Frame.TabEmots = {}

    if (A_AM.ActMod.A_ActMod_RedyUse and GetConVarNumber("actmod_cl_eloading") ~= 0) or GetConVarNumber("actmod_cl_eloading") == 0 then
        if GetConVarNumber("actmod_cl_sortemote") > 2 then
            self.Frame:SetSize(ScrW(), ScrW()*0.125) self.Frame:SetPos(ScrW()/2-self.Frame:GetWide()/2 ,ScrH()-self.Frame:GetTall()-5)
        elseif GetConVarNumber("actmod_cl_sortemote") == 2 then
            self.Frame:SetSize(math.Clamp(h*1.06, 751/3,751), math.Clamp(h*0.6865, 470/1.4,470)) self.Frame:Center()
        else
            self.Frame:SetSize(w, h) self.Frame:Center()
        end
    else
        self.Frame:SetSize(0, 0)
        self.Frame.SSz = true
		if GetConVarNumber("actmod_cl_eloading") ~= 0 then
			self.Loding = vgui.Create("DPanel")
			self.Loding:SetPos(ScrW() / 2 - 380 / 2, ScrH() / 2 - 100)
			self.Loding:SetSize(380, 80)
			self.Loding:SetText("")
			self.Loding.Paint = function(ste, aw, ah)
				local WiDl
				local PSho = A_AM.ActMod.A_ActMod_RedyUse_Num or 0
		
				draw.RoundedBox(15, 0, 0, aw, ah, Color(50, 70, 90, 150))
				draw.SimpleText(aR:T("wndSetup_Checks"), "ActMod_a6", 2, 25, Color(180, 255, 200, 255), nil, TEXT_ALIGN_CENTER)
				draw.SimpleText(PSho .. "%", "ActMod_a6", aw - 57, 25, Color(180, 255, 200, 255), nil, TEXT_ALIGN_CENTER)
				draw.RoundedBox(10, 10, 40, aw - 20, 30, Color(20, 20, 20, 150))
				draw.RoundedBox(10, 10, 40, math.Remap( PSho, 0, 100, 0, aw - 20 ), 30, Color(20, 150, 100, 150))
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
				draw.SimpleText(WiDl, "ActMod_a5", aw / 2, 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				WiDl = nil
			end
        end
    end

    self.Frame:SetKeyboardInputEnabled(false)
	self.Frame:MakePopup()
	if not vrShow then
		self.Frame:SetAlpha(0)
		if GetReadyFUse(ply) == true then
			self.Frame:AlphaTo(255, 0.1)
		else
			self.Frame:AlphaTo(85, 0.1)
		end
    end

    if A_AM.ActMod.A_ActMod_RedyUse and (not ConVarExists("actmod_cl_lang") or ConVarExists("actmod_cl_lang") and Mar_TabDat(TLang, GetConVarString("actmod_cl_lang")) == false) then
		aSatLang(self)
		self.Frame.Paint = function(s, w, h) end
		return
    end
	
	if not A_AM.ActMod.A_ActMod_RedyUse then
		self.Frame.Paint = function(s, w, h)
			local p_w,p_h,z_w,z_h = 20,h/2-10,w-40,20
			local nu = math.Remap((A_AM.ActMod.A_ActMod_RedyUse_Num or 0),0,100,0,1)
			draw.RoundedBox(0, p_w+2,p_h+2, z_w-4, z_h-4, Color(50, 70, 100, 255))
			draw.RoundedBox(0, p_w+2,p_h+2, (z_w-4)*nu, z_h-4, Color(50, 255, 255, 255))
			surface.SetDrawColor(Color(255,255,255,255))
			surface.DrawOutlinedRect(p_w,p_h,z_w,z_h, 2)
			draw.RoundedBox(0, p_w,p_h-22,70,23, Color(50, 50, 100, 100))
			draw.SimpleText("ActMod", "ActMod_a3", p_w+4,(p_h-11), Color(255, 255, 255, 255),0,1)
			surface.SetDrawColor(Color(255,255,255,255))
			surface.DrawOutlinedRect(p_w,p_h-22,70,23, 2)
		end
		return
	end
	
    local function getIntercept(x, y, radius, angle, w, h)
        return x + (radius * math.sin(angle)) - (w or 0), y + (radius * -math.cos(angle)) - (h or 0)
    end

    local function DrawLine(w, h, a, rMul)
        local r = (h / 2) * (rMul or 1)
        local x, y = getIntercept(w / 2, h / 2, r, a)
        surface.DrawLine(w / 2, h / 2, x, y)
    end

    local function DrOuR2(x, z, w, h, Co, sA)
        surface.SetDrawColor(Co)
        surface.DrawOutlinedRect(x, z, w, h, sA)
    end

	self.Frame._openTime = CurTime()
	
    local pi = 3.14159265
    local pr = 8.13

    self.Frame.Paint = function(s, w, h)
        if GetConVarNumber("actmod_cl_sortemote") > 2 then
            if GetConVarNumber("actmod_cl_menuformat2") == 1 then
                draw.RoundedBox(20, 9.2, 5, w - 18.4, h-10, Color(70, 150, 255, 140))
                draw.RoundedBox(10, 9.2, 10, w - 19.2, h - 20, Color(2, 2, 5, 180))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 2 then
                draw.RoundedBox(20, 9.2, 5, w - 18.4, h-10, Color(120, 20, 50, 100))
                draw.RoundedBox(10, 9.2, 10, w - 19.2, h - 20, Color(30, 70, 80, 150))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 3 then
                draw.RoundedBox(20, 9.2, 5, w - 18.4, h-10, Color(120, 100, 255, 70))
                draw.RoundedBox(10, 9.2, 10, w - 19.2, h - 20, Color(2, 2, 5, 150))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 4 then
                draw.RoundedBox(20, 9.2, 5, w - 18.4, h-10, Color(90, 90, 90, 130))
                draw.RoundedBox(10, 9.2, 10, w - 19.2, h - 20, Color(0, 0, 0, 150))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 5 then
                draw.RoundedBox(0, 0, 0, w, h, Color(90, 100, 100, 160))
                DrOuR2(0, 0, w,h , Color(90, 90, 90, 255),5)
                DrOuR2(5,5, w-10,h-10 ,Color(90, 95, 120, 240),4)
                DrOuR2(9,9, w-18,h-18 ,Color(90, 110, 150, 200),3)
                DrOuR2(12,12, w-24,h-24 ,Color(110, 150, 180, 150),2)
            end
        elseif GetConVarNumber("actmod_cl_sortemote") == 2 then
            if GetConVarNumber("actmod_cl_menuformat2") == 1 then
                draw.RoundedBox(40, 9.2, 5, w - 18.6, h - 65, Color(70, 150, 255, 140))
                draw.RoundedBox(40, 9.2, 20, w - 19.2, h - 95, Color(2, 2, 5, 180))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 2 then
                draw.RoundedBox(40, 9.2, 5, w - 18.6, h - 65, Color(120, 20, 50, 100))
                draw.RoundedBox(40, 9.2, 20, w - 19.2, h - 95, Color(30, 70, 80, 150))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 3 then
                draw.RoundedBox(40, 9.2, 5, w - 18.6, h - 65, Color(120, 100, 255, 70))
                draw.RoundedBox(40, 9.2, 20, w - 19.2, h - 95, Color(2, 2, 5, 150))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 4 then
                draw.RoundedBox(40, 9.2, 5, w - 18.6, h - 65, Color(60, 70, 70, 100))
                draw.RoundedBox(40, 9.2, 20, w - 19.2, h - 95, Color(0, 0, 0, 150))
            elseif GetConVarNumber("actmod_cl_menuformat2") == 5 then
				local l = h*0.8
                draw.RoundedBox(0, 0, 0, w, l, Color(150, 200, 200, 110))
                DrOuR2(0, 0, w,l , Color(90, 90, 90, 255),5)
                DrOuR2(5,5, w-10,l-10 ,Color(90, 95, 120, 240),4)
                DrOuR2(9,9, w-18,l-18 ,Color(90, 110, 150, 200),3)
                DrOuR2(12,12, w-24,l-24 ,Color(110, 150, 180, 150),2)
            end
        else
			local openFrac = math.Clamp((CurTime() - (s._openTime or 0)) / 0.3, 0, 1)
			local rMul = openFrac * openFrac * (3 - 2 * openFrac)
            if GetConVarNumber("actmod_cl_menuformat") == 1 then
                surface.SetDrawColor(50, 50, 255, 150)
                DrawLine(w, h, pi / 8, rMul)
                DrawLine(w, h, pi / 2 - pi / 8, rMul)
                DrawLine(w, h, pi / 2 + pi / 8, rMul)
                DrawLine(w, h, pi - pi / 8, rMul)
                DrawLine(w, h, pi + pi / 8, rMul)
                DrawLine(w, h, pi * 1.5 - pi / 8, rMul)
                DrawLine(w, h, pi * 1.5 + pi / 8, rMul)
                DrawLine(w, h, pi * 2 - pi / 8, rMul)
                surface.SetDrawColor(50, 255, 50, 150)
                DrawLine(w, h, pi / pr, rMul)
                DrawLine(w, h, pi / 2 - pi / pr, rMul)
                DrawLine(w, h, pi / 2 + pi / pr, rMul)
                DrawLine(w, h, pi - pi / pr, rMul)
                DrawLine(w, h, pi + pi / pr, rMul)
                DrawLine(w, h, pi * 1.5 - pi / pr, rMul)
                DrawLine(w, h, pi * 1.5 + pi / pr, rMul)
                DrawLine(w, h, pi * 2 - pi / pr, rMul)
                surface.SetDrawColor(255, 50, 50, 150)
                local pr = 7.93
                DrawLine(w, h, pi / pr, rMul)
                DrawLine(w, h, pi / 2 - pi / pr, rMul)
                DrawLine(w, h, pi / 2 + pi / pr, rMul)
                DrawLine(w, h, pi - pi / pr, rMul)
                DrawLine(w, h, pi + pi / pr, rMul)
                DrawLine(w, h, pi * 1.5 - pi / pr, rMul)
                DrawLine(w, h, pi * 1.5 + pi / pr, rMul)
                DrawLine(w, h, pi * 2 - pi / pr, rMul)
            elseif GetConVarNumber("actmod_cl_menuformat") == 2 then
                local radius = math.min(w, h) * rMul
				DrawColorCircles(
					w / 2, h / 2,
					radius/12,
					8,radius*0.015,0,
					-2,3,nil,255
				)
                surface.DrawCircle(w / 2, h / 2, radius / 2.02, Color(220, 10, 255, 140))
                surface.DrawCircle(w / 2, h / 2, radius / 2, Color(100, 155, 255, 140))
            end
        end

        if GetReadyFUse(ply) ~= true then
            local WiDl

            if GetConVarNumber("actmod_sv_a_vehicles") == 0 and ply:InVehicle() then
                WiDl = aR:T("iCantUse_inVehicle")
            elseif GetConVarNumber("actmod_sv_a_ground") == 1 and not ply:OnGround() then
                WiDl = aR:T("iCantUse_notFloor")
            elseif GetConVarNumber("actmod_sv_a_crouching") == 0 and ply:Crouching() then
                WiDl = aR:T("iCantUse_Crouching")
            elseif prone and (ply:GetNW2Int("prone.AnimationState", 3) ~= 3 or ply:GetNWInt("prone.AnimationState", 3) ~= 3) then
                WiDl = aR:T("iCantUse_prone")
            elseif ply:GetNWBool("wOS.LS.IsGetIncapped", false) then
                WiDl = aR:T("iCantUse_helpless")
            elseif (wOS and wOS.RollMod and ply:wOSIsRolling()) or ply:GetNWBool("wOS.LS.IsRolling", false) then
                WiDl = aR:T("iCantUse_rolling")
            elseif GetConVarNumber("actmod_sv_a_move") ~= 0 and ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) then
                WiDl = aR:T("iCantUse_moving")
            end

            if WiDl then
				local zw, zh = 450, 70
				local zw2, zh2 = math.max(zw - 10 + (8 * math.sin(CurTime() * 6)), 0), math.max(zh - 10 + (5 * math.sin(CurTime() * 6)), 0)
				draw.RoundedBox(10, w / 2 - (zw + 15) / 2, h / 2 - (zh + 15) / 2, zw + 15, zh + 15, Color(0, 0, 0, 255))
				draw.RoundedBox(10, w / 2 - (zw + 10) / 2, h / 2 - (zh + 10) / 2, zw + 10, zh + 10, Color(0, 0, 0, 255))
				draw.RoundedBox(10, w / 2 - zw / 2, h / 2 - zh / 2, zw, zh, Color(0, 0, 0, 255))
				draw.RoundedBox(10, w / 2 - zw2 / 2, h / 2 - zh2 / 2, zw2, zh2, Color(200, 100, 0, 255))
                draw.SimpleText(WiDl, "ActMod_a1", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
                draw.SimpleText(WiDl, "ActMod_a1", w / 2 + 1, h / 2 + 1, Color(255, 255, 255, 255), 1, 1)
            end
        end
    end

    self.Frame.tr = false

	local ATDataNew = A_AM.ActMod:LoadEmts("savefvit",{"Actojifavo"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
	if ATDataNew and istable(ATDataNew) then A_AM.ActMod.Actoji.AETData = ATDataNew end

    self.Frame.Think = function(s)
        local ply = LocalPlayer()
        if self.Frame.SSz == true then
			if A_AM.ActMod.A_ActMod_RedyUse then
                self.Frame.SSz = nil
                self:Close(true,vrShow)
            end
        elseif not vrShow then
            if GetReadyFUse(ply) == true then
                if self.Frame.tr == false then
                    self.Frame.tr = true
                    self.Frame:AlphaTo(255, 0.1)
                    return
                end
            else
                if self.Frame.tr == true then
                    self.Frame.tr = false
                    self.Frame:AlphaTo(85, 0.1)
                    return
                end
            end
        end
		if (self.Frame.TiRs or 0) < CurTime() then
			self.Frame.TiRs = CurTime() + 0.7
			local ATDataNew = A_AM.ActMod:LoadEmts("savefvit",{"Actojifavo"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
			if ATDataNew and istable(ATDataNew) then A_AM.ActMod.Actoji.AETData = ATDataNew end
		end
    end


    local aO,ButSize = 0.2,h*0.2
	local matbckd = Material("materials/actmod/imenu/iblocked_01.png", "noclamp smooth")
	self.Frame.dragState = { isDragging = false,sourceButton = nil,sourceSlot = nil,ghostPanel = nil,hoveredSlot = nil,originalPositions = {} ,pendingCrossPage = nil }
	local dragState = self.Frame.dragState
	local GetSTabEts = A_AM.ActMod:GetSTabEts()
	
    local function MakeButton(a, aa, aba, az, aN ,ntis)
        local ply = LocalPlayer()
        local vCs, BZz ,tx, ty
        if aba then vCs = aba else vCs = self.Frame end
        if az then
            BZz = az
        else
			if GetConVarNumber("actmod_cl_sortemote") > 2 then
				BZz = self.Frame:GetTall()*0.75
			elseif GetConVarNumber("actmod_cl_sortemote") == 2 then
				BZz = self.Frame:GetWide()*0.19
			else
				BZz = ButSize
			end
        end

		if self.Frame.TabEmots and istable(self.Frame.TabEmots) and self.Frame.TabEmots[aN] then self.Frame.TabEmots[aN] = nil end

        local e = vgui.Create("DButton", vCs)
        e:SetText("")
		e.OnRemove = function() if IsValid(e.Cmenu) then e.Cmenu:Remove() end end
        e:SetSize(BZz, BZz + 10)
        if GetConVarNumber("actmod_cl_sortemote") > 2 or aba then
            tx, ty = a, aa
        elseif GetConVarNumber("actmod_cl_sortemote") == 2 or aba then
            tx, ty = a, aa
        else
            tx, ty = getIntercept(self.Frame:GetWide() / 2, self.Frame:GetTall() / 2, self.Frame:GetWide() / 3, a, e:GetWide() / 2, e:GetTall() / 2)
        end
        e:SetPos(tx , ty)
		if not vrShow then e:SetAlpha(0) e:AlphaTo(255, aO) end
        e.Slot = aN
		local TActData = A_AM.ActMod:GetEmoIcn( GetSTabEts and GetSTabEts[A_AM.ActMod:ActojTyp(aN)] and GetSTabEts[A_AM.ActMod.aNTyp[aN]] or aN,A_AM.ActMod:ActaLoed(A_AM.ActMod:ActojTyp(aN),A_AM.ActMod.aNTyp[aN]) )
		if TActData and istable(TActData) and TActData[1] and TActData[2] then
			self.table[aN] = TActData[2]
			e.Material = TActData[1]
			e.Actoji = TActData[2]
			e.txtMat = TActData[3]
			if GetConVarNumber("actmod_cl_showsholightic") > 0 then e.WMaterial = A_AM.ActMod:GetWMaterial(e.txtMat, 128, 128) end
		else
			self.table[aN] = ""
		end
		
		if type(e.Material) ~= "IMaterial" or e.Material:IsError() then e.Material = Material("actmod/imenu/p_none.png","noclamp smooth") e.MatE = true else e.MatE = false end
		
        if GetConVar("actmod_sv_avs"):GetInt() > 0 then
            timer.Simple(0.1, function()
                if IsValid(ply) and IsValid(e) and e.Actoji then
                    if A_AM.ActMod:LokTabData(ply, A_AM.ActMod.ActLck, ReString(e.Actoji)) == true then
                        e.GLok = true
                    else
                        e.GLok = false
                    end
                end
            end)
        end

        e.DoRightClick = function(s)
            if input.IsMouseDown(MOUSE_LEFT) then
				if not s.Actoji or e.MatE then return end
				if IsValid(e.Cmenu) then e.Cmenu:Remove() end
				local ATData = {}
				local ATDataNew = A_AM.ActMod:LoadEmts("savefvit",{"Actojifavo"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
				if ATDataNew and istable(ATDataNew) then ATData = ATDataNew end
				e.Cmenu = DermaMenu()
				e.Cmenu:AddOption( aR:T("LReplace_txt_CopyName"), function() SetClipboardText(A_AM.ActMod:ReNameAct(ReString(s.Actoji))) aShowCopy(s) end ):SetIcon( "icon16/page_copy.png" )
				e.Cmenu:AddOption( "name_act", function() SetClipboardText(ReString(s.Actoji)) aShowCopy(s) end ):SetIcon( "icon16/page_copy.png" )
				e.Cmenu:AddSpacer()
				if ATData and A_AM.ActMod:ATabData(ATData, s.Actoji) == true then
					e.Cmenu:AddOption( aR:T("LReplace_txt_RemfF"), function()
						A_AM.ActMod:RemveFvite(s.Actoji)
					end ):SetIcon( "icon16/drive_delete.png" )
				else
					e.Cmenu:AddOption( aR:T("LReplace_txt_AddF"), function()
						A_AM.ActMod:AddToFvite(s.Actoji)
					end ):SetIcon( "icon16/drive_disk.png" )
				end
				e.Cmenu:AddSpacer()
				e.Cmenu:AddOption( " (i)   ".. aR:T("LGPly_tinfo"), function() A_AM.ActMod:ListGInfoAct(s.Actoji) end ):SetIcon( "icon16/information.png" )
				e.Cmenu:Open()
            else
                self:Replace(s.Slot, aba)
                A_AM.ActMod.ClServro(ply)
				GetSTabEts = nil
            end
        end

		local IsBLocd = A_AM.ActMod:IsDanceBlacklisted(e.Actoji)
		e.IsBLocd = IsBLocd
		if IsBLocd and not e.SCurr then e.SCurr = true e:SetCursor("arrow") end
        e.DoClick = function(s)
            if dragState.isDragging or s.IsBLocd or LocalPlayer().ActMod_cl_MisDragging then return end
            if not s.Actoji or s.MatE then self:Replace(s.Slot, aba) A_AM.ActMod.ClServro(ply) return end
			if GetReadyFUse(ply) ~= true or not A_AM.ActMod:aIsRdy(ply) then return end
 			if hook.Call("ActMod_CantSCAct",nil,ply,"StartAct") == true then return end
            if s.GLok == true then A_AM.ActMod:ASa(s) return end
			ply.ActMod_TimMenRe = CurTime() + 0.5
			ply:SetNWString("A_ActMod_cl_actLoop", s.Actoji)
			local cl_s,cl_e,cl_l,cl_y = "0","0","0","0"
			if GetConVarNumber("actmod_cl_sound") == 1 then cl_s = "1" end
			if GetConVarNumber("actmod_cl_effects") == 1 then cl_e = "1" end
			if GetConVarNumber("actmod_cl_loop") == 1 then cl_l = "1" elseif GetConVarNumber("actmod_cl_loop") == 2 then cl_l = "2" end
			if GetConVarNumber("actmod_cl_asyn") == 1 then cl_y = "1" end
			A_AM.ActMod:CStart_cl(s.Actoji,string.format("%s %s %s %s",cl_s,cl_e,cl_l,cl_y))
			sStNewDat(ply, ReString(e.Actoji))
			if GetConVarNumber("actmod_cl_automclose") > 0 then self:Close(nil,vrShow) end
        end
		if not e.Actoji then return end


        local NIcon
        local shv = ReString(e.Actoji)
        local si_Gmod_Taunt = A_AM.ActMod:ATabData(A_AM.ActMod.ActGmod, shv) == true
        local si_AM4_Amod = A_AM.ActMod:ATabData(A_AM.ActMod.AcTAM4, ReString(shv)) == true
        local si_AM4_PUBG = string.StartsWith(shv, "amod_pubg_")
        local si_AM4_Mixamo = string.StartsWith(shv, "amod_mixamo_")
        local si_AM4_MMD = string.StartsWith(shv, "amod_mmd_")
        local si_AM4_Fortnite = string.StartsWith(shv, "amod_fortnite_")
        local s_CTA_Other = string.StartsWith(shv, "amod_cumact_")
		local vt = "amod_cumact_".. shv
        local GTabActO = A_AM.ActMod.GTabActO[shv]
        local GTabActO_CTA = A_AM.ActMod.GTabActO[vt]
        local si_CTA_Other = GTabActO_CTA and GTabActO_CTA["class"]
		local IMeNum = isnumber(si_CTA_Other) and (si_CTA_Other > 40 and si_CTA_Other < 50 and "actmod/imenu/dcomn.png" or si_CTA_Other > 0 and si_CTA_Other < 10 and "actmod/imenu/is_cm.png" or si_CTA_Other > 60 and istable(A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)]) and isstring(A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)].i) and A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)].i ~= "" and A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)].i)
		e.isG = (GTabActO_CTA and isnumber(GTabActO_CTA["NoStop"]) and GTabActO_CTA["NoStop"] == 63) or (GTabActO and isnumber(GTabActO["NoStop"]) and GTabActO["NoStop"] == 63)
		e.IMeNum = IMeNum
		
		e.StZ = 1
		e.Alpa = 0
		e.Alpa2 = 0
		e.AlpOne = false
		e.Alptxt = A_AM.ActMod:ReNameAct(ReString(e.Actoji))
		local anTime,AlpBse,start,nbb,sped = 0,170,0,1,2
		
		e.aFrvl = false
		e.aEdit = false
		e.tt = CurTime() + 0.3
		e.Think = function(s)
			if not ntis and s:IsHovered() then self.Frame.TiHOVR = CurTime() + 0.1 end
			if (s.tt or 0) < CurTime() then
				s.tt = CurTime() + 0.8
				if A_AM.ActMod.Actoji.AETData and A_AM.ActMod:ATabData(A_AM.ActMod.Actoji.AETData, s.Actoji) == true then
					s.aFrvl = true else s.aFrvl = false
				end
				if A_AM.ActMod.Actoji.AETDataEdit and A_AM.ActMod:ATabData(A_AM.ActMod.Actoji.AETDataEdit, s.Actoji) == true then
					s.aEdit = true else s.aEdit = false
				end
				shv = ReString(e.Actoji)
				IsBLocd = A_AM.ActMod:IsDanceBlacklisted(e.Actoji)
				si_Gmod_Taunt = A_AM.ActMod:ATabData(A_AM.ActMod.ActGmod, shv) == true
				si_AM4_Amod = A_AM.ActMod:ATabData(A_AM.ActMod.AcTAM4, ReString(shv)) == true
				si_AM4_PUBG = string.StartsWith(shv, "amod_pubg_")
				si_AM4_Mixamo = string.StartsWith(shv, "amod_mixamo_")
				si_AM4_MMD = string.StartsWith(shv, "amod_mmd_")
				si_AM4_Fortnite = string.StartsWith(shv, "amod_fortnite_")
				s_CTA_Other = string.StartsWith(shv, "amod_cumact_")
				vt = "amod_cumact_".. shv
				GTabActO = A_AM.ActMod.GTabActO[shv]
				GTabActO_CTA = A_AM.ActMod.GTabActO[vt]
				si_CTA_Other = GTabActO_CTA and GTabActO_CTA["class"] or 0
				IMeNum = isnumber(si_CTA_Other) and (si_CTA_Other > 40 and si_CTA_Other < 50 and "actmod/imenu/dcomn.png" or si_CTA_Other > 0 and si_CTA_Other < 10 and "actmod/imenu/is_cm.png" or si_CTA_Other > 60 and istable(A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)]) and isstring(A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)].i) and A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)].i ~= "" and A_AM.ActMod.TDCustom[RoundDT(si_CTA_Other)].i or 0) or 0
				e.IMeNum = IMeNum
				e.isG = (GTabActO_CTA and isnumber(GTabActO_CTA["NoStop"]) and GTabActO_CTA["NoStop"] == 63) or (GTabActO and isnumber(GTabActO["NoStop"]) and GTabActO["NoStop"] == 63)
				if IsBLocd and not e.SCurr then e.SCurr = true e:SetCursor("arrow") elseif not IsBLocd and e.SCurr then e.SCurr = false e:SetCursor("hand") end
				e.txtwa = A_AM.ActMod.aGetTextSize(e.MatE and shv or e.Alptxt,ActMod_a4_SC)
				e.IsBLocd = IsBLocd
			end
			if (s.tti or 0) < CurTime() then
				s.tti = CurTime() + 0.5
				if aN then
					local TActData = A_AM.ActMod:GetEmoIcn( GetSTabEts and GetSTabEts[A_AM.ActMod:ActojTyp(aN)] and GetSTabEts[A_AM.ActMod.aNTyp[aN]] or aN,A_AM.ActMod:ActaLoed(A_AM.ActMod:ActojTyp(aN),A_AM.ActMod.aNTyp[aN]) )
					if TActData and istable(TActData) and TActData[1] and TActData[2] then
						self.table[aN] = TActData[2]
						e.Material = TActData[1]
						e.Actoji = TActData[2]
						e.txtMat = TActData[3]
						if GetConVarNumber("actmod_cl_showsholightic") > 0 then e.WMaterial = A_AM.ActMod:GetWMaterial(e.txtMat, 128, 128) end
					end
					if type(e.Material) ~= "IMaterial" or e.Material:IsError() then e.Material = Material("actmod/imenu/p_none.png","noclamp smooth") e.MatE = true else e.MatE = false end
				end
			end
			
			if not IsValid(e.Cmenu) and not ntis and not LocalPlayer().ActMod_cl_MisDragging and input.IsMouseDown(MOUSE_LEFT) and s.Actoji and not dragState.pendingCrossPage then
				if not s._dragTracking and s:IsHovered() and not dragState.isDragging then
					s._dragTracking = true
					s._dragStartX, s._dragStartY = gui.MousePos()
				end
				if s._dragTracking then
					local mx, my = gui.MousePos()
					local dx = mx - (s._dragStartX or mx)
					local dy = my - (s._dragStartY or my)
					GetSTabEts = nil
					if not dragState.isDragging and (math.abs(dx) > 8 or math.abs(dy) > 8) then
						dragState.isDragging = true
						dragState.sourceButton = s
						dragState.sourceSlot = s.Slot
						dragState.originalPositions = {}
						if istable(self.Frame.TabEmots) then
							for slot, btn in pairs(self.Frame.TabEmots) do
								if IsValid(btn) then
									local bx, by = btn:GetPos()
									dragState.originalPositions[slot] = {x = bx, y = by}
								end
							end
						end
						if IsValid(dragState.ghostPanel) then dragState.ghostPanel:Remove() end
						local ghostSz = BZz * 0.7
						dragState.ghostPanel = vgui.Create("DPanel")
						dragState.ghostPanel:SetSize(ghostSz, ghostSz)
						dragState.ghostPanel:SetDrawOnTop(true)
						dragState.ghostPanel:SetMouseInputEnabled(false)
						local srcMat = s.Material
						dragState.ghostPanel.Paint = function(gp, gw, gh)
							local breath = 1 + 0.08 * math.sin(CurTime() * 4)
							local bw, bh = gw * breath, gh * breath
							local ox, oy = (gw - bw) * 0.5, (gh - bh) * 0.5
							draw.RoundedBox(8, ox, oy, bw, bh, Color(40, 80, 200, 100))
							if srcMat then
								surface.SetDrawColor(255, 255, 255, 200)
								surface.SetMaterial(srcMat)
								surface.DrawTexturedRect(ox + 4, oy + 4, bw - 8, bh - 8)
								surface.SetDrawColor(Color(100*breath,255,255,150+100*math.sin(CurTime() * 4))) surface.DrawOutlinedRect(0, 0, gw, gh, 1)
							end
						end
						surface.PlaySound("actmod/s/ui_tmov_01.mp3")
					end
					if dragState.isDragging and IsValid(dragState.ghostPanel) then
						local ghostSz2 = BZz * 0.7
						dragState.ghostPanel:SetPos(mx - ghostSz2 * 0.5, my - ghostSz2 * 0.5)
						local newHovered = nil
						if istable(self.Frame.TabEmots) then
							for slot, btn in pairs(self.Frame.TabEmots) do
								if IsValid(btn) and slot ~= dragState.sourceSlot and btn.Actoji then
									local origPos = dragState.originalPositions[slot]
									if origPos then
										local parent = btn:GetParent()
										local px, py = parent:LocalToScreen(origPos.x, origPos.y)
										local bw2, bh2 = btn:GetSize()
										if mx >= px and mx <= px + bw2 and my >= py and my <= py + bh2 then
											newHovered = slot
											btn.tsel = CurTime() + 0.1
											break
										end
									end
								end
							end
						end
						dragState.hoveredSlot = newHovered
					end
				end
			else
				if s._dragTracking then
					s._dragTracking = false
					if dragState.isDragging and dragState.sourceSlot == s.Slot then
						if dragState.hoveredSlot then
							local targetBtn = self.Frame.TabEmots[dragState.hoveredSlot]
							if IsValid(targetBtn) then
								local tmpMat = s.Material
								local tmpActoji = s.Actoji
								local tmpAlptxt = s.Alptxt
								local tmptxtwa = s.txtwa
								local tmpMatE = s.MatE
								local tmpisG = s.isG
								local tmpIMeNum = s.IMeNum
								local tmpIsBLocd = s.IsBLocd
								s.Material = targetBtn.Material
								s.Actoji = targetBtn.Actoji
								s.Alptxt = targetBtn.Alptxt
								s.txtwa = targetBtn.txtwa
								s.MatE = targetBtn.MatE
								s.isG = targetBtn.isG
								s.IMeNum = targetBtn.IMeNum
								s.IsBLocd = targetBtn.IsBLocd
								targetBtn.Material = tmpMat
								targetBtn.Actoji = tmpActoji
								targetBtn.Alptxt = tmpAlptxt
								targetBtn.txtwa = tmptxtwa
								targetBtn.MatE = tmpMatE
								targetBtn.isG = tmpisG
								targetBtn.IMeNum = tmpIMeNum
								targetBtn.IsBLocd = tmpIsBLocd
							end
							if istable(self.Frame.TabEmots) then
								for slot, btn in pairs(self.Frame.TabEmots) do
									if IsValid(btn) and dragState.originalPositions[slot] then
										btn:SetPos(dragState.originalPositions[slot].x, dragState.originalPositions[slot].y)
									end
								end
							end
							s:SetAlpha(255)
							dragState.originalPositions = {}
							SwapEmoteSlots(dragState.sourceSlot, dragState.hoveredSlot)
							surface.PlaySound("actmod/s/ui_tmovd_01.mp3")
						else
							s:AlphaTo(255, 0.2)
							surface.PlaySound("actmod/s/ui_umov_01.mp3")
						end
						if IsValid(dragState.ghostPanel) then dragState.ghostPanel:Remove() end
						dragState.isDragging = false
						dragState.hoveredSlot = nil
						dragState.sourceButton = nil
						dragState.sourceSlot = nil
					end
				end
			end
			
			if dragState.isDragging then
				if s.Slot == dragState.sourceSlot then
					s:SetAlpha(0)
				elseif dragState.hoveredSlot == s.Slot and dragState.originalPositions[dragState.sourceSlot] then
					local srcPos = dragState.originalPositions[dragState.sourceSlot]
					local cx, cy = s:GetPos()
					local nx = Lerp(FrameTime() * 12, cx, srcPos.x)
					local ny = Lerp(FrameTime() * 12, cy, srcPos.y)
					if math.abs(nx - srcPos.x) < 2 then nx = srcPos.x end
					if math.abs(ny - srcPos.y) < 2 then ny = srcPos.y end
					s:SetPos(nx, ny)
				elseif dragState.originalPositions[s.Slot] then
					local origPos = dragState.originalPositions[s.Slot]
					local cx, cy = s:GetPos()
					if math.abs(cx - origPos.x) > 0.5 or math.abs(cy - origPos.y) > 0.5 then
						local nx2 = Lerp(FrameTime() * 12, cx, origPos.x)
						local ny2 = Lerp(FrameTime() * 12, cy, origPos.y)
						if math.abs(nx2 - origPos.x) < 2 then nx2 = origPos.x end
						if math.abs(ny2 - origPos.y) < 2 then ny2 = origPos.y end
						s:SetPos(nx2, ny2)
					end
				end
			elseif next(dragState.originalPositions) ~= nil then
				s:SetAlpha(255)
				local origPos = dragState.originalPositions[s.Slot]
				if origPos then
					local cx, cy = s:GetPos()
					local dist = math.sqrt((cx - origPos.x)^2 + (cy - origPos.y)^2)
					local speed = math.max(35, 900 / (dist + 1))
					local nx3 = Lerp(FrameTime() * speed, cx, origPos.x)
					local ny3 = Lerp(FrameTime() * speed, cy, origPos.y)
					s:SetPos(nx3, ny3)
					if dist < 0.7 then
						s:SetPos(origPos.x, origPos.y)
						dragState.originalPositions[s.Slot] = nil
					end
				end
			end
			if dragState.pendingCrossPage then
				if IsValid(dragState.ghostPanel) then
					local mx, my = gui.MousePos()
					local gsz = BZz * 0.7
					dragState.ghostPanel:SetPos(mx - gsz * 0.5, my - gsz * 0.5)
				end
				if not s._crossOrigX then
					s._crossOrigX, s._crossOrigY = s:GetPos()
					local cx = self.Frame:GetWide() * 0.5
					local cy = self.Frame:GetTall() * 0.5
					local dx = s._crossOrigX + BZz * 0.5 - cx
					local dy = s._crossOrigY + BZz * 0.5 - cy
					local dist = math.max(math.sqrt(dx * dx + dy * dy), 1)
					s._sqDirX = dx / dist
					s._sqDirY = dy / dist
				end
				local mx, my = gui.MousePos()
				local parent = s:GetParent()
				local px, py = parent:LocalToScreen(s._crossOrigX, s._crossOrigY)
				local bw, bh = s:GetSize()
				local isOver = mx >= px and mx <= px + bw and my >= py and my <= py + bh and s.Actoji
				local pushDist = BZz * 0.2
				if isOver then
					s.tsel = CurTime() + 0.1
					local cx, cy = s:GetPos()
					s:SetPos(
						Lerp(FrameTime() * 14, cx, s._crossOrigX + s._sqDirX * pushDist),
						Lerp(FrameTime() * 14, cy, s._crossOrigY + s._sqDirY * pushDist)
					)
				else
					local cx, cy = s:GetPos()
					if math.abs(cx - s._crossOrigX) > 0.5 or math.abs(cy - s._crossOrigY) > 0.5 then
						s:SetPos(
							Lerp(FrameTime() * 14, cx, s._crossOrigX),
							Lerp(FrameTime() * 14, cy, s._crossOrigY)
						)
					end
				end
				if not input.IsMouseDown(MOUSE_LEFT) then
					local dmx, dmy = gui.MousePos()
					local tgtSlot = nil
					if istable(self.Frame.TabEmots) then
						for sl, bt in pairs(self.Frame.TabEmots) do
							if IsValid(bt) and bt.Actoji and bt._crossOrigX then
								local par = bt:GetParent()
								local bpx, bpy = par:LocalToScreen(bt._crossOrigX, bt._crossOrigY)
								local bbw, bbh = bt:GetSize()
								if dmx >= bpx and dmx <= bpx + bbw and dmy >= bpy and dmy <= bpy + bbh then
									tgtSlot = sl break
								end
							end
						end
					end
					if tgtSlot then
						local tgtBtn = self.Frame.TabEmots[tgtSlot]
						if IsValid(tgtBtn) then tgtBtn:AlphaTo(0, 0.15) end
						if IsValid(dragState.ghostPanel) and IsValid(tgtBtn) then
							local tx, ty = tgtBtn:LocalToScreen(0, 0)
							local gw, gh = dragState.ghostPanel:GetSize()
							local ghost = dragState.ghostPanel
							ghost:MoveTo(tx, ty, 0.15)
							ghost:SizeTo(gw * 0.6, gh * 0.6, 0.15)
							ghost:AlphaTo(0, 0.15, 0, function() if IsValid(ghost) then ghost:Remove() end end)
							dragState.ghostPanel = nil
						else
							if IsValid(dragState.ghostPanel) then dragState.ghostPanel:Remove() end
						end
						SwapEmoteSlots(dragState.pendingCrossPage.slot, tgtSlot)
						timer.Simple(0.1, function() if IsValid(tgtBtn) then tgtBtn:SetAlpha(0) tgtBtn:AlphaTo(255, 0.4) end end)
						surface.PlaySound("actmod/s/ui_tmovd_01.mp3")
					else
						if IsValid(dragState.ghostPanel) then dragState.ghostPanel:Remove() end
					end
					if istable(self.Frame.TabEmots) then
						for sl, bt in pairs(self.Frame.TabEmots) do
							if IsValid(bt) and bt._crossOrigX then
								bt:SetPos(bt._crossOrigX, bt._crossOrigY)
								bt._crossOrigX = nil
								bt._crossOrigY = nil
							end
						end
					end
					dragState.pendingCrossPage = nil
					dragState.ghostPanel = nil
				end
			end
		end
		
		e.txtwa = A_AM.ActMod.aGetTextSize(e.MatE and shv or e.Alptxt,ActMod_a4_SC)
        e.Paint = function(s, w, h)
            if not s.Material then return end
            if e.MatE then
				local aa = s:IsHovered() and 255 or 100
				surface.SetDrawColor(255, 255, 255, aa)
				surface.SetMaterial(s.Material)
				surface.DrawTexturedRect(3,3,w-6,h-6)
				draw.SimpleText("None", ActMod_a8_SC, w/2, h/2, Color(255, 255, 255, aa), 1, 1)
				if s:IsHovered() then
					local wa = math.min( s.txtwa + 14 ,w)
					draw.RoundedBox(0, w/2-wa/2, h-12,wa,12, Color(0,0,50))
					if s.txtwa > w then
						draw.ScrollingText(shv, ActMod_a4_SC, 0, h-7, Color(255,255,255), 0,1 ,w,s,2,s.Actoji)
					else
						draw.SimpleText(shv, ActMod_a4_SC, w/2, h-7, Color(255,255,255),1,1)
					end
				end
				return
			end
			if dragState.isDragging or (s.tsel or 0) > CurTime() then
				if (s.tsel or 0) > CurTime() then
					surface.SetDrawColor(Color(100+50*math.sin(CurTime()*4),255,255,200+50*math.sin(CurTime() * 4-1))) surface.DrawOutlinedRect(0, 0, w, h, 2)
					surface.SetDrawColor(255, 255, 255, 155+100*math.sin(CurTime()*4+3))
				else
					surface.SetDrawColor(255, 255, 255, 255)
				end
				surface.SetMaterial(s.Material)
				surface.DrawTexturedRect(3,3,w-6,w-6)
				return
			end
            if s:IsHovered() and GetReadyFUse(ply) == true then
				if s.AlpOne == false then s.AlpOne = true end
				if nbb == 1 then start = SysTime() + anTime nbb = 2 end
				if math.Round(AlpBse,5) < 255 then
					AlpBse = Lerp( (SysTime() - start )/sped, AlpBse, 255)
				end
			else
				if s.AlpOne == true then
					if nbb == 2 then start = SysTime() + anTime nbb = 1 end
					if math.Round(AlpBse,5) > 140 then
						AlpBse = Lerp( (SysTime() - start )/sped, AlpBse, 140)
					end
				end
            end
			local hwa = math.max(math.min(math.Remap(AlpBse,180,240,0,255),255),0)
			surface.SetDrawColor( A_AM.ActMod:aIsRdy(ply) and Color(255, 255, 255, hwa) or Color(255, 100, 100, hwa) )
			if GetConVarNumber("actmod_cl_stibox") > 1 then
				surface.SetMaterial(Material("materials/actmod/sm_hover" .. tostring(GetConVarNumber("actmod_cl_stibox")) .. ".png", "noclamp smooth"))
			else
				surface.SetMaterial(Material("materials/actmod/sm_hover.png", "noclamp smooth"))
			end
			surface.DrawTexturedRect(0, 0, w, h-10)
			
			local hw = BZz*0.6
			local lw,lh,ca = math.min(hw+AlpBse*0.3,w),math.min(hw+AlpBse*0.3,h-10),math.max(math.min((AlpBse*2-300)*1.25,255),0)
			local cw,ch,zw,zh = w/2-lw/2,h/2-5-lw/2, lw,lh
            if s:IsHovered() then
				if GetConVarNumber("actmod_cl_showsholightic") > 0 and s.WMaterial then
					local Aclor = math.Clamp( 255*math.sin(CurTime()*4) ,0,255 )
					local azs_w,azs_h = 6+2*math.sin(CurTime()*6),6+2*math.sin(CurTime()*6)
					surface.SetDrawColor(Aclor, Aclor, 255, math.Clamp( AlpBse*2*math.max(math.sin(CurTime()*4),0)+50 ,0,255 ))
					surface.SetMaterial(s.WMaterial)
					surface.DrawTexturedRect(cw-azs_w/2,ch-azs_h/2,zw+azs_w,zh+azs_h)
				end
				if s.isG then
					local Aclor = math.Clamp( 1+1.2*math.sin(CurTime()*4) ,0.4,1 )
					if GetConVarNumber("actmod_cl_showsholightic") > 0 and s.WMaterial then
						local azs_w,azs_h = 2,2
						surface.SetDrawColor(0, 40, 140, 255*Aclor)
						surface.SetMaterial(s.WMaterial)
						surface.DrawTexturedRect(cw-azs_w/2,ch-azs_h/2,zw+azs_w,zh+azs_h)
					end
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetMaterial(s.Material)
					surface.DrawTexturedRect(cw+3,ch+3,zw-6,zh-6)
					surface.SetDrawColor(255, 255, 255, AlpBse*Aclor)
					surface.SetMaterial(Material("actmod/imenu/ic_g.png", "noclamp smooth"))
					surface.DrawTexturedRect(cw+3,zh/2,zw-6,zh/2-2)
				else
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetMaterial(s.Material)
					surface.DrawTexturedRect(cw+3,ch+3,zw-6,zh-6)
				end
			else
				if s.isG then
					local Aclor = math.Clamp( 1+1.2*math.sin(CurTime()*4) ,0.2,0.7 )
					surface.SetDrawColor(255, 255, 255, AlpBse)
					surface.SetMaterial(s.Material)
					surface.DrawTexturedRect(cw+3,ch+3,zw-6,zh-6)
					surface.SetDrawColor(255, 255, 255, AlpBse*Aclor)
					surface.SetMaterial(Material("actmod/imenu/ic_g.png", "noclamp smooth"))
					surface.DrawTexturedRect(cw+3,zh/2,zw-6,zh/2-2)
				else
					surface.SetDrawColor(255, 255, 255, AlpBse)
					surface.SetMaterial(s.Material)
					surface.DrawTexturedRect(cw+3,ch+3,zw-6,zh-6)
				end
			end
			if s.IsBLocd then
				local aw = h*0.6
				local Aclor = math.Clamp( 1+1.2*math.sin(CurTime()*4) ,0.2,0.7 )
				surface.SetDrawColor(255, 255, 255, AlpBse*Aclor)
				surface.SetMaterial(matbckd)
				surface.DrawTexturedRect(w/2-aw/2,h/2-aw/2,aw,aw)
			end
			local alpb = math.max(math.min((ca*1.5)-80,255),0)
			if alpb > 0 then
				local wa = math.min( s.txtwa + 14 ,w)
				draw.RoundedBox(0, w/2-wa/2, h-12,wa,12, Color(0,0,50,alpb))
				if s.txtwa > w then
					draw.ScrollingText(s.Alptxt, ActMod_a4_SC, 0, h-7, Color(255,255,255,alpb), 0,1 ,w,s,2,s.Actoji)
				else
					draw.SimpleText(s.Alptxt, ActMod_a4_SC, w/2, h-7, Color(255,255,255,alpb),1,1)
				end
			end

			if GetConVarNumber("actmod_cl_showiconsml") ~= 0 then
				if e.aFrvl then
					surface.SetDrawColor(0, 0, 0, AlpBse)
					surface.SetMaterial(Material("actmod/imenu/is_featured.png", "noclamp smooth"))
					surface.DrawTexturedRect(w-24, 0, 24, 24)
					surface.SetDrawColor(255, 255, 255, math.Clamp((AlpBse* math.sin(CurTime() * 5))*2+AlpBse*2,0,255))
					surface.DrawTexturedRect(w-22, 2, 20, 20)
				end
				if e.aEdit then
					surface.SetDrawColor(0, 0, 0, AlpBse)
					surface.SetMaterial(Material("icon16/bullet_wrench.png", "noclamp smooth"))
					surface.DrawTexturedRect(w-24, 25, 24, 24)
					surface.SetDrawColor(255, 255, 255, math.Clamp((AlpBse* math.sin(CurTime() * 5))*2+AlpBse*2,0,255))
					surface.DrawTexturedRect(w-22, 27, 20, 20)
				end
            end
            if s:IsHovered() then
				if s.StZ == 1 or s.StZ == 2 then
					if s.StZ == 1 then
						s.Alpa2 = math.min(s.Alpa2 + 580*FrameTime(),600)
						if s.Alpa2 >= 500 then s.Alpa = math.min(s.Alpa2-500,255) end
						if s.Alpa2 >= 600 then s.StZ = 2 end
					else
						e.Alpa2 = math.max(e.Alpa2 - 200*FrameTime(),0)
						s.Alpa = math.max(s.Alpa2,0)
						if s.StZ == 2 and s.Alpa2 <= 0 then s.StZ = 0 end
					end
					surface.SetDrawColor(255, 255, 255, s.Alpa)

					if si_AM4_Amod then
						surface.SetMaterial(Material("actmod/imenu/is_am4.png", "noclamp smooth"))
						NIcon = "AM4"
					elseif si_AM4_Fortnite then
						surface.SetMaterial(Material("actmod/imenu/Is_fortnite.png", "noclamp smooth"))
						NIcon = "AM4"
					elseif si_AM4_MMD then
						surface.SetMaterial(Material("actmod/imenu/is_mmd2.png", "noclamp smooth"))
						NIcon = "AM4"
					elseif si_AM4_PUBG then
						surface.SetMaterial(Material("actmod/imenu/is_pubg.png", "noclamp smooth"))
						NIcon = "AM4"
					elseif si_AM4_Mixamo then
						surface.SetMaterial(Material("actmod/imenu/is_mixamo.png", "noclamp smooth"))
						NIcon = "AM4"
					elseif si_Gmod_Taunt then
						surface.SetMaterial(Material("actmod/imenu/is_gmod.png", "noclamp smooth"))
						NIcon = "( G )"
					elseif si_CTA_Other or s_CTA_Other then
						surface.SetMaterial(Material(isstring(IMeNum) and IMeNum or "actmod/imenu/i_cusr.png", "noclamp smooth"))
						NIcon = "CTM"
					else
						surface.SetMaterial(Material("icon64/tool.png", "noclamp smooth"))
						NIcon = "None"
					end
					local a0 = math.min(h*0.06,80)
					local a1,a2,b1,b2 = a0,a0,a0*2,a0*2
					local amov = a0 + (4 * math.sin(CurTime() * 3))
					surface.DrawTexturedRect(a1 - amov / 2, a2 - amov / 2, b1 + amov, b2 + amov)
				end
            else
				s.StZ = 1
				s.Alpa = 0
				s.Alpa2 = 0
            end
        end

		if not self.Frame.TabEmots then self.Frame.TabEmots = {} end
		self.Frame.TabEmots[aN] = e
		
        return e
    end
	self.MakeButton = MakeButton

	local function spwnemotes(GSN)
		local At = {
			[1] = { [1] = 1 ,[2] = 2 ,[3] = 3 ,[4] = 4 ,[5] = 5 ,[6] = 6 ,[7] = 7 ,[8] = 8 }
			,[2] = { [1] = 9 ,[2] = 10 ,[3] = 11 ,[4] = 12 ,[5] = 13 ,[6] = 14 ,[7] = 15 ,[8] = 16 }
			,[3] = { [1] = 22 ,[2] = 23 ,[3] = 24 ,[4] = 25 ,[5] = 26 ,[6] = 27 ,[7] = 28 ,[8] = 29 }
			,[4] = { [1] = 30 ,[2] = 31 ,[3] = 32 ,[4] = 33 ,[5] = 34 ,[6] = 35 ,[7] = 36 ,[8] = 37 }
			,[5] = { [1] = 38 ,[2] = 39 ,[3] = 40 ,[4] = 41 ,[5] = 42 ,[6] = 43 ,[7] = 44 ,[8] = 45 }
			,[6] = { [1] = 46 ,[2] = 47 ,[3] = 48 ,[4] = 49 ,[5] = 50 ,[6] = 51 ,[7] = 52 ,[8] = 53 }
			,[7] = { [1] = 54 ,[2] = 55 ,[3] = 56 ,[4] = 57 ,[5] = 58 ,[6] = 59 ,[7] = 60 ,[8] = 61 }
			,[8] = { [1] = 62 ,[2] = 63 ,[3] = 64 ,[4] = 65 ,[5] = 66 ,[6] = 67 ,[7] = 68 ,[8] = 69 }
		}
		local An = 1
		if GSN then
			An = GSN
		else
			if GetConVarNumber("actmod_cl_pageslot") > 7 then
				An = 8
			elseif GetConVarNumber("actmod_cl_pageslot") > 6 then
				An = 7
			elseif GetConVarNumber("actmod_cl_pageslot") > 5 then
				An = 6
			elseif GetConVarNumber("actmod_cl_pageslot") > 4 then
				An = 5
			elseif GetConVarNumber("actmod_cl_pageslot") > 3 then
				An = 4
			elseif GetConVarNumber("actmod_cl_pageslot") > 2 then
				An = 3
			elseif GetConVarNumber("actmod_cl_pageslot") > 1 then
				An = 2
			end
		end
		if GetConVarNumber("actmod_cl_sortemote") > 2 then
			local Maa = 50
			local GTup = self.Frame:GetWide()-Maa
			local msaf = self.Frame:GetTall()*0.75/6
			local MRe = GTup/8.875
			local MRe2 = MRe
			MakeButton(Maa/2, msaf, nil, nil, At[An][1])
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][2]) MRe = MRe+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][3]) MRe = MRe+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][4]) MRe = MRe+MRe2+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][5]) MRe = MRe+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][6]) MRe = MRe+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][7]) MRe = MRe+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][8])
			GTup = nil msaf = nil MRe = nil MRe2 = nil Maa = nil
		elseif GetConVarNumber("actmod_cl_sortemote") == 2 then
			local Maa = self.Frame:GetTall()*0.15
			local GTup = self.Frame:GetWide()-Maa
			local msaf = self.Frame:GetTall()*0.075
			local MRe = GTup/3.8
			local MRe2 = MRe
			MakeButton(Maa/2, msaf, nil, nil, At[An][1])
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][2]) MRe = MRe+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][3]) MRe = MRe+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][4]) MRe = MRe+MRe2
			msaf = self.Frame:GetTall()*0.5   MRe = GTup/3.8   MRe2 = MRe
			MakeButton(Maa/2 , msaf, nil, nil, At[An][5])
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][6]) MRe = MRe+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][7]) MRe = MRe+MRe2
			MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][8])
			GTup = nil msaf = nil MRe = nil MRe2 = nil Maa = nil
		else
			MakeButton(0, nil, nil, nil, At[An][1])
			MakeButton(pi / 4, nil, nil, nil, At[An][2])
			MakeButton(pi / 2, nil, nil, nil, At[An][3])
			MakeButton(pi - pi / 4, nil, nil, nil, At[An][4])
			MakeButton(pi, nil, nil, nil, At[An][5])
			MakeButton(pi + pi / 4, nil, nil, nil, At[An][6])
			MakeButton(pi * 1.5, nil, nil, nil, At[An][7])
			MakeButton(pi * 1.5 + pi / 4, nil, nil, nil, At[An][8])
		end
    end
	if istable(self.Frame.TabEmots) then
		for k,tm in pairs( self.Frame.TabEmots ) do
			if IsValid(tm) then tm:Remove() end
		end
		self.Frame.TabEmots = {}
	end
	spwnemotes()

    local ess = vgui.Create("DPanel", self.Frame)
    ess.zt = self.Frame:GetTall()*0.565

    if GetConVarNumber("actmod_cl_sortemote") > 2 then
		ess:SetSize(self.Frame:GetTall()*0.8, self.Frame:GetTall()*0.565) ess:SetPos(self.Frame:GetWide() / 2 - ess:GetWide() / 2, self.Frame:GetTall() / 2 - ess:GetTall() / 2)
    elseif GetConVarNumber("actmod_cl_sortemote") == 2 then
        ess:SetSize(self.Frame:GetTall()*0.6, self.Frame:GetTall()*0.1) ess:SetPos(self.Frame:GetWide() / 2 - ess:GetWide() / 2, self.Frame:GetTall() - 50.5)
		ess.zt = self.Frame:GetTall()*0.2
    else
		ess:SetSize(self.Frame:GetTall()*0.21, self.Frame:GetTall()*0.1425) ess:SetPos(self.Frame:GetWide() / 2 - ess:GetWide() / 2, self.Frame:GetTall() / 2 - ess:GetTall() / 2)
		ess.zt = self.Frame:GetTall()*0.1425
    end

    ess:SetText("")
    ess.Paint = function(ste, w, h)
		if ste:IsHovered() then self.Frame.TiHOVR = CurTime() + 0.1 end
        draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 120, 100))
    end
    ess.OnRemove = function(ste, w, h) if IsValid(self.ess2) then self.ess2:Remove() end end

	local ess2
    if GetConVarNumber("actmod_cl_showslotss") ~= 0 and (A_AM.ActMod.A_ActMod_RedyUse and GetConVarNumber("actmod_cl_eloading") ~= 0 or GetConVarNumber("actmod_cl_eloading") == 0) then
		self.ess2 = vgui.Create("DFrame")
		ess2 = self.ess2
		ess2.zt = h*0.1
		ess2:SetDraggable(false) ess2:ShowCloseButton(false) ess2:MakePopup()
		ess2:SetSize(ess2.zt*4.025, ess2.zt/2) ess2:SetTitle("")
		if GetConVarNumber("actmod_cl_sortemote") > 2 then
			ess2:SetPos(20, ScrH() - self.Frame:GetTall()*1.3)
		elseif GetConVarNumber("actmod_cl_sortemote") == 2 then
			ess2:SetPos(ScrW() / 2 - ess2:GetWide() / 2, ScrH()/2 - self.Frame:GetTall()/1.65)
		else
			ess2:SetPos(ScrW() / 2 + 80, 5)
		end
		ess2.Paint = function(ste, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 120, 140))
		end
    end

    local function DBtt(ess, Gw, Gh, GCN, GSN)
        local DBu = vgui.Create("DButton", ess)
        DBu:SetPos(Gw, Gh)
        DBu:SetSize(ess.zt*0.38, ess.zt*0.38)
        DBu:SetText("")
        DBu.Cmo = GCN

        DBu.Paint = function(ste, w, h)
            if GSN == "actmod_sv_enabled_addso" or GSN == "actmod_sv_enabled_addef" then
                if ste:IsHovered() then
                    surface.SetDrawColor(Color(80, 255, 255, 255))
                    surface.DrawOutlinedRect(0, 0, w, h, 2)
                end
            elseif GCN == "A_BETT_2" then
				if A_AM.ActMod.ActGrpP then
					if ste:IsHovered() then
						surface.SetDrawColor(Color(80, 255, 255, 255))
						surface.DrawOutlinedRect(0, 0, w, h, 2)
					end
				elseif A_AM.ActMod.autDon and A_AM.ActMod.autDon == 1 then
					if ste:IsHovered() then
						surface.SetDrawColor(Color(200,220,200,255))
						surface.DrawOutlinedRect(0, 0, w, h, 2)
					else
						surface.SetDrawColor(Color(math.max(200 + (255 * math.sin(CurTime() * 6)) * 1.5, 100), math.max(210 + (255 * math.sin(CurTime() * 6)) * 1.5, 110), 200, 255))
						surface.DrawOutlinedRect(0, 0, w, h, 2)
					end
				elseif not A_AM.ActMod.ActGrpP then
					if ste:IsHovered() then
						surface.SetDrawColor(Color(180, 170, 150, 255))
						surface.DrawOutlinedRect(0, 0, w, h, 2)
					end
				end
            else
                if ste:IsHovered() then
                    surface.SetDrawColor(Color(80, 255, 255, 255))
                    surface.DrawOutlinedRect(0, 0, w, h, 2)
                end
            end

            surface.SetDrawColor(color_white)

            if GSN == "actmod_sv_enabled_addso" then
                if GetConVarNumber(GSN) == 1 then
                    if GetConVarNumber(GCN) == 1 then
                        surface.SetMaterial(Material("icon16/sound.png", "noclamp smooth"))
                    else
                        surface.SetMaterial(Material("icon16/sound_mute.png", "noclamp smooth"))
                    end
                else
                    surface.SetMaterial(Material("icon32/muted.png", "noclamp smooth"))
                end
                CTxtMos(ste, nil, {100, 100, 100, 130}, aR:T("LReplace_txt_Sound"), "CreditsText")
            elseif GSN == "actmod_sv_enabled_addef" then
                if GetConVarNumber(GSN) == 1 then
                    if GetConVarNumber(GCN) == 1 then
                        surface.SetMaterial(Material("actmod/imenu/ic_star_01.png", "noclamp smooth"))
                    else
                        surface.SetMaterial(Material("actmod/imenu/ic_star_02.png", "noclamp smooth"))
                    end
                else
                    surface.SetMaterial(Material("icon16/delete.png", "noclamp smooth"))
                end
                CTxtMos(ste, nil, {100, 100, 100, 130}, aR:T("LReplace_txt_EffModl"), "CreditsText")
            elseif GCN == "A_BETT_1" then
                surface.SetMaterial(Material("icon16/keyboard_add.png", "noclamp smooth"))

                CTxtMos(ste, nil, {100, 150, 200, 130}, aR:T("LButt_LB_txt0"), "CreditsText")
            elseif GCN == "A_BETT_2" then
                surface.SetMaterial(Material("icon16/group_link.png", "noclamp smooth"))

				if A_AM.ActMod.ActGrpP then
                    CTxtMos(ste, nil, {100, 150, 200, 130}, aR:T("LButt_LC_txt1"), "CreditsText")
				elseif A_AM.ActMod.autDon and A_AM.ActMod.autDon == 1 then
                    CTxtMos(ste, nil, {110, 150, 100, 110}, string.format(aR:T("LButt_LC_txt0t"), "90,000"), "CreditsText")
                elseif not A_AM.ActMod.ActGrpP then
                    CTxtMos(ste, nil, {200, 150, 100, 110}, aR:T("LButt_LC_txt0"), "CreditsText")
                end
				
            elseif GCN == "A_BETT_3" then
				CTxtMos(ste, nil, {100, 100, 100, 150}, "Stop Emote/Dance", "CreditsText")
				surface.SetMaterial(Material("icon16/stop.png", "noclamp smooth"))
            elseif GCN == "A_BETT_4" then
				CTxtMos(ste, nil, {100, 100, 100, 150}, "Stop Gesture", "CreditsText")
				surface.SetMaterial(Material("icon16/delete.png", "noclamp smooth"))
				
            elseif GCN == "actmod_cl_pageslot" then
				CTxtMos(ste, nil, {100, 100, 100, 150}, GSN, "CreditsText")
				if GetConVarNumber(GCN) == GSN then
					surface.SetMaterial(Material("vgui/spawnmenu/hover", "noclamp smooth"))
					surface.DrawTexturedRect(1, 1, w - 2, h - 2)
					surface.SetMaterial(Material("icon16/folder_go.png", "noclamp smooth"))
				else
                    surface.SetDrawColor(Color(150, 150, 170, 255))
					surface.SetMaterial(Material("icon16/folder.png", "noclamp smooth"))
				end
            end

            surface.DrawTexturedRect(3, 3, w - 6, h - 6)
        end

        DBu.DoRightClick = function(e)
            if GCN == "A_BETT_2" and A_AM.ActMod.ActGrpP then
				local TTab = table.Copy(LocalPlayer().ActMod_TC_TblPly)
				if istable(TTab) and not table.IsEmpty(TTab) and table.Count(TTab) > 2 and TTab["GetTabPlayers"] and TTab["GetTabPlayers"]["GetPlayers"] then
					e.Cmenu = DermaMenu()
					e.Cmenu:AddOption( "Start", function()
						if istable(TTab) and not table.IsEmpty(TTab) then
							surface.PlaySound("actmod/i_menu/menu_buttons_02.mp3")
							net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"LTD.ClToSv","StratAct",TTab} ) net.SendToServer()
						end
					end ):SetIcon( "icon16/transmit_blue.png" )
					e.Cmenu:AddSpacer()
					e.Cmenu:AddOption( "Stop", function()
						if istable(TTab) and not table.IsEmpty(TTab) then
							surface.PlaySound("actmod/i_menu/menu_othr_01.mp3")
							net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"LTD.ClToSv","StopAct",TTab} ) net.SendToServer()
						end
					end ):SetIcon( "icon16/control_stop_blue.png" )
					e.Cmenu:Open()
				end
			end
		end
		DBu.OnRemove = function() if IsValid(DBu.Cmenu) then DBu.Cmenu:Remove() end end
        DBu.DoClick = function(s)
            if GCN == "A_BETT_1" then
                surface.PlaySound("garrysmod/ui_click.wav")
				A_AM.ActMod:LShowSOpKes(self,DBu)
            elseif GCN == "A_BETT_2" then
                if A_AM.ActMod.ActGrpP then
                    surface.PlaySound("garrysmod/ui_click.wav")
                    A_AM.ActMod.ActGrpP:OMenu(LocalPlayer())
                elseif A_AM.ActMod.autDon and A_AM.ActMod.autDon == 1 and A_AM.ActMod.autDon_URL and A_AM.ActMod.autDon_URL != "" then
					gui.OpenURL(A_AM.ActMod.autDon_URL)
                else
                    surface.PlaySound("garrysmod/ui_return.wav")
                end
            elseif GCN == "A_BETT_3" then
				surface.PlaySound("garrysmod/ui_return.wav")
				RunConsoleCommand("actmod_wts","wts_End")
            elseif GCN == "A_BETT_4" then
				surface.PlaySound("garrysmod/ui_return.wav")
				RunConsoleCommand("actmod_wts","stpg")
            elseif GCN == "actmod_cl_pageslot" then
				surface.PlaySound("garrysmod/ui_click.wav")
				if GetConVarNumber(GCN) ~= GSN then
					LocalPlayer():ConCommand("actmod_cl_pageslot ".. math.Clamp(tonumber(GSN),1,8) .."\n")
					if istable(self.Frame.TabEmots) then for k,tm in pairs( self.Frame.TabEmots ) do if IsValid(tm) then tm:Remove() end end self.Frame.TabEmots = {} end
					spwnemotes(GSN)
				end
            else
                if GetConVarNumber(s.Cmo) == 1 then RunConsoleCommand(s.Cmo, "0") else RunConsoleCommand(s.Cmo, "1") end
                surface.PlaySound("garrysmod/ui_click.wav")
            end
        end
    end
	
	if IsValid(self.Frame) then
		function self.Frame:OnMouseWheeled(wheelDelta)
			if (self:IsHovered() or (self.TiHOVR or 0) > CurTime()) and (ply.ActMod_AddTcic or 0) < CurTime() then
				local Tgnum = GetConVarNumber("actmod_cl_pageslot")
				local gnum = Tgnum
				gnum = gnum + math.Clamp(-wheelDelta,-1,1)
				gnum = math.Clamp(gnum,1,8)
				if gnum ~= Tgnum then
					ply.ActMod_AddTcic = CurTime() + 0.05
					surface.PlaySound("actmod/i_menu/menu_othr_02.mp3")
					LocalPlayer():ConCommand("actmod_cl_pageslot ".. math.Clamp(tonumber(gnum),1,8) .."\n")
					if dragState.isDragging and dragState.sourceSlot then
						local srcSlot = dragState.sourceSlot
						local srcMat = IsValid(dragState.sourceButton) and dragState.sourceButton.Material or nil
						dragState.pendingCrossPage = {slot = srcSlot, mat = srcMat, srcPage = Tgnum}
						dragState.isDragging = false
						dragState.sourceButton = nil
						dragState.sourceSlot = nil
						dragState.hoveredSlot = nil
						dragState.originalPositions = {}
					end
					local backToSrc = false
					if dragState.pendingCrossPage and dragState.pendingCrossPage.srcPage == gnum then
						backToSrc = true
					end
					if istable(self.TabEmots) then
						for k,tm in pairs( self.TabEmots ) do
							if IsValid(tm) and not (k > 16 and k < 22) then tm:Remove() end
						end
						self.TabEmots = {}
					end
					spwnemotes(gnum)
					if backToSrc and dragState.pendingCrossPage then
						local srcSlot = dragState.pendingCrossPage.slot
						dragState.isDragging = true
						dragState.sourceSlot = srcSlot
						dragState.hoveredSlot = nil
						dragState.originalPositions = {}
						if istable(self.TabEmots) then
							for slot, btn in pairs(self.TabEmots) do
								if IsValid(btn) then
									local bx, by = btn:GetPos()
									dragState.originalPositions[slot] = {x = bx, y = by}
									if slot == srcSlot then
										dragState.sourceButton = btn
										btn:SetAlpha(0)
										btn._dragTracking = true
										btn._dragStartX, btn._dragStartY = gui.MousePos()
									end
								end
							end
						end
						dragState.pendingCrossPage = nil
					end
				end
			end
		end
	end

	local eGW,eGT = ess:GetWide(),ess:GetTall()
    if GetConVarNumber("actmod_cl_sortemote") > 2 then
        DBtt(ess, eGW*0.05, eGT*0.05, "actmod_cl_sound", "actmod_sv_enabled_addso")
        DBtt(ess, eGW*0.70, eGT*0.05, "actmod_cl_effects", "actmod_sv_enabled_addef")
        DBtt(ess, eGW*0.05, eGT*0.575, "A_BETT_1")
        DBtt(ess, eGW*0.70, eGT*0.575, "A_BETT_2")
        DBtt(ess, eGW*0.5-ess.zt*0.36/2, eGT*0.05, "A_BETT_4")
        DBtt(ess, eGW*0.5-ess.zt*0.36/2, eGT*0.575, "A_BETT_3")
    elseif GetConVarNumber("actmod_cl_sortemote") == 2 then
        DBtt(ess, eGT*0.09, eGT*0.125, "actmod_cl_sound", "actmod_sv_enabled_addso")
        DBtt(ess, eGW*0.17, eGT*0.125, "actmod_cl_effects", "actmod_sv_enabled_addef")
        DBtt(ess, eGW*0.35, eGT*0.125, "A_BETT_4")
        DBtt(ess, eGW*0.51, eGT*0.125, "A_BETT_3")
        DBtt(ess, eGW*0.70, eGT*0.125, "A_BETT_1")
        DBtt(ess, eGW*0.86, eGT*0.125, "A_BETT_2")
    else
        DBtt(ess, eGW*0.05, eGT*0.05, "actmod_cl_sound", "actmod_sv_enabled_addso")
        DBtt(ess, eGW*0.70, eGT*0.05, "actmod_cl_effects", "actmod_sv_enabled_addef")
        DBtt(ess, eGW*0.05, eGT*0.575, "A_BETT_1")
        DBtt(ess, eGW*0.70, eGT*0.575, "A_BETT_2")
        DBtt(ess, eGW*0.5-ess.zt*0.36/2, eGT*0.05, "A_BETT_4")
        DBtt(ess, eGW*0.5-ess.zt*0.36/2, eGT*0.575, "A_BETT_3")
    end
    if ess2 and IsValid(ess2) and GetConVarNumber("actmod_cl_showslotss") ~= 0 and (A_AM.ActMod.A_ActMod_RedyUse and GetConVarNumber("actmod_cl_eloading") ~= 0 or GetConVarNumber("actmod_cl_eloading") == 0) then
		local gl = ess2.zt/2
		DBtt(ess2, 5, 5, "actmod_cl_pageslot", 1)
		DBtt(ess2, 5+gl, 5, "actmod_cl_pageslot", 2)
		DBtt(ess2, 5+gl*2, 5, "actmod_cl_pageslot", 3)
		DBtt(ess2, 5+gl*3, 5, "actmod_cl_pageslot", 4)
		DBtt(ess2, 5+gl*4, 5, "actmod_cl_pageslot", 5)
		DBtt(ess2, 5+gl*5, 5, "actmod_cl_pageslot", 6)
		DBtt(ess2, 5+gl*6, 5, "actmod_cl_pageslot", 7)
		DBtt(ess2, 5+gl*7, 5, "actmod_cl_pageslot", 8)
	end

	Actoji:OpenListErr()
end

A_AM.ActMod.LuaVgi_MEmote_Done = true
