--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

local function ss(w)
	return w * (ScrW() / 1920)
end

local function a(b)
	local c, d = ScrW(), ScrH()
	return math.Round(b * math.min(c, d) / 1080)
end

surface.CreateFont("lFont3", {
	font = "Inter Bold",
	size = a(26),
	antialias = true,
	extended = true,
	weight = 350
})

local function DrawRoundedMaterial(radius, x, y, w, h, mat, col)
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilWriteMask(255)
	render.SetStencilTestMask(255)
	render.SetStencilReferenceValue(1)
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.OverrideColorWriteEnable(true, false)
	DrawRoundedBox(radius, x, y, w, h, color_white)
	render.OverrideColorWriteEnable(false, false)
	render.SetStencilCompareFunction(STENCIL_EQUAL)
	render.SetStencilPassOperation(STENCIL_KEEP)
	surface.SetMaterial(mat)
	surface.SetDrawColor(col or color_white)
	surface.DrawTexturedRect(x, y, w, h)
	render.SetStencilEnable(false)
end

timer.Simple(1, function()
	surface.CreateFont("lFont", {
		font = "Inter Bold",
		size = a(28),
		antialias = true,
		extended = true,
		weight = 350
	})

	surface.CreateFont("lFont2", {
		font = "Inter Semi Bold",
		size = a(18),
		antialias = true,
		extended = true,
		weight = 350
	})

	local e = {
		laws_mat = Material('hud/zakkon.png', 'smooth mips')
	}

	local f = {
		w = Color(255, 255, 255),
		b = Color(30, 30, 30, 140),
		h = Color(30, 30, 30, 200),
		cardBg = Color(42, 43, 46),
		dimmer = Color(217, 217, 217, 64),
	}

	local ACCENT = Color(56, 182, 210)

	local function g(h, b, i, j, k, f)
		surface.SetDrawColor(f)
		surface.SetMaterial(k)
		surface.DrawTexturedRect(h, b, i, j)
	end

	local function drawGradientOverlay(radius, x, y, w, h, accent)
		render.ClearStencil()
		render.SetStencilEnable(true)
		render.SetStencilWriteMask(255)
		render.SetStencilTestMask(255)
		render.SetStencilReferenceValue(1)
		render.SetStencilCompareFunction(STENCIL_ALWAYS)
		render.SetStencilPassOperation(STENCIL_REPLACE)
		render.SetStencilFailOperation(STENCIL_KEEP)
		render.SetStencilZFailOperation(STENCIL_KEEP)
		render.OverrideColorWriteEnable(true, false)
		DrawRoundedBox(radius, x, y, w, h, color_white)
		render.OverrideColorWriteEnable(false, false)
		render.SetStencilCompareFunction(STENCIL_EQUAL)
		render.SetStencilPassOperation(STENCIL_KEEP)
		for i = 0, h - 1 do
			local alpha = (i / h) * 26
			surface.SetDrawColor(accent.r, accent.g, accent.b, alpha)
			surface.DrawRect(x, y + i, w, 1)
		end
		render.SetStencilEnable(false)
	end

	local cachedLawsText = ""

	local function l()
		print('але')

		local m = LocalPlayer()
		local n = ScrW()

		laws = vgui.Create('Panel')
		laws:SetSize(a(320), 0)
		laws:SetPos(n - laws:GetWide() - a(12), a(150))
		laws:DockPadding(a(15), a(55), a(15), a(10))
		laws:ParentToHUD()

		local maxH = ScrH() - a(150) - a(20)

		laws.Paint = function(self, i, j)
			if not m:Alive() then return end
			if m:IsBanned() then return end
			if m:IsJailed() then return end
			if IsValid(accs) then return end

			local radius = a(15)
			DrawRoundedBox(radius, 0, 0, i, j, f.cardBg)
			drawGradientOverlay(radius, 0, 0, i, j, ACCENT)
			DrawRoundedBox(a(5), a(10), a(10), a(37), a(37), ACCENT)

			local matSz = a(28)
			local matX = a(10) + math.floor((a(37) - matSz) / 2)
			local matY = a(10) + math.floor((a(37) - matSz) / 2)
			g(matX, matY, matSz, matSz, e.laws_mat, f.w)

			draw.SimpleText('Законы города', 'lFont', a(60), a(10), color_white, 0, 3)
			draw.SimpleText('Законодательство штата', 'lFont2', a(60), a(33), Color(255, 255, 255, 178), 0, 3)
		end

		local scroll = laws:Add('DScrollPanel')
		scroll:Dock(FILL)

		local q = scroll:Add('DLabel')
		q:Dock(TOP)
		q:SetFont('lFont2')
		q:SetTextColor(f.w)
		q:SetWrap(true)
		q:SetAutoStretchVertical(true)
		q:DockMargin(0, 0, a(6), 0)

		local vbar = scroll:GetVBar()
		vbar:SetWide(a(4))
		vbar:SetHideButtons(true)
		vbar.Paint = function() end
		vbar.btnGrip.Paint = function(me, w, h)
			draw.RoundedBox(2, 0, 0, w, h, ACCENT)
		end

		laws.q = q

		print(nw.GetGlobal('TheLaws'))
		q:SetText('\n' .. (nw.GetGlobal('TheLaws') or ''))

		laws.Think = function(self)
			if not m:Alive() then return end
			if m:IsBanned() then return end
			if m:IsJailed() then return end
			if IsValid(accs) then return end

			local r = '\n' .. (nw.GetGlobal('TheLaws') or '')
			if r ~= cachedLawsText then
				cachedLawsText = r
				if IsValid(q) then
					q:SetText(r)
					q:InvalidateLayout(true)
				end
			end

			if not IsValid(q) then return end
			local contentH = q:GetTall() + a(65)
			local desiredH = math.min(math.max(contentH, a(100)), maxH)
			self:SetTall(desiredH)
		end
	end

	net.Receive('addLaws', function()
		local r = '\n' .. (nw.GetGlobal('TheLaws') or '')
		cachedLawsText = r
		if IsValid(laws) and IsValid(laws.q) then
			laws.q:SetText(r)
			laws.q:InvalidateLayout(true)
		end
	end)

	hook.Add('InitPostEntity', 'drawlawshuds', l)
end)

hook.Add('eui.Loaded', 'hud.loaded', function()
	local clr = Color(30, 30, 30, 140)
	local gz = Material("jui/other/sz.png")

	hook.Add("HUDPaint", "huddata", function()
		local P = LocalPlayer()
		if not P:Alive() then return end
		if IsValid(accs) then return end

		local targetY = a(150)

		local lawsVisible = IsValid(laws) and laws:GetTall() > 0
			and P:Alive() and not P:IsBanned() and not P:IsJailed() and not IsValid(accs)

		if lawsVisible then
			targetY = targetY + laws:GetTall() + a(10)
		end

		if mayor_system and mayor_system.GetParty() then
			DrawRoundedBox(10, ScrW() - a(335), targetY, a(320), a(50), clr)
			draw.SimpleText(
				mayor_system.GetParty() or 'Абоба',
				'lFont3',
				ScrW() - a(335) + a(160),
				targetY + a(25),
				color_white,
				1,
				1
			)
			targetY = targetY + a(60)
		end

		if inSafeZone then
			local offsetY = a(115)
			local sx = ScrW() - a(335)
			local sy = targetY + offsetY
			local sw = a(320)
			local sh = a(70)

			DrawRoundedMaterial(a(10), sx, sy, sw, sh, gz, color_white)

			targetY = targetY + sh + offsetY + a(10)
		end
	end)
end)

hook.Run('eui.Loaded')

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
