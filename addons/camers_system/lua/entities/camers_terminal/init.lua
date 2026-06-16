AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_lab/monitor02.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if not IsValid(caller) or not caller:IsPlayer() then return end

    if not CamersSystem.IsPolice(caller) then
        caller:ChatPrint("[Камеры] У вас нет доступа к системе наблюдения!")
        return
    end

    net.Start("CamersSystem_Open")
    net.Send(caller)
end
