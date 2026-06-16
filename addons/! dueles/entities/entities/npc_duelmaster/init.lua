AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/smith.mdl") -- можно заменить на любую модель
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()
end

function ENT:AcceptInput(name, activator, caller)
    if name == "Use" and IsValid(caller) and caller:IsPlayer() then
        -- Отправляем сигнал клиенту открыть меню дуэлей
        net.Start("Duels_OpenMenu")
        net.Send(caller)
    end
end
