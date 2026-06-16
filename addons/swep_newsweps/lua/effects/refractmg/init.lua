--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher



EFFECT.Mat = Material( "sprites/ref" )

/*---------------------------------------------------------
   Init( data table )
---------------------------------------------------------*/
function EFFECT:Init( data )

	self.StartPos 	 = data:GetStart()
	self.Normal		 = data:GetNormal()
	self.LifeTime 	 = CurTime() + 5
	self.sizeAdjust  = 60
	self.alpha = 0
end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
	if CurTime() > self.LifeTime then return false end
	self.sizeAdjust = self.sizeAdjust + 1
	self.alpha = self.alpha + 0.5
	return true
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render( )

	render.SetMaterial( self.Mat )

	render.DrawQuadEasy( self.StartPos, //position of the rect
						 self.Normal, //direction to face in
						 self.sizeAdjust, self.sizeAdjust, //size of the rect
						 Color( 143,167,240,255*(1/self.alpha) ) //color...
					   ) 
end


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
