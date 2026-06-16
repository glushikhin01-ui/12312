--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward.RegisterReward("glorified_level", function(ply, levels)
    if !isfunction(GlorifiedLeveling.AddPlayerLevels) then return end
    GlorifiedLeveling.AddPlayerLevels(ply, levels)
end, Material("sreward/level-up.png", "smooth"))

sReward.RegisterReward("glorified_xp", function(ply, xp)
    if !isfunction(GlorifiedLeveling.AddPlayerXP) then return end
    GlorifiedLeveling.AddPlayerXP(ply, xp)
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
