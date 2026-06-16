--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

local MaterialGlow = Material( "sprites/light_glow02_add" );

function EFFECT:Init(data)
	self:SetPos(data:GetOrigin())
	self:SetRenderBounds(-Vector(256,256,256), Vector(256,256,256))

	local lifetime = math.Rand(0.3, 0.8)
	self.LifeTime = CurTime() + lifetime
	self.LifeInv = 1 / lifetime

	self.Size = math.Rand(1, 1.8)
	self.Center = data:GetOrigin()
	self.Velocity = data:GetNormal() * data:GetMagnitude() * 4

	self.NextPoint = 0
	self.Points = {}
	self.PStart = 1

	self.ShouldTrail = math.random(1,4) == 3
end

local MAXPOINTS = 32

local inverses = {}
for i = 1, MAXPOINTS do
	inverses[i] = (i-1) / MAXPOINTS
end

function EFFECT:Think()
	local tocenter = self:GetPos() - self.Center
	local vel = self.Velocity:Cross(tocenter):GetNormalized()

	self.Velocity = self.Velocity - (Vector(0,0, 900) + vel * 1000 + VectorRand() * 10) * FrameTime() 
	self:SetPos(self:GetPos() + self.Velocity * FrameTime())

	if self.NextPoint < CurTime() && self.ShouldTrail then
		self.NextPoint = CurTime() + 0.05

		local point = {
			pos = self:GetPos(), points = {}
		}

		local rand = math.random(1, 4)
		if bit.band(rand, 3) > 0 then
			for i = 1, rand do
				point.points[#point.points + 1] = VectorRand() * 70
			end
		end

		if #self.Points < MAXPOINTS then
			self.Points[#self.Points + 1] = point
		else
			local index = bit.band((self.PStart - 1), MAXPOINTS - 1) + 1
			self.PStart = self.PStart + 1
			self.Points[index] = point
		end
	end

	return self.LifeTime > CurTime()
end

local color = Color(255, 191, 0)
local color2 = Color(170, 100, 0)

local mat2 = Material("silverethernet2021/vball_trailing")

function EFFECT:Render()
	//self:DrawModel()
	local time = (self.LifeTime - CurTime()) * self.LifeInv

	render.SetMaterial(MaterialGlow)
	render.StartBeam(#self.Points + 1)
	for i = 1, #self.Points do
		local index = bit.band((self.PStart - 2 + i), MAXPOINTS - 1) + 1
		local size = 10 * inverses[i]
		render.AddBeam(self.Points[index].pos, size * time, inverses[i], color2)

		for k, v in ipairs(self.Points[index].points) do
			render.DrawSprite(self.Points[index].pos + v * time, 12 * time, 10 * time, color)
		end
	end
	render.AddBeam(self:GetPos(), 10, 1, self.Colore)

	render.SetMaterial(mat2)
	render.EndBeam()	

	render.SetMaterial(MaterialGlow)
	render.DrawSprite(self:GetPos(), 32 * self.Size * time, 32 * self.Size * time, color)
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
