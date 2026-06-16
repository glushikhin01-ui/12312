SWEP.Base = "tfa_codww2k_flamebase"
SWEP.Category = "TFA COD WW2 Kabyi"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Purpose = "12 Meter range"
SWEP.Manufacturer = "US Army Chemical Warfare Service"
SWEP.Type_Displayed = "Flamethrower"
SWEP.Author = "Olli, Fox, Mav"
SWEP.Slot = 4
SWEP.PrintName = "M2 Flamethrower"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_codww2/flamethrower/c_flamethrower.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_codww2/flamethrower/w_flamethrower.mdl"
SWEP.HoldType = "smg"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, -1.75, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -6.5,
        Right = 1,
        Forward = 14,
        },
        Ang = {
		Up = -90,
        Right = 180,
        Forward = 12
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = Sound("TFA_CODWW2_M2FT.Start")
SWEP.Primary.LoopSound = Sound("TFA_CODWW2_M2FT.Loop")
SWEP.Primary.LoopSoundTail = Sound("TFA_CODWW2_M2FT.Stop")
SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.LMG"
SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.LMG"
SWEP.MuzzleFlashEffect = "tfa_codww2k_flamethrower_muzzle"
SWEP.Primary.Ammo = "AlyxGun"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 1000
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.RPM_Displayed = 700
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 150
SWEP.Primary.HullSize = 10
SWEP.Primary.DryFireDelay = 0.35
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.DefaultFireMode = ""
SWEP.FireModeName = nil

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = false
SWEP.LowAmmoSoundThreshold = 0.33 --0.33
SWEP.LowAmmoSound = nil
SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.Range = 600 --Flame Distance
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.25 --0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 --.09

SWEP.ViewModelPunch_MaxVertialOffset				= 3.0 --3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 2.0 --1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1.2 --1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 1.2 --0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 --0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 --0.25

SWEP.ChangeStateRecoilMultiplier = 1.3 --1.3
SWEP.CrouchRecoilMultiplier = 0.65 --0.65
SWEP.JumpRecoilMultiplier = 1.65 --1.3
SWEP.WallRecoilMultiplier = 1.1 --1.1

--[Spread Related]--
SWEP.Primary.Spread		  = .03
SWEP.Primary.IronAccuracy = .03
SWEP.IronRecoilMultiplier = 0.8
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 0.05
SWEP.Primary.KickDown 			= 0.05
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor = 0.2

SWEP.Primary.SpreadMultiplierMax = 5
SWEP.Primary.SpreadIncrement = 0.3
SWEP.Primary.SpreadRecovery = 4

--[Bash]--
SWEP.Secondary.BashDamage = 35
SWEP.Secondary.BashSound = Sound("TFA_CODWW2_MELEE.SwingLrg")
SWEP.Secondary.BashHitSound = Sound("TFA_CODWW2_MELEE.Hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_CODWW2_MELEE.HitPlr")
SWEP.Secondary.BashLength = 60
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashDamageType = DMG_CLUB
SWEP.Secondary.BashInterrupt = true

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.IronInSound = "TFA_CODWW2_GEN.AdsUp"
SWEP.IronOutSound = "TFA_CODWW2_GEN.AdsDown"
SWEP.Secondary.IronFOV = 75
SWEP.IronSightsPos = Vector(-2.86, -3, 1.5)
SWEP.IronSightsAng = Vector(1.5, 0, 0)
SWEP.IronSightTime = 0.45

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = "models/entities/tfa_codww2/shells/fx_762.mdl"
SWEP.LuaShellScale = 0
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Jamming]-- RPG
SWEP.CanJam = false
SWEP.JamChance = 0.00
SWEP.JamFactor = 0.00

--[Projectile]--
SWEP.Primary.Projectile         = "codww2k_flamethrower_fx" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 1500 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_codww2/fliegerfaust/fliegerfaust_proj.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {alyxgun = "Napalm"}
SWEP.FireModeSound = "TFA_CODWW2_GEN.Switch"
SWEP.InspectPos = Vector(10, -4, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.85
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -1, -0.5)
SWEP.SafetyAng = Vector(-15, 30, -20)
SWEP.ImpactDecal = "Dark"
SWEP.TracerCount = 0

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 3
SWEP.DInv2_Volume = nil
SWEP.DInv2_Mass = 11

--[NZombies]--
SWEP.NZPaPName = "Paint it Black"
SWEP.Primary.MaxAmmo = 150

function SWEP:NZMaxAmmo()

    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary.Damage = 250
self.Primary.ClipSize = -1
self.Primary.DefaultClip = 250
self.Primary.MaxAmmo = 250
self.MoveSpeed = 0.9
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
}

SWEP.SequenceLengthOverride = {
}

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
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_LNCHR.Raise") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_LNCHR.Holster") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

--[Attachments]--
SWEP.ViewModelBoneMods = {
}

SWEP.VElements = {
	["receiver_default"] = { type = "Model", model = "models/weapons/tfa_codww2/flamethrower/c_flamethrower_receiver.mdl", bone = "tag_weapon", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, active = true, bodygroup = {} },
	["barrel_default"] = { type = "Model", model = "models/weapons/tfa_codww2/flamethrower/c_flamethrower_barrel.mdl", bone = "tag_weapon", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, active = true, bodygroup = {} },
}
SWEP.WElements = {
	["backpack_default"] = { type = "Model", model = "models/weapons/tfa_codww2/flamethrower/w_flamethrower_backpack.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-7, -3.5, 0), angle = Angle(180, -105, 0), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = true, bodygroup = {} },
}
SWEP.Attachments = {
}

SWEP.AttachmentDependencies     = {}
SWEP.AttachmentExclusions       = {}
SWEP.AttachmentTableOverride    = {}
SWEP.AttachmentIconOverride     = {}

DEFINE_BASECLASS( SWEP.Base )

function SWEP:PreSpawnProjectile(ent)
	local owner = self:GetOwner()
	ent:SetPos(owner:GetShootPos() + owner:GetForward()*35)
end