--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

local lifetime = 0.2
local inv = 1 / lifetime

include("includes/koxleta_aleksandra_martynasmalec.lua")

function EFFECT:Init(data)
	local ent = data:GetEntity()
	self.Attachment = data:GetAttachment()

	local kolxeta = koxlette.GetKoxletaBasedOnNumber(data:GetColor())
	self.Colore = kolxeta[math.random(1, #kolxeta)]
	self.Colore2 = koxlette.AddColor(self.Colore, 50)
	self.Size = 1

	//Napisz na @karolek471
	if(ent:IsWeapon() && ent:IsCarriedByLocalPlayer()) then
		local ply = ent:GetOwner()
		if(!ply:ShouldDrawLocalPlayer()) then
			local vm = ply:GetViewModel()
			
			if(IsValid(vm)) then
				ent = vm
				self.Size = 2
			end
		end
	end
	
	if !IsValid(ent) then self:Remove() end
	
	/*local pos = ent:GetAttachment(self.Attachment).Pos
	local frwd = ent:GetAttachment(self.Attachment).Ang:Forward()
	local att = data:GetAttachment()

	local emitter = ParticleEmitter(pos, false)
	for i = 1, 20 do
		
		local part = emitter:Add("sprites/light_glow02_add", pos + VectorRand() * 10)
		part:SetDieTime( math.Rand( 0.2, 0.4 ) );
		part:SetStartAlpha( 255 );
		part:SetEndAlpha( 0 );
		part:SetStartSize( math.Rand( 3,8 ) );
		part:SetEndSize( 0 );
		part:SetColor(self.Colore2:Unpack());
		part:SetNextThink(CurTime())
		part:SetThinkFunction(function(pa)
			if !IsValid(ent) then return end
			local muzzle = ent:GetAttachment(att).Pos
			local frwd = ent:GetAttachment(att).Ang:Forward()
			local dist = (part:GetPos() - muzzle):Dot(frwd)
			local pointation = (part:GetPos() - frwd * dist):GetNormalized():Cross(muzzle)
			part:SetVelocity(frwd * 90 + pointation * 20)
			part:SetNextThink(CurTime())
		end)
	end

	emitter:Finish()*/

	self.Particles = {}
	self.Kret = Either(math.random(0, 1) > 0, 1, -1)

	local rand = math.random(1, 2.5)
	for i = 1, rand * rand do
		self.Particles[i] = {
			pos = VectorRand() * Vector(0,1,1) * 5,
			theta = math.Rand(0, 6.28), //angle theta, thetas bonitas :3
			velmul = math.Rand(0.8, 1.3), //velocity multipliraptor, veloraptor multiplicity
		}
	end

	self.Entity = ent
	self:SetRenderBounds(Vector(-32,-32,-32), Vector(32,32,32))

	self.DieTime = CurTime() + lifetime
end

function EFFECT:GetGoodPos()
	return self.Entity:GetAttachment(self.Attachment).Pos
end

local FLAMELETS = 4
local FLAMELET_INV = 1 / FLAMELETS

local mat = Material("silverethernet2021/vball_trailing")
local mat2 = Material("sprites/light_glow02_add")

local vector_frwd = Vector(1,0,0)
local vector_right = Vector(0,1,0)

function EFFECT:Render()
	if(!IsValid(self.Entity)) then return end

	local frwd = self.Entity:GetAttachment(self.Attachment).Ang:Forward()
	local ang = self.Entity:GetAttachment(self.Attachment).Ang
	local pos = self:GetGoodPos()
	local x = 1 - ((self.DieTime - CurTime()) * inv)
	local y = ((self.DieTime - CurTime()) * inv)
	local size2 = 24 * y

	render.SetMaterial(mat2)
	render.DrawSprite(pos + frwd, size2, size2,self.Colore)

	local transpol = Matrix()
	transpol:Identity()
	transpol:Translate(pos)
	transpol:SetAngles(ang)
	for k, v in ipairs(self.Particles) do
		local cos = math.cos(y * 6.28 * v.velmul + v.theta)
		local sin = math.sin(y * 6.28 * v.velmul + v.theta) * self.Kret
		local vec = (v.pos * y + vector_frwd * x * 20)
		local vec2 = transpol * Vector(vec.x, vec.y * cos - vec.z * sin, vec.y * sin + vec.z * cos)
		local z = math.min(x, y)
		render.DrawSprite(vec2, 6 * z, 6 * z,self.Colore)
	end
	
	render.SetMaterial(mat)
	render.DrawBeam(pos, pos + frwd * 16 * self.Size * y * y, 6 * y, 0, 1, self.Colore)
	render.DrawBeam(pos, pos + frwd * 20 * self.Size * y * y, 3 * y, 0, 1, self.Colore2)
	for i = 0, FLAMELETS - 1 do
		local vec = ang
		vec:RotateAroundAxis(frwd, 360 * i * FLAMELET_INV + CurTime() * 800)
		render.DrawBeam(pos, pos + vec:Right() * 5 * self.Size * y * y, 2 * y, 0, 1, self.Colore2)
	end
end

function EFFECT:Think()
	if !IsValid(self.Entity) then return false end

	local xpos = self:GetGoodPos()
	self:SetPos(xpos)

	return self.DieTime > CurTime()
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
