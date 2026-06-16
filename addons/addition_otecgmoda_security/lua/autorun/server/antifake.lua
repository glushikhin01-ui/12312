--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

/*
    Leystryku pososal   Leystryku pososal   Leystryku pososal   Leystryku pososal
    Leystryku pososal   Leystryku pososal   Leystryku pososal   Leystryku pososal
    Leystryku pososal   Leystryku pososal   Leystryku pososal   Leystryku pososal
    Leystryku pososal   Leystryku pososal   Leystryku pososal   Leystryku pososal
    Leystryku pososal   Leystryku pososal   Leystryku pososal   Leystryku pososal
    Leystryku pososal   Leystryku pososal   Leystryku pososal   Leystryku pososal
    Leystryku pososal   Leystryku pososal   Leystryku pososal   Leystryku pososal

*/

local loshpeds = {}
hook.Add("ClientSignOnStateChanged", "LibFuse:AntiPidor", function(u, o, n)
   
    if n < o and n ~= 0 then

        print(u, "Не совпал стейт, очередь нарушена проследи", o , "-->", n)

    end

    if n == 2 then
        loshpeds[u] = CurTime()
    elseif n == 3 then
        loshpeds[u] = nil
    end

end)

timer.Create("FindLey", 5, 0, function()
    for ply, time in pairs(loshpeds) do
        if CurTime() - time > 15 then
            loshpeds[ply] = nil
            game.KickID(ply, "Ошибка авторизации, перезайди!") 
            -- https://wiki.facepunch.com/gmod/game.KickID ( не работает почему то Player(ply):Kick RETURN NULL ENTITY)
        end
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
