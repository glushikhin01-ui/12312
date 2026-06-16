--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

local weight = (...).weight or function(w) return w end
local height = (...).height or function(h) return h end
local ModelPanel = (...).ModelPanel
local ub_findByIGSid = (...).find
local FixCam = (...).FixCam
local divColor = (...).divColor

local lastTick = 0
local function PlayTick( )
	if lastTick > CurTime( ) - 0.05 then
		return
	end
	lastTick = CurTime( )
	LocalPlayer( ):EmitSound("ub_tick.wav")
end


local UpgradePage = {}
UpgradePage.Base = "EditablePanel"

surface.CreateFont( "opencase_superbig", {
	font = "Open Sans Semibold",
	size = 70,
	weight = 8000,
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
	extended = true
} )
surface.CreateFont( "opencase_supermedium", {
	font = "Open Sans Semibold",
	size = 50,
	weight = 8000,
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
	extended = true
} )

function UpgradePage:CreatePoly(x, y, radius, percent, angle)
	local poly = {}

	local radius = radius

	table.insert(poly, { x = x, y = y })

	local scale = ((percent/100) * 360)

	for i = 0, 90 do
		local a = math.rad((i / 90) * -scale) + math.rad( 180 - (angle or 0) )
		table.insert(poly, {
			x = x + math.sin(a) * radius,
			y = y + math.cos(a) * radius
		})
	end

	local a = math.rad(0)
	--table.insert(poly, { x = x + math.sin(a) * radius, y = y + math.cos(a) * radius })
	return poly
end
function UpgradePage:DrawTriangle( w, h, ang )
	local rad = math.rad( 270 + ang )
	local size = 20
	local space = 8

	local triangle = {
		{x = w + w * math.cos( rad ) + math.cos( rad ) * space, y = h + h * math.sin( rad ) + math.sin( rad ) * space},
		{x = w + (w + size/2) * math.cos( rad ) + math.sin( rad ) * size/3 + math.cos( rad ) * space, y = h + (h + size/2) * math.sin( rad ) - math.cos( rad ) * size/3 + math.sin( rad ) * space},
		{x = w + (w + size/2) * math.cos( rad ) - math.sin( rad ) * size/3 + math.cos( rad ) * space, y = h + (h + size/2) * math.sin( rad ) + math.cos( rad ) * size/3 + math.sin( rad ) * space},
	}

	surface.DrawPoly( triangle )
end
UpgradePage.IsMoney = false
UpgradePage.Chance = 0
UpgradePage.Items = {} -- init table
function UpgradePage:SetIsMoney( b )
	if self.IsMoney == b then
		return
	end
	self.IsMoney = b
	self.LeftLayout:SetVisible( !b )
	self.MoneySelector:SetVisible( b )
end
function UpgradePage:Init( )
	self.Items = {}
	self.Chance = 0
	self.IsMoney = false
	local custom_vector = Vector( 1, 1, 1 )


	// Control buttons
	self.ControlFrame = vgui.Create( "EditablePanel", self )
	self.ControlFrame.Paint = function( self, w, h )
		--draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 100, 100 ) )
	end
	do // Buttons;
		local start = vgui.Create( "DButton", self.ControlFrame )
		start:SetPos(0,0)
        start:SetSize(weight(100),height(40))
		start:SetText ""
		start.PerformLayout = function( self, w, h )
			start.Triangle = {
				{x = weight(12), y = h/4},
				{x = weight(28), y = h/2},
				{x = weight(12), y = h-h/4},
			}
		end
		start.Paint = function( self, w, h )
			if not self.Triangle then return end
			draw.RoundedBox( 8,0,0,w,h,Color(161,104,255) )

			surface.SetDrawColor( 255, 255, 255 )
			draw.NoTexture( )
			surface.DrawPoly( self.Triangle )

			draw.SimpleText( "СТАРТ", "MM_16", weight(32), h/2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
		start.DoClick = function( s )
			local left, right = self:GetLeft( ), self:GetRight( )

			if not left or not right then
				return
			end

			local left_item = self.Items[ left ]
			local right_item = self.RightLayout.Items[ right ]

			if (not left_item and not self.IsMoney) or not right_item then return end

			if self.IsMoney then
				if left <= 0 then
					return
				end
			else
				if right_item.uid == left_item.uid then
					return
				end
			end

			LocalPlayer( ):EmitSound( "buttons/lever7.wav" )

			net.Start( "StartClientUpgradeAnimation" )
				net.WriteString( right_item.uid )
				if self.IsMoney then
					net.WriteBool( false )
					net.WriteUInt( left, 32 )
				else
					net.WriteBool( true )
					net.WriteString( left_item.uid )
					net.WriteString( left_item.id )
					net.WriteBool( left_item.isInventory )
				end
			net.SendToServer( )

			--self:DoSpin( math.random() <= 0.5 )
		end

		-- local ButtonColor = Color( 0, 152, 226 )

		-- local storage = vgui.Create( "DButton", self.ControlFrame )
		-- storage:Dock( TOP )
		-- storage:SetTall( 50 )
		-- storage:DockMargin( 0, 5, 0, 5 )
		-- storage:SetText ""
		-- storage.Paint = function( s, w, h )
		-- 	if not self.IsMoney then
		-- 		--draw.RoundedBox( 0, 0, 0, w, h, frameColor )
		-- 		surface.SetDrawColor( ButtonColor.r, ButtonColor.g, ButtonColor.b, 50 )
		-- 		surface.DrawOutlinedRect( 0, 0, w, h, 2 )
		-- 	else
		-- 		draw.RoundedBox( 0, 0, 0, w, h, s:IsDown() and divColor( ButtonColor, 1.5 ) or s:IsHovered() and divColor( ButtonColor, 1.2 ) or ButtonColor )
		-- 	end

		-- 	draw.SimpleText( "СКЛАД", "ub2_3", w/2, h/2, self.IsMoney and Color( 255, 255, 255 ) or Color(ButtonColor.r, ButtonColor.g, ButtonColor.b, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		-- end
		-- storage.DoClick = function( s )
		-- 	if BUC2.buttonsLocked then return end
		-- 	if not self.IsMoney then
		-- 		return
		-- 	end
		-- 	self:SetIsMoney( false )
		-- 	self:SetLeft( false )
		-- end

		-- local cash = vgui.Create( "DButton", self.ControlFrame )
		-- cash:Dock( TOP )
		-- cash:SetTall( 50 )
		-- cash:DockMargin( 0, 5, 0, 5 )
		-- cash:SetText ""
		-- cash.Paint = function( s, w, h )
		-- 	if self.IsMoney then
		-- 		--draw.RoundedBox( 0, 0, 0, w, h, frameColor )
		-- 		surface.SetDrawColor( ButtonColor.r, ButtonColor.g, ButtonColor.b, 50 )
		-- 		surface.DrawOutlinedRect( 0, 0, w, h, 2 )
		-- 	else
		-- 		draw.RoundedBox( 0, 0, 0, w, h, s:IsDown() and divColor( ButtonColor, 1.5 ) or s:IsHovered() and divColor( ButtonColor, 1.2 ) or ButtonColor )
		-- 	end

		-- 	draw.SimpleText( "БАЛАНС", "ub2_3", w/2, h/2, self.IsMoney and Color(ButtonColor.r, ButtonColor.g, ButtonColor.b, 50) or Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		-- end
		-- cash.DoClick = function( s )
		-- 	if BUC2.buttonsLocked then return end
		-- 	if self.IsMoney then
		-- 		return
		-- 	end
		-- 	self:SetIsMoney( true )
		-- 	self:SetLeft( 0 )
		-- end
	end
	local function CreateItemPanel( )
		local Item = vgui.Create( "DModelPanel", self )
		AccessorFunc( Item, "m_BackgroundColor", "BackgroundColor" )
		Item:SetBackgroundColor( Color( 255, 255, 255 ) )
		Item.LayoutEntity = function()end

		for i = 0, 5 do
			Item:SetDirectionalLight( i, Color( 255, 255, 255 ) )
		end
		Item.Set = function( self, id )
			if not id then
				self:SetModel("")
				return
			else
				self.Selected = true
			end

			local cfg = BUC2.ITEMS[ id ]
			if not cfg then
				if tonumber( id ) then
					cfg = {
						color = Color( 0, 139, 207 ),
					}
				else
					return
				end
			end
			self.IsMoney = !cfg.model

			self:SetBackgroundColor( cfg.color )
			if self.IsMoney then
				self.Money = tonumber(id) or 0
			else
				self:SetModel( cfg.model )
				FixCam( self )
				self:SetFOV( 90 )
			end
		end

		return Item
	end

	self.SpinPanel = vgui.Create( "EditablePanel", self )

	self.SpinPanel.ResultAngle = 0

	self.SpinPanel.Angle = 0
	self.SpinPanel.Mode = true


	self.SpinPanel.PerformLayout = function( spin, w, h )
		spin.MainCircle = self:CreatePoly( w/2, h/2, h/2 - 3, 100 )
		spin.OutlineCircle = self:CreatePoly( w/2, h/2, h/2, 100 )
		spin.Triangle = {
			{x = w/2, y = -8},
			{x = w/2 - 6, y = -16},
			{x = w/2 + 6, y = -16},
		}
	end
	self.SpinPanel.DoSpin = function( spin, isWin )
		spin.Angle = -360 * 20 // four spins before result

		local result_angle = 10

		if spin.Mode then
			spin.ResultAngle = (isWin and math.random( 0, self.Chance ) or math.random( self.Chance + 1, 99 )) / 100 * 360
		else
			spin.ResultAngle = (isWin and math.random( -self.Chance, 0 ) or math.random( 1, 100 - self.Chance - 1 )) / 100 * 360
		end
	end
	self.SpinPanel.Paint = function( spin, w, h )
		local x,y = spin:LocalToScreen( )
		draw.SimpleText( "Шанс", "MM_16", w/2, 3*h/8, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( self.Chance .. "%", "MM_22", w/2, 3*h/8+height(24), Color( 161, 104, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )


		if spin.ResultAngle - spin.Angle > 0.3 then
			//print('FIRST RESULT')
			local distance = spin.ResultAngle - spin.Angle
			local speed = distance > 500 and 30 or distance > 100 and 10 or 1
			if spin.Mode then
				local ang = math.abs(spin.Angle % 360)
				if self.lastTick ~= 1 and ang <= speed then
					self.lastTick = 1
					PlayTick( )
				end
				if self.lastTick ~= 2 and math.abs( self.Chance / 100 * 360 - ang ) <= speed then
					self.lastTick = 2
					PlayTick( )
				end
			else
				print('SECOND RESULT')
				local ang = math.abs(spin.Angle % 360)
				if self.lastTick ~= 1 and math.abs(ang - self.Chance / 100 * 360 * 2) <= speed then
					self.lastTick = 1
					PlayTick( )
				end
				if self.lastTick ~= 2 and ang <= speed then
					self.lastTick = 2
					PlayTick( )
				end
				--draw.SimpleText( ang, "DermaLarge", w/2, h/2, Color( 255, 255, 255 ) )
			end
			spin.Angle = Lerp( 0.01, spin.Angle, spin.ResultAngle )
		else
			if spin.Angle != spin.ResultAngle then
				LocalPlayer():EmitSound("buttons/lever6.wav")
				spin.Angle = 0
				spin.ResultAngle = 0
				if not self.IsMoney then
					net.Start( "SpinEnded" )
						net.WriteBool( false )
					net.SendToServer( )
					self:SetLeft( false )
					self:Update( )
				end
				buttonsLockeds = false
			end
		end

		local radius = ScrH()/4 + 4
		Progress = self:CreatePoly( w/2, h/2, h/2, self.Chance, spin.Mode and 0 or spin.Angle )


		draw.NoTexture( )

		render.ClearStencil()
			render.SetStencilEnable(true)

				render.SetStencilWriteMask(1)
				render.SetStencilTestMask(1)

				render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
				render.SetStencilPassOperation(STENCILOPERATION_ZERO)
				render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
				render.SetStencilReferenceValue(1)

				surface.SetDrawColor( 255, 255, 255 )
				surface.DrawPoly( spin.MainCircle )

				render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
				render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
				render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NOTEQUAL)
				render.SetStencilReferenceValue(1)

				--spin.avatar:PaintManual()
				surface.SetDrawColor( 161, 104, 255 )
				surface.DrawPoly( Progress )

				surface.SetDrawColor( 50, 50, 50 )
				surface.DrawPoly( spin.OutlineCircle )

			render.SetStencilEnable(false)
		render.ClearStencil()


		surface.SetDrawColor( 161, 104, 255 )
		if spin.Mode then
			DisableClipping( true )
				self:DrawTriangle( w/2, h/2, spin.Angle )
			DisableClipping( false )
		else
			DisableClipping( true )
				surface.DrawPoly( spin.Triangle )
			DisableClipping( false )
		end
	end

	self.LeftItem = CreateItemPanel( )
	self.LeftItem:Set( false )
	self.RightItem = CreateItemPanel( )
	self.RightItem:Set( false )

	self:CreateSelectors()
end
function UpgradePage:Append( uid, id, isInventory )
	if not uid then return end
	local found = ub_findByIGSid( uid )
	if found then
		local ITEM = IGS.GetItemByUID( uid )
		-- PrintTable(ITEM)
		if not ITEM or ITEM.isnull or ITEM.price <= 0 then return end
		table.insert( self.Items, {
			name = found,
			mdlsd = ITEM.icon.icon,
			price = ITEM.price,
			uid = uid,
			id = id,
			isInventory = isInventory
		} )
	end
end
function UpgradePage:ShowItems( ) // Force left-selector to recreate layout
	local layout = self.LeftLayout
	if not IsValid( layout ) then return end

	layout:Clear( )

	for i, item in SortedPairsByMemberValue( self.Items, "price", true ) do
		local model = vgui.Create('DButton')
		self.Items[ i ].panel = model
		model:SetPos( 0, 0 )
		model:SetSize( weight(95)*1.3, height(95)*1.3 )
		model.data = item
		model.i = i
		model:SetText('')
		model.Enabled = true
		-- model:Set( item.name )
		model:SetMouseInputEnabled( true )
		model.DoClick = function( s )
			if not s.Enabled then return end
			self:SetLeft( i )
		end
		model.Paint = function(self,w,h)
			draw.RoundedBox(10,0,0,w,h,Color(255,255,255,20))
			draw.RoundedBox(10,weight(1),height(1),w-weight(2),h-height(2),Color(41,38,66))
		end
		model.SetEnabled = function( s, b )
			s.Enabled = b
			if b then
				s.PaintOver = nil
			else
				s.PaintOver = function( s, w, h )
					draw.RoundedBox( 10, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
				end
			end
		end
		if item.mdlsd then
			local mdl = vgui.Create('ModelImage', model)
			mdl:SetSize( weight(55)*1.3, height(55)*1.3 )
			mdl:SetPos( model:GetWide() / 2 - weight(55)*1.3 / 2, model:GetTall() / 2 - height(50)*1.3 / 2 )
			mdl:SetModel( item.mdlsd or 'models/Items/item_item_crate.mdl' )
			mdl:SetTooltip()
			mdl:SetMouseInputEnabled(false)
			mdl.DoClick = function() 
				return
			end
		end
		layout:Add( model )
	end
end
function UpgradePage:Update( )

	/*IGS.GetInventory(function( inventory ) -- Can upgrade purchases?
		if not IsValid( self ) then return end
		local i = 0
		IGS.GetMyPurchases( function( purchases )
			if not IsValid( self ) or not purchases then return end
			--local serverID = IGS.SERVERS:ID()
			self.Items = {}
			self:SetLeft( false )

			local i = 0
			for k,v in pairs( purchases ) do
				--[[ if v.server != serverID then
					continue
				end--]] 
				if not BUC2.UpgradeFromItems[ v.item ] then continue end
				i = i + 1
				self:Append( v.item, v.id )
			end
			for k,v in pairs( inventory ) do
				if not BUC2.UpgradeFromItems[ v.item.uid ] then continue end
				i = i + 1
				self:Append( v.item.uid, v.id, true )
			end
			self:ShowItems( )
		end )
	end)*/

	IGS.GetInventory( function( inventory ) -- Can upgrade purchases?
		if not IsValid( self ) or not inventory then return end
		self.Items = {}
		self:SetLeft( false )
		for k,v in pairs( inventory ) do
			if not BUC2.UpgradeFromItems[ v.item.uid ] then continue end
			self:Append( v.item.uid, v.id, true )
		end
		self:ShowItems( )
	end )

end
function UpgradePage:CreateSelectors()

	self.LeftScroll = vgui.Create( "DScrollPanel", self )
	self.LeftScroll.VBar:SetWide(0)
	self.LeftScroll.Paint = function(self,w,h)
	end
	local spacing = height(5)


	local LeftLayout = vgui.Create( "DIconLayout", self.LeftScroll )
	self.LeftLayout = LeftLayout
	LeftLayout:SetLayoutDir( TOP )
	LeftLayout:Dock( TOP )
	LeftLayout:SetBorder( 6 )
	LeftLayout:SetSpaceY( spacing )
	LeftLayout:SetSpaceX( spacing )

	self:Update( )


	local MoneySelector = vgui.Create( "EditablePanel", self.LeftScroll )
	self.MoneySelector = MoneySelector
	MoneySelector:SetPos( 0, 0 )
	MoneySelector:SetTall( 150 )
	MoneySelector:SetVisible( false )
	do
		local Wang = vgui.Create("DNumberWang", MoneySelector)
		Wang:Dock( TOP )
		Wang:SetTall( 40 )
		Wang:SetFont( "ub2_3" )
		Wang:SetValue( 1 )
		Wang:SetMin(1)
		Wang:SetMax( 999999 )
		Wang:DockMargin( 5, 5, 5, 5 )
		Wang.OnValueChanged = function( s )
			if buttonsLockeds then
				s.Think = function( s )
					if buttonsLockeds then return end
					s:OnValueChanged( )
					s.Think = nil
				end
				return
			end
			local x = tonumber(s:GetValue( ))
			x = math.min( x, 999999 )
			self:SetIsMoney( true )
			self:SetLeft( x )
			self:RecalculateChance( )
		end
		local old = Wang.Paint
		Wang.Paint = function( self, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, Color( 26, 26, 26 ) )
			old( self, w, h )
		end
		Wang:SetTextColor( Color( 255, 255, 255 ) )
		Wang:SetPaintBackground( false )
		Wang:SetCursorColor( Color( 255, 255, 255 ) )
		Wang:SetUpdateOnType( true )

		local btn = vgui.Create( "EditablePanel", MoneySelector )
		btn:Dock( TOP )
		btn:SetTall( 40 )
		btn:DockMargin( 5, 5, 5, 5 )
		btn.Color = Color( 27, 151, 223 )
		btn.Paint = function( self, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, self.Color )
			draw.SimpleText( "СДЕЛАТЬ СТАВКУ", "ub2_3", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end
	


	self.RightScroll = vgui.Create( "DScrollPanel", self )
	self.RightScroll.VBar:SetWide(0)

	local RightLayout = vgui.Create( "DIconLayout", self.RightScroll )
	self.RightLayout = RightLayout
	RightLayout:SetLayoutDir( TOP )
	RightLayout:Dock( TOP )
	RightLayout:SetBorder( 6 )
	RightLayout:SetSpaceY( spacing )
	RightLayout:SetSpaceX( spacing )

	// Load inventory:
	RightLayout.Items = {} -- init table
	RightLayout.ShowItems = function( s )
		s:Clear( )
		for i, item in SortedPairsByMemberValue( s.Items, "price", true ) do
			local model = vgui.Create('DButton')
			model:SetPos( 0, 0 )
			model:SetSize( weight(95)*1.3, height(95)*1.3 )
			model.data = item
			model.i = i
			model:SetText('')
			model.Enabled = true

			model:SetMouseInputEnabled( true )
			model.DoClick = function( s )
				self:SetRight( i )
			end
			model.Paint = function(self,w,h)
				draw.RoundedBox(10,0,0,w,h,Color(255,255,255,20))
				draw.RoundedBox(10,weight(1),height(1),w-weight(2),h-height(2),Color(41,38,66))
			end
			model.SetEnabled = function( s, b )
				s.Enabled = b
				if b then
					s.PaintOver = nil
				else
					s.PaintOver = function( s, w, h )
						draw.RoundedBox( 10, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
					end
				end
			end
			if BUC2.ITEMS[item.name].model then
				local mdl = vgui.Create('ModelImage', model)
				mdl:SetSize( weight(55)*1.3, height(55)*1.3 )
				mdl:SetPos( model:GetWide() / 2 - weight(55)*1.3 / 2, model:GetTall() / 2 - height(50)*1.3 / 2 )
				mdl:SetModel( BUC2.ITEMS[item.name].model or 'models/Items/item_item_crate.mdl' )
				mdl:SetTooltip()
				mdl:SetMouseInputEnabled(false)
				mdl.DoClick = function() 
					return
				end
			end
			RightLayout:Add( model )
		end
	end
	function RightLayout:Append( id, isInventory )
		if not id then return end
		local found = ub_findByIGSid( id )
		if found then
			local igs = IGS.GetItemByUID( id )
			if not igs or igs.price == 0 then return end
			table.insert( self.Items, {
				name = found,
				price = igs.price,
				uid = id,
			} )
		end
	end
	for id, v in pairs( BUC2.UpgradeToItems ) do
		RightLayout:Append( id )
	end
	RightLayout:ShowItems( )
end
function UpgradePage:DoSpin( bool )
	self.SpinPanel:DoSpin( bool )
end

function UpgradePage:GetLeft( )
	return self.Left
end
function UpgradePage:SetLeft( i )
	if not i or self.IsMoney then
		self.Left = i
		self.LeftItem:Set( i )

		local prev = self.Items[ self:GetLeft( ) or -1 ]
		if prev and IsValid( prev.panel ) then
			prev.panel:SetEnabled( true )
		end

		return
	end

	local data = self.Items[ i ]
	if not data then return end
	if not IsValid( data.panel ) then return end

	local prev = self.Items[ self:GetLeft( ) or -1 ]
	if prev and IsValid( prev.panel ) then
		prev.panel:SetEnabled( true )
	end

	data.panel:SetEnabled( false )
	self.Left = i

	self.LeftItem:Set( data.name )

	self:RecalculateChance( )
end
function UpgradePage:SetRight( i )
	if not i or self.IsMoney then
		self.Right = i
		self.RightItem:Set( i )

		local prev = self.Items[ self:GetLeft( ) or -1 ]
		if prev and IsValid( prev.panel ) then
			prev.panel:SetEnabled( true )
		end

		return
	end
	
	local layout = self.RightLayout

	if not IsValid( layout ) then return end
	local data = layout.Items[ i ]

	local prev = layout.Items[ self:GetRight( ) or -1 ]
	if prev and IsValid( prev.panel ) then
		prev.panel:SetEnabled( true )
	end

	-- data.panel:SetEnabled( false )

	self.RightItem:Set( data.name )
	self.Right = i

	self:RecalculateChance( )
end

function UpgradePage:GetRight( )
	return self.Right
end

function UpgradePage:RecalculateChance( )
	local left, right = self:GetLeft( ), self:GetRight( )

	if not left or not right then
		self.Chance = 0
	end

	local left_item = self.IsMoney and {price = left} or self.Items[ left ]
	local right_item = self.RightLayout.Items[ right ]

	if not left_item or not right_item then return end

	self.Chance = math.Round( math.Clamp( left_item.price / right_item.price, 0, 1 ), 3 ) * 100

end
function UpgradePage:Paint( w, h )
	--draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0 ) )
end
function UpgradePage:PerformLayout( w, h )
	// Main Animation
	self.SpinPanel:SetSize( w / 5, w / 5 )
	self.SpinPanel:SetPos( w/2 - self.SpinPanel:GetWide()/2, 0 )


	// Items
	self.LeftItem:SetSize( w / 3.7, w / 3.7 )
	self.LeftItem:SetPos( w/5 - self.LeftItem:GetWide()/2, -10 )

	self.RightItem:SetSize( w / 3.7, w / 3.7 )
	self.RightItem:SetPos( w * 4/5 - self.RightItem:GetWide()/2, -10 )


	// Control Buttons:
	local x,y = self.SpinPanel:GetPos( )
	local wide = self.SpinPanel:GetWide( )
	self.ControlFrame:SetPos( x + (wide - wide/1.5)/1.5, y + w/5 + 15 )
	self.ControlFrame:SetSize( weight(100), h - (h/3.5 - self.SpinPanel:GetTall()/2 + w/5 - 15) )


	// do Selectors
	local SelectorsWide = x + (wide - wide/1.5)/2 - 5
	local x,y = self.RightItem:GetPos( )
	local SelectorsY = y + self.RightItem:GetTall( ) - 16
	local tall = self.LeftItem:GetTall( )

		// Left Selector:
		self.LeftScroll:SetPos( 0, height(200) )
		self.LeftScroll:SetSize( SelectorsWide, h - SelectorsY )
		self.MoneySelector:SetWide( SelectorsWide )

		// Right Selector
		self.RightScroll:SetPos( weight(550), height(200) )
		self.RightScroll:SetSize( SelectorsWide, h - SelectorsY )
end

return UpgradePage

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
