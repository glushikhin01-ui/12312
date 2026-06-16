--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher


EFFECT.Duration			= 1;
EFFECT.Size				= 1;

local MaterialGlow		= Material( "sprites/light_glow02_add" );
local ColorTable = {{Color(204,204,0),Color(255,255,51),Color(255,255,0)},{Color(100,105,255),Color(100,15,235),Color(30,15,255)},{Color(255,255,255),Color(255,255,255),Color(255,255,255)}}

function EFFECT:Init( data )

	self.Position = data:GetOrigin();
	self.Normal = data:GetNormal();
	self.LifeTime = self.Duration;

	local kolxeta = ColorTable[data:GetColor() || 1] // || 1 ratuje przed nilem
	self.Colore = kolxeta[math.random(1, #kolxeta)]
	-- particles
	local emitter = ParticleEmitter( self.Position );
	if( emitter ) then
		
		for i = 1, 150 do

			local particle = emitter:Add( "sprites/light_glow02_add", self.Position + self.Normal * 2 );
			particle:SetVelocity( ( self.Normal * -0.1 + VectorRand()):GetNormal() * 1000 );
			particle:SetDieTime( math.Rand( 5,5.5 ) );
			particle:SetStartAlpha( 255 );
			particle:SetEndAlpha( 0 );
			particle:SetStartSize( math.Rand( 4,9 ) );
			particle:SetEndSize( 0 );
			if math.random(1,2) == 1 then
				print("be")
				particle:SetColor(Color(255,255,255));
				particle:SetCollide(true);
				particle:SetBounce( 0 );
				particle:SetGravity( Vector( 0, 0, -100 ) );
			else
				particle:SetColor(self.Colore:Unpack()); // rozkladamy Color() na czynniki
				particle:SetCollide(true);
				particle:SetBounce( 0.1 );
				particle:SetGravity( Vector( 0, 0, -700 ) );
			end
		end
		emitter:Finish();
	end
	
	local light = DynamicLight( 0 );
	if( light ) then

		light.Pos = self.Position;
		light.Size = 128;
		light.Decay = 156;
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
