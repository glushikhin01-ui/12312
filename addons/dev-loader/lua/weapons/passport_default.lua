--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- Maked from NS Team for JustRP <3
AddCSLuaFile()

SWEP.PrintName = "Паспорт"
SWEP.Author = "JustRP"
SWEP.Category = "Passports"

SWEP.Slot = 4
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model( "" )
SWEP.WorldModel = ""
SWEP.UseHands = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.DrawAmmo = false

function SWEP:Initialize()

	self:SetHoldType( "normal" )

end

function SWEP:SecondaryAttack()
    if not IsFirstTimePredicted() then return end

    if dev.justrp_documents and dev.justrp_documents.secondary then
		dev.justrp_documents.secondary(self)
	end
end

if CLIENT then
	surface.SetFont('ui.def.20')
	local x, y = surface.GetTextSize('RIGHT MOUSE - Показать документ')
	function SWEP:DrawHUD()
		draw.SimpleText('LEFT MOUSE - Посмореть документ', 'ui.def.20', ScrW() / 2 - x / 2, ScrH() - 40 - y)
		draw.SimpleText('RIGHT MOUSE - Показать документ', 'ui.def.20', ScrW() / 2 - x / 2, ScrH() - 40)
	end
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

    if dev.justrp_documents and dev.justrp_documents.primary then
		dev.justrp_documents.primary(self)
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
