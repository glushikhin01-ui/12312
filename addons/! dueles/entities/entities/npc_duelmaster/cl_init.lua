include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH

-- ─── Вспомогательные ─────────────────────────────────────────
local color_white = Color(255, 255, 255)
local color_black = Color(0,   0,   0)
local color_red   = Color(220, 60,  60)
local color_orange= Color(255, 140, 30)

local complex_off = Vector(0, 0, 9)
local simple_off  = Vector(0, 0, 75)
local ang         = Angle(0, 90, 90)

-- Иконка (используем ту же что в аукционере либо любую другую)
local icon = Material("materials/hud/scrutiny.png", "noclamp smooth")

surface.CreateFont("DuelNPC_Label",  { font = "Roboto", size = 60, weight = 800 })
surface.CreateFont("DuelNPC_Sub",    { font = "Roboto", size = 32, weight = 400 })
surface.CreateFont("DuelNPC_Hint",   { font = "Roboto", size = 28, weight = 400 })

-- ─── Draw ─────────────────────────────────────────────────────
function ENT:Draw()
    self:DrawModel()

    -- Позиция метки над головой
    local bone = self:LookupBone("ValveBiped.Bip01_Head1")
    local pos
    if bone then
        pos = self:GetBonePosition(bone) + complex_off
    else
        pos = self:GetPos() + simple_off
    end

    ang.y = LocalPlayer():EyeAngles().y - 90

    local inView, dist = self:InDistance(150000)
    if not inView then return end

    local alpha = math.Clamp(255 - dist / 590, 0, 255)

    -- Анимация покачивания
    local sway = math.sin(CurTime() * math.pi) * 30

    cam.Start3D2D(pos, ang, 0.03)
        -- Иконка
        surface.SetDrawColor(255, 255, 255, alpha)
        surface.SetMaterial(icon)
        surface.DrawTexturedRect(-55, -246 + sway - 10, 128, 128)

        -- Основной заголовок
        local cw = color_white:Copy() cw.a = alpha
        local cb = color_black:Copy() cb.a = alpha
        draw.SimpleTextOutlined("ДУЭЛИ", "DuelNPC_Label", 0, sway - 10,
            Color(220, 60, 60, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, cb)

        -- Подпись
        draw.SimpleTextOutlined("Арены • Ставки • Оружие", "DuelNPC_Sub", 0, sway + 60,
            Color(255, 140, 30, alpha * 0.85), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, cb)
    cam.End3D2D()

    -- Подсказка [E] когда близко
    if dist < 8000 then
        local hintAlpha = math.Clamp(255 - dist / 32, 0, 255)
        local hintPos   = pos + Vector(0, 0, -40)

        cam.Start3D2D(hintPos, ang, 0.02)
            draw.SimpleTextOutlined("[E] Открыть меню дуэлей", "DuelNPC_Hint", 0, 0,
                Color(230, 235, 245, hintAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, cb)
        cam.End3D2D()
    end
end

-- ─── Сигнал от сервера → открыть меню ────────────────────────
net.Receive("Duels_OpenMenu", function()
    if DuelMenu then
        DuelMenu()
    end
end)
