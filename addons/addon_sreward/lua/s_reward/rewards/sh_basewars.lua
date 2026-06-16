--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward.RegisterReward("basewars_money", function(ply, amount)
    if !isfunction(ply.GiveMoney) then return end
    ply:GiveMoney(amount)
end, Material("sreward/money.png", "smooth"))

sReward.RegisterReward("basewars_level", function(ply, level)
    if !isfunction(ply.AddLevel) then return end
    ply:AddLevel(level)
end, Material("sreward/level.png", "smooth"))

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
