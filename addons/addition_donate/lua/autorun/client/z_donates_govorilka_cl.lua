--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local Tag = "KylDonate:Govorilka"

local char_to_hex = function(c) return string.format("%%%02X", string.byte(c)) end
local function urlencode(url)
    return url:gsub("\n", "\r\n")
        :gsub("([^%w ])", char_to_hex)
        :gsub(" ", "+")
end

net.Receive(Tag, function()
    p = net.ReadPlayer()
    v = net.ReadVector()
    str = urlencode(net.ReadString())
    if LocalPlayer():GetPos():Distance(p:GetPos()) > 1000 then return end
    sound.PlayURL ( string.format("https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&&tl=ru&q=%s", str), "3d", function( ss )
        if ( IsValid( ss ) ) then
            ss:SetPos( v )
            ss:SetVolume(0.7)
            ss:Set3DFadeDistance(200, 1000)
            ss:Play()
        end
    end)
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
