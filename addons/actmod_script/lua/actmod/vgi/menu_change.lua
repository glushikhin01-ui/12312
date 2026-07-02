if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaVgi_MChange = true

if SERVER then return end

local Actoji,ASettings = A_AM.ActMod.Actoji,A_AM.ActMod.Settings
A_AM.ActMod.FindIt = {}
if Actoji and IsValid(Actoji.Underlay) then
	if IsValid(Actoji.Underlay.modelmenu) then Actoji.Underlay.modelmenu:Remove() end
	Actoji.Underlay:Remove()
end
local function ReString(st, tam4) return A_AM.ActMod:ReString(st, tam4) end
local function RvString(ara) return A_AM.ActMod:RvString(ara) end
local function CTxtMos(Ow, IsH, Ty, txt, txf, aup) A_AM.ActMod:CTxtMos(Ow, IsH, Ty, txt, txf, aup) end
local function aShowCopy(s) A_AM.ActMod:aShowCopy(s) end
local function GActNewV(txt)
	return (not A_AM.ActMod.ActNewVCustom or istable(A_AM.ActMod.ActNewVCustom[txt])) or A_AM.ActMod:ATabData(A_AM.ActMod.ActNewV, txt) == true
end
local function RoundDT(num) return math.floor(num / 10) * 10 end
local function SimplePulse(t,g) return (t < g*0.5 and t or (t < g*0.5 and g or g - t))*2 end
local function AaA(g)
	local ao = 0
	for k, v in pairs(g) do
		if v["ok"] == "yes" then
			ao = ao + 1
		end
	end
	return ao
end
local function ScrTIx(list, targetIndex, spaceY, border)
    border = border or 1
    spaceY = spaceY or 1
    local children = list:GetChildren()
    if #children == 0 then return end
    local offsetY = border
    for i = 1, targetIndex - 1 do
        local child = children[i]
        if child then offsetY = offsetY + spaceY/6 end
    end
	if IsValid(list.TScroll) then
		list.TScroll.btnUp.DoClick = function( s ) s:GetParent():AddScroll( -offsetY ) end
		list.TScroll.btnDown.DoClick = function( s ) s:GetParent():AddScroll( offsetY ) end
	end
end
local function sf_txt(txt1,txt2)
	if isstring(txt1) and isstring(txt2) and (txt1 == txt2 or string.find(txt1,txt2)) then
		return true
	end
	return false
end

local function MarkNew_TabDataRn(str)
	local RNMR = 0
	if str > 69 or str >= 40 and str < 60 then
		if istable(A_AM.ActMod.ActNewVCustom) then
			for k, vTab in pairs(A_AM.ActMod.ActNewVCustom) do
				if vTab[1] and A_AM.ActMod:ATabData(A_AM.ActMod.cl_TmpDatanew, k) == false then
					local vt = "amod_cumact_".. string.lower(k)
					vt = vt:gsub("%s+$", "")
					if A_AM.ActMod.GTabActO[vt] and A_AM.ActMod.GTabActO[vt]["class"] and A_AM.ActMod.GTabActO[vt]["class"] > 0 and A_AM.ActMod.GTabActO[vt]["class"] == str-(str > 69 and -1 or str > 40 and str < 45 and 0 or 49) and A_AM.ActMod:ExistsMaterial("materials/actmod/cumact/".. k ..".png") then
						RNMR = RNMR + 1
					end
				end
			end
		end
	else
		if istable(A_AM.ActMod.ActNewV) then
			for k, tv in pairs(A_AM.ActMod.ActNewV) do
				local v = string.lower(tostring(tv))
				if A_AM.ActMod:ATabData(A_AM.ActMod.cl_TmpDatanew, v) == false then
					if ( str == 1 and A_AM.ActMod:ATabData(A_AM.ActMod.ActGmod, ReString(v)) == true )
					or ( (str == 2 or str == 3) and not string.sub(v,1,5) "amod_" )
					or ( str == 5 and (string.sub(v,1,5) == "amod_" or string.sub(v,1,9) == "amod_am4_" or string.sub(v,1,7) == "amod_m_") and string.sub(v,1,10) ~= "amod_pubg_" and string.sub(v,1,12) ~= "amod_mixamo_" and string.sub(v,1,9) ~= "amod_mmd_" and string.sub(v,1,14) ~= "amod_fortnite_" )
					or ( str == 11 and string.sub(v,1,10) == "amod_pubg_" )
					or ( str == 10 and string.sub(v,1,12) == "amod_mixamo_" )
					or ( str == 6 and string.sub(v,1,9) == "amod_mmd_" )
					or ( str == 7 and string.sub(v,1,14) == "amod_fortnite_" ) then
						RNMR = RNMR + 1
					end
				end
			end
		end
	end
	return RNMR
end


Actoji.Replace = function(self, Slot, isS ,callback ,ava)
    local Dled
    if Slot == 1001 or Slot == 1002 then Dled = true end
    if not IsValid(self.Frame) and (Slot ~= 1001 and Slot ~= 1002) then return end
	local atgufn = A_AM.ActMod:GUniqueFiName(LocalPlayer())
	

	if self.Underlay and IsValid(self.Underlay) then
		if (self.Underlay.Dled ~= nil or Dled ~= nil) and self.Underlay.Dled ~= Dled then
			if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
			self.Underlay:Remove()
		else
			self.Underlay:SetVisible(true) self.Underlay:MakePopup()
			self.Underlay:SetAlpha(0) self.Underlay:AlphaTo(255, 0.5)
			self.Underlay.Slot = Slot
			self.Underlay.callback = callback
			if IsValid(self.Underlay.Panel) then
				if istable(self.Underlay.Panel.tablTime) then
					for i,v in pairs(self.Underlay.Panel.tablTime) do
						if IsValid(v) then
							v.aak = nil
						end
					end
					if IsValid(self.Underlay.Passq) then
						self.Underlay.Passq.aNextN = 0
						self.Underlay.Passq.ttim = CurTime() + 1
					end
				end
			end
			if IsValid(self.Underlay.DButCh) then self.Underlay.DButCh:rBsa() end
			local aaw = 0
			if file.Exists(atgufn, "DATA") then
				local tmp = file.Read(atgufn, "DATA")
				local commit
				pcall(function() commit = util.JSONToTable(A_AM.ActMod:A_BED(2, tmp)) end)
				if not commit or not istable(commit) or not commit.inopn then
					aaw = 0
					file.Delete(atgufn, "DATA")
				elseif A_AM.ActMod:A_BED(1, commit.inopn) == "QWN0TW9kIFtBTTRd" then
					aaw = 1
					if AaA(commit) > 0 then aaw = 2 end
				end
			end
			self.Underlay.aaw = aaw
			return
		end
	end

    if A_AM.ActMod.cl_TmpDatanew then A_AM.ActMod.cl_TmpDatanew = {} end
    local ActDataNew = A_AM.ActMod:LoadEmts("saveenew",{"ActojiDNew1"},function(t,g) A_AM.ActMod:RCFi(t,g) end)

    if ActDataNew and istable(ActDataNew) then
        local TActDataNew = ActDataNew

        if TActDataNew[1] and TActDataNew[1] == A_AM.ActMod.Mounted["Version ActMod"] then
            A_AM.ActMod.cl_TmpDatanew = TActDataNew
        else
            TActDataNew = {}
            table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
            A_AM.ActMod.cl_TmpDatanew = TActDataNew
			A_AM.ActMod:ReAddEmts("saveenew",{"ActojiDNew1",0,TActDataNew},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
        end
		TActDataNew = nil
	else
		local TActDataNew = {}
		table.insert(TActDataNew, A_AM.ActMod.Mounted["Version ActMod"])
		A_AM.ActMod.cl_TmpDatanew = TActDataNew
		A_AM.ActMod:ReAddEmts("saveenew",{"ActojiDNew1",0,TActDataNew},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
		TActDataNew = nil
    end

    local ply = LocalPlayer()
    local ThemeN = GetConVarNumber("actmod_cl_thememenu")
    local TmpB = GetConVarNumber("actmod_cl_sortemote")
	
    self.Underlay = vgui.Create("DButton")
	self.Underlay.Slot = Slot
	self.Underlay.Dled = Dled
	self.Underlay.callback = callback
    self.Underlay.OnRemove = function(pan)
		if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
        if IsValid(self.Underlay.Cmenu) then self.Underlay.Cmenu:Remove() end
        if IsValid(self.Aar) and not self.Underlay.Dled then self.Aar:Remove() end
    end
    self.Underlay:SetText("")
    self.Underlay:SetCursor("arrow")
    self.Underlay:SetSize(ScrW(), ScrH())
    self.Underlay:SetAlpha(0)
    self.Underlay:AlphaTo(255, 0.5)
    self.Underlay.DoClick = function(s)
		if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
        if IsValid(self.Underlay) then self.Underlay:SetVisible(false) end
    end
    self.Underlay.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150)) end
    self.Underlay:MakePopup()
	local aaw = 0
	if file.Exists(atgufn, "DATA") then
		local tmp = file.Read(atgufn,"DATA")
		local commit
		pcall(function() commit = util.JSONToTable(A_AM.ActMod:A_BED(2, tmp)) end)
		if not commit or not istable(commit) or not commit.inopn then
			aaw = 0
			file.Delete(atgufn, "DATA")
		elseif A_AM.ActMod:A_BED(1, commit.inopn) == "QWN0TW9kIFtBTTRd" then
			aaw = 1
			if AaA(commit) > 0 then aaw = 2 end
		end
	end
	self.Underlay.aaw = aaw

	
	local Panel2
	if self.Underlay.Dled then
        if IsValid(Panel2) then Panel2:Remove() Panel2 = nil end
		Panel2 = nil
	else
		Panel2 = vgui.Create("DPanel", self.Underlay)
		Panel2:SetSize(240, 35)
		Panel2:SetPos(5, 5)

		Panel2.Paint = function(s, w, h)
			draw.RoundedBox(10, 0, 0, w, h, (ThemeN == 1 and Color(50, 100, 150, 255)) or (ThemeN == 2 and Color(0, 0, 0, 150)) or Color(100, 100, 100, 150))
		end
    end

    local Thh = 30
    local alfh = 1000
    self.Underlay.Panel = vgui.Create("DPanel", self.Underlay)
    local Panel = self.Underlay.Panel
    Panel:SetSize(760, math.Clamp(ScrH() / 1.3 ,355,680) + Thh)
    Panel:Center()

    Panel.Paint = function(s, w, h)
        draw.RoundedBox(10, 0, 0, w, h, (ThemeN == 1 and Color(50, 100, 150, 255)) or (ThemeN == 2 and Color(0, 0, 0, 150)) or Color(100, 100, 100, 150))
    end

    local List
    local Buttons = {}
	
	local function ValueToIndex(tbl, value) for k, v in pairs(tbl) do if v == value then return k end end end

    local function Update()
        List:SetSpaceY(self.ScaleIconsDEG / 4)
        List:SetSpaceX(self.ScaleIconsDEG / 4)
		ScrTIx(List, 2, self.ScaleIconsDEG / 4, List:GetBorder())
        for _, v in pairs(Buttons or {}) do
            v:SetSize(self.ScaleIconsDEG, self.ScaleIconsDEG)
        end
    end

    local DermaNumSlider = vgui.Create("DNumSlider", Panel)
	if self.Underlay.Dled then
		DermaNumSlider:SetPos(520, Panel:GetTall() - (-5 + Thh))
		DermaNumSlider:SetSize(180, 20)
	else
		DermaNumSlider:SetPos(3, Panel:GetTall() - (25 + Thh))
		DermaNumSlider:SetSize(165, 20)
	end
    DermaNumSlider:SetText(aR:T("LReplace_AGSize"))
    DermaNumSlider:SetMin(1)
    DermaNumSlider:SetMax(4)
    DermaNumSlider:SetDecimals(0)
    DermaNumSlider:SetValue(ValueToIndex(self.TScaleIconsDEG, self.ScaleIconsDEG))
    DermaNumSlider.OnValueChanged = function(s, dfn)
		dfn = math.Round(dfn)
		if self.ScaleIconsDEG ~= self.TScaleIconsDEG[dfn] then
			self.ScaleIconsDEG = self.TScaleIconsDEG[dfn]
			Update()
		end
    end
	DermaNumSlider.Paint = function(p, w, h)
		CTxtMos(p, nil, {100, 100, 100, 200}, aR:T("LReplace_AGSize"), "CreditsText" ,11 ,2)
	end

    local function Wnds_ComboBox3(aPos, bPos, aSize, bSize, cPos, dPos, cSize, dSize, TextN, comm, comm_1, comm_2, comm_3, comm_4, ic_1, ic_2, ic_3, ic_4, ShIc)
        local rh = vgui.Create("DPanel", (ShIc == "CTheme" and Panel2) or Panel)
        rh:SetPos(aPos, (ShIc == "CTheme" and bPos) or Panel:GetTall() - (bPos + Thh))
        rh:SetSize(aSize, bSize)
        rh:SetText("")
        rh:SetAlpha(255)

        rh.Paint = function(s, w, h)
            if ThemeN == 1 then
                draw.RoundedBox(0, 0, 0, w, h, Color(40, 60, 80, 255))
            end

            if ShIc == "SCamV" then
                if GetConVarNumber(comm) == 0 then
                    draw.SimpleText(aR:T("LReplace_BxC_0"), "ActMod_a4", 32, 16, Color(255, 255, 255, 255))
                elseif GetConVarNumber(comm) == 1 then
                    draw.SimpleText(aR:T("LReplace_BxC_1"), "ActMod_a4", 32, 16, Color(255, 255, 255, 255))
                elseif GetConVarNumber(comm) == 2 then
                    draw.SimpleText(aR:T("LReplace_BxC_2"), "ActMod_a4", 32, 16, Color(255, 255, 255, 255))
                elseif GetConVarNumber(comm) == 3 then
                    draw.SimpleText(aR:T("LReplace_BxC_3"), "ActMod_a4", 32, 16, Color(255, 255, 255, 255))
                end
            end
        end

        local rs = vgui.Create("DPanel", rh)
        rs:SetPos(1, 0)

        if ShIc == "SCamV" then
            rs:SetSize(29, 30)
        else
            rs:SetSize(25, 25)
        end

        rs:SetText("")
        rs:SetAlpha(255)

        rs.Paint = function(s, w, h)
            surface.SetDrawColor(color_white)

            if ShIc == "SCamV" then
                surface.SetMaterial(Material("icon16/camera.png", "noclamp smooth"))
            else
                if GetConVarNumber(comm) == 0 and comm_1 then
                    surface.SetMaterial(Material(ic_1, "noclamp smooth"))
                elseif GetConVarNumber(comm) == 1 then
                    surface.SetMaterial(Material(ic_2, "noclamp smooth"))
                elseif GetConVarNumber(comm) == 2 then
                    surface.SetMaterial(Material(ic_3, "noclamp smooth"))
                elseif GetConVarNumber(comm) == 3 and comm_4 then
                    surface.SetMaterial(Material(ic_4, "noclamp smooth"))
                elseif GetConVarNumber(comm) == 4 then
                    surface.SetMaterial(Material("icon16/bullet_black.png", "noclamp smooth"))
                elseif GetConVarNumber(comm) == 5 then
                    surface.SetMaterial(Material("icon16/collision_on.png", "noclamp smooth"))
                end
            end

            surface.DrawTexturedRect(0, 0, w, h)
        end

        if ShIc == "SCamV" then
            local DButt = vgui.Create("DButton", rs)
            DButt:SetPos(0, 0)
            DButt:SetSize(rs:GetWide(), rs:GetTall())
            DButt:SetText("")
            DButt.Paint = function(ss, w, h)
                if IsValid(ss.aar) then
                    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
                    surface.SetDrawColor(color_white)
                    surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
                    surface.DrawTexturedRect(0, 0, w, h)
                end
            end
            DButt.OClick = false
            DButt.DoClick = function(ss)
                if IsValid(ss.aar) then
                    ss.aar:Remove()
                    ss.OClick = false
                else
                    ss.OClick = true
                    ss.aar = vgui.Create("DPanel", rh)
                    ss.aar:SetPos(rs:GetWide(), 0)
                    ss.aar:SetText("")
                    ss.aar:SetSize(rh:GetWide() - ss.aar:GetWide() / 2 + 4, rh:GetTall())
                    ss.aar.Paint = function(s, w, h)
                        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
                    end

                    local CBox = vgui.Create("DCheckBoxLabel", ss.aar)
                    CBox:SetPos(2, 2)
                    CBox:SetText("SmoothCam")
					CBox:SetTextColor( Color(255,255,255) )
                    CBox:SetSize(ss.aar:GetWide() - 5, 10)
                    CBox:SetConVar("actmod_cl_smshcam_on")
					
                    local DCBox = vgui.Create("DNumSlider", ss.aar)
                    DCBox:SetPos(-80, 15)
                    DCBox:SetSize(ss.aar:GetWide() + 107, 15)
                    DCBox:SetText("")
                    DCBox:SetMin(1)
                    DCBox:SetMax(10)
                    DCBox:SetDecimals(0)
                    DCBox:SetConVar("actmod_cl_smshcam_sp")
                    DCBox.Paint = function(s, w, h)
                        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 255, 150))
                    end
                end
            end
        end

        local DButton = vgui.Create("DComboBox", rh)
        DButton:SetPos(cPos, dPos)
        DButton:SetSize(cSize, dSize)

		if not self.Underlay.TDComboBox then self.Underlay.TDComboBox = {} end
		if ShIc then self.Underlay.TDComboBox[ShIc] = DButton else self.Underlay.TDComboBox["noneShIc"] = DButton end
        if ShIc == "ShowCh" then
            if GetConVarNumber(comm) == 0 then
                DButton:SetText(aR:T("LReplace_BxSh_0"))
            elseif GetConVarNumber(comm) == 1 then
                DButton:SetText(aR:T("LReplace_BxSh_1"))
            elseif GetConVarNumber(comm) == 2 then
                DButton:SetText(aR:T("LReplace_BxSh_2"))
            end
        else
            DButton:SetText(TextN)
        end

        if comm_1 then DButton:AddChoice(comm_1, 0, false, ic_1) end
        if comm_2 then DButton:AddChoice(comm_2, 1, false, (ShIc == "SEmote" and "actmod/imenu/16imll1_1.png") or ic_2) end
        if comm_3 then DButton:AddChoice(comm_3, 2, false, ic_3) end
        if comm_4 then DButton:AddChoice(comm_4, 3, false, ic_4) end

        if ShIc == "CommTh" then
            DButton:AddChoice(aR:T("LReplace_MF04"), 4, false, "icon16/bullet_black.png")
            DButton:AddChoice(aR:T("LReplace_MF05"), 5, false, "icon16/collision_on.png")
        end

        DButton.OnSelect = function(pl, index, value, data)
            ply:ConCommand(comm .. " " .. data .. "\n")
            if ShIc == "ShowCh" then
                if GetConVarNumber(comm) == 0 then
                    DButton:SetText(aR:T("LReplace_BxSh_0"))
                elseif GetConVarNumber(comm) == 1 then
                    DButton:SetText(aR:T("LReplace_BxSh_1"))
                elseif GetConVarNumber(comm) == 2 then
                    DButton:SetText(aR:T("LReplace_BxSh_2"))
                end
                timer.Simple(0.1, function()
                    if IsValid(self.Frame) then
                        if GetConVarNumber(comm) == 0 then
                            DButton:SetText(aR:T("LReplace_BxSh_0"))
                        elseif GetConVarNumber(comm) == 1 then
                            DButton:SetText(aR:T("LReplace_BxSh_1"))
                        elseif GetConVarNumber(comm) == 2 then
                            DButton:SetText(aR:T("LReplace_BxSh_2"))
                        end
                    end
                end)
            elseif ShIc == "CTheme" then
                DButton:SetText(aR:T("LReplace_BxCTh"))
                if IsValid(self.Underlay) and ThemeN ~= data then
					if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
					self.Underlay:Remove()
                    timer.Simple(0.1, function()
                        if IsValid(self.Frame) and not IsValid(self.Underlay) then
                            self:Replace(self.Underlay.Slot)
                        end
                    end)
                end
            elseif ShIc == "SEmote" then
                DButton:SetText(aR:T("LReplace_BxSEm"))
                if IsValid(self.Underlay) and TmpB ~= data then
					if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
                    self.Underlay:Remove()
                    if IsValid(self.Frame) then self.Frame:Remove() end
                    self:Close("nOw")
                end
            else
                DButton:SetText(TextN)
            end
        end
    end

    local function Wnds_CheckBox1(aPos, bPos, aSize, bSize, cPos, dPos, cSize, dSize, TextN, comm, ic_1, ic_2, commsv, ic_3)
        local rh = vgui.Create("DPanel", Panel)
        rh:SetPos(aPos, Panel:GetTall() - (bPos + Thh))
        rh:SetSize(aSize, bSize)
        rh:SetText("")
        rh:SetAlpha(255)
        rh.Paint = function(s, w, h) if ThemeN == 1 then draw.RoundedBox(0, 0, 0, w, h, Color(40, 60, 80, 255)) end end

        local rs = vgui.Create("DPanel", rh)
        rs:SetPos(1, 0)
        rs:SetSize(cSize, dSize)
        rs:SetText("")
        rs:SetAlpha(255)
        rs.Paint = function(s, w, h)
            surface.SetDrawColor(color_white)
            if commsv then
                if GetConVarNumber(commsv) == 1 then
					surface.SetMaterial(Material(GetConVarNumber(comm) == 1 and ic_2 or ic_1, "noclamp smooth"))
                else
                    surface.SetMaterial(Material(ic_3, "noclamp smooth"))
                end
            else
				surface.SetMaterial(Material(GetConVarNumber(comm) == 1 and ic_2 or ic_1, "noclamp smooth"))
            end
            surface.DrawTexturedRect(0, 0, w, h)
        end
		
		local ttxtN,ttxtNh
		if istable(TextN) then
			ttxtN = TextN[1]
			ttxtNh = TextN[2]
		else ttxtN = TextN
		end

        local DButton = vgui.Create("DCheckBoxLabel", rh)
        DButton:SetPos(cPos, dPos)
        DButton:SetText(ttxtN) DButton:SetTextColor( Color(255,255,255) )
        DButton:SetConVar(comm)
        DButton:SizeToContents()
		if istable(TextN) then
			local rs = vgui.Create("DLabel", DButton)
			rs:SetText("") rs:SetPos(0,0) rs:SetAlpha(0)
			rs:SetSize(DButton:GetSize())
			local qw,qh = DButton:GetSize()
			rs.Think = function(p,w,h) if ttxtNh then CTxtMos(p,A_AM.ActMod:IsMouseInPanel(p,-4,-4,qw+8,qh+8),{100, 100, 100, 160},ttxtNh,"CreditsText",2) end end
		end
    end

	if not self.Underlay.Dled then
		Wnds_ComboBox3(145, 28, 145, 25, 30, -0.1, 110, 25, nil, "actmod_cl_loop", aR:T("LReplace_BxSh_00"), aR:T("LReplace_BxSh_01"), aR:T("LReplace_BxSh_02"), nil, "icon16/control_stop_blue.png", "icon16/control_repeat_blue.png", "icon16/control_equalizer_blue.png", nil, "ShowCh")
		if GetConVarNumber("actmod_cl_sortemote") == 1 then
			Wnds_ComboBox3(465, 28, 125, 25, 30, -0.1, 90, 25, aR:T("LReplace_txt_MFormat"), "actmod_cl_menuformat", aR:T("LReplace_MF0"), aR:T("LReplace_MF1"), aR:T("LReplace_MF2"), nil, "icon16/collision_off.png", "icon16/pencil.png", "actmod/imenu/isk1_1.png")
		elseif GetConVarNumber("actmod_cl_sortemote") >= 2 then
			Wnds_ComboBox3(465, 28, 125, 25, 30, -0.1, 90, 25, aR:T("LReplace_txt_MFormat"), "actmod_cl_menuformat2", aR:T("LReplace_MF0"), aR:T("LReplace_MF01"), aR:T("LReplace_MF02"), aR:T("LReplace_MF03"), "icon16/collision_off.png", "icon16/bullet_blue.png", "icon16/bullet_red.png", "icon16/bullet_purple.png", "CommTh")
		end
		if not self.Underlay.TDComboBox then self.Underlay.TDComboBox = {} end
		self.Underlay.TDComboBox["CThemev2"] = vgui.Create("DComboBox", Panel2)
		local DBuCh = self.Underlay.TDComboBox["CThemev2"]
		DBuCh:SetPos(5, 5)
		DBuCh:SetSize(120, 25)
		DBuCh:Clear()
		DBuCh:SetSortItems( false )
		DBuCh:SetText(aR:T("LReplace_BxCTh"))
		DBuCh:AddChoice(aR:T("LReplace_BxCTh1"), 1, false, GetConVarNumber("actmod_cl_thememenu") == 1 and "icon16/arrow_right.png")
		DBuCh:AddChoice(aR:T("LReplace_BxCTh2"), 2, false, GetConVarNumber("actmod_cl_thememenu") == 2 and "icon16/arrow_right.png" )
		DBuCh.OnSelect = function(pl, index, value, data)
			if GetConVarNumber("actmod_cl_thememenu") ~= data then
				surface.PlaySound("actmod/s/button15.mp3")
				ply:ConCommand("actmod_cl_thememenu " .. data .. "\n")
				DBuCh:SetText(aR:T("LReplace_BxCTh"))
                if IsValid(self.Underlay) then
					if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
					self.Underlay:Remove()
                    timer.Simple(0.1, function()
                        if IsValid(self.Frame) and not IsValid(self.Underlay) then
                            self:Replace(self.Underlay.Slot)
                        end
                    end)
                end
			end
		end
	end

    local Scroll = vgui.Create("AM4_DScrollPanel", Panel)
    Scroll:SetPos(10, 50)
	if self.Underlay.Dled then
		Scroll:SetSize(Panel:GetWide() - 20, Panel:GetTall() - (55 + Thh))
	else
		Scroll:SetSize(Panel:GetWide() - 20, Panel:GetTall() - (80 + Thh))
	end
	
    local a_i_am4 = Material("actmod/imenu/i_am4.jpg", "noclamp smooth")
    local a_i_gmod = Material("actmod/imenu/i_gmod.jpg", "noclamp smooth")
    local a_i_gmod2 = Material("actmod/imenu/i_gmod2.png", "noclamp smooth")
    local a_i_f = Material("actmod/imenu/i_fortnite.jpg", "noclamp smooth")
    local a_i_f2 = Material("actmod/imenu/i_fortnite2.jpg", "noclamp smooth")
    local a_i_f2_2 = Material("actmod/imenu/i_fortnite2_1.png", "noclamp smooth")
    local a_i_mmd = Material("actmod/imenu/i_mmd3.jpg", "noclamp smooth")
    local a_i_mmd2 = Material("actmod/imenu/i_mmd2.png", "noclamp smooth")
    local a_i_mmd_0 = Material("actmod/imenu/i_bmku00.jpg", "noclamp smooth")
    local a_i_mmd_1 = Material("actmod/imenu/i_bmku01.png", "noclamp smooth")
    local a_i_mmd_2 = Material("actmod/imenu/i_bmku01_2.png", "noclamp smooth")
    local a_i_tf2 = Material("actmod/imenu/i_team_fortress2.jpg", "noclamp smooth")
    local a_i_mimx = Material("actmod/imenu/i_mixamo.jpg", "noclamp smooth")
    local a_i_pubg = Material("actmod/imenu/i_pubg.jpg", "noclamp smooth")
    local a_i_feud = Material("actmod/imenu/i_featured.jpg", "noclamp smooth")
    local a_i_find = Material("icon16/shading.png", "noclamp smooth")
    local a_i_srsh = Material("actmod/imenu/i_srsh.jpg", "noclamp smooth")
    local a_i_cu = Material("actmod/imenu/i_cu.jpg", "noclamp smooth")
    local a_i_disc = Material("widgets/disc.png", "noclamp smooth")
    local a_i_b01 = Material("actmod/imenu/i_b01.jpg", "noclamp smooth")
    local a_i_b01_ef01 = Material("actmod/eff_particle/p_i_ligtstar_04", "noclamp smooth")
    local a_m_nw = Material("icon16/new.png", "noclamp smooth")
    local a_m_lck = Material("icon16/lock.png", "noclamp smooth")
    local a_m_ftd =  Material("actmod/imenu/is_featured.png", "noclamp smooth")
	local matbckd = Material("materials/actmod/imenu/iblocked_01.png", "noclamp smooth")
	
    Scroll.Paint = function(s, w, h)
        if GetConVarNumber("actmod_cl_background") == 1 then
			local IMeun_Num = A_AM.ActMod.clo_IMeun_Num
            if IMeun_Num > 0 then
                surface.SetDrawColor(color_white)

                if IMeun_Num == 1 then
                    surface.SetMaterial(ThemeN == 1 and a_i_gmod or a_i_gmod2) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 2 or IMeun_Num == 7 then
                    surface.SetMaterial(a_i_f) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 4 then
                    surface.SetMaterial(a_i_mmd) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 5 then
                    surface.SetMaterial(a_i_am4) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 6 then
                    surface.SetMaterial(a_i_mmd2) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 8 then
                    surface.SetMaterial(a_i_tf2) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 10 then
                    surface.SetMaterial(a_i_mimx) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 11 then
                    surface.SetMaterial(a_i_pubg) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 20 then
                    surface.SetMaterial(a_i_feud) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 30 then
                    surface.SetMaterial(a_i_find) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 15 then
                    surface.SetMaterial(a_i_srsh) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 41 then
                    surface.SetMaterial(a_i_f2) surface.DrawTexturedRect(0, 0, w, h)
					surface.SetDrawColor(Color(255,255,255,math.Clamp(-100+355*math.sin(CurTime()*3),0,255)))
                    surface.SetMaterial(a_i_f2_2) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num == 42 then
                    surface.SetMaterial(a_i_mmd_0) surface.DrawTexturedRect(0, 0, w, h)
					local t = (CurTime()*0.5)%1
					local tAa = math.Clamp( -1+2*t ,0,1 )
					local tAL = SimplePulse(t,1)
					local ap_s,ap_x,ap_z = h*0.75 ,w*0.5-(h*0.75)*0.5 ,h*0.13
					surface.SetDrawColor(Color(255*math.min(tAa*2,1),255,255,255*tAL))
                    surface.SetMaterial(a_i_mmd_2) surface.DrawTexturedRect(ap_x-2-10*tAa,ap_z-2-10*tAa, ap_s+4+20*tAa, ap_s+4+20*tAa)
					surface.SetDrawColor(Color(255,255,255,255))
                    surface.SetMaterial(a_i_mmd_1) surface.DrawTexturedRect(ap_x,ap_z, ap_s, ap_s)
                elseif IMeun_Num == 43 then
                    surface.SetMaterial(a_i_b01) surface.DrawTexturedRect(0, 0, w, h)
					surface.SetDrawColor(Color(255,255,255,130))
					surface.SetMaterial(a_i_b01_ef01)
					surface.DrawTexturedRectRotated(w*0.55, h*0.15, h*0.7, h*0.7, (CurTime()*10)%360)
                elseif IMeun_Num >= 50 and IMeun_Num < 60 then
                    surface.SetMaterial(a_i_cu) surface.DrawTexturedRect(0, 0, w, h)
                elseif IMeun_Num > 60 then
					local att = A_AM.ActMod.TDCustom[RoundDT(IMeun_Num)]
					if att and att.b and isstring(att.b[IMeun_Num+1]) then
						surface.SetMaterial(Material(att.b[IMeun_Num+1], "noclamp smooth"))
					else
						surface.SetMaterial(a_i_cu)
					end
                    surface.DrawTexturedRect(0, 0, w, h)
                else
                    surface.SetMaterial(a_i_disc) surface.DrawTexturedRect(0, 0, w, h)
                end
            end

            if IMeun_Num == 1 or IMeun_Num == 41 or IMeun_Num == 43 or IMeun_Num == 42 then
                draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 20, 180))
            elseif IMeun_Num == 2 or IMeun_Num == 7 then
                draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 20, 200))
            elseif IMeun_Num == 4 or IMeun_Num == 7 or IMeun_Num == 30 then
                draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 20, 170))
            elseif IMeun_Num == 5 or IMeun_Num == 20 then
                draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 40, 180))
            elseif IMeun_Num == 10 or IMeun_Num == 11 or IMeun_Num == 6 or IMeun_Num == 15 or (IMeun_Num >= 50 and IMeun_Num < 60) then
                draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100))
			elseif IMeun_Num > 60 then
				local att = A_AM.ActMod.TDCustom[RoundDT(IMeun_Num)]
				if att and att.c and istable(att.c[IMeun_Num+1]) then
					draw.RoundedBox(0, 0, 0, w, h, att.c[IMeun_Num+1])
				else
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 120))
				end
            end
        end
		if self.Underlay.Finding and self.Underlay.Finding == true then
			draw.SimpleText(". . . . .", "CloseCaption_Bold", w / 2, h / 2, color_white, 1, 1)
		end
    end
    local b = Scroll:GetVBar()
    function b.btnUp:Paint(w, h) draw.RoundedBox(w/2, 0, 0, w, h, Color(150, 150, 250, 150)) end
    function b.btnDown:Paint(w, h) draw.RoundedBox(w/2, 0, 0, w, h, Color(150, 150, 250, 150)) end
    function b:Paint(w, h) draw.RoundedBox(0, w / 2 - 2, 0, 5, h, Color(50, 50, 50, 100)) end
    function b.btnGrip:Paint(w, h) draw.RoundedBox(4, w / 2 - 4, 0, 8, h, b.btnGrip.Depressed and Color(150, 255, 255, 255) or b.btnGrip:IsHovered() and Color(100, 200, 255, 255) or b:IsHovered() and Color(100, 200, 255, 255) or Color(100, 150, 255, 255)) end

    List = vgui.Create("DIconLayout", Scroll)
    List:SetPos(0, 0)
    List:SetSize(Scroll:GetWide(), Scroll:GetTall())
    List:SetSpaceY(self.ScaleIconsDEG / 4)
    List:SetSpaceX(self.ScaleIconsDEG / 4)
    List.TScroll = b
	
	timer.Simple(0.4, function() if IsValid(List) then ScrTIx(List, 2, self.ScaleIconsDEG / 4, List:GetBorder()) end end)

    local function AS(gg)
        surface.PlaySound("actmod/s/lock.mp3")

        if IsValid(gg.trh) then gg.trh:Remove() end

        gg.trh = vgui.Create("DLabel", gg)
        gg.trh:SetSize(self.ScaleIconsDEG, self.ScaleIconsDEG)
        gg.trh:SetPos(0, 0)
        gg.trh:SetText("")
        gg.trh:SetAlpha(255)
        gg.trh:AlphaTo(0, 0.5, 0.6, function(s)
            if IsValid(gg.trh) then gg.trh:Remove() end
        end)

        gg.trh.Paint = function(s, w, h)
            draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(100, 50, 10, 255))
            draw.SimpleText(aR:T("LReplace_txt_Lock"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    local function MakeButton(Name)
        local ListItem = List:Add("DButton")
        table.insert(Buttons, ListItem)
        ListItem:SetSize(self.ScaleIconsDEG, self.ScaleIconsDEG)
        ListItem:SetText("")
        ListItem.file = Name
		ListItem.tkkl = 0
		ListItem.tkklMax = 600
		ListItem.Material = Material(A_AM.ActMod:RIPng(Name), "noclamp smooth")
		ListItem.isNeew = GActNewV(ReString(Name)) and A_AM.ActMod:ATabData(A_AM.ActMod.cl_TmpDatanew, ReString(Name)) == false
		ListItem.ReName = A_AM.ActMod:ReNameAct(ReString(Name))
		ListItem.txtwa = A_AM.ActMod.aGetTextSize(ListItem.ReName,"CreditsOutroText")
		
        local shv = ReString(Name)
		local IsBLocd = A_AM.ActMod:IsDanceBlacklisted(Name)
		local vt = "amod_cumact_".. shv
        local GTabActO = A_AM.ActMod.GTabActO[shv]
        local GTabActO_CTA = A_AM.ActMod.GTabActO[vt]
		ListItem.isG = (GTabActO_CTA and isnumber(GTabActO_CTA["NoStop"]) and GTabActO_CTA["NoStop"] == 63) or (GTabActO and isnumber(GTabActO["NoStop"]) and GTabActO["NoStop"] == 63)
		if IsBLocd and not ListItem.SCurr then ListItem.SCurr = true ListItem:SetCursor("arrow") end

        ListItem.DoRightClick = function(s)
            if IsValid(self.Underlay.Cmenu) then self.Underlay.Cmenu:Remove() end
			local ATData = {}
			local ATDataNew = A_AM.ActMod:LoadEmts("savefvit",{"Actojifavo"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
			if ATDataNew and istable(ATDataNew) then ATData = ATDataNew end
			self.Underlay.Cmenu = DermaMenu()
			if not IsBLocd then
				self.Underlay.Cmenu:AddOption( "---->", function()
					if IsBLocd or not Name then return end
					if A_AM.ActMod:GetReadyFUse(ply) ~= true or not A_AM.ActMod:aIsRdy(ply) then return end
					if hook.Call("ActMod_CantSCAct",nil,ply,"StartAct---->") == true then return end
					if GetConVar("actmod_sv_avs"):GetInt() > 0 and A_AM.ActMod:LokTabData(LocalPlayer(), A_AM.ActMod.ActLck, ReString(Name)) == true then
						surface.PlaySound("actmod/s/lock.mp3")
						if IsValid(List.txh) then List.txh:Remove() end
						List.txh = vgui.Create("DLabel", ListItem)
						List.txh:SetSize(ListItem:GetWide(), ListItem:GetTall())
						List.txh:SetPos(0, 0)
						List.txh:SetText("")
						List.txh:SetAlpha(255)
						List.txh:AlphaTo(0, 0.6, 0.2, function()
							if IsValid(List.txh) then
								List.txh:Remove()
							end
						end)
						List.txh.Paint = function(s, w, h)
							draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(100, 50, 10, 255))
							draw.SimpleText(aR:T("LReplace_txt_Lock"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						end
					else
						ply.ActMod_TimMenRe = CurTime() + 0.5
						ply:SetNWString("A_ActMod_cl_actLoop", Name)
						local cl_s,cl_e,cl_l,cl_y = "0","0","0","0"
						if GetConVarNumber("actmod_cl_sound") == 1 then
							ply:SetNWBool("A_ActMod_cl_Sound", true) cl_s = "1"
						else
							ply:SetNWBool("A_ActMod_cl_Sound", false)
						end
						if GetConVarNumber("actmod_cl_effects") == 1 then
							ply:SetNWBool("A_ActMod_cl_Effects", true) cl_e = "1"
						else
							ply:SetNWBool("A_ActMod_cl_Effects", false)
						end
						if GetConVarNumber("actmod_cl_loop") == 1 then
							ply:SetNWInt("A_ActMod_cl_Loop", 1) cl_l = "1"
						elseif GetConVarNumber("actmod_cl_loop") == 2 then
							ply:SetNWInt("A_ActMod_cl_Loop", 2) cl_l = "2"
						else
							ply:SetNWInt("A_ActMod_cl_Loop", 0)
						end
						if GetConVarNumber("actmod_cl_asyn") == 1 then cl_y = "1" end
						A_AM.ActMod:CStart_cl(Name,string.format("%s %s %s %s",cl_s,cl_e,cl_l,cl_y))
					end
				end ):SetIcon( "icon16/bullet_go.png" )
			end
			self.Underlay.Cmenu:AddOption( aR:T("LReplace_txt_CopyName"), function() SetClipboardText(ListItem.ReName) aShowCopy(s) end ):SetIcon( "icon16/page_copy.png" )
            if input.IsMouseDown(MOUSE_LEFT) then
				self.Underlay.Cmenu:AddOption( "name_act", function() SetClipboardText(ReString(Name)) aShowCopy(s) end ):SetIcon( "icon16/page_copy.png" )
			end
			self.Underlay.Cmenu:AddSpacer()
			if ATData and A_AM.ActMod:ATabData(ATData, s.file) == true then
				self.Underlay.Cmenu:AddOption( aR:T("LReplace_txt_RemfF"), function()
					A_AM.ActMod:RemveFvite(s.file)
					if A_AM.ActMod.clo_IMeun_Num == 20 then
						if IsValid(List) then List:Remove() end
						Buttons = {}
						List = vgui.Create("DIconLayout", Scroll)
						List:SetPos(0, 0)
						List:SetSize(Scroll:GetWide(), Scroll:GetTall())
						List:SetSpaceY(self.ScaleIconsDEG / 4)
						List:SetSpaceX(self.ScaleIconsDEG / 4)
						self.Underlay.Spawnacti()
					end
				end ):SetIcon( "icon16/drive_delete.png" )
			else
				self.Underlay.Cmenu:AddOption( aR:T("LReplace_txt_AddF"), function()
					A_AM.ActMod:AddToFvite(s.file)
				end ):SetIcon( "icon16/drive_disk.png" )
			end
			self.Underlay.Cmenu:AddSpacer()
			self.Underlay.Cmenu:AddOption( " (i)   ".. aR:T("LGPly_tinfo"), function() A_AM.ActMod:ListGInfoAct(Name) end ):SetIcon( "icon16/information.png" )
			self.Underlay.Cmenu:Open()
        end
		
        if GetConVar("actmod_sv_avs"):GetInt() > 0 and not ava and A_AM.ActMod:LokTabData(ply, A_AM.ActMod.ActLck, ReString(ListItem.file)) == true then
            ListItem.GLok = true ListItem.GLokC = 100 else ListItem.GLok = false ListItem.GLokC = 0
        end

        ListItem.DoClick = function(s)
            if s.GLok == true then AS(s) return end
			if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
			local tn = ReString(s.file)
			local aNSlot = self.Underlay.Slot
            if aNSlot == 1001 and isS and self.Underlay.Dled then
                isS.str = s.file
                if IsValid(self.Underlay) then self.Underlay:SetVisible(false) end
            elseif aNSlot == 1002 and self.Underlay.Dled then
				if self.Underlay.callback then self.Underlay.callback(s.file) end
				self.Underlay.callback = nil
                if IsValid(self.Underlay) then self.Underlay:SetVisible(false) end
            else
                if self.table[aNSlot] then
					local AMl = A_AM.ActMod:RIPng(s.file)
					if s.file and AMl ~= "" and not Material(AMl, "noclamp smooth"):IsError() then
						self.table[aNSlot] = s.file
						A_AM.ActMod:ReAddEmts("savemots",{A_AM.ActMod:ActojTyp(aNSlot),A_AM.ActMod.aNTyp[aNSlot],s.file},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
					end
					if IsValid(self.Underlay) then
						self.Underlay:SetVisible(false)
						A_AM.ActMod:RefshEmot(aNSlot)
					end
                else
                    if IsValid(self.Underlay) then self.Underlay:SetVisible(false) end
                end
            end
            if not table.HasValue(A_AM.ActMod.cl_TmpDatanew, tn) and GActNewV(tn) then
                table.insert(A_AM.ActMod.cl_TmpDatanew, tn)
				A_AM.ActMod:ReAddEmts("saveenew",{"ActojiDNew1",tn},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
            end
        end

        ListItem.amov1 = 0
        ListItem.amov2 = 0

        ListItem.Paint = function(s, w, h)
            if not s.Material then return end
			local aRFT,CTe = RealFrameTime(),CurTime()
            if s:IsHovered() then
				if s.noR then
					if (s.ntimr or 0) < CTe then s.tkkl = math.max(s.tkkl - aRFT * 500,0) end
				else
					s.tkkl = math.min(s.tkkl + aRFT * 500,s.tkklMax)
					s.ntimr = CTe + 0.3
				end
			end
            if s:IsHovered() then
                if s:IsDown() then
                    s.amov2 = math.Round(Lerp(19 * aRFT, s.amov2+0.001, h / 2),3)
                else
                    s.amov2 = math.Round(Lerp(15 * aRFT, s.amov2-0.001, 0),3)
                end
                s.amov1 = math.Round(Lerp(15 * aRFT, s.amov1+0.001, 100),3)
            else
                s.amov1 = math.Round(Lerp(14 * aRFT, s.amov1-0.001, 0),3)
                s.amov2 = math.Round(Lerp(16 * aRFT, s.amov2-0.001, 0),3)
            end
            if s.amov1 > 0 then
				local aa = math.Clamp((s.tkkl*1.5-s.tkklMax*0.8)/255,0,1)
				local atat = math.Clamp((-50+(s.amov1*3.2))/255,0,1)
				draw.RoundedBox(6, 0, 0, w, h, Color(s.GLokC * 2, 250 - s.GLokC, 120 - s.GLokC + 100 * s.amov2 / 50, 100*atat))
				draw.RoundedBox(6, 0, h - (8+s.amov2) - (h*0.1)*atat, w, (8+s.amov2)+(h*0.1)*atat, Color(150 + s.GLokC, 215 - s.GLokC, 255 - s.GLokC * 2, 200*atat))
				if aa == 1 then
					draw.RoundedBox(w / 16, 5, 5, w-10, h-10, Color(60,70,80,255))
					surface.SetDrawColor(Color(140,200,255,255))
					surface.SetMaterial(Material("gui/gradient_up", "noclamp smooth"))
					surface.DrawTexturedRect(5, 5, w - 10, h - 10)
				else
					draw.RoundedBox(w / 16, 5, 5, w-10, h-10, Color(60,70,80,255*aa))
					surface.SetDrawColor(Color(140,200,220,math.Clamp(s.tkkl*2-s.tkklMax*0.9,0,255)))
					surface.SetMaterial(Material("gui/gradient_up", "noclamp smooth"))
					surface.DrawTexturedRect(5, 6+(h-10)*(1-aa), w - 10, (h - 10)*aa)
				end
			end
            if s.isNeew and not s:IsHovered() then
				draw.RoundedBox(w / 2, 0, 0, w, h, Color(255, 255, 0, math.max(15 + (25 * math.sin(CTe * 8)), 0)))
            end
			local aalp = math.Clamp(s.tkklMax-s.tkkl,0,255)
            surface.SetDrawColor(Color(255,255,255,aalp))
			if not s.t22 or s.noR then
				if s.isG then
					local hw,AlpBse = self.ScaleIconsDEG*0.6,170
					local lw,lh,ca = math.min(hw+AlpBse*0.3,w),math.min(hw+AlpBse*0.3,h-10),math.max(math.min((AlpBse*2-300)*1.25,255),0)
					local cw,ch,zw,zh = w/2-lw/2,h/2-5-lw/2, lw,lh
					local Aclor = math.Clamp( 1+1.2*math.sin(CTe*4) ,0.4,1 )
					surface.SetDrawColor(255, 255, 255, aalp)
					surface.SetMaterial(s.Material)
					surface.DrawTexturedRect(cw+3,ch+3,zw-6,zh-6)
					surface.SetDrawColor(255, 255, 255, aalp*Aclor)
					surface.SetMaterial(Material("actmod/imenu/ic_g.png", "noclamp smooth"))
					surface.DrawTexturedRect(cw+3,zh/2,zw-6,zh/2-2)
				else
					surface.SetMaterial(s.Material)
					if s:IsHovered() then surface.DrawTexturedRect(2, 2, w-4, h-4) else surface.DrawTexturedRect(5, 5, w - 10, h - 10) end
				end
			end
			if IsBLocd then
				local aw = h*0.6
				local Aclor = math.Clamp( 1+1.2*math.sin(CTe*4) ,0.2,0.7 )
				surface.SetDrawColor(255, 255, 255, aalp*Aclor)
				surface.SetMaterial(matbckd)
				surface.DrawTexturedRect(w/2-aw/2,h/2-aw/2,aw,aw)
			end

            if s.GLok == true then
				surface.SetDrawColor(Color(255, 255, 255, s:IsHovered() and 140 or 55))
                local acw = math.max(0, math.min(30, 30 + (30 * math.sin(CTe * 3))))
                surface.SetMaterial(a_m_lck)
                surface.DrawTexturedRect(20 + acw / 2, 20 + acw / 2, h - 40 - acw, h - 40 - acw)
            end

            if s.isNeew then
                surface.SetDrawColor(Color(255, 255, 255, math.max(150 + (100 * math.sin(CTe * 7)), 0)))
                surface.SetMaterial(a_m_nw)
                surface.DrawTexturedRect(0, -3 + (3 * math.sin(CTe * 3)), 20, 20)
            end
            surface.SetDrawColor(Color(255,255,255,math.Clamp(s.tkklMax-s.tkkl,0,255)))
            if s.aFrvl then
                surface.SetMaterial(a_m_ftd)
				surface.DrawTexturedRect(w-20, 0, 20, 20)
            end
			
			local aa = math.Clamp( (aalp*3) ,0,255)
			local wa = math.min( s.txtwa + 14 ,w)
			draw.RoundedBox(0, w/2-wa/2, h-12,wa,12, s:IsHovered() and Color(0,0,50,aa) or Color(0,0,0,100))
			if s.txtwa > w then
				draw.ScrollingText(s.ReName, "CreditsOutroText", 0, h-7, Color(255,255,255,aa), 0,1 ,w,s,2,Name)
			else
				draw.SimpleText(s.ReName, "CreditsOutroText", w/2, h-7, Color(255,255,255,aa),1,1)
			end
        end

		ListItem.aanu = vgui.Create("DLabel", ListItem)
		ListItem.aanu:SetSize(ListItem:GetWide()-10, ListItem:GetTall()-10)
		ListItem.aanu:SetPos(5, 5)
		ListItem.aanu:SetText("")
		ListItem.aanu:SetAlpha(0)
		ListItem.aFrvl = false
		ListItem.tt = CurTime() + 0.3
		ListItem.Think = function(s)
			if (s.tt or 0) < CurTime() then
				s.tt = CurTime() + 0.8
				ListItem.aanu:SetSize(ListItem:GetWide()-10, ListItem:GetTall()-10)
				if A_AM.ActMod.clo_IMeun_Num ~= 20 and A_AM.ActMod.Actoji.AETData and A_AM.ActMod:ATabData(A_AM.ActMod.Actoji.AETData, Name) == true then
					s.aFrvl = true else s.aFrvl = false
				end
				if GetConVar("actmod_sv_avs"):GetInt() > 0 and not ava and A_AM.ActMod:LokTabData(ply, A_AM.ActMod.ActLck, ReString(s.file)) == true then
					s.GLok = true s.GLokC = 100 else s.GLok = false s.GLokC = 0
				end
				s.isNeew = GActNewV(ReString(s.file)) and A_AM.ActMod:ATabData(A_AM.ActMod.cl_TmpDatanew, ReString(s.file)) == false
				IsBLocd = A_AM.ActMod:IsDanceBlacklisted(Name)
				if IsBLocd and not ListItem.SCurr then ListItem.SCurr = true ListItem:SetCursor("arrow") elseif not IsBLocd and ListItem.SCurr then ListItem.SCurr = false ListItem:SetCursor("hand") end
			end
		end
		
		ListItem.aanu.Paint = function ( ste, w, h )
			if ListItem:IsHovered() then
				if ListItem.modelmenu and IsValid(ListItem.modelmenu) and ListItem.modelmenu:GetEntity() then
					if not ListItem.t22 then
						if ListItem.tkkl >= ListItem.tkklMax then ListItem.t22 = true
							ListItem.modelmenu:SetVisible(true)
							ListItem.modelmenu:ChangePage(Name)
						end
					end
				elseif not ListItem.noR and ListItem.tkkl >= ListItem.tkklMax*0.9 then
					if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
					if string.sub(Name,1,9 ) ~= "amod_cum_" then
						self.Underlay.modelmenu = vgui.Create("AM4_DModelPreview", ListItem.aanu)
						self.Underlay.modelmenu:SetVisible(false)
						local aModelmenu = self.Underlay.modelmenu
						aModelmenu:Dock(FILL)
						aModelmenu.aanu = ListItem.aanu.rh
						local zw, zh = Scroll:GetSize()
						local bx, by = ScrW()/2-zw/2 ,ScrH()/2-zh/2 - 5
						if self.Underlay.Dled then zh = zh + 12.5 end
						aModelmenu.pbase = {bx, by}
						aModelmenu.zbase = {zw, zh}
						aModelmenu.Panelbase = Panel
						aModelmenu.Dled = self.Underlay.Dled
						aModelmenu.OnRemove = function(self)
							if IsValid(self.Entity) then self.Entity:Remove() end
							if IsValid(self.EntityT) then self.EntityT:Remove() end
							if IsValid(aModelmenu.aanu) then aModelmenu.aanu:Remove() ListItem:SetCursor("hand") end
							if IsValid(ListItem) then ListItem:SetCursor("hand") end
							hook.Remove("Think", aModelmenu.LIndex)
							LocalPlayer().ActMod_cl_MisDragging = nil
						end
						ListItem.modelmenu = aModelmenu
						function aModelmenu:ChangePage(ActAnime)
							if not ActAnime then return end
							local ent = aModelmenu:GetEntity()
							if ( !IsValid( ent ) ) then return end
							ent:ResetSequence("idle_all_02")
							ent:SetCycle(0)
							ent:SetPlaybackRate(0)
							ent.GLast = ListItem
							local bx, by = Panel:LocalToScreen( 0, 0 )
							ent.pbase = {bx, by}
							local zw, zh = Panel:GetSize()
							ent.zbase = {zw, zh}
							ent.Panelbase = Panel
							timer.Create("AA_irunAnm",0.5,1,function() if IsValid( ent ) then
								local ve = string.lower(A_AM.ActMod:ReString(ActAnime):gsub("%s+$", ""))
								local vt = "amod_cumact_".. ve
								vt = vt:gsub("%s+$", "")
								if A_AM.ActMod.GTabActO[vt] and A_AM.ActMod.GTabActO[vt]["GetName"] and A_AM.ActMod.GTabActO[vt]["ID_ACT"] and A_AM.ActMod.GTabActO[vt]["ID_ACT"] == ve then
									ActAnime = vt
								end
								local RDW_Snd
								local TTbl = A_AM.ActMod:A_ActMod_GetActString(ActAnime)
								local GAO = istable(A_AM.ActMod.GTabActO) and A_AM.ActMod.GTabActO[TTbl.txt]
								if istable(GAO) and istable(GAO.SndsC_) and isnumber(GAO.SndsC_.n) and GAO.SndsC_.n > 1 then RDW_Snd = math.random(GAO.SndsC_.n) end
								A_AM.ActMod:StartAniAct(ent,{TTbl.txt,RDW_Snd},nil,{"",1,1,2},TTbl.tBl)
							end end)
						end
					end
				end
			elseif not ListItem:IsHovered() and not LocalPlayer().ActMod_cl_MisDragging then
				if ListItem.t22 then ListItem.t22 = false ListItem.noR = nil ListItem.tkkl = 0
					ListItem:SetCursor("hand")
				elseif ListItem.tkkl > 0 then ListItem.tkkl = 0
				end
				if ListItem.modelmenu and IsValid(ListItem.modelmenu) and ListItem.modelmenu:GetEntity() then
					if IsValid(ListItem.modelmenu) then hook.Remove("Think", tostring(ListItem.modelmenu.LIndex)) ListItem.modelmenu:Remove() end
					ListItem.modelmenu = nil
				end
			end
		end
    end

	self.Underlay.Spawnacti = function()
        local Actimenu = {}
        local Yt = A_AM.ActMod.clo_IMeun_Num
		local aatimlst = 0
		if istable(A_AM.ActMod.TimList) and not table.IsEmpty(A_AM.ActMod.TimList) then
			for k, v in pairs(A_AM.ActMod.TimList) do if timer.Exists( v ) then timer.Remove( v ) end end
		end
		A_AM.ActMod.TimList = {}
		A_AM.ActMod.Yt = Yt
		if Yt == 20 then
			local ATDa = {}
			local ATDNew = A_AM.ActMod:LoadEmts("savefvit",{"Actojifavo"},function(t,g) A_AM.ActMod:RCFi(t,g) end)
			if istable(ATDNew) then
				for k, v in pairs(ATDNew) do
					aatimlst = aatimlst+0.01
					v = v:gsub("%s+$", "")
					local vt = ("amod_cumact_".. ReString(v)):gsub("%s+$", "")
					local addnati = "aactmod_timlist_".. tostring(aatimlst)
					timer.Create(addnati,aatimlst,1,function()
						if Panel and IsValid(Panel) and A_AM.ActMod.Yt == Yt and (A_AM.ActMod.GTabActO[ReString(v)] or A_AM.ActMod.GTabActO[vt]) then MakeButton(v) end
						if istable(A_AM.ActMod.TimList) and #A_AM.ActMod.TimList > 1 and k == #A_AM.ActMod.TimList then A_AM.ActMod.TimList = {} end
					end)
					table.insert(A_AM.ActMod.TimList,addnati)
				end
			end
		else
			if Yt > 69 or Yt > 40 and Yt < 60 then
				for ki, v in pairs(file.Find("materials/actmod/cumact/*.png", "GAME")) do
					local ve = v:gsub("%s+$", "")
					local vt = "amod_cumact_".. ReString(v)
					vt = string.lower(vt:gsub("%s+$", ""))
					if not table.HasValue(Actimenu, v) and A_AM.ActMod.GTabActO[vt] and A_AM.ActMod.GTabActO[vt]["class"] and A_AM.ActMod.GTabActO[vt]["class"] == Yt-(Yt > 69 and -1 or Yt > 40 and Yt < 45 and 0 or 49) and A_AM.ActMod.GTabActO[vt]["GetName"] then
						table.insert(Actimenu, string.lower(v))
					end
				end
			else
				for _, v in pairs(file.Find("materials/" .. ASettings["IconsActs"] .. "/*.png", "GAME")) do
					v = string.lower(v)
					local ve = ReString(v)
					if not table.HasValue(Actimenu, v) and A_AM.ActMod.GTabActO[ve] then
						if ( Yt == 1 and A_AM.ActMod:ATabData(A_AM.ActMod.ActGmod, ReString(v)) == true )
						or ( Yt == 5 and (string.sub(v,1,5) == "amod_" or string.sub(v,1,9) == "amod_am4_" or string.sub(v,1,7) == "amod_m_") and string.sub(v,1,10) ~= "amod_pubg_" and string.sub(v,1,12) ~= "amod_mixamo_" and string.sub(v,1,9) ~= "amod_mmd_" and string.sub(v,1,14) ~= "amod_fortnite_" )
						or ( Yt == 11 and string.sub(v,1,10) == "amod_pubg_" )
						or ( Yt == 10 and string.sub(v,1,12) == "amod_mixamo_" )
						or ( Yt == 6 and string.sub(v,1,9) == "amod_mmd_" )
						or ( Yt == 7 and string.sub(v,1,14) == "amod_fortnite_" ) then
							table.insert(Actimenu, v)
						elseif Yt == 15 then
							if A_AM.ActMod.FindIt and istable(A_AM.ActMod.FindIt) then
								Actimenu = A_AM.ActMod.FindIt
							end
						end
					end
				end
			end
			for k, v in pairs(Actimenu or {}) do
				aatimlst = aatimlst+0.01
				local addnati = "aactmod_timlist_".. tostring(aatimlst)
				timer.Create(addnati,aatimlst,1,function()
					if Panel and IsValid(Panel) and A_AM.ActMod.Yt == Yt then MakeButton(v) end
					if A_AM.ActMod.TimList and istable(A_AM.ActMod.TimList) and #A_AM.ActMod.TimList > 1 and k == #A_AM.ActMod.TimList then A_AM.ActMod.TimList = {} end
				end)
				table.insert(A_AM.ActMod.TimList,addnati)
			end
		end
    end

    self.Underlay.Spawnacti()
    self.Underlay.Passq = vgui.Create("DLabel", Panel)
    local Passq = self.Underlay.Passq
    Passq:SetPos(10, 50)
    Passq:SetSize(Scroll:GetWide(), Scroll:GetTall())
    Passq:SetAlpha(0)
    Passq.aNextN = 1
    Passq.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(180, 190, 200, 255))
    end
	Passq.Think = function()
		if (Passq.ttim or 0) < CurTime() and istable(Panel.tablTime) then
			Passq.ttim = CurTime() + 2
			local NTbT = table.Count(Panel.tablTime)
			if Passq.aNextN >= NTbT then
				Passq.aNextN = 1
			else
				Passq.aNextN = Passq.aNextN + 1
			end
		end
    end

    local function Button_NWInt(aPos, bPos, aSize, bSize, iconn, aText, comm, srvr, ARe, inx)
        local SButton = vgui.Create("DButton", Panel)
        SButton:SetText("")
        SButton:SetFont("ActMod_a1") SButton:SetTextColor( Color(255,255,255) )
        SButton:SetAlpha(50)
        SButton:SetPos(aPos, bPos)
        SButton:SetSize(aSize, bSize)
        SButton.tButt = false
        SButton:AlphaTo(255, 0.5)

        timer.Simple((ARe and 0.2) or 0.7, function()
            if IsValid(SButton) then SButton.tButt = true end
        end)

        SButton.Paint = function(self, w, h)
            if A_AM.ActMod.clo_IMeun_Num == srvr then
				draw.RoundedBox(4, 0, 0, w, h, Color(90, 255, 150, 150))
			end
            if SButton:IsHovered() and SButton.tButt == true then
                draw.RoundedBox(4, 0, 0, w, h, Color(100, 100, 250, 155))
            else
                draw.RoundedBox(4, 0, 0, w, h, (ThemeN == 1 and Color(70, 70, 50, 155)) or (ThemeN == 2 and Color(70, 70, 90, 80)) or Color(10, 10, 10, 150))
            end

            draw.SimpleText(aText, "ActMod_a1", 41, h / 2, Color(0, 0, 0), 0, 1)
            draw.SimpleText(aText, "ActMod_a1", 41.5, h / 2 + 0.5, Color(255, 255, 255), 0, 1)
        end

        SButton.Think = function()
            if A_AM.ActMod.clo_IMeun_Num ~= srvr then
                SButton:SetDisabled(false)

                if IsValid(SButton.pk) then
                    SButton.pk:Remove()
                end
            else
                SButton:SetDisabled(true)

                if not IsValid(SButton.pk) then
                    SButton.pk = vgui.Create("DPanel", SButton)
                    SButton.pk:SetAlpha(0)
                    SButton.pk:SetPos(0, 0)
                    SButton.pk:SetSize(SButton:GetWide(), SButton:GetTall())
                end
            end
        end

        SButton.DoClick = function(s)
            if SButton.tButt == true and A_AM.ActMod.clo_IMeun_Num ~= srvr and (self.Underlay.PutMark_TimCRe or 0) < CurTime() then
                self.Underlay.PutMark_TimCRe = CurTime() + 0.3
				A_AM.ActMod.clo_IMeun_Num = srvr
				A_AM.ActMod.clo_IMeun_inx = inx
                if srvr == 1 then
                    surface.PlaySound("garrysmod/ui_click.wav")
                elseif srvr == 2 or srvr == 3 or srvr == 7 or srvr == 9 then
                    surface.PlaySound("actmod/i_menu/Fortnite.mp3")
                elseif srvr == 8 then
                    surface.PlaySound("actmod/i_menu/TF2.mp3")
                elseif srvr == 4 or srvr == 6 then
                    surface.PlaySound("actmod/i_menu/MMD.mp3")
                elseif srvr == 5 then
                    surface.PlaySound("actmod/i_menu/AM4.mp3")
                elseif srvr == 11 then
                    surface.PlaySound("actmod/i_menu/pubg.mp3")
                elseif srvr == 10 then
                    surface.PlaySound("actmod/i_menu/Mixamo.mp3")
                elseif srvr == 30 then
                    surface.PlaySound("actmod/i_menu/AM4.mp3")
                elseif srvr == 20 then
                    surface.PlaySound("garrysmod/save_load3.wav")
                elseif srvr >= 40 and srvr < 50 then
                    surface.PlaySound("actmod/i_menu/dchub.mp3")
                elseif srvr > 60 or srvr >= 50 and srvr < 60 then
                    surface.PlaySound("actmod/i_menu/menu_cu.mp3")
                end

                Passq:SetAlpha(255)
                Passq:AlphaTo(0, 0.2,0.1)

                if IsValid(List) then List:Remove() end
                Buttons = nil
                Buttons = {}
                List = vgui.Create("DIconLayout", Scroll)
                List:SetPos(0, 0)
                List:SetSize(Scroll:GetWide(), Scroll:GetTall())
                List:SetSpaceY(self.ScaleIconsDEG / 4)
                List:SetSpaceX(self.ScaleIconsDEG / 4)
                self.Underlay.Spawnacti()
            end
        end

        local rs = vgui.Create("DLabel", SButton)
        rs:SetPos(1, 0)
        rs:SetSize(40, 40)
        rs:SetText("")
        rs:SetAlpha(255)
        rs.Oinx = inx
        rs.Paint = function(s, w, h)
            surface.SetDrawColor(color_white)
            surface.SetMaterial(Material(iconn, "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        end
		if not Panel.tablTime then Panel.tablTime = {} end
		Panel.tablTime[inx] = rs
        rs.Think = function()
			if not rs.aak or (rs.ttim or 0) < CurTime() and Passq.aNextN == rs.Oinx then
				rs.ttim = CurTime() + 1
				rs.aak = true
				local NTnum = MarkNew_TabDataRn(srvr)
				if NTnum > 0 then
					if IsValid(rs.nw) then
						rs.nw.NTnum = NTnum
					else
						rs.nw = vgui.Create("DLabel", Panel)
						rs.nw:SetPos(aPos + aSize/2, bPos - 10)
						rs.nw:SetSize(20, 20)
						rs.nw:SetText("")
						rs.nw:SetAlpha(0)
						rs.nw:AlphaTo(255, 0.2)
						rs.nw.NTnum = NTnum
						rs.nw.Paint = function(s, w, h)
							local aaa = 100 * math.sin((CurTime()+(srvr*0.3)) * 8)
							draw.RoundedBox(w / 2, 0, 0, w, h, Color(180, 110, math.max(50 + (80 * math.sin(CurTime() * 7)), 0), math.max(150 + aaa, 0)))
							if s.NTnum > 99 then
								draw.SimpleText(s.NTnum, "ActMod_a4", w / 2 - 1, h / 2 - 1, color_white, 1, 1)
								draw.SimpleText(s.NTnum, "ActMod_a4", w / 2, h / 2, Color(80, 255, math.max(150 + aaa, 0)), 1, 1)
							else
								draw.SimpleText(s.NTnum, "ActMod_a3", w / 2 - 1, h / 2 - 1, color_white, 1, 1)
								draw.SimpleText(s.NTnum, "ActMod_a3", w / 2, h / 2, Color(80, 255, math.max(150 + aaa, 0)), 1, 1)
							end
						end
						SButton.OnRemove = function(pan) if IsValid(rs.nw) then rs.nw:Remove() end end
					end
				elseif NTnum == 0 then
					if IsValid(rs.nw) then rs.nw:Remove() end
				end
			end
        end
        return SButton
    end

    local rh = vgui.Create("DPanel", Panel)
    rh:SetPos(10, Panel:GetTall() - (-2 + Thh))
    rh:SetSize(280, 25)
    rh:SetText("")
    rh:SetAlpha(255)
    rh.Paint = function(s, w, h)
        if ThemeN == 1 then
            draw.RoundedBox(0, 0, 0, w, h, Color(40, 60, 80, 255))
        end
        draw.SimpleText(aR:T("LReplace_txt_Search"), "ActMod_a3", 2, 2, Color(255,255,255,255))
    end
	
    local AButxtbar = vgui.Create("DButton", rh)
    AButxtbar:SetPos(62, 2)
    AButxtbar:SetSize(185, 20)
    AButxtbar:SetText("")
    AButxtbar.OnRemove = function()
        if IsValid(self.Aar) then self.Aar:Remove() end
	end
    AButxtbar.Paint = function(pan, ww, hh)
        draw.RoundedBox(5, 0, 0, ww, hh, Color(230, 240, 255, 255))
        draw.SimpleText(GetConVarString("actmod_cl_stext"), "ActMod_a4", 2, hh/2, Color(0, 0, 0, 255),0,1)
    end
    AButxtbar.DoClick = function(s)
        surface.PlaySound("garrysmod/content_downloaded.wav")
        if IsValid(self.Aar) then self.Aar:Remove() end
        if IsValid(self.ButRTxt) then self.ButRTxt:Remove() end
		
		self.ButRTxt = vgui.Create("DButton")
		self.ButRTxt.OnRemove = function(pan)
            if IsValid(self.Aar) then self.Aar:Remove() end
		end
		self.ButRTxt:SetText("")
		self.ButRTxt:SetCursor("arrow")
		self.ButRTxt:SetSize(ScrW(), ScrH())
		self.ButRTxt:SetAlpha(0)
		self.ButRTxt:AlphaTo(255, 0.3)
		self.ButRTxt.DoClick = function(s) if IsValid(self.Aar) then self.Aar:Remove() end end
		self.ButRTxt.OnMouseReleased = function() if IsValid(self.Aar) then self.Aar:Remove() end end
		self.ButRTxt.ttim = CurTime() + 2
		self.ButRTxt.Think = function(S)
			if IsValid(self.Aar) then
				local mouseX, mouseY = gui.MousePos()
				if mouseX == 0 and mouseY == 0 then S.ttim = CurTime() + 1 return end
				local removeDistance = 50
				local x, y = self.Aar:GetPos()
				local w, h = self.Aar:GetSize()
				if mouseX < x - removeDistance or
				   mouseX > x + w + removeDistance or
				   mouseY < y - removeDistance or
				   mouseY > y + h + removeDistance then
					if S.ttim < CurTime() then self.Aar:Remove() end
				else
					S.ttim = CurTime() + 0.5
				end
			elseif S.ttim < CurTime() - 1 then
				if IsValid(S) then S:Remove() end
				if IsValid(self.ButRTxt) then self.ButRTxt:Remove() end
			end
		end
		self.ButRTxt.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150)) end
		self.ButRTxt:MakePopup()
	
        self.Aar = vgui.Create("DFrame")
        self.Aar.OnRemove = function(pan)
            self.OnDfind = nil
            if IsValid(self.ButRTxt) then self.ButRTxt:Remove() end
        end
        self.OnDfind = true
        self.Aar:SetSize(219, 25)
        self.Aar:SetPos(ScrW()/2 -310, ScrH()/2 + Panel:GetTall()/2-28)
        self.Aar:MakePopup() self.Aar:SetTitle("") self.Aar:SetDraggable(false) self.Aar:ShowCloseButton(false)
        self.Aar.Paint = function(pan, w, h) end
		
        local DButton = vgui.Create("DButton", self.Aar)
        DButton:SetPos(self.Aar:GetWide() - 28, 0) DButton:SetSize(28, 25)
        DButton:SetText(aR:T("LReplace_txt_ok")) DButton:SetFont("ActMod_a5")
		DButton:SetTextColor( Color(200,200,0) )
        DButton.DoClick = function(s)
            if IsValid(self.Aar) then self.Aar:Remove() end
        end

        local txtbar = vgui.Create("DTextEntry", self.Aar)
        txtbar:SetPos(0, 0) txtbar:SetSize(188, 25)
        txtbar:SetFont("ActMod_a4") txtbar:SetTextColor( Color(0,0,0,255) )
        txtbar:SetText("") txtbar:SetConVar("actmod_cl_stext")
    end

    self.Underlay.Finding = false
    local DBu = vgui.Create("DButton", rh)
    DBu:SetPos(rh:GetWide() - 26, Gh)
    DBu:SetSize(25, 25)
    DBu:SetText("")
    DBu.Cmo = GCN
    DBu.Paint = function(ste, w, h)
        surface.SetDrawColor(color_white)

        if self.Underlay.Finding == true then
            surface.SetMaterial(Material("icon16/folder_magnify.png", "noclamp smooth"))
        elseif ste:IsDown() then
            surface.SetMaterial(Material("icon16/zoom.png", "noclamp smooth"))
        elseif ste:IsHovered() then
            surface.SetMaterial(Material("icon16/magnifier_zoom_in.png", "noclamp smooth"))
        else
            surface.SetMaterial(Material("icon16/magnifier.png", "noclamp smooth"))
        end

        surface.DrawTexturedRect(0, 0, w, h)
    end

    DBu.DoClick = function(ss)
	 if self.Underlay.Finding == true then return end
        if A_AM.ActMod.clo_IMeun_Num ~= 15 then
            A_AM.ActMod.clo_IMeun_Num = 15
            Passq:SetAlpha(255)
            Passq:AlphaTo(0, 0.2)
        end

        self.Underlay.PutMark_TimCRe = CurTime() + 0.3
        surface.PlaySound("garrysmod/ui_click.wav")

        if IsValid(List) then
            List:Remove()
        end

        Buttons = nil
        Buttons = {}
        List = vgui.Create("DIconLayout", Scroll)
        List:SetPos(0, 0)
        List:SetSize(Scroll:GetWide(), Scroll:GetTall())
        List:SetSpaceY(self.ScaleIconsDEG / 4)
        List:SetSpaceX(self.ScaleIconsDEG / 4)
		A_AM.ActMod.FindIt = {}
		self.Underlay.Finding = true
		timer.Create("AaA_finding",0.01,1,function()
			if IsValid(ply) then
				local gcvs = string.lower(GetConVarString("actmod_cl_stext"))
				gcvs = gcvs:gsub("%s+$", "")
				for _, gv in pairs(file.Find("materials/" .. ASettings["IconsActs"] .. "/*.png", "GAME")) do
					local v = string.format("%s",tostring(string.lower(gv)))
					if not table.HasValue(A_AM.ActMod.FindIt, v) then
						if A_AM.ActMod.clo_IMeun_Num == 15 then
							v = v:gsub("%s+$", "")
							local aE = A_AM.ActMod.tmpE[ ReString(v) ] and table.Copy(A_AM.ActMod.tmpE[ ReString(v) ])
							if aE and aE[1] and aE[2] then
								aE[1] = string.lower(aE[1]) aE[2] = string.lower(aE[2])
								local ytxt = string.lower(A_AM.ActMod:ReNameAct( aE[1] ))
								if sf_txt(aE[1],gcvs) or sf_txt(aE[2],gcvs) or sf_txt(ytxt,gcvs) then
									table.insert(A_AM.ActMod.FindIt, v) continue
								end
							end
							local isGetTbl = A_AM.ActMod.tNamsAct[ A_AM.ActMod:TrgmaNams( v ) ]
							if isGetTbl then
								for gk, gav in pairs( isGetTbl ) do
									local av = string.lower(gav)
									local k = string.lower(gk)
									if string.find(RvString(ReString(v)), k) and A_AM.ActMod:ATabData(A_AM.ActMod.FindIt, v) == false then
										if sf_txt(av,gcvs) then
											table.insert(A_AM.ActMod.FindIt, v) continue
										end
									end
								end
								if string.find(v, gcvs) and A_AM.ActMod:ATabData(A_AM.ActMod.FindIt, v) == false then
									table.insert(A_AM.ActMod.FindIt, v)
								end
							end
						end
					end
				end
				for _, gv in pairs(file.Find("materials/actmod/cumact/*.png", "GAME")) do
					local v = string.format("%s",tostring(string.lower(gv)))
					local vt = "amod_cumact_".. ReString(v)
					if not table.HasValue(A_AM.ActMod.FindIt, v) and A_AM.ActMod.GTabActO[vt] and A_AM.ActMod.GTabActO[vt]["class"] then
						if A_AM.ActMod.clo_IMeun_Num == 15 then
							local vg = v:gsub("%s+$", "")
							local aE = A_AM.ActMod.tmpE[ ReString(vg) ] and table.Copy(A_AM.ActMod.tmpE[ ReString(vg) ])
							if istable(aE) and not table.IsEmpty(aE) and aE[1] and aE[2] then
								aE[1] = string.lower(aE[1]) aE[2] = string.lower(aE[2])
								local ytxt = string.lower(A_AM.ActMod:ReNameAct( aE[1] ))
								if sf_txt(aE[1],gcvs) or sf_txt(aE[2],gcvs) or sf_txt(ytxt,gcvs) then
									table.insert(A_AM.ActMod.FindIt, v)
								end
							end
						end
					end
				end
				for k, v in pairs(A_AM.ActMod.FindIt or {}) do MakeButton(v) end
				if IsValid(ply) and IsValid(self.Underlay) then self.Underlay.Finding = false end
				timer.Create("AaA_finding",0.6,1,function()
					if IsValid(ply) and IsValid(self.Underlay) then
						self.Underlay.Finding = false
					end
				end)
			end
		end)
    end

    Wnds_CheckBox1(295, -2, 165, 25, 30, 5, 25, 25, aR:T("LReplace_BxSModel"), "actmod_cl_background", "icon16/image.png", "icon16/photo.png")

	if not self.Underlay.Dled then
		Wnds_CheckBox1(295, 28, 165, 25, 30, 5, 25, 25, {aR:T("LReplace_ASyn"),aR:T("LReplace_ASyn_hlp")}, "actmod_cl_asyn", "actmod/imenu/ic_sny_off.png", "actmod/imenu/ic_sny_on.png")
		Wnds_ComboBox3(465, -2, 124, 25, 30, -0.1, 90, 25, aR:T("LReplace_BxSEm"), "actmod_cl_sortemote", nil, aR:T("LReplace_MF1"), aR:T("LReplace_MF2_2"), aR:T("LReplace_MF3"), nil, "actmod/imenu/imll1_1.png", "icon16/application_view_tile.png", "icon16/textfield.png", "SEmote")
		Wnds_ComboBox3(594, 3, 158, 30, 30, -0.1, 126, 15, aR:T("LReplace_BxSCView"), "actmod_cl_setcamera", aR:T("LReplace_BxSCView0"), aR:T("LReplace_BxSCView1"), aR:T("LReplace_BxSCView2"), aR:T("LReplace_BxSCView3"), "icon16/page_white_text.png", "icon16/arrow_in.png", "icon16/anchor.png", "icon16/eye.png", "SCamV")

		local rha = vgui.Create("DPanel", Panel2)
		rha:SetPos(131, 2)
		rha:SetSize(99, 31)
		rha:SetText("")
		rha:SetAlpha(255)
		rha.Paint = function(s, w, h)
			local acw = math.max(0, math.min(200, 255 + (300 * math.sin(CurTime() * 4))))
			if self.Underlay.aaw == 0 then
				draw.RoundedBox(5, 0, 0, w, h, Color(50 + acw, 55 + acw, 55, 255))
			elseif self.Underlay.aaw == 2 then
				draw.RoundedBox(5, 0, 0, w, h, Color(50 + acw / 3, 55 + acw, 55, 255))
			else
				draw.RoundedBox(5, 0, 0, w, h, Color(50, 55, 55, 255))
			end
		end

		local DBut = vgui.Create("DButton", rha)
		DBut:SetPos(5, 5)
		DBut:SetSize(89, 20)
		DBut:SetText(aR:T("LAchievements"))
		DBut:SetTextColor( Color(0,0,0) )
		DBut.Paint = function(p, w, h)
			if p:IsDown() then
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 50, 100, 255))
			else
				draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
				draw.RoundedBox(0, 0, h/2, w, h/2, Color(200, 200, 200, 255))
			end
			CTxtMos(p, nil, {100, 100, 100, 160}, aR:T("LAchievements"), "CreditsText")
		end
		DBut.DoClick = function(s)
			surface.PlaySound("garrysmod/content_downloaded.wav")
			if IsValid(LocalPlayer().OAvs) then LocalPlayer().OAvs:Remove() end
			local aa_self = vgui.Create("DButton")
			aa_self:SetSize(ScrW(), ScrH())
			aa_self:SetText("")
			aa_self:MakePopup()
			aa_self:SetCursor( "arrow" )
			aa_self:SetAlpha(0)
			aa_self.OnMouseReleased = function() aa_self:Remove() if IsValid(LocalPlayer().OAvs) then LocalPlayer().OAvs:Remove() end end
			LocalPlayer().OAvs = vgui.Create("ActMod_Avs")
			LocalPlayer().OAvs.GetPly = LocalPlayer()
			LocalPlayer().OAvs.aa_self = aa_self
			self:Close()
			if LocalPlayer().ActMod_MousePos then LocalPlayer().ActMod_MousePos = nil end
		end
		
        rha.Think = function()
			if not rha.aak or (rha.ttim or 0) < CurTime() then
				rha.ttim = CurTime() + 1
				rha.aak = true
				local NTnum = A_AM.ActMod:AG_DatA(11) or 0
				if NTnum > 0 then
					if IsValid(rha.nw) then
						rha.nw.NTnum = NTnum
					else
						rha.nw = vgui.Create("DLabel", Panel2)
						rha.nw:SetSize(20, 14)
						rha.nw:SetPos(Panel2:GetWide()-rha.nw:GetWide(), 0)
						rha.nw:SetText("")
						rha.nw:SetAlpha(0)
						rha.nw:AlphaTo(255, 0.2)
						rha.OnRemove = function(pan) if IsValid(rha.nw) then rha.nw:Remove() end end
						rha.nw.NTnum = NTnum
						rha.nw.Paint = function(s, w, h)
							local aaa = math.sin((CurTime()) * 8)
							local TTXT = "*".. s.NTnum
							draw.RoundedBox(h/2, 0, 0, w, h, Color(0,0,0,150))
							draw.SimpleText(TTXT, "ActMod_a4", w / 2, h / 2, Color(255,255,255*math.max(aaa, 0),255), 1, 1)
						end
					end
				elseif NTnum == 0 then
					if IsValid(rha.nw) then rha.nw:Remove() end
				end
			end
		end
		
	end

    local rh = vgui.Create("DPanel", Panel)
    rh:SetPos(10, 0)
    rh:SetSize(740, 50)
    rh:SetText("")
    rh:SetAlpha(255)
    rh.Paint = function(s, w, h)
        if ThemeN == 1 then
            draw.RoundedBox(15, 0, 0, w, h + 15, Color(80, 80, 100, 255))
            draw.RoundedBox(10, 160, 10, 570, 50, Color(50, 100, 150, 255))
        elseif ThemeN == 2 then
            draw.RoundedBox(15, 0, 0, w, h + 15, Color(20, 20, 20, 200))
            draw.RoundedBox(10, 160, 10, 570, 50, Color(140, 150, 100, 35))
        end

        if A_AM.ActMod.clo_Select_Bace == 1 then
            draw.SimpleText("= Gmod =", "ActMod_a1", 105, 38, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif A_AM.ActMod.clo_Select_Bace == 2 then
            draw.SimpleText("CTE-Taunt", "ActMod_a1", 105, 38, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif A_AM.ActMod.clo_Select_Bace == 3 then
            draw.SimpleText("AM4-Pack", "ActMod_a1", 105, 38, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif A_AM.ActMod.clo_Select_Bace == 4 then
            draw.SimpleText("A Emotes C", "ActMod_a1", 105, 38, color_white, 1, 1)
        elseif A_AM.ActMod.clo_Select_Bace == 40 then
            draw.SimpleText("D-C-Hub", "ActMod_a1", 105, 38, color_white, 1, 1)
        elseif A_AM.ActMod.clo_Select_Bace == 50 then
            draw.SimpleText("E-Custom", "ActMod_a1", 105, 38, color_white, 1, 1)
        elseif A_AM.ActMod.clo_Select_Bace > 50 and A_AM.ActMod.TDCustom[A_AM.ActMod.clo_Select_Bace] and A_AM.ActMod.TDCustom[A_AM.ActMod.clo_Select_Bace].t then
			local tat = A_AM.ActMod.TDCustom[A_AM.ActMod.clo_Select_Bace].t
			local ntxt = string.len(tat) > 20
			if ntxt then
				draw.ScrollingText(tat, "ActMod_a4", 54, 31, color_white, 0, 0 ,w*0.138,s,2)
			else
				draw.SimpleText(tat, "ActMod_a4", 105, 38, color_white, 1, 1)
			end
        end
    end

    local TrCl_AM4 = A_AM.ActMod.GetMSS_Tab_cl and A_AM.ActMod.GetMSS_Tab_cl["GetMDLSeq_AM4"] and A_AM.ActMod.GetMSS_Tab_cl["GetMDLSeq_AM4"] == 2 or false
    local rs = vgui.Create("DPanel", rh)
    rs:SetPos(1, 0)
    rs:SetSize(50, 50)
    rs:SetText("")
    rs:SetAlpha(255)
    rs.Paint = function(s, w, h)
        if A_AM.ActMod.clo_Select_Bace == 1 then
			surface.SetDrawColor(color_white)
            surface.SetMaterial(Material("actmod/imenu/is_gmod.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        elseif A_AM.ActMod.clo_Select_Bace == 3 then
			surface.SetDrawColor(color_white)
            surface.SetMaterial(Material("actmod/imenu/ifrom_am4.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
            if not TrCl_AM4 then
                surface.SetDrawColor(255, 255, 255, math.max(200 + (100 * math.sin(CurTime() * 12)), 0))
                surface.SetMaterial(Material("icon16/error.png", "noclamp smooth"))
                surface.DrawTexturedRect(30, 30, 20, 20)
            end
        elseif A_AM.ActMod.clo_Select_Bace == 4 then
			surface.SetDrawColor(color_white)
            surface.SetMaterial(Material("icon16/cd_add.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        elseif A_AM.ActMod.clo_Select_Bace == 40 then
			if s.rfshT and s.rfshT > CurTime() - 0.71 then
				local aa = math.Clamp( (s.rfshT - CurTime()+0.7)/0.5 ,0,1)
                surface.SetDrawColor(255, 255, 255, 200*aa)
                surface.SetMaterial(Material("actmod/eff_particle/p_i_ligtstar_00_3", "noclamp smooth"))
				surface.DrawTexturedRectRotated(w/2, h/2, w, h, (CurTime()*40)%360)
			elseif s.rfshT then
				s.rfshT = nil
			end
			surface.SetDrawColor(color_white)
            surface.SetMaterial(Material("actmod/imenu/dcomn.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        elseif A_AM.ActMod.clo_Select_Bace == 50 then
			surface.SetDrawColor(color_white)
            surface.SetMaterial(Material("actmod/imenu/is_cm.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        elseif A_AM.ActMod.clo_Select_Bace > 60 then
			surface.SetDrawColor(color_white)
			local att = A_AM.ActMod.TDCustom[A_AM.ActMod.clo_Select_Bace]
			if att and isstring(att.i) then
				surface.SetMaterial(Material(att.i, "noclamp smooth"))
			else
				surface.SetMaterial(Material("actmod/imenu/i_cusr.png", "noclamp smooth"))
			end
            surface.DrawTexturedRect(0, 0, w, h)
        else
			surface.SetDrawColor(color_white)
            surface.SetMaterial(Material("icon16/collision_off.png", "noclamp smooth"))
            surface.DrawTexturedRect(0, 0, w, h)
        end
    end

    local function Bsa(ay)
        if A_AM.ActMod.clo_Select_Bace == 1 then
			self.Underlay.IBu0 = Button_NWInt(250, 10, 170, 40, "actmod/imenu/is_gmod.png", " Garry's Mod", "clo_IMeun_Num", 1, ay ,1)
			self.Underlay.IBu1 = Button_NWInt(500, 10, 132, 40, "actmod/imenu/is_featured.png", " Favorite", "clo_IMeun_Num", 20, ay ,2)
        elseif A_AM.ActMod.clo_Select_Bace == 3 then
            self.Underlay.IBu0 = Button_NWInt(174, 10, 100, 40, "actmod/imenu/is_am4.png", "Other", "clo_IMeun_Num", 5, ay ,1)
            self.Underlay.IBu1 = Button_NWInt(281, 10, 100, 40, "actmod/imenu/is_pubg.png", "PUBG", "clo_IMeun_Num", 11, ay ,2)
            self.Underlay.IBu2 = Button_NWInt(389, 10, 120, 40, "actmod/imenu/is_mixamo.png", "Mixamo", "clo_IMeun_Num", 10, ay ,3)
            self.Underlay.IBu3 = Button_NWInt(516, 10, 95, 40, "actmod/imenu/is_mmd2.png", "MMD", "clo_IMeun_Num", 6, ay ,4)
            self.Underlay.IBu4 = Button_NWInt(618, 10, 118, 40, "actmod/imenu/Is_fortnite.png", "Fortnite", "clo_IMeun_Num", 7, ay ,5)
        elseif A_AM.ActMod.clo_Select_Bace == 40 then
			if istable(A_AM.ActMod.TDCustom[40]) and not table.IsEmpty(A_AM.ActMod.TDCustom[40]) and istable(A_AM.ActMod.TDCustom[40].N) then
				local nAgn = {F=false,M=false,O=false}
				for i,Tb in pairs(A_AM.ActMod.TDCustom[40].N) do
					if Tb == 41 then nAgn.F = true end
					if Tb == 42 then nAgn.M = true end
					if Tb == 43 then nAgn.O = true end
				end
				if nAgn.F then
					self.Underlay.IBu4 = Button_NWInt(220, 10, 127, 40, "actmod/imenu/Is_fortnite.png", " Fortnite", "clo_IMeun_Num", 41, ay ,1)
				end
				if nAgn.M then
					self.Underlay.IBu3 = Button_NWInt(210*2, 10, 100, 40, "actmod/imenu/is_mmd2.png", " MMD", "clo_IMeun_Num", 42, ay ,2)
				end
				if nAgn.O then
					self.Underlay.IBu0 = Button_NWInt(200*3, 10, 105, 40, "icon64/tool.png", " Other", "clo_IMeun_Num", 43, ay ,3)
				end
			end
        elseif A_AM.ActMod.clo_Select_Bace == 50 then
			self.Underlay.IBu0 = Button_NWInt(180, 10, 55, 40, "icon16/folder.png", "1", "clo_IMeun_Num", 50, ay ,1)
			self.Underlay.IBu1 = Button_NWInt(180+70, 10, 55, 40, "icon16/folder.png", "2", "clo_IMeun_Num", 51, ay ,2)
			self.Underlay.IBu2 = Button_NWInt(180+70*2, 10, 55, 40, "icon16/folder.png", "3", "clo_IMeun_Num", 52, ay ,3)
			self.Underlay.IBu3 = Button_NWInt(180+70*3, 10, 55, 40, "icon16/folder.png", "4", "clo_IMeun_Num", 53, ay ,4)
			self.Underlay.IBu4 = Button_NWInt(180+70*4, 10, 55, 40, "icon16/folder.png", "5", "clo_IMeun_Num", 54, ay ,5)
			self.Underlay.IBu5 = Button_NWInt(180+70*5, 10, 55, 40, "icon16/folder.png", "6", "clo_IMeun_Num", 55, ay ,6)
			self.Underlay.IBu6 = Button_NWInt(180+70*6, 10, 55, 40, "icon16/folder.png", "7", "clo_IMeun_Num", 56, ay ,7)
			self.Underlay.IBu7 = Button_NWInt(180+70*7, 10, 55, 40, "icon16/folder.png", "8", "clo_IMeun_Num", 57, ay ,8)
        elseif A_AM.ActMod.clo_Select_Bace > 60 then
			local GetTC = istable(A_AM.ActMod.TDCustom) and A_AM.ActMod.TDCustom[A_AM.ActMod.clo_Select_Bace] and A_AM.ActMod.TDCustom[A_AM.ActMod.clo_Select_Bace].N and table.Copy(A_AM.ActMod.TDCustom[A_AM.ActMod.clo_Select_Bace].N)
			if istable(GetTC) and not table.IsEmpty(GetTC) then
				table.sort( GetTC, function(a, b) return a < b end )
				local nAgn = {}
				for i,n in ipairs(GetTC) do
					if n > 0 and not table.HasValue(nAgn, n) then
						table.insert(nAgn , n)
						self.Underlay["IBu".. i-1] = Button_NWInt(180+(70*(#nAgn-1)), 10, 55, 40, "icon16/folder.png", tostring(n), "clo_IMeun_Num", A_AM.ActMod.clo_Select_Bace+n-1, ay ,i)
					end
				end
			end
        end
    end
	self.Underlay.DButCh = vgui.Create("DComboBox", rh)
	local DButCh = self.Underlay.DButCh
	DButCh:SetPos(52, 0)
	DButCh:SetSize(100, 25)
	function DButCh:rBsa()
		local GetTC = A_AM.ActMod.TDCustom
		DButCh:Clear()
		DButCh:SetSortItems( false )
		DButCh:SetText(aR:T("LReplace_txt_SAFrom"))
		DButCh:AddChoice("Searches", 15, false, "icon16/folder_magnify.png")
		DButCh:AddChoice("Garry's Mod", 1, false, "icon16/folder_page.png")
		DButCh:AddChoice("Pack Basic for ActMod", 3, false, TrCl_AM4 and "icon16/folder_page.png" or "icon16/folder_error.png")
		DButCh:AddSpacer()
		if istable(GetTC) and not table.IsEmpty(GetTC) then
			if istable(GetTC[40]) and not table.IsEmpty(A_AM.ActMod.TDCustom[40]) and istable(A_AM.ActMod.TDCustom[40].N) then
				local nAgn = {F=false,M=false,O=false}
				for i,Tb in pairs(A_AM.ActMod.TDCustom[40].N) do
					if Tb == 41 then nAgn.F = true end
					if Tb == 42 then nAgn.M = true end
					if Tb == 43 then nAgn.O = true end
				end
				if nAgn.F or nAgn.M or nAgn.O then
					DButCh:AddChoice("ActMod Commission Hub", 40, false, "icon16/folder_star.png" )
				end
			end
			for i,t in pairs(A_AM.ActMod.Aadons) do
				if table.HasValue(DButCh.Choices, t) then continue end
				local tk
				for kk,vT in pairs(GetTC) do if vT.t and vT.t == t then tk = kk end end
				if tk then DButCh:AddChoice( t, tk, false, "icon16/folder_go.png" ) end
			end
			DButCh:AddChoice("Dances/Emotes <Custom>", 50, false, "icon16/folder_user.png" )
			for i,T in pairs(GetTC) do
				if not isnumber(i) then continue end
				if table.HasValue(DButCh.Choices, T.t) then continue end
				DButCh:AddChoice( T.t, i, false, "icon16/folder_user.png" )
			end
		else
			DButCh:AddChoice("Dances/Emotes <Custom>", 50, false, "icon16/folder_user.png" )
		end
    end
	DButCh:rBsa()
	DButCh.OnSelect = function(pl, index, value, data)
		if data == 15 then
			if A_AM.ActMod.clo_IMeun_Num ~= 15 then
				A_AM.ActMod.clo_IMeun_Num = 15
				Passq:SetAlpha(255)
				Passq:AlphaTo(0, 0.2)
				surface.PlaySound("actmod/i_menu/menu_othr_02.mp3")
				if IsValid(List) then List:Remove() end
				Buttons = nil
				Buttons = {}
				List = vgui.Create("DIconLayout", Scroll)
				List:SetPos(0, 0)
				List:SetSize(Scroll:GetWide(), Scroll:GetTall())
				List:SetSpaceY(self.ScaleIconsDEG / 4)
				List:SetSpaceX(self.ScaleIconsDEG / 4)
				for k, v in pairs(A_AM.ActMod.FindIt or {}) do
					MakeButton(v)
				end
			end
		elseif A_AM.ActMod.clo_Select_Bace ~= data then
			if IsValid(self.Underlay.IBu0) then self.Underlay.IBu0:Remove() end
			if IsValid(self.Underlay.IBu1) then self.Underlay.IBu1:Remove() end
			if IsValid(self.Underlay.IBu2) then self.Underlay.IBu2:Remove() end
			if IsValid(self.Underlay.IBu3) then self.Underlay.IBu3:Remove() end
			if IsValid(self.Underlay.IBu4) then self.Underlay.IBu4:Remove() end
			if IsValid(self.Underlay.IBu5) then self.Underlay.IBu5:Remove() end
			if IsValid(self.Underlay.IBu6) then self.Underlay.IBu6:Remove() end
			if IsValid(self.Underlay.IBu7) then self.Underlay.IBu7:Remove() end
			Panel.tablTime = {}
			Passq.aNextN = 0
			if data == 40 and rs then rs.rfshT = CurTime() + 0.1 end
			surface.PlaySound(data == 40 and "actmod/i_menu/bdchub.mp3" or "garrysmod/content_downloaded.wav")
			A_AM.ActMod.clo_Select_Bace = data
			Bsa(true)
		end

		DButCh:SetText(aR:T("LReplace_txt_SAFrom"))
	end

    Bsa()
	
	if not self.Underlay.Dled then
		local DButton = vgui.Create("DButton", Panel)
		DButton:SetPos(595, Panel:GetTall() - (27 + Thh))
		DButton:SetSize(90, 20)
		DButton:SetText(aR:T("LReplace_txt_REmot"))
		DButton:SetTextColor( Color(0,0,0) )
		DButton.Paint = function(p, w, h)
			if p:IsDown() then
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 50, 100, 255))
			else
				draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
				draw.RoundedBox(0, 0, h/2, w, h/2, Color(200, 200, 200, 255))
			end
			CTxtMos(p, nil, {100, 100, 100, 160}, aR:T("LReplace_txt_REmot"), "CreditsText",-1)
		end
		DButton.DoClick = function(s)
			Derma_Query(aR:T("LReplace_txt_REmott1"), aR:T("LReplace_txt_REmott2"), aR:T("LReplace_txt_REmott3"), function()
				A_AM.ActMod:ActojiClear() self:Close(true)
				if IsValid(self.Underlay.modelmenu) then self.Underlay.modelmenu:Remove() end
				if IsValid(self.Underlay) then self.Underlay:Remove() end
			end, aR:T("LReplace_txt_REmott4"), function() end)
		end

		local DButton = vgui.Create("DButton", Panel)
		DButton:SetPos(690, Panel:GetTall() - (27 + Thh))
		DButton:SetSize(60, 20)
		DButton:SetText(aR:T("LReplace_txt_Options"))
		DButton:SetTextColor( Color(0,0,0) )
		DButton.Paint = function(p, w, h)
			if p:IsDown() then
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 50, 100, 255))
			else
				draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
				draw.RoundedBox(0, 0, h/2, w, h/2, Color(200, 200, 200, 255))
			end
			CTxtMos(p, nil, {100, 100, 100, 160}, aR:T("LReplace_txt_Options"), "CreditsText",-1)
		end
		DButton.DoClick = function(s)
			self:AMenuOption(LocalPlayer())
			self:Close()
			if LocalPlayer().ActMod_MousePos then LocalPlayer().ActMod_MousePos = nil end
		end
	end
end

A_AM.ActMod.LuaVgi_MChange_Done = true
