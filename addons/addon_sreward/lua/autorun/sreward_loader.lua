--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if slib then slib.loadFolder("s_reward/", true, {{"s_reward/", "sh_sreward_config.lua"}, {"s_reward/", "sv_sreward_config.lua"}, {"s_reward/core/", "sv_storage.lua"}}) end
hook.Add("slib:loadedUtils", "sR:Init_SReward", function() slib.loadFolder("s_reward/", true, {{"s_reward/", "sh_sreward_config.lua"}, {"s_reward/", "sv_sreward_config.lua"}, {"s_reward/core/", "sv_storage.lua"}}) end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
