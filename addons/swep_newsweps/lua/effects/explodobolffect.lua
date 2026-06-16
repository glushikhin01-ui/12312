--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

include("includes/koxleta_aleksandra_martynasmalec.lua")

function EFFECT:Init(data)
	self.TimerZycia = CurTime() + 10
	self.SizeMul = 0.5

	local kolxeta = koxlette.GetKoxletaBasedOnNumber(data:GetColor())
	self.Colore = kolxeta[math.random(1, #kolxeta)]

	self:SetRenderBounds(Vector(-512,-512,-512), Vector(512,512,512))
	self.Entita = data:GetEntity()
	self.StartPos = data:GetOrigin()

	local light = DynamicLight( 0 );
	if( light ) then
		light.Pos = self.StartPos;
		light.Size = 64;
		light.Decay = 256;
		light.R = 128;
		light.G = 128;
		light.B = 128;
		light.Brightness = 2;
		light.DieTime = self.TimerZycia
	end

	self.TrailTime = 0
	self.Trails = {}
	self.LastPos = self:GetPos()
	self.I = 1

	self.Particles = {}
	for i = 1, math.random(10, 20) do
		local part = {
			pos = VectorRand():GetNormalized(),
			velo = math.Rand(0.8, 1.6),
			color = kolxeta[math.random(1, #kolxeta)],
			size = math.Rand(0.8, 1.2),
			angle = AngleRand()
		}

		self.Particles[i] = part
	end
end

local MAX_TRAIL = 8
local MAX_TRAIL_INV = 1/MAX_TRAIL
local TRAILTIME = 0.015
local TRAILINV = 1/TRAILTIME

function EFFECT:Think()
	if self.TimerZycia < CurTime() || !IsValid(self.Entita) then
		return false
	end

	self:SetPos(self.Entita:GetPos())

	if(self.TrailTime < CurTime()) then
		local vel = self.Entita:GetVelocity()
		local TurnBool = self.Entita:GetNWBool("TrailLatch")

		if !TurnBool then
			table.insert(self.Trails, 1, {pos = self:GetPos(), offys={VectorRand() * 0}})
			self.LastPos = self:GetPos()
		end
		
		if(#self.Trails > MAX_TRAIL) || TurnBool then
			table.remove(self.Trails, #self.Trails)
		end

		self.TrailTime = CurTime() + TRAILTIME
	end
	
	return true
end

local _inv1 = 1.0 / 1.5
local _mat = Material("sprites/light_glow02_add")
local _mat2 = Material("sprites/bluelaser1")
local _mat3 = Material("effects/bluelaser1")
local _mat4 = Material("effects/fluttercore")

local colorinho = Color(255,255,255)
local anglihno = Angle(0,0,0)

function EFFECT:Render()
	if !IsValid(self.Entita) then return end

	local sin = 0.5
	local sin2 = 0.5

	local pupsize = math.min((self.TimerZycia - CurTime()) - 1.5, 1.5) * _inv1
	local spheresize = self.Entita:GetNWFloat("Zorro")

	if self.TimerZycia - CurTime() < 4 then
		sin2 = math.sin(CurTime() * pupsize * 3.5) * self.SizeMul
		sin = math.sin(CurTime() * (self.TimerZycia - CurTime() * 0.5)) * self.SizeMul
	end

	local fiixar = Vector(0,0,0)
	/*local freq = 0.005/(self.TimerZycia - CurTime())

	for i = 1, 4 do
		fiixar.x = fiixar.x + math.sin(2 * i * freq * CurTime()) * math.cos(CurTime() * 0.5 * i * freq)
		fiixar.y = fiixar.y + math.cos(2 * i * freq) * math.sin(CurTime() * 2.5 * i * freq)
		fiixar.z = fiixar.z + math.sin(2 * i * freq) * math.sin(CurTime() * 0.5 * i)
	end*/

	render.SetMaterial(_mat)
	render.DrawSprite(self:GetPos() + fiixar,spheresize * 0.05, spheresize * 0.05 ,self.Colore)
	render.DrawSprite(self:GetPos(),10 * sin,22 * sin,self.Colore)
	colorinho.r = 25
	colorinho.g = 255
	colorinho.b = 255
	render.DrawSprite(self:GetPos() + fiixar,((sin2) * spheresize) * 0.05,((sin2) * spheresize) * 0.05, colorinho)

	for k, v in ipairs(self.Particles) do
		local vecc = (v.pos * 16)
		anglihno.pitch = CurTime() * v.velo * 500
		anglihno.yaw = CurTime() * v.velo * 500
		anglihno.roll = 0
		v.velo = v.velo + FrameTime() * 0.001
		vecc:Rotate(anglihno)
		vecc:Rotate(v.angle)
		render.DrawSprite(self:GetPos() + vecc, 8 * v.size, 8 * v.size, v.color)
    end
	
	local matrix = Matrix()
    matrix:Identity()
    matrix:SetAngles(Angle(CurTime() * 2080, 0, 0))
    matrix:SetTranslation(self:GetPos())

    cam.Start3D()
        cam.PushModelMatrix(matrix)
        render.SetMaterial(_mat3)
        render.DrawSphere(Vector(0, 0, 0), spheresize * 0.008 , 12, 12)
        cam.PopModelMatrix()
    cam.End3D()
	
	render.SetMaterial(_mat2)
	for j = 1, 1 do
		render.StartBeam(#self.Trails)
		//render.AddBeam(self:GetPos(), 32, 1, _COLOR)
		for i = 1, #self.Trails do
			local invx = (#self.Trails - i) * MAX_TRAIL_INV
			local xpos = self.Trails[i].pos + self.Trails[i].offys[j] * invx
			render.AddBeam(xpos, (spheresize * invx) * 0.05, 1, self.Colore)
		end
		render.EndBeam()
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
