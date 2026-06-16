--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Sukuna's Finger"
ENT.Author = "minwool"
ENT.Category = "Other"

ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:Initialize()

    if SERVER then
        self:SetModel("models/sukuna/finger.mdl")
        self:SetModelScale(4.5)
        self:SetColor(Color(137,119,119))
        self:SetMaterial("finger")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        self:SetNWBool("debounce", false)

        local phys = self:GetPhysicsObject()


        if phys:IsValid() then
            phys:Wake()
        end

    end
end

function ENT:Use(ply, caller)
    if not ply:IsPlayer() or not ply:IsValid() then return end
    if ply:GetNWBool("vessel_equipped") then

        if ply:GetNWInt("vessel_fingers") == 20 then
            if self:GetNWBool("debounce") then return end
            self:SetNWBool("debounce", true)
            timer.Simple(0.5, function() self:SetNWBool("debounce", false) end)
            ply:EmitSound("sukuna/finger/fool.wav", 340, 100, 2, CHAN_STATIC)
            ply:ChatPrint("Sukuna: You fool. You already have all 20 of my fingers.")
            return
        end
        ply:SetNWInt("vessel_fingers", ply:GetNWInt("vessel_fingers") + 1)
        ParticleEffect( "smash", ply:GetPos()+ Vector(0,0,40), Angle(0,0,0), ply )

        if ply:GetNWInt("vessel_fingers") == 1 then
            timer.Simple(0.5, function() ply:EmitSound("sukuna/finger/taunt.wav", 340, 100, 2, CHAN_STATIC) end)
            
            
        else
            ply:EmitSound("sukuna/finger/sukunaDing.wav", 340, 100, 2, CHAN_STATIC)

        end
        ply:EmitSound("sukuna/finger/eat.wav", 340, 100, 2, CHAN_STATIC)
        
        self:Remove()
    else
        if self:GetNWBool("debounce") then return end
        self:SetNWBool("debounce", true)
        ply:ChatPrint("<You need to equip Sukuna's Vessel first>")
        timer.Simple(0.5, function() self:SetNWBool("debounce", false) end)
    end
end

function ENT:Think()
    if not IsValid(self) then return end

    ParticleEffect( "finger", self:GetPos(), Angle(0,0,0), self )

end


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
