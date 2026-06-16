--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

// Copyright © 2012-2018 VCMod (freemmaann). All Rights Reserved. if you have any complaints or ideas contact me: steam - steamcommunity.com/id/freemmaann/ or email - freemmaann@gmail.com.

if !VC.Material then VC.Material = {} end
if !VC.Image then VC.Image = {} end

// Load all VCMod icons icons
local ID = "hue_ring" VC.Image[ID] = "materials/vcmod/gui/hue_ring.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_add" VC.Image[ID] = "materials/vcmod/gui/icons/add.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_brakepads" VC.Image[ID] = "materials/vcmod/gui/icons/brakepads.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_car" VC.Image[ID] = "materials/vcmod/gui/icons/car.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_check" VC.Image[ID] = "materials/vcmod/gui/icons/check.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_climate" VC.Image[ID] = "materials/vcmod/gui/icons/climate.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_copy" VC.Image[ID] = "materials/vcmod/gui/icons/copy.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_cross" VC.Image[ID] = "materials/vcmod/gui/icons/cross.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_download" VC.Image[ID] = "materials/vcmod/gui/icons/download.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_drop" VC.Image[ID] = "materials/vcmod/gui/icons/drop.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_edit" VC.Image[ID] = "materials/vcmod/gui/icons/edit.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_electricity" VC.Image[ID] = "materials/vcmod/gui/icons/electricity.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_els" VC.Image[ID] = "materials/vcmod/gui/icons/els.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_esp" VC.Image[ID] = "materials/vcmod/gui/icons/esp.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_exhaust" VC.Image[ID] = "materials/vcmod/gui/icons/exhaust.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_fuel" VC.Image[ID] = "materials/vcmod/gui/icons/fuel.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_home" VC.Image[ID] = "materials/vcmod/gui/icons/home.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_info" VC.Image[ID] = "materials/vcmod/gui/icons/info.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_left" VC.Image[ID] = "materials/vcmod/gui/icons/left.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_paste" VC.Image[ID] = "materials/vcmod/gui/icons/paste.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_remove" VC.Image[ID] = "materials/vcmod/gui/icons/remove.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_repair" VC.Image[ID] = "materials/vcmod/gui/icons/repair.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_right" VC.Image[ID] = "materials/vcmod/gui/icons/right.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_save" VC.Image[ID] = "materials/vcmod/gui/icons/save.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_search" VC.Image[ID] = "materials/vcmod/gui/icons/search.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_seat" VC.Image[ID] = "materials/vcmod/gui/icons/seat.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_settings" VC.Image[ID] = "materials/vcmod/gui/icons/settings.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_spikestrips" VC.Image[ID] = "materials/vcmod/gui/icons/spikestrips.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_trailer" VC.Image[ID] = "materials/vcmod/gui/icons/trailer.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_upload" VC.Image[ID] = "materials/vcmod/gui/icons/upload.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_wheel" VC.Image[ID] = "materials/vcmod/gui/icons/wheel.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_abs" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/abs.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_airbag" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/airbag.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_battery" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/battery.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_blinker_left" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/blinker_left.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_blinker_right" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/blinker_right.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_brakes" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/brakes.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_coolant" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/coolant.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_cruise" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/cruise.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_engine" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/engine.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_fog" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/fog.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_hazards" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/hazards.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_heater" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/heater.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_highbeams" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/highbeams.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_lowbeams" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/lowbeams.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_oil" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/oil.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_running" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/running.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_seatbelt" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/seatbelt.png" VC.Material[ID] = Material(VC.Image[ID])
local ID = "icon_tire_pressure" VC.Image[ID] = "materials/vcmod/gui/icons/dashboard/tire_pressure.png" VC.Material[ID] = Material(VC.Image[ID])



function VC.UI_AnimatePanel_Start(self, time, delay)
	self:AlphaTo(0, 0, 0)
	self:AlphaTo(255, time or 1, delay or 0.5)
end




-- if !VC.Material then VC.Material = {} end
VC.Material.Fade = Material("VCMod/fade")
VC.Material.Circle_32 = Material("vcmod/circle_32")
VC.Material.Circle = Material("vcmod/circle")
VC.Material.Check = Material("vcmod/check.png")
VC.Material.Cross = Material("vcmod/cross.png")
VC.Material.Info = Material("vcmod/info.png")
VC.Material.Button = Material("vcmod/button.png")

-- VC.Material.dash_fuel = Material("vcmod/icon_fuel.png")
-- VC.Material.dash_light = Material("vcmod/dashboard/running_light.png")
-- VC.Material.dash_els = Material("vcmod/icon_els.png")
-- VC.Material.dash_exhaust = Material("vcmod/icon_exhaust.png")
-- VC.Material.dash_wheel = Material("vcmod/icon_tire.png")
-- VC.Material.dash_engine  = Material("vcmod/icon_engine.png")
-- VC.Material.Icon_Repair  = Material("vcmod/icon_repair.png")

function VC.UI_PaintOver(obj, Sx, Sy)
	local pnl = obj.VC_Panel
	if obj:IsHovered() or pnl and pnl:IsHovered() then
		local tclr = VC.ColorCopyAlpha(VC.Color.Accent, (obj.IsDown and obj:IsDown() or pnl and pnl.IsDown and pnl:IsDown()) and 55 or 25)
		surface.SetDrawColor(tclr) surface.DrawRect(0, 0, Sx, Sy)
	end
end

local function applyMenu(self)
	self.AddSpacer = function() local dpnl = vgui.Create("DPanel") dpnl:SetTall(6) dpnl.Paint = function(obj, Sx, Sy) surface.SetDrawColor(VC.Color.Accent) surface.DrawLine(5, 3, Sx-5, 3) end self:AddPanel(dpnl) end

	self.AddSlider = function(obj, text, min, max, dec, def, cw, ch)
		local el = vgui.Create("DNumSlider", self) el.Label:SetTextColor(Color(0,0,0,255)) el:SetText(text or "") el:SetMin(mir or 0) el:SetMax(max or 1) el:SetDecimals(dec or 2) el:SetValue(def or 0) self:AddCustom(el, cw or 250, ch or 30)

		el.TextArea:SetEditable(true)
		el.TextArea:SetEnabled(true)
		return el
	end

	self.AddLabel = function(obj, text, cw, ch)
		local el = vgui.Create("DLabel", self) el:SetText(text) el:SetColor(Color(0,0,0,255)) self:AddCustom(el, cw or 250, ch or 24) return el
	end

	self.AddCheckBox = function(obj, text, def, cw, ch)
		local el = vgui.Create("DCheckBoxLabel", self) el:SetText(text) el:SetTextColor(Color(0,0,0,255)) el:SetChecked(def or 0) self:AddCustom(el, cw or 250, ch or 24) return el
	end

	self.AddButtonStay = function(obj, text, func)

		local el = vgui.Create("DButton", self) el:SetText(text or "") self:AddCustom(el, cw or 250, ch or 30)

		el.Paint = VC.UI_PaintOver
		function el:SetColorIcon(clr)
			el.ColorIcon = clr
		end
		el.PaintOver = function(_, Sx, Sy)
			if el.ColorIcon then
				draw.RoundedBox(4, 10, 5, 12, 12, VC.Color.Accent)
				draw.RoundedBox(4, 11, 6, 10, 10, el.ColorIcon)
			end
		end
		return el
	end

	self.AddButton = function(obj, text, func)
		local el = self:AddOption(text, func)
		el.Paint = VC.UI_PaintOver
		function el:SetColorIcon(clr)
			el.ColorIcon = clr
		end
		el.PaintOver = function(_, Sx, Sy)
			if el.ColorIcon then
				draw.RoundedBox(4, 10, 5, 12, 12, VC.Color.Accent)
				draw.RoundedBox(4, 11, 6, 10, 10, el.ColorIcon)
			end
		end
		return el
	end

	self.VC_AddSubMenu = function(obj, text, func)
		local sobj, sobj_l = obj:AddSubMenu(text, func)
		applyMenu(sobj)

		sobj_l.Paint = VC.UI_PaintOver

		sobj.Paint = function(tobj, Sx, Sy)
			surface.SetDrawColor(VC.Color.Accent)
			surface.DrawRect(0, 0, Sx, Sy)

			surface.SetDrawColor(VC.Color.Base)
			surface.DrawRect(1, 1, Sx-2, Sy-2)
		end

		return sobj, sobj_l
	end

	self.AddCustom = function(obj, el, cw, ch, marg)
		local pnl = vgui.Create("DPanel", self) pnl.Paint = function() end el:SetParent(pnl) pnl:SetTall(ch or el:GetTall()) pnl:SetWide(cw or self:GetWide()) if marg then el:DockMargin(marg.l,marg.t,marg.r,marg.b) else el:DockMargin(10,4,10,4) end pnl.VC_Panel = el pnl.PaintOver = VC.UI_PaintOver el:Dock(FILL)
		self:AddPanel(pnl)
		return pnl
	end
end

function VC.DermaMenu(text)
	local self = DermaMenu()

	applyMenu(self)

	self.AddAction = function(obj, clk, icon, ttip)
		if !self.ActionPanel then self.ActionPanel = vgui.Create("DPanel") self.ActionPanel:SetTall(40) self.ActionPanel.Paint = function(idx, Sx, Sy) end self:AddCustom(self.ActionPanel) self:AddSpacer() end
		local tall = self.ActionPanel:GetTall()
		local btn = vgui.Create("DButton", self.ActionPanel) btn:SetSize(tall, tall) btn.DoClick = clk btn:Dock(LEFT) btn:SetText("") btn.VC_Icon = icon if ttip then btn:SetTooltip(ttip) end
		local margins = 2
		btn.PaintOver = VC.UI_PaintOver btn.Paint = function(idx, Sx, Sy) if idx.VC_Icon then surface.SetDrawColor(VC.Color.Accent) surface.SetMaterial(idx.VC_Icon) surface.DrawTexturedRect(margins, margins, Sx-margins*2, Sy-margins*2) end end
	end

	self.VC_Text = text or "Unknown"
	self.Button_Close = vgui.Create("DButton", self) self.Button_Close:SetTall(25) self.Button_Close:SetText("") self.Button_Close.DoClick = function() self:Remove() end
	self.Button_Close.Paint = function(obj, Sx, Sy) draw.SimpleText(self.VC_Text, "VC_DEV_lower", Sx/2, Sy-3, VC.Color.Accent, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM) end self:AddPanel(self.Button_Close)

	self.Paint = function(obj, Sx, Sy)
		local clr_bg = VC.Color.Base
		local clr_a = VC.Color.Accent

		local hov = self.Button_Close:IsHovered()
		local act = self.Button_Close:IsDown()
		local clr = VC.Color.Accent_Light if hov then clr = VC.Color.Accent end if act then clr = VC.Color.Base end
		surface.SetDrawColor(clr)
		local size = 25
		surface.DrawRect(Sx-size-2, 2, size, size)

		local clr = VC.Color.Base if hov then clr = Color(255,255,255,255) end if act then clr = VC.Color.Accent end
		surface.SetDrawColor(clr) surface.SetMaterial(VC.Material.icon_cross) local size = 12 surface.DrawTexturedRect(Sx-size-2, 2, size, size)

		VC.UI_DrawPanelBG(obj, Sx, Sy)
	end

	self.AddSpacer()

	VC.UI_AnimatePanel_Start(self, 0.2, 0)

	return self
end

local function createPoly(Sx, Sy, cSize, extra, psx, psy)
	return {
		{x = psx+extra, y = psy+extra},
		{x = psx+Sx-cSize-extra, y = psy+extra},
		{x = psx+Sx-extra, y = psy+cSize+extra},
		{x = psx+Sx-extra, y = psy+Sy-extra},
		{x = psx+extra, y = psy+Sy-extra}
	}
end

function VC.UI_DrawPanelBG(obj, Sx, Sy, psx, psy, extra)
	if !psx then psx = 0 end if !psy then psy = 0 end if !extra then extra = 25 end
	local clr_bg = VC.Color.Base
	local clr_a = VC.Color.Accent
	surface.SetDrawColor(clr_a)
	draw.NoTexture()
	surface.DrawPoly(createPoly(Sx, Sy, extra, 0, psx, psy))
	surface.SetDrawColor(clr_bg)
	surface.DrawPoly(createPoly(Sx, Sy, extra, 2, psx, psy))
end

function VCMsg(msg, clr)
	msg = VC.Lng(msg)
	if msg == nil then msg = "nil" end
	if type(msg) != table then msg = {msg} end
		for _, PM in pairs(msg) do if type(PM) != string then
		PM = tostring(PM) end
		if !VC_DG_Chat_Msg_All then chat.AddText(VC.Color.Accent_Light, "VCMod: ", (clr or VC.Color.Base), tostring(PM)) end
	end
end
net.Receive("VCMsg", function(len) local PM = net.ReadString() VCMsg(PM) end)

if !VC.Fonts then VC.Fonts = {} end
local Txt = "VC_Dev_Text" if !VC.Fonts[Txt] then VC.Fonts[Txt] = true surface.CreateFont(Txt, {font = "MenuLarge", size = 16, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
local Font = "VC_Big" if !VC.Fonts[Font] then VC.Fonts[Font] = true surface.CreateFont(Font, {font = "Trebuchet24", size = 26, weight = 10000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
local Font_i = "VC_Big_Italic" if !VC.Fonts[Font_i] then VC.Fonts[Font_i] = true surface.CreateFont(Font_i, {font = "Trebuchet24", size = 26, weight = 10000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = true, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
local Font_Logo = "VC_Logo" if !VC.Fonts[Font_Logo] then VC.Fonts[Font_Logo] = true surface.CreateFont(Font_Logo, {font = "MenuLarge", size = 50, weight = 1000, blursize = 5, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
local Font_SideBtn = "VC_Menu_Side" if !VC.Fonts[Font_SideBtn] then VC.Fonts[Font_SideBtn] = true surface.CreateFont(Font_SideBtn, {font = "MenuLarge", size = 20, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
local Font_SideBtn_Focused = "VC_Menu_Side_Focused" if !VC.Fonts[Font_SideBtn_Focused] then VC.Fonts[Font_SideBtn_Focused] = true surface.CreateFont(Font_SideBtn_Focused, {font = "MenuLarge", size = 20, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = true, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
local Font_Header = "VC_Menu_Header" if !VC.Fonts[Font_Header] then VC.Fonts[Font_Header] = true surface.CreateFont(Font_Header, {font = "MenuLarge", size = 18, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
local Font_Header_Focused = "VC_Menu_Header_Focused" if !VC.Fonts[Font_Header_Focused] then VC.Fonts[Font_Header_Focused] = true surface.CreateFont(Font_Header_Focused, {font = "MenuLarge", size = 18, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = true, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
local Fnt = "VC_Name" if !VC.Fonts[Fnt] then VC.Fonts[Fnt] = true surface.CreateFont(Fnt, {font = "MenuLarge", size = 26, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false,outline = false}) end
local Font_Info_Small = "VC_Info_Small" if !VC.Fonts[Font_Info_Small] then VC.Fonts[Font_Info_Small] = true surface.CreateFont(Font_Info_Small, {font = "MenuLarge", size = 19, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
local Font_Info_Smaller = "VC_Info_Smaller" if !VC.Fonts[Font_Info_Smaller] then VC.Fonts[Font_Info_Smaller] = true surface.CreateFont(Font_Info_Smaller, {font = "MenuLarge", size = 17, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end
if !VC.Fonts["VC_Regular2"] then VC.Fonts["VC_Regular2"] = true surface.CreateFont("VC_Regular2", {font = "MenuLarge", size = 15, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false,outline = false}) end
if !VC.Fonts["VC_HUD_Bisgs"] then VC.Fonts["VC_HUD_Bisgs"] = true surface.CreateFont("VC_HUD_Bisgs", {font = "BudgetLabel", size = 17, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false,outline = false}) end
if !VC.Fonts["VC_Regular_S"] then VC.Fonts["VC_Regular_S"] = true surface.CreateFont("VC_Regular_S", {font = "MenuLarge", size = 10, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false,outline = false}) end
if !VC.Fonts["VC_Regular_Ms"] then VC.Fonts["VC_Regular_Ms"] = true surface.CreateFont("VC_Regular_Ms", {font = "MenuLarge", size = 13, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false,outline = false}) end
if !VC.Fonts["VC_Cruise"] then VC.Fonts["VC_Cruise"] = true surface.CreateFont("VC_Cruise", {font = "MenuLarge", size = 26, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false,outline = false}) end
if !VC.Fonts["VC_DEV_lower"] then VC.Fonts["VC_DEV_lower"] = true surface.CreateFont("VC_DEV_lower", {font = "MenuLarge", size = 13, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false,outline = false}) end
local Font_Model_Name = "VC_Model_Name" if !VC.Fonts[Font_Model_Name] then VC.Fonts[Font_Model_Name] = true surface.CreateFont(Font_Model_Name, {font = "MenuLarge", size = 18, weight = 1000, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false}) end

function VC.Add_El_List(Px,Py,Sx,Sy)
	local List = vgui.Create("DPanelList") List:EnableVerticalScrollbar(true) List:SetPos(Px, Py) List:SetSize(Sx, Sy)
	local sbar = List.VBar sbar:SetWide(2) sbar.btnUp:SetWide(2) sbar.btnDown:SetWide(2) sbar.btnGrip:SetWide(2) function sbar:Paint(w, h) end function sbar.btnUp:Paint(w, h) end function sbar.btnDown:Paint(w, h) end sbar.btnGrip:NoClipping(true) function sbar.btnGrip:Paint(w, h) draw.RoundedBox(0, w-2, -sbar.btnDown:GetTall(), 2, h+sbar.btnDown:GetTall()*2, VC.Color.Blue) end
	return List
end

function VC.Add_El_Slider(Txt, Min, Max, Dec, Tip, CVar, Tbl, JustAdd) if !Tbl then Tbl = VC.Settings end local Sldr = vgui.Create("DNumSlider") Sldr.Paint = function(obj, Sx, Sy) draw.RoundedBox(0, Sx-50, 5, 45, Sy-10, Color(100,200,200,100)) end Sldr.VC_Text = VC.Lng(Txt or "") Sldr:SetText(Sldr.VC_Text) Sldr:SetMin(Min or 0) Sldr:SetMax(Max or 1) Sldr.VC_Decimals = Dec or 2 Sldr:SetDecimals(Dec or 2) Sldr:SetValue(math.Clamp(0, Min or 0, Max or 1)) if Tip then Sldr:SetToolTip(Tip) Sldr.VC_Tip = Tip end if CVar then Sldr:SetValue(Tbl[CVar] or 0) Sldr.OnValueChanged = function(idx, val) if JustAdd then Tbl[CVar] = val else VC.SaveSetting(CVar, val) end end end return Sldr end
function VC.Add_El_Checkbox(Txt, Tip, CVar, Tbl, JustAdd) if !Tbl then Tbl = VC.Settings end local CBox = vgui.Create("DCheckBoxLabel") CBox.VC_Text = Txt or "" CBox.VC_CheckBox = true CBox:SetText(VC.Lng(Txt or "")) CBox:SetValue(0) if Tip then CBox:SetToolTip(Tip) CBox.VC_Tip = Tip end if CVar then CBox:SetValue(Tbl[CVar] or 0) CBox.OnChange = function(idx, val) if JustAdd then Tbl[CVar] = val else VC.SaveSetting(CVar, val) end end end return CBox end
function VC.Add_El_Line(Pnl, clr) local Line = vgui.Create("VC_Line", Pnl) if clr then Line:SetColor(clr) end Line:SetTall(10) if Pnl then Pnl:AddItem(Line) end end
function VC.Add_El_Banner(Pnl, Text, Clr) local El = vgui.Create("VC_Banner", Pnl) El:SetText(VC.Lng(Text)) El:SetColor(Clr) if Pnl then Pnl:AddItem(El) end end
function VC.Add_El_Panel(Prt, Tbl, Sy, NDraw) VC.DevPanelDimentions = Tbl local Pnl = vgui.Create(NDraw and (NDraw == 2 and "VC_Panel_Draw_Whole" or "VC_Panel_NoDraw") or "VC_Panel") Pnl.VC_Parent = Prt local Sx,_ = Prt:GetSize() Pnl:SetSize(Sx, Sy) Prt:AddItem(Pnl) Pnl.VC_Panels.Main = Pnl return Pnl.VC_Panels end

function VC.Add_El_SliderP(Pnl, Txt, Min, Max, Dec, Tip) local Sldr = VC.Add_El_Slider(Txt, Min, Max, Dec, Tip) if Pnl then Pnl:AddItem(Sldr) end return Sldr end
function VC.Add_El_CheckboxP(Pnl, Txt, Tip) local CBox = VC.Add_El_Checkbox(Txt, Tip) if Pnl then Pnl:AddItem(CBox) end return CBox end

function VC.DoTabClr(prt, pnl) pnl.Tab.Paint = function(obj, Sx, Sy) local active = prt:GetActiveTab() == pnl.Tab draw.RoundedBox(0, 0, 0, Sx, Sy- (active and 4 or 0), active and Color(64,64,64, 255) or Color(0,0,0,200)) end end

function VC.DrawFadeRect(Px,Py,Sx,Sy,tclr,fade)
	if !tclr then tclr = VC.Color.Main end tclr = tclr and table.Copy(tclr)
	if !fade then fade = VC.FadeW end
	Sx = math.Round(Sx) Sy = math.Round(Sy)
	Px = math.Round(Px) Py = math.Round(Py)
	local Sy2 = math.Round(Sy/2)
	draw.RoundedBox(0, math.Round(Px+fade/2), Py, Sx-fade, Sy, tclr)
	surface.SetDrawColor(tclr)
	surface.SetMaterial(VC.Material.Fade)
	surface.DrawTexturedRectRotated(Px+Sx, Py+Sy2, fade, Sy, 0)
	surface.DrawTexturedRectRotated(Px, Py+Sy2, fade, Sy, 180)
end

local typedata = {
	check = {mat = VC.Material.Check, clr = VC.Color.Base},
	cross = {mat = VC.Material.Cross, clr = VC.Color.Base},
	info = {mat = VC.Material.Info, clr = VC.Color.Bsae}
}

net.Receive("VCPopup", function(dt) VCPopup(net.ReadString(), net.ReadString(), net.ReadInt(8)) end)
function VCPopup(text, ttype, length)
	if VC_DG_Popup then return end
	local instant = (length or 2) < 0.8 local Pnl = vgui.Create("DFrame") Pnl:SetSize(50, 50) Pnl:SetTitle("") Pnl:SetPos(ScrW()/2-Pnl:GetWide()/2,ScrH()/2-Pnl:GetTall()/2) Pnl.VC_OriginalPos = {Pnl:GetPos()} Pnl:SetDraggable(false) Pnl:ShowCloseButton(false) Pnl:NoClipping(true) if !instant then Pnl:AlphaTo(0, 0, 0) Pnl:AlphaTo(255, 0.3, 0) end
	local TextPnl = VC.Add_El_List(0,0,50,50) TextPnl:SetParent(Pnl) local text = VC.Lng(text) if !length then length = 2.5 end if !ttype then ttype = "info" end ttype = string.lower(ttype)
	local data = typedata[ttype] TextPnl.Paint = function(obj, Sx, Sy) draw.DrawText(text, Font, Sx, 12, data.clr, TEXT_ALIGN_RIGHT) Pnl.VC_TextSize = surface.GetTextSize(text)+10 end
	Pnl.VC_Start = instant and 0.6 or -0.5 local tclr = table.Copy(VC.Color.Main)

	Pnl.Paint = function(obj, Sx, Sy)
	local FTm = Pnl.FrameRate or 15 if FTm > 10 then FTm = 0.01 end
	Pnl.VC_Start = Pnl.VC_Start+3.5*FTm

	local Int = Pnl.VC_Start if Int < 0 then Int = 0 end if Int > 1 then Int = 1 end Int = VC.EaseInOut(Int)*(Pnl.VC_TextSize or 100)
	tclr.a = Int*5 if tclr.a > 220 then tclr.a = 220 end
	Pnl:SetPos(Pnl.VC_OriginalPos[1]-Int/2, Pnl.VC_OriginalPos[2])
	Pnl:SetWide(50+Int)
	TextPnl:SetPos(40, 0)
	TextPnl:SetWide(Int)
	VC.DrawFadeRect(0,0, Sx, Sy)

	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial(data.mat) surface.DrawTexturedRect(5, 5, 40, 40)

	if Pnl.VC_Start > length*2 and !Pnl.VC_Removing then Pnl.VC_Removing = true Pnl:AlphaTo(0, 0.2, 0) timer.Simple(0.2, function() Pnl:Remove() end) end
	Pnl.FrameRate = VGUIFrameTime()- (Pnl.FrameTime or 0) Pnl.FrameTime = VGUIFrameTime()
	end
	if vgui.CursorVisible() then Pnl:MakePopup() end
end


VC.Menu_Info_Panel = true
VC.Menu_Update_Panel = nil

function VC.DataServer_Get()
	if !VC.DataServer_Checking then
	VC.DataServer_Checking = true
	if file.Exists("vcmod/dataserver.txt", "DATA") then VC.DataServer = util.JSONToTable(file.Read("vcmod/dataserver.txt", "DATA")) end
	http.Fetch("http://vcmod.org/".."api/download_info.php?st=i", function(body) VC.DataServer_Checking = nil VC.DataServer = util.JSONToTable(body) file.Write("vcmod/dataserver.txt", util.TableToJSON(VC.DataServer,true)) end)
	timer.Simple(30, function() if VC.DataServer_Checking then VC.DataServer_Checking = nil VCPrint("could not contact VCMod server, falling back onto data file.") end end)
	end
end
timer.Simple(2, VC.DataServer_Get) timer.Create("VC_ContactServer", 60*30, 0, VC.DataServer_Get)
timer.Create("VC_PrintedChatMsgT", 2, 0, function()
	if !IsValid(LocalPlayer()) then return end
	local ent = LocalPlayer():GetVehicle()
	if IsValid(ent) and (ent.VC_IsJeep or ent:GetNWBool("VC_ExtraSeat", false)) and (!VC.PrintedChatMsgT or CurTime() >= VC.PrintedChatMsgT) then
	VCMsg("Chat")
	VC.PrintedChatMsgT = CurTime()+60*60
	end
end)

local function GetFirstAvailable(ttbl) local key = nil for k,v in pairs(ttbl) do if !v.Check or v.Check() then key = k break end end return key end

function VC.DoOpenMenu(ply, cmd, arg)
	if VC_DG_Menu or arg[1] and ply:EntIndex() != tonumber(arg[1]) then return end

	if IsValid(VC.Menu_Panel) then VC.Menu_Panel:SetVisible(true) VC.Menu_Panel:AlphaTo(0, 0, 0) VC.Menu_Panel:AlphaTo(255, 0.2, 0) return end
	local Menu_Items_A = VC.Menu_Items_A or {} local Menu_Items_P = VC.Menu_Items_P or {}

	local CL_Body = VC.Color.Main
	local CL_Selection = table.Copy(VC.Color.Blue) CL_Selection.a = CL_Selection.a/51
	local CL_Button = Color(0, 0, 0, 0)
	local CL_Button_Hov = table.Copy(VC.Color.Blue) CL_Button_Hov.a = CL_Button_Hov.a/10
	local CL_Button_Sel_Hov = CL_Button_Hov

	local SideButtons, SizeX, SizeY = {}, 750, 550
	VC.Menu_Panel = vgui.Create("DFrame") if !VC.MenuPosX then VC.MenuPosX = ScrW()/2-SizeX/2 end if !VC.MenuPosY then VC.MenuPosY= ScrH()/2-SizeY/2 end VC.Menu_Panel:SetPos(VC.MenuPosX, VC.MenuPosY) VC.Menu_Panel:SetSize(SizeX, SizeY) VC.Menu_Panel:SetTitle("") VC.Menu_Panel:NoClipping(true) VC.Menu_Panel:MakePopup()
	VC.Menu_Panel.VC_Refresh = true VC.Menu_Panel.VC_Refresh_Side = true VC.Menu_Panel:AlphaTo(0, 0, 0) VC.Menu_Panel:AlphaTo(255, 0.2, 0)

	VC.Menu_Panel.Paint = function(obj, Sx, Sy)
	draw.RoundedBox(0, 0, 0, SizeX, SizeY, CL_Body)
	draw.DrawText("VCMod", Font_Logo, -15, -20,  Color(255, 55, 0, 255), TEXT_ALIGN_LEFT)
	draw.RoundedBox(0, 135, 26, 611, SizeY-30, CL_Selection)
	end

	local Button_personal = vgui.Create("DButton") Button_personal:SetParent(VC.Menu_Panel) Button_personal:SetPos(135, 3) Button_personal:SetSize(226, 20) Button_personal:SetText("") Button_personal:NoClipping(true)
	Button_personal.DoClick = function() if VC.Menu_AdminPanelSel or VC.Menu_Info_Panel or VC.Menu_Update_Panel then VC.Menu_Info_Panel = nil VC.Menu_Update_Panel = nil if !VC.Menu_AdminPanelSel_Side_P then VC.Menu_AdminPanelSel_Side_P = GetFirstAvailable(Menu_Items_P) end VC.Menu_Panel.VC_Refresh_Side = true VC.Menu_Panel.VC_Refresh = true end VC.Menu_AdminPanelSel = false end
	Button_personal.Paint = function(obj, Sx, Sy)
	local IsHovered = Button_personal:IsHovered()
	draw.RoundedBox(0, 0, 0, Sx, Sy+(VC.Menu_AdminPanelSel and 0 or 3), (VC.Menu_Info_Panel or VC.Menu_Update_Panel or VC.Menu_AdminPanelSel) and (IsHovered and CL_Button_Hov or CL_Button) or (IsHovered and CL_Button_Sel_Hov or CL_Selection))
	draw.DrawText(VC.Lng("Personal"), IsHovered and Font_Header_Focused or Font_Header, Sx/2, 0, !(VC.Menu_Info_Panel or VC.Menu_Update_Panel or VC.Menu_AdminPanelSel) and VC.Color.Good or VC.Color.White, TEXT_ALIGN_CENTER)
	end

	local Button_admin = vgui.Create("DButton") Button_admin:SetParent(VC.Menu_Panel) Button_admin:SetPos(364, 3) Button_admin:SetSize(226, 20) Button_admin:SetText("") Button_admin:NoClipping(true)
	Button_admin.DoClick = function() if !VC.CanEditAdminSettings(LocalPlayer()) then VCPopup("AccessRestricted", "cross") Button_personal.DoClick() return end if !VC.Menu_AdminPanelSel or VC.Menu_Update_Panel or VC.Menu_Info_Panel then VC.Menu_Info_Panel = nil VC.Menu_Update_Panel = nil if !VC.Menu_AdminPanelSel_Side_A then VC.Menu_AdminPanelSel_Side_A = GetFirstAvailable(Menu_Items_A) end VC.Menu_Panel.VC_Refresh_Side = true VC.Menu_Panel.VC_Refresh = true end VC.Menu_AdminPanelSel = true end
	Button_admin.Paint = function(obj, Sx, Sy)
	local IsHovered = Button_admin:IsHovered()
	draw.RoundedBox(0, 0, 0, Sx, Sy+(VC.Menu_AdminPanelSel and 3 or 0), (VC.Menu_Info_Panel or VC.Menu_Update_Panel or !VC.Menu_AdminPanelSel) and (IsHovered and CL_Button_Hov or CL_Button) or (IsHovered and CL_Button_Sel_Hov or CL_Selection))
	draw.DrawText(VC.Lng("Administrator"), IsHovered and Font_Header_Focused or Font_Header, Sx/2, 0, !VC.Menu_Info_Panel and !VC.Menu_Update_Panel and VC.Menu_AdminPanelSel and VC.Color.Good or VC.Color.White, TEXT_ALIGN_CENTER)
	end

	local Tbl = {} local TblR = {} local Int = 1 local Lng_CBox = vgui.Create("DComboBox", Pnl) Lng_CBox:SetParent(VC.Menu_Panel) Lng_CBox:SetPos(593, 3) Lng_CBox:SetSize(120, 20)
	for k,v in pairs(VC.Lng_T) do local code = string.lower(v.Language_Code) Lng_CBox:AddChoice(string.upper(code).."  "..v.Name) Tbl[Int] = code TblR[code] = Int Int = Int+1 end
	Lng_CBox.OnSelect = function(idx, val) if Lng_CBox.Ignore then Lng_CBox.Ignore = nil return end if VC.Lng_Sel == Tbl[val] then return end if VC.Lng_Set then VC.Lng_Set(Tbl[val]) end VC.Menu_Panel:Close() VC.DoOpenMenu(ply, {}, {}) end
	if VC.Lng_Sel and TblR[VC.Lng_Sel] then Lng_CBox:ChooseOptionID(TblR[VC.Lng_Sel]) else Lng_CBox.Ignore = true Lng_CBox:ChooseOptionID(1) end
	Lng_CBox:SetColor(Color(255,255,255,255))

	Lng_CBox.Paint = function(obj, Sx, Sy) local IsHovered = Lng_CBox:IsHovered() draw.RoundedBox(0, 0, 0, Sx, Sy, IsHovered and Color(35,135,100,245) or Color(35,100,135,245)) end

	VC.Menu_SelectedPnl = nil

	local Btn = vgui.Create("DButton") Btn:SetParent(VC.Menu_Panel) Btn:SetPos(3, VC.Menu_Panel:GetTall()-40) Btn:SetSize(129, 40) Btn:SetText("") Btn:NoClipping(true)
	Btn.DoClick = function() if !VC.Menu_Info_Panel then VC.Menu_Panel.VC_Refresh_Side = true end VC.Menu_Info_Panel = true VC.Menu_Update_Panel = nil end
	Btn.Paint = function(obj, Sx, Sy)
	local IsHovered = Btn:IsHovered()
	draw.RoundedBox(0, 0, 0, Sx+(VC.Menu_Info_Panel and 3 or 0), Sy-4, VC.Menu_Info_Panel and (IsHovered and CL_Button_Sel_Hov or CL_Selection) or (IsHovered and CL_Button_Hov or CL_Button))
	draw.DrawText(VC.Lng("Info"), IsHovered and Font_SideBtn_Focused or Font_SideBtn, Sx/2, Sy/2-14, VC.Menu_Info_Panel and VC.Color.Good or VC.Color.White, TEXT_ALIGN_CENTER)
	end

	local Btn = vgui.Create("DButton") Btn:SetParent(VC.Menu_Panel) Btn:SetPos(3, VC.Menu_Panel:GetTall()-40*2) Btn:SetSize(129, 40) Btn:SetText("") Btn:NoClipping(true)
	Btn.DoClick = function() if !VC.Menu_Update_Panel then VC.Menu_Panel.VC_Refresh_Side = true end VC.Menu_Update_Panel = true VC.Menu_Info_Panel = nil end
	Btn.Paint = function(obj, Sx, Sy)
	local IsHovered = Btn:IsHovered()
	draw.RoundedBox(0, 0, 0, Sx+(VC.Menu_Update_Panel and 3 or 0), Sy-4, VC.Menu_Update_Panel and (IsHovered and CL_Button_Sel_Hov or CL_Selection) or (IsHovered and CL_Button_Hov or CL_Button))
	draw.DrawText(VC.Lng("Updates"), IsHovered and Font_SideBtn_Focused or Font_SideBtn, Sx/2, Sy/2-14, VC.Menu_Update_Panel and VC.Color.Good or VC.Color.White, TEXT_ALIGN_CENTER)
	end

	Button_personal.Think = function()
		if VC.Menu_Panel.VC_Refresh then
		for btnk, btnv in pairs(SideButtons) do if IsValid(btnv) then btnv:Remove() end end SideButtons = {}
			if VC.Menu_AdminPanelSel then
			local Int = 0
				for ItemK, Table in pairs(Menu_Items_A) do
					if !Table.Check or Table.Check() then
					local Name = Table[1]
						if Name then
						local Btn = vgui.Create("DButton") Btn:SetParent(VC.Menu_Panel) Btn:SetPos(3, 26+Int) Btn:SetSize(129, (Table[3] or 45)-(Table[4] or 5)) Btn:SetText("") Btn:NoClipping(true)
						Btn.DoClick = function() if VC.Menu_AdminPanelSel_Side_A != ItemK or VC.Menu_Info_Panel or VC.Menu_Update_Panel then VC.Menu_Panel.VC_Refresh_Side = true end VC.Menu_AdminPanelSel_Side_A = ItemK VC.Menu_Info_Panel = nil VC.Menu_Update_Panel = nil end
						Btn.Paint = function(obj, Sx, Sy)
						local IsHovered = Btn:IsHovered() local On = VC.Menu_AdminPanelSel_Side_A == ItemK and !VC.Menu_Info_Panel and !VC.Menu_Update_Panel
						draw.RoundedBox(0, 0, 0, Sx+(On and 3 or 0), Sy, On and (IsHovered and CL_Button_Sel_Hov or CL_Selection) or (IsHovered and CL_Button_Hov or CL_Button))
						draw.DrawText(VC.Lng(Name), IsHovered and Font_SideBtn_Focused or Font_SideBtn, Sx/2, Sy/2-11, On and VC.Color.Good or VC.Color.White, TEXT_ALIGN_CENTER)
						end
						SideButtons[Name] = Btn
						end
					Int = Int+(Table[3] or 43)
					end
				end
			else
			local Int = 0

				for ItemK, Table in pairs(Menu_Items_P) do
					if !Table.Check or Table.Check() then
					local Name = Table[1]
						if Name then
						local Btn = vgui.Create("DButton") Btn:SetParent(VC.Menu_Panel) Btn:SetPos(3, 26+Int) Btn:SetSize(129, (Table[3] or 45)-(Table[4] or 5)) Btn:SetText("") Btn:NoClipping(true)
						Btn.DoClick = function() if VC.Menu_AdminPanelSel_Side_P != ItemK or VC.Menu_Info_Panel or VC.Menu_Update_Panel then VC.Menu_Panel.VC_Refresh_Side = true end VC.Menu_AdminPanelSel_Side_P = ItemK VC.Menu_Info_Panel = nil VC.Menu_Update_Panel = nil end
						Btn.Paint = function(obj, Sx, Sy)
						local IsHovered = Btn:IsHovered() local On = VC.Menu_AdminPanelSel_Side_P == ItemK and !VC.Menu_Info_Panel and !VC.Menu_Update_Panel
						draw.RoundedBox(0, 0, 0, Sx+(On and 3 or 0), Sy, On and (IsHovered and CL_Button_Sel_Hov or CL_Selection) or (IsHovered and CL_Button_Hov or CL_Button))
						draw.DrawText(VC.Lng(Name), IsHovered and Font_SideBtn_Focused or Font_SideBtn, Sx/2, Sy/2-11, On and VC.Color.Good or VC.Color.White, TEXT_ALIGN_CENTER)
						end
						SideButtons[Name] = Btn
						end
					Int = Int+(Table[3] or 43)
					end
				end
			end
		VC.Menu_Panel.VC_Refresh = nil
		end
		if VC.Menu_Panel.VC_Refresh_Panel then
		if VC.Menu_SelectedPnl then VC.Menu_SelectedPnl:Remove() VC.Menu_SelectedPnl = nil end
		local function HandlePanel(Table) if Table then local Pnl = VC.Add_El_List(138,29,605,SizeY-36) Pnl:SetParent(VC.Menu_Panel) Table.Panel = Pnl VC.Menu_SelectedPnl = Pnl Table[2](Pnl) end end
		HandlePanel(VC.Menu_Info_Panel and VC.Menu_Info_Panel_Build or VC.Menu_Update_Panel and VC.Menu_Update_Panel_Build or VC.Menu_AdminPanelSel and Menu_Items_A[VC.Menu_AdminPanelSel_Side_A] or VC.Menu_AdminPanelSel_Side_P and Menu_Items_P[VC.Menu_AdminPanelSel_Side_P]) VC.Menu_Panel.VC_Refresh_Panel = nil
		end
		if VC.Menu_Panel.VC_Refresh_Side then
		if VC.Menu_SelectedPnl then VC.Menu_SelectedPnl:SetVisible(false) VC.Menu_SelectedPnl = nil end
		local function HandlePanel(Table) if Table then if IsValid(Table.Panel) then Table.Panel:SetVisible(true) Table.Panel:AlphaTo(0, 0, 0) Table.Panel:AlphaTo(255, 0.2, 0) VC.Menu_SelectedPnl = Table.Panel else local Pnl = VC.Add_El_List(138,29,605,SizeY-36) Pnl:AlphaTo(0, 0, 0) Pnl:AlphaTo(255, 0.2, 0) Pnl:SetParent(VC.Menu_Panel) Table.Panel = Pnl VC.Menu_SelectedPnl = Pnl Table[2](Pnl) end end end
		HandlePanel(VC.Menu_Info_Panel and VC.Menu_Info_Panel_Build or VC.Menu_Update_Panel and VC.Menu_Update_Panel_Build or VC.Menu_AdminPanelSel and Menu_Items_A[VC.Menu_AdminPanelSel_Side_A] or VC.Menu_AdminPanelSel_Side_P and Menu_Items_P[VC.Menu_AdminPanelSel_Side_P]) VC.Menu_Panel.VC_Refresh_Side = nil
		end
	end
end

// Initialize console commands
local cmds = {"vc_open_menu", "vc_menu", "vcmod"} for k,v in pairs(cmds) do concommand.Add(v, function(...) VC.DoOpenMenu(LocalPlayer(), {}, {}) end) end concommand.Add("vc_menu_null", function() end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
