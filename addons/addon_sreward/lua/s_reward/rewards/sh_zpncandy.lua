--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward.RegisterReward("zpn_candy", function(ply, amount)
    if !zpn or !zpn.Candy or !zpn.Candy.AddPoints then return end
    
    zpn.Candy.AddPoints(ply, amount)
end, Material("sreward/money.png", "smooth"))

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
