AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Editable		= true
ENT.PrintName		= "Undertale Bone"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

if( CLIENT ) then killicon.Add( "ent_undertale_bone_ground", "undertale/killicon_spear_bone", color_white ) end

function ENT:Initialize()
	if( SERVER ) then
		self:SetModel( "models/undertale/undertale_bone.mdl" )
		self:SetTrigger( true )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_NONE )
		self:SetCollisionGroup( COLLISION_GROUP_WORLD )
		
		-- Сохраняем начальные параметры
		self:SetVar( "value", -50 )
		self:SetVar( "position", self:GetPos() )
		self:SetVar( "seed", math.Rand( 0, 1 ) )
		self:SetVar( "reverse", false )
		self:SetVar( "hasDamaged", false )
		self:SetVar( "soundPlayed", false )
		
		-- Получаем нормаль поверхности
		local trace = util.TraceLine({
			start = self:GetPos() + Vector(0,0,100),
			endpos = self:GetPos() - Vector(0,0,100),
			filter = self
		})
		self:SetVar( "normal", trace.HitNormal )
		
		-- Удаляем через 15 секунд
		timer.Simple( 15, function()
			if IsValid(self) then
				self:Remove()
			end
		end)
		
		local phys = self:GetPhysicsObject()
		if( IsValid( phys ) ) then
			phys:Wake()
			phys:EnableMotion( false )
		end
	end
end

function ENT:PhysicsUpdate()
	if( SERVER ) then
		local value = math.min( self:GetVar( "value" ), 35 )
		local counter = self:GetVar( "value" )
		local seed = self:GetVar( "seed" )
		local position = self:GetVar( "position" )
		
		-- Анимация появления/исчезновения
		if( self:GetVar( "reverse" ) ) then
			self:SetVar( "value", counter - 2 )
			if( value < -20 ) then
				self:Remove()
				return
			end
		else
			self:SetVar( "value", counter + 2 )
		end
		
		-- Когда кость появляется
		if( value > 10 and not self:GetVar( "hasDamaged" ) ) then
			if( value < 15 and not self:GetVar( "soundPlayed" ) ) then
				local pos = self:GetVar( "pos", self:GetPos() )
				local normal = self:GetVar( "normal", Vector(0,0,1) )
				
				-- Звук появления
				self:EmitSound( "undertale/bone_end.wav" )
				self:SetVar( "soundPlayed", true )
				
				-- Наносим урон всем в области
				local entities = ents.FindInSphere( pos, 50 )
				for _, ent in ipairs( entities ) do
					if( IsValid( ent ) and ent ~= self.Owner and ent ~= self ) then
						if( ent:IsPlayer() or ent:IsNPC() ) then
							local damageInfo = DamageInfo()
							damageInfo:SetAttacker( self.Owner )
							damageInfo:SetInflictor( self )
							damageInfo:SetDamage( 35 )
							damageInfo:SetDamageType( DMG_SLASH )
							damageInfo:SetDamageForce( normal * 5000 )
							
							ent:TakeDamageInfo( damageInfo )
							
							-- Эффект попадания
							local effectData = EffectData()
							effectData:SetOrigin( ent:GetPos() )
							effectData:SetNormal( normal )
							util.Effect( "bloodspray", effectData )
						end
					end
				end
				
				self:SetVar( "hasDamaged", true )
			end
			
			-- Делаем кость твердой
			if( not self:GetVar( "do" ) ) then
				self:SetVar( "do", true )
				self:SetSolid( SOLID_VPHYSICS )
				self:SetCollisionGroup( COLLISION_GROUP_WORLD )
			end
		end
		
		-- Анимация исчезновения
		if( counter > 100 ) then
			self:SetVar( "reverse", true )
			self:SetSolid( SOLID_NONE )
		end
		
		-- Движение кости (анимация)
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			local val1 = math.sin( ( math.max( 0, value ) + 50 ) / 10 ) * 30
			local val2 = ( seed - 0.5 ) * 13
			
			-- Движение вверх/вниз
			self:SetPos( position + self:GetUp() * ( val1 - val2 - 5 ) )
			
			-- Добавляем вращение для эффекта
			local angle = self:GetAngles()
			angle:RotateAroundAxis( self:GetUp(), math.sin( CurTime() * 2 ) * 5 )
			self:SetAngles( angle )
			
			phys:Wake()
		end
	end
end

function ENT:Touch( ent )
	if SERVER and IsValid(ent) and ent ~= self.Owner and self:GetSolid() == SOLID_VPHYSICS then
		if ent:IsPlayer() or ent:IsNPC() then
			-- Дополнительный урон при касании
			local damageInfo = DamageInfo()
			damageInfo:SetAttacker( self.Owner )
			damageInfo:SetInflictor( self )
			damageInfo:SetDamage( 10 )
			damageInfo:SetDamageType( DMG_SLASH )
			
			ent:TakeDamageInfo( damageInfo )
			
			-- Отбрасывание
			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				local forceDir = (ent:GetPos() - self:GetPos()):GetNormalized()
				phys:ApplyForceCenter( forceDir * 3000 )
			end
			
			-- Эффект
			local effectData = EffectData()
			effectData:SetOrigin( ent:GetPos() )
			util.Effect( "bloodspray", effectData )
		end
	end
end

-- Клиентская часть для визуальных эффектов
if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		
		-- Добавляем свечение
		local value = self:GetVar( "value", 0 )
		if value > 0 and value < 100 then
			local emitter = ParticleEmitter( self:GetPos(), false )
			
			local particle = emitter:Add( Material( "sprites/light_glow02" ), self:GetPos() )
			if particle then
				particle:SetVelocity( Vector(0,0,10) )
				particle:SetColor( 100, 150, 255 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartSize( 20 )
				particle:SetEndSize( 5 )
				particle:SetStartAlpha( 100 )
				particle:SetEndAlpha( 0 )
			end
			
			emitter:Finish()
		end
	end
end