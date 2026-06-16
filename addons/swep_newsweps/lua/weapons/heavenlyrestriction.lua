--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

if SERVER then

    AddCSLuaFile ()

end

if CLIENT then
    
    killicon.Add("heavenlyrestriction", "toji", Color(255, 255, 255))

end

SWEP.PrintName = "Heavenly Restriction: Physically Gifted"
SWEP.Author = "minwool"
SWEP.Instructions = "the one who left it all behind"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Category = "Jujutsu Kaisen"
SWEP.HoldType = "normal"
SWEP.UseHands = true

SWEP.ViewModel = ''
SWEP.WorldModel = 'models/weapons/isoh.mdl'

SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
    local ply = self:GetOwner()

    if ( IsValid(ply) ) then
        ply:GetNWBool("hr_equipped", false)
        self:SetHoldType(ply:GetNWString("hr_holdtype"))

        ply:SetNWBool("hr_equipped", false)
        ply:SetNWString("hr_holdtype", "normal")

        -- ◘ cooldowns / debounces ◘ -- 

        ply:SetNWBool("hr_heavy", false)
        ply:SetNWBool("hr_slam", false)
        ply:SetNWBool("hr_slam_got", false)
        ply:SetNWBool("hr_barrage", false)

        -- isoh
        ply:SetNWBool("hr_isoh1", false)
        ply:SetNWBool("hr_isoh2", false)

        -- chain
        ply:SetNWBool("hr_chain1", false)
        ply:SetNWBool("hr_chain2", false)

        -- soulblade
        ply:SetNWBool("hr_sb1", false)
        ply:SetNWBool("hr_sb2", false)

        -- modes
        ply:SetNWBool("hr_debounce", false)
        ply:SetNWInt("hr_mode", 1) 

        ply:SetNWBool("hr_isoh", false)

        ply:SetNWBool("hr_jump", false)
        

        ply:SetNWBool("hr_shift", false)
        ply:SetNWInt("hr_maxHP", 500)
    end
end

function SWEP:Deploy()
    local ply = self:GetOwner()

    if ( IsValid(ply) ) then
        ply:GetNWBool("hr_equipped", false)
        self:SetHoldType(ply:GetNWString("hr_holdtype"))

        ply:SetNWBool("hr_equipped", false)
        ply:SetNWString("hr_holdtype", "normal")

        -- ◘ cooldowns / debounces ◘ -- 

        ply:SetNWBool("hr_heavy", false)
        ply:SetNWBool("hr_slam", false)
        ply:SetNWBool("hr_slam_got", false)
        ply:SetNWBool("hr_barrage", false)

        -- isoh
        ply:SetNWBool("hr_isoh1", false)
        ply:SetNWBool("hr_isoh2", false)

        -- chain
        ply:SetNWBool("hr_chain1", false)
        ply:SetNWBool("hr_chain2", false)

        -- soulblade
        ply:SetNWBool("hr_sb1", false)
        ply:SetNWBool("hr_sb2", false)

        -- modes
        ply:SetNWBool("hr_debounce", false)
        ply:SetNWInt("hr_mode", 1) 

        ply:SetNWBool("hr_isoh", false)

        ply:SetNWBool("hr_jump", false)
        

        ply:SetNWBool("hr_shift", false)
        ply:SetNWInt("hr_maxHP", 500)
    end

    return true 
end

function SWEP:Holster()
    local ply = self:GetOwner()

    if IsValid(ply) then
        ply:SetJumpPower(200)
        ply:SetWalkSpeed(rp.cfg.WalkSpeed)
        ply:SetGravity(1)
        --ply:SetHealth(ply:GetMaxHealth())
        ply:SetRunSpeed(rp.cfg.RunSpeed)
    end

    return true
end

if CLIENT then
    local WorldModel = ClientsideModel(SWEP.WorldModel)

    -- Settings...
    WorldModel:SetNoDraw(true)

    function SWEP:DrawWorldModel()
        local _Owner = self:GetOwner()

        if (IsValid(_Owner)) then

            WorldModel:SetModelScale(9)

            WorldModel:SetupBones()

            if _Owner:GetNWBool("hr_mode") == 2 then -- isoh
                WorldModel:SetModel("models/weapons/isoh.mdl")
                WorldModel:SetMaterial("isoh")

                if _Owner:GetNWBool("hr_chain1") or _Owner:GetNWBool("hr_chain2") then
                    WorldModel:SetModelScale(0.1)
                end

                offsetVec = Vector(4, -1, -1)

            elseif _Owner:GetNWBool("hr_mode") == 3 then -- soul blade
                WorldModel:SetModel("models/weapons/soulblade.mdl")
                WorldModel:SetMaterial("soulblade")
                offsetVec = Vector(4, -1, -7)
            else
                WorldModel:SetModel("models/weapons/isoh.mdl")
            
                WorldModel:SetModelScale(0.1)
                return
            end


            local offsetAng = Angle(180, 0, 0)

            local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
            if !boneid then return end

            local matrix = _Owner:GetBoneMatrix(boneid)
            if !matrix then return end

            local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
           
            
            WorldModel:SetPos(newPos)
            WorldModel:SetAngles(newAng)
        
        else
            WorldModel:SetPos(self:GetPos())
            WorldModel:SetAngles(self:GetAngles())
        end

        WorldModel:DrawModel()
    end
end

function SWEP:DrawHUD()
  
    if not CLIENT then return end

    local ply = LocalPlayer()

   
    local mode = "Рукопашный"
    local color = Color(116, 63, 114)
    local color2 = Color(255, 222, 124)
    if ( ply:GetNWInt("hr_mode") == 1 ) then
        mode = "Рукопашный"
        color = Color(116, 63, 114)
    elseif ( ply:GetNWInt("hr_mode") == 2 ) then
        if (ply:GetNWBool("hr_shift")) then
            mode = "Проклятый инструмент: Перевернутое копье Небес + цепь длиной в тысячу миль"
            color = Color(121, 121, 121)
        else
            mode = "Проклятое орудие: Перевернутое копье Небес"
            color = Color(255, 255, 255)
        end
        
    elseif ( ply:GetNWInt("hr_mode") == 3 ) then
        mode = "Проклятый инструмент: Катана с расщепленной душой"
        color = Color(255, 255, 255)
    end

    draw.SimpleText("Небесное ограничение: Физически одаренный", "Trebuchet24", 60,  130, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(mode ,"Trebuchet24", 60, 160, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    -- health bar

    local health = ply:Health()
    local maxHealth = ply:GetNWInt("hr_maxHP")

    local barWidth = 500
    local barHeight = 20
    local barX = 60
    local barY = ScrH() - 850
    local healthPercentage = health / maxHealth

    local healthText = "Health: " .. health .. " / " .. maxHealth

    surface.SetFont("Trebuchet24")
    local textWidth, textHeight = surface.GetTextSize(healthText)
    surface.SetDrawColor(255, 0, 47, 78)
    surface.DrawRect(barX, barY, barWidth, barHeight)
    surface.SetDrawColor(213, 48, 87)
    surface.DrawRect(barX, barY, barWidth * healthPercentage, barHeight)

    surface.SetTextColor(255, 255, 255)
    surface.SetTextPos(barX + 10 / 2, barY - textHeight + 21)
    surface.DrawText(healthText)

end

function SWEP:Melee(ply, key)
    if ( key == IN_RELOAD ) then
        if (!ply:OnGround()) then
            
            if (ply:GetNWBool("hr_slam") or !IsValid(ply) or ply:OnGround()) then return end -- slam does not cost anything
            ply:SetNWBool("hr_slam", true)

            local range = 600
            local damage = math.random(30, 50)
            local cd = 10

            ply:SetGravity(-50)
            ply:EmitSound("fall.wav", 350, 100, 1, CHAN_STATIC)
            timer.Simple(0.2, function()
                if IsValid(ply) then
                    ply:SetGravity(50)
                end
            end)

            local function POW()
                if (!IsValid(ply)) then return end

                
                ParticleEffect( "hr_slam", ply:GetPos(), Angle(0,0,0), ent )
                ply:EmitSound("slam.wav", 350, 100, 1, CHAN_STATIC)
                util.ScreenShake( ply:GetPos(), 10, 40, 1, range, true)

                local entities = ents.FindInSphere(ply:GetPos(), range)

                for _, ent in ipairs(entities) do
                    if ent:IsValid() and ( ent ~= ply ) and ( ent:IsRagdoll() or ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle() ) and !ent:GetNWBool("barrier") then

                        if IsValid( ent:GetPhysicsObject() ) then
                            if ( ent:GetClass() == "prop_physics" ) then
                                constraint.RemoveAll(ent)
                                ent:GetPhysicsObject():EnableMotion(true)
                            end
                        end
                        
                        local dir = (ent:GetPos() - ply:GetPos()):GetNormalized()
                        local force = 50000
                        local phys = ent:GetPhysicsObject()

                        if IsValid(phys) then phys:SetVelocity(dir * force) end
                
                        if SERVER then
                            ent:TakeDamage(damage, ply, self)
                        end
                    end
                end

                ply:SetNWBool("hr_slam_got", false)
                ply:SetGravity(1)
            end

            timer.Create("hr_slam_think", 0.1, cd*10, function()
                if !ply:GetNWBool("hr_slam_got") then 
                    if ply:OnGround() then
                        POW() 
                        ply:SetNWBool("hr_slam_got", true)
                    end
                    return
                end
                
            end)

            timer.Simple(cd+5, function() 
                if !IsValid(ply) then return end
                ply:SetGravity(1) 
                ply:SetNWBool("hr_slam", false) 
                ply:SetNWBool("hr_slam_got", false) 
            
            end)
        else
            if (ply:GetNWBool("hr_barrage") or !IsValid(ply)) then return end

            local range = 500
            local damage = math.random(40, 50)
            local cooldown = 3
        
            ply:SetNWBool("hr_barrage", true)
            timer.Simple(cooldown, function() ply:SetNWBool("hr_barrage", false) end)

            self:SetHoldType("fist")
            timer.Simple(2, function() if IsValid(ply) then self:SetHoldType(ply:GetNWString("hr_holdtype")) end end)

            ply:SetAnimation(PLAYER_ATTACK1)
            ply:EmitSound("heavy_swing.wav", 340, math.random(100, 150), 1, CHAN_STATIC)

            timer.Create("hr_swingbarrage", 0.1, 7, function()
                if ( !IsValid(ply) ) then return end
                ply:EmitSound("heavy_swing.wav", 340, math.random(100, 150), 1, CHAN_STATIC)
                ply:SetAnimation(PLAYER_ATTACK1)
            end)

        
            timer.Create("barrage_think", 0.05, 20, function()

                local trace = util.TraceHull({
                    start = ply:GetShootPos(),
                    endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
                    filter = ply,
                    maxs = {45,45,45},
                    mins = {-45,-45,-45}
                })
        
                local entities = ents.FindInSphere(trace.HitPos, range)
                local lentities  = {} 
            
                for _, ent in ipairs(entities) do
                    if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle() ) and !ent:GetNWBool("barrier") then
                        table.insert(lentities, ent)
                    end
                end
        
                for _, ent in ipairs(lentities) do
                    if ( !IsValid(ent) or !SERVER or ent == p ) then return end 
                    ParticleEffect( "hr_normal", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )
                    ent:EmitSound("heavy_hit.wav", 340, math.random(100,110), 1, CHAN_STATIC)
                    ent:TakeDamage(damage, ply, self)
                    util.ScreenShake( ply:GetPos(), 10, 40, 0.5, 600, true)

                end
            end)
        end
    end
end

function SWEP:ISOH(ply, key)
    if ( key == IN_USE ) then
        if (ply:GetNWBool("hr_isoh1") or !IsValid(ply)) then return end

        ply:SetNWBool("hr_isoh1", true)

        local range = 300
        local damage = math.random(25, 45)
        local cooldown = 3

        timer.Simple(cooldown, function() ply:SetNWBool("hr_isoh1", false) end)

        self:SetHoldType("melee")
        timer.Simple(0.3, function() if IsValid(ply) then self:SetHoldType(ply:GetNWString("hr_holdtype")) end end)

        ply:SetAnimation(PLAYER_ATTACK1)
        ply:EmitSound("isoh/swing.wav", 340, math.random(100, 150), 1, CHAN_STATIC)

        timer.Create("hr_isoh_swings", 0.1, 5, function()
            if ( !IsValid(ply) ) then return end
            ply:EmitSound("isoh/swing.wav", 340, math.random(100, 150), 1, CHAN_STATIC)
            ply:SetAnimation(PLAYER_ATTACK1)
        end)
        
        timer.Create("isoh_think", 0.05, 15, function()
            local trace = util.TraceHull({
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
                filter = ply,
                maxs = {45,45,45},
                mins = {-45,-45,-45}
            })
    
            local entities = ents.FindInSphere(trace.HitPos, range)
            local lentities  = {} 
            
            for _, ent in ipairs(entities) do
                if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle() ) and !ent:GetNWBool("barrier") then
                    table.insert(lentities, ent)
                end
            end
    
            for _, ent in ipairs(lentities) do
                if ( !IsValid(ent) or !SERVER or ent == p ) then return end 
                ParticleEffect( "isoh_slash", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )
                ParticleEffect( "hr_blood", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(0,0,0), ply )
                ent:EmitSound("isoh/hit.wav", 340, math.random(100,150), 1, CHAN_STATIC)

                if ( ent:GetNWBool("limitless_infEnabled") ) then
                    ent:EmitSound("isoh/bypass.wav", 340, math.random(80,100), 1, CHAN_STATIC)
                    ent:SetNWBool("stunned", true)
                    ParticleEffect( "isoh_bypass",(ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40)), Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                end

                util.ScreenShake(ply:GetPos(), 10, 40, 0.5, 600, true)
                ent:TakeDamage(damage, ply, self)
            end
        end)
    elseif ( key == IN_RELOAD ) then
        if (ply:GetNWBool("hr_isoh2") or !IsValid(ply)) then return end

        ply:SetNWBool("hr_isoh2", true)

        local range = 600
        local damage = math.random(35, 50)
        local cooldown = 5

        timer.Simple(cooldown, function() ply:SetNWBool("hr_isoh2", false) end)

        self:SetHoldType("melee")
        timer.Simple(0.3, function() if IsValid(ply) then self:SetHoldType(ply:GetNWString("hr_holdtype")) end end)

        ply:SetAnimation(PLAYER_ATTACK1)
        ply:EmitSound("isoh/heavy_swing.wav", 340, math.random(100, 150), 1, CHAN_STATIC)

        local trace = util.TraceHull({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
            filter = ply,
            maxs = {45,45,45},
            mins = {-45,-45,-45}
        })

        local entities = ents.FindInSphere(trace.HitPos, range)
        local lentities  = {} 
        
        for _, ent in ipairs(entities) do
            if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle() ) and !ent:GetNWBool("barrier") then
                table.insert(lentities, ent)
            end
        end

        for _, ent in ipairs(lentities) do
            if ( !IsValid(ent) or !SERVER or ent == p ) then return end 
            

            timer.Create("hr_isoh_swings", 0.1, 10, function()
                if ( !IsValid(ent) ) then return end
                ParticleEffect( "isoh_slash", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )
                ParticleEffect( "hr_blood", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(0,0,0), ply )
                ent:EmitSound("isoh/heavy_hit.wav", 340, math.random(100,150), 1, CHAN_STATIC)

                if ( ent:GetNWBool("limitless_infEnabled") ) then
                    ent:EmitSound("isoh/bypass.wav", 340, math.random(80,100), 1, CHAN_STATIC)
                    ent:SetNWBool("stunned", true)
                    ParticleEffect( "isoh_bypass", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40)), Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                end
                 
            util.ScreenShake(ply:GetPos(), 10, 40, 0.5, 600, true)

            ent:TakeDamage(damage, ply, self)
            end)
           
        end

    end
end

function SWEP:SoulBlade(ply, key)
    if ( key == IN_USE ) then
        if (ply:GetNWBool("hr_sb1") or !IsValid(ply)) then return end

        ply:SetNWBool("hr_sb1", true)
        timer.Simple(2, function() ply:SetNWBool("hr_sb1", false) end)


        local range = 300
        local damage = math.random(10, 50)
        local cooldown = 3
    
        self:SetHoldType("knife")
        timer.Simple(3, function() if IsValid(ply) then self:SetHoldType(ply:GetNWString("hr_holdtype")) end end)

        ply:SetAnimation(PLAYER_ATTACK1)
        ply:EmitSound("soulblade/swing.wav", 340, math.random(100, 150), 1, CHAN_STATIC)

        timer.Create("hr_soulblade_swings2", 0.1, 5, function()
            if ( !IsValid(ply) ) then return end
            ply:EmitSound("soulblade/swing.wav", 340, math.random(100, 150), 1, CHAN_STATIC)
            ply:SetAnimation(PLAYER_ATTACK1)
        end)

        
        timer.Create("soulblade2_think", 0.05, 15, function()
            local trace = util.TraceHull({
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
                filter = ply,
                maxs = {45,45,45},
                mins = {-45,-45,-45}
            })
    
            local entities = ents.FindInSphere(trace.HitPos, range)
            local lentities  = {} 
          
            for _, ent in ipairs(entities) do
                if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle() ) and !ent:GetNWBool("barrier") then
                    table.insert(lentities, ent)
                end
            end
    
            for _, ent in ipairs(lentities) do
                if ( !IsValid(ent) or !SERVER or ent == p ) then return end 
                ParticleEffect( "soulblade_slash", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )
                ParticleEffect( "hr_blood", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(0,0,0), ply )
                ent:EmitSound("soulblade/heavy_hit.wav", 340, math.random(100,150), 1, CHAN_STATIC)
                ent:TakeDamage(damage, ply, self)
                util.ScreenShake(ply:GetPos(), 10, 40, 0.5, 600, true)

            end
        end)
    elseif ( key == IN_RELOAD ) then
        if (ply:GetNWBool("hr_sb2") or !IsValid(ply)) then return end

        ply:SetNWBool("hr_sb2", true)

        local range = 300
        local damage = math.random(10, 50)
        local cooldown = 5

        self:SetHoldType("grenade")
        timer.Simple(cooldown, function() ply:SetNWBool("hr_sb2", false) end)

        ply:SetAnimation(PLAYER_ATTACK1)
        ply:EmitSound("soulblade/swing.wav", 340, math.random(100, 150), 1, CHAN_STATIC)

        timer.Simple(0.3, function() if IsValid(ply) then self:SetHoldType(ply:GetNWString("hr_holdtype")) end end)

        local trace1 = util.TraceHull({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * range*2),
            filter = function(ent) return ( ent:GetClass() == "prop_physics" ) end,
            maxs = {45, 45, 45},
            mins = {-45, -45, -45}
        })

        local trace2 = util.TraceHull({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
            filter = ply,
            maxs = {45, 45, 45},
            mins = {-45, -45, -45}
        })


        local entities = ents.FindInSphere(trace2.HitPos, range)
        local lentities  = {} 
      
        for _, ent in ipairs(entities) do
            if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle() ) and !ent:GetNWBool("barrier") then
                table.insert(lentities, ent)
            end
        end

     
        for _, ent in ipairs(lentities) do
        
            if ( !IsValid(ent) or !SERVER ) then return end 
            ent:EmitSound("soulblade/ding.wav", 400, math.random(100,150), 1, CHAN_STATIC)


        end
        timer.Simple(0.5, function()
            timer.Create("hr_soulblade_swings2", 0.01, 50, function()
                for _, ent in ipairs(lentities) do
            
                    if ( !IsValid(ent) or !SERVER ) then return end 
                    ParticleEffect( "soulblade_slash", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )
                    ParticleEffect( "hr_blood", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(0,0,0), ply )
                    ent:EmitSound("soulblade/heavy_hit.wav", 340, math.random(100,150), 1, CHAN_STATIC)

                    util.ScreenShake(ent:GetPos(), 10, 40, 0.5, 600, true)

                    ent:TakeDamage(damage, ply, self)

                end
            end)
        end)


        local eye = ply:EyeAngles()
        if IsValid(ply) and SERVER then
            local trail = util.SpriteTrail( ply, 0, Color( 255, 255, 255), false, 150, 1, 4, 1 / ( 150 + 1 ) * 0.5, "effects/beam_generic01" )
            timer.Simple(0.3, function()
                SafeRemoveEntity(trail)
            end)
        end
        ply:EmitSound("soulblade/steel.wav", 500, math.random(100,150), 1, CHAN_STATIC)

        timer.Simple(0.1, function()
            ply:SetPos(trace1.HitPos)
        end)
        
        timer.Simple(0.3, function()
            ParticleEffect( "hr_slam2", ply:GetPos(), Angle(0,0,0), ent )
        end)
    end
end

function SWEP:Chain(ply, key)
    if ( key == IN_USE ) then
        if (ply:GetNWBool("hr_chain1") or !IsValid(ply)) then return end

        ply:SetNWBool("hr_chain1", true)

        local detectRange = 300
        local damage = math.random(35, 60)
        local cooldown = 3
        local duration = 2
        local speed = 1000

        timer.Simple(cooldown, function() ply:SetNWBool("hr_chain1", false) end)

        self:SetHoldType("melee")
        timer.Simple(0.3, function() if IsValid(ply) then self:SetHoldType(ply:GetNWString("hr_holdtype")) end end)

        ply:SetAnimation(PLAYER_ATTACK1)
        ply:EmitSound("chain/chain.wav", 340, math.random(100, 150), 1, CHAN_STATIC)

        if SERVER then
            self.isoh = ents.Create("prop_dynamic")
        end

        if ( IsValid(self.isoh) ) then
            self.isoh:SetModel("models/weapons/isoh.mdl")
            self.isoh:SetMaterial("isoh")
            self.isoh:SetColor(Color(255, 255, 255))
            self.isoh:SetRenderMode( RENDERMODE_TRANSALPHA )
            self.isoh:SetModelScale(9)
            self.isoh:SetMoveType( MOVETYPE_NOCLIP )
            self.isoh:DrawShadow(false)
            
            self.isoh:Spawn()

            ply.isoh = self.isoh

            self.isoh:SetAngles(ply:EyeAngles() + Angle(90,0,0))
        end

        local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * 100),
            filter = ply
        })

        local dir = (trace.HitPos - ply:EyePos()):GetNormalized()
        local movement = dir * speed

        if IsValid(self.isoh) then
            self.isoh:SetPos(trace.HitPos)
            local rope = constraint.Rope(self.isoh, ply, 0, 0, Vector(0, 0, 0), Vector(0, 0, 0), 100, 3000, 0, 20, "isoh_chain", Color(255,255,255))

        end

        timer.Create("chain_think", 0.01, duration*10, function()

            if (!IsValid(self.isoh)) then return end

            self.isoh:SetPos(self.isoh:GetPos() + movement * 0.1)

            local entities = ents.FindInSphere(self.isoh:GetPos(), detectRange)
            local lentities  = {} 
            
            for _, ent in ipairs(entities) do
                if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle() ) and !ent:GetNWBool("barrier") and ent ~= self.isoh then
                    table.insert(lentities, ent)
                end
            end
            ParticleEffect( "hr_slash_trail", self.isoh:GetPos(), Angle(0,0,0), ply )

            for _, ent in ipairs(lentities) do
                if ( !IsValid(ent) or !SERVER or ent == p ) then return end 
                ParticleEffect( "isoh_slash", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )
                ParticleEffect( "hr_blood", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()) + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(0,0,0), ply )
                ent:EmitSound("isoh/heavy_hit.wav", 340, math.random(100,150), 1, CHAN_STATIC)

                if ( ent:GetNWBool("limitless_infEnabled") ) then
                    ent:EmitSound("isoh/bypass.wav", 340, math.random(80,100), 1, CHAN_STATIC)
                    ent:SetNWBool("stunned", true)
                    ParticleEffect( "isoh_bypass", self.isoh:GetPos(), Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                end
                ent:EmitSound("chain/hit.wav", 400, math.random(80, 100), 1, CHAN_STATIC)

                util.ScreenShake(ply:GetPos(), 10, 40, 0.5, 600, true)
                ent:TakeDamage(damage, ply, self)
            end

            if (!ply:Alive() or !IsValid(ply)) then
                if (IsValid(ply.isoh)) then
                    ply.isoh:Remove()
                end
            end
        end)

        timer.Simple(duration-1.5, function()
            if (IsValid(self.isoh)) then
                self.isoh:Remove()
            end
        end)
    elseif ( key == IN_RELOAD ) then
        if (ply:GetNWBool("hr_chain2") or !IsValid(ply)) then return end

        ply:SetNWBool("hr_chain2", true)

        local detectRange = 600
        local damage = math.random(20, 40)
        local cooldown = 0.5
        local duration = 1
        local speed = 1000

        self:SetHoldType("melee")
        timer.Simple(0.3, function() if IsValid(ply) then self:SetHoldType(ply:GetNWString("hr_holdtype")) end end)

        ply:SetAnimation(PLAYER_ATTACK1)
        ply:EmitSound("chain/chain.wav", 340, math.random(100, 150), 1, CHAN_STATIC)
        
        if SERVER then
            self.isohT = ents.Create("prop_dynamic")
        end

        if ( IsValid(self.isohT) ) then
            self.isohT:SetModel("models/weapons/isoh.mdl")
            self.isohT:SetMaterial("isoh")
            self.isohT:SetColor(Color(255, 255, 255))
            self.isohT:SetRenderMode( RENDERMODE_TRANSALPHA )
            self.isohT:SetModelScale(9)
            self.isohT:SetMoveType( MOVETYPE_NOCLIP )
            self.isohT:DrawShadow(false)
            
            self.isohT:Spawn()

            ply.isohT = self.isohT

            self.isohT:SetAngles(ply:EyeAngles() + Angle(90,0,0))
        end

        local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * 10000),
            filter = ply,
            maxs = {360,360,360},
            mins = {-360,-360,-360}
        })

        local ent = trace.Entity


        if IsValid(ent) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle()  and !ent:GetNWBool("barrier") ) then
            if (!IsValid(self.isohT)) then return end
            cooldown = 3
        
            if ( !IsValid(ent) or !SERVER ) then return end 
        
            local chain = constraint.Rope(self.isohT, ply, 0, 0, Vector(0, 0, 0), Vector(0, 0, 0), 100, 3000, 0, 20, "isoh_chain", Color(255,255,255))

            util.ScreenShake(ply:GetPos(), 10, 40, 0.5, 600, true)
        
            ent:EmitSound("chain/hit.wav", 400, math.random(80, 100), 1, CHAN_STATIC)
            ent:EmitSound("soulblade/heavy_hit.wav", 400, math.random(80, 100), 1, CHAN_STATIC)

            ParticleEffect( "hr_slam2", ent:GetPos(), Angle(0,0,0), ply )
            ParticleEffect( "hr_blood", (ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward()), Angle(0,0,0), ply )

            
            timer.Create("chain_think2", 0.1, duration*10, function()
                if (!IsValid(self.isohT) or !IsValid(ent)) then return end
                self.isohT:SetPos(ent:GetPos() + Vector(0,0,40))
            end)

            timer.Simple(0.7, function()
                SafeRemoveEntity(chain)
                ent:EmitSound("chain/chain.wav", 400, 100, 1, CHAN_STATIC)
    
                local pos = ply:EyePos() +  ply:GetAimVector() * 150
                ent:SetPos(pos)
                ParticleEffect( "hr_slam2", ent:GetPos(), Angle(0,0,0), ply )
                ent:EmitSound("fall.wav", 400, math.random(80, 100), 1, CHAN_STATIC)

            end)
        else
            if (!IsValid(self.isohT)) then return end
            self.isohT:Remove()
        end

        timer.Simple(cooldown, function() ply:SetNWBool("hr_chain2", false) end)

        timer.Simple(duration, function()
            if (!IsValid(self.isohT)) then return end
            self.isohT:Remove()
        end)
  
        
    end
end

function SWEP:KeyPress(ply, key)
    if key == IN_USE or key == IN_RELOAD then
        if ply:GetNWInt("hr_mode") == 1 then
            self:Melee(ply, key)
        elseif ply:GetNWInt("hr_mode") == 2 and !ply:GetNWBool("hr_shift") then
            self:ISOH(ply, key)
        elseif ply:GetNWInt("hr_mode") == 2 and ply:GetNWBool("hr_shift") then
            self:Chain(ply, key)
        elseif ply:GetNWInt("hr_mode") == 3 then
            self:SoulBlade(ply, key)
        else
            self:Melee(ply, key) 
        end
    end
end

function SWEP:DoPunch(condition) -- catch these hands
    local ply = self:GetOwner()
    
    if ( !IsValid(ply) or !SERVER or ply:GetNWBool("hr_normal")) then return end
    ply:SetNWBool("hr_normal", true)

    local swing   = {'swing.wav','swing2.wav'}
    local hit     = 'hit.wav'

    local damage = math.random(20, 40)
    local range = 300

    local cooldown = 0.2

    if ( condition == 1 ) then
       
        self:SetHoldType('knife')
        damage = damage*1.5
        hit = "isoh/hit.wav"
        swing   = 'isoh/swing.wav'
        range = 300
        ply:EmitSound(swing, 340, math.random(100,200), 1, CHAN_STATIC)


    elseif ( condition == 2 ) then
        self:SetHoldType('melee')
        hit    = "soulblade/hit.wav"
        swing  = "soulblade/swing.wav"
        damage = damage*1.5
        cooldown = 0.5
        range = 300
        ply:EmitSound(swing, 340, math.random(80,110), 1, CHAN_STATIC)

    else
        self:SetHoldType('fist')
        ply:EmitSound(swing[math.random(#swing)], 340, math.random(90,100), 1, CHAN_STATIC)

    end

    local trace = util.TraceHull({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
        filter = ply,
        maxs = {45,45,45},
        mins = {-45,-45,-45}
      
    })

    local entities = ents.FindInSphere(trace.HitPos, 100)
    local lentities  = {} 

    for _, ent in ipairs(entities) do
        if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle() ) and !ent:GetNWBool("barrier") then
            table.insert(lentities, ent)
        end
    end

    

    timer.Simple(cooldown, function() ply:SetNWBool("hr_normal", false) end)

    ply:SetAnimation(PLAYER_ATTACK1)
    timer.Simple(0.5, function() if IsValid(ply) then self:SetHoldType(ply:GetNWString("hr_holdtype")) end end)

    if #lentities > 0 then
        
        if (condition == 1) then
            ParticleEffect( "isoh_slash", trace.HitPos, Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
        elseif (condition == 2) then
            ParticleEffect( "soulblade_slash", trace.HitPos, Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )

        else
            ParticleEffect( "hr_normal", trace.HitPos, Angle(0,0,0), ply )

        end
        
    else return end

    for _, ent in ipairs(lentities) do

        if ( IsValid(ent) and SERVER ) then
        
            util.ScreenShake( ply:GetPos(), 10, 40, 0.5, 100, true)

            local phys = ent:GetPhysicsObject()

            if ( IsValid(phys) ) then
                local dir = (ent:GetPos() - ply:GetPos()):GetNormalized()
                local force = 500
                if IsValid(phys) then phys:SetVelocity(dir * force) end
            end

            if ( condition == 1 ) then
                
                if ( !ent:IsValid() ) then return end
                if ( ent:GetNWBool("limitless_infEnabled") and !ent:GetNWBool("stunned_got") ) then
                   
                    ent:SetNWBool("stunned", true)
                    ent:EmitSound("isoh/bypass.wav", 340, math.random(80,100), 1, CHAN_STATIC)
                    ParticleEffect( "isoh_bypass", trace.HitPos, Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
            
                end

                if (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then
                    ParticleEffect( "hr_blood", trace.HitPos, Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                end
        
            elseif ( condition == 2 ) then
                
                if (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then
                    ParticleEffect( "hr_blood", trace.HitPos, Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                end
            end

            ent:EmitSound(hit, 340, math.random(80, 100), 1, CHAN_STATIC)
            ent:TakeDamage(damage, ply, self)       
        end
    end
    

end

function SWEP:DoHeavy(condition) -- catch this hand
    local ply = self:GetOwner()
    
    if ( !IsValid(ply) or !SERVER or ply:GetNWBool("hr_heavy") ) then return end

    ply:SetNWBool("hr_heavy", true)

    local swing   = 'heavy_swing.wav'
    local hit     = 'heavy_hit.wav'
    local cooldown = 0.5
    local damage = math.random(20, 50)
    local range = 300

    if ( condition == 1 ) then
        self:SetHoldType('melee')

        damage = damage*1.5
        hit    = "isoh/heavy_hit.wav"
        swing  = 'isoh/heavy_swing.wav'
        range  = 300
    elseif ( condition == 2 ) then
        self:SetHoldType('melee2')
        hit    = "soulblade/heavy_hit.wav"
        swing  = "soulblade/heavy_swing.wav"
        damage = damage*1.5
        range  = 300
    else
        self:SetHoldType('melee')
       
    end

    ply:EmitSound(swing, 340, math.random(90,100), 1, CHAN_STATIC)
    ply:SetAnimation(PLAYER_ATTACK1)

    timer.Simple(cooldown, function() ply:SetNWBool("hr_heavy", false) self:SetHoldType(ply:GetNWString("hr_holdtype")) end)
    
    local trace = util.TraceHull({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
        filter = ply,
        maxs = {45,45,45},
        mins = {-45,-45,-45}
    })

    local entities = ents.FindInSphere(trace.HitPos, 100)
    local lentities  = {} 

    for _, ent in ipairs(entities) do
        if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:GetClass() == "prop_physics" or ent:IsVehicle() and !ent:GetNWBool("barrier") ) then
            table.insert(lentities, ent)
        end
    end
   
    ply:EmitSound(swing, 340, math.random(90,100), 1, CHAN_STATIC)
    
    if #lentities > 0 then
        
        if (condition == 1) then
            timer.Create("hr_isoh_slashes", 0, 3, function()
                if (!IsValid(ply)) then return end
                ParticleEffect( "isoh_slash", trace.HitPos+ Vector(math.random(-40,40), math.random(-40,40), 40), Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
            end)

            
        elseif (condition == 2) then
            timer.Create("hr_soulblade_slashes", 0, 2, function()
                if (!IsValid(ply)) then return end
                ParticleEffect( "soulblade_slash", trace.HitPos + Vector(math.random(-40,40), math.random(-40,40), 40), Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
            end)
        else
            ParticleEffect( "hr_normal", trace.HitPos, Angle(0,0,0), ply )
            ParticleEffect( "hr_normal", trace.HitPos, Angle(0,0,0), ply )

        end
        
    else return end

    for _, ent in ipairs(lentities) do

        if ( IsValid(ent) and SERVER ) then
        
            util.ScreenShake( ply:GetPos(), 10, 40, 0.5, 100, true)

            local phys = ent:GetPhysicsObject()

            if ( IsValid(phys) ) then
                local dir = (ent:GetPos() - ply:GetPos()):GetNormalized()
                local force = 5000
                if IsValid(phys) then phys:SetVelocity(dir * force) end
            end

            if ( condition == 1 ) then
                
                if ( !ent:IsValid() ) then return end
                if ( ent:GetNWBool("limitless_infEnabled") ) then
                    ent:EmitSound("isoh/bypass.wav", 340, math.random(80,100), 1, CHAN_STATIC)
                    ent:SetNWBool("stunned", true)
                    ParticleEffect( "isoh_bypass", trace.HitPos, Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                end
        
                if (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then
                    ParticleEffect( "hr_heavy_blood", trace.HitPos, Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                end
        
            elseif ( condition == 2 ) then
                
                if (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then
                    ParticleEffect( "hr_heavy_blood", trace.HitPos, Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                end
            end

            ent:EmitSound(hit, 340, math.random(80, 100), 1, CHAN_STATIC)
            ent:TakeDamage(damage, ply, self)       
        end
    end

end

function SWEP:PrimaryAttack() 
    local ply = self:GetOwner()
    if ( !ply:IsValid() ) then return end

    if ( ply:GetNWInt("hr_mode") == 2 ) then
        self:DoPunch(1)
    elseif ( ply:GetNWInt("hr_mode") == 3 ) then
        self:DoPunch(2)
    else
        self:DoPunch(0)
    end

end

function SWEP:SecondaryAttack() 
    local ply = self:GetOwner()
    if ( !ply:IsValid() ) then return end
    if ( ply:GetNWInt("hr_mode") == 2 ) then
        self:DoHeavy(1)
    elseif ( ply:GetNWInt("hr_mode") == 3 ) then
        self:DoHeavy(2)
    else
        self:DoHeavy(0)
    end

end

local function SwitchMode(ply)
    if ( ply:GetNWBool("hr_debounce") or !ply:IsValid() ) then return end
    ply:SetNWBool("hr_debounce", true)

    timer.Simple(0.01, function()
        ply:SetNWBool("hr_debounce", false)
    end)

    if ply:GetNWBool("hr_shift") then
        -- go back a mode
        local current = ply:GetNWInt("hr_mode")
        ply:SetNWInt("hr_mode", current - 1)

        if ply:GetNWInt("hr_mode") <= 0 then
            ply:SetNWInt("hr_mode", 3)
        end

        return
    end

    -- go up a mode

    local current = ply:GetNWInt("hr_mode")
    ply:SetNWInt("hr_mode", current + 1)

    if ply:GetNWInt("hr_mode") > 3 then
        ply:SetNWInt("hr_mode", 1)
    end



end

hook.Add("GetFallDamage", "hr_GetFallDamage", function(ply)
    if IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "heavenlyrestriction" then
        return 0
    end
end)

hook.Add("PlayerButtonDown", "hr_SwitchModes", function(ply, button)
    if !ply:Alive() then return end
    if ( button == KEY_LALT and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "heavenlyrestriction" ) then
        SwitchMode(ply)
    end
end)

hook.Add("KeyPress", "hr", function(ply, key)
    
    if ply:InVehicle() then return end

    local weapon = ply:GetActiveWeapon()

    if IsValid(weapon) and weapon.KeyPress then
        weapon:KeyPress(ply, key)
    end

end)

function SWEP:Think()
    local ply = self:GetOwner()

    if not self.DealyHP then self.DealyHP = 0 end

    if ( !IsValid(ply) ) then return end

    if ply:GetMaxHealth() < ply:GetNWInt("hr_maxHP")then  
        ply:SetHealth(ply:GetNWInt("hr_maxHP"))
        ply:SetMaxHealth(ply:GetNWInt("hr_maxHP"))
    end

    if SERVER then
        if ply:Team() != TEAM_TOJI then
            ply:Kill()
            rp.Notify(ply, NOTIFY_ERROR, 'Нельзя брать этот свеп!')
        end
    end

    if ( ply:GetNWInt("hr_mode") == 1 and ply:GetNWString("hr_holdtype") ~= 'normal') then
        ply:SetNWString("hr_holdtype", "normal")
        self:SetHoldType(ply:GetNWString("hr_holdtype"))

    elseif ( ply:GetNWInt("hr_mode") == 2 and ply:GetNWString("hr_holdtype") ~= 'knife' and !ply:GetNWBool("hr_shift")) then
        ply:SetNWString("hr_holdtype", "knife")
        self:SetHoldType(ply:GetNWString("hr_holdtype"))
        ply:EmitSound("isoh/equip.wav", 340, math.random(90,100), 1, CHAN_STATIC)
 
    elseif ( ply:GetNWInt("hr_mode") == 3 and ply:GetNWString("hr_holdtype") ~= 'melee2' ) then
        ply:SetNWString("hr_holdtype", "melee2")
        self:SetHoldType(ply:GetNWString("hr_holdtype"))
        ply:EmitSound("soulblade/equip.wav", 340, math.random(100,200), 1, CHAN_STATIC)

    end
    
    if ply:GetNWBool("hr_shift") and ply:GetNWInt("hr_mode" ) == 2 and ply:GetNWString("hr_holdtype") ~= 'melee2' then
        ply:SetNWString("hr_holdtype", "melee2")
        self:SetHoldType(ply:GetNWString("hr_holdtype"))
        ply:EmitSound("chain/equip.wav", 340, math.random(90,100), 1, CHAN_STATIC)

    end

    --[[local maxHealth = ply:GetNWInt("hr_maxHP")
    if ply:Health() < maxHealth and self.DealyHP < CurTime() then
        ply:SetHealth(math.Clamp(ply:Health() + 10, 0, maxHealth)) 

        self.DealyHP = CurTime() + 0.5
    end]]

    if ply:KeyDown(IN_SPEED) then
        ply:SetNWBool("hr_shift", true)

    elseif ply:GetNWBool("hr_shift") then
        ply:SetNWBool("hr_shift", false)
    end

    if not ply:GetNWBool("hr_equipped") then
       -- ply:SetHealth(ply:GetNWInt("hr_maxHP"))
        ply:SetNWBool("hr_equipped", true)
        ply:SetJumpPower(350)
        
    end
    ply:SetWalkSpeed(450)
    ply:SetRunSpeed(650)

    if !ply:GetNWBool("hr_slam") then
        ply:SetGravity(1)
    end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
