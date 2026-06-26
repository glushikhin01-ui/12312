local function s(y)
    local scrW, scrH = ScrW(), ScrH()
    return math.Round(y * math.min(scrW, scrH) / 1080)
end

local function AddIcon(mat, x, y, w, h, c)
    surface.SetDrawColor(c)
    surface.SetMaterial(mat)
    surface.DrawTexturedRect(x, y, w, h)
end

local function NewClose(pnl) if IsValid(pnl) then pnl:Remove() end end

function width(x) return s(x * 1920 / 1080) end
function height(y) return s(y) end

function GetJobModel(index)
    local job = rp.teams[index]
    if isstring(job.model) then return job.model end
    local idx = cvar.GetValue('TeamModel' .. job.name)
    if isnumber(idx) and util.IsValidModel(job.model[idx]) then return job.model[idx] end
    return job.model[1]
end

function SetJobModel(index, modelIndex)
    local job = rp.teams[index]
    cvar.SetValue('TeamModel' .. job.name, modelIndex)
end

local C = {
    white      = Color(255,255,255),
    bg         = Color(42,43,46),
    bg_a       = Color(28,29,32,245),
    sidebar    = Color(33,34,37),
    card       = Color(159,159,159,46),
    card_h     = Color(159,159,159,80),
    card_s     = Color(159,159,159,120),
    inner      = Color(255,255,255,18),
    gray       = Color(150,150,150),
    gray_t     = Color(175,175,175),
    gray_l     = Color(210,210,210),
    green      = Color(60,210,95),
    blue       = Color(218,62,68),
    btn        = Color(217,217,217,46),
    discord    = Color(88,101,242,255),
    telegram   = Color(38,165,228,255),
    donate     = Color(214,158,18,255),
    donate_t   = Color(255,210,60),
    gold       = Color(255,191,0,46),
    gold_t     = Color(255,200,40),
    silver     = Color(200,200,200,46),
    silver_t   = Color(225,225,225),
    bronze     = Color(204,110,40,46),
    bronze_t   = Color(224,140,70),
    rules      = Color(22,22,22),
    red        = Color(218,62,68),
    black      = Color(0,0,0),
}

local mats = {
    home     = Material('f4menu/128.png','smooth mips'),
    shop     = Material('f4/items.png','smooth mips'),
    jobs     = Material('f4/jobs.png','smooth mips'),
    cards    = Material('f4/cards.png','smooth mips'),
    wardrobe = Material('f4/wardrobe.png','smooth mips'),
    settings = Material('f4/settings.png','smooth mips'),
    deposit  = Material('f4/plus.png','smooth mips'),
    dmoney   = Material('f4/az.png','smooth mips'),
    lvl1     = Material('lvlsys/1lvl.png','smooth mips'),
    lvl2     = Material('lvlsys/2lvl.png','smooth mips'),
    lvl3     = Material('lvlsys/3lvl.png','smooth mips'),
    lvl4     = Material('lvlsys/4lvl.png','smooth mips'),
}

local rankNames = {
    ["*"]              = "Владелец",
    ["co*"]            = "Со-Владелец",
    ["uprav"]          = "Управляющий",
    ["zamuprav"]       = "Зам.Управляющего",
    ["arizona-team"]   = "Команда Проекта",
    ["project-team"]   = "Д-Команда",
    ["manager"]        = "Менеджер",
    ["vice-manager"]   = "Вице-Менеджер",
    ["head-curator"]   = "Главный Куратор",
    ["curator"]        = "Куратор",
    ["head-admin"]     = "Главный Админ",
    ["admin"]          = "Админ",
    ["moderator"]      = "Модератор",
    ["helper"]         = "Хелпер",
    ["intern"]         = "Стажёр",
    ["owner"]          = "Овнер",
    ["superadmin"]     = "Супер-Админ",
    ["dadmin"]         = "Д.Админ",
    ["dmoderator"]     = "Д.Модератор",
    ["vip"]            = "вип",
    ["user"]           = "игрок",
}

local staffRanks = {
    ["*"]              = true,
    ["co*"]            = true,
    ["uprav"]          = true,
    ["zamuprav"]       = true,
    ["arizona-team"]   = true,
    ["project-team"]   = true,
    ["manager"]        = true,
    ["vice-manager"]   = true,
    ["head-curator"]   = true,
    ["curator"]        = true,
    ["head-admin"]     = true,
    ["admin"]          = true,
    ["moderator"]      = true,
    ["helper"]         = true,
    ["intern"]         = true,
}

local function LocalizeRank(g)
    g = tostring(g or 'user')
    return rankNames[g] or rankNames[string.lower(g)] or g
end

local function IsStaff(g)
    g = tostring(g or '')
    return staffRanks[g] or staffRanks[string.lower(g)] or false
end

local categoriess = {
    ['Гражданские']=true,['Разное']=true,['Поликлиника']=true,
    ['Военные']=true,['ФСИН']=true,['Криминал']=true,
    ['Правительство']=true,['Полиция']=true,['Личные профессии']=true,
    ['Гос структуры']=true,['SWAT']=true,
}

local catSettings = {
    ['ГЛАВНОЕ']={'f4_set',{'Other','Другое','Третье лицо','Худ'}},
    ['ЗВУКИ']={'f4_set','Медиа Плеер'},
    ['ИГРОВОЙ ЧАТ']={'f4_set','Чат'},
    ['БИНД КЛАВИШ']={'f4_bind','bind'},
    ['ПРИЦЕЛ']={'f4_crosshair','crosshair'},
    ['ЦВЕТА']={'f4_colors','colors'},
}

local ordSettings = {'ГЛАВНОЕ','ЗВУКИ','ИГРОВОЙ ЧАТ','БИНД КЛАВИШ','ПРИЦЕЛ','ЦВЕТА'}

local bannedNames = {['забаненный']=true,['забанен']=true,['banned']=true}
local hiddenJobs = {['Курьер']=true,['Грузчик']=true}

local purchases = {
    ['Бульдозер']={uid='bulldozer_job'},['Агент Эльза']={uid='elza_job'},
    ['Muffler']={uid='muffler_job'},['Агент Хаку']={uid='haku_job'},
    ['Roxy']={uid='roxy_job'},['Сёгун']={uid='segun_job'},
    ['Хранитель']={uid='hranitel_job'},['Тоби']={uid='tobi_job'},
    ['Тень']={uid='shadow_job'},['SOPMOD']={uid='sopmod_job'},
    ['Берсерк']={uid='berserk_job'},['Toji Zenin']={uid='toji_job'},
    ['Ryomen Sukuna']={uid='sukuna_job'},['Сатору Годжо']={uid='satoru_job'},
    ['Аколит']={uid='mag_akolit'},['Колдун']={uid='mag_koldun'},
    ['Чародей']={uid='mag_charodei'},['Чернокнижник']={uid='mag_chernoknizhnik'},
    ['Архимаг']={uid='mag_archimag'},['Фурина']={uid='furina_job'},
    ['Мото мото']={uid='motomoto_job'},
}

local purchaseOverrides = {}

net.Receive('f4_purchase_update', function()
    purchaseOverrides[net.ReadString()] = net.ReadBool()
end)

local function hasPurchase(ply, uid)
    if purchaseOverrides[uid] ~= nil then return purchaseOverrides[uid] end
    if not ply.HasPurchase then return false end
    return ply:HasPurchase(uid)
end

local function isJobBanned(job)
    if not job or not job.name then return true end
    local low = string.lower(job.name)
    for b in pairs(bannedNames) do if string.find(low,b) then return true end end
    return false
end

local function isJobHidden(job, ply)
    if not job or not job.name then return true end
    if hiddenJobs[job.name] then return true end
    if job.name == 'Администратор' and not ply:IsAdmin() then return true end
    if purchases[job.name] and not hasPurchase(ply, purchases[job.name].uid) then return true end
    return false
end

local fr

local function makeScroll(scrl)
    scrl.Paint = nil
    local bar = scrl.VBar
    bar:SetWide(s(6))
    bar:SetHideButtons(true)
    bar.Paint = function(_,w,h) draw.RoundedBox(8,w*0.4,0,w*0.2,h,Color(255,255,255,15)) end
    bar.btnGrip.Paint = function(_,w,h) draw.RoundedBox(8,0,0,w,h,C.card_s) end
end

local gradMat = Material('gui/gradient_up')
local function drawGrad(x,y,w,h)
    surface.SetDrawColor(218,62,68,26)
    surface.SetMaterial(gradMat)
    surface.DrawTexturedRect(x,y,w,h)
end

local function Card(parent)
    local p = parent:Add('Panel')
    p.Paint = function(_,w,h) draw.RoundedBox(s(12),0,0,w,h,C.card) end
    return p
end

local navBtns = {}
local function setActiveNav(idx)
    for i=1,#navBtns do if navBtns[i] then navBtns[i]._active=(i==idx) end end
end

local contentPanel
local function clearContent()
    if IsValid(contentPanel) then contentPanel:Remove() end
end

local function newContent(parent)
    clearContent()
    contentPanel = parent:Add('Panel')
    contentPanel:Dock(FILL)
    contentPanel:DockMargin(s(24),s(24),s(24),s(24))
    contentPanel.Paint = function() end
    return contentPanel
end

local function BuildMain(parent, p)
    local c = newContent(parent)
    local GAP = s(14)

    local leftCol = c:Add('Panel')
    leftCol:Dock(LEFT)
    leftCol:DockMargin(0,0,GAP,0)
    leftCol.Paint = function() end

    local rightCol = c:Add('Panel')
    rightCol:Dock(FILL)
    rightCol.Paint = function() end

    c.PerformLayout = function(self,w,h)
        leftCol:SetWide(math.floor((w - GAP) * 0.46))
    end

    local infoCard = Card(leftCol)
    infoCard:Dock(TOP)
    infoCard:SetTall(s(96))
    infoCard:DockPadding(s(16),s(14),s(16),s(14))

    local av = infoCard:Add('sinc.Avatar')
    av:Dock(LEFT)
    av:DockMargin(0,s(18),s(14),0)
    av:SetWide(s(50))
    av:SetPlayer(p,128)

    local infoTxt = infoCard:Add('Panel')
    infoTxt:Dock(FILL)
    infoTxt.Paint = function(_,w,h)
        draw.SimpleText('Информация об игроке','BKfont.13',0,s(2),C.gray_t,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
        draw.SimpleText(p:Name(),'MKfont.18',0,s(30),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
        local jn = ''
        if p.GetJobName then jn=p:GetJobName()
        elseif rp.teams[p:Team()] then jn=rp.teams[p:Team()].name or '' end
        draw.SimpleText(jn,'BKfont.14',0,s(54),C.gray_t,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
        local ug = p.GetUserGroup and p:GetUserGroup() or 'user'
        if rankNames[ug] or rankNames[string.lower(tostring(ug))] then
            local rank = LocalizeRank(ug)
            surface.SetFont('MKfont.18')
            local tw2 = surface.GetTextSize(p:Name())
            surface.SetFont('MKfont.11')
            local rw = surface.GetTextSize(rank)
            local bx = tw2 + s(10)
            draw.RoundedBox(s(5),bx,s(30),rw+s(16),s(20),C.card_s)
            draw.SimpleText(rank,'MKfont.11',bx+(rw+s(16))/2,s(40),C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    end

    local rCard = Card(leftCol)
    rCard:Dock(BOTTOM)
    rCard:SetTall(s(118))
    rCard:DockPadding(s(16),s(14),s(16),s(14))

    local rHead = rCard:Add('Panel')
    rHead:Dock(TOP)
    rHead:SetTall(s(30))
    rHead.Paint = function(_,w,h)
        draw.RoundedBox(s(7),0,0,s(30),s(30),C.red)
        draw.SimpleText('!','MKfont.18',s(15),s(14),C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText('Подача жалобы','MKfont.16',s(40),s(15),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local rBtn = rCard:Add('DButton')
    rBtn:Dock(BOTTOM)
    rBtn:SetTall(s(38))
    rBtn:SetText('')
    rBtn.Paint = function(self,w,h)
        draw.RoundedBox(s(8),0,0,w,h,self:IsHovered() and C.card_s or C.btn)
        draw.SimpleText('Подать жалобу','MKfont.15',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    rBtn.DoClick = function() LocalPlayer():ConCommand('say /report Жалоба (F4)'); NewClose(fr) end

    local wCard = Card(leftCol)
    wCard:Dock(FILL)
    wCard:DockMargin(0,GAP,0,GAP)
    wCard:DockPadding(s(16),s(16),s(16),s(16))

    local wHead = wCard:Add('Panel')
    wHead:Dock(TOP)
    wHead:SetTall(s(34))
    wHead.Paint = function(_,w,h)
        draw.RoundedBox(s(7),0,0,s(34),s(34),C.inner)
        draw.SimpleText('$','MKfont.18',s(17),s(17),C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText('Ваше состояние','MKfont.18',s(44),s(17),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local rowMoney = wCard:Add('Panel')
    rowMoney:Dock(TOP)
    rowMoney:DockMargin(0,s(16),0,0)
    rowMoney:SetTall(s(50))
    rowMoney.Paint = function(_,w,h)
        draw.SimpleText('Всего у вас денег','BKfont.13',0,0,C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
        draw.SimpleText(p.GetMoney and rp.FormatMoney(p:GetMoney()) or '$0','MKfont.20',0,s(22),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
    end

    local rowLvl = wCard:Add('Panel')
    rowLvl:Dock(TOP)
    rowLvl:DockMargin(0,s(14),0,0)
    rowLvl:SetTall(s(62))
    rowLvl.Paint = function(_,w,h)
        draw.SimpleText('Ваш уровень прокачки','BKfont.13',0,0,C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
        local lvl = (p.GetNWInt and p:GetNWInt('level',0)) or 0
        local lvlMat
        if lvl >= 30 then lvlMat = mats.lvl4
        elseif lvl >= 20 then lvlMat = mats.lvl3
        elseif lvl >= 10 then lvlMat = mats.lvl2
        else lvlMat = mats.lvl1 end
        AddIcon(lvlMat,0,s(18),s(52),s(44),color_white)
        draw.SimpleText(tostring(lvl),'MKfont.18',s(26),s(38),C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end

    local rowAZ = wCard:Add('Panel')
    rowAZ:Dock(TOP)
    rowAZ:DockMargin(0,s(14),0,0)
    rowAZ:SetTall(s(62))
    rowAZ.Paint = function(_,w,h)
        draw.SimpleText('Ваше кол-во AZ коинов','BKfont.13',0,0,C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
        AddIcon(mats.dmoney,0,s(22),s(36),s(36),color_white)

        local az = 0
        if p.IGSFunds then az = math.Round(p:IGSFunds() or 0) end
        draw.SimpleText(tostring(az),'MKfont.18',s(44),s(41),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local aCard = Card(rightCol)
    aCard:Dock(TOP)
    aCard:SetTall(s(280))
    aCard:DockPadding(s(16),s(16),s(16),s(16))

    local aHead = aCard:Add('Panel')
    aHead:Dock(TOP)
    aHead:SetTall(s(30))
    local aCnt = 0

    local aScrl = aCard:Add('DScrollPanel')
    aScrl:Dock(FILL)
    aScrl:DockMargin(0,s(12),0,0)
    makeScroll(aScrl)

    for _,pl in ipairs(player.GetAll()) do
        if IsStaff(pl:GetUserGroup()) then
            aCnt = aCnt + 1
            local ap = aScrl:Add('Panel')
            ap:Dock(TOP)
            ap:SetTall(s(40))
            ap:DockMargin(0,0,s(4),s(6))
            ap:DockPadding(s(8),s(7),s(12),s(7))
            ap.Paint = function(_,w,h) draw.RoundedBox(s(7),0,0,w,h,C.card) end

            local aa = ap:Add('sinc.Avatar')
            aa:Dock(LEFT)
            aa:DockMargin(0,0,s(10),0)
            aa:SetWide(s(26))
            aa:SetPlayer(pl,64)

            local nl = ap:Add('DLabel')
            nl:Dock(FILL)
            nl:SetFont('MKfont.15')
            nl:SetTextColor(C.white)
            nl:SetText(pl:Name())
            nl:SetContentAlignment(4)

            local rl = ap:Add('DLabel')
            rl:Dock(RIGHT)
            rl:SetFont('MKfont.14')
            rl:SetTextColor(C.gray_l)
            rl:SetText(LocalizeRank(pl:GetUserGroup() or 'admin'))
            rl:SetContentAlignment(6)
            rl:SizeToContentsX()
        end
    end

    aHead.Paint = function(_,w,h)
        AddIcon(mats.settings,0,h/2-s(13),s(26),s(26),C.white)
        draw.SimpleText('Администрация онлайн','MKfont.18',s(36),h/2,C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(aCnt..' чел.','MKfont.15',w,h/2,C.gray_l,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
    end

    local clCard = Card(rightCol)
    clCard:Dock(FILL)
    clCard:DockMargin(0,GAP,0,0)
    clCard:DockPadding(s(16),s(16),s(16),s(16))

    local clHead = clCard:Add('Panel')
    clHead:Dock(TOP)
    clHead:SetTall(s(30))
    clHead.Paint = function(_,w,h)
        AddIcon(mats.jobs,0,h/2-s(13),s(26),s(26),C.white)
        draw.SimpleText('Банды','MKfont.18',s(36),h/2,C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local clBody = clCard:Add('Panel')
    clBody:Dock(FILL)
    clBody:DockMargin(0,s(12),0,0)
    clBody.Paint = function(_,w,h)
        draw.RoundedBox(s(10),0,0,w,h,C.card)
        local top = (_G.F4GangState and _G.F4GangState.top) or {}
        if #top == 0 then
            draw.SimpleText('Банд ещё нет','MKfont.20',w/2,h/2-s(12),C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText('Информация появится позже','MKfont.15',w/2,h/2+s(18),C.gray_l,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            return
        end
        for i=1,math.min(5,#top) do
            local g = top[i]
            local cy = (i - 1) * s(38)
            draw.RoundedBox(s(7),0,cy,w,s(32),Color(20,20,22,135))
            draw.SimpleText('#' .. i,'MKfont.15',s(12),cy+s(16),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(g.name or '—','MKfont.15',s(48),cy+s(16),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(string.Comma(tonumber(g.reputation or 0) or 0) .. ' REP','MKfont.14',w-s(12),cy+s(16),C.green,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        end
    end
end

function BuildSettings(parent, p)
    local c = newContent(parent)

    local catPanel = c:Add('Panel')
    catPanel:Dock(LEFT)
    catPanel:SetWide(s(280))
    catPanel:DockMargin(0,0,s(14),0)
    catPanel.Paint = function(_,w,h) draw.RoundedBox(s(12),0,0,w,h,C.card) end
    catPanel:DockPadding(s(12),s(12),s(12),s(12))

    local catTitle = catPanel:Add('Panel')
    catTitle:Dock(TOP)
    catTitle:SetTall(s(40))
    catTitle:DockMargin(0,0,0,s(10))
    catTitle.Paint = function(_,w,h)
        draw.SimpleText('ВЫБОР КАТЕГОРИИ','MKfont.16',s(4),h/2,C.gray_t,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local selCat = ordSettings[1]
    local detailPanel

    local function showCat(cat, catdata)
        if IsValid(detailPanel) then detailPanel:Remove() end
        detailPanel = c:Add('Panel')
        detailPanel:Dock(FILL)
        detailPanel.Paint = function(_,w,h) draw.RoundedBox(s(12),0,0,w,h,C.card) end
        detailPanel:DockPadding(s(14),s(14),s(14),s(14))

        local dt = detailPanel:Add('Panel')
        dt:Dock(TOP)
        dt:SetTall(s(40))
        dt:DockMargin(0,0,0,s(8))
        dt.Paint = function(_,w,h)
            draw.SimpleText(cat,'MKfont.20',s(2),h/2,C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end

        local ds = detailPanel:Add('DScrollPanel')
        ds:Dock(FILL)
        makeScroll(ds)

        local pnl = ds:Add(catdata[1])
        if not IsValid(pnl) then return end
        pnl:Dock(TOP)
        pnl:SetTall(s(600))
        if cat ~= 'БИНД КЛАВИШ' and cat ~= 'ПРИЦЕЛ' and cat ~= 'ЦВЕТА' then
            pnl:SetSetting(catdata[2])
        end
        pnl:DockMargin(0,s(4),0,0)
    end

    for _,catname in ipairs(ordSettings) do
        local btn = catPanel:Add('DButton')
        btn:Dock(TOP)
        btn:DockMargin(0,0,0,s(6))
        btn:SetTall(s(44))
        btn:SetText('')
        btn.Paint = function(self,w,h)
            local bg, tc = C.btn, C.white
            if self:IsHovered() then bg=C.card_h
            elseif selCat==catname then bg=C.card_s end
            draw.RoundedBox(s(8),0,0,w,h,bg)
            draw.SimpleText(catname,'MKfont.15',s(14),h/2,tc,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        btn.DoClick = function()
            selCat = catname
            showCat(catname, catSettings[catname])
        end
    end

    showCat('ГЛАВНОЕ', catSettings['ГЛАВНОЕ'])
end

local gangState = nil
local gangPanel = nil
local gangLoading = false
local gangActiveTab = 'Главная'

local gangPermNames = {
    invite   = 'Приглашать',
    kick     = 'Исключать',
    setrank  = 'Выдавать ранги',
    ranks    = 'Настраивать ранги',
    withdraw = 'Снимать деньги',
    disband  = 'Распустить банду',
}
local gangPermOrder = {'invite','kick','setrank','ranks','withdraw','disband'}

local function GangMoney(v)
    v = tonumber(v or 0) or 0
    if rp and rp.FormatMoney then return rp.FormatMoney(v) end
    if DarkRP and DarkRP.formatMoney then return DarkRP.formatMoney(v) end
    return string.Comma(v) .. '₽'
end

local function GangNotify(txt, ok)
    if notification and notification.AddLegacy then
        notification.AddLegacy(tostring(txt or ''), ok and NOTIFY_GENERIC or NOTIFY_ERROR, 4)
    end
end

local function GangSteam32(sid64)
    sid64 = tostring(sid64 or '')
    if util and util.SteamIDFrom64 and sid64 ~= '' then
        local ok, sid = pcall(util.SteamIDFrom64, sid64)
        if ok and sid and sid ~= 'STEAM_0:0:0' then return sid end
    end
    return sid64
end

local function GangWrapLines(font, str, maxW)
    str = tostring(str or ''):gsub('\r', '')
    surface.SetFont(font)
    local out = {}
    for paragraph in string.gmatch(str .. '\n', '([^\n]*)\n') do
        local line = ''
        for word in string.gmatch(paragraph, '%S+') do
            local test = line == '' and word or (line .. ' ' .. word)
            local tw = surface.GetTextSize(test)
            if tw > maxW and line ~= '' then
                out[#out + 1] = line
                line = word
            else
                line = test
            end
        end
        if line ~= '' then out[#out + 1] = line end
        if paragraph == '' then out[#out + 1] = '' end
    end
    return out
end

local function GangHasPerm(perm)
    if not gangState or not gangState.my then return false end
    if gangState.my.is_owner or tonumber(gangState.my.weight or 0) >= 100 then return true end
    return gangState.my.perms and gangState.my.perms[perm] == true
end

local function GangAction(action, data)
    net.Start('F4Gangs:Action')
        net.WriteString(action)
        net.WriteString(util.TableToJSON(data or {}) or '{}')
    net.SendToServer()
end

local function GangRequest()
    gangLoading = true
    net.Start('F4Gangs:Request')
    net.SendToServer()
end

local GangBtn
local activeGangInvite
local activeGangInvitePanel

local function CloseGangInvite()
    if IsValid(activeGangInvitePanel) then activeGangInvitePanel:Remove() end
    activeGangInvitePanel = nil
    activeGangInvite = nil
    hook.Remove('PlayerButtonDown', 'F4Gangs.InviteHotkeys')
    hook.Remove('PlayerBindPress', 'F4Gangs.InviteBind')
end

local function ShowGangInvite(gangID, gangName, inviterName)
    gangID = tonumber(gangID or 0) or 0
    if gangID <= 0 then return end
    if activeGangInvite and activeGangInvite.gang_id == gangID and IsValid(activeGangInvitePanel) then return end

    CloseGangInvite()
    activeGangInvite = { gang_id = gangID, name = tostring(gangName or 'Банда'), inviter = tostring(inviterName or '') }

    local pnl = vgui.Create('EditablePanel')
    activeGangInvitePanel = pnl
    pnl:SetSize(s(440), s(132))
    pnl:SetPos(ScrW() / 2 - pnl:GetWide() / 2, s(82))
    pnl:SetAlpha(0)
    pnl:AlphaTo(255, 0.15)
    pnl.Paint = function(self,w,h)
        draw.RoundedBox(s(12),0,0,w,h,C.bg_a)
        draw.RoundedBox(s(10),s(8),s(8),w-s(16),h-s(16),C.card)
        draw.SimpleText('Приглашение в банду','MKfont.18',s(22),s(30),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(activeGangInvite.name,'MKfont.20',s(22),s(58),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        local by = activeGangInvite.inviter ~= '' and ('от ' .. activeGangInvite.inviter) or 'нажмите F1 или F2'
        draw.SimpleText(by,'MKfont.14',s(22),s(82),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local accept = GangBtn(pnl, 'F1 Принять', C.card_s, function()
        GangAction('accept', { gang_id = gangID })
        CloseGangInvite()
    end)
    accept:SetPos(s(238), s(74))
    accept:SetSize(s(92), s(34))

    local decline = GangBtn(pnl, 'F2 Отказ', C.btn, function()
        GangAction('decline', { gang_id = gangID })
        CloseGangInvite()
    end)
    decline:SetPos(s(338), s(74))
    decline:SetSize(s(82), s(34))

    hook.Add('PlayerButtonDown', 'F4Gangs.InviteHotkeys', function(_, key)
        if not activeGangInvite then return end
        if key == KEY_F1 then
            GangAction('accept', { gang_id = activeGangInvite.gang_id })
            CloseGangInvite()
        elseif key == KEY_F2 then
            GangAction('decline', { gang_id = activeGangInvite.gang_id })
            CloseGangInvite()
        end
    end)

    hook.Add('PlayerBindPress', 'F4Gangs.InviteBind', function(_, bind, pressed)
        if not activeGangInvite or not pressed then return end
        bind = string.lower(tostring(bind or ''))
        if bind == 'gm_showhelp' then
            GangAction('accept', { gang_id = activeGangInvite.gang_id })
            CloseGangInvite()
            return true
        elseif bind == 'gm_showteam' then
            GangAction('decline', { gang_id = activeGangInvite.gang_id })
            CloseGangInvite()
            return true
        end
    end)

    timer.Simple(25, function()
        if activeGangInvite and activeGangInvite.gang_id == gangID then CloseGangInvite() end
    end)
end

GangBtn = function(parent, txt, col, click)
    local b = parent:Add('DButton')
    b:SetText('')
    b:SetTall(s(38))
    b.Paint = function(self,w,h)
        local bg = self:IsHovered() and C.card_h or (col or C.btn)
        draw.RoundedBox(s(8),0,0,w,h,bg)
        draw.SimpleText(txt,'MKfont.15',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    b.DoClick = click
    return b
end

local function GangSection(parent, title)
    local card = Card(parent)
    card:Dock(TOP)
    card:DockMargin(0,0,0,s(12))
    card:DockPadding(s(14),s(14),s(14),s(14))
    local head = card:Add('Panel')
    head:Dock(TOP)
    head:SetTall(s(30))
    head.Paint = function(_,w,h)
        draw.SimpleText(title,'MKfont.20',0,h/2,C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end
    return card
end

local function GangOpenAmount(title, placeholder, cb)
    local f = vgui.Create('DFrame')
    f:SetSize(s(420), s(210))
    f:Center()
    f:MakePopup()
    f:SetTitle('')
    f:ShowCloseButton(false)
    f.Paint = function(_,w,h)
        draw.RoundedBox(s(14),0,0,w,h,C.bg_a)
        draw.RoundedBox(s(12),s(14),s(14),w-s(28),h-s(28),C.card)
        draw.SimpleText(title or 'Сумма','MKfont.20',s(30),s(38),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText('Введите сумму','MKfont.14',s(30),s(66),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local close = f:Add('DButton')
    close:SetText('')
    close:SetPos(s(374), s(18))
    close:SetSize(s(28), s(28))
    close.Paint = function(self,w,h)
        draw.RoundedBox(s(7),0,0,w,h,self:IsHovered() and C.card_h or C.btn)
        draw.SimpleText('×','MKfont.18',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    close.DoClick = function() f:Remove() end

    local entry = f:Add('DTextEntry')
    entry:SetPos(s(30), s(88))
    entry:SetSize(s(360), s(42))
    entry:SetFont('MKfont.18')
    entry:SetTextColor(C.white)
    entry:SetNumeric(true)
    entry:SetText(tostring(placeholder or '10000'))
    entry:SetDrawBackground(false)
    if entry.SetCursorColor then entry:SetCursorColor(C.white) end
    entry.Paint = function(self,w,h)
        draw.RoundedBox(s(8),0,0,w,h,Color(20,20,22,220))
        surface.SetDrawColor(self:HasFocus() and C.card_s or Color(255,255,255,24))
        surface.DrawOutlinedRect(0,0,w,h,1)
        self:DrawTextEntryText(C.white, C.card_s, C.white)
    end
    entry:RequestFocus()
    entry:SelectAllText(true)

    local cancel = GangBtn(f, 'Отмена', C.btn, function() f:Remove() end)
    cancel:SetPos(s(30), s(150))
    cancel:SetSize(s(120), s(36))

    local ok = GangBtn(f, 'Готово', C.card_s, function()
        local amount = math.floor(tonumber(entry:GetValue() or 0) or 0)
        if amount <= 0 then GangNotify('Некорректная сумма', false) return end
        cb(amount)
        f:Remove()
    end)
    ok:SetPos(s(162), s(150))
    ok:SetSize(s(228), s(36))

    entry.OnEnter = function() ok:DoClick() end
end

local function GangConfirm(title, textMsg, yesText, cb)
    local f = vgui.Create('DFrame')
    f:SetSize(s(390), s(185))
    f:Center()
    f:MakePopup()
    f:SetTitle('')
    f:ShowCloseButton(false)
    f.Paint = function(_,w,h)
        draw.RoundedBox(s(14),0,0,w,h,C.bg_a)
        draw.RoundedBox(s(12),s(12),s(12),w-s(24),h-s(24),C.card)
        draw.SimpleText(title or 'Подтверждение','MKfont.20',s(26),s(38),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(textMsg or 'Вы уверены?','MKfont.15',s(26),s(72),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local no = GangBtn(f, 'Отмена', C.btn, function() f:Remove() end)
    no:SetPos(s(26), s(125))
    no:SetSize(s(130), s(36))

    local yes = GangBtn(f, yesText or 'Да', C.card_s, function()
        f:Remove()
        if cb then cb() end
    end)
    yes:SetPos(s(168), s(125))
    yes:SetSize(s(196), s(36))
end

local function GangOpenInviteSelector()
    if not GangHasPerm('invite') then GangNotify('Нет прав приглашать', false) return end

    local f = vgui.Create('DFrame')
    f:SetSize(s(520), s(500))
    f:Center()
    f:MakePopup()
    f:SetTitle('')
    f:ShowCloseButton(false)
    f.Paint = function(_,w,h)
        draw.RoundedBox(s(14),0,0,w,h,C.bg_a)
        draw.RoundedBox(s(12),s(14),s(14),w-s(28),h-s(28),C.card)
        draw.SimpleText('Пригласить игрока','MKfont.20',s(30),s(38),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local close = f:Add('DButton')
    close:SetText('')
    close:SetPos(s(474), s(18))
    close:SetSize(s(28), s(28))
    close.Paint = function(self,w,h)
        draw.RoundedBox(s(7),0,0,w,h,self:IsHovered() and C.card_h or C.btn)
        draw.SimpleText('×','MKfont.18',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    close.DoClick = function() f:Remove() end

    local search = f:Add('DTextEntry')
    search:SetPos(s(30), s(64))
    search:SetSize(s(460), s(38))
    search:SetFont('MKfont.15')
    search:SetTextColor(C.white)
    search:SetPlaceholderText('Поиск')
    search:SetDrawBackground(false)
    if search.SetCursorColor then search:SetCursorColor(C.white) end
    search.Paint = function(self,w,h)
        draw.RoundedBox(s(8),0,0,w,h,Color(20,20,22,220))
        surface.SetDrawColor(self:HasFocus() and C.card_s or Color(255,255,255,22))
        surface.DrawOutlinedRect(0,0,w,h,1)
        self:DrawTextEntryText(C.white, C.card_s, C.white)
    end

    local selectedSteam, selectedName

    local list = f:Add('DScrollPanel')
    list:SetPos(s(30), s(114))
    list:SetSize(s(460), s(280))
    makeScroll(list)

    local selected = f:Add('Panel')
    selected:SetPos(s(30), s(406))
    selected:SetSize(s(290), s(54))
    selected.Paint = function(_,w,h)
        draw.RoundedBox(s(8),0,0,w,h,Color(20,20,22,160))
        draw.SimpleText(selectedName or 'Игрок не выбран','MKfont.15',s(12),s(19),selectedName and C.white or C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        if selectedSteam then draw.SimpleText(GangSteam32(selectedSteam),'MKfont.12',s(12),s(38),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
    end

    local send = GangBtn(f, 'Пригласить', C.card_s, function()
        if not selectedSteam then GangNotify('Выберите игрока', false) return end
        GangAction('invite', { steamid = selectedSteam })
        f:Remove()
    end)
    send:SetPos(s(332), s(414))
    send:SetSize(s(158), s(38))

    local function rebuild()
        list:Clear()
        local q = string.lower(search:GetValue() or '')
        local any = false
        for _, op in ipairs(gangState.online or {}) do
            if op.steamid ~= LocalPlayer():SteamID64() and tonumber(op.gang_id or 0) == 0 then
                local hay = string.lower((op.name or '') .. ' ' .. (op.steamid or '') .. ' ' .. GangSteam32(op.steamid))
                if q == '' or string.find(hay, q, 1, true) then
                    any = true
                    local row = list:Add('DButton')
                    row:Dock(TOP)
                    row:DockMargin(0,0,s(4),s(6))
                    row:SetTall(s(46))
                    row:SetText('')
                    row.Paint = function(self,w,h)
                        local chosen = selectedSteam == op.steamid
                        local bg = chosen and C.card_s or (self:IsHovered() and C.card_h or Color(20,20,22,150))
                        draw.RoundedBox(s(8),0,0,w,h,bg)
                        draw.SimpleText(op.name or 'Игрок','MKfont.15',s(12),s(16),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                        draw.SimpleText(GangSteam32(op.steamid),'MKfont.12',s(12),s(33),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    end
                    row.DoClick = function()
                        selectedSteam = op.steamid
                        selectedName = op.name
                    end
                end
            end
        end
        if not any then
            local empty = list:Add('Panel')
            empty:Dock(TOP)
            empty:SetTall(s(46))
            empty.Paint = function(_,w,h)
                draw.RoundedBox(s(8),0,0,w,h,Color(20,20,22,150))
                draw.SimpleText('Никого нет','MKfont.15',s(12),h/2,C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
        end
    end

    search.OnChange = rebuild
    rebuild()
end

local function GangOpenInfoEditor()
    if not gangState or not gangState.my or not gangState.my.is_owner then
        GangNotify('Только глава банды может менять информацию', false)
        return
    end

    local f = vgui.Create('DFrame')
    f:SetSize(s(520), s(380))
    f:Center()
    f:MakePopup()
    f:SetTitle('')
    f:ShowCloseButton(false)
    f.Paint = function(_,w,h)
        DrawBlur(f, 4)
        draw.RoundedBox(s(16),0,0,w,h,Color(28,29,32,252))
        draw.RoundedBoxEx(s(16),0,0,w,s(4),C.red,true,true,false,false)
        draw.SimpleText('Описание клана','MKfont.23',s(22),s(30),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText('Этот текст увидят участники клана','MKfont.15',s(22),s(60),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local close = f:Add('DButton')
    close:SetText('')
    close:SetPos(s(474), s(16))
    close:SetSize(s(30), s(30))
    close.Paint = function(self,w,h)
        draw.RoundedBox(s(8),0,0,w,h,self:IsHovered() and C.red or C.card)
        draw.SimpleText('×','MKfont.20',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    close.DoClick = function() f:Remove() end

    local entry = f:Add('DTextEntry')
    entry:SetPos(s(22), s(88))
    entry:SetSize(s(476), s(215))
    entry:SetFont('MKfont.16')
    entry:SetTextColor(C.white)
    entry:SetMultiline(true)
    entry:SetText(gangState.gang.description or '')
    entry:SetDrawBackground(false)
    if entry.SetCursorColor then entry:SetCursorColor(C.white) end
    entry.Paint = function(self,w,h)
        draw.RoundedBox(s(10),0,0,w,h,Color(15,15,18,235))
        surface.SetDrawColor(self:HasFocus() and C.red or Color(255,255,255,28))
        surface.DrawOutlinedRect(0,0,w,h,1)
        self:DrawTextEntryText(C.white, C.red, C.white)
    end

    local cancel = GangBtn(f, 'Отмена', C.btn, function() f:Remove() end)
    cancel:SetPos(s(22), s(316))
    cancel:SetSize(s(150), s(42))

    local save = GangBtn(f, 'Сохранить информацию', C.green, function()
        GangAction('setinfo', { description = entry:GetValue() or '' })
        f:Remove()
    end)
    save:SetPos(s(184), s(316))
    save:SetSize(s(314), s(42))
end

local function GangOpenRankEditor(rank)
    if not GangHasPerm('ranks') then GangNotify('Нет прав', false) return end
    rank = rank or {name='', weight=10, perms={}}

    local f = vgui.Create('DFrame')
    f:SetSize(s(380), s(430))
    f:Center()
    f:MakePopup()
    f:SetTitle('')
    f:ShowCloseButton(false)
    f.Paint = function(_,w,h)
        DrawBlur(f,4)
        draw.RoundedBox(s(12),0,0,w,h,C.bg_a)
        draw.SimpleText(rank.id and 'Редактирование ранга' or 'Создание ранга','MKfont.20',s(18),s(18),C.white)
    end

    local close = f:Add('DButton')
    close:SetText('')
    close:SetPos(s(335), s(14))
    close:SetSize(s(30), s(30))
    close.Paint = function(self,w,h)
        draw.RoundedBox(s(6),0,0,w,h,self:IsHovered() and C.red or C.card)
        draw.SimpleText('×','MKfont.20',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    close.DoClick = function() f:Remove() end

    local name = f:Add('DTextEntry')
    name:SetPos(s(18), s(62))
    name:SetSize(s(344), s(36))
    name:SetText(rank.name or '')
    name:SetPlaceholderText('Название ранга')

    local weight = f:Add('DTextEntry')
    weight:SetPos(s(18), s(108))
    weight:SetSize(s(344), s(36))
    weight:SetNumeric(true)
    weight:SetText(tostring(rank.weight or 10))
    weight:SetPlaceholderText('Вес 1-99')

    local checks = {}
    local y = s(158)
    for _, perm in ipairs(gangPermOrder) do
        local cb = f:Add('DCheckBoxLabel')
        cb:SetPos(s(20), y)
        cb:SetText(gangPermNames[perm] or perm)
        cb:SetFont('MKfont.15')
        cb:SetTextColor(C.white)
        cb:SetValue(rank.perms and rank.perms[perm] and 1 or 0)
        cb:SizeToContents()
        checks[perm] = cb
        y = y + s(32)
    end

    local save = GangBtn(f, 'Сохранить', C.green, function()
        local perms = {}
        for _, perm in ipairs(gangPermOrder) do perms[perm] = checks[perm] and checks[perm]:GetChecked() or false end
        GangAction('saverank', {
            id = rank.id,
            name = name:GetValue(),
            weight = tonumber(weight:GetValue() or 10) or 10,
            perms = perms,
        })
        f:Remove()
    end)
    save:SetPos(s(18), s(360))
    save:SetSize(s(344), s(42))
end

local function GangRenderNoGang(parent, p)
    parent:DockPadding(s(16), s(16), s(16), s(16))

    local help = Card(parent)
    help:Dock(BOTTOM)
    help:SetTall(s(105))
    help:DockMargin(0,s(12),0,0)
    help.Paint = function(_,w,h)
        draw.RoundedBox(s(12),0,0,w,h,C.card)
        draw.SimpleText('Как вступить в банду','MKfont.20',s(18),s(24),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText('Когда тебя пригласят, сверху появится уведомление.','MKfont.15',s(18),s(58),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText('F1 — принять    F2 — отклонить','MKfont.16',s(18),s(82),C.green,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local create = Card(parent)
    create:Dock(TOP)
    create:SetTall(s(330))
    create.Paint = function(_,w,h)
        draw.RoundedBox(s(12),0,0,w,h,C.card)
        draw.SimpleText('Создание банды','MKfont.23',s(18),s(26),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

        draw.RoundedBox(s(10),s(18),s(56),w-s(36),s(78),Color(255,255,255,14))
        draw.SimpleText('Придумай название своей банды','MKfont.18',s(34),s(82),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText('До 10 символов, только английские буквы/цифры.','MKfont.14',s(34),s(110),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

        local cost = gangState and gangState.create_cost or 0
        draw.SimpleText('Стоимость создания:','MKfont.16',s(18),s(160),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(GangMoney(cost),'MKfont.18',s(190),s(160),C.green,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

        draw.SimpleText('Название банды','MKfont.15',s(18),s(198),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local nameEntry = create:Add('DTextEntry')
    nameEntry:SetPos(s(18), s(212))
    nameEntry:SetSize(s(720), s(46))
    nameEntry:SetFont('MKfont.18')
    nameEntry:SetTextColor(C.white)
    nameEntry:SetPlaceholderText('Например: Arizona')
    nameEntry:SetDrawBackground(false)
    if nameEntry.SetCursorColor then nameEntry:SetCursorColor(C.white) end
    if nameEntry.SetHighlightColor then nameEntry:SetHighlightColor(C.red) end
    nameEntry.AllowInput = function(self, char)
        local current = self:GetValue() or ''
        if #current >= 10 then return true end
        if not tostring(char or ''):match('^[A-Za-z0-9 _%-]$') then return true end
    end
    nameEntry.Paint = function(self,w,h)
        draw.RoundedBox(s(10),0,0,w,h,Color(20,20,22,220))
        surface.SetDrawColor(Color(255,255,255,28))
        surface.DrawOutlinedRect(0,0,w,h,1)
        self:DrawTextEntryText(C.white, C.red, C.white)
    end

    local createBtn = GangBtn(create, 'Создать банду', C.green, function()
        local name = string.Trim(nameEntry:GetValue() or '')
        if name == '' then GangNotify('Введите название банды', false) return end
        if #name < 3 then GangNotify('Название минимум 3 символа', false) return end
        if #name > 10 then GangNotify('Название максимум 10 символов', false) return end
        if not name:match('^[A-Za-z0-9 _%-]+$') then
            GangNotify('Только английские буквы, цифры, пробел, - и _', false)
            return
        end
        GangAction('create', { name = name })
    end)
    createBtn:SetPos(s(18), s(274))
    createBtn:SetSize(s(720), s(42))

    create.PerformLayout = function(_,w,h)
        nameEntry:SetWide(w - s(36))
        createBtn:SetWide(w - s(36))
    end
end

local function GangRenderMembers(section)
    local members = gangState.members or {}
    section:SetTall(s(90 + math.max(#members, 1) * 64))
    if #members == 0 then
        local empty = section:Add('Panel')
        empty:Dock(FILL)
        empty.Paint = function(_,w,h)
            draw.SimpleText('Участников нет','MKfont.16',0,s(18),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        return
    end

    for _, m in ipairs(members) do
        local row = section:Add('Panel')
        row:Dock(TOP)
        row:DockMargin(0,s(8),0,0)
        row:SetTall(s(56))
        row.Paint = function(_,w,h)
            draw.RoundedBox(s(10),0,0,w,h,C.card)
            local onlineCol = m.online and C.green or C.gray_l
            draw.SimpleText(m.online and '●' or '○','MKfont.18',s(16),h/2,onlineCol,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(m.name or m.steamid,'MKfont.16',s(42),s(20),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(GangSteam32(m.steamid),'MKfont.13',s(42),s(39),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(m.rank or 'Участник','MKfont.15',w-s(190),h/2,C.gray_l,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        end

        if GangHasPerm('kick') and m.steamid ~= gangState.gang.owner and m.steamid ~= LocalPlayer():SteamID64() then
            local kick = GangBtn(row, 'Исключить', C.red, function()
                Derma_Query('Исключить ' .. (m.name or m.steamid) .. '?', 'Банды', 'Да', function() GangAction('kick', {steamid = m.steamid}) end, 'Нет')
            end)
            kick:Dock(RIGHT); kick:SetWide(s(92)); kick:DockMargin(s(6),s(9),s(8),s(9))
        end

        if GangHasPerm('setrank') and m.steamid ~= gangState.gang.owner then
            local setr = GangBtn(row, 'Ранг', C.btn, function()
                local menu = DermaMenu()
                for _, r in ipairs(gangState.ranks or {}) do
                    if tonumber(r.weight or 0) < tonumber(gangState.my.weight or 0) or gangState.my.is_owner then
                        menu:AddOption(r.name .. ' (' .. r.weight .. ')', function()
                            GangAction('setrank', {steamid = m.steamid, rank_id = r.id})
                        end)
                    end
                end
                menu:Open()
            end)
            setr:Dock(RIGHT); setr:SetWide(s(82)); setr:DockMargin(0,s(9),0,s(9))
        end
    end
end

local function GangPermSummary(perms)
    perms = perms or {}
    local out = {}
    for _, perm in ipairs(gangPermOrder) do
        if perms[perm] then out[#out + 1] = gangPermNames[perm] or perm end
    end
    return #out > 0 and table.concat(out, ', ') or 'Без дополнительных прав'
end

local function GangRenderRanks(section)
    local ranks = gangState.ranks or {}
    local addH = GangHasPerm('ranks') and 52 or 0
    section:SetTall(s(92 + addH + math.max(#ranks, 1) * 70))

    if GangHasPerm('ranks') then
        local add = GangBtn(section, '+ Создать ранг', C.green, function() GangOpenRankEditor(nil) end)
        add:Dock(TOP)
        add:SetTall(s(42))
        add:DockMargin(0,s(10),0,s(6))
    end

    if #ranks == 0 then
        local empty = section:Add('Panel')
        empty:Dock(FILL)
        empty.Paint = function(_,w,h)
            draw.SimpleText('Рангов нет','MKfont.16',0,s(18),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        return
    end

    for _, r in ipairs(ranks) do
        local row = section:Add('Panel')
        row:Dock(TOP)
        row:DockMargin(0,s(8),0,0)
        row:SetTall(s(62))
        row.Paint = function(_,w,h)
            draw.RoundedBox(s(10),0,0,w,h,C.card)
            draw.SimpleText(r.name or '—','MKfont.17',s(14),s(20),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('Вес: ' .. tostring(r.weight or 0),'MKfont.13',s(14),s(42),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

            local summary = GangPermSummary(r.perms)
            local maxW = w - s(320)
            surface.SetFont('MKfont.13')
            local tw = surface.GetTextSize(summary)
            if tw > maxW then summary = string.sub(summary, 1, 52) .. '...' end
            draw.SimpleText(summary,'MKfont.13',s(120),s(42),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end

        if GangHasPerm('ranks') and tonumber(r.weight or 0) < 100 then
            local edit = GangBtn(row, 'Изменить', C.btn, function() GangOpenRankEditor(r) end)
            edit:Dock(RIGHT); edit:SetWide(s(92)); edit:DockMargin(s(6),s(11),s(8),s(11))
            local del = GangBtn(row, 'Удалить', C.red, function()
                Derma_Query('Удалить ранг ' .. (r.name or '') .. '?', 'Банды', 'Да', function() GangAction('deleterank', {id = r.id}) end, 'Нет')
            end)
            del:Dock(RIGHT); del:SetWide(s(86)); del:DockMargin(0,s(11),0,s(11))
        end
    end
end

local function GangRenderFlags(section)
    local flags = gangState.flags or {}
    section:SetTall(s(70 + math.max(#flags, 1) * 48))
    if #flags == 0 then
        local empty = section:Add('Panel')
        empty:Dock(FILL)
        empty.Paint = function(_,w,h)
            draw.SimpleText('Флаги ещё не установлены','MKfont.16',0,s(18),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        return
    end

    for _, fl in ipairs(flags) do
        local row = section:Add('Panel')
        row:Dock(TOP)
        row:DockMargin(0,s(8),0,0)
        row:SetTall(s(40))
        row.Paint = function(_,w,h)
            draw.RoundedBox(s(8),0,0,w,h,C.card)
            draw.SimpleText(fl.name or ('Флаг #' .. tostring(fl.id)),'MKfont.15',s(12),h/2,C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            local owner = (fl.gang_name and fl.gang_name ~= '') and fl.gang_name or 'Не захвачен'
            local col = (fl.gang_name and fl.gang_name ~= '') and C.green or C.gray_l
            draw.SimpleText(owner,'MKfont.15',w-s(12),h/2,col,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        end
    end
end

local function GangRenderGang(parent, p)
    parent:DockPadding(s(16), s(16), s(16), s(16))

    local tabNames = {'Главная','Игроки','Банк','Ранги','Флаги'}
    local active = gangActiveTab or 'Главная'

    local header = Card(parent)
    header:Dock(TOP)
    header:SetTall(s(92))
    header:DockMargin(0,0,0,s(12))
    header.Paint = function(_,w,h)
        draw.RoundedBox(s(12),0,0,w,h,C.card)
        draw.SimpleText(gangState.gang.name or 'Банда','MKfont.24',s(18),s(28),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText('Ваш ранг: ' .. tostring(gangState.my.rank or '—'),'MKfont.15',s(18),s(58),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText('Репутация: ' .. string.Comma(tonumber(gangState.gang.reputation or 0) or 0),'MKfont.16',w-s(18),s(30),C.green,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        draw.SimpleText('Банк: ' .. GangMoney(gangState.gang.bank),'MKfont.16',w-s(18),s(58),C.green,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
    end

    local tabs = parent:Add('Panel')
    tabs:Dock(TOP)
    tabs:SetTall(s(44))
    tabs:DockMargin(0,0,0,s(12))

    local page = parent:Add('Panel')
    page:Dock(FILL)
    page.Paint = function() end

    local function clearPage()
        page:Clear()
    end

    local function showMain()
        clearPage()
        local scroll = page:Add('DScrollPanel')
        scroll:Dock(FILL)
        makeScroll(scroll)

        local stats = Card(scroll)
        stats:Dock(TOP)
        stats:SetTall(s(145))
        stats:DockMargin(0,0,0,s(12))
        stats.Paint = function(_,w,h)
            draw.RoundedBox(s(12),0,0,w,h,C.card)
            local members = #(gangState.members or {})
            local flags = 0
            for _, fl in ipairs(gangState.flags or {}) do if tonumber(fl.gang_id or 0) == tonumber(gangState.gang.id or 0) then flags = flags + 1 end end
            draw.SimpleText('Информация о банде','MKfont.23',s(16),s(24),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('Репутация','MKfont.14',s(18),s(66),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(string.Comma(tonumber(gangState.gang.reputation or 0) or 0),'MKfont.24',s(18),s(100),C.green,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('Игроков','MKfont.14',s(220),s(66),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(tostring(members),'MKfont.24',s(220),s(100),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('Флагов','MKfont.14',s(380),s(66),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(flags .. '/2','MKfont.24',s(380),s(100),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end

        local leaveText = gangState.my and gangState.my.is_owner and 'Распустить банду' or 'Выйти из банды'
        local leaveBtn = GangBtn(stats, leaveText, C.btn, function()
            if gangState.my and gangState.my.is_owner then
                GangConfirm('Распустить банду', 'Все участники будут удалены из банды.', 'Распустить', function() GangAction('disband', {}) end)
            else
                GangConfirm('Выйти из банды', 'Вы покинете текущую банду.', 'Выйти', function() GangAction('leave', {}) end)
            end
        end)
        leaveBtn:SetSize(s(170), s(36))
        stats.PerformLayout = function(_,w,h)
            leaveBtn:SetPos(w - s(190), h - s(50))
        end

        local about = Card(scroll)
        about:Dock(TOP)
        about:SetTall(s(175))
        about.Paint = function(_,w,h)
            draw.RoundedBox(s(12),0,0,w,h,C.card)
            draw.SimpleText('Информация клана','MKfont.20',s(16),s(28),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

            local desc = tostring(gangState.gang.description or '')
            if desc == '' then
                desc = gangState.my and gangState.my.is_owner and 'Информация не заполнена. Нажми «Изменить», чтобы написать описание клана.' or 'Глава клана ещё не заполнил информацию.'
            end
            local lines = GangWrapLines('MKfont.15', desc, w - s(36))
            for i = 1, math.min(#lines, 4) do
                draw.SimpleText(lines[i], 'MKfont.15', s(16), s(56) + (i - 1) * s(21), C.gray_l, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
        end

        if gangState.my and gangState.my.is_owner then
            local editInfo = GangBtn(about, 'Изменить информацию', C.btn, function()
                GangOpenInfoEditor()
            end)
            editInfo:SetPos(s(16), s(128))
            editInfo:SetSize(s(210), s(36))
        end

    end

    local function showPlayers()
        clearPage()
        local scroll = page:Add('DScrollPanel')
        scroll:Dock(FILL)
        makeScroll(scroll)

        if GangHasPerm('invite') then
            local invite = Card(scroll)
            invite:Dock(TOP)
            invite:SetTall(s(92))
            invite:DockMargin(0,0,0,s(12))
            invite.Paint = function(_,w,h)
                draw.RoundedBox(s(12),0,0,w,h,C.card)
                draw.SimpleText('Приглашение игроков','MKfont.20',s(16),s(28),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText('Список игроков открывается отдельным окном — удобно даже при большом онлайне.','MKfont.14',s(16),s(58),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
            local open = GangBtn(invite, 'Открыть список игроков', C.green, function()
                GangOpenInviteSelector()
            end)
            open:Dock(RIGHT)
            open:SetWide(s(220))
            open:DockMargin(0,s(25),s(16),s(25))
        end

        local members = GangSection(scroll, 'Игроки банды')
        GangRenderMembers(members)
    end

    local function showBank()
        clearPage()
        local card = Card(page)
        card:Dock(TOP)
        card:SetTall(s(235))
        card:DockPadding(s(18),s(18),s(18),s(18))
        card.Paint = function(_,w,h)
            draw.RoundedBox(s(12),0,0,w,h,C.card)
            draw.SimpleText('Банк банды','MKfont.23',s(18),s(30),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(GangMoney(gangState.gang.bank),'MKfont.28',s(18),s(76),C.green,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('Деньги с флагов поступают сюда автоматически.','MKfont.15',s(18),s(112),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end

        local depCard = card:Add('Panel')
        depCard:SetPos(s(18), s(145))
        depCard:SetSize(s(250), s(72))
        depCard.Paint = function(_,w,h)
            draw.RoundedBox(s(10),0,0,w,h,Color(255,255,255,14))
            draw.SimpleText('Внести деньги','MKfont.16',s(12),s(18),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('Со своего баланса в банк','MKfont.13',s(12),s(42),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        local dep = GangBtn(depCard, 'Внести', C.green, function()
            GangOpenAmount('Внести деньги в банк', '10000', function(amount) GangAction('deposit', {amount = amount}) end)
        end)
        dep:Dock(RIGHT); dep:SetWide(s(92)); dep:DockMargin(0,s(16),s(10),s(16))

        local wdCard
        if GangHasPerm('withdraw') then
            wdCard = card:Add('Panel')
            wdCard:SetPos(s(286), s(145))
            wdCard:SetSize(s(250), s(72))
            wdCard.Paint = function(_,w,h)
                draw.RoundedBox(s(10),0,0,w,h,Color(255,255,255,14))
                draw.SimpleText('Забрать деньги','MKfont.16',s(12),s(18),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText('Из банка на свой баланс','MKfont.13',s(12),s(42),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
            local wd = GangBtn(wdCard, 'Забрать', C.btn, function()
                GangOpenAmount('Забрать деньги из банка', '10000', function(amount) GangAction('withdraw', {amount = amount}) end)
            end)
            wd:Dock(RIGHT); wd:SetWide(s(96)); wd:DockMargin(0,s(16),s(10),s(16))
        end

        card.PerformLayout = function(_,w,h)
            local half = math.floor((w - s(54)) / 2)
            depCard:SetWide(half)
            if IsValid(wdCard) then
                wdCard:SetPos(s(36) + half, s(145))
                wdCard:SetWide(half)
            end
        end
    end

    local function showRanks()
        clearPage()
        local scroll = page:Add('DScrollPanel')
        scroll:Dock(FILL)
        makeScroll(scroll)
        local ranks = GangSection(scroll, 'Ранги и права')
        GangRenderRanks(ranks)
    end

    local function showFlags()
        clearPage()
        local scroll = page:Add('DScrollPanel')
        scroll:Dock(FILL)
        makeScroll(scroll)
        local info = Card(scroll)
        info:Dock(TOP)
        info:SetTall(s(158))
        info:DockMargin(0,0,0,s(12))
        info.Paint = function(_,w,h)
            draw.RoundedBox(s(12),0,0,w,h,C.card)
            draw.SimpleText('Флаги на карте','MKfont.23',s(16),s(26),C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('Подойдите к флагу и нажмите E, чтобы начать захват. Одна банда может держать максимум 2 флага.','MKfont.15',s(16),s(54),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('Захват длится 5 минут. Для захвата нужны 3 живых участника банды в радиусе флага.','MKfont.15',s(16),s(80),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('Награда: +2.500₽ в банк банды и +25 репутации за каждый флаг каждые 5 минут.','MKfont.15',s(16),s(106),C.green,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText('КД после успешного захвата или срыва захвата — 20 минут.','MKfont.15',s(16),s(132),C.gray_l,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        local flags = GangSection(scroll, 'Все флаги')
        GangRenderFlags(flags)
    end

    local renderers = {
        ['Главная'] = showMain,
        ['Игроки'] = showPlayers,
        ['Банк'] = showBank,
        ['Ранги'] = showRanks,
        ['Флаги'] = showFlags,
    }

    local function renderTabs()
        tabs:Clear()
        for _, name in ipairs(tabNames) do
            local b = tabs:Add('DButton')
            b:Dock(LEFT)
            b:DockMargin(0,0,s(8),0)
            b:SetWide(s(118))
            b:SetText('')
            b.Paint = function(self,w,h)
                local bg = active == name and C.card_s or (self:IsHovered() and C.card_h or C.card)
                draw.RoundedBox(s(9),0,0,w,h,bg)
                draw.SimpleText(name,'MKfont.15',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            end
            b.DoClick = function()
                active = name
                gangActiveTab = name
                renderTabs()
                if renderers[active] then renderers[active]() end
            end
        end
    end

    renderTabs()
    if renderers[active] then renderers[active]() else showMain() end
end

function BuildGangs(parent, p, noRequest)
    local c = newContent(parent)
    gangPanel = c

    local body = Card(c)
    body:Dock(FILL)
    body:DockPadding(s(16),s(16),s(16),s(16))

    if gangLoading and not gangState then
        body.Paint = function(_,w,h)
            draw.RoundedBox(s(12),0,0,w,h,C.card)
            draw.SimpleText('Загрузка банд...','MKfont.23',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    elseif not gangState then
        body.Paint = function(_,w,h)
            draw.RoundedBox(s(12),0,0,w,h,C.card)
            draw.SimpleText('Нет данных. Нажмите обновить.','MKfont.20',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        local refresh = GangBtn(body, 'Обновить', C.btn, GangRequest)
        refresh:SetSize(s(160),s(42)); refresh:SetPos(s(20),s(20))
    elseif gangState.gang then
        GangRenderGang(body, p)
    else
        GangRenderNoGang(body, p)
    end

    if not noRequest then GangRequest() end
end

net.Receive('F4Gangs:Data', function()
    gangLoading = false
    gangState = util.JSONToTable(net.ReadString() or '{}') or {}
    _G.F4GangState = gangState
    if (not gangState.gang) and gangState.invites and gangState.invites[1] then
        local inv = gangState.invites[1]
        ShowGangInvite(inv.gang_id, inv.name or ('Банда #' .. tostring(inv.gang_id)), '')
    end
    if IsValid(gangPanel) and IsValid(fr) then
        BuildGangs(fr, LocalPlayer(), true)
    end
end)

net.Receive('F4Gangs:Notify', function()
    local ok = net.ReadBool()
    local msg = net.ReadString()
    GangNotify(msg, ok)
end)

net.Receive('F4Gangs:InvitePopup', function()
    local gangID = net.ReadUInt(32)
    local gangName = net.ReadString()
    local inviterName = net.ReadString()
    ShowGangInvite(gangID, gangName, inviterName)
end)

local function makeTabs(parent, keys, onClick)
    local bar = parent:Add('DHorizontalScroller')
    bar:Dock(TOP)
    bar:SetTall(s(44))
    bar:SetOverlap(-s(8))
    bar.Paint = function() end
    local activeRef = {keys[1]}
    for _,k in ipairs(keys) do
        local b = vgui.Create('DButton')
        surface.SetFont('MKfont.15')
        local tw = surface.GetTextSize(k)
        b:SetSize(math.max(s(110), tw+s(34)), s(40))
        b:SetText('')
        b._n = k
        b.Paint = function(self,w,h)
            draw.RoundedBox(s(8),0,0,w,h,activeRef[1]==self._n and C.card_s or C.card)
            draw.SimpleText(self._n,'MKfont.15',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        b.DoClick = function(self) activeRef[1]=self._n; onClick(self._n) end
        bar:AddPanel(b)
    end
    return bar, activeRef
end

local function BuildShop(parent, p, categories)
    local c = newContent(parent)

    local keys = {}
    for k in pairs(categories) do keys[#keys+1]=k end
    table.sort(keys)

    local scroll
    local function show(cat)
        if IsValid(scroll) then scroll:Remove() end
        scroll = c:Add('DScrollPanel')
        scroll:Dock(FILL)
        scroll:DockMargin(0,s(12),0,0)
        makeScroll(scroll)

        local gl = scroll:Add('DLabel')
        gl:Dock(TOP); gl:SetFont('MKfont.23'); gl:SetTextColor(C.white); gl:SetText(cat)
        gl:SetTall(s(36)); gl:DockMargin(s(2),0,0,s(10))

        local grid = scroll:Add('DIconLayout')
        grid:Dock(TOP); grid:SetSpaceX(s(12)); grid:SetSpaceY(s(12))

        local items = categories[cat]
        if not items then return end

        for _,ent in pairs(items) do
            local item = grid:Add('DButton')
            item:SetSize(s(205),s(180))
            item:SetText('')
            item.Paint = function(self,w,h) draw.RoundedBox(s(12),0,0,w,h,self:IsHovered() and C.card_h or C.card) end

            if ent.model then
                local mp = item:Add('DModelPanel')
                mp:Dock(FILL)
                mp:DockMargin(s(6),s(6),s(6),s(6))
                mp:SetModel(ent.model)
                mp:SetMouseInputEnabled(false)
                mp:SetCursor('arrow')

                local te = ClientsideModel('models/error.mdl')
                te:SetModel(ent.model); te:SetNoDraw(true)
                local cen = te:OBBCenter()
                local dist = te:BoundingRadius()*1.5
                mp:SetLookAt(cen)
                mp:SetCamPos(cen+Vector(dist,dist,0))
                mp.LayoutEntity = function() end
                te:Remove()

                local tax = (mayor_system and mayor_system.calculate_tax) and mayor_system:calculate_tax(1,ent.price) or 0
                mp.PaintOver = function(_,w,h)
                    draw.SimpleText(rp.FormatMoney(ent.price+tax),'MKfont.15',s(4),h-s(40),C.green,0,0)
                    draw.SimpleText(ent.name or '','MKfont.15',s(4),h-s(20),C.white,0,0)
                end
            end

            item.DoClick = function()
                if ent.ammoType then cmd.Run('buyammo',ent.ammoType)
                elseif ent.shipmodel then cmd.Run('buyshipment',ent.name)
                else LocalPlayer():ConCommand('say ' .. ent.cmd) end
                NewClose(fr)
            end
        end
    end

    local _, activeRef = makeTabs(c, keys, show)
    show(activeRef[1])
end

local function BuildJobs(parent, p)
    local c = newContent(parent)

    local cats = {}
    local catsOrder = {}
    local seen = {}
    for k,v in pairs(rp.teams) do
        if not isJobBanned(v) and not isJobHidden(v,p) then
            local tc = v.category or 'Другое'
            if categoriess[tc] then
                local ln = string.lower(v.name or '')
                if not seen[ln] then
                    seen[ln]=true
                    if not cats[tc] then cats[tc]={}; catsOrder[#catsOrder+1]=tc end
                    cats[tc][k]=v
                end
            end
        end
    end
    local catPriority = {
        ['Гражданские'] = 1,
        ['Гос структуры'] = 2,
        ['Гос.структуры'] = 2,
        ['SWAT'] = 3,
        ['Криминал'] = 4,
        ['Личные профессии'] = 5,
        ['Лич.проф'] = 5,
        ['Разное'] = 6
    }
    table.sort(catsOrder, function(a, b)
        local pa = catPriority[a] or 99
        local pb = catPriority[b] or 99
        if pa == pb then return a < b end
        return pa < pb
    end)

    local bodyHolder = c:Add('Panel')
    bodyHolder:Dock(FILL)
    bodyHolder:DockMargin(0,s(12),0,0)
    bodyHolder.Paint = function() end

    local jobScroll, rightPnl

    local function showJob(cat)
        if IsValid(jobScroll) then jobScroll:Remove() end
        if IsValid(rightPnl) then rightPnl:Remove() end

        local lp = bodyHolder:Add('Panel')
        lp:Dock(LEFT)
        lp:SetWide(s(420))
        lp:DockMargin(0,0,s(12),0)
        lp.Paint = function() end
        jobScroll = lp

        local scrl = lp:Add('DScrollPanel')
        scrl:Dock(FILL)
        makeScroll(scrl)

        local gl = scrl:Add('DLabel')
        gl:Dock(TOP); gl:SetFont('MKfont.23'); gl:SetTextColor(C.white); gl:SetText(cat)
        gl:SetTall(s(36)); gl:DockMargin(s(2),0,0,s(10))

        local grid = scrl:Add('DIconLayout')
        grid:Dock(TOP); grid:SetSpaceX(s(12)); grid:SetSpaceY(s(12))

        local jobs = cats[cat]
        if not jobs then return end

        local first = true
        for inx,v in pairs(jobs) do
            local jm = GetJobModel(inx)
            local item = grid:Add('DButton')
            item:SetSize(s(194),s(170))
            item:SetText('')
            item.Paint = function(self,w,h) draw.RoundedBox(s(12),0,0,w,h,self:IsHovered() and C.card_h or C.card) end

            local mdl = item:Add('DModelPanel')
            mdl:SetSize(s(194),s(118))
            mdl:SetModel(jm); mdl:SetFOV(6.4)
            mdl:SetCamPos(Vector(310,50,45)); mdl:SetLookAt(Vector(0,0,60))
            mdl:SetCursor('arrow'); mdl:SetMouseInputEnabled(false)
            mdl.LayoutEntity = function() end

            item.PaintOver = function(_,w,h)
                draw.SimpleText(rp.FormatMoney(v.salary or 0)..'/час','MKfont.15',s(10),h-s(42),C.green,0,0)
                draw.SimpleText(v.name or '','MKfont.17',s(10),h-s(22),C.white,0,0)
            end

            item.DoClick = function()
                if IsValid(rightPnl) then rightPnl:Remove() end
                rightPnl = bodyHolder:Add('Panel')
                rightPnl:Dock(FILL)
                rightPnl.Paint = function(_,w,h) draw.RoundedBox(s(12),0,0,w,h,C.card) end
                rightPnl:DockPadding(s(14),s(14),s(14),s(14))

                local t = rightPnl:Add('Panel')
                t:Dock(TOP); t:SetTall(s(44))
                t.Paint = function(_,w,h)
                    draw.RoundedBox(s(8),0,0,w,h,v.color or C.blue)
                    draw.SimpleText(v.name or '','MKfont.20',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end

                if v.description then
                    local d = rightPnl:Add('DLabel')
                    d:Dock(TOP); d:DockMargin(0,s(10),0,0)
                    d:SetFont('BKfont.16'); d:SetTextColor(C.gray_l)
                    d:SetText(v.description)
                    d:SetWrap(true); d:SetAutoStretchVertical(true)
                    d:SetContentAlignment(7)
                end

                local ts = 1
                if istable(v.model) then for mi,mm in ipairs(v.model) do if mm==jm then ts=mi break end end end

                local dp = rightPnl:Add('Panel')
                dp:Dock(BOTTOM); dp:SetTall(s(46)); dp:DockMargin(0,s(10),0,0)
                dp.Paint = function() end

                local jModel = rightPnl:Add('DModelPanel')
                jModel:Dock(FILL); jModel:DockMargin(0,s(10),0,0); jModel:SetFOV(6.4)
                jModel:SetCamPos(Vector(310,50,45)); jModel:SetLookAt(Vector(0,0,60))
                jModel:SetModel(jm); jModel:SetCursor('arrow')
                jModel.LayoutEntity = function() end

                local bL = dp:Add('DButton')
                bL:Dock(LEFT); bL:SetWide(s(58)); bL:SetText('')
                bL.Paint = function(self,w,h)
                    draw.RoundedBox(s(8),0,0,w,h,self.Hovered and C.card_s or C.btn)
                    draw.SimpleText('<','MKfont.20',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
                bL.DoClick = function(self)
                    if istable(v.model) and CurTime()>=(self._d or 0) and ts>1 then
                        ts=ts-1; jModel:SetModel(v.model[ts]); cmd.Run('model',v.model[ts]); SetJobModel(inx,ts); self._d=CurTime()+1
                    end
                end

                local bR = dp:Add('DButton')
                bR:Dock(RIGHT); bR:SetWide(s(58)); bR:SetText('')
                bR.Paint = function(self,w,h)
                    draw.RoundedBox(s(8),0,0,w,h,self.Hovered and C.card_s or C.btn)
                    draw.SimpleText('>','MKfont.20',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
                bR.DoClick = function(self)
                    if istable(v.model) and CurTime()>=(self._d or 0) and ts<table.Count(v.model) then
                        ts=ts+1; jModel:SetModel(v.model[ts]); cmd.Run('model',v.model[ts]); SetJobModel(inx,ts); self._d=CurTime()+1
                    end
                end

                local bP = dp:Add('DButton')
                bP:Dock(FILL); bP:SetText(''); bP:DockMargin(s(8),0,s(8),0)
                bP.Paint = function(self,w,h)
                    draw.RoundedBox(s(8),0,0,w,h,self.Hovered and C.blue or C.card_s)
                    draw.SimpleText('Выбрать','MKfont.18',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
                bP.DoClick = function()
                    if v.vote then LocalPlayer():ConCommand('say /vote'..v.command)
                    else LocalPlayer():ConCommand('say /'..v.command) end
                    NewClose(fr)
                end
            end

            if first then first=false; item:DoClick() end
        end
    end

    local _, activeRef = makeTabs(c, catsOrder, showJob)
    if activeRef[1] then showJob(activeRef[1]) end
end

local function BuildModels(parent, p)
    local c = newContent(parent)

    local scrl = c:Add('DScrollPanel')
    scrl:Dock(FILL)
    makeScroll(scrl)

    local job = rp.teams[p:Team()]
    if not job or not istable(job.model) then
        local l = scrl:Add('DLabel')
        l:Dock(TOP); l:SetFont('MKfont.20'); l:SetTextColor(C.white)
        l:SetText('У текущей профессии нет дополнительных моделей')
        l:SetTall(s(60)); l:SetContentAlignment(5)
        return
    end

    local gl = scrl:Add('DLabel')
    gl:Dock(TOP); gl:SetFont('MKfont.23'); gl:SetTextColor(C.white); gl:SetText('Модели профессии')
    gl:SetTall(s(36)); gl:DockMargin(s(2),0,0,s(10))

    local grid = scrl:Add('DIconLayout')
    grid:Dock(TOP); grid:SetSpaceX(s(12)); grid:SetSpaceY(s(12))

    for i,mp in ipairs(job.model) do
        local item = grid:Add('DButton')
        item:SetSize(s(194),s(170)); item:SetText('')
        item.Paint = function(self,w,h) draw.RoundedBox(s(12),0,0,w,h,self:IsHovered() and C.card_h or C.card) end

        local mdl = item:Add('DModelPanel')
        mdl:SetSize(s(194),s(138)); mdl:SetModel(mp); mdl:SetFOV(6.4)
        mdl:SetCamPos(Vector(310,50,45)); mdl:SetLookAt(Vector(0,0,60))
        mdl:SetCursor('arrow'); mdl:SetMouseInputEnabled(false)
        mdl.LayoutEntity = function() end

        item.PaintOver = function(_,w,h)
            draw.SimpleText('Модель #'..i,'MKfont.17',s(10),h-s(22),C.white,0,0)
        end

        item.DoClick = function() cmd.Run('model',mp); SetJobModel(p:Team(),i); NewClose(fr) end
    end
end

local function OpenF4Menu()
    if IsValid(fr) then fr:Remove() end
    local p = LocalPlayer()
    navBtns = {}
    timer.Simple(0.2, function()
        if IsValid(fr) then
            net.Start('F4Gangs:Request')
            net.SendToServer()
        end
    end)

    local categories = {}

    local ammos = table.Copy(rp.ammoTypes)
    table.SortByMember(ammos,'price',true)
    for i,d in pairs(ammos) do
        local tc = d.category or 'Патроны'; categories[tc]=categories[tc] or {}; categories[tc][i]=d
    end

    local ships = table.Copy(rp.shipments)
    table.SortByMember(ships,'price',true)
    for i,d in pairs(ships) do
        local tc = d.category or 'Оружия'
        if (d.allowed[p:Team()]==true) and ((not d.customCheck) or d.customCheck(p)) then
            categories[tc]=categories[tc] or {}; categories[tc][i]=d
        end
    end

    local ents = table.Copy(rp.entities)
    table.SortByMember(ents,'price',true)
    for i,d in pairs(ents) do
        if (d.allowed[p:Team()]==true) and ((not d.customCheck) or d.customCheck(p)) then
            categories[d.catagory]=categories[d.catagory] or {}
            table.insert(categories[d.catagory],d)
        end
    end

    local scrW, scrH = ScrW(), ScrH()
    local fw = math.min(s(1180), math.floor(scrW * 0.92))
    local fh = math.min(s(660),  math.floor(scrH * 0.9))
    fw = math.max(fw, 820)
    fh = math.max(fh, 500)

    fr = vgui.Create('EditablePanel')
    fr:SetSize(fw, fh)
    fr:Center()
    fr:MakePopup()
    fr.OnKeyCodePressed = function(_,key)
        if key==KEY_ESCAPE or key==KEY_F4 then
            gui.HideGameUI(); NewClose(fr); return true
        end
    end
    fr.Paint = function(self,w,h)
        DrawBlur(self,5)
        draw.RoundedBox(s(16),0,0,w,h,C.bg_a)
        drawGrad(0,0,w,h)
    end

    local sidebar = fr:Add('Panel')
    sidebar:Dock(LEFT)
    sidebar:SetWide(s(258))
    sidebar:DockPadding(s(18),s(18),s(18),s(18))
    sidebar.Paint = function(_,w,h) draw.RoundedBoxEx(s(16),0,0,w,h,C.sidebar,true,false,true,false) end

    local titleP = sidebar:Add('Panel')
    titleP:Dock(TOP)
    titleP:SetTall(s(54))
    titleP.Paint = function(_,w,h)
        draw.RoundedBox(s(10),0,0,w,h,C.card)
        AddIcon(mats.home,s(14),h/2-s(11),s(22),s(22),C.white)
        draw.SimpleText('Меню сервера','MKfont.18',s(48),h/2,C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local navHolder = sidebar:Add('Panel')
    navHolder:Dock(TOP)
    navHolder:DockMargin(0,s(14),0,0)
    navHolder:SetTall(s(56)*8)
    navHolder.Paint = function() end

    local navData = {
        {name='Главная',icon=mats.home,fn=function() setActiveNav(1); BuildMain(fr,p) end},
        {name='Работы',icon=mats.jobs,fn=function() setActiveNav(2); BuildJobs(fr,p) end},
        {name='Магазин',icon=mats.shop,fn=function() setActiveNav(3); BuildShop(fr,p,categories) end},
        {name='Карты',icon=mats.cards,fn=function() setActiveNav(4); RunConsoleCommand('say','/luck'); NewClose(fr) end},
        {name='Контейнеры',icon=mats.wardrobe,fn=function() setActiveNav(5); BuildModels(fr,p) end},
        {name='Банды',icon=mats.jobs,fn=function() setActiveNav(6); BuildGangs(fr,p) end},
        {name='Батл Пасс',icon=mats.home,fn=function() setActiveNav(7); RunConsoleCommand('battlepass'); NewClose(fr) end},
        {name='Настройки',icon=mats.settings,fn=function() setActiveNav(8); BuildSettings(fr,p) end},
    }

    for i,v in ipairs(navData) do
        local item = navHolder:Add('DButton')
        item:Dock(TOP)
        item:SetTall(s(48))
        item:DockMargin(0,0,0,s(6))
        item:SetText('')
        item._active = (i==1)
        item.Paint = function(self,w,h)
            local hov = self:IsHovered()
            if self._active then draw.RoundedBox(s(10),0,0,w,h,C.card_s)
            elseif hov then draw.RoundedBox(s(10),0,0,w,h,C.card) end
            local col = (self._active or hov) and C.white or C.gray
            AddIcon(v.icon,s(14),h/2-s(12),s(24),s(24),col)
            draw.SimpleText(v.name,'MKfont.18',s(50),h/2,col,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end
        item.DoClick = v.fn
        navBtns[i] = item
    end

    local socialP = sidebar:Add('Panel')
    socialP:Dock(BOTTOM)
    socialP:SetTall(s(108))
    socialP.Paint = function() end

    local row = socialP:Add('Panel')
    row:Dock(TOP)
    row:SetTall(s(46))
    row.Paint = function() end

    local discBtn = row:Add('DButton')
    discBtn:Dock(LEFT)
    discBtn:DockMargin(0,0,s(8),0)
    discBtn:SetText('')
    discBtn.Paint = function(self,w,h)
        local col = self:IsHovered() and Color(110,123,255) or C.discord
        draw.RoundedBox(s(10),0,0,w,h,col)
        draw.SimpleText('Discord','MKfont.16',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    discBtn.DoClick = function() gui.OpenURL('https://discord.gg/arizonarp') end

    local tgBtn = row:Add('DButton')
    tgBtn:Dock(FILL)
    tgBtn:SetText('')
    tgBtn.Paint = function(self,w,h)
        local col = self:IsHovered() and Color(60,185,248) or C.telegram
        draw.RoundedBox(s(10),0,0,w,h,col)
        draw.SimpleText('Telegram','MKfont.16',w/2,h/2,C.white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    tgBtn.DoClick = function() gui.OpenURL('https://t.me/arizonarpgpromo') end

    row.PerformLayout = function(self,w,h)
        discBtn:SetWide(math.floor((w - s(8)) / 2))
    end

    local donateBtn = socialP:Add('DButton')
    donateBtn:Dock(FILL)
    donateBtn:DockMargin(0,s(10),0,0)
    donateBtn:SetText('')
    donateBtn.Paint = function(self,w,h)
        local col = self:IsHovered() and Color(235,178,30) or C.donate
        draw.RoundedBox(s(10),0,0,w,h,col)
        surface.SetFont('MKfont.18')
        local txt = 'Донат магазин'
        local tw = surface.GetTextSize(txt)
        local star = '★ '
        local sw = surface.GetTextSize(star)
        local startX = w/2 - (tw+sw)/2
        draw.SimpleText(star,'MKfont.18',startX,h/2,C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText(txt,'MKfont.18',startX+sw,h/2,C.white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end
    donateBtn.DoClick = function()
        NewClose(fr)
        if IGS and IGS.UI then
            IGS.UI()
        else
            RunConsoleCommand('igs')
        end
    end

    setActiveNav(1)
    BuildMain(fr, p)
end

net.Receive('F4Menu:VGUI', function()
    OpenF4Menu()
end)

concommand.Add('f4_flag_add', function(_, _, args)
    net.Start('F4Gangs:FlagAdmin')
        net.WriteString('add')
        net.WriteString(table.concat(args or {}, ' '))
    net.SendToServer()
end)

concommand.Add('f4_flag_remove', function()
    net.Start('F4Gangs:FlagAdmin')
        net.WriteString('remove')
    net.SendToServer()
end)

hook.Add('PlayerBindPress', 'F4Menu:BindOpen', function(ply, bind, pressed)
	if not pressed then return end
	if bind == 'gm_showspare2' then
		OpenF4Menu()
		return true
	end
end)