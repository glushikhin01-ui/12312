--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

dev.justrp = dev.justrp or {}
if dev.justrp.panel then dev.justrp.panel:Remove() dev.justrp.panel = nil end

dev.documents_cooldown = 0

surface.SetFont('ui.def.18')
local _, yGlobal = surface.GetTextSize('Lorem ipsum')
yGlobal = yGlobal - 4

local function disable(_)
    _.disabled = true
    dev.justrp.panel = nil
end

local function draw_text(text, x, y) -- chtob bistro
    draw.SimpleText(text, 'ui.def.24', x, y, Color(0, 0, 0, alpha))
end

local types = {
    passport = function(pl, job, name, gender, family)
        pl = pl or LocalPlayer()
        job = job or pl:GetJobName()
        name = name or pl:Name()
        gender = gender or 'Муж.'
        family = family or 'Холост'

        local steam = pl:SteamID64() -- Записываем на случай если игрок выйдет!!

        math.randomseed(steam)

        local day, month, year = math.random(1, 29), math.random(1, 12), math.random(1990, 2005)
        local when = ui.makeZero(day) .. '.' .. ui.makeZero(month) .. '.' .. year

        local age = tonumber(os.date('%Y')) - tonumber(year)
        
        math.randomseed(steam)
        code = math.random(1000, 9999)

        local passport = vgui.Create('DPanel')
        dev.justrp.panel = passport
        passport:SetSize(w(582), h(869))
        passport:MakePopup()
        passport:SetPos(ScrW() / 2 - passport:GetWide() / 2, ScrH() / 2)
        passport.data = {
            multi = 0
        }
	    passport.disabled = false

        surface.SetFont('ui.def.20')
        local defaultX, defaultY = surface.GetTextSize('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')

        local model = vgui.Create('DModelPanel', passport)
        model:SetSize(w(155), h(202))
        model:SetPos(w(16), h(548))
	    model:SetFOV(40) 
        model:SetCamPos(Vector(30, 0, 66))
	    model:SetLookAt(Vector(10, 0, 65))
        model:SetModel(pl:GetModel())
        function model:LayoutEntity(ent)
            ent:SetSequence(ent:LookupSequence('pose_standing_01'))
            self:RunAnimation()
            return false
        end

        function passport:Paint(w_, h_)
            self.data.multi = Lerp(FrameTime() * 10, self.data.multi, self.disabled and 0 or 1)
            if self.data.multi <= .1 and self.disabled then self:Remove() end -- eto suicid?

            passport:SetPos(ScrW() / 2 - passport:GetWide() / 2, ScrH() / 2 - (self:GetTall() / 2 * self.data.multi))
            local alpha = 255 * self.data.multi
            model:SetAlpha(alpha >= 0.9 and 255 or alpha)

            --[[ PASSPORT ]]

            local offsetY = h(57) -- offset ramok
            local offsetX = w(9) -- offset ramok

            surface.SetMaterial(Material('justrp_icons/passport_default.png'))
            surface.SetDrawColor(255, 255, 255, alpha)
            surface.DrawTexturedRect(0, 0, w_, h_)

            draw_text('УФМС РОССИИ ПО ГОРОДУ АРИЗОНАГРАД', w(130) + offsetX, h(69) + offsetY) -- given

            local x, y = surface.GetTextSize(when)

            draw_text(when, w(105) + offsetX + (w(105) / 2 - x / 2), h(168) + offsetY) -- data vidachi

            local x, y = surface.GetTextSize(steam)

            draw_text(steam, w(291) + offsetX + (w(244) / 2 - x / 2), h(168) + offsetY) -- steam id

            local x, y = surface.GetTextSize(job) -- center text
            draw_text(job, (w(23) + offsetX) + w(159) / 2 - x / 2, h(289) + offsetY) -- job

            offsetY = offsetY - h(3) -- text siejhaet

            draw_text(name, w(247) + offsetX, h(503) + offsetY) -- nickname
            draw_text(code, w(260) + offsetX, h(542) + offsetY) -- code
            draw_text(gender, w(216) + offsetX, h(581) + offsetY) -- gender
            draw_text(age, w(420) + offsetX, h(581) + offsetY) -- age
            draw_text(family, w(321) + offsetX, h(619) + offsetY) -- polojenie
            draw_text('Аризонаград', w(292) + offsetX, h(657) + offsetY) -- otkyda
        end

        --[[ ESC ]]

        surface.SetFont('ui.notdef.20')
        local x, y = surface.GetTextSize('ESC')
        surface.SetFont('ui.def.20')
        local x2, y2 = surface.GetTextSize('Выход')

        local esc = vgui.Create('DButton', passport)
        esc:SetPos(passport:GetWide() - w(55) - x2, 0)
        esc:SetSize(x + x2 + w(25), h(40))
        esc:SetText('')
        esc.alpha = 0
        esc.hovered = false

        function esc:OnCursorEntered() self.hovered = true end
        function esc:OnCursorExited() self.hovered = false end
        function esc:DoClick() disable(passport) end

        function esc:Paint(w_, h_)
            self.alpha = Lerp(FrameTime() * 10, self.alpha, self.hovered and 255 or 180)
            local alpha = self.alpha * passport.data.multi

            draw.RoundedBox(5, w_ - w(45), 0, w(45), h(40), Color(255, 255, 255, alpha))
            draw.SimpleText('ESC', 'ui.notdef.20', w_ - w(45) / 2 - x / 2, h(40) / 2 - y / 2, Color(0, 0, 0, alpha))
            draw.SimpleText('Выход', 'ui.def.20', w_ - w(55) - x2, y2 / 2, Color(255, 255, 255, alpha))
        end

        --[[ END ]]

        function passport:Think()
            if input.IsKeyDown(KEY_ESCAPE) and not self.disabled then
                disable(self)
                gui.HideGameUI()
            end
        end
    end,
    goverment = function(variant, pl, job, name)
        pl = pl or LocalPlayer()
        job = job or pl:GetJobName()
        name = name or pl:Name()
        variant = variant or 1

        local steam = pl:SteamID64()

        math.randomseed(steam)

        local day, month, year = math.random(1, 29), math.random(1, 12), math.random(1990, 2005); year = year + 18 -- Dobavlyaem 18 let
        local when = ui.makeZero(day) .. '.' .. ui.makeZero(month) .. '.' .. year

        local variants = {
            'passport_general.png', 'passport_korrespondent.png', 'passport_ministr.png', 'passport_polkovnik.png', 'passport_deputat.png',
            'passport_sergant.png'
        }

        --[[
            1 = general
            2 = korrespondent
            3 = ministr
            4 = polkovnik
            5 = deputat
        ]]

        local variant = variants[math.Clamp(variant, 1, #variants)]

        local passport = vgui.Create('DPanel')
        dev.justrp.panel = passport
        passport:SetSize(w(1156), h(391))
        passport:MakePopup()
        passport:SetPos(ScrW() / 2 - passport:GetWide() / 2, ScrH() / 2)
        passport.data = {
            multi = 0
        }
	    passport.disabled = false

        surface.SetFont('ui.def.28')
        local defaultX, defaultY = surface.GetTextSize('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')

        local model = vgui.Create('DModelPanel', passport)
        model:SetSize(w(155), h(202))
        model:SetPos(w(30), h(86))
	    model:SetFOV(40) 
        model:SetCamPos(Vector(30, 0, 66))
	    model:SetLookAt(Vector(10, 0, 65))
        model:SetModel(pl:GetModel())
        function model:LayoutEntity(ent)
            ent:SetSequence(ent:LookupSequence('pose_standing_01'))
            self:RunAnimation()
            return false
        end

        function passport:Paint(w_, h_)
            self.data.multi = Lerp(FrameTime() * 10, self.data.multi, self.disabled and 0 or 1)
            if self.data.multi <= .1 and self.disabled then self:Remove() end -- eto suicid?

            passport:SetPos(ScrW() / 2 - passport:GetWide() / 2, ScrH() / 2 - (self:GetTall() / 2 * self.data.multi))
            local alpha = 255 * self.data.multi
            model:SetAlpha(alpha >= 0.9 and 255 or alpha)

            --[[ GOVERMENT ]]

            local offsetY = h(50) -- offset ramok

            surface.SetMaterial(Material('justrp_icons/'.. variant))
            surface.SetDrawColor(255, 255, 255, alpha)
            surface.DrawTexturedRect(0, 0, w_, h_)

            draw_text(job, w(207), h(64) + offsetY)
            draw_text(name, w(207), h(135) + offsetY)
            draw_text(steam, w(207), h(206) + offsetY)
            draw_text(when, w(38), h(273) + offsetY)
            
            surface.SetFont('ui.def.32')
            local x, y = surface.GetTextSize(job)

            draw.SimpleText(job, 'ui.def.32', w(799) + (w(141) / 2 - x / 2), h(111) + offsetY, Color(0, 0, 0, alpha))
        end

        --[[ ESC ]]

        surface.SetFont('ui.notdef.20')
        local x, y = surface.GetTextSize('ESC')
        surface.SetFont('ui.def.20')
        local x2, y2 = surface.GetTextSize('Выход')

        local esc = vgui.Create('DButton', passport)
        esc:SetPos(passport:GetWide() - w(55) - x2, 0)
        esc:SetSize(x + x2 + w(25), h(40))
        esc:SetText('')
        esc.alpha = 0
        esc.hovered = false

        function esc:OnCursorEntered() self.hovered = true end
        function esc:OnCursorExited() self.hovered = false end
        function esc:DoClick() disable(passport) end

        function esc:Paint(w_, h_)
            self.alpha = Lerp(FrameTime() * 10, self.alpha, self.hovered and 255 or 180)
            local alpha = self.alpha * passport.data.multi

            draw.RoundedBox(5, w_ - w(45), 0, w(45), h(40), Color(255, 255, 255, alpha))
            draw.SimpleText('ESC', 'ui.notdef.20', w_ - w(45) / 2 - x / 2, h(40) / 2 - y / 2, Color(0, 0, 0, alpha))
            draw.SimpleText('Выход', 'ui.def.20', w_ - w(55) - x2, y2 / 2, Color(255, 255, 255, alpha))
        end

        --[[ END ]]

        function passport:Think()
            if input.IsKeyDown(KEY_ESCAPE) and not self.disabled then
                disable(self)
                gui.HideGameUI()
            end
        end
    end,
    driver = function(pl, name)
        pl = pl or LocalPlayer()
        name = name or pl:Name()

        local steam = pl:SteamID64()

        math.randomseed(pl:SteamID64())

        local day, month, year = math.random(1, 29), math.random(1, 12), math.random(1990, 2005)
        local age = tonumber(os.date('%Y')) - tonumber(year)
        year = year + 18 -- Dobavlyaem 18 let
        local when = ui.makeZero(day) .. '.' .. ui.makeZero(month) .. '.' .. year

        local passport = vgui.Create('DPanel')
        dev.justrp.panel = passport
        passport:SetSize(w(573), h(395))
        passport:MakePopup()
        passport:SetPos(ScrW() / 2 - passport:GetWide() / 2, ScrH() / 2)
        passport.data = {
            multi = 0
        }
	    passport.disabled = false

        surface.SetFont('ui.def.28')
        local defaultX, defaultY = surface.GetTextSize('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')

        local model = vgui.Create('DModelPanel', passport)
        model:SetSize(w(143), h(187))
        model:SetPos(w(18), h(130))
	    model:SetFOV(40) 
        model:SetCamPos(Vector(30, 0, 66))
	    model:SetLookAt(Vector(10, 0, 65))
        model:SetModel(pl:GetModel())
        function model:LayoutEntity(ent)
            ent:SetSequence(ent:LookupSequence('pose_standing_01'))
            self:RunAnimation()
            return false
        end
        
        function passport:Paint(w_, h_)
            self.data.multi = Lerp(FrameTime() * 10, self.data.multi, self.disabled and 0 or 1)
            if self.data.multi <= .1 and self.disabled then self:Remove() end -- eto suicid?

            passport:SetPos(ScrW() / 2 - passport:GetWide() / 2, ScrH() / 2 - (self:GetTall() / 2 * self.data.multi))
            local alpha = 255 * self.data.multi
            model:SetAlpha(alpha >= 0.9 and 255 or alpha)

            --[[ DRIVE ]]

            local offsetY = h(50) -- offset ramok

            surface.SetMaterial(Material('justrp_icons/passport_drive.png'))
            surface.SetDrawColor(255, 255, 255, alpha)
            surface.DrawTexturedRect(0, 0, w_, h_)

            draw_text(name, w(177), h(103) + offsetY)
            draw_text(steam, w(177), h(239) + offsetY)
            draw_text(when, w(447), h(290) + offsetY)
            draw_text(age, w(177), h(169) + offsetY)
        end

        --[[ ESC ]]

        surface.SetFont('ui.notdef.20')
        local x, y = surface.GetTextSize('ESC')
        surface.SetFont('ui.def.20')
        local x2, y2 = surface.GetTextSize('Выход')

        local esc = vgui.Create('DButton', passport)
        esc:SetPos(passport:GetWide() - w(55) - x2, 0)
        esc:SetSize(x + x2 + w(25), h(40))
        esc:SetText('')
        esc.alpha = 0
        esc.hovered = false

        function esc:OnCursorEntered() self.hovered = true end
        function esc:OnCursorExited() self.hovered = false end
        function esc:DoClick() disable(passport) end

        function esc:Paint(w_, h_)
            self.alpha = Lerp(FrameTime() * 10, self.alpha, self.hovered and 255 or 180)
            local alpha = self.alpha * passport.data.multi

            draw.RoundedBox(5, w_ - w(45), 0, w(45), h(40), Color(255, 255, 255, alpha))
            draw.SimpleText('ESC', 'ui.notdef.20', w_ - w(45) / 2 - x / 2, h(40) / 2 - y / 2, Color(0, 0, 0, alpha))
            draw.SimpleText('Выход', 'ui.def.20', w_ - w(55) - x2, y2 / 2, Color(255, 255, 255, alpha))
        end

        --[[ END ]]

        function passport:Think()
            if input.IsKeyDown(KEY_ESCAPE) and not self.disabled then
                disable(self)
                gui.HideGameUI()
            end
        end
    end
}

local function build(_type, ...)
    if dev.justrp.panel then disable(dev.justrp.panel) end
    local args = {...}

    if type(types[_type]) == 'function' then
        return types[_type](unpack(args))
    end
end 

local i = 1
local ii = 1

concommand.Add('justrp_build', function() 
    if not LocalPlayer():IsSuperAdmin() then return false end

    local selectors = {
        function() build('passport') i = i + 1 end,
        function() if ii == 5 then i = i + 1 end build('goverment', ii) ii = ii + 1 end,
        function() build('driver') i = 1; ii = 1 end,
    }

    selectors[i]()    
end)
concommand.Add('justrp_reset', function()
    if not LocalPlayer():IsSuperAdmin() then return false end
    if dev.justrp.panel then dev.justrp.panel:Remove() dev.justrp.panel = nil end
end)

function dev.justrp_passpport(swep, pl)
    local swep_category = {
        passport_default = function() build('passport', pl) end,
        passport_drive = function() build('driver', pl) end,
        passport_general = function() build('goverment', 1, pl) end,
        passport_korrespondent = function() build('goverment', 2, pl) end,
        passport_ministr = function() build('goverment', 3, pl) end,
        passport_polkovnik = function() build('goverment', 4, pl) end,
        passport_deputat = function() build('goverment', 5, pl) end,
        passport_sergant = function() build('goverment', 6, pl) end,
        --[[
        паспорт-служебный = function() build('goverment', type, pl)
            type = 1 - 5
            1 = general
            2 = korrespondent
            3 = ministr
            4 = polkovnik
            5 = deputat

        вод. права = function() build('driver', pl) end
        ]]
    }

    if type(swep_category[swep]) == 'function' then swep_category[swep]() end
end

net.Receive('justrp_documents_request', function(len)
    local swep = net.ReadString()
    local pl = net.ReadPlayer()

    Derma_Query(pl:Name() .. ' предлагает вам посмореть свои документы', 'Предложение', 'Отказаться', function() end, 'Согласиться', function() dev.justrp_passpport(swep, pl) end)
end)


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
