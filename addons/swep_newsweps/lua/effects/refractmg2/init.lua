--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher


EFFECT.Refract = Material("sprites/ref_spr");

/*---------------------------------------------------------
   Init( data table )
---------------------------------------------------------*/
function EFFECT:Init( data )
	self.EndPos 	 = data:GetOrigin()
	self.LifeTime = CurTime() + 0.5
	self.Size = 128
end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
if CurTime() > self.LifeTime then return false end
return true
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render( )
	self.Size = math.Max( self.Size - 1.5, 0)
	
	local EndPos = self.EndPos;
	
	render.SetMaterial(self.Refract);
	render.DrawSprite(
		EndPos,
		self.Size,self.Size,
		Color(120,120,255,255)
	);

end


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
