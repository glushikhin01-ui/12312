--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

include("includes/koxleta_aleksandra_martynasmalec.lua")

local mat2 = Material("sprites/light_glow02_add")
function EFFECT:Init(data)
	self.TimerZycia = CurTime() + 4.9

	local kolxeta = koxlette.GetKoxletaBasedOnNumber(data:GetColor())
	self.Colore = kolxeta[math.random(1, #kolxeta)]

	self.Entit = data:GetEntity()
	self.StartPos = data:GetOrigin()
	self.SizeMul = 1
end

function EFFECT:Render()
	if !IsValid(self.Entit) then return false end

	local sin2 = math.sin(CurTime() * 3 * 0.9) * self.SizeMul
	local sin3 = math.sin(CurTime() * 3 * 0.4) * self.SizeMul
	local size = (sin2 * 0.05 + 0.95) * 32 * self.SizeMul

	if self.TimerZycia - CurTime() < 1 then
		self.SizeMul = (self.TimerZycia - CurTime() )
	end

	render.SetMaterial(mat2)
	render.DrawSprite(self.Entit:GetPos(),90,90,self.Colore)
	
	cam.Start3D()
		local matrix = Matrix()
		matrix:Identity()
		matrix:Translate(self.Entit:GetPos())
		matrix:Rotate(Angle((CurTime() * 10) % 360, 0, 0))

		cam.PushModelMatrix(matrix)
		render.SetMaterial(Material("effects/combineshield/comshieldwall"))
		render.DrawSphere(self.Entit:GetPos(),size,30,30,self.Colore)
	cam.PopModelMatrix()
	cam.End3D()
end

function EFFECT:Think()
	if !IsValid(self.Entit) then return false end
	
	if self.TimerZycia < CurTime() then
		return false
		else
		return true
	end
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
