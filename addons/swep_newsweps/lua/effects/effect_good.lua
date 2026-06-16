--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher


function EFFECT:Init(data)
	self.TimerZycia = CurTime() + 1
	self.mat = Material("sprites/plasmaember.vtf")

	self.SizeMul = 1
end

function EFFECT:Render()
	local sin2 = math.sin(CurTime() * 2 * 0.4) * self.SizeMul
	local sin3 = math.sin(CurTime() * 2 * 0.4) * self.SizeMul
	local size = (sin2 * 0.05 + 0.95) * 16 * self.SizeMul

	if self.TimerZycia - CurTime() < 1 then
		self.SizeMul = (self.TimerZycia - CurTime())
	end

	render.SetMaterial(self.mat)
	render.DrawSprite(self:GetPos(),30 * sin3,30 * sin3,Color(80,200,80))
	
	cam.Start3D()
		local matrix = Matrix()
		matrix:Identity()
		matrix:Translate(self:GetPos())
		matrix:Rotate(Angle((CurTime() * 260) % 160, 0, 0))

		cam.PushModelMatrix(matrix)
		render.SetMaterial(Material("effects/combineshield/comshieldwall"))
		render.DrawSphere(Vector(0, 0, 0),size * 0.7,20,20,Color(160, 60, 251,255 ))
	cam.End3D()
end

function EFFECT:Think()
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
