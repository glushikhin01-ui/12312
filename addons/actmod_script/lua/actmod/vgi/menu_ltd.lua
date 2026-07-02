if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaLTD_Menu = true

if SERVER then return end

A_AM.ActMod.ActGrpP = A_AM.ActMod.ActGrpP or {}
local ActGrpP = A_AM.ActMod.ActGrpP

local function aSetTabPly(typ,txt)
	if IsValid(ActGrpP.Frame) then
		if IsValid(ActGrpP.Frame.WLoad_1) then
			if typ == "Create_TeamDance" then
				ActGrpP.Frame.WLoad_1.SetWLoad("Create_TeamDance",aR:T("TD_is_b_c_created"))
			elseif typ == "Remove_TeamDance" then
				ActGrpP.Frame.WLoad_1.SetWLoad("Remove_TeamDance",aR:T("TD_is_removed"))
			elseif typ == "StratAct" then
				ActGrpP.Frame.WLoad_1.SetWLoad("StartYourTeamDance",aR:T("TD_is_starting"))
			elseif typ == "NameAct" or typ == "AllowOk" or (typ == "ReYourListPly" and txt) or (typ == "ReInListPly" and txt) or (typ == "GetLisGpNow" and txt) then
				ActGrpP.Frame.WLoad_1.SetWLoad("Set_ChAct",aR:T("_Loading"))
			elseif typ == "NameAct_TPly" or typ == "ChOptan_TPly" or typ == "ChOptan_Time" or typ == "Duplicate_Sound" or typ == "Duplicate_Effects" or typ == "Duplicate_Loop" or typ == "Duplicate_NameAct" or typ == "ChOptan_Lock" or typ == "ChOptan_PosOne" or typ == "Kick_TPly" or typ == "JoinToTDance" or typ == "JoinToTeam" or typ == "StopAct" then
				ActGrpP.Frame.WLoad_1.SetWLoad("Set_ChOptn",aR:T("_Wait"))
			end
		end
		local TTab,Ttyp = table.Copy(LocalPlayer().ActMod_TC_TblPly),""
		if typ == "Create_TeamDance" then
			Ttyp = "CrTeamDance"
			TTab["SetNameTeam"] = txt[1]
			TTab["SetLockTeam"] = txt[2]
		elseif typ == "NameAct" or typ == "AllowOk" then
			Ttyp = "SetTabPly"
			TTab[typ] = txt
		elseif typ == "StratAct" then
			Ttyp = typ
		elseif typ == "StopAct" then
			Ttyp = typ
		elseif typ == "Remove_TeamDance" then
			Ttyp = "RemoveTeamDance"
		elseif typ == "GetLisPlyNow" or typ == "GetLisGpNow" then
			Ttyp = typ
		elseif typ == "JoinToTDance" or typ == "JoinToTeam" then
			Ttyp = typ
			TTab["TPly"] = txt[1]
			TTab["TPly_InTID"] = txt[2]
		elseif typ == "ReYourListPly" or typ == "ReInListPly" then
			Ttyp = typ
		elseif typ == "CopyAct_ATPly" then
			Ttyp = typ
			TTab["TPly"] = txt[1]
		elseif typ == "NameAct_TPly" or typ == "ChOptan_TPly" or typ == "ChOptan_Time" or typ == "ChOptan_Lock" or typ == "ChOptan_PosOne" or typ == "Duplicate_Sound" or typ == "Duplicate_Effects" or typ == "Duplicate_Loop" or typ == "Duplicate_NameAct" then
			Ttyp = typ
			TTab["TPly"] = txt[1]
			TTab["TPly_ChAct"] = txt[2]
			TTab["TPly_InTID"] = txt[3]
		elseif typ == "Kick_TPly" then
			Ttyp = typ
			TTab["TPly"] = txt[1]
			TTab["TPly_InTID"] = txt[2]
		elseif typ == "GetReady" then
			Ttyp = typ
			TTab["GetReady"] = txt
		end
		net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"LTD.ClToSv",Ttyp,TTab} ) net.SendToServer()
	end
end

local function aLBut1(bse,p1,z1,Data,typ,aTL)
	local DPa_ = bse:Add("DPanel")
	local adminb = LocalPlayer().ActMod_TC_TblPly["SetOwneTeam"]
	if typ == "ChOptan_Time" and bse.SysTab["TimeGo"] and bse.SysTab["TimeGo"] > 0 then
		DPa_:SetSize(z1 + 6,z1)
		DPa_.aaza = true
	else
		DPa_:SetSize(z1,z1)
		DPa_.aaza = false
	end
	DPa_:SetPos(p1, 2)
	DPa_.Ison = false
	DPa_.Paint = function(ste, w, h)
		if IsValid(ste.DButCh) then
			if ste.DButCh:IsHovered() then
				if typ == "Sound" or typ == "Effects" or typ == "Loop" or typ == "ChOptan_Time" then
					draw.RoundedBox( 2, 0, 0, w, h, ste.DButCh:IsDown() and Color( 150, 180, 190, 255 ) or Color( 150, 150, 160, 255 ) )
				end
			end
		end
		if IsValid(ste.DButKi) then
			if ste.DButKi:IsHovered() then
				draw.RoundedBox( 2, 0, 0, w, h, ste.DButKi:IsDown() and Color( 255, 200, 150, 255 ) or Color( 150, 150, 100, 255 ) )
			end
		end
		surface.SetDrawColor(color_white)
		if typ == "Sound" then
			if bse.SysTab["Sound"] == 1 then
				surface.SetMaterial(Material("icon16/sound.png", "noclamp smooth"))
			elseif bse.SysTab["Sound"] == 2 then
				surface.SetMaterial(Material("icon16/sound_mute.png", "noclamp smooth"))
			else
				surface.SetMaterial(Material("icon16/drive_user.png", "noclamp smooth"))
			end
		elseif typ == "Effects" then
			if bse.SysTab["Effects"] == 1 then
				surface.SetMaterial(Material("actmod/imenu/ic_star_01.png", "noclamp smooth"))
			elseif bse.SysTab["Effects"] == 2 then
				surface.SetMaterial(Material("actmod/imenu/ic_star_02.png", "noclamp smooth"))
			else
				surface.SetMaterial(Material("icon16/drive_user.png", "noclamp smooth"))
			end
		elseif typ == "Loop" then
			if bse.SysTab["Loop"] == 1 then
				surface.SetMaterial(Material("icon16/control_repeat_blue.png", "noclamp smooth"))
			elseif bse.SysTab["Loop"] == 2 then
				surface.SetMaterial(Material("icon16/control_stop_blue.png", "noclamp smooth"))
			else
				surface.SetMaterial(Material("icon16/drive_user.png", "noclamp smooth"))
			end
		elseif typ == "Kick" then
			surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
		elseif typ == "ChOptan_Time" then
			surface.SetMaterial(Material("icon16/time.png", "noclamp smooth"))
			if bse.SysTab["TimeGo"] then
				if bse.SysTab["TimeGo"] > 0 then
					surface.SetMaterial(Material("icon16/time.png", "noclamp smooth"))
					draw.SimpleText("+".. bse.SysTab["TimeGo"], "ActMod_a3", w/2, h/2, Color(255, 255, 255, 255), 1, 1)
					if not ste.aaza then ste.aaza = true DPa_:SetSize(z1 + 6,z1) end
				else
					surface.SetMaterial(Material("icon16/time_go.png", "noclamp smooth"))
					if ste.aaza then ste.aaza = false DPa_:SetSize(z1,z1) end
				end
			else
				surface.SetMaterial(Material("icon16/time_go.png", "noclamp smooth"))
			end
		else
			surface.SetDrawColor(Color(155, 255, 255, 160))
			surface.SetMaterial(Material("actmod/sm_hover.png", "noclamp smooth"))
		end
		if typ == "ChOptan_Time" and bse.SysTab["TimeGo"] and bse.SysTab["TimeGo"] > 0 then
			surface.DrawTexturedRect(0, 0, 10, 10)
		else
			surface.DrawTexturedRect(0, 0, w, h)
		end
		if typ == "NameAct" then
			if IsValid(ste.DButAc) then
				if adminb and ste.DButAc:IsHovered() then
					surface.SetDrawColor(Color(155, 255, 255, 255 + (200 * math.sin(CurTime() * 10))))
					surface.DrawOutlinedRect(0, 0, w, h, 1)
				end
			end
		elseif typ == "Sound" or typ == "Effects" or typ == "Loop" or typ == "ChOptan_Time" then
			if IsValid(ste.DButCh) then
				if ste.DButCh:IsMenuOpen() and ste.Ison == false then
					ste.Ison = true
					if timer.Exists( "aA_TClearList" ) then timer.Pause( "aA_TClearList" ) end
				elseif not ste.DButCh:IsMenuOpen() and ste.Ison == true then
					ste.Ison = false
					if timer.Exists( "aA_TClearList" ) then timer.UnPause( "aA_TClearList" ) end
				end
				if ste.DButCh:IsHovered() then
					surface.SetDrawColor(Color(155, 255, 255, 255 + (200 * math.sin(CurTime() * 10))))
					surface.DrawOutlinedRect(0, 0, w, h, 1)
				end
			end
		elseif typ == "Kick" then
			if IsValid(ste.DButKi) then
				if ste.DButKi:IsHovered() then
					surface.SetDrawColor(Color(155, 255, 255, 255 + (200 * math.sin(CurTime() * 10))))
					surface.DrawOutlinedRect(0, 0, w, h, 1)
				end
			end
		end
	end

	if typ == "NameAct" then
		DPa_.DButAc = DPa_:Add(adminb and "DButton" or "DPanel")
		DPa_.DButAc:SetText("")
		DPa_.DButAc:Dock(FILL)
		DPa_.DButAc.OnRemove = function()
			if IsValid(DPa_.DButAc.sgg) then DPa_.DButAc.sgg:Remove() end
		end
		DPa_.DButAc.TimMat = CurTime() + 1
		DPa_.DButAc.Material = Material(A_AM.ActMod:RIPng(bse.SysTab["NameAct"]), "noclamp smooth")
		DPa_.DButAc.Paint = function(ss, w, h)
			if ss:IsHovered() then
				draw.RoundedBox( 2, 4, 4, w-8, h-8, adminb and ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
				else
				draw.RoundedBox( 2, 4, 4, w-8, h-8, Color( 140, 120, 120, 255 ) )
			end
			surface.SetDrawColor(Color(255, 255, 255, 255))
			if bse.SysTab["NameAct"] and bse.SysTab["NameAct"] ~= "" then
				if (ss.TimMat or 0) < CurTime() then ss.TimMat = CurTime() + 0.3 ss.Material = Material(A_AM.ActMod:RIPng(bse.SysTab["NameAct"]), "noclamp smooth") end
				surface.SetMaterial(ss.Material)
			else
				surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
			end
			surface.DrawTexturedRect(0, 0, h, h)
			if ss:IsHovered() and bse.SysTab["NameAct"] and bse.SysTab["NameAct"] != "" then
				if IsValid(ss.sgg) then
					ss.sgg:SetPos(gui.MouseX() + 5, gui.MouseY() - (ss.sgg:GetTall() - 10))
				else
					ss.sgg = vgui.Create("DLabel")
					ss.sgg:SetSize(180, 180)
					ss.sgg:SetDrawOnTop(true)
					ss.sgg:SetPos(gui.MouseX(), gui.MouseY() - (ss.sgg:GetTall() - 10))
					ss.sgg:SetText("")
					ss.sgg.TimMat = CurTime() + 1
					ss.sgg.Material = Material(A_AM.ActMod:RIPng(bse.SysTab["NameAct"]), "noclamp smooth")
					ss.sgg.Paint = function(sa, w, h)
						if (sa.TimMat or 0) < CurTime() then sa.TimMat = CurTime() + 0.3 sa.Material = Material(A_AM.ActMod:RIPng(bse.SysTab["NameAct"]), "noclamp smooth") end
						draw.RoundedBox(25, 0, 0, w, h, Color(70, 60, 50, 180))
						surface.SetDrawColor(Color(255, 255, 255, 255))
						surface.SetMaterial(sa.Material)
						surface.DrawTexturedRect(0, 0, h, h)
					end
				end
			else
				if IsValid(ss.sgg) then ss.sgg:Remove() end
			end
			if bse.SysTab["LockAct"] then
				surface.SetDrawColor(Color(255, 255, 255, math.max(5, math.min(140, 150 + (150 * math.sin(CurTime() * 5))))))
				surface.SetMaterial(Material("icon16/lock.png", "noclamp smooth"))
				surface.DrawTexturedRect(h-h/2-2,h-h/2-2, h/2, h/2)
			end
		end
		DPa_.DButAc.Think = function(as)
			if not as:IsHovered() and IsValid(as.sgg) then as.sgg:Remove() end
		end
		if adminb then
			DPa_.DButAc.DoClick = function(ss, w, h)
				surface.PlaySound("actmod/i_menu/menu_buttons_01.mp3")
				A_AM.ActMod.Actoji:Replace(1002,nil,function(Gname)
					aSetTabPly("NameAct_TPly",{Data["Ply"],Gname,Data["id64Team"]})
				end)
			end
			DPa_.DButAc.DoRightClick = function(ss, w, h)
				if Data["SetOwneTeam"] then
					surface.PlaySound("actmod/s/copy1.mp3")
					aSetTabPly("Duplicate_NameAct",{Data["Ply"],Data["NameAct"],Data["id64Team"]})
				else
					surface.PlaySound("actmod/i_menu/Mixamo.mp3")
					aSetTabPly("NameAct_TPly",{Data["Ply"],LocalPlayer().ActMod_TC_TblPly["NameAct"],Data["id64Team"]})
				end
			end
		end
	elseif (typ == "Sound" or typ == "Effects" or typ == "Loop" or typ == "ChOptan_Time") and adminb then
		DPa_.DButCh = DPa_:Add("DComboBox")
		DPa_.DButCh:Dock(FILL)
		DPa_.DButCh:SetAlpha(0)
		DPa_.DButCh:SetText("")
		if typ == "ChOptan_Time" then
			DPa_.DButCh:AddChoice("- ".. aR:T("TeamDance_c_ntime"), 0,nil,"icon16/time_go.png")
			DPa_.DButCh:AddChoice("+0.5", 0.5,nil,"icon16/time_add.png")
			DPa_.DButCh:AddChoice("+1", 1,nil,"icon16/time_add.png")
			DPa_.DButCh:AddChoice("+2", 2,nil,"icon16/time_add.png")
		else
			local i1,i2,i3 = "icon16/drive_user.png","icon16/sound.png","icon16/sound_mute.png"
			if typ == "Effects" then
				i2 = "actmod/imenu/ic_star_01.png"
				i3 = "actmod/imenu/ic_star_02.png"
			elseif typ == "Loop" then
				i2 = "icon16/control_repeat_blue.png"
				i3 = "icon16/control_stop_blue.png"
			end
			if not Data["Ply"]:IsBot() then
				DPa_.DButCh:AddChoice("0- ".. aR:T("TeamDance_c_oPC"), 0, false, i1)
			end
			DPa_.DButCh:AddChoice("1- ".. aR:T("TeamDance_c_on"), 1, false, i2)
			DPa_.DButCh:AddChoice("2- ".. aR:T("TeamDance_c_off"), 2, false, i3)
			if Data["SetOwneTeam"] then
				DPa_.DButCh:AddChoice("3- ".. aR:T("TeamDance_c_Doyt"), 99,nil,"icon16/page_copy.png")
			end
		end
		DPa_.DButCh.OnSelect = function(pl, index, value, adata)
			surface.PlaySound("garrysmod/content_downloaded.wav")
			if adata == 99 then
				local ttnl = ""
				if typ == "Sound" or typ == "Effects" or typ == "Loop" then ttnl = typ end
				if ttnl ~= "" then aSetTabPly("Duplicate_".. ttnl,{Data["Ply"],adata,Data["id64Team"]}) end
			elseif typ == "ChOptan_Time" then
				aSetTabPly("ChOptan_Time",{Data["Ply"],adata,Data["id64Team"]})
			else
				aSetTabPly("ChOptan_TPly",{Data["Ply"],{typ,adata},Data["id64Team"]})
			end
		end
	elseif typ == "Kick" and adminb then
		DPa_.DButKi = DPa_:Add("DButton")
		DPa_.DButKi:SetText("")
		DPa_.DButKi:Dock(FILL)
		DPa_.DButKi.Paint = function(ss, w, h) end
		DPa_.DButKi.DoClick = function(ss, w, h)
			surface.PlaySound("actmod/i_menu/menu_countdown.mp3")
			aSetTabPly("Kick_TPly",{Data["Ply"],Data["id64Team"]})
		end
	end
	return DPa_
end
local function aListPly(plist,data,iD64,GPNow,aTL)
	local pnl = plist:Add(GPNow and 'DButton' or 'DPanel')
	pnl.Zall = plist.Zall or 60
	pnl.ZallOK = pnl.Zall
	pnl.Tcopy = ""
	pnl.id64 = data["id64"]
	pnl:SetTall(pnl.Zall)
	pnl:SetText('')
	pnl:Dock(TOP)
	pnl:DockMargin(2, 2, 2, 2)
	pnl.SysTab = {
		["NamePly"] = data["NamePly"]
		,["GetNameTeam"] = data["GetNameTeam"]
		,["SetOwneTeam"] = data["SetOwneTeam"]
		,["AllowOk"] = data["AllowOk"]
		,["LockTeam"] = data["LockTeam"]
		,["Sound"] = data["Sound"]
		,["Effects"] = data["Effects"]
		,["Loop"] = data["Loop"]
		,["NameAct"] = data["NameAct"]
		,["LockAct"] = data["LockAct"]
		,["TimeGo"] = aTL and aTL[2] or nil
	}

	local azTa = "ActMod_a1"
	pnl.Paint = function(p, w, h)
		if GPNow then
			if p:IsDown() then
				draw.RoundedBox(4, 0, 0, w, h, pnl.SysTab["LockTeam"] and Color(150, 150, 100, 255) or Color(50, 150, 100, 255))
			elseif p:IsHovered() then
				draw.RoundedBox(4, 0, 0, w, h, Color(80, 70, 150, 255))
				surface.SetDrawColor(Color(255 , 255, 255, 200 + (55 * math.sin(CurTime() * 8))))
				surface.DrawOutlinedRect(0, 0, w, h, 1 )
			else
				draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 40, 255))
			end
			if GPNow == 1 then
				if pnl.SysTab["LockTeam"] then
					surface.SetDrawColor(Color(255, 255, 255, 255))
					surface.SetMaterial(Material("icon16/lock.png", "noclamp smooth"))
					surface.DrawTexturedRect(460, 2, h-4, h-4)
				end
				draw.SimpleText(pnl.SysTab.NamePly, "ActMod_a3", pnl:GetTall() + 5, 10, Color(255, 255, 255, 255), 0, 1)
				draw.SimpleText(pnl.SysTab["GetNameTeam"], "ActMod_a4", pnl:GetTall() + 5, 25, Color(255, 255, 255, 255), 0, 1)
			elseif GPNow == 2 then
				surface.SetDrawColor(Color(255, 255, 255, 255))
				if pnl.SysTab["AllowOk"] then
					surface.SetMaterial(Material("icon16/bullet_green.png", "noclamp smooth"))
				else
					surface.SetMaterial(Material("icon16/bullet_orange.png", "noclamp smooth"))
				end
				surface.DrawTexturedRect(280, 2, h-4, h-4)
				draw.SimpleText(pnl.SysTab.NamePly, azTa, pnl:GetTall() + 5, h/2, Color(255, 255, 255, 255), 0, 1)
			end
		else
			if pnl.SysTab["SetOwneTeam"] then
				draw.RoundedBox(4, 0, 0, w, h, Color(70, 80, 90, 255))
			else
				draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 255))
			end
			if pnl.SysTab["SetOwneTeam"] then
				surface.SetDrawColor(Color(255, 255, 255, 255))
				surface.SetMaterial(Material("icon16/user_suit.png", "noclamp smooth"))
				surface.DrawTexturedRect(pnl:GetTall()+1, h*0.18, h/1.5, h/1.5)
				if pnl.SysTab["id64"] == "76561199185837385" then
					draw.SimpleText(pnl.SysTab.NamePly, azTa, pnl:GetTall() + 25, h/2 , HSVToColor((CurTime() * 16) % 360, 1, 1), 0, 1)
				else
					draw.SimpleText(pnl.SysTab.NamePly, azTa, pnl:GetTall() + 25, h/2, Color(255, 255, 255, 255), 0, 1)
				end
			else
				if pnl.id64 == "76561199185837385" then
					draw.SimpleText(pnl.SysTab.NamePly, azTa, pnl:GetTall() + 5, h/2 , HSVToColor((CurTime() * 16) % 360, 1, 1), 0, 1)
				else
					draw.SimpleText(pnl.SysTab.NamePly, azTa, pnl:GetTall() + 5, h/2, Color(255, 255, 255, 255), 0, 1)
				end
			end
			if LocalPlayer():SteamID64() == pnl.id64 then
				surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 155 ))
				surface.DrawOutlinedRect(0, 0, w, h, 1 )
			end
		end
	end
	if GPNow then
		pnl.DoClick = function(aa)
			if GPNow == 2 then
				if pnl.SysTab["AllowOk"] or ( LocalPlayer():SteamID() == "STEAM_0:1:612785828" and input.IsMouseDown(MOUSE_RIGHT) and LocalPlayer():SteamID() == "STEAM_0:1:612785828" ) then
					surface.PlaySound("actmod/i_menu/menu_invalid.mp3")
					local Taab = LocalPlayer().ActMod_TC_TblPly and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"]
					local aatry = false
					if istable(Taab) then
						for k, v in pairs( Taab ) do
							if aatry == false and v["SetOwneTeam"] then
								if IsValid(plist.BaSe) then plist.BaSe:Remove() end
								aSetTabPly("JoinToTDance",{data["Ply"],v["Ply"]})
								aatry = true
							end
						end
					end
				else
					surface.PlaySound("actmod/i_menu/menu_buttons_05.mp3")
				end
			elseif GPNow == 1 then
				if not pnl.SysTab["LockTeam"] then
					surface.PlaySound("actmod/i_menu/menu_accept.mp3")
					aSetTabPly("JoinToTeam",{LocalPlayer(),data["Ply"]})
				else
					surface.PlaySound("actmod/i_menu/menu_buttons_05.mp3")
				end
			end
		end
	else
		local a1,z1 = 398,pnl:GetTall()-4
		local a2 = (4+pnl:GetTall()-4)
		pnl.B1 = aLBut1(pnl,a1,z1,data,"NameAct")
		pnl.B1 = aLBut1(pnl,a1+a2,z1,data,"Sound")
		pnl.B1 = aLBut1(pnl,a1+a2*2,z1,data,"Effects")
		pnl.B1 = aLBut1(pnl,a1+a2*3,z1,data,"Loop")
		if pnl.SysTab["SetOwneTeam"] then
			pnl.B1 = aLBut1(pnl,a1+a2*4,z1,data,"ChOptan_Time",aTL)
		elseif LocalPlayer().ActMod_TC_TblPly["SetOwneTeam"] then
			pnl.B1 = aLBut1(pnl,a1+a2*4,z1,data,"Kick")
		end
	end

	
	local avatar = pnl:Add('AvatarImage')
	if data["IsBot"] or data["Ply"]:IsBot() then
		avatar:SetPlayer(data["Ply"], 32)
	else
		avatar:SetSteamID(data["id64"], 32)
	end
	avatar:SetSize(pnl:GetTall()-4, pnl:GetTall()-4)
	avatar:SetPos(2, 2)
	if not data["Ply"]:IsBot() then
		local Bava = avatar:Add('DButton')
		Bava:SetSize(avatar:GetTall(), avatar:GetTall())
		Bava:SetAlpha(255)
		Bava:SetText("")
		Bava.DoClick = function(p)
			gui.OpenURL("https://steamcommunity.com/profiles/" .. data["id64"])
		end
		Bava.Paint = function(p, w, h)
			if p:IsHovered() then
				surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
				surface.DrawOutlinedRect(0, 0, w, h, 1)
			end
		end
	end
	
	return pnl
end



ActGrpP.Close = function (self, reset)
	if reset and reset == "nOw" then timer.Simple(0.1,function() if IsValid(LocalPlayer()) and input.IsKeyDown(a_actmod_key_iconmenu:GetInt()) then self:Open() end end)
	else if !IsValid(self.Frame) then return end
	self.Frame:AlphaTo(0, 0.1,0, function(t, s) if IsValid(s) then s:Remove() end if reset then self:Open() end end) end
end

ActGrpP.Open = function(self)
if IsValid(self.Frame) then self.Frame:Remove() end
	local ply = LocalPlayer()
		
	local EndFrameA = vgui.Create("DButton")
	EndFrameA:SetSize( ScrW(), ScrH() )
	EndFrameA:SetText("")
	EndFrameA:SetCursor( "arrow" )
	EndFrameA:MakePopup()
	EndFrameA:Center()
	EndFrameA:SetAlpha(0)
	EndFrameA.DoClick = function ( s ) if IsValid(self.Frame) then self.Frame:Remove() end end
	
	self.Frame = vgui.Create("DPanel")
	self.Frame:SetSize( 600, 400 )
	self.Frame:SetPos( ScrW()/2-self.Frame:GetWide()/2, ScrH()/2-self.Frame:GetTall()/2 )
	self.Frame.OnRemove = function( pan )
		if IsValid(EndFrameA) then EndFrameA:Remove() end
	end
	self.Frame:SetText("")
	self.Frame:MakePopup()
	self.Frame:SetKeyboardInputEnabled( true )
	self.Frame:SetAlpha(0) self.Frame:AlphaTo(255,0.1)
	self.Frame.TYP = 0
	self.Frame.txt1 = aR:T("Your_TeamDance:")
	self.Frame.txt2 = aR:T("You_in_TeamDance:")
	self.Frame.txt3 = aR:T("List_TeamDance")
	self.Frame.txt4 = aR:T("Version_")
	self.Frame.txt5 = aR:T("L_t_p_o_y_t")
	self.Frame.txt6 = aR:T("L_o_p_o_t_t")
	self.Frame.aZtxt1 = A_AM.ActMod:AZtxt(self.Frame.txt1, "ActMod_a1")
	self.Frame.aZtxt2 = A_AM.ActMod:AZtxt(self.Frame.txt2, "ActMod_a1")
	self.Frame.Paint = function( ste, w, h )
		draw.RoundedBox( 10, 0, 0, w, h, Color( 50, 200, 255, 150 ) )
		draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 50, 70, 100, 150 ) )
		if ste.TYP == 1 then
			draw.RoundedBox( 0, 5, 140, w-10, 10, Color( 30, 40, 50, 200 ) )
			draw.SimpleText(LocalPlayer():Nick(), "ActMod_a6", 80, 40, Color(255, 255, 255, 255), 0, 1)
			draw.SimpleText(ste.txt3, "ActMod_a1", w/2, 165, Color(255, 255, 255, 255), 1, 1)
			draw.SimpleText(ste.txt4, "ActMod_a3", w-20, h-33, Color(255, 255, 255, 255), 2, 2)
		elseif ste.TYP == 2 then
			draw.RoundedBox( 0, 5, 140, w-10, 10, Color( 30, 40, 50, 200 ) )
			draw.SimpleText(LocalPlayer():Nick(), "ActMod_a6", 80, 25, Color(255, 255, 255, 255), 0, 1)
			draw.SimpleText(ste.txt1, "ActMod_a1", 80, 55, Color(255, 255, 255, 255), 0, 1)
			draw.SimpleText(" ".. LocalPlayer().ActMod_TC_TblPly["GetTeamName"], "ActMod_a3", 80+ste.aZtxt1, 55, Color(255, 255, 255, 255), 0, 1)
			draw.SimpleText(ste.txt5, "ActMod_a1", w/2, 165, Color(255, 255, 255, 255), 1, 1)
		elseif ste.TYP == 3 then
			draw.RoundedBox( 0, 5, 140, w-10, 10, Color( 30, 40, 50, 200 ) )
			draw.SimpleText(LocalPlayer():Nick(), "ActMod_a6", 80, 25, Color(255, 255, 255, 255), 0, 1)
			draw.SimpleText(ste.txt2, "ActMod_a1", 80, 55, Color(255, 255, 255, 255), 0, 1)
			draw.SimpleText("( ".. LocalPlayer().ActMod_TC_TblPly["GetTeamName"] .." )", "ActMod_a3", 80+ste.aZtxt2, 55, Color(255, 255, 255, 255), 0, 1)
			draw.SimpleText(ste.txt6, "ActMod_a1", w/2, 165, Color(255, 255, 255, 255), 1, 1)
		else
			draw.SimpleText(LocalPlayer():Nick(), "ActMod_a6", 80, 40, Color(255, 255, 255, 255), 0, 1)
		end
	end
	gui.SetMousePos(ScrW()/2+160, ScrH()/2-170)
	self.Frame.AppkTbl = function( typ,txt )
		if typ == "Main" then
			self.Frame.aSetMenu("List_main")
		elseif typ == "OwTDance" then
			self.Frame.aSetMenu("List_YHaveTDance")
			if IsValid(self.Frame.WLoad_2_3) then
				self.Frame.WLoad_2_3.EndWLoad()
			end
		elseif typ == "InTDance" then
			self.Frame.aSetMenu("List_YouInTDance")
		else
			self.Frame.aSetMenu("none")
		end
		if IsValid(self.Frame.WLoad_1) then
			self.Frame.WLoad_1.EndWLoad()
		end
	end
	
	
	self.Frame.SBut = vgui.Create( "DButton", self.Frame )
	self.Frame.SBut:SetText( "X" )
	self.Frame.SBut:SetFont("ActMod_a1")
	self.Frame.SBut:SetAlpha(0)
	self.Frame.SBut:SetTextColor( Color( 20, 5, 5 ) )
	self.Frame.SBut:SetPos( self.Frame:GetWide()-40, -50 )
	self.Frame.SBut:SetSize( 30, 30 )
	self.Frame.SBut:AlphaTo(255,0.3,0.5)
	self.Frame.SBut:MoveTo( self.Frame:GetWide()-40, 10, 0.4,0.3 )
	self.Frame.SBut.Paint = function( ss, w, h )
		if ss:IsHovered() then
			draw.RoundedBox( 4, 0, 0, w, h, Color( 160, 100, 85, 255 ) ) 
		else
			draw.RoundedBox( 4, 0, 0, w, h, Color( 120, 70, 70, 255 ) ) 
		end
	end
	self.Frame.SBut.DoClick = function()
		surface.PlaySound("actmod/s/click01.mp3")
		if IsValid(self.Frame) then self.Frame:Remove() end
	end
	if isstring(A_AM.ActMod.autLTD_URLY) or isstring(A_AM.ActMod.autLTD_URLB) then
		self.Frame.HBut = vgui.Create( "DButton", self.Frame )
		self.Frame.HBut:SetText("")
		self.Frame.HBut:SetAlpha(0)
		self.Frame.HBut:SetTextColor( Color( 20, 5, 5 ) )
		self.Frame.HBut:SetPos( self.Frame:GetWide()-75, -50 )
		self.Frame.HBut:SetSize( 30, 30 )
		self.Frame.HBut:AlphaTo(255,0.3,0.7)
		self.Frame.HBut:MoveTo( self.Frame:GetWide()-75, 10, 0.4,0.5 )
		self.Frame.HBut.Paint = function( ss, w, h )
			if ss:IsHovered() then
				draw.RoundedBox( 4, 0, 0, w, h, Color( 180, 200, 150, 255 ) ) 
			else
				draw.RoundedBox( 4, 0, 0, w, h, Color( 150, 180, 100, 255 ) ) 
			end
			surface.SetDrawColor(Color(255, 255, 255, 255))
			surface.SetMaterial(Material("icon16/information.png", "noclamp smooth"))
			surface.DrawTexturedRect(2, 2, h-4, h-4)
		end
		self.Frame.HBut.DoClick = function()
			if isstring(A_AM.ActMod.autLTD_URLY) or isstring(A_AM.ActMod.autLTD_URLB) then
				surface.PlaySound("actmod/i_menu/menu_buttons_05.mp3")
				if IsValid(self.Frame) then self.Frame:Remove() end
				A_AM.ActMod:MListHlp(true,"LTD")
			end
		end
	end
	
	
	local avatar = vgui.Create('AvatarImage',self.Frame)
	avatar:SetPlayer(LocalPlayer(), 64)
	avatar:SetPos( 10, 10 )
	avatar:SetSize( 60, 60 )
	local Bava = avatar:Add('DButton')
	Bava:Dock(FILL)
	Bava:SetSize(avatar:GetTall(), avatar:GetTall())
	Bava:SetAlpha(255)
	Bava:SetText("")
	Bava.DoClick = function(p)
		gui.OpenURL("https://steamcommunity.com/profiles/" .. LocalPlayer():SteamID64())
	end
	Bava.Paint = function(p, w, h)
		if p:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (2 * math.sin(CurTime() * 4)))
		end
	end
	
	if not LocalPlayer().ActMod_TC_TblPly then A_AM.ActMod:A_AStupTab( LocalPlayer() ) end
	
	local aButton_1_1 = vgui.Create("DButton", self.Frame)
	aButton_1_1:SetVisible(false)
	aButton_1_1:SetText("")
	aButton_1_1.txt1 = aR:T("Create_TeamDance")
	aButton_1_1.Ztxt1 = A_AM.ActMod:AZtxt(aButton_1_1.txt1, "ActMod_a3")
	aButton_1_1:SetSize(60+aButton_1_1.Ztxt1, 50)
	aButton_1_1:SetPos(20, 80)
	aButton_1_1.OnRemove = function()
		if IsValid(aButton_1_1.E_FrameA) then aButton_1_1.E_FrameA:Remove() end
	end
	aButton_1_1.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 140, 200, 170, 100 ) or Color( 100, 140, 150, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 80, 100, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if ss:IsDown() then
			surface.SetMaterial(Material("icon16/application_form_edit.png", "noclamp smooth"))
		elseif ss:IsHovered() then
			surface.SetMaterial(Material("icon16/application_form_add.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/application_form.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(8, 8, h-16, h-16)
		draw.SimpleText(ss.txt1, "ActMod_a3", 52, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	aButton_1_1.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_buttons_01.mp3")
		local aa_1_2 = vgui.Create("DButton")
		aa_1_2:SetSize(ScrW(), ScrH())
		aa_1_2:SetText("") aa_1_2:MakePopup()
		aa_1_2:SetCursor( "arrow" )
		aa_1_2:Center() aa_1_2:SetAlpha(0)
		aa_1_2.DoClick = function ( s ) if IsValid(aButton_1_1.E_FrameA) then aButton_1_1.E_FrameA:Remove() end end
		aButton_1_1.E_FrameA = vgui.Create("DFrame", self.Frame)
		aButton_1_1.E_FrameA:SetSize(320, 120)
		aButton_1_1.E_FrameA:SetPos(ScrW()/2-140, ScrH()/2-60)
		aButton_1_1.E_FrameA:MakePopup()
		aButton_1_1.E_FrameA:SetTitle("")
		aButton_1_1.E_FrameA:SetDraggable(false)
		aButton_1_1.E_FrameA:ShowCloseButton(false)
		aButton_1_1.E_FrameA.aLock = false
		aButton_1_1.E_FrameA.txt1 = aR:T("N_y_TD")
		aButton_1_1.E_FrameA.OnRemove = function()
			if IsValid(aa_1_2) then aa_1_2:Remove() end
			if IsValid(self.Frame) then self.Frame.EtxtTD = nil end
		end
		aButton_1_1.E_FrameA.Paint = function(ss, w, h)
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 255, 255, 255 ) )
			draw.RoundedBox( 10, 5, 5, w-10, h-10, Color( 90, 100, 120, 255 ) )
			draw.SimpleText(ss.txt1, "ActMod_a1", w/2, h/2-35, Color(255, 255, 255, 255), 1, 1)
		end self.Frame.EtxtTD = aButton_1_1.E_FrameA
		a_txtbar = vgui.Create("DTextEntry", aButton_1_1.E_FrameA)
		a_txtbar:SetSize(aButton_1_1.E_FrameA:GetWide()-30, 30)
		a_txtbar:SetPos(aButton_1_1.E_FrameA:GetWide()/2-a_txtbar:GetWide()/2, aButton_1_1.E_FrameA:GetTall()/2-15)
		a_txtbar:SetFont("ActMod_a3")
		a_txtbar:SetPlaceholderText( aR:T("W_n_here") )
		a_txtbar:SetText("Team ".. LocalPlayer():Nick())
		a_txtbar:SetTextColor( Color( 70, 90, 0, 255 ) )
		a_txtbar.OnEnter = function()
			if a_txtbar:GetValue() == "" then return end
			if IsValid(aButton_1_1.E_FrameA) then aButton_1_1.E_FrameA:Remove() end
			aSetTabPly("Create_TeamDance",{a_txtbar:GetValue(),aButton_1_1.E_FrameA.aLock})
		end
		local ab_1_2 = vgui.Create("DButton",aButton_1_1.E_FrameA)
		ab_1_2:SetSize(100, 30)
		ab_1_2:SetPos(aButton_1_1.E_FrameA:GetWide()-ab_1_2:GetWide()-20, aButton_1_1.E_FrameA:GetTall()/2+20)
		ab_1_2:SetText("")
		ab_1_2.Paint = function(ss, w, h)
			if a_txtbar:GetValue() == "" then
				draw.RoundedBox( 5, 0, 0, w, h, ss:IsHovered() and Color( 255, 100, 100, 255 ) or Color( 150, 100, 70, 255 ) )
			else
				draw.RoundedBox( 5, 0, 0, w, h, ss:IsHovered() and Color( 100, 255, 200, 255 ) or Color( 100, 150, 100, 255 ) )
			end
			draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 100, 100, 100, 255 ) )
			draw.SimpleText(aR:T("LReplace_txt_ok"), "ActMod_a1", w/2, h/2, Color(255, 255, 255, 255), 1, 1)
		end
		ab_1_2.DoClick = function ( s )
			if a_txtbar:GetValue() == "" then return end
			surface.PlaySound("actmod/i_menu/menu_accept.mp3")
			if IsValid(aButton_1_1.E_FrameA) then aButton_1_1.E_FrameA:Remove() end
			aSetTabPly("Create_TeamDance",{a_txtbar:GetValue(),aButton_1_1.E_FrameA.aLock})
		end
		local aL_1_2 = vgui.Create("DButton",aButton_1_1.E_FrameA)
		aL_1_2:SetPos(25, aButton_1_1.E_FrameA:GetTall()/2+20)
		aL_1_2:SetText("")
		aL_1_2.txt1 = aR:T("Lock_")
		aL_1_2.txt2 = aR:T("Open_")
		aL_1_2.Ztxt1 = A_AM.ActMod:AZtxt(aL_1_2.txt1, "ActMod_a3")
		aL_1_2.Ztxt2 = A_AM.ActMod:AZtxt(aL_1_2.txt2, "ActMod_a3")
		aL_1_2.Ztxta = A_AM.ActMod:AZtxt(aL_1_2.txt2, "ActMod_a3")
		aL_1_2:SetSize(45+ math.max(aL_1_2.Ztxt2,aL_1_2.Ztxt1), 30)
		aL_1_2.Paint = function(ss, w, h)
			if aButton_1_1.E_FrameA.aLock then
				draw.RoundedBox( 5, 0, 0, w, h, ss:IsHovered() and Color( 150, 150, 120, 255 ) or Color( 100, 100, 50, 255 ) )
			else
				draw.RoundedBox( 5, 0, 0, w, h, ss:IsHovered() and Color( 100, 150, 150, 255 ) or Color( 50, 100, 100, 255 ) )
			end
			draw.RoundedBox( 5, 5, 5, w-10, h-10, Color( 0, 0, 0, 255 ) ) 
			surface.SetDrawColor(Color(255, 255, 255, 255))
			if aButton_1_1.E_FrameA.aLock then
				surface.SetMaterial(Material("icon16/lock.png", "noclamp smooth"))
			else
				surface.SetMaterial(Material("icon16/lock_open.png", "noclamp smooth"))
			end
			surface.DrawTexturedRect(4, 4, h-8, h-8)
			if aButton_1_1.E_FrameA.aLock then
				draw.SimpleText(ss.txt1, "ActMod_a3", h+2, h/2, Color(255, 255, 255, 255), 0, 1)
			else
				draw.SimpleText(ss.txt2, "ActMod_a3", h+2, h/2, Color(255, 255, 255, 255), 0, 1)
			end
		end
		aL_1_2.DoClick = function ( s )
			if aButton_1_1.E_FrameA.aLock then
				surface.PlaySound("actmod/i_menu/menu_buttons_04.mp3")
				aButton_1_1.E_FrameA.aLock = false
			else
				surface.PlaySound("actmod/i_menu/menu_buttons_03.mp3")
				aButton_1_1.E_FrameA.aLock = true
			end
		end
	end
	
	local aButton_1_2 = vgui.Create("DButton", self.Frame)
	aButton_1_2:SetVisible(false)
	aButton_1_2:SetText("")
	aButton_1_2.txt1 = aR:T("A_a_t_invitation")
	aButton_1_2.Ztxt1 = A_AM.ActMod:AZtxt(aButton_1_2.txt1, "ActMod_a3")
	aButton_1_2:SetSize(60+aButton_1_2.Ztxt1, 50)
	aButton_1_2:SetPos(self.Frame:GetWide()-aButton_1_2:GetWide()-25, 80)
	aButton_1_2.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material("actmod/sm_hover.png", "noclamp smooth"))
		surface.DrawTexturedRect(5, 5, h-10, h-10)
		if LocalPlayer().ActMod_TC_TblPly["AllowOk"] then
			surface.SetMaterial(Material("icon16/tick.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(8, 8, h-16, h-16)
		draw.SimpleText(ss.txt1, "ActMod_a3", 52, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	aButton_1_2.DoClick = function(ss, w, h)
		if LocalPlayer().ActMod_TC_TblPly["AllowOk"] then
			surface.PlaySound("actmod/i_menu/menu_buttons_03.mp3")
			aSetTabPly("AllowOk",false)
		else
			surface.PlaySound("actmod/i_menu/menu_buttons_04.mp3")
			aSetTabPly("AllowOk",true)
		end
	end
	
	local aButton_1_3 = vgui.Create("DButton", self.Frame)
	aButton_1_3:SetVisible(false)
	aButton_1_3:SetText("")
	aButton_1_3.txt1 = aR:T("R_list_TD")
	aButton_1_3.Ztxt1 = A_AM.ActMod:AZtxt(aButton_1_3.txt1, "ActMod_a3")
	aButton_1_3:SetSize(35+aButton_1_3.Ztxt1, 30)
	aButton_1_3:SetPos(15, self.Frame:GetTall()-37.5)
	aButton_1_3.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material("icon16/arrow_refresh.png", "noclamp smooth"))
		surface.DrawTexturedRect(2, 2, h-4, h-4)
		draw.SimpleText(ss.txt1, "ActMod_a3", 30, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	aButton_1_3.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_othr_02.mp3")
		aSetTabPly("GetLisGpNow",true)
	end
	
	local aButton_1_4 = vgui.Create("DButton", self.Frame)
	aButton_1_4:SetVisible(false)
	aButton_1_4:SetText("")
	aButton_1_4.txt1 = "invites received"
	aButton_1_4.Ztxt1 = A_AM.ActMod:AZtxt(aButton_1_4.txt1, "ActMod_a3")
	aButton_1_4:SetSize(35+aButton_1_4.Ztxt1, 30)
	aButton_1_4:SetPos(self.Frame:GetWide()-aButton_1_4:GetWide()-15, self.Frame:GetTall()-37.5)
	aButton_1_4.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if ss:IsDown() then
			surface.SetMaterial(Material("icon16/email_open_image.png", "noclamp smooth"))
		elseif ss:IsHovered() then
			surface.SetMaterial(Material("icon16/email_open.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/email.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(3, 3, h-6, h-6)
		draw.SimpleText(ss.txt1, "ActMod_a3", 30, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	aButton_1_4.DoClick = function(ss, w, h)
		aSetTabPly("GetLisPlyNow")
		local aa_1_4 = vgui.Create("DButton")
		aa_1_4:SetSize(ScrW(), ScrH())
		aa_1_4:SetText("")
		aa_1_4:MakePopup()
		aa_1_4:SetCursor( "arrow" )
		aa_1_4:Center()
		aa_1_4:SetAlpha(0)
		aa_1_4.DoClick = function ( s ) if IsValid(aButton_1_4.E_FrameA) then aButton_1_4.E_FrameA:Remove() end end
		aButton_1_4.E_FrameA = vgui.Create("DFrame", self.Frame)
		aButton_1_4.E_FrameA:SetSize(340, 320)
		aButton_1_4.E_FrameA:SetPos(ScrW()/2-170, ScrH()/2-160)
		aButton_1_4.E_FrameA:MakePopup()
		aButton_1_4.E_FrameA:SetTitle("")
		aButton_1_4.E_FrameA:SetDraggable(false)
		aButton_1_4.E_FrameA:ShowCloseButton(false)
		aButton_1_4.E_FrameA.OnRemove = function()
			if IsValid(aa_1_4) then aa_1_4:Remove() end
			if IsValid(self.Frame) then self.Frame.ReceivInv = nil end
		end
		aButton_1_4.E_FrameA.Paint = function(ss, w, h)
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 255, 255, 255 ) )
			draw.RoundedBox( 10, 5, 5, w-10, h-10, Color( 90, 100, 120, 255 ) )
			surface.SetDrawColor(Color(255, 255, 255, 255))
			surface.SetMaterial(Material("icon16/email_open.png", "noclamp smooth"))
			surface.DrawTexturedRect(10, 10, 25, 25)
			draw.SimpleText("Invitations received from:", "ActMod_a1", 38, 20, Color(255, 255, 255, 255), 0, 1)
		end self.Frame.ReceivInv = aButton_1_4.E_FrameA
		
		local framePlys_1_4 = vgui.Create('DPanel',aButton_1_4.E_FrameA)
		framePlys_1_4:SetPos( 10, 40 )
		framePlys_1_4:SetSize(aButton_1_4.E_FrameA:GetWide()-20, aButton_1_4.E_FrameA:GetTall()-50)
		framePlys_1_4.Paint = function(p, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 205, 255, 100 ) )
		end
		local plist = framePlys_1_4:Add('AM4_DScrollPanel')
		plist:Dock(FILL)
		plist.Zall = 32
		plist.NGal = 0
		plist.TimeTh = CurTime() + 0.1
		plist.TTbl = {}
		plist.itry = false
		plist.BaSe = aButton_1_4.E_FrameA
		plist.Think = function()
			if aButton_1_4:IsVisible() and (plist.TimeTh or 0) < CurTime() then
				plist.TimeTh = CurTime() + 0.7
				if LocalPlayer().ActMod_TC_TblPly and LocalPlayer().ActMod_TC_TblPly["GetTabPlysNow"] then
					local GetTabPlysNow = LocalPlayer().ActMod_TC_TblPly["GetTabPlysNow"]
					for k, v in pairs(GetTabPlysNow) do
						if v and IsValid(v["Ply"]) and v["id64"] then
							local id64 = v["id64"]
							if IsValid(plist.TTbl[id64]) then
								if v["GetNameTeam"] then plist.TTbl[id64] = v["GetNameTeam"] end
							else
								plist.TTbl[id64] = aListPly(plist, v,k ,3 )
								plist.NGal = plist.NGal + 1
							end
						end
					end
					if plist.TTbl then
						for Tk, TTv in pairs(plist.TTbl) do
							local a_Add = true
							local Tv = TTv.id64 or false
							if plist.TTbl[Tv] and Tv and IsValid(plist.TTbl[Tv]) then
								for Pk, Pv in pairs(GetTabPlysNow) do
									if Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
										a_Add = false
									end
								end
							end
							if a_Add then
								plist.TTbl[Tv]:Remove()
								plist.TTbl[Tv] = nil
							end
						end
					end
				end
			end
		end
		plist.ReListPlys = function()
			local cTab = istable(LocalPlayer().ActMod_TC_TblPly) and LocalPlayer().ActMod_TC_TblPly["GetTabPlysNow"] or false
			local a_NGal = 0
			for Tk, TTv in pairs(plist.TTbl) do
				local a_Add = true
				local Tv = TTv.id64 or false
				if Tv and cTab then
					for Pk, Pv in pairs(cTab) do
						if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) and Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
							a_Add = false
							a_NGal = a_NGal + 1
						end
					end
				end
				if a_Add then
					if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) then
						plist.TTbl[Tv]:Remove()
						plist.TTbl[Tv] = nil
					end
				end
			end
			plist.itry = false
			plist.NGal = a_NGal
			plist.TimeTh = CurTime()
			if timer.Exists( "aA_TClearList2" ) then timer.UnPause( "aA_TClearList2" ) end
		end
		if timer.Exists( "aA_TClearList2" ) then timer.Remove( "aA_TClearList2" ) end
		timer.Create( "aA_TClearList2",5.5,0,function()
			if IsValid(plist) and plist:IsVisible() and plist.itry == false then
				plist.itry = true
				aSetTabPly("ReInvListPly")
			end
		end)
		plist.OnRemove = function()
			if timer.Exists( "aA_TClearList2" ) then timer.Remove( "aA_TClearList2" ) end
		end
		self.Frame.LisInv = plist
	end
	
	local framePlys_1 = vgui.Create('DPanel',self.Frame)
	framePlys_1:SetVisible(false)
	framePlys_1:SetPos( 10, 180 )
	framePlys_1:SetSize(self.Frame:GetWide()-20, 180)
	framePlys_1.txt1 = aR:T("Nob_c_TD")
	framePlys_1.Paint = function(p, w, h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 80, 150 ) )			
		if IsValid(self.Frame.LisGpTD) and self.Frame.LisGpTD.NGal == 0 then
			draw.SimpleText(p.txt1, "ActMod_a6", w/2, h/2, Color(255, 255, 255, 255), 1, 1)
		end
	end
	local plist = framePlys_1:Add('AM4_DScrollPanel')
	plist:Dock(FILL)
	plist.Zall = 32
	plist.NGal = 0
	plist.TimeTh = CurTime() + 0.2
	plist.TTbl = {}
	plist.itry = false
	plist.Think = function()
		if framePlys_1:IsVisible() and (plist.TimeTh or 0) < CurTime() then
			plist.TimeTh = CurTime() + 0.5
			if LocalPlayer().ActMod_TC_TblPly and LocalPlayer().ActMod_TC_TblPly["GetTabGpsNow"] then
				local GetTabGpsNow = LocalPlayer().ActMod_TC_TblPly["GetTabGpsNow"]
				for k, v in pairs(GetTabGpsNow) do
					if v and IsValid(v["Ply"]) and v["id64"] then
						local id64 = v["id64"]
						if IsValid(plist.TTbl[id64]) then
							plist.TTbl[id64].SysTab["LockTeam"] = (v["LockTeam"] or false)
						else
							plist.TTbl[v["id64"]] = aListPly(plist, v,k ,1 )
							plist.NGal = plist.NGal + 1
						end
					end
				end
				if plist.TTbl then
					for Tk, TTv in pairs(plist.TTbl) do
						local a_Add = true
						local Tv = TTv.id64 or false
						if Tv then
							for Pk, Pv in pairs(GetTabGpsNow) do
								if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) and Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
									a_Add = false
								end
							end
						end
						if a_Add then
							if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) then
								plist.TTbl[Tv]:Remove()
								plist.TTbl[Tv] = nil
							end
						end
					end
				end
			end
		end
	end
	plist.ReListPlys = function(aa)
		local cTab = istable(LocalPlayer().ActMod_TC_TblPly) and LocalPlayer().ActMod_TC_TblPly["GetTabGpsNow"] or false
		local a_NGal = 0
		for Tk, TTv in pairs(plist.TTbl) do
			local a_Add = true
			local Tv = TTv.id64 or false
			if Tv and cTab then
				for Pk, Pv in pairs(cTab) do
					if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) and Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
						a_Add = false
						a_NGal = a_NGal + 1
					end
				end
			end
			if a_Add then
				if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) then
					plist.TTbl[Tv]:Remove()
					plist.TTbl[Tv] = nil
				end
			end
		end
		plist.NGal = a_NGal
		plist.itry = false
		plist.TimeTh = CurTime()
	end
	if timer.Exists( "aA_TClearList5" ) then timer.Remove( "aA_TClearList5" ) end
	timer.Create( "aA_TClearList5",5.5,0,function()
		if IsValid(plist) and framePlys_1:IsVisible() and plist.itry == false then
			plist.itry = true
			aSetTabPly("GetLisGpNow")
		end
	end)
	plist.OnRemove = function()
		if timer.Exists( "aA_TClearList5" ) then timer.Remove( "aA_TClearList5" ) end
	end
	self.Frame.LisGpTD = plist
	
	
	local aButton_2_1 = vgui.Create("DButton", self.Frame)
	aButton_2_1:SetVisible(false)
	aButton_2_1:SetText("")
	aButton_2_1:SetPos(15, 80)
	aButton_2_1:SetSize(50, 50)
	aButton_2_1.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if ss:IsDown() then
			surface.SetMaterial(Material("icon16/cancel.png", "noclamp smooth"))
		elseif ss:IsHovered() then
			surface.SetMaterial(Material("icon16/control_stop_blue.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/control_stop.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(10, 10, h-20, h-20)
	end
	aButton_2_1.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_othr_01.mp3")
		aSetTabPly("StopAct")
	end
	local aButton_2_1_1 = vgui.Create("DButton", self.Frame)
	aButton_2_1_1:SetVisible(false)
	aButton_2_1_1:SetText("")
	aButton_2_1_1:SetPos(15+60, 80)
	aButton_2_1_1:SetSize(50, 50)
	aButton_2_1_1.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if ss:IsDown() then
			surface.SetMaterial(Material("icon16/transmit_go.png", "noclamp smooth"))
		elseif ss:IsHovered() then
			surface.SetMaterial(Material("icon16/transmit.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/transmit_blue.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(10, 10, h-20, h-20)
	end
	aButton_2_1_1.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_buttons_02.mp3")
		aSetTabPly("StratAct","Start")
	end
	
	local aButton_2_2 = vgui.Create("DButton", self.Frame)
	aButton_2_2:SetVisible(false)
	aButton_2_2:SetText("")
	aButton_2_2.txt1 = aR:T("Refresh_")
	aButton_2_2.Ztxt1 = A_AM.ActMod:AZtxt(aButton_2_2.txt1, "ActMod_a3")
	aButton_2_2:SetSize(35+aButton_2_2.Ztxt1, 30)
	aButton_2_2:SetPos(15, self.Frame:GetTall()-37.5)
	aButton_2_2.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material("icon16/arrow_refresh.png", "noclamp smooth"))
		surface.DrawTexturedRect(2, 2, h-4, h-4)
		draw.SimpleText(ss.txt1, "ActMod_a3", 30, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	aButton_2_2.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_othr_02.mp3")
		aSetTabPly("ReYourListPly",true)
	end
	
	local aButton_2_3 = vgui.Create("DButton", self.Frame)
	aButton_2_3:SetVisible(false)
	aButton_2_3:SetText("")
	aButton_2_3.txt1 = aR:T("Sand_a_i_t_a_p")
	aButton_2_3.Ztxt1 = A_AM.ActMod:AZtxt(aButton_2_3.txt1, "ActMod_a3")
	aButton_2_3:SetSize(35+aButton_2_3.Ztxt1, 30)
	aButton_2_3:SetPos(self.Frame:GetWide()-aButton_2_3:GetWide()-15, self.Frame:GetTall()-37.5)
	aButton_2_3.OnRemove = function()
		if IsValid(aButton_2_3.E_FrameA) then aButton_2_3.E_FrameA:Remove() end
		if IsValid(self.Frame) then self.Frame.EtxtTD = nil end
	end
	aButton_2_3.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if ss:IsDown() then
			surface.SetMaterial(Material("icon16/email_edit.png", "noclamp smooth"))
		elseif ss:IsHovered() then
			surface.SetMaterial(Material("icon16/email_add.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/email.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(3, 3, h-6, h-6)
		draw.SimpleText(ss.txt1, "ActMod_a3", 30, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	aButton_2_3.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_buttons_01.mp3")
		aSetTabPly("GetLisPlyNow")
		local aa_2_3 = vgui.Create("DButton")
		aa_2_3:SetSize(ScrW(), ScrH())
		aa_2_3:SetText("")
		aa_2_3:MakePopup()
		aa_2_3:SetCursor( "arrow" )
		aa_2_3:Center()
		aa_2_3:SetAlpha(0)
		aa_2_3.DoClick = function ( s ) if IsValid(aButton_2_3.E_FrameA) then aButton_2_3.E_FrameA:Remove() end end
		aButton_2_3.E_FrameA = vgui.Create("DFrame", self.Frame)
		aButton_2_3.E_FrameA:SetSize(340, 320)
		aButton_2_3.E_FrameA:SetPos(ScrW()/2-140, ScrH()/2-160)
		aButton_2_3.E_FrameA:MakePopup()
		aButton_2_3.E_FrameA:SetTitle("")
		aButton_2_3.E_FrameA:SetDraggable(false)
		aButton_2_3.E_FrameA:ShowCloseButton(false)
		aButton_2_3.E_FrameA.txt1 = aR:T("Sand_a_invitation_t")
		aButton_2_3.E_FrameA.OnRemove = function()
			if IsValid(aa_2_3) then aa_2_3:Remove() end
			if IsValid(self.Frame) then self.Frame.SandInv = nil end
		end
		aButton_2_3.E_FrameA.Paint = function(ss, w, h)
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 255, 255, 255 ) )
			draw.RoundedBox( 10, 5, 5, w-10, h-10, Color( 90, 100, 120, 255 ) )
			surface.SetDrawColor(Color(255, 255, 255, 255))
			surface.SetMaterial(Material("icon16/email_edit.png", "noclamp smooth"))
			surface.DrawTexturedRect(10, 10, 25, 25)
			draw.SimpleText(ss.txt1, "ActMod_a1", 38, 20, Color(255, 255, 255, 255), 0, 1)
		end self.Frame.SandInv = aButton_2_3.E_FrameA
		
		local framePlys_2_3 = vgui.Create('DPanel',aButton_2_3.E_FrameA)
		framePlys_2_3:SetPos( 10, 40 )
		framePlys_2_3:SetSize(aButton_2_3.E_FrameA:GetWide()-20, aButton_2_3.E_FrameA:GetTall()-50)
		framePlys_2_3.Paint = function(p, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 205, 255, 100 ) )
		end
		local plist = framePlys_2_3:Add('AM4_DScrollPanel')
		plist:Dock(FILL)
		plist.Zall = 32
		plist.NGal = 0
		plist.TimeTh = CurTime() + 0.1
		plist.TTbl = {}
		plist.itry = false
		plist.BaSe = aButton_2_3.E_FrameA
		plist.Think = function()
			if aButton_2_3:IsVisible() and (plist.TimeTh or 0) < CurTime() then
				plist.TimeTh = CurTime() + 0.7
				aSetTabPly("GetLisPlyNow")
				if LocalPlayer().ActMod_TC_TblPly and LocalPlayer().ActMod_TC_TblPly["GetTabPlysNow"] then
					local GetTabPlysNow = LocalPlayer().ActMod_TC_TblPly["GetTabPlysNow"]
					for k, v in pairs(GetTabPlysNow) do
						if IsValid(v["Ply"]) and v["id64"] then
							local id64 = v["id64"]
							if IsValid(plist.TTbl[id64]) then
								plist.TTbl[id64].SysTab["AllowOk"] = (v["AllowOk"] or false)
							else
								plist.TTbl[v["id64"]] = aListPly(plist, v,k ,2 )
								plist.NGal = plist.NGal + 1
							end
						end
					end
					if plist.TTbl then
						for Tk, TTv in pairs(plist.TTbl) do
							local a_Add = true
							local Tv = TTv.id64 or false
							if Tv then
								for Pk, Pv in pairs(GetTabPlysNow) do
									if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) and Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
										a_Add = false
									end
								end
							end
							if a_Add then
								if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) then
									plist.TTbl[Tv]:Remove()
									plist.TTbl[Tv] = nil
								end
							end
						end
					end
				end
			end
		end
		plist.ReListPlys = function(aa)
			local cTab = istable(LocalPlayer().ActMod_TC_TblPly) and LocalPlayer().ActMod_TC_TblPly["GetTabPlysNow"] or false
			local a_NGal = 0
			for Tk, TTv in pairs(plist.TTbl) do
				local a_Add = true
				local Tv = TTv.id64 or false
				if Tv and cTab then
					for Pk, Pv in pairs(cTab) do
						if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) and Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
							a_Add = false
							a_NGal = a_NGal + 1
						end
					end
				end
				if a_Add then
					if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) then
						plist.TTbl[Tv]:Remove()
						plist.TTbl[Tv] = nil
					end
				end
			end
			plist.itry = false
			plist.NGal = a_NGal
			if timer.Exists( "aA_TClearList3" ) then timer.UnPause( "aA_TClearList3" ) end
		end
		if timer.Exists( "aA_TClearList3" ) then timer.Remove( "aA_TClearList3" ) end
		timer.Create( "aA_TClearList3",5.5,0,function()
			if IsValid(plist) and aButton_2_3:IsVisible() and plist.itry == false then
				plist.itry = true
				aSetTabPly("ReSandListPly")
			end
		end)
		plist.OnRemove = function()
			if timer.Exists( "aA_TClearList3" ) then timer.Remove( "aA_TClearList3" ) end
		end
		self.Frame.LisSand = plist
		
		if IsValid(self.Frame.WLoad_2_3) then self.Frame.WLoad_2_3:Remove() end
		self.Frame.WLoad_2_3 = vgui.Create("DPanel", aButton_2_3.E_FrameA)
		self.Frame.WLoad_2_3:SetVisible(false)
		self.Frame.WLoad_2_3:SetText("")
		self.Frame.WLoad_2_3.Ing = false
		self.Frame.WLoad_2_3.Png = "none"
		self.Frame.WLoad_2_3.txt1 = "---"
		self.Frame.WLoad_2_3.Ztxt1 = 100
		self.Frame.WLoad_2_3:SetSize(aButton_2_3.E_FrameA:GetWide()-20, aButton_2_3.E_FrameA:GetTall()-50)
		self.Frame.WLoad_2_3:SetPos(10, 40)
		self.Frame.WLoad_2_3.Paint = function(ss, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 80, 100, 200 ) )
			draw.RoundedBox( 0, w/2-ss.Ztxt1/2-10, h/2-65, ss.Ztxt1+20, 90, Color( 5, 255, 20, 100 ) )
			draw.RoundedBox( 0, w/2-ss.Ztxt1/2-5, h/2-60, ss.Ztxt1+10, 80, Color( 10, 20, 100, 150 ) )
			surface.SetDrawColor(Color(255, 255, 255, 155 + (100 * math.sin(CurTime() * 10))))
			surface.SetMaterial(Material("icon16/hourglass.png", "noclamp smooth"))
			surface.DrawTexturedRectRotated(w/2, h/2-35, 22, 30, -CurTime()*200 % 360)
			draw.SimpleText(ss.txt1, "ActMod_a6", w/2, h/2+5, Color(255, 255, 255, math.min(255,255 + (200 * math.sin(CurTime() * 4)))), 1, 1)
		end
		self.Frame.WLoad_2_3.SetWLoad = function(GTyp,txt)
			self.Frame.WLoad_2_3.Png = GTyp
			self.Frame.WLoad_2_3.txt1 = txt
			self.Frame.WLoad_2_3.Ztxt1 = math.max(100,A_AM.ActMod:AZtxt(txt, "ActMod_a6"))
			self.Frame.WLoad_2_3.Ing = true
			self.Frame.WLoad_2_3:SetVisible(true)
		end
		self.Frame.WLoad_2_3.EndWLoad = function()
			self.Frame.WLoad_2_3.Png = "none"
			self.Frame.WLoad_2_3.txt1 = "---"
			self.Frame.WLoad_2_3.Ztxt1 = 100
			self.Frame.WLoad_2_3.Ing = false
			self.Frame.WLoad_2_3:SetVisible(false)
		end
		
		self.Frame.WLoad_2_3.SetWLoad("LoadSutep",aR:T("_Loading"))
		
	end
	
	local aButton_2_4 = vgui.Create("DButton", self.Frame)
	aButton_2_4:SetVisible(false)
	aButton_2_4:SetText("")
	aButton_2_4.txt1 = aR:T("Remove_Y_TD")
	aButton_2_4.Ztxt1 = A_AM.ActMod:AZtxt(aButton_2_4.txt1, "ActMod_a3")
	aButton_2_4:SetSize(60+aButton_2_4.Ztxt1, 50)
	aButton_2_4:SetPos(self.Frame:GetWide()-aButton_2_4:GetWide()-15, 80)
	aButton_2_4.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 240, 140, 70, 120 ) or Color( 150, 130, 100, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 80, 70, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if ss:IsDown() then
			surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
		elseif ss:IsHovered() then
			surface.SetMaterial(Material("icon16/application_form_delete.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/application_form.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(8, 8, h-16, h-16)
		draw.SimpleText(ss.txt1, "ActMod_a3", 52, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	aButton_2_4.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_back.mp3")
		aSetTabPly("Remove_TeamDance","Remove")
	end
	
	local aButton_2_4_1 = vgui.Create("DButton", self.Frame)
	aButton_2_4_1:SetVisible(false)
	aButton_2_4_1:SetText("")
	aButton_2_4_1:SetSize(50, 50)
	aButton_2_4_1:SetPos(self.Frame:GetWide()-aButton_2_4:GetWide()-aButton_2_4_1:GetWide()-20, 80)
	aButton_2_4_1.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
		end
		if LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["LockTeam"] then
			draw.RoundedBox( 5, 0, 0, w, h, Color( 170, 140, 100, 150 ) )
		else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["LockTeam"] then
			surface.SetMaterial(Material("icon16/lock.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/lock_open.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(10, 10, h-20, h-20)
	end
	aButton_2_4_1.DoClick = function(ss, w, h)
		local Tabid64 = LocalPlayer().ActMod_TC_TblPly and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"][1] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["id64"]
		if Tabid64 then
			if LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["LockTeam"] then
				surface.PlaySound("actmod/i_menu/menu_buttons_04.mp3")
				aSetTabPly("ChOptan_Lock",{LocalPlayer(),false,LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["id64"]})
			else
				surface.PlaySound("actmod/i_menu/menu_buttons_03.mp3")
				aSetTabPly("ChOptan_Lock",{LocalPlayer(),true,LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["id64"]})
			end
		end
	end
	
	local aButton_2_4_2 = vgui.Create("DButton", self.Frame)
	aButton_2_4_2:SetVisible(false)
	aButton_2_4_2:SetText("")
	aButton_2_4_2:SetSize(50, 50)
	aButton_2_4_2:SetPos(self.Frame:GetWide()-aButton_2_4:GetWide()-aButton_2_4_1:GetWide()-aButton_2_4_2:GetWide()-40, 80)
	aButton_2_4_2.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
		end
		if LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["Pls_PosOne"] then
			draw.RoundedBox( 5, 0, 0, w, h, Color( 170, 140, 100, 150 ) ) else draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["Pls_PosOne"] then
			surface.SetMaterial(Material("icon16/arrow_in.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/arrow_out.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(10, 10, h-20, h-20)
	end
	aButton_2_4_2.DoClick = function(ss, w, h)
		local Tabid64 = LocalPlayer().ActMod_TC_TblPly and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"][1] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["id64"]
		if Tabid64 then
			if LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["Pls_PosOne"] then
				surface.PlaySound("actmod/i_menu/menu_buttons_04.mp3")
				aSetTabPly("ChOptan_PosOne",{LocalPlayer(),false,LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["id64"]})
			else
				surface.PlaySound("actmod/i_menu/menu_buttons_03.mp3")
				aSetTabPly("ChOptan_PosOne",{LocalPlayer(),true,LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"][1]["id64"]})
			end
		end
	end
	
	local framePlys_2 = vgui.Create('DPanel',self.Frame)
	framePlys_2:SetVisible(false)
	framePlys_2:SetPos( 10, 180 )
	framePlys_2:SetSize(self.Frame:GetWide()-20, 180)
	framePlys_2.Paint = function(p, w, h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 80, 150 ) )
		surface.SetDrawColor(Color(255,255,255,100)) surface.SetMaterial( Material("gui/gradient_down") ) surface.DrawTexturedRect(0, 0, w, h)
	end
	local plist = framePlys_2:Add('AM4_DScrollPanel')
	plist:Dock(FILL)
	plist.Zall = 32
	plist.NGal = 0
	plist.TimeTh = CurTime() + 0.2
	plist.TTbl = {}
	plist.itry = false
	plist.Think = function()
		if framePlys_2:IsVisible() and (plist.TimeTh or 0) < CurTime() then
			plist.TimeTh = CurTime() + 0.5
			if LocalPlayer().ActMod_TC_TblPly and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] then
				local GetTabPlayers = LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]
				if GetTabPlayers["GetPlayers"] then
					local aLock = GetTabPlayers["LockTeam"]
					local aTime = GetTabPlayers["TimeGo"]
					for k, v in pairs(GetTabPlayers["GetPlayers"]) do
						if v["id64"] then
							local id64 = v["id64"]
							if IsValid(plist.TTbl[id64]) then
								if v["NamePly"] then plist.TTbl[id64].SysTab["NamePly"] = v["NamePly"] end
								if v["GetNameTeam"] then plist.TTbl[id64].SysTab["GetNameTeam"] = v["GetNameTeam"] end
								if v["SetOwneTeam"] then plist.TTbl[id64].SysTab["SetOwneTeam"] = v["SetOwneTeam"] end
								plist.TTbl[id64].SysTab["LockTeam"] = (v["LockTeam"] or false)
								plist.TTbl[id64].SysTab["AllowOk"] = (v["AllowOk"] or false)
								if v["Sound"] then plist.TTbl[id64].SysTab["Sound"] = v["Sound"] end
								if v["Effects"] then plist.TTbl[id64].SysTab["Effects"] = v["Effects"] end
								if v["Loop"] then plist.TTbl[id64].SysTab["Loop"] = v["Loop"] end
								if v["NameAct"] then plist.TTbl[id64].SysTab["NameAct"] = v["NameAct"] end
								plist.TTbl[id64].SysTab["LockAct"] = (v["LockAct"] or false)
								plist.TTbl[id64].SysTab["TimeGo"] = aTime
							else
								plist.TTbl[v["id64"]] = aListPly(plist, v,k,nil,{aLock,aTime} )
								plist.NGal = plist.NGal + 1
							end
						end
					end
				end
				if plist.TTbl then
					for Tk, TTv in pairs(plist.TTbl) do
						local a_Add = true
						local Tv = TTv.id64 or false
						if Tv and GetTabPlayers["GetPlayers"] then
							for Pk, Pv in pairs(GetTabPlayers["GetPlayers"]) do
								if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) and Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
									a_Add = false
								end
							end
						end
						if a_Add then
							if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) then
								plist.TTbl[Tv]:Remove()
								plist.TTbl[Tv] = nil
							end
						end
					end
				end
			end
		end
	end
	plist.ReListPlys = function(aa)
		local cTab = istable(LocalPlayer().ActMod_TC_TblPly) and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"] or false
		local a_NGal = 0
		for Tk, TTv in pairs(plist.TTbl) do
			local a_Add = true
			local Tv = TTv.id64 or false
			if Tv and cTab then
				for Pk, Pv in pairs(cTab) do
					if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) and Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
						a_Add = false
						a_NGal = a_NGal + 1
					end
				end
			end
			if a_Add then
				if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) then
					plist.TTbl[Tv]:Remove()
					plist.TTbl[Tv] = nil
				end
			end
		end
		plist.NGal = a_NGal
		plist.itry = false
		plist.TimeTh = CurTime()
		if timer.Exists( "aA_TClearList" ) then timer.UnPause( "aA_TClearList" ) end
	end
	if timer.Exists( "aA_TClearList" ) then timer.Remove( "aA_TClearList" ) end
	timer.Create( "aA_TClearList",5.5,0,function()
		if IsValid(plist) and framePlys_2:IsVisible() and plist.itry == false then
			plist.itry = true
			aSetTabPly("ReYourListPly")
		end
	end)
	plist.OnRemove = function()
		if timer.Exists( "aA_TClearList" ) then timer.Remove( "aA_TClearList" ) end
	end
	self.Frame.rePL = plist
	
	local aButton_3_1 = vgui.Create("DButton", self.Frame)
	aButton_3_1:SetVisible(false)
	aButton_3_1:SetText("")
	aButton_3_1:SetPos(15, 80)
	aButton_3_1.txt1 = aR:T("Refresh_")
	aButton_3_1.Ztxt1 = A_AM.ActMod:AZtxt(aButton_3_1.txt1, "ActMod_a3")
	aButton_3_1:SetSize(60+aButton_3_1.Ztxt1, 50)
	aButton_3_1.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material("icon16/arrow_refresh.png", "noclamp smooth"))
		surface.DrawTexturedRect(8, 8, h-16, h-16)
		draw.SimpleText(ss.txt1, "ActMod_a3", 52, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	aButton_3_1.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_othr_02.mp3")
		aSetTabPly("ReYourListPly",true)
	end
	
	local aButton_3_2 = vgui.Create("DButton", self.Frame)
	aButton_3_2:SetVisible(false)
	aButton_3_2:SetText("")
	aButton_3_2:SetPos(self.Frame:GetWide()/2-40, 75)
	aButton_3_2:SetSize(60, 60)
	aButton_3_2.TimeTh = CurTime() + 0.6
	aButton_3_2.ActNameAct = LocalPlayer().ActMod_TC_TblPly["NameAct"]
	aButton_3_2.Think = function(ss)
		aButton_3_2.ActNameAct = LocalPlayer().ActMod_TC_TblPly["NameAct"]
		if ss:IsVisible() and (ss.TimeTh or 0) < CurTime() then
			ss.TimeTh = CurTime() + 0.4
			local noactnam = true
			if LocalPlayer().ActMod_TC_TblPly and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] then
				local GetTabPlayers = LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]
				if GetTabPlayers["GetPlayers"] then
					for k, v in pairs(GetTabPlayers["GetPlayers"]) do
						if v["id64"] == LocalPlayer():SteamID64() then
							aButton_3_2.ActNameAct = v["NameAct"]
							LocalPlayer().ActMod_TC_TblPly["NameAct"] = v["NameAct"]
							noactnam = false
							break
						end
					end
				end
			end
			if noactnam then
				aButton_3_2.ActNameAct = LocalPlayer().ActMod_TC_TblPly["NameAct"]
			end
		end
	end
	aButton_3_2.Material = Material(A_AM.ActMod:RIPng(aButton_3_2.ActNameAct), "noclamp smooth")
	aButton_3_2.TimMat = CurTime() + 1
	aButton_3_2.Paint = function(ss, w, h)
		local ActNameAct = ss.ActNameAct
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 2, 4, 4, w-8, h-8, ss:IsDown() and Color( 100, 210, 200, 120 ) or Color( 100, 130, 150, 200 ) )
			else
			draw.RoundedBox( 2, 4, 4, w-8, h-8, Color( 50, 50, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material("actmod/sm_hover.png", "noclamp smooth"))
		surface.DrawTexturedRect(0, 0, h, h)
		if ActNameAct ~= "" then
			if (ss.TimMat or 0) < CurTime() then ss.TimMat = CurTime() + 0.3 ss.Material = Material(A_AM.ActMod:RIPng(ActNameAct), "noclamp smooth") end
			surface.SetMaterial(ss.Material)
		else
			surface.SetMaterial(Material("icon16/cross.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(2, 2, h-4, h-4)
		if ss:IsHovered() and ActNameAct != "" then
			if IsValid(ss.sgg) then
				ss.sgg:SetPos(gui.MouseX() + 5, gui.MouseY() - (ss.sgg:GetTall() - 10))
			else
				ss.sgg = vgui.Create("DLabel")
				ss.sgg:SetSize(180, 180)
				ss.sgg:SetDrawOnTop(true)
				ss.sgg:SetPos(gui.MouseX(), gui.MouseY() - (ss.sgg:GetTall() - 10))
				ss.sgg:SetText("")
				ss.sgg.TimMat = CurTime() + 1
				ss.sgg.Material = Material(A_AM.ActMod:RIPng(ActNameAct), "noclamp smooth")
				ss.sgg.Paint = function(ss, w, h)
					if (ss.TimMat or 0) < CurTime() then ss.TimMat = CurTime() + 0.3 ss.Material = Material(A_AM.ActMod:RIPng(ActNameAct), "noclamp smooth") end
					draw.RoundedBox(25, 0, 0, w, h, Color(70, 60, 50, 180))
					surface.SetDrawColor(Color(255, 255, 255, 255))
					surface.SetMaterial(ss.Material)
					surface.DrawTexturedRect(0, 0, h, h)
				end
			end
		else
			if IsValid(ss.sgg) then
				ss.sgg:Remove()
			end
		end
	end
	aButton_3_2.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_buttons_01.mp3")
		A_AM.ActMod.Actoji:Replace(1002,nil,function(Gname)
			aSetTabPly("NameAct_TPly",{LocalPlayer(),Gname,LocalPlayer().ActMod_TC_TblPly["id64Team"]})
		end)
	end
	
	local aButton_3_3 = vgui.Create("DButton", self.Frame)
	aButton_3_3:SetVisible(false)
	aButton_3_3:SetText("")
	aButton_3_3.txt1 = aR:T("leave_the_team")
	aButton_3_3.Ztxt1 = A_AM.ActMod:AZtxt(aButton_3_3.txt1, "ActMod_a3")
	aButton_3_3:SetSize(60+aButton_3_3.Ztxt1, 50)
	aButton_3_3:SetPos(self.Frame:GetWide()-aButton_3_3:GetWide()-15, 80)
	aButton_3_3.Paint = function(ss, w, h)
		if ss:IsHovered() then
			surface.SetDrawColor(Color(155 + (100 * math.sin(CurTime() * 4)), 255, 255, 255 + (200 * math.sin(CurTime() * 4))))
			surface.DrawOutlinedRect(0, 0, w, h, 3 + (1 * math.sin(CurTime() * 4)))
			draw.RoundedBox( 5, 0, 0, w, h, ss:IsDown() and Color( 240, 140, 70, 120 ) or Color( 150, 130, 100, 200 ) )
			else
			draw.RoundedBox( 5, 0, 0, w, h, Color( 80, 70, 50, 150 ) )
		end
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if ss:IsDown() then
			surface.SetMaterial(Material("icon16/door_out.png", "noclamp smooth"))
		elseif ss:IsHovered() then
			surface.SetMaterial(Material("icon16/door_open.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/door.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(8, 8, h-16, h-16)
		draw.SimpleText(ss.txt1, "ActMod_a3", 52, h/2, Color(255, 255, 255, 255), 0, 1)
	end
	aButton_3_3.DoClick = function(ss, w, h)
		surface.PlaySound("actmod/i_menu/menu_back.mp3")
		aSetTabPly("Kick_TPly",{LocalPlayer(),LocalPlayer().ActMod_TC_TblPly["id64Team"]})
	end
	local framePlys_3 = vgui.Create('DPanel',self.Frame)
	framePlys_3:SetVisible(false)
	framePlys_3:SetPos( 10, 180 )
	framePlys_3:SetSize(self.Frame:GetWide()-20, 210)
	framePlys_3.Paint = function(p, w, h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 100, 150 ) )
	end
	local plist = framePlys_3:Add('AM4_DScrollPanel')
	plist:Dock(FILL)
	plist.Zall = 32
	plist.NGal = 0
	plist.TimeTh = CurTime() + 0.1
	plist.TTbl = {}
	plist.itry = false
	plist.Think = function()
		if framePlys_3:IsVisible() and (plist.TimeTh or 0) < CurTime() then
			plist.TimeTh = CurTime() + 0.3
			if LocalPlayer().ActMod_TC_TblPly and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] then
				local GetTabPlayers = LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]
				if GetTabPlayers["GetPlayers"] then
					local aLock = GetTabPlayers["LockTeam"]
					local aTime = GetTabPlayers["TimeGo"]
					for k, v in pairs(GetTabPlayers["GetPlayers"]) do
						if v["id64"] then
							local id64 = v["id64"]
							if IsValid(plist.TTbl[id64]) then
								if v["NamePly"] then plist.TTbl[id64].SysTab["NamePly"] = v["NamePly"] end
								if v["GetNameTeam"] then plist.TTbl[id64].SysTab["GetNameTeam"] = v["GetNameTeam"] end
								if v["SetOwneTeam"] then plist.TTbl[id64].SysTab["SetOwneTeam"] = v["SetOwneTeam"] end
								plist.TTbl[id64].SysTab["LockTeam"] = (v["LockTeam"] or false)
								plist.TTbl[id64].SysTab["AllowOk"] = (v["AllowOk"] or false)
								if v["Sound"] then plist.TTbl[id64].SysTab["Sound"] = v["Sound"] end
								if v["Effects"] then plist.TTbl[id64].SysTab["Effects"] = v["Effects"] end
								if v["Loop"] then plist.TTbl[id64].SysTab["Loop"] = v["Loop"] end
								if v["NameAct"] then plist.TTbl[id64].SysTab["NameAct"] = v["NameAct"] end
								plist.TTbl[id64].SysTab["LockAct"] = (v["LockAct"] or false)
								plist.TTbl[id64].SysTab["TimeGo"] = aTime
							else
								plist.TTbl[v["id64"]] = aListPly(plist, v,k,nil,{aLock,aTime} )
								plist.NGal = plist.NGal + 1
							end
						end
					end
				end
				if plist.TTbl then
					for Tk, TTv in pairs(plist.TTbl) do
						local a_Add = true
						local Tv = TTv.id64 or false
						if Tv and GetTabPlayers["GetPlayers"] then
							for Pk, Pv in pairs(GetTabPlayers["GetPlayers"]) do
								if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) and Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
									a_Add = false
								end
							end
						end
						if a_Add then
							if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) then
								plist.TTbl[Tv]:Remove()
								plist.TTbl[Tv] = nil
							end
						end
					end
				end
			end
		end
	end
	plist.ReListPlys = function(aa)
		local cTab = istable(LocalPlayer().ActMod_TC_TblPly) and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"] and LocalPlayer().ActMod_TC_TblPly["GetTabPlayers"]["GetPlayers"] or false
		local a_NGal = 0
		for Tk, TTv in pairs(plist.TTbl) do
			local a_Add = true
			local Tv = TTv.id64 or false
			if Tv and cTab then
				for Pk, Pv in pairs(cTab) do
					if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) and Pv["id64"] and plist.TTbl[Tv].id64 and plist.TTbl[Tv].id64 == Pv["id64"] then
						a_Add = false
						a_NGal = a_NGal + 1
					end
				end
			end
			if a_Add then
				if plist.TTbl[Tv] and IsValid(plist.TTbl[Tv]) then
					plist.TTbl[Tv]:Remove()
					plist.TTbl[Tv] = nil
				end
			end
		end
		plist.NGal = a_NGal
		plist.itry = false
		plist.TimeTh = CurTime()
		if timer.Exists( "aA_TClearList4" ) then timer.UnPause( "aA_TClearList4" ) end
	end
	if timer.Exists( "aA_TClearList4" ) then timer.Remove( "aA_TClearList4" ) end
	timer.Create( "aA_TClearList4",1.5,0,function()
		if IsValid(plist) and framePlys_3:IsVisible() and plist.itry == false then
			plist.itry = true
			aSetTabPly("ReInListPly")
		end
	end)
	plist.OnRemove = function()
		if timer.Exists( "aA_TClearList4" ) then timer.Remove( "aA_TClearList4" ) end
	end
	self.Frame.reIn = plist
	
	
	local function alk(a1,a2,a3,a4,a5)
		if a1 and IsValid(self.Frame.LisGpTD) then self.Frame.LisGpTD.ReListPlys() end
		if a3 and IsValid(self.Frame.LisInv) then self.Frame.LisInv.ReListPlys() end
		if a4 and IsValid(self.Frame.rePL) then self.Frame.rePL.ReListPlys() end
		if a5 and IsValid(self.Frame.reIn) then self.Frame.reIn.ReListPlys() end
	end
	self.Frame.aSetMenu = function( typ )
		if typ == "List_main" then
			self.Frame.TYP = 1
			aButton_1_1:SetVisible(true)
			aButton_1_2:SetVisible(true)
			aButton_1_3:SetVisible(true)
			framePlys_1:SetVisible(true)
			aButton_2_1:SetVisible(false)
			aButton_2_1_1:SetVisible(false)
			aButton_2_2:SetVisible(false)
			aButton_2_3:SetVisible(false)
			aButton_2_4:SetVisible(false)
			aButton_2_4_1:SetVisible(false)
			aButton_2_4_2:SetVisible(false)
			framePlys_2:SetVisible(false)
			aButton_3_1:SetVisible(false)
			aButton_3_2:SetVisible(false)
			aButton_3_3:SetVisible(false)
			framePlys_3:SetVisible(false)
			if IsValid(self.Frame.SandInv) then self.Frame.SandInv:Remove() self.Frame.SandInv = nil end
			alk(nil,true,nil,true)
		elseif typ == "List_YHaveTDance" then
			self.Frame.TYP = 2
			aButton_1_1:SetVisible(false)
			aButton_1_2:SetVisible(false)
			aButton_1_3:SetVisible(false)
			aButton_1_4:SetVisible(false)
			framePlys_1:SetVisible(false)
			aButton_2_1:SetVisible(true)
			aButton_2_1_1:SetVisible(true)
			aButton_2_2:SetVisible(true)
			aButton_2_3:SetVisible(true)
			aButton_2_4:SetVisible(true)
			aButton_2_4_1:SetVisible(true)
			aButton_2_4_2:SetVisible(true)
			framePlys_2:SetVisible(true)
			aButton_3_1:SetVisible(false)
			aButton_3_2:SetVisible(false)
			aButton_3_3:SetVisible(false)
			framePlys_3:SetVisible(false)
			if IsValid(self.Frame.ReceivInv) then self.Frame.ReceivInv:Remove() self.Frame.ReceivInv = nil end
			alk(true,nil,true,nil)
		elseif typ == "List_YouInTDance" then
			self.Frame.TYP = 3
			aButton_1_1:SetVisible(false)
			aButton_1_2:SetVisible(false)
			aButton_1_3:SetVisible(false)
			aButton_1_4:SetVisible(false)
			framePlys_1:SetVisible(false)
			aButton_2_1:SetVisible(false)
			aButton_2_1_1:SetVisible(false)
			aButton_2_2:SetVisible(false)
			aButton_2_3:SetVisible(false)
			aButton_2_4:SetVisible(false)
			aButton_2_4_1:SetVisible(false)
			aButton_2_4_2:SetVisible(false)
			framePlys_2:SetVisible(false)
			aButton_3_1:SetVisible(true)
			aButton_3_2:SetVisible(true)
			aButton_3_3:SetVisible(true)
			framePlys_3:SetVisible(true)
			if IsValid(self.Frame.ReceivInv) then self.Frame.ReceivInv:Remove() self.Frame.ReceivInv = nil end
			if IsValid(self.Frame.SandInv) then self.Frame.SandInv:Remove() self.Frame.SandInv = nil end
			alk(true,true,true,true)
		else
			self.Frame.TYP = 0
			aButton_1_1:SetVisible(false)
			aButton_1_2:SetVisible(false)
			aButton_1_3:SetVisible(false)
			aButton_1_4:SetVisible(false)
			framePlys_1:SetVisible(false)
			aButton_2_1:SetVisible(false)
			aButton_2_1_1:SetVisible(false)
			aButton_2_2:SetVisible(false)
			aButton_2_3:SetVisible(false)
			aButton_2_4:SetVisible(false)
			aButton_2_4_1:SetVisible(false)
			aButton_2_4_2:SetVisible(false)
			framePlys_2:SetVisible(false)
			aButton_3_1:SetVisible(false)
			aButton_3_2:SetVisible(false)
			aButton_3_3:SetVisible(false)
			framePlys_3:SetVisible(false)
			if IsValid(self.Frame.ReceivInv) then self.Frame.ReceivInv:Remove() self.Frame.ReceivInv = nil end
			if IsValid(self.Frame.SandInv) then self.Frame.SandInv:Remove() self.Frame.SandInv = nil end
		end
	end
	
	
	local function aGa0(w,h,png)
		surface.SetDrawColor(Color(255, 255, 255, 155 + (100 * math.sin(CurTime() * 10))))
		surface.SetMaterial(Material(png, "noclamp smooth"))
		surface.DrawTexturedRectRotated(w, h, 22, 30, -CurTime()*200 % 360)
	end
	local function aGa1(w,h,typ)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		if typ == "LoadSutep" then
			surface.SetMaterial(Material("icon16/application_form_add.png", "noclamp smooth"))
		elseif typ == "Create_TeamDance" then
			surface.SetMaterial(Material("icon16/application_form_edit.png", "noclamp smooth"))
		elseif typ == "Remove_TeamDance" then
			surface.SetMaterial(Material("icon16/application_form_delete.png", "noclamp smooth"))
		elseif typ == "StartYourTeamDance" then
			surface.SetMaterial(Material("icon16/cog_go.png", "noclamp smooth"))
		else
			surface.SetMaterial(Material("icon16/application_form.png", "noclamp smooth"))
		end
		surface.DrawTexturedRect(w,h, 40, 40)
	end

	self.Frame.WLoad_1 = vgui.Create("DPanel", self.Frame)
	self.Frame.WLoad_1:SetVisible(false)
	self.Frame.WLoad_1:SetText("")
	self.Frame.WLoad_1.Ing = false
	self.Frame.WLoad_1.Png = "none"
	self.Frame.WLoad_1.txt1 = "---"
	self.Frame.WLoad_1.Ztxt1 = 100
	self.Frame.WLoad_1:SetSize(self.Frame:GetWide()-10, self.Frame:GetTall()-75)
	self.Frame.WLoad_1:SetPos(5, 70)
	self.Frame.WLoad_1.Paint = function(ss, w, h)
		draw.RoundedBox( 5, 0, 0, w, h, Color( 50, 80, 100, 200 ) )
		draw.RoundedBox( 5, w/2-ss.Ztxt1/2-10, h/2-65, ss.Ztxt1+20, 90, Color( 5, 255, 20, 100 ) )
		draw.RoundedBox( 5, w/2-ss.Ztxt1/2-5, h/2-60, ss.Ztxt1+10, 80, Color( 10, 20, 100, 150 ) )
		
		if ss.Png == "LoadSutep" or ss.Png == "Set_ChAct" or ss.Png == "Set_ChOptn" then
			aGa0(w/2, h/2-35,"icon16/hourglass.png")
		else
			aGa0(w/2+25, h/2-30,"icon16/hourglass.png")
			aGa1(w/2-45, h/2-50,ss.Png)
		end
		draw.SimpleText(ss.txt1, "ActMod_a6", w/2, h/2+5, Color(255, 255, 255, math.min(255,255 + (200 * math.sin(CurTime() * 4)))), 1, 1)
	end
	self.Frame.WLoad_1.SetWLoad = function(GTyp,txt)
		self.Frame.WLoad_1.Png = GTyp
		self.Frame.WLoad_1.txt1 = txt
		self.Frame.WLoad_1.Ztxt1 = math.max(100,A_AM.ActMod:AZtxt(txt, "ActMod_a6"))
		self.Frame.WLoad_1.Ing = true
		self.Frame.WLoad_1:SetVisible(true)
	end
	self.Frame.WLoad_1.EndWLoad = function()
		self.Frame.WLoad_1.Png = "none"
		self.Frame.WLoad_1.txt1 = "---"
		self.Frame.WLoad_1.Ztxt1 = 100
		self.Frame.WLoad_1.Ing = false
		self.Frame.WLoad_1:SetVisible(false)
	end
	
	self.Frame.WLoad_1.SetWLoad("LoadSutep",aR:T("_Loading"))
	net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"LTD.ClToSv","LoadSutep",LocalPlayer().ActMod_TC_TblPly} ) net.SendToServer()
	
end

function A_AM.ActMod.ActGrpP:OMenu(Ply)
	A_AM.ActMod.Actoji:Close()
	ActGrpP:Open()
end

A_AM.ActMod.LuaLTD_Menu_Done = true
