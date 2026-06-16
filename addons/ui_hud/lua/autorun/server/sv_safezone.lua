SafeZones = SafeZones or {}

SafeZones.Zones = {
    { Vector(-1474.383911, -1127.803345, -200), Vector(-2353.728516, -2006.004395, 600) },
}

function SafeZones.IsInZone(pos)
    for _, zone in ipairs(SafeZones.Zones) do
        local p1, p2 = zone[1], zone[2]
        local minX = math.min(p1.x, p2.x)
        local maxX = math.max(p1.x, p2.x)
        local minY = math.min(p1.y, p2.y)
        local maxY = math.max(p1.y, p2.y)
        local minZ = math.min(p1.z, p2.z)
        local maxZ = math.max(p1.z, p2.z)

        if pos.x >= minX and pos.x <= maxX
            and pos.y >= minY and pos.y <= maxY
            and pos.z >= minZ and pos.z <= maxZ then
            return true
        end
    end
    return false
end

util.AddNetworkString("SafeZone_Status")

local playerInZone = {}

timer.Create("SafeZone_Check", 0.25, 0, function()
    for _, ply in ipairs(player.GetAll()) do
        if IsValid(ply) and ply:Alive() then
            local inZone = SafeZones.IsInZone(ply:GetPos())
            local wasInZone = playerInZone[ply] or false

            if inZone ~= wasInZone then
                playerInZone[ply] = inZone

                net.Start("SafeZone_Status")
                net.WriteBool(inZone)
                net.Send(ply)

                if inZone then
                    ply:GodEnable()
                else
                    ply:GodDisable()
                end
            end
        end
    end
end)

hook.Add("EntityTakeDamage", "SafeZone_BlockDamage", function(target, dmginfo)
    if target:IsPlayer() and IsValid(target) and target:Alive() then
        if SafeZones.IsInZone(target:GetPos()) then
            dmginfo:SetDamage(0)
            dmginfo:ScaleDamage(0)
            return true
        end
    end
end)

hook.Add("PlayerDisconnected", "SafeZone_Cleanup", function(ply)
    playerInZone[ply] = nil
end)

hook.Add("PlayerSpawn", "SafeZone_Spawn", function(ply)
    timer.Simple(0.1, function()
        if IsValid(ply) then
            local inZone = SafeZones.IsInZone(ply:GetPos())
            playerInZone[ply] = inZone
            
            net.Start("SafeZone_Status")
            net.WriteBool(inZone)
            net.Send(ply)

            if inZone then
                ply:GodEnable()
            else
                ply:GodDisable()
            end
        end
    end)
end)