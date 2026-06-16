--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local Tag = "KylDonate:Govorilka"
util.AddNetworkString(Tag)
	
hook.Add('PlayerSay', Tag, function(ply, s, tt)
    if ply.Govorilka then
        if not ply:IsChatMuted() and ply:Alive() then
            local str = s
            if string.sub(str, 1, 1) == "!" or string.sub(str, 1, 1) == "@" or string.sub(str, 1, 1) == "/" then return end

            net.Start(Tag)
                net.WritePlayer(ply)
                net.WriteVector(ply:GetPos())
                net.WriteString(str)
            net.Broadcast()
        end
    end
end)

hook.Add("LibFuse:PlayerFullyLoad", "KylDonate:Govorilka", function(ply)
    KylDonate.HasItem(ply, "govorilka", function(data)
        if data then
            ply.Govorilka = true
        end
    end)
end)

hook.Add("LibFuse:PlayerFullyLoad", "KylDonate:Objora", function(ply)
	KylDonate.HasItem(ply, 'objora', function(data)
        if data then
            ply.Objora = true
        end
    end)
end)

hook.Add("LibFuse:PlayerFullyLoad", "KylDonate:sumkammo", function(ply)
	KylDonate.HasItem(ply, 'sumkammo', function(data)
        if data then
            ply.SumkaPatron = true
        end
    end)
end)

hook.Add("PlayerSpawn", "KylDonate:sumkammo", function(ply)
	if ply.SumkaPatron then
        for k, v in pairs(game.GetAmmoTypes()) do
            ply:GiveAmmo(500,k)
        end
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
