--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

include("shared.lua")
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:DrawTranslucent()
	self:DrawModel()

	local white = Color(255,255,255)
	local red = Color (255,100,100)
	local dzialko = self:GetNWEntity("dzialko")
	local laser = Material("sprites/bluelaser1")

	--if self:GetNWBool("RedAlert",false) then dzialko:EmitSound("npc/scanner/combat_scan_loop1.wav")	hhhhmmmmm
	--end
	
	if dzialko:IsValid() && self:GetNWBool("RedAlert",true) then
			local tr = util.TraceLine({start = dzialko:GetAttachment(1).Pos,endpos = dzialko:GetForward() * 99999999})
			render.SetMaterial(laser)
			render.DrawBeam(dzialko:GetAttachment(1).Pos,tr.HitPos,0.8,0,0,self:GetLaserColor():ToColor())
	end

	if dzialko:IsValid() then
	  	if self:GetNWBool("RedAlert",false) then
			    render.SetMaterial(Material("sprites/glow04_noz"))
			    render.DrawSprite( dzialko:GetPos() + dzialko:GetUp() * 3.5 + dzialko:GetForward() * 7 + dzialko:GetRight() * -2.9,2.7,2.7,red)
	   		else
			    render.SetMaterial(Material("sprites/glow04_noz"))
			    render.DrawSprite( dzialko:GetPos() + dzialko:GetUp() * 3.5 + dzialko:GetForward() * 7 + dzialko:GetRight() * -2.9,2.7,2.7,white)
		end
	end
end

local TablePlayers = TablePlayers or {}

net.Receive('rp.Turrel.RefreshPlayers', function()
	TablePlayers = net.ReadTable() or {}
end)

net.Receive('rp.Turrel.Menu', function()
	local fr = ui.Create('ui_frame', function(self)
		self:SetTitle('Выбрать игрока')
		self:SetSize(.2, .4)
		self:Center()
		self:MakePopup()
	end)

	fr.tabList = ui.Create('ui_scrollpanel', function(list)
		list:DockMargin(0, 5, 0, 5)
		list:Dock(FILL)
		list:SetSpacing(5)
	end, fr)

	for k, v in ipairs(player.GetAll()) do
		if v == LocalPlayer() then continue end

		local btn = ui.Create('ui_imagerow')
		btn:SetPlayer(v, v:SteamID64())
		
		function btn:Think()
			if TablePlayers[v:SteamID64()] then
				self:SetAlpha(50)
			else
				self:SetAlpha(255)
			end
		end

		btn.DoClick = function()
			net.Start('rp.Turrel.SetPlayer')
				net.WriteString(tostring(v:SteamID64()))
			net.SendToServer()
		end

		fr.tabList:AddItem(btn)
	end

	fr:Focus()
end)

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
