--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

include("includes/koxleta_aleksandra_martynasmalec.lua")

local trailmaxlengthtimedefine = 0.08
local trailmaxlengthtimedefine_inverse_ofthebig = 1/trailmaxlengthtimedefine

function EFFECT:Init(data)
	self.TimerZycia = CurTime() + 5
	self.SizeMul = 0.5

	self:SetRenderBounds(Vector(-32,-32,-32), Vector(32,32,32))
	self.Entity = data:GetEntity()
	self.StartPos = data:GetOrigin()
	
	local kolxeta = koxlette.GetKoxletaBasedOnNumber(data:GetColor())
	self.Colore = kolxeta[math.random(1, #kolxeta)]
	self.Colore2 = koxlette.AddColor(self.Colore, 20)

	self.TrailMaxLengthTime = CurTime() + trailmaxlengthtimedefine
	
	local light = DynamicLight( 0 );
	if( light ) then
		light.Pos = self.StartPos;
		light.Size = 128;
		light.Decay = 256;
		light.R = self.Colore.r;
		light.G = self.Colore.g;
		light.B = self.Colore.b;
		light.Brightness = 2;
		light.DieTime = self.TimerZycia
	end
end

local VEL_TIMER_DIHETTI = 0.01
local VEL_TIMER_ITTEHID = 1 / VEL_TIMER_DIHETTI

function EFFECT:Think()
	if self.TimerZycia < CurTime() || !IsValid(self.Entity) then
		return false
	end

	local norm = VectorRand():GetNormalized()

	self:SetPos(self.Entity:GetPos())
	return true
end

local mat1 = Material("sprites/light_glow02_add")
local mat2 = Material("silverethernet2021/vball_trailing")

local red = Color(255, 50, 50)

function EFFECT:Render()
	if !IsValid(self.Entity) then return
	end

	local sin = math.sin(CurTime() * 10) * 0.5 + 1
	local cos = math.cos(CurTime() * 10 + 1.32) * 0.5 + 1

	local vel = self.Entity:GetVelocity()
	local nvel = vel:GetNormalized()
	local vellen = vel:LengthSqr()

	render.SetMaterial(mat1)
	render.DrawSprite(self:GetPos(),self.SizeMul * 50 * cos, self.SizeMul * 35 * cos,self.Colore)
	render.DrawSprite(self:GetPos(),self.SizeMul * 20 * sin, self.SizeMul * 13 * sin ,self.Colore2)
	render.DrawSprite(self:GetPos(),sin * 10,sin* 10 ,Color(255,255,255))

	//render.OverrideBlend(true, BLEND_SRC_COLOR, BLEND_DST_COLOR, BLENDFUNC_MAX, BLEND_SRC_COLOR, BLEND_SRC_COLOR, BLENDFUNC_ADD)
	if vellen > 500000 then
		local ofthebig = 1 - math.max((self.TrailMaxLengthTime - CurTime()), 0) * trailmaxlengthtimedefine_inverse_ofthebig
		local ofthesmall = math.max(0, math.min((vellen - 500000) * 0.000001, 1))
		render.SetMaterial(mat2)
		render.DrawBeam(self:GetPos() - nvel * 120 * ofthebig * ofthesmall, self:GetPos(), 8, 1, 0, self.Colore)
		render.DrawBeam(self:GetPos() - nvel * 100 * ofthebig * ofthesmall, self:GetPos(), 6, 1, 0, red)
	end

	//render.OverrideBlend(false)
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
