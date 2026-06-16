AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Editable		= true
ENT.PrintName		= "Undertale Gaster Blaster"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

if( CLIENT ) then killicon.Add( "ent_undertale_gaster_blaster", "undertale/killicon_gaster_blaster", color_white ) end

local modelAvailible = true

function ENT:Initialize()
	if( SERVER ) then
		local model = "models/evangelos/undertale/gasterblaster.mdl"
		if( !util.IsValidModel( model ) ) then 
			model = "models/Gibs/HGIBS.mdl" 
			modelAvailible = false 
		end
		
		self:SetModel( model )
		self:SetTrigger( true )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_NONE )
		
		self:SetVar( "open", CurTime() + 0.75 )
		self:SetVar( "CurTime", CurTime() )
		self:SetVar( "distance", nil )
		self:SetVar( "scale", self:GetModelScale() )
		self:SetVar( "shoot", false )
		
		-- Инициализация костей
		self:ManipulateBoneAngles( 0, Angle( 0, 0, -30 ) )
		
		local phys = self:GetPhysicsObject()
		if( IsValid( phys ) ) then
			phys:Wake()
		end
		
		util.AddNetworkString( "gaster_blaster_shooting" )
	end
	
	if( CLIENT ) then
		self:SetVar( "shootEffect", 0 )
	end
end

function ENT:PhysicsUpdate()
	if( SERVER ) then
		local pos = self:GetVar( "position", NULL )
		if not pos then return end
		
		local dist = pos:Distance( self:GetPos() )
		
		if( self:GetVar( "distance", NULL ) == NULL ) then
			self:SetVar( "distance", dist )
			self:SetVar( "scale", self:GetModelScale() )
		end
		
		local scale = self:GetVar( "scale", NULL )
		local saveDist = self:GetVar( "distance" )
		local curtime = CurTime() - self:GetVar( "CurTime", CurTime() )
		local vec = Vector( math.cos( curtime ), math.sin( curtime ), math.sin( curtime ) / 2 )
		
		local numb = ( CurTime() - self:GetVar( "open", NULL ) ) * 6
		
		if( numb < 3 ) then
			-- Движение к цели
			self:SetPos( self:GetPos() + ( pos - self:GetPos() ) / 10 + vec * math.max( 0.5, dist / 30 ) )
		else
			-- Движение назад после выстрела
			if( numb > 10 ) then
				self:Remove()
				return
			end
			self:SetPos( self:GetPos() - self:GetForward() * ( dist / 10 + 0.1 ) )
		end
		
		-- Выстрел когда близко к цели
		if( dist < 15 and not self:GetVar( "shoot", false ) ) then
			self:SetVar( "shoot", true )
			
			self:EmitSound( "undertale/gaster_blaster/gaster_blaster_end.mp3", 75, 100, 1, CHAN_AUTO )
			
			-- Создаем луч
			local tr = util.TraceLine( {
				start = self:GetPos(),
				endpos = self:GetPos() + self:GetForward() * 10000,
				filter = { self, self.Owner }
			} )
			
			-- Наносим урон всем в линии
			local entities = ents.FindInSphere( tr.HitPos, 50 )
			for _, ent in ipairs( entities ) do
				if( IsValid( ent ) and ent ~= self.Owner and ent ~= self ) then
					if( ent:IsPlayer() or ent:IsNPC() ) then
						ent:TakeDamage( 25, self.Owner, self )
					end
				end
			end
			
			-- Отправляем эффект выстрела клиентам
			net.Start( "gaster_blaster_shooting" )
			net.WriteEntity( self )
			net.Broadcast()
		end
		
		-- Анимация открытия/выстрела
		if( self:GetVar( "shoot", false ) ) then
			local value = math.sin( math.max( 0, math.min( 2, numb ) ) ) * 1.1
			
			-- Манипуляции с костями
			self:ManipulateBoneScale( 2, Vector( 0, 0, 0 ) )
			self:ManipulateBoneAngles( 1, Angle( 180, 0, 0 ) )
			self:ManipulateBonePosition( 1, Vector( 9, 8, -6 ) )
			
			self:ManipulateBoneAngles( 0, Angle( 0, 0, -30 ) * value + Angle( 0, 0, -30 ) )
			self:ManipulateBoneAngles( 3, Angle( 0, 0, -50 ) * value )
			self:ManipulateBoneAngles( 4, Angle( 0, 0, -40 ) * value )
			self:ManipulateBoneAngles( 5, Angle( 0, 0, -40 ) * value )
			
			self:ManipulateBonePosition( 4, Vector( -10, 0, -20 ) * value )
			self:ManipulateBonePosition( 5, Vector( 10, 0, -20 ) * value )
			
			self:GetPhysicsObject():Wake()
			if( modelAvailible ) then
				self:SetModelScale( scale )
			else
				self:SetModelScale( scale * 5 )
			end
		else
			-- Масштабирование при приближении
			if( modelAvailible ) then
				local newScale = scale * math.max( 0, math.min( 1, ( saveDist - dist ) / saveDist ) )
				self:SetModelScale( math.max( 0.1, newScale ) )
			else
				local newScale = scale * math.max( 0, math.min( 1, ( saveDist - dist ) / saveDist ) ) * 5
				self:SetModelScale( math.max( 0.1, newScale ) )
			end
		end
	end
end

-- Клиентская часть для эффекта выстрела
if CLIENT then
	net.Receive( "gaster_blaster_shooting", function()
		local ent = net.ReadEntity()
		if IsValid(ent) then
			ent:SetVar( "shootEffect", CurTime() )
		end
	end )
end

function ENT:Draw()
	self:DrawModel()
	
	-- Рисуем луч выстрела
	if( self:GetVar( "shootEffect", 0 ) > 0 ) then
		local shootTime = CurTime() - self:GetVar( "shootEffect", 0 )
		if( shootTime > 1 ) then
			self:SetVar( "shootEffect", 0 )
			return
		end
		
		-- Трассировка для определения конечной точки луча
		local tr = util.TraceLine( {
			start = self:GetPos(),
			endpos = self:GetPos() + self:GetForward() * 10000,
			filter = { self, self.Owner }
		} )
		
		-- Создаем материал для луча
		local beamMat = Material( "sprites/light_glow02" )
		render.SetMaterial( beamMat )
		
		local size = math.max( 0, math.min( 1, math.sin( shootTime * 10 ) * 1.4 ) )
		local startPos = self:GetPos() - self:GetUp() * 20 - self:GetForward() * 10
		local endPos = tr.HitPos
		
		-- Рисуем основной луч
		render.DrawBeam( startPos, endPos, 30 * size, 0, 1, Color( 255, 255, 255, 255 ) )
		
		-- Рисуем дополнительные лучи для эффекта
		for i = 1, 3 do
			local offset = Vector( math.Rand( -5, 5 ), math.Rand( -5, 5 ), math.Rand( -5, 5 ) )
			render.DrawBeam( startPos + offset, endPos + offset, 10 * size, 0, 1, Color( 255, 200, 100, 150 ) )
		end
		
		-- Добавляем спрайт в точке попадания
		render.DrawSprite( endPos, 50 * size, 50 * size, Color( 255, 255, 255, 255 ) )
	end
end