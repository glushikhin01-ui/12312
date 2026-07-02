if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaVgi_MOption = true

if SERVER then return end

local Actoji = A_AM.ActMod.Actoji
local function CTxtMos(Ow, IsH, Ty, txt, txf, aup) A_AM.ActMod:CTxtMos(Ow, IsH, Ty, txt, txf, aup) end

local function Button_DLabel(dkj, aPos, bPos, aSize, bSize, aText, comm, srvr)
	local ply = LocalPlayer()
	
	local SButton = vgui.Create("DPanel", dkj)
	SButton:SetText("")
	SButton:SetPos(aPos, bPos)
	SButton:SetSize(dkj:GetWide() - aPos * 2, bSize)
	SButton.Paint = function(self, w, h) end
	local es = vgui.Create("DPanel", SButton)
	es:SetPos(2, 5)
	es:SetSize(30, 30)
	es:SetText("")
	es:SetAlpha(0)

	timer.Simple(0.2, function()
		if IsValid(dkj) then
			es:AlphaTo(255, 0.5)
		end
	end)

	es.Paint = function(ste, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 255))

		if GetConVarNumber(comm) == 1 then
			surface.SetMaterial(Material("icon16/tick.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
		end

		surface.DrawTexturedRect(0, 0, w, h)
	end

	local pButton = vgui.Create("DButton", SButton)
	pButton:SetText("")
	pButton:SetPos(0, 0)
	pButton:SetSize(40, 40)

	local SndText = vgui.Create("DPanel", SButton)
	SndText:SetPos(35, 4.5)
	SndText:SetText("")
	SndText:SetAlpha(0)
	if comm == "actmod_sv_enabled_addso" or comm == "actmod_cl_sound" then
		SndText:SetSize(A_AM.ActMod:AZtxt(aText .." 888%","DermaLarge"),30)
	else
		SndText:SetSize(A_AM.ActMod:AZtxt(aText,"DermaLarge"),30)
	end
	SndText:AlphaTo(255, 0.5)
	SndText.gga = false
	SndText.ttxt_1 = aR:T("LAchievements_H")
	SndText.ttxt_2 = aR:T("AL_COS_EnLodng_hlp")
	SndText.Paint = function(p, w, h)
		if p:IsHovered() then
			draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100))
		end
		if comm == "actmod_sv_avs" then
			CTxtMos(p, nil, {100, 100, 100, 200}, p.ttxt_1, "CreditsText")
		elseif comm == "actmod_cl_eloading" then
			CTxtMos(p, nil, {100, 100, 100, 200}, p.ttxt_2, "CreditsText")
		end
		if p.gga == true then
			draw.RoundedBox(0, 0, 0, w, h, Color(80, 100, 255, 100))
		end
		if comm == "actmod_sv_enabled_addso" and GetConVarNumber("actmod_sv_enabled_addso") > 0 then
			draw.SimpleText(aText .." ".. GetConVarNumber("actmod_sv_soundlevel") .."%", "DermaLarge", 0, h / 2, Color(255, 255, 255, 255),0,1)
		elseif comm == "actmod_cl_sound" and GetConVarNumber("actmod_cl_sound") > 0 then
			draw.SimpleText(aText .." ".. GetConVarNumber("actmod_cl_soundlevel") .."%", "DermaLarge", 0, h / 2, Color(255, 255, 255, 255),0,1)
		else
			draw.SimpleText(aText, "DermaLarge", 0, h / 2, Color(255, 255, 255, 255),0,1)
		end
	end
	
	pButton.Paint = function(self, w, h)
		if ply:IsListenServerHost() and pButton:IsHovered() then
			surface.SetDrawColor(Color(255, 255, 255, 255))
			surface.SetMaterial(Material("actmod/sm_hover.png", "noclamp smooth"))
			surface.DrawTexturedRect(0, 0, w - 5, h)
			SndText.gga = true
		elseif srvr and pButton:IsHovered() then
			surface.SetDrawColor(Color(255, 255, 255, 255))
			surface.SetMaterial(Material("actmod/sm_hover.png", "noclamp smooth"))
			surface.DrawTexturedRect(0, 0, w - 5, h)
			SndText.gga = true
		elseif SndText.gga == true then
			SndText.gga = false
		end
	end

	pButton.DoClick = function()
		if ply:IsListenServerHost() then
			surface.PlaySound("garrysmod/ui_click.wav")
			if GetConVarNumber(comm) == 1 then
				RunConsoleCommand(comm, "0")
			else
				RunConsoleCommand(comm, "1")
			end
		elseif srvr then
			surface.PlaySound("garrysmod/ui_click.wav")
			if GetConVarNumber(comm) == 1 then
				RunConsoleCommand(comm, "0")
			else
				RunConsoleCommand(comm, "1")
			end
		else
			surface.PlaySound("garrysmod/ui_return.wav")
		end
	end
end

Actoji.AMenuOption = function(self, ply)
    if IsValid(ply) then

        if IsValid(self.OptMenu) then self.OptMenu:Remove() end

		local aa_self = vgui.Create("DButton")
		aa_self:SetSize(ScrW(), ScrH())
		aa_self:SetText("")
		aa_self:MakePopup()
		aa_self:SetCursor( "arrow" )
		aa_self:Center()
		aa_self:SetAlpha(0)
		aa_self.DoClick = function ()
			if IsValid(self.OptMenu) and IsValid(self.ShowMenuiA) then
				self.ShowMenuiA:Remove()
				if IsValid(self.OptMenu) then self.OptMenu:MakePopup() end
			elseif IsValid(self.OptMenu) then self.OptMenu:Remove()
			end
		end
		
        self.OptMenu = vgui.Create("DFrame")
        self.OptMenu:SetTitle("")
        self.OptMenu:SetSize(410, 555)
        self.OptMenu:SetAlpha(0)
        self.OptMenu:Center()
        self.OptMenu:MakePopup()
        self.OptMenu:ShowCloseButton(false)
        self.OptMenu:SetDraggable(false)
        self.OptMenu:MoveTo(ScrW() / 10, ScrH() / 2 - self.OptMenu:GetTall() / 2 , 0.3)
        self.OptMenu:AlphaTo(255, 0.3)
        self.OptMenu.OnRemove = function(pan)
			if IsValid(aa_self) then aa_self:Remove() end
            if IsValid(self.ShowMenuiA) then self.ShowMenuiA:Remove() end
        end
        self.OptMenu.Paint = function(s, w, h)
            draw.RoundedBox(6, 0, 0, w, h, Color(110, 139, 155, 250))
            draw.RoundedBox(6, 5, 5, w - 10, h - 10, Color(20, 20, 20, 250))
        end

        self.OptMenu.TimeR = CurTime() + 0.8
        self.OptMenu.mTy = 1

        timer.Simple(0.4, function()
            if IsValid(self.OptMenu) then
                self.OptMenu.SBut = vgui.Create("DButton", self.OptMenu)
                self.OptMenu.SBut:SetText("X")
                self.OptMenu.SBut:SetFont("ActMod_a1")
                self.OptMenu.SBut:SetAlpha(0)
                self.OptMenu.SBut:SetTextColor(Color(20, 5, 5))
                self.OptMenu.SBut:SetPos(self.OptMenu:GetWide() - 40, -40)
                self.OptMenu.SBut:SetSize(30, 30)
				self.OptMenu.SBut:AlphaTo(255,0.3,0.5)
                self.OptMenu.SBut:MoveTo(self.OptMenu:GetWide() - 40, 10, 0.4)
                self.OptMenu.SBut.Paint = function(ss, w, h)
                    if ss:IsHovered() then
                        draw.RoundedBox(4, 0, 0, w, h, Color(160, 100, 85, 255))
                    else
                        draw.RoundedBox(4, 0, 0, w, h, Color(120, 70, 70, 255))
                    end
                end

                self.OptMenu.SBut.DoClick = function()
                    surface.PlaySound("actmod/s/click01.mp3")
                    if IsValid(self.OptMenu) then
                        self.OptMenu:Remove()
                    end
                end

				self.OptMenu.TxtV = vgui.Create("DLabel", self.OptMenu)
				self.OptMenu.TxtV:SetPos(10, self.OptMenu:GetTall() - 25)
				self.OptMenu.TxtV:SetSize(243, 20)
				self.OptMenu.TxtV:SetAlpha(0)
				self.OptMenu.TxtV:SetFont("ActMod_a2") self.OptMenu.TxtV:SetTextColor( Color(255,255,255) )
				self.OptMenu.TxtV:SetText(" ".. aR:T("AL_i_iefoV") .. "  AhmedMake400")
				self.OptMenu.TxtV:AlphaTo(255,0.5,1.1)

				self.OptMenu.Txt2V = vgui.Create("DLabel", self.OptMenu)
				self.OptMenu.Txt2V:SetPos(self.OptMenu:GetWide() - 140, self.OptMenu:GetTall() - 25)
				self.OptMenu.Txt2V:SetSize(120, 20)
				self.OptMenu.Txt2V:SetAlpha(0)
				self.OptMenu.Txt2V:SetFont("ActMod_a3") self.OptMenu.Txt2V:SetTextColor( Color(255,255,255) )
				self.OptMenu.Txt2V:SetText(aR:T("AL_i_iefoV2") .. A_AM.ActMod.Mounted["Version ActMod"] .. ")")
				self.OptMenu.Txt2V:AlphaTo(255,0.5,1.7)
            end
        end)

        local function as1_ss(asa)
            local esOpt = vgui.Create("DPanel", asa)
            esOpt:SetPos(0, 50)
            esOpt:SetSize(asa:GetWide(), asa:GetTall() - 50)
            esOpt:SetText("")
            esOpt.Paint = function(s, w, h) end

            timer.Simple(0.0, function()
                if IsValid(self.OptMenu) then
                    local es = vgui.Create("DPanel", esOpt)
                    es:SetPos(30, 10)
                    es:SetSize(esOpt:GetWide() - 60, 175)
                    es:SetText("")
                    es:SetAlpha(0)
                    es:AlphaTo(255, 0.5)
                    es.Paint = function(ste, w, h)
                        if ply:IsListenServerHost() then
                            draw.RoundedBox(6, 0, 0, w, h, Color(40, 80, 100, 250))
                        else
                            draw.RoundedBox(6, 0, 0, w, h, Color(50, 40, 40, 250))
                        end
                    end

                    local SText = vgui.Create("DLabel", es)
                    SText:SetPos(2, 2)
                    SText:SetText(aR:T("AL_SOS"))
                    SText:SetFont("ActMod_a1") SText:SetTextColor( Color(255,255,255) )
                    SText:SizeToContents()

                    timer.Simple(0.05, function()
                        if IsValid(self.OptMenu) then
                            Button_DLabel(es, 2, 30, 250, 40, aR:T("AL_SOS_EA"), "actmod_sv_enabled")

                            timer.Simple(0.05, function()
                                if IsValid(self.OptMenu) then
                                    Button_DLabel(es, 2, 65, 250, 40, aR:T("AL_SOS_AF"), "actmod_sv_enabled_addef")

                                    timer.Simple(0.05, function()
                                        if IsValid(self.OptMenu) then
                                            Button_DLabel(es, 2, 100, 250, 40, aR:T("AL_SOS_AS"), "actmod_sv_enabled_addso")
                                        end
                                    end)
                                    timer.Simple(0.1, function()
                                        if IsValid(self.OptMenu) then
                                            Button_DLabel(es, 2, 135, 250, 40, aR:T("LAchievements"), "actmod_sv_avs")
                                        end
                                    end)
                                end
                            end)
                        end
                    end)
                end
            end)

            timer.Simple(0.1, function()
                if IsValid(self.OptMenu) then
                    local es = vgui.Create("DPanel", esOpt)
                    es:SetPos(30, 205)
                    es:SetSize(esOpt:GetWide() - 60, 270)
                    es:SetText("")
                    es:SetAlpha(0)
                    es:AlphaTo(255, 0.5)
                    es.Paint = function(ste, w, h)
                        draw.RoundedBox(6, 0, 0, w, h, Color(40, 80, 60, 250))
                    end

                    local CText = vgui.Create("DLabel", es)
                    CText:SetPos(2, 2)
                    CText:SetText(aR:T("AL_COS"))
                    CText:SetFont("ActMod_a1") CText:SetTextColor( Color(255,255,255) )
                    CText:SizeToContents()

                    timer.Simple(0.0, function()
                        if IsValid(self.OptMenu) then
                            local KText = vgui.Create("DLabel", es)
                            KText:SetPos(2, 35)
                            KText:SetAlpha(0)
                            KText:SetText(aR:T("AL_COS_Ky"))
                            KText:SetFont("DermaLarge") KText:SetTextColor( Color(255,255,255) )
                            KText:SizeToContents()
                            KText:AlphaTo(255, 0.5)
                            local button_open = vgui.Create("DBinder", es)
                            button_open:SetPos(es:GetWide() - 200, 32)
                            button_open:SetSize(180, 40)
                            button_open:SetAlpha(0)
                            button_open:AlphaTo(255, 0.5)
                            button_open:SetValue(GetConVar("actmod_key_iconmenu"):GetInt())
                            button_open:SetFont("ActMod_a1") button_open:SetTextColor( Color(255,255,255) )
                            button_open.kyT = false
                            button_open.Paint = function(self, w, h)
                                if button_open.kyT == true then
                                    draw.RoundedBox(10, 0, 0, w, h, Color(math.max(200 + (55 * math.sin(CurTime() * 7)), 200), 150, 80, 255))
                                else
                                    draw.RoundedBox(10, 0, 0, w, h, Color(200, 200, 200, 255))
                                end
                            end

                            function button_open:OnChange(num)
                                if num == 66 or num == 83 or num == 107 or num == 108 or num == 109 or num == 112 or num == 113 or num == GetConVar("actmod_keyo_h"):GetInt() then
                                    button_open:SetText(aR:T("AL_COS_CKy"))
                                    button_open.kyT = true
                                    button_open:SetFont("ActMod_a5")
                                else
                                    button_open.kyT = false
                                    button_open:SetFont("ActMod_a1")
                                    RunConsoleCommand("actmod_key_iconmenu", num)
                                end
                            end

                            timer.Simple(0.05, function()
                                if IsValid(self.OptMenu) then
                                    Button_DLabel(es, 2, 75, 250, 40, aR:T("AL_COS_EF"), "actmod_cl_effects", true)

                                    timer.Simple(0.05, function()
                                        if IsValid(self.OptMenu) then
                                            Button_DLabel(es, 2, 115, 250, 40, aR:T("AL_COS_ES"), "actmod_cl_sound", true)

                                            timer.Simple(0.05, function()
                                                if IsValid(self.OptMenu) then
                                                    Button_DLabel(es, 2, 155, 250, 40, aR:T("AL_COS_EnLodng"), "actmod_cl_eloading", true)

                                                    timer.Simple(0.05, function()
                                                        if IsValid(self.OptMenu) then
                                                            Button_DLabel(es, 2, 195, 250, 40, aR:T("AL_COS_EC"), "actmod_cl_cam180", true)
                                                            local tl = GetConVarString("actmod_cl_lang") or ""
                                                            local DPa_ = vgui.Create("DPanel", es)
                                                            DPa_:SetSize(35, 25)
                                                            DPa_:SetPos(4, 240)
                                                            DPa_:SetAlpha(0)
                                                            DPa_:AlphaTo(255, 0.5, 0.3)
                                                            DPa_.Paint = function(ste, w, h)
                                                                surface.SetDrawColor(color_white)
                                                                if tl == "ru" then
                                                                    surface.SetMaterial(Material("flags16/ru.png", "noclamp smooth"))
                                                                elseif tl == "zh-CN" then
                                                                    surface.SetMaterial(Material("flags16/cn.png", "noclamp smooth"))
                                                                elseif tl == "de" then
                                                                    surface.SetMaterial(Material("flags16/de.png", "noclamp smooth"))
                                                                elseif tl == "tr" then
                                                                    surface.SetMaterial(Material("flags16/tr.png", "noclamp smooth"))
                                                                else
                                                                    surface.SetMaterial(Material("flags16/gb.png", "noclamp smooth"))
                                                                end
                                                                surface.DrawTexturedRect(0, 0, w, h)
                                                            end

                                                            local DButCh = vgui.Create("DComboBox", DPa_)
                                                            DButCh:SetSize(35, 25)
                                                            DButCh:SetPos(0, 0)
                                                            DButCh:SetAlpha(0)
                                                            DButCh:SetText("")
                                                            DButCh:AddChoice("1- English", "en", false, "flags16/gb.png")
                                                            DButCh:AddChoice("2- China", "zh-CN", false, "flags16/cn.png")
                                                            DButCh:AddChoice("3- Russian", "ru", false, "flags16/ru.png")
                                                            DButCh:AddChoice("4- Germany", "de", false, "flags16/de.png")
                                                            DButCh:AddChoice("5- Turkish", "tr", false, "flags16/tr.png")
                                                            DButCh.OnSelect = function(pl, index, value, data)
                                                                surface.PlaySound("garrysmod/content_downloaded.wav")
                                                                LocalPlayer():ConCommand("actmod_cl_lang " .. data .. "\n")
                                                                tl = data
																if Actoji and IsValid(Actoji.Underlay) then Actoji.Underlay:Remove() end
                                                                if IsValid(self.OptMenu.mMun1) then
                                                                    self.OptMenu.mMun1:Remove()
                                                                    timer.Simple(0.1, function()
                                                                        if IsValid(self.OptMenu) then
                                                                            self.OptMenu.mMun1 = as1_ss(self.OptMenu)
                                                                            self.OptMenu.B1:SetText(aR:T("AL_Optin"))
                                                                            self.OptMenu.B1:SizeToContents()
                                                                            self.OptMenu.B2:SetText(aR:T("AL_About"))
                                                                            self.OptMenu.B2:SizeToContents()
																			self.OptMenu.TxtV:SetText(" ".. aR:T("AL_i_iefoV") .. "  AhmedMake400")
																			self.OptMenu.Txt2V:SetText(aR:T("AL_i_iefoV2") .. A_AM.ActMod.Mounted["Version ActMod"] .. ")")
                                                                        end
                                                                    end)
                                                                end
                                                            end

                                                            local t2 = GetConVarNumber("actmod_cl_stibox") or 1
                                                            local aa_ = vgui.Create("DPanel", es)
                                                            aa_:SetSize(25, 25)
                                                            aa_:SetPos(60, 240)
                                                            aa_:SetAlpha(0)
                                                            aa_:AlphaTo(255, 0.5, 0.3)
                                                            aa_.Paint = function(ste, w, h)
                                                                surface.SetDrawColor(color_white)
                                                                if GetConVarNumber("actmod_cl_stibox") > 1 then
                                                                    surface.SetMaterial(Material("materials/actmod/sm_hover" .. tostring(GetConVarNumber("actmod_cl_stibox")) .. ".png", "noclamp smooth"))
                                                                else
                                                                    surface.SetMaterial(Material("materials/actmod/sm_hover.png", "noclamp smooth"))
                                                                end
                                                                surface.DrawTexturedRect(0, 0, w, h)
                                                            end

                                                            local DBu1 = vgui.Create("DButton", aa_)
                                                            DBu1:SetSize(aa_:GetWide(), aa_:GetTall())
                                                            DBu1:SetText("")
                                                            DBu1:SetAlpha(0)
                                                            DBu1.Paint = function() end
                                                            DBu1.DoClick = function(s)
                                                                A_AM.ActMod:MunChIBox()
                                                            end

															local DImagButton = vgui.Create( "DImageButton", es )
															DImagButton:SetPos( 110, es:GetTall() - 30 )
															DImagButton:SetSize( 28, 28 )
															DImagButton:SetImage( "icon16/cog.png" )
                                                            DImagButton:SetAlpha(0)
                                                            DImagButton:AlphaTo(255, 0.5, 0.4)
															DImagButton.DoClick = function()
																A_AM.ActMod:MListAPSond()
															end

                                                            local DBu = vgui.Create("DButton", es)
                                                            DBu:SetPos(es:GetWide() - 195, es:GetTall() - 30)
                                                            DBu:SetSize(190, 25)
                                                            DBu:SetText(aR:T("LReplace_txt_RAll"))
															DBu:SetTextColor( Color(0,0,0) )
                                                            DBu:SetAlpha(0)
                                                            DBu:AlphaTo(255, 0.5, 0.5)
                                                            DBu.DoClick = function(s)
                                                                Derma_Query(aR:T("LReplace_txt_R_t1"), aR:T("LReplace_txt_RAll"), aR:T("LORTR_Yes"), function()
                                                                    Derma_Query(aR:T("LReplace_txt_R_t3") .. "\n" .. aR:T("LReplace_txt_R_t2"), aR:T("LReplace_txt_RAll"), aR:T("LReplace_txt_R_t4"), function()
                                                                        local function Rre(t, s)
                                                                            local as = s
                                                                            if isnumber(s) then as = tostring(math.floor(s)) end
                                                                            LocalPlayer():ConCommand(t .. " " .. as .. "\n")
                                                                        end

																		Rre("actmod_cl_showmasngerr", 1)
																		Rre("actmod_cl_eloading", 0)
																		Rre("actmod_cl_menuformat", 1)
																		Rre("actmod_cl_menuformat2", 1)
																		Rre("actmod_cl_loop", 2)
																		Rre("actmod_cl_effects", 1)
																		Rre("actmod_cl_sound", 1)
																		Rre("actmod_cl_thememenu", 1)
																		Rre("actmod_cl_stext", "dance")
																		Rre("actmod_cl_background", 1)
																		Rre("actmod_cl_sortemote", 1)
																		Rre("actmod_cl_setcamera", 0)
																		Rre("actmod_cl_pageslot", 1)
																		Rre("actmod_cl_smshcam_on", 0)
																		Rre("actmod_cl_smshcam_sp", 5)
																		Rre("actmod_cl_showbhelp", 1)
																		Rre("actmod_cl_stibox", 1)
																		Rre("actmod_cl_lang", "none")
																		Rre("actmod_cl_cam180", 0)
																		Rre("actmod_cl_viewdis", 2100)
																		Rre("actmod_cl_automclose", 1)
																		Rre("actmod_cl_showslotss", 1)
																		Rre("actmod_cl_showiconsml", 1)
																		Rre("actmod_cl_showmsgavs", 1)
																		Rre("actmod_cl_showmsgavssnd", 1)
																		Rre("actmod_cl_vrjoin", 1)
																		Rre("actmod_cl_vr_tst", 0)
																		Rre("actmod_cl_smartomenu", 1)
																		Rre("actmod_cl_soundlevel", 75)
																		Rre("actmod_cl_soundlevelother", 100)
																		Rre("actmod_cl_sdwfix", 0)
																		Rre("actmod_cl_showarrow", 0)
																		Rre("actmod_cl_q_ef", 2)
																		Rre("actmod_cl_g_hud_typ", 1)
																		Rre("actmod_sp_pause", 1)
																		
																		A_AM.ActMod.clo_IMeun_Num = 1
																		A_AM.ActMod.clo_Select_Bace = 1

                                                                        if file.Exists(A_AM.ActMod:GUniqueFiName(LocalPlayer()), "DATA") then
                                                                            file.Delete(A_AM.ActMod:GUniqueFiName(LocalPlayer()), "DATA")
                                                                            timer.Create("Acl_t1", 0.2, 1, function()
                                                                                if IsValid(LocalPlayer()) then
                                                                                    A_AM.ActMod:A_ReGD()
                                                                                end
                                                                            end)
                                                                        end

                                                                        A_AM.ActMod:ActojiClear()
                                                                        self:Close(true)

                                                                        if IsValid(self.OptMenu) then self.OptMenu:Remove() end
																		if Actoji and IsValid(Actoji.Underlay) then Actoji.Underlay:Remove() end
                                                                        if LocalPlayer().ActMod_MousePos then LocalPlayer().ActMod_MousePos = nil end
                                                                        Derma_Message(aR:T("LReplace_txt_R_t6"), aR:T("LReplace_txt_R_t5"), aR:T("LReplace_txt_R_t7"))
                                                                    end, aR:T("LORTR_No"), function() end)
                                                                end, aR:T("LORTR_No"), function() end)
                                                            end
                                                        end
                                                    end)
                                                end
                                            end)
                                        end
                                    end)
                                end
                            end)
                        end
                    end)
                end
            end)

            return esOpt
        end

        timer.Simple(0.4, function()
            if IsValid(self.OptMenu) then
                self.OptMenu.mMun1 = as1_ss(self.OptMenu)
            end
        end)

        self.OptMenu.B1 = vgui.Create("DButton", self.OptMenu)
        self.OptMenu.B1:SetPos(10, 15)
        self.OptMenu.B1:SetText(aR:T("AL_Optin"))
        self.OptMenu.B1:SetFont("ActMod_a1")
        self.OptMenu.B1:SetTextColor(Color(205, 255, 255))
        self.OptMenu.B1:SizeToContents()
        self.OptMenu.B1.Paint = function(s, w, h)
            if self.OptMenu.mTy == 1 then
                draw.RoundedBox(6, 0, 0, w, h, Color(100, 100, 50, 250))
            elseif (self.OptMenu.TimeR or 0) > CurTime() then
                draw.RoundedBox(6, 0, 0, w, h, Color(20, 20, 20, 250))
            else
                draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 50, 250))
            end
        end

        self.OptMenu.B1.DoClick = function()
            if self.OptMenu.mTy == 2 and (self.OptMenu.TimeR or 0) < CurTime() then
                self.OptMenu.TimeR = CurTime() + 0.5
				surface.PlaySound("garrysmod/ui_return.wav")
                if IsValid(self.OptMenu.mMun1) then self.OptMenu.mMun1:Remove() end
                self.OptMenu.mMun1 = as1_ss(self.OptMenu)
                self.OptMenu.mTy = 1
            end
        end

        self.OptMenu.B2 = vgui.Create("DButton", self.OptMenu)
        self.OptMenu.B2:SetPos(240, 15)
        self.OptMenu.B2:SetText(aR:T("AL_About"))
        self.OptMenu.B2:SetFont("ActMod_a1")
        self.OptMenu.B2:SetTextColor(Color(205, 255, 255))
        self.OptMenu.B2:SizeToContents()
        self.OptMenu.B2.Paint = function(s, w, h)
            if self.OptMenu.mTy == 2 then
                draw.RoundedBox(6, 0, 0, w, h, Color(100, 100, 50, 250))
            elseif (self.OptMenu.TimeR or 0) > CurTime() then
                draw.RoundedBox(6, 0, 0, w, h, Color(20, 20, 20, 250))
            else
                draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 50, 250))
            end
        end

        self.OptMenu.B2.DoClick = function()
            if self.OptMenu.mTy == 1 and (self.OptMenu.TimeR or 0) < CurTime() then
				surface.PlaySound("garrysmod/ui_return.wav")
                if IsValid(self.OptMenu.mMun1) then
                    self.OptMenu.mMun1:Remove()
                end
				if A_AM.ActMod.LuaVgi_MAbout then self.OptMenu.mMun1 = A_AM.ActMod:as2_ss(self,self.OptMenu) end
                self.OptMenu.mTy = 2
            end
        end
    end
end

concommand.Add("actmod_cl_listoption", function(ply, cmd, args)
	if ply and IsValid(ply) and ply:IsPlayer() then
		Actoji:AMenuOption(LocalPlayer())
		if IsValid(Actoji.Frame) then Actoji:Close() end
		if LocalPlayer().ActMod_MousePos then LocalPlayer().ActMod_MousePos = nil end
	end
end)

A_AM.ActMod.LuaVgi_MOption_Done = true
