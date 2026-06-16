SWEP.Base = "tfa_codww2k_base"
SWEP.Category = "TFA COD WW2 Kabyi"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Purpose = "Single use Self-Heal"
SWEP.Type_Displayed = "Health Kit"
SWEP.Author = "Olli, Fox, Mav"
SWEP.Slot = 5
SWEP.PrintName = "Health Kit"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_codww2/usa_health/c_usa_health.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_codww2/usa_health/w_usa_health.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

-- We actually want VManip to break on this one lol 
SWEP.VElements = false

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 4.5,
        Forward = 5,
        },
        Ang = {
		Up = 35,
        Right = 20,
        Forward = 90
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "nil"
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 60
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.FiresUnderwater = false

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = .001

--[Bash]--
SWEP.Secondary.CanBash = false
SWEP.Secondary.BashDamage = 35
SWEP.Secondary.BashSound = Sound("TFA_CODWW2_MELEE.SwingSml")
SWEP.Secondary.BashHitSound = Sound("TFA_CODWW2_MELEE.Hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_CODWW2_MELEE.HitPlr")
SWEP.Secondary.BashLength = 60
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
SWEP.Primary.PickupSound = "TFA_CODWW2_PICKUP.Healthkit"
SWEP.InspectPos = Vector(5, -3, 0)
SWEP.InspectAng = Vector(15, 20, 5)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, 0)
SWEP.SafetyAng = Vector(0, 0, 0)
SWEP.TracerCount = 0
SWEP.Primary.MaxAmmo = 1

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 2
SWEP.DInv2_Volume = nil
SWEP.DInv2_Mass = 1

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.SequenceLengthOverride = {
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
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_HEALTHKIT.Use") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_HEALTHKIT.Bandage") },
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

--[Heal]-- credit to yurie for csgo medishot
DEFINE_BASECLASS( SWEP.Base )
local sp = game.SinglePlayer()

function SWEP:SwitchToPreviousWeapon()
	local wep = LocalPlayer():GetPreviousWeapon()

	if IsValid(wep) and wep:IsWeapon() and wep:GetOwner() == LocalPlayer() then
		input.SelectWeapon(wep)
	else
		wep = LocalPlayer():GetWeapon(cl_defaultweapon:GetString())

		if IsValid(wep) then
			input.SelectWeapon(wep)
		else
			local _
			_, wep = next(LocalPlayer():GetWeapons())

			if IsValid(wep) then
				input.SelectWeapon(wep)
			end
		end
	end
end

function SWEP:Think2(...)
	local stat = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()

	if stat == TFA.Enum.STATUS_DRAW and statusend then
		self:GetOwner():SetHealth(math.min(self:GetOwner():GetMaxHealth(), self:GetOwner():Health() + self:GetStat("Primary.Damage")))
		self:TakePrimaryAmmo(1, true)
		if self:Ammo1() <= 0 then
			timer.Simple(0, function()
				if CLIENT or not IsValid(self) or not self:OwnerIsValid() then return end
				self:GetOwner():StripWeapon(self:GetClass())
			end)
		else
			if CLIENT and not sp then
				self:SwitchToPreviousWeapon()
			elseif SERVER then
				self:CallOnClient("SwitchToPreviousWeapon", "")
			end
		end
	end
	
	return BaseClass.Think2(self, ...)
end
