--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

local IsValid = IsValid
local CurTime = CurTime
local CLIENT = CLIENT
local SERVER = SERVER
local hook = hook
local game = game
local engine = engine
local file = file
local math = math
local ents = ents
local cleanup = cleanup
local timer = timer
local resource = resource
local hook_Add = hook.Add
local game_AddAmmoType = game.AddAmmoType
local engine_ActiveGamemode = engine.ActiveGamemode
local file_Read = file.Read
local math_random = math.random
local ents_Create = ents.Create
local cleanup_Add = cleanup.Add
local timer_Simple = timer.Simple
local resource_AddWorkshop = resource.AddWorkshop
local language_Add

if CLIENT then
	language_Add = language.Add
end

hook_Add("Initialize", "Init_Robert", function()
	game_AddAmmoType({
		name = "hamster_robert",
		dmgtype = DMG_BLAST
	})

	if CLIENT then
		language_Add("hamster_robert_ammo", "Robert")
		language_Add("ent_hamster", "Robert")
	end
end)

local pitch, fol = 165, "vo/npc/male01/"

local sound_ = {"readywhenyouare01", "readywhenyouare02", "question06", "question14", "vanswer", "littlecorner01", "question26", "okimready01", "okimready02", "okimready03", "uhoh", "letsgo01", "letsgo02", "incoming02"}

local sound___ = {"gotone01", "vanswer14", "vanswer04", "yougotit02"}

local sound____ = {fol .. "finally", fol .. "yeah02", fol .. "hi01", fol .. "hi02", "vo/npc/barney/ba_laugh04"}

SWEP.PrintName = "Robert"
SWEP.Author = "Rem & always has bean"
SWEP.Purpose = "Use Robert for good purposes."
SWEP.Instructions = "Robert will be in your dreams until you caress him :3"
SWEP.Spawnable = false
SWEP.AdminOnly = true
SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models/weapons/c_homyak.mdl"
SWEP.WorldModel = "models/homyak/homyak.mdl"
SWEP.Slot = 1
SWEP.DrawCrosshair = true
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 2
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "hamster_robert"
SWEP.Primary.Recoil = 1
SWEP.Primary.Delay = 1.3
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.UseHands = true

if engine_ActiveGamemode() == "terrortown" then
	SWEP.Base = "weapon_tttbase"
	SWEP.Primary.ClipSize = 5

	SWEP.EquipMenuData = {
		type = "item_weapon",
		desc = "Robert will be in your dreams until you caress him :3"
	}

	SWEP.Icon = "entities/weapon_hamster.png"
	SWEP.Kind = WEAPON_EQUIP1

	SWEP.CanBuy = {ROLE_TRAITOR}

	SWEP.AutoSpawnable = false
	SWEP.InLoadoutFor = nil
	SWEP.AllowDrop = true
	SWEP.IsSilent = false
	SWEP.NoSights = false
end

function SWEP:Initialize()
	local check = CheckTypeWeapon()

	if check ~= 1 then
		self.Primary.ClipSize = 1
		self.Primary.DefaultClip = 1
		self.Primary.Automatic = false
		self.Primary.Ammo = "none"
	end

	self.delay = CurTime()
	self.SoundCooldown = CurTime() + 8
	self:SetHoldType("grenade")
end

function SWEP:Think()
	local owner = self:GetOwner()

	if SERVER and self:Clip1() < 1 and owner:GetAmmoCount(self:GetPrimaryAmmoType()) < 1 and IsValid(owner:GetActiveWeapon()) and owner:GetActiveWeapon():GetClass() == "weapon_hamster" then
		owner:StripWeapon("weapon_hamster")
	end

	if CheckRobertSound() and CurTime() > self.SoundCooldown then
		self.SoundCooldown = self.SoundCooldown + 8

		if CLIENT and IsValid(self:GetOwner():GetActiveWeapon()) and owner:GetActiveWeapon():GetClass() == "weapon_hamster" then
			self:EmitSound(fol .. sound_[math_random(1, #sound_)] .. ".wav", 80, pitch)
		end
	end
end

function SWEP:Deploy()
	local owner = self:GetOwner()
	if self:Clip1() < 1 and owner:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 then
		self:DefaultReload(172)
	end

	self.SoundCooldown = CurTime() + 8
	self:SendWeaponAnim(172)

	if CheckRobertSound() then
		owner:EmitSound(sound____[math_random(1, #sound____)] .. ".wav", 80, pitch)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Equip()
	self:SendWeaponAnim(172)
	self:GetOwner():SetAnimation(0)
end

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:PrimaryAttack()
	local check = CheckTypeWeapon()

	if check ~= 2 then
		if self:Clip1() < 1 and check ~= 3 then return end
		self:SendWeaponAnim(172)
		local owner = self:GetOwner()
		owner:SetAnimation(0)

		if SERVER then
			local random = math_random(1, 10)

			if check ~= 3 then
				self:TakePrimaryAmmo(1)
			end

			self:SendWeaponAnim(ACT_VM_THROW)
			owner:SetAnimation(PLAYER_ATTACK1)
			local ent = ents_Create("ent_hamster")
			if not IsValid(ent) then return end
			ent:SetPos(owner:EyePos() + (owner:GetAimVector() * 25))
			ent:SetAngles(owner:EyeAngles())

			if CheckRobert() then
				ent:VariantR(1)
			end

			ent:Spawn()
			local phys = ent:GetPhysicsObject()

			if not IsValid(phys) then
				ent:Remove()

				return
			end

			local velocity = owner:GetAimVector()
			velocity = velocity * phys:GetMass() * 2000
			velocity = velocity + (VectorRand() * 10)
			phys:ApplyForceCenter(velocity)
			cleanup_Add(owner, "hamster", ent)

			timer_Simple(0.5, function()
				if IsValid(self) and IsValid(owner:GetActiveWeapon()) and owner:GetActiveWeapon():GetClass() == "weapon_hamster" then
					self:DefaultReload(172)

					if check == 3 then
						self:SendWeaponAnim(172)
					end

					if CheckRobertSound() and random > 5 then
						owner:EmitSound(fol .. sound___[math_random(1, #sound___)] .. ".wav", 80, pitch)
					end
				end
			end)

			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		end
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
