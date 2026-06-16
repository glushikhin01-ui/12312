--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward.config["indexToName"] = {} --- Ignore this! Used for optimization.

sReward.RegisterReward = function(name, func, ico)
    sReward.Rewards = sReward.Rewards or {}
    sReward.Rewards[name] = SERVER and func or ico or true
end

sReward.HasPermission = function(ply, perm)
    if !IsValid(ply) then return false end
    
    return (CAMI and isfunction(CAMI.PlayerHasAccess) and CAMI.PlayerHasAccess(ply, perm, function() end)) or (sReward.config["permissions"][perm] and sReward.config["permissions"][perm][ply:GetUserGroup()])
end

timer.Simple(3, function()
    if !CAMI then return end

    for k,v in pairs(sReward.config["permissions"]) do
        CAMI.RegisterPrivilege({Name = k, hasAccess = false, callback = function() end})
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
