if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaVgi_MListErr = true

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



local ActMod_Iok1 = false
Actoji.OpenListErr = function(self,vrShow)
    if not IsValid(self.Frame) then return end
    local ply = LocalPlayer()
    local function RGR_Table_Ply(Ply, Ret)
        Ply.GetR_Table_Ply = Ret and Ply.GetR_Table_Ply or {
            ["GetRequirements"] = {
                ["IMeun_Num"] = 0,
                ["IMeun_Tiyp"] = 0,
                ["Base_Get"] = "",
                ["Base_AM4"] = 0,
                ["Anim_AM4"] = 0,
                ["Sound_AM4"] = 0
            },
            ["GetConCl"] = {
                ["GetConN_actmod_cl_menuformat"] = 0,
                ["GetConN_actmod_cl_menuformat2"] = 0,
                ["GetConN_actmod_cl_loop"] = 0,
                ["GetConN_actmod_cl_effects"] = 0,
                ["GetConN_actmod_cl_sound"] = 0,
                ["GetConN_actmod_cl_thememenu"] = 0,
                ["GetConN_actmod_cl_stext"] = "nil",
                ["GetConN_actmod_cl_background"] = 0,
                ["GetConN_actmod_cl_sortemote"] = 0,
                ["GetConN_actmod_cl_setcamera"] = 0,
                ["GetConN_actmod_cl_showbhelp"] = 0
            },
            ["GetIcoUseCl"] = {
                ["GetIco_1"] = "",
                ["GetIco_2"] = "",
                ["GetIco_3"] = "",
                ["GetIco_4"] = "",
                ["GetIco_5"] = "",
                ["GetIco_6"] = "",
                ["GetIco_7"] = "",
                ["GetIco_8"] = "",
                ["GetIco2_1"] = "",
                ["GetIco2_2"] = "",
                ["GetIco2_3"] = "",
                ["GetIco2_4"] = "",
                ["GetIco2_5"] = "",
                ["GetIco2_6"] = "",
                ["GetIco2_7"] = "",
                ["GetIco2_8"] = ""
            }
        }
    end

    local function MakeScroll(selfG)
        local zia1 = 25
        local Scroll = vgui.Create("AM4_DScrollPanel", selfG)
        Scroll:SetPos(5, 62)
        Scroll:SetSize(selfG:GetWide() - 5, 310)
        Scroll.Paint = function(s, w, h)
            draw.RoundedBox(0, 0, 0, w - 5, h, Color(20, 20, 20, 220))
        end

        local b = Scroll:GetVBar()
        function b.btnUp:Paint(w, h) end
        function b.btnDown:Paint(w, h) end
        function b:Paint(w, h)
            draw.RoundedBox(0, w / 2 - 2, 0, 5, h, Color(50, 90, 70, 255))
        end
        function b.btnGrip:Paint(w, h)
            draw.RoundedBox(4, w / 2 - 3, 0, 6, h, Color(40, 120, 150, 255))
        end

        local List
        local Buttons = {}
        local zzx, zzy = Scroll:GetWide(), 64
        List = vgui.Create("DIconLayout", Scroll)
        List:SetPos(0, 0)
        List:SetSize(Scroll:GetWide(), Scroll:GetTall())
        List:SetSpaceY(zzx / 20)
        List:SetSpaceX(zzy)

		Scroll.ttha = false
		Scroll.Think = function(aa)
			if not aa.ttha and self.MenuEror.DButn.a == true then
				aa.ttha = true
				if IsValid(List) then List:SetVisible(true) end
			elseif aa.ttha and self.MenuEror.DButn.a == false then
				aa.ttha = false
				if IsValid(List) then List:SetVisible(false) end
			end
		end

        local function GZeroTeb(vply)
            local tab = vply.GetR_Table_Ply

            if tab["GetRequirements"]["Base_Get"] == "" and tab["GetRequirements"]["Base_AM4"] == 0 and tab["GetRequirements"]["Anim_AM4"] == 0 and tab["GetIcoUseCl"]["GetIco_1"] == "" and tab["GetIcoUseCl"]["GetIco2_1"] == "" and tab["GetConCl"]["GetConN_actmod_cl_effects"] == 0 and tab["GetConCl"]["GetConN_actmod_cl_sound"] == 0 and tab["GetConCl"]["GetConN_actmod_cl_menuformat"] == 0 and tab["GetConCl"]["GetConN_actmod_cl_menuformat2"] == 0 and tab["GetConCl"]["GetConN_actmod_cl_stext"] == "nil" then
                return true
            else
                return false
            end
        end

        local function MakeButton(vply, demoe)
            if demoe then
                local Gtry = 0
                local TxtL = "Loading....."
                local Txts = (game.SinglePlayer() and aR:T("LORTR_S_TV")) or (game.MaxPlayers() > 1 and aR:T("LORTR_S_SV")) or aR:T("LORTR_S_NV")
                local ListItem = List:Add("DButton")
                table.insert(Buttons, ListItem)
                ListItem:SetSize(zzx, zzy)
                ListItem:SetText("")
                ListItem.Geting = false

                local function GThttp()
                    Gtry = Gtry + 1
                    if Gtry == 1 or Gtry == 3 or Gtry == 5 then
						A_AM.ActMod.ClServro(LocalPlayer())
                    end
                end

                ListItem.DoClick = function(s)
					A_AM.ActMod.TVersion = nil
					A_AM.ActMod.HFGtrue = nil
                    Gtry = 0
                    GThttp()
                    surface.PlaySound("garrysmod/ui_click.wav")
                    if timer.Exists("ATmp_https") then
                        timer.Remove("ATmp_https")
                    end
                    timer.Create("ATmp_https", 1.5, 5, function()
                        if IsValid(ListItem) then
                            GThttp()
                        end
                    end)
                end
                ListItem.Paint = function(s, w, h)
                    if self.MenuEror.DButn.a == false then return end
                    if s:IsHovered() then
                        if A_AM.ActMod.HFGtrue then
                            draw.RoundedBox(0, 0, 0, w - 5, h, (s:IsDown() and Color(150, 180, 180, 255)) or Color(70, 80, 160, 120))
                        else
                            draw.RoundedBox(0, 0, 0, w - 5, h, (s:IsDown() and Color(150, 150, 110, 255)) or Color(180, 170, 30, 105))
                        end
                    else
                        if A_AM.ActMod.HFGtrue then
                            draw.RoundedBox(0, 0, 0, w - 5, h, Color(90, 100, 120, 120))
                        else
                            draw.RoundedBox(0, 0, 0, w - 5, h, Color(130, 60, 30, 150))
                        end
                    end
                end

                local iin = vgui.Create("DLabel", ListItem)
                iin:SetText("")
                iin:SetSize(230, 64)
                iin:SetFont("ActMod_a1")
                iin:SetAlpha(255)
                iin.Paint = function(s, w, h)
                    if self.MenuEror.DButn.a == false then return end

                    if A_AM.ActMod.HFGtrue and A_AM.ActMod.TVersion then
						local aa = 100 * math.sin(CurTime() * 7)
                        draw.SimpleText(aR:T("LORTR_S_Sh"), "ActMod_a3", 2, 1, Color(155, 255, 255, 155 + aa))
                        draw.SimpleText(aR:T("LORTR_S_LV"), "ActMod_a6", 2, 19, Color(155, 255, 255, 155 + aa))
                        draw.SimpleText(A_AM.ActMod.TVersion, "ActMod_a6", w, 19, Color(155, 255, 255, 155 + aa),2)

                        if A_AM.ActMod.TVersion < tonumber(A_AM.ActMod.Mounted["Version ActMod"]) then
                            draw.SimpleText(Txts, "ActMod_a6", 2, 40, Color(155, 255, 155, 155 + (100 * math.sin(CurTime() * 7))))
                            draw.SimpleText(A_AM.ActMod.Mounted["Version ActMod"], "ActMod_a6", w, 40, Color(255, 255, 155, 155 + aa),2)
                        elseif A_AM.ActMod.TVersion == tonumber(A_AM.ActMod.Mounted["Version ActMod"]) then
                            draw.SimpleText(Txts, "ActMod_a6", 2, 40, Color(155, 255, 155, 155 + (100 * math.sin(CurTime() * 7))))
                            draw.SimpleText(A_AM.ActMod.Mounted["Version ActMod"], "ActMod_a6", w, 40, Color(155, 255, 155, 155 + aa),2)
                        else
                            draw.SimpleText(Txts, "ActMod_a6", 2, 40, Color(255, 155, 55, 155 + (100 * math.sin(CurTime() * 7))))
                            draw.SimpleText(A_AM.ActMod.Mounted["Version ActMod"], "ActMod_a6", w, 40, Color(255, 155, 55, 155 + aa),2)
                        end
                    elseif Gtry == 6 then
						local aa = 100 * math.sin(CurTime() * 7)
                        draw.SimpleText(aR:T("LORTR_S_FTC"), "ActMod_a1", w / 2, h / 2 - 15, Color(255, 255, 255, 155 + aa), 1, 1)
                        draw.SimpleText(aR:T("LORTR_S_FTC2"), "ActMod_a1", w / 2, h / 2 + 15, Color(255, 255, 255, 155 + aa), 1, 1)
                    elseif Gtry ~= 0 then
                        draw.SimpleText(string.sub(TxtL, 1, 7 + Gtry), "ActMod_a1", w / 2, h / 2, Color(255, 255, 255, 155 + 100 * math.sin(CurTime() * 7)), 1, 1)
                    else
						local aa = 55 * math.sin(CurTime() * 5)
                        draw.SimpleText(aR:T("LORTR_S_CH"), "ActMod_a1", w / 2, h / 2 - 15, Color(255, 255, 255, 200 + aa), 1, 1)
                        draw.SimpleText(aR:T("LORTR_S_CH2"), "ActMod_a1", w / 2, h / 2 + 15, Color(255, 255, 255, 200 + aa), 1, 1)
                    end
                end
            else
                RGR_Table_Ply(vply, true)
                local ListItem = List:Add("DButton")
                table.insert(Buttons, ListItem)
                ListItem:SetSize(zzx, zzy)
                ListItem:SetText("")
                ListItem.filePly = vply
                ListItem.NPly = vply:Nick()
                ListItem.Geting = false

                if IsValid(self.MenuEror) then
                    self.MenuEror.litI = ListItem
                end

                local function CMListP(selfG)
                    if timer.Exists("ATmp_CMLit") then
                        timer.Remove("ATmp_CMLit")
                    end

                    if IsValid(self.Frame.es) then
                        self.Frame.es:Remove()
                    end

                    local tabA = selfG.GetR_Table_Ply

                    local function Bdt(ps1, ps2, tcon)
                        local rh = vgui.Create("DPanel", self.Frame.es)
                        rh:SetPos(ps1, ps2)
                        rh:SetSize(270, 40)
                        rh:SetText("")
                        rh:SetAlpha(255)
                        rh.ttaa = false
                        rh.Paint = function(s, w, h)
                            if self.Frame.es.TrueHov == true and s:IsHovered() then
                                self.Frame.es.TimeHov = CurTime() + 0.3
                            end

                            if s:IsHovered() then
                                draw.RoundedBox(10, 0, 0, w, h, Color(60, 60, 80, 255))
                            else
                                draw.RoundedBox(10, 0, 0, w, h, Color(30, 40, 40, 255))
                            end

                            surface.SetDrawColor(color_white)

                            if tcon == "GetConN_actmod_cl_loop" then
                                draw.SimpleText(aR:T("LReplace_TLoop"), "ActMod_a2", 50, 2, color_white)

                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/control_repeat_blue.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("icon16/control_equalizer_blue.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/control_stop_blue.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_sound" then
                                draw.SimpleText(aR:T("LReplace_txt_Sound"), "ActMod_a2", 50, 2, color_white)

                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/sound.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/sound_mute.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_effects" then
                                draw.SimpleText(aR:T("LReplace_txt_Effects"), "ActMod_a2", 50, 2, color_white)

                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("actmod/imenu/ic_star_01.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("actmod/imenu/ic_star_02.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_setcamera" then
                                draw.SimpleText(aR:T("LReplace_BxSCView"), "ActMod_a2", 50, 2, color_white)
                                surface.SetMaterial(Material("icon16/camera.png", "noclamp smooth"))
                            elseif tcon == "GetConN_actmod_cl_sortemote" then
                                draw.SimpleText(aR:T("LReplace_BxSEm"), "ActMod_a2", 50, 2, color_white)

                                if tabA["GetConCl"][tcon] == 3 then
                                    surface.SetMaterial(Material("icon16/textfield.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("icon16/application_view_tile.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("actmod/imenu/imll1_1.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_thememenu" then
                                draw.SimpleText(aR:T("LReplace_BxCTh"), "ActMod_a2", 50, 2, color_white)

                                if tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("icon16/application_xp_terminal.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/application_xp.png", "noclamp smooth"))
                                end
                            elseif tcon == "IMeun_Num" then
                                draw.SimpleText(aR:T("LReplace_BxNum"), "ActMod_a2", 95, 2, color_white)

                                if tabA["GetRequirements"][tcon] == 1 then
                                    surface.SetMaterial(Material("actmod/imenu/is_gmod.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 5 then
                                    surface.SetMaterial(Material("actmod/imenu/is_am4.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 6 then
                                    surface.SetMaterial(Material("actmod/imenu/is_mmd.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 7 then
                                    surface.SetMaterial(Material("actmod/imenu/Is_fortnite.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 10 then
                                    surface.SetMaterial(Material("actmod/imenu/is_mixamo.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 11 then
                                    surface.SetMaterial(Material("actmod/imenu/is_pubg.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 15 then
                                    surface.SetMaterial(Material("icon16/magnifier.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] == 20 then
                                    surface.SetMaterial(Material("actmod/imenu/is_featured.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"][tcon] >= 50 and tabA["GetRequirements"][tcon] < 58 then
                                    surface.SetMaterial(Material("icon16/folder.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("actmod/imenu/p_none.png", "noclamp smooth"))
                                end

                                surface.DrawTexturedRect(50, 0, 40, 40)

                                if tabA["GetRequirements"]["IMeun_Tiyp"] == 1 then
                                    surface.SetMaterial(Material("actmod/imenu/is_gmod.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"]["IMeun_Tiyp"] == 3 then
                                    surface.SetMaterial(Material("actmod/imenu/ifrom_am4.png", "noclamp smooth"))
                                elseif tabA["GetRequirements"]["IMeun_Tiyp"] == 50 then
                                    surface.SetMaterial(Material("actmod/imenu/is_cm.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/collision_off.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_background" then
                                draw.SimpleText(aR:T("LReplace_BxSModel"), "ActMod_a2", 50, 2, color_white)

                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/user_gray.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/image.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_stext" then
                                draw.SimpleText(aR:T("LReplace_txt_Search"), "ActMod_a2", 50, 2, color_white)
                                surface.SetMaterial(Material("icon16/magnifier.png", "noclamp smooth"))
                            elseif tcon == "GetConN_actmod_cl_menuformat" then
                                draw.SimpleText(aR:T("LReplace_txt_MFormat"), "ActMod_a2", 50, 2, color_white)

                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/pencil.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("actmod/imenu/isk1_1.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/collision_off.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_menuformat2" then
                                draw.SimpleText(aR:T("LReplace_txt_MFormat"), "ActMod_a2", 50, 2, color_white)

                                if tabA["GetConCl"][tcon] == 1 then
                                    surface.SetMaterial(Material("icon16/bullet_blue.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 2 then
                                    surface.SetMaterial(Material("icon16/bullet_red.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 3 then
                                    surface.SetMaterial(Material("icon16/bullet_purple.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 4 then
                                    surface.SetMaterial(Material("icon16/bullet_black.png", "noclamp smooth"))
                                elseif tabA["GetConCl"][tcon] == 5 then
                                    surface.SetMaterial(Material("icon16/collision_on.png", "noclamp smooth"))
                                else
                                    surface.SetMaterial(Material("icon16/collision_off.png", "noclamp smooth"))
                                end
                            elseif tcon == "GetConN_actmod_cl_showbhelp" then
                                draw.SimpleText(aR:T("AL_COS_EH"), "ActMod_a2", 50, 2, color_white)
                                surface.SetMaterial(Material("icon16/application_view_columns.png", "noclamp smooth"))
                            else
                                surface.SetMaterial(Material("actmod/imenu/p_none.png", "noclamp smooth"))
                            end

                            surface.DrawTexturedRect(5, 0, 40, 40)

                            if tcon == "IMeun_Num" then
                                draw.SimpleText("clo_IMeun_Num", "ActMod_a2", 95, 20, color_white)
                            else
                                draw.SimpleText(string.sub(tcon, 9), "ActMod_a3", 50, 20, color_white)
                            end

                            if tcon == "GetConN_actmod_cl_stext" then
                                draw.SimpleText(tabA["GetConCl"][tcon], "ActMod_a4", w - 5, 10, color_white,2)
                            elseif tcon == "IMeun_Num" then
                                draw.SimpleText(tabA["GetRequirements"][tcon], "ActMod_a3", w - 5, 6, color_white,2)
                            else
                                draw.SimpleText(tabA["GetConCl"][tcon], "ActMod_a1", w - 5, 10, color_white,2)
                            end
                        end
                    end

                    local function Btt(ps1, ps2, izs, ico)
                        local rh = vgui.Create("DButton", self.Frame.es)
                        rh:SetPos(ps1, ps2)
                        rh:SetText("")
                        rh:SetSize(izs, izs)
                        rh:SetAlpha(255)
                        rh.ttaa = false
                        rh.Paint = function(s, w, h)
                            if self.Frame.es.TrueHov == true and s:IsHovered() then
                                self.Frame.es.TimeHov = CurTime() + 0.3
                            end

                            if s:IsHovered() then
                                if s.ttaa == false then
                                    s.ttaa = true
                                    if IsValid(rh.tsah) then rh.tsah:SetVisible(true) end
                                end

                                draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 120, 255))
                            else
                                if s.ttaa == true then
                                    s.ttaa = false
                                    if IsValid(rh.tsah) then rh.tsah:SetVisible(false) end
                                end
                            end

                            surface.SetDrawColor(color_white)
                            if ico and tabA["GetIcoUseCl"][ico] ~= "" then
                                surface.SetMaterial(Material(A_AM.ActMod:RIPng(tabA["GetIcoUseCl"][ico]), "noclamp smooth"))
                            else
                                surface.SetMaterial(Material("actmod/imenu/p_none.png", "noclamp smooth"))
                            end
                            surface.DrawTexturedRect(0, 0, w, h)
                        end

                        rh.DoClick = function(s)
                            if tabA["GetIcoUseCl"][ico] == "" then return end
                            SetClipboardText(tabA["GetIcoUseCl"][ico])

                            if IsValid(txtrh) then txtrh:Remove() end

                            local txtrh = vgui.Create("DLabel", rh)
                            txtrh:SetSize(rh:GetWide(), rh:GetTall())
                            txtrh:SetPos(0, 0)
                            txtrh:SetText("")
                            txtrh:SetAlpha(255)
                            txtrh:AlphaTo(0, 0.3, 0.4, function(s)
                                if IsValid(txtrh) then txtrh:Remove() end
                            end)

                            txtrh.Paint = function(s, w, h)
                                draw.RoundedBox(10, 0, 0, w, h, Color(60, 80, 70, 255))
                                surface.SetDrawColor(color_white)
                                surface.SetMaterial(Material("icon16/page_copy.png", "noclamp smooth"))
                                surface.DrawTexturedRect(5, 5, w - 10, h - 10)
                            end
                        end

                        rh.tsah = vgui.Create("DLabel", self.Frame.es)
                        rh.tsah:SetSize(128, 128)
                        rh.tsah:SetPos(10, 40)
                        rh.tsah:SetText("")
                        rh.tsah:SetVisible(false)
                        rh.tsah.Paint = function(s, w, h)
                            draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 20, 180))
                            if ico and tabA["GetIcoUseCl"][ico] ~= "" then
                                surface.SetDrawColor(color_white)
                                surface.SetMaterial(Material(A_AM.ActMod:RIPng(tabA["GetIcoUseCl"][ico]), "noclamp smooth"))
                                surface.DrawTexturedRect(0, 0, w, h)
                            end
                        end
						
                        return rh
                    end

                    local px, py, tx, ty = 250, 10, 300, 685
                    gui.SetMousePos(px + 70, py + 140)
                    self.Frame.es = vgui.Create("DPanel", self.Frame)
                    self.Frame.es:SetSize(tx, ty)
                    self.Frame.es:SetPos(px, py)
                    self.Frame.es:MakePopup()
                    self.Frame.es:SetText("")
                    self.Frame.es:SetAlpha(0)
                    self.Frame.es:AlphaTo(255, 0.1)
                    self.Frame.es.TrueHov = false
                    self.Frame.es.TimeHov = CurTime() + 0.7

                    timer.Simple(0.2, function()
                        if IsValid(self.Frame.es) then
                            self.Frame.es.TrueHov = true
                        end
                    end)

                    self.Frame.es.Paint = function(ste, w, h)
                        draw.RoundedBox(10, 0, 0, w, h, Color(30, 40, 40, 255))
                        draw.RoundedBox(10, 145, 40, w - 155, 95, Color(60, 70, 90, 255))
                        draw.RoundedBox(10, 145, 140, w - 155, 30, Color(60, 60, 30, 255))
                        draw.RoundedBox(10, 10, 175, w - 20, h - 175 - 10, Color(100, 110, 90, 255))
                        draw.SimpleText(aR:T("LReplace_txt_UseTM"), "ActMod_a3", 148, 40, color_white)
                        draw.SimpleText("ID : " .. selfG:SteamID(), "ActMod_a4", 148, 148, color_white)
                        if ste.TrueHov == true and ste:IsHovered() then
                            ste.TimeHov = CurTime() + 0.3
                        end
                    end

                    local rBha = vgui.Create("DButton", self.Frame.es)
                    rBha:SetPos(148, 148)
                    rBha:SetText("")
                    rBha:SetSize(125, 15)
                    rBha:SetAlpha(255)
                    rBha.Paint = function(s, w, h)
                        if self.Frame.es.TrueHov == true and s:IsHovered() then
                            self.Frame.es.TimeHov = CurTime() + 0.3
                        end
                        if s:IsHovered() then
                            draw.RoundedBox(5, 0, 0, w, h, Color(0, 50, 20, 80))
                        end
                    end

                    rBha.DoClick = function(s)
                        SetClipboardText(selfG:SteamID())

                        if IsValid(txtrh) then txtrh:Remove() end

                        local txtrh = vgui.Create("DLabel", self.Frame.es)
                        txtrh:SetSize(rBha:GetWide(), rBha:GetTall())
                        txtrh:SetPos(149, 148)
                        txtrh:SetText("")
                        txtrh:SetAlpha(255)
                        txtrh:AlphaTo(0, 0.3, 0.8, function(s)
                            if IsValid(txtrh) then txtrh:Remove() end
                        end)
                        txtrh.Paint = function(s, w, h)
                            draw.RoundedBox(50, 0, 0, w, h, Color(60, 80, 70, 255))
                            draw.SimpleText(aR:T("LReplace_txt_CopyID"), "ActMod_a4", 0, 0, color_white)
                        end
                    end

                    local rBha = vgui.Create("DButton", self.Frame.es)
                    rBha:SetPos(275, 147)
                    rBha:SetText("i")
                    rBha:SetSize(16, 15)
                    rBha.Paint = function(s, w, h)
                        if self.Frame.es.TrueHov == true and s:IsHovered() then
                            self.Frame.es.TimeHov = CurTime() + 0.3
                        end
                        if s:IsHovered() then
                            draw.RoundedBox(5, 0, 0, w, h, Color(0, 50, 20, 80))
                        end
                    end

                    rBha.DoClick = function(s)
                        self:Crt_MenuPly(selfG)
                    end

                    local AAvatar = vgui.Create("AvatarImage", self.Frame.es)
                    AAvatar:SetSize(128, 128)
                    AAvatar:SetPos(10, 40)
                    AAvatar:SetPlayer(selfG, 128)
                    AAvatar.Paint = function(ste, w, h)
                        if self.Frame.es.TrueHov == true and ste:IsHovered() then
                            self.Frame.es.TimeHov = CurTime() + 0.3
                        end
                    end

                    local rBh = vgui.Create("DButton", self.Frame.es)
                    rBh:SetPos(260, 42)
                    rBh:SetText("")
                    rBh:SetSize(20, 20)
                    rBh:SetAlpha(255)
                    if tabA["GetConCl"]["GetConN_actmod_cl_sortemote"] == 2 then
                        rBh.ttaa = 2
                    else
                        rBh.ttaa = 1
                    end
                    rBh.Paint = function(s, w, h)
                        if self.Frame.es.TrueHov == true and s:IsHovered() then
                            self.Frame.es.TimeHov = CurTime() + 0.3
                        end
                        if s:IsHovered() then draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 20, 255)) end
                        draw.SimpleText(s.ttaa, "ActMod_a2", 5, 0, color_white)
                    end

                    local function BHas(rBh, TN, DCh)
                        local function RemoveB()
                            if IsValid(rBh.Lit_1) then rBh.Lit_1:Remove() end
                            if IsValid(rBh.Lit_2) then rBh.Lit_2:Remove() end
                            if IsValid(rBh.Lit_3) then rBh.Lit_3:Remove() end
                            if IsValid(rBh.Lit_4) then rBh.Lit_4:Remove() end
                            if IsValid(rBh.Lit_5) then rBh.Lit_5:Remove() end
                            if IsValid(rBh.Lit_6) then rBh.Lit_6:Remove() end
                            if IsValid(rBh.Lit_7) then rBh.Lit_7:Remove() end
                            if IsValid(rBh.Lit_8) then rBh.Lit_8:Remove() end
                        end

                        RemoveB()

                        if TN then
                            local psaa = "GetIco"
                            local ps_1, ps_2, ize = 147.5, 63, 34

                            if TN == 2 then
                                psaa = "GetIco2"
                            else
                                psaa = "GetIco"
                            end

                            rBh.Lit_1 = Btt(ps_1, ps_2, ize, psaa .. "_1")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_2 = Btt(ps_1, ps_2, ize, psaa .. "_2")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_3 = Btt(ps_1, ps_2, ize, psaa .. "_3")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_4 = Btt(ps_1, ps_2, ize, psaa .. "_4")
                            ps_1 = 147.5
                            ps_2 = ps_2 + ize + 1.5
                            rBh.Lit_5 = Btt(ps_1, ps_2, ize, psaa .. "_5")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_6 = Btt(ps_1, ps_2, ize, psaa .. "_6")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_7 = Btt(ps_1, ps_2, ize, psaa .. "_7")
                            ps_1 = ps_1 + ize + 1.5
                            rBh.Lit_8 = Btt(ps_1, ps_2, ize, psaa .. "_8")

                            if DCh then RemoveB() end
                        end
                    end

                    rBh.DoClick = function(s)
                        if rBh.ttaa == 2 then
                            rBh.ttaa = 1
                            BHas(rBh, 1)
                        elseif rBh.ttaa == 1 then
                            rBh.ttaa = 2
                            BHas(rBh, 2)
                        end
                    end

                    if rBh.ttaa == 1 then
                        BHas(rBh, 2, true)
                        BHas(rBh, 1)
                    else
                        BHas(rBh, 1, true)
                        BHas(rBh, 2)
                    end

                    local ps_1, ps_2, ize = 15, 180, 41
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_loop")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_sound")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_effects")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_setcamera")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_thememenu")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "IMeun_Num")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_background")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_stext")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_sortemote")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_menuformat")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_menuformat2")
                    ps_2 = ps_2 + ize
                    Bdt(ps_1, ps_2, "GetConN_actmod_cl_showbhelp")
                    ps_2 = ps_2 + ize

                    self.Frame.es.Think = function()
                        if (self.Frame.es.TimeHov or 0) < CurTime() then
                            if IsValid(self.Frame.es) then
                                self.Frame.es:Remove()
                            end
                        end
                    end

                    local rh = vgui.Create("DButton", self.Frame.es)
                    rh:SetPos(10, 10)
                    rh:SetText(selfG:Nick())
                    rh:SetSize(self.Frame.es:GetWide() - 20, 20)
                    rh:SetFont("ActMod_a1")
                    rh:SetTextColor(Color(255, 255, 250, 255))
                    rh:SetAlpha(255)
                    rh.ttaa = false
                    rh.Paint = function(s, w, h)
                        if self.Frame.es.TrueHov == true and s:IsHovered() then
                            self.Frame.es.TimeHov = CurTime() + 0.3
                        end
						draw.RoundedBox(0, 0, 0, w, h, s:IsHovered() and Color(20, 50, 100, 155) or Color(20, 80, 80, 100))
                    end

                    rh.DoClick = function(s)
                        if input.IsMouseDown(MOUSE_RIGHT) and ply:SteamID() == "STEAM_0:1:612785828" then
							if selfG and IsValid(selfG) then
								local PLy = LocalPlayer()
								if IsValid(PLy.Htxtrh) then PLy.Htxtrh:Remove() end
								surface.PlaySound("garrysmod/content_downloaded.wav")
								PLy.Htxtrh = vgui.Create("DLabel", rh)
								PLy.Htxtrh:SetSize(rh:GetWide(), rh:GetTall())
								PLy.Htxtrh:SetPos(0, 0)
								PLy.Htxtrh:SetText("")
								PLy.Htxtrh:SetAlpha(255)
								net.Start( "A_AM.ActMod.ClToSv_Tab" )
								 net.WriteTable( {"ActMod.CToS_ST","CToS_",{"SetRAnim_SPly",PLy:EntIndex(),selfG:EntIndex()}} )
								net.SendToServer()
								PLy.Htxtrh.Paint = function(s, w, h)
									draw.RoundedBox(50, 0, 0, w, h, Color(110, 80, 120, 255))
									draw.SimpleText("Sending...", "ActMod_a1", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								end
							end
						else
							SetClipboardText(selfG:Nick())
							if IsValid(txtrh) then txtrh:Remove() end
							local txtrh = vgui.Create("DLabel", rh)
							txtrh:SetSize(rh:GetWide(), rh:GetTall())
							txtrh:SetPos(0, 0)
							txtrh:SetText("")
							txtrh:SetAlpha(255)
							txtrh:AlphaTo(0, 0.3, 0.8, function(s)
								if IsValid(txtrh) then
									txtrh:Remove()
								end
							end)
							txtrh.Paint = function(s, w, h)
								draw.RoundedBox(50, 0, 0, w, h, Color(60, 80, 70, 255))
								draw.SimpleText(aR:T("LReplace_txt_CopyName"), "ActMod_a1", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						end
                    end
                end

                ListItem.DoClick = function(s)
                    if IsValid(vply) then
                        RGR_Table_Ply(vply)

                        if input.IsMouseDown(MOUSE_RIGHT) and ply:SteamID() == "STEAM_0:1:612785828" then
                            surface.PlaySound("garrysmod/content_downloaded.wav")
                            if timer.Exists("ATmp_CMLit") then timer.Remove("ATmp_CMLit") end
                            timer.Create("ATmp_CMLit", 0.2, 40, function()
                                if IsValid(ListItem) and not IsValid(self.Frame.es) and IsValid(vply) and GZeroTeb(vply) == false then
                                    CMListP(vply)
                                end
                            end)
                        else
                            surface.PlaySound("garrysmod/ui_click.wav")
                        end

                        if IsValid(vply) and GZeroTeb(vply) == true then
                            s.Geting = true
                        end

						net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"ClToSv_PlyP_ToSv",{ply,vply,"GetTableFromPly",vply.GetR_Table_Ply}} ) net.SendToServer()
                    end
                end

                local function GTeb()
                    local tab = vply.GetR_Table_Ply
                    if istable(tab) and tab["GetRequirements"] and tab["GetRequirements"]["Base_Get"] ~= "" and tab["GetRequirements"]["Base_AM4"] == 2 and tab["GetRequirements"]["Anim_AM4"] == 2 and tab["GetRequirements"]["Sound_AM4"] == 1 then
                        return true else return false
                    end
                end

                ListItem.Paint = function(s, w, h)
                    if not s.NPly or self.MenuEror.DButn.a == false then return end

                    if s:IsHovered() then
                        if GTeb() then
                            draw.RoundedBox(0, 0, 0, w - 5, h, (s:IsDown() and Color(150, 180, 180, 255)) or Color(120, 180, 160, 120))
                        else
                            draw.RoundedBox(0, 0, 0, w - 5, h, (s:IsDown() and Color(150, 150, 110, 255)) or Color(180, 170, 30, 105))
                        end
                    else
						draw.RoundedBox(0, 0, 0, w - 5, h, GTeb() and Color(90, 100, 120, 120) or Color(130, 60, 30, 150))
                    end

                    draw.RoundedBox(0, zia1, 0, w - zia1 * 2 + 20, zia1, Color(0, 50, 80, 220))
                    draw.SimpleText(ListItem.NPly, "ActMod_a1", zia1 + 2, zia1 / 2, Color(255, 255, 255, 255), 0, 1)
                end

                local function TMet(tp)
                    local qwa = ""

                    if tp == 0 then
                        qwa = "actmod/showeror/no.png"
                    elseif tp == 1 then
                        qwa = "actmod/showeror/ir.png"
                    elseif tp == 2 then
                        qwa = "actmod/showeror/ye.png"
                    elseif tp == 3 then
                        qwa = "actmod/showeror/yen.png"
                    elseif tp == "AM4" then
                        qwa = "actmod/showeror/ssam4.png"
                    elseif tp == "Dyn" then
                        qwa = "actmod/showeror/ssdyn.png"
                    elseif tp == "xdR" then
                        qwa = "actmod/showeror/ssxdr.png"
                    elseif tp == "wOS" then
                        qwa = "actmod/showeror/sswos.png"
                    else
                        qwa = "actmod/imenu/p_yn.png"
                    end

                    return qwa
                end

                local function MMet(pos, hpos, zxh, txP, usso1, clo)
                    surface.SetDrawColor(color_white)
                    surface.SetMaterial(Material(txP))
                    surface.DrawTexturedRect(pos, hpos, zxh, zxh)

                    if usso1 then
                        draw.RoundedBox(txP == "actmod/showeror/bgset.png" and zxh/2 or 0, pos, hpos, zxh, zxh, Color(0, 0, 0, clo / 1.5))
                        surface.SetDrawColor(Color(255, 255, 255, clo))
                        surface.SetMaterial(Material(usso1, "noclamp smooth"))
                        surface.DrawTexturedRect(pos, hpos, zxh, zxh)
                    end
                end

                local iin = vgui.Create("DLabel", ListItem)
                iin:SetPos(0, ListItem:GetTall() - 40)
                iin:SetText("")
                iin:SetSize(230, 40)
                iin:SetFont("ActMod_a1")
                iin:SetAlpha(255)
                iin.Paint = function(s, w, h)
                    if not IsValid(vply) or self.MenuEror.DButn.a == false then return end
                    if GZeroTeb(vply) == true then
                        if ListItem.Geting == true then
                            draw.SimpleText("Loading...", "ActMod_a1", w / 2, 10, Color(255, 255, 255, 155 + (100 * math.sin(CurTime() * 7))), 1)
                        else
                            draw.SimpleText(aR:T("LORTR_S_CHS"), "ActMod_a1", w / 2, 10, Color(255, 255, 255, 200 + (55 * math.sin(CurTime() * 5))), 1)
                        end
                    else
                        local hpos = 5
                        local zxh, pos, spc = 34.2, 1, 10
                        local tab = vply.GetR_Table_Ply
                        local useso1 = TMet(tab["GetRequirements"]["Base_Get"])
                        local useso2 = TMet(tab["GetRequirements"]["Base_AM4"])
                        local useso3 = TMet(tab["GetRequirements"]["Anim_AM4"])
                        local AColor_1 = math.max(0, math.min(255, 255 + (500 * math.sin(CurTime() * 4))))
                        pos = pos + zxh/1.3
                        MMet(pos, hpos, zxh, "actmod/showeror/bgset.png", useso1, AColor_1)
                        pos = pos + zxh + spc*3
                        MMet(pos, hpos, zxh, "actmod/showeror/bam4.jpg", useso2, AColor_1)
                        pos = pos + zxh + spc*3
                        MMet(pos, hpos, zxh, "actmod/showeror/fulf.png", useso3, AColor_1)
                    end
                end

                local AAvatar = vgui.Create("AvatarImage", ListItem)
                AAvatar:SetSize(zia1, zia1)
                AAvatar:SetPos(0, 0)
                AAvatar:SetPlayer(vply, 32)
                AAvatar.aply = vply
                local AAva = vgui.Create("AvatarImage", ListItem)
                AAva:SetSize(64, 64)
                AAva:SetPos(0, 0)
                AAva:SetPlayer(vply, 64)
                AAva:SetAlpha(0)
                AAva:SetVisible(false)
                AAva.aply = vply
                local rh = vgui.Create("DPanel", ListItem)
                rh:SetPos(0, 0)
                rh:SetSize(zia1, zia1)
                rh:SetAlpha(255)
                rh:SetText("")
                rh.tth = false
                rh.ttha = false
                rh.Think = function(aa)
					if IsValid(AAvatar) and not IsValid(AAvatar.aply) then AAvatar:Remove() end
					if IsValid(AAva) and not IsValid(AAva.aply) then AAva:Remove() end
				end
				
                rh.Paint = function(s, w, h)
                    if self.MenuEror.DButn.a == false then return end
                    if s:IsHovered() and s.tth == false then
                        s.tth = true
                        surface.PlaySound("garrysmod/ui_hover.wav")
                        draw.RoundedBox(0, 0, 0, w, h, Color(20, 255, 100, 155))
                        if IsValid(AAva) then
                            AAva:SetAlpha(255)
                            AAva:SetVisible(true)
                        end
                    elseif not s:IsHovered() and s.tth == true then
                        s.tth = false
                        draw.RoundedBox(0, 0, 0, w, h, Color(255, 20, 80, 100))
                        if IsValid(AAva) then
                            AAva:SetAlpha(0)
                            AAva:SetVisible(false)
                        end
                    end
                end
            end
        end

        MakeButton(nil, true)

        for k, v in pairs(player.GetAll()) do
            if IsValid(v) and not v:IsBot() then
                MakeButton(v)
            end
        end

        return Scroll
    end

    local function GNoBWBol_cl(pply)
		if A_AM.ActMod.GetMSS_Tab_cl and A_AM.ActMod.GetMSS_Tab_cl["GetMDLSeq_AM4"] == 2 and A_AM.ActMod.GetMSS_Tab_cl["GetPackAnimV"] == 2 then
            return true
        else
            return false
        end
    end

    local GzMnu
    if GNoBWBol_cl(ply) == true then
        GzMnu = 400
    else
        GzMnu = 430
    end

    self.MenuEror = vgui.Create("DFrame", self.Frame)
    self.MenuEror:SetSize(250, 26)
    self.MenuEror:SetPos(2, 2)
    self.MenuEror:MakePopup()
    self.MenuEror:SetTitle("")
    self.MenuEror:ShowCloseButton(false)
    self.MenuEror.DButn = vgui.Create("DButton", self.MenuEror)
    self.MenuEror.DButn:SetPos(self.MenuEror:GetWide() - 65, 3)
    self.MenuEror.DButn:SetSize(60, 20)
    self.MenuEror.DButn:SetText(aR:T("ListOfRTRB_Show"))
    self.MenuEror.DButn:SetDark(true)
    self.MenuEror.DButn.Trgit = false
    self.MenuEror.DButn.a = false
    if Mar_TabDat(TLang, GetConVarString("actmod_cl_lang")) == false then
		self.MenuEror:SetVisible(false)
	end

    self.MenuEror.DButn.DoClick = function(s)
        if IsValid(self.MenuEror) then
            if s.Trgit == false and s.a == false then
                s.Trgit = true
                s:SetText(aR:T("ListOfRTRB_Hide"))

                self.MenuEror:SizeTo(250, (ply.DButtonRestart == true or not A_AM.ActMod.A_ActMod_RedyUse) and 382 or GzMnu, 0.2, 0, -1, function(t, sS)
                    s.a = true
                end)
            elseif s.a == true then
                s.Trgit = false
                s:SetText(aR:T("ListOfRTRB_Show"))

                self.MenuEror:SizeTo(250, 26, 0.2, 0, -1, function(t, sS)
                    s.a = false
                end)
            end
        end
    end

    if ply.DButtonRestart == nil and A_AM.ActMod.A_ActMod_RedyUse then
        local DButtonD = vgui.Create("DButton", self.MenuEror)
        DButtonD:SetPos(30, 375)
        DButtonD:SetSize(190, 17)
        DButtonD:SetText(aR:T("ListOfRTR_ReROR"))
        DButtonD:SetTextColor(Color(255, 255, 150, 255))
        DButtonD.DoClick = function(s)
            if IsValid(self.MenuEror) then
                if ply.DButtonRestart == nil then
					RunConsoleCommand("r_flushlod")
                    A_AM.ActMod:Tast_SvToCl_restuo(ply, true)
                    ply.DButtonRestart = true
                    timer.Simple(3.5, function() if IsValid(ply) then ply.DButtonRestart = nil end end)
                    if IsValid(DButtonD) then DButtonD:Remove() end
                    self.MenuEror:SizeTo(250, 382, 0.2, 0, -1)
                    if IsValid(self.Frame) then self.Frame:Remove() end
                    self:Close("nOw")
                end
            end
        end
        DButtonD.Paint = function(pan, ww, hh)
            draw.RoundedBox(2, 0, 0, ww, hh, (pan:IsDown() and Color(150, 150, 50, 155)) or (pan:IsHovered() and Color(50, 50, 80, 100)) or Color(50, 50, 50, 255))
        end

        if GNoBWBol_cl(ply) == false then
            local DButtss = vgui.Create("DButton", self.MenuEror)
            DButtss:SetPos(10, 396)
            DButtss:SetSize(self.MenuEror:GetWide() - 20, 25)
            DButtss:SetText(aR:T("LORTR_How"))
            DButtss:SetTextColor(Color(255, 255, 250, 255))
            DButtss:SetFont("ActMod_a1")
            DButtss.DoClick = function(s)
                if IsValid(self.MenuEror) then
                    surface.PlaySound("garrysmod/content_downloaded.wav")
                    self.MenuEror:Remove()
                    self:HelpFixActMod()
                end
            end
            DButtss.Paint = function(pan, ww, hh)
                local AColor_1 = math.max(70, math.min(150, 255 + (255 * math.sin(CurTime() * 2))))
                draw.RoundedBox(2, 0, 0, ww, hh, (pan:IsDown() and Color(150, 150, 50, 155)) or (pan:IsHovered() and Color(80, 120, 80, 100)) or Color(AColor_1 + 50, AColor_1, 50, 255))
            end
        end
    end

    self.MenuEror.Typ = self.MenuEror.Typ or 0
    local DButtonD = vgui.Create("DButton", self.MenuEror)
    DButtonD:SetPos(10, 30)
    DButtonD:SetSize(50, 20)
    DButtonD:SetText(aR:T("LORTR_T_Image"))
    DButtonD:SetTextColor(Color(150, 150, 160, 255))
    DButtonD.DoClick = function(s)
        if IsValid(self.MenuEror) then
            surface.PlaySound("garrysmod/ui_return.wav")
            if self.MenuEror.Typ ~= 0 then
                self.MenuEror.Typ = 0
                if IsValid(self.ListShowRPlys) then
                    self.ListShowRPlys:Remove()
                end
            end
        end
    end

    DButtonD.Paint = function(pan, ww, hh)
        draw.RoundedBox(10, 0, 0, ww, hh, self.MenuEror.Typ == 0 and Color(50, 50, 50, 255) or Color(20, 20, 30, 255))
        if pan:IsDown() then
            pan:SetTextColor(Color(220, 255, 255, 255))
        elseif pan:IsHovered() then
            pan:SetTextColor(Color(200, 200, 255, 255))
        else
            pan:SetTextColor(Color(150, 150, 160, 255))
        end
    end

    local DButtonD = vgui.Create("DButton", self.MenuEror)
    DButtonD:SetPos(65, 30)
    DButtonD:SetSize(50, 20)
    DButtonD:SetText(aR:T("LORTR_T_Text"))
    DButtonD.DoClick = function(s)
        if IsValid(self.MenuEror) then
            surface.PlaySound("garrysmod/ui_return.wav")
            if self.MenuEror.Typ ~= 1 then
                self.MenuEror.Typ = 1
                if IsValid(self.ListShowRPlys) then
                    self.ListShowRPlys:Remove()
                end
            end
        end
    end
    DButtonD.Paint = function(pan, ww, hh)
        draw.RoundedBox(10, 0, 0, ww, hh, self.MenuEror.Typ == 1 and Color(50, 50, 50, 255) or Color(20, 20, 30, 255))
        if pan:IsDown() then
            pan:SetTextColor(Color(220, 255, 255, 255))
        elseif pan:IsHovered() then
            pan:SetTextColor(Color(200, 200, 255, 255))
        else
            pan:SetTextColor(Color(150, 150, 160, 255))
        end
    end

    local DButtonD = vgui.Create("DButton", self.MenuEror)
    DButtonD:SetPos(130, 30)
    DButtonD:SetSize(100, 20)
    DButtonD:SetText(aR:T("LORTR_T_SP"))
    DButtonD.DoClick = function(s)
        if IsValid(self.MenuEror) then
            surface.PlaySound("garrysmod/ui_return.wav")
            if IsValid(self.ListShowRPlys) then
                self.ListShowRPlys:Remove()
                for k, v in pairs(player.GetAll()) do
                    if IsValid(v) then
                        RGR_Table_Ply(v)
                    end
                end
                self.ListShowRPlys = MakeScroll(self.MenuEror)
            end
            if self.MenuEror.Typ ~= 2 then
                self.MenuEror.Typ = 2
                if IsValid(self.ListShowRPlys) then
                    self.ListShowRPlys:Remove()
                end
                self.ListShowRPlys = MakeScroll(self.MenuEror)
            end
        end
    end
    DButtonD.Paint = function(pan, ww, hh)
        draw.RoundedBox(10, 0, 0, ww, hh, self.MenuEror.Typ == 2 and Color(50, 50, 50, 255) or Color(20, 20, 30, 255))
        if pan:IsDown() then
            pan:SetTextColor(Color(255, 255, 255, 255))
        elseif pan:IsHovered() then
            pan:SetTextColor(Color(200, 200, 100, 255))
        else
            pan:SetTextColor(Color(120, 120, 130, 255))
        end
    end

    local function Dimage(pply, Gw, Gh, Gname, GNWBool)
		local Tab_sv,Tab_cl = A_AM.ActMod.GetMSS_Tab,A_AM.ActMod.GetMSS_Tab_cl
		
        if GNWBool == "AM4_Dyn_xdR" or GNWBool == "AM4_Dyn_xdR__sv" then
			local aa,az = 30 + 15 ,30
			local ah = 45/2 - az/2
			draw.RoundedBox(5, Gw, Gh, 218, 45, Color(15, 45, 65, 255))
			surface.SetDrawColor(Color(255, 255, 255, 200))
			surface.SetMaterial(Material("actmod/showeror/bam4.jpg"))
			surface.DrawTexturedRect(Gw + 4, Gh + ah, az, az)
			draw.RoundedBox(5, Gw + 4, Gh + ah + az + 1, az, 2, Tab_sv["GetMDLSeq_AM4"] == 2 and Color(100, 255, 100, 255) or Tab_sv["GetMDLSeq_AM4"] == 1 and Color(255, 255, 100, 255) or Color(200, 100, 50, 255))
			draw.SimpleText("|", "ActMod_a6", Gw + az*1.5 -3, Gh + 9, Color(255, 255, 255, 255) ,1)
			surface.SetDrawColor(Color(255, 255, 255, 200))
			surface.SetMaterial(Material("actmod/showeror/bdyn.png", "noclamp smooth"))
			surface.DrawTexturedRect(Gw + 4 + aa, Gh + ah, az, az)
			draw.RoundedBox(5, Gw + 4 + aa, Gh + ah + az + 1, az, 2, Tab_sv["GetMDLSeq_Dyn"] == 2 and Color(100, 255, 100, 255) or Tab_sv["GetMDLSeq_Dyn"] == 1 and Color(255, 255, 100, 255) or Color(200, 100, 50, 255))
			draw.SimpleText("|", "ActMod_a6", Gw + (az*1.5)*2 -3, Gh + 9, Color(255, 255, 255, 255),1)
			surface.SetDrawColor(Color(255, 255, 255, 200))
			surface.SetMaterial(Material("actmod/showeror/bxdr.png", "noclamp smooth"))
			surface.DrawTexturedRect(Gw + 4 + aa*2, Gh + ah, az, az)
			draw.RoundedBox(5, Gw + 4 + aa*2, Gh + ah + az + 1, az, 2, Tab_sv["GetMDLSeq_xdR"] == 2 and Color(100, 255, 100, 255) or Tab_sv["GetMDLSeq_xdR"] == 1 and Color(255, 255, 100, 255) or Color(200, 100, 50, 255))
			draw.SimpleText(">", "ActMod_a6", Gw + (az*1.5)*3 + 15, Gh + 10, Color(200, 255, 255, 255),1)
			surface.SetDrawColor(Color(255, 255, 255, 200))
			if GNWBool == "AM4_Dyn_xdR__sv" then
				if Tab_sv["GetMDLSeq_Dyn"] == 2 then
					surface.SetMaterial(Material("actmod/showeror/ssdyn.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				elseif Tab_sv["GetMDLSeq_AM4"] == 2 then
					surface.SetMaterial(Material("actmod/showeror/ssam4.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				elseif Tab_sv["GetMDLSeq_xdR"] == 2 then
					surface.SetMaterial(Material("actmod/showeror/ssxdr.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				elseif Tab_sv["GetMDLSeq_wOS"] == 2 then
					surface.SetMaterial(Material("actmod/showeror/sswos.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				else
					surface.SetMaterial(Material("actmod/showeror/no.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				end
			else
				if Tab_cl["GetMDLSeq_Dyn"] == 2 then
					surface.SetMaterial(Material("actmod/showeror/ssdyn.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				elseif Tab_cl["GetMDLSeq_AM4"] == 2 then
					surface.SetMaterial(Material("actmod/showeror/ssam4.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				elseif Tab_cl["GetMDLSeq_xdR"] == 2 then
					surface.SetMaterial(Material("actmod/showeror/ssxdr.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				elseif Tab_cl["GetMDLSeq_wOS"] == 2 then
					surface.SetMaterial(Material("actmod/showeror/sswos.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				else
					surface.SetMaterial(Material("actmod/showeror/no.png", "noclamp smooth"))
					surface.DrawTexturedRect(Gw + 4 + aa*3 + 35, Gh + 5, 36, 36)
				end
			end
			return
		end
		
		local anok = 0
		
        draw.RoundedBox(5, Gw, Gh, 104, 45, Color(15, 45, 65, 255))
        draw.SimpleText(">", "ActMod_a6", Gw + 46, Gh + 10, Color(200, 255, 255, 255))
        surface.SetDrawColor(Color(255, 255, 255, 200))
		if Gname == "bam4" then
			surface.SetMaterial(Material("actmod/showeror/bam4.jpg"))
		elseif Gname == "eam4" then
			surface.SetMaterial(Material("actmod/showeror/fulf.png"))
		else
			surface.SetMaterial(Material("actmod/showeror/" .. Gname .. ".png", "noclamp smooth"))
		end
        surface.DrawTexturedRect(Gw + 2.5, Gh + 2.5, 40, 40)
		
		if GNWBool == "GetMDLSeq_AM4_sv" then
			anok = Tab_sv["GetMDLSeq_AM4"]
		elseif GNWBool == "GetMDLSeq_Dyn_sv" then
			anok = Tab_sv["GetMDLSeq_Dyn"]
		elseif GNWBool == "GetMDLSeq_xdR_sv" then
			anok = Tab_sv["GetMDLSeq_xdR"]
		elseif GNWBool == "GetMDLSeq_wOS_sv" then
			anok = Tab_sv["GetMDLSeq_wOS"]
		elseif GNWBool == "GetPackAnimV_sv" then
			anok = Tab_sv["GetPackAnimV"] == 0 and 0 or Tab_sv["GetPackAnimV"] == 1 and 1 or Tab_sv["GetORG"] == 0 and 3 or 2 
		elseif GNWBool == "GetMDLSeq_AM4" then
			anok = Tab_cl["GetMDLSeq_AM4"]
		elseif GNWBool == "GetMDLSeq_Dyn" then
			anok = Tab_cl["GetMDLSeq_Dyn"]
		elseif GNWBool == "GetMDLSeq_xdR" then
			anok = Tab_cl["GetMDLSeq_xdR"]
		elseif GNWBool == "GetMDLSeq_wOS" then
			anok = Tab_cl["GetMDLSeq_wOS"]
		elseif GNWBool == "GetPackAnimV" then
			anok = Tab_cl["GetPackAnimV"] == 0 and 0 or Tab_cl["GetPackAnimV"] == 1 and 1 or Tab_cl["GetORG"] == 0 and 3 or 2 
		end
		
		if anok == 2 then
			surface.SetMaterial(Material("actmod/showeror/ye.png", "noclamp smooth"))
		elseif anok == 3 then
			surface.SetMaterial(Material("actmod/showeror/yen.png", "noclamp smooth"))
		elseif anok == 1 then
			surface.SetMaterial(Material("actmod/showeror/ir.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("actmod/showeror/no.png", "noclamp smooth"))
		end

        surface.DrawTexturedRect(Gw + 62, Gh + 2.5, 40, 40)
    end

    local function DText(pply, Gw, Gh, Gname, GNWBool)
		local Tab_sv,Tab_cl = A_AM.ActMod.GetMSS_Tab,A_AM.ActMod.GetMSS_Tab_cl
        draw.SimpleText(Gname, "ActMod_a5", Gw, Gh, Color(200, 255, 255, 255))

		local anok,txt,Clo = 0,"__",Color(150, 255, 150, 255)
		
		if GNWBool == "GetMDLSeq_AM4_sv" then
			anok = Tab_sv["GetMDLSeq_AM4"]
		elseif GNWBool == "GetMDLSeq_Dyn_sv" then
			anok = Tab_sv["GetMDLSeq_Dyn"]
		elseif GNWBool == "GetMDLSeq_xdR_sv" then
			anok = Tab_sv["GetMDLSeq_xdR"]
		elseif GNWBool == "GetMDLSeq_wOS_sv" then
			anok = Tab_sv["GetMDLSeq_wOS"]
		elseif GNWBool == "GetPackAnimV_sv" then
			anok = Tab_sv["GetPackAnimV"] == 0 and 0 or Tab_sv["GetPackAnimV"] == 1 and 1 or Tab_sv["GetORG"] == 0 and 3 or 2 
		elseif GNWBool == "GetMDLSeq_AM4" then
			anok = Tab_cl["GetMDLSeq_AM4"]
		elseif GNWBool == "GetMDLSeq_Dyn" then
			anok = Tab_cl["GetMDLSeq_Dyn"]
		elseif GNWBool == "GetMDLSeq_xdR" then
			anok = Tab_cl["GetMDLSeq_xdR"]
		elseif GNWBool == "GetMDLSeq_wOS" then
			anok = Tab_cl["GetMDLSeq_wOS"]
		elseif GNWBool == "GetPackAnimV" then
			anok = Tab_cl["GetPackAnimV"] == 0 and 0 or Tab_cl["GetPackAnimV"] == 1 and 1 or Tab_cl["GetORG"] == 0 and 3 or 2 
		end
		
		if GNWBool == "AM4_Dyn_xdR__sv" then
			txt = Tab_sv["GetSetBase"]
			if txt == "wOS" then
				Clo = Color(255, 150, 100, 255)
			end
		elseif GNWBool == "AM4_Dyn_xdR" then
			txt = Tab_cl["GetSetBase"]
			if txt == "wOS" then
				Clo = Color(255, 150, 100, 255)
			end
		elseif anok == 3 then
			txt = self.MenuEror.sR_yes
			Clo = Color(240, 240, 150, 255)
		elseif anok == 2 then
			txt = self.MenuEror.sR_yes
		elseif anok == 1 then
			txt = self.MenuEror.sR_unK
			Clo = Color(180, 150, 100, 255)
		else
			txt = self.MenuEror.sR_no
			Clo = Color(255, 150, 100, 255)
		end
		
		draw.SimpleText(txt, "ActMod_a5", self.MenuEror:GetWide() - 20, Gh, Clo ,2)
    end

    local function DSText(pply, Gw, Gh, Gname, GNWBool)
        draw.SimpleText(Gname, "ActMod_a5", Gw, Gh, Color(200, 255, 255, 255))
        if pply:GetNWBool(GNWBool, false) == true then
            draw.SimpleText("True", "ActMod_a5", self.MenuEror:GetWide() - 45, Gh, Color(120, 255, 150, 255))
        else
            draw.SimpleText("False", "ActMod_a5", self.MenuEror:GetWide() - 45, Gh, Color(255, 120, 100, 255))
        end
    end

    self.MenuEror.sR_TRq = aR:T("LORTRTheReq")
    self.MenuEror.sR_Sv = aR:T("LORTRServer")
    self.MenuEror.sR_Cl = aR:T("LORTRClient")
    self.MenuEror.sR_yes = aR:T("LORTR_Yes")
    self.MenuEror.sR_no = aR:T("LORTR_No")
    self.MenuEror.sR_unK = aR:T("LORTR_unK")
    self.MenuEror.sR_Rrun = aR:T("ListOfRToRun")
    self.MenuEror.sR_FullF = aR:T("Fullyfunctional")

    self.MenuEror.Paint = function(pan, ww, hh)
        if GNoBWBol_cl(ply) == false and self.MenuEror.DButn.a == false and self.MenuEror.DButn.Trgit == false and A_AM.ActMod.A_ActMod_RedyUse then
            local AColor_1 = math.max(70, math.min(150, 255 + (255 * math.sin(CurTime() * 2))))
            draw.RoundedBox(5, 0, 0, ww, hh, Color(AColor_1 + 50, AColor_1, 10, 255))
        else
            draw.RoundedBox(5, 0, 0, ww, hh, Color(15, 45, 65, 255))
        end

        draw.SimpleText(self.MenuEror.sR_Rrun, "ActMod_a5", 7, 3, Color(255, 255, 255, 255))
        draw.RoundedBox(8, 0, 40, ww, 336, Color(50, 50, 50, 255))
        if self.MenuEror.Typ == 2 or self.MenuEror.DButn.a == false then return end
        local Geth = 40

        if game.SinglePlayer() then
            draw.RoundedBox(8, 4, Geth + 20, ww - 8, 180, Color(68, 80, 90, 255))
            draw.SimpleText(self.MenuEror.sR_TRq, "CloseCaption_Normal", 125, Geth + 40, Color(200, 255, 255, 255), 1, 1)
			draw.SimpleTextOutlined(":  AhmedMake400  :", "ActMod_a6", ww/2, Geth + 230, Color(150, 255, 255, 255), 1, 1, 1, Color(255, 255, 255, math.max(10, math.min(255, 255 * math.sin(CurTime() * 1)-100))))
            if self.MenuEror.Typ == 0 then
                Dimage(ply, 16, Geth + 70, "hy", "AM4_Dyn_xdR")
                Dimage(ply, 16, Geth + 130, "bam4", "GetMDLSeq_AM4")
                Dimage(ply, 130, Geth + 130, "eam4", "GetPackAnimV")
            elseif self.MenuEror.Typ == 1 then
                DText(ply, 6, Geth + 70, "Base ( AM4 | Dyn | xdR ) :", "AM4_Dyn_xdR__sv")
                DText(ply, 6, Geth + 100, "Base Anim-AM4 :", "GetMDLSeq_AM4_sv")
                DText(ply, 6, Geth + 130, self.MenuEror.sR_FullF .." :", "GetPackAnimV_sv")
            end
            draw.SimpleTextOutlined("ActMod", "GModToolName", 125, Geth + 290, Color(150, 255, 255, 255), 1, 1, 2, Color(255, 255, 255, math.max(10, math.min(255, 255 * math.sin(CurTime() * 1)))))
       else
            draw.RoundedBox(8, 4, Geth + 20, ww - 8, 120, Color(68, 80, 90, 255))
            draw.SimpleText(self.MenuEror.sR_Sv, "ActMod_a5", 6, Geth + 20, Color(150, 255, 255, 255))
            if self.MenuEror.Typ == 0 then
                Dimage(ply, 16, Geth + 42, "hy", "AM4_Dyn_xdR__sv")
                Dimage(ply, 16, Geth + 91, "bam4", "GetMDLSeq_AM4_sv")
                Dimage(ply, 130, Geth + 91, "eam4", "GetPackAnimV_sv")
            elseif self.MenuEror.Typ == 1 then
                DText(ply, 10, Geth + 50, "Base ( AM4 | Dyn | xdR ) :", "AM4_Dyn_xdR__sv")
                DText(ply, 10, Geth + 80, "Base Anim-AM4 :", "GetMDLSeq_AM4_sv")
                DText(ply, 10, Geth + 110, self.MenuEror.sR_FullF .." :", "GetPackAnimV_sv")
            end
            draw.RoundedBox(8, 4, Geth + 160, ww - 8, 120, Color(68, 80, 90, 255))
            draw.SimpleText(self.MenuEror.sR_Cl, "ActMod_a5", 6, Geth + 160, Color(255, 255, 155, 255))
			draw.SimpleTextOutlined(":  AhmedMake400  :", "ActMod_a6", ww/2, Geth + 310, Color(150, 255, 255, 255), 1, 1, 1, Color(255, 255, 255, math.max(10, math.min(255, 255 * math.sin(CurTime() * 1)-100))))
            if self.MenuEror.Typ == 0 then
                Dimage(ply, 16, Geth + 181, "hy", "AM4_Dyn_xdR")
                Dimage(ply, 16, Geth + 231, "bam4", "GetMDLSeq_AM4")
                Dimage(ply, 130, Geth + 231, "eam4", "GetPackAnimV")
            elseif self.MenuEror.Typ == 1 then
                DText(ply, 10, Geth + 190, "Base ( AM4 | Dyn | xdR ) :", "AM4_Dyn_xdR")
                DText(ply, 10, Geth + 220, "Base Anim-AM4 :", "GetMDLSeq_AM4")
                DText(ply, 10, Geth + 250, self.MenuEror.sR_FullF .." :", "GetPackAnimV")
            end
        end
    end

    if A_AM.ActMod.A_ActMod_RedyUse and Mar_TabDat(TLang, GetConVarString("actmod_cl_lang")) == true and GetConVarNumber("actmod_cl_showbhelp") == 1 then
        local function hText(Nam, TText, Po1, Po2, clo) draw.SimpleText(Nam, TText, Po1, Po2, clo, 1, 0) end
        local ListHelp,wa = vgui.Create("DPanel", self.Frame) ,250
        ListHelp:SetSize(wa, 21)
        if ActMod_Iok1 ~= true then
            ListHelp:SetPos(-40, 30)
            ListHelp:MoveTo(2, 30, 0.3)

            timer.Simple(0.4, function()
                if IsValid(ListHelp) then
                    ListHelp:SizeTo(wa, 85, 0.2, 0, -1)
                    timer.Simple(1.1, function()
                        if IsValid(ListHelp) then
                            ListHelp:SizeTo(wa, 119, 0.5, 0, -1)
							timer.Simple(0.3, function()
								if IsValid(ListHelp) then
									ActMod_Iok1 = true
								end
							end)
                        end
                    end)
                end
            end)
        else
            ListHelp:SizeTo(wa, 119, 0.2, 0, -1)
            ListHelp:SetPos(2, 30)
        end
        ListHelp:SetAlpha(0)
        ListHelp:AlphaTo(255, 0.3)
        ListHelp:MakePopup()
        ListHelp:SetText("")
        ListHelp.Paint = function(ste, w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(30 + (10 * math.sin(CurTime() * 2)), 40 + (10 * math.sin(CurTime() * 2)), 10, 255))
            draw.RoundedBox(10, 0, 0, w, 21, Color(60, 60, 80, 255))
            hText(aR:T("AHlp_Txt_0"), "ActMod_a5", w / 2, 2, Color(255, 255, 155, 255))
            if GetConVarNumber("actmod_cl_showbhelp") == 1 then
                hText(aR:T("AHlp_Txt_1"), "ActMod_a6", w / 2, 25, Color(155, 255, 255, 255))
                hText(aR:T("AHlp_Txt_2"), "ActMod_a2", w / 2, 54, Color(255, 255, 150, 255))
            else
                hText(aR:T("AHlp_Txt_3"), "ActMod_a5", w / 2, 20, Color(155, 255, 255, 255))
                hText(aR:T("AHlp_Txt_4"), "ActMod_a3", w / 2, 40, Color(155, 255, 255, 255))
            end
        end

        local function BaSText(ListHelp, Po1, Po2, Sz1, Sz2, Gname, GNWBool)
            local DButton = vgui.Create("DButton", ListHelp)
            DButton:SetPos(Po1, Po2)
            DButton:SetSize(Sz1, Sz2)
            DButton:SetText("")
            DButton.DoClick = function(s)
                if IsValid(ListHelp) and GetConVarNumber("actmod_cl_showbhelp") == 1 then
                    if GNWBool then
                        self:HelpActMod()
                        ListHelp:AlphaTo(0, 0.1,0.1,function(s) if IsValid(ListHelp) then ListHelp:Remove() end end)
                        ListHelp:SizeTo(wa, 0, 0.1, 0, -1)
						self:Close()
						if LocalPlayer().ActMod_MousePos then
							LocalPlayer().ActMod_MousePos = nil
						end
                    else
                        ListHelp:SizeTo(wa, 0, 2.4, 1, -1)
                        RunConsoleCommand("actmod_cl_showbhelp", "0")
						ListHelp:AlphaTo(0,0.6,2.1,function(s) if IsValid(ListHelp) then ListHelp:Remove() end end )
						if IsValid(ListHelp.bt1) then ListHelp.bt1:Remove() end
						if IsValid(ListHelp.bt2) then ListHelp.bt2:Remove() end
                    end
                end
            end

            DButton.Paint = function(ste, w, h)
                if ste:IsDown() then
                    draw.RoundedBox(5, 0, 0, w, h, GNWBool and Color(30, 150, 80, 255) or Color(150, 130, 80, 255))
                    draw.SimpleText(Gname, "ActMod_a5", w / 2, h / 2, Color(255, 255, 155, 255), 1, 1)
                    surface.SetDrawColor(Color(100, 255, 255, math.max(155 + (100 * math.sin(CurTime() * 15)), 0)))
                    surface.DrawOutlinedRect(0, 0, w, h, 1)
                elseif ste:IsHovered() then
                    draw.RoundedBox(5, 0, 0, w, h, GNWBool and Color(20, 100, 70, 255) or Color(100, 80, 40, 255))
                    draw.SimpleText(Gname, "ActMod_a5", w / 2, h / 2, Color(255, 255, 155, 255), 1, 1)
                else
                    draw.RoundedBox(5, 0, 0, w, h, GNWBool and Color(15, 80, 40, math.max(200 + (155 * math.sin(CurTime() * 7)), 0)) or Color(70, 50, 30, 255))
                    draw.SimpleText(Gname, "ActMod_a5", w / 2, h / 2, Color(220, 255, 255, 255), 1, 1)
                end
            end
			return DButton
        end

        ListHelp.bt1 = BaSText(ListHelp, ListHelp:GetWide() - 110, 90, 100, 25, aR:T("LORTR_Yes"), true)
        ListHelp.bt2 = BaSText(ListHelp, 10, 90, 102, 25, aR:T("LORTR_No"))
    end
end

A_AM.ActMod.LuaVgi_MListErr_Done = true
