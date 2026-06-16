local matVoidBlack = CreateMaterial("Orbit_Void_Black_Final_V3", "UnlitGeneric", {
    ["$basetexture"] = "color/black",
    ["$model"] = 1,
    ["$nocull"] = 1,
    ["$vertexalpha"] = 1,
    ["$vertexcolor"] = 1
})

local matGlow = Material("sprites/light_glow02_add")

Orbit_Register(6, "Void", function(ply)
    local t = CurTime()
    local c = ply:GetPos()

    for i = 1, 3 do
        local angle = (t * 0.8) + (i * 2.09) 
        
        local centerPos = c + Vector(
            math.cos(angle) * 70,  
            math.sin(angle) * 70, 
            50 + math.sin(t * 2 + i) * 10 
        )

        render.SetMaterial(matVoidBlack) 
        render.DrawSphere(centerPos, 8, 30, 30, Color(0, 0, 0, 255))

        render.SetMaterial(matGlow)
        render.DrawSprite(centerPos, 32, 32, Color(120, 0, 255, 255)) 

        local segments = 5 
        for j = 1, segments do
            local rot = (t * 4) + (j * (math.pi * 2 / segments))
            local dDist = 18 
            local dPos = centerPos + Vector(math.cos(rot) * dDist, math.sin(rot) * dDist, math.sin(rot) * 6)
            
            render.DrawSprite(dPos, 12, 12, Color(100, 0, 255, 150))
        end

        for k = 1, 2 do 
            local pCycle = (t * 1.5 + k * 0.5) % 1
            local pDist = 55 * (1 - pCycle) 
            local pAngle = (t * 5) + (k * 180) + i 
            
            local pPos = centerPos + Vector(
                math.cos(pAngle) * pDist, 
                math.sin(pAngle) * pDist, 
                math.sin(pAngle * 2) * 5
            )

            local size = 8 * pCycle
            render.DrawSprite(pPos, size, size, Color(180, 100, 255, 255))
        end
    end
end)