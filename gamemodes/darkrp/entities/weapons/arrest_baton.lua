--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

local BaseClass = baseclass.Get('baton_base')

if CLIENT then
	SWEP.PrintName = 'Арестовать'
	SWEP.Instructions = 'Left click to arrest\nRight click to switch to unarrest'
end
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.Spawnable = true
SWEP.Category = "RP"

SWEP.Color = Color(255, 0, 0, 255)

function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) then return end

	BaseClass.PrimaryAttack(self)

	if CLIENT then return end

	local ent = self:GetTrace().Entity

	if ent.WantReason and self.Owner:IsCP() then
		local owner = ent.ItemOwner

		if (IsValid(owner)) then
			if (not owner:IsWanted()) and (not owner:IsArrested()) then
				owner:Wanted(self.Owner, ent.WantReason)
			end
		end

		hook.Call('PlayerArrestedEntity', nil, self.Owner, ent, owner)

		ent:Remove()
		self.Owner:AddMoney(ent.SeizeReward, 'Арестовал чувака ' .. ent:SteamID64())
		self.Owner:LVLAddExp( enc.lvls["ent_arrest"] )
		rp.Notify(self.Owner, NOTIFY_SUCCESS, term.Get('ArrestBatonBonus'), rp.FormatMoney(ent.SeizeReward))
		return
	end

	if (not ent:IsPlayer()) then return end
	if (not ent:GetNWBool('isHandcuffed')) then
		return rp.Notify(self.Owner, NOTIFY_ERROR, 'Игрок должен быть в наручниках, чтобы арестовать его.')
	end

	if ent:InVehicle() then ent:ExitVehicle() end
	if ent:InSpawn() then return rp.Notify(self.Owner, NOTIFY_ERROR, 'На спавне запрещено арестовывать людей.') end
	if ent:IsCP() or ent:IsMayor() then return rp.Notify(self.Owner, NOTIFY_ERROR, 'Вы не можете арестовывать других копов.') end
	if ent:IsAdmjob() then return rp.Notify(self.Owner, NOTIFY_ERROR, 'Администратора запрещено арестовывать.') end

	eui.battlepass.AddProgress(self.Owner, 12)
	eui.battlepass.AddProgress(self.Owner, 35)
	ent:Arrest(self.Owner)

	rp.Notify(ent, NOTIFY_ERROR, term.Get('ArrestBatonArrested'), self.Owner)
	--rp.Notify(self.Owner, NOTIFY_SUCCESS, term.Get('ArrestBatonYouArrested'), ent)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
