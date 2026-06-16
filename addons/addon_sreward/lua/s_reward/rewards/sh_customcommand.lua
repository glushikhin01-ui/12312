--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local replacements = {
    ["{sid64}"] = function(ply) return ply:SteamID64() end,
    ["{sid}"] = function(ply) return ply:SteamID() end,
    ["{name}"] = function(ply) return ply:Nick() end
}

sReward.RegisterReward("custom_command", function(ply, str)
    for k,v in pairs(replacements) do
        str = string.Replace(str, k, v(ply))
    end

    local packed = string.Explode(" ", str)

    RunConsoleCommand(unpack(packed))
end)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
