local matGlow = Material("sprites/light_glow02_add")
local matChars = {"0", "1", "A", "Z", "X", "9"}
local cache = {}

Orbit_Register(1, "Matrix", function(ply)
    local t = CurTime()
    local c = ply:GetPos()
    if not cache[ply] then cache[ply] = {} end

    for i = 1, 3 do
        local a = (t * 1.5) + (i * 2.09)
        local pos = c + Vector(math.cos(a)*60, math.sin(a)*60, 45 + math.sin(t*3+i)*10)
        
        render.SetMaterial(matGlow)
        render.DrawSprite(pos, 60, 60, Color(0,255,0))
        render.DrawSprite(pos, 40, 40, Color(255,255,255))

        if math.random() < 0.05 then
            table.insert(cache[ply], {p=pos, v=Vector(0,0,15), t=table.Random(matChars), d=CurTime()+1})
        end
    end

    local ang = EyeAngles()
    ang:RotateAroundAxis(ang:Right(), 90); ang:RotateAroundAxis(ang:Up(), -90)
    for k, v in pairs(cache[ply]) do
        v.p = v.p + v.v * FrameTime()
        if v.d < t then cache[ply][k] = nil continue end
        cam.Start3D2D(v.p, ang, 0.2)
        draw.SimpleText(v.t, "DermaLarge", 0,0, Color(0,255,0, (v.d-t)*255), 1, 1)
        cam.End3D2D()
    end
end)