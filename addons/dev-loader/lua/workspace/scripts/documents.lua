--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

dev.justrp_documents = dev.justrp_documents or {}

function dev.justrp_documents.secondary(self)
    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    local trace = owner:GetEyeTrace()
    local target = trace.Entity

    if IsValid(target) and target:IsPlayer() then
		local distance = trace.HitPos:Distance(owner:GetPos())
		if distance < 200 then
        	if SERVER then
				dev.documents_cooldown[owner:SteamID()] = dev.documents_cooldown[owner:SteamID()] or 0
				if os.time() - dev.documents_cooldown[owner:SteamID()] <= 30 then return false end
				dev.documents_cooldown[owner:SteamID()] = os.time()
				net.Start('justrp_documents_request')
				net.WriteString(self:GetClass())
				net.WritePlayer(owner)
				net.Send(target)

				eui.battlepass.AddProgress(owner, 18)
			else
				if os.time() - dev.documents_cooldown <= 30 then notification.AddLegacy("Кулдаун: " .. math.Round(30 - (os.time() - dev.documents_cooldown)) .. 's', NOTIFY_GENERIC, 5) return false end
				dev.documents_cooldown = os.time()
				notification.AddLegacy("Вы смотрите на игрока: " .. target:Nick(), NOTIFY_GENERIC, 5)
        	end
			return true
		end
    end

	if SERVER then return false end
	notification.AddLegacy('Упс.. что-то не получилось?', NOTIFY_GENERIC, 5)
end

function dev.justrp_documents.primary(self)
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
	
	if CLIENT then
		dev.justrp_passpport(self:GetClass(), LocalPlayer())
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
