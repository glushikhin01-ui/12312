surface.CreateFont("MM_14",{font="Tahoma",size=14,weight=500})

buttonsLockeds = false

local backgroundColor = Color(14, 14, 14, 255)
local secondaryBackgroundColor = Color(19, 19, 19, 82)
local categoryColor = Color(1,89,224)

local function Nums(String) local TableLetters = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"} local Accept = false  for k, v in pairs(TableLetters) do  if v == string.upper(String) then  Accept = true  end  end  return Accept  end 
local function niceSum(i, fb) return math.Truncate(tonumber(i) or fb or 0, 2) end
local function ub_findByIGSids( itemID )
    for k,v in pairs( BUC2.ITEMS ) do
        if v.weaponName == itemID or v.amount == itemID then
            return k
        end
    end
end
local function FixCam( self )
    local min, max = self.Entity:GetRenderBounds()
    self:SetFOV( 90 )
    self:SetCamPos(min:Distance(max) * Vector(0.43, 0.43, 0))
    self:SetLookAt((max + min) / 2)
end

local crateMat = Material("bu2/case.png","smooth noclamp")
local keyMat = Material("bu2/key.png","smooth noclamp")
local moneyIcon = Material("bu2/money.png","smooth noclamp")
local itemShadowMat = Material("bu2/item_shadow.png","smooth noclamp")

local matCache = {}
local logo2mat = Material('materials/eui/default/logo2.png', 'smooth')
local function CreateMaterials(arguments)
    if not matCache[arguments] then
        matCache[arguments] = Material('hud/'..arguments..'.png', 'smooth')
    end
    return matCache[arguments]
end

local function weight(w) return (w / 1920) * ScrW() end
local function height(h) return (h / 1080) * ScrH() end

function generateTape(itemID)
    local totalChance = 0
    for k , v in pairs(BUC2.ITEMS[itemID].items) do
        v = BUC2.ITEMS[v]
        totalChance = totalChance + v.chance
    end
    local itemList = {}
    for i = 0  , 99 do
        local num = math.random(1 , totalChance)
        local prevCheck = 0
        local item = nil
        for k ,v in pairs(BUC2.ITEMS[itemID].items) do
            local original_v = v 
            v = BUC2.ITEMS[v]
            if v.itemType ~= "Key" and v.itemType ~= "Crate" then
                if num >= prevCheck and num <= prevCheck + v.chance then
                    item = original_v 
                end
                prevCheck = prevCheck + v.chance
            end
        end
        if item == nil then
            for k, v in pairs(BUC2.ITEMS[itemID].items) do
                local itemData = BUC2.ITEMS[v]
                if itemData.itemType ~= "Key" and itemData.itemType ~= "Crate" then
                    item = v
                    break
                end
            end
        end
        itemList[i] = item
    end
    return itemList
end

local isOpen = false
local donateVGUI = nil
local frame
function OpenDonateUI()
    if IsValid(frame) then return end
    buttonsLockeds = false
    isOpen = true
    local ply = LocalPlayer()

    local ModelPanel = CompileFile "unbox/modelpanel.lua" {
        outline = GenerateOutline,
        cam = FixCam,
        mat1 = itemBackgroundMat,
        mat2 = moneyIcon,
        weight = weight,
        height = height
    }
    local UpgradePage = CompileFile "unbox/upgrade.lua" {
        ModelPanel = ModelPanel,
        find = ub_findByIGSids,
        FixCam = FixCam,
        divColor = divColor,
        weight = weight,
        height = height
    }
    local SpinnerPanel = CompileFile "unbox/spinner.lua" {
        ModelPanel = ModelPanel,
        generateTape = generateTape,
        frameColor = frameColor,
        gradientL = gradientL,
        gradientR = gradientR,
        weight = weight,
        height = height
    }
    local CratePanel = CompileFile "unbox/crate.lua" ( )

    frame = vgui.Create('EditablePanel')
    frame:SetSize(ScrW(), ScrH())
    frame:SetPos(0, 0)
    frame:MakePopup()
    frame:SetAlpha(0)
    frame:AlphaTo(255,0.3)

    donateVGUI = frame

    local mainFrame = vgui.Create('Panel',frame)
    mainFrame:SetSize(ScrW(), ScrH())
    mainFrame:SetPos(0, 0)
    mainFrame.Paint = function(self,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(15, 15, 15, 200)) 
    end
    local close = vgui.Create("DButton", mainFrame)
    close:SetSize(weight(40), height(40))
    close:SetPos(ScrW() - close:GetWide() - weight(10), height(10))
    close:SetText("")
    close:SetZPos(1000)
    close.DoClick = function()
        if buttonsLockeds then return end
        frame:AlphaTo(0,0.3,0,function()
            buttonsLockeds = false
            isOpen = false
            donateVGUI = nil
            BUC2.DonateInvPanel = nil
            BUC2.DonateUpgradePanel = nil
            BUC2.DonateCasePanel = nil
            frame:Remove()
        end)
    end
    close.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(255, 50, 50, self:IsHovered() and 255 or 200))
        draw.SimpleText("X", "DermaLarge", w / 2, h / 2, Color(255, 255, 255), 1, 1)
    end

    local topBalBox = vgui.Create('Panel', mainFrame)
    topBalBox:SetSize(weight(500), height(110))
    topBalBox:SetPos(weight(70), height(70))
    local azIcon = Material("f6donate/coinaz.png", "smooth")
    topBalBox.Paint = function(self, w, h)
        local money = math.Round(ply:IGSFunds() or 0)
        surface.SetFont("DermaLarge")
        local tw, th = surface.GetTextSize(tostring(money))
        
        local iconSize = height(38)
        if not azIcon:IsError() then
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(azIcon)
            surface.DrawTexturedRect(0, height(70) - iconSize/2, iconSize, iconSize)
        else
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(moneyIcon)
            surface.DrawTexturedRect(0, height(70) - iconSize/2, iconSize, iconSize)
        end
        
        local textOffset = iconSize + weight(10)
        draw.SimpleText(money, "DermaLarge", textOffset, height(70), Color(255, 255, 255), 0, 1)
        
        if IsValid(self.plusBtn) then
            self.plusBtn:SetPos(textOffset + tw + weight(25), height(50))
            draw.SimpleText("1 RUB = 3 AZ", "Trebuchet24", textOffset + tw + weight(25) + self.plusBtn:GetWide()/2, height(38), Color(255, 255, 255, 240), 1, 1)
        end
    end

    local plusBtn = vgui.Create('DButton', topBalBox)
    topBalBox.plusBtn = plusBtn
    plusBtn:SetSize(weight(160), height(40)) 
    plusBtn:SetText('')
    plusBtn.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, self:IsHovered() and Color(255, 220, 50) or Color(255, 200, 0))
        draw.SimpleText("+ ПОПОЛНИТЬ", "DermaDefaultBold", w/2, h/2, Color(0, 0, 0), 1, 1)
    end
    plusBtn.DoClick = function()
        if IsValid(activeDep) then activeDep:Remove() end
        activeDep = vgui.Create('DFrame')
        local Dep = activeDep
        Dep:SetSize(weight(400), height(220)) 
        Dep:Center() 
        Dep:SetTitle('') 
        Dep:MakePopup() 
        Dep:ShowCloseButton(false) 
        Dep.Paint = function(self,w,h)
            draw.RoundedBox(12,0,0,w,h,Color(25, 25, 25, 250))
            draw.SimpleText('Пополнение баланса','DermaLarge',w/2,height(30),Color(255,255,255),1,1)
            draw.SimpleText('Введите сумму (в рублях) для пополнения:','DermaDefault',w/2,height(70),Color(200,200,200),1,1)
        end
        local cls = vgui.Create('DButton',Dep)
        cls:SetSize(weight(30),height(30))
        cls:SetPos(Dep:GetWide() - weight(40),height(10))
        cls:SetText('')
        cls.Paint = function(self,w,h)
            draw.RoundedBox(6,0,0,w,h, self:IsHovered() and Color(255,100,100) or Color(200,50,50))
            draw.SimpleText('X','DermaDefaultBold',w/2,h/2,Color(255,255,255),1,1)
        end
        cls.DoClick = function() Dep:Remove() end

        local text = vgui.Create('DTextEntry',Dep)
        text:SetPos(weight(40),height(100))
        text:SetSize(weight(320),height(40))
        text:SetFont('DermaLarge')
        text:SetNumeric(true)
        text.Paint = function(self,w,h)
            draw.RoundedBox(8,0,0,w,h,Color(15,15,15))
            self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
        end
        local oplat = vgui.Create('DButton',Dep)
        oplat:SetPos(weight(40),height(160))
        oplat:SetSize(weight(320),height(40))
        oplat:SetText('')
        oplat.Paint = function(self,w,h)
            draw.RoundedBox(8,0,0,w,h,self:IsHovered() and Color(255, 220, 50) or Color(255, 200, 0))
            draw.SimpleText('ПЕРЕЙТИ К ОПЛАТЕ','DermaDefaultBold',w/2,h/2,Color(0,0,0),1,1)
        end
        oplat.DoClick = function()
            local am = tonumber(text:GetValue() or 0)
            if am > 0 then
                IGS.UICharge(am)
                Dep:Remove()
            end
        end
    end

    local butList = vgui.Create('Panel', mainFrame)
    butList:SetSize(weight(350), ScrH() - height(200))
    butList:SetPos(weight(70), height(215))
    butList.Paint = function() end

    local function openProfile()
        if IsValid(Profile) then return end
        Profile = vgui.Create('Panel',mainFrame)
        Profile:SetSize(weight(1400),height(950))
        Profile:SetPos(weight(480),height(68))

        local bpanel = vgui.Create('Panel',Profile)
        bpanel:SetSize(weight(147)*1.3,height(38)*1.3)
        bpanel:SetPos(weight(611)*1.3,height(10)*1.3)

        local function openInv()
            if IsValid(profileInv) then profileInv:Remove() end
            profileInv = vgui.Create('DScrollPanel',Profile)
            profileInv:SetSize(weight(775)*1.3,height(484)*1.3)
            profileInv:SetPos(weight(20)*1.3,height(66)*1.3)
            profileInv.VBar:SetWide(0)

            local xpos,ypos = 0,0
            IGS.GetInventory(function(datas)
                for k,v in ipairs(datas) do
                    local item = vgui.Create('Panel',profileInv)
                    item:SetSize(weight(180)*1.3,height(256)*1.3)
                    item:SetPos(xpos,ypos)
                    item.Paint = function(self,w,h)
                        draw.RoundedBox(10,0,0,w,h,secondaryBackgroundColor)
                        draw.SimpleText(v.item.name, 'M_14', w/2, h/2-weight(107)*1.3, color_white, 1,1)
                    end

                    if not v or not v.item then continue end

                    local activeBut = vgui.Create('DButton',item)
                    activeBut:SetPos(weight(46)*1.3,height(189)*1.3)
                    activeBut:SetSize(weight(42)*1.3,height(42)*1.3)
                    activeBut:SetText('')
                    activeBut.Paint = function(self,w,h)
                        draw.RoundedBox(5,0,0,w,h,Color(categoryColor.r, categoryColor.g, categoryColor.b, 51))
                        surface.SetMaterial(CreateMaterials('plus_3_1-info')) 
                        surface.SetDrawColor(255,255,255) 
                        surface.DrawTexturedRect(weight(6)*1.3,height(6)*1.3,weight(30)*1.3,height(30)*1.3)
                    end
                    activeBut.DoClick = function()
                        ui.BoolRequest("Подтверждение активации", 'Вы уверены, что хотите активировать '..v.item.name..' ?', function(t)
                            if not t then return end
                            IGS.ProcessActivate(v.id, function(ok)
                                if not ok then return end
                            end)
                            openInv()
                        end)
                    end

                    local del = vgui.Create('DButton', item)
                    del:SetPos(weight(92)*1.3, height(189)*1.3)
                    del:SetSize(weight(42)*1.3, height(42)*1.3)
                    del:SetText('')
                    del.Paint = function(self,w,h)
                        draw.RoundedBox(5,0,0,w,h,Color(229,118,118,51))
                        surface.SetMaterial(CreateMaterials('recycle-bin_1')) 
                        surface.SetDrawColor(255,255,255) 
                        surface.DrawTexturedRect(weight(6)*1.3, height(6)*1.3, weight(30)*1.3, height(30)*1.3)
                    end
                    del.DoClick = function()
                        local itemName = (v.item and v.item.name) or "неизвестный предмет"
                        ui.BoolRequest("Подтверждение выбрасывания", 'Вы уверены, что хотите выбросить ' .. itemName .. ' ?', function(t)
                            if not t then return end
                            IGS.DropItem(v.id)
                            openInv()
                        end)
                    end

                    if not v.item.icon or not v.item.icon.icon then continue end

                    if v.item.icon.isModel then
                        local mdl = vgui.Create('ModelImage', item)
                        mdl:SetSize( weight(128)*1.3, height(128)*1.3 )
                        mdl:SetPos( item:GetWide() / 2 - weight(128)*1.3 / 2, item:GetTall() / 2 - height(160-2)*1.3 / 2 )
                        mdl:SetModel( v.item.icon.icon or 'models/items/item_item_crate.mdl' )
                        mdl:SetTooltip()
                        mdl:SetMouseInputEnabled(false)
                    else
                        local model_panels = vgui.Create("igs_wmat", item)
                        model_panels:SetSize( weight(128)*1.3, height(128)*1.3 )
                        model_panels:SetPos( item:GetWide() / 2 - weight(128)*1.3 / 2, item:GetTall() / 2 - height(178-2)*1.3 / 2 )
                        model_panels:SetURL(v.item.icon.icon)
                        model_panels:SetMouseInputEnabled(false)
                    end
                    xpos = xpos + weight(196)*1.3
                    if xpos > weight(775)*1.3 then
                        xpos = 0
                        ypos = ypos + height(270)*1.3
                    end
                end
            end)
        end
        openInv()

        local matveicherCat247
        local function matveicher()
            if IsValid(matveicherCat247) then matveicherCat247:Remove() end
            matveicherCat247 = vgui.Create('DScrollPanel',Profile)
            matveicherCat247:SetSize(weight(775)*1.3,height(484)*1.3)
            matveicherCat247:SetPos(weight(20)*1.3,height(66)*1.3)
            matveicherCat247.VBar:SetWide(0)

            local xpos,ypos = 0,0
            IGS.GetMyPurchases(function(datas)
                for k,v in ipairs(datas) do
                    local ITEM    = IGS.GetItemByUID(v.item)
                    local exp     = IGS.TimestampToDate(v.expire) or 'Никогда'
                    if ITEM.isnull then continue end
                    if not ITEM.swep then continue end
                    local item = vgui.Create('Panel',matveicherCat247)
                    item:SetSize(weight(180)*1.3,height(256)*1.3)
                    item:SetPos(xpos,ypos)
                    item.Paint = function(self,w,h)
                        draw.RoundedBox(10,0,0,w,h,secondaryBackgroundColor)
                    end
                    local should_give = LocalPlayer():GetNWBool("igs.gos." .. ITEM:ID())
                    if ITEM.swep then 
                        local pnl = vgui.Create('Panel',item)
                        pnl:SetSize(weight(123)*1.3,height(42)*1.3)
                        pnl:SetPos(weight(28)*1.3,height(189)*1.3)
                        pnl.Paint = function(self,w,h)
                            draw.RoundedBox(12,0,0,w,h,Color(categoryColor.r, categoryColor.g, categoryColor.b, 51))
                            local should_give = LocalPlayer():GetNWBool("igs.gos." .. ITEM:ID())
                            draw.SimpleText(should_give and 'ВКЛ' or 'Вкл',should_give and "DermaDefault" or 'MM_12',weight(61)*1.3/2,h/2,Color(255,255,255),1,1)
                            draw.SimpleText(should_give and 'Выкл' or 'ВЫКЛ',should_give and 'MM_12' or "DermaDefault",weight(61+62),h/2,Color(255,255,255),1,1)
                        end
                        local cbox = vgui.Create('DButton',pnl)
                        cbox:SetPos(should_give and 0 or weight(62)*1.3,0)
                        cbox:SetSize(weight(61)*1.3,height(42)*1.3)
                        cbox:SetText('')
                        cbox.Paint = function(self,w,h)
                            draw.RoundedBox(10,0,0,w,h,should_give and Color(234,104,255,60) or Color(255,103,103,60))
                        end
                        cbox.DoClick = function()
                            local should_give = LocalPlayer():GetNWBool("igs.gos." .. ITEM:ID())
                            cbox:MoveTo(should_give and weight(62)*1.3 or 0,0,0.2,0)
                            net.Start("IGS.GiveOnSpawnWep")
                            net.WriteIGSItem(ITEM)
                            net.WriteBool(not should_give)
                            net.SendToServer()
                        end
                    end
                    if ITEM.category == 'Привилегии' then
                        local pnl = vgui.Create('Panel',item)
                        pnl:SetSize(weight(123)*1.3,height(42)*1.3)
                        pnl:SetPos(weight(28)*1.3,height(189)*1.3)
                        pnl.Paint = function(self,w,h)
                            draw.RoundedBox(12,0,0,w,h,Color(categoryColor.r, categoryColor.g, categoryColor.b, 51))
                            surface.SetMaterial(CreateMaterials('deadline_1-bin_1')) 
                            surface.SetDrawColor(255,255,255) 
                            surface.DrawTexturedRect(weight(2)*1.3,height(6)*1.3,weight(30)*1.3,height(30)*1.3)
                            draw.SimpleText(exp, 'MM_16',w/2,h/2,Color(255,255,255),1,1)
                        end
                    end
                    if not ITEM.icon then continue end
                    if ITEM.icon.isModel then
                        local mdl = vgui.Create('ModelImage', item)
                        mdl:SetSize( weight(55)*1.3, height(55)*1.3 )
                        mdl:SetPos( item:GetWide() / 2 - weight(55)*1.3 / 2, item:GetTall() / 2 - height(55)*1.3 / 2 )
                        mdl:SetModel( ITEM.icon.icon or 'models/Items/item_item_crate.mdl' )
                        mdl:SetTooltip()
                        mdl:SetMouseInputEnabled(false)
                        mdl.DoClick = function() 
                            return
                        end
                    else
                        local model_panels = vgui.Create("igs_wmat", item)
                        model_panels:SetSize( weight(55)*1.3, height(55)*1.3 )
                        model_panels:SetPos( item:GetWide() / 2 - weight(55)*1.3 / 2, item:GetTall() / 2 - height(55)*1.3 / 2 )
                        model_panels:SetURL(ITEM.icon.icon)
                        model_panels:SetMouseInputEnabled(false)
                    end
                    xpos = xpos + weight(196)*1.3
                    if xpos > weight(775)*1.3 then
                        xpos = 0
                        ypos = ypos + height(270)*1.3
                    end
                end
            end)
        end

        local profileHistoryScroll
        local function history()
            if IsValid(profileHistoryScroll) then profileHistoryScroll:Remove() end
            profileHistoryScroll = vgui.Create('DScrollPanel',Profile)
            profileHistoryScroll:SetSize(weight(780)*1.3,height(482)*1.3)
            profileHistoryScroll:SetPos(weight(14)*1.3,height(68)*1.3)
            profileHistoryScroll.VBar:SetWide(0)

            local space = 0
            IGS.GetMyTransactions(function(dat)
                for k,v in pairs(dat) do
                    v.note = v.note or "-"
                    local function name_or_uid(sUid)
                        local ITEM = IGS.GetItemByUID(sUid)
                        return ITEM.isnull and sUid or ITEM:Name()
                    end
                    local note =
                        v.note:StartWith("P: ") and name_or_uid(v.note:sub(4)) or
                        v.note:StartWith("A: ") and ("Пополнение счета (" .. v.note:sub(4) .. ")") or
                        v.note:StartWith("C: ") and ("Купон " .. v.note:sub(4,13) .. "...") or
                        v.note

                    surface.SetFont("DermaDefault")
                    local data = vgui.Create('Panel',profileHistoryScroll)
                    data:SetSize(weight(780)*1.3,height(41)*1.3)
                    data:SetPos(0,space)
                    data.Paint = function(self,w,h)
                        draw.RoundedBox(6,0,0,w,h,secondaryBackgroundColor)
                        draw.SimpleText(string.sub(v.sum, 1, 1) == "-" and v.sum..'p' or '+'..v.sum..'p',"DermaDefault",w/2,h/2,string.sub(v.sum, 1, 1) == "-" and Color(255,138,138) or categoryColor,1,1)
                        draw.SimpleText(note == '-' and '' or note,"DermaDefault",weight(50)*1.3,h/2,Color(255,255,255),0,1)
                        draw.SimpleText(IGS.TimestampToDate(v.date,true),"DermaDefault",w-weight(9)*1.3,h/2,Color(255,255,255,127),2,1)
                        if v.note:StartWith("A: ") or string.sub(v.sum, 1, 1) ~= "-" then
                            surface.SetMaterial(CreateMaterials('salarasdy_1_1-bin_1')) 
                            surface.SetDrawColor(255,255,255) 
                            surface.DrawTexturedRect(weight(7)*1.3,height(6)*1.3,weight(30)*1.3,height(30)*1.3)
                        end
                        if note == 'Покупка кейса' or note == 'Покупка аксессуара' then
                            surface.SetMaterial(CreateMaterials('salarasdy_1_1-bin_1')) 
                            surface.SetDrawColor(255,255,255) 
                            surface.DrawTexturedRect(weight(7)*1.3,height(6)*1.3,weight(30)*1.3,height(30)*1.3)
                        end
                        if note == 'Покупка лота' then
                            surface.SetMaterial(CreateMaterials('prempass')) 
                            surface.SetDrawColor(255,255,255) 
                            surface.DrawTexturedRect(weight(7)*1.3,height(6)*1.3,weight(30)*1.3,height(30)*1.3)
                        end
                    end
                    if v.note:StartWith("P: ") then
                        local ITEM = IGS.GetItemByUID(v.note:sub(4))
                        if ITEM and not ITEM.isnull and ITEM.icon then
                            if ITEM.image_url ~= 'http://i.imgur.com/32iTOFi.jpg' then
                                if ITEM.icon.isModel then
                                    local mdl = vgui.Create('ModelImage', data)
                                    mdl:SetSize( weight(30)*1.3, height(30)*1.3 )
                                    mdl:SetPos( weight(7), data:GetTall() / 2 - height(30)*1.3 / 2 )
                                    mdl:SetModel( ITEM.icon.icon or 'models/Items/item_item_crate.mdl' )
                                    mdl:SetTooltip()
                                    mdl:SetMouseInputEnabled(false)
                                    mdl.DoClick = function() 
                                        return
                                    end
                                else
                                    local model_panels = vgui.Create("igs_wmat", data)
                                    model_panels:SetSize( weight(30)*1.3, height(30)*1.3 )
                                    model_panels:SetPos( weight(7), data:GetTall() / 2 - height(30)*1.3 / 2 )
                                    model_panels:SetURL(ITEM.icon.icon)
                                    model_panels:SetMouseInputEnabled(false)
                                end
                            end
                        end
                    end
                    space = space + height(50)*1.3
                end
            end)
        end

        local bSelected = 1
        local allButs = {
            {
                iconname = 'shoppinasdg-cart_3_1',
                xpos = weight(8),
                func = function()
                    if IsValid(matveicherCat247) then matveicherCat247:Remove() end
                    if IsValid(profileHistoryScroll) then profileHistoryScroll:Remove() end
                    openInv()
                    bSelected = 1
                end
            },
            {
                iconname = 'time-managasdasdement_1_1',
                xpos = weight(10),
                func = function()
                    if IsValid(profileHistoryScroll) then profileHistoryScroll:Remove() end
                    if IsValid(profileInv) then profileInv:Remove() end
                    matveicher()
                    bSelected = 2
                end
            },
            {
                iconname = 'asdasdasd',
                xpos = weight(10),
                func = function()
                    if IsValid(profileInv) then profileInv:Remove() end
                    if IsValid(matveicherCat247) then matveicherCat247:Remove() end
                    history()
                    bSelected = 3
                end
            }
        }

        local space = 0
        for k,v in ipairs(allButs) do
            local btn = vgui.Create('DButton',bpanel)
            btn:SetSize(weight(38)*1.3,height(38)*1.3)
            btn:SetPos(space,0)
            btn:SetText('')
            btn.Paint = function(self,w,h)
                local clr = Color(categoryColor.r, categoryColor.g, categoryColor.b, 40)
                if bSelected == k then
                    clr = Color(categoryColor.r, categoryColor.g, categoryColor.b, 40)
                end
                draw.RoundedBox(6,0,0,w,h,clr)
                surface.SetMaterial(CreateMaterials(v.iconname)) 
                surface.SetDrawColor(categoryColor) 
                surface.DrawTexturedRect(v.xpos*1.3,height(9)*1.3,weight(20)*1.3,height(20)*1.3)
            end
            btn.DoClick = v.func
            space = space + weight(38+16)
        end
    end

    local cat
    local function drawCategory(cats) 
        if IsValid(cat) then cat:Remove() end

        cat = vgui.Create('Panel',mainFrame)
        cat:SetSize(weight(1400), height(950))
        cat:SetPos(weight(480), height(68))

        local sc = vgui.Create('DScrollPanel', cat)
        sc:Dock(FILL)
        sc:GetVBar():SetWide(0)

        local scr = vgui.Create('DIconLayout', sc)
        scr:Dock(TOP)
        scr:SetPos(0, 0)
        scr:SetSpaceX(weight(20)*1.3)
        scr:SetSpaceY(height(20)*1.3)

        for k,v in pairs(IGS.GetItems()) do
            if v.category ~= cats then continue end
            if v.hidden then continue end

            local items = vgui.Create('Panel', scr)
            items:SetSize(weight(167)*1.3, height(228)*1.3)
            items.Paint = function(self,w,h)
                draw.RoundedBox(10, 0, 0, w, h, secondaryBackgroundColor)
            end
            local mpanel = vgui.Create('Panel',items)
            mpanel:SetSize(weight(147)*1.3,height(147)*1.3)
            mpanel:SetPos(weight(10)*1.3,height(10)*1.3)
            mpanel.Paint = function(self,w,h)
                draw.RoundedBox(10,0,0,w,h,Color(255,255,255,10))
                if v.color then
                    surface.SetMaterial(CreateMaterials('Ellipse_6-info')) 
                    surface.SetDrawColor(v.color:Unpack()) 
                    surface.DrawTexturedRect(weight(5)*1.3,height(5)*1.3,weight(135)*1.3,height(135)*1.3)
                end
            end

            if not v.icon then continue end
            if v.icon.isModel then
                local model_panel = vgui.Create("DModelPanel", mpanel)
                model_panel:Dock(FILL)
                local mdl = type(v.icon.icon) == "string" and v.icon.icon or "models/error.mdl"
                model_panel:SetModel(mdl)
                model_panel:SetMouseInputEnabled(false)

                local mn, mx = model_panel.Entity:GetRenderBounds()
                local size = 0
                size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
                size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
                size = math.max(size, math.abs(mn.z) + math.abs(mx.z))

                model_panel:SetFOV(50)
                model_panel:SetCamPos(Vector(size, size, size))
                model_panel:SetLookAt((mn + mx) * 0.5)
                model_panel.LayoutEntity = function() return false end
            else
                local model_panels = vgui.Create("igs_wmat", mpanel)
                model_panels:Dock(FILL)
                model_panels:SetURL(v.icon.icon)
                model_panels:SetMouseInputEnabled(false)
            end
            local main = vgui.Create('Panel',items)
            main:SetSize(weight(167)*1.3,height(167)*1.3)
            main:SetPos(0,height(167)*1.3)
            main.Paint = function(self,w,h)
                draw.SimpleText(v.name,'M_14',weight(10)*1.3)
                draw.SimpleText(math.Round(v.price, 0) .. ' P','M_14',weight(10)*1.3,height(28)*1.3,categoryColor)
                if v.discounted_from then
                    draw.SimpleText(v.discounted_from .. ' P','M_14',weight(20)*1.3,height(57)*1.3,Color(255,255,255,255/2))
                    surface.SetFont('M_14')
                    local gx,xy = surface.GetTextSize(v.discounted_from .. ' P')
                    draw.RoundedBox(0,weight(20)*1.3,height(65)*1.3,gx+weight(1)*1.3,height(1)*1.3,Color(255,255,255,127))
                end
            end

            local buy = vgui.Create('DButton',main)
            buy:SetSize(weight(60)*1.3,height(29)*1.3)
            buy:SetPos(weight(97)*1.3,height(23)*1.3)
            buy:SetText('')
            buy.alpha = 0
            buy.Paint = function(self,w,h)
                if self:IsHovered() then
                    self.alpha = Lerp(FrameTime()*8,self.alpha,0.8)
                else
                    self.alpha = Lerp(FrameTime()*8,self.alpha,1)
                end
                draw.RoundedBox(6,0,0,w,h,Color(categoryColor.r, categoryColor.g, categoryColor.b, 255*self.alpha))
                draw.SimpleText('Купить','M_14',w/2,h/2,Color(255,255,255),1,1)
            end

            local function purchase(ITEM, buy_button)
                IGS.Purchase(ITEM:UID(), function(errMsg,dbID)
                    if not IsValid(buy_button) then return end
                    if errMsg then
                        IGS.ShowNotify(errMsg, "Ошибка покупки")
                        surface.PlaySound("ambient/voices/citizen_beaten1.wav")
                        return
                    end
                    buy_button.purchased = buy_button.purchased or 0
                    buy_button.purchased = buy_button.purchased + 1
                    if ITEM:IsStackable() then
                        buy_button:SetText("Куплено " .. buy_button.purchased .. " шт")
                    else
                        if IsValid(m) then
                            m:Close()
                        end
                        if not IGS.C.Inv_Enabled then
                            IGS.ShowNotify("Спасибо за покупку. Это было просто, правда? :)", "Успешная покупка")
                            return
                        end
                        IGS.BoolRequest("Успешная покупка",
                        "Спасибо за покупку. Она находится в вашем /donate инвентаре.\n\nАктивировать ее сейчас?",
                        function(yes)
                            if not yes then return end
                            IGS.ProcessActivate(dbID)
                        end)
                    end
                    surface.PlaySound("ambient/office/coinslot1.wav")
                end)
            end

            local panelBuy
			buy.DoClick = function()
                if IsValid(panelBuy) then return end
                panelBuy = vgui.Create('Panel',mainFrame)
                panelBuy:SetSize(weight(416)*1.3,height(113)*1.3)
                panelBuy:Center()
                panelBuy.Paint = function(self,w,h)
                    draw.RoundedBox(12,0,0,w,h,Color(255,255,255,20))
                    draw.RoundedBox(12,weight(1),height(1),w-weight(2),h-height(2),backgroundColor)
                    draw.SimpleText('Вы точно хотите приобрести данный товар?','DermaDefaultBold',w/2,height(20)*1.3,Color(255,255,255),1,0)
                end

                local tr = vgui.Create('DButton',panelBuy)
                tr:SetSize(weight(114)*1.3,height(33)*1.3)
                tr:SetPos(weight(199)*1.3,height(60)*1.3)
                tr:SetText('')
                tr.Paint = function(self,w,h)
                    draw.RoundedBox(6,0,0,w,h,Color(71,150,34))
                    draw.SimpleText('Подтвердить','DermaDefault',w/2,h/2,Color(255,255,255),1,1)
                end
                tr.DoClick = function(self)
                    if not istable(v) then return end
                    purchase(v, self)
                    panelBuy:Remove()
                end

                local fal = vgui.Create('DButton',panelBuy)
                fal:SetSize(weight(73)*1.3,height(33)*1.3)
                fal:SetPos(weight(323)*1.3,height(60)*1.3)
                fal:SetText('')
                fal.Paint = function(self,w,h)
                    draw.RoundedBox(6,0,0,w,h,Color(184,51,51))
                    draw.SimpleText('Отмена','DermaDefault',w/2,h/2,Color(255,255,255),1,1)
                end
                fal.DoClick = function()
                    panelBuy:Remove()
                end
            end

            local info = vgui.Create('DButton',items)
            info:SetPos(weight(128)*1.3,height(15)*1.3)
            info:SetSize(weight(24)*1.3,height(24)*1.3)
            info:SetText('')
            info.Paint = function(self,w,h)
                surface.SetMaterial(CreateMaterials('ic_round-info')) 
                surface.SetDrawColor(255,255,255) 
                surface.DrawTexturedRect(0,0,w,h)
            end

            local function descr()
                local desc = vgui.Create('RichText',items)
                desc:SetSize(weight(177)*1.3,height(173)*1.3)
                desc:SetPos(weight(10)*1.3,height(44)*1.3)
                desc:SetText(v.description or '')
                desc.PerformLayout = function()
                    desc:SetFontInternal( "M_14" )
                    desc:SetFGColor( Color( 255, 255, 255 ) )
                end

                local descClose = vgui.Create("DButton",items)
                descClose:SetPos(items:GetWide()-weight(29)*1.3,height(15)*1.3)
                descClose:SetSize(weight(14)*1.3,height(14)*1.3)
                descClose:SetText("")
                descClose.DoClick = function()
                    mpanel:SetVisible(true)
                    main:SetVisible(true)
                    info:SetVisible(true)
                    desc:Remove()
                    descClose:Remove()
                end
                descClose.Paint = function(self, w, h)
                    draw.SimpleText("✕","DermaDefault",w/2,h/2,Color( 255,255,255,200 ),1,1)
                end
            end
            info.DoClick = function(self,w,h)
                mpanel:SetVisible(false)
                main:SetVisible(false)
                info:SetVisible(false)
                descr()
            end
        end
    end
    local case
    local function unbox()
        if IsValid(case) then return end

        case = vgui.Create('Panel',mainFrame)
        BUC2.DonateCasePanel = case
        case:SetSize(weight(1400),height(950))
        case:SetPos(weight(480),height(68))

        local historyHeaders = vgui.Create( "EditablePanel", case)
        historyHeaders:DockMargin( 0,0,0,0)
        historyHeaders:Dock( TOP )
        historyHeaders:SetTall( height(95)*1.3 )
        historyHeaders.Fill = function( self, data )
            self:Clear( )
            for k, v in pairs( data ) do
                local id = ub_findByIGSids( v )
                if not id then continue end
                local t = vgui.Create('DPanel',historyHeaders)
                t:Dock( LEFT )
                t:DockMargin( weight(5)*1.3, 0, 10, 0 )
                t:SetWide( weight(95)*1.3 )
                t.item = BUC2.ITEMS[id]
                t.Paint = function(self,w,h)
                    draw.RoundedBox(10,0,0,w,h,self.item.color)
                    draw.RoundedBox(10,0,0,w,h-height(4)*1.3,secondaryBackgroundColor)
                    draw.SimpleText(self.item.name1,'MM_16',w/2,height(108),Color(255,255,255),1,1)
                    if self.item and self.item.color then
                        draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 50))
                    end
                    if self.item.itemType == "IGS" then
                        surface.SetDrawColor(255,255,255,255)
                        surface.SetMaterial(moneyIcon)
                        surface.DrawTexturedRect(weight(15)*1.3,height(15)*1.3,w/1.5,h/1.5) 
                    end
                end
                if BUC2.ITEMS[id].itemType == "Weapon" then
                    local mdl = vgui.Create('ModelImage', t)
                    mdl:SetSize( weight(55)*1.3, height(55)*1.3 )
                    mdl:SetPos( t:GetWide() / 2 - weight(55)*1.3 / 2, t:GetTall() / 2+weight(10)*1.3 )
                    mdl:SetModel( BUC2.ITEMS[id].model or 'models/Items/item_item_crate.mdl' )
                    mdl:SetTooltip()
                    mdl:SetMouseInputEnabled(false)
                    mdl.DoClick = function() 
                        return
                    end
                end
            end
        end
        historyHeaders:Fill( BUC2.History )

        case._historyHeaders = historyHeaders

        local sc = vgui.Create('DScrollPanel', case)
        sc:Dock(FILL)
        sc:DockMargin(0,height(15)*1.3,0,0)
        sc:GetVBar():SetWide(0)

        local scr = vgui.Create('DIconLayout', sc)
        scr:Dock(TOP)
        scr:SetPos(0, 0)
        scr:SetSpaceX(weight(20)*1.3)
        scr:SetSpaceY(height(20)*1.3)
        for k , v in pairs(BUC2.ITEMS) do
            if v.canBuy then
                local items = vgui.Create('Panel', scr)
                items:SetSize(weight(167)*1.3, height(228)*1.3)
                items.Paint = function(self,w,h)
                    draw.RoundedBox(10, 0, 0, w, h, secondaryBackgroundColor)
                end

                local mpanel = vgui.Create('Panel',items)
                mpanel:SetSize(weight(147)*1.3,height(147)*1.3)
                mpanel:SetPos(weight(10)*1.3,height(10)*1.3)
                local owned = 0
                for _, ubinv_id in pairs(LocalPlayer().ubinv or {}) do
                    if ubinv_id == k then owned = owned + 1 end
                end

                mpanel.Paint = function(self,w,h)
                    draw.RoundedBox(10,0,0,w,h,Color(255,255,255,10))
                    if v.itemType == "Crate" then
                        local customIcon = BUC2.CustomCrateIcons[ v.name1 ]
                        if customIcon then
                            local size = h
                            surface.SetDrawColor( color_white )
                            surface.SetMaterial( customIcon )
                            surface.DrawTexturedRect( w/2 - size/2 - weight(8)*1.3, h/2 - size/2 - height(8)*1.3, size + 15*1.3, size + 15*1.3 )
                        else
                            local size = h
                            surface.SetDrawColor( v.PaintCase and v.color or color_white )
                            surface.SetMaterial( crateMat )
                            surface.DrawTexturedRect( w/2 - size/2*1.3, h/2 - size/2*1.3, size*1.3, size*1.3 )
                        end
                    elseif v.itemType == "Key" then
                        surface.SetDrawColor( v.color )
                        surface.SetMaterial( keyMat )
                        surface.DrawTexturedRect( 0, 0, weight(180)*1.3, height(180)*1.3 )
                    end
                end

                local main = vgui.Create('Panel',items)
                main:SetSize(weight(167)*1.3,height(167)*1.3)
                main:SetPos(0,height(167)*1.3)
                main.Paint = function(self,w,h)
                    draw.SimpleText(v.name1,'M_14',weight(10)*1.3, 0)
                    draw.SimpleText(v.price .. ' P','M_14',weight(10)*1.3,height(28)*1.3,categoryColor)
                    if owned > 0 then
                        draw.SimpleText('В наличии: x' .. owned, 'DermaDefault', weight(10)*1.3, height(50)*1.3, Color(200, 200, 200))
                    end
                end

                local buy = vgui.Create('DButton',main)
                buy:SetSize(weight(60)*1.3,height(29)*1.3)
                buy:SetPos(weight(97)*1.3,height(23)*1.3)
                buy:SetText('')
                buy.Paint = function(self,w,h)
                    draw.RoundedBox(6,0,0,w,h,categoryColor)
                    draw.SimpleText('Купить','M_14',w/2,h/2,Color(255,255,255),1,1)
                end
                buy.DoClick = function(s,w,h)
                    local panelBuy2
                    if IsValid(panelBuy2) then return end
                    panelBuy2 = vgui.Create('Panel',mainFrame)
                    panelBuy2:SetSize(weight(416)*1.3,height(113)*1.3)
                    panelBuy2:Center()
                    panelBuy2.Paint = function(self,w,h)
                        draw.RoundedBox(12,0,0,w,h,Color(255,255,255,20))
                        draw.RoundedBox(12,weight(1),height(1),w-weight(2),h-height(2),backgroundColor)
                        draw.SimpleText('Вы точно хотите приобрести данный товар?','DermaDefault',w/2,height(20)*1.3,Color(255,255,255),1,0)
                    end

                    local tr = vgui.Create('DButton',panelBuy2)
                    tr:SetSize(weight(114)*1.3,height(33)*1.3)
                    tr:SetPos(weight(199)*1.3,height(60)*1.3)
                    tr:SetText('')
                    tr.Paint = function(self,w,h)
                        draw.RoundedBox(6,0,0,w,h,Color(71,150,34))
                        draw.SimpleText('Подтвердить','DermaDefault',w/2,h/2,Color(255,255,255),1,1)
                    end
                    tr.DoClick = function(self)
                        net.Start("ub_purchase")
                            net.WriteString(k)
                            net.WriteInt(1,8)
                        net.SendToServer() 
                        panelBuy2:Remove()
                    end

                    local fal = vgui.Create('DButton',panelBuy2)
                    fal:SetSize(weight(73)*1.3,height(33)*1.3)
                    fal:SetPos(weight(323)*1.3,height(60)*1.3)
                    fal:SetText('')
                    fal.Paint = function(self,w,h)
                        draw.RoundedBox(6,0,0,w,h,Color(184,51,51))
                        draw.SimpleText('Отмена',"DermaDefault",w/2,h/2,Color(255,255,255),1,1)
                    end
                    fal.DoClick = function()
                        panelBuy2:Remove()
                    end
                end
            end
        end
    end

    local upgrad
    local function upgrade()
        if IsValid(upgrad) then return end
        upgrad = vgui.Create('Panel',mainFrame)
        upgrad:SetSize(weight(1400),height(950))
        upgrad:SetPos(weight(480),height(68))
        upgrad.Paint = function(self,w,h)
            surface.SetMaterial(CreateMaterials('Ellipse_4')) 
            surface.SetDrawColor(255,255,255) 
            surface.DrawTexturedRect(weight(75)*1.3,height(20)*1.3,weight(145)*1.3,height(145)*1.3)

            surface.SetMaterial(CreateMaterials('Ellipse_5')) 
            surface.SetDrawColor(255,255,255) 
            surface.DrawTexturedRect(weight(510)*1.3,height(20)*1.3,weight(145)*1.3,height(145)*1.3)
        end
        local page = vgui.CreateFromTable( UpgradePage, upgrad, "Upgrade Panel" )
        page:Dock( FILL )
        page:InvalidateParent( true )
        page:SetTall( upgrad:GetTall( ) )
        upgrad.DoSpin = function(s, b) page:DoSpin( b ) end
        upgrad.GetLeft = function(s) return page:GetLeft( ) end
        BUC2.DonateUpgradePanel = upgrad
    end

    local inv
    local function inventory()
        if IsValid(inv) then return end

        inv = vgui.Create('DScrollPanel',mainFrame)
        BUC2.DonateInvPanel = inv
        inv:SetSize(weight(1400),height(950))
        inv:SetPos(weight(480),height(68))
        inv.VBar:SetWide(0)
        inv.OnFinish = function( self )
            net.Start( "SpinEnded" )
                net.WriteBool( true )
            net.SendToServer( )
            LocalPlayer( ):EmitSound( "buttons/lever6.wav" )
            timer.Simple(2.5,function()
                buttonsLockeds = false
                if IsValid(inv) then inv:Remove() end
                inventory()
            end)
        end
        inv.DoSpin = function( self, tbl )
            if IsValid(temp) then temp:Remove() end
            local caseID = self:GetCaseID( )
            local p = nil
            for i, id in next, tbl do
                local panel = vgui.CreateFromTable( SpinnerPanel, self, "Spinner" )
                panel:Dock( TOP )
                panel:DockMargin( weight(5)*1.3,height(5)*1.3,weight(5)*1.3,height(5)*1.3 )
                panel:SetWide( weight(728)*1.3 )
                panel:SetTall( height(85)*1.3 )
                panel:SetID( caseID )
                panel:DoSpin( id )
                panel:SetZPos( -200 )
                p = panel
            end
            if not IsValid( p ) then buttonsLockeds = false return end
            p.OnFinish = self.OnFinish
        end

        local temp
        local containPanel

        local function initSpinMenus(itemID, check)
            inv:Clear()
            inv.GetCaseID = function() return itemID end

            local opencaseblur = Material( "opencase/opencase.png" )
            opencaseblur:Recompute( )

            temp = vgui.Create( "Panel",inv )
            temp:Dock( TOP )
            temp:SetTall( height(209)*1.3 )
            temp:DockMargin( 0, 0, 0, 0 )
            temp.Paint = function( self, w, h )
                local customIcon = BUC2.CustomCrateIcons[ BUC2.ITEMS[ itemID ].name1 ]
                if customIcon then
                    local size = h
                    surface.SetDrawColor( color_white )
                    surface.SetMaterial( customIcon )
                    surface.DrawTexturedRect( w/2 - size/2 - weight(8)*1.3, h/2 - size/2 - height(8)*1.3, size + 15*1.3, size + 15*1.3 )
                else
                    local size = h
                    surface.SetDrawColor( self.PaintCase and BUC2.ITEMS[ itemID ].color or color_white )
                    surface.SetMaterial( crateMat )
                    surface.DrawTexturedRect( w/2 - size/2*1.3, h/2 - size/2 + 15*1.3, size*1.3, size*1.3 )
                end
            end

            if not check then
                local color = Color( 255, 24, 24 )
                local OpenButton = vgui.Create( "DButton", temp )
                OpenButton:SetPos( weight(1400)/2 + weight(50), height(209)*1.3 - height(37)*1.3 - height(27)*1.3 )
                OpenButton:SetSize( weight(83)*1.3,height(37)*1.3 )
                OpenButton:SetText ""
                OpenButton.Paint = function( self, w, h )
                    draw.RoundedBox( 6, 0, 0, w, h, categoryColor )
                    draw.SimpleText( "Открыть", "DermaDefault", w/2, h/2, Color( 255, 255, 255 ), 1, 1 )
                 end

                local tbl = {
                    1, 2, 3, 5, 10
                }
                local count = table.Count( tbl )

                local Available = 0
                for k,v in pairs( LocalPlayer().ubinv or {} ) do
                    if v == itemID then
                        Available = Available + 1
                        if Available == tbl[ count ] then
                            break
                        end
                    end
                end

                if Available < 10 then
                    tbl = {
                        1, 2, 3, 4, 5
                    }
                end

                for k, v in pairs( tbl ) do
                    if v > Available then
                         tbl[ k ] = nil
                    end
                end
                count = table.Count( tbl )

                local active = 1
                if count > 1 then
                    local panel = vgui.Create( "EditablePanel", temp )
                    panel:SetPos( weight(1400)/2 - weight(80), height(180)*1.3 )
                    panel:SetSize( weight(43)*1.3, height(22)*1.3 )

                    for k, v in next, tbl do
                        local left = vgui.Create('DButton',panel)
                        left:SetSize(weight(14)*1.3,height(14)*1.3)
                        left:SetPos(0,height(5)*1.3)
                        left:SetText('')
                        left.Paint = function(self,w,h)
                            surface.SetMaterial(CreateMaterials('Polygon_2')) 
                            surface.SetDrawColor(255,255,255) 
                            surface.DrawTexturedRect(0,0,w,h)
                        end
                        local right = vgui.Create('DButton',panel)
                        right:SetSize(weight(14)*1.3,height(14)*1.3)
                        right:SetPos(panel:GetWide()-weight(14)*1.3,height(5)*1.3)
                        right:SetText('')
                        right.Paint = function(self,w,h)
                            surface.SetMaterial(CreateMaterials('Polygon_1')) 
                            surface.SetDrawColor(255,255,255) 
                            surface.DrawTexturedRect(0,0,w,h)
                        end

                        local function UpdateActive()
                            if active > count then
                                active = 1
                            elseif active < 1 then
                                active = count
                            end
                        end

                        left.DoClick = function()
                            active = active - 1
                            UpdateActive()
                        end

                        right.DoClick = function()
                            active = active + 1
                            UpdateActive()
                        end
                        panel.Paint = function(s,w,h)
                            draw.SimpleText(active and active or '1','DermaDefault',w/2,h/2,Color(255,255,255),1,1)
                        end
                    end
                end

                OpenButton.requestSent = nil
                OpenButton.DoClick = function( self, w, h )
                    if Available < active then return end
                    if not self.requestSent then
                        self.requestSent = true
                        buttonsLockeds = true
                        net.Start("BeginSpin")
                            net.WriteString( itemID )
                            net.WriteUInt( active, 4 )
                        net.SendToServer( )
                    end 
                end
            end

            containPanel = vgui.Create("EditablePanel", inv)
            containPanel:Dock( TOP )
            containPanel:DockMargin( 0, 10*1.3, 0, 0 )

            if BUC2.ITEMS[itemID] ~= nil then
                if BUC2.ITEMS[itemID].items ~= nil and table.Count(BUC2.ITEMS[itemID].items) > 0 then
                    local xPos = 0
                    local yPos = 0 
                    for k, v in pairs(BUC2.ITEMS[itemID].items) do
                        local testPan = vgui.CreateFromTable( ModelPanel, containPanel )
                        testPan:SetPos(xPos,yPos)
                        testPan:SetSize(weight(95)*1.3 , height(95)*1.3)
                        testPan:Set( v )
                        xPos = xPos + weight(100)*1.3
                        if xPos > inv:GetWide() - weight(120) then
                            xPos = 0
                            yPos = yPos + height(100)*1.3
                        end
                    end
                    containPanel:SetTall( yPos + height(100)*1.3 )
                end
            end
        end

        local function createModelModules(k , v , x ,y)
            local over = vgui.Create("Panel" , inv)
            over:SetPos(x,y)
            over:SetSize(weight(167)*1.3, height(233)*1.3)
            over.itemID = k
            over.Paint = function(s , w , h)
                draw.RoundedBox(10,0,0,w,h,secondaryBackgroundColor)
                draw.RoundedBox(10,weight(10)*1.3,height(10)*1.3,weight(147)*1.3,height(147)*1.3,Color(255,255,255,10))
                draw.SimpleText(v.name1,'M_14',weight(10)*1.3,height(167)*1.3)
            end

            local mod = vgui.Create("DModelPanel" , over)
            mod:SetPos(weight(25),0)
            mod:SetSize(weight(180)*1.3,height(180)*1.3)
            mod:SetModel(v.model)
            mod:SetAnimated(false)
            mod.ang = mod.Entity:GetAngles()
            function mod:LayoutEntity(Entity)
                if ( self.bAnimated ) then
                    self:RunAnimation()
                end
            end
            FixCam( mod )
            local open = vgui.Create('DButton',over)
            open:SetPos(weight(10)*1.3,height(194)*1.3)
            open:SetSize(weight(72)*1.3,height(29)*1.3)
            open:SetText('')
            open.alpha = 0
            open.Paint = function(self,w,h)
                if self:IsHovered() then
                    self.alpha = Lerp(FrameTime()*8,self.alpha,0.8)
                else
                    self.alpha = Lerp(FrameTime()*8,self.alpha,1)
                end
                draw.RoundedBox(6,0,0,w,h,Color(categoryColor.r, categoryColor.g, categoryColor.b, 255*self.alpha))
                draw.SimpleText('Забрать','M_14',w/2,h/2,Color(255,255,255),1,1)
            end
            open.DoClick = function(s) 
                net.Start("ub_equipweapon")
                net.WriteString(v.name1)
                net.SendToServer()
                UrefreshInv()
            end
            return over
        end

        local function createPngModules(k , v , x ,y)
            local over = vgui.Create("Panel" , inv)
            over:SetPos(x,y)
            over:SetSize(weight(167)*1.3, height(233)*1.3)
            over.itemID = k
            over.Paint = function(s , w , h)
                draw.RoundedBox(10,0,0,w,h,secondaryBackgroundColor)
                draw.RoundedBox(10,weight(10)*1.3,height(10)*1.3,weight(147)*1.3,height(147)*1.3,Color(255,255,255,10))
                draw.SimpleText(v.name1,'M_14',weight(10)*1.3,height(167)*1.3)
            end

            local cratePanelTemp = vgui.CreateFromTable( CratePanel, over, "CratePanel" )
            cratePanelTemp:SetSize( weight(200)*1.3, height(200)*1.3 )
            cratePanelTemp:SetPos(weight(-17)*1.3,height(-22)*1.3)
            cratePanelTemp:Set( v )

            local open = vgui.Create('DButton',over)
            open:SetPos(weight(10)*1.3,height(194)*1.3)
            open:SetSize(weight(72)*1.3,height(29)*1.3)
            open:SetText('')
            open.alpha = 0
            open.Paint = function(self,w,h)
                if self:IsHovered() then
                    self.alpha = Lerp(FrameTime()*8,self.alpha,0.8)
                else
                    self.alpha = Lerp(FrameTime()*8,self.alpha,1)
                end
                draw.RoundedBox(6,0,0,w,h,Color(categoryColor.r, categoryColor.g, categoryColor.b, 255*self.alpha))
                draw.SimpleText('Открыть','M_14',w/2,h/2,Color(255,255,255),1,1)
            end
            open.DoClick = function(s) 
                initSpinMenus(v.name1) 
            end
            return over
        end

        function UrefreshInv()
            if LocalPlayer().ubinv ~= nil and table.Count(LocalPlayer().ubinv) > 0 then
                local xPos = 0
                local yPos = 0

                local grouped = {}
                for k, v in pairs(LocalPlayer().ubinv) do
                    if v ~= nil and BUC2.ITEMS[v] ~= nil then
                        if not grouped[v] then
                            grouped[v] = { count = 1, first_k = k }
                        else
                            grouped[v].count = grouped[v].count + 1
                        end
                    end
                end

                for item_id, data in pairs(grouped) do
                    local id = item_id
                    local k = data.first_k
                    local v = BUC2.ITEMS[id]
                    local pan = nil

                    if v.itemType == "Key" or v.itemType == "Crate" then
                        pan = createPngModules(k , v , xPos , yPos) 
                    else
                        pan = createModelModules(k , v , xPos , yPos)
                    end

                    if data.count > 1 then
                        local countLbl = vgui.Create("DLabel", pan)
                        countLbl:SetPos(weight(10)*1.3, height(145)*1.3)
                        countLbl:SetSize(weight(147)*1.3, height(20)*1.3)
                        countLbl:SetFont("DermaDefaultBold")
                        countLbl:SetTextColor(Color(200, 255, 200))
                        countLbl:SetText("x" .. data.count .. " шт.")
                    end

                    pan.itemID = id
                    xPos = xPos + weight(187)*1.3
                    if xPos > weight(1200) then
                        xPos = 0
                        yPos = yPos + height(253)*1.3
                    end
                end

                if IsValid(inv) and inv.GetCanvas then
                    timer.Simple(0, function() 
                        if IsValid(inv) then inv:GetCanvas():SetTall(math.max(inv:GetTall(), yPos + height(260)*1.3)) end 
                    end)
                end
            end
        end
        UrefreshInv()
    end

    local dashboardPanel

    local function drawDashboard()
        if IsValid(cat) then cat:Remove() end
        if IsValid(dashboardPanel) then dashboardPanel:Remove() end
        dashboardPanel = vgui.Create('Panel', mainFrame)
        dashboardPanel:SetSize(weight(1400), height(950))
        dashboardPanel:SetPos(weight(480), height(68))

        dashboardPanel.Paint = function(s, w, h) end

        local function CreateBanner(parent, x, y, w, h, matPath, fallbackText, fallbackColor)
            local btn = vgui.Create("Panel", parent)
            btn:SetPos(weight(x), height(y))
            btn:SetSize(weight(w), height(h))
            local mat = Material(matPath, "smooth")

            btn.Paint = function(self, bw, bh)
                if not mat:IsError() then
                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.SetMaterial(mat)
                    surface.DrawTexturedRect(0, 0, bw, bh)
                else
                    draw.RoundedBox(16, 0, 0, bw, bh, fallbackColor)
                    if fallbackText == "Ежедневный кейс" then
                        draw.SimpleText("ЕЖЕДНЕВНЫЙ", "DermaLarge", bw/2, bh/2 - height(40), Color(255, 255, 255), 1, 1)
                        draw.RoundedBox(8, bw/2 - weight(226), bh/2 + height(10), weight(453), height(80), Color(255, 200, 0))
                        draw.SimpleText("КЕЙС ARIZONA", "DermaLarge", bw/2, bh/2 + height(50), Color(0, 0, 0), 1, 1)
                    elseif fallbackText == "X3" then
                        draw.SimpleText("К ЗАРАБОТКУ", "DermaLarge", bw/2, height(60), Color(0, 0, 0), 1, 1)
                        draw.SimpleText("X3", "DermaLarge", bw/2, height(140), Color(255, 255, 255), 1, 1)
                        draw.RoundedBox(8, bw/2 - weight(154), height(200), weight(308), height(68), Color(255, 255, 255))
                        draw.SimpleText("НА ВСЁМ", "DermaLarge", bw/2, height(234), Color(0, 0, 0), 1, 1)
                    elseif fallbackText == "+1000 AZ" then
                        draw.SimpleText("ПОЛУЧАЙ", "DermaLarge", bw/2, height(60), Color(0, 0, 0), 1, 1)
                        draw.RoundedBox(8, bw/2 - weight(143), height(110), weight(286), height(66), Color(255, 255, 255))
                        draw.SimpleText("+1000 AZ", "DermaLarge", bw/2, height(143), Color(248, 193, 100), 1, 1)
                        draw.SimpleText("каждый час", "DermaLarge", bw/2, height(200), Color(0, 0, 0), 1, 1)
                        draw.RoundedBoxEx(16, 0, bh - height(110), bw, height(110), Color(255, 200, 0), false, false, true, true)
                        draw.SimpleText("КУПИТЬ от 99RUB", "DermaLarge", bw/2, bh - height(55), Color(0, 0, 0), 1, 1)
                    elseif fallbackText == "Особый префикс" then
                        draw.RoundedBoxEx(16, bw - weight(400), 0, weight(400), bh, Color(0, 0, 0, 80), false, true, false, true)
                        draw.SimpleText("Особый префикс", "DermaLarge", weight(40), bh/2, Color(255, 255, 255), 0, 1)
                    end
                end
            end
            return btn
        end

        CreateBanner(dashboardPanel, 8, 0, 858, 294, "f6donate/bannerazevery.png", "Ежедневный кейс", Color(58,58,58))
        CreateBanner(dashboardPanel, 8, 314, 849, 318, "f6donate/sansq.png", "Особый префикс", Color(45,39,124))
        CreateBanner(dashboardPanel, 886, 0, 494, 328, "f6donate/x3ak.png", "X3", Color(116, 239, 117))
        CreateBanner(dashboardPanel, 886, 348, 494, 404, "f6donate/1000az.png", "+1000 AZ", Color(248, 193, 100))
    end

        local selected = 1
    local function handleCategoryClick(id, actFn)
        if buttonsLockeds then return end
        if IsValid(case) then case:Remove() end
        if IsValid(upgrad) then upgrad:Remove() end
        if IsValid(promoPanel) then promoPanel:Remove() end
        if IsValid(inv) then inv:Remove() end
        if IsValid(Profile) then Profile:Remove() end
        if IsValid(profileInv) then profileInv:Remove() end
        if IsValid(cat) then cat:Remove() end
        if IsValid(dashboardPanel) then dashboardPanel:Remove() end

        selected = id
        actFn()
    end

    local category = {
        { name = 'ARIZONA +', icon = 'f6donate/azplus.png', action = function() drawDashboard() end },
        { name = 'ВАЛЮТА', icon = 'f6donate/rocket.png', action = function() drawCategory('Деньги') end },
        { name = 'БОЕВОЙ ПРОПУСК', icon = 'f6donate/granata.png', action = function() drawCategory('Premium Pass') end },
        { name = 'КЕЙСЫ', icon = 'f6donate/box.png', action = function() unbox() end },
        { name = 'ДЛЯ СТАРТА', icon = 'f6donate/upgrade.png', action = function() drawCategory('Наборы') end },
        { name = 'АПГРЕЙДЫ', icon = 'f6donate/upgrade.png', action = function() drawCategory('Привилегии') end },
        { name = 'СПИНЫ', icon = 'f6donate/spin.png', action = function() drawCategory('Спины') end },
        { name = 'ПРОФЕССИИ', icon = 'f6donate/tickeyt.png', action = function() drawCategory('Профессии') end },
        { name = 'ОРУЖИЕ', icon = 'f6donate/tickeyt.png', action = function() drawCategory('Оружие') end },
        { name = 'ИНВЕНТАРЬ', icon = 'f6donate/box.png', action = function() inventory() end },
        { name = 'ПРОФИЛЬ', icon = 'f6donate/box.png', action = function() openProfile() end }
    }

    handleCategoryClick(1, category[1].action)

    local scrollTabs = vgui.Create('DScrollPanel', butList)
    scrollTabs:SetSize(weight(350), ScrH() - height(250))
    scrollTabs:SetPos(0, 0)
    scrollTabs:GetVBar():SetWide(0)

    local space = 0
    for k, v in ipairs(category) do
        local but = vgui.Create('DButton', scrollTabs)
        but:SetPos(0, space)
        but:SetSize(weight(320), height(60)) 
        but:SetText('')
        but.alpha = 0
        but.Paint = function(self, w, h)
            local targetAlpha = self:IsHovered() and 1 or 0
            if selected == k then targetAlpha = 1 end
            self.alpha = Lerp(FrameTime() * 8, self.alpha, targetAlpha)

            local clr = selected == k and Color(150, 150, 150, 200) or Color(50, 50, 50, 150)
            draw.RoundedBox(10, 0, 0, w, h, clr)

            local textOffset = weight(30)
            if v.icon then
                local mat = Material(v.icon, "smooth")
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(mat)
                local iconSize = height(34)
                surface.DrawTexturedRect(weight(20), h/2 - iconSize/2, iconSize, iconSize)
                textOffset = weight(20) + iconSize + weight(15)
            end

            draw.SimpleText(v.name, 'DermaLarge', textOffset, h/2, Color(255, 255, 255), 0, 1)
        end
        but.DoClick = function() handleCategoryClick(k, v.action) end
        space = space + height(70) 
    end
end

local function closeMenu()
    if IsValid(frame) then
        frame:AlphaTo(0,0.3,0,function()
            buttonsLockeds = false
            isOpen = false
            donateVGUI = nil
            BUC2.DonateInvPanel = nil
            BUC2.DonateUpgradePanel = nil
            BUC2.DonateCasePanel = nil
            frame:Remove()
        end)
    end
end

local function openMenu()
    OpenDonateUI()
end

hook.Add("Think", "DonateKEYReplace", function()
    if (not IGS or not IGS.UI) then return end

    IGS.ShowUI = openMenu
    IGS.HideUI = closeMenu
    IGS.CloseUI = closeMenu
    IGS.GetUI = function() return donateVGUI end
    IGS.UI = function() 
        if(not IsValid(donateVGUI))then 
            net.Start('donOpen')
            net.SendToServer()
            OpenDonateUI() 
        end 
    end

    hook.Remove("Think", "DonateKEYReplace")
end)