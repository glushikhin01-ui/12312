--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

enc_inv = enc_inv or {}
enc_inv.stored = enc_inv.stored or {}

--

local ITEM = {}
ITEM.__index = ITEM

function enc_inv.addItem(class)
	enc_inv.stored[class] = setmetatable({
		Class = class,
		Data = {},
	}, ITEM)     

	return enc_inv.stored[class]
end

function enc_inv.getItem( tb )
	if !tb || !tb.Class then return {} end
	if !enc_inv.stored[tb.Class] then return {} end

	local class = enc_inv.stored[tb.Class]

	local data = {
		Class = tb.Class,
		Data = tb.Data or {}
	}

	setmetatable( data, {__index = class} )

	return data
end

enc_inv.Rarity = {
	['Ginger Bread'] = {
		color = Color(255,0,0),
		rarity = 'Редкое',
	},
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
