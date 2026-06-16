--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

-- OTHER
local CLIENT = CLIENT
local SERVER = SERVER
local util = util
local net = net
local bit = bit
local file = file
local hook = hook
local ScrW = ScrW
local ScrH = ScrH
local ColorAlpha = ColorAlpha
local CreateConVar = CreateConVar
local IsValid = IsValid
local ipairs = ipairs
local draw_RoundedBox
local util_AddNetworkString = util.AddNetworkString
local net_Receive = net.Receive
local bit_bor = bit.bor
local file_Exists = file.Exists
local file_Write = file.Write
local chat_AddText
local vgui_Create
local hook_Add = hook.Add

-- OTHER
local ccc = bit_bor(8192, 128)
local cvar = CreateConVar("sv_robert_explosive_change", 0, ccc, nil, 0, 1)
local cvarw = CreateConVar("sv_robert_type", 1, ccc, nil, 1, 3)
local cvarww = CreateConVar("sv_robert_explosive_default", 1, ccc, nil, 1, 3)
local cvarwww = CreateConVar("sv_robert_sound", 1, ccc, nil, 0, 1)

function CheckRobert()
    return cvar and cvar:GetBool() or false
end

function CheckTypeWeapon()
    return cvarw and cvarw:GetInt() or 1
end

function CheckDefault()
    return cvarww and cvarww:GetInt() or 1
end

function CheckRobertSound()
    return cvarwww and cvarwww:GetBool() or false
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
