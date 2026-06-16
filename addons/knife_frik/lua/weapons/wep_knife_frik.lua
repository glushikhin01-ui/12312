-- НОЖ FRIK - УРОН ЧЕРЕЗ ЗДОРОВЬЕ
SWEP.PrintName = "Frik Knife"
SWEP.Author = "Frikadelka"
SWEP.Instructions = "ЛКМ - удар (bam), ПКМ - звук (zarejy)"
SWEP.Category = "Frik Addons"

-- СПИСОК РАЗРЕШЕННЫХ STEAMID
local allowedSteamIDs = {
    ["STEAM_0:0:562541572"] = true,  -- Замените на свой SteamID
    ["STEAM_0:1:87654321"] = false,  -- Добавьте других через запятую
    -- Пример: ["STEAM_0:0:123456789"] = true,
}

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

-- Модели
SWEP.ViewModel = "models/weapons/horizon/v_csgo_ursus.mdl"
SWEP.WorldModel = "models/weapons/horizon/w_csgo_ursus.mdl"
SWEP.ViewModelFOV = 65
SWEP.UseHands = true

-- Патроны
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Damage = 3000
SWEP.Primary.Delay = 0.8

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HoldType = "knife"

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
    util.PrecacheSound("knife_sound/bam.wav")
    util.PrecacheSound("knife_sound/zarejy.wav")
end

-- Проверка доступа по SteamID
function SWEP:CanAccess()
    local owner = self:GetOwner()
    if not IsValid(owner) then return false end
    if not owner:IsPlayer() then return false end
    
    local steamID = owner:SteamID()
    return allowedSteamIDs[steamID] or false
end

-- ПКМ - ТВОЙ ЗВУК (с проверкой)
function SWEP:SecondaryAttack()
    if not self:CanAccess() then
        if SERVER then
            self:GetOwner():ChatPrint("У вас нет доступа к этому ножу!")
        end
        return
    end
    
    self:EmitSound("knife_sound/zarejy.wav", 100, 100)
    self:SetNextSecondaryFire(CurTime() + 1.0)
end

-- ЛКМ - УРОН И ЗВУК (с проверкой)
function SWEP:PrimaryAttack()
    if not self:CanAccess() then
        if SERVER then
            self:GetOwner():ChatPrint("У вас нет доступа к этому ножу!")
        end
        return
    end
    
    -- Звук
    self:EmitSound("knife_sound/bam.wav", 100, 100)
    
    -- Анимация
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    
    -- УРОН ХАРДКОР
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
    
    -- Трейс
    local trace = util.TraceLine({
        start = owner:GetShootPos(),
        endpos = owner:GetShootPos() + owner:GetAimVector() * 80,
        filter = owner
    })
    
    -- ЕБАШИМ
    if IsValid(trace.Entity) and trace.Entity:IsPlayer() and trace.Entity ~= owner then
        if SERVER then
            -- ПРЯМОЕ ИЗМЕНЕНИЕ ЗДОРОВЬЯ
            local newHealth = trace.Entity:Health() - self.Primary.Damage
            trace.Entity:SetHealth(newHealth)
            
            -- Кровь
            util.Decal("Blood", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)
            
            -- Если умер
            if newHealth <= 0 then
                trace.Entity:Kill()
            end
        end
    end
end

-- Функция для выдачи ножа (можно вызвать из консоли)
function GiveFrikKnife(ply)
    if not IsValid(ply) then return end
    if not allowedSteamIDs[ply:SteamID()] then
        ply:ChatPrint("У вас нет доступа к Frik Knife!")
        return
    end
    ply:Give("wep_knife_frik")
end

-- Для сервера
if SERVER then
    resource.AddFile("sound/knife_sound/bam.wav")
    resource.AddFile("sound/knife_sound/zarejy.wav")
    
    -- Консольная команда для выдачи ножа админам
    concommand.Add("give_frik_knife", function(ply, cmd, args)
        if not IsValid(ply) then return end
        GiveFrikKnife(ply)
    end)
end