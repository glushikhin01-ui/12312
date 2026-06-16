local matGlow = Material("sprites/light_glow02_add")

Orbit_Register(7, "Holy", function(ply)
    local t = CurTime()
    local c = ply:GetPos()
    for i = 1, 3 do
        local a = (t * 1.0) + (i * 2.09)
        local pos = c + Vector(math.cos(a)*60, math.sin(a)*60, 45)
        
        render.SetMaterial(matGlow)
        render.DrawSprite(pos, 80, 80, Color(255,220,100,100))
        render.DrawSprite(pos, 40, 40, Color(255,255,255))
    end
end)