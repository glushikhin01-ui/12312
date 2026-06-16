local matGlow = Material("sprites/light_glow02_add")

Orbit_Register(4, "Frost", function(ply)
    local t = CurTime()
    local c = ply:GetPos()
    for i = 1, 3 do
        local a = (t * -1.2) + (i * 2.09)
        local pos = c + Vector(math.cos(a)*60, math.sin(a)*60, 45)

        render.SetMaterial(matGlow)
        render.DrawSprite(pos, 50, 50, Color(0, 255, 255))
        render.DrawSprite(pos, 25, 25, Color(255, 255, 255))

        local p2 = pos + Vector(math.sin(t*10)*5, math.cos(t*10)*5, 0)
        render.DrawSprite(p2, 15, 15, Color(200, 255, 255, 150))
    end
end)