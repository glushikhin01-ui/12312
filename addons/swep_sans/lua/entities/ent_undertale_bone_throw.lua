AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Editable		= true
ENT.PrintName		= "Undertale Bone"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

if( CLIENT ) then killicon.Add( "ent_undertale_bone_throw", "undertale/killicon_bone", color_white ) end

function ENT:Initialize()
	if( SERVER ) then
		self:SetModel( "models/undertale/undertale_bone.mdl" )
		self:SetTrigger( true )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		self:SetModelScale( self:GetModelScale() / 2, 0 )
		self:SetVar( "hit", false )
		self:SetVar( "damage", 15 )
		
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableGravity( false )
			phys:SetDragCoefficient( 0 )
			phys:SetBuoyancyRatio( 0 )
		end
		
		-- Удаляем через 10 секунд если никуда не влетело
		timer.Simple( 10, function()
			if IsValid(self) then
				self:Remove()
			end
		end)
	end
	
	if( CLIENT ) then
		-- Эффект при создании
		local vec = self:GetPos()
		local emitter = ParticleEmitter( vec, false )
		
		for cycles = 1, 10 do
			local particle = emitter:Add( Material( "effects/fire_cloud1" ), vec )
			if( particle ) then
				particle:SetVelocity( VectorRand() * 40 )
				particle:SetColor( 0, 100, 255 ) 
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 1 )
				particle:SetStartSize( 20 )
				particle:SetEndSize( 10 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
			end
		end
		
		emitter:Finish()
	end
end

if( SERVER ) then
	function ENT:Think()
		local parent = self:GetParent()
		
		if( parent:IsValid() ) then
			if( parent:IsPlayer() and parent:Health() <= 0 ) then
				self:Remove()
			end
		end
		
		-- Вращение кости в полете
		local phys = self:GetPhysicsObject()
		if IsValid(phys) and not self:GetVar( "hit", false ) then
			phys:AddAngleVelocity( Vector( 0, 100, 0 ) )
		end
		
		self:NextThink( CurTime() + 0.1 )
		return true
	end

	function ENT:PhysicsUpdate()
		if( not self:GetVar( "hit", false ) ) then
			local vel = self:GetVelocity()
			if( vel:Length() < 500 ) then
				self:SetVar( "hit", true )
				self:Fire( "Kill", "", 5 )
				local phys = self:GetPhysicsObject()
				if IsValid(phys) then
					phys:EnableGravity( true )
				end
			end
		end
	end

	function ENT:PhysicsCollide( data, phys )
		if( self:GetVar( "hit", false ) ) then return end
		
		if( data.Speed > 50 ) then
			local hitEnt = data.HitEntity
			
			if( IsValid(hitEnt) and hitEnt ~= self.Owner and hitEnt:GetClass() ~= "ent_undertale_bone_throw" ) then
				self:SetMoveType( MOVETYPE_NONE )
				self:SetPos( data.HitPos )
				self:SetSolid( SOLID_NONE )
				self:SetCollisionGroup( COLLISION_GROUP_WORLD )
				self:SetVar( "hit", true )
				
				-- Наносим урон
				if( hitEnt:IsPlayer() or hitEnt:IsNPC() ) then
					local damageInfo = DamageInfo()
					damageInfo:SetAttacker( self.Owner )
					damageInfo:SetInflictor( self )
					damageInfo:SetDamage( self:GetVar( "damage", 15 ) )
					damageInfo:SetDamageType( DMG_SLASH )
					damageInfo:SetDamageForce( self:GetVelocity() * 10 )
					
					hitEnt:TakeDamageInfo( damageInfo )
					
					-- Отбрасываем цель
					local hitPhys = hitEnt:GetPhysicsObject()
					if IsValid(hitPhys) then
						local forceDir = self:GetVelocity():GetNormalized()
						hitPhys:ApplyForceCenter( forceDir * 10000 )
					end
				end
				
				-- Прикрепляем к цели если это не мир
				if not data.HitWorld then
					self:SetParent( hitEnt )
				end
				
				-- Звук попадания
				self:EmitSound( "undertale/sans/smash.wav" )
				
				-- Удаляем через 5 секунд
				timer.Simple( 5, function()
					if IsValid(self) then
						self:Remove()
					end
				end)
			end
		end
	end
end

function ENT:Draw()
	self:DrawModel()
	
	-- Добавляем свечение на клиенте
	if CLIENT and not self:GetVar( "hit", false ) then
		local vel = self:GetVelocity()
		if vel:Length() > 100 then
			local emitter = ParticleEmitter( self:GetPos(), false )
			
			local particle = emitter:Add( Material( "sprites/light_glow02" ), self:GetPos() )
			if particle then
				particle:SetVelocity( -vel:GetNormalized() * 10 )
				particle:SetColor( 100, 150, 255 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartSize( 10 )
				particle:SetEndSize( 5 )
				particle:SetStartAlpha( 200 )
				particle:SetEndAlpha( 0 )
			end
			
			emitter:Finish()
		end
	end
end