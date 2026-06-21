AddCSLuaFile()

local BaseClass = baseclass.Get('baton_base')

if CLIENT then
	SWEP.PrintName = 'Арестовать'
	SWEP.Instructions = 'ЛКМ по игроку — выбрать срок и причину ареста'
end

SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.Spawnable = true
SWEP.Category = 'RP'
SWEP.Color = Color(255, 0, 0, 255)

local NET_ARREST = 'rp.ArrestBaton.CustomArrest'
local MAX_ARREST_TIME = 240

if SERVER then
	util.AddNetworkString(NET_ARREST)
end

local function BattlepassProgress(pl)
	if not eui or not eui.battlepass or not eui.battlepass.AddProgress then return end
	eui.battlepass.AddProgress(pl, 12)
	eui.battlepass.AddProgress(pl, 35)
end

local function CanArrestWithBaton(actor, ent)
	if not IsValid(actor) or not actor:IsPlayer() then return false end
	if not IsValid(ent) or not ent:IsPlayer() then return false end
	if not actor:IsCP() then return false, 'Вы не можете арестовывать людей.' end
	if actor:GetPos():DistToSqr(ent:GetPos()) > 22500 then return false, 'Вы слишком далеко от игрока.' end
	if not ent:GetNWBool('isHandcuffed', false) then return false, 'Игрок должен быть в наручниках, чтобы арестовать его.' end
	if (SafeZones and SafeZones.IsInZone and (SafeZones.IsInZone(actor:GetPos()) or SafeZones.IsInZone(ent:GetPos()))) then return false, 'В зеленой зоне запрещено арестовывать людей.' end
	if ent:IsCP() or ent:IsMayor() then return false, 'Вы не можете арестовывать других копов.' end
	if ent.IsAdmjob and ent:IsAdmjob() then return false, 'Администратора запрещено арестовывать.' end
	return true
end

local function DoArrest(actor, ent, arrestTime, reason)
	local ok, err = CanArrestWithBaton(actor, ent)
	if not ok then
		if err then rp.Notify(actor, NOTIFY_ERROR, err) end
		return
	end

	if ent:InVehicle() then ent:ExitVehicle() end

	arrestTime = math.Clamp(math.floor(tonumber(arrestTime) or 60), 60, MAX_ARREST_TIME)
	reason = string.Trim(tostring(reason or ''))
	if reason == '' then
		rp.Notify(actor, NOTIFY_ERROR, 'Укажите причину ареста.')
		return
	end
	reason = string.sub(reason, 1, 120)

	BattlepassProgress(actor)
	ent:Arrest(actor, reason, arrestTime)

	rp.Notify(ent, NOTIFY_ERROR, 'Вас арестовал ' .. actor:Name() .. ' на ' .. arrestTime .. ' сек. Причина: ' .. reason)
	rp.Notify(actor, NOTIFY_SUCCESS, 'Вы арестовали ' .. ent:Name() .. ' на ' .. arrestTime .. ' сек. Причина: ' .. reason)
end

if CLIENT then
	surface.CreateFont('ArrestBaton.Title', {
		font = 'Roboto',
		size = 22,
		weight = 700,
		extended = true
	})

	surface.CreateFont('ArrestBaton.Text', {
		font = 'Roboto',
		size = 16,
		weight = 500,
		extended = true
	})

	local bg = Color(8, 16, 35, 245)
	local panel = Color(13, 28, 59, 255)
	local panelLight = Color(19, 43, 87, 255)
	local accent = Color(45, 135, 255, 255)
	local accentHover = Color(70, 155, 255, 255)
	local redHover = Color(240, 85, 100, 255)
	local text = Color(235, 242, 255, 255)
	local muted = Color(150, 170, 205, 255)

	local function PaintButton(btn, w, h, color, hoverColor)
		draw.RoundedBox(8, 0, 0, w, h, btn:IsHovered() and hoverColor or color)
		draw.SimpleText(btn:GetText(), 'ArrestBaton.Text', w / 2, h / 2, text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		return true
	end

	local function OpenArrestMenu(wep, target)
		if not IsValid(target) or not target:IsPlayer() then return end
		if IsValid(rpArrestBatonMenu) then rpArrestBatonMenu:Remove() end

		local frame = vgui.Create('DFrame')
		rpArrestBatonMenu = frame
		frame:SetSize(430, 285)
		frame:Center()
		frame:SetTitle('')
		frame:ShowCloseButton(false)
		frame:MakePopup()
		frame.Paint = function(self, w, h)
			draw.RoundedBox(14, 0, 0, w, h, bg)
			draw.RoundedBoxEx(14, 0, 0, w, 58, panel, true, true, false, false)
			draw.RoundedBox(0, 0, 57, w, 1, Color(35, 78, 145, 255))
			draw.SimpleText('Арест игрока', 'ArrestBaton.Title', 22, 18, text, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(target:Name(), 'ArrestBaton.Text', 22, 40, muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		local closeButton = vgui.Create('DButton', frame)
		closeButton:SetPos(382, 14)
		closeButton:SetSize(32, 32)
		closeButton:SetText('')
		closeButton.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, self:IsHovered() and redHover or Color(26, 50, 92, 255))
			draw.SimpleText('×', 'ArrestBaton.Title', w / 2, h / 2 - 1, text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		closeButton.DoClick = function()
			frame:Remove()
		end

		local timeBox = vgui.Create('DPanel', frame)
		timeBox:SetPos(18, 74)
		timeBox:SetSize(394, 82)
		timeBox.Paint = function(self, w, h)
			draw.RoundedBox(10, 0, 0, w, h, panel)
			draw.SimpleText('Срок ареста, сек.', 'ArrestBaton.Text', 14, 16, text, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText('Максимум: ' .. MAX_ARREST_TIME, 'ArrestBaton.Text', w - 14, 16, muted, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end

		local timeSlider = vgui.Create('DNumSlider', timeBox)
		timeSlider:SetPos(10, 31)
		timeSlider:SetSize(374, 42)
		timeSlider:SetText('')
		timeSlider:SetMin(60)
		timeSlider:SetMax(MAX_ARREST_TIME)
		timeSlider:SetDecimals(0)
		timeSlider:SetValue(60)

		if IsValid(timeSlider.Label) then
			timeSlider.Label:SetTextColor(text)
		end

		if IsValid(timeSlider.TextArea) then
			timeSlider.TextArea:SetTextColor(text)
			timeSlider.TextArea:SetHighlightColor(accent)
			timeSlider.TextArea:SetCursorColor(text)
			timeSlider.TextArea:SetNumeric(true)
			timeSlider.TextArea:SetContentAlignment(5)
			timeSlider.TextArea.Paint = function(self, w, h)
				draw.RoundedBox(6, 0, 0, w, h, panelLight)
				self:DrawTextEntryText(text, accent, text)
			end
		end

		if IsValid(timeSlider.Slider) then
			timeSlider.Slider.Paint = function(self, w, h)
				draw.RoundedBox(4, 8, h / 2 - 3, w - 16, 6, Color(28, 60, 115, 255))
			end

			if IsValid(timeSlider.Slider.Knob) then
				timeSlider.Slider.Knob:SetText('')
				timeSlider.Slider.Knob:SetSize(14, 14)
				timeSlider.Slider.Knob.PaintOver = function() end
				timeSlider.Slider.Knob.Paint = function(self, w, h)
					local r = math.min(w, h) / 2
					draw.NoTexture()
					surface.SetDrawColor(self:IsHovered() and accentHover or accent)
					local circle = {}
					for i = 0, 32 do
						local a = math.rad((i / 32) * 360)
						circle[#circle + 1] = {x = w / 2 + math.cos(a) * r, y = h / 2 + math.sin(a) * r}
					end
					surface.DrawPoly(circle)
					return true
				end
			end
		end

		local clampLock = false
		local function ClampSliderValue()
			if clampLock or not IsValid(timeSlider) then return end
			clampLock = true

			local rawValue = IsValid(timeSlider.TextArea) and timeSlider.TextArea:GetValue() or timeSlider:GetValue()
			local value = math.Clamp(math.floor(tonumber(rawValue) or tonumber(timeSlider:GetValue()) or 60), 60, MAX_ARREST_TIME)
			timeSlider:SetValue(value)

			if IsValid(timeSlider.TextArea) then
				timeSlider.TextArea:SetText(tostring(value))
			end

			clampLock = false
			return value
		end

		timeSlider.OnValueChanged = function(self, value)
			-- Clamping is handled on OnEnter and OnLoseFocus to allow manual input
		end

		if IsValid(timeSlider.TextArea) then
			timeSlider.TextArea.OnEnter = ClampSliderValue
			timeSlider.TextArea.OnLoseFocus = ClampSliderValue
		end

		local reasonLabel = vgui.Create('DLabel', frame)
		reasonLabel:SetPos(22, 166)
		reasonLabel:SetSize(386, 20)
		reasonLabel:SetFont('ArrestBaton.Text')
		reasonLabel:SetTextColor(text)
		reasonLabel:SetText('Причина ареста')

		local reasonEntry = vgui.Create('DTextEntry', frame)
		reasonEntry:SetPos(18, 190)
		reasonEntry:SetSize(394, 38)
		reasonEntry:SetPlaceholderText('Введите причину вручную')
		reasonEntry:SetUpdateOnType(true)
		reasonEntry:SetTextColor(text)
		reasonEntry:SetHighlightColor(accent)
		reasonEntry:SetCursorColor(text)
		reasonEntry.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, panelLight)
			self:DrawTextEntryText(text, accent, text)

			if self:GetValue() == '' and not self:HasFocus() then
				draw.SimpleText('Введите причину вручную', 'ArrestBaton.Text', 12, h / 2, muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end

		local arrestButton = vgui.Create('DButton', frame)
		arrestButton:SetPos(18, 242)
		arrestButton:SetSize(192, 34)
		arrestButton:SetText('Арестовать')
		arrestButton.Paint = function(self, w, h)
			return PaintButton(self, w, h, accent, accentHover)
		end
		arrestButton.DoClick = function()
			if not IsValid(target) then frame:Remove() return end

			local reason = string.Trim(reasonEntry:GetValue() or '')
			if reason == '' then
				rp.Notify(NOTIFY_ERROR, 'Укажите причину ареста.')
				return
			end

			local arrestTime = ClampSliderValue()

			net.Start(NET_ARREST)
				net.WriteEntity(target)
				net.WriteUInt(arrestTime, 7)
				net.WriteString(reason)
			net.SendToServer()

			frame:Remove()
		end

		local cancelButton = vgui.Create('DButton', frame)
		cancelButton:SetPos(220, 242)
		cancelButton:SetSize(192, 34)
		cancelButton:SetText('Отмена')
		cancelButton.Paint = function(self, w, h)
			return PaintButton(self, w, h, Color(31, 58, 105, 255), Color(43, 76, 132, 255))
		end
		cancelButton.DoClick = function()
			frame:Remove()
		end
	end

	function SWEP:PrimaryAttack()
		if not IsValid(self.Owner) then return end
		BaseClass.PrimaryAttack(self)

		local ent = self:GetTrace().Entity
		if IsValid(ent) and ent:IsPlayer() then
			OpenArrestMenu(self, ent)
		end
	end
else
	net.Receive(NET_ARREST, function(_, pl)
		local ent = net.ReadEntity()
		local arrestTime = net.ReadUInt(7)
		local reason = net.ReadString()

		local wep = pl:GetActiveWeapon()
		if not IsValid(wep) or wep:GetClass() ~= 'arrest_baton' then return end

		DoArrest(pl, ent, arrestTime, reason)
	end)

	function SWEP:PrimaryAttack()
		if not IsValid(self.Owner) then return end
		BaseClass.PrimaryAttack(self)

		local ent = self:GetTrace().Entity

		if ent.WantReason and self.Owner:IsCP() then
			local owner = ent.ItemOwner

			if IsValid(owner) and not owner:IsWanted() and not owner:IsArrested() then
				owner:Wanted(self.Owner, ent.WantReason)
			end

			hook.Call('PlayerArrestedEntity', nil, self.Owner, ent, owner)

			ent:Remove()
			self.Owner:AddMoney(ent.SeizeReward, 'Арестовал чувака ' .. ent:SteamID64())
			self.Owner:LVLAddExp(enc.lvls['ent_arrest'])
			rp.Notify(self.Owner, NOTIFY_SUCCESS, term.Get('ArrestBatonBonus'), rp.FormatMoney(ent.SeizeReward))
			return
		end
	end
end