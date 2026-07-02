if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaFon = true
if SERVER then return end

local Actoji = A_AM.ActMod.Actoji
if Actoji and IsValid(Actoji.Underlay) then
	if IsValid(Actoji.Underlay.modelmenu) then Actoji.Underlay.modelmenu:Remove() end
	Actoji.Underlay:Remove()
end


surface.CreateFont("ActMod_close", {
	font = "Roboto Bk",
	extended = false,
	bold = true,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont( "ActMod_a1", {
	font = "Roboto",
	extended = false,
	bold = true,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = false
} )

surface.CreateFont( "ActMod_a2", {
	font = "Roboto Bold",
	extended = false,
	bold = true,
	size = 19,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true
} )

surface.CreateFont( "ActMod_a3", {
	font = "Roboto",
	extended = false,
	bold = true,
	size = 20,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true
} )

surface.CreateFont( "ActMod_a4", {
	font = "Roboto Bold",
	extended = false,
	bold = true,
	size = 12,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true
} )
	
surface.CreateFont( "ActMod_a5",{
	font = "",
	extended = false,
	size = 17,
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
	
surface.CreateFont( "ActMod_a6",{
	font = "",
	extended = false,
	size = 25,
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

surface.CreateFont( "ActMod_e1", {
	font = "Roboto Bold",
	extended = false,
	bold = true,
	size = 15,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true
} )



local ttw,tth = ScrW(),ScrH()
if ttw > tth then ttw = tth else tth = ttw end
A_AM.ActMod.FontCache = A_AM.ActMod.FontCache or {}
function A_AM.ActMod:CGFont(baseFontName,Tab)
	Tab = Tab or {}
	Tab.weight = Tab.weight or 500
	Tab.blursize = Tab.blursize or 0
	antialias = antialias == nil and true or antialias
	local key = baseFontName .. "_" .. tostring(Tab.size) .. "_" .. tostring(Tab.weight)
	if not A_AM.ActMod.FontCache[key] then
		surface.CreateFont(key, {font = Tab.font,size = Tab.size,weight = Tab.weight,blursize = Tab.blursize,antialias = Tab.antialias,extended = Tab.extended})
		A_AM.ActMod.FontCache[key] = key
	end
	return A_AM.ActMod.FontCache[key]
end
A_AM.ActMod:CGFont("ActMod_a4_SC", {font = "Roboto Regular",size = ttw*0.016})
A_AM.ActMod:CGFont("ActMod_a8_SC", {font = "Roboto Bold",size = ttw*0.03})






function A_AM.ActMod.aGetTextSize(atxt,afont)
	if atxt and afont then
		surface.SetFont( afont )
		local width, height = surface.GetTextSize( atxt )
		return width,height
	end
	return 0
end



local PANEL = {}

AccessorFunc( PANEL, "m_HideButtons", "HideButtons" )

function PANEL:Init()
	self.Offset = 0
	self.Scroll = 0
	self.CanvasSize = 1
	self.BarSize = 1
	self.btnUp = vgui.Create( "DButton", self )
	self.btnUp:SetText( "" )
	self.btnUp.DoClick = function( self ) self:GetParent():AddScroll( -1 ) end
	self.btnUp.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonUp", panel, w, h ) end
	self.btnDown = vgui.Create( "DButton", self )
	self.btnDown:SetText( "" )
	self.btnDown.DoClick = function( self ) self:GetParent():AddScroll( 1 ) end
	self.btnDown.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonDown", panel, w, h ) end
	self.btnGrip = vgui.Create( "DScrollBarGrip", self )
	self:SetSize( 15, 15 )
	self:SetHideButtons( false )
end

function PANEL:SetEnabled( b )
	if ( !b ) then
		self.Offset = 0
		self:SetScroll( 0 )
		self.HasChanged = true
	end
	self:SetMouseInputEnabled( b )
	self:SetVisible( b )
	if ( self.Enabled != b ) then
		self:GetParent():InvalidateLayout()
		if ( self:GetParent().OnScrollbarAppear ) then
			self:GetParent():OnScrollbarAppear()
		end
	end
	self.Enabled = b
end

function PANEL:Value() return self.Pos end

function PANEL:BarScale()
	if ( self.BarSize == 0 ) then return 1 end
	return self.BarSize / ( self.CanvasSize + self.BarSize )
end

function PANEL:SetUp( _barsize_, _canvassize_ )
	self.BarSize = _barsize_
	self.CanvasSize = math.max( _canvassize_ - _barsize_, 1 )
	self:SetEnabled( _canvassize_ > _barsize_ )
	self:InvalidateLayout()
end

function PANEL:OnMouseWheeled( dlta )
	if ( !self:IsVisible() ) then return false end
	return self:AddScroll( dlta * -2 )
end

local length,ease,amount = 0.5,0.25,30

local function sign( num ) return num > 0 end

local function getBiggerPos( signOld, signNew, old, new )
	if signOld != signNew then return new end
	if signNew then
		return math.max(old, new) else return math.min(old, new)
	end
end

local tScroll = 0
local newerT = 0
function PANEL:AddScroll( dlta )
	self.Old_Pos = nil
	self.Old_Sign = nil
	local OldScroll = self:GetScroll()
	dlta = dlta * amount
	local anim = self:NewAnimation( length, 0, ease )
	anim.StartPos = OldScroll
	anim.TargetPos = OldScroll + dlta + tScroll
	tScroll = tScroll + dlta
	local ctime = RealTime()
	local doing_scroll = true
	newerT = ctime
	anim.Think = function( anim, pnl, fraction )
		local nowpos = Lerp( fraction, anim.StartPos, anim.TargetPos )
		if ctime == newerT then
			self:SetScroll( getBiggerPos( self.Old_Sign, sign(dlta), self.Old_Pos, nowpos ) )
			tScroll = tScroll - (tScroll * fraction)
		end
		if doing_scroll then
			self.Old_Sign = sign(dlta)
			self.Old_Pos = nowpos
		end
		if ctime != newerT then doing_scroll = false end
	end
	return math.Clamp( self:GetScroll() + tScroll, 0, self.CanvasSize ) != self:GetScroll()
end

function PANEL:SetScroll( scrll )
	if ( !self.Enabled ) then self.Scroll = 0 return end
	self.Scroll = math.Clamp( scrll, 0, self.CanvasSize )
	self:InvalidateLayout()
	local func = self:GetParent().OnVScroll
	if ( func ) then
		func( self:GetParent(), self:GetOffset() )
	else
		self:GetParent():InvalidateLayout()
	end
end

function PANEL:AnimateTo( scrll, length, delay, ease )
	local anim = self:NewAnimation( length, delay, ease )
	anim.StartPos = self.Scroll
	anim.TargetPos = scrll
	anim.Think = function( anim, pnl, fraction )
		pnl:SetScroll( Lerp( fraction, anim.StartPos, anim.TargetPos ) )
	end
end

function PANEL:GetScroll()
	if ( !self.Enabled ) then self.Scroll = 0 end
	return self.Scroll
end

function PANEL:GetOffset()
	if ( !self.Enabled ) then return 0 end
	return self.Scroll * -1
end

function PANEL:Think() end

function PANEL:Paint( w, h )
	derma.SkinHook( "Paint", "VScrollBar", self, w, h )
	return true
end

function PANEL:OnMousePressed()
	local x, y = self:CursorPos()
	local PageSize = self.BarSize
	if ( y > self.btnGrip.y ) then
		self:SetScroll( self:GetScroll() + PageSize )
	else
		self:SetScroll( self:GetScroll() - PageSize )
	end
end

function PANEL:OnMouseReleased()
	self.Dragging = false
	self.DraggingCanvas = nil
	self:MouseCapture( false )
	self.btnGrip.Depressed = false
end

function PANEL:OnCursorMoved( x, y )
	if ( !self.Enabled ) then return end
	if ( !self.Dragging ) then return end
	local x, y = self:ScreenToLocal( 0, gui.MouseY() )
	y = y - self.btnUp:GetTall()
	y = y - self.HoldPos
	local BtnHeight = self:GetWide()
	if ( self:GetHideButtons() ) then BtnHeight = 0 end
	local TrackSize = self:GetTall() - BtnHeight * 2 - self.btnGrip:GetTall()
	y = y / TrackSize
	self:SetScroll( y * self.CanvasSize )
end

function PANEL:Grip()
	if ( !self.Enabled ) then return end
	if ( self.BarSize == 0 ) then return end
	self:MouseCapture( true )
	self.Dragging = true
	local x, y = self.btnGrip:ScreenToLocal( 0, gui.MouseY() )
	self.HoldPos = y
	self.btnGrip.Depressed = true
end

function PANEL:PerformLayout()
	local Wide = self:GetWide()
	local BtnHeight = Wide
	if ( self:GetHideButtons() ) then BtnHeight = 0 end
	local Scroll = self:GetScroll() / self.CanvasSize
	local BarSize = math.max( self:BarScale() * ( self:GetTall() - ( BtnHeight * 2 ) ), 10 )
	local Track = self:GetTall() - ( BtnHeight * 2 ) - BarSize
	Track = Track + 1
	Scroll = Scroll * Track
	self.btnGrip:SetPos( 0, BtnHeight + Scroll )
	self.btnGrip:SetSize( Wide, BarSize )
	if ( BtnHeight > 0 ) then
		self.btnUp:SetPos( 0, 0, Wide, Wide )
		self.btnUp:SetSize( Wide, BtnHeight )
		self.btnDown:SetPos( 0, self:GetTall() - BtnHeight )
		self.btnDown:SetSize( Wide, BtnHeight )
		self.btnUp:SetVisible( true )
		self.btnDown:SetVisible( true )
	else
		self.btnUp:SetVisible( false )
		self.btnDown:SetVisible( false )
		self.btnDown:SetSize( Wide, BtnHeight )
		self.btnUp:SetSize( Wide, BtnHeight )
	end
end

derma.DefineControl( "AM4_DVScrollBar", "AM4 Scrollbar", PANEL, "Panel" )




local PANEL = {}
AccessorFunc( PANEL, "Padding", "Padding" )
AccessorFunc( PANEL, "pnlCanvas", "Canvas" )

function PANEL:Init()

	self.pnlCanvas = vgui.Create( "Panel", self )
	self.pnlCanvas.OnMousePressed = function( self, code ) self:GetParent():OnMousePressed( code ) end
	self.pnlCanvas:SetMouseInputEnabled( true )
	self.pnlCanvas.PerformLayout = function( pnl )
		self:PerformLayoutInternal()
		self:InvalidateParent()
	end

	self.VBar = vgui.Create( "AM4_DVScrollBar", self )
	self.VBar:Dock( RIGHT )
	
	self:SetPadding( 0 )
	self:SetMouseInputEnabled( true )
	self:SetPaintBackgroundEnabled( false )
	self:SetPaintBorderEnabled( false )
	self:SetPaintBackground( false )
end

function PANEL:AddItem( pnl )
	pnl:SetParent( self:GetCanvas() )
end

function PANEL:OnChildAdded( child )
	self:AddItem( child )
end

function PANEL:SizeToContents()
	self:SetSize( self.pnlCanvas:GetSize() )
end

function PANEL:GetVBar()
	return self.VBar
end

function PANEL:GetCanvas()
	return self.pnlCanvas
end

function PANEL:InnerWidth()
	return self:GetCanvas():GetWide()
end

function PANEL:Rebuild()
	self:GetCanvas():SizeToChildren( false, true )
	if ( self.m_bNoSizing && self:GetCanvas():GetTall() < self:GetTall() ) then
		self:GetCanvas():SetPos( 0, ( self:GetTall() - self:GetCanvas():GetTall() ) * 0.5 )
	end
end

function PANEL:OnMouseWheeled( dlta )
	return self.VBar:OnMouseWheeled( dlta )
end

function PANEL:OnVScroll( iOffset )
	self.pnlCanvas:SetPos( 0, iOffset )
end

function PANEL:ScrollToChild( panel )
	self:InvalidateLayout( true )
	local x, y = self.pnlCanvas:GetChildPosition( panel )
	local w, h = panel:GetSize()
	y = y + h * 0.5
	y = y - self:GetTall() * 0.5
	self.VBar:AnimateTo( y, 0.5, 0, 0.5 )
end

function PANEL:PerformLayoutInternal()
	local Tall = self.pnlCanvas:GetTall()
	local Wide = self:GetWide()
	local YPos = 0
	self:Rebuild()
	self.VBar:SetUp( self:GetTall(), self.pnlCanvas:GetTall() )
	YPos = self.VBar:GetOffset()
	if ( self.VBar.Enabled ) then Wide = Wide - self.VBar:GetWide() end
	self.pnlCanvas:SetPos( 0, YPos )
	self.pnlCanvas:SetWide( Wide )
	self:Rebuild()
	if ( Tall != self.pnlCanvas:GetTall() ) then
		self.VBar:SetScroll( self.VBar:GetScroll() )
	end
end

function PANEL:PerformLayout()
	self:PerformLayoutInternal()
end

function PANEL:Clear()
	return self.pnlCanvas:Clear()
end

derma.DefineControl( "AM4_DScrollPanel", "", PANEL, "DPanel" )





local PANEL = {}
function PANEL:Init()
	if LocalPlayer():GetObserverMode() == 4 or LocalPlayer():GetObserverMode() == 5 or LocalPlayer():GetObserverMode() == 6 then
		local mdlname = LocalPlayer():GetInfo( "cl_playermodel" )
		local mdlpath = player_manager.TranslatePlayerModel( mdlname )
		self:SetModel(tostring(mdlpath)) else self:SetModel(LocalPlayer():GetModel())
	end
	
	local ent = self:GetEntity()
	if ( !IsValid( ent ) ) then return end
	local skin = LocalPlayer():GetInfoNum( "cl_playerskin", 0 )
	ent:SetSkin( skin )
	
	local groups = LocalPlayer():GetInfo( "cl_playerbodygroups" )
	if ( groups == nil ) then groups = "" end
	local groups = string.Explode( " ", groups )
	for k = 0, ent:GetNumBodyGroups() - 1 do
		local v = tonumber( groups[ k + 1 ] ) or 0
		ent:SetBodygroup( k, v )
	end
	
	ent:SetLOD( 0 )

	local PrevMins, PrevMaxs = self.Entity:GetRenderBounds()
	self.GSetPs = ent:GetBonePosition(0) + Vector(PrevMins:Distance(PrevMaxs)*1.2, 0, PrevMins:Distance(PrevMaxs)*0.2)
	self.GDisCam = self:GetCamPos():Distance(ent:GetBonePosition(0))
	self.GCtLerp = self.GSetPs
	self.zEnd = 0
	self:SetCamPos(self.GSetPs)
	self:SetFOV(45)
	self.PMins = PrevMins
	self.PMaxs = PrevMaxs
	
	self.EntityT = ClientsideModel( "models/hunter/blocks/cube8x8x025.mdl", RENDERGROUP_OTHER )
	if ( !IsValid( self.EntityT ) ) then return end
	self.EntityT:SetNoDraw( true )
	self.EntityT:SetMaterial("actmod/eff_particle/gplv")
	
	
	self.LIndex = "CursorHide_" .. tostring(self)
    local _dragging = false
    local _lockX, _lockY = 0, 0
    local _dragYaw = 0
    local _dragPitch = 0
    local timremv = CurTime() + 0.5
	hook.Add("Think", self.LIndex, function()
		if not self.EMMus then LocalPlayer().ActMod_cl_MisDragging = false return end
		if not IsValid(self) or not self.EMMus and timremv < CurTime() then hook.Remove("Think", self.LIndex) return end
        local mx, my = gui.MousePos()
        local sx, sy = self:LocalToScreen(0, 0)
        local sw, sh = self:GetWide(), self:GetTall()
        local inBounds = mx >= sx and mx <= sx+sw and my >= sy and my <= sy+sh
        if input.IsMouseDown(MOUSE_LEFT) and inBounds and not _dragging then _dragging = true _lockX, _lockY = mx, my _dragYaw = self._dragYaw _dragPitch = self._dragPitch end
        if not input.IsMouseDown(MOUSE_LEFT) and _dragging then 
            _dragging = false _dragYaw = 0 _dragPitch = 0
            gui.SetMousePos(_lockX, _lockY)
			self._cursorIdleTime = CurTime() + 0.5
        end
        if _dragging then
            local dx,dy = -mx + _lockX ,my - _lockY
            _dragYaw = (_dragYaw + dx * 0.2) % 360
            _dragPitch = math.Clamp(_dragPitch + dy * 0.15 , -40, 10)
            gui.SetMousePos(_lockX, _lockY)
        end
        LocalPlayer().ActMod_cl_MisDragging = _dragging
        self._dragYaw = _dragYaw
        self._dragPitch = _dragPitch
	end)
    LocalPlayer().ActMod_cl_MisDragging = false
    self._dragYaw    = 0
    self._dragPitch  = 0
	self._cursorIdleTime = CurTime() + 0.5
end

function PANEL:OnRemove()
    hook.Remove("Think", self.LIndex)
	LocalPlayer().ActMod_cl_MisDragging = nil
end

function PANEL:Paint()
	if ( !IsValid( self.Entity ) ) then return end
	local x, y = self:LocalToScreen( 0, 0 )
	self:LayoutEntity( self.Entity )
	local ang = self.aLookAngle
	if ( !ang ) then
		ang = (self.vLookatPos-self.vCamPos):Angle()
	end
	local w, h = self:GetSize()
	local zw,zh ,pw,ph
	local textPos,textAng = Vector(-900, -300, 360) ,Angle(0, 90, 0) 
	if self.pbase and self.zbase then
		pw, ph = self.pbase[1],self.pbase[2]
		zw, zh = self.zbase[1],self.zbase[2]
		LocalPlayer().attTab = {self.pbase,self.zbase}
	elseif self.Entity.pbase and self.Entity.zbase then
		pw, ph = self.Entity.pbase[1],self.Entity.pbase[2]
		zw, zh = self.Entity.zbase[1],self.Entity.zbase[2]
	else
		zw, zh = 760,math.Clamp(ScrH() / 1.3 ,355,680)
		pw, ph = ScrW()/2-zw/2,ScrH()-zh+5
	end
	render.SetScissorRect( pw, ph, pw+zw, ph+zh, true )
	cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, math.max(self.zEnd,5) )
		render.SuppressEngineLighting( true )
		local FogSN = math.max(self.zEnd,5)
		render.FogMode(1)
		render.FogStart(1+FogSN/6)
		render.FogColor(100, 150, 170)
		render.FogMaxDensity(1)
		render.FogEnd(0+FogSN)
		render.SetLightingOrigin( self.Entity:GetPos() )
		render.ResetModelLighting( 0.6, 0.6, 0.6 )
		render.SetColorModulation( 1, 1, 1 )
		for i = 0, 6 do if self.DirectionalLight[ i ] then render.SetModelLighting( i, 1.4, 1.4, 1.2 ) end end
		self.Entity:DrawModel()
		self:DrawOtherModels()
		A_AM.ActMod.WM3D.Draw(
			textPos, textAng,
			{ scale = 15,depth = 60,r=240,g=255,b=255,ox = 16,oz = 60 },
			{ scale = 8,depth = 60,r=200,g=255,b=255,ox = -3,oz = 0 }
		)
		if self.EMMus and isnumber(A_AM.ActMod.RKarm) and A_AM.ActMod.RKarm > 0 then
			if not self.arrert then self.arrert = true A_AM.ActMod.MoonLantern3D.Push("ramadan_moon") A_AM.ActMod.MoonLantern3D.Reset("ramadan_moon") end
			A_AM.ActMod.MoonLantern3D.Draw(Vector(400, -750, 630),self.vCamPos)
		end
		render.SuppressEngineLighting( false )
	cam.End3D()
	render.SetScissorRect( 0, 0, 0, 0, false )
	
	if self.Entity.noR then
		if not self.ttEEnd then self.ttEEnd = SysTime() + 1 self.tszEnd = self.zEnd end
		local taf = math.Clamp( (self.ttEEnd - SysTime()) ,0,1)
		self.zEnd = self.tszEnd*math.ease.InExpo( taf )
		if self.zEnd < 150 then
			if self.Entity.GLast.modelmenu and IsValid(self.Entity.GLast.modelmenu) and not self.aLast then
				self.aLast = true
				self.Entity.GLast.modelmenu:Remove()
				hook.Remove("Think", self.LIndex)
				local hovered = vgui.GetHoveredPanel()
				if IsValid(hovered) then hovered:SetCursor(not self.EMMus and "hand" or "arrow") end
			end
		end
	elseif self.zEnd < 2500 then
		self.zEnd = self.zEnd + RealFrameTime() * 1800
	end
	self.LastPaint = RealTime()
end

function PANEL:DrawOtherModels()
	local ply = LocalPlayer()
	if IsValid(self.EntityT) then
		if not self.EntityT.Eaaa then
			self.EntityT.Eaaa = true
			self.EntityT:SetPos(Vector(0, 0, -53))
			self.EntityT:SetAngles(Angle(0, 0, 0))
			self.EntityT:SetModelScale(9)
		end
		self.EntityT:DrawModel()
	end
	if not self.Eaaa then
		self.Eaaa = true
		local ent = self:GetEntity()
		if not ent.Eaaa and IsValid(ent) then
			ent.Eaaa = true
			local skin = LocalPlayer():GetInfoNum( "cl_playerskin", 0 )
			ent:SetSkin( skin )
			local groups = LocalPlayer():GetInfo( "cl_playerbodygroups" )
			if ( groups == nil ) then groups = "" end
			local groups = string.Explode( " ", groups )
			for k = 0, ent:GetNumBodyGroups() - 1 do
				local v = tonumber( groups[ k + 1 ] ) or 0
				ent:SetBodygroup( k, v )
			end
			if GetConVar("cl_playercolor") and tostring(GetConVar("cl_playercolor")) == "ConVar [cl_playercolor]" and isstring(GetConVarString("cl_playercolor")) then
				self.Entity.GetPlayerColor = function() return Vector(GetConVarString("cl_playercolor")) end
			else
				self.Entity.GetPlayerColor = function() end
			end
		end
	end
end

function PANEL:LayoutEntity()
	local aModelmenu,FTi,RFTi = self,FrameTime(),RealFrameTime()
	local ent = self:GetEntity()
	ent:SetEyeTarget(self:GetCamPos())
	ent:FrameAdvance(FTi)
	local ap0 = A_AM.ActMod:GetEntityBoneCenter(ent)
	local mx, my = gui.MousePos()
	local sx, sy = self:LocalToScreen(0, 0)
	local sw, sh = self:GetWide(), self:GetTall()
	local inBounds = mx >= sx and mx <= sx+sw and my >= sy and my <= sy+sh
	local targetYaw, targetPitch = 0, 0
	if inBounds then
		targetYaw = ((mx - sx)/sw - 0.5) * 80
		targetPitch = ((my - sy)/sh - 0.8) * 25
	end
	if not self.MouseAngLerp then self.MouseAngLerp = Angle() end
	if LocalPlayer().ActMod_cl_MisDragging then
		self.MouseAngLerp.y = self._dragYaw
		self.MouseAngLerp.p = self._dragPitch
	else
		local lerpSpeed = inBounds and 3 or 5
		self.MouseAngLerp = LerpAngle(RFTi * lerpSpeed, self.MouseAngLerp, Angle(targetPitch,-targetYaw,0))
		self._dragYaw = self.MouseAngLerp.y
		self._dragPitch = self.MouseAngLerp.p
	end
	if not self._lastMX then self._lastMX, self._lastMY = mx, my end
	if mx ~= self._lastMX or my ~= self._lastMY then
		self._lastMX, self._lastMY = mx, my
		self._cursorIdleTime = CurTime() + 0.3
	end
	local hoveredPanel = vgui.GetHoveredPanel()
	if not self.addtisWorkM and IsValid(hoveredPanel) then self.addtisWorkM = true hoveredPanel.tisWorkM = true end
	if self.addtisWorkM and IsValid(hoveredPanel) and hoveredPanel.tisWorkM then
		local shouldHide = LocalPlayer().ActMod_cl_MisDragging or (self._cursorIdleTime and CurTime() > self._cursorIdleTime)
		hoveredPanel:SetCursor(shouldHide and "blank" or (not self.EMMus and "hand" or "arrow"))
	end
	local camDist = self.PMaxs.z * 1.55
	local aaoup = math.Clamp(-10-self.MouseAngLerp.p,0,20)
	local aaop = math.max(self.MouseAngLerp.p,0)
	local yawRad = math.rad(self.MouseAngLerp.y)
	local ggu = ap0 + Vector( camDist * math.cos(yawRad) - aaop*3 -aaoup*1.5 ,camDist * math.sin(yawRad) ,self.PMaxs.z * 0.2 + aaop*4 -aaoup*1.5 )
	local aaap = ggu:Distance(aModelmenu.GCtLerp)
	aModelmenu.GCtLerp = LerpVector(math.Clamp(RFTi*2*aaap,0,1), aModelmenu.GCtLerp, ggu)
	aModelmenu:SetCamPos(aModelmenu.GCtLerp)
	local faixang = (ap0 - aModelmenu:GetCamPos()):Angle()
	if not aModelmenu.GangLrp then aModelmenu.GangLrp = faixang end
	aModelmenu.GangLrp = LerpAngle(math.Clamp(RFTi*20,0,1), aModelmenu.GangLrp ,Angle((self.PMaxs.z*0.05)+faixang.p + self.MouseAngLerp.p - aaop*1.5 +aaoup*0.2, faixang.y, 0))
	aModelmenu:SetLookAng(aModelmenu.GangLrp)
end


vgui.Register('AM4_DModelPreview', PANEL, 'DModelPanel')






local a = 0
local last = nil
local isSafe = true
local function CalculateSmartTextPosition(target, viewerPos)
	local basePos = target:GetPos()
	local rootBone = target:GetBonePosition(0)
	local displacement = basePos:Distance(rootBone)
	local toViewer = (viewerPos - basePos):Angle()
	local pullStrength = math.Clamp((50-displacement)/8,0,1)
	return basePos + Vector(0, 0, 10) + toViewer:Forward() * (30*pullStrength)
end
function A_AM.ActMod:HUD_3D_TaSynPly()
	local p = LocalPlayer()
	if GetConVarNumber("actmod_sv_alowdsyn") <= 0 or GetConVarNumber("actmod_sv_showhisyn") <= 0 or GetConVarNumber("actmod_cl_showhisyn") <= 0 or not p:Alive() or p:GetObserverMode() ~= 0 then return end
	if !IsValid(p) then return end
	local t = p.ActMod_TSndJ_LookTPly
	local dt = FrameTime()
	if IsValid(t) then a = Lerp(dt * 8, a, 1) last = t else a = Lerp(dt * 12, a, 0) end
	if a < 0.01 or !IsValid(last) then return end
	local Amins,Amaxs = Vector(-10,-10,0),Vector(10,10,15)
	if last:IsPlayer() then
		local AGHN,AGHM = last:GetHull()
		if isvector(AGHN) then Amins = AGHN end
		if isvector(AGHM) then Amaxs = AGHM end
	end
	local pos = last:GetPos()
	local ang = last:GetAngles()
	local tc = Color(80,200,225)
	local col = isSafe and Color(tc.r, tc.g, tc.b, 255 * a) or Color(255, 80, 80, 255 * a)
	local ePos,na,groundPos = EyePos(),6,pos + Vector(0, 0, 2)
	local radius = Amaxs.y + math.sin(CurTime() * 2) * 3
	local pulse = (1 + math.sin(CurTime() * 8))*0.5
	render.SetColorMaterial()
	cam.Start3D(ePos,EyeAngles())
		for i = 0, na do
			local angle1,angle2 = math.rad((i / na) * 360),math.rad(((i + 1) / na) * 360)
			render.DrawBeam(groundPos + Vector(math.cos(angle1) * radius, math.sin(angle1) * radius, 0),groundPos + Vector(math.cos(angle2) * radius, math.sin(angle2) * radius, 0),1,0,1,Color(col.r, col.g, col.b, 100*pulse*a))
		end
	cam.End3D()
end


A_AM.ActMod.WM3D = WM3D or {}
local _=Mesh local __=Matrix local ___=Vector local ____=Angle
local _a=render local _b=cam local _c=mesh local _d=hook
local _e=CreateMaterial("__wm"..math.random(1e6),"UnlitGeneric",{["$vertexcolor"]=1,["$nocull"]=1})
local _f,_g,_PQ,_W,_H,_GAP={},{},{},5,7,2.5
local _D={
	[99]={0,14,17,16,16,17,14},[116]={8,8,14,8,8,8,6},[77]={17,27,21,17,17,17,17},
	[111]={0,14,17,17,17,17,14},[100]={1,1,15,17,17,17,15},[104]={16,16,30,17,17,17,17},
	[109]={0,0,26,21,21,21,21},[101]={0,14,17,31,16,16,14},[107]={16,18,20,24,20,18,17},
	[52]={2,6,10,18,31,2,2},[48]={14,17,19,21,25,17,14},[97]={0,14,1,15,17,19,13},[65]={14,17,17,31,17,17,17}
}
local function _px(b,x,y) return bit.band(bit.rshift((_D[b] or {})[y+1] or 0,_W-1-x),1)==1 end
local function _mk(s,sc,dp,cr,cg,cb)
	local _n=#s
	local _sr,_sg,_sb=math.floor(cr*.45),math.floor(cg*.45),math.floor(cb*.45)
	local function _io(gx,py)
		if gx<0 or py<0 or py>=_H then return false end
		local ci=math.floor(gx/(_W+1))+1
		if ci<1 or ci>_n then return false end
		local px2=gx%((_W+1))
		if px2>=_W then return false end
		return _px(s:byte(ci),px2,py)
	end
	local _tw=_n*(_W+1)-1
	local _v,_vc={},0
	local function _t(p1,p2,p3,r2,g2,b2)
		_vc=_vc+1 _v[_vc]={p1,r2,g2,b2}
		_vc=_vc+1 _v[_vc]={p2,r2,g2,b2}
		_vc=_vc+1 _v[_vc]={p3,r2,g2,b2}
	end
	local function _q(p1,p2,p3,p4,r2,g2,b2) _t(p1,p2,p3,r2,g2,b2) _t(p1,p3,p4,r2,g2,b2) end
	for gx=0,_tw-1 do
		for py=0,_H-1 do
			if _io(gx,py) then
				local x0,x1=gx*sc,(gx+1)*sc
				local z0,z1=-(py+1)*sc,-py*sc
				_q(___(x0,dp,z0),___(x0,dp,z1),___(x1,dp,z1),___(x1,dp,z0),cr,cg,cb)
				_q(___(x1,0,z0),___(x1,0,z1),___(x0,0,z1),___(x0,0,z0),cr,cg,cb)
				if not _io(gx,py-1) then _q(___(x0,0,z1),___(x0,dp,z1),___(x1,dp,z1),___(x1,0,z1),_sr,_sg,_sb) end
				if not _io(gx,py+1) then _q(___(x1,0,z0),___(x1,dp,z0),___(x0,dp,z0),___(x0,0,z0),_sr,_sg,_sb) end
				if not _io(gx+1,py) then _q(___(x1,0,z1),___(x1,dp,z1),___(x1,dp,z0),___(x1,0,z0),_sr,_sg,_sb) end
				if not _io(gx-1,py) then _q(___(x0,0,z0),___(x0,dp,z0),___(x0,dp,z1),___(x0,0,z1),_sr,_sg,_sb) end
			end
		end
	end
	if _vc==0 then return false end
	local m=_(_e)
	_c.Begin(m,MATERIAL_TRIANGLES,_vc)
	for _,v in ipairs(_v) do
		_c.Position(v[1]) _c.Color(v[2],v[3],v[4],255) _c.AdvanceVertex()
	end
	_c.End()
	return {m=m,w=_tw*sc,h=_H*sc}
end
local _S1,_S2,_tR=string.char(65,99,116,77,111,100),string.char(65,104,109,101,100,77,97,107,101,52,48,48),SysTime()
local function _get(s,sc,dp,cr,cg,cb)
	local k=s.."|"..sc.."|"..dp.."|"..cr.."|"..cg.."|"..cb
	if _f[k]==nil and not _PQ[k] then
		_PQ[k]={s=s,sc=sc,dp=dp,cr=cr,cg=cg,cb=cb}
		if hook.GetTable().Think and not hook.GetTable().Think["_AtMd_wm_b"] then
			_d.Add("Think","_AtMd_wm_b",function() local n=0 for _k,_v in pairs(_PQ) do n=1 _tR=SysTime()+0.5 _f[_k]=_mk(_v.s,_v.sc,_v.dp,_v.cr,_v.cg,_v.cb) or false _PQ[_k]=nil end if n==0 and _tR<SysTime() then _d.Remove("Think","_AtMd_wm_b") end end)
		end
	end
	return _f[k]
end
function A_AM.ActMod.WM3D.Draw(pos,ang,opt1,opt2)
	opt1=opt1 or {} opt2=opt2 or {}
	local sc1=opt1.scale or 1.5
	local dp1=opt1.depth or 3.5
	local cr1=opt1.r or 255  local cg1=opt1.g or 220  local cb1=opt1.b or 120
	local ox1=opt1.ox or 0   local oz1=opt1.oz or 0   local oy1=opt1.oy or 0
	local cx1=opt1.cx~=false
	local sc2=opt2.scale or 1.0
	local dp2=opt2.depth or 2.5
	local cr2=opt2.r or 180  local cg2=opt2.g or 180  local cb2=opt2.b or 180
	local ox2=opt2.ox or 0   local oz2=opt2.oz or 0   local oy2=opt2.oy or 0
	local cx2=opt2.cx~=false
	local d1=_get(_S1,sc1,dp1,cr1,cg1,cb1)
	local d2=_get(_S2,sc2,dp2,cr2,cg2,cb2)
	if not (d1 and d2) then return end
	_a.SetMaterial(_e)
	local _o1=___(ox1,oy1,0) _o1:Rotate(ang)
	local _o2=___(ox2,oy2,0) _o2:Rotate(ang)
	local _m1,_m2=__(),__()
	_m1:SetTranslation(___( pos.x + _o1.x + (cx1 and -d1.w*.5 or 0),pos.y + _o1.y,pos.z + oz1 + d2.h + _GAP ))
	_m1:SetAngles(ang)
	_b.PushModelMatrix(_m1) d1.m:Draw() _b.PopModelMatrix()
	_m2:SetTranslation(___( pos.x + _o2.x + (cx2 and -d2.w*.5 or 0),pos.y + _o2.y,pos.z + oz2 ))
	_m2:SetAngles(ang)
	_b.PushModelMatrix(_m2) d2.m:Draw() _b.PopModelMatrix()
end



A_AM.ActMod.MoonLantern3D = A_AM.ActMod.MoonLantern3D or {}
A_AM.ActMod.MoonLantern3D.TMat = A_AM.ActMod.MoonLantern3D.TMat or {
	M = CreateMaterial("__ActMod_TMat_gplm", "UnlitGeneric", {["$basetexture"] = "actmod/eff_particle/gplm",["$vertexcolor"] = 1,["$vertexalpha"] = 1,["$translucent"] = 1})
	,T = CreateMaterial("__ActMod_TMat_gplt", "UnlitGeneric", {["$basetexture"] = "actmod/eff_particle/gplt",["$vertexcolor"] = 1,["$vertexalpha"] = 1,["$translucent"] = 1})
	,L = CreateMaterial("__ActMod_TMat_gpll", "UnlitGeneric", {["$basetexture"] = "actmod/eff_particle/gpll",["$vertexcolor"] = 1,["$vertexalpha"] = 1,["$translucent"] = 1})
}
local _matMoon = A_AM.ActMod.MoonLantern3D.TMat.M
local _matTxt = A_AM.ActMod.MoonLantern3D.TMat.T
local _matLantern = A_AM.ActMod.MoonLantern3D.TMat.L
local _matGlow = Material("sprites/glow04_noz")
local _matRope = Material("trails/laser")
local _state = {}
local function _drawBillboard(center, right, up, w, h, mat, col, rotRad)
	if not mat then return end
    rotRad = rotRad or 0
    local hw, hh = w*0.5, h*0.5
    local cosR, sinR = math.cos(rotRad), math.sin(rotRad)
    local r = right*cosR + up*sinR
    local u = right*(-sinR) + up*cosR
    render.SetMaterial(mat)
    render.DrawQuad(center - r*hw + u*hh,center + r*hw + u*hh,center + r*hw - u*hh,center - r*hw - u*hh,col or color_white)
end
local function _drawRope(from, to, right, ropt)
    local width = ropt.ropeWidth or 1.5
    local segs = ropt.ropeSegments or 12
    local sag = ropt.ropeSag or 3.0
    local col = ropt.ropeColor or Color(160, 120, 60, 220)
    local up = Vector(0, 0, 1)
    local hw = width * 0.5
    render.SetMaterial(_matRope)
    for i = 0, segs-1 do
        local t0 = i/segs
        local t1 = (i+1)/segs
        local p0 = LerpVector(t0, from, to) - up*(math.sin(t0*math.pi)*sag)
        local p1 = LerpVector(t1, from, to) - up*(math.sin(t1*math.pi)*sag)
        render.DrawQuad(p0-right*hw, p0+right*hw,p1+right*hw, p1-right*hw,col)
    end
end
function A_AM.ActMod.MoonLantern3D.Draw(pos,camPos)
    local key = "ramadan_moon"
    local t = CurTime()
    if not _state[key] then _state[key] = { ang=math.rad(35), vel=0, lastTime=t } end
    local s  = _state[key]
    local dt = math.Clamp(t - s.lastTime, 0, 0.05)
    s.lastTime = t
    local moonW = 250
    local moonH = 250
    local moonFloat = 6
    local moonFSpd = 0.8
    local moonCol = color_white
    local moonRot = 0
    local moonGlowSz = 510
    local moonGlowC = Color(255, 240, 160, 90)
    local ropeOffX = 0
    local ropeOffY = -(moonH * 0.45)
    local ropeLen = 250
    local ropt = { ropeWidth = 100 ,ropeColor = Color(255, 255, 100, 255) ,ropeSegments = 12 ,ropeSag = 14 }
    local lanternW = 100
    local lanternH = 200
    local lanternOffY = 14
    local lanternCol = color_white
    local lanternGlowC = Color(255, 140, 30, 180)
    local lanternGlowSz = 128
    local gravity = 800
    local damping = 0.01
    local starCount = 30
    local starRadius = 250
    local starCol = Color(255, 245, 200)
    local w2 = gravity / ropeLen
    local function acc(a, v) return -w2*math.sin(a) - damping*v end
    local k1a,k1v = s.vel,            acc(s.ang, s.vel)
    local k2a,k2v = s.vel+.5*dt*k1v, acc(s.ang+.5*dt*k1a, s.vel+.5*dt*k1v)
    local k3a,k3v = s.vel+.5*dt*k2v, acc(s.ang+.5*dt*k2a, s.vel+.5*dt*k2v)
    local k4a,k4v = s.vel+dt*k3v,    acc(s.ang+dt*k3a,    s.vel+dt*k3v)
    s.ang = s.ang + (dt/6)*(k1a+2*k2a+2*k3a+k4a)
    s.vel = s.vel + (dt/6)*(k1v+2*k2v+2*k3v+k4v)
    local toEye = (camPos - pos); toEye.z=0
    if toEye:Length() < 1 then toEye = Vector(1,0,0) end
    toEye:Normalize()
    local right = toEye:Cross(Vector(0,0,-1)):GetNormalized()
    local up    = Vector(0,0,1)
    local moonPos   = Vector(pos.x, pos.y, pos.z + math.sin(t*moonFSpd)*moonFloat)
    local pivot     = moonPos + right*ropeOffX + up*ropeOffY
    local ropeEnd   = pivot + right*(math.sin(s.ang)*ropeLen) + up*(-math.cos(s.ang)*ropeLen)
    local lPos      = ropeEnd - up*lanternOffY
    if not s.starData then
        local sd = {}
        math.randomseed(key:byte(1,1)*31+7)
        for i = 1, starCount do
            sd[i] = {
                a  = math.random()*math.pi*2,
                d  = moonW*0.6 + math.random()*starRadius,
                sz = math.random()*6 + 25,
                ph = math.random()*math.pi*2,
                k  = math.random(3),
                sp = math.random()*0.5 + 0.2,
            }
        end
        math.randomseed(os.time())
        s.starData = sd
    end
    render.SetMaterial(_matGlow)
    for _, st in ipairs(s.starData) do
        local alpha, size
        if st.k == 1 then
            alpha = 140 + math.sin(t*0.5+st.ph)*55
            size  = st.sz
        elseif st.k == 2 then
            local cy = (t*st.sp+st.ph) % (math.pi*2)
            alpha = ((math.sin(cy)+1)*0.5) * 190
            size  = st.sz * (0.5+(math.sin(cy)+1)*0.5)
        else
            local bl = math.sin(t*(2.5+st.ph)+st.ph)
            alpha = bl>0 and bl*220 or 0
            size  = st.sz*0.7
        end
        if alpha > 5 then
            local sp = moonPos + right*(math.cos(st.a)*st.d) + up*(math.sin(st.a)*st.d*0.8)
            render.DrawSprite(sp+Vector(0,0,100), size, size, Color(starCol.r, starCol.g, starCol.b, alpha))
        end
    end
	render.SetMaterial(_matGlow)
	render.DrawSprite(moonPos, moonGlowSz, moonGlowSz,Color(moonGlowC.r, moonGlowC.g, moonGlowC.b,moonGlowC.a + math.sin(t*0.5)*15))
    _drawBillboard(moonPos, right, up, moonW, moonH, _matMoon, moonCol, moonRot)
    _drawBillboard(moonPos+Vector(-moonW*0,0,moonH*1.5), right, up, moonW*3, moonH*2, _matTxt, moonCol, moonRot)
    _drawRope(pivot, ropeEnd, right, ropt)
	local flicker = 0.85 + math.sin(t*8.1)*0.08 + math.sin(t*14.3)*0.04
	render.SetMaterial(_matGlow)
	render.DrawSprite(lPos, lanternGlowSz*(1+flicker*0.3), lanternGlowSz*(1+flicker*0.3),Color(lanternGlowC.r, lanternGlowC.g, lanternGlowC.b,math.floor(lanternGlowC.a*flicker)))
    _drawBillboard(lPos, right, up, lanternW, lanternH,_matLantern, lanternCol, s.ang or 0)
end
function A_AM.ActMod.MoonLantern3D.Push(key, force)
    if _state[key] then _state[key].vel = _state[key].vel + math.rad(force or 20) end
end
function A_AM.ActMod.MoonLantern3D.Reset(key, angle)
    if _state[key] then _state[key].ang = math.rad(angle or 30) _state[key].vel = 0 end
end



A_AM.ActMod.LuaFon_Done = true