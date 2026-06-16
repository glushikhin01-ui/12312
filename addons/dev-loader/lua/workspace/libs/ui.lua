--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then
    resource.AddFile('resource/fonts/montserrat_sb.ttf')
    return false
end
resource.AddFile('resource/fonts/montserrat_sb.ttf')
ui = ui or {}

function ui.CreateFont(display, name, size, w)
    local font_name = 'ui.'..display..'.'..size

    surface.CreateFont(font_name, {
        font = name,
        weight = w,
        size = size,
        extended = true,
    })
    dev.print('Loaded '.. font_name, ' ui.lib ~ ')
    return font_name
end

function ui.makeZero(num)
    return num < 10 and '0'.. num or num
end

local def = 'Montserrat SemiBold'

local fonts = {
    {'def', def, 12, 600},
    {'def', def, 14, 600},
    {'def', def, 15, 600},
    {'def', def, 16, 600},
    {'def', def, 18, 600},
    {'def', def, 20, 600},
    {'def', def, 24, 600},
    {'def', def, 28, 600},
    {'def', def, 32, 600},
    {'notdef', def, 20, 1000},
}

for i,v in ipairs(fonts) do
    ui.CreateFont(unpack(v))
end

local scrW, scrH = ScrW() / 1920, ScrH() / 1080

function w(px) return math.Round(px * scrW) end
function h(px) return math.Round(px * scrH) end

hook.Add('OnScreenSizeChanged', 'sizescreen', function() scrW, scrH = ScrW() / 1920, ScrH() / 1080 end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
