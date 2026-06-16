--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

// Copyright © 2012-2018 VCMod (freemmaann). All Rights Reserved. if you have any complaints or ideas contact me: steam - steamcommunity.com/id/freemmaann/ or email - freemmaann@gmail.com.

VC.Color.Main = Color(0,0,0,220)
VC.Color.Good = Color(155,255,100,255)
VC.Color.Neutral = Color(255,170,0,255)
VC.Color.Blue = Color(155,225,255,255)
VC.Color.Bad = Color(255,70,70,255)
VC.Color.Slider = Color(0,0,0,200)
VC.Color.White = Color(220,255,255,255)

VC.Color.Base = Color(237, 237, 237, 255)
VC.Color.Accent = Color(127, 37, 37, 255)
VC.Color.Accent_Light = Color(163, 48, 48, 255)

VC.Color.Btn_Add = Color(0,125,0,255)
VC.Color.Btn_Rem = Color(200,0,0,255)
VC.Color.Btn_Cng = Color(155,225,255,255)
VC.Color.Btn_Spw = Color(155,155,255,255)
VC.Color.Btn_Orn = Color(255,180,55,255)

-- MODULE:Hook("VC_CD_Spawned","VC",function(ply, data)
--     MODULE:Log(bLogs:FormatPlayer(ply).." CD: spawned vehicle "..bLogs:Highlight(data.veh_name).. " ("..bLogs:Highlight(data.veh_category)..") using " .. bLogs:Highlight(data.cd_name).." car dealer.")
-- end)

VC.FadeW = 50

VC.KBK = {["KEY_A"] = {}, ["KEY_B"] = {}, ["KEY_C"] = {}, ["KEY_D"] = {}, ["KEY_E"] = {}, ["KEY_F"] = {}, ["KEY_G"] = {}, ["KEY_H"] = {}, ["KEY_I"] = {}, ["KEY_J"] = {}, ["KEY_K"] = {}, ["KEY_L"] = {}, ["KEY_M"] = {}, ["KEY_N"] = {}, ["KEY_O"] = {}, ["KEY_P"] = {}, ["KEY_Q"] = {}, ["KEY_R"] = {}, ["KEY_S"] = {}, ["KEY_T"] = {}, ["KEY_U"] = {}, ["KEY_V"] = {}, ["KEY_W"] = {}, ["KEY_X"] = {}, ["KEY_Y"] = {}, ["KEY_Z"] = {}, ["KEY_PAD_0"] = {name = "Keypad 0"}, ["KEY_PAD_1"] = {name = "Keypad 1"}, ["KEY_PAD_2"] = {name = "Keypad 2"}, ["KEY_PAD_3"] = {name = "Keypad 3"}, ["KEY_PAD_4"] = {name = "Keypad 4"}, ["KEY_PAD_5"] = {name = "Keypad 5"}, ["KEY_PAD_6"] = {name = "Keypad 6"}, ["KEY_PAD_7"] = {name = "Keypad 7"}, ["KEY_PAD_8"] = {name = "Keypad 8"}, ["KEY_PAD_9"] = {name = "Keypad 9"}, ["KEY_PAD_DIVIDE"] = {name = "Keypad /"}, ["KEY_PAD_MULTIPLY"] = {name = "Keypad *"}, ["KEY_PAD_MINUS"] = {name = "Keypad -"}, ["KEY_PAD_PLUS"] = {name = "Keypad +"}, ["KEY_PAD_ENTER"] = {name = "Keypad Enter"}, ["KEY_PAD_DECIMAL"] = {name = "Keypad Del"}, ["KEY_LBRACKET"] = {name = "Left Bracket"}, ["KEY_RBRACKET"] = {name = "Right Bracket"}, ["KEY_SEMICOLON"] = {name = "Semicolon"}, ["KEY_APOSTROPHE"] = {name = 'Apostrophe'}, ["KEY_BACKQUOTE"] = {name = "Back quote"}, ["KEY_COMMA"] = {name = "Comma"}, ["KEY_PERIOD"] = {name = "Period"}, ["KEY_SLASH"] = {name = "Forward Slash"}, ["KEY_BACKSLASH"] = {name = "Back Slash"}, ["KEY_MINUS"] = {name = "Minus"}, ["KEY_EQUAL"] = {name = "Equal"}, ["KEY_ENTER"] = {name = "Enter"}, ["KEY_SPACE"] = {name = "Space"}, ["KEY_TAB"] = {name = "Tab"}, ["KEY_CAPSLOCK"] = {name = "Caps Lock"}, ["KEY_NUMLOCK"] = {name = "Num Lock"}, ["KEY_SCROLLLOCK"] = {name = "Scroll Lock"}, ["KEY_INSERT"] = {name = "Insert"}, ["KEY_DELETE"] = {name = "Delete"}, ["KEY_HOME"] = {name = "Home"}, ["KEY_END"] = {name = "End"}, ["KEY_PAGEUP"] = {name = "Page Up"}, ["KEY_PAGEDOWN"] = {name = "Page Down"}, ["KEY_BREAK"] = {name = "Break"}, ["KEY_LSHIFT"] = {name = "Shift"}, ["KEY_RSHIFT"] = {name = "Shift"}, ["KEY_LALT"] = {name = "Alt"}, ["KEY_RALT"] = {name = "Alt"}, ["KEY_LCONTROL"] = {name = "Control"}, ["KEY_RCONTROL"] = {name = "Control"}, ["KEY_UP"] = {name = "Arrow Up"}, ["KEY_LEFT"] = {name = "Arrow Left"}, ["KEY_DOWN"] = {name = "Arrow Down"},["KEY_RIGHT"] = {name = "Arrow Right"}, ["KEY_F1"] = {name = "Function 1"}, ["KEY_F2"] = {name = "Function 2"}, ["KEY_F3"] = {name = "Function 3"}, ["KEY_F4"] = {name = "Function 4"}, ["KEY_F5"] = {name = "Function 5"}, ["KEY_F6"] = {name = "Function 6"}, ["KEY_F7"] = {name = "Function 7"}, ["KEY_F8"] = {name = "Function 8"}, ["KEY_F9"] = {name = "Function 9"}, ["KEY_F10"] = {name = "Function 10"}, ["KEY_F11"] = {name = "Function 11"}, ["KEY_F12"] = {name = "Function 12"}}
VC.KBK_Mouse = {MOUSE_LEFT = {name = "Mouse 1"}, MOUSE_RIGHT = {name = "Mouse 2"}, MOUSE_MIDDLE = {name = "Mouse 3"}, MOUSE_4 = {name = "Mouse 4"}, MOUSE_5 = {name = "Mouse 5"}}

local Icon_Tick = Material("icon16/tick.png")

local tbl = {main = "vcmod1", els = "vcmod1_els", hdl = "vcmod_hdl"}

function VC.FunctionDRAW(Sx, Sy, self)
	if self.Info then

	local size = Sx local Clr = table.Copy(self.Info.color) local Spd = self.StartSpeed
	if self:IsHovered() then
	Clr.a = 255 Spd = Spd+3 size = size-15

	draw.RoundedBox(0, 100, 60, 200, 255, VC.Color.Main)
	draw.RoundedBox(0, 100, 60, 200, 25, VC.Color.Main)
	draw.DrawText(self.Info.name, "VC_Dev_Text", 107, 60, VC.Color.Blue, TEXT_ALIGN_LEFT)
		for k,v in pairs(self.Info.features) do
		surface.SetDrawColor(255, 255, 255, 255) surface.SetMaterial(Icon_Tick) surface.DrawTexturedRect(107, 65+k*15, 15, 15)
		draw.DrawText(v, nil, 130, 65+k*15, Color(255,255,255,255), TEXT_ALIGN_LEFT)
		end

		surface.SetDrawColor(VC.Color.Blue.r,VC.Color.Blue.g,VC.Color.Blue.b,255)
		local pcx, pcy = Sx/2, Sy/2 local epx, epy = 95, 75 local epx2, epy2 = epx+205, epy
		for i=1,5 do surface.DrawLine(pcx+i, pcy, epx+i, epy) end
		for i=1,3 do surface.DrawLine(epx+i, epy+i-1, epx2, epy2+i-1) end
	end

	local symbol = "$"

	local tclr = Color(255,55,0,255)
	if self.Info.price then
	local free = nil if self.Info.price == "0.00" then tclr = VC.Color.Good free = true end
	surface.SetDrawColor(tclr)
	local pcx, pcy = Sx/2, Sy/2 local epx, epy = pcx-50, pcy-40 local epx2, epy2 = epx-(free and 40 or 100), epy
	for i=1,5 do surface.DrawLine(pcx+i, pcy, epx+i, epy) end
	for i=1,3 do surface.DrawLine(epx+i, epy+i-1, epx2, epy2+i-1) end
	draw.DrawText(free and "free" or (symbol..self.Info.price.." "..symbol..self.Info.price_full), "VC_Dev_Text", epx2+5, epy2-15, VC.Color.Good, TEXT_ALIGN_LEFT)

		if !free then
		surface.SetDrawColor(VC.Color.Good.r,VC.Color.Good.g,VC.Color.Good.b, 255)
		surface.DrawLine(epx, epy-6, epx-50, epy-6)
		surface.DrawLine(epx, epy-7, epx-50, epy-7)
		end
	end

	local cur_ver = tonumber(self.Info.cur_ver) local addon_ver = VC.Versions[tbl[self.Info.id]]

	local Tclr = VC.Color.Blue local len = 115 local text = "Not installed"

	if addon_ver then
		-- if cur_ver > addon_ver then
		-- print(cur_ver , addon_ver)
		if VC_useBeta or cur_ver > addon_ver then
			text = "Beta" Tclr = VC.Color.Blue len = 50
			-- text = "Out of date" Tclr = table.Copy(VC.Color.Bad) Tclr.a = math.sin(CurTime()*15) > 0 and 255 or 0  len = 100
			-- elseif cur_ver < addon_ver then
			-- text = "Beta" Tclr = VC.Color.Blue len = 50
		else
			text = "Up to date" Tclr = VC.Color.Good len = 100
		end
	end

	surface.SetDrawColor(tclr)
	local pcx, pcy = Sx/2, Sy/2 local epx, epy = pcx-10, pcy-60 local epx2, epy2 = epx+len, epy
	for i=1,5 do surface.DrawLine(pcx+i, pcy, epx+i, epy) end
	for i=1,3 do surface.DrawLine(epx+i, epy+i-1, epx2, epy2+i-1) end
	draw.DrawText(text, "VC_Menu_Side", epx+5, epy2-20, Tclr, TEXT_ALIGN_LEFT)

	surface.SetDrawColor(Clr.r, Clr.g, Clr.b, Clr.a) surface.SetMaterial(VC.Material.Circle_32)
	local sin = math.sin(CurTime()*1*Spd)*5 local TX, TY = sin*math.sin(CurTime()*5*Spd)*3, sin*math.sin(CurTime()*8*Spd)*3 surface.DrawTexturedRect(Sx/2-size/2-TX/2, Sy/2-size/2-TY/2, size+TX, size+TY)
	local sin = math.sin(CurTime()*2*Spd)*4 local TX, TY = sin*math.sin(CurTime()*4*Spd)*2, sin*math.sin(CurTime()*9*Spd)*4 surface.DrawTexturedRect(Sx/2-size/2-TX/2, Sy/2-size/2-TY/2, size+TX, size+TY)
	local sin = math.sin(CurTime()*3*Spd)*3 local TX, TY = sin*math.sin(CurTime()*3*Spd)*1, sin*math.sin(CurTime()*10*Spd)*2 surface.DrawTexturedRect(Sx/2-size/2-TX/2, Sy/2-size/2-TY/2, size+TX, size+TY)
	draw.DrawText(self.Info.title, Hov and "VC_Big" or "VC_Big", Sx/2, Sy/2-15, Color(255, 255, 255, self:IsHovered() and 255 or Clr.a), TEXT_ALIGN_CENTER)
	end
end

local El = {}
function El:Init() self.VC_Button = vgui.Create("DButton", self) self.VC_Button:SetSize(self:GetSize()) self.VC_Button:SetText("") self.VC_Button.Paint = function(obj, Sx, Sy) end end

function El:Setup(Tbl)
	self.VC_Button:SetSize(self:GetSize()) self.VC_Button.Info = Tbl self.VC_Button.StartSpeed = math.Rand(0.6,1)
	if Tbl.link then
		self.VC_Button.DoClick = function()

		local Tclr = VC.Color.Blue local len = 115

			local DDM = VC.DermaMenu("VCMod "..Tbl.name)
			DDM:AddLabel("Version: "..Tbl.cur_ver)
			DDM:AddLabel("Price: "..(Tbl.price == 0 and "free" or (Tbl.price.."USD")))
			DDM:AddSpacer()
			if Tbl.trailer then DDM:AddButton("Watch trailer", function() gui.OpenURL(Tbl.trailer) end):SetImage("icon16/film.png") end
			if Tbl.link then DDM:AddButton("Download", function() gui.OpenURL(Tbl.link) end):SetImage("icon16/plugin.png") end
			DDM:Open()
		end
	end
end
function El:Paint(Sx, Sy) VC.FunctionDRAW(Sx, Sy, self.VC_Button) end
vgui.Register("VC_Ball", El)

local El = {}
function El:Init() self.VC_List1, self.VC_List2, self.VC_Button = vgui.Create("DListView", self), vgui.Create("DListView", self), vgui.Create("DImageButton", self) self.VC_Button:SetMaterial(VC.Material.icon_right) end
function El:Think()
	local PWth = self:GetParent():GetWide()
	self.VC_List1:SetTall(self.VC_Tall) self.VC_List1:SetWide(PWth*0.47)
	self.VC_List2:SetWide(PWth*0.47) self.VC_List2:SetTall(self.VC_Tall) self.VC_List2:SetPos(PWth-PWth*0.47, 0)
	self.VC_Button:SetWide(PWth*0.06) local BtnHt = math.min(50, self.VC_Tall) self.VC_Button:SetPos(PWth*0.47, self.VC_Tall/2-BtnHt/2) self.VC_Button:SetTall(BtnHt)
end
vgui.Register("VC_Lists", El)

local El_TxtNtr = {}
function El_TxtNtr:Init() self.VC_TxtNtr, self.VC_TxtNtrLbl = vgui.Create("DTextEntry", self), vgui.Create("DLabel", self) end
function El_TxtNtr:SetTextColor(clr) self.VC_TxtNtrLbl:SetTextColor(clr) end
function El_TxtNtr:GetValue() self.VC_TxtNtr:GetValue() end
function El_TxtNtr:Think() if !self.VC_AsnedChng and self.VC_TextChngd then self.VC_TxtNtr.OnTextChanged = self.VC_TextChngd self.VC_AsnedChng = true end if !self.VC_AsnedInfo then self.VC_TxtNtrLbl:SetText(self.VC_Text) self.VC_AsnedInfo = true end local PWth = self:GetParent():GetWide() local EWth = PWth*(self.VC_TxtNtrPrc or 0.7) self.VC_TxtNtr:SetWide(EWth) self.VC_TxtNtrLbl:SetPos(math.Clamp(EWth+6, 0, PWth), 0) self.VC_TxtNtrLbl:SetWide(math.Clamp(PWth-EWth-6, 0, PWth)) end
vgui.Register("VC_TextEntry", El_TxtNtr)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Line
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

local El = {}
function El:Init() self.Color = VC.Color.Blue end
function El:Paint(Sx, Sy) local clr = self:GetColor() if clr then draw.RoundedBox(0, 4, Sy/2-1, Sx-8, 2, clr) end end
function El:SetColor(val) self.Color = val end
function El:GetColor() return self.Color end
derma.DefineControl("VC_Line", "A tiny line spanning accross the x axis.", El, "Panel")

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Banner
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

local El = {}
function El:Init() self:SetTall(40) self.Color = VC.Color.Blue end
function El:Paint(Sx, Sy)
	local clr = self:GetColor() if !clr then clr = VC.Color.Blue end
	draw.SimpleText(self:GetText() or "Unknown", "VC_DEV_lower", Sx/2, Sy/2, clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.RoundedBox(1, 4, Sy-2-5, Sx-8, 2, clr)
end
function El:SetText(val) self.Text = val end
function El:GetText() return self.Text end
function El:SetColor(val) self.Color = val end
function El:GetColor() return self.Color end
derma.DefineControl("VC_Banner", "A tiny banner with a line.", El, "Panel")

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Control
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

local El_Cnt = {}
function El_Cnt:Paint() if !self.VC_AsgndInf then return end self.VC_BtnSlcTNm = self.VC_BtnSlcTNm or 0 local CMS, BW, BH = self.VC_BtnSlcTNm > 0 and ((80+ math.sin(CurTime()*10)*8)* self.VC_BtnSlcTNm) or 20, self:GetSize() if self.VC_AwaitInput and self.VC_BtnSlcTNm < 1 then self.VC_BtnSlcTNm = self.VC_BtnSlcTNm+ 0.05 elseif !self.VC_AwaitInput and self.VC_BtnSlcTNm > 0 then self.VC_BtnSlcTNm = self.VC_BtnSlcTNm- 0.03 end draw.RoundedBox(0, BW/2, 0, BW/2, BH, Color(CMS, (self.VC_BtnInfo[2] or self.VC_BtnCmd == "vc_holdkey") and 65 or 50, 70- 80*self.VC_BtnSlcTNm, 255)) if self:CheckIfOverwritten() then draw.RoundedBox(0, 0, 0, BW/2, BH, Color(0, 0, 0, 255)) draw.RoundedBox(0, BW/2, 0, BW/2, BH, Color(0, 0, 0, 55)) else draw.RoundedBox(0, 0, 0, BW/2, BH, Color(90, 20, 00, 255)) end end

function El_Cnt:OnMousePressed(MB)
	if MB == MOUSE_LEFT then
		if !self.VC_AwaitInput and !self:CheckIfOverwritten() then
		self.VC_BtnKey:SetText(VC.Lng("EnterKey"))
		self.VC_AwaitInput_Time = CurTime()+5 self.VC_AwaitInput = true
		end
	end
end

function El_Cnt:CheckIfOverwritten() return !self.VC_Override and VC.ServerSettings.Override_Controls and VC.Override_Controls and VC.Override_Controls[self.VC_BtnCmd] and tostring(VC.Override_Controls[self.VC_BtnCmd].use) == "1" end

function El_Cnt:Think()
	local ctbl = VC.Controls_List if self.VC_Override or self:CheckIfOverwritten() then ctbl = VC.Override_Controls
	if self.VC_Override and self.VC_BtnCmd and ctbl and !ctbl[self.VC_BtnCmd] then ctbl[self.VC_BtnCmd] = VC.Controls_List[self.VC_BtnCmd] end
	end
	if !ctbl then ctbl = {} end
	local Width = self:GetWide()/2+10
		if self.VC_BtnInfo and !self.VC_AsgndInf then
		self.VC_BtnInfLbl = vgui.Create("DLabel", self) self.VC_BtnInfLbl:SetSize(Width-18, 20) self.VC_BtnInfLbl:SetPos(8, 2) self.VC_BtnInfLbl:SetText((self:CheckIfOverwritten() and ("{{"..VC.Lng("Overwritten").."}} ") or "")..VC.Lng(self.VC_BtnInfo[1]))
		self.VC_BtnKey = vgui.Create("DLabel", self) self.VC_BtnKey:SetSize(Width, 20)
		local GCN = (ctbl[self.VC_BtnCmd] or {}).key or "None"
		self.VC_BtnKey:SetText((self.VC_BtnInfo[2] and (VC.Lng("HoldKey").." + ") or "")..VC.Lng(GCN == "None" and "None" or (VC.KBK[GCN] or VC.KBK_Mouse[GCN]).name or string.Explode("KEY_", ctbl[self.VC_BtnCmd].key)[2]))
		self.VC_AsgndInf = true
		end
	if self.VC_BtnKey then self.VC_BtnKey:SetPos(Width, 2) end
	if self.VC_AwaitInput and vgui.CursorVisible() and self.VC_AwaitInput_Time and CurTime() < self.VC_AwaitInput_Time then
	self.VC_BtnInit = true
	if input.IsKeyDown(KEY_BACKSPACE) then RunConsoleCommand(self.VC_Override and "VC_SetControl_Override" or "VC_SetControl", self.VC_BtnCmd, "None") self.VC_BtnKey:SetText("None") self.VC_AwaitInput = nil self.VC_BtnTxt = nil end
	for KLk, KLv in pairs(VC.KBK) do if input.IsKeyDown(_G[KLk]) and !KLv[self] then KLv[self] = true elseif !input.IsKeyDown(_G[KLk]) and KLv[self] and self.VC_BtnCmd then self.VC_BtnTxt = KLv.name or string.Explode("KEY_", KLk)[2] RunConsoleCommand(self.VC_Override and "VC_SetControl_Override" or "VC_SetControl", self.VC_BtnCmd, KLk) self.VC_BtnKey:SetText(self.VC_BtnTxt) self.VC_AwaitInput = nil end end
	if CurTime() >= (self.VC_AwaitInput_Time-4.8) then for KLk, KLv in pairs(VC.KBK_Mouse) do if input.IsMouseDown(_G[KLk]) and !KLv[self] then KLv[self] = true elseif !input.IsMouseDown(_G[KLk]) and KLv[self] and self.VC_BtnCmd then self.VC_BtnTxt = KLv.name RunConsoleCommand(self.VC_Override and "VC_SetControl_Override" or "VC_SetControl", self.VC_BtnCmd, KLk, "0", "1") self.VC_BtnKey:SetText(self.VC_BtnTxt) self.VC_AwaitInput = nil end end end
	elseif self.VC_BtnInit then
	local GCN = (ctbl[self.VC_BtnCmd] or {}).key or "None"
	self.VC_BtnKey:SetText((self.VC_BtnInfo[2] and (VC.Lng("HoldKey").." + ") or "")..VC.Lng((self.VC_BtnTxt == "None" or GCN == "None") and "None" or (VC.KBK[GCN] or VC.KBK_Mouse[GCN]).name or string.Explode("KEY_", ctbl[self.VC_BtnCmd].key)[2]))
	for KLk, KLv in pairs(VC.KBK) do KLv[self] = nil end
	for KLk, KLv in pairs(VC.KBK_Mouse) do KLv[self] = nil end
	self.VC_AwaitInput = nil self.VC_BtnInit = nil
	end
end
vgui.Register("VC_Control", El_Cnt)

local El_Cnt_Chk = {}
function El_Cnt_Chk:Think()
	if self.VC_BtnInfo and !self.VC_AsgndInf then
	local ctbl = VC.Controls_List if self.VC_Override then ctbl = VC.Override_Controls end if !ctbl then ctbl = {} end
	self.VC_Control = vgui.Create("VC_Control", self) self.VC_Control.VC_Override = self.VC_Override self.VC_Control.VC_BtnInfo = self.VC_BtnInfo self.VC_Control.VC_BtnCmd = self.VC_BtnCmd
	self.VC_CheckBox = vgui.Create("DCheckBox", self) self.VC_CheckBox:SetValue(ctbl[self.VC_BtnCmd] and ctbl[self.VC_BtnCmd].hold or 0) self.VC_CheckBox:SetToolTip("Hold")
	self.VC_CheckBox.OnChange = function(CBP, CBV) RunConsoleCommand(self.VC_Override and "VC_SetControl_Override" or "VC_SetControl", self.VC_BtnCmd, "Hold", CBV and "1" or "0") end
	self.VC_AsgndInf = true
	end
	if self.VC_Control then self.VC_Control:SetSize(self:GetSize()) if self.VC_Control:CheckIfOverwritten() then self.VC_CheckBox:SetDisabled(true) end self.VC_CheckBox:SetPos(self:GetWide()-20, 4) end
end
vgui.Register("VC_Control_CheckBox", El_Cnt_Chk)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


local El_Pnl = {}
function El_Pnl:Think()
	if self.VC_BTbl then
	local DoIcons = #self.VC_BTbl == 2 and self:GetWide() < 200
		for Bk, Bv in pairs(self.VC_BTbl) do
		if !self.VC_BTbl[Bk].info then
		local Btn = vgui.Create("VC_Button", self) Btn:SetText(Bv.name) if Bv.tooltip then Btn:SetToolTip(Bv.tooltip) end if Bv.clk then Btn.DoClick = Bv.clk end self.VC_BTbl[Bk].btn = Btn self.VC_BTbl[Bk].info = true
			Btn:SetTextIsWhite(true)
			if Bk == 1 then
			Btn:SetColor(VC.Color.Btn_Add)
			if DoIcons then Btn.VC_DrawIcon = "Add" end
			elseif Bk == (self.RemoveButton or 2) then
			Btn:SetColor(VC.Color.Btn_Rem)
			if DoIcons then Btn.VC_DrawIcon = "Rem" end
			else
			Btn:SetColor(VC.Color.Btn_Cng)
			Btn:SetTextIsWhite(false)
			end
		if Bv.paint then Btn.Paint = Bv.paint end
		end
		local Sx, Sy = self:GetSize() Bv.btn:SetPos(Sx/#self.VC_BTbl*(Bk-1)) Bv.btn:SetSize(Sx/#self.VC_BTbl-1, Sy)
		end
	end
end
vgui.Register("VC_ARB", El_Pnl)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
local function Init(self)
	local PosX = 0 self.VC_Panels = {}
	for k,v in pairs(VC.DevPanelDimentions) do self.VC_Panels[k] = vgui.Create("DPanelList") self.VC_Panels[k]:EnableVerticalScrollbar(true) self.VC_Panels[k]:SetParent(self) end
	self.VC_DevPanelDimentions = table.Copy(VC.DevPanelDimentions) VC.DevPanelDimentions = nil
end

local function Think(self) if self.VC_Panels and self.VC_Parent and self.VC_DevPanelDimentions then local PosX = 0 local Sx, Sy = self.VC_Parent:GetSize() for k,v in pairs(self.VC_DevPanelDimentions) do self.VC_Panels[k]:SetPos(PosX, 0) self.VC_Panels[k]:SetSize(Sx*v-(self.VC_Panels[k+1] and 2 or 0), Sy) PosX = PosX+Sx*v end end end

local El_Pnl = {}
function El_Pnl:Init() Init(self) end
function El_Pnl:Think() Think(self) end
function El_Pnl:Paint() for k,v in pairs(self.VC_Panels) do local Px, Py = v:GetPos() local Sx, Sy = v:GetSize() draw.RoundedBox(0, Px, Py, Sx, Sy-4, Color(0,0,0,120)) end end
vgui.Register("VC_Panel", El_Pnl)

local El_Pnl = {}
function El_Pnl:Init() Init(self) end
function El_Pnl:Think() Think(self) end
vgui.Register("VC_Panel_NoDraw", El_Pnl)

local El_Pnl = {}
function El_Pnl:Init() Init(self) end
function El_Pnl:Think() Think(self) end
function El_Pnl:Paint() local Sx, Sy = self:GetSize() draw.RoundedBox(0, 0, 0, Sx, Sy-4, Color(0,0,0,120)) end
vgui.Register("VC_Panel_Draw_Whole", El_Pnl)

local El = {}
function El:SetColor(val) self.VC_Color = val end
function El:SetPulseColor(val) self.VC_PulseColor = val end
function El:SetFont(val) self.VC_Font = val end
function El:SetKey(val) self.VC_Key = "["..string.upper(val).."]" end
function El:SetText(val) self.VC_Text = val end
function El:SetTextIsWhite(val) self.VC_IsWhiteText = val end
function El:Paint(Sx, Sy)
	local cx, cy = Sx/2, Sy/2

	if !self.VC_ClrNil then self.VC_ClrNil = true self:SetTextColor(Color(0,0,0,0)) end
	local hov = self:IsHovered() local dwn = self:IsDown()
	local clr = self.VC_Color or VC.Color.Blue if self.VC_PulseColor and math.sin(CurTime()*50) > 0 then clr = self.VC_PulseColor end
	local clr_t = table.Copy(clr) clr_t.a = 25

	draw.RoundedBox(0, 0, 0, Sx, Sy, Color(0,0,0,255))

	draw.RoundedBox(0, 0, 0, Sx, Sy, clr_t)
	if dwn then clr_t.a = 255 draw.RoundedBox(0, 0, 0, Sx, Sy, clr_t) elseif hov then draw.RoundedBox(0, 0, 0, Sx, Sy, clr_t) end
	draw.RoundedBox(0, 1, Sy-2, Sx-1, 2, clr)

	if self.VC_DrawIcon then
		local nclr = VC.Color.Good local icon = VC.Material.icon_add if self.VC_DrawIcon == "Rem" then nclr = VC.Color.Bad icon = VC.Material.icon_remove end

		surface.SetDrawColor(255, 255, 255, 255) surface.SetMaterial(icon) local sz = Sy*0.8 surface.DrawTexturedRect(cx-sz/2, cy-sz/2, sz, sz)
	else
		local pos_y = cy-(Sy > 50 and 12 or 8)
		draw.DrawText(self.VC_Text or "", self.VC_Font, cx, pos_y, dwn and Color(0,0,0,255) or VC.Color.White, TEXT_ALIGN_CENTER)
		if self.VC_Key then draw.DrawText(self.VC_Key or "", nil, Sx-3, pos_y, clr, TEXT_ALIGN_RIGHT) end
	end
end
derma.DefineControl("VC_Button", "VCMod's button.", El, "DButton")

local El_MBtn = {}
function El_MBtn:Think()
	if self.VC_BTbl then
		for Bk, Bv in pairs(self.VC_BTbl) do
			if !self.VC_BTbl[Bk].info then
			local Btn = vgui.Create("VC_Button", self) Btn:SetText(Bv.name) if Bv.tooltip then Btn:SetToolTip(Bv.tooltip) end if Bv.clk then Btn.DoClick = Bv.clk end self.VC_BTbl[Bk].btn = Btn self.VC_BTbl[Bk].info = true
			if Bv.clr then Btn:SetColor(Bv.clr) end if Bv.IsTextWhite then Btn:SetTextIsWhite(Bv.IsTextWhite) end
			end
		local Sx, Sy = self:GetSize() Bv.btn:SetPos(Sx/#self.VC_BTbl*(Bk-1)) Bv.btn:SetSize(Sx/#self.VC_BTbl-1, Sy)
		end
	end
end
vgui.Register("VC_MultiButton", El_MBtn)

local El = {}
function El:Init()
	self.VC_List = vgui.Create("DComboBox", self)
	self.VC_List:SetSortItems(false)

	self.VC_Max = 0
	self.VC_Sel = 0

	self.VC_List.OnSelect = function(...) self.OnSelect(...) end

	self.VC_Btn1 = vgui.Create("DImageButton", self) self.VC_Btn1:SetMaterial(VC.Material.icon_left) self.VC_Btn1:SetToolTip("Select previous in the list.") self.VC_Btn1:SetWidth(25)
	self.VC_Btn2 = vgui.Create("DImageButton", self) self.VC_Btn2:SetMaterial(VC.Material.icon_right) self.VC_Btn2:SetToolTip("Select next in the list.") self.VC_Btn2:SetWidth(25)
	self.VC_Btn3 = vgui.Create("DImageButton", self) self.VC_Btn3:SetMaterial(VC.Material.icon_search) self.VC_Btn3:SetToolTip("Display all data.") self.VC_Btn3:SetWidth(25)
	self.VC_Btn1.DoClick = function() local sel = self:GetSelected() if sel and sel > 1 then self:ChooseOptionID(sel-1) end end
	self.VC_Btn2.DoClick = function() local sel = self:GetSelected() local cnt = table.Count(self.VC_List.Choices) if cnt > 0 and (!sel or cnt > sel) then self:ChooseOptionID((sel or 0)+1) end end
end

function El:AddChoice(...) if self.VC_List then self.VC_List:AddChoice(...) end end
function El:ChooseOption(...) if self.VC_List then self.VC_List:ChooseOption(...) end end
function El:ChooseOptionID(...) if self.VC_List then self.VC_List:ChooseOptionID(...) end end
function El:GetSelected() local ret = self.VC_List and self.VC_List.selected return ret end
function El:Clear(...) if self.VC_List then self.VC_List:Clear(...) end end
function El:OnSelect(...) end
function El:Think()
	if self.VC_List then
	local Sx,Sy = self:GetSize()
		if self.VC_DontDoView then
			self.VC_List:SetWidth(Sx-50)
			self.VC_Btn1:SetPos(Sx-50, 0)
			self.VC_Btn2:SetPos(Sx-25, 0)
			self.VC_Btn3:Remove()
		else
			self.VC_List:SetWidth(Sx-75)
			self.VC_Btn1:SetPos(Sx-75, 0)
			self.VC_Btn2:SetPos(Sx-50, 0)
			self.VC_Btn3:SetPos(Sx-25, 0)
		end
	end
end
vgui.Register("VC_DComboBox", El)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
local El_Vec = {}
function El_Vec:Init() self.VC_VecLbl, self.VC_VecX, self.VC_VecY, self.VC_VecZ = vgui.Create("DLabel", self), vgui.Create("DNumberWang", self), vgui.Create("DNumberWang", self), vgui.Create("DNumberWang", self) self.VC_VecLbl:SetPos(5,0) self.VC_VecLbl:SetSize(37,24) self.VC_VecX:SetSize(50, 20) self.VC_VecY:SetSize(50, 20) self.VC_VecZ:SetSize(50, 20)
	self.VC_VecX.OnValueChanged = function(idx, val) if !self.IgnoreChange and self.OnChange then self.OnChange(nil, self:GetValue()) end end
	self.VC_VecY.OnValueChanged = function(idx, val) if !self.IgnoreChange and self.OnChange then self.OnChange(nil, self:GetValue()) end end
	self.VC_VecZ.OnValueChanged = function(idx, val) if !self.IgnoreChange and self.OnChange then self.OnChange(nil, self:GetValue()) end end
end
function El_Vec:Think() local PWd = self:GetParent():GetWide() self.VC_VecLbl:SetWide(PWd-150) self.VC_VecX:SetPos(PWd-150, 0) self.VC_VecY:SetPos(PWd-100, 0) self.VC_VecZ:SetPos(PWd-50, 0) end
function El_Vec:Setup(text, min, max, dec)
	if !text then text = "" end self.VC_Text = text if !min then min = -500 end if !max then max = 500 end if !dec then dec = 2 end
	self.VC_VecX:SetMin(min) self.VC_VecX:SetMax(max) self.VC_VecX:SetDecimals(dec) self.VC_VecY:SetMin(min) self.VC_VecY:SetMax(max) self.VC_VecY:SetDecimals(dec) self.VC_VecZ:SetMin(min) self.VC_VecZ:SetMax(max) self.VC_VecZ:SetDecimals(dec) self.VC_VecLbl:SetText(text) self.VC_VecX:SetValue(0) self.VC_VecY:SetValue(0) self.VC_VecZ:SetValue(0)
end
function El_Vec:SetValue(vec)
	if !vec then vec = Vector(0,0,0) elseif type(vec) != "vector" then vec = Vector(vec[1],vec[2],vec[3]) end
	vec = Vector(math.Round(vec[1]*100)/100, math.Round(vec[2]*100)/100, math.Round(vec[3]*100)/100)
	if vec.x != self.VC_VecX:GetValue() or vec.y != self.VC_VecY:GetValue() or vec.z != self.VC_VecZ:GetValue() then
	self.IgnoreChange = true self.VC_VecX:SetValue(vec.x) self.VC_VecY:SetValue(vec.y) self.VC_VecZ:SetValue(vec.z) self.IgnoreChange = nil
	if self.OnChange then self.OnChange(nil, vec) end
	end
end
function El_Vec:GetValue() return Vector(self.VC_VecX:GetValue(),self.VC_VecY:GetValue(),self.VC_VecZ:GetValue()) end
vgui.Register("VC_Vector", El_Vec)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
