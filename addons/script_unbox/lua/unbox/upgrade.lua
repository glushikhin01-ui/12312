local weight = (...).weight or function(w) return w end
local height = (...).height or function(h) return h end
local ub_findByIGSid = (...).find

local UpgradePage = {}
UpgradePage.Base = "EditablePanel"

surface.CreateFont("UPG_14", {font = "Tahoma", size = 14, weight = 600, antialias = true, extended = true})
surface.CreateFont("UPG_16", {font = "Tahoma", size = 16, weight = 800, antialias = true, extended = true})
surface.CreateFont("UPG_22", {font = "Tahoma", size = 22, weight = 900, antialias = true, extended = true})
surface.CreateFont("UPG_32", {font = "Tahoma", size = 32, weight = 900, antialias = true, extended = true})

local C_BG      = Color(22, 23, 30, 245)
local C_CARD    = Color(34, 36, 48, 245)
local C_INNER   = Color(43, 46, 60, 250)
local C_ACCENT  = Color(161, 104, 255)
local C_MUTED   = Color(175, 180, 195)
local C_GREEN   = Color(85, 190, 95)
local C_RED     = Color(210, 75, 75)

local function IsValidMdlPath(path)
    return isstring(path) and path:lower():StartWith("models/") and path:lower():EndsWith(".mdl")
end

local function SafeText(text, font, x, y, col, ax, ay)
    text = tostring(text or "")
    surface.SetFont(font or "DermaDefault")
    local tw, th = surface.GetTextSize(text)
    tw = tonumber(tw) or 0
    th = tonumber(th) or 0
    if ax == TEXT_ALIGN_CENTER then x = x - tw / 2 elseif ax == TEXT_ALIGN_RIGHT then x = x - tw end
    if ay == TEXT_ALIGN_CENTER then y = y - th / 2 elseif ay == TEXT_ALIGN_BOTTOM then y = y - th end
    surface.SetTextColor(col or color_white)
    surface.SetTextPos(tonumber(x) or 0, tonumber(y) or 0)
    surface.DrawText(text)
end

local function AddPreview(parent, item, x, y, w, h)
    if not IsValid(parent) or not item then return end
    local modelPath = item.model
    local icon = item.icon

    -- Возвращаем модели оружия. ERROR в центре был не из-за карточек оружия.
    if IsValidMdlPath(modelPath) then
        local mdl = vgui.Create("ModelImage", parent)
        mdl:SetPos(x, y)
        mdl:SetSize(w, h)
        mdl:SetModel(modelPath)
        mdl:SetMouseInputEnabled(false)
        return mdl
    end

    if istable(icon) and icon.icon then
        if icon.isModel and IsValidMdlPath(icon.icon) then
            local mdl = vgui.Create("ModelImage", parent)
            mdl:SetPos(x, y)
            mdl:SetSize(w, h)
            mdl:SetModel(icon.icon)
            mdl:SetMouseInputEnabled(false)
            return mdl
        elseif not icon.isModel then
            local img = vgui.Create("igs_wmat", parent)
            img:SetPos(x, y)
            img:SetSize(w, h)
            img:SetURL(icon.icon)
            img:SetMouseInputEnabled(false)
            return img
        end
    end
end

local function GetIGSItemName(item)
    if not item then return "" end
    if item.Name then
        local ok, name = pcall(function() return item:Name() end)
        if ok and name then return tostring(name) end
    end
    return tostring(item.name or item.Name or "")
end

local function ResolveDisplayPrice(item, fallbackName)
    local fallback = tonumber(item and item.price) or 0
    local targetName = GetIGSItemName(item)
    if targetName == "" then targetName = tostring(fallbackName or "") end

    local best = fallback
    if IGS and IGS.GetItems then
        for _, it in pairs(IGS.GetItems() or {}) do
            local nm = GetIGSItemName(it)
            local price = tonumber(it.price) or 0
            local cat = tostring(it.category or "")
            local hidden = it.hidden and true or false
            -- Берем цену из обычного F6-магазина, а не из скрытого case-предмета.
            if nm == targetName and price > best and (cat == "Оружие" or not hidden) then
                best = price
            end
        end
    end
    return best
end

local function CirclePoly(cx, cy, r, seg, startAng, endAng)
    local poly = {{x = cx, y = cy}}
    startAng = startAng or -90
    endAng = endAng or 270
    for i = 0, seg do
        local a = math.rad(startAng + (endAng - startAng) * (i / seg))
        poly[#poly + 1] = {x = cx + math.cos(a) * r, y = cy + math.sin(a) * r}
    end
    return poly
end

function UpgradePage:Init()
    self.Items = {}
    self.Left = nil
    self.Right = nil
    self.Chance = 0
    self.IsMoney = false
    self.Spinning = false
    self.SpinEnd = 0
    self.SpinWin = false

    self.LeftPreview = vgui.Create("Panel", self)
    self.LeftPreview:SetZPos(10)
    self.RightPreview = vgui.Create("Panel", self)
    self.RightPreview:SetZPos(10)
    self.CenterPanel = vgui.Create("Panel", self)
    self.CenterPanel:SetZPos(10000)
    self.ControlFrame = vgui.Create("Panel", self)
    self.ControlFrame:SetZPos(10001)

    self.LeftScroll = vgui.Create("DScrollPanel", self)
    self.LeftScroll:GetVBar():SetWide(0)
    self.LeftLayout = vgui.Create("DIconLayout", self.LeftScroll)
    self.LeftLayout:Dock(TOP)
    self.LeftLayout:SetSpaceX(weight(8))
    self.LeftLayout:SetSpaceY(height(8))

    self.RightScroll = vgui.Create("DScrollPanel", self)
    self.RightScroll:GetVBar():SetWide(0)
    self.RightLayout = vgui.Create("DIconLayout", self.RightScroll)
    self.RightLayout:Dock(TOP)
    self.RightLayout:SetSpaceX(weight(8))
    self.RightLayout:SetSpaceY(height(8))
    self.RightLayout.Items = {}

    local function PaintPreview(panel, side)
        panel.Paint = function(p, w, h)
            draw.RoundedBox(16, 0, 0, w, h, C_BG)
            draw.RoundedBox(14, weight(8), height(8), w - weight(16), h - height(16), C_INNER)
            local data = side == "left" and self:GetLeftData() or self:GetRightData()
            if data then
                SafeText(data.name or "Предмет", "UPG_22", w / 2, height(22), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                SafeText((tonumber(data.price) or 0) .. " P", "UPG_16", w / 2, h - height(32), C_ACCENT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                SafeText(side == "left" and "Выберите предмет" or "Выберите цель", "UPG_16", w / 2, h / 2, C_MUTED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
    end
    PaintPreview(self.LeftPreview, "left")
    PaintPreview(self.RightPreview, "right")

    self.CenterPanel.Paint = function(p, w, h)
        draw.RoundedBox(16, 0, 0, w, h, Color(18, 19, 25, 245))
        local r = math.min(w, h) / 2 - 8
        local cx, cy = w / 2, h / 2
        draw.NoTexture()
        surface.SetDrawColor(48, 50, 62, 255)
        surface.DrawPoly(CirclePoly(cx, cy, r, 96, -90, 270))
        local chance = math.Clamp(tonumber(self.Chance) or 0, 0, 100)
        if chance > 0 then
            surface.SetDrawColor(self.Spinning and (self.SpinWin and C_GREEN or C_RED) or C_ACCENT)
            surface.DrawPoly(CirclePoly(cx, cy, r, 96, -90, -90 + chance / 100 * 360))
        end
        surface.SetDrawColor(28, 30, 39, 255)
        surface.DrawPoly(CirclePoly(cx, cy, r * 0.70, 96, -90, 270))
        SafeText("Шанс", "UPG_16", cx, cy - height(18), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        SafeText(math.Round(chance, 1) .. "%", "UPG_32", cx, cy + height(14), C_ACCENT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    self.StartButton = vgui.Create("DButton", self.ControlFrame)
    self.StartButton:Dock(FILL)
    self.StartButton:SetText("")
    self.StartButton.Paint = function(btn, w, h)
        local can = self:GetLeftData() and self:GetRightData() and not self.Spinning
        draw.RoundedBox(10, 0, 0, w, h, can and (btn:IsHovered() and Color(181,124,255) or C_ACCENT) or Color(75,75,85))
        SafeText(self.Spinning and "КРУТИМ..." or "СТАРТ", "UPG_16", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.StartButton.DoClick = function()
        if self.Spinning then return end
        local left, right = self:GetLeft(), self:GetRight()
        local left_item = self:GetLeftData()
        local right_item = self:GetRightData()
        if not left_item or not right_item then return end
        if right_item.uid == left_item.uid then return end
        LocalPlayer():EmitSound("buttons/lever7.wav")
        buttonsLockeds = true
        net.Start("StartClientUpgradeAnimation")
            net.WriteString(right_item.uid)
            net.WriteBool(true)
            net.WriteString(left_item.uid)
            net.WriteString(left_item.id or "")
            net.WriteBool(left_item.isInventory and true or false)
        net.SendToServer()
    end

    self:LoadRightItems()
    self:Update()
end

function UpgradePage:ClearPreview(panel)
    if not IsValid(panel) then return end
    for _, child in ipairs(panel:GetChildren()) do
        if child ~= panel then child:Remove() end
    end
end

function UpgradePage:RefreshBigPreviews()
    self:ClearPreview(self.LeftPreview)
    self:ClearPreview(self.RightPreview)
    timer.Simple(0, function()
        if not IsValid(self) then return end
        local l = self:GetLeftData()
        local r = self:GetRightData()
        if l then AddPreview(self.LeftPreview, l, self.LeftPreview:GetWide()/2 - weight(78), height(62), weight(156), height(156)) end
        if r then AddPreview(self.RightPreview, r, self.RightPreview:GetWide()/2 - weight(78), height(62), weight(156), height(156)) end
    end)
end

function UpgradePage:MakeCard(parentLayout, data, onClick)
    local card = vgui.Create("DButton")
    card:SetSize(weight(112), height(118))
    card:SetText("")
    card.Paint = function(c, w, h)
        draw.RoundedBox(10, 0, 0, w, h, C_CARD)
        draw.RoundedBox(8, weight(7), height(7), w - weight(14), height(70), C_INNER)
        SafeText(data.name or "Предмет", "UPG_14", w / 2, h - height(31), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        SafeText((tonumber(data.price) or 0) .. " P", "UPG_14", w / 2, h - height(12), C_ACCENT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    card.DoClick = onClick
    timer.Simple(0, function()
        if IsValid(card) then AddPreview(card, data, card:GetWide()/2 - weight(28), height(12), weight(56), height(56)) end
    end)
    parentLayout:Add(card)
    data.panel = card
    return card
end

function UpgradePage:Append(uid, id, isInventory)
    if not uid then return end
    local found = ub_findByIGSid(uid)
    if not found then return end
    local ITEM = IGS.GetItemByUID(uid)
    if not ITEM or ITEM.isnull or (tonumber(ITEM.price) or 0) <= 0 then return end
    local cfg = BUC2.ITEMS[found] or {}
    self.Items[#self.Items + 1] = {
        name = found,
        model = cfg.model,
        icon = ITEM.icon,
        price = ResolveDisplayPrice(ITEM, found),
        uid = uid,
        id = id,
        isInventory = isInventory
    }
end

function UpgradePage:ShowItems()
    if not IsValid(self.LeftLayout) then return end
    self.LeftLayout:Clear()
    for i, item in SortedPairsByMemberValue(self.Items, "price", true) do
        self:MakeCard(self.LeftLayout, item, function() self:SetLeft(i) end)
    end
end

function UpgradePage:LoadRightItems()
    self.RightLayout.Items = {}
    for uid in pairs(BUC2.UpgradeToItems or {}) do
        local found = ub_findByIGSid(uid)
        if found then
            local igs = IGS.GetItemByUID(uid)
            if igs and not igs.isnull and (tonumber(igs.price) or 0) > 0 then
                local cfg = BUC2.ITEMS[found] or {}
                self.RightLayout.Items[#self.RightLayout.Items + 1] = {
                    name = found,
                    model = cfg.model,
                    icon = igs.icon,
                    price = ResolveDisplayPrice(igs, found),
                    uid = uid
                }
            end
        end
    end
    self.RightLayout:Clear()
    for i, item in SortedPairsByMemberValue(self.RightLayout.Items, "price", true) do
        self:MakeCard(self.RightLayout, item, function() self:SetRight(i) end)
    end
end

function UpgradePage:Update()
    IGS.GetInventory(function(inventory)
        if not IsValid(self) then return end
        self.Items = {}
        self:SetLeft(false)
        for _, v in pairs(inventory or {}) do
            if v.item and v.item.uid and BUC2.UpgradeFromItems[v.item.uid] then
                self:Append(v.item.uid, v.id, true)
            end
        end
        self:ShowItems()
    end)
end

function UpgradePage:GetLeft() return self.Left end
function UpgradePage:GetRight() return self.Right end
function UpgradePage:GetLeftData() return self.Left and self.Items[self.Left] or nil end
function UpgradePage:GetRightData() return self.Right and self.RightLayout.Items[self.Right] or nil end

function UpgradePage:SetLeft(i)
    self.Left = i or nil
    self:RecalculateChance()
    self:RefreshBigPreviews()
end

function UpgradePage:SetRight(i)
    self.Right = i or nil
    self:RecalculateChance()
    self:RefreshBigPreviews()
end

function UpgradePage:RecalculateChance()
    local left_item = self:GetLeftData()
    local right_item = self:GetRightData()
    if not left_item or not right_item or (tonumber(right_item.price) or 0) <= 0 then
        self.Chance = 0
        return
    end
    self.Chance = math.Round(math.Clamp((tonumber(left_item.price) or 0) / (tonumber(right_item.price) or 1), 0, 1), 3) * 100
end

function UpgradePage:DoSpin(win)
    self.Spinning = true
    self.SpinWin = win and true or false
    self.SpinEnd = CurTime() + 2.0
    timer.Simple(2.0, function()
        if not IsValid(self) then return end
        self.Spinning = false
        buttonsLockeds = false
        if not self.SpinWin then
            net.Start("SpinEnded")
                net.WriteBool(false)
            net.SendToServer()
        end
        self:SetLeft(false)
        self:Update()
    end)
end

function UpgradePage:Paint(w, h)
    draw.RoundedBox(14, 0, 0, w, h, Color(16, 17, 24, 0))
end

function UpgradePage:PerformLayout(w, h)
    w = tonumber(w) or self:GetWide()
    h = tonumber(h) or self:GetTall()
    if w <= 0 or h <= 0 then return end

    local margin = weight(24)
    local topY = height(18)
    local spinSize = math.min(w * 0.22, h * 0.28)
    local itemSize = math.min(w * 0.25, h * 0.34)
    local listTop = topY + itemSize + height(18)
    local listH = math.max(height(210), h - listTop - height(12))
    local listW = math.max(weight(260), (w - spinSize - margin * 6) / 2)

    local centerW = spinSize + weight(18)
    local centerH = spinSize + height(18)
    self.CenterPanel:SetSize(centerW, centerH)
    self.CenterPanel:SetPos(w / 2 - centerW / 2, topY + height(8))

    self.LeftPreview:SetSize(itemSize, itemSize)
    self.LeftPreview:SetPos(margin, topY)

    self.RightPreview:SetSize(itemSize, itemSize)
    self.RightPreview:SetPos(w - margin - itemSize, topY)

    local cx, cy = self.CenterPanel:GetPos()
    self.ControlFrame:SetSize(weight(140), height(46))
    self.ControlFrame:SetPos(w / 2 - self.ControlFrame:GetWide() / 2, cy + centerH + height(12))

    self.LeftScroll:SetPos(margin, listTop)
    self.LeftScroll:SetSize(listW, listH)

    self.RightScroll:SetPos(w - margin - listW, listTop)
    self.RightScroll:SetSize(listW, listH)

    self:RefreshBigPreviews()
end

return UpgradePage
