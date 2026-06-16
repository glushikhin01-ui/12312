--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward.RegisterReward("darkrp_money", function(ply, amount)
    if !isfunction(ply.addMoney) then return end
    ply:addMoney(amount)
end, Material("sreward/money.png", "smooth"))

sReward.RegisterReward("donate_kyl", function(ply, amount)
    if !isfunction(ply.addMoney) then return end
    KylDonate.AddDonateCoins(ply:SteamID(), amount)
end, Material("sreward/money.png", "smooth"))

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
