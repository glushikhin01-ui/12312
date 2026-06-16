if SERVER then return end

surface.CreateFont("D_Title", { font = "Roboto", size = 20, weight = 700, antialias = true })
surface.CreateFont("D_Label", { font = "Roboto", size = 13, weight = 600, antialias = true })
surface.CreateFont("D_Small", { font = "Roboto", size = 11, weight = 400, antialias = true })
surface.CreateFont("D_Big",   { font = "Roboto", size = 38, weight = 900, antialias = true })
surface.CreateFont("D_HUD",   { font = "Roboto", size = 48, weight = 900, antialias = true })

local WHITE  = Color(255, 255, 255)
local GRAY   = Color(180, 180, 180)
local DARK   = Color(100, 100, 100)
local RED    = Color(220, 60,  60)
local GREEN  = Color(50,  200, 80)

local BG_HEADER  = Color(20,  20,  20,  200)
local BG_CARD    = Color(30,  30,  30,  160)
local BG_CARD_S  = Color(220, 60,  60,  200)
local BG_CARD_H  = Color(50,  50,  50,  180)
local BG_PANEL   = Color(15,  15,  15,  180)
local BG_BTN_RED = Color(200, 50,  50,  220)
local BG_BTN_GRY = Color(60,  60,  60,  200)

local function R(r,x,y,w,h,c) draw.RoundedBox(r,x,y,w,h,c) end
local function T(s,f,x,y,c,ax,ay) draw.SimpleText(s,f,x,y,c,ax or 0,ay or 0) end
local function LC(t,a,b) return Color(Lerp(t,a.r,b.r),Lerp(t,a.g,b.g),Lerp(t,a.b,b.b),Lerp(t,a.a or 255,b.a or 255)) end

local blurMat = Material("pp/blurscreen")
local function Blur(panel, x, y, w, h)
	if not IsValid(panel) then return end
	local x2,y2 = panel:LocalToScreen(x,y)
	surface.SetMaterial(blurMat)
	surface.SetDrawColor(255,255,255,255)
	for i=1,3 do
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRectUV(x,y,w,h, x2/ScrW(), y2/ScrH(), (x2+w)/ScrW(), (y2+h)/ScrH())
	end
end

function DuelMenu()
	if IsValid(DuelMenuFrame) then DuelMenuFrame:Remove() end

	local W, H = 820, 560
	local sel = { target=nil, arena=nil, wepKey=nil, isDon=false }

	local frame = vgui.Create("DFrame")
	DuelMenuFrame = frame
	frame:SetSize(W, H)
	frame:Center()
	frame:SetTitle("")
	frame:ShowCloseButton(false)
	frame:SetDraggable(true)
	frame:MakePopup()

	frame.Paint = function(s,w,h)
		Blur(s, 0, 0, w, h)
		R(0,0,0,w,h,Color(10,10,15,170))
		R(0,0,0,w,52,BG_HEADER)
		surface.SetDrawColor(RED)
		surface.DrawRect(0,52,w,1)
		T("АРЕНЫ","D_Title",16,26,WHITE,0,1)
		R(4,w-54,14,42,24,Color(50,50,50,200))
		T("ESC","D_Small",w-33,26,WHITE,1,1)
		T("Выход","D_Small",w-62,26,GRAY,2,1)
	end

	local escBtn = frame:Add("DButton")
	escBtn:SetPos(W-56,14) escBtn:SetSize(44,24) escBtn:SetText("")
	escBtn.Paint = function() end
	escBtn.DoClick = function() frame:Remove() end

	local content = frame:Add("EditablePanel")
	content:SetPos(0,53) content:SetSize(W,H-53)
	content.Paint = function() end

	local function Clear() for _,v in ipairs(content:GetChildren()) do v:Remove() end end

	local function NavBtn(parent,label,x,y,w,h,isRed,fn)
		local b = parent:Add("DButton")
		b:SetPos(x,y) b:SetSize(w,h) b:SetText("") b._hov=0
		b.Paint = function(s,sw,sh)
			s._hov = Lerp(FrameTime()*10,s._hov,s:IsHovered() and 1 or 0)
			local bg = isRed and LC(s._hov,BG_BTN_RED,Color(240,70,70,220)) or LC(s._hov,BG_BTN_GRY,Color(80,80,80,220))
			R(4,0,0,sw,sh,bg)
			T(label,"D_Label",sw/2,sh/2,WHITE,1,1)
		end
		b.DoClick = fn or function() end
		return b
	end

	local PageWeapon, PageArena, PagePlayers

	local function PageBet()
		Clear()
		local PW,PH = W,H-53

		local root = content:Add("EditablePanel")
		root:SetPos(0,0) root:SetSize(PW,PH)
		root.Paint = function(s,w,h)
			R(0,0,0,220,h,BG_PANEL)
			surface.SetDrawColor(40,40,40,150)
			surface.DrawRect(220,0,1,h)
		end

		local lp = root:Add("EditablePanel")
		lp:SetPos(0,0) lp:SetSize(220,PH)
		lp.Paint = function(s,w,h)
			T("ИТОГ ВЫБОРА","D_Small",w/2,18,GRAY,1,0)
			surface.SetDrawColor(50,50,50,200)
			surface.DrawRect(14,32,w-28,1)
			local rows = {
				{"Соперник", sel.target and sel.target:Name() or "—"},
				{"Арена",    sel.arena  and rp.duels.arenas[sel.arena].name or "—"},
				{"Оружие",   sel.wepKey and (rp.duels.weapons[sel.wepKey] and rp.duels.weapons[sel.wepKey].name) or "—"},
				{"Валюта",   sel.isDon  and "Донат" or "Игровая"},
			}
			local iy = 42
			for _,row in ipairs(rows) do
				T(row[1],"D_Small",14,iy,DARK)
				T(row[2],"D_Label",14,iy+14,WHITE)
				surface.SetDrawColor(35,35,35,180)
				surface.DrawRect(14,iy+30,w-28,1)
				iy = iy+40
			end
		end

		local rp2 = root:Add("EditablePanel")
		rp2:SetPos(230,0) rp2:SetSize(PW-240,PH)
		rp2.Paint = function(s,w,h)
			T("Выберите ставку","D_Title",w/2,18,WHITE,1,0)
		end

		local minBet = sel.isDon and 50 or 100000
		local maxBet = sel.isDon and LocalPlayer():IGSFunds() or LocalPlayer():GetMoney()
		maxBet = math.max(minBet,maxBet)
		local curBet = minBet

		local disp = rp2:Add("EditablePanel")
		disp:SetPos(0,50) disp:SetSize(PW-240,72)
		disp.Paint = function(s,w,h)
			R(6,0,0,w,h,BG_CARD)
			surface.SetDrawColor(RED.r,RED.g,RED.b,60)
			surface.DrawOutlinedRect(0,0,w,h,1)
			local sym = sel.isDon and "DONATE  " or "$  "
			T(sym..math.Round(curBet),"D_Big",w/2,h/2,RED,1,1)
		end

		local slW = PW-240
		local sl = rp2:Add("EditablePanel")
		sl:SetPos(0,134) sl:SetSize(slW,28)
		local drag = false
		sl.Paint = function(s,w,h)
			R(3,0,12,w,6,Color(40,40,40,200))
			local pct = (curBet-minBet)/math.max(maxBet-minBet,1)
			if pct>0 then R(3,0,12,math.floor(w*pct),6,RED) end
			local hx = math.Clamp(math.floor(w*pct)-7,0,w-14)
			R(3,hx,6,14,16,WHITE)
		end
		sl:SetCursor("hand")
		sl.OnMousePressed  = function() drag = true end
		sl.OnMouseReleased = function() drag = false end
		sl.Think = function(s)
			if drag and input.IsMouseDown(MOUSE_LEFT) then
				local cx = select(1, s:CursorPos())
				local pct = math.Clamp(cx/s:GetWide(),0,1)
				curBet = math.Round(Lerp(pct,minBet,maxBet))
			end
		end

		local rng = rp2:Add("EditablePanel")
		rng:SetPos(0,164) rng:SetSize(slW,16)
		rng.Paint = function(s,w,h)
			T("МИН "..minBet,"D_Small",0,0,DARK)
			T("МАКС "..maxBet,"D_Small",w,0,DARK,2,0)
		end

		local qL = {"МИН","25%","50%","МАКС"}
		local qV = {minBet,math.floor(maxBet*.25),math.floor(maxBet*.5),maxBet}
		local qW2 = math.floor((slW-18)/4)
		for i,qv in ipairs(qV) do
			local qb = rp2:Add("DButton")
			qb:SetPos((i-1)*(qW2+6),186) qb:SetSize(qW2,28) qb:SetText("") qb._h=0
			qb.Paint = function(s,w,h)
				s._h = Lerp(FrameTime()*10,s._h,s:IsHovered() and 1 or 0)
				R(4,0,0,w,h,LC(s._h,BG_CARD,BG_CARD_H))
				surface.SetDrawColor(60,60,60,150) surface.DrawOutlinedRect(0,0,w,h,1)
				T(qL[i],"D_Small",w/2,h/2,GRAY,1,1)
			end
			qb.DoClick = function() curBet = qv end
		end

		NavBtn(rp2,"ОТПРАВИТЬ ВЫЗОВ НА ДУЭЛЬ",0,PH-96,slW,44,true,function()
			local aIdx = sel.arena or math.random(#rp.duels.arenas)
			local wk = sel.wepKey
			if not wk then
				local ks={} for k in pairs(rp.duels.weapons) do ks[#ks+1]=k end
				wk = ks[math.random(#ks)]
			end
			net.Start("GetDuelRequest")
			net.WriteBool(sel.isDon)
			net.WriteUInt(math.Round(curBet),32)
			net.WriteEntity(sel.target)
			net.WriteUInt(aIdx,8)
			net.WriteString(wk)
			net.SendToServer()
			frame:Remove()
		end)
		NavBtn(rp2,"НАЗАД",0,PH-46,120,34,false,function() PageWeapon() end)
	end

	PageWeapon = function()
		Clear()
		local PW,PH = W,H-53

		local root = content:Add("EditablePanel")
		root:SetPos(0,0) root:SetSize(PW,PH)
		root.Paint = function(s,w,h)
			T("Выберите оружие","D_Title",w/2,16,WHITE,1,0)
		end

		local COLS=4
		local PAD=14
		local CW=math.floor((PW-PAD*(COLS+1))/COLS)
		local CH=100

		local scrl = root:Add("DScrollPanel")
		scrl:SetPos(PAD,44) scrl:SetSize(PW-PAD*2,PH-44-50)
		local vb = scrl:GetVBar() vb:SetWide(3)
		vb.Paint         = function(s,w,h) R(2,0,0,w,h,Color(30,30,30,150)) end
		vb.btnGrip.Paint = function(s,w,h) R(2,0,0,w,h,RED) end
		vb.btnUp.Paint   = function() end
		vb.btnDown.Paint = function() end

		local total = table.Count(rp.duels.weapons)
		local rows  = math.ceil(total/COLS)
		local grid  = scrl:Add("EditablePanel")
		grid:SetSize(scrl:GetWide(),rows*(CH+8))
		grid.Paint = function() end

		local idx = 0
		for key,data in SortedPairsByMemberValue(rp.duels.weapons,"name") do
			local c    = idx%COLS
			local r    = math.floor(idx/COLS)
			local card = grid:Add("DButton")
			card:SetPos(c*(CW+PAD),r*(CH+8)) card:SetSize(CW,CH)
			card:SetText("") card._h=0
			card.Paint = function(s,w,h)
				s._h = Lerp(FrameTime()*10,s._h,s:IsHovered() and 1 or 0)
				local isSel = sel.wepKey==key
				local busy  = data.ready
				local bgC   = isSel and BG_CARD_S or busy and Color(35,10,10,180) or LC(s._h,BG_CARD,BG_CARD_H)
				R(6,0,0,w,h,bgC)
				T(data.name,"D_Label",w/2,h/2-6,busy and DARK or WHITE,1,1)
				local st = busy and "ЗАНЯТО" or isSel and "ВЫБРАНО" or ""
				T(st,"D_Small",w/2,h/2+10,busy and DARK or GREEN,1,0)
			end
			card.DoClick = function() if data.ready then return end sel.wepKey=key end
			idx = idx+1
		end

		NavBtn(root,"ДАЛЕЕ: СТАВКА",PW-180,PH-42,166,34,true,function()
			if not sel.wepKey then
				local ks={} for k in pairs(rp.duels.weapons) do ks[#ks+1]=k end
				sel.wepKey = ks[math.random(#ks)]
			end
			PageBet()
		end)
		NavBtn(root,"НАЗАД",PAD,PH-42,120,34,false,function() PageArena() end)
	end

	PageArena = function()
		Clear()
		local PW,PH = W,H-53

		local root = content:Add("EditablePanel")
		root:SetPos(0,0) root:SetSize(PW,PH)
		root.Paint = function(s,w,h)
			T("Выберите арену","D_Title",w/2,16,WHITE,1,0)
			surface.SetDrawColor(50,50,50,150)
			surface.DrawRect(14,240,w-28,1)
			T("ТИП ВАЛЮТЫ","D_Small",w/2,250,GRAY,1,0)
		end

		local AC  = {RED, Color(210,130,30,255), Color(50,130,210,255)}
		local CW2 = math.floor((PW-56)/3)
		local CH2 = 160

		for i,arena in ipairs(rp.duels.arenas) do
			local cx   = 14+(i-1)*(CW2+14)
			local ac   = AC[i]
			local card = root:Add("DButton")
			card:SetPos(cx,38) card:SetSize(CW2,CH2) card:SetText("") card._h=0
			card.Paint = function(s,w,h)
				s._h = Lerp(FrameTime()*10,s._h,s:IsHovered() and 1 or 0)
				local isSel = sel.arena==i
				local busy  = arena.ready
				local bgC   = isSel and BG_CARD_S or busy and Color(30,10,10,180) or LC(s._h,BG_CARD,BG_CARD_H)
				R(8,0,0,w,h,bgC)
				if isSel then
					surface.SetDrawColor(ac) surface.DrawOutlinedRect(0,0,w,h,2)
				end
				local nc = busy and DARK or isSel and WHITE or Color(ac.r,ac.g,ac.b,180+math.floor(s._h*75))
				T(tostring(i),"D_Big",w/2,h/2-20,nc,1,1)
				T(arena.name,"D_Label",w/2,h-40,busy and DARK or WHITE,1,0)
				local st = busy and "ЗАНЯТА" or isSel and "ВЫБРАНА" or "СВОБОДНА"
				local sc = busy and DARK or isSel and GREEN or GRAY
				T(st,"D_Small",w/2,h-22,sc,1,0)
			end
			card.DoClick = function() if arena.ready then return end sel.arena=i end
		end

		local bW = math.floor((PW-42)/2)
		local function CurBtn(x,label,isDonVal,selColor)
			local b = root:Add("DButton")
			b:SetPos(x,266) b:SetSize(bW,40) b:SetText("") b._h=0
			b.Paint = function(s,w,h)
				s._h = Lerp(FrameTime()*10,s._h,s:IsHovered() and 1 or 0)
				local isSel = sel.isDon==isDonVal
				local bgC   = isSel and Color(selColor.r*.3,selColor.g*.3,selColor.b*.3,220) or LC(s._h,BG_CARD,BG_CARD_H)
				R(5,0,0,w,h,bgC)
				if isSel then surface.SetDrawColor(selColor) surface.DrawOutlinedRect(0,0,w,h,1) end
				T(label,"D_Label",w/2,h/2,isSel and selColor or GRAY,1,1)
			end
			b.DoClick = function() sel.isDon=isDonVal end
		end
		CurBtn(14,"ИГРОВАЯ  ( $ )",false,GREEN)
		CurBtn(14+bW+14,"ДОНАТ-ВАЛЮТА",true,Color(210,130,30))

		NavBtn(root,"ДАЛЕЕ: ОРУЖИЕ",PW-180,PH-42,166,34,true,function()
			if not sel.arena then sel.arena=math.random(#rp.duels.arenas) end
			PageWeapon()
		end)
		NavBtn(root,"НАЗАД",14,PH-42,120,34,false,function() PagePlayers() end)
	end

	PagePlayers = function()
		Clear()
		local PW,PH = W,H-53

		local root = content:Add("EditablePanel")
		root:SetPos(0,0) root:SetSize(PW,PH)
		root.Paint = function(s,w,h)
			T("Выберите соперника","D_Title",w/2,16,WHITE,1,0)
			local cnt = #player.GetAll()-1
			T("Онлайн: "..cnt.." игроков","D_Small",w/2,36,GRAY,1,0)
			surface.SetDrawColor(50,50,50,150)
			surface.DrawRect(14,50,w-28,1)
		end

		local scrl = root:Add("DScrollPanel")
		scrl:SetPos(14,56) scrl:SetSize(PW-28,PH-56-50)
		local vb = scrl:GetVBar() vb:SetWide(3)
		vb.Paint         = function(s,w,h) R(2,0,0,w,h,Color(30,30,30,150)) end
		vb.btnGrip.Paint = function(s,w,h) R(2,0,0,w,h,RED) end
		vb.btnUp.Paint   = function() end
		vb.btnDown.Paint = function() end

		local ROW  = 60
		local plys = player.GetAll()
		table.sort(plys,function(a,b) return a:Name()<b:Name() end)

		for _,ply in ipairs(plys) do
			if ply==LocalPlayer() then continue end
			local busy = ply.dueltarget~=nil

			local row = scrl:Add("DButton")
			row:SetSize(scrl:GetWide()-4,ROW)
			row:Dock(TOP) row:DockMargin(0,0,0,6)
			row:SetText("") row._h=0

			row.Paint = function(s,w,h)
				s._h = Lerp(FrameTime()*10,s._h,s:IsHovered() and 1 or 0)
				local isSel = sel.target==ply
				local bgC   = isSel and BG_CARD_S or busy and Color(32,10,10,180) or LC(s._h,BG_CARD,BG_CARD_H)
				R(6,0,0,w,h,bgC)
				local avBg = isSel and Color(255,255,255,40) or Color(60,60,60,180)
				R(5,10,(h-40)/2,40,40,avBg)
				T(string.upper(string.sub(ply:Name(),1,1)),"D_Title",30,h/2,WHITE,1,1)
				T(ply:Name(),"D_Label",62,h/2-9,busy and DARK or WHITE)
				T(ply:SteamID(),"D_Small",62,h/2+6,DARK)
				if busy then
					R(4,w-86,h/2-9,78,18,Color(50,10,10,200))
					T("В ДУЭЛИ","D_Small",w-47,h/2,RED,1,1)
				elseif isSel then
					R(4,w-86,h/2-9,78,18,Color(10,50,15,200))
					T("ВЫБРАН","D_Small",w-47,h/2,GREEN,1,1)
				end
			end

			row.DoClick = function()
				if busy then return end
				sel.target = ply
			end
		end

		NavBtn(root,"ДАЛЕЕ: АРЕНА",PW-180,PH-42,166,34,true,function()
			if not sel.target then return end
			PageArena()
		end)
	end

	PagePlayers()
end

net.Receive("Duels_OpenMenu", function() DuelMenu() end)

net.Receive("SendDuelRequest", function()
	local idx   = net.ReadUInt(8)
	local state = net.ReadBool()
	if rp.duels.arenas[idx] then rp.duels.arenas[idx].ready=state end
end)

net.Receive("DuelSend", function()
	local isEnd = net.ReadBool()
	local isWin = isEnd and net.ReadBool() or false
	local t     = CurTime()

	if isEnd then
		hook.Remove("HUDPaint","Duels_Timer")
		local txt = isWin and "ПОБЕДА" or "ПОРАЖЕНИЕ"
		local col = isWin and GREEN or RED

		if isWin then
			sound.PlayURL("https://cdn.discordapp.com/attachments/1094995654301990973/1095020456974745693/You_Win_Street_Fighter_-_Sound_Effect_256_kbps.mp3","mono",function(s) if IsValid(s) then s:Play() end end)
		else
			sound.PlayURL("https://cdn.discordapp.com/attachments/1094995654301990973/1095020518060589128/You_Lose_-_Sound_Effect_HD_256_kbps.mp3","mono",function(s) if IsValid(s) then s:Play() end end)
		end

		local expire = t+3.5
		hook.Add("HUDPaint","Duels_Result",function()
			if CurTime()>expire then hook.Remove("HUDPaint","Duels_Result") return end
			local a  = math.Clamp((expire-CurTime())/3.5*255,0,255)
			local sw = ScrW()
			local nw,nh = 280,48
			local nx,ny = sw/2-nw/2,18
			draw.RoundedBox(6,nx,ny,nw,nh,Color(15,15,15,math.floor(a*0.9)))
			surface.SetDrawColor(col.r,col.g,col.b,math.floor(a))
			surface.DrawRect(nx,ny,nw,2)
			surface.DrawOutlinedRect(nx,ny,nw,nh,1)
			draw.SimpleText(txt,"D_Title",sw/2,ny+nh/2,Color(col.r,col.g,col.b,math.floor(a)),1,1)
		end)
		return
	end

	sound.PlayURL("https://cdn.discordapp.com/attachments/1094995654301990973/1095021959810666536/15081----_mp3cut.net_1.mp3","mono",function(s) if IsValid(s) then s:Play() end end)
	local startT = t+3
	local endT   = t+123

	hook.Add("HUDPaint","Duels_Timer",function()
		if CurTime()>endT then hook.Remove("HUDPaint","Duels_Timer") return end
		local sw = ScrW()
		local rem,label,col
		if CurTime()<startT then
			rem=math.ceil(startT-CurTime()) label="ДО НАЧАЛА" col=Color(210,130,30)
		else
			rem=math.ceil(endT-CurTime()) label="ОСТАЛОСЬ" col=rem<20 and RED or WHITE
		end
		local bw,bh = 180,64
		local bx,by = sw/2-bw/2,16
		R(6,bx,by,bw,bh,Color(0,0,0,200))
		surface.SetDrawColor(col.r,col.g,col.b,140) surface.DrawRect(bx,by,bw,2)
		T(label,"D_Small",sw/2,by+12,GRAY,1,0)
		T(tostring(rem),"D_HUD",sw/2,by+20,col,1,0)
	end)
end)

concommand.Add("duel_menu",function() DuelMenu() end)
