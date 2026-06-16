--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

SWEP.Author              = "Jonascone"
SWEP.Contact             = ""
SWEP.Purpose             = "The Blink power from Dishonored!"
SWEP.Instructions        = "Hold left-click to charge, then, let go to Blink!"

SWEP.Spawnable                  = true
SWEP.AdminSpawnable             = false

SWEP.UseHands = true
SWEP.ViewModel                  = "models/weapons/v_blink.mdl"
SWEP.HoldType                   = "normal"
SWEP.ViewModelFOV               = 55

SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = -1
SWEP.Primary.Automatic          = true
SWEP.Primary.Ammo               = "none"

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = true
SWEP.Secondary.Ammo             = "none"

function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)
    self.Weapon:DrawShadow(false)
    self.IsHolding = false
    self.IndicatorDelay = 0
    self.ShouldJump = false
    self.ShouldTeleport = false
    self.ShouldSpawnUnder = false
    self.ShouldSpawnAbove = false         
    return true
end
function SWEP:PreDrawViewModel( vm, wep, ply )
	vm:SetMaterial("engine/occlusionproxy") -- Hide that view model with hacky material
end
function SWEP:DrawWorldModel() return false end 
function SWEP:Deploy()
    self.IsHolding = false
    self.IndicatorDelay = 0
    self.ShouldJump = false
    self.ShouldTeleport = false
    self.ShouldSpawnUnder = false
    self.ShouldSpawnAbove = false  
    if (CLIENT) then return true end
    //self.Owner:SetFOV(75, 0.125)   
    self:SendWeaponAnim(ACT_VM_DRAW)
    self:Idle()
end
function SWEP:OnRemove()
    if (!IsValid(self.Owner)) then return end
    local vm = self.Owner:GetViewModel()
    timer.Destroy("blink_reset" .. self.Owner:UniqueID())
    timer.Destroy("blink_anim" .. self.Owner:UniqueID())
    if (!IsValid(vm)) then return end
    vm:SetMaterial("")
end
function SWEP:Holster()
    self:OnRemove()
    return true
end
function SWEP:Idle()
    timer.Create("blink_anim" .. self.Owner:UniqueID(), self:SequenceDuration(), 1, function() 
        if (!IsValid(self)) then return end
        self:SendWeaponAnim(ACT_VM_IDLE)
    end)  
end
function SWEP:Teleport()
    self.IsHolding = false  
    if (CLIENT) then return end
    if (!self.ShouldTeleport) then 
        self.ShouldJump = false
        self.Owner:ChatPrint("Недостаточно пространства для телепорта")
        self:SendWeaponAnim(ACT_VM_IDLE)  
        return 
    end
    -- local FOV = 75
    -- self.Owner:SetFOV(FOV + 25, 0.25)
    -- timer.Simple(0.125, function() 
    --     if (!IsValid(self)) then return end
    --     self.Owner:SetFOV(FOV, 0.25) 
    -- end)
    self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
    self:Idle()
    self.Owner:EmitSound(Sound("weapons/blink_swep/teleport" .. math.random(1, 2) .. ".mp3", 256, 100))
    if (self.ShouldJump) then
        self.Owner:SetEyeAngles(self.TraceUp.HitNormal:Angle() + Angle(0, 180, 0))
        self.Owner:SetPos(self.TraceUp.HitPos)
        self.Owner:SetLocalVelocity(Vector(0, 0, 260)) 
        timer.Simple(0.3, function() 
            if (!self) then return end
            self.Owner:SetLocalVelocity(self.Owner:GetVelocity() + self.Owner:GetForward() * 150)
            self.ShouldJump = false
        end)
        return
    end
    self.Owner:SetLocalVelocity(Vector(0, 0, 0))
    local TraceDist = self.TraceUp.HitPos:Distance(self.TraceDown.HitPos)
    local Offset = TraceDist < 72 and 0 or -36 //  If there isn't enough space between the two ... circle-things, set us above the top circle.
    self.Owner:SetPos(self.TraceUp.HitPos + Vector(0, 0, (self.ShouldSpawnUnder and -72 or Offset)))
    self.Owner:SetNW2Int("NextUBCDown", CurTime() + 2.5)
end
function SWEP:CreateIndicator()	
    if ((SERVER and !game.SinglePlayer()) or CurTime() < self.IndicatorDelay) then return end
    local Effect = EffectData()    
    Effect:SetNormal(Vector(0, 0, 1))
    
    if (self.ShouldJump and self.TraceUp.HitWorld) then
        Effect:SetNormal(self.TraceUp.HitNormal)
        Effect:SetOrigin(self.TraceUp.HitPos - self.TraceUp.HitNormal)
        util.Effect("selection_indicator", Effect)           
    else
        if (self.ShouldTeleport or math.abs((self.TraceDown.HitPos - self.TraceUp.HitPos):Length()) <= 5) then
            Effect:SetOrigin(self.TraceDown.HitPos)
            util.Effect("selection_indicator", Effect)      
        end
        Effect:SetOrigin(self.TraceUp.HitPos)
        util.Effect("selection_indicator", Effect)
    end
    self.IndicatorDelay = CurTime() + 0.05125
end
function SWEP:Trace()
    local TraceData = {}
    TraceData.filter = self.Owner   
    TraceData.mins = Vector(-20, -20, 0.5)
    TraceData.maxs = Vector(20, 20, 0.5)
    
    local BlinkLength = GetConVarNumber("blinkswep_length")
    TraceData.start = self.Owner:GetShootPos()
    TraceData.endpos = TraceData.start + self.Owner:GetAimVector() * Vector(800, 800, 800 - 50)
    self.TraceUp = util.TraceHull(TraceData)
    
    TraceData.start = self.TraceUp.HitPos
    TraceData.endpos = self.TraceUp.HitPos - Vector(0, 0, 9e32)
    self.TraceDown = util.TraceHull(TraceData)    
    
    if (self.TraceUp.Hit and self.TraceUp.HitNormal.z == 0) then
        TraceData.endpos = TraceData.start + Vector(0, 0, 50)
        local PreTraceJump = util.TraceHull(TraceData)
        if (!PreTraceJump.Hit) then
            TraceData.start = PreTraceJump.HitPos
            TraceData.endpos = TraceData.start - self.TraceUp.HitNormal
            self.TraceJump = util.TraceHull(TraceData)
            self.ShouldJump = !self.TraceJump.Hit
         end
    else
        self.ShouldJump = false
    end
    TraceData.start = self.TraceDown.HitPos
    TraceData.endpos = TraceData.start + Vector(0, 0, 72)
    self.ShouldTeleport = !util.TraceHull(TraceData).Hit 
    TraceData.start = self.TraceUp.HitPos
    TraceData.endpos = TraceData.start + Vector(0, 0, 36)
    if (util.TraceHull(TraceData).Hit) then self.ShouldSpawnUnder = true
    else self.ShouldSpawnUnder = false
    end
end
function SWEP:Think()
    if (self.Owner:KeyDown(IN_ATTACK) and self.IsHolding) then
        self:Trace()
        self:CreateIndicator()
    elseif (self.IsHolding) then
        self:Teleport()
    end
end
function SWEP:PrimaryAttack()
    if self.Owner:GetNW2Int("NextUBCDown") > CurTime() then return end
    if (self.IsHolding or timer.Exists("blink_reset" .. self.Owner:UniqueID())) then return end
    timer.Create("blink_reset" .. self.Owner:UniqueID(), 0.5, 1, function()
        if (self.Owner:KeyDown(IN_ATTACK)) then 
            self.IsHolding = true 
            self:SendWeaponAnim(ACT_VM_RELOAD)
            return
        end 
        self:Idle()
    end) 
    if (CLIENT) then return true end
    self.Owner:EmitSound(Sound("weapons/blink_swep/aim" .. math.random(1, 2) .. ".mp3"), 256, 100)
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)   
    return true
end
function SWEP:SecondaryAttack()
    return false
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
