--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher



function EFFECT:Init( data )
	
	self.Pos = data:GetStart()
	self.Ent = data:GetEntity()
	
	local emitter = ParticleEmitter( self.Pos )
		
		if IsValid(self.Ent) then
		for i=4, math.random(20,40) do
		
			local particle = emitter:Add( "particles/smokey", self.Pos + self.Ent:GetForward() * i * math.Rand(1.5,2.6) )

				particle:SetVelocity(self.Ent:GetForward() * math.Rand(150,300) + VectorRand()*math.Rand(50,100) + Vector(0,0,-2*i))
				particle:SetDieTime(math.Rand(3,6))
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( math.Rand( 10, 20 ) )
				particle:SetStartSize( math.Rand(5,15) )
				particle:SetEndSize( math.Rand( 60, 100 ) )
				particle:SetRoll( math.Rand( 0, 360 ) )
				particle:SetRollDelta( math.Rand( -1, 1 ) )
				particle:SetColor( 0, 0, 0 )
				particle:SetCollide( true )
                particle:SetBounce( 0.2 )
				particle:SetGravity(Vector(0,0,-4*i))
			
	    end
		end

	emitter:Finish()
	
end

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
	
end





--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
