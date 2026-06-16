--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

--howdy! thanks for rooting around in my mod! 
--this file handles any edge cases and weird stuff, notably just brick blast's looping sound right now
-- -splet

AddCSLuaFile()

function WizDieClear( victim, inflictor, attacker )
	--stop brick blast looping sound
	victim:StopSound("LoopAtk")
end
hook.Add("PlayerDeath", "Wiz_DieClear",  WizDieClear )

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
