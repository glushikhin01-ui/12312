surface.CreateFont("OrbitUI_Title", {font = "Roboto", size = 24, weight = 800, extended = true})
surface.CreateFont("OrbitUI_Btn", {font = "Roboto", size = 18, weight = 500, extended = true})
surface.CreateFont("OrbitUI_Warn", {font = "Roboto", size = 16, weight = 500, extended = true})

ORBIT_EFFECTS_LIST = ORBIT_EFFECTS_LIST or {}

function Orbit_Register(id, name, func)
    if not id or not name then return end
    ORBIT_EFFECTS_LIST[id] = {name = name, func = func}
end

hook.Add("PostPlayerDraw", "OrbitRenderCore", function(ply)
    if not IsValid(ply) or not ply:Alive() then return end
    if not IsValid(LocalPlayer()) then return end
    local fxID = ply:GetNWInt("OrbitFX", 0)
    if fxID == 0 then return end
    if LocalPlayer():GetPos():DistToSqr(ply:GetPos()) > 2000000 then return end
    if ORBIT_EFFECTS_LIST[fxID] and ORBIT_EFFECTS_LIST[fxID].func then
        ORBIT_EFFECTS_LIST[fxID].func(ply)
    end
end)

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
    if not blur then return end
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)
    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

concommand.Add("orbit_menu", function()
    if not IsValid(LocalPlayer()) then return end
    local frame = vgui.Create("DFrame")
    frame:SetSize(800, 500)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)

    frame.Paint = function(s, w, h)
        DrawBlur(s, 5)
        draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 240))
        draw.RoundedBox(0, 0, 0, 250, h, Color(35, 35, 35, 200)) 
        draw.RoundedBox(0, 0, 0, w, 50, Color(0, 0, 0, 150))
        draw.SimpleText("ДОСТУПНЫЕ ЭФФЕКТЫ", "OrbitUI_Title", 15, 25, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local btnClose = vgui.Create("DButton", frame)
    btnClose:SetPos(750, 0)
    btnClose:SetSize(50, 50)
    btnClose:SetText("✕")
    btnClose:SetFont("OrbitUI_Btn")
    btnClose:SetTextColor(Color(200, 200, 200))
    btnClose.Paint = function(s, w, h) 
        if s:IsHovered() then draw.RoundedBox(0, 0, 0, w, h, Color(200, 50, 50, 200)) end
    end
    btnClose.DoClick = function() frame:Close() end

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:SetPos(0, 50)
    scroll:SetSize(250, 450)
    scroll:GetCanvas():SetPos(0, 0)

    local selectedID = 0
    local labelStatus 

    local function AddItem(id, name)
        local btn = scroll:Add("DButton")
        btn:SetText("")
        btn:Dock(TOP)
        btn:SetHeight(45)
        btn:DockMargin(0, 0, 0, 1)
        btn.Paint = function(s, w, h)
            local isSel = (selectedID == id)
            if isSel then
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 140, 255, 60))
                draw.RoundedBox(0, 0, 0, 4, h, Color(0, 140, 255))
            elseif s:IsHovered() then
                draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 10))
            end
            local color = isSel and Color(255, 255, 255) or Color(180, 180, 180)
            draw.SimpleText(string.upper(name), "OrbitUI_Btn", 15, h/2, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
        btn.DoClick = function()
            selectedID = id
            if IsValid(labelStatus) then
                labelStatus:SetText(id == 0 and "ОТКЛЮЧЕНО" or string.upper(name))
            end
        end
    end

    AddItem(0, "Отключить")
    for id, v in SortedPairs(ORBIT_EFFECTS_LIST) do
        if LocalPlayer():GetNWBool("Orbit_Has_" .. id, false) then
            AddItem(id, v.name)
        end
    end

    local pnlRight = vgui.Create("DPanel", frame)
    pnlRight:SetPos(250, 50)
    pnlRight:SetSize(550, 450)
    pnlRight.Paint = function() end

    labelStatus = vgui.Create("DLabel", pnlRight)
    labelStatus:SetPos(0, 100)
    labelStatus:SetSize(550, 40)
    labelStatus:SetFont("OrbitUI_Title")
    labelStatus:SetText("ВЫБЕРИТЕ ЭФФЕКТ")
    labelStatus:SetContentAlignment(5)

    local btnApply = vgui.Create("DButton", pnlRight)
    btnApply:SetPos(125, 200)
    btnApply:SetSize(300, 60)
    btnApply:SetText("ПРИМЕНИТЬ")
    btnApply:SetFont("OrbitUI_Title")
    btnApply:SetTextColor(Color(255, 255, 255))
    btnApply.Paint = function(s, w, h)
        local col = s:IsHovered() and Color(0, 180, 100) or Color(0, 150, 80)
        draw.RoundedBox(6, 0, 0, w, h, col)
    end
    btnApply.DoClick = function()
        net.Start("Orbit_UpdateEffect")
        net.WriteUInt(selectedID, 4)
        net.SendToServer()
        frame:Close()
    end
end)

net.Receive("Orbit_OpenCrafting", function()
    local frame = vgui.Create("DFrame")
    frame:SetSize(400, 500)
    frame:Center()
    frame:SetTitle("СТОЛ КРАФТА")
    frame:MakePopup()

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)

    for id, v in SortedPairs(ORBIT_EFFECTS_LIST) do
        local has = LocalPlayer():GetNWBool("Orbit_Has_" .. id, false)
        local btn = scroll:Add("DButton")
        btn:SetText(v.name .. (has and " (УЖЕ ЕСТЬ)" or ""))
        btn:Dock(TOP)
        btn:SetHeight(40)
        btn:SetEnabled(not has)
        btn.DoClick = function()
            net.Start("Orbit_DoCraft")
            net.WriteUInt(id, 4)
            net.SendToServer()
            frame:Close()
        end
    end
end)