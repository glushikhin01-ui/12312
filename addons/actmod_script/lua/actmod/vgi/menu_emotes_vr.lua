if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaVgi_MEmoteVR = true

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



Actoji.OpenEmoteVR = function(self,vrShow)

    local w = math.Clamp(ScrW() / 0.8 ,640,800)
    local h = math.Clamp(ScrH() / 0.8 ,480,800)
    local ply = LocalPlayer()
    ply.ActMod_UseMenu = true

    if w > h then w = h else h = w end
    local w,h = w,w/1.5
	local ActMod_a4_SC = A_AM.ActMod:CGFont("ActMod_a4_SC", {font = "Roboto Regular",size = w*0.016})

	if GetConVarNumber("actmod_cl_pageslot") < 1 or GetConVarNumber("actmod_cl_pageslot") > 8 then LocalPlayer():ConCommand("actmod_cl_pageslot 1\n") end
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
	
    self.Frame = vgui.Create("DFrame")
	self.Frame:SetIcon( "actmod/showeror/ssam4.png" )
    self.Frame:SetTitle("ActMod") PASY.Plist.isFrameH = true
    self.Frame.OnRemove = function(pan)
        ply.ActMod_UseMenu = nil
		ply.CKeyAct_UseMenu = nil
        if IsValid(self.PanelLoadigAnimSy) then self.PanelLoadigAnimSy:Remove() end
        if IsValid(self.Loding) then self.Loding:Remove() end
		if IsValid(self.LitHelp) then self.LitHelp:Remove()end
        if IsValid(EndFrameA) then EndFrameA:Remove() end
        if IsValid(self.LitLang) then self.LitLang:Remove() end
        if IsValid(self.Underlay) then
			if IsValid(self.Underlay.DButCh) then self.Underlay.DButCh:CloseMenu() end
			if self.Underlay.TDComboBox then for k, v in pairs(self.Underlay.TDComboBox) do if IsValid(v) then v:CloseMenu() end end end
			if IsValid(self.Underlay.Cmenu) then self.Underlay.Cmenu:Remove() end
			if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
			self.Underlay:SetVisible(false)
		end
    end
	if vrShow then
		if vrShow == true then ply.CKeyAct_UseMenu_VR = true end
		if isnumber(vrShow) then
			self.Frame:SetPaintedManually(true)
		end
		A_AM.ActMod.Truevr = vrShow else A_AM.ActMod.Truevr = false
	end
	
	self.Frame.TabEmots = {}
	
    if (A_AM.ActMod.A_ActMod_RedyUse and GetConVarNumber("actmod_cl_eloading") ~= 0) or GetConVarNumber("actmod_cl_eloading") == 0 then
		self.Frame:SetSize(w, h) self.Frame:Center()
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
	
	self.Frame.dCB = vgui.Create("DCheckBoxLabel", self.Frame)
	self.Frame.dCB:SetText("Auto close") self.Frame.dCB:SetTextColor( Color(255,255,255) )
	self.Frame.dCB:SetConVar("actmod_cl_automclose") self.Frame.dCB:SizeToContents() self.Frame.dCB:SetPos(80, 5)
	self.Frame.dCBj = vgui.Create("DCheckBoxLabel", self.Frame)
	self.Frame.dCBj:SetText("Join") self.Frame.dCBj:SetTextColor( Color(255,255,255) )
	self.Frame.dCBj:SetConVar("actmod_cl_vrjoin") self.Frame.dCBj:SizeToContents() self.Frame.dCBj:SetPos(110 + self.Frame.dCB:GetWide(), 5)
	self.Frame.dCBk = vgui.Create("DCheckBoxLabel", self.Frame)
	self.Frame.dCBk:SetText("Shortcut key") self.Frame.dCBk:SetTextColor( Color(255,255,255) )
	self.Frame.dCBk:SetConVar("actmod_cl_vrslist") self.Frame.dCBk:SizeToContents() self.Frame.dCBk:SetPos(130 + self.Frame.dCB:GetWide() + self.Frame.dCBj:GetWide(), 5)
	if ply:SteamID64() == "76561199185837385" or ply:SteamID64() == "76561199186277029" then
		self.Frame.dCheckBox2 = vgui.Create("DCheckBoxLabel", self.Frame)
		self.Frame.dCheckBox2:SetText("BNext") self.Frame.dCheckBox2:SetTextColor( Color(255,255,255) )
		self.Frame.dCheckBox2:SetConVar("actmod_cl_vrenext") self.Frame.dCheckBox2:SizeToContents() self.Frame.dCheckBox2:SetPos(170 + self.Frame.dCB:GetWide() + self.Frame.dCBj:GetWide() + self.Frame.dCBk:GetWide(), 5)
		self.Frame.dCheckBox3 = vgui.Create("DCheckBoxLabel", self.Frame)
		self.Frame.dCheckBox3:SetText("Axie") self.Frame.dCheckBox3:SetTextColor( Color(255,255,255) )
		self.Frame.dCheckBox3:SetConVar("actmod_cl_vrenext2") self.Frame.dCheckBox3:SizeToContents() self.Frame.dCheckBox3:SetPos(195 + self.Frame.dCheckBox2:GetWide() + self.Frame.dCB:GetWide() + self.Frame.dCBj:GetWide() + self.Frame.dCBk:GetWide(), 5)
		self.Frame.dCheckBox4 = vgui.Create("DCheckBoxLabel", self.Frame)
		self.Frame.dCheckBox4:SetText("Show SysNext") self.Frame.dCheckBox4:SetTextColor( Color(255,255,255) )
		self.Frame.dCheckBox4:SetConVar("actmod_cl_vrshwsynext") self.Frame.dCheckBox4:SizeToContents() self.Frame.dCheckBox4:SetPos(225 + self.Frame.dCB:GetWide() + self.Frame.dCBj:GetWide() + self.Frame.dCBk:GetWide() + self.Frame.dCheckBox2:GetWide() + self.Frame.dCheckBox3:GetWide() , 5)
		self.Frame.dCheckBox5 = vgui.Create("DCheckBoxLabel", self.Frame)
		self.Frame.dCheckBox5:SetText("Sound") self.Frame.dCheckBox5:SetTextColor( Color(255,255,255) )
		self.Frame.dCheckBox5:SetConVar("actmod_cl_vrsondnext") self.Frame.dCheckBox5:SizeToContents() self.Frame.dCheckBox5:SetPos(245 + self.Frame.dCB:GetWide() + self.Frame.dCBj:GetWide() + self.Frame.dCBk:GetWide() + self.Frame.dCheckBox2:GetWide() + self.Frame.dCheckBox3:GetWide() + self.Frame.dCheckBox4:GetWide() , 5)
	end

	if GetReadyFUse(ply) == true then
		local oldPaint = self.Frame.Paint
		local titleH = (self.lblTitle and self.lblTitle:GetTall() or 24) + 2
		self.Frame.Paint = function(self, w, h)
			if true then
				local inset = self:GetDockPadding()-2
				surface.SetDrawColor(50, 50, 50, 255)
				surface.DrawRect(0,0,w,titleH )
				surface.SetDrawColor(0, 50, 100, 150)
				surface.DrawRect(inset,titleH,w - inset * 2,h - titleH - inset )
				surface.SetDrawColor(50, 50, 50, 255)
				surface.DrawOutlinedRect(0, titleH, w, h - titleH, 3)
			else
				if oldPaint then oldPaint(self, w, h) end
			end
		end
	else
		self.Frame.Paint = function(s, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(70, 150, 255, 140))
			if GetReadyFUse(ply) ~= true then
				local zw, zh = 450, 70
				local zw2, zh2 = math.max(zw - 10 + (8 * math.sin(CurTime() * 6)), 0), math.max(zh - 10 + (5 * math.sin(CurTime() * 6)), 0)
				draw.RoundedBox(10, w / 2 - (zw + 15) / 2, h / 2 - (zh + 15) / 2, zw + 15, zh + 15, Color(0, 0, 0, 255))
				draw.RoundedBox(10, w / 2 - (zw + 10) / 2, h / 2 - (zh + 10) / 2, zw + 10, zh + 10, Color(0, 0, 0, 255))
				draw.RoundedBox(10, w / 2 - zw / 2, h / 2 - zh / 2, zw, zh, Color(0, 0, 0, 255))
				draw.RoundedBox(10, w / 2 - zw2 / 2, h / 2 - zh2 / 2, zw2, zh2, Color(200, 100, 0, 255))
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
					draw.SimpleText(WiDl, "ActMod_a1", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
					draw.SimpleText(WiDl, "ActMod_a1", w / 2 + 1, h / 2 + 1, Color(255, 255, 255, 255), 1, 1)
				end
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

    local aO = 0.2
	local matbckd = Material("materials/actmod/imenu/iblocked_01.png", "noclamp smooth")
	self.Frame.dragState = { isDragging = false,sourceButton = nil,sourceSlot = nil,ghostPanel = nil,hoveredSlot = nil,originalPositions = {} }
	local dragState = self.Frame.dragState
	
    local function MakeButton(a, aa, aba, az, aN)
        local ply = LocalPlayer()
        local vCs, BZz

        if aba then
            vCs = aba
        else
            vCs = self.Frame
        end

        if az then
            BZz = az
        else
			BZz = self.Frame:GetTall()/2.70
        end

        local tx, ty
		
		if self.Frame.TabEmots and istable(self.Frame.TabEmots) and self.Frame.TabEmots[aN] then self.Frame.TabEmots[aN] = nil end

        local e = vgui.Create("DButton", vCs)
        e:SetText("")
		e.OnRemove = function() if IsValid(e.Cmenu) then e.Cmenu:Remove() end end
        e:SetSize(BZz, BZz + 10)
		tx, ty = a, aa
        e:SetPos(tx , ty)
		if not vrShow then e:SetAlpha(0) e:AlphaTo(255, aO) end
        e.Slot = aN
		local TActData = A_AM.ActMod:GetEmoIcn( aN,A_AM.ActMod:ActaLoed(A_AM.ActMod:ActojTyp(aN),A_AM.ActMod.aNTyp[aN]) )
		if TActData and istable(TActData) and TActData[1] and TActData[2] then
			self.table[aN] = TActData[2]
			e.Material = TActData[1]
			e.Actoji = TActData[2]
			e.txtMat = TActData[3]
			if GetConVarNumber("actmod_cl_showsholightic") > 0 then e.WMaterial = A_AM.ActMod:GetWMaterial(e.txtMat, 128, 128) end
		else
			self.table[aN] = ""
		end
		
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
				if not s.Actoji then return end
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
				e.Cmenu:Open()
            else
                self:Replace(s.Slot, aba)
                A_AM.ActMod.ClServro(ply)
            end
        end

		local IsBLocd = A_AM.ActMod:IsDanceBlacklisted(e.Actoji)
        e.DoClick = function(s)
            if IsBLocd or not s.Actoji then return end
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
			if GetConVarNumber("actmod_cl_automclose") > 0 then
				self:Close(nil,vrShow)
			end
        end
		if not e.Actoji then return end


        local NIcon
        local shv = ReString(e.Actoji)
        local si_Gmod_Taunt = A_AM.ActMod:ATabData(A_AM.ActMod.ActGmod, shv) == true
        local si_AM4_Amod = (string.StartsWith(shv, "amod_") or string.StartsWith(shv, "amod_am4_") or string.StartsWith(shv, "amod_m_")) and not string.StartsWith(shv, "amod_cumact_") and not string.StartsWith(shv, "amod_pubg_") and not string.StartsWith(shv, "amod_mixamo_") and not string.StartsWith(shv, "amod_mmd_") and not string.StartsWith(shv, "amod_fortnite_")
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
				si_AM4_Amod = (string.StartsWith(shv, "amod_") or string.StartsWith(shv, "amod_am4_") or string.StartsWith(shv, "amod_m_")) and not string.StartsWith(shv, "amod_cumact_") and not string.StartsWith(shv, "amod_pubg_") and not string.StartsWith(shv, "amod_mixamo_") and not string.StartsWith(shv, "amod_mmd_") and not string.StartsWith(shv, "amod_fortnite_")
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
				e.isG = (GTabActO_CTA and isnumber(GTabActO_CTA["NoStop"]) and GTabActO_CTA["NoStop"] == 63) or (GTabActO and isnumber(GTabActO["NoStop"]) and GTabActO["NoStop"] == 63)
			end
			if (s.tti or 0) < CurTime() then
				s.tti = CurTime() + 0.5
				if aN then
					local TActData = A_AM.ActMod:GetEmoIcn( aN,A_AM.ActMod:ActaLoed(A_AM.ActMod:ActojTyp(aN),A_AM.ActMod.aNTyp[aN]) )
					if TActData and istable(TActData) and TActData[1] and TActData[2] then
						self.table[aN] = TActData[2]
						e.Material = TActData[1]
						e.Actoji = TActData[2]
						e.txtMat = TActData[3]
						if GetConVarNumber("actmod_cl_showsholightic") > 0 then e.WMaterial = A_AM.ActMod:GetWMaterial(e.txtMat, 128, 128) end
					end
				end
			end
		end
		
        e.Paint = function(s, w, h)
            if not s.Material then return end
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
			if IsBLocd then
				local aw = h*0.6
				local Aclor = math.Clamp( 1+1.2*math.sin(CurTime()*4) ,0.2,0.7 )
				surface.SetDrawColor(255, 255, 255, AlpBse*Aclor)
				surface.SetMaterial(matbckd)
				surface.DrawTexturedRect(w/2-aw/2,h/2-aw/2,aw,aw)
			end
			local wa = math.min( A_AM.ActMod.aGetTextSize(s.Alptxt,ActMod_a4_SC) + 20 ,w)
			local alpb = math.max(math.min((ca*1.5)-80,255),0)
			draw.RoundedBox(0, w/2-wa/2, h-12,wa,12, Color(0, 0, 0, alpb))
			draw.SimpleText(s.Alptxt, ActMod_a4_SC, w/2, h-7, Color(255, 255, 255, alpb), 1, 1)

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
					
					if si_AM4_Fortnite then
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
					elseif si_AM4_Amod then
						surface.SetMaterial(Material("actmod/imenu/is_am4.png", "noclamp smooth"))
						NIcon = "AM4"
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
		local Maa = 10
		local GTup = self.Frame:GetWide()-Maa
		local msaf = self.Frame:GetTall()/12
		local MRe = GTup/4
		local MRe2 = MRe
		MakeButton(Maa/2, msaf, nil, nil, At[An][1])
		MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][2]) MRe = MRe+MRe2
		MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][3]) MRe = MRe+MRe2
		MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][4])
		msaf = self.Frame:GetTall()/2.1   MRe = GTup/4   MRe2 = MRe
		MakeButton(Maa/2 , msaf, nil, nil, At[An][5])
		MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][6]) MRe = MRe+MRe2
		MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][7]) MRe = MRe+MRe2
		MakeButton(Maa/2 + MRe , msaf, nil, nil, At[An][8])
		GTup = nil msaf = nil MRe = nil MRe2 = nil Maa = nil
	end
	if istable(self.Frame.TabEmots) then
		for k,tm in pairs( self.Frame.TabEmots ) do
			if IsValid(tm) then tm:Remove() end
		end
		self.Frame.TabEmots = {}
	end
	spwnemotes()

    local ess = vgui.Create("DPanel", self.Frame)
    ess:SetText("")
    ess.zt = self.Frame:GetTall()*0.565
	ess:SetSize(200, 47) ess:SetPos(10, self.Frame:GetTall() - 50.5)
	ess.zt = 488*0.2
    ess.Paint = function(ste, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 120, 100))
    end
	
	local ess2
    if (A_AM.ActMod.A_ActMod_RedyUse and GetConVarNumber("actmod_cl_eloading") ~= 0) or GetConVarNumber("actmod_cl_eloading") == 0 then
		ess2 = vgui.Create("DPanel", self.Frame)
		ess2:SetText("")
		ess2.zt = self.Frame:GetTall()*0.565
		ess2:SetSize(410, 47) ess2:SetPos(self.Frame:GetWide() - ess2:GetWide() - 10, self.Frame:GetTall() - 50.5)
		ess2.zt = 488*0.2
		ess2.Paint = function(ste, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 120, 100))
		end
    end
	
    local ess3 = vgui.Create("DPanel", self.Frame)
    ess3:SetText("")
    ess3.zt = self.Frame:GetTall()*0.565
	ess3:SetSize(100, 47) ess3:SetPos(220, self.Frame:GetTall() - 50.5)
	ess3.zt = 488*0.2
    ess3.Paint = function(ste, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 120, 100))
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
            elseif GCN == "A_BETT_3" then
				CTxtMos(ste, nil, {100, 100, 100, 150}, "Stop Emote/Dance", "CreditsText")
				surface.SetMaterial(Material("icon16/stop.png", "noclamp smooth"))
            elseif GCN == "A_BETT_4" then
				CTxtMos(ste, nil, {100, 100, 100, 150}, "Stop Gesture", "CreditsText")
				surface.SetMaterial(Material("icon16/delete.png", "noclamp smooth"))
            end

            surface.DrawTexturedRect(3, 3, w - 6, h - 6)
        end

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
            elseif GCN == "actmod_cl_pageslot" then
				surface.PlaySound("garrysmod/ui_click.wav")
				if GetConVarNumber(GCN) ~= GSN then
					LocalPlayer():ConCommand("actmod_cl_pageslot ".. math.Clamp(tonumber(GSN),1,8) .."\n")
					if istable(self.Frame.TabEmots) then for k,tm in pairs( self.Frame.TabEmots ) do if IsValid(tm) then tm:Remove() end end self.Frame.TabEmots = {} end
					spwnemotes(GSN)
				end
            elseif GCN == "A_BETT_3" then
				surface.PlaySound("garrysmod/ui_click.wav")
				RunConsoleCommand("actmod_wts","wts_End")
            elseif GCN == "A_BETT_4" then
				surface.PlaySound("garrysmod/ui_click.wav")
				RunConsoleCommand("actmod_wts","stpg")
            else
                if GetConVarNumber(s.Cmo) == 1 then
                    RunConsoleCommand(s.Cmo, "0")
                else
                    RunConsoleCommand(s.Cmo, "1")
                end

                surface.PlaySound("garrysmod/ui_click.wav")
            end
        end
    end

	DBtt(ess, 5, 5, "actmod_cl_sound", "actmod_sv_enabled_addso")
	DBtt(ess, 55, 5, "actmod_cl_effects", "actmod_sv_enabled_addef")
	DBtt(ess, 106, 5, "A_BETT_1")
	DBtt(ess, 158, 5, "A_BETT_2")
	
    if ess2 and IsValid(ess2) and (A_AM.ActMod.A_ActMod_RedyUse and GetConVarNumber("actmod_cl_eloading") ~= 0 or GetConVarNumber("actmod_cl_eloading") == 0) then
		local aw,aa,ak = 4,50,2
		DBtt(ess2, aw, 5, "actmod_cl_pageslot", 1) aw = aw + aa + ak
		DBtt(ess2, aw, 5, "actmod_cl_pageslot", 2) aw = aw + aa + ak
		DBtt(ess2, aw, 5, "actmod_cl_pageslot", 3) aw = aw + aa + ak
		DBtt(ess2, aw, 5, "actmod_cl_pageslot", 4) aw = aw + aa + ak
		DBtt(ess2, aw, 5, "actmod_cl_pageslot", 5) aw = aw + aa + ak
		DBtt(ess2, aw, 5, "actmod_cl_pageslot", 6) aw = aw + aa + ak
		DBtt(ess2, aw, 5, "actmod_cl_pageslot", 7) aw = aw + aa + ak
		DBtt(ess2, aw, 5, "actmod_cl_pageslot", 8) aw = aw + aa + ak
	end
	
	local gl = ess3.zt/2
	DBtt(ess3, 5, 5, "A_BETT_3")
	DBtt(ess3, 10+gl, 5, "A_BETT_4")

	Actoji:OpenListErr()
end

A_AM.ActMod.LuaVgi_MEmoteVR_Done = true
