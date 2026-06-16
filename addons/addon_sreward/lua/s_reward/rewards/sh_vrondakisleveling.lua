--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward.RegisterReward("vrondakis_level", function(ply, levels)
    if !isfunction(ply.addLevels) then return end
    ply:addLevels(levels)
end, Material("sreward/level-up.png", "smooth"))

sReward.RegisterReward("vrondakis_xp", function(ply, xp)
    if !isfunction(ply.addXP) then return end
    ply:addXP(xp)
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
