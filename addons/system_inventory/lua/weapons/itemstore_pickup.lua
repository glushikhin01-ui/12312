--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then
	AddCSLuaFile()
end

SWEP.PrintName = "Инвентарь"

SWEP.Purpose = ""
SWEP.Instructions = ""

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.WorldModel = ""
SWEP.UseHands = true
SWEP.Category = "RP"

SWEP.Primary.Clipsize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Slot               = 2
SWEP.SlotPos 			= 10
SWEP.DrawAmmo           = false
SWEP.DrawCrosshair      = true

function SWEP:Initialize()
	self:SetHoldType( "normal" )
end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:PrimaryAttack()
	if CLIENT then return end

	self.Owner:PickupItem()
end

function SWEP:SecondaryAttack()
	if CLIENT then 
		enc.inventory()
	end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
