local matGlow = Material("sprites/light_glow02_add")

Orbit_Register(3, "Neon", function(ply)
    local t = CurTime()
    local c = ply:GetPos()
    
    for i = 1, 3 do
        local a1 = (t * 2) + (i * 2.09)
        local pos1 = c + Vector(math.cos(a1)*60, math.sin(a1)*60, 35)
        render.SetMaterial(matGlow)
        render.DrawSprite(pos1, 55, 55, Color(255, 0, 255)) 
        render.DrawSprite(pos1, 25, 25, Color(255, 255, 255))
    end

    for k = 1, 3 do
        local a2 = (t * -2) + (k * 2.09) 
        local pos2 = c + Vector(math.cos(a2)*60, math.sin(a2)*60, 55)
        render.SetMaterial(matGlow)
        render.DrawSprite(pos2, 55, 55, Color(0, 255, 255))
        render.DrawSprite(pos2, 25, 25, Color(255, 255, 255))
    end
end)