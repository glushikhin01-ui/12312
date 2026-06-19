include('shared.lua')

local DRAW_DISTANCE = 1400
local CIRCLE_DISTANCE = 1100
local SEGMENTS = 56

function ENT:Initialize()
    self:DrawShadow(false)
    if self.DestroyShadow then self:DestroyShadow() end
    self:SetRenderBounds(Vector(-96, -96, -40), Vector(96, 96, 140))
end

local function DrawRadius(ent)
    local lp = LocalPlayer()
    if not IsValid(lp) or not IsValid(ent) then return end
    if not ent:GetNWBool('F4FlagCapturing', false) then return end

    local pos = ent:GetPos()
    if lp:GetPos():DistToSqr(pos) > (CIRCLE_DISTANCE * CIRCLE_DISTANCE) then return end

    local radius = ent:GetNWInt('F4FlagRadius', 320)
    if radius <= 0 then return end

    local col = Color(255, 200, 70, 210)
    local z = pos.z + 6
    local step = math.pi * 2 / SEGMENTS
    local first
    local last

    render.SetColorMaterial()

    for i = 0, SEGMENTS do
        local a = i * step
        local p = Vector(pos.x + math.cos(a) * radius, pos.y + math.sin(a) * radius, z)
        if last then render.DrawLine(last, p, col, true) end
        first = first or p
        last = p
    end

    if first and last then
        render.DrawLine(last, first, col, true)
    end
end

hook.Add('PostDrawTranslucentRenderables', 'F4Gangs.DrawFlagRadius', function()
    for _, ent in ipairs(ents.FindByClass('f4_gang_flag')) do
        DrawRadius(ent)
    end
end)

function ENT:Draw()
    self:DrawModel()

    local lp = LocalPlayer()
    if not IsValid(lp) then return end

    local distSqr = lp:GetPos():DistToSqr(self:GetPos())
    if distSqr > (DRAW_DISTANCE * DRAW_DISTANCE) then return end

    local pos = self:GetPos() + Vector(0, 0, 70)
    local ang = Angle(0, lp:EyeAngles().y - 90, 90)
    local name = self:GetNWString('F4FlagName', 'Флаг')
    local ownerName = self:GetNWString('F4FlagGangName', '')
    local capturing = self:GetNWBool('F4FlagCapturing', false)
    local minPlayers = self:GetNWInt('F4FlagMinPlayers', 3)
    local curPlayers = self:GetNWInt('F4FlagCaptureCount', 0)
    local endTime = self:GetNWFloat('F4FlagCaptureEnd', 0)
    local startTime = self:GetNWFloat('F4FlagCaptureStart', 0)
    local nextCapture = self:GetNWFloat('F4FlagNextCapture', 0)
    local cdLeft = math.max(0, math.ceil(nextCapture - CurTime()))

    cam.Start3D2D(pos, ang, 0.08)
        local w, h = 380, capturing and 150 or 112
        draw.RoundedBox(10, -w/2, -h/2, w, h, Color(28, 29, 32, 238))
        draw.RoundedBox(8, -w/2 + 8, -h/2 + 8, w - 16, h - 16, Color(42, 43, 46, 230))

        draw.SimpleText(name, 'DermaLarge', 0, -h/2 + 30, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(ownerName ~= '' and ('Контроль: ' .. ownerName) or 'Не захвачен', 'DermaDefaultBold', 0, -h/2 + 62, ownerName ~= '' and Color(80,220,110) or Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if capturing then
            local total = math.max(1, endTime - startTime)
            local left = math.max(0, endTime - CurTime())
            local progress = math.Clamp(1 - (left / total), 0, 1)
            local barW, barH = w - 54, 14
            local bx, by = -barW/2, 14
            draw.RoundedBox(6, bx, by, barW, barH, Color(15, 15, 18, 230))
            draw.RoundedBox(6, bx, by, barW * progress, barH, Color(255, 200, 70, 230))
            draw.SimpleText('Захват: ' .. string.ToMinutesSeconds(math.ceil(left)), 'DermaDefaultBold', 0, 44, Color(255, 220, 120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText('В радиусе: ' .. curPlayers .. '/' .. minPlayers, 'DermaDefaultBold', 0, 68, curPlayers >= minPlayers and Color(80, 220, 110) or Color(220, 70, 70), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif cdLeft > 0 then
            draw.SimpleText('КД: ' .. string.ToMinutesSeconds(cdLeft), 'DermaDefaultBold', 0, 28, Color(255, 210, 80), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText('E — начать захват', 'DermaDefaultBold', 0, 24, Color(210,210,210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText('Нужно ' .. minPlayers .. ' живых участника', 'DermaDefaultBold', 0, 48, Color(210,210,210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    cam.End3D2D()
end