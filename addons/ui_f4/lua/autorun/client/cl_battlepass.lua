if SERVER then return end

local BP = BP or {}

BP.BASE_W = 1921
BP.BASE_H = 1080

BP.Colors = {
    bg       = Color(42, 43, 46),
    overlay  = Color(145, 22, 22),
    line     = Color(87, 68, 72),
    task     = Color(159, 159, 159, 64),
    white    = Color(255, 255, 255),
    dimWhite = Color(255, 255, 255, 178),
}

BP.Mats = {
    -- materials/f4/battlepass/bg.png
    -- materials/f4/battlepass/1_10.png
    -- materials/f4/battlepass/11_20.png
    -- materials/f4/battlepass/reward.png
    bg     = Material('f4/battlepass/bg.png', 'smooth mips'),
    r1     = Material('f4/battlepass/1_10.png', 'smooth mips'),
    r2     = Material('f4/battlepass/11_20.png', 'smooth mips'),
    reward = Material('f4/battlepass/reward.png', 'smooth mips'),
}

local function sx(v) return math.Round(v * ScrW() / BP.BASE_W) end
local function sy(v) return math.Round(v * ScrH() / BP.BASE_H) end
local function sc(v) return math.Round(v * math.min(ScrW() / BP.BASE_W, ScrH() / BP.BASE_H)) end

local function createFonts()
    surface.CreateFont('BP.Desc', {
        font = 'Inter',
        size = sc(20),
        weight = 500,
        extended = true,
        antialias = true,
    })

    surface.CreateFont('BP.Level', {
        font = 'Inter',
        size = sc(20),
        weight = 700,
        extended = true,
        antialias = true,
    })

    surface.CreateFont('BP.Task', {
        font = 'Inter',
        size = sc(20),
        weight = 500,
        extended = true,
        antialias = true,
    })

    surface.CreateFont('BP.Close', {
        font = 'Inter',
        size = sc(42),
        weight = 800,
        extended = true,
        antialias = true,
    })
end
createFonts()
hook.Add('OnScreenSizeChanged', 'ArizonaRP.BattlePass.Fonts', createFonts)

local function drawRounded(radius, x, y, w, h, col)
    draw.RoundedBox(radius, x, y, w, h, col)
end

local function drawPoly(col, points)
    surface.SetDrawColor(col)
    draw.NoTexture()
    surface.DrawPoly(points)
end

local function drawCardGradient(x, y, w, h, r)
    drawRounded(r, x, y, w, h, BP.Colors.bg)

    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilWriteMask(255)
    render.SetStencilTestMask(255)
    render.SetStencilReferenceValue(1)
    render.SetStencilCompareFunction(STENCIL_ALWAYS)
    render.SetStencilPassOperation(STENCIL_REPLACE)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_KEEP)
    render.OverrideColorWriteEnable(true, false)
        drawRounded(r, x, y, w, h, color_white)
    render.OverrideColorWriteEnable(false, false)
    render.SetStencilCompareFunction(STENCIL_EQUAL)
    render.SetStencilPassOperation(STENCIL_KEEP)

    for i = 0, 70 do
        local t = i / 70
        local alpha = math.Clamp((t - 0.211) / (0.59 - 0.211), 0, 1) * 26
        if alpha > 0 then
            local ox = x + w * (0.15 + t * 0.92)
            drawPoly(Color(145, 22, 22, alpha), {
                {x = ox - h * 0.95, y = y + h},
                {x = ox - h * 0.62, y = y + h},
                {x = ox + h * 0.46, y = y},
                {x = ox + h * 0.13, y = y},
            })
        end
    end

    render.SetStencilEnable(false)
end

local function drawImage(mat, x, y, w, h, label)
    if mat and not mat:IsError() then
        surface.SetMaterial(mat)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(x, y, w, h)
        return
    end

    drawRounded(sc(10), x, y, w, h, Color(145, 22, 22, 90))
    surface.SetDrawColor(255, 255, 255, 35)
    surface.DrawOutlinedRect(x, y, w, h, 2)
    draw.SimpleText(label or 'PNG', 'BP.Level', x + w / 2, y + h / 2, BP.Colors.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function drawTextWrapped(textValue, fontName, x, y, maxW, lineH, col)
    surface.SetFont(fontName)
    local line = ''
    local yy = y

    for word in tostring(textValue):gmatch('%S+') do
        local test = line == '' and word or (line .. ' ' .. word)
        local tw = surface.GetTextSize(test)
        if tw > maxW and line ~= '' then
            draw.SimpleText(line, fontName, x, yy, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            yy = yy + lineH
            line = word
        else
            line = test
        end
    end

    if line ~= '' then
        draw.SimpleText(line, fontName, x, yy, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end
end

local function drawLevel(num, x, y)
    local size = sy(36)
    surface.SetDrawColor(BP.Colors.line)
    surface.DrawRect(x, y, size, size)
    draw.SimpleText(tostring(num), 'BP.Level', x + size / 2, y + size / 2, BP.Colors.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function drawTask(x, y)
    drawRounded(sc(10), x, y, sx(185), sy(42), BP.Colors.task)
    draw.SimpleText('Отыграть: 3/10ч', 'BP.Task', x + sx(92), y + sy(21), BP.Colors.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function drawBattlePass()
    if BP.Mats.bg and not BP.Mats.bg:IsError() then
        surface.SetMaterial(BP.Mats.bg)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    else
        surface.SetDrawColor(16, 16, 18, 245)
        surface.DrawRect(0, 0, ScrW(), ScrH())
        drawPoly(Color(145, 22, 22, 38), {
            {x = ScrW() * 0.55, y = 0},
            {x = ScrW(), y = 0},
            {x = ScrW(), y = ScrH()},
            {x = ScrW() * 0.2, y = ScrH()},
        })
    end

    local cardX, cardY = sx(163), sy(287)
    local cardW, cardH = sx(1618), sy(505)
    drawCardGradient(cardX, cardY, cardW, cardH, sc(30))

    drawPoly(Color(255, 136, 0, 230), {
        {x = sx(177), y = sy(307)},
        {x = sx(277), y = sy(325)},
        {x = sx(250), y = sy(406)},
        {x = sx(188), y = sy(390)},
    })
    drawPoly(Color(255, 162, 96, 220), {
        {x = sx(190), y = sy(317)},
        {x = sx(263), y = sy(332)},
        {x = sx(242), y = sy(392)},
        {x = sx(198), y = sy(380)},
    })

    drawTextWrapped(
        "Arizona LVL’S - Это уникальная система уровней, за повышения уровней вы будете получать награды, титулы, бонусы! За каждое выполненое задание вы получите 1exp. Для повышения уровня требуется 1exp",
        'BP.Desc', sx(301), sy(311), sx(555), sy(24), BP.Colors.white
    )

    surface.SetDrawColor(BP.Colors.line)
    surface.DrawRect(sx(209), sy(540) - sy(2), sx(1572), sy(5))

    for i = 1, 11 do
        local levelX = sx(209 + (i - 1) * 144)
        drawLevel(i, levelX, sy(519))

        if i == 1 then
            drawImage(BP.Mats.r1, sx(195), sy(454), sx(64), sy(65), '1-10')
        elseif i == 11 then
            drawImage(BP.Mats.r2, sx(1635), sy(459), sx(69), sy(60), '11-20')
        else
            drawImage(BP.Mats.reward, sx(347 + (i - 2) * 144), sy(463), sx(48), sy(48), 'PNG')
        end
    end

    for col = 0, 6 do
        for row = 0, 2 do
            drawTask(sx(209 + col * 203), sy(597 + row * 50))
        end
    end
end

function BP.Open()
    if IsValid(BP.Frame) then BP.Frame:Remove() end

    local fr = vgui.Create('EditablePanel')
    BP.Frame = fr
    fr:SetSize(ScrW(), ScrH())
    fr:MakePopup()

    fr.Paint = function()
        drawBattlePass()
    end

    fr.OnKeyCodePressed = function(_, key)
        if key == KEY_ESCAPE or key == KEY_F4 then
            gui.HideGameUI()
            if IsValid(fr) then fr:Remove() end
            return true
        end
    end

    local close = fr:Add('DButton')
    close:SetSize(sc(48), sc(48))
    close:SetPos(ScrW() - sc(78), sc(38))
    close:SetText('')
    close.Paint = function(self, w, h)
        drawRounded(sc(12), 0, 0, w, h, self:IsHovered() and Color(255,255,255,80) or Color(255,255,255,46))
        draw.SimpleText('×', 'BP.Close', w / 2, h / 2, BP.Colors.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    close.DoClick = function()
        if IsValid(fr) then fr:Remove() end
    end
end

concommand.Add('battlepass', BP.Open)