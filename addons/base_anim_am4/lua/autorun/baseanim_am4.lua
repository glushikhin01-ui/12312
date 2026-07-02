

AM4 = AM4 or {}
AM4.AniExte = AM4.AniExte or {}
AM4.AniExte.Mounted = AM4.AniExte.Mounted or {}
AM4.AniExte.Mounted[ "Base AM4" ] = true
AM4.AniExte.Mounted[ "Version" ] = "2.3"


if CLIENT then
	AM4 = AM4 or {}
	AM4.AM4ani = AM4.AM4ani or {}
	local AM4ani = AM4.AM4ani
	
	local function A_ToMinutesSecondsCD(seconds)
		seconds = math.ceil(seconds)
		local minutes = math.floor(seconds / 60)
		seconds = seconds - minutes * 60

		return string.format("%02d:%02d", minutes, seconds)
	end
	local function GfindLongestAnimationIn(sequenceInfo, puppeteer)
		local longestAnim = { numframes = -1 }
		for _, anim in pairs(sequenceInfo.anims) do
			local animInfo = puppeteer:GetAnimInfo(anim)
			if not (animInfo and animInfo.numframes) then continue end
			if animInfo.numframes > longestAnim.numframes then longestAnim = animInfo end
		end
		return longestAnim
	end

	list.Add( "DesktopWindows", {icon = "baseani_am4/icoam4.png",title = "View Anim",init = function() AM4:OpenMenuAni() end})
	concommand.Add( "am4_manim", function( ply, cmd, args, str ) AM4:OpenMenuAni() end )

	if AM4ani.AniFrame and IsValid(AM4ani.AniFrame) then AM4ani.AniFrame:Remove() end

	AM4ani.Close = function (self, reset)
		if !IsValid(self.AniFrame) then return end
		self.AniFrame:AlphaTo(0,0.1,0, function(t, s) if AM4ani.AniFrame then AM4ani.AniFrame:Remove() AM4ani.AniFrame = nil gui.EnableScreenClicker( false ) end if reset then self:Open() end end)
	end

	local w, h = ScrW(), ScrH()
	local Zw_1,Zw_2,Zw_3 = w*0.58,w*0.75,w*0.99
	local Zh_1,Zh_2,Zh_3 = h*0.5,h*0.7,h*0.80

	local zise = 2
	local aniactse = nil
	local showactinf = false
	local trumovi = false
	AM4ani.Open = function(self)

		w, h = ScrW(), ScrH()
		Zw_1,Zw_2,Zw_3 = w*0.58,w*0.75,w*0.99
		Zh_1,Zh_2,Zh_3 = h*0.5,h*0.7,h*0.80
		AM4:ReZFont(zise)

		if IsValid(self.AniFrame) then self.AniFrame:Remove() end
		
		self.AniFrame = vgui.Create("DButton")
		self.AniFrame:SetSize(w, h)
		self.AniFrame:SetText("")
		self.AniFrame:SetCursor("arrow")
		self.AniFrame:Center()
		self.AniFrame:SetAlpha(0)
		self.AniFrame.DoClick = function(s)
			AM4:OpenMenuAni()
		end
		
		gui.EnableScreenClicker( true )
		
		self.MenuAni = vgui.Create( "DFrame", self.AniFrame )
		
		if zise == 1 then self.MenuAni:SetSize( Zw_1, Zh_1 )
		elseif zise == 2 then self.MenuAni:SetSize( Zw_2, Zh_2 )
		elseif zise == 3 then self.MenuAni:SetSize( Zw_3, Zh_3 ) end
		self.MenuAni:Center()
		self.MenuAni.Display = LocalPlayer():GetModel()
		self.MenuAni:MakePopup()
		self.MenuAni:SetTitle( "" )
		self.MenuAni:ShowCloseButton( false )
		self.MenuAni:SetDraggable( false )
		
		local fw, fh = self.MenuAni:GetSize()
		local padx = fh*0.025
		local pady = padx
		
		local bshw = false
		local ssped_r = 1
		local modelmenu = vgui.Create( "DAdjustableModelPanel", self.MenuAni )
		modelmenu:SetPos( padx, pady )
		modelmenu:SetSize( fw/2 - padx - padx/2, fh*0.95 - 2*pady )
		modelmenu.LayoutEntity = function()
			local ent = modelmenu:GetEntity()
			ent:SetEyeTarget( modelmenu:GetCamPos() )
			ent:FrameAdvance( FrameTime() )
		end
		modelmenu.aGetCycle = 0
		modelmenu.GetNSeq = ""
		modelmenu.Set_fps = 30
		
		function modelmenu:SChangeAnim( Ani )
			local ent = modelmenu:GetEntity()
			ent:ResetSequence( Ani ) ent:SetCycle( 0 ) ent:SetPlaybackRate( ssped_r )
			modelmenu.GetNSeq = Ani
			
			local defaultFPS,Default_MAX_Frame = 30,60
			local seqInfo = ent:GetSequenceInfo(ent:GetSequence())
			local animInfo = GfindLongestAnimationIn(seqInfo, ent)
			local fps,maxFrame = 30,60
			if animInfo.numframes > -1 then
				fps = animInfo.fps
				maxFrame = animInfo.numframes
			end
			if animInfo then
				if animInfo.fps then modelmenu.Set_fps = animInfo.fps end
			end
			
		end
		
		self.MenuAni.Paint = function( pan, ww, hh )
			if not vgui.CursorVisible() then gui.EnableScreenClicker( true ) end
			draw.RoundedBox( 20, 0, 0, ww, hh, Color( 15, 45, 65, 255 ) )

			if bshw then
			surface.SetDrawColor( Color( 250, 155, 0, 255 ) )
			draw.RoundedBox( 0, padx, pady, modelmenu:GetWide(), modelmenu:GetTall(), Color( 0, 255, 0, 255 ) )
			else
			draw.RoundedBox( 0, padx, pady, modelmenu:GetWide(), modelmenu:GetTall(), Color( 80, 80, 80, 255 ) )
			draw.SimpleText( "Viewer Animation Player :", "AM4_Font", pady+ww/70, padx+15, Color( 200, 255, 255, 150+(100*math.sin(CurTime()*4)) ) )
			surface.SetDrawColor( Color( 0, 255, 255, 255 ) )
			surface.DrawOutlinedRect( padx, pady, modelmenu:GetWide(), modelmenu:GetTall() )
			surface.SetDrawColor( Color( 0, 200, 255, 255 ) )
			surface.DrawOutlinedRect( padx+2, pady+2, modelmenu:GetWide()-4, modelmenu:GetTall()-4 )
			surface.SetDrawColor( Color( 0, 150, 255, 255 ) )
			surface.DrawOutlinedRect( padx+4, pady+4, modelmenu:GetWide()-8, modelmenu:GetTall()-8 )
			end
			
		end 

	------------------------------
	--------Search Text-----------

	local t_w,t_h = fw*0.495 + padx, pady

		local searchbar = vgui.Create( "DTextEntry", self.MenuAni )

		searchbar:SetSize( fw*0.15 * 1.5, fh*0.05 * 0.8 )
		searchbar:SetPos( t_w,t_h )
		searchbar:SetFont("AM4_DescFont")
		searchbar:SetText( "" )

		
	--------Search Text-----------
	------------------------------

		
	------------------------------
	------------Lister------------

		local lister = vgui.Create( "DListView", self.MenuAni )
		lister:SetPos( fw/2 + padx/2, fh*0.20 - pady*2 - searchbar:GetTall() )
		lister:SetSize( fw/2 - padx - padx/2, fh*0.70 - pady)
		lister:AddColumn( "Name" )
		lister:SetMultiSelect( false )
		lister:SetHideHeaders( true )
		lister.Pages = {}
		lister.CurrentPage = 1
		lister.GeAniS = false
		
		local BLister = vgui.Create( "DLabel", self.MenuAni )
		BLister:SetPos( fw/2.04 + padx/2 , fh*0.185 - pady*2 - searchbar:GetTall() )
		BLister:SetSize( lister:GetSize()*1.035, lister:GetTall()*1.045)
		BLister:SetText( "" )
		BLister.Paint = function( pan, ww, hh )
			if not vgui.CursorVisible() then gui.EnableScreenClicker( true ) end
			surface.SetDrawColor( Color( 0, 255, 255, 255 ) )
			surface.DrawOutlinedRect( 0, 0, BLister:GetWide(), BLister:GetTall() )
			surface.SetDrawColor( Color( 0, 200, 255, 255 ) )
			surface.DrawOutlinedRect( 2, 2, BLister:GetWide()-4, BLister:GetTall()-4 )
			surface.SetDrawColor( Color( 0, 150, 255, 255 ) )
			surface.DrawOutlinedRect( 4, 4, BLister:GetWide()-8, BLister:GetTall()-8 )
		end 
		
		function lister:Think()
			local ply = LocalPlayer()
			if ply:GetObserverMode() == 4 or ply:GetObserverMode() == 5 or ply:GetObserverMode() == 6 then
			else
				if AM4ani.MenuAni.Display != modelmenu:GetModel() then
					modelmenu:RebuildModel()
				end
			end
			
			if IsValid(modelmenu.AnimTrack) then
			local ent = modelmenu:GetEntity()
				if ( modelmenu.AnimTrack:GetDragging() ) then
					ent:SetCycle( modelmenu.AnimTrack:GetSlideX() )
					modelmenu.aGetCycle = modelmenu.AnimTrack:GetSlideX()

				elseif ( ent:GetCycle() != modelmenu.AnimTrack:GetSlideX() ) then
					local cyc = ent:GetCycle()
					if ( cyc < 0 ) then cyc = cyc + 1 end
					modelmenu.AnimTrack:SetSlideX( cyc )
					modelmenu.aGetCycle = cyc

				end
			end
		end


		function lister:RebuildCache( ent )
			lister:Clear()
			lister.BasePages = {}
			lister.Pages = {}
			lister.CurrentPage = 1
			local max = 500
			local count = 0
			local curpage = 1
			for k, v in SortedPairsByValue( ent:GetSequenceList() ) do
				if not lister.BasePages[ curpage ] then lister.BasePages[ curpage ] = {} end
				if count < max then
					table.insert( lister.BasePages[ curpage ], v )
					if curpage == 1 then
						local line = lister:AddLine( v )
						line.OnSelect = function() aniactse = v
							modelmenu:SChangeAnim( aniactse )
						end
					end
					count = count + 1
				else
					curpage = curpage + 1
					count = 0
				end
			end

			lister.Pages = lister.BasePages
		end

		function lister:RebuildToLines( ent, lines )
			lister:Clear()
			lister.Pages = {}
			lister.CurrentPage = 1
			local max = 500
			local count = 0
			local curpage = 1
			for k, v in SortedPairsByValue( lines ) do
				if not lister.Pages[ curpage ] then lister.Pages[ curpage ] = {} end
				if count < max then
					table.insert( lister.Pages[ curpage ], v )
					if curpage == 1 then
						local line = lister:AddLine( v )
						line.OnSelect = function() aniactse = v
							modelmenu:SChangeAnim( aniactse )
						end
					end
					count = count + 1
				else
					curpage = curpage + 1
					count = 0
				end
			end
		end


		function lister:ChangePage( page )
			lister:Clear()
			if not page then return end	
			if not lister.Pages[ page ] then return end
			local ent = modelmenu:GetEntity()
			for k, v in pairs( lister.Pages[ page ] ) do
				local line = lister:AddLine( v )
				line.OnSelect = function() aniactse = v
					modelmenu:SChangeAnim( aniactse )
				end
			end

			lister:SelectFirstItem()
		end


		function modelmenu:RebuildModel()
			local ply = LocalPlayer()
			if ply:GetObserverMode() == 4 or ply:GetObserverMode() == 5 or ply:GetObserverMode() == 6 then
				local mdlname = ply:GetInfo( "cl_playermodel" )
				local mdlpath = player_manager.TranslatePlayerModel( mdlname )
				modelmenu:SetModel(tostring(mdlpath)) else modelmenu:SetModel(ply:GetModel())
			end
			local ent = modelmenu:GetEntity()
			local pos = ent:GetPos()
			local campos = pos + Vector( 130, 0, 0 )
			modelmenu:SetCamPos( campos + Vector( 0, 0, 40 ) )
			modelmenu:SetFOV( 45 )
			modelmenu.Entity.GetPlayerColor = function() return Vector( GetConVar( "cl_playercolor" ):GetString() ) end
			ent:SetSkin( ply:GetInfoNum( "cl_playerskin", 0 ) )
			
			local groups = ply:GetInfo( "cl_playerbodygroups" )
			if ( groups == nil ) then groups = "" end
			local groups = string.Explode( " ", groups )
			for k = 0, ent:GetNumBodyGroups() - 1 do
				local v = tonumber( groups[ k + 1 ] ) or 0
				ent:SetBodygroup( k, v )
			end
			modelmenu:SetLookAng( ( campos * -1 ):Angle() )
			if trumovi == false and aniactse == nil and lister.GeAniS == false then lister.GeAniS = true
			timer.Simple(2.4,function() if IsValid(modelmenu) and aniactse == nil then ent:ResetSequence( "gesture_wave_original" ) ent:SetCycle( 0 ) ent:SetPlaybackRate( ssped_r )
			timer.Simple(3.3,function() if IsValid(modelmenu) and aniactse == nil then ent:ResetSequence( "idle_suitcase" ) ent:SetCycle( 0 ) ent:SetPlaybackRate( ssped_r )
			end end) end end)
			end
			lister:RebuildCache( modelmenu:GetEntity() )
            ent:SetLOD(0)
		end
			modelmenu:RebuildModel()
		
			modelmenu.AnimTrack = vgui.Create( "DSlider", self.MenuAni )
			modelmenu.AnimTrack:SetSize( fw*0.98, fh*0.05 )
			modelmenu.AnimTrack:SetPos( 10, fh*0.965 - pady )
			modelmenu.AnimTrack:SetNotches( 100 )
			modelmenu.AnimTrack:SetTrapInside( true )
			modelmenu.AnimTrack:SetLockY( 0.5 )
			modelmenu.AnimTrack.Paint = function( pan, ww, hh )
				draw.RoundedBox( 5, 0, hh/2-5, ww, 5, Color( 0, 255, 255, 150 ) )
			end
			modelmenu.GCNbr = vgui.Create( "DButton", self.MenuAni )
			modelmenu.GCNbr:SetSize( fw*0.24, fh*0.05  )
			modelmenu.GCNbr:SetPos( fw/2, fh*0.905 - pady )
			modelmenu.GCNbr:SetText( "" )
			modelmenu.GCNbr.Paint = function( pan, w, h )
				draw.RoundedBox( 10, 0, 0, w, h, ( pan:IsDown() and Color( 100, 120, 100, 150 ) ) or Color( 50, 60, 60, 150 ) )
				local ent = modelmenu:GetEntity()
				local GetSeq = ent:GetSequenceInfo( ent:GetSequence() ).label
				draw.SimpleText( "[fps=".. modelmenu.Set_fps .."]:Frames: " , "AM4_DescFont", 5, h/2, Color( 210, 255, 255 ), 0,1 )
				draw.SimpleText( tostring( math.floor(( modelmenu.aGetCycle*(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps) )+0.001) ) .." /".. math.Round(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps) , "AM4_DescFont", w-10, h/2, Color( 220, 255, 255 ), 2,1 )
			end
			modelmenu.GCNbr.DoRightClick = function( pan )
				surface.PlaySound("garrysmod/ui_click.wav")
				local ent = modelmenu:GetEntity()
				local GetSeq = ent:GetSequenceInfo( ent:GetSequence() ).label
				SetClipboardText( tostring( math.floor(( modelmenu.aGetCycle*(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps) )+0.001) ) )
			end
			modelmenu.GCNbr.DoClick = function(s)
				s.Cmenu = DermaMenu()
				s.Cmenu:AddOption( "Set Frame", function()
					local ent = modelmenu:GetEntity()
					local GetSeq = ent:GetSequenceInfo( ent:GetSequence() ).label
					local aa1 = math.floor(( modelmenu.aGetCycle*(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps) )+0.001)
					Derma_StringRequest( "Define the frame", 
						"Please write only numbers, otherwise the entry will be invalid\n".. tostring( aa1 ) .." /".. math.Round(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps),
						tostring( aa1 ),
						function(text)
							text = tonumber(text)
							if isnumber(text) and modelmenu and IsValid(modelmenu) then
								local ent = modelmenu:GetEntity()
								local GetSeq = ent:GetSequenceInfo( ent:GetSequence() ).label
								local GetMax = math.Round(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps)
								local GetSLC = math.min(math.max(text,0),GetMax)
								local SetCyc = GetSLC/GetMax  --print("text = ",GetSLC,GetSLC/GetMax)
								ssped_r = 0
								ent:SetPlaybackRate( 0 )
								ent:SetCycle( SetCyc )
								modelmenu.AnimTrack:SetSlideX( SetCyc )
								modelmenu.aGetCycle = SetCyc
							else
								surface.PlaySound("actmod/s/warning.wav")
							end
						end
					)
				end ):SetIcon( "icon16/tab_edit.png" )
				s.Cmenu:AddOption( "Set Frame (by Cycle)", function()
					local ent = modelmenu:GetEntity()
					local aa1 = ent:GetCycle()
					Derma_StringRequest( "Define the frame", 
						"Please write only numbers, otherwise the entry will be invalid\n".. tostring( aa1 ) .." /1",
						tostring( aa1 ),
						function(text)
							text = tonumber(text)
							if isnumber(text) and modelmenu and IsValid(modelmenu) then
								local ent = modelmenu:GetEntity()
								local SetCyc = math.Clamp(text,0,1)
								ssped_r = 0
								ent:SetPlaybackRate( 0 )
								ent:SetCycle( SetCyc )
								modelmenu.AnimTrack:SetSlideX( SetCyc )
								modelmenu.aGetCycle = SetCyc
							else
								surface.PlaySound("actmod/s/warning.wav")
							end
						end
					)
				end ):SetIcon( "icon16/tab_edit.png" )
				s.Cmenu:AddOption( "Copy Frames", function() SetClipboardText( tostring( math.floor(( modelmenu.aGetCycle*(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps) )+0.001) ) ) end ):SetIcon( "icon16/page_copy.png" )
				s.Cmenu:AddOption( "Copy the current frame", function() SetClipboardText(math.Round(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps)) end ):SetIcon( "icon16/page_copy.png" )
				s.Cmenu:AddSpacer() s.Cmenu:AddSpacer() s.Cmenu:AddSpacer()
				s.Cmenu:AddOption( "FrameRate = 30", function() modelmenu.Set_fps = 30 end ):SetIcon( modelmenu.Set_fps == 30 and "icon16/tick.png" or "icon16/text_align_justify.png" )
				s.Cmenu:AddOption( "FrameRate = 60", function() modelmenu.Set_fps = 60 end ):SetIcon( modelmenu.Set_fps == 60 and "icon16/tick.png" or "icon16/text_align_justify.png" )
				local nn36 = modelmenu.Set_fps ~= 30 and modelmenu.Set_fps ~= 60
				s.Cmenu:AddOption( nn36 and "Customize FrameRate  ( ".. modelmenu.Set_fps .." )" or "Customize FrameRate", function()
					Derma_StringRequest( "FrameRate", "Enter the value for FrameRate\n1-120",tostring( modelmenu.Set_fps ),
						function(text)
							text = tonumber(text)
							if isnumber(text) and modelmenu and IsValid(modelmenu) then
								local Settext = math.Clamp(text,1,120)
								modelmenu.Set_fps = Settext
							else
								surface.PlaySound("actmod/s/warning.wav")
							end
						end
					)
				end ):SetIcon( nn36 and "icon16/tick.png" or "icon16/text_align_justify.png" )
				s.Cmenu:Open()
			end
			modelmenu.GCNbr2 = vgui.Create( "DButton", self.MenuAni )
			modelmenu.GCNbr2:SetSize( fw*0.225, fh*0.05  )
			modelmenu.GCNbr2:SetPos( fw-modelmenu.GCNbr2:GetWide()-10, fh*0.905 - pady )
			modelmenu.GCNbr2:SetText( "" )
			modelmenu.GCNbr2.Paint = function( pan, w, h )
				draw.RoundedBox( 10, 0, 0, w, h, ( pan:IsDown() and Color( 100, 120, 100, 150 ) ) or Color( 50, 60, 50, 130 ) )
				draw.SimpleText( "Cycle:", "AM4_DescFont", 5, h/2, Color( 210, 255, 255 ), 0,1 )
				draw.SimpleText( tostring(modelmenu.aGetCycle), "AM4_DescFont", w*0.25, h/2, Color( 220, 255, 255 ), 0,1 )
			end
			modelmenu.GCNbr2.DoClick = function( pan )
				surface.PlaySound("garrysmod/ui_click.wav")
				SetClipboardText( tostring(modelmenu.aGetCycle) )
			end

	------------Lister------------
	------------------------------
		
		local searchtext = vgui.Create( "DButton", self.MenuAni )
		searchtext:SetSize( fw*0.15 * 0.15, fh*0.05  )
		searchtext:SetPos( t_w + searchbar:GetWide()*1.01,searchbar:GetTall()/2 )
		searchtext:SetText( "" )
		searchtext.Paint = function( pan, w, h )
			surface.SetDrawColor(color_white)
			surface.SetMaterial( Material("icon16/magnifier.png", "noclamp smooth") )
			surface.DrawTexturedRect(0, 0, w, h)
		end
		searchtext.DoClick = function( pan )
			local var = string.lower(searchbar:GetValue())
			local page = 1
			local line = 0

			if (var == "") then
				lister.Pages = lister.BasePages
				lister:ChangePage( page )
			else
				local found = {}
										
				for i = 1, #lister.BasePages do
					for _, v in ipairs( lister.BasePages[i] ) do
						if (string.find(string.lower(v), var)) then
							table.insert(found, v)
						end
					end
				end

				lister:RebuildToLines( modelmenu:GetEntity(), found )
			end
		end
	------------------------------
	-------------PAGE:------------
		
		local prevbutt = vgui.Create( "DButton", self.MenuAni )
		prevbutt:SetSize( fw*0.02, fh*0.05 )
		prevbutt:SetPos( fw/1.35 + searchtext:GetWide(), searchtext:GetTall()/2.5 )
		prevbutt:SetText( "" )
		prevbutt.Paint = function( pan, ww, hh )
		if lister.CurrentPage > 1 then
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 0, 55, 155, 155 ) ) or ( pan:IsHovered() and Color( 50, 100, 200, 155 ) ) or Color( 70, 100, 150, 150 ) )
			draw.SimpleText( "<", "AM4_DescFont", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 150, 50, 0, 155 ) ) or ( pan:IsHovered() and Color( 100, 50, 0, 100 ) ) or Color( 60, 40, 20, 60 ) )
			draw.SimpleText( "-", "AM4_DescFont", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		end
		prevbutt.DoClick = function( pan )
		if lister.CurrentPage > 1 then
			lister.CurrentPage = math.Clamp( lister.CurrentPage - 1, 1, #lister.Pages )
			lister:ChangePage( lister.CurrentPage )
		else surface.PlaySound("garrysmod/ui_return.wav") end
		end
		
		local pagedisplay = vgui.Create( "DLabel", self.MenuAni )
		pagedisplay:SetSize( fw*0.10, fh*0.05 )
		pagedisplay:SetPos( fw/1.30 + prevbutt:GetWide(), searchtext:GetTall()/2.5 )
		pagedisplay:SetText( "" )
		pagedisplay.Paint = function( pan, ww, hh )
			draw.RoundedBox( 15, 0, 0, ww, hh, Color( 70, 100, 150, 150 ) )
			draw.SimpleText( "Page: "..lister.CurrentPage.."/"..#lister.Pages, "AM4_DescFont", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		local nextbutt = vgui.Create( "DButton", self.MenuAni )
		nextbutt:SetSize( fw*0.02, fh*0.05 )
		nextbutt:SetPos( fw/1.258 + pagedisplay:GetWide(), searchtext:GetTall()/2.5 )
		nextbutt:SetText( "" )
		nextbutt.Paint = function( pan, ww, hh )
		if lister.CurrentPage < #lister.Pages then
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 0, 55, 155, 155 ) ) or ( pan:IsHovered() and Color( 50, 100, 200, 155 ) ) or Color( 70, 100, 150, 150 ) )
			draw.SimpleText( ">", "AM4_DescFont", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 150, 50, 0, 155 ) ) or ( pan:IsHovered() and Color( 100, 50, 0, 100 ) ) or Color( 60, 40, 20, 60 ) )
			draw.SimpleText( "-", "AM4_DescFont", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		end
		nextbutt.DoClick = function( pan )
		if lister.CurrentPage < #lister.Pages then
			lister.CurrentPage = math.Clamp( lister.CurrentPage + 1, 1, #lister.Pages )
			lister:ChangePage( lister.CurrentPage )
		else surface.PlaySound("garrysmod/ui_return.wav") end
		end
		
	-------------PAGE:------------
	------------------------------
		
		local Zibutt = vgui.Create( "DButton", self.MenuAni )
		Zibutt:SetSize( fw*0.065, fh*0.05 )
		Zibutt:SetPos( fw/1.108 + nextbutt:GetWide(), searchtext:GetTall()/2.5 )
		Zibutt:SetText( "" )
		Zibutt.Paint = function( pan, ww, hh )
		if zise == 1 then
			draw.RoundedBox( 10, 0, 0, ww, hh, ( pan:IsDown() and Color( 100, 200, 250, 255 ) ) or Color( 20, 80, 25, 155 ) )
			draw.SimpleText( "Size (S)", "AM4_DescFont", ww/2, hh/2, Color( 100, 255, 50 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		elseif zise == 2 then
			draw.RoundedBox( 10, 0, 0, ww, hh, ( pan:IsDown() and Color( 100, 200, 250, 255 ) ) or Color( 100, 110, 30, 155 ) )
			draw.SimpleText( "Size (M)", "AM4_DescFont", ww/2, hh/2, Color( 255, 255, 80 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		elseif zise == 3 then
			draw.RoundedBox( 10, 0, 0, ww, hh, ( pan:IsDown() and Color( 100, 200, 250, 255 ) ) or Color( 130, 80, 50, 105 ) )
			draw.SimpleText( "Size (L)", "AM4_DescFont", ww/2, hh/2, Color( 255, 190, 100 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		end
		
		local closebutt = vgui.Create( "DButton", self.MenuAni )
		closebutt:SetSize( fw*0.11, fh*0.05 )
		closebutt:SetPos( fw/2 + fw*0.38, fh*0.84 - pady )
		closebutt:SetText( "" )
		closebutt.Paint = function( pan, ww, hh )
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 250, 105, 105, 155 ) ) or Color( 175, 125, 125, 155 ) )
			draw.SimpleText( "Close Menu", "AM4_DescFont", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		closebutt.DoClick = function( pan )
			surface.PlaySound("garrysmod/balloon_pop_cute.wav") AM4:OpenMenuAni()	
		end
		
		
		local babutt = vgui.Create( "DButton", self.MenuAni )
		babutt:SetSize( fw*0.04, fh*0.05 )
		babutt:SetPos( fw/2, fh*0.84 - pady )
		babutt:SetText( "" )
		babutt.Paint = function( pan, ww, hh )
		if bshw then
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 105, 105, 105, 155 ) ) or Color( 55, 185, 55, 155 ) )
			draw.SimpleText( "B", "AM4_DescFont", ww/2, hh/2, Color( 80, 80, 80 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 50, 160, 50, 155 ) ) or Color( 90, 90, 90, 155 ) )
			draw.SimpleText( "G", "AM4_DescFont", ww/2, hh/2, Color( 50, 255, 50 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		end
		babutt.DoClick = function( pan )
			if bshw == true then bshw = false elseif bshw == false then bshw = true end
		end
		
		local sspeedr = vgui.Create( "DButton", self.MenuAni )
		sspeedr:SetSize( fw*0.02, fh*0.05 )
		sspeedr:SetPos( fw/2 + fw*0.125, fh*0.84 - pady )
		sspeedr:SetText( "" )
		sspeedr.Paint = function( pan, ww, hh )
		if ssped_r < 4.9 then
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 50, 160, 200, 155 ) ) or Color( 90, 90, 90, 155 ) )
			draw.SimpleText( ">", "AM4_DescFont", ww/2, hh/2, Color( 50, 150, 50 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 105, 20, 20, 155 ) ) or Color( 185, 185, 55, 155 ) )
			draw.SimpleText( "x", "AM4_DescFont", ww/2, hh/2, Color( 50, 50, 50 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		end
		sspeedr.DoClick = function( pan )
		if ssped_r < 4.9 then ssped_r = ssped_r +0.1 end
			local selected = lister:GetSelectedLine()
			if not selected then return end
			local ent = modelmenu:GetEntity()
			ent:SetPlaybackRate( ssped_r )
		end
		local sspeedf = vgui.Create( "DLabel", self.MenuAni )
		sspeedf:SetSize( fw*0.035, fh*0.05 )
		sspeedf:SetPos( fw/2 + fw*0.085, fh*0.84 - pady )
		sspeedf:SetText( "" )
		sspeedf.Paint = function( pan, ww, hh )
			draw.RoundedBox( 5, 0, 0, ww, hh, Color( 90, 90, 90, 155 ) )
		if ssped_r == 0 then
			draw.SimpleText( "0", "AM4_DescFont", ww/2, hh/2, Color( 150, 170, 180 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( ssped_r, "AM4_DescFont", ww/2, hh/2, Color( 150, 170, 180 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		end
		local rspeed = vgui.Create( "DButton", self.MenuAni )
		rspeed:SetSize( fw*0.02, fh*0.05 )
		rspeed:SetPos( fw/2 + fw*0.092, fh*0.84 - pady )
		rspeed:SetText( "" )
		rspeed.Paint = function( pan, ww, hh ) end
		rspeed.DoClick = function( pan )
		if ssped_r != 0 then ssped_r = 0
		elseif ssped_r != 1 then ssped_r = 1 end
			local selected = lister:GetSelectedLine()
			if not selected then return end
			local ent = modelmenu:GetEntity()
			ent:SetPlaybackRate( ssped_r )
		end
		local sspeedl = vgui.Create( "DButton", self.MenuAni )
		sspeedl:SetSize( fw*0.02, fh*0.05 )
		sspeedl:SetPos( fw/2 + fw*0.06, fh*0.84 - pady )
		sspeedl:SetText( "" )
		sspeedl.Paint = function( pan, ww, hh )
		if ssped_r > -1.5 then
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 50, 160, 200, 155 ) ) or Color( 90, 90, 90, 155 ) )
			draw.SimpleText( "<", "AM4_DescFont", ww/2, hh/2, Color( 50, 150, 50 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 105, 20, 20, 155 ) ) or Color( 185, 185, 55, 155 ) )
			draw.SimpleText( "x", "AM4_DescFont", ww/2, hh/2, Color( 50, 50, 50 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		end
		sspeedl.DoClick = function( pan )
			if ssped_r > 0.2 then ssped_r = ssped_r -0.1 elseif ssped_r > 0 then ssped_r = 0 elseif ssped_r > -1.5 then ssped_r = ssped_r -0.1 end
			local selected = lister:GetSelectedLine()
			if not selected then return end
			local ent = modelmenu:GetEntity()
			ent:SetPlaybackRate( ssped_r )
		end
		
		local shwbutt = vgui.Create( "DButton", self.MenuAni )
		shwbutt:SetSize( fw*0.13, fh*0.05 )
		shwbutt:SetPos( fw/2 + fw*0.24, fh*0.84 - pady )
		shwbutt:SetText( "" )
		shwbutt.Paint = function( pan, ww, hh )
		if showactinf == true then
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 0, 55, 155, 155 ) ) or Color( 65, 155, 75, 155 ) )
			draw.SimpleText( "Hied Act_Info", "AM4_DescFont", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 0, 55, 155, 155 ) ) or Color( 155, 155, 75, 155 ) )
			draw.SimpleText( "Show Act_Info", "AM4_DescFont", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		end
		shwbutt.DoClick = function( pan )
		if showactinf == true then showactinf = false elseif showactinf == false then showactinf = true end
		end
		
		local printbutt = vgui.Create( "DButton", self.MenuAni )
		printbutt:SetSize( fw*0.06, fh*0.05 )
		printbutt:SetPos( fw/2 + fw*0.17, fh*0.84 - pady )
		printbutt:SetText( "" )
		printbutt.Paint = function( pan, ww, hh )
			draw.RoundedBox( 5, 0, 0, ww, hh, ( pan:IsDown() and Color( 50, 105, 255, 155 ) ) or ( pan:IsHovered() and Color( 100, 100, 50, 100 ) ) or Color( 60, 70, 90, 160 ) )
			draw.SimpleText( "Print", "AM4_DescFont", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		printbutt.DoClick = function( pan )
			if not lister:GetLines()[ lister:GetSelectedLine() ] then return end
			local title = lister:GetLines()[ lister:GetSelectedLine() ]:GetValue( 1 )
			local ent = modelmenu:GetEntity()
			local act = ent:LookupSequence( title )
			surface.PlaySound("garrysmod/ui_click.wav")
			print("\n") chat.AddText(Color(255, 255, 200), "Open console to see print")
			timer.Simple(0.2,function() if IsValid(printbutt) then
			surface.PlaySound("garrysmod/content_downloaded.wav")
			timer.Simple(0.0,function() if IsValid(printbutt) then print("------------------------:")
			timer.Simple(0.0,function() if IsValid(printbutt) then
			if act then
				local actn = ent:GetSequenceActivityName( act )
				local GetSeq = ent:GetSequenceInfo( ent:GetSequence() ).label
				act = ent:GetSequenceActivity( act )
				if not act then print("ID: NONE") else print("ID:   "..act) end
				if not actn then print("Name: N/A") else print("Name: "..actn) end
				print("Seq :    "..title)
				print("Cycle :  "..modelmenu.aGetCycle)
				print("Frames : "..tostring( math.floor(( modelmenu.aGetCycle*(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps) )+0.001) ) .." /".. math.Round(ent:SequenceDuration(ent:LookupSequence(GetSeq))*modelmenu.Set_fps))
				print("==GetAnimInfo==")
				local defaultFPS,Default_MAX_Frame = 30,60
				local seqInfo = ent:GetSequenceInfo(ent:GetSequence()) --ent:LookupSequence( title )
				local animInfo = GfindLongestAnimationIn(seqInfo, ent)
				local fps,maxFrame = 30,60
				if animInfo.numframes > -1 then
					fps = animInfo.fps
					maxFrame = animInfo.numframes
				end
				if istable(animInfo) then PrintTable(animInfo) end
				print("===============")
			end
			timer.Simple(0.1,function() if IsValid(printbutt) then
			print("------------------------:\n")
			end end) end end) end end) end end)
		end
		
		local mw, mh = modelmenu:GetSize()
		
			local GSZText_1 = vgui.Create( "DLabel", modelmenu )
			GSZText_1:SetSize( mw, mh*0.2 ) GSZText_1:SetPos( 0, mh*0.8 )
			GSZText_1:SetAlpha(0) GSZText_1:SetFont("AM4_DescFont")
			GSZText_1:SetText( "" ) GSZText_1:SizeToContents()
			local GSZText_2 = vgui.Create( "DLabel", modelmenu )
			GSZText_2:SetSize( mw, mh*0.2 ) GSZText_2:SetPos( 0, mh*0.8 )
			GSZText_2:SetAlpha(0) GSZText_2:SetFont("AM4_DescFont")
			GSZText_2:SetText( "" ) GSZText_2:SizeToContents()
			local GSZText_3 = vgui.Create( "DLabel", modelmenu )
			GSZText_3:SetSize( mw, mh*0.2 ) GSZText_3:SetPos( 0, mh*0.8 )
			GSZText_3:SetAlpha(0) GSZText_3:SetFont("AM4_DescFont")
			GSZText_3:SetText( "" ) GSZText_3:SizeToContents()
			
		local infoframe = vgui.Create( "DPanel", modelmenu )
		infoframe:SetSize( mw, mh*0.2 )
		infoframe:SetPos( 0, mh*0.8 )
	--------
			local DBText_1 = vgui.Create( "DButton", modelmenu )
			DBText_1:SetPos( 10, mh*0.8 + infoframe:GetTall()*0.75 )
			DBText_1:SetSize( mw/5, 20 )
			DBText_1:SetText("")
			DBText_1.Paint = function( pan, ww, hh ) if pan:IsHovered() then draw.RoundedBox( 3, 0, 0, ww, hh, ( pan:IsDown() and Color( 20, 100, 20, 150 ) ) or ( pan:IsHovered() and Color( 50, 50, 100, 100 ) ) or Color( 0, 0, 0, 0 ) ) end end
			DBText_1.DoCopy = function( alower )
				if lister:GetLines()[ lister:GetSelectedLine() ] then
					local title = lister:GetLines()[ lister:GetSelectedLine() ]:GetValue( 1 )
					local ent = modelmenu:GetEntity()
					local act = ent:LookupSequence( title )
					if act then
						local actn = ent:GetSequenceActivityName( act )
						act = ent:GetSequenceActivity( act )
						if alower then
							SetClipboardText( string.lower( act ) )
						else
							SetClipboardText( act )
						end
					end
				end
			end
			DBText_1.DoClick = function( s ) DBText_1.DoCopy() end
			DBText_1.DoRightClick = function( s ) DBText_1.DoCopy(true) end
			
			local DBText_2 = vgui.Create( "DButton", modelmenu )
			DBText_2:SetPos( 10, mh*0.8 + infoframe:GetTall()*0.28 )
			DBText_2:SetSize( mw/5, 20 )
			DBText_2:SetText("")
			DBText_2.Paint = function( pan, ww, hh ) if pan:IsHovered() then draw.RoundedBox( 3, 0, 0, ww, hh, ( pan:IsDown() and Color( 20, 100, 20, 150 ) ) or ( pan:IsHovered() and Color( 50, 50, 100, 100 ) ) or Color( 0, 0, 0, 0 ) ) end end
			DBText_2.DoCopy = function( alower )
				if lister:GetLines()[ lister:GetSelectedLine() ] then
					if alower then
						SetClipboardText( string.lower( lister:GetLines()[ lister:GetSelectedLine() ]:GetValue( 1 ) ) )
					else
						SetClipboardText( lister:GetLines()[ lister:GetSelectedLine() ]:GetValue( 1 ) )
					end
				end
			end
			DBText_2.DoClick = function( s ) DBText_2.DoCopy() end
			DBText_2.DoRightClick = function( s ) DBText_2.DoCopy(true) end
		
			local DBText_3 = vgui.Create( "DButton", modelmenu )
			DBText_3:SetPos( 10, mh*0.8 + infoframe:GetTall()*0.54 )
			DBText_3:SetSize( mw/5, 20 )
			DBText_3:SetText("")
			DBText_3.Paint = function( pan, ww, hh ) draw.RoundedBox( 3, 0, 0, ww, hh, ( pan:IsDown() and Color( 20, 100, 20, 150 ) ) or ( pan:IsHovered() and Color( 50, 50, 100, 100 ) ) or Color( 0, 0, 0, 0 ) ) end
			DBText_3.DoCopy = function( alower )
				if lister:GetLines()[ lister:GetSelectedLine() ] then
					local title = lister:GetLines()[ lister:GetSelectedLine() ]:GetValue( 1 )
					local ent = modelmenu:GetEntity()
					local act = ent:LookupSequence( title )
					if act then
						local actn = ent:GetSequenceActivityName( act )
						if alower then
							SetClipboardText( string.lower( actn ) )
						else
							SetClipboardText( actn )
						end
					end
				end
			end
			DBText_3.DoClick = function( s ) DBText_3.DoCopy() end
			DBText_3.DoRightClick = function( s ) DBText_3.DoCopy(true) end
	--------
		infoframe.Paint = function( pan, ww, hh )
			if not showactinf then
			GSZText_1:SetText( "" ) GSZText_1:SizeToContents() DBText_1:SetSize( GSZText_1:GetSize(),GSZText_1:GetTall() )
			GSZText_2:SetText( "" ) GSZText_2:SizeToContents() DBText_2:SetSize( GSZText_2:GetSize(),GSZText_1:GetTall() )
			GSZText_3:SetText( "" ) GSZText_3:SizeToContents() DBText_3:SetSize( GSZText_3:GetSize(),GSZText_1:GetTall() )
			return end
			draw.RoundedBox( 0, 0, 0, ww, hh, Color( 0, 255, 255, 60 ) )
			if not lister:GetLines()[ lister:GetSelectedLine() ] then return end
			local title = lister:GetLines()[ lister:GetSelectedLine() ]:GetValue( 1 )
			local ent = modelmenu:GetEntity()
			local act = ent:LookupSequence( title )
			local GetSeq = ent:GetSequenceInfo( ent:GetSequence() ).label
			local time = "None"
			time = ent:SequenceDuration(ent:LookupSequence(title))
			draw.SimpleText( "Sequence: " .. title, "AM4_DescFont", 10, hh*0.28, color_white )
			GSZText_2:SetText( "Sequence: " .. title ) GSZText_2:SizeToContents() DBText_2:SetSize( GSZText_2:GetSize(),GSZText_1:GetTall() )
			if act then
				local actn = ent:GetSequenceActivityName( act )
				act = ent:GetSequenceActivity( act )
				if not act then 
					draw.SimpleText( "ID Act: NONE", "AM4_DescFont", 10, hh*0.75, color_white )
					GSZText_1:SetText( "ID Act: NONE" ) GSZText_1:SizeToContents() DBText_1:SetSize( GSZText_1:GetSize(),GSZText_1:GetTall() )
				else
					draw.SimpleText( "Time:  "..A_ToMinutesSecondsCD( math.Round(time*modelmenu.aGetCycle) ).." / ".. A_ToMinutesSecondsCD(time) .."   [ ".. math.Round(time*modelmenu.aGetCycle,5) .."  ( ".. math.Round(time-time*modelmenu.aGetCycle,5) .." )   / ".. math.Round(time,5) .." ]", "AM4_Font", 10, hh*0.04, color_white )
					draw.SimpleText( "ID Act: " .. act, "AM4_DescFont", 10, hh*0.75, color_white )
					GSZText_1:SetText( "ID Act: " .. act ) GSZText_1:SizeToContents() DBText_1:SetSize( GSZText_1:GetSize(),GSZText_1:GetTall() )
				end
				if not actn or actn == "" then 
					draw.SimpleText( "Name Act: N/A", "AM4_DescFont", 10, hh*0.54, color_white )
					GSZText_3:SetText( "Name Act: N/A" ) GSZText_3:SizeToContents() DBText_3:SetSize( GSZText_3:GetSize(),GSZText_1:GetTall() )
				else
					draw.SimpleText( "Name Act: " .. actn, "AM4_DescFont", 10, hh*0.54, color_white )
					GSZText_3:SetText( "Name Act: " .. actn ) GSZText_3:SizeToContents() DBText_3:SetSize( GSZText_3:GetSize(),GSZText_1:GetTall() )
				end
			end	
		end
		
		
		Zibutt.DoClick = function( pan )
			if zise == 1 then zise = 2
			elseif zise == 2 then zise = 3
			elseif zise == 3 then zise = 1
			end surface.PlaySound("garrysmod/ui_click.wav")
			
			self.AniFrame:SetSize( w, h )
			self.AniFrame:Center()
			
			if zise == 1 then self.MenuAni:SetSize( Zw_1, Zh_1 )
			elseif zise == 2 then self.MenuAni:SetSize( Zw_2, Zh_2 )
			elseif zise == 3 then self.MenuAni:SetSize( Zw_3, Zh_3 ) end
			self.MenuAni:Center()
			self.MenuAni:MakePopup()
			
			fw, fh = self.MenuAni:GetSize()
			padx = fh*0.025
			pady = padx
			
			modelmenu:SetPos( padx, pady )
			modelmenu:SetSize( fw/2 - padx - padx/2, fh*0.95 - 2*pady )
			
			local t_w,t_h = fw*0.495 + padx, pady
			searchbar:SetSize( fw*0.15 * 1.5, fh*0.05 * 0.8 )
			searchbar:SetPos( t_w,t_h )
			
			lister:SetPos( fw/2 + padx/2, fh*0.20 - pady*2 - searchbar:GetTall() )
			lister:SetSize( fw/2 - padx - padx/2, fh*0.70 - pady)
			
			BLister:SetPos( fw/2.04 + padx/2 , fh*0.185 - pady*2 - searchbar:GetTall() )
			BLister:SetSize( lister:GetSize()*1.035, lister:GetTall()*1.045)
			
			searchtext:SetSize( fw*0.15 * 0.15, fh*0.05  )
			searchtext:SetPos( t_w + searchbar:GetWide()*1.01,searchbar:GetTall()/2 )
			
			prevbutt:SetSize( fw*0.02, fh*0.05 )
			prevbutt:SetPos( fw/1.35 + searchtext:GetWide(), searchtext:GetTall()/2.5 )
			
			pagedisplay:SetSize( fw*0.10, fh*0.05 )
			pagedisplay:SetPos( fw/1.30 + prevbutt:GetWide(), searchtext:GetTall()/2.5 )
			
			nextbutt:SetSize( fw*0.02, fh*0.05 )
			nextbutt:SetPos( fw/1.258 + pagedisplay:GetWide(), searchtext:GetTall()/2.5 )
			
			Zibutt:SetSize( fw*0.065, fh*0.05 )
			Zibutt:SetPos( fw/1.108 + nextbutt:GetWide(), searchtext:GetTall()/2.5 )
			
			closebutt:SetSize( fw*0.11, fh*0.05 )
			closebutt:SetPos( fw/2 + fw*0.38, fh*0.84 - pady )
			
			babutt:SetSize( fw*0.04, fh*0.05 )
			babutt:SetPos( fw/2, fh*0.84 - pady )
			
			sspeedr:SetSize( fw*0.02, fh*0.05 )
			sspeedr:SetPos( fw/2 + fw*0.125, fh*0.84 - pady )
			
			sspeedf:SetSize( fw*0.035, fh*0.05 )
			sspeedf:SetPos( fw/2 + fw*0.085, fh*0.84 - pady )
			
			rspeed:SetSize( fw*0.02, fh*0.05 )
			rspeed:SetPos( fw/2 + fw*0.092, fh*0.84 - pady )
			
			sspeedl:SetSize( fw*0.02, fh*0.05 )
			sspeedl:SetPos( fw/2 + fw*0.06, fh*0.84 - pady )
			
			shwbutt:SetSize( fw*0.13, fh*0.05 )
			shwbutt:SetPos( fw/2 + fw*0.24, fh*0.84 - pady )
			
			printbutt:SetSize( fw*0.06, fh*0.05 )
			printbutt:SetPos( fw/2 + fw*0.17, fh*0.84 - pady )
			
			modelmenu.AnimTrack:SetSize( fw*0.98, fh*0.05 )
			modelmenu.AnimTrack:SetPos( 10, fh*0.965 - pady )
			
			modelmenu.GCNbr:SetSize( fw*0.24, fh*0.05  )
			modelmenu.GCNbr:SetPos( fw/2, fh*0.905 - pady )
			modelmenu.GCNbr2:SetSize( fw*0.225, fh*0.05  )
			modelmenu.GCNbr2:SetPos( fw-modelmenu.GCNbr2:GetWide()-10, fh*0.905 - pady )
			
			local mw, mh = modelmenu:GetSize()
			GSZText_1:SetSize( mw, mh*0.2 ) GSZText_1:SetPos( 0, mh*0.8 )
			GSZText_2:SetSize( mw, mh*0.2 ) GSZText_2:SetPos( 0, mh*0.8 )
			GSZText_3:SetSize( mw, mh*0.2 ) GSZText_3:SetPos( 0, mh*0.8 )
			
			infoframe:SetSize( mw, mh*0.2 )
			infoframe:SetPos( 0, mh*0.8 )

			DBText_1:SetPos( 10, mh*0.8 + infoframe:GetTall()*0.75 )
			DBText_1:SetSize( mw/5, 20 )
			DBText_2:SetPos( 10, mh*0.8 + infoframe:GetTall()*0.28 )
			DBText_2:SetSize( mw/5, 20 )
			DBText_3:SetPos( 10, mh*0.8 + infoframe:GetTall()*0.54 )
			DBText_3:SetSize( mw/5, 20 )
			
			AM4:ReZFont(zise)
		end
		
		
		if trumovi == false then
		if zise == 1 then self.MenuAni:SetSize( 0, Zh_1 ) self.MenuAni:SizeTo( Zw_1, Zh_1,0.5,0.3,-1 )
		elseif zise == 2 then self.MenuAni:SetSize( 0, Zh_2 ) self.MenuAni:SizeTo( Zw_2, Zh_2,0.5,0.3,-1 )
		elseif zise == 3 then self.MenuAni:SetSize( 0, Zh_3 ) self.MenuAni:SizeTo( Zw_3, Zh_3,0.5,0.3,-1 )
		end
		movist = vgui.Create( "DPanel", self.MenuAni )
		movist:SetPos( padx-3, pady-3 )
		movist:SetSize( fw*0.987, fh*0.962 )
		movist.Paint = function( pan, ww, hh )
			draw.RoundedBox( 0, 0, 0, ww, hh, Color( 15, 45, 65, 255 ) )
			surface.SetDrawColor(Color(255,255,255,255))
			surface.SetMaterial( Material("baseani_am4/baseam4.png", "noclamp smooth") )
			surface.DrawTexturedRect(ww/2.7, hh/3.5, ww/4, hh/2.5)
			draw.SimpleText( "( Version ".. AM4.AniExte.Mounted[ "Version" ] .." )", "AM4_FontL", ww/2, hh/1.3, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( "By AhmedMake400", "AM4_FontL", ww/2, hh/1.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		
		movist2 = vgui.Create( "DPanel", self.MenuAni )
		movist2:SetPos( padx-3, pady-3 )
		-- movist2:SetSize( fw*0.987, fh*0.962 )
		movist2:SetSize( fw*0.987, 0 )
		movist2:SetAlpha( 0 )
		movist2:SizeTo( fw*0.987, fh*0.962,0.5,2,-1 )
		-- movist2:AlphaTo( 255,0.5,1 )
		movist2:AlphaTo( 255,0.5,2,function(s) if IsValid(movist2) then if IsValid(movist) then movist:Remove() end
		movist2:AlphaTo( 0,0.5,0,function(s) if IsValid(movist2) then movist2:Remove() trumovi = true end end ) end end )
		movist2.Paint = function( pan, ww, hh )
			draw.RoundedBox( 0, 0, 0, ww, hh, Color( 200, 230, 255, 255 ) )
		end
		end
		
		
		
	end


	function AM4:OpenMenuAni()
		w = ScrW()
		h = ScrH()
		if AM4ani.AniFrame then
			AM4ani.AniFrame:Remove()
			AM4ani.AniFrame = nil
			gui.EnableScreenClicker( false )
			return 
		end
		AM4ani:Open()
	end
	
	function AM4:ReZFont(zise)
	 local zf = 22*(h/1200)+zise*zise
		surface.CreateFont( "AM4_Font", {
			font = "Roboto Cn",
			extended = false,
			size = 24*(h/1200)+zise*zise,
			weight = 1000,
			blursize = 0,
			scanlines = 0,
			antialias = true,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = false,
			additive = false,
			outline = false,
		} )

		surface.CreateFont( "AM4_DescFont",{
			font = "",
			extended = false,
			size = zf,
			weight = 500,
			blursize = 0,
			scanlines = 0,
			antialias = false,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = true,
			additive = false,
			outline = false,
		} )

		surface.CreateFont( "AM4_FontL",{
			font = "",
			extended = false,
			size = zf*3,
			weight = 500,
			blursize = 0,
			scanlines = 0,
			antialias = false,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = true,
			additive = false,
			outline = false,
		} )
		
		surface.CreateFont( "AM4_FontS",{
			font = "Roboto Cn",
			extended = false,
			size = zf*1,
			weight = 500,
			blursize = 0,
			scanlines = 0,
			antialias = false,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = true,
			additive = false,
			outline = false,
		} )
	end
	AM4:ReZFont(zise)


end
