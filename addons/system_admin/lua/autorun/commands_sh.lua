local function syncToPanel(target_sid32, ITEM, pl)
    if not SERVER then return end
    if not VibeRP or not VibeRP.Config or not VibeRP.Config.PanelURL then return end
    local cat = ITEM:Category()
    if cat == "Профессии" or cat == "Оружие" or cat == "Модели" then
        local ep = ""
        local act = ""
        local payload = {
            steamid32 = target_sid32,
            title = ITEM:Name(),
            by = IsValid(pl) and pl:Nick() or "Server Console"
        }
        if cat == "Профессии" then
            ep = "/api/jobs_sync"
            act = "grant_job"
            payload.job_command = ITEM:UID()
        elseif cat == "Оружие" then
            ep = "/api/weapons_sync"
            act = "grant_weapon"
            payload.weapon_class = ITEM:UID()
        elseif cat == "Модели" then
            ep = "/api/models_sync"
            act = "grant_model"
            payload.model_path = ITEM:UID()
        end
        payload.action = act
        HTTP({
            url = VibeRP.Config.PanelURL .. ep,
            method = "POST",
            body = util.TableToJSON(payload),
            type = "application/json",
            headers = { ["X-API-Password"] = VibeRP.Config.Secret, ["Content-Type"] = "application/json" }
        })
    end
end

local cangivecredits = {
    ['STEAM_0:1:22093009'] = true,
    ['STEAM_0:0:562541572'] = true,
    ['STEAM_0:1:575732651'] = true,
    ['STEAM_0:1:452003092'] = true,
}

local function InitDonateCommands()
    if not ba or not ba.cmd then return false end

    ba.cmd.Create('adddonate', function(pl, args)
        if IsValid(pl) and pl:IsPlayer() then
            if not cangivecredits[pl:SteamID()] then pl:ChatPrint('Ошибка доступа!') return end
        end
        local item_uid = args.uid
        local ITEM = IGS.GetItemByUID(item_uid)
        if not ITEM or ITEM.isnull then
            local errMsg = "Ошибка: услуга с UID '" .. tostring(item_uid) .. "' не найдена!"
            if IsValid(pl) then pl:ChatPrint(errMsg) else print(errMsg) end
            return
        end

        if IsValid(args.target) and args.target:IsPlayer() then
            IGS.PlayerActivateItem(args.target, item_uid, function(id)
                local successMsg = 'Вы успешно выдали '..ITEM:Name()..' игроку '..args.target:GetName().. ' ('..id..')'
                if IsValid(pl) then
                    pl:ChatPrint(successMsg)
                else
                    print(successMsg)
                end
                args.target:ChatPrint('Вам выдали '..ITEM:Name()..'!')
                syncToPanel(args.target:SteamID(), ITEM, pl)
                if IsValid(args.target) then
                    net.Start('f4_purchase_update')
                        net.WriteString(item_uid)
                        net.WriteBool(true)
                    net.Send(args.target)
                end
                timer.Simple(0.5, function()
                    if IsValid(args.target) and IGS.SyncPurchases then
                        IGS.SyncPurchases(args.target)
                    elseif IsValid(args.target) and IGS.LoadPurchases then
                        IGS.LoadPurchases(args.target)
                    end
                end)
            end)
        else
            local target_sid = tostring(args.target)
            IGS.StoreLocalPurchase(util.SteamIDTo64(target_sid), item_uid, nil, function(id)
                local successMsg = 'Вы успешно выдали '..ITEM:Name()..' игроку '..target_sid.. ' ('..id..')'
                if IsValid(pl) then
                    pl:ChatPrint(successMsg)
                else
                    print(successMsg)
                end
                syncToPanel(target_sid, ITEM, pl)
            end)
        end
    end)
    :AddParam('player_steamid', 'target')
    :AddParam('string', 'uid')
    :SetFlag('*')
    :SetHelp('Выдать донат')

    ba.cmd.Create('donatelogs', function(pl, args)
        if CLIENT then return end
        if IsValid(pl) and pl:IsPlayer() then
            if not cangivecredits[pl:SteamID()] then pl:ChatPrint('Ошибка доступа!') return end
        end

        local sid64
        local plyEnt = NULL

        if IsValid(args.target) and args.target:IsPlayer() then
            sid64 = args.target:SteamID64()
            plyEnt = args.target
        else
            sid64 = util.SteamIDTo64(args.target)
        end

        if not sid64 or sid64 == "0" then
            local errMsg = 'Некорректный SteamID или игрок не найден'
            if IsValid(pl) then pl:ChatPrint(errMsg) else print(errMsg) end
            return
        end

        IGS.GetPurchases(function(purchases)
            if not IsValid(pl) then
                print("Донат логи для " .. sid64 .. ":")
                PrintTable(purchases)
                return
            end
            net.Start('igsClientMenu')
                net.WriteTable(purchases)
                net.WriteEntity(plyEnt)
                net.WriteString(sid64)
            net.Send(pl)
        end, {
            sid = sid64,
            only_active = 1
        })
    end)
    :AddParam('player_steamid', 'target')
    :SetFlag('*')
    :SetHelp('Информация о донате')

    return true
end

if not InitDonateCommands() then
    hook.Add('Initialize', 'InitDonateCommands', function()
        timer.Simple(5, function()
            if not InitDonateCommands() then
                timer.Simple(10, InitDonateCommands)
            end
        end)
    end)
end

if CLIENT then
    surface.CreateFont('DonateTitle', { font = 'Roboto', size = 20, weight = 700 })
    surface.CreateFont('DonateItem', { font = 'Roboto', size = 18, weight = 500 })
    surface.CreateFont('DonateSmall', { font = 'Roboto', size = 14, weight = 400 })
    surface.CreateFont('DonateBtn', { font = 'Roboto', size = 16, weight = 600 })

    local colBg = Color(22, 22, 28)
    local colCard = Color(32, 32, 42)
    local colCardHover = Color(42, 42, 55)
    local colAccent = Color(100, 120, 255)
    local colRed = Color(255, 80, 80)
    local colRedHover = Color(255, 50, 50)
    local colText = Color(240, 240, 240)
    local colSubtext = Color(160, 160, 180)
    local colGreen = Color(80, 220, 120)

    net.Receive('igsClientMenu', function()
        if igsFrameDonate then igsFrameDonate:Remove() end

        local donate_all = net.ReadTable()
        local ply = net.ReadEntity()
        local targetSID = net.ReadString()

        if #donate_all == 0 then
            chat.AddText(Color(255, 80, 80), "[IGS] ", Color(255, 255, 255), "У данного игрока нет активных покупок.")
            return
        end

        local display_name = (IsValid(ply) and ply:IsPlayer()) and ply:GetName() or targetSID

        local fr = vgui.Create('DFrame')
        fr:SetSize(ScrW() * 0.5, ScrH() * 0.6)
        fr:Center()
        fr:MakePopup()
        fr:SetTitle('')
        fr:ShowCloseButton(false)
        fr:DockPadding(12, 50, 12, 12)
        fr.Paint = function(self, w, h)
            draw.RoundedBox(10, 0, 0, w, h, colBg)
            draw.RoundedBoxEx(10, 0, 0, w, 44, colAccent, true, true, false, false)
            draw.SimpleText('Донат: ' .. display_name, 'DonateTitle', w * 0.5, 22, colText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        igsFrameDonate = fr

        local closeBtn = vgui.Create('DButton', fr)
        closeBtn:SetSize(30, 30)
        closeBtn:SetPos(fr:GetWide() - 38, 7)
        closeBtn:SetText('')
        closeBtn.Paint = function(self, w, h)
            local c = self:IsHovered() and colRed or colSubtext
            draw.SimpleText('X', 'DonateTitle', w * 0.5, h * 0.5, c, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        closeBtn.DoClick = function() fr:Remove() end

        local count = vgui.Create('DPanel', fr)
        count:Dock(TOP)
        count:SetTall(28)
        count:DockMargin(0, 0, 0, 8)
        count.Paint = function(self, w, h)
            draw.SimpleText('Активных услуг: ' .. #donate_all, 'DonateSmall', 4, h * 0.5, colGreen, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local Scroll = vgui.Create("DScrollPanel", fr)
        Scroll:Dock(FILL)
        local sbar = Scroll:GetVBar()
        sbar:SetWide(5)
        sbar:SetHideButtons(true)
        sbar.Paint = function(self, w, h)
            draw.RoundedBox(3, 0, 0, w, h, Color(20, 20, 26))
        end
        sbar.btnGrip.Paint = function(self, w, h)
            draw.RoundedBox(3, 0, 0, w, h, colAccent)
        end

        for k, v in ipairs(donate_all) do
            local item_name = v.Item
            local ITEM = IGS.GetItemByUID(v.Item)
            if not ITEM.isnull then item_name = ITEM:Name() end

            local card = Scroll:Add('DPanel')
            card:Dock(TOP)
            card:DockMargin(0, 0, 0, 8)
            card:SetTall(140)
            card.Paint = function(self, w, h)
                local bg = self:IsHovered() and colCardHover or colCard
                draw.RoundedBox(8, 0, 0, w, h, bg)
                draw.RoundedBox(3, 0, 0, 4, h, colAccent)
            end

            local iconPanel = vgui.Create('DPanel', card)
            iconPanel:SetSize(120, 120)
            iconPanel:SetPos(12, 10)
            iconPanel.Paint = function(self, w, h)
                draw.RoundedBox(6, 0, 0, w, h, Color(20, 20, 26))
            end

            if ITEM.icon then
                if ITEM.icon.isModel then
                    local model_panel = vgui.Create("DModelPanel", iconPanel)
                    model_panel:Dock(FILL)
                    model_panel:DockMargin(4, 4, 4, 4)
                    model_panel:SetModel(ITEM.icon.icon)
                    if IsValid(model_panel.Entity) then
                        local mn, mx = model_panel.Entity:GetRenderBounds()
                        local size = math.max(math.abs(mn.x) + math.abs(mx.x), math.abs(mn.y) + math.abs(mx.y), math.abs(mn.z) + math.abs(mx.z))
                        model_panel:SetFOV(45)
                        model_panel:SetCamPos(Vector(size, size, size))
                        model_panel:SetLookAt((mn + mx) * 0.5)
                    end
                    model_panel.LayoutEntity = function() end
                else
                    local img = vgui.Create("igs_wmat", iconPanel)
                    img:Dock(FILL)
                    img:DockMargin(4, 4, 4, 4)
                    img:SetURL(ITEM.icon.icon)
                end
            end

            local infoPanel = vgui.Create('DPanel', card)
            infoPanel:SetPos(144, 12)
            infoPanel:SetSize(350, 80)
            infoPanel.Paint = function(self, w, h)
                draw.SimpleText(item_name, 'DonateItem', 0, 4, colText, TEXT_ALIGN_LEFT)
                draw.SimpleText('ID: ' .. v.ID, 'DonateSmall', 0, 28, colSubtext, TEXT_ALIGN_LEFT)
                if v.ExpireDate then
                    draw.SimpleText('Истекает: ' .. os.date('%d.%m.%Y', v.ExpireDate), 'DonateSmall', 0, 46, colSubtext, TEXT_ALIGN_LEFT)
                else
                    draw.SimpleText('Перманентно', 'DonateSmall', 0, 46, colGreen, TEXT_ALIGN_LEFT)
                end
            end

            local disable = vgui.Create('DButton', card)
            disable:SetSize(180, 36)
            disable:SetPos(144, 96)
            disable:SetText('')
            disable.Paint = function(self, w, h)
                local bg = self:IsHovered() and colRedHover or colRed
                draw.RoundedBox(6, 0, 0, w, h, bg)
                draw.SimpleText('Забрать услугу', 'DonateBtn', w * 0.5, h * 0.5, colText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            disable.DoClick = function()
                Derma_Query("Вы уверены что хотите забрать услугу \"" .. item_name .. "\"?", "Подтверждение", "Да", function()
                    if IsValid(igsFrameDonate) then igsFrameDonate:Remove() end
                    net.Start('igs.RemoveMenu')
                        net.WriteEntity(ply)
                        net.WriteUInt(v.ID, IGS.BIT_PURCH_ID)
                        net.WriteString(item_name)
                        net.WriteString(v.Item)
                    net.SendToServer()
                end, "Нет")
            end
        end
    end)
end

if SERVER then
    util.AddNetworkString('igsClientMenu')
    util.AddNetworkString('igs.RemoveMenu')
    util.AddNetworkString('f4_purchase_update')

    net.Receive('igs.RemoveMenu', function(_, pl)
        if not cangivecredits[pl:SteamID()] then return end

        local user = net.ReadEntity()
        local id = net.ReadUInt(IGS.BIT_PURCH_ID)
        local item_name = net.ReadString()
        local item_uid = net.ReadString()

        IGS.DisablePurchase(id, function(bDisabled)
            if not IsValid(pl) then return end
            local target_nick = IsValid(user) and user:Name() or "Оффлайн игрок"
            pl:ChatPrint('Услуга "' .. item_name .. '" успешно отключена у ' .. target_nick)
            if IsValid(user) then
                user:ChatPrint('Администратор ' .. pl:Name() .. ' аннулировал вашу услугу: ' .. item_name)
                net.Start('f4_purchase_update')
                    net.WriteString(item_uid)
                    net.WriteBool(false)
                net.Send(user)
                timer.Simple(0.5, function()
                    if IsValid(user) and IGS.SyncPurchases then
                        IGS.SyncPurchases(user)
                    elseif IsValid(user) and IGS.LoadPurchases then
                        IGS.LoadPurchases(user)
                    end
                end)
            end
        end)
    end)
end