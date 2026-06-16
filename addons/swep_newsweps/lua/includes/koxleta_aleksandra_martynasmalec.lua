--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

local ColorTable = {{Color(241,116,30),Color(255,255,51),Color(251,126,20)},{Color(15,15,255),Color(70,15,235),Color(30,15,255)},
{Color(0,255,250), Color(50,250,170), Color(50,191,255)}, {Color(238,0,255), Color(255,0,170), Color(220,0,255)}}

koxlette = {}

function koxlette.GetKoxletaBasedOnNumber(number)
	if number > #ColorTable || number < 1 then
		return ColorTable[1]
	end
	
	return ColorTable[number || 1]
end

function koxlette.GetEntireKoxleta()
	return ColorTable
end

function koxlette.AddColor(color, add)
	local col = Color(1,1,1,255)
	col.r = color.r + add
	col.g = color.g + add
	col.b = color.b + add
	col.a = color.a

	return col
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
