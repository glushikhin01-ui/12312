--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

hook.Add("CreateEntityRagdoll", "AmaterasuRagdollBurn", function(owner, ragdoll)
    if owner.IsOnAmaterasu then
        MS_StopAmaterasu(owner)
        timer.Remove("Amaterasu " .. tostring(owner:EntIndex()))
        timer.Simple(0.1, function()
            if IsValid(ragdoll) then
                ragdoll:Ignite(GetConVar("itachi_amaterasu_length"):GetFloat())
                MS_StartAmaterasu(ragdoll)
            end
        end)
    end
end)

hook.Add("EntityRemoved", "RemoveAmaterasuTimer", function(entity)
    if timer.Exists("Amaterasu " .. tostring(entity:EntIndex())) then
        timer.Remove("Amaterasu " .. tostring(entity:EntIndex()))
    end
end)

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
