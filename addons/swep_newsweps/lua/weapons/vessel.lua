--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher


if ( SERVER ) then
    
    AddCSLuaFile ()

end


SWEP.PrintName = "Sukuna's Vessel"
SWEP.Author = "minwool"
SWEP.Instructions = "The cage for The King of Curses"

SWEP.Category  = "Личное оружие"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "normal"
SWEP.UseHands = true

SWEP.ViewModel = 'models/weapons/c_arms_citizen.mdl'
SWEP.WorldModel = ''

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

local defaultHoldType = "Normal"

-- hello code dweller

if CLIENT then
    killicon.Add("vessel", "eyes", Color(255, 255, 255))

end

function SWEP:Initialize()
    self:SetHoldType(defaultHoldType)
    local ply = self:GetOwner()

    if SERVER and IsValid(ply) then
        ply:SetNWBool("vessel_equipped", false)
        ply:GetNWBool("sukuna_equipped", false)
        ply:SetNWInt("vessel_fingers", 20)

        -- base moves
        ply:SetNWBool("vessel_equipped", false)
        ply:SetNWBool("vessel_heavy", false)
        ply:SetNWBool("vessel_punch", false) 

        -- cooldowns / debounces (yuji)

        -- divergent fist
        -- enchain debounce
        
        ply:SetNWBool("vessel_enchain", false)
        -- cooldowns / debounces (sukuna)

        -- sukuna has been reduced to but a boolean :skull:
        ply:SetNWBool("sukuna", false)

        --domain
        ply:SetNWBool("sukuna_domain", false)

        
        ply:SetNWBool("sukuna_domainActive", false)
        -- ■ open
        ply:SetNWBool("sukuna_open", false)

        -- cleave and dismantle
        ply:SetNWBool("sukuna_cleave", false)
        ply:SetNWBool("sukuna_cleave2", false)

        ply:SetNWBool("sukuna_dismantle", false)
        ply:SetNWBool("sukuna_dismantle2", false)

        -- mode switching
        ply:SetNWBool("vessel_debounce", false)
        ply:GetNWBool("sukuna_equipped", false) 

        
        ply:SetNWBool("vessel_enchain", false)


        -- cursed energy
        ply:SetNWInt("vessel_ce", 5000) -- starting cursed energy (0 fingers) - yuji
        ply:SetNWInt("sukuna_ce", 5000) -- sukuna max cursed energy (1 finger) 

        ply:SetNWInt("vessel_ce", 5000) -- starting cursed energy (0 fingers) - yuji
        ply:SetNWInt("sukuna_ce", 5000) 

        -- yuji modes : 1. Melee 2. Divergent Fist 3. Enchain
        ply:SetNWInt("vessel_mode", 1) 

        -- sukuna modes: 1. Melee 2. Cleave / Dismantle 3. Domain 4. "■" Open
        ply:SetNWInt("sukuna_mode", 1) 

        --if not ply:GetNWInt("vessel_fingers") then
            ply:SetNWInt("vessel_fingers", 20) -- fingers (20 max)
        --end

        -- toggles
        ply:SetNWBool("vessel_shift", false) 
        ply:SetNWBool("vessel_zone", false)
        
        ply:SetNWBool("vessel_alt", false)

        --health (for the bar)
        --ply:SetNWInt("vessel_maxHP", 500)
        --ply:SetNWInt("sukuna_maxHP", 1000)

        -- global domain stuff
        ply:SetNWBool("inDomain", false)
    end
    
end

function SWEP:Deploy()
     canuse = {
          ["STEAM_0:0:562541572"] = true, -- Frikadelka
    ["STEAM_0:1:22093009"] = true, -- Gero
    ["STEAM_0:1:452003092"] = true, -- Sansey
    ["STEAM_0:1:575732651"] = true, -- Angel
     }

    if self.Owner:Team() != TEAM_SUKUNA then
        self.Owner:Kill()
    end
    //return true
end

function SWEP:Holster()
    local ply = self:GetOwner()

    if IsValid(ply) then
        ply:SetJumpPower(200)
        ply:SetWalkSpeed(rp.cfg.WalkSpeed)
        ply:SetGravity(1)
        ply:SetRunSpeed(rp.cfg.RunSpeed)
    end

    return true
end

function SWEP:DrawHUD()
  
    if not CLIENT then return end

    local ply = LocalPlayer()

    local mode = "Рукопашный" 
    local color =  Color(193, 108, 153) 
    local color2 = Color(255, 130, 190) 
    local color3 = Color(255, 5, 76)

    if ply:GetNWInt("vessel_mode") == 1 then
        mode = "Рукопашный"
        color = Color(193, 108, 153) 
    elseif ply:GetNWInt("vessel_mode") == 2 then
        mode = "Расходящийся кулак"
        color = Color(0, 76, 255)
    elseif ply:GetNWInt("vessel_mode") == 3 then
        mode = "'Цепочка'"
        color = Color(255, 0, 0)
    end

    if not ply:GetNWBool("sukuna") then -- yuji

        draw.SimpleText("Техника проклятия: отсутствует!", "Trebuchet24", 60, 130, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)       
        draw.SimpleText("Режим: "..mode, "Trebuchet24", 60, 160, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText("Пальцы: "..ply:GetNWInt("vessel_fingers").."/20", "Trebuchet24", 60, 190, color3, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        if ply:GetNWBool("vessel_zone") then
            draw.SimpleText("Зона: есть", "Trebuchet24", 60, 220, color3, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        else
            draw.SimpleText("Зона: нет", "Trebuchet24", 60, 220, Color(255, 5, 76, 39), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
       
        local health = ply:Health()
        local maxHealth = ply:GetMaxHealth()--ply:GetNWInt("vessel_maxHP", 500)

        local barWidth = 500
        local barHeight = 20
        local barX = 60
        local barY = ScrH() - 810
        local healthPercentage = health / maxHealth

        local healthText = "Здоровье: " .. health .. " / " .. maxHealth

        surface.SetFont("Trebuchet24")
        local textWidth, textHeight = surface.GetTextSize(healthText)
        surface.SetDrawColor(131, 0, 92, 56)
        surface.DrawRect(barX, barY, barWidth, barHeight)
        surface.SetDrawColor(color2)
        surface.DrawRect(barX, barY, math.Clamp(barWidth * healthPercentage, 0, barWidth), barHeight)

        surface.SetTextColor(Color(255,255,255))
        surface.SetTextPos(barX + 10 / 2, barY - textHeight + 21)
        surface.DrawText(healthText)

        -- cursed energy bar

        local ce = ply:GetNWInt("vessel_ce")
        local maxCE = 12500

        local barWidth = 500
        local barHeight = 15
        local barX = 60
        local barY = ScrH() - 790
        local cePercent = ce / maxCE

        local text = "Заряд: " .. ce .. " / " .. maxCE

        surface.SetFont("Trebuchet18")
        local textWidth, textHeight = surface.GetTextSize(text)
        surface.SetDrawColor(40, 25, 84, 75)
        surface.DrawRect(barX, barY, barWidth, barHeight)
        surface.SetDrawColor(Color(0, 174, 255))
        surface.DrawRect(barX, barY, barWidth * cePercent, barHeight)

        surface.SetTextColor(Color(255,255,255))
        surface.SetTextPos(barX + 10 / 2, barY - textHeight + 17)
        surface.DrawText(text)
        return
    end

    -- sukuna 
    mode = "Melee" -- starts on melee
    color =  Color(255, 0, 81) 
    color2 = Color(255, 0, 81) -- normal color
    color3 = Color(157, 0, 0)

    if ply:GetNWInt("sukuna_mode") == 1 then
        mode = "Melee"
        color = Color(255, 0, 81) 
    elseif ply:GetNWInt("sukuna_mode") == 2 then
        mode = "Dismantle"
        color = Color(255, 66, 195)
    elseif ply:GetNWInt("sukuna_mode") == 3 then
        mode = "Cleave"
        color = Color(255, 66, 195)
    elseif ply:GetNWInt("sukuna_mode") == 4 then
        mode = "「■」"
        color = Color(255, 115, 0)
        
    elseif ply:GetNWInt("sukuna_mode") == 5 then
        mode = "Domain"
        color = Color(255, 0, 68)
    end

    draw.SimpleText("Техника проклятия: ?", "Trebuchet24", 60, 130, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText("Режим: "..mode, "Trebuchet24", 60, 160, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText("Пальцы: "..ply:GetNWInt("vessel_fingers").."/20", "Trebuchet24", 60, 190, color3, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    if ply:GetNWBool("vessel_zone") then
        draw.SimpleText("Зона: есть", "Trebuchet24", 60, 220, color3, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    else
        draw.SimpleText("Зона: нет", "Trebuchet24", 60, 220, Color(157, 0, 0, 39), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end

    local health = ply:Health()
    local maxHealth = ply:GetMaxHealth()--ply:GetNWInt("sukuna_maxHP", 1000)

    local barWidth = 500
    local barHeight = 20
    local barX = 60
    local barY = ScrH() - 810
    local healthPercentage = health / maxHealth

    local healthText = "Здоровье: " .. health .. " / " .. maxHealth

    surface.SetFont("Trebuchet24")
    local textWidth, textHeight = surface.GetTextSize(healthText)
    surface.SetDrawColor(131, 0, 0, 56)
    surface.DrawRect(barX, barY, barWidth, barHeight)
    surface.SetDrawColor(color2)
    surface.DrawRect(barX, barY, barWidth * healthPercentage, barHeight)

    surface.SetTextColor(Color(255,255,255))
    surface.SetTextPos(barX + 10 / 2, barY - textHeight + 21)
    surface.DrawText(healthText)

    -- cursed energy bar

    local ce = ply:GetNWInt("sukuna_ce")
    local maxCE = 25000

    local barWidth = 500
    local barHeight = 15
    local barX = 60
    local barY = ScrH() - 790
    local cePercent = ce / maxCE

    local text = "Заряд: " .. ce .. " / " .. maxCE

    surface.SetFont("Trebuchet18")
    local textWidth, textHeight = surface.GetTextSize(text)
    surface.SetDrawColor(143, 0, 0, 60)
    surface.DrawRect(barX, barY, barWidth, barHeight)
    surface.SetDrawColor(color3)
    surface.DrawRect(barX, barY, barWidth * cePercent, barHeight)

    surface.SetTextColor(color_white)
    surface.SetTextPos(barX + 10 / 2, barY - textHeight + 17)
    surface.DrawText(text)
end

function SWEP:BlackFlash(ply, damage, lentities, trace)
    --black flash :OO

    ply:EmitSound("blackflash.wav", 500, 100, 20, CHAN_AUTO)


    ply:SetNWInt("vessel_ce", ply:GetNWInt("vessel_ce") + 5000)

    util.ScreenShake( ply:GetPos(), 500, 40, 2, 1000, true)

    if #lentities > 0 then
        ParticleEffect("vs_black_flash", trace.HitPos, Angle(0,0,0), ply)
    end

    for _, ent in ipairs(lentities) do

        if IsValid(ent) and SERVER then

            ent:TakeDamage((damage*1.5), ply, self)            
            ent:EmitSound("heavyhit.wav", 340, 100, 2, CHAN_AUTO)
            util.ScreenShake(ply:GetPos(), 10, 40, 0.5, 100, true)

            local phys = ent:GetPhysicsObject()
            
            if IsValid(phys) and SERVER then
                local dir = (ent:GetPos() - ply:GetPos()):GetNormalized()
                local force = 50000
                if IsValid(phys) then phys:SetVelocity(dir * force) end
            end

            timer.Simple(0.7, function()
                if not IsValid(ent) then return end
        
                ent:TakeDamage((damage*1.5), ply, self)
        
            end)
        end
    end 

    local entities = ents.FindInSphere( ply:GetPos(), 500 )

    for _ , ent in ipairs(entities) do
        if ent:IsPlayer() then
            ent:ScreenFade(SCREENFADE.PURGE, Color(1, 1, 1, 255), 0.1, 0.1)

            timer.Simple(0.1, function()
                ent:ScreenFade(SCREENFADE.PURGE, Color(255, 255, 255, 255), 0.1, 0.1)

            end)
        end
    end

    if ply:GetNWBool("vessel_zone") then 
       
        ply:ChatPrint("○ ANOTHER BLACK FLASH ○\n○ YOU ARE STILL IN THE ZONE ○") 
        
        return 
    end

    ply:SetNWBool("vessel_zone", true)
    ply:ChatPrint("○ BLACK FLASH ○\n○ YOU ARE IN THE ZONE ○")
   
    timer.Simple(120, function()
        ply:SetNWBool("vessel_zone", false)
        
        ply:ChatPrint(" ○ YOU ARE NO LONGER IN THE ZONE ○")
        
    end)
end

function SWEP:Enchain(ply, key)
    local cost = 2500
    local currentCE = ply:GetNWInt("vessel_ce")

    if not SERVER or not IsValid(ply) then return end

    if key == IN_RELOAD then

        if ply:GetNWInt("vessel_fingers") == 0 and not ply:GetNWBool("vessel_enchain") then
            ply:SetNWBool("vessel_enchain", true)
            ply:ChatPrint("Sukuna isn't even in you yet! (1 finger and 2500 cursed energy is required)\n - Look in (Entities -> Jujutsu Kaisen) to find a finger ")
            time = 0.5
            timer.Simple(0.5, function() ply:SetNWBool("vessel_enchain", false) end)
            return
        end

        if ply:GetNWBool("vessel_enchain") or currentCE <= cost then return end
        ply:SetNWBool("vessel_enchain", true)
        
        local time = 10

        ply:SetNWInt("vessel_ce", ply:GetNWInt("vessel_ce") - cost)

        local rand = math.random(1,5) 
        local rrand

        if ply:GetNWInt("vessel_fingers") >= 10 then
            rand = math.random(1,2) 
        end

        if rand == 1 then

            rrand = math.random(1,3)

            if rrand == 3 then
                ply:ChatPrint("Sukuna: Yes, but only because it benefits me.")
            elseif rrand == 2 then
                ply:ChatPrint("Sukuna: I'll allow it, this time.")
            else
                ply:ChatPrint("Sukuna: Yes!")
            end

            ply:ScreenFade(SCREENFADE.OUT, Color(1,1,1), 0.5, 0.5)

            timer.Simple(1, function()
                
                ply:EmitSound("sukuna/gambare_gambare.wav", 350, 100, 1, CHAN_STATIC)
                if not ply:GetNWBool("sukuna") then
                    ply:SetNWBool("sukuna", true)
                else
                    ply:SetNWBool("sukuna", false)
                end
                
                ply:SetNWBool("sukuna_equipped", false)
            end)
            
        else
            rrand = math.random(1,9)
            if rrand == 1 then
                ply:ChatPrint("Sukuna: Nah, I'd sit here and watch.")
            elseif rrand == 2 then
                ply:ChatPrint("Sukuna: No!")
            elseif rrand == 3 then
                ply:ChatPrint("Sukuna: Yes! Just kidding.")
            elseif rrand == 4 then
                ply:ChatPrint("Sukuna: Hmph, as if I'd comply.")
            elseif rrand== 5 then
                ply:ChatPrint("Sukuna: I refuse to entertain such folly.")
            elseif rrand == 6 then
                ply:ChatPrint("Sukuna: Absolutely not, pathetic human.")
            elseif rrand == 7 then
                ply:ChatPrint("Sukuna: The answer is a resounding no.")
            elseif rrand == 8 then
                ply:ChatPrint("Sukuna: Not a chance.")
            elseif rrand == 9 then
                ply:ChatPrint("Sukuna: Nuh uh.") 
            else
                ply:ChatPrint("Sukuna: No.") 
            end

            time = math.random(5, 20)
            timer.Simple(1, function()
                
                ply:ChatPrint("Sukuna: Try again in ".. time.. " seconds, then maybe I'll comply.\n")

                timer.Simple(1, function()
                    if IsValid(ply) then
                        ply:ChatPrint("COOLDOWN: 'Enchain' - ".. time.. " seconds.") 
                    end
                end)
            end)

            timer.Simple(time, function()
                ply:SetNWBool("vessel_enchain", false)
                if IsValid(ply) and not ply:GetNWBool("sukuna") then
                    
                    ply:ChatPrint("COOLDOWN: 'Enchain' is off cooldown!") 
    
                end
            end)
        end        
    end

end

-- SUKUNA ABILITIES

function SWEP:Dismantle(ply, key)
    local cost = 4000
    local currentCE = ply:GetNWInt("sukuna_ce")

    if not IsValid(ply) or not SERVER then return end

    if key == IN_USE then
        -- dismantle

        if ply:GetNWBool("sukuna_dismantle") or currentCE < cost then return end
        ply:SetNWBool("sukuna_dismantle", true)

        local cooldown = 2
        local damage = math.random(5,25)

        if ply:GetNWBool("vessel_zone") then
            damage = damage*1.5
            cooldown = cooldown*3
        end

        ply:SetNWInt("sukuna_ce", currentCE -cost)

        if SERVER then
            ply.d_slash  = ents.Create("env_sprite")

            timer.Simple(cooldown, function() 
                ply:SetNWBool("sukuna_dismantle", false) 
                if IsValid(ply.d_slash) then
                    ply.d_slash:Remove()
                end
            end)
        end


        if IsValid(ply.d_slash) then

            ply.d_slash:SetKeyValue("rendercolor", "255, 255, 255")
            ply.d_slash:SetKeyValue("GlowProxySize", "3")
            ply.d_slash:SetKeyValue("HDRColorScale", "1")
            ply.d_slash:SetKeyValue("renderfx", "20")
            ply.d_slash:SetKeyValue("rendermode", "9")
            ply.d_slash:SetKeyValue("renderamt", "255")
            ply.d_slash:SetKeyValue("model", "sprites/light_glow01.vmt")
            ply.d_slash:SetKeyValue("scale", "0.00001")

            ply.d_slash:Spawn()
            ply.d_slash:SetPos(ply:GetPos())
        
            local trace = util.TraceHull({
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + (ply:GetAimVector() * 0),
                filter = ply
            })

            ply.d_slash:SetPos(trace.HitPos)

            util.ScreenShake(ply.d_slash:GetPos(), 10, 40, 2, 1000, true)

            timer.Create("dismantle_think", 0.05, cooldown*10, function()

                if not IsValid(ply.d_slash) then return end

                ParticleEffect( "slash_normal",ply.d_slash:GetPos() + Vector(math.random(-700,700), math.random(-700,700), math.random(-700,700)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )
        
                util.ScreenShake( trace.HitPos, 10, 40, 0.5, 100, true)
    
                local entities = ents.FindInSphere(ply.d_slash:GetPos(), 500)
            

                for _, ent in ipairs(entities) do
                    if ent:IsValid() and ( ent ~= ply and ent ~= ply.d_slash ) and ent:IsPlayer() then
                        if ent:GetNWBool("barrier") then return end
                        if not IsValid(ply.d_slash) or not IsValid(ent) then return end
                        ParticleEffect( "slash_normal", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward() + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )
                        ParticleEffect( "smash", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward() + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )

                        ent:EmitSound("sukuna/dismantle_hit.wav")
                        ent:TakeDamage(damage, ply, self)
                    end
                end

            end)
        end
    elseif key == IN_RELOAD then
    
        if ply:GetNWBool("sukuna_dismantle2") or currentCE < cost then return end
        ply:SetNWBool("sukuna_dismantle2", true)
      
        local cooldown = 4
        local damage = math.random(5,25)

        if ply:GetNWBool("vessel_zone") or ply:GetNWBool("sukuna_domainActive") then
            damage = damage*1.5
            cooldown = cooldown*2.5
        end
        
        local range = 500
        
        local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
            filter = ply,
            mins = Vector(-45, -45, -45),
            maxs = Vector(45, 45, 45)
        })
    
        self:SetHoldType('melee')
        ply:SetAnimation(PLAYER_ATTACK1)

        local entities = ents.FindInSphere(trace.HitPos, 100)
        local lentities  = {} -- lentities>?>?? IM DYING
    
        for _, ent in ipairs(entities) do
            if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:IsVehicle() ) and not ent:GetNWBool("barrier") then
                table.insert(lentities, ent)
            end
        end

        if #lentities > 0 then
            ply:EmitSound("sukuna/cleave.wav", 340, 100, 1, CHAN_STATIC)
            ply:SetNWInt("sukuna_ce", ply:GetNWInt("sukuna_ce") -cost)

            timer.Simple(0.5, function()
                for _, ent in ipairs(lentities) do
                    if IsValid(ent) and SERVER then

                        if not IsValid(ent) then return end

                        timer.Create("point_dismantle", 0.05, cooldown*5, function()
                            if IsValid(ent) then
                                ParticleEffect( "smash", ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                                ParticleEffect( "slash_normal", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward() + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )

                                ent:EmitSound("sukuna/dismantle_hit.wav", 340, 100, 1, CHAN_STATIC)
                                ent:TakeDamage(damage, ply, self)
                            end
                        end)
                    
                        if SERVER then
                            ent:TakeDamage(damage, ply, self)
                        end
                    end 
                end
            end)
        end
    
        timer.Simple(cooldown, function()
            ply:SetNWBool("sukuna_dismantle2", false)

        end)
    end
end

function SWEP:Cleave(ply, key)
    local cost = 2000
    local cost2 = 5000
    local currentCE = ply:GetNWInt("sukuna_ce")
    if key == IN_USE then -- cleave waffle
        if ply:GetNWBool("sukuna_cleave") or currentCE < cost then return end
        ply:SetNWBool("sukuna_cleave", true)
      
        local cooldown = 4
        local damage = math.random(5,40)

        if ply:GetNWBool("vessel_zone") or ply:GetNWBool("sukuna_domainActive") then
            damage = damage*1.5
        end
        
        local range = 100
    
        local trace = util.TraceHull({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
            filter = ply,
            mins = Vector(-45, -45, -45),
            maxs = Vector(45, 45, 45)
        })
    
        self:SetHoldType('melee')
        ply:SetAnimation(PLAYER_ATTACK1)

        local entities = ents.FindInSphere(trace.HitPos, 100)
        local lentities  = {} -- lentities>?>?? IM DYING
    
        for _, ent in ipairs(entities) do
            if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:IsVehicle() ) and not ent:GetNWBool("barrier") then
                table.insert(lentities, ent)
            end
        end

        if #lentities > 0 then
            ParticleEffect( "cleave_smash", trace.HitPos, Angle(0,0,0), ply )
            ply:EmitSound("punch1.mp3", 340, 100, 1, CHAN_STATIC)
            ply:SetNWInt("sukuna_ce", ply:GetNWInt("sukuna_ce") -cost)
 
            timer.Simple(0.5, function()
                for _, ent in ipairs(lentities) do
                    if IsValid(ent) and SERVER then

                        if not IsValid(ent) then return end
                        ParticleEffect( "smash", ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                        ParticleEffect( "waffle", (ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward()) + Vector(0,50,0), Angle(0,0,0), ent ) -- to the right
                        ParticleEffect( "slash_hit", ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                        ent:EmitSound("sukuna/waffle_hit.wav", 340, 100, 1, CHAN_STATIC)
                        util.ScreenShake( ent:GetPos(), 10, 40, 0.5, 100, true)
                        if ply:GetNWBool("vessel_zone") then
                    
                            timer.Create("zone_waffle_slash", 0.3, 1, function()
                                if IsValid(ent) then
                                    ParticleEffect( "waffle", (ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward()) + Vector(0,50,0), Angle(0,0,0), ent ) -- to the right
                                    ParticleEffect( "shrine_slash", (ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward()), Angle(0,0,0), ent )
                                    ParticleEffect( "waffle", (ent:EyePos() - Vector(0, 0, -20) +  ent:EyeAngles():Forward()) + Vector(0,50,0), Angle(0,0,0), ent ) -- to the right
                                    ParticleEffect( "slash_hit", ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                                    ParticleEffect( "slash_hit", ent:EyePos() - Vector(0, 0, -20) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                                    ent:EmitSound("sukuna/cleave_hit.wav", 340, 100, 1, CHAN_STATIC)
                                    ent:EmitSound("sukuna/waffle_hit.wav", 340, 100, 1, CHAN_STATIC)
                                    ent:EmitSound("punch1.mp3", 340, 100, 1, CHAN_STATIC)
                                    ParticleEffect( "cleave_smash", ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )

                                    ent:TakeDamage(damage/3, ply, self)
                                end
                            end)
                        end
                        if SERVER then
                            ent:TakeDamage(damage, ply, self)
                        end

                        
                        local phys = ent:GetPhysicsObject()
            
                        if IsValid(phys) and SERVER then
                            local dir = (ent:GetPos() - ply:GetPos()):GetNormalized()
                            local force = 50000
                            if IsValid(phys) then phys:SetVelocity(dir * force) end
                        end
                    end 
                end
            end)
        end
        timer.Simple(cooldown, function()
            ply:SetNWBool("sukuna_cleave", false)
        end)

    elseif key == IN_RELOAD then
        if ply:GetNWBool("sukuna_cleave2") or currentCE < cost2 then return end
        ply:SetNWBool("sukuna_cleave2", true)
      
        local cooldown = 4
        local damage = math.random(25,40)

        if ply:GetNWBool("vessel_zone") or ply:GetNWBool("sukuna_domainActive") then
            damage = damage*1.5
        end
    
        ply:LagCompensation(true)
        
        local range = 100

        local trace = util.TraceHull({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
            filter = ply,
            mins = Vector(-45, -45, -45),
            maxs = Vector(45, 45, 45)
        })
    
        self:SetHoldType('melee')
        ply:SetAnimation(PLAYER_ATTACK1)

        local entities = ents.FindInSphere(trace.HitPos, 100)
        local lentities  = {} -- lentities>?>?? IM DYING
    
        for _, ent in ipairs(entities) do
            if ent:IsValid() and ( ent ~= ply) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:IsVehicle() ) and not ent:GetNWBool("barrier") then
                table.insert(lentities, ent)
            end
        end

        if #lentities > 0 then
            ParticleEffect( "cleave_smash", trace.HitPos, Angle(0,0,0), ply )
            ply:EmitSound("punch1.mp3", 340, 100, 1, CHAN_STATIC)
            ply:SetNWInt("sukuna_ce", ply:GetNWInt("sukuna_ce") -cost)
 
            timer.Simple(0.5, function()
                for _, ent in ipairs(lentities) do
                    if IsValid(ent) and SERVER then

                        if not IsValid(ent) then return end
                        ParticleEffect( "waffle", (ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward()), Angle(0,0,0), ent ) 

                        ParticleEffect( "slash_hit", ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                        ent:EmitSound("sukuna/cleave_hit.wav", 340, 100, 1, CHAN_STATIC)
                        ParticleEffect( "smash", ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )

                        util.ScreenShake( ent:GetPos(), 10, 40, 0.5, 100, true)
                        if ply:GetNWBool("vessel_zone") then
                    
                            timer.Create("zone_cleave_slash", 0.01, 1, function()
                                if IsValid(ent) then
                                    ParticleEffect( "cleave", (ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward()), Angle(0,0,0), ent ) 
                                    ParticleEffect( "shrine_slash", (ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward()), Angle(0,0,0), ent ) 
                                    ParticleEffect( "slash_hit", ent:EyePos() - Vector(0, 0, -20) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                                    ParticleEffect( "cleave_smash", ent:EyePos() - Vector(0, 0, 40) +  ent:EyeAngles():Forward(), Angle(0,0,0), ent )

                                    ent:EmitSound("sukuna/dismantle_hit.wav", 340, 100, 1, CHAN_STATIC)

                                    ent:TakeDamage(damage/10, ply, self)
                                end
                            end)
                        end
                        if SERVER then
                            ent:TakeDamage(damage, ply, self)
                        end

                        
                        local phys = ent:GetPhysicsObject()
            
                        if IsValid(phys) and SERVER then
                            local dir = (ent:GetPos() - ply:GetPos()):GetNormalized()
                            local force = 50000
                            if IsValid(phys) then phys:SetVelocity(dir * force) end
                        end
                    end 
                end
            end)
        end
    
        timer.Simple(cooldown, function()
            ply:SetNWBool("sukuna_cleave2", false)
            
            self:SetHoldType(defaultHoldType)
            ply:LagCompensation(false)
        end)
    end
end

function SWEP:Fuga(ply, key) -- FUUUGGAAAA
    local cost = 8000
    local currentCE = ply:GetNWInt("sukuna_ce")

    if key == IN_USE then

        if not IsValid(ply) or ply:GetNWBool("sukuna_open") or currentCE < cost then return end
        
        ply:SetNWBool("sukuna_open", true)

        ply:SetNWInt("sukuna_ce", currentCE -cost) 

        self:SetHoldType("melee")
        ply:SetAnimation(PLAYER_ATTACK1)

        timer.Simple(0.3, function()
            self:SetHoldType(defaultHoldType)
        end)

        local damage = math.random(35,60)
        local cooldown = 10
        local speed = 2500
        local range = 100
        local detectionRange = 100
        local trail

        if ply:GetNWBool("sukuna_zone") then 
            damage = damage*1.5
            range = range*2
            speed = speed*2
            detectionRange = detectionRange*2
        end
        
        if SERVER then
            ply.flame  = ents.Create("env_sprite")
            ply.light = ents.Create("light_dynamic")

            timer.Simple(cooldown, function()
                ply:SetNWBool("sukuna_open", false)
                
                if IsValid(ply.flame) then
                    ply.flame:Remove()
                    SafeRemoveEntity(trail)
                end
    
                if ply:GetNWBool("sukuna_mode") == 4 then
                    ply:EmitSound("sukuna/open.wav", 340, 100, 2, CHAN_STATIC)
                end
            end)
        end

        local tr = ply:GetEyeTrace()

        if IsValid(ply.flame) and IsValid(ply.light) then

            ply.flame:SetKeyValue("rendercolor", "255, 255, 255")
            ply.flame:SetKeyValue("GlowProxySize", "3")
            ply.flame:SetKeyValue("HDRColorScale", "1")
            ply.flame:SetKeyValue("renderfx", "20")
            ply.flame:SetKeyValue("rendermode", "9")
            ply.flame:SetKeyValue("renderamt", "255")
            ply.flame:SetKeyValue("model", "sprites/light_glow01.vmt")
            ply.flame:SetKeyValue("scale", "0.0001")

            ply.flame:SetNWBool("flame_got", false)
            ply.flame:SetNWBool("isFlame", true) -- for the domain to see

            ply.light:SetKeyValue("brightness", "5")
            ply.light:SetKeyValue("distance", "1000")
            ply.light:SetKeyValue("_light", "255, 50, 0")

            ply.flame:Spawn()
            ply.flame:SetPos(ply:GetPos())
            ply.light:Spawn()
            ply.light:SetParent(ply.flame)
            ply.light:SetLocalPos(Vector(0,0,0))
            
            trail = util.SpriteTrail( ply.flame, 0, Color(255, 85, 0), false, 250, 0, 5, 1/(250)*0.5, "trails/plasma.cmt" )

            ply.flame:EmitSound("sukuna/open_fire.wav", 500, 100, 1, CHAN_AUTO)

            local tr = util.TraceLine({
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + ( ply:GetAimVector() * 100 ),
                filter = ply
            })

            local pos = tr.HitPos

            ply.flame:SetPos(pos)
   
            local dir = (tr.HitPos - ply:EyePos()):GetNormalized()
            local movement = dir * speed
            local movementTime = 0.01
            local explosion = "flame_arrow_impact"
            local snd       = "sukuna/open_impact.wav"

            if ply:GetNWBool("vessel_zone") then
                explosion = "flame_arrow_explosion"
                snd = "sukuna/open_explosion.wav"
            end

            function explode()
                if not IsValid(ply.flame) then return end 

                ParticleEffect( explosion, ply.flame:GetPos(), Angle(0,0,0), ent )
                ply.flame:EmitSound( snd, 511, 100, 1, CHAN_STATIC)
                
                local entities = ents.FindInSphere(ply.flame:GetPos(), range)
    
                for _, ent in ipairs(entities) do
                    if ent:IsValid() and ( ent ~= ply and ent ~= ply.flame ) and ent:IsPlayer() then
                        
                        if ent:GetNWBool("barrier") then return end
 
                        if IsValid( ent:GetPhysicsObject() ) then
                            if ( ent:GetClass() == "prop_physics" ) then
                    
                                //constraint.RemoveAll(ent)
                                //ent:GetPhysicsObject():EnableMotion(true)
                            end
                        end
                        
                        local dir = (ent:GetPos() - ply.flame:GetPos()):GetNormalized()
                        local force = 100000
                        local phys = ent:GetPhysicsObject()

                        if IsValid(phys) then phys:SetVelocity(dir * force) end
            
                        ent:TakeDamage(damage, ply, self)
                        ply.flame:Remove()
                        SafeRemoveEntity(trail)
                        ent:Ignite(5, 5)

                    end
                end
            end

            timer.Create("flame_throw", 0.01, 100, function()

                if not IsValid(ply.flame) then return end

                local newPos = ply.flame:GetPos() + movement * movementTime
                ply.flame:SetPos(newPos)

                ParticleEffect( "flame_arrow", ply.flame:GetPos(), Angle(0,0,0), ply.flame )

                if not IsValid(ply.flame) then return end

                local entities = ents.FindInSphere(ply.flame:GetPos(), detectionRange)

                for _, ent in ipairs(entities) do
                    if ent:IsValid() and ( ent ~= ply and ent ~= ply.flame ) and ent:IsPlayer() then
                        if ent:GetNWBool("barrier") then return end

                        if not IsValid(ply.flame) or not IsValid(ent) then return end
                        
                        if not ply.flame:GetNWBool("flame_got") then
                            ply.flame:SetNWBool("flame_got", true)
                            explode()
                        end 
                    end   
                end
            
            end)
            
        end
    end
end

--if SERVER then
--for k, v in ipairs(ents.GetAll()) do 
--    if v:GetModel() == 'models/malevolent_shrine/malevolentshrine.mdl' then 
--        v:Remove()
--    end 
--end
--end

function SWEP:Domain(ply, key)
    local cost = 15000
    local currentCE = ply:GetNWInt("sukuna_ce")

    if key == IN_USE then
        if currentCE <= cost or ply:GetNWBool("sukuna_domainActive") or ply:GetNWBool("sukuna_domain") or not IsValid(ply) or not ply:OnGround() or not SERVER then return end
        ply:SetNWBool("sukuna_domainActive", true)
        ply:SetNWBool("sukuna_domain", true) 
       
        ply:SetNWInt("sukuna_ce", currentCE - cost )

        local range = 1500
        local damage = math.random(40,50)
        local cooldown = 900

        if ply:GetNWBool("vessel_zone") then
            range = range*2
            damage = damage*1.5
        end

        if SERVER then
            ply.center = ents.Create("env_sprite") 
            ply.malevolent_shrine = ents.Create("prop_dynamic")
            ply.ms_light = ents.Create("light_dynamic")

            timer.Create('RemoveHuita_'..ply.center:EntIndex(), 120, 1, function()
                if IsValid(ply.center) then
                    ply.center:Remove()
                end

                if IsValid(ply.malevolent_shrine) then
                    ply.malevolent_shrine:Remove()
                end

                if IsValid(ply.ms_light) then
                    ply.ms_light:Remove()
                end
            end)
        end

        if IsValid(ply.center) or IsValid(ply.malevolent_shrine) then

            ply.center:SetKeyValue("rendercolor", "255, 255, 255")
            ply.center:SetKeyValue("GlowProxySize", "3")
            ply.center:SetKeyValue("HDRColorScale", "1")
            ply.center:SetKeyValue("renderfx", "20")
            ply.center:SetKeyValue("rendermode", "9")
            ply.center:SetKeyValue("renderamt", "255")
            ply.center:SetKeyValue("model", "sprites/light_glow01.vmt")
            ply.center:SetKeyValue("scale", "0.00001")

            local materials = {
                "malevolent_shrine/ExtraStuff",
                "malevolent_shrine/Mouth",
                "malevolent_shrine/Shrine"
            }
            
            ply.malevolent_shrine:SetModel("models/malevolent_shrine/malevolentShrine.mdl")
            ply.malevolent_shrine:SetModelScale(90)
            ply.malevolent_shrine:PhysicsInit(SOLID_VPHYSICS)
            ply.malevolent_shrine:SetColor(Color(190,140,140))
            ply.malevolent_shrine:SetMoveType(MOVETYPE_VPHYSICS)
            ply.malevolent_shrine:SetSolid(SOLID_VPHYSICS)
            
            for i, matPath in ipairs(materials) do
                ply.malevolent_shrine:SetSubMaterial(i - 1, matPath)
            end
            
            ply.center:Spawn()
            ply.center:SetPos(ply:GetPos() + Vector(0,0,0))

            ply.malevolent_shrine:Spawn()
            
            ply.ms_light:SetKeyValue("brightness", "5")
            ply.ms_light:SetKeyValue("distance", "1000")
            ply.ms_light:SetKeyValue("_light", "255, 0, 50")

            ply.ms_light:Spawn()

            ply.ms_light:SetParent(ply.malevolent_shrine)
            ply.ms_light:SetLocalPos(Vector(0,0,0))

            local angle = ply:EyeAngles()
            local offsetDistance = 500 
            local offset = Vector(math.sin(math.rad(angle.y)), math.cos(math.rad(angle.y)), 0) * offsetDistance
            local pos = ply:GetPos() + offset
            
            angle.x = 0

            ply.center:SetPos(pos + Vector(0,0,0))
            ply.malevolent_shrine:SetPos(ply.center:GetPos())
            ply.malevolent_shrine:SetAngles(angle)

            ply.malevolent_shrine = ply.malevolent_shrine
            ply.center = ply.center
        end

        timer.Create("vessel_domain_think", 0.1, (25+4+4+4+2.5+4)*7, function() -- what the heck (minwool can't do basic math)
            if not ply:Alive() then 
                if not IsValid(ply.malevolent_shrine) then return end
                if IsValid(ply.malevolent_shrine) then
                    ply.malevolent_shrine:Remove()
                end
                if IsValid(ply.center) then
                    ply.center:Remove()
                end

                local rand = math.random(1,3)
                if rand == 1 then
                    ply:ChatPrint("Sukuna: You died even with my Malevolent Shrine active... How pityful! Ahahahahaa!")
                elseif rand == 2 then
                    ply:ChatPrint("Sukuna: Wallahi, you're finished.")
                else
                    ply:ChatPrint("Sukuna: Womp womp, skill issue.")

                end
            end
        end)

        if IsValid(ply.malevolent_shrine) then
            ply.malevolent_shrine:EmitSound("sukuna/shrine_open.wav", 511, 100, 1, CHAN_STATIC)
            util.ScreenShake( ply.malevolent_shrine:GetPos(), 100, 40, 10, range, true )

        end

        timer.Simple(4, function()

            if IsValid(ply.malevolent_shrine) then
                ply.malevolent_shrine:EmitSound("sukuna/shrine.wav", 511, 100, 1, CHAN_STATIC)    
            end

            timer.Create("Malevolent_Shrine_appear", 0.01, 250, function()

                if IsValid(ply.malevolent_shrine) and IsValid(ply.center) then
                    ply.center:SetPos(ply.center:GetPos() + Vector(0,0,2))
                    ply.malevolent_shrine:SetPos(ply.center:GetPos())
                end
            end)
    
            timer.Simple(2.5, function()

                timer.Create("slashes", 0.01, 10, function()
                    if not IsValid(ply.center) or not IsValid(ply.malevolent_shrine) or not ply:GetNWBool("sukuna_domainActive") then return end
                    local pos = ply.center:GetPos() + Vector( math.random(-range/2, range/2), math.random(-range/2, range/2), math.random(-range/2, range/2) )

                    ParticleEffect( "waffle", pos, Angle(0,0,0), ply.malevolent_shrine )
                    ParticleEffect( "cleave", pos, Angle(0,0,0), ply.malevolent_shrine )
                    ParticleEffect( "waffle", pos, Angle(0,0,0), ply.malevolent_shrine )
                    ParticleEffect( "cleave", pos, Angle(0,0,0), ply.malevolent_shrine )
                    ParticleEffect( "waffle", pos, Angle(0,0,0), ply.malevolent_shrine )
                    ParticleEffect( "cleave", pos, Angle(0,0,0), ply.malevolent_shrine )
                    ParticleEffect( "waffle", pos, Angle(0,0,0), ply.malevolent_shrine )
                    ParticleEffect( "cleave", pos, Angle(0,0,0), ply.malevolent_shrine )

                end)

                timer.Create("Malevolent_Shrine", 0.1, 5, function() -- 25 sec
                    if not IsValid(ply.center) or not IsValid(ply.malevolent_shrine) or not ply:GetNWBool("sukuna_domainActive") then return end
                    local entities = ents.FindInSphere(ply.center:GetPos(), range)
                    util.ScreenShake( ply.malevolent_shrine:GetPos(), 100, 40, 0.5, range, true )

                    for _, ent in ipairs(entities) do
                        if IsValid(ent) and ( ent ~= ply ) and ( ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:IsVehicle() ) then

                            rand = math.random(1,3)

                            if rand == 3 then
                                ParticleEffect( "shrine_slash", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward(), Angle(0,0,0), ent )
    
                            elseif rand == 2 then
                                ParticleEffect( "waffle", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                            else
                                ParticleEffect( "slashes_normal", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward(), Angle(0,0,0), ent )
        
                            end
                            ParticleEffect( "smash", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                            ParticleEffect( "cleave_smash", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward(), Angle(0,0,0), ent )

                            ent:EmitSound("sukuna/dismantle_hit.wav", 350, 100, 1, CHAN_STATIC)
                            ent:TakeDamage(damage, ply, ply)
                            util.ScreenShake( ent:GetPos(), 10, 40, 0.3, 300, true )

                        end   
                    end
                
                end)
    
            end)
        end)
       
        
       
        timer.Simple(25+4+4, function() -- i hate timing sound

            ply:SetNWBool("sukuna_domainActive", false)

            if IsValid(ply.malevolent_shrine) then
                ply.malevolent_shrine:EmitSound("sukuna/shrine_open.wav", 511, 100, 1, CHAN_STATIC)
                util.ScreenShake( ply.malevolent_shrine:GetPos(), 100, 40, 10, range, true )
            end

            timer.Simple(4, function()
            
                timer.Create("Malevolent_Shrine_disappear", 0.01, 250, function()
    
                    if IsValid(ply.malevolent_shrine) and IsValid(ply.center) then
                        ply.center:SetPos(ply.center:GetPos() + Vector(0,0,-2))
                        ply.malevolent_shrine:SetPos(ply.center:GetPos())
                    end
                end)
        
                timer.Simple(2.5+4, function()
                    
                    if IsValid(ply.center) then
                        ply.center:Remove()
                    end
        
                    if IsValid(ply.malevolent_shrine) then
                        ply.malevolent_shrine:Remove()
                    end
        
                    if IsValid(ply) then
                        ply:ChatPrint("COOLDOWN: 'Domain Expansion: Malevolent Shrine' - 15 minutes")
                    end

                    
                end)
            end)
        end)

        timer.Simple((25+8)+ cooldown, function()
            ply:SetNWBool("sukuna_domain", false) 
            if IsValid(ply) then
                ply:ChatPrint("COOLDOWN: 'Domain Expansion: Malevolent Shrine' is off cooldown!")
            end
        end)
    
    end
end

function SWEP:KeyPress(ply, key)
    if key == IN_USE or key == IN_RELOAD then
        if ply:GetNWBool("sukuna") then
            if ply:GetNWInt("sukuna_mode") == 1 then
                self:SetHoldType("fist")
            elseif ply:GetNWInt("sukuna_mode") == 2 then
                self:Dismantle(ply, key)
            elseif ply:GetNWInt("sukuna_mode") == 3 then
                self:Cleave(ply, key)
            elseif ply:GetNWInt("sukuna_mode") == 4 then
                self:Fuga(ply, key)
            else
                self:Domain(ply, key)  -- somehow if else
            end
            return
        end
        if ply:GetNWInt("vessel_mode") == 1 then
            self:SetHoldType("fist")
        elseif ply:GetNWInt("vessel_mode") == 2 then
            self:SetHoldType("fist")
        elseif ply:GetNWInt("vessel_mode") == 3 then
            self:Enchain(ply, key)
            self:SetHoldType(defaultHoldType)
        else
            --self:Melee(ply, key) -- somehow if else
            self:SetHoldType(defaultHoldType)
        end
    end
end

function SWEP:DoPunch(condition) -- catch these hands
    
    local ply = self:GetOwner()
    
    if not IsValid(ply) or ply:GetNWBool("vessel_punch") or not SERVER then return end

    ply:SetNWBool("vessel_punch", true) 

    ply:LagCompensation(true)

    local swings = {"swing.wav", "swing2.wav"}
    local hit   = "hit.wav"

    if condition == 1 then
        swings = {Sound('divergent_fist/swing1.wav'), Sound('divergent_fist/swing2.wav'), Sound('divergent_fist/swing3.wav')}
        hits   = {Sound('divergent_fist/hit1.wav'), Sound('divergent_fist/hit3.wav'), Sound('divergent_fist/hit3.wav')}
    end

    local damage
    local swing

    local cooldown = 0.1
    if ply:GetNWBool("vessel_zone") then cooldown = 0.1 end

    damage = math.random(1,50)

    if ply:GetNWBool("sukuna_domainActive") or ply:GetNWBool("vessel_zone") then
        damage = damage*1.5
    end
    
    swing = swings[math.random(#swings)]

    local range = 25

    if ply:GetNWBool("sukuna") and condition == 2 then
        range = range*2
    
    elseif ply:GetNWBool("sukuna") then
        damage = damage*2
  
    end
    
    local trace = util.TraceHull({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
        filter = ply,
        mins = Vector(-45, -45, -45),
        maxs = Vector(45, 45, 45)
    })

    if condition ~= 2 then

        self:SetHoldType('fist')
        ply:SetAnimation(PLAYER_ATTACK1)
        ply:EmitSound(swing, 340, 100, 1, CHAN_STATIC)
        
        local entities = ents.FindInSphere(trace.HitPos, 100)
        local lentities  = {} -- lentities>?>?? IM DYING
    
        for _, ent in ipairs(entities) do
            if ent:IsValid() and ( ent ~= ply) and ent:IsPlayer() and not ent:GetNWBool("barrier") then
                table.insert(lentities, ent)
            end
        end
       
        timer.Simple(0.1, function()
    
            if #lentities > 0 then
                local rand = 50
    
                if ply:GetNWBool("sukuna") then
                    rand = 400
                end

                if condition ~= 1 then
                    if math.random(1,rand) == 1 then
                        self:BlackFlash(ply, damage, lentities, trace)
                        return
                    end
                end

                if condition == 1 then
                    ParticleEffect( "df_normal", trace.HitPos, Angle(0,0,0), ply )

                elseif ply:GetNWBool("sukuna") and condition ~= 3 then
                    ParticleEffect( "smash", trace.HitPos, Angle(0,0,0), ply )
                elseif ply:GetNWBool("sukuna") and condition == 3 then
                    ParticleEffect( "cleave_smash", trace.HitPos, Angle(0,0,0), ply )
                else
                    ParticleEffect( "vs_normal", trace.HitPos, Angle(0,0,0), ply )

                end
            else
                return
            end
    
            for _, ent in ipairs(lentities) do
    
                if IsValid(ent) and SERVER then

                    if condition == 1 then
                        local cost = 150
                        ply:SetNWInt("vessel_ce", ply:GetNWInt("vessel_ce") - cost)
                        ent:TakeDamage(damage*1.5, ply, self)
                        timer.Simple(0.1, function()
                            if IsValid(ent) then
                                ent:TakeDamage(damage/1.5, ply, self) -- effects of divergent fist
                                ent:EmitSound("divergent_fist/aftershock.wav", 340, 100, 2, CHAN_STATIC)
                                ParticleEffect( "df_normal", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward(), Angle(0,0,0), ent)
                            end
                        end)
                    elseif condition == 2 then
                        ent:TakeDamage(damage*1.5, ply, self)
                    elseif condition == 3 and ply:GetNWBool("sukuna") then
                        ent:TakeDamage(damage, ply, self)
                        timer.Simple(0.5, function()
                            if IsValid(ent) and SERVER then
                                local cost = 500
                                ply:SetNWInt("sukuna_ce", ply:GetNWInt("sukuna_ce") - cost)
                                timer.Create("vessel_normal_cleave_slashes", 0.1, 5, function()
                                    if (!IsValid(ply) or !IsValid(ent)) then return end
                                    ParticleEffect( "shrine_slash", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward() + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                                    ParticleEffect( "smash", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward() + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
                                    ent:TakeDamage(damage*0.25, ply, self) -- effects of cleave
                                    ent:EmitSound("sukuna/slashes_hit.wav", 340, 100, 2, CHAN_STATIC)


                                end)
                            end
                        end)
                    else
                        ent:TakeDamage(damage, ply, self)
                        ent:EmitSound(hit, 340, math.random(70,100), 1, CHAN_STATIC)
                    end
                    
                    util.ScreenShake( ply:GetPos(), 10, 40, 0.5, 100, true)
        
                    local phys = ent:GetPhysicsObject()
        
                    if IsValid(phys) and SERVER then
                        local dir = (ent:GetPos() - ply:GetPos()):GetNormalized()
                        local force = 500
                        if IsValid(phys) then phys:SetVelocity(dir * force) end
                    end
                end
            end 
        end)
    else
        -- normal slashes

        local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
            filter = ply,
            mins = Vector(-45, -45, -45),
            maxs = Vector(45, 45, 45)
        })
    
        cooldown = 0.05
        timer.Create("vessel_normal_slashes", 0.02, 1, function()
            if (!IsValid(ply) ) then return end
            ParticleEffect( "slash_normal", trace.HitPos + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
            ply:EmitSound("sukuna/dismantle_hit.wav", 340, math.random(50, 90), 2, CHAN_STATIC)
            util.ScreenShake( trace.HitPos, 10, 40, 0.5, 100, true)


        end)

        ParticleEffect( "slash_normal", trace.HitPos, Angle(0,0,0), ply )
        local entities = ents.FindInSphere(trace.HitPos, 100)

        for _, ent in ipairs(entities) do
            if ent:IsValid() and ( ent ~= ply and ent:IsPlayer() ) and not ent:GetNWBool("barrier") then
                if ent:GetNWBool("barrier") then return end
                if IsValid(ent) then
                    ParticleEffect( "smash", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward(), Angle(0,0,0), ent )
                    ent:TakeDamage(damage*1.5, ply, self)
                    ent:EmitSound("sukuna/slashes_hit.wav", 340, math.random(70, 90), 2, CHAN_STATIC)
                    util.ScreenShake( ent:GetPos(), 10, 40, 0.5, 100, true)

                    if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() or ent:IsRagdoll() then
                        ParticleEffect( "slash_hit", trace.HitPos, Angle(0,0,0), ply )
                    end
    
                end
                
            end
        end
    end

    ply:LagCompensation(false)

    timer.Simple(cooldown, function()
        ply:SetNWBool("vessel_punch", false) 

        self:SetHoldType(defaultHoldType)
    end)
end

function SWEP:DoHeavy(condition) -- catch THIS hand...
    local ply = self:GetOwner()
 
    if ( not IsValid(ply) or ply:GetNWBool("vessel_heavy") or not SERVER ) then return end

    ply:SetNWBool("vessel_heavy", true)

    ply:LagCompensation(true)
  
    local hit   = "heavy_hit.wav"
    local swing = "heavy_swing.wav"

    local cooldown = 1

    if condition == 1 then
        hit   = "divergent_fist/heavyhit.wav"
        swing = "divergent_fist/swing1.wav"
    end

    damage = math.random(1,50)

    if ( ply:GetNWBool("sukuna_domainActive") or ply:GetNWBool("vessel_zone") ) then
        damage = damage*1.5
    end

    local range = 25

    if ply:GetNWBool("sukuna") and condition == 2 then
        range = range*3
       
    elseif ply:GetNWBool("sukuna") then
        damage = damage*2

    end

    local trace = util.TraceHull({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
        filter = ply,
        mins = Vector(-45, -45, -45),
        maxs = Vector(45, 45, 45)
    })
 
    if condition ~= 2 then

        self:SetHoldType('melee')
        ply:SetAnimation(PLAYER_ATTACK1)
        ply:EmitSound(swing, 340, 100, 1, CHAN_STATIC)
        
        local entities = ents.FindInSphere(trace.HitPos, 100)
        local lentities  = {} -- lentities>?>?? IM DYING
    
        for _, ent in ipairs(entities) do
            if ent:IsValid() and ( ent ~= ply) and ent:IsPlayer() and not ent:GetNWBool("barrier") then
                table.insert(lentities, ent)
            end
        end
        
        timer.Simple(0.1, function()
    
            if #lentities > 0 then
                local rand = 25
    
                if ply:GetNWBool("sukuna") then
                    rand = 50
                end

                if condition ~= 1 then
                    if math.random(1,rand) == 1 then
                        self:BlackFlash(ply, damage, lentities, trace)
                        return
                    end
                end

                if condition == 1 then
                    ParticleEffect( "df_heavy", trace.HitPos, Angle(0,0,0), ply )

                elseif ply:GetNWBool("sukuna") and condition ~= 3 then
                    ParticleEffect( "smash", trace.HitPos, Angle(0,0,0), ply )
                elseif ply:GetNWBool("sukuna") and condition == 3 then
                    ParticleEffect( "cleave_smash", trace.HitPos, Angle(0,0,0), ply )
                else
                    ParticleEffect( "vs_normal", trace.HitPos, Angle(0,0,0), ply )

                end
            else
                return
            end
    
            for _, ent in ipairs(lentities) do
    
                if IsValid(ent) and SERVER then

                    if condition == 1 then
                        local cost = 450
                        ply:SetNWInt("vessel_ce", ply:GetNWInt("vessel_ce") - cost)
                        ent:TakeDamage(damage*1.5, ply, self)
                        ent:EmitSound("divergent_fist/heavyhit.wav", 340, 100, 2, CHAN_STATIC)

                        timer.Simple(0.1, function()
                            if IsValid(ent) and SERVER then
                                ent:TakeDamage(damage/2, ply, self) -- effects of divergent fist
                                ent:EmitSound("divergent_fist/aftershock.wav", 340, 100, 2, CHAN_STATIC)
                            end
                        end)
                    elseif condition == 3 and ply:GetNWBool("sukuna") then
                        ent:TakeDamage(damage, ply, self)
                        timer.Simple(0.5, function()
                            if IsValid(ent) and SERVER then
                                local cost = 800
                                ply:SetNWInt("sukuna_ce", ply:GetNWInt("sukuna_ce") - cost)
                                timer.Create("vessel_normal_cleave_slashes", 0.1, 3, function()
                                    ent:TakeDamage(damage*0.5, ply, self) -- effects of cleave
                                    ParticleEffect( "shrine_slash", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward() + Vector(math.random(-40,40), math.random(-40,40), 40), Angle(math.random(0,360),math.random(0,360),math.random(0,360)), ply )
                                    ent:EmitSound("sukuna/cleave_hit.wav", 340, 100, 2, CHAN_STATIC)
                                end)
                            end
                        end)
                    else
                        ent:TakeDamage(damage, ply, self)
                        ent:EmitSound(hit, 340, 100, 2, CHAN_STATIC)
                    end
                    
                    util.ScreenShake( ply:GetPos(), 10, 40, 0.5, 100, true)
        
                    local phys = ent:GetPhysicsObject()
        
                    if IsValid(phys) and SERVER then
                        local dir = (ent:GetPos() - ply:GetPos()):GetNormalized()
                        local force = 50000
                        if IsValid(phys) then phys:SetVelocity(dir * force) end
                    end
                end
            end 
        end)
    else
        local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
            filter = ply,
            mins = Vector(-45, -45, -45),
            maxs = Vector(45, 45, 45)
        })
    
     
        -- heavy slashes
        timer.Create("vessel_normal_slashes", 0.02, 5, function()
            if (!IsValid(ply) ) then return end
            ParticleEffect( "slash_normal", trace.HitPos + Vector(math.random(-40,40), math.random(-40,40), math.random(-40,40)), Angle(math.random(50,180),math.random(50,180),math.random(50,180)), ply )
            ply:EmitSound("sukuna/dismantle_hit.wav", 340, math.random(50, 90), 2, CHAN_STATIC)
            util.ScreenShake( trace.HitPos, 10, 40, 0.5, 100, true)

        end)

        local entities = ents.FindInSphere(trace.HitPos, 100)

        for _, ent in ipairs(entities) do
            if ent:IsValid() and ( ent ~= ply and ent:IsPlayer() ) and not ent:GetNWBool("barrier") then
                
                if IsValid(ent) then
                    ParticleEffect( "smash", ent:EyePos() - Vector(0, 0, 40) + ent:EyeAngles():Forward(), Angle(0,0,0), ent )

                    ent:TakeDamage(damage*1.1, ply, self)
                    
                    ent:EmitSound("sukuna/slashes_hit.wav", 340,  math.random(70, 90), 1, CHAN_STATIC)
                    util.ScreenShake( ply:GetPos(), 10, 40, 0.5, 100, true)
    
                    if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
                        ParticleEffect( "slash_hit", trace.HitPos, Angle(0,0,0), ply )
    
                    end
                end
                
            end
        end
        
    end

    if ply:GetNWBool("vessel_zone") then
        cooldown = 0.6
    end

    timer.Simple(cooldown, function()
        ply:SetNWBool("vessel_heavy", false)

    end)
end

function SWEP:PrimaryAttack()
    local ply = self:GetOwner()

    local cost = 150
    local currentCE = ply:GetNWInt("vessel_ce")

    if ply:GetNWInt("vessel_mode") == 2 and not ply:GetNWBool("sukuna") then
        if currentCE >= cost then
            self:DoPunch(1)
        end
        return
    end

    if ply:GetNWInt("sukuna_mode") == 2 and ply:GetNWBool("sukuna") then -- dismantle
        cost = 600
        currentCE = ply:GetNWInt("sukuna_ce")
        if currentCE >= cost then
            ply:SetNWInt("sukuna_ce", ply:GetNWInt("sukuna_ce") - cost)
            self:DoPunch(2)
        end
        return
    elseif ply:GetNWInt("sukuna_mode") == 3 and ply:GetNWBool("sukuna") then -- cleave
        cost = 500
        currentCE = ply:GetNWInt("sukuna_ce")
        if currentCE >= cost then
            self:DoPunch(3)
        end
        return
    end
    self:DoPunch(0)
end

function SWEP:SecondaryAttack()
    local ply = self:GetOwner()

    local cost = 450
    local currentCE = ply:GetNWInt("vessel_ce")

    if ply:GetNWInt("vessel_mode") == 2 and not ply:GetNWBool("sukuna") then
        if currentCE >= cost then
            self:DoHeavy(1)
        end
        return
    end

    if ply:GetNWInt("sukuna_mode") == 2 and ply:GetNWBool("sukuna") then -- dismantle
        cost = 500
        currentCE = ply:GetNWInt("sukuna_ce")
        if currentCE >= cost then
            ply:SetNWInt("sukuna_ce", ply:GetNWInt("sukuna_ce") - cost)
            self:DoHeavy(2)
        end
        return
    elseif ply:GetNWInt("sukuna_mode") == 3 and ply:GetNWBool("sukuna") then -- cleave
        cost = 800
        currentCE = ply:GetNWInt("sukuna_ce")
        if currentCE >= cost then
            
            self:DoHeavy(3)
        end
        return
    end

    self:DoHeavy(0)
end

local function SwitchMode(ply)
    if ply:GetNWBool("vessel_debounce") then return end
    ply:SetNWBool("vessel_debounce", true)

    timer.Simple(0.01, function()
        ply:SetNWBool("vessel_debounce", false)
    end)

    if ply:GetNWBool("sukuna") then
        
    
        if ply:GetNWBool("vessel_shift") then
            -- go back a mode
    
            if IsValid(ply) then
                local current = ply:GetNWInt("sukuna_mode")
                ply:SetNWInt("sukuna_mode", current - 1)
    
                if ply:GetNWInt("sukuna_mode") <= 0 then
                    ply:SetNWInt("sukuna_mode", 5)
                end
            end
            return
        end
    
        -- go up a mode
    
        if IsValid(ply) then
            local current = ply:GetNWInt("sukuna_mode")
            ply:SetNWInt("sukuna_mode", current + 1)
    
            if ply:GetNWInt("sukuna_mode") > 5 then
                ply:SetNWInt("sukuna_mode", 1)
            end
        end

        if ply:GetNWInt("sukuna_mode") == 4 and ply:GetNWInt("sukuna_ce") >= 8000 then
            ply:EmitSound("sukuna/open.wav", 340, 100, 2, CHAN_STATIC)
        end

        return
    end

    if ply:GetNWBool("vessel_shift") then
        -- go back a mode

        if IsValid(ply) then
            local current = ply:GetNWInt("vessel_mode")
            ply:SetNWInt("vessel_mode", current - 1)

            if ply:GetNWInt("vessel_mode") <= 0 then
                ply:SetNWInt("vessel_mode", 3)
            end
        end
        return
    end

    -- go up a mode

    if IsValid(ply) then
        local current = ply:GetNWInt("vessel_mode")
        ply:SetNWInt("vessel_mode", current + 1)

        if ply:GetNWInt("vessel_mode") > 3 then
            ply:SetNWInt("vessel_mode", 1)
        end
    end

    if ply:GetNWInt("vessel_mode") == 2 then
        ply:EmitSound("divergent_fist/equip.wav", 340, 100, 2, CHAN_STATIC)
    end
end



hook.Add("GetFallDamage", "vessel_GetFallDamage", function(ply)-- no more silly fall damage
    if IsValid(ply) then
        if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "vessel" then
            return 0
        end
    end
end)

hook.Add("PlayerButtonDown", "vessel_SwitchModes", function(ply, button)
    if !ply:Alive() then return end
    if button == KEY_LALT and IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "vessel" then
        SwitchMode(ply)
    end
end)

hook.Add("KeyPress", "vessel", function(ply, key)
    
    if ply:InVehicle() then return end

    local weapon = ply:GetActiveWeapon()

    if IsValid(weapon) and weapon.KeyPress then
        weapon:KeyPress(ply, key)
    end

end)

function SWEP:Deploy()
    if SERVER then
        self.Owner:SetNWInt("vessel_fingers", 20)
    end
end

local nextheal = 0

function SWEP:Think()
    local ply = self:GetOwner()
    
    if not IsValid(ply) then return end

    if ply:GetMaxHealth() < 500 then
        ply:SetMaxHealth(500)
        if nextheal > CurTime() then return end  
        ply:SetHealth(ply:Health() + 50)
        if ply:Health() > 500 then ply:SetHealth(500) end
        nextheal = CurTime() + 5
    end

    if ply:GetNWBool("vessel_mode") == 1 or ply:GetNWBool("vessel_mode") == 2 then
        self:SetHoldType("fist")

    else
        self:SetHoldType(defaultHoldType)

    end

    local currentHealth = ply:Health()
    local maxHealth = ply:GetMaxHealth()
    local maxCE = 2000
    local currentCE = ply:GetNWInt("vessel_ce")

    if ply:GetNWInt("vessel_fingers") == 0 then
        maxCE = 2000
    else
        maxCE = 2500 + (500*ply:GetNWInt("vessel_fingers"))
    end
    
    if ply:KeyDown(IN_SPEED) then

        if ply:InVehicle() then return end
        ply:SetNWBool("vessel_shift", true)

    elseif ply:GetNWBool("vessel_shift") then
        ply:SetNWBool("vessel_shift", false)
    end

    if ply:GetNWBool("sukuna") then -- sukuna values

        if ply:GetNWBool("sukuna_mode") == 1 or ply:GetNWBool("sukuna_mode") == 3  then

            self:SetHoldType("fist")

        elseif ply:GetNWBool("sukuna_mode") == 4 then 

            self:SetHoldType("melee")

        else
            self:SetHoldType(defaultHoldType)
        end

        maxCE     = maxCE * 2
       -- maxHealth = ply:GetNWInt("sukuna_maxHP", 500)
        currentCE = ply:GetNWInt("sukuna_ce", 5000)

        --[[[if not self.AddHealth then self.AddHealth = 0 end

        if ply:Health() < maxHealth and self.AddHealth < CurTime() then
            if ply:GetNWBool("vessel_zone") then
                ply:SetHealth(math.Clamp(ply:Health() + 10, 0, maxHealth) or 100)

                self.AddHealth = CurTime() + 0.2
            else
                ply:SetHealth(math.Clamp(ply:Health() + 5, 0, maxHealth) or 100)

                self.AddHealth = CurTime() + 0.2
            end
        end]]

        if currentCE < maxCE then
            if ply:GetNWInt("vessel_zone") then
                ply:SetNWInt("sukuna_ce", math.min(currentCE + 40, maxCE))
            else
                timer.Simple(1, function()
                    ply:SetNWInt("sukuna_ce", math.min(ply:GetNWInt("sukuna_ce") + 20, maxCE))
    
                end)
            end
        elseif currentCE <= 0 then
            ply:SetNWInt("sukuna_ce", 0)
        elseif currentCE > maxCE then
            ply:SetNWInt("sukuna_ce", maxCE)
        end

        ply:SetJumpPower(300)
        ply:SetRunSpeed(380)
        ply:SetGravity(0.8)

        if ply:GetNWBool("vessel_zone") then ply:SetRunSpeed(380) ply:SetJumpPower(300) end

        --[[if not ply:GetNWBool("sukuna_equipped") then
            ply:SetHealth(maxHealth or 100)
            ply:SetNWBool("sukuna_equipped", true)
        end]]

        if ply:GetNWInt("sukuna_mode") == 4 and ply:GetNWInt("sukuna_ce") >= 8000 and not ply:GetNWBool("sukuna_open") then -- flame arrow on hand effect
      
            local hand  = ply:LookupBone("ValveBiped.Bip01_R_Hand")
            if not hand then return end
        
            local handPos, handAng = ply:GetBonePosition(hand)
    
            timer.Simple(0.1, function()
                if not IsValid(ply) or ply:GetNWInt("sukuna_mode") ~= 4  then return end
                ParticleEffect( "flame_arrow_hand", handPos, Angle(0,0,0), ply )
            end)   
        end

        return
    else
        --maxHealth = ply:GetNWInt("vessel_maxHP", 500)

        --[[if not self.AddHealth then self.AddHealth = 0 end

        if ply:Health() < maxHealth and self.AddHealth < CurTime() then
            if ply:GetNWBool("vessel_zone") then
                ply:SetHealth(math.Clamp(ply:Health() + 10, 0, maxHealth) or 100)

                self.AddHealth = CurTime() + 0.2
            else
                ply:SetHealth(math.Clamp(ply:Health() + 5, 0, maxHealth) or 100)

                self.AddHealth = CurTime() + 0.2
            end
        end]]
    end

    if currentCE < maxCE then
        if ply:GetNWInt("vessel_zone") then
            ply:SetNWInt("vessel_ce", math.min(currentCE + 5, maxCE))
        else
            timer.Simple(0.5, function()
                ply:SetNWInt("vessel_ce", math.min(ply:GetNWInt("vessel_ce") + 5, maxCE))
                
            end)
        end
    elseif currentCE <= 0 then
        ply:SetNWInt("vessel_ce", 0)
    elseif currentCE > maxCE then
        ply:SetNWInt("vessel_ce", maxCE)
    end

    if not ply:GetNWBool("vessel_equipped") then
        --ply:SetHealth(maxHealth or 100)
        --ply:SetNWInt("vessel_maxHP", maxHealth)
        ply:SetNWBool("vessel_equipped", true)
    end
    
    ply:SetJumpPower(300)
    ply:SetRunSpeed(380)
    ply:SetGravity(0.8)
    if ply:GetNWBool("vessel_zone") then ply:SetRunSpeed(380) ply:SetJumpPower(300) end

    if ply:GetNWInt("vessel_mode") == 2 then -- divergent fist effects
        
        local rightHand = ply:LookupBone("ValveBiped.Bip01_R_Hand")
        local leftHand  = ply:LookupBone("ValveBiped.Bip01_L_Hand")
        if not rightHand or not leftHand then return end
    
        local RHandPos, RHandAng = ply:GetBonePosition(rightHand)
        
        local LHandPos, LHandAng = ply:GetBonePosition(leftHand)

        timer.Simple(0.01, function()
            if not IsValid(ply) or ply:GetNWInt("vessel_mode") ~=2 then return end
            ParticleEffect( "divergent_fist", RHandPos, Angle(0,0,0), ply )
            ParticleEffect( "divergent_fist", LHandPos, Angle(0,0,0), ply )
        end)
    end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
