local box = draw.RoundedBox
local PANEL = {}

AccessorFunc(PANEL, 'm_bFromBottom', 'FromBottom', FORCE_BOOL)
AccessorFunc(PANEL, 'm_bVBarPadding', 'VBarPadding', FORCE_NUMBER)
PANEL:SetVBarPadding(0)

local starting_scroll_speed = 3

local vbar_OnMouseWheeled = function(s, delta)
    s.scroll_speed = s.scroll_speed + (14 * RealFrameTime())
    s:AddScroll(delta * -s.scroll_speed)
end

local vbar_SetScroll = function(s, amount)
    if not s.Enabled then s.Scroll = 0 return end
    s.scroll_target = amount
    s:InvalidateLayout()
end

local vbar_OnCursorMoved = function(s, _, y)
    if s.Dragging then
        y = y - s.HoldPos
        y = y / (s:GetTall() - s:GetWide() * 2 - s.btnGrip:GetTall())
        s.scroll_target = y * s.CanvasSize
    end
end

local vbar_Think = function(s)
    local frame_time = RealFrameTime() * 14
    local scroll_target = s.scroll_target
    s.Scroll = Lerp(frame_time, s.Scroll, scroll_target)
    if not s.Dragging then
        s.scroll_target = Lerp(frame_time / 14, scroll_target, math.Clamp(scroll_target, 0, s.CanvasSize))
    end
    s.scroll_speed = Lerp(frame_time / 14, s.scroll_speed, starting_scroll_speed)
end

local vbar_Paint = function(s, w, h)
    box(2, 0, 0, enc.w(2), h, Color(0, 0, 0))
end

local vbarGrip_Paint = function(s, w, h)
    box(2, 0, 0, w, h, Color(1, 89, 224))
end

local vbar_PerformLayout = function(s, w, h)
    if not s.CanvasSize or s.CanvasSize == 0 then return end
    local scroll   = s:GetScroll() / s.CanvasSize
    local bar_size = math.max(s:BarScale() * h, 10)
    local track    = (h - bar_size) + 1
    scroll = scroll * track
    s.btnGrip.y = scroll
    s.btnGrip:SetSize(enc.w(3), bar_size)
end

function PANEL:Init()
    local canvas   = self:GetCanvas()
    local children = {}

    function canvas:OnChildAdded(child)
        table.insert(children, child)
    end

    function canvas:OnChildRemoved(child)
        for i = #children, 1, -1 do
            if children[i] == child then
                table.remove(children, i)
                return
            end
        end
    end

    canvas.GetChildren = function()
        return children
    end
    canvas.children = children

    local vbar = self.VBar
    vbar:SetHideButtons(true)
    vbar.btnUp:SetVisible(false)
    vbar.btnDown:SetVisible(false)
    vbar.vertices      = {}
    vbar.scroll_target = 0
    vbar.scroll_speed  = starting_scroll_speed
    vbar.OnMouseWheeled = vbar_OnMouseWheeled
    vbar.SetScroll      = vbar_SetScroll
    vbar.OnCursorMoved  = vbar_OnCursorMoved
    vbar.Think          = vbar_Think
    vbar.Paint          = vbar_Paint
    vbar.PerformLayout  = vbar_PerformLayout
    vbar.btnGrip.vertices = {}
    vbar.btnGrip.Paint    = vbarGrip_Paint
end

function PANEL:OnChildAdded(child)
    self:AddItem(child)
    self:ChildAdded(child)
end

function PANEL:ChildAdded()
end

function PANEL:Paint(w, h)
end

function PANEL:ScrollToBottom()
    local vbar = self.VBar
    for k, anim in pairs(vbar.m_AnimList or {}) do
        anim:Think(vbar, 1)
        vbar.m_AnimList[k] = nil
    end
    self:InvalidateParent(true)
    self:InvalidateChildren(true)
    vbar:SetScroll(vbar.CanvasSize)
end

function PANEL:PerformLayoutInternal(w, h)
    w = w or self:GetWide()
    h = h or self:GetTall()
    local canvas = self.pnlCanvas
    self:Rebuild()
    local vbar = self.VBar
    vbar:SetUp(h, canvas:GetTall())
    if vbar.Enabled then
        w = w - vbar:GetWide() - self.m_bVBarPadding
    end
    canvas:SetWide(w)
    self:Rebuild()
end

function PANEL:Think()
    local canvas = self.pnlCanvas
    local vbar   = self.VBar
    if vbar.Enabled then
        canvas.y = -vbar.Scroll
    else
        if self:GetFromBottom() then
            canvas._y = Lerp(14 * RealFrameTime(), canvas._y or canvas.y, self:GetTall() - canvas:GetTall())
        else
            canvas._y = Lerp(14 * RealFrameTime(), canvas._y or canvas.y, -vbar.Scroll)
        end
        canvas.y = canvas._y
    end
end

vgui.Register('enc.scroll', PANEL, 'DScrollPanel')
