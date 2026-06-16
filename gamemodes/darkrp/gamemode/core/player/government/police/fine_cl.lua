--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local draw_SimpleText = draw.SimpleText
local draw_RoundedBox = draw.RoundedBox
local colors = {
    ['main_bg'] = Color(26, 26, 26),
    ['red'] = Color(218, 71, 71),
    ['green'] = Color(72, 197, 72),
    ['white_05'] = Color(255, 255, 255, 2),
    ['white_1'] = Color(255, 255, 255, 10),
    ['white_2'] = Color(255, 255, 255, 20),
    ['white_120'] = Color(255, 255, 255, 120),
}

local selected_reasons
local cost
local function reasons(parent, tbl, id)
    local panel_reason = vgui.Create('DButton', parent)
    panel_reason:Dock(TOP)
    panel_reason:DockMargin(0, 0, 0, enc.h(5))
    panel_reason:SetTall(enc.h(60))
    panel_reason:SetText(tbl['Name'] .. ' (' .. tbl['Price'] .. 'p)')
    panel_reason:SetFont('MSB_20')
    panel_reason.Selected = false
    panel_reason.clr = colors['white_05']
    panel_reason.Paint = function(s, w, h)
        local tickInterval = engine.TickInterval()

        if s.Selected then
            s.clr = s.clr:Lerp(color_white, tickInterval)
        else
            s.clr = s.clr:Lerp(colors['white_05'], tickInterval)
        end
        draw_RoundedBox(10, 0, 0, w, h, s.clr)
    end
    panel_reason.DoClick = function()
        panel_reason.Selected = not panel_reason.Selected
        if panel_reason.Selected then
            selected_reasons[#selected_reasons + 1] = id
            cost = cost + tbl['Price']
        else
            table.RemoveByValue(selected_reasons, id)
            cost = cost - tbl['Price']
        end
    end
end


local fr
local function OpenFineBook(type, target)
    if type == false and LocalPlayer():Team() != TEAM_SWATS then LocalPlayer():ChatPrint('Вы не ДПС, чтобы выписывать штрафы на машины') return end
    if IsValid(fr) then fr:Remove() return end
    selected_reasons = {}
    cost = 0

    fr = vgui.Create('EditablePanel')
    fr:SetSize(enc.w(600), enc.h(800))
    fr:Center()
    fr:DockPadding(enc.w(24), enc.h(82), enc.w(24), enc.h(24))
    fr:MakePopup()
    fr.Paint = function(s, w, h)
        draw_RoundedBox(10, 0, 0, w, h, colors['main_bg'])
        draw_SimpleText('Штрафной Бланк', 'MSB_30', enc.w(24), enc.h(44), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_RoundedBox(10, enc.w(24), enc.h(88), w - enc.w(48), 1, colors['white_1'])
    end
    fr.Think = function()
        if input.IsKeyDown(KEY_ESCAPE) then
            fr:AlphaTo(0, 0.2, 0,function()
                fr:Remove()
            end)
            gui.HideGameUI()
        end
    end

    local closebutton = vgui.Create('DButton', fr)
    closebutton:SetSize(enc.w(60), enc.h(40))
    closebutton:SetPos(fr:GetWide() - closebutton:GetWide() - enc.w(24), enc.h(24))
    closebutton:SetText('')
    closebutton.Paint = function(s, w, h)
        draw_RoundedBox(8, 0, 0, w, h, color_white)
        draw_SimpleText('ESC', 'MSB_20', w * .5, h * .5, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    closebutton.DoClick = function(s, w, h)
        fr:Remove()
    end

    local scroll = vgui.Create('enc.scroll', fr)
    scroll:Dock(FILL)
    scroll:DockMargin(enc.w(0),enc.h(30),enc.w(0),enc.h(0))

    for i, v in ipairs(just_police.FiningPolice) do
        if v['Vehicle'] == type then continue end
        reasons(scroll, v, i)
    end

    local send_fine = vgui.Create('DButton', fr)
    send_fine:Dock(BOTTOM)
    send_fine:SetTall(enc.h(80))
    send_fine:SetText('')
    send_fine.clr = colors['white_05']
    send_fine.Paint = function(s, w, h)
        local tickInterval = engine.TickInterval()

        if s:IsHovered() then
            s.clr = s.clr:Lerp(colors['green'], tickInterval)
        else
            s.clr = s.clr:Lerp(colors['white_05'], tickInterval)
        end
        draw_RoundedBox(10, 0, 0, w, h, s.clr)
        draw_SimpleText('Выписать штраф: ' .. target:Name() .. ' (' .. cost .. 'p)', 'MSB_20', w * .5, h * .5, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    send_fine.DoClick = function()
        net.Start('just_police:DoFine')
            net.WriteEntity(target)
            net.WriteTable(selected_reasons)
        net.SendToServer()
        fr:Remove()
    end
end

net.Receive('just_police:GetFine', function(_, ply)
    local types = net.ReadBool()
    local ent = net.ReadEntity()
    OpenFineBook(types, ent)
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
