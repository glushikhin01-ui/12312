if SERVER then return end

print('[ArizonaRP BattlePass] loaded: HEADER_RIGHT_SMALL_v15')

local BP = {}
BP.BASE_W = 1921
BP.BASE_H = 1080
BP.MAX_LEVEL = 50
BP.Page = 0
BP.LevelScroll = 0
BP.TargetLevelScroll = 0
BP.Frame = nil
BP.LeftButton = nil
BP.RightButton = nil

local COL_CARD = Color(42, 43, 46)
local COL_GRAD_R = 218
local COL_GRAD_G = 62
local COL_GRAD_B = 68
local COL_LINE = Color(87, 68, 72)
local COL_TASK = Color(159, 159, 159, 64)
local WHITE = Color(255, 255, 255)
local BG_DIM = Color(0, 0, 0, 145)

local mats = {
    bg = Material('f4/battlepass/bg.png', 'smooth mips'),
    header = Material('lvlsys/azlogolvl.png', 'smooth mips'),
    level1 = Material('lvlsys/1lvl.png', 'smooth mips'),
    level10 = Material('lvlsys/1lvl.png', 'smooth mips'),
    level20 = Material('lvlsys/2lvl.png', 'smooth mips'),
    level30 = Material('lvlsys/3lvl.png', 'smooth mips'),
    level40 = Material('lvlsys/4lvl.png', 'smooth mips'),
    level50 = Material('lvlsys/5lvl.png', 'smooth mips'),
    money = Material('hud/dollar.png', 'smooth mips'),
    task = Material('hud/news.png', 'smooth mips')
}

local function X(v) return math.Round(v * ScrW() / BP.BASE_W) end
local function Y(v) return math.Round(v * ScrH() / BP.BASE_H) end
local function S(v) return math.Round(v * math.min(ScrW() / BP.BASE_W, ScrH() / BP.BASE_H)) end

local function MakeFonts()
    surface.CreateFont('BP.Text20', { font = 'Inter', size = S(20), weight = 500, extended = true, antialias = true })
    surface.CreateFont('BP.Bold20', { font = 'Inter', size = S(20), weight = 700, extended = true, antialias = true })
    surface.CreateFont('BP.Close', { font = 'Inter', size = S(34), weight = 800, extended = true, antialias = true })
    surface.CreateFont('BP.Arrow', { font = 'Inter', size = S(28), weight = 800, extended = true, antialias = true })
end

MakeFonts()
hook.Add('OnScreenSizeChanged', 'ArizonaRP.BattlePass.Fonts', MakeFonts)

local function DrawCard(x, y, w, h, r)
    draw.RoundedBox(r, x, y, w, h, COL_CARD)

    local rows = math.max(1, h)
    for i = 0, rows do
        local t = i / rows
        local a = math.floor(t * 26)
        if a > 0 then
            local inset = 0
            if i < r then
                local dy = r - i
                inset = r - math.sqrt(math.max(0, r * r - dy * dy))
            elseif i > h - r then
                local dy = i - (h - r)
                inset = r - math.sqrt(math.max(0, r * r - dy * dy))
            end
            surface.SetDrawColor(COL_GRAD_R, COL_GRAD_G, COL_GRAD_B, a)
            surface.DrawRect(x + inset, y + i, math.max(0, w - inset * 2), 1)
        end
    end
end

local function DrawImage(mat, x, y, w, h, fallback)
    if mat and not mat:IsError() then
        surface.SetMaterial(mat)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(x, y, w, h)
        return
    end

    surface.SetDrawColor(145, 22, 22, 145)
    surface.DrawRect(x, y, w, h)
    surface.SetDrawColor(255, 255, 255, 80)
    surface.DrawOutlinedRect(x, y, w, h, 1)
    if fallback and fallback ~= '' then
        draw.SimpleText(fallback, 'BP.Text20', x + w / 2, y + h / 2, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local function DrawHeaderIcon(x, y)
    if mats.header and not mats.header:IsError() then
        DrawImage(mats.header, x + X(28), y + Y(4), X(60), Y(59), '')
        return
    end

    surface.SetDrawColor(255, 136, 0)
    draw.NoTexture()
    surface.DrawPoly({
        { x = x, y = y },
        { x = x + X(100), y = y + Y(18) },
        { x = x + X(73), y = y + Y(99) },
        { x = x + X(11), y = y + Y(83) }
    })
    surface.SetDrawColor(255, 162, 96)
    surface.DrawPoly({
        { x = x + X(13), y = y + Y(10) },
        { x = x + X(86), y = y + Y(25) },
        { x = x + X(65), y = y + Y(85) },
        { x = x + X(21), y = y + Y(73) }
    })
end

local function DrawWrapped(txt, font, x, y, maxW, lineH, col)
    surface.SetFont(font)
    local line = ''
    local cy = y

    for word in tostring(txt):gmatch('%S+') do
        local test = line == '' and word or (line .. ' ' .. word)
        local tw = surface.GetTextSize(test)
        if tw > maxW and line ~= '' then
            draw.SimpleText(line, font, x, cy, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            cy = cy + lineH
            line = word
        else
            line = test
        end
    end

    if line ~= '' then
        draw.SimpleText(line, font, x, cy, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end
end

local function DrawLevel(num, x, y)
    local size = X(36)
    surface.SetDrawColor(COL_LINE)
    surface.DrawRect(x, y, size, size)
    draw.SimpleText(tostring(num), 'BP.Bold20', x + size / 2, y + size / 2, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function DrawTask(x, y)
    draw.RoundedBox(S(10), x, y, X(185), Y(42), COL_TASK)
    if mats.task and not mats.task:IsError() then
        DrawImage(mats.task, x + X(13), y + Y(11), X(20), Y(20), '')
        draw.SimpleText('Отыграть: 3/10ч', 'BP.Text20', x + X(108), y + Y(21), WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
        draw.SimpleText('Отыграть: 3/10ч', 'BP.Text20', x + X(185) / 2, y + Y(42) / 2, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local function MaxPage()
    return math.max(0, math.ceil((BP.MAX_LEVEL - 11) / 4))
end

local function SetPage(page)
    page = math.Clamp(page, 0, MaxPage())
    if page == BP.Page then return end
    BP.Page = page
    BP.TargetLevelScroll = X(BP.Page * 4 * 144)
end

local function MovePage(delta)
    SetPage(BP.Page + delta)
end

local function IsIconLevel(lvl)
    return lvl == 1 or lvl % 10 == 0
end

local function LevelMat(lvl)
    if lvl == 1 then return mats.level1 end
    if lvl == 10 then return mats.level10 end
    if lvl == 20 then return mats.level20 end
    if lvl == 30 then return mats.level30 end
    if lvl == 40 then return mats.level40 end
    if lvl == 50 then return mats.level50 end
    return mats.money
end

local function DrawReward(lvl, x, y, scroll)
    if IsIconLevel(lvl) then
        local size = X(54)
        local offset = X(-3)
        DrawImage(LevelMat(lvl), x - scroll + offset, y + offset, size, size, '')
    else
        local size = X(27)
        local offset = X(10)
        DrawImage(mats.money, x - scroll + offset, y + offset, size, size, '')
    end
end

local function DrawLevels(scroll)
    scroll = math.Round(scroll)

    local clipX = X(160)
    local clipY = Y(430)
    local clipW = X(1625)
    local clipH = Y(130)

    render.SetScissorRect(clipX, clipY, clipX + clipW, clipY + clipH, true)
    surface.SetDrawColor(COL_LINE)
    surface.DrawRect(math.Round(X(209) - scroll), Y(540) - math.max(1, Y(2)), X((BP.MAX_LEVEL - 1) * 144 + 1572), math.max(1, Y(5)))

    for i = 1, BP.MAX_LEVEL do
        local lx = math.Round(X(209 + (i - 1) * 144) - scroll)
        DrawLevel(i, lx, Y(519))
        DrawReward(i, math.Round(X(203 + (i - 1) * 144)), Y(463), scroll)
    end

    render.SetScissorRect(0, 0, 0, 0, false)
end

local function DrawTasks()
    for col = 0, 3 do
        for row = 0, 2 do
            DrawTask(X(209 + col * 203), Y(597 + row * 50))
        end
    end
end

local function DrawBattlePass()
    if mats.bg and not mats.bg:IsError() then
        surface.SetMaterial(mats.bg)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    else
        surface.SetDrawColor(BG_DIM)
        surface.DrawRect(0, 0, ScrW(), ScrH())
    end

    local cardX = X(163)
    local cardY = Y(287)
    local cardW = X(1618)
    local cardH = Y(505)

    DrawCard(cardX, cardY, cardW, cardH, S(30))
    DrawHeaderIcon(X(177), Y(307))

    DrawWrapped(
        'Arizona LVL’S - Это уникальная система уровней, за повышения уровней вы будете получать награды, титулы, бонусы! За каждое выполненое задание вы получите 1exp. Для повышения 1 уровня требуется 10exp',
        'BP.Text20', X(301), Y(311), X(555), Y(24), WHITE
    )

    DrawLevels(BP.LevelScroll)
    DrawTasks()
end

local function RefreshButtons()
    if IsValid(BP.LeftButton) then BP.LeftButton:SetVisible(BP.Page > 0) end
    if IsValid(BP.RightButton) then BP.RightButton:SetVisible(BP.Page < MaxPage()) end
end

local function ArrowPaint(self, w, h, txt)
    draw.RoundedBox(S(8), 0, 0, w, h, self:IsHovered() and Color(159, 159, 159, 95) or Color(159, 159, 159, 55))
    draw.SimpleText(txt, 'BP.Arrow', w / 2, h / 2 - S(1), WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function BP.Open()
    if IsValid(BP.Frame) then BP.Frame:Remove() end

    BP.Page = 0
    BP.LevelScroll = 0
    BP.TargetLevelScroll = 0

    local fr = vgui.Create('EditablePanel')
    BP.Frame = fr
    fr:SetSize(ScrW(), ScrH())
    fr:MakePopup()
    fr.Paint = DrawBattlePass

    fr.Think = function()
        BP.LevelScroll = Lerp(FrameTime() * 9, BP.LevelScroll, BP.TargetLevelScroll)
        if math.abs(BP.LevelScroll - BP.TargetLevelScroll) < 0.5 then BP.LevelScroll = BP.TargetLevelScroll end
        RefreshButtons()
    end

    fr.OnKeyCodePressed = function(_, key)
        if key == KEY_ESCAPE or key == KEY_F4 then
            gui.HideGameUI()
            if IsValid(fr) then fr:Remove() end
            return true
        end
    end

    local close = fr:Add('DButton')
    close:SetSize(S(48), S(48))
    close:SetPos(ScrW() - S(78), S(38))
    close:SetText('')
    close.Paint = function(self, w, h)
        draw.RoundedBox(S(8), 0, 0, w, h, self:IsHovered() and Color(255,255,255,90) or Color(255,255,255,60))
        draw.SimpleText('×', 'BP.Close', w / 2, h / 2, WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    close.DoClick = function()
        if IsValid(fr) then fr:Remove() end
    end

    local arrowSize = S(34)
    local cardX = X(163)
    local cardY = Y(287)
    local cardW = X(1618)
    local cardH = Y(505)
    local arrowY = math.Round(cardY + cardH * 0.5 - arrowSize * 0.5)

    BP.LeftButton = fr:Add('DButton')
    BP.LeftButton:SetSize(arrowSize, arrowSize)
    BP.LeftButton:SetPos(math.Round(cardX + S(16)), arrowY)
    BP.LeftButton:SetText('')
    BP.LeftButton.Paint = function(self, w, h) ArrowPaint(self, w, h, '‹') end
    BP.LeftButton.DoClick = function() MovePage(-1) end

    BP.RightButton = fr:Add('DButton')
    BP.RightButton:SetSize(arrowSize, arrowSize)
    BP.RightButton:SetPos(math.Round(cardX + cardW - arrowSize - S(16)), arrowY)
    BP.RightButton:SetText('')
    BP.RightButton.Paint = function(self, w, h) ArrowPaint(self, w, h, '›') end
    BP.RightButton.DoClick = function() MovePage(1) end

    RefreshButtons()
end

concommand.Remove('battlepass')
concommand.Add('battlepass', BP.Open)