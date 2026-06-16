--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

local allowedteams = {
	[TEAM_SUD] = true,
	[TEAM_LEYPOLICE] = true,
	[TEAM_FSB] = true
}

function SWEP:SecretPrimaryAttack()
	self.Owner:SetAnimation(ACT_VM_PRIMARYATTACK)

	self:SetNextPrimaryFire(CurTime() + 1)

	local tr = self.Owner:GetEyeTraceNoCursor()

	if (not tr.Entity:IsPlayer()) then return end
	if tr.Entity:InVehicle() then tr.Entity:ExitVehicle() end
	if tr.Entity:InSpawn() then return rp.Notify(self.Owner, NOTIFY_ERROR, 'На спавне запрещено использовать наручники.') end
	if tr.Entity:IsCP() and not allowedteams[self.Owner:Team()] then return rp.Notify(self:GetOwner(), NOTIFY_ERROR, 'Вы не можете надевать наручники на других копов.') end
	if tr.Entity:Team() == TEAM_ADMIN then return rp.Notify(self.Owner, NOTIFY_ERROR, 'На администратора нельзя надеть наручники.') end
	if tr.Entity:Team() == TEAM_MAYOR then return rp.Notify(self.Owner, NOTIFY_ERROR, 'На мэра нельзя надеть наручники.') end

	if (self:GetOwner():EyePos():Distance(tr.Entity:GetPos()) < 150) and (tr.Entity:GetNWBool('isHandcuffed') == false) then

		tr.Entity:SetNWBool('isHandcuffed', true)

		tr.Entity:SetWalkSpeed(rp.cfg.WalkSpeed/2.5)
		tr.Entity:SetRunSpeed(rp.cfg.RunSpeed/2.5)

		tr.Entity.HandcuffedWeapons = {}
		tr.Entity.HandcuffedWeaponAmmo = {}
		tr.Entity.HandcuffedWeaponAmmoType = {}

		local weps = tr.Entity:GetWeapons()

		for i, v in ipairs(weps) do
			tr.Entity.HandcuffedWeapons[i] = {v:GetClass(),v.donate}
			tr.Entity.HandcuffedWeaponAmmo[v:GetPrimaryAmmoType()] = tr.Entity:GetAmmoCount( v:GetPrimaryAmmoType() )
		end

		tr.Entity:StripWeapons()
	end
end

function SWEP:SecretSecondaryAttack()
	local tr = self.Owner:GetEyeTraceNoCursor()

	if (not tr.Entity:IsPlayer()) then return end
	if tr.Entity:InVehicle() then tr.Entity:ExitVehicle() end

	if (self:GetOwner():EyePos():Distance(tr.Entity:GetPos()) < 150) and (tr.Entity:GetNWBool('isHandcuffed') == true) then

		tr.Entity:SetNWBool('isHandcuffed', false)

		self:GiveHandcuffWeaponsBack(tr.Entity)
		self:GiveHandcuffWeaponAmmoBack(tr.Entity)

		tr.Entity:SwitchToDefaultWeapon()

		tr.Entity:SetWalkSpeed(rp.cfg.WalkSpeed)
		tr.Entity:SetRunSpeed(rp.cfg.RunSpeed)
		end
end

function SWEP:GiveHandcuffWeaponsBack(pl)
	for i, v in ipairs(pl.HandcuffedWeapons) do
		if v[2] == true then pl:Give(v[1], true).donate=true else pl:Give(v[1], true) end
	end
end

function SWEP:GiveHandcuffWeaponAmmoBack(pl)
	for k, v in pairs(pl.HandcuffedWeaponAmmo) do
		pl:SetAmmo(v, k)
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
