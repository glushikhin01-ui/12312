local matGlow = Material("sprites/light_glow02_add")

Orbit_Register(5, "Electro", function(ply)
    local t = CurTime()
    local c = ply:GetPos()

    for i = 1, 3 do
        local a = (t * 2.5) + (i * 2.09)
        local pos = c + Vector(math.cos(a)*60, math.sin(a)*60, 55)
        
        render.SetMaterial(matGlow)
        render.DrawSprite(pos, 50, 50, Color(0, 100, 255, 80))
        
        local jitter = Vector(math.random(-2,2), math.random(-2,2), math.random(-2,2))
        render.DrawSprite(pos + jitter, 25, 25, Color(200, 255, 255, 255))

        if math.random() > 0.1 then 
            for k = 1, 2 do
                local speed = t * 2 
                local offset = k * 3.14
                
                local elPos = pos + Vector(
                    math.sin(speed + offset) * 25,
                    math.cos(speed * 0.5) * 25, 
                    math.cos(speed + offset) * 25
                )
                
                local midPoint = LerpVector(0.5, pos, elPos)
                midPoint = midPoint + Vector(math.random(-8,8), math.random(-8,8), math.random(-8,8))

                render.DrawBeam(pos, midPoint, 5, 0, 1, Color(100, 200, 255, 255))
                render.DrawBeam(midPoint, elPos, 5, 0, 1, Color(100, 200, 255, 255))
                
                render.DrawSprite(elPos, 15, 15, Color(150, 255, 255, 255))
            end
        end
    end
end)