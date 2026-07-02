if not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaVgi_MAbout = true

if SERVER then return end

local Actoji = A_AM.ActMod.Actoji
local ASettings = A_AM.ActMod.Settings
local GetIDNames = A_AM.ActMod.GetIDNames or {}

local function ReString(st, tam4)
    return A_AM.ActMod:ReString(st, tam4)
end

local function RvString(ara)
    return A_AM.ActMod:RvString(ara)
end

local function CTxtMos(Ow, IsH, Ty, txt, txf, aup)
	A_AM.ActMod:CTxtMos(Ow, IsH, Ty, txt, txf, aup)
end




local function title(list, text ,oT)
    local label = list:Add('DLabel')
    label:SetText(text)
    local aFont,aTextColor,aveSh1,aveSh2,aCA = 'ActMod_a2',color_white ,2,color_black ,5
	if oT and istable(oT) then
		if oT["aFont"] then aFont = oT["aFont"] end
		if oT["TextColor"] then aTextColor = oT["TextColor"] end
		if oT["aveSh1"] then aveSh1 = oT["aveSh1"] end
		if oT["aveSh2"] then aveSh2 = oT["aveSh2"] end
		if oT["aCA"] then aCA = oT["aCA"] end
	end
    label:SetFont(aFont)
    label:SetTextColor(aTextColor)
    label:SetExpensiveShadow(aveSh1,aveSh2)
    label:SetContentAlignment(aCA)
    label:Dock(TOP)
    label:DockMargin(0, 0, 0, 4)
    return label
end

local function ic_dit(plist, data, NIi)
    local pnl = plist:Add('DButton')
    pnl:SetTall(50)
    pnl:SetText('')
    pnl:Dock(TOP)
    pnl:DockMargin(0, 0, 0, 5)

    pnl.OnRemove = function(pan)
        if IsValid(plist.aMh) then
            plist.aMh:Remove()
        end
    end

    local Stxt = vgui.Create("DPanel", pnl)
    Stxt:SetPos(2, 0)
    Stxt:SetSize(pnl:GetTall(), pnl:GetTall())
    Stxt:SetAlpha(255)
    Stxt:SetText("")
    Stxt.OnRemove = function(pan)
        if IsValid(Stxt.sgg) then Stxt.sgg:Remove() end
    end
    Stxt.Paint = function(s, w, h)
        if s:IsHovered() then
            draw.RoundedBox(15, 0, 0, w, h, Color(70, 150, 80, 150))
            if IsValid(plist.sgg) then
				if plist.sgg.fortis ~= s then plist.sgg:Remove() else plist.sgg:SetPos(gui.MouseX() + 5, gui.MouseY() - (plist.sgg:GetTall() - 10)) end
            else
                plist.sgg = vgui.Create("DLabel")
                plist.sgg:SetSize(180, 180)
                plist.sgg:SetDrawOnTop(true)
                plist.sgg:SetPos(gui.MouseX(), gui.MouseY() - (plist.sgg:GetTall() - 10))
                plist.sgg:SetText("")
				plist.sgg.fortis = s
                plist.sgg.Paint = function(s, w, h)
                    draw.RoundedBox(25, 0, 0, w, h, Color(100 + (50 * math.sin(CurTime() * 4)), 150 + (50 * math.sin(CurTime() * 2)), 150, 180))
                    surface.SetDrawColor(Color(255, 255, 255, 255))
                    surface.SetMaterial(Material(A_AM.ActMod:RIPng(NIi .. ".png"), "noclamp smooth"))
                    surface.DrawTexturedRect(0, 0, h, h)
                end
            end
        else
            if IsValid(plist.sgg) and plist.sgg.fortis == s then plist.sgg:Remove() end
        end

        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(Material(A_AM.ActMod:RIPng(NIi .. ".png"), "noclamp smooth"))
        surface.DrawTexturedRect(0, 0, h, h)
    end

    pnl.GNameAct = A_AM.ActMod:ReNameAct(ReString(NIi))
    pnl.GNameStr = ReString(NIi)
    pnl.Paint = function(p, w, h)
        if p:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, p:IsDown() and Color(150, 150, 110, 255) or Color(80, 140, 150, 255))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(70, 70, 120, 255))
        end

        draw.SimpleText(p.GNameAct, "ActMod_a1", h + 5, 2, Color(255, 255, 215, 255))
        draw.SimpleText(p.GNameStr, "ActMod_a2", h + 5, h - 25, Color(255, 255, 215, 255))
    end
    pnl.DoClick = function(p)
        if GetConVar("actmod_sv_avs"):GetInt() > 0 and A_AM.ActMod:LokTabData(LocalPlayer(), A_AM.ActMod.ActLck, ReString(NIi)) == true then
            surface.PlaySound("actmod/s/lock.mp3")

            if IsValid(plist.txh) then
                plist.txh:Remove()
            end

            plist.txh = vgui.Create("DLabel", pnl)
            plist.txh:SetSize(pnl:GetWide() / 2, pnl:GetTall())
            plist.txh:SetPos(plist.txh:GetWide() / 2, 0)
            plist.txh:SetText("")
            plist.txh:SetAlpha(255)

            plist.txh:AlphaTo(0, 0.5, 0.1, function()
                if IsValid(plist.txh) then
                    plist.txh:Remove()
                end
            end)

            plist.txh.Paint = function(s, w, h)
                draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(100, 50, 10, 255))
                draw.SimpleText(aR:T("LReplace_txt_Lock"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        else
            surface.PlaySound("garrysmod/balloon_pop_cute.wav")
            pnl.aaic = A_AM.ActMod:Chicon(plist, NIi)
        end
    end
    pnl.DoRightClick = function(p)
        surface.PlaySound("actmod/s/copy1.mp3")
		SetClipboardText(ReString(NIi))

        if IsValid(plist.txh) then
            plist.txh:Remove()
        end

        plist.txh = vgui.Create("DLabel", pnl)
        plist.txh:SetSize(pnl:GetWide() / 2, pnl:GetTall())
        plist.txh:SetPos(plist.txh:GetWide() / 2, 0)
        plist.txh:SetText("")
        plist.txh:SetAlpha(255)
        plist.txh:AlphaTo(0, 0.5, 0.3, function()
            if IsValid(plist.txh) then
                plist.txh:Remove()
            end
        end)
        plist.txh.Paint = function(s, w, h)
            draw.RoundedBox(50, 0, h / 3.5, w, h / 2, Color(20, 90, 200, 255))
            draw.SimpleText(aR:T("LReplace_txt_CopyName"), "ActMod_a2", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end

local function credit(plist, data, aself)
    local pnl = plist:Add('DPanel')
    pnl:SetTall(data.Az or 50)
    pnl:SetText('')
    pnl:Dock(TOP)
    pnl:DockMargin(0, 0, 0, 5)

    if data.url then
        pnl.Bava0 = pnl:Add('DButton')
        pnl.Bava0:SetPos(pnl:GetTall() + 2, 0)
        pnl.Bava0:SetSize(320, pnl:GetTall())
        pnl.Bava0:SetAlpha(0)
        pnl.Bava0:SetText("")
        pnl.Bava0.DoClick = function(p)
            if string.find(data.url, "https:") then
                gui.OpenURL(data.url)
            else
                A_AM.ActMod:ShowM_iconActs(aself, data)
            end
        end
    end

    if data.rainbow and data.s64 == "76561199185837385" then
        pnl.Bava1 = pnl:Add('DButton')
        pnl.Bava1:SetPos(220, 0)
        pnl.Bava1:SetSize(150, 25)
        pnl.Bava1:SetAlpha(150)
        pnl.Bava1:SetText("")
        pnl.Bava1.THo = 0
        pnl.Bava1.Think = function(p)
            if p:IsHovered() then
                if p.THo == 0 then
                    p.THo = 1

                    p:AlphaTo(255, 0.3, nil, function(s)
                        if IsValid(pnl.Bava1) then
                            pnl.Bava1.THo = 2
                        end
                    end)
                end
            else
                if p.THo == 2 then
                    p.THo = 1

                    p:AlphaTo(100, 0.2, nil, function(s)
                        if IsValid(pnl.Bava1) then
                            pnl.Bava1.THo = 0
                        end
                    end)
                end
            end
        end

        pnl.Bava1.DoClick = function(p)
			A_AM.ActMod:MSupMe()
        end

        pnl.Bava1.Paint = function(p, w, h)
            if p:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, p:IsDown() and Color(70, 255, 190, 255) or Color(50, 155, 100, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(160, 160, 180, 255))
            end

            draw.RoundedBox(4, 0, 0, w, h / 1.5, Color(10, 20, 200, 200))
            surface.SetDrawColor(Color(255, 255, 255, 255))
			surface.SetMaterial(Material("icon16/heart.png", "noclamp smooth"))
            surface.DrawTexturedRect(w - h / 1.2, h / 2 - 10, 20, 20)
            draw.SimpleTextOutlined(aR:T("LReplace_txt_supl"), "ActMod_a3", w / 2 - 12, h / 2, Color(255, 255, 255, 255), 1, 1, 1, Color(5, 5, 255, 255))
        end
    end

    pnl.Paint = function(p, w, h)
        if pnl.Bava0 then
            if data.rainbow then
                if p.Bava0:IsHovered() then
                    draw.RoundedBox(4, 0, 0, w, h, Color(100, 180, 150, 255))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(20, 60, 60, 255))
                end
            else
                if p.Bava0:IsHovered() then
                    draw.RoundedBox(4, 0, 0, w, h, Color(80, 70, 150, 255))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 40, 255))
                end
            end
        else
            if p:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, Color(80, 70, 150, 255))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 40, 255))
            end
        end
    end

    if data.name and data.icon then
        local Bicon = pnl:Add('DLabel')
        Bicon:SetSize(335, pnl:GetTall())
        Bicon:SetAlpha(255)
        Bicon:SetText("")
        Bicon.Paint = function(p, w, h)
            if data.icon then
                surface.SetDrawColor(Color(255, 255, 255, 255))
                surface.SetMaterial(Material(data.icon, "noclamp smooth"))
                surface.DrawTexturedRect(5, 2, h - 4, h - 4)
            end

            if data.name then
                draw.SimpleText(data.tname or data.name, "ActMod_a6", w / 2 + data.Az*0.6, h / 2, Color(255, 255, 255, 255), 1, 1)
            end
        end
    end

    if data.s64 then
        local avatar = pnl:Add('AvatarImage')
        avatar:SetSteamID(data.s64, 64)
        avatar:DockMargin(2, 2, 5, 2)
        avatar:SetWide(pnl:GetTall() - 4)
        avatar:Dock(LEFT)
        local Bava = avatar:Add('DButton')
        Bava:Dock(FILL)
        Bava:SetSize(avatar:GetTall(), avatar:GetTall())
        Bava:SetAlpha(255)
        Bava:SetText("")
        Bava.DoClick = function(p)
            gui.OpenURL("https://steamcommunity.com/profiles/" .. data.s64)
        end

        Bava.Paint = function(p, w, h)
            if p:IsHovered() then
                surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
                surface.DrawOutlinedRect(0, 0, w, h, 3 + (2 * math.sin(CurTime() * 4)))
            end
        end

        local lblName = pnl:Add('DLabel')

        if GetIDNames and GetIDNames[data.name] then
            lblName:SetText(GetIDNames[data.name])
        else
            lblName:SetText(data.name)
        end

        lblName:SetFont('ActMod_a1')
        lblName:SetExpensiveShadow(1, color_black)
        lblName:Dock(FILL)

        if data.rainbow then
            lblName.Think = function(p)
                p:SetTextColor(HSVToColor((CurTime() * 16) % 360, 1, 1))
            end
        else
            lblName:SetTextColor(data.color or color_white)
        end

        A_AM.ActMod:GetNameA(data.s64, function(Gname, Gonln)
            if IsValid(lblName) and Gname ~= "nonE" then
                GetIDNames[data.name] = Gname
                lblName:SetText(GetIDNames[data.name])
            end

            if IsValid(avatar) and Gonln ~= "nonE" then
                local lbOnli = vgui.Create('DPanel', pnl)
                lbOnli:SetText("")
                lbOnli:SetSize(20, 20)
                lbOnli:SetPos(-10, avatar:GetTall() - 30)

                if string.find(Gonln, "Online") or string.find(Gonln, "In-") then
                    lbOnli.Gnow = 2
                elseif string.find(string.sub(Gonln, 1, 7), "Offline") then
                    lbOnli.Gnow = 1
                else
                    lbOnli.Gnow = 0
                end

                lbOnli.Paint = function(p, w, h)
                    if p.Gnow == 2 then
                        draw.RoundedBox(10, 0, 0, w, h, Color(10, 10, 10, 100 + (100 * math.sin(CurTime() * 5))))
                        draw.RoundedBox(8, 2, 2, w - 4, h - 4, p:IsHovered() and Color(50, 255, 200, 255) or Color(50, 220, 150, 200 + (55 * math.sin(CurTime() * 5))))

                        CTxtMos(p, nil, {20, 150, 50, 140}, "Online", "CreditsText", 1)
                    elseif p.Gnow == 1 then
                        draw.RoundedBox(10, 0, 0, w, h, Color(10, 10, 10, 100 + (100 * math.sin(CurTime() * 5))))
                        draw.RoundedBox(8, 2, 2, w - 4, h - 4, p:IsHovered() and Color(200, 100, 0, 255) or Color(120, 0, 0, 200 + (55 * math.sin(CurTime() * 5))))

                        CTxtMos(p, nil, {100, 100, 50, 140}, "Offline", "CreditsText", 1)
                    else
                        draw.RoundedBox(10, 0, 0, w, h, Color(255, 40, 0, 255))
                    end
                end
            end
        end)
    end

    if data.desc then
        local lblDesc = pnl:Add('DLabel')
        lblDesc:SetText(data.desc)
        lblDesc:SetFont('ActMod_a5')
        lblDesc:SetExpensiveShadow(1, color_black)
        lblDesc:Dock(BOTTOM)
    end
end

function A_AM.ActMod:ShowM_iconActs(self, Ty)
    if not IsValid(self.OptMenu) then return end

    if IsValid(self.ShowMenuiA) then
        self.ShowMenuiA:Remove()
    end

    local NoSc1 = false

    if Ty.url == "LogsUpdt" then
        NoSc1 = true
    end

    self.ShowMenuiA = vgui.Create("DFrame")
    self.ShowMenuiA:SetTitle("")
    self.ShowMenuiA:SetSize(450, 490)
    self.ShowMenuiA:SetAlpha(0)
    self.ShowMenuiA:Center()
    self.ShowMenuiA:MakePopup()
    self.ShowMenuiA:MoveTo(ScrW() / 2 + 150 - self.ShowMenuiA:GetWide() / 2, ScrH() / 2 - self.ShowMenuiA:GetTall() / 2, 0.3)
    self.ShowMenuiA:AlphaTo(255, 0.2)
    self.ShowMenuiA.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(110, 139, 155, 250))
        draw.RoundedBox(6, 5, 2.5, w - 9, h - 5, Color(20, 20, 20, 250))

        if NoSc1 == true then
            surface.SetDrawColor(Color(255, 255, 255, 255))
            surface.SetMaterial(Material("actmod/imenu/p_yn.png", "noclamp smooth"))
            surface.DrawTexturedRect(15, 15, 50, 50)
        end
    end

    local Stxt = vgui.Create("DLabel", self.ShowMenuiA)

    if NoSc1 == true then
        Stxt:SetPos(70, 25)
    else
        Stxt:SetPos(60, 15)
    end

    if GetIDNames and GetIDNames[Ty.name] then
        Stxt:SetText(" " .. GetIDNames[Ty.name] .. " ")
    else
        Stxt:SetText(" " .. Ty.name .. " ")
    end

    Stxt:SetFont("ActMod_a1")
    Stxt:SetTextColor(Color(255, 255, 215))
    Stxt:SizeToContents()

    Stxt.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(70, 80, 50, 250))
    end

    if NoSc1 == false then
        local avatar = self.ShowMenuiA:Add('AvatarImage')
        avatar:SetSteamID(Ty.s64, 64)
        avatar:SetPos(10, 7)
        avatar:SetSize(40, 40)
    end

    local function as2_ss(asa)
        local frame = vgui.Create('DPanel', asa)

        if NoSc1 == true then
            frame:SetPos(10, 70)
            frame:SetSize(asa:GetWide() - 20, asa:GetTall() - 80)
        else
            frame:SetPos(10, 50)
            frame:SetSize(asa:GetWide() - 20, asa:GetTall() - 60)
        end

        frame.Paint = function(p, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(40, 50, 30, 155))
        end

        local plist = frame:Add('AM4_DScrollPanel')
        plist:Dock(FILL)

        local function addi(plist, al, nRe)
            for k, v in pairs(al or {}) do
                ic_dit(plist, Ty, nRe and v or ReString(v))
            end
        end

        local function a2w(tp2)
			local GTTebl_i = {}
			local GTTebl_n = 0

			for k, v in pairs(file.Find("materials/" .. ASettings["IconsActs"] .. "/" .. tp2 .. "*", "GAME")) do
				if string.find(string.sub(v, -4, -1), ".png") then
					table.insert(GTTebl_i, string.Replace(v, ".png", ""))
					GTTebl_n = GTTebl_n + 1
				end
			end

			ic_dit(plist, Ty, GTTebl_i[1])
			GTTebl_i = nil
			GTTebl_n = nil
		end
        local function addiT(al, tp, tp2)
            for k, v in ipairs(al) do
                if tp2 and (istable(tp2) and A_AM.ActMod:ATabData(tp2, v) == true or isstring(tp2) and v == tp2) then
					a2w(v)
                elseif tp and (istable(tp) and A_AM.ActMod:ATabData(tp, v) == true or isstring(tp) and v == tp) then
                    ic_dit(plist, Ty, v .. "._so_.")
                else
					local reNme
					for k2, v2 in ipairs(file.Find("materials/" .. ASettings["IconsActs"] .. "/*", "GAME")) do
						if not reNme and string.find(v2, v,nil,true) then
							v2 = string.Replace(v2, ".png", "")
							if string.find(v2, "._so_.",nil,true) and string.find(v2, "._ef_.",nil,true) and string.find(v2, "._mo_.",nil,true) then
								reNme = v2
							elseif string.find(v2, "._so_.",nil,true) and string.find(v2, "._ef_.",nil,true) then
								reNme = v2
							elseif string.find(v2, "._so_.",nil,true) then
								reNme = v2
							elseif string.find(v2, "._ef_.",nil,true) then
								reNme = v2
							end
						end
					end
					if not reNme then reNme = ReString(v) end
                    if reNme and reNme ~= "" then ic_dit(plist, Ty, reNme) end
                end
            end
        end

        if NoSc1 == true then
			
            if Ty.upV == "v9.5" then
                local T1 = { ["aFont"] = 'ActMod_a2' ,["TextColor"] = Color(100,200,255) ,["aCA"] = 4 }
                local T2 = { ["aFont"] = 'ActMod_a4' ,["TextColor"] = Color(200,200,200) ,["aCA"] = 7 }
                title(plist, "Some problems and bugs have been fixed :",T1)
                title(plist, "- Fixed an issue recognizing animations in DynaBase.",T2)
                title(plist, "- Fixed an issue with the body appearing while using ActMod with Draconic Base",T2)
                title(plist, "- Fixed an issue with repeating the music/song with the dance.",T2)
                title(plist, "- Fixed some bugs in achievements.",T2)
                title(plist, "- Fixed some errors that cause slow servers.",T2)
                title(plist, "- Fixed some bugs in programming (hooks).",T2)
                title(plist, "- Fixed the problem in searching for emotes.",T2)
                title(plist, "- Fixed the small or large icons or the emots list that does not fit the screen size.",T2)
                title(plist, "Some things have been improved :",T1)
                title(plist, "- Some things have been improved.",T2)
                title(plist, "- Shortcut buttons have been added to use Act without showing the menu.",T2)
                title(plist, "- Smooth camera settings have been added.",T2)
                title(plist, "- Achievements settings have been added to enable or disable them.",T2)
                title(plist,"")
                title(plist, "-==[   Version 9.5  {".. A_AM.ActMod:ATabDataGNum( A_AM.ActMod.ActoldV__v9_5 ) .."}   ]==-")
                addiT(A_AM.ActMod.ActoldV__v9_5, nil, {"amod_fortnite_cerealbox","amod_fortnite_cyclone"})
            elseif Ty.upV == "v9.6" then
                local T1 = { ["aFont"] = 'ActMod_a2' ,["TextColor"] = Color(100,200,255) ,["aCA"] = 4 }
                local T2 = { ["aFont"] = 'ActMod_a4' ,["TextColor"] = Color(200,200,200) ,["aCA"] = 7 }
                title(plist, "Some problems and bugs have been fixed :",T1)
                title(plist, "- Fixed the issue of the menu/emotes wheel sometimes not working.",T2)
                title(plist, "Some things have been improved :",T1)
                title(plist, "- A setting has been added to enable/disable loading after joining the map.",T2)
                title(plist, "- A favorite category has been added, so you can save/add some of your Emotes in it",T2)
                title(plist, " so you don't search for it again in other categories.",T2)
                title(plist, "- Camera height control has been added by holding the E key",T2)
                title(plist, " and rotating the mouse wheel.",T2)
                title(plist,"")
                title(plist, "-==[   Version 9.6  {".. A_AM.ActMod:ATabDataGNum( A_AM.ActMod.ActoldV__v9_6 ) .."}   ]==-")
                addiT(A_AM.ActMod.ActoldV__v9_6)
            elseif Ty.upV == "v9.7" then
                local T1 = { ["aFont"] = 'ActMod_a2' ,["TextColor"] = Color(100,200,255) ,["aCA"] = 4 }
                local T2 = { ["aFont"] = 'ActMod_a4' ,["TextColor"] = Color(200,200,200) ,["aCA"] = 7 }
                title(plist, "Some problems and bugs have been fixed :",T1)
                title(plist, "- Fixed some bugs that conflict with other addons (I hope it reduces bugs).",T2)
                title(plist, "- Fixed an issue with Glue Library - Action Extension",T2)
                title(plist, "   (Conflicts with the animation speed system)",T2)
                title(plist, "- Fixed some errors or conflicts with other addons for the camera system.",T2)
                title(plist, "- Fixed The problem of repeating the message completing the achievement",T2)
                title(plist, "   (Instead of repeating the message because there is a problem with saving,",T2)
                title(plist, "   a message will be shown in the chat only once about that achievement",T2)
                title(plist, "   whose progress was not saved).",T2)
                title(plist, "Improvements and new features :",T1)
                title(plist, "- The ActMod system has now become advanced,",T2)
                title(plist, "   making it able to make players dance in sync.",T2)
                title(plist, "- Reduce  (efforts / processor consumption)  on the server.",T2)
                title(plist, "- The animation synchronization has become good or perfect.",T2)
                title(plist, "- Improvements in ActMod which gives a better experience (better than the old version)",T2)
                title(plist, "   and reduces response time with the client that has high Ping.",T2)
                title(plist, "   (there are some dances that allow the other to dance with him).",T2)
                title(plist, "- It now works with the VR system  (but not completely).",T2)
                title(plist, "- A system has been added that automatically deals with PM in different sizes",T2)
                title(plist, "   of Emotes that include models (does not work well with all PMs).",T2)
                title(plist, "- The system for searching for Emote/Dance has been improved.",T2)
                title(plist, '- "Turkey" language has been added.',T2)
                title(plist, "- Advanced settings added.",T2)
                title(plist, "- Volume control has been added for both client and server side.",T2)
                title(plist, "- Added settings to try to make ActMod hooks a priority.",T2)
                title(plist, "- You can join in the synchronized dancing with others!",T2)
                title(plist,"")
                title(plist, "-==[   Version 9.7  {".. A_AM.ActMod:ATabDataGNum( A_AM.ActMod.ActoldV__v9_7 ) .."}   ]==-")
                addiT(A_AM.ActMod.ActoldV__v9_7)
            elseif Ty.upV == "v9.8" then
                local T1 = { ["aFont"] = 'ActMod_a2' ,["TextColor"] = Color(100,200,255) ,["aCA"] = 4 }
                local T2 = { ["aFont"] = 'ActMod_a4' ,["TextColor"] = Color(200,200,200) ,["aCA"] = 7 }
                title(plist, "Some errors have been fixed.",T1)
                title(plist, "Improvements and new features.",T1)
                title(plist, "You can find out more on the ActMod page on Steam",T2)
                title(plist,"")
                title(plist, "-==[   Version 9.8  {".. A_AM.ActMod:ATabDataGNum( A_AM.ActMod.ActNewV ) .."}   ]==-")
                addiT(A_AM.ActMod.ActNewV)
            end
        end

        local Stxt2 = vgui.Create("DPanel", frame)
        Stxt2:SetPos(0, 0)
        Stxt2:SetSize(60, 28)
        Stxt2:SetAlpha(0)
        Stxt2:SetText("")
        Stxt2.Paint = function(s, w, h) end
    end

    as2_ss(self.ShowMenuiA)
end



function A_AM.ActMod:as2_ss(self,asa)
	local frame = vgui.Create('DPanel', asa)
	frame:SetPos(10, 60)
	frame:SetSize(asa:GetWide() - 20, asa:GetTall() - 100)

	frame.Paint = function(p, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 50, 150, 150))
	end

	local plist = frame:Add('AM4_DScrollPanel')
	plist:Dock(FILL)
	title(plist, aR:T("LGPly_Credits"))

	credit(plist, {
		name = 'AhmedMake400',
		s64 = '76561199185837385',
		desc = aR:T("LGPly_Aif"),
		url = 'https://steamcommunity.com/sharedfiles/filedetails/?id=2538387266',
		rainbow = true
	}, self)

	title(plist, '')
	title(plist, aR:T("LGPly_Conrs"))

	credit(plist, {
		name = 'SheepyLord',
		s64 = '76561198282841113',
		desc = aR:T("LGPly_Expns")
	}, self)

	credit(plist, {
		name = 'Kona疏',
		s64 = '76561199042844827',
		desc = aR:T("cr_txtadf_")
	}, self)

	title(plist, '')
	title(plist, aR:T("LGPly_AdLa"))

	credit(plist, {
		name = 'AhmedMake400',
		s64 = '76561199185837385',
		desc = aR:T("cr_txtAL_") .. "   China"
	}, self)

	credit(plist, {
		name = 'MoistCr1tikal',
		s64 = '76561198071567487',
		desc = aR:T("cr_txtAL_") .. "   Russian"
	}, self)

	credit(plist, {
		name = 'NextKuromeThe76Soldier',
		s64 = '76561197960487064',
		desc = aR:T("cr_txtAL_") .. "   Germany"
	}, self)

	credit(plist, {
		name = 'Tora',
		s64 = '76561198443702005',
		desc = aR:T("cr_txtAL_") .. "   Turkish"
	}, self)

	title(plist, '')
	title(plist, aR:T("LGPly_InfoActMod"))

	credit(plist, {
		Az = 50,
		name = aR:T("LGPly_Info_upV") .. "  v9.8",
		tname = aR:T("AL_i_iefoV2") .. "  v9.8 ) ,",
		icon = "icon32/folder.png",
		url = "LogsUpdt",
		upV = "v9.8"
	}, self)
	credit(plist, {
		Az = 30,
		name = aR:T("LGPly_Info_upV") .. "  v9.7",
		tname = aR:T("AL_i_iefoV2") .. "  v9.7 ) ,",
		icon = "icon32/folder.png",
		url = "LogsUpdt",
		upV = "v9.7"
	}, self)
	credit(plist, {
		Az = 30,
		name = aR:T("LGPly_Info_upV") .. "  v9.6",
		tname = aR:T("AL_i_iefoV2") .. "  v9.6 ) ,",
		icon = "icon32/folder.png",
		url = "LogsUpdt",
		upV = "v9.6"
	}, self)
	credit(plist, {
		Az = 30,
		name = aR:T("LGPly_Info_upV") .. "  v9.5",
		tname = aR:T("AL_i_iefoV2") .. "  v9.5 ) ,",
		icon = "icon32/folder.png",
		url = "LogsUpdt",
		upV = "v9.5"
	}, self)

	title(plist, '')

	return frame
end

A_AM.ActMod.LuaVgi_MAbout_Done = true
