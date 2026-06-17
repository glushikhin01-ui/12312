local box       = draw.RoundedBox
local boxex     = draw.RoundedBoxEx
local text      = draw.SimpleText
local hookadd   = hook.Add
local setmat    = surface.SetMaterial
local setcolor  = surface.SetDrawColor
local setsize   = surface.DrawTexturedRect
local ui        = vgui.Create
local getplayerss = player.GetAll
local tcopy     = table.Copy
local tsort     = table.sort

local lol  = Color(1, 89, 224)
local mat2 = Material("hud/players_just.png", "smooth mips")
local mat3 = Material("scoreboard/greenping.png", "smooth mips")
local mat4 = Material("scoreboard/rec3.png", "smooth mips")
local mat5 = Material("scoreboard/steamm.png", "smooth mips")
local mat6 = Material("scoreboard/gotoo.png", "smooth mips")
local mat7 = Material("scoreboard/returnn.png", "smooth mips")
local mat8 = Material("scoreboard/spectatee.png", "smooth mips")

local a = math.Round
local b = math.min

local function n(o)
    local p, q = ScrW(), ScrH()
    return a(o * b(p, q) / 1080)
end

local function SafeTextValue(value, fallback)
    if value == nil then return fallback or "" end
    value = tostring(value)
    if value == "" then return fallback or "" end
    return value
end

local function UTF8SubSafe(str, chars)
    str = SafeTextValue(str)
    chars = tonumber(chars) or 0
    if chars <= 0 then return "" end
    if utf8 and utf8.sub then
        local ok, res = pcall(utf8.sub, str, 1, chars)
        if ok and res then return res end
    end
    if utf8 and utf8.offset then
        local ok, bytePos = pcall(utf8.offset, str, chars + 1)
        if ok and bytePos then return string.sub(str, 1, bytePos - 1) end
    end
    return string.sub(str, 1, chars)
end

local function UTF8LenSafe(str)
    str = SafeTextValue(str)
    if utf8 and utf8.len then
        local ok, len = pcall(utf8.len, str)
        if ok and len then return len end
    end
    return #str
end

local function FitText(str, font, maxWidth)
    str = SafeTextValue(str)
    maxWidth = math.max(0, tonumber(maxWidth) or 0)
    surface.SetFont(font)
    if surface.GetTextSize(str) <= maxWidth then return str end
    if maxWidth <= surface.GetTextSize("...") then return "" end
    local low, high = 0, UTF8LenSafe(str)
    local best = ""
    while low <= high do
        local mid = math.floor((low + high) / 2)
        local candidate = UTF8SubSafe(str, mid) .. "..."
        if surface.GetTextSize(candidate) <= maxWidth then
            best = candidate
            low = mid + 1
        else
            high = mid - 1
        end
    end
    return best
end

local function SimpleTextLimited(str, font, x, y, clr, xalign, yalign, maxWidth)
    text(FitText(str, font, maxWidth), font, x, y, clr, xalign, yalign)
end

local rank_translations = {
    ["*"]              = "Владелец",
    ["co*"]            = "Со-Владелец",
    ["uprav"]          = "Управляющий",
    ["zamuprav"]       = "Зам.Управляющего",
    ["arizonateam"]    = "Команда Проекта",
    ["project-team"]   = "Д-Команда",
    ["manager"]        = "Менеджер",
    ["vice-manager"]   = "Вице-Менеджер",
    ["headcurator"]    = "Главный Куратор",
    ["curator"]        = "Куратор",
    ["headadmin"]      = "Главный Админ",
    ["admin"]          = "Админ",
    ["moderator"]      = "Модератор",
    ["helper"]         = "Хелпер",
    ["intern"]         = "Стажёр",
    ["owner"]          = "Овнер",
    ["superadmin"]     = "Супер-Админ",
    ["dadmin"]         = "Д.Админ",
    ["dmoderator"]     = "Д.Модератор",
    ["vip"]            = "Вип",
    ["user"]           = "Игрок",
}

surface.CreateFont('tabok', {
    size      = n(25),
    weight    = 600,
    antialias = true,
    extended  = true,
    font      = 'Tahoma',
})

surface.CreateFont('rank_badge', {
    size      = n(13),
    weight    = 700,
    antialias = true,
    extended  = true,
    font      = 'Tahoma',
})

surface.CreateFont('scoreboard_name', {
    size      = n(18),
    weight    = 700,
    antialias = true,
    extended  = true,
    font      = 'Tahoma',
})

local logomat = Material('scoreboard/azlogo.png', 'smooth mips')

local buts = {
    {
        name = 'Открыть профиль',
        mat  = mat5,
        clr  = Color(34, 77, 173),
        func = function(s)
            if IsValid(s.target) then
                s.target:ShowProfile()
            end
        end,
    },
    {
        name = 'Копировать SteamID',
        mat  = mat5,
        clr  = Color(34, 77, 173),
        func = function(s)
            if IsValid(s.target) then
                SetClipboardText(s.target:SteamID())
            end
        end,
    },
    {
        name  = 'Телепортироваться',
        mat   = mat6,
        check = function(self)
            return IsValid(self.ply) and self.ply:IsAdmin()
        end,
        func = function(s)
            if IsValid(s.target) then
                RunConsoleCommand('ba', 'goto', s.target:SteamID())
            end
        end,
    },
    {
        name  = 'ТП к себе',
        mat   = mat6,
        check = function(self)
            return IsValid(self.ply) and self.ply:IsAdmin()
        end,
        func = function(s)
            if IsValid(s.target) then
                RunConsoleCommand('ba', 'tp', s.target:SteamID())
            end
        end,
    },
    {
        name  = 'Вернуть',
        mat   = mat7,
        check = function(self)
            return IsValid(self.ply) and self.ply:IsAdmin()
        end,
        func = function(s)
            if IsValid(s.target) then
                RunConsoleCommand('ba', 'return', s.target:SteamID())
            end
        end,
    },
    {
        name  = 'Наблюдать',
        mat   = mat8,
        check = function(self)
            return IsValid(self.ply) and self.ply:IsAdmin()
        end,
        func = function(s)
            if IsValid(s.target) then
                RunConsoleCommand('ba', 'spectate', s.target:SteamID())
            end
        end,
    },
}

local start      = SysTime()
local anim       = 0.5
local scselected = nil
local fr

local function SafeGetJobName(ply)
    if not IsValid(ply) then return "N/A" end
    if ply.GetJobName and type(ply.GetJobName) == "function" then
        local ok, val = pcall(ply.GetJobName, ply)
        if ok and val then return val end
    end
    return team.GetName(ply:Team()) or "Unknown"
end

local function SafeGetJobColor(ply)
    if not IsValid(ply) then return color_white end
    if ply.GetJobColor and type(ply.GetJobColor) == "function" then
        local ok, val = pcall(ply.GetJobColor, ply)
        if ok and val then return val end
    end
    return team.GetColor(ply:Team()) or color_white
end

local function SafeGetPlayTime(ply)
    if not IsValid(ply) then return "00:00" end
    local ok_pt, pt = pcall(function()
        if ply.GetPlayTime and type(ply.GetPlayTime) == "function" then
            return ply:GetPlayTime()
        end
        return nil
    end)
    if ok_pt and pt then
        pt = tonumber(pt) or 0
        if ba and ba.str and ba.str.FormatTime then
            local ok_fmt, str = pcall(ba.str.FormatTime, pt)
            if ok_fmt and str then return str end
        end
        local hrs = math.floor(pt / 3600)
        local mins = math.floor((pt % 3600) / 60)
        return string.format("%02d:%02d", hrs, mins)
    end
    return "00:00"
end

function enc.scoreboard()
    if IsValid(fr) then fr:Remove() end
    fr = vgui.Create('EditablePanel')
    fr:SetSize(enc.w(1120), enc.h(639))
    fr:Center()
    fr:MakePopup()
    fr:SetAlpha(0)
    fr:AlphaTo(255, 0.2)

    function fr:Paint(w, h)
        box(15, 0, 0, w, h, Color(42, 43, 46))
        for i = 0, h do
            local alpha = (i / h) * 10
            surface.SetDrawColor(218, 62, 68, alpha)
            surface.DrawRect(0, i, w, 1)
        end
    end

    do
        local top = vgui.Create('Panel', fr)
        top:Dock(TOP)
        top:DockMargin(enc.w(41), enc.h(30), enc.w(46), 0)
        top:SetTall(enc.h(48))

        function top:Paint(w, h)
            surface.SetFont('tabok')
            local txt = 'ARIZONA'
            local tw, th = surface.GetTextSize(txt)
            local icon_w, icon_h = enc.w(40), enc.h(40)
            local spacing = enc.w(15)
            local shift_x = enc.w(25)
            if logomat and not logomat:IsError() then
                setmat(logomat)
                setcolor(255, 255, 255)
                setsize(w / 2 - tw / 2 - icon_w - spacing + shift_x, h / 2 - icon_h / 2, icon_w, icon_h)
            end
            text(txt, 'tabok', w / 2 + shift_x, h / 2, enc.clrs.white, 1, 1)
        end

        local online = vgui.Create('Panel', top)
        online:Dock(RIGHT)
        online:DockMargin(0, enc.h(9), 0, enc.h(10))
        online:SetWide(enc.w(67))

        function online:Paint(w, h)
            if mat2 and not mat2:IsError() then
                setmat(mat2)
                setcolor(255, 255, 255)
                setsize(0, h / 2 - enc.h(8), enc.w(16), enc.h(16))
            end
            text(player.GetCount(), 'MKfont.24', enc.w(21), h / 2 - 2, enc.clrs.white, 0, 1)
        end
    end

    local cols = {
        name = enc.w(84),
        job  = enc.w(420),
        clan = enc.w(650),
        time = enc.w(905),
    }

    do
        local texts = vgui.Create('Panel', fr)
        texts:Dock(TOP)
        texts:DockMargin(enc.w(26), enc.h(30), enc.w(20), 0)
        texts:SetTall(enc.h(20))

        function texts:Paint(w, h)
            text('Имя',        'MKfont.16', cols.name, h / 2, enc.clrs.whitea, 0, 1)
            text('Профессия',  'MKfont.16', cols.job,  h / 2, enc.clrs.whitea, 1, 1)
            text('Клан',       'MKfont.16', cols.clan, h / 2, enc.clrs.whitea, 1, 1)
            text('Часы',       'MKfont.16', cols.time, h / 2, enc.clrs.whitea, 1, 1)
            text('Пинг',       'MKfont.16', w - enc.w(50), h / 2, enc.clrs.whitea, 2, 1)
        end
    end

    scselected = nil

    do
        local joblist = {}

        if RPExtraTeams then
            for k, v in pairs(RPExtraTeams) do
                local cache = {}
                for _, c in pairs(player.GetAll()) do
                    if IsValid(c) and RPExtraTeams[c:Team()] and RPExtraTeams[c:Team()].category == v.category then
                        local found = false
                        for _, existing in ipairs(cache) do
                            if existing == c then found = true break end
                        end
                        if not found then
                            table.insert(cache, c)
                        end
                    end
                end
                if #cache > 0 then
                    joblist[(v.category or 'nil')] = {
                        players = cache,
                    }
                end
            end
            for k, v in pairs(joblist) do
                table.sort(v.players, function(a, b)
                    return a:Team() < b:Team()
                end)
            end
        else
            local all = player.GetAll()
            if #all > 0 then
                joblist["Players"] = { players = all }
            end
        end

        local player_list = vgui.Create("enc.scroll", fr)
        player_list:Dock(FILL)
        player_list:DockMargin(enc.w(26), enc.h(8), enc.w(12), enc.h(49))

        for k, v in pairs(joblist) do
            for k2, v2 in pairs(v.players) do
                if not IsValid(v2) then continue end

                local row = vgui.Create("DButton", player_list)
                row:Dock(TOP)
                row:SetTall(enc.h(55))
                row:SetText("")
                row:SetColor(team.GetColor(v2:Team()) or color_white)
                row:DockMargin(0, 0, 0, enc.h(5))
                row.Hover = 0

                local bg_alpha = 25
                if k2 % 2 == 0 then bg_alpha = 50 end

                local plyRef = v2
                local plySid = IsValid(v2) and v2:SteamID64() or ""

                row.Paint = function(self, w, h)
    if not IsValid(plyRef) then return end

    local hover = self:IsHovered()
    self.Hover = Lerp(FrameTime() * 8, self.Hover, 0)

    local final_alpha = bg_alpha
    if hover then final_alpha = 127 end
    if scselected ~= nil and scselected == plySid then final_alpha = 127 end

    box(5, 0, 0, w, h, Color(159, 159, 159, final_alpha))

    local rank_raw = SafeTextValue(plyRef:GetUserGroup(), "user")
    local rank_txt = rank_translations[rank_raw] or rank_raw

    local nameAreaEnd = cols.job - enc.w(20)
    local gap         = enc.w(50)
    local padX        = enc.w(12)
    local padY        = enc.h(6)
    local minNameW    = enc.w(35)
    local maxRankW    = math.max(enc.w(44), nameAreaEnd - cols.name - gap - minNameW)

    local rank_fit = FitText(rank_txt, 'rank_badge', math.max(0, maxRankW - padX * 2))
    surface.SetFont('rank_badge')
    local rw, rh = surface.GetTextSize(rank_fit)

    local panel_w = math.max(enc.w(44), math.Round(rw + padX * 2))
    local panel_h = math.max(enc.h(16), math.Round(rh + padY * 2))
    local nameMaxW = math.max(minNameW, nameAreaEnd - cols.name - gap - panel_w)
    local name_txt = FitText(plyRef:Name(), 'scoreboard_name', nameMaxW)

    local centerY = math.Round(h / 2)

    surface.SetFont('scoreboard_name')
    local nw = math.Round(surface.GetTextSize(name_txt))
    text(name_txt, 'scoreboard_name', cols.name, centerY, enc.clrs.white, 0, 1)

    local rank_x = math.Round(cols.name + nw + gap)
    local panel_y = math.Round(centerY - panel_h / 2)

    box(4, rank_x, panel_y, panel_w, panel_h, Color(90, 90, 90, 255))
    local text_x = rank_x + math.Round((panel_w - rw) / 2)
    text(rank_fit, 'rank_badge', text_x, centerY, enc.clrs.white, 0, 1)

    SimpleTextLimited(SafeGetJobName(plyRef), 'MKfont.16', cols.job, centerY, SafeGetJobColor(plyRef), 1, 1, enc.w(220))

    local clan_name = "-"
    if plyRef.GetClan and type(plyRef.GetClan) == "function" then
        local okClan, valClan = pcall(plyRef.GetClan, plyRef)
        if okClan and valClan and valClan ~= "" then clan_name = valClan end
    else
        local nwClan = plyRef:GetNWString("clan", "")
        if nwClan ~= "" then clan_name = nwClan end
    end

    SimpleTextLimited(clan_name, 'MKfont.16', cols.clan + enc.w(20), centerY, enc.clrs.white, 1, 1, enc.w(210))
    SimpleTextLimited(SafeGetPlayTime(plyRef), 'MKfont.16', cols.time, centerY, enc.clrs.white, 1, 1, enc.w(115))

    local ping_str = plyRef:Ping() .. "ms"
    text(ping_str, 'MKfont.16', w - enc.w(50), centerY, enc.clrs.white, 2, 1)

    if mat3 and not mat3:IsError() then
        setmat(mat3)
        if plyRef.GetPingColor then
            setcolor(plyRef:GetPingColor():Unpack())
        else
            setcolor(255, 255, 255)
        end
        setsize(w - enc.w(42), centerY - enc.h(6), enc.w(10), enc.h(12))
    end
end

                function row:DoClick()
                    self.Hover = 255
                    if IsValid(plyRef) then
                        scselected = plyRef:SteamID64()
                        enc.scoreboardright(plyRef)
                    end
                end

                function row:Think()
                    if not IsValid(plyRef) then
                        timer.Simple(0, function()
                            if IsValid(self) then self:Remove() end
                        end)
                    end
                end

                local avatar_bg = vgui.Create('Panel', row)
                avatar_bg:SetSize(enc.w(35), enc.h(35))
                avatar_bg:SetPos(enc.w(12), enc.h(10))

                function avatar_bg:Paint(w, h)
                    draw.RoundedBox(math.floor(w / 2), 0, 0, w, h, Color(217, 217, 217))
                end

                local avatar = vgui.Create('enc.circleavatar', avatar_bg)
                avatar:SetSize(enc.w(31), enc.h(31))
                avatar:SetPos(enc.w(2), enc.h(2))
                avatar:SetPlayer(plyRef, 64)
            end
        end

        local sbar = player_list:GetVBar()
        sbar:SetWide(enc.w(8))
    end
end

local rightfr

local function novisible()
    if IsValid(rightfr) and IsValid(fr) then
        fr:MoveTo(fr:GetX() + enc.w(82), fr:GetY(), 0.2)
        rightfr:MoveTo(rightfr:GetX() + enc.w(82), rightfr:GetY(), 0.2)
        rightfr:AlphaTo(0, 0.2, 0, function()
            if IsValid(rightfr) then rightfr:Remove() end
        end)
    end
end

local function frnovisible()
    if IsValid(fr) then
        fr:AlphaTo(0, 0.2, 0, function()
            if IsValid(fr) then fr:Remove() end
        end)
    end
end

function enc.scoreboardright(pl)
    if not IsValid(pl) then return end
    if not IsValid(fr) then return end

    local doAnim
    if IsValid(rightfr) then
        rightfr:Remove()
    else
        doAnim = true
        fr:MoveTo(fr:GetX() - enc.w(82), fr:GetY(), 0.2)
    end

    rightfr = vgui.Create('Panel')
    rightfr:SetSize(enc.w(270), enc.h(324))
    rightfr:SetX(fr:GetWide() + fr:GetX() + enc.w(21))
    rightfr:CenterVertical()
    rightfr:SetAlpha(0)

    if doAnim then
        rightfr:MoveTo(fr:GetWide() + fr:GetX() - enc.w(82 - 21), rightfr:GetY(), 0.2)
    end

    rightfr:AlphaTo(255, 0.2)

    function rightfr:Paint(w, h)
        box(15, 0, 0, w, h, Color(42, 43, 46))
        for i = 0, h do
            local alpha = (i / h) * 10
            surface.SetDrawColor(218, 62, 68, alpha)
            surface.DrawRect(0, i, w, 1)
        end
    end

    do
        local top = vgui.Create('Panel', rightfr)
        top:Dock(TOP)
        top:DockMargin(enc.w(17), enc.h(16), enc.w(18), 0)
        top:SetTall(enc.h(50))

        function top:Paint(w, h)
            if mat4 and not mat4:IsError() then
                setmat(mat4)
                setcolor(255, 255, 255)
                setsize(0, 0, w, h)
            end
        end

        local avatar_bg = vgui.Create('Panel', rightfr)
        avatar_bg:SetSize(enc.w(42), enc.h(42))
        avatar_bg:SetPos(enc.w(38), enc.h(45))

        function avatar_bg:Paint(w, h)
            draw.RoundedBox(math.floor(w / 2), 0, 0, w, h, Color(217, 217, 217))
        end

        local avatar = vgui.Create('enc.circleavatar', avatar_bg)
        avatar:SetSize(enc.w(38), enc.h(38))
        avatar:SetPos(enc.w(2), enc.h(2))
        avatar:SetPlayer(pl, 64)
    end

    do
        local info = vgui.Create('Panel', rightfr)
        info:Dock(TOP)
        info:DockMargin(enc.w(17), enc.h(31), enc.w(17), 0)
        info:SetTall(enc.h(64))

        local name = vgui.Create('DLabel', info)
        name:Dock(TOP)
        name:SetText(pl:Name())
        name:SetFont('MKfont.16')
        name:SetTextColor(enc.clrs.white)
        name:SizeToContents()

        local job = vgui.Create('DLabel', info)
        job:Dock(TOP)
        job:SetText(SafeGetJobName(pl))
        job:SetFont('MKfont.14')
        job:SetTextColor(SafeGetJobColor(pl))
        job:SizeToContents()

        local rankLabel = vgui.Create('DLabel', info)
        rankLabel:Dock(TOP)
        local r_raw = pl:GetUserGroup()
        rankLabel:SetText(rank_translations[r_raw] or r_raw)
        rankLabel:SetFont('MKfont.14')
        rankLabel:SetTextColor(enc.clrs.whitea)
        rankLabel:SizeToContents()
    end

    do
        local list = vgui.Create('Panel', rightfr)
        list:Dock(TOP)
        list:DockMargin(enc.w(17), enc.h(16), enc.w(18), 0)
        list:SetTall(enc.h(127))
        list.ply = LocalPlayer()

        local y = 0
        for k, v in ipairs(buts) do
            if v.check and not v.check(list) then continue end

            local but = vgui.Create('DButton', list)
            but:Dock(TOP)
            but:DockMargin(0, 0, 0, enc.h(2))
            but:SetTall(enc.h(30))
            but:SetText('')
            but.target = pl

            function but:Paint(w, h)
                local hovered = self:IsHovered()
                box(5, 0, 0, w, h, hovered and Color(159, 159, 159, 127) or Color(159, 159, 159, 64))
                text(v.name, 'MKfont.16', enc.w(32), h / 2, enc.clrs.white, 0, 1)
                if v.mat and not v.mat:IsError() then
                    setmat(v.mat)
                    setcolor(255, 255, 255)
                    setsize(enc.w(9), enc.h(8), enc.w(14), enc.h(14))
                end
            end

            but.DoClick = v.func
            y = y + enc.h(32)
        end

        list:SetTall(y)
        rightfr:SetTall(y + enc.h(187))
    end
end

hookadd('ScoreboardShow', 'enc.scoreboard.open', function()
    enc.scoreboard()
    return true
end)

hookadd('ScoreboardHide', 'enc.scoreboard.remove', function()
    if IsValid(rightfr) then
        novisible()
        frnovisible()
        return true
    end
    if IsValid(fr) then
        frnovisible()
        return true
    end
    return true
end)