--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local ScrW=ScrW;local ScrH=ScrH;local a=math.Round;local b=math.min;local c=surface.CreateFont;local d=table.insert;local e=math.rad;local f=math.sin;local g=math.cos;local h=surface.SetDrawColor;local i=draw.NoTexture;local j=surface.DrawPoly;local k=math.floor;local l=math.Clamp;local m=surface.DrawRect;local function n(o)local p,q=ScrW(),ScrH()return a(o*b(p,q)/1080)end;local function r(s,o,t,u,v,w,x)x=x or 80;t=-t+180;local y={}d(y,{x=s,y=o})for z=0,x do local A=e(z/x*-u+t)d(y,{x=s+f(A)*v,y=o+g(A)*v})end;h(w)i()j(y)end;function DrawRoundedBoxEx(B,s,o,C,D,E,F,G,H,I)s=k(s)o=k(o)C=k(C)D=k(D)B=l(k(B),0,b(D/2,C/2))if B==0 then h(E)m(s,o,C,D)return end;h(E)m(s+B,o,C-B*2,B)m(s,o+B,C,D-B*2)m(s+B,o+D-B,C-B*2,B)if F then r(s+B,o+B,270,90,B,E,B)else h(E)m(s,o,B,B)end;if G then r(s+C-B,o+B,0,90,B,E,B)else h(E)m(s+C-B,o,B,B)end;if H then r(s+B,o+D-B,180,90,B,E,B)else h(E)m(s,o+D-B,B,B)end;if I then r(s+C-B,o+D-B,90,90,B,E,B)else h(E)m(s+C-B,o+D-B,B,B)end end;function DrawRoundedBox(B,s,o,C,D,E)DrawRoundedBoxEx(B,s,o,C,D,E,true,true,true,true)end

-- Font creation function (called on init and resolution change)
local function createHudFonts()
    local function sc(v) return a(v * b(ScrW(), ScrH()) / 1080) end
    c('hFont',  {size = sc(24), weight = 350, antialias = true, extended = true, font = 'Inter Bold'})
    c('hFont2', {size = sc(18), weight = 350, antialias = true, extended = true, font = 'Inter Bold'})
    c('hFont3', {size = sc(36), weight = 350, antialias = true, extended = true, font = 'Inter Bold'})
    c('hFont4', {size = sc(20), weight = 350, antialias = true, extended = true, font = 'Inter Bold'})
    c('hFont5', {size = sc(64), weight = 350, antialias = true, extended = true, font = 'Inter Bold'})
    c('hFont6', {size = sc(28), weight = 350, antialias = true, extended = true, font = 'Inter Bold'})
    c('hudCardTitle', {size = sc(16), weight = 600, antialias = true, extended = true, font = 'Inter Bold'})
    c('hudCardSub',   {size = sc(12), weight = 500, antialias = true, extended = true, font = 'Inter Bold'})
end

createHudFonts()

hook.Add('OnScreenSizeChanged', 'JustRP.HUD.Fonts', function()
    createHudFonts()
end)
