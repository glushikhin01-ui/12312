local matGlow = Material("sprites/light_glow02_add")

-- Регистрируем для меню, чтобы кнопка была
Orbit_Register(8, "Blood", function(ply) end) 

-- Запускаем отрисовку напрямую через хук, забив на базу
hook.Add("PostPlayerDraw", "Direct_Blood_Render_Test", function(ply)
    if not IsValid(ply) or not ply:Alive() then return end
    
    -- Проверяем, выбран ли эффект Blood (ID 8)
    if ply:GetNWInt("OrbitFX", 0) ~= 8 then return end

    local t = CurTime()
    local c = ply:GetPos()

    render.SetMaterial(matGlow)
    for i = 1, 3 do
        local a = (t * 1.5) + (i * 2.09)
        local pos = c + Vector(math.cos(a) * 60, math.sin(a) * 60, 50)

        -- Рисуем огромные красные хреновины
        render.DrawSprite(pos, 100, 100, Color(255, 0, 0, 255))
        render.DrawSprite(pos, 40, 40, Color(255, 255, 255, 255))
    end
end)