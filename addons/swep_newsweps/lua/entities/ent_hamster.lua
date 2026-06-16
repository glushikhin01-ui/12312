--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()
local CLIENT = CLIENT
local util = util
local table = table
local EffectData = EffectData
local Vector = Vector
local util_Effect = util.Effect
local util_BlastDamage = util.BlastDamage
local util_TraceLine = util.TraceLine
local util_Decal = util.Decal
local table_Random = table.Random
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Hamster"
ENT.Spawnable = false
ENT.AutomaticFrameAdvance = true
ENT.RenderGroup = 7
ENT.VV = 250
local pitch, fol = 165, "vo/npc/male01/"

local sound_ = {"no02", "pain07", "pain08", "pain09", "hacks01", "help01"}

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end

function ENT:VariantR(v)
    if CheckRobert() then
        if v == "1" then
            self.VV = 250
        elseif v == "2" then
            self.VV = 1000
        elseif v == "3" then
            self.VV = 9999999
        else
            self.VV = 250
        end
    end
end

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/homyak/homyak.mdl")
        self:PhysicsInit(6)
        self:SetSolid(6)
        self:SetMoveType(6)
        self:SetNW2Int(self:EntIndex()..'RobertUnRobert', CurTime() + 20)
        local phys = self:GetPhysicsObject()

        if phys:IsValid() then
            phys:Wake()
            phys:EnableMotion(true)
        end

        if CheckRobertSound() then
            self:EmitSound(fol .. table_Random(sound_) .. ".wav", 80, pitch)
        end

    end

    function ENT:PhysicsCollide(data, phys)
        self:Explode()
    end

    function ENT:Think()
        if IsValid(self) and self:GetNW2Int(self:EntIndex()..'RobertUnRobert') < CurTime() then
            self:Remove()
        end
    end

    function ENT:Explode()
        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos())
        util_Effect("Explosion", effectdata)

        if CheckRobert() then
            if self.VV == 9999999 then
                util_BlastDamage(self, self, self:GetPos(), self.VV, self.VV)
            else
                util_BlastDamage(self, self, self:GetPos(), self.VV, 150)
            end
        else
            if CheckDefault() then
                if CheckDefault() == 3 then
                    util_BlastDamage(self, self, self:GetPos(), 9999999, 9999999)
                elseif CheckDefault() == 2 then
                    util_BlastDamage(self, self, self:GetPos(), 1000, 150)
                elseif CheckDefault() == 1 then
                    util_BlastDamage(self, self, self:GetPos(), 250, 150)
                end
            else
                util_BlastDamage(self, self, self:GetPos(), self.VV, 150)
            end
        end

        local spos = self:GetPos()

        local trs = util_TraceLine({
            start = spos + Vector(0, 0, 64),
            endpos = spos + Vector(0, 0, -32),
            filter = self
        })

        util_Decal("Scorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)
        self:Remove()
    end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
