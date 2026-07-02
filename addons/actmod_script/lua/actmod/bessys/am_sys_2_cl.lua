if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.bessys_2 = true

local Actoji = A_AM.ActMod.Actoji

local function ReString(st, tam4)
    return A_AM.ActMod:ReString(st, tam4)
end

local function RvString(ara)
    return A_AM.ActMod:RvString(ara)
end


A_AM.ActMod.OptSFPly = A_AM.ActMod.OptSFPly or {}

local function CTxtMos(Ow, IsH, Ty, txt, txf, aup, useSTBW) A_AM.ActMod:CTxtMos(Ow, IsH, Ty, txt, txf, aup, useSTBW) end

local function aListPly(plist,iD64,dAta)
	local pnl
	if iD64 and iD64 == "76561199185837385" then
		pnl = plist:Add('DPanel')
	else
		pnl = plist:Add('DButton')
	end
	pnl.Zall = 32
	pnl:SetTall(pnl.Zall)
	pnl:SetText('')
	pnl:Dock(TOP)
	pnl:DockMargin(5, 0, 5, 2)
	pnl.namPly = dAta and dAta.name or iD64 or "_?_"
	pnl.Paint = function(p, w, h)
		if iD64 and iD64 == "76561199185837385" then
			draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 100 + (50 * math.sin(CurTime() * 1)), 255))
		elseif iD64 and iD64 ~= "76561199185837385" then
			if not A_AM.ActMod.OptSFPly[iD64] then
				draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 255))
			elseif p:IsHovered() then
				draw.RoundedBox(4, 0, 0, w, h, Color(70, 80, 150, 255))
			else
				draw.RoundedBox(4, 0, 0, w, h, Color(100, 60, 70, 255))
			end
			if p:IsHovered() then
				surface.SetDrawColor(Color(255, 255, 255, math.min(255 + (200 * math.sin(CurTime() * 4)),255)))
				surface.DrawOutlinedRect(0, 0, w, h, 1 )
			end
		else
			draw.RoundedBox(4, 0, 0, w, h, Color(70, 50, 40, 255))
		end
		surface.SetDrawColor(color_white)
		if A_AM.ActMod.OptSFPly[iD64] then
			surface.SetMaterial( Material("actmod/imenu/p_no.png", "noclamp smooth") )
		else
			surface.SetMaterial( Material("actmod/imenu/p_yas.png", "noclamp smooth") )
		end
		surface.DrawTexturedRect(w-h-4,3, h-6, h-6)
		draw.SimpleText(pnl.namPly, "ActMod_a1", pnl.Zall+5, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	if iD64 and iD64 ~= "76561199185837385" then
		pnl.DoClick = function(p, w, h)
			plist.TimeTh = CurTime() + 1
			if not A_AM.ActMod.OptSFPly[iD64] then
				if dAta and dAta.Ply then
					A_AM.ActMod.OptSFPly[iD64] = { ["Ply"] = dAta.Ply ,["noSound"] = true }
				end
			else
				A_AM.ActMod.OptSFPly[iD64] = nil
			end
		end
	end
	if iD64 then
		local avatar = pnl:Add('AvatarImage')
		avatar:SetSteamID(iD64, 32)
		avatar:DockMargin(2, 2, 5, 2)
		avatar:SetWide(pnl:GetTall() - 4)
		avatar:Dock(LEFT)
		A_AM.ActMod:GetNameA(iD64, function(Gname, Gonln)
			if IsValid(pnl) then
				if Gname ~= "nonE" then pnl.namPly = Gname end
				if Gonln ~= "nonE" then
				end
			end
		end)
	end
	return pnl
end

local function aListOpt(plist,D_,aDat)
	if aDat then
		local pnl,gtip
		if D_ then
			if D_ == "___" then
				pnl = plist:Add("DLabel")
				gtip = "DLabel"
			else
				pnl = plist:Add(D_)
				gtip = D_
			end
		else
			pnl = plist:Add('DButton')
			gtip = "DButton"
		end
		if pnl then
			pnl.Zall = aDat.Zall or 32
			pnl:SetTall(pnl.Zall)
			pnl:Dock(TOP)
			pnl:DockMargin(5, 0, 5, 2)
			pnl.namOpt = aDat.name or "_?_"
			local isSrv = aDat.isSrv and (game.SinglePlayer() or LocalPlayer():IsListenServerHost() or LocalPlayer():IsSuperAdmin()) or not aDat.isSrv
			if gtip == "DLabel" then
				pnl:SetText("")
				pnl.a_w = aDat.a_w or 0
				pnl.a_h = aDat.a_h or 0
				pnl.Paint = function(p, w, h)
					draw.SimpleText(p.namOpt, "ActMod_a1", w/2+p.a_w, h/2+p.a_h, Color(255, 255, 255, 255), 1, 1)
				end
				
			elseif gtip == "DComboBox" then
				pnl:SetText(pnl.namOpt .."   ==>  ...")
				if istable(aDat.TabAddC) then
					pnl:SetText(pnl.namOpt .."   ==>  ".. aDat.TabAddC[GetConVarNumber(aDat.comm)])
					for ii,j in pairs(aDat.TabAddC) do
						pnl:AddChoice(ii .."- ".. tostring(j), ii)
					end
					pnl.Trfh = CurTime() + 2
					pnl.Think = function()
						if pnl.Trfh < CurTime() then
							pnl.Trfh = CurTime() + 1
							pnl:SetText(pnl.namOpt .."   ==>  ".. aDat.TabAddC[GetConVarNumber(aDat.comm)])
						end
						if aDat.hlp then
							CTxtMos(pnl, nil, {100, 100, 100, 200}, aDat.hlp, "CreditsText" ,11 ,2)
						end
					end
					pnl.OnSelect = function(pl, index, value, data)
						if GetConVarNumber(aDat.comm) ~= data then
							surface.PlaySound("garrysmod/content_downloaded.wav")
							RunConsoleCommand(aDat.comm, data)
						end
						pnl:SetText(pnl.namOpt .."   ==>  ".. aDat.TabAddC[data])
					end
				end

			elseif gtip == "DNumSlider" then
				pnl:SetText("                  ".. pnl.namOpt)
				pnl:SetMin(aDat.mnix and aDat.mnix[1] or 5)
				pnl:SetMax(aDat.mnix and aDat.mnix[2] or 100)
				pnl:SetDecimals(0)
				if not isSrv then pnl:SetEnabled(false) end
				pnl:SetConVar(aDat.comm)
				if aDat.comm == "actmod_sv_soundlevel" or aDat.comm == "actmod_sv_syrhook" or aDat.comm == "actmod_cl_soundlevel" or aDat.comm == "actmod_cl_soundlevelother" then
					pnl.OnValueChanged = function(s, dfn)
						if aDat.isSrv and (aDat.comm == "actmod_sv_soundlevel" or aDat.comm == "actmod_sv_syrhook") and not LocalPlayer():IsListenServerHost() and LocalPlayer():IsSuperAdmin() then
							dfn = math.Round(dfn)
							local isSrv = "A_AM.aDNumSliderTCTS_c_|".. aDat.comm
							if timer.Exists( isSrv ) then timer.Remove( isSrv ) end
							timer.Create(isSrv,0.4,1,function() if IsValid(LocalPlayer()) then
								net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"SCVCom",aDat.comm,tostring(dfn)} ) net.SendToServer()
							end end)
						end
					end
				end
				pnl.Paint = function(p, w, h)
					if p:IsHovered() then
						draw.RoundedBox(4, 0, 0, w, h, isSrv and Color(100, 110, 80, 255) or Color(0, 0, 0, 255))
						if isSrv then
							surface.SetDrawColor(Color(255, 255, 255, math.min(255 + (200 * math.sin(CurTime() * 4)),255)))
							surface.DrawOutlinedRect(0, 0, w, h, 1 )
						end
					else
						draw.RoundedBox(4, 0, 0, w, h, isSrv and Color(50, 60, 70, 155) or Color(10, 10, 10, 180))
					end
					surface.SetDrawColor(Color(255, 255, 255, 255))
					if aDat.comm == "actmod_cl_soundlevel" or aDat.comm == "actmod_cl_soundlevelother" or aDat.comm == "actmod_sv_soundlevel" then
						if GetConVarNumber(aDat.comm) > 50 then
							surface.SetMaterial(Material("icon16/sound.png", "noclamp smooth"))
						elseif GetConVarNumber(aDat.comm) > 19 then
							surface.SetMaterial(Material("icon16/sound_low.png", "noclamp smooth"))
						else
							surface.SetMaterial(Material("icon16/sound_none.png", "noclamp smooth"))
						end
					elseif aDat.comm == "actmod_sv_rangecam" then
						surface.SetMaterial(Material("icon16/camera_link.png", "noclamp smooth"))
					else
						surface.SetMaterial(Material("icon16/chart_curve_edit.png", "noclamp smooth"))
					end
					surface.DrawTexturedRect(4, 3, h-6, h-6)
					if aDat.hlp then
						CTxtMos(p, nil, {100, 100, 100, 200}, aDat.hlp, "CreditsText" ,11 ,2)
					end
				end
				
				function pnl:PerformLayout()
					local w, h = self:GetSize()
					local label = self.Label
					local numSlider = self.Slider
					local textBox = self.TextArea
					local sliderWidth = 100
					local padding = 10
					if IsValid(label) then
						label:SetPos(padding, 0)
						label:SetSize(w - sliderWidth - textBox:GetWide() - 3 * padding, 20)
					end
					if IsValid(numSlider) then
						numSlider:SetPos(w - sliderWidth - textBox:GetWide() - padding, 0)
						numSlider:SetSize(sliderWidth, h)
					end
					if IsValid(textBox) then
						textBox:SetPos(w - textBox:GetWide() - padding, 0)
						textBox:SetSize(40, h)
					end
				end
			elseif gtip == "DButton" then
				pnl:SetText('')
				if not isSrv then pnl:SetCursor("arrow") end
				local comm = aDat.comm or "_?_"
				pnl.Paint = function(p, w, h)
					local aGcomm = not aDat.Gcomm or GetConVarNumber(aDat.Gcomm) == 1
					if not aGcomm then
						draw.RoundedBox(4, 0, 0, w, h, isSrv and Color(100, 70, 50, 155) or Color(70, 50, 10, 180))
					else
						if p:IsDown() then
							draw.RoundedBox(4, 0, 0, w, h, Color(100, 120, 150, 255))
							if isSrv then
								surface.SetDrawColor(Color(255,255,255,255))
								surface.DrawOutlinedRect(0, 0, w, h, 2 )
							end
						elseif p:IsHovered() then
							draw.RoundedBox(4, 0, 0, w, h, isSrv and Color(100, 110, 80, 255) or Color(0, 0, 0, 255))
							if isSrv then
								surface.SetDrawColor(Color(255, 255, 255, math.min(255 + (200 * math.sin(CurTime() * 4)),255)))
								surface.DrawOutlinedRect(0, 0, w, h, 1 )
							end
						else
							draw.RoundedBox(4, 0, 0, w, h, isSrv and Color(50, 60, 70, 155) or Color(10, 10, 10, 180))
						end
					end
					surface.SetDrawColor(Color(255, 255, 255, 255))
					if aGcomm and GetConVarNumber(comm) ~= 0 then
						surface.SetMaterial(Material("icon16/tick.png", "noclamp smooth"))
					else
						surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
					end
					surface.DrawTexturedRect(4, 3, h-6, h-6)
					draw.SimpleText(p.namOpt, "ActMod_a1", h+5, h/2, Color(255, 255, 255, 255), 0, 1)
					if not aGcomm then
						draw.RoundedBox(4, h+2, h/3, w-h-4, h/4, Color(100, 50, 10, 200))
					end
					if aDat.hlp then
						CTxtMos(p, nil, {100, 100, 100, 200}, aDat.hlp, "CreditsText" ,11 ,2)
					end
				end
				pnl.DoClick = function(p, w, h)
					if isSrv and (not aDat.Gcomm or GetConVarNumber(aDat.Gcomm) == 1) then
						surface.PlaySound("garrysmod/ui_click.wav")
						local aa = "0"
						if GetConVarNumber(comm) == 1 then
							aa = "0" else aa = "1"
						end
						if not aDat.isSrv or LocalPlayer():IsListenServerHost() then
							RunConsoleCommand(comm, aa)
						elseif aDat.isSrv then
							net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"SCVCom",comm, aa} ) net.SendToServer()
						end
					end
				end
			end
			return pnl
		end
	end
end





function A_AM.ActMod:MListAPSond()
	if A_AM.ActMod.cframeAPSond and IsValid(A_AM.ActMod.cframeAPSond) then A_AM.ActMod.cframeAPSond:Remove() A_AM.ActMod.cframeAPSond = nil end
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 540, 410 )
	frame:Center()
	frame:SetSizable( true ) frame:SetMinWidth( 540 ) frame:SetMinHeight( 300 )
	frame:SetTitle(aR:T("Advanced_S_Menu"))
	frame:MakePopup()
	A_AM.ActMod.cframeAPSond = frame

	local sheet = vgui.Create( "DPropertySheet", frame )
	sheet:Dock( FILL )
	
	local isSSrv = game.SinglePlayer() or LocalPlayer():IsListenServerHost() or LocalPlayer():IsSuperAdmin()


	local sheet_sv
	if GetConVarNumber("actmod_sv_shofcl") == 0 or isSSrv then
		sheet_sv = vgui.Create( "DPropertySheet", sheet )
		sheet_sv:Dock( FILL )
		sheet:AddSheet( aR:T("_Server"), sheet_sv, "icon16/wrench.png" )
		local sv_panel1 = vgui.Create("AM4_DScrollPanel", sheet_sv)
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_weapact") ,comm = "actmod_sv_a_weapact" ,hlp = aR:T("osv_sys_weapact_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_steatd") ,comm = "actmod_sv_a_vehicles" ,hlp = aR:T("osv_sys_steatd_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_ground") ,comm = "actmod_sv_a_ground" ,hlp = aR:T("osv_sys_ground_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_crouching") ,comm = "actmod_sv_a_crouching" ,hlp = aR:T("osv_sys_crouching_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_move") ,comm = "actmod_sv_a_move" ,hlp = aR:T("osv_sys_move_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_tymovcl") ,comm = "actmod_sv_typmovecl" ,hlp = aR:T("osv_sys_tymovcl_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_alowangcl") ,comm = "actmod_sv_alowangcl",Gcomm = "actmod_sv_typmovecl" ,hlp = aR:T("osv_sys_alowangcl_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_darchk") ,comm = "actmod_sv_ondcklpos" ,hlp = aR:T("osv_sys_darchk_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_adsyn") ,comm = "actmod_sv_alowdsyn" ,hlp = aR:T("osv_sys_adsyn_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_hisyn") ,comm = "actmod_sv_showhisyn",Gcomm = "actmod_sv_alowdsyn" ,hlp = aR:T("osv_sys_hisyn_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DButton",{name = aR:T("osv_sys_aallcop") ,comm = "actmod_sv_alowacop",Gcomm = "actmod_sv_alowdsyn" ,hlp = aR:T("osv_sys_aallcop_hlp") ,isSrv = true})
		aListOpt(sv_panel1,"DNumSlider",{name = aR:T("lesnd_svh_o") ,comm = "actmod_sv_soundlevel" ,hlp = aR:T("lesnd_svh_o_hlp") ,mnix = {5,100} ,isSrv = true})
		aListOpt(sv_panel1,"DNumSlider",{name = aR:T("osv_sys_rcam") ,comm = "actmod_sv_rangecam" ,hlp = aR:T("osv_sys_rcam_hlp") ,mnix = {10,2000} ,isSrv = true})
		aListOpt(sv_panel1,"DNumSlider",{name = aR:T("osv_sys_syrhook") ,comm = "actmod_sv_syrhook" ,hlp = aR:T("osv_sys_syrhook_hlp") ,mnix = {0,3} ,isSrv = true})
		sv_panel1.Paint = function(self, w, h) draw.RoundedBox( 4, 0, 0, w, h, Color( 50, 80, 100, self:GetAlpha() ) ) end
		sheet_sv:AddSheet( aR:T("_Settings"), sv_panel1, "icon16/table_gear.png" )
		
		local sv_panel2 = vgui.Create("AM4_DScrollPanel", sheet_sv)
		A_AM.ActMod.CLpanel_sv_panel2 = sv_panel2
		sv_panel2.WitL = function(txt)
			sheet_sv.WaitL = sheet_sv:Add("DPanel")
			local atat = sheet_sv.WaitL
			atat:SetText("")
			atat:Dock(FILL)
			atat.Think = function() atat:SetSize(sheet_sv:GetSize()) end
			atat.aSL = Material(txt and "icon16/disk.png" or "icon16/drive_go.png", "noclamp smooth")
			atat.Paint = function(aa,w,h)
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 140 ) )
				local ap = 155 + (100 * math.sin(CurTime() * 10))
				surface.SetDrawColor(Color(255, 255, 255, ap))
				surface.SetMaterial(Material("icon16/hourglass.png", "noclamp smooth"))
				surface.DrawTexturedRectRotated(w/2, h*0.3, 30, 30, -CurTime()*200 % 360)
				surface.SetDrawColor(color_white) surface.SetMaterial(aa.aSL) surface.DrawTexturedRect(w/2-15, h*0.5, 30, 30)
				draw.SimpleText( string.sub("........",-(CurTime() * 5)%10), "ActMod_a6", w/2, h*0.5+60, color_white ,1,1 )
			end 
		end
		sv_panel2.EndWitL = function() if IsValid(sheet_sv.WaitL) then sheet_sv.WaitL:Remove() end end
		if isSSrv then
			local boxadd = sv_panel2:Add("DButton")
			boxadd:SetText("") boxadd:Dock(TOP) boxadd:SetTall(30)
			boxadd.Paint = function(aa,w,h)
				if aa:IsHovered() then draw.RoundedBox( 0, 0, 0, w, h, aa:IsDown() and Color( 150, 100, 50, 180 ) or Color( 200, 150, 100, 150 ) ) end
				draw.SimpleText( "=>( + )<=", "ActMod_a6", w/2, h/2, color_white ,1,1 )
			end 
			boxadd.DoClick = function()
				if not isSSrv then return end
				surface.PlaySound("actmod/i_menu/menu_buttons_01.mp3")
				A_AM.ActMod.Actoji:Replace(1002,nil,function(Gname)
					net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"SCVCom","+|.BListD",Gname} ) net.SendToServer()
				end)
			end
			local b_lodn = boxadd:Add("DButton")
			b_lodn:SetText("") b_lodn:Dock(RIGHT) b_lodn:SetWide(30)
			b_lodn.Paint = function(aa,w,h)
				if aa:IsHovered() then draw.RoundedBox( 0, 0, 0, w, h, aa:IsDown() and Color( 100, 255, 200, 150 ) or Color( 100, 200, 200, 150 ) ) end
				surface.SetDrawColor(color_white) surface.SetMaterial(Material("icon16/drive_go.png", "noclamp smooth")) surface.DrawTexturedRect(2, 2, w-4, h-4)
			end 
			b_lodn.DoClick = function() sv_panel2.WitL() net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"SCVCom","L|.BListD","2"} ) net.SendToServer() end
			local b_Sav = boxadd:Add("DButton")
			b_Sav:SetText("") b_Sav:Dock(RIGHT) b_Sav:SetWide(30)
			b_Sav.Paint = function(aa,w,h)
				if aa:IsHovered() then draw.RoundedBox( 0, 0, 0, w, h, aa:IsDown() and Color( 100, 255, 200, 150 ) or Color( 100, 200, 200, 150 ) ) end
				surface.SetDrawColor(color_white) surface.SetMaterial(Material("icon16/disk.png", "noclamp smooth")) surface.DrawTexturedRect(2, 2, w-4, h-4)
			end 
			b_Sav.DoClick = function() sv_panel2.WitL(true) net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"SCVCom","S|.BListD","1"} ) net.SendToServer() end
			aListOpt(sv_panel2,"___",{name = "-------------------" ,Zall = 15 ,a_h = -5})
		end 
		sv_panel2.NGal = 0
		sv_panel2.GTabk = {}
		sv_panel2.Paint = function(self, w, h)
			draw.RoundedBox( 4, 0, 0, w, h, Color( 70, 40, 10, self:GetAlpha() ) )
			if istable(sv_panel2.GTabk) and table.Count(sv_panel2.GTabk) <= 0 then
				draw.SimpleText( "╮(･ᴗ･)╭", "ActMod_a6", w/2, h/2, color_white ,1,1 )
			end
		end
		net.Start( "A_AM.ActMod.ClToSv_Tab",true ) net.WriteTable( {"SCVCom","G|.BListD"} ) net.SendToServer()
		sv_panel2.GOnBDone = function(arm) sv_panel2.GTabk[arm]:Remove() sv_panel2.GTabk[arm] = nil end
		sv_panel2.grid = vgui.Create("DIconLayout", sv_panel2)
		sv_panel2.grid:Dock(FILL) sv_panel2.grid:SetSpaceX(5) sv_panel2.grid:SetSpaceY(5)
		sv_panel2.Think = function()
			if (sv_panel2.TimeTh or 0) < CurTime() then
				sv_panel2.TimeTh = CurTime() + 5
				net.Start( "A_AM.ActMod.ClToSv_Tab",true ) net.WriteTable( {"SCVCom","G|.BListD"} ) net.SendToServer()
				for k, v in pairs(sv_panel2.GTabk) do
					if not IsValid(v) or not v.daid or v.Removed or not A_AM.ActMod.Blacklist[v.daid] then
						sv_panel2.GTabk[k]:Remove()
						sv_panel2.GTabk[k] = nil
					end
				end
				for k, v in pairs(A_AM.ActMod.Blacklist) do
					if not sv_panel2.GTabk[k] then
						local box = sv_panel2.grid:Add("DButton")
						local knam = A_AM.ActMod:ReString(k)
						box:SetText("") box:SetSize(160, 180)
						if not isSSrv then box:SetCursor("arrow") end
						box.daid = k box.Note = v.n ~= "" and v.n box.Removing = false
						box.Nam = A_AM.ActMod:ReNameAct(knam) box.by = v.b
						box.mat = Material(A_AM.ActMod:RIPng(k), "noclamp smooth")
						box.Paint = function(aa,w,h)
							draw.RoundedBox( 0, 0, 0, w, h, Color( 45, 45, 45, 230 ) )
							draw.SimpleText( aa.Nam, "ActMod_a4", 2, 2, color_white )
							if aa:IsHovered() then
								if aa.by then draw.SimpleText("By: "..  aa.by, "ActMod_a4", 2, h-12, Color(255,255,200,255) ,0,1 ) end
							else
								if aa.Note then
									draw.SimpleText( aa.Note, "ActMod_a4", 2, h-12, Color(255,255,200,255) ,0,1 )
								elseif aa.by then
									draw.SimpleText("By: "..  aa.by, "ActMod_a4", 2, h-12, Color(255,255,200,255) ,0,1 )
								end
							end
							draw.RoundedBox( 0, 5, 20, w-10, h-40, Color( 200, 150, 100, 100 ) )
							surface.SetDrawColor(color_white)
							surface.SetMaterial(not aa.mat:IsError() and aa.mat or Material("icon16/help.png", "noclamp smooth"))
							surface.DrawTexturedRect(5, 20, w-10, h-40)
							if aa.Removing then
								draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 140 ) )
								local ap = 155 + (100 * math.sin(CurTime() * 10))
								surface.SetDrawColor(Color(255, 255, 255, ap))
								surface.SetMaterial(Material("actmod/imenu/hourglass_01.png", "noclamp smooth"))
								surface.DrawTexturedRectRotated(w/2, h/2, 100, 100, -CurTime()*200 % 360)
								draw.SimpleText( string.sub("........",-(CurTime() * 5)%10), "ActMod_a6", w/2, h/2+60, color_white ,1,1 )
							else
								if isSSrv and aa:IsHovered() then
									local ap = math.Clamp(math.sin(CurTime() * 4),0.2,1)
									surface.SetDrawColor(Color( 255, 255, 255, aa:IsDown() and 255 or 200*ap ))
									surface.SetMaterial(Material(aa:IsDown() and "icon16/cross.png" or "icon16/cancel.png", "noclamp smooth"))
									surface.DrawTexturedRect(w/2-40, h/2-40, w-80, h-100)
								end
							end
						end
						box.DoClick = function()
							if not isSSrv or box.Removing then return end
							box.Removing = true box:SetCursor("arrow")
							net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"SCVCom","-|.BListD",box.daid} ) net.SendToServer()
						end

						sv_panel2.NGal = sv_panel2.NGal + 1
						sv_panel2.GTabk[k] = box
					end
				end
			end
		end
		sheet_sv:AddSheet( " "..aR:T("blackList"), sv_panel2, "icon16/lock_edit.png" )
	end
	
	

	local sheet_cl = vgui.Create( "DPropertySheet", sheet )
	sheet_cl:Dock( FILL )
	sheet:AddSheet( aR:T("_Client"), sheet_cl, "icon16/wrench_orange.png" )
	
	local cl_panel1 = vgui.Create("AM4_DScrollPanel", sheet_cl)
	aListOpt(cl_panel1,"DButton",{name = aR:T("AC_After_Click") ,comm = "actmod_cl_automclose" ,hlp = aR:T("AC_After_Click_hlp")})
	aListOpt(cl_panel1,"DButton",{name = aR:T("AC_Hold_OMToggle") ,comm = "actmod_cl_smartomenu" ,hlp = aR:T("AC_Hold_OMToggle_hlp")})
	aListOpt(cl_panel1,"DButton",{name = aR:T("SHOW_P_Sel_Bar") ,comm = "actmod_cl_showslotss" ,hlp = aR:T("SHOW_P_Sel_Bar_hlp")})
	aListOpt(cl_panel1,"DButton",{name = aR:T("SHOW_Fav_Icon") ,comm = "actmod_cl_showiconsml" ,hlp = aR:T("SHOW_Fav_Icon_hlp")})
	aListOpt(cl_panel1,"DButton",{name = aR:T("SHOW_MsgAvs") ,comm = "actmod_cl_showmsgavs" ,hlp = aR:T("SHOW_MsgAvs_hlp")})
	aListOpt(cl_panel1,"DButton",{name = aR:T("SHOW_MsgAvsSnd") ,comm = "actmod_cl_showmsgavssnd",Gcomm = "actmod_cl_showmsgavs" ,hlp = aR:T("SHOW_MsgAvsSnd_hlp")})
	aListOpt(cl_panel1,"DButton",{name = aR:T("ocl_sys_sdwup") ,comm = "actmod_cl_sdwfix" ,hlp = aR:T("ocl_sys_sdwup_hlp")})
	aListOpt(cl_panel1,"DButton",{name = aR:T("ocl_sys_sharrow") ,comm = "actmod_cl_showarrow" ,hlp = aR:T("ocl_sys_sharrow_hlp")})
	aListOpt(cl_panel1,"DButton",{name = aR:T("ocl_ic_shlig") ,comm = "actmod_cl_showsholightic" ,hlp = aR:T("ocl_ic_shlig_hlp")})
	aListOpt(cl_panel1,"DButton",{name = aR:T("ocl_ic_hisyn") ,comm = "actmod_cl_showhisyn" ,hlp = aR:T("ocl_ic_hisyn_hlp")})
	aListOpt(cl_panel1,"DNumSlider",{name = aR:T("lesnd_h_y") ,comm = "actmod_cl_soundlevel" ,hlp = aR:T("lesnd_h_y_hlp") ,mnix = {5,100}})
	aListOpt(cl_panel1,"DComboBox",{name = aR:T("ocl_GHTyp") ,comm = "actmod_cl_g_hud_typ" ,hlp = aR:T("ocl_GHTyp_hlp") ,mnix = {0,2} ,TabAddC = {[0] = aR:T("Ltxt_GHTyp_tn") ,[1] = aR:T("Ltxt_GHTyp_t1") ,[2] = aR:T("Ltxt_GHTyp_t2") ,[3] = aR:T("Ltxt_GHTyp_t3") ,[4] = aR:T("Ltxt_GHTyp_t4") ,[5] = aR:T("Ltxt_GHTyp_t5")}})
	aListOpt(cl_panel1,"DComboBox",{name = aR:T("Ltxt_QF") ,comm = "actmod_cl_q_ef" ,hlp = aR:T("Ltxt_QF_hlp") ,mnix = {0,2} ,TabAddC = {[1] = aR:T("Ltxt_QLow") ,[2] = aR:T("Ltxt_QMedium") ,[3] = aR:T("Ltxt_QHigh") ,[4] = aR:T("Ltxt_QMaximum")}})
	aListOpt(cl_panel1,"DNumSlider",{name = aR:T("ocl_sys_viewdis") ,comm = "actmod_cl_viewdis" ,hlp = aR:T("ocl_sys_viewdis_hlp") ,mnix = {0,9000}})
	cl_panel1.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, Color( 100, 100, 50, self:GetAlpha() ) )
	end
	sheet_cl:AddSheet( aR:T("_Settings"), cl_panel1, "icon16/table_gear.png" )
	
	local cl_panel2 = vgui.Create("AM4_DScrollPanel", sheet_cl)
	aListOpt(cl_panel2,"DNumSlider",{name = aR:T("lesnd_h_o") ,comm = "actmod_cl_soundlevelother" ,hlp = aR:T("lesnd_h_o_hlp") ,mnix = {5,100}})
	aListOpt(cl_panel2,"___",{name = "-------------------" ,Zall = 15 ,a_h = -5})
	cl_panel2.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, Color( 100, 100, 50, self:GetAlpha() ) )
	end
	cl_panel2.NGal = 0
	cl_panel2.GTabk = {}
	cl_panel2.Think = function()
		if (cl_panel2.TimeTh or 0) < CurTime() then cl_panel2.TimeTh = CurTime() + 1
			for k, v in pairs(A_AM.ActMod.OptSFPly) do
				if not IsValid(v["Ply"]) then
					if A_AM.ActMod.OptSFPly[k] and cl_panel2.GTabk[k] and IsValid(cl_panel2.GTabk[k]) then
						cl_panel2.GTabk[k]:Remove()
						cl_panel2.GTabk[k] = nil
					end
					A_AM.ActMod.OptSFPly[k] = nil
				end
			end
			for k, v in pairs(player.GetAll()) do
				if v ~= LocalPlayer() then
					local iD64 = v:SteamID64()
					if cl_panel2.GTabk[iD64] and IsValid(cl_panel2.GTabk[iD64]) and not IsValid(v) then
						cl_panel2.GTabk[iD64]:Remove()
						cl_panel2.GTabk[iD64] = nil
					end
					if not cl_panel2.GTabk[iD64] then
						cl_panel2.NGal = cl_panel2.NGal + 1
						cl_panel2.GTabk[iD64] = aListPly(cl_panel2,iD64,{["name"] = v:Nick() ,["Ply"] = v})
					end
				end
			end
		end
	end
	sheet_cl:AddSheet( " "..aR:T("Hear_O_Playrs"), cl_panel2, "icon16/sound.png" )
	
	if IsValid(sheet_sv) then
		if not isSSrv then sheet:SetActiveTab( sheet:GetItems()[2].Tab ) end
	end
end

local function AaMaStart(aa,typ,ax,ay,zx,zy,ag,txt,taa,taj)
	local awaa = vgui.Create(typ,aa)
	awaa:SetSize( zx,zy )
	awaa:SetPos( ax-awaa:GetWide()/2,ay-awaa:GetTall()/2 )
	awaa:SetText("")
	awaa.waa = false
	awaa.BOn = true
	awaa.taaA = ""
	if taa then
		if isstring(taj) and taj ~= "" then
			awaa.taaA = taj
		else
			if taa == "ic_yo" then
				if A_AM.ActMod.autDon_URL_Y then
					awaa.taaA = A_AM.ActMod.autDon_URL_Y
				else
					awaa.taaA = "https://youtu.be/huTGPGgVz4M"
				end
			end
			if taa == "ic_bi" then
				if A_AM.ActMod.autDon_URL_B then
					awaa.taaA = A_AM.ActMod.autDon_URL_B
				else
					awaa.taaA = "https://www.bilibili.com/video/BV1YX4y1R7fb"
				end
			end
			if taa == "ic_pye" then
				if A_AM.ActMod.autDon_URL_P then
					awaa.taaA = A_AM.ActMod.autDon_URL_P
				else
					awaa.taaA = "http://paypal.me/400283"
				end
			end
			if taa == "ic_cfi" then
				if A_AM.ActMod.autDon_URL_K then
					awaa.taaA = A_AM.ActMod.autDon_URL_K
				else
					awaa.taaA = "https://ko-fi.com/ahmedmake400"
				end
			end
			if awaa.taaA == "" and taa != "ext" then
				awaa.BOn = false
				awaa.txtLock = aR:T("AHlp_Txt3")
			end
		end
	end
	awaa:SetAlpha(0) awaa:AlphaTo(255,0.4)
	timer.Simple(0.4,function() if IsValid(awaa) then awaa.waa = true end end)
	awaa.Paint = function(ss,w,h)
		if taa and taa == "ext" then
			if aa.loaa == false then
				draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 100, 50, 20, 255 ) )
			else
				if ss:IsHovered() then
					draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 100, 150, 150, 255 ) )
				else
					draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 100, 100, 100, 255 ) )
				end
			end
		elseif taa and ss.taaA == "" then
			draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 50, 50, 20, 255 ) )
		elseif ss:IsHovered() then
			draw.RoundedBox( 10, 0, 0, w, h, Color( 150, 200, 170, 255 ) )
		else
			draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 150, 140, 150, 255 ) )
		end
		if taa then
			if string.find(string.sub(taa,1,-3), "ic_") then
				surface.SetDrawColor(color_white)
				surface.SetMaterial( Material("actmod/imenu/".. taa ..".png", "noclamp smooth") )
				surface.DrawTexturedRect(15,7.5, 45, 45)
				draw.SimpleTextOutlined( txt, "ActMod_a6", w/2+15, h/2, Color(80, 255, 255, 255) ,1,1, 2, Color( 50, 110, 255, 255 ) )
				if taa and ss.taaA == "" then
					if ss:IsHovered() then
						draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 50, 50, 20, 255 ) )
						draw.SimpleTextOutlined( ss.txtLock, "ActMod_a6", w/2, h/2, Color(200, 200, 200, 255) ,1,1, 2, Color( 120, 110, 50, 255 ) )
					else
						draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 50, 50, 20, 150 ) )
					end
				end
			else
				draw.SimpleTextOutlined( txt, "ActMod_a6", w/2, h/2, Color(80, 255, 255, 255) ,1,1, 2, Color( 50, 110, 255, 255 ) )
			end
		else
			draw.SimpleTextOutlined( txt, "ActMod_a6", w/2, h/2, Color(80, 255, 255, 255) ,1,1, 2, Color( 50, 110, 255, 255 ) )
		end
	end
	if typ == "DButton" then
		awaa.DoClick = function ( s )
			if awaa.BOn == false then return end
			if taa then
				if taa == "ext" and IsValid(aa) then
					if aa.loaa == false then return end
					RunConsoleCommand("actmod_cl_showbhelp", "0")
					aa:Remove()
				else
					SetClipboardText(awaa.taaA)
					surface.PlaySound("actmod/s/copy1.mp3")
					if IsValid(awaa.txh) then awaa.txh:Remove() end
					awaa.txh = vgui.Create( "DLabel", awaa )
					awaa.txh:SetSize( awaa:GetWide(), awaa:GetTall() )
					awaa.txh:SetPos( 0, 0 ) awaa.txh:SetText("") awaa.txh:SetAlpha(255)
					awaa.txh:AlphaTo( 0,0.5,0.5,function(s) if IsValid(awaa.txh) then awaa.txh:Remove() end end )
					awaa.txh.Paint = function ( s, w, h ) draw.RoundedBox( 50, 0, 0, w, h, Color(20,90,200,255) )
						draw.SimpleText( aR:T("LReplace_txt_CopyLink"), "ActMod_a2", w/2, h/2-14, color_white, 1, 1 )
						draw.SimpleText( awaa.taaA, "ActMod_a4", w/2, h/2+6, color_white, 1, 1 )
					end
					aa.loaa = true
				end
			else
				if awaa.waa == false then return end
				if IsValid(awaa) then awaa:Remove() end
				if txt != "START" then aa.Ydon = txt end
				aa.Entra(ag)
			end
		end
		awaa.DoRightClick = function ( s )
			if awaa.BOn == false then return end
			if taa then
				if taa == "ic_yo" or taa == "ic_bi" or taa == "ic_pye" or taa == "ic_cfi" then gui.OpenURL(awaa.taaA) end
				aa.loaa = true
			end
		end
	end
	return awaa
end

function A_AM.ActMod:MListHlp(trA,ATT)
	local ply,trr = LocalPlayer(),false
	local OAasa = vgui.Create("DFrame")
	timer.Simple(0.5,function() if IsValid(OAasa) and trr == false then OAasa:Remove() end end)
	OAasa:SetTitle( "" )
	OAasa:SetSize( 350,250 )
	OAasa:SetCursor( "arrow" )
	OAasa:MakePopup() OAasa:Center()
	OAasa.loaa = false
	OAasa.txt1 = aR:T("AHlp_Txt1")
	OAasa.txt2 = aR:T("AHlp_Txt2")
	input.SetCursorPos( OAasa:GetX() + OAasa:GetWide()/2+130, OAasa:GetY() + OAasa:GetTall()/2 -10)
	OAasa.Paint = function ( ss, w, h )
		draw.RoundedBox( 10, 0, 0, w, h, Color( 100, 100, 80, 255 ) ) 
		draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 50, 80, 120, 225 ) ) 
		draw.SimpleText( ss.txt1, "ActMod_a6", w/2, h/2-90, Color(215,225,255,255) ,1,1 )
		draw.SimpleText( ss.txt2, "ActMod_a4", w/2, h/2-70, Color(215,225,255,255) ,1,1 )
	end
	if ATT == "LTD" then
		if A_AM.ActMod.autLTD_URLY then AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2-15,230,65,0,"YouTube","ltd_yo",A_AM.ActMod.autLTD_URLY) end
		if A_AM.ActMod.autLTD_URLB then AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2+45,230,60,0,"bilibili","ltd_bi",A_AM.ActMod.autLTD_URLB) end
	else
		AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2-15,230,65,0,"YouTube","ic_yo")
		AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2+45,230,60,0,"bilibili","ic_bi")
	end
	if not trA then
		AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2+100,190,40,0,aR:T("AHlp_HMenu"),"ext")
	end
	trr = true
end

function A_AM.ActMod:MSupMe()
	local ply,trr = LocalPlayer(),false
	local OAasa = vgui.Create("DFrame")
	timer.Simple(0.5,function() if IsValid(OAasa) and trr == false then OAasa:Remove() end end)
	OAasa:SetTitle( "" )
	OAasa:SetSize( 350,250 )
	OAasa:SetCursor( "arrow" )
	OAasa:MakePopup() OAasa:Center()
	OAasa.loaa = false
	OAasa.txt1 = aR:T("AHlp_Txt11")
	OAasa.txt2 = aR:T("AHlp_Txt2")
	input.SetCursorPos( OAasa:GetX() + OAasa:GetWide()/2+130, OAasa:GetY() + OAasa:GetTall()/2 -10)
	OAasa.Paint = function ( ss, w, h )
		draw.RoundedBox( 10, 0, 0, w, h, Color( 100, 100, 80, 255 ) ) 
		draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 50, 80, 120, 225 ) ) 
		draw.SimpleText( ss.txt1, "ActMod_a6", w/2, h/2-90, Color(215,225,255,255) ,1,1 )
		draw.SimpleText( ss.txt2, "ActMod_a4", w/2, h/2-70, Color(215,225,255,255) ,1,1 )
	end
	AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2-15,230,65,0,"PayPal","ic_pye")
	AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2+45,230,60,0,"Ko-fi","ic_cfi")
	trr = true
end

local function AaMuhIBox(saa)
	local DBu1 = vgui.Create( "DButton", saa )
	DBu1:SetSize( 30, 30) DBu1:SetPos( EmeA.aFrame:GetWide()-DBu1:GetWide()-10, 10) DBu1:SetText("X")
	DBu1:SetAlpha(0) DBu1:AlphaTo(255,0.2)
	DBu1.Paint = function(s,w,h)
		draw.RoundedBox( 15, 0, 0, w, h, Color( 150, 80, 50, 255 ) )
	end
	DBu1.DoClick = function( s ) if IsValid(EmeA) then EmeA:Remove() end end
	return DBu1
end

function A_AM.ActMod:MunGam1Box()
	local ply,trr = LocalPlayer(),false
	local OAasa = vgui.Create("DFrame")
	timer.Simple(0.5,function() if IsValid(OAasa) and trr == false then OAasa:Remove() end end)
	OAasa:SetTitle( "" )
	OAasa:SetSize( 350,230 )
	OAasa:SetCursor( "arrow" )
	OAasa:MakePopup() OAasa:Center()
	OAasa.fid = 0
	OAasa.waa = false
	OAasa.strt = 0
	OAasa.rond = 0
	OAasa.ronx = 10
	OAasa.s1 = 0
	OAasa.s2 = 0
	OAasa.s3 = 0
	OAasa.Gdon = 0
	OAasa.Ydon = "?"
	OAasa.GTi = CurTime()
	OAasa.STi = false
	OAasa.RTi = 0
	timer.Simple(0.2,function() if IsValid(OAasa) then OAasa.waa = true end end)
	input.SetCursorPos( OAasa:GetX() + OAasa:GetWide()/2, OAasa:GetY() + OAasa:GetTall()/2 +40)
	OAasa.Paint = function ( ss, w, h )
		draw.RoundedBox( 10, 0, 0, w, h, Color( 40, 50, 80, 255 ) ) 
		draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 100, 100, 130, 255 ) ) 
		draw.SimpleText( OAasa.rond .." / ".. OAasa.ronx, "ActMod_a6", w/2, h/2-80, Color(255,255,100,255) ,1,1 )
		if ss.rond < 6 then
			draw.SimpleText( OAasa.s1 .." + ".. OAasa.s2 .." = ".. OAasa.Ydon , "ActMod_a6", w/2, h/2-50, OAasa.fid == 2 and Color(150,255,255,180) or OAasa.fid == 1 and Color(255,170,100,255) or Color(255,255,255,255) ,1,1 )
		else
			draw.SimpleText( OAasa.s1 .." + ".. OAasa.s2 .." + ".. OAasa.s3 .." = ".. OAasa.Ydon , "ActMod_a6", w/2, h/2-50, OAasa.fid == 2 and Color(150,255,255,180) or OAasa.fid == 1 and Color(255,170,100,255) or Color(255,255,255,255) ,1,1 )
		end
		if OAasa.fid == 1 then
			draw.SimpleTextOutlined( "(".. OAasa.Gdon ..")" , "GModToolName", w/2, h/2+60, Color(100, 120, 80, 255) ,1,1, 1, Color( 255, 255, 50, 255 ) )
		end
		if OAasa.RTi > 0 then
			if (ss.GTi or 0) < CurTime() and OAasa.STi == true then
				ss.GTi = CurTime() + 1
				ss.RTi = ss.RTi - 1
				if OAasa.RTi <= 0 then OAasa.STi = false ss.Fntra() end
			end
			draw.SimpleText( " _ ".. ss.RTi-1 .." _ ", "ActMod_a6", w/2, h/2, OAasa.RTi < 4 and Color(255,math.max(200 + (255 * math.sin(CurTime() * 15)), 0),math.max(100 + (255 * math.sin(CurTime() * 15)), 0),255) or OAasa.RTi < 7 and Color(255,200,100,255) or Color(255,235,200,255) ,1,1 )
		end
	end
	OAasa.Fntra = function()
		if IsValid(OAasa.B1) then OAasa.B1:Remove() end
		if IsValid(OAasa.B2) then OAasa.B2:Remove() end
		if IsValid(OAasa.B3) then OAasa.B3:Remove() end
		surface.PlaySound("actmod/s/button19.mp3")
		OAasa.fid = 1
		OAasa.STi = false
		OAasa.Ydon = OAasa.Gdon
		timer.Simple(1.5,function() if IsValid(OAasa) then
			OAasa.fid = 0
			OAasa.waa = false
			OAasa.strt = 0
			OAasa.rond = 0
			OAasa.ronx = 10
			OAasa.s1 = 0
			OAasa.s2 = 0
			OAasa.s3 = 0
			OAasa.Gdon = 0
			OAasa.Ydon = "?"
			OAasa.GTi = CurTime()
			OAasa.STi = false
			OAasa.RTi = 0
			AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2+40,100,50,0,"START")
		end end)
	end
	local function ANo_Avs_ok(ply,txt)
		if txt then return (!ply.GetTable_Avs or (ply.GetTable_Avs and ply.GetTable_Avs["Avs_"..txt]["ok"] == "no")) end return false
	end
	OAasa.Cntra = function()
		if ANo_Avs_ok(ply,"a1_3") == true then
			if A_AM.ActMod:AG_DatA(7,"Avs_a1_3") >= 3 then
				A_AM.ActMod:AG_DatA(1,A_AM.ActMod:A_BED(2,"QXZzX2ExXzM="),"yes") A_AM.ActMod:AShowB(ply,"Avs_a1_3",aR:T("LAchievements_a1_m3"))
			else
				A_AM.ActMod:AG_DatA(1,A_AM.ActMod:A_BED(2,"QXZzX2ExXzM="),nil,A_AM.ActMod:AG_DatA(7,"Avs_a1_3")+1)
				if A_AM.ActMod:AG_DatA(7,"Avs_a1_3") >= 3 then
					A_AM.ActMod:AG_DatA(1,A_AM.ActMod:A_BED(2,"QXZzX2ExXzM="),"yes") A_AM.ActMod:AShowB(ply,"Avs_a1_3",aR:T("LAchievements_a1_m3"))
				else
					A_AM.ActMod:AShowB(ply,"Avs_a1_3","  ".. A_AM.ActMod:AG_DatA(7,"Avs_a1_3") .." / 3  ",2)
				end
			end
		end
		if IsValid(OAasa.B1) then OAasa.B1:Remove() end
		if IsValid(OAasa.B2) then OAasa.B2:Remove() end
		if IsValid(OAasa.B3) then OAasa.B3:Remove() end
		surface.PlaySound("actmod/s/s2.mp3")
		timer.Simple(3.5,function() if IsValid(OAasa) then
		OAasa.fid = 0
		OAasa.waa = false
		OAasa.strt = 0
		OAasa.rond = 0
		OAasa.ronx = 15
		OAasa.s1 = 0
		OAasa.s2 = 0
		OAasa.s3 = 0
		OAasa.Gdon = 0
		OAasa.Ydon = "?"
		OAasa.GTi = CurTime()
		OAasa.STi = false
		OAasa.RTi = 0
			AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2+40,100,50,0,"START")
		end end)
	end
	OAasa.Entra = function(aa)
		if IsValid(OAasa.B1) then OAasa.B1:SetDisabled(true) end
		if IsValid(OAasa.B2) then OAasa.B2:SetDisabled(true) end
		if IsValid(OAasa.B3) then OAasa.B3:SetDisabled(true) end
		timer.Simple(1,function() if IsValid(OAasa) then
			if IsValid(OAasa.B1) then OAasa.B1:Remove() end
			if IsValid(OAasa.B2) then OAasa.B2:Remove() end
			if IsValid(OAasa.B3) then OAasa.B3:Remove() end
			OAasa.fid = 0
		end end)
		OAasa.STi = false
		if aa == 0 then
			surface.PlaySound("actmod/s/button9.mp3")
		else
			OAasa.fid = 2
			if OAasa.Gdon == OAasa.Ydon then
				surface.PlaySound("actmod/s/button15.mp3")
				OAasa.rond = OAasa.rond + 1
				if OAasa.rond == OAasa.ronx then
					OAasa.Cntra()
					return
				end
			else
				surface.PlaySound("actmod/s/button19.mp3")
				OAasa.Fntra()
				return
			end
		end
		if OAasa.rond < 6 then
			timer.Simple(1.5,function() if IsValid(OAasa) then
				local Ttmdon = {}
				local RwdTtn = 1
				OAasa.Ydon = "?"
				OAasa.RTi = 9 - OAasa.rond/2
				OAasa.strt = OAasa.strt + 1
				OAasa.s1 = math.Round(math.random(1,OAasa.strt*4))
				OAasa.s2 = math.Round(math.random(OAasa.strt*4,1))
				OAasa.Gdon = OAasa.s1 + OAasa.s2
				table.insert(Ttmdon, OAasa.Gdon*2) table.insert(Ttmdon, OAasa.Gdon) table.insert(Ttmdon, OAasa.Gdon-3)
				RwdTtn = math.Round(math.random(1,3))
				timer.Simple(0.5,function() if IsValid(OAasa) then OAasa.B1 = AaMaStart(OAasa,"DButton",OAasa:GetWide()/2-100,OAasa:GetTall()/2+60,60,40,1,Ttmdon[RwdTtn])
				if IsValid(OAasa.B1) then OAasa.B1:SetDisabled(true) end
				table.remove( Ttmdon, RwdTtn ) RwdTtn = math.Round(math.random(1,2))
				timer.Simple(0.3,function() if IsValid(OAasa) then OAasa.B2 = AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2+60,60,40,2,Ttmdon[RwdTtn])
				if IsValid(OAasa.B1) then OAasa.B1:SetDisabled(true) end if IsValid(OAasa.B2) then OAasa.B2:SetDisabled(true) end
				table.remove( Ttmdon, RwdTtn )
				timer.Simple(0.2,function() if IsValid(OAasa) then OAasa.B3 = AaMaStart(OAasa,"DButton",OAasa:GetWide()/2+100,OAasa:GetTall()/2+60,60,40,3,Ttmdon[1])
				if IsValid(OAasa.B1) then OAasa.B1:SetDisabled(false) end if IsValid(OAasa.B2) then OAasa.B2:SetDisabled(false) end if IsValid(OAasa.B3) then OAasa.B3:SetDisabled(false) end
				timer.Simple(0.5,function() if IsValid(OAasa) then OAasa.RTi = math.Round(9 - OAasa.rond/2) OAasa.STi = true
				end end) end end) end end) end end)
			end end)
		else
			timer.Simple(1.5,function() if IsValid(OAasa) then
				local Ttmdon = {}
				local RwdTtn = 1
				OAasa.Ydon = "?"
				OAasa.RTi = 20 - OAasa.rond
				OAasa.strt = OAasa.strt + 1
				OAasa.s1 = math.Round(math.random(1,OAasa.strt*4))
				OAasa.s2 = math.Round(math.random(OAasa.strt*4,1))
				OAasa.s3 = math.Round(math.random(OAasa.strt,1))
				OAasa.Gdon = OAasa.s1 + OAasa.s2 + OAasa.s3
				table.insert(Ttmdon, OAasa.Gdon*2) table.insert(Ttmdon, OAasa.Gdon) table.insert(Ttmdon, OAasa.Gdon-3)
				RwdTtn = math.Round(math.random(1,3))
				timer.Simple(0.5,function() if IsValid(OAasa) then OAasa.B1 = AaMaStart(OAasa,"DButton",OAasa:GetWide()/2-100,OAasa:GetTall()/2+60,60,40,1,Ttmdon[RwdTtn])
				if IsValid(OAasa.B1) then OAasa.B1:SetDisabled(true) end
				table.remove( Ttmdon, RwdTtn ) RwdTtn = math.Round(math.random(1,2))
				timer.Simple(0.3,function() if IsValid(OAasa) then OAasa.B2 = AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2+60,60,40,2,Ttmdon[RwdTtn])
				if IsValid(OAasa.B1) then OAasa.B1:SetDisabled(true) end if IsValid(OAasa.B2) then OAasa.B2:SetDisabled(true) end
				table.remove( Ttmdon, RwdTtn )
				timer.Simple(0.2,function() if IsValid(OAasa) then OAasa.B3 = AaMaStart(OAasa,"DButton",OAasa:GetWide()/2+100,OAasa:GetTall()/2+60,60,40,3,Ttmdon[1])
				if IsValid(OAasa.B1) then OAasa.B1:SetDisabled(false) end if IsValid(OAasa.B2) then OAasa.B2:SetDisabled(false) end if IsValid(OAasa.B3) then OAasa.B3:SetDisabled(false) end
				timer.Simple(0.5,function() if IsValid(OAasa) then OAasa.RTi = math.Round(20 - OAasa.rond) OAasa.STi = true
				end end) end end) end end) end end)
			end end)
		end
	end
	timer.Simple(0.5,function() if IsValid(OAasa) then AaMaStart(OAasa,"DButton",OAasa:GetWide()/2,OAasa:GetTall()/2+40,100,50,0,"START") end end)
	trr = true
end
	
function A_AM.ActMod:MunChIBox()
	local ply,trr = LocalPlayer(),false
	local EmeA = vgui.Create("DButton")
	timer.Simple(0.5,function() if IsValid(EmeA) and trr == false then EmeA:Remove() end end)
	EmeA:SetSize( ScrW(), ScrH() ) EmeA:SetAlpha(0)
	EmeA:SetText("") EmeA:SetCursor( "arrow" )
	EmeA:MakePopup() EmeA:Center()
	EmeA.waa = false
	timer.Simple(0.2,function() if IsValid(EmeA) then EmeA.waa = true end end)
	input.SetCursorPos( EmeA:GetX() + EmeA:GetWide()/2, EmeA:GetY() + EmeA:GetTall()/2 +67.5)
	EmeA.DoClick = function ( s ) if IsValid(EmeA) then EmeA:Remove() end end
	EmeA.Paint = function ( ss, w, h ) end
	
	local aGFileIc = A_AM.ActMod.Settings["IconsActs"]
	local icn = A_AM.ActMod:ActaLoed("ActojiDial",math.Round(math.Rand( 1, 8 )))
	local zX,zY,zA,zI = 240,240,65,10
	local GMat = "actmod/sm_hover.png"
	if file.Exists("materials/actmod/sm_hover2.png", "GAME") then GMat = "actmod/sm_hover2.png" end
	EmeA.aFrame = vgui.Create("DPanel",EmeA)
	EmeA.aFrame:SetSize( 400, 400 )
	EmeA.aFrame.OnRemove = function( pan )
		if IsValid(EmeA) then EmeA:Remove() end
	end
	EmeA.aFrame.tas = true
	EmeA.aFrame:SetText("")
	EmeA.aFrame:MakePopup()
	EmeA.aFrame:Center() EmeA.aFrame:SetAlpha(0) EmeA.aFrame:AlphaTo(255,0.2)
	EmeA.aFrame.Paint = function(s,w,h)
		if EmeA.aFrame.tas == false then
			draw.RoundedBox( 20, 0, 0, w, h, Color( 60, 60, 50, 255 ) )
			draw.RoundedBox( 25, 15, 15, w-30, h-30, Color( 80, 100, 200, 255 ) )
		end
		if (s.t or 0) < CurTime() then
			s.t = CurTime() + 2
			icn = Actoji.table[math.Round(math.Rand( 1, 21 ))]
			if math.Rand( 1, 2 ) == 2 then
				icn = A_AM.ActMod:ActaLoed("ActojiDialh",math.Round(math.Rand( 1, 5 )))
			elseif math.Rand( 1, 2 ) == 2 then
				icn = A_AM.ActMod:ActaLoed("ActojiDial2",math.Round(math.Rand( 1, 8 )))
			elseif math.Rand( 1, 2 ) == 2 then
				icn = A_AM.ActMod:ActaLoed("ActojiDial3",math.Round(math.Rand( 1, 8 )))
			else
				icn = A_AM.ActMod:ActaLoed("ActojiDial",math.Round(math.Rand( 1, 8 )))
			end
		end
		if EmeA.aFrame.tas == true then
			surface.SetDrawColor( Color( 60, 200, 200, math.max(0,math.min(100, 50+(100*math.sin(CurTime()*4)))) ) )
			surface.DrawOutlinedRect( w/2-zX/2-zI/2-5,h/2-zY/2-zI/2-5-zA, zX+zI+10, zY+zI+10 ,5 )
		else
			draw.RoundedBox( 5, w/2-zX/2-zI/2,h/2-zY/2-zI/2-zA, zX+zI, zY+zI, Color(60,60,50,255) )
		end
		surface.SetDrawColor(color_white)
		if GetConVarNumber("actmod_cl_stibox") > 1 then
			surface.SetMaterial( Material("materials/actmod/sm_hover".. tostring(GetConVarNumber("actmod_cl_stibox")) ..".png", "noclamp smooth") )
		else
			surface.SetMaterial( Material("materials/actmod/sm_hover.png", "noclamp smooth") )
		end
		surface.DrawTexturedRect(w/2-zX/2+zI/2,h/2-zY/2+zI/2-zA, zX-zI, zY-zI)
		surface.SetMaterial( Material(aGFileIc .."/".. icn, "noclamp smooth") )
		surface.DrawTexturedRect(w/2-zX/2,h/2-zY/2-zA, zX, zY)
	end
	
	local Scroll = vgui.Create( "DScrollPanel", EmeA.aFrame )
	Scroll:SetSize( 310, 105 )
	Scroll:SetPos( EmeA.aFrame:GetWide()/2-Scroll:GetWide()/2, EmeA.aFrame:GetTall()/2-Scroll:GetTall()/2 + 140 )

	local List = vgui.Create( "DIconLayout", Scroll )
	List:Dock( FILL )
	List:SetSpaceY( 5 )
	List:SetSpaceX( 5 )
	List.Paint = function(s,w,h)
		draw.RoundedBox( 10, 0, 0, w, h, Color( 60,60,50,255 ) )
	end

	local num = 0
	for k, v in pairs(file.Find("materials/actmod/sm_hover*" ,"GAME")) do
		if string.find(string.sub(v,-4,-1), ".png") then
			num = num + 1
			local Liem = List:Add( "DButton" )
			Liem:SetSize( 70, 70 )
			Liem:SetText("")
			Liem.num = num
			Liem.Paint = function(s,w,h)
				surface.SetDrawColor(color_white)
				surface.SetMaterial( Material("materials/actmod/".. v, "noclamp smooth") )
				surface.DrawTexturedRect(10,10,w-20,h-20)
				if GetConVarNumber("actmod_cl_stibox") == s.num then
					surface.SetDrawColor( Color( 50, 100, 255, 255 ) )
					surface.DrawOutlinedRect( 5,5,w-10,h-10,4+(2*math.sin(CurTime()*4)) )
				end
			end
			Liem.DoClick = function( s ) ply:ConCommand("actmod_cl_stibox ".. tostring(Liem.num) .."\n") end
		end
	end
	
	EmeA.Dt1 = vgui.Create( "DButton", EmeA.aFrame )
	EmeA.Dt1:SetSize( 30, 30) EmeA.Dt1:SetPos( EmeA.aFrame:GetWide()-EmeA.Dt1:GetWide()-10, 10) EmeA.Dt1:SetText("O")
	EmeA.Dt1:SetAlpha(0) EmeA.Dt1:AlphaTo(255,0.2)
	EmeA.Dt1.Paint = function(s,w,h)
		draw.RoundedBox( 15, 0, 0, w, h, Color( 100, 100, 50, 200 ) )
		draw.RoundedBox( 10, 5, 5, w-10, h-10, Color( 50, 50, 60, 255 ) )
	end
	EmeA.Dt1.DoClick = function( s )
		if EmeA.aFrame.tas == true then
			EmeA.aFrame.tas = false
		else
			EmeA.aFrame.tas = true
		end
	end
	trr = true
end




A_AM.ActMod.ActGrpP = A_AM.ActMod.ActGrpP or {}
local ActGrpP = A_AM.ActMod.ActGrpP

function A_AM.ActMod:LTDSvToCl( GetStrg,GetTan )
	LocalPlayer().ActMod_TC_TblPly = GetTan
	local TC_TblPly = LocalPlayer().ActMod_TC_TblPly
	if IsValid(ActGrpP.Frame) then
		if istable(TC_TblPly) then
			local TC_TblPly_aa,a_1,a_2,a_3 = 0,false,false,false
			local LPSID64 = LocalPlayer():SteamID64()
			if TC_TblPly["TouAre"] == "Main" then
				TC_TblPly_aa = 1
				TC_TblPly["GetTabPlysNow"] = {}
				TC_TblPly["GetTabPlayers"] = {}
			else
				for k, v in pairs(TC_TblPly["GetTabGpsNow"]) do
					if v and IsValid(v["Ply"]) and v["id64"] and v["id64"] ~= LPSID64 then
						a_1 = true
						break
					end
				end
				if TC_TblPly["GetTabPlayers"] and TC_TblPly["GetTabPlayers"]["GetPlayers"] and TC_TblPly["GetTabPlayers"]["GetPlayers"][1] and IsValid(TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["Ply"]) then
					if TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["SetOwneTeam"] == true then
						if TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["id64"] ~= LPSID64 then
							a_2 = true
						end
						if TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["id64"] == LPSID64 then
							a_3 = true
						end
					end
				end
				if a_1 or a_2 or a_3 then
					if a_1 and a_2 and a_3 then
						TC_TblPly_aa = 0
					elseif a_1 and not a_2 and not a_3 then
						TC_TblPly_aa = 1
					elseif a_2 and not a_3 then
						TC_TblPly_aa = 2
					elseif a_3 then
						TC_TblPly_aa = 3
					end
				end
			end
			if TC_TblPly_aa > 0 then
				if TC_TblPly_aa == 1 then
					ActGrpP.Frame.AppkTbl("Main")
				elseif TC_TblPly_aa == 2 then
					ActGrpP.Frame.AppkTbl("InTDance")
				elseif TC_TblPly_aa == 3 then
					ActGrpP.Frame.AppkTbl("OwTDance")
				else
					ActGrpP.Frame.AppkTbl("none")
				end
			else
				if TC_TblPly["TouAre"] == "Main" then
					ActGrpP.Frame.AppkTbl("Main")
				elseif TC_TblPly["TouAre"] == "InTDance" then
					ActGrpP.Frame.AppkTbl("InTDance")
				elseif TC_TblPly["TouAre"] == "OwTDance" then
					ActGrpP.Frame.AppkTbl("OwTDance")
				else
					ActGrpP.Frame.AppkTbl("none")
				end
			end
			if IsValid(ActGrpP.Frame.WLoad_1) then
				ActGrpP.Frame.WLoad_1.EndWLoad()
			end
			if IsValid(ActGrpP.Frame.WLoad_2_3) then
				ActGrpP.Frame.WLoad_2_3.EndWLoad()
			end
		end
		if GetStrg == "StratAct" then
			ActGrpP:Close()
		elseif GetStrg == "ReYourListPly" then
			if IsValid(ActGrpP.Frame.rePL) then ActGrpP.Frame.rePL.ReListPlys() end
		elseif GetStrg == "GetLisGpNow" then
			if IsValid(ActGrpP.Frame.LisGpTD) then ActGrpP.Frame.LisGpTD.ReListPlys() end
		elseif GetStrg == "ReSandListPly" then 
			if IsValid(ActGrpP.Frame.LisSand) then ActGrpP.Frame.LisSand.ReListPlys() end
		elseif GetStrg == "ReInvListPly" then 
			if IsValid(ActGrpP.Frame.LisInv) then ActGrpP.Frame.LisInv.ReListPlys() end
		elseif GetStrg == "ReInListPly" then 
			if IsValid(ActGrpP.Frame.reIn) then ActGrpP.Frame.reIn.ReListPlys() end
		end
	end
end

A_AM.ActMod.bessys_2_Done = true
