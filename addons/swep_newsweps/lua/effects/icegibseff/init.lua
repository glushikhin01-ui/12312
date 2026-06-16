--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

	
/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/

IceGibsEnt = {}

table.insert( IceGibsEnt, "models/gibs/glass_shard01.mdl" )
table.insert( IceGibsEnt, "models/gibs/glass_shard02.mdl" )
table.insert( IceGibsEnt, "models/gibs/glass_shard03.mdl" )
table.insert( IceGibsEnt, "models/gibs/glass_shard04.mdl" )
table.insert( IceGibsEnt, "models/gibs/glass_shard05.mdl" )
table.insert( IceGibsEnt, "models/gibs/glass_shard06.mdl" )

function EFFECT:Init( data )
	
	local iCount = table.Count( IceGibsEnt )
	
	self.Entity:SetModel( IceGibsEnt[ math.random( iCount ) ] )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS)
	self.Entity:SetCollisionBounds( Vector( -128 -128, -128 ), Vector( 128, 128, 128 ) )
	self.Entity:SetModelScale(data:GetScale()*math.Rand(0.5,1))
	self.Entity:SetRenderMode(1)
	self.Entity:SetMaterial("sprites/skin_freeze")
	
	local phys = self.Entity:GetPhysicsObject()
	if ( phys && phys:IsValid() ) then
		phys:Wake()
		phys:EnableMotion(true)
		phys:SetMaterial( "glass" )
		phys:SetAngles( Angle( math.Rand(0,360), math.Rand(0,360), math.Rand(0,360) ) )
		phys:SetVelocity( VectorRand() * (math.Rand( 20, 50 )/3)*20 )
	
	end
	
	self.LifeTime = CurTime() + 5
end

function EFFECT:PhysicsCollide(data, physobj)
end
/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
	if self.LifeTime < CurTime() then
	self.Entity:SetColor(Color(self.Entity:GetColor().r,self.Entity:GetColor().g,self.Entity:GetColor().b,self.Entity:GetColor().a - 0.01))
	if self.Entity:GetColor().a <= 0 then
	return false
	end
	end
	return true
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()
	render.SuppressEngineLighting( true )
	render.ResetModelLighting( 0.5, 0.5, 0.5)
	render.SetColorModulation( 0.9, 0.9, 0.9 )
	self.Entity:DrawModel()
	render.SetColorModulation( 1, 1, 1 )
	render.ResetModelLighting( 1, 1, 1)
	render.SuppressEngineLighting( false )
end





--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
