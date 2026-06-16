SWEP.Base = "tfa_codww2k_nade_base"
SWEP.Category = "TFA COD WW2 Kabyi"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Purpose = "Creates the original fire effect from TFA CoD Ww2 Specials"
SWEP.Type_Displayed = "Impact Explosive"
SWEP.Description = "Velocity: 850 HU/s"
SWEP.Author = "Olli, Fox, Mav"
SWEP.Slot = 5
SWEP.PrintName = "Molotov"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_codww2/molotov/c_molotov.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_codww2/molotov/w_molotov.mdl"
SWEP.HoldType = "grenade"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 1,
        Right = 2.5,
        Forward = 3,
        },
        Ang = {
		Up = 0,
        Right = 195,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "nil"
SWEP.Primary.Ammo = "grenade"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 15
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 1
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.FiresUnderwater = false
SWEP.ThrowSpin = true
SWEP.Delay = 0.15

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false

--[Projectiles]--
SWEP.Primary.Round = ("codww2k_molotov")
SWEP.Primary.ProjectileModel = "models/weapons/tfa_codww2/molotov/molotov_proj.mdl"
SWEP.Velocity = 850
SWEP.Underhanded = false
SWEP.AllowSprintAttack = false
SWEP.AllowUnderhanded = false
SWEP.DisableIdleAnimations = false

--[Spread Related]--
SWEP.Primary.Spread		  = .001

--[Bash]--
SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 35
SWEP.Secondary.BashSound = Sound("TFA_CODWW2_MELEE.SwingSml")
SWEP.Secondary.BashHitSound = Sound("TFA_CODWW2_MELEE.Hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_CODWW2_MELEE.HitPlr")
SWEP.Secondary.BashLength = 30
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashDamageType = DMG_CLUB
SWEP.Secondary.BashInterrupt = true

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.FireModeSound = "TFA_CODWW2_GEN.Switch"
SWEP.Primary.PickupSound = "TFA_CODWW2_MOLOTOV.Raise"
SWEP.InspectPos = Vector(5, -3, 0)
SWEP.InspectAng = Vector(15, 20, 5)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, 0)
SWEP.SafetyAng = Vector(0, 0, 0)
SWEP.TracerCount = 0
SWEP.Primary.MaxAmmo = 3

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 2
SWEP.DInv2_Volume = nil
SWEP.DInv2_Mass = 2

--[Tables]--
SWEP.SequenceRateOverride = {
	["sprint_loop"] = 25 / 30,
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_in", --Number for act, String/Number for sequence
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
	}
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_MOLOTOV.Raise") },
{time = 0, type = "lua", value = function(wep, vm) wep:StopSounds() wep:SetGlow(true) end},
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_MOLOTOV.Holster") },
},
[ACT_VM_PULLPIN] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_MOLOTOV.Pullback") },
},
[ACT_VM_THROW] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_MOLOTOV.Throw") },
},
-- [ACT_VM_IDLE] = {
-- { ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_MOLOTOV.Hold") },

--},
["sprint_loop"] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_MOLOTOV.Holster") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

SWEP.WorldModelBoneMods = {
}

--[Fire EFX]-- credit to TFA & Yurie
DEFINE_BASECLASS( SWEP.Base )

function SWEP:ChooseDrawAnim()
	-- Add this function just for checking the idle loop
	if SERVER then
		self:EmitSound( "TFA_CODWW2_MOLOTOV.CSGO_IDLE_LOOP" )
	end
	return BaseClass.ChooseDrawAnim(self)
end 

function SWEP:Deploy(...)
	BaseClass.Deploy(self,...)
	if not self:VMIV() then return true end
	self:CleanParticles()
	timer.Simple(0, function()
		if IsValid(self) and self:VMIV() then
			ParticleEffectAttach("ww2_molotov_rag", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
		end
	end)
	return true
end

local drawdlight = GetConVar("cl_tfa_codww2k_dlights")

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)
	self:NetworkVarTFA("Bool", "Glow")
end

function SWEP:Think2(...)
	if DynamicLight then
		if self:GetGlow() and drawdlight:GetBool() then
			self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)

			if self.DLight then
				local attpos = (self:IsFirstPerson() and self:GetOwner():GetViewModel() or self):GetAttachment(2)

				self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
				self.DLight.r = 235
				self.DLight.g = 75
				self.DLight.b = 15
				self.DLight.decay = 1000
				self.DLight.brightness = 1
				self.DLight.size = 128
				self.DLight.dietime = CurTime() + 0.5
			end
		elseif self.DLight then
			self.DLight.dietime = -1
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:StopSounds(vm)
	self:SetGlow(false)

	if self.DLight then
		self.DLight.dietime = -1
	end
end

function SWEP:OnDrop(...)
	local retval = BaseClass.OnDrop(self, ...)
	if SERVER then
		self:StopSound( "TFA_CODWW2_MOLOTOV.CSGO_IDLE_LOOP" )
	end 
	self:StopSounds(self.OwnerViewModel)
	return retval
end

function SWEP:OwnerChanged(...)
	self:StopSounds(self.OwnerViewModel)
	return BaseClass.OwnerChanged(self, ...)
end

--[Make grenade physics object spin at a better angle]--
function SWEP:PostSpawnProjectile(ent)
	if self.ThrowSpin then
		local angvel = Vector(math.random(-1000,-250),math.random(-250,-1000),math.random(-250,-1000)) //The positive z coordinate emulates the spin from a right-handed overhand throw
		angvel:Rotate(-1*ent:EyeAngles())
		angvel:Rotate(Angle(0,self.Owner:EyeAngles().y,0))

		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:AddAngleVelocity(angvel)
		end
	end
end

function SWEP:Holster(...)
	local retval = BaseClass.Holster(self, ...)

	if retval then
		if SERVER then
			self:StopSound( "TFA_CODWW2_MOLOTOV.CSGO_IDLE_LOOP" )
		end 
		self:StopSounds()
	end

	return retval
end