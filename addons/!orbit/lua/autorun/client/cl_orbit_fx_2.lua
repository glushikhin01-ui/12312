local matGlow = Material("sprites/light_glow02_add")

Orbit_Register(2, "Inferno", function(ply)
    local t = CurTime()
    local c = ply:GetPos()
    
    for i = 1, 3 do
        local a = (t * 1.8) + (i * 2.09)
        local h = 45 + math.sin(t * 3 + i) * 15
        local pos = c + Vector(math.cos(a) * 65, math.sin(a) * 65, h)
        
        render.SetMaterial(matGlow)
        
        render.DrawSprite(pos, 70, 70, Color(255, 60, 0, 150))
        render.DrawSprite(pos, 35, 35, Color(255, 180, 0, 255))
        
        for k = 1, 4 do
            local pCycle = (t * 2 + k * 0.25) % 1
            local pPos = pos + Vector(
                math.sin(t * 10 + k) * 8, 
                math.cos(t * 10 + k) * 8, 
                pCycle * 35
            )
            local size = 15 * (1 - pCycle)
            render.DrawSprite(pPos, size, size, Color(255, 100, 0, 255 * (1 - pCycle)))
        end

        local sparkPos = pos + Vector(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))
        if math.random() > 0.8 then
            render.DrawSprite(sparkPos, 10, 10, Color(255, 255, 100, 200))
        end
    end
end)