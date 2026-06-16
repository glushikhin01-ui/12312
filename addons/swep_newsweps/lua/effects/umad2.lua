--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher


EFFECT.Duration			= 1;
EFFECT.Size				= 1;

local MaterialGlow		= Material( "sprites/light_glow02_add" );
include("includes/koxleta_aleksandra_martynasmalec.lua")

function EFFECT:Init( data )

	self.Position = data:GetOrigin();
	self.Normal = data:GetNormal();
	self.LifeTime = self.Duration;

	local kolxeta = koxlette.GetKoxletaBasedOnNumber(data:GetColor())
	self.Colore = kolxeta[math.random(1, #kolxeta)]

	-- particles
	local emitter = ParticleEmitter( self.Position );
	if( emitter ) then
		
		for i = 1, 20 do

			local particle = emitter:Add( "sprites/light_glow02_add", self.Position + self.Normal * 2 );
			particle:SetVelocity( ( self.Normal * -0.1 + VectorRand()):GetNormal() * 1500 );
			particle:SetDieTime( math.Rand( 0.5,2 ) );
			particle:SetStartAlpha( 255 );
			particle:SetEndAlpha( 0 );
			particle:SetStartSize( math.Rand( 2,5 ) );
			particle:SetEndSize( 0 );
			particle:SetColor(self.Colore:Unpack());

			particle:SetGravity( Vector( 0, 0, -500 ) );
			particle:SetCollide( true );
			
			particle:SetBounce( 0.1 );
		end

		emitter:Finish();

	end
	
	local light = DynamicLight( 0 );
	if( light ) then

		light.Pos = self.Position;
		light.Size = 16;
		light.Decay = 226;
		light.R = 128;
		light.G = 128;
		light.B = 128;
		light.Brightness = 3;
		light.DieTime = CurTime() + self.Duration;
	end
end


function EFFECT:Think()

	self.LifeTime = self.LifeTime - FrameTime();
	return self.LifeTime > 0;

end


function EFFECT:Render()
end


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
