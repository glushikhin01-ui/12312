--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

surface.CreateFont( "TargetID", {
	font = "Roboto Lt",
	size = 23,
	weight = 600,
	antialias = true,
	extended = true,
	outline = false,
})

surface.CreateFont( "ChatLine", {
	font = "Roboto Lt",
	size = 23,
	weight = 600,
	antialias = true,
	extended = true,
	outline = false,
})

local surface_DrawText = surface.DrawText
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize
local surface_SetAlphaMultiplier = surface.SetAlphaMultiplier
local surface_SetTextColor = surface.SetTextColor
local surface_SetTextPos = surface.SetTextPos
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_SimpleText = draw.SimpleText
local draw_Blur = draw.Blur


function ba.LoadSingleEmote(em)

	if (not istable(em)) then return end



	em.matloading = true



	texture.Create('Chat_Emote_' .. em.name)

		:EnableProxy(true)

		:SetSize(64, 64)

		:Download(em.loadUrl, function(self, mat)

			em.mat = mat

			em.matloading = false

		end)

end



local function ParseForEmotes(...)

	local data = {...}



	if (ba.chatEmotes) then

		local k = 0

		for k, v in ipairs(data) do

			if istable(v) then

				local first = true

				local shouldgoto

				for m, n in pairs(v) do

					if (shouldgoto and m < shouldgoto) then

						continue

					elseif (shouldgoto) then

						shouldgoto = nil

					end

					if (isstring(n) and (!first or n[1] == ":")) then

						first = nil



						local earliest = math.huge

						local emote

						for i, l in pairs(ba.chatEmotes) do

							local pos = string.find(n, i, 1, true)

							if (pos and pos < earliest) then

								earliest = pos

								emote = i

							end

						end



						if (emote) then

							local repwith = n:sub(1, earliest-1)

							local add = n:sub(earliest+#emote)

							local em = ba.chatEmotes[emote]



							if (!em.mat and !em.matloading) then

								ba.LoadSingleEmote(em)

							end



							data[k][m] = repwith

							table.insert(data[k], m+1,add)

							table.insert(data[k], m+1, em)



							shouldgoto = m + 2

						end

					end

				end

			end

		end

	end



	return data

end

function ba.CreateChatBox()
	if !IsValid(LocalPlayer()) then return end
	local frame = vgui.Create('ba_chatbox')
	-- frame:AddMessage({ui.col.SUP, '| ', Color(255, 255, 255), 'Добро пожаловать на ', ui.col.SUP, 'JustRP!'})

	return frame
end

local LABEL = {}
function LABEL:Init()
	self._Colors = {}
	self._Emotes = {}
	self._Text = ''
	self._SelStart = 0
	self._SelEnd = 0
	self._SelText = ''
	self._Bits = {}

	self.Expire = SysTime() + 15
	self.Created = SysTime()

	self:SetText('')
end

function LABEL:SizeToContents()
	surface_SetFont("TargetID")

	local w, h = 0, 30
	for i = 1,utf8_len(self._Text) do
		if (self._Emotes[i]) then

			if (h < 16) then h = 16 end

			table.insert(self._Chars, {'', w, 16})

			w = w + 16

		else
			local char = utf8_sub(self._Text, i,i)
			local wid, th = surface_GetTextSize(char)
			if (h < th) then h = th end

			if (self._Text[i] == '&') then wid = 12 end
			table.insert(self._Chars, {char, w, wid})
			w = w + wid
		end
	end

	self:SetSize(w, h)
end

function LABEL:SetText(val)
	self._Text = val
	self._Bits = {}

	self._Chars = {}

	surface_SetFont("TargetID")

	self:SizeToContents()
end

function LABEL:AddColor(Pos, Col)
	self._Colors[Pos] = Col
	self._Bits = {}
end

function LABEL:AddEmote(Pos, Emote)
	self._Emotes[Pos] = Emote
	self._Bits = {}
end

function LABEL:Think()
	self._SelText = ''

	local x1 = nil
	local x2 = nil

	if (self._SelStart != 0 or self._SelEnd != 0) then
		local endx
		for k, v in ipairs(self._Chars) do
			if (self._SelStart <= v[2] + v[3] and self._SelEnd >= v[2] + v[3]) then
				self._SelText = self._SelText .. v[1] .. ((k == #self._Chars) and '\n' or '')
				v.Sel = true

				if (!x1) then x1 = v[2] end
			else
				v.Sel = false

				if (x1 and !x2) then x2 = v[2] - x1 end
			end
			endx = v[2] + v[3]
		end
		if (x1 and !x2) then x2 = endx - x1 end
	end

	self._HighX1 = x1
	self._HighX2 = x2

	if (!self._Bits[1]) then
		local lastcol = Color(0, 0, 0)
		local lastpos = 1
		local str = ''

		for k, v in ipairs(self._Chars) do
			if (self._Colors[k]) then
				str = utf8_sub(self._Text, lastpos, k - 1)

				table.insert(self._Bits, {str, self._Chars[lastpos][2], lastcol})

				lastpos = k

				lastcol = self._Colors[k]
			end

			if (self._Emotes[k]) then

				str = utf8_sub(self._Text, lastpos, k - 1)


				table.insert(self._Bits, {str, self._Chars[lastpos][2], lastcol})



				if (self._Chars[k-1]) then

					table.insert(self._Bits, {'', self._Chars[k-1][2] + self._Chars[k-1][3], lastCol, Emote = self._Emotes[k]})

				else

					table.insert(self._Bits, {'', 0, lastCol, Emote = self._Emotes[k]})

				end



				lastpos = k+1


			end

		end

		if (self._Text[lastpos] and self._Chars[lastpos]) then
			str = utf8_sub(self._Text, lastpos)

			table.insert(self._Bits, {str, self._Chars[lastpos][2], lastcol})
		end
	end
end

function LABEL:GetSelText()
	return self._SelText or ''
end

local blk = Color(0, 0, 0, 255)
function LABEL:Paint(w, h)
	if (CHATBOX and CHATBOX.ShouldDraw == false) then return true end
	if (SysTime() > self.Expire) and (CHATBOX and !CHATBOX._Open) then return true end

	local fin = math.Clamp((SysTime() - (self.Expire - 15)) / .25, 0, 1)
	if (!CHATBOX._Open and fin == 1) then
		-- calc alpha and override mul
		local a = 1 - (math.Clamp((SysTime() - self.Expire) + 2, 0, 2) / 2)
		surface_SetAlphaMultiplier(a)
	else
		surface_SetAlphaMultiplier(fin)
	end

	if (self._HighX1 and self._HighX2) then
		surface_SetDrawColor(200, 200, 200, 100)
		surface_DrawRect(self._HighX1, 0, self._HighX2, h)
	end

	for k, v in ipairs(self._Bits) do
		-- if (v.Emote) then

		-- 	-- if (v.Emote.mat) then

		-- 	-- 	surface.SetDrawColor(255, 255, 255)

		-- 	-- 	surface.SetMaterial(v.Emote.mat)

		-- 	-- 	--surface_DrawTexturedRect(v[2], (h - 16) * 0.5, 16, 16)

		-- 	-- 	surface.DrawTexturedRect(v[2], 0, h, h)

		-- 	-- end

		-- else
		v[3].a = math.Clamp((SysTime() - self.Created) * 2, 0, 1) * 255
		local copy = v[1]:Trim():Replace(']', ''):Replace('[', '')
		if rp.Label[copy] then
			if v[3].r ~= 250 then
				self._Bits[k][1] = copy
				self._Bits[k][3].r,self._Bits[k][3].g,self._Bits[k][3].b = 250,250,250
			end
			surface.SetFont('TargetID')
			local tx, ty = surface.GetTextSize(v[1])
			draw.RoundedBox(6, v[2], (h==16 and 1 or 0), tx+8,ty, rp.Label[v[1]])
		end
		local v2 = v[2]+2
		draw_SimpleTextOutlined(v[1], "TargetID", v2 + 1, ((h == 16 and 1) or 0), v[3], 0, 0, 0.5, blk)

		-- end
	end

	return true
end
derma.DefineControl('ba_chatlabel', 'Badmin Chatbox Label', LABEL, 'DLabel')

local PANEL = {}

function PANEL:OnMouseReleased(b)
	self.Selecting = nil
end

function PANEL:Init()
	local w,h =chat.GetChatBoxSize(true)
	self:SetSize(w,h)
	self:SetPos(chat.GetChatBoxPos())

	self.ShouldDraw = true

	self._Open = false
	self._Messages = {}
	self._Team = false

	self.History = {}
	self.AutoNames = {}
	self.CurrentAutoName = 0

	-- self.btnResize = vgui.Create('Panel', self)
	-- self.btnResize:SetCursor('sizenesw')
	-- self.btnResize.OnMousePressed = function(s, mb)
	-- 	-- if (mb == MOUSE_LEFT) then
	-- 	-- 	self.Resizing = true
	-- 	-- end
	-- end

	self.msgFrame = vgui.Create('ui_scrollpanel', self)
	self.msgFrame:HideScrollbar(true)
	self.msgFrame:SetScrollSize(2)
	self.msgFrame:SetSkin('SUP')

	self.OvermsgFrame = vgui.Create('Panel', self)

	self.OvermsgFrame.Think = function(s)
		local y = 0
		local off = math.abs(self.msgFrame.yOffset)
		local mouseX, mouseY = gui.MouseX() - s.x - self.x, gui.MouseY() - s.y - self.y + self.msgFrame.yOffset
		local firstx, firsty, lastx, lasty
		local sTall = s:GetTall()
		local selectedText = {}
	
		if self.Selecting then
			if self.MouseDown[2] > mouseY then
				firstx, firsty = mouseX, mouseY
				lastx, lasty = self.MouseDown[1], self.MouseDown[2]
			else
				firstx, firsty = self.MouseDown[1], self.MouseDown[2]
				lastx, lasty = mouseX, mouseY
			end
		end
	
		local abs = math.abs
		local min, max = math.min, math.max
	
		for k, v in next, self._Messages do
			local vTall = v:GetTall()
			local vBottom = v.y + vTall
			local visible = y >= off - sTall and y <= off + sTall
	
			v:SetVisible(visible)
	
			if self.Selecting and visible then
				if firsty <= v.y and lasty > vBottom then
					v._SelStart, v._SelEnd = 0, v:GetWide()
				elseif firsty >= v.y and firsty < vBottom then
					if lasty > vBottom then
						v._SelStart, v._SelEnd = firstx, v:GetWide()
					else
						v._SelStart, v._SelEnd = min(firstx, lastx), max(firstx, lastx)
					end
				elseif lasty >= v.y and lasty < vBottom then
					if firsty <= v.y then
						v._SelStart, v._SelEnd = 0, lastx
					else
						v._SelStart, v._SelEnd = min(firstx, lastx), max(firstx, lastx)
					end
				else
					v._SelStart, v._SelEnd = 0, 0
				end
			else
				v._SelStart, v._SelEnd = 0, 0
			end
	
			if visible then
				selectedText[#selectedText + 1] = v:GetSelText()
			end
	
			y = y + vTall
		end
	
		self.SelectedText = table.concat(selectedText)
	end

	self.OvermsgFrame.OnMouseWheeled = function(s, ...)
		return self.msgFrame:OnMouseWheeled(...)
	end

	self.OvermsgFrame.OnMousePressed = function(s, b)
		local sb = self.msgFrame.scrollBar.scrollButton
		local sbx, sby = sb:CursorPos()

		if (sbx >= 0 and sbx <= sb:GetWide() and sby >= 0 and sby <= sb:GetTall()) then
			sb:OnMousePressed(b)
		else
			self.MouseDown = {gui.MouseX() - self.x - s.x, gui.MouseY() - self.y - s.y + self.msgFrame.yOffset}
			self.Selecting = true
		end
	end

	self.OvermsgFrame.OnMouseReleased = function(s, b)
		self.Selecting = false
	end

	self.txtEntry = vgui.Create('DTextEntry', self)
	self.txtEntry:SetPaintBackground(false)
	self.txtEntry:SetVisible(false)
	self.txtEntry:SetTextColor(color_white)
	self.txtEntry:SetCursorColor(color_white)
	-- self.txtEntry.Paint = function(self, w,h)
		-- derma.SkinHook( "Paint", "TextEntry", self, 2, h )
	-- end
	self.txtEntry.PaintOver = function(s, w, h)
		if (CHATBOX and CHATBOX.ShouldDraw == false) then return true end
		surface_SetFont('ui.18')

		-- local w, h = surface_GetTextSize(s:GetValue())
		-- surface_SetDrawColor(255,255,255,255)
		-- surface_SetTextColor(230,230,230)
		-- surface_SetTextPos(0, 0)
		-- surface_DrawText(s:GetText())

		if (!s.AutoFillText) then
			return 
		end

		-- surface_SetFont('ui.18')
		local x = surface_GetTextSize(s:GetValue())
		local w, h = surface_GetTextSize(s.AutoFillText)
		

		surface_SetDrawColor(s:GetHighlightColor() or ui.col.SUP)
		surface_DrawRect(x+4.5, h*.5, w, h+1)
		surface_SetTextColor(40,40,40)
		surface_SetTextPos(x+3, h*.5)
		surface_DrawText(s.AutoFillText)
	end

	self.txtEntry.OnKeyCodeTyped = function(s, c)
		if (c == KEY_TAB) or ((c == KEY_RIGHT) and (s:GetCaretPos() == utf8_len(s:GetValue()))) then
			self:DoAutoFill()
			s:OnTextChanged()
			s:SetCaretPos( utf8_len(s:GetValue()) )
		elseif (c == KEY_UP) then
			if (#self.AutoNames > 0) then
				local auto = self:GetAutoFill(1)
				s.AutoFillText = auto and auto.CompleteString or nil
			else
				if (self.History[s.historyPos + 1]) then
					s.historyPos = s.historyPos + 1
					s:SetText(self.History[s.historyPos])
					s:SetCaretPos(utf8_len(s:GetValue()))
				end
			end
		elseif (c == KEY_DOWN) then
			if (#self.AutoNames > 0) then
				local auto = self:GetAutoFill(1)
				s.AutoFillText = auto and auto.CompleteString or nil
			else
				if (self.History[s.historyPos - 1] or s.historyPos - 1 == 0) then
					s.historyPos = s.historyPos - 1
					s:SetText(self.History[s.historyPos] or '')
					s:SetCaretPos( utf8_len(s:GetValue()) )
				end
			end
		elseif (c == KEY_ENTER) then
			RunConsoleCommand('say' .. ((self._Team and '_team') or ''), s:GetValue())
			if (string.Trim(s:GetValue()) != '') then
				table.insert(self.History, 1, s:GetValue())
			end
			self:Close()
		elseif (c == KEY_ESCAPE) then
			self:Close()

			-- RunConsoleCommand('cancelselect')
		end
	end

	self.txtEntry.OnLoseFocus = function(s)
		if (input.IsKeyDown(KEY_TAB)) then
			s:RequestFocus()
			s:SetCaretPos( utf8_len(s:GetText()) )
		end
	end

	self.txtEntry.OnTextChanged = function(s)
		self:CalculateAutoFill()

		local auto = self:GetAutoFill()
		s.AutoFillText = auto and auto.CompleteString or nil

		if (s:AllowInput()) then
			s:SetValue(string.sub(s:GetValue(), 1, 120))
			s:SetCaretPos(120)
		end

		gamemode.Call('ChatTextChanged', s:GetValue())
	end

	self.txtEntry.AllowInput = function(s)
		if (string.len(s:GetValue()) >= 120) then
			surface.PlaySound('Resource/warning.wav')
			return true
		end
	end

	-- self.emotes = ui.Create('ui_button', self)

	-- self.emotes:SetText('')

	-- self.emotes:SetVisible(false)



	-- self.emotes.PaintOver = function(s, w, h)

	-- 	draw_SimpleText('☺', 'ui.29', 12, 9, ui.col.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) -- gettextsize doesnt work here

	-- end

	-- self.emotes.DoClick = function()

	-- 	if IsValid(self.emotesList) then

	-- 		self.emotesList:AddRecents()

	-- 		self.emotesList:SetVisible(not self.emotesList:IsVisible())

	-- 	else

	-- 		self.emotesList = ui.Create('ba_emotes_list', self)

	-- 	end

	-- end

	self:PerformLayout(self:GetWide(), self:GetTall())
end

function PANEL:OnKeyCodePressed(k)
	if (k == KEY_C) and (input.IsKeyDown(KEY_LCONTROL)) then
		if (self.SelectedText and self.SelectedText != '') then
			SetClipboardText(self.SelectedText)
		end
	end
end

function PANEL:PerformLayout(w,h)
	self.txtEntry:SetFont('ui.18')
	self.txtEntry:SetPos(5, h - 25 - 5)
	-- self.txtEntry:SetSize(w - 25 - 15, 36)
	self.txtEntry:SetSize(w+11,36)
	-- self.emotes:SetSize(25, 36)
	-- self.emotes:SetPos(w - 25 - 5, h - 25 - 5)

	-- if IsValid(self.emotesList) then
	-- 	self.emotesList:SetSize(185, 220)
	-- 	self.emotesList:SetPos(w - self.emotesList:GetWide() - 5, h - self.emotesList:GetTall() - 25 - 10)
	-- end

	-- self.btnResize:SetSize(5, 5)
	-- self.btnResize:SetPos(self:GetWide() - 5, 0)
	self.msgFrame:SetPos(5, 5)
	self.msgFrame:SetSize(self:GetWide() - 10, self.txtEntry.y - 10)
	self.OvermsgFrame:SetPos(5, 5)
	self.OvermsgFrame:SetSize(self:GetWide() - 10, self.txtEntry.y - 10)
end

function PANEL:Think()
	-- if (!self.Resizing) then return end
	-- if (!input.IsMouseDown(MOUSE_LEFT)) then
	-- 	cvar.SetValue('ChatboxSize', {self:GetWide(), self:GetTall()})
	-- 	self.Resizing = false
	-- 	return
	-- end

	-- local w = math.Clamp(gui.MouseX() - chat.GetChatBoxLeftBound(), 265, ScrW() - 23) + 3
	-- local h = math.Clamp(chat.GetChatBoxBottomBound() - gui.MouseY(), 155, ScrH() - 23) + 3

	-- if (x != self:GetWide() or h != self:GetTall()) then
	-- 	local newOff = self.msgFrame.yOffset
	-- 	if (h < self:GetTall()) then
	-- 		newOff = newOff + (self:GetTall() - h)
	-- 	end
	-- 	self:SetSize(w, h)
	-- 	self:SetPos(chat.GetChatBoxPos(w, h))
	-- 	self:InvalidateLayout(true)
	-- 	self.msgFrame:SetOffset(newOff)
	-- end
end

local colblack = Color(0, 0, 0)
local coloutline = Color(ui.col.Outline.r, ui.col.Outline.g, ui.col.Outline.b)
local colteamchat = Color(100, 200, 100)
local colglobalchat = Color(0, 0, 0)
function PANEL:Paint(w, h)
	self.ShouldDraw = hook.Call('HUDShouldDraw', GAMEMODE, 'Chatbox')
	if (!self.ShouldDraw) then return true end

	local a = 0
	if (self._OpenTime) then
		a = math.Clamp((SysTime() - self._OpenTime) / .25, 0, 1)
	elseif (self._CloseTime) then
		a = 1 - math.Clamp((SysTime() - self._CloseTime) / .25, 0, 1)
	end

	if (a == 0) then
		return
	end

	-- draw_Blur(self, a * 6)

	-- surface_SetDrawColor(0, 0, 0, 150 * a)
	-- surface_DrawRect(0, 0, w, h)

	-- coloutline.a = a * 255
	-- surface_SetDrawColor(coloutline)
	-- surface_DrawOutlinedRect(0, 0, w, h)

	local x, y, w, h = self.txtEntry.x - 2, self.txtEntry.y - 2, self.txtEntry:GetWide() + 4, self.txtEntry:GetTall() + 4

	-- colblack.a = a * 150
	-- surface_SetDrawColor(colblack)
	-- surface_DrawRect(x + 1, y + 1, w - 2, h - 2)

	colteamchat.a = a * 175
	colglobalchat.a = a * 175
	surface_SetDrawColor((self._Team and colteamchat) or colglobalchat)
	surface_DrawRect(x+2, y+2, w-4, h-4)
end

function PANEL:PaintOver(w, h)
end

function PANEL:AddMessage(...)
	local strings = ''
	local colors = {}
	local emotes = {}
	local emotesww = {}

	table.insert(colors, {Col=Color(200, 200, 200), Pos=1})

	local data = {...}--ParseForEmotes(...)

	for _,v in ipairs(data[1]) do
		if !v or v == '' then continue end


		if istable(v) and v.mat != nil then

			-- strings = strings .. '*'

			-- emotesww[emotes[table.insert(emotes, {Emote = v, Pos=utf8_len(strings)})].Pos] = true

		elseif (isstring(v) or isnumber(v)) then
			if (v[1] == '>') then
				table.insert(colors, {Col=Color(140, 200, 100), Pos=utf8_len(strings)})
			end
			strings = strings .. v
		elseif isplayer(v) then
			if (utf8_len(strings) == 0) then table.remove(colors, 1) end

			table.insert(colors, {Col=team.GetColor(v:Team()), Pos=utf8_len(strings) + 1})

			strings = strings .. v:Name()
		else
			if (utf8_len(strings) == 0) then table.remove(colors, 1) end
			table.insert(colors, {Col=v:Copy(), Pos=utf8_len(strings) + 1})
		end
	end

	local texts = string.Wrap("TargetID", strings, self.msgFrame:GetWide() - 5)

	local shouldPopDown
	if (self.msgFrame:IsAtMaxOffset()) then
		shouldPopDown = true
	end

	local cursnip = 1
	for k, v in ipairs(texts) do
		if (v == '') then continue end

		if (self._Messages[1000]) then self._Messages[1]:Remove() table.remove(self._Messages, 1) end

		local lbl = vgui.Create('ba_chatlabel', self.msgFrame:GetCanvas())
		lbl:SetFont("TargetID")

		table.insert(self._Messages, lbl)

		for i, l in ipairs(colors) do
			if (l.Pos <= cursnip and (!colors[i+1] or colors[i+1].Pos > cursnip)) then
				lbl:AddColor(1, l.Col)
			elseif (l.Pos >= cursnip and l.Pos < cursnip + utf8_len(v)) then
				lbl:AddColor(l.Pos - cursnip + 1, l.Col)
			end
		end

		for i, l in ipairs(emotes) do
			if (l.Pos >= cursnip and l.Pos < cursnip + #v) then
				lbl:AddEmote(l.Pos - cursnip + 1, l.Emote)
			end
		end
		-- lbl:DockMargin(2,10,2,2)
		lbl:SetText(v)
		self.msgFrame:AddItem(lbl)

		cursnip = cursnip + utf8_len(v)
	end

	chat.PlaySound()

	if (shouldPopDown) then
		self.msgFrame.yOffset = math.Clamp(self.msgFrame:GetCanvas():GetTall() - self.msgFrame:GetTall(), 0, math.huge)
	end

	self:InvalidateLayout()
end

function PANEL:CalculateAutoFill()

	local curSel = self.AutoNames[self.CurrentAutoName]



	table.Empty(self.AutoNames)



	local words = string.Explode(' ', self.txtEntry:GetValue())

	match = words[#words]



	if (!match or match == '') then

		self.CurrentAutoName = 0

		return

	end



	local isEmote = string.StartWith(match, ':')



	if (not isEmote) then

		for k, v in ipairs(player.GetAll()) do

			if ((string.find(v:Name():lower(), match:lower(), 1, true) or -1) == 1) then

				if (curSel and curSel.SteamID == v:SteamID()) then

					self.CurrentAutoName = #self.AutoNames + 1

				end



				self.AutoNames[#self.AutoNames + 1] = {

					Name = v:Name(),

					SteamID = v:SteamID()

				}

			end

		end

	end



	if isEmote then

		for k, v in pairs(ba.chatEmotes) do // do the hack

			if ((string.find(k:lower(), match:lower(), 1, true) or -1) == 1)  then

				self.AutoNames[#self.AutoNames + 1] = {

					Name = k,

					SteamID = k

				}

			end

		end

	end

end

function PANEL:GetAutoFill(step)
	step = step or 0

	local words = string.Explode(' ', self.txtEntry:GetValue())
	match = words[#words]
	if (!match or match == '') then return end

	self.CurrentAutoName = self.CurrentAutoName + step
	if (!self.AutoNames[self.CurrentAutoName]) then
		self.CurrentAutoName = (self.CurrentAutoName <= 0 and #self.AutoNames) or 1
	end

	local fillData = self.AutoNames[self.CurrentAutoName]

	if (fillData) then
		fillData.CompleteString = utf8_sub(fillData.Name, utf8_len(match) + 1)
	end

	return fillData
end

function PANEL:DoAutoFill()
	local pl = self:GetAutoFill()
	if (!pl) then return end

	local words = string.Explode(' ', self.txtEntry:GetValue())
	match = words[#words]
	if (!match or match == '') then return end

	local pref = utf8_sub(self.txtEntry:GetValue(), 1, 1)
	local fillVal

	local firstarg = utf8_sub(self.txtEntry:GetValue(), 1, (string.find(self.txtEntry:GetValue(), ' ')  or (utf8_len(self.txtEntry:GetValue()) + 1)) - 1)

	if (pref == '/' or pref == '!') and (firstarg != '//' and firstarg != '/ooc' and firstarg != '/ad' and firstarg != '/advert') and (!ret) then
		fillVal = pl.SteamID
	else
		fillVal = pl.Name
	end

	self.txtEntry:SetText(utf8_sub(self.txtEntry:GetValue(), 1, -(utf8_len(match) + 1)) .. fillVal .. ' ')
end

function PANEL:Open(tm)
	if (CHATBOX and CHATBOX.ShouldDraw == false) then return end -- Don't open if we can't draw!

	self._Open = true
	self._OpenTime = SysTime()
	self._CloseTime = nil

	self._Team = tm
	gamemode.Call('StartChat')

	self:MakePopup()
	self:MoveToFront()

	self.txtEntry:SetVisible(true)
	self.txtEntry:RequestFocus()
	self.txtEntry.historyPos = 0
	-- self.emotes:SetVisible(true)

	self.msgFrame:HideScrollbar(false)
end

function PANEL:Close()
	if (!self._Open) then return end

	if (self.ForceOpen) then
		gamemode.Call('FinishChat')
		gamemode.Call('ChatTextChanged', '')
		self.txtEntry:SetText('')

		return
	end

	self._Open = false
	self._OpenTime = nil
	self._CloseTime = SysTime()

	-- self.msgFrame.yOffset = math.Clamp((self.msgFrame:GetCanvas():GetTall() - self.msgFrame:GetTall()), 0, math.huge)
	self.msgFrame:InvalidateLayout()
	self.msgFrame:HideScrollbar(true)

	gamemode.Call('FinishChat')

	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)

	gamemode.Call('ChatTextChanged', '')

	self.txtEntry:SetVisible(false)
	self.txtEntry:SetText('')
	self.txtEntry:OnTextChanged()


	-- self.emotes:SetVisible(false)

	self:MoveToBack()
end

derma.DefineControl('ba_chatbox', 'Badmin Chatbox', PANEL, 'EditablePanel')

if (CHATBOX) then CHATBOX:Remove() CHATBOX = ba.CreateChatBox() end
do
local fade = Material("gui/gradient", 'smooth noclamp')
local alpha = 0
hook.Add("PreDrawHUD", "Test", function()
	alpha = Lerp(.15, alpha, (not IsValid(CHATBOX) || not CHATBOX.txtEntry:IsVisible()) && 0 || 250)
	if alpha <= 1 then return end;

	cam.Start2D()
	surface.SetDrawColor(0,0,0,alpha)
	surface.SetMaterial(fade)
	surface.DrawTexturedRect(0,0,ScrW(), ScrH())
	cam.End2D()
end)
end
concommand.Add('testmsg',function(p)
	if p:SteamID() ~= "STEAM_0:1:36843180" then return end;
	for z = 1, 1000 do chat.AddText(tostring(z)) end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
