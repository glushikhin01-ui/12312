--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

AddCSLuaFile()

local model1 = "models/crsk_autos/avtovaz/2113.mdl"
local model2 = "models/crsk_autos/avtovaz/2114.mdl"
local model3 = "models/crsk_autos/avtovaz/2114_trafficpolice.mdl"
local model4 = "models/crsk_autos/avtovaz/2115.mdl"
local model5 = "models/crsk_autos/avtovaz/2115_trafficpolice.mdl"
local siren = {"vehicles/sim_fphys_lada_samara/siren.ogg", "vehicles/sim_fphys_lada_samara/siren2.ogg", "vehicles/sim_fphys_lada_samara/horn.ogg", "common/null.ogg"}

if GetConVar("gmod_language"):GetString() == "ru" or GetConVar("gmod_language"):GetString() == "uk" then
	NameLang1 = "ВАЗ-2113"
	NameLang2 = "ВАЗ-2114"
	NameLang3 = "ВАЗ-2114 ДПС"
	NameLang4 = "ВАЗ-2115"
	NameLang5 = "ВАЗ-2115 ДПС"
else
	NameLang1 = "VAZ-2113"
	NameLang2 = "VAZ-2114"
	NameLang3 = "VAZ-2114 Police"
	NameLang4 = "VAZ-2115"
	NameLang5 = "VAZ-2115 Police"
end

local light_table = {
	ModernLights = false, -- грубо говоря, ксенон или старые фары. True - ксенон, false - старые
	L_HeadLampPos = Vector(-24.45,92.25,29.925), -- рассположение обычных фар (левых - L)
	L_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	R_HeadLampPos = Vector(24.45,92.25,29.925), -- рассположение обычных фар (правых - R)
	R_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	L_RearLampPos = Vector(28.57,-81.7,29.2), -- расположение задних фар
	L_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	R_RearLampPos = Vector(-28.57,-81.7,29.2), -- расположение задних фар
	R_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	Headlight_sprites = { -- Обычные фары
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	Headlamp_sprites = { -- дальние
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	FogLight_sprites = { -- противотуманки
		{pos = Vector(25.66,94.6,16.33), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66+2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66-2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		
		{pos = Vector(-25.66+0.6,94.6,16.33+0.1), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66+2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66-2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
	},
	Rearlight_sprites = { -- задние фары
			{pos =  Vector(28.57,-81.7,29.2),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(28.57,-81.7,29.2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(28.57,-81.7,29.2+2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(28.57,-81.7,29.2-2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2+2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2-2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
	},
	Brakelight_sprites = { -- тормозные огни
			{pos =  Vector(17.67,-82.45,29.2),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(17.67,-82.45,29.2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(17.67,-82.45,29.2+2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(17.67,-82.45,29.2-2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2+2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2-2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			
			{pos = Vector(5.7, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(4.66, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(3.63, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(2.6, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(1.55, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(0.52, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-0.52, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-1.55, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-2.6, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-3.63, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-4.66, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-5.7, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[7]={0}}},
			
			{pos = Vector(5.7, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(4.66, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(3.63, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(2.6, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(1.55, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(0.52, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-0.52, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-1.55, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-2.6, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-3.63, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-4.66, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
			{pos = Vector(-5.7, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[7]={0}}},
	},
	Reverselight_sprites = { -- фары заднего хода
		{pos = Vector(23,-82.17,27.42),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
		{pos = Vector(23,-82.17,27.42),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(23+2,-82.17+0.3,27.42),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(23-2,-82.17-0.3,27.42),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		
		{pos = Vector(-0.35-23,0.25-82.17,27.42+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
		{pos = Vector(-0.35-23,0.25-82.17,27.42+0.15),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(-0.35-23-2,0.25-82.17+0.3,27.42+0.15),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(-0.35-23+2,0.25-82.17-0.3,27.42+0.15),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
	},
	Turnsignal_sprites = { -- поворотники
		Right = { -- правый
			{pos =  Vector(33.1,88,29.63),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(33.5,89,29.63),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(38.2,44.82,28.47),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(38.2,44.82,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82+1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82-1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(32.65,-81.1,29.2),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(32.65,-81.1,29.2),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(32.65,-81.1,29.2+2),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(32.65,-81.1,29.2-2),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
		},
		Left = { -- левый
			{pos =  Vector(-33.1+0.6,88,29.63+0.1),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-33.5+0.6,89,29.63+0.1),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82+1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82-1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2+2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2-2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
		},
	},
	SubMaterials = {
        off = {
            Base = {
                [12] = "models/crskautos/shared/vmt/white_illum",
            },
        },
        on_lowbeam = {
            Base = {
                [12] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
        on_highbeam = {
            Base = {
                [12] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
    },
}
list.Set( "simfphys_lights", "vaz-2113", light_table) -- здесь тебе нужно изменить "test" на любое другое название, например "myfirstsimfcar"

local V = {
	Name = NameLang1, -- название машины в меню
	Model = model1, -- модель машины (в вкладке дополнения и проп авто)
	Category = "Willi302's Cars", -- категория в которой будет машина

	Members = {
		Mass = 1400, -- масса авто

		ModelInfo = {
			Color = Color(140, 140, 140)
		},
		
		OnTick = function(v)
			v:SetPoseParameter("fuel_needle", v:GetFuel() / v:GetMaxFuel())
		end,
		
		SpeedoMax = -1, -- какая максималка на спидометре(может работать криво)

		LightsTable = "vaz-2113", -- название light_table

		AirFriction = -300000,

		FrontWheelRadius = 12,--радиус переднего колеса
		RearWheelRadius = 12,--радиус заднего колеса

		CustomMassCenter = Vector(0,0,-1), 

		SeatOffset = Vector(-2,0,-4), -- положение водительского сидения
		SeatPitch = 0,

		PassengerSeats = { -- пассажирские места
			{
				pos = Vector(17,7,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(0,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(-17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
		},

		ExhaustPositions = { -- позиция выхлопа
        	{
                pos = Vector(-25.5,-82.3,10.87),
                ang = Angle(120,-110,0),
        	},
        },

		StrengthenSuspension = false, -- жесткая подвеска.

		FrontHeight = 10, -- высота передней подвески
		FrontConstant = 43000,
		FrontDamping = 3000,
		FrontRelativeDamping = 3000,

		RearHeight = 12, -- высота задней подвески
		RearConstant = 43000,
		RearDamping = 3000,
		RearRelativeDamping = 3000,

		FastSteeringAngle = 20,
		SteeringFadeFastSpeed = 1000,

		TurnSpeed = 8,

		MaxGrip = 45,
		Efficiency = 1,
		GripOffset = -3,
		BrakePower = 55, -- сила торможения

		IdleRPM = 750, -- мин. кол-во оборотов
		LimitRPM = 8000, -- макс. кол-во оборотов
		Revlimiter = true, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 140, -- крутящий момент
		PowerbandStart = 850, -- какие обороты на нейтральной передаче
		PowerbandEnd = 6000, -- ограничение по оборотам
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп

		FuelFillPos = Vector(37, -74.5, 29), -- положение заправки
		FuelType = FUELTYPE_PETROL, -- тип топлива
		FuelTankSize = 43, -- размер бака

		PowerBias = -1, -- привод. 1 - задний, 0 - полный, -1 - передний

		EngineSoundPreset = -1,
--
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/generic1/generic1_idle.ogg",

		snd_low = "simulated_vehicles/generic1/generic1_low.ogg",
		snd_low_revdown = "simulated_vehicles/generic1/generic1_low.ogg", -- это всё звук
		snd_low_pitch = 0.8,

		snd_mid = "simulated_vehicles/generic1/generic1_mid.ogg",
		snd_mid_gearup = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_geardown = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_pitch = 0.8,

		snd_horn = "simulated_vehicles/horn_7.ogg",

--
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.2,0.35,0.5,0.65,0.8} -- кол-во передач и "мощность"
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_vaz-2113", V )

local light_table = {
	ModernLights = false, -- грубо говоря, ксенон или старые фары. True - ксенон, false - старые
	L_HeadLampPos = Vector(-24.45,92.25,29.925), -- рассположение обычных фар (левых - L)
	L_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	R_HeadLampPos = Vector(24.45,92.25,29.925), -- рассположение обычных фар (правых - R)
	R_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	L_RearLampPos = Vector(28.57,-81.7,29.2), -- расположение задних фар
	L_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	R_RearLampPos = Vector(-28.57,-81.7,29.2), -- расположение задних фар
	R_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	Headlight_sprites = { -- Обычные фары
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	Headlamp_sprites = { -- дальние
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	FogLight_sprites = { -- противотуманки
		{pos = Vector(25.66,94.6,16.33), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66+2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66-2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		
		{pos = Vector(-25.66+0.6,94.6,16.33+0.1), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66+2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66-2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
	},
	Rearlight_sprites = { -- задние фары
			{pos =  Vector(28.57,-81.7,29.2),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(28.57,-81.7,29.2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(28.57,-81.7,29.2+2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(28.57,-81.7,29.2-2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2+2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2-2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
	},
	Brakelight_sprites = { -- тормозные огни
			{pos =  Vector(17.67,-82.45,29.2),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(17.67,-82.45,29.2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(17.67,-82.45,29.2+2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(17.67,-82.45,29.2-2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2+2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2-2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			
			{pos = Vector(5.7, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(4.66, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(3.63, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(2.6, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(1.55, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(0.52, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-0.52, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-1.55, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-2.6, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-3.63, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-4.66, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-5.7, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[6]={0}}},
			
			{pos = Vector(5.7, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(4.66, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(3.63, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(2.6, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(1.55, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(0.52, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-0.52, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-1.55, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-2.6, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-3.63, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-4.66, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
			{pos = Vector(-5.7, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[6]={0}}},
	},
	Reverselight_sprites = { -- фары заднего хода
		{pos = Vector(23,-82.17,27.42),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
		{pos = Vector(23,-82.17,27.42),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(23+2,-82.17+0.3,27.42),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(23-2,-82.17-0.3,27.42),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		
		{pos = Vector(-0.35-23,0.25-82.17,27.42+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
		{pos = Vector(-0.35-23,0.25-82.17,27.42+0.15),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(-0.35-23-2,0.25-82.17+0.3,27.42+0.15),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(-0.35-23+2,0.25-82.17-0.3,27.42+0.15),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
	},
	Turnsignal_sprites = { -- поворотники
		Right = { -- правый
			{pos =  Vector(33.1,88,29.63),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(33.5,89,29.63),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(38.2,44.82,28.47),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(38.2,44.82,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82+1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82-1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(32.65,-81.1,29.2),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(32.65,-81.1,29.2),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(32.65,-81.1,29.2+2),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(32.65,-81.1,29.2-2),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
		},
		Left = { -- левый
			{pos =  Vector(-33.1+0.6,88,29.63+0.1),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-33.5+0.6,89,29.63+0.1),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82+1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82-1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2+2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2-2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
		},
	},
	SubMaterials = {
        off = {
            Base = {
                [10] = "models/crskautos/shared/vmt/white_illum",
            },
        },
        on_lowbeam = {
            Base = {
                [10] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
        on_highbeam = {
            Base = {
                [10] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
    },
}
list.Set( "simfphys_lights", "vaz-2114", light_table) -- здесь тебе нужно изменить "test" на любое другое название, например "myfirstsimfcar"

local V = {
	Name = NameLang2, -- название машины в меню
	Model = model2, -- модель машины (в вкладке дополнения и проп авто)
	Category = "Willi302's Cars", -- категория в которой будет машина

	Members = {
		Mass = 1400, -- масса авто

		ModelInfo = {
			Color = Color(110, 110, 110)
		},
		
		OnTick = function(v)
			v:SetPoseParameter("fuel_needle", v:GetFuel() / v:GetMaxFuel())
		end,
		
		SpeedoMax = -1, -- какая максималка на спидометре(может работать криво)

		LightsTable = "vaz-2114", -- название light_table

		AirFriction = -300000,

		FrontWheelRadius = 12,--радиус переднего колеса
		RearWheelRadius = 12,--радиус заднего колеса

		CustomMassCenter = Vector(0,0,-1), 

		SeatOffset = Vector(-2,0,-4), -- положение водительского сидения
		SeatPitch = 0,

		PassengerSeats = { -- пассажирские места
			{
				pos = Vector(17,7,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(0,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(-17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
		},

		ExhaustPositions = { -- позиция выхлопа
        	{
                pos = Vector(-25.5,-82.3,10.87),
                ang = Angle(120,-110,0),
        	},
        },

		StrengthenSuspension = false, -- жесткая подвеска.

		FrontHeight = 10, -- высота передней подвески
		FrontConstant = 43000,
		FrontDamping = 3000,
		FrontRelativeDamping = 3000,

		RearHeight = 12, -- высота задней подвески
		RearConstant = 43000,
		RearDamping = 3000,
		RearRelativeDamping = 3000,

		FastSteeringAngle = 20,
		SteeringFadeFastSpeed = 1000,

		TurnSpeed = 8,

		MaxGrip = 45,
		Efficiency = 1,
		GripOffset = -3,
		BrakePower = 55, -- сила торможения

		IdleRPM = 750, -- мин. кол-во оборотов
		LimitRPM = 8000, -- макс. кол-во оборотов
		Revlimiter = true, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 140, -- крутящий момент
		PowerbandStart = 850, -- какие обороты на нейтральной передаче
		PowerbandEnd = 6000, -- ограничение по оборотам
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп

		FuelFillPos = Vector(37, -74.5, 29), -- положение заправки
		FuelType = FUELTYPE_PETROL, -- тип топлива
		FuelTankSize = 43, -- размер бака

		PowerBias = -1, -- привод. 1 - задний, 0 - полный, -1 - передний

		EngineSoundPreset = -1,
--
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/generic1/generic1_idle.ogg",

		snd_low = "simulated_vehicles/generic1/generic1_low.ogg",
		snd_low_revdown = "simulated_vehicles/generic1/generic1_low.ogg", -- это всё звук
		snd_low_pitch = 0.8,

		snd_mid = "simulated_vehicles/generic1/generic1_mid.ogg",
		snd_mid_gearup = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_geardown = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_pitch = 0.8,

		snd_horn = "simulated_vehicles/horn_7.ogg",

--
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.2,0.35,0.5,0.65,0.8} -- кол-во передач и "мощность"
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_vaz-2114", V )

local light_table = {
	ModernLights = false, -- грубо говоря, ксенон или старые фары. True - ксенон, false - старые
	L_HeadLampPos = Vector(-24.45,92.25,29.925), -- рассположение обычных фар (левых - L)
	L_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	R_HeadLampPos = Vector(24.45,92.25,29.925), -- рассположение обычных фар (правых - R)
	R_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	L_RearLampPos = Vector(28.57,-81.7,29.2), -- расположение задних фар
	L_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	R_RearLampPos = Vector(-28.57,-81.7,29.2), -- расположение задних фар
	R_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	Headlight_sprites = { -- Обычные фары
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	Headlamp_sprites = { -- дальние
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	FogLight_sprites = { -- противотуманки
		{pos = Vector(25.66,94.6,16.33), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66+2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66-2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		
		{pos = Vector(-25.66+0.6,94.6,16.33+0.1), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66+2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66-2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
	},
	Rearlight_sprites = { -- задние фары
			{pos =  Vector(28.57,-81.7,29.2),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(28.57,-81.7,29.2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(28.57,-81.7,29.2+2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(28.57,-81.7,29.2-2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2+2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-28.57,0.25-81.7,29.2-2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
	},
	Brakelight_sprites = { -- тормозные огни
			{pos =  Vector(17.67,-82.45,29.2),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(17.67,-82.45,29.2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(17.67,-82.45,29.2+2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(17.67,-82.45,29.2-2),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,160,0,100)},
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2+2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			{pos =  Vector(-0.35-17.67,0.25-82.45,29.2-2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,60,0)},
			
			{pos = Vector(5.7, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(4.66, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(3.63, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(2.6, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(1.55, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(0.52, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-0.52, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-1.55, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-2.6, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-3.63, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-4.66, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-5.7, -85.8, 42.7),size = 7,color = Color(255, 160, 0, 255), material = 'sprites/light_ignorez_new2',OnBodyGroups = {[9]={0}}},
			
			{pos = Vector(5.7, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(4.66, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(3.63, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(2.6, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(1.55, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(0.52, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-0.52, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-1.55, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-2.6, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-3.63, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-4.66, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
			{pos = Vector(-5.7, -85.8, 42.7),size = 15,color = Color(255, 80, 0, 255), material = 'sprites/light_ignorez_new',OnBodyGroups = {[9]={0}}},
	},
	Reverselight_sprites = { -- фары заднего хода
		{pos = Vector(23,-82.17,27.42),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
		{pos = Vector(23,-82.17,27.42),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(23+2,-82.17+0.3,27.42),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(23-2,-82.17-0.3,27.42),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		
		{pos = Vector(-0.35-23,0.25-82.17,27.42+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
		{pos = Vector(-0.35-23,0.25-82.17,27.42+0.15),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(-0.35-23-2,0.25-82.17+0.3,27.42+0.15),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
		{pos = Vector(-0.35-23+2,0.25-82.17-0.3,27.42+0.15),size = 50,material="sprites/light_ignorez_new", color = Color(220,205,160)},
	},
	Turnsignal_sprites = { -- поворотники
		Right = { -- правый
			{pos =  Vector(33.1,88,29.63),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(33.5,89,29.63),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(38.2,44.82,28.47),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(38.2,44.82,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82+1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82-1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(32.65,-81.1,29.2),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(32.65,-81.1,29.2),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(32.65,-81.1,29.2+2),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(32.65,-81.1,29.2-2),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
		},
		Left = { -- левый
			{pos =  Vector(-33.1+0.6,88,29.63+0.1),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-33.5+0.6,89,29.63+0.1),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82+1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82-1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2+0.15),size = 20,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2+2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-32.65-0.35,-81.1+0.25,29.2-2+0.15),size = 40,material="sprites/light_ignorez_new", color = Color(255,140,0)},
		},
	},
	ems_sounds = siren,
	ems_sprites = {
		{pos = Vector(-9.8,-7.8,66.05),size = 80,material = "sprites/light_ignorez_new",Colors = {Color(255,80,0,255),Color(255,80,0,225),Color(255,80,0,200),Color(255,80,0,175),Color(255,80,0,150),Color(255,80,0,125),Color(255,80,0,100),Color(255,80,0,75),Color(255,80,0,50),Color(255,80,0,25),Color(255,80,0,0),Color(255,80,0,0),Color(0,0,0)},Speed = 0.05,},
		{pos = Vector(-22.26,-7.8,66.05),size = 80,material = "sprites/light_ignorez_new",Colors = {Color(255,80,0,50),Color(255,80,0,25),Color(255,80,0,0),Color(255,80,0,0),Color(0,0,0),Color(255,80,0,255),Color(255,80,0,225),Color(255,80,0,200),Color(255,80,0,175),Color(255,80,0,150),Color(255,80,0,125),Color(255,80,0,100),Color(255,80,0,75)},Speed = 0.05,},
		
		{pos = Vector(9.8,-7.8,66.05),size = 80,material = "sprites/light_ignorez_new",Colors = {Color(0,150,255,25),Color(0,150,255,0),Color(0,150,255,0),Color(0,0,0),Color(0,150,255,255),Color(0,150,255,225),Color(0,150,255,200),Color(0,150,255,175),Color(0,150,255,150),Color(0,150,255,125),Color(0,150,255,100),Color(0,150,255,75),Color(0,150,255,50)},Speed = 0.05,},
		{pos = Vector(22.26,-7.8,66.05),size = 80,material = "sprites/light_ignorez_new",Colors = {Color(0,150,255,0),Color(0,150,255,0),Color(0,0,0),Color(0,150,255,255),Color(0,150,255,225),Color(0,150,255,200),Color(0,150,255,175),Color(0,150,255,150),Color(0,150,255,125),Color(0,150,255,100),Color(0,150,255,75),Color(0,150,255,50),Color(0,150,255,25)},Speed = 0.05,},
	
	
		{pos = Vector(-9.8,-7.8,66.05),size = 200,material = "sprites/light_ignorez_new2",Colors = {Color(255,0,0,255/2.55),Color(255,0,0,225/2.55),Color(255,0,0,200/2.55),Color(255,0,0,175/2.55),Color(255,0,0,150/2.55),Color(255,0,0,125/2.55),Color(255,0,0,100/2.55),Color(255,0,0,75/2.55),Color(255,0,0,50/2.55),Color(255,0,0,25/2.55),Color(255,0,0,0),Color(255,0,0,0),Color(0,0,0)},Speed = 0.05,},
		{pos = Vector(-22.26,-7.8,66.05),size = 200,material = "sprites/light_ignorez_new2",Colors = {Color(255,0,0,50/2.55),Color(255,0,0,25/2.55),Color(255,0,0,0),Color(255,0,0,0),Color(0,0,0),Color(255,0,0,255/2.55),Color(255,0,0,225/2.55),Color(255,0,0,200/2.55),Color(255,0,0,175/2.55),Color(255,0,0,150/2.55),Color(255,0,0,125/2.55),Color(255,0,0,100/2.55),Color(255,0,0,75/2.55)},Speed = 0.05,},
		
		{pos = Vector(9.8,-7.8,66.05),size = 200,material = "sprites/light_ignorez_new2",Colors = {Color(0,100,255,25/2.55),Color(0,100,255,0),Color(0,100,255,0),Color(0,0,0),Color(0,100,255,255/2.55),Color(0,100,255,225/2.55),Color(0,100,255,200/2.55),Color(0,100,255,175/2.55),Color(0,100,255,150/2.55),Color(0,100,255,125/2.55),Color(0,100,255,100/2.55),Color(0,100,255,75/2.55),Color(0,100,255,50)},Speed = 0.05,},
		{pos = Vector(22.26,-7.8,66.05),size = 200,material = "sprites/light_ignorez_new2",Colors = {Color(0,100,255,0),Color(0,100,255,0),Color(0,0,0),Color(0,100,255,255/2.55),Color(0,100,255,225/2.55),Color(0,100,255,200/2.55),Color(0,100,255,175/2.55),Color(0,100,255,150/2.55),Color(0,100,255,125/2.55),Color(0,100,255,100/2.55),Color(0,100,255,75/2.55),Color(0,100,255,50/2.55),Color(0,100,255,25)},Speed = 0.05,},
	},
	SubMaterials = {
        off = {
            Base = {
                [10] = "models/crskautos/shared/vmt/white_illum",
            },
        },
        on_lowbeam = {
            Base = {
                [10] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
        on_highbeam = {
            Base = {
                [10] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
    },
}
list.Set( "simfphys_lights", "vaz-2114_pol", light_table) -- здесь тебе нужно изменить "test" на любое другое название, например "myfirstsimfcar"

local V = {
	Name = NameLang3, -- название машины в меню
	Model = model3, -- модель машины (в вкладке дополнения и проп авто)
	Category = "Willi302's Cars", -- категория в которой будет машина

	Members = {
		Mass = 1400, -- масса авто
		
		OnTick = function(v)
			v:SetPoseParameter("fuel_needle", v:GetFuel() / v:GetMaxFuel())
		end,
		
		SpeedoMax = -1, -- какая максималка на спидометре(может работать криво)

		LightsTable = "vaz-2114_pol", -- название light_table

		AirFriction = -300000,

		FrontWheelRadius = 12,--радиус переднего колеса
		RearWheelRadius = 12,--радиус заднего колеса

		CustomMassCenter = Vector(0,0,-1), 

		SeatOffset = Vector(-2,0,-4), -- положение водительского сидения
		SeatPitch = 0,

		PassengerSeats = { -- пассажирские места
			{
				pos = Vector(17,7,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(0,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(-17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
		},

		ExhaustPositions = { -- позиция выхлопа
        	{
                pos = Vector(-25.5,-82.3,10.87),
                ang = Angle(120,-110,0),
        	},
        },

		StrengthenSuspension = false, -- жесткая подвеска.

		FrontHeight = 10, -- высота передней подвески
		FrontConstant = 43000,
		FrontDamping = 3000,
		FrontRelativeDamping = 3000,

		RearHeight = 12, -- высота задней подвески
		RearConstant = 43000,
		RearDamping = 3000,
		RearRelativeDamping = 3000,

		FastSteeringAngle = 20,
		SteeringFadeFastSpeed = 1000,

		TurnSpeed = 8,

		MaxGrip = 45,
		Efficiency = 1,
		GripOffset = -3,
		BrakePower = 55, -- сила торможения

		IdleRPM = 750, -- мин. кол-во оборотов
		LimitRPM = 8000, -- макс. кол-во оборотов
		Revlimiter = true, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 165, -- крутящий момент
		PowerbandStart = 850, -- какие обороты на нейтральной передаче
		PowerbandEnd = 6000, -- ограничение по оборотам
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп

		FuelFillPos = Vector(37, -74.5, 29), -- положение заправки
		FuelType = FUELTYPE_PETROL, -- тип топлива
		FuelTankSize = 43, -- размер бака

		PowerBias = -1, -- привод. 1 - задний, 0 - полный, -1 - передний

		EngineSoundPreset = -1,
--
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/generic1/generic1_idle.ogg",

		snd_low = "simulated_vehicles/generic1/generic1_low.ogg",
		snd_low_revdown = "simulated_vehicles/generic1/generic1_low.ogg", -- это всё звук
		snd_low_pitch = 0.8,

		snd_mid = "simulated_vehicles/generic1/generic1_mid.ogg",
		snd_mid_gearup = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_geardown = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_pitch = 0.8,

		snd_horn = "vehicles/sim_fphys_lada_samara/horn.ogg",

--
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.2,0.35,0.5,0.65,0.8} -- кол-во передач и "мощность"
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_vaz-2114_pol", V )

local light_table = {
	ModernLights = false, -- грубо говоря, ксенон или старые фары. True - ксенон, false - старые
	L_HeadLampPos = Vector(-24.45,92.25,29.925), -- рассположение обычных фар (левых - L)
	L_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	R_HeadLampPos = Vector(24.45,92.25,29.925), -- рассположение обычных фар (правых - R)
	R_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	L_RearLampPos = Vector(28.5,-91.5,30.35), -- расположение задних фар
	L_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	R_RearLampPos = Vector(-28.5,-91.5,30.35), -- расположение задних фар
	R_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	Headlight_sprites = { -- Обычные фары
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	Headlamp_sprites = { -- дальние
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	FogLight_sprites = { -- противотуманки
		{pos = Vector(25.66,94.6,16.33), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66+2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66-2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		
		{pos = Vector(-25.66+0.6,94.6,16.33+0.1), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66+2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66-2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
		
		{pos = Vector(15.34,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(15.84,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(15.34,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(14.84,-91.455,28.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(-15.34-0.4,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(-15.84-0.4,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-15.34-0.4,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-14.84-0.4,-91.455,28.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
	},
	Rearlight_sprites = { -- задние фары
		{pos = Vector(28.52,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(28.62,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(28.52,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(28.22,-91.455,28.34),size = 40,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(-28.52-0.4,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(-28.62-0.4,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-28.52-0.4,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-28.22-0.4,-91.455,28.34),size = 40,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
	},
	Brakelight_sprites = { -- тормозные огни
		{pos = Vector(24.205,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(24.705,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(24.205,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(23.705,-91.455,28.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(-24.205-0.4,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(-24.705-0.4,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-24.205-0.4,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-23.705-0.4,-91.455,28.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(1.28-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(2.4-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(3.52-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(4.64-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(5.76-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-0.16,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-1.28,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-2.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-3.52,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-4.64,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-5.76,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		
		{pos = Vector(1.28-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(2.4-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(3.52-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(4.64-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(5.76-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-0.16,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-1.28,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-2.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-3.52,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-4.64,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-5.76,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		
	},
	Reverselight_sprites = { -- фары заднего хода
		{pos = Vector(19.4,-91.455,32.45),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		{pos = Vector(18.5,-91.455,30.55),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		{pos = Vector(17.6,-91.455,28.65),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(-19.4-0.4,-91.455,32.45),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-18.5-0.4,-91.455,30.55),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-17.6-0.4,-91.455,28.65),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
	},
	Turnsignal_sprites = { -- поворотники
		Right = { -- правый
			{pos =  Vector(33.1,88,29.63),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(33.5,89,29.63),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(38.2,44.82,28.47),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(38.2,44.82,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82+1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82-1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(32.645,-89.155,30.34),size = 20,color = Color(255,255,0,100),material="sprites/light_ignorez_new2"},
			{pos =  Vector(32.645,-89.155,32.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
			{pos =  Vector(32.645,-89.155,30.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
			{pos =  Vector(32.645,-89.155,28.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
		},
		Left = { -- левый
			{pos =  Vector(-33.1+0.6,88,29.63+0.1),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-33.5+0.6,89,29.63+0.1),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82+1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82-1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-32.645-0.4,-89.155,30.34),size = 20,color = Color(255,255,0,100),material="sprites/light_ignorez_new2"},
			{pos =  Vector(-32.645-0.4,-89.155,32.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
			{pos =  Vector(-32.645-0.4,-89.155,30.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
			{pos =  Vector(-32.645-0.4,-89.155,28.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
		},
	},
	SubMaterials = {
        off = {
            Base = {
                [12] = "models/crskautos/shared/vmt/white_illum",
            },
        },
        on_lowbeam = {
            Base = {
                [12] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
        on_highbeam = {
            Base = {
                [12] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
    },
}
list.Set( "simfphys_lights", "vaz-2115", light_table) -- здесь тебе нужно изменить "test" на любое другое название, например "myfirstsimfcar"

local V = {
	Name = NameLang4, -- название машины в меню
	Model = model4, -- модель машины (в вкладке дополнения и проп авто)
	Category = "Willi302's Cars", -- категория в которой будет машина

	Members = {
		Mass = 1400, -- масса авто

		ModelInfo = {
			Color = Color(110, 110, 110)
		},
		
		OnTick = function(v)
			v:SetPoseParameter("fuel_needle", v:GetFuel() / v:GetMaxFuel())
		end,
		
		SpeedoMax = -1, -- какая максималка на спидометре(может работать криво)

		LightsTable = "vaz-2115", -- название light_table

		AirFriction = -300000,

		FrontWheelRadius = 12,--радиус переднего колеса
		RearWheelRadius = 12,--радиус заднего колеса

		CustomMassCenter = Vector(0,0,-1), 

		SeatOffset = Vector(-2,0,-4), -- положение водительского сидения
		SeatPitch = 0,

		PassengerSeats = { -- пассажирские места
			{
				pos = Vector(17,7,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(0,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(-17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
		},

		ExhaustPositions = { -- позиция выхлопа
        	{
                pos = Vector(-25.5,-91.5,10.5),
                ang = Angle(120,-110,0),
        	},
        },

		StrengthenSuspension = false, -- жесткая подвеска.

		FrontHeight = 10, -- высота передней подвески
		FrontConstant = 43000,
		FrontDamping = 3000,
		FrontRelativeDamping = 3000,

		RearHeight = 12, -- высота задней подвески
		RearConstant = 43000,
		RearDamping = 3000,
		RearRelativeDamping = 3000,

		FastSteeringAngle = 20,
		SteeringFadeFastSpeed = 1000,

		TurnSpeed = 8,

		MaxGrip = 45,
		Efficiency = 1,
		GripOffset = -3,
		BrakePower = 55, -- сила торможения

		IdleRPM = 750, -- мин. кол-во оборотов
		LimitRPM = 8000, -- макс. кол-во оборотов
		Revlimiter = true, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 140, -- крутящий момент
		PowerbandStart = 850, -- какие обороты на нейтральной передаче
		PowerbandEnd = 6000, -- ограничение по оборотам
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп

		FuelFillPos = Vector(37, -83, 29), -- положение заправки
		FuelType = FUELTYPE_PETROL, -- тип топлива
		FuelTankSize = 43, -- размер бака

		PowerBias = -1, -- привод. 1 - задний, 0 - полный, -1 - передний

		EngineSoundPreset = -1,
--
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/generic1/generic1_idle.ogg",

		snd_low = "simulated_vehicles/generic1/generic1_low.ogg",
		snd_low_revdown = "simulated_vehicles/generic1/generic1_low.ogg", -- это всё звук
		snd_low_pitch = 0.8,

		snd_mid = "simulated_vehicles/generic1/generic1_mid.ogg",
		snd_mid_gearup = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_geardown = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_pitch = 0.8,

		snd_horn = "simulated_vehicles/horn_7.ogg",

--
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.2,0.35,0.5,0.65,0.8} -- кол-во передач и "мощность"
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_vaz-2115", V )

local light_table = {
	ModernLights = false, -- грубо говоря, ксенон или старые фары. True - ксенон, false - старые
	L_HeadLampPos = Vector(-24.45,92.25,29.925), -- рассположение обычных фар (левых - L)
	L_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	R_HeadLampPos = Vector(24.45,92.25,29.925), -- рассположение обычных фар (правых - R)
	R_HeadLampAng = Angle(180,-90,0), -- угол поворота фар

	L_RearLampPos = Vector(28.5,-91.5,30.35), -- расположение задних фар
	L_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	R_RearLampPos = Vector(-28.5,-91.5,30.35), -- расположение задних фар
	R_RearLampAng = Angle(0,-90,0), -- угол поворота фар

	Headlight_sprites = { -- Обычные фары
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	Headlamp_sprites = { -- дальние
		{pos =  Vector(24.45,92.25,29.925),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45+4,92.25-0.5,29.925),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(24.45-4,92.25+1,29.925),size = 100,material="sprites/light_ignorez_new"},
		
		{pos =  Vector(-24.45+0.6,92.25,29.925+0.1),size = 60,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45-4+0.6,92.25-0.5,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
		{pos =  Vector(-24.45+4+0.6,92.25+1,29.925+0.1),size = 100,material="sprites/light_ignorez_new"},
	},
	FogLight_sprites = { -- противотуманки
		{pos = Vector(25.66,94.6,16.33), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66+2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(25.66-2,95.6,16.33), size = 80,material="sprites/light_ignorez_new"},
		
		{pos = Vector(-25.66+0.6,94.6,16.33+0.1), size = 40,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66+2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
		{pos = Vector(-25.66-2+0.6,95.6,16.33+0.1), size = 80,material="sprites/light_ignorez_new"},
		
		{pos = Vector(15.34,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(15.84,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(15.34,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(14.84,-91.455,28.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(-15.34-0.4,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(-15.84-0.4,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-15.34-0.4,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-14.84-0.4,-91.455,28.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
	},
	Rearlight_sprites = { -- задние фары
		{pos = Vector(28.52,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(28.62,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(28.52,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(28.22,-91.455,28.34),size = 40,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(-28.52-0.4,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(-28.62-0.4,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-28.52-0.4,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-28.22-0.4,-91.455,28.34),size = 40,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
	},
	Brakelight_sprites = { -- тормозные огни
		{pos = Vector(24.205,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(24.705,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(24.205,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(23.705,-91.455,28.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(-24.205-0.4,-91.455,30.34),size = 20,color=Color(255,160,0,100),material="sprites/light_ignorez_new2"},
		{pos = Vector(-24.705-0.4,-91.455,32.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-24.205-0.4,-91.455,30.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-23.705-0.4,-91.455,28.34),size = 35,color=Color(255,60,0,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(1.28-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(2.4-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(3.52-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(4.64-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(5.76-0.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-0.16,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-1.28,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-2.4,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-3.52,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-4.64,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		{pos = Vector(-5.76,-93,46.1),size = 7,color=Color(255,150,0),material="sprites/light_ignorez_new2",OnBodyGroups={[6]={0}}},
		
		{pos = Vector(1.28-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(2.4-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(3.52-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(4.64-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(5.76-0.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-0.16,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-1.28,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-2.4,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-3.52,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-4.64,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		{pos = Vector(-5.76,-93,46.1),size = 15,color=Color(255,40,0),material="sprites/light_ignorez_new",OnBodyGroups={[6]={0}}},
		
	},
	Reverselight_sprites = { -- фары заднего хода
		{pos = Vector(19.4,-91.455,32.45),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		{pos = Vector(18.5,-91.455,30.55),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		{pos = Vector(17.6,-91.455,28.65),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		
		{pos = Vector(-19.4-0.4,-91.455,32.45),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-18.5-0.4,-91.455,30.55),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
		{pos = Vector(-17.6-0.4,-91.455,28.65),size = 50,color = Color(220,205,160,255),material="sprites/light_ignorez_new"},
	},
	Turnsignal_sprites = { -- поворотники
		Right = { -- правый
			{pos =  Vector(33.1,88,29.63),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(33.5,89,29.63),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(38.2,44.82,28.47),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(38.2,44.82,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82+1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(38.2,44.82-1,28.47),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(32.645,-89.155,30.34),size = 20,color = Color(255,255,0,100),material="sprites/light_ignorez_new2"},
			{pos =  Vector(32.645,-89.155,32.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
			{pos =  Vector(32.645,-89.155,30.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
			{pos =  Vector(32.645,-89.155,28.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
		},
		Left = { -- левый
			{pos =  Vector(-33.1+0.6,88,29.63+0.1),size = 15,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-33.5+0.6,89,29.63+0.1),size = 80,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 10,material="sprites/light_ignorez_new2", color = Color(255,255,0,100)},
			{pos =  Vector(-38.2+0.5,44.82+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82+1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			{pos =  Vector(-38.2+0.5,44.82-1+0.15,28.47+0.1),size = 20,material="sprites/light_ignorez_new", color = Color(255,140,0)},
			
			{pos =  Vector(-32.645-0.4,-89.155,30.34),size = 20,color = Color(255,255,0,100),material="sprites/light_ignorez_new2"},
			{pos =  Vector(-32.645-0.4,-89.155,32.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
			{pos =  Vector(-32.645-0.4,-89.155,30.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
			{pos =  Vector(-32.645-0.4,-89.155,28.34),size = 40,color = Color(255,120,0,255),material="sprites/light_ignorez_new"},
		},
	},
	ems_sounds = siren,
	ems_sprites = {
		{pos = Vector(-9.8,-7.8,66.05),size = 80,material = "sprites/light_ignorez_new",Colors = {Color(255,80,0,255),Color(255,80,0,225),Color(255,80,0,200),Color(255,80,0,175),Color(255,80,0,150),Color(255,80,0,125),Color(255,80,0,100),Color(255,80,0,75),Color(255,80,0,50),Color(255,80,0,25),Color(255,80,0,0),Color(255,80,0,0),Color(0,0,0)},Speed = 0.05,},
		{pos = Vector(-22.26,-7.8,66.05),size = 80,material = "sprites/light_ignorez_new",Colors = {Color(255,80,0,50),Color(255,80,0,25),Color(255,80,0,0),Color(255,80,0,0),Color(0,0,0),Color(255,80,0,255),Color(255,80,0,225),Color(255,80,0,200),Color(255,80,0,175),Color(255,80,0,150),Color(255,80,0,125),Color(255,80,0,100),Color(255,80,0,75)},Speed = 0.05,},
		
		{pos = Vector(9.8,-7.8,66.05),size = 80,material = "sprites/light_ignorez_new",Colors = {Color(0,150,255,25),Color(0,150,255,0),Color(0,150,255,0),Color(0,0,0),Color(0,150,255,255),Color(0,150,255,225),Color(0,150,255,200),Color(0,150,255,175),Color(0,150,255,150),Color(0,150,255,125),Color(0,150,255,100),Color(0,150,255,75),Color(0,150,255,50)},Speed = 0.05,},
		{pos = Vector(22.26,-7.8,66.05),size = 80,material = "sprites/light_ignorez_new",Colors = {Color(0,150,255,0),Color(0,150,255,0),Color(0,0,0),Color(0,150,255,255),Color(0,150,255,225),Color(0,150,255,200),Color(0,150,255,175),Color(0,150,255,150),Color(0,150,255,125),Color(0,150,255,100),Color(0,150,255,75),Color(0,150,255,50),Color(0,150,255,25)},Speed = 0.05,},
	
	
		{pos = Vector(-9.8,-7.8,66.05),size = 200,material = "sprites/light_ignorez_new2",Colors = {Color(255,0,0,255/2.55),Color(255,0,0,225/2.55),Color(255,0,0,200/2.55),Color(255,0,0,175/2.55),Color(255,0,0,150/2.55),Color(255,0,0,125/2.55),Color(255,0,0,100/2.55),Color(255,0,0,75/2.55),Color(255,0,0,50/2.55),Color(255,0,0,25/2.55),Color(255,0,0,0),Color(255,0,0,0),Color(0,0,0)},Speed = 0.05,},
		{pos = Vector(-22.26,-7.8,66.05),size = 200,material = "sprites/light_ignorez_new2",Colors = {Color(255,0,0,50/2.55),Color(255,0,0,25/2.55),Color(255,0,0,0),Color(255,0,0,0),Color(0,0,0),Color(255,0,0,255/2.55),Color(255,0,0,225/2.55),Color(255,0,0,200/2.55),Color(255,0,0,175/2.55),Color(255,0,0,150/2.55),Color(255,0,0,125/2.55),Color(255,0,0,100/2.55),Color(255,0,0,75/2.55)},Speed = 0.05,},
		
		{pos = Vector(9.8,-7.8,66.05),size = 200,material = "sprites/light_ignorez_new2",Colors = {Color(0,100,255,25/2.55),Color(0,100,255,0),Color(0,100,255,0),Color(0,0,0),Color(0,100,255,255/2.55),Color(0,100,255,225/2.55),Color(0,100,255,200/2.55),Color(0,100,255,175/2.55),Color(0,100,255,150/2.55),Color(0,100,255,125/2.55),Color(0,100,255,100/2.55),Color(0,100,255,75/2.55),Color(0,100,255,50)},Speed = 0.05,},
		{pos = Vector(22.26,-7.8,66.05),size = 200,material = "sprites/light_ignorez_new2",Colors = {Color(0,100,255,0),Color(0,100,255,0),Color(0,0,0),Color(0,100,255,255/2.55),Color(0,100,255,225/2.55),Color(0,100,255,200/2.55),Color(0,100,255,175/2.55),Color(0,100,255,150/2.55),Color(0,100,255,125/2.55),Color(0,100,255,100/2.55),Color(0,100,255,75/2.55),Color(0,100,255,50/2.55),Color(0,100,255,25)},Speed = 0.05,},
	},
	SubMaterials = {
        off = {
            Base = {
                [12] = "models/crskautos/shared/vmt/white_illum",
            },
        },
        on_lowbeam = {
            Base = {
                [12] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
        on_highbeam = {
            Base = {
                [12] = "models/crskautos/shared/vmt/white_illum_on",
            },
        },
    },
}
list.Set( "simfphys_lights", "vaz-2115_pol", light_table) -- здесь тебе нужно изменить "test" на любое другое название, например "myfirstsimfcar"

local V = {
	Name = NameLang5, -- название машины в меню
	Model = model5, -- модель машины (в вкладке дополнения и проп авто)
	Category = "Willi302's Cars", -- категория в которой будет машина

	Members = {
		Mass = 1400, -- масса авто
		
		SpeedoMax = -1, -- какая максималка на спидометре(может работать криво)

		LightsTable = "vaz-2115_pol", -- название light_table

		OnTick = function(v)
			v:SetPoseParameter("fuel_needle", v:GetFuel() / v:GetMaxFuel())
		end,

		AirFriction = -300000,

		FrontWheelRadius = 12,--радиус переднего колеса
		RearWheelRadius = 12,--радиус заднего колеса

		CustomMassCenter = Vector(0,0,-1), 

		SeatOffset = Vector(-2,0,-4), -- положение водительского сидения
		SeatPitch = 0,

		PassengerSeats = { -- пассажирские места
			{
				pos = Vector(17,7,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(0,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
			{
				pos = Vector(-17,-30,10),
				ang = Angle(0,0,14) -- Vector(ширина, длина, высота),
			},
		},

		ExhaustPositions = { -- позиция выхлопа
        	{
                pos = Vector(-25.5,-91.5,10.5),
                ang = Angle(120,-110,0),
        	},
        },

		StrengthenSuspension = false, -- жесткая подвеска.

		FrontHeight = 10, -- высота передней подвески
		FrontConstant = 43000,
		FrontDamping = 3000,
		FrontRelativeDamping = 3000,

		RearHeight = 12, -- высота задней подвески
		RearConstant = 43000,
		RearDamping = 3000,
		RearRelativeDamping = 3000,

		FastSteeringAngle = 20,
		SteeringFadeFastSpeed = 1000,

		TurnSpeed = 8,

		MaxGrip = 45,
		Efficiency = 1,
		GripOffset = -3,
		BrakePower = 55, -- сила торможения

		IdleRPM = 750, -- мин. кол-во оборотов
		LimitRPM = 8000, -- макс. кол-во оборотов
		Revlimiter = true, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 165, -- крутящий момент
		PowerbandStart = 850, -- какие обороты на нейтральной передаче
		PowerbandEnd = 6000, -- ограничение по оборотам
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп

		FuelFillPos = Vector(37, -83, 29), -- положение заправки
		FuelType = FUELTYPE_PETROL, -- тип топлива
		FuelTankSize = 43, -- размер бака

		PowerBias = -1, -- привод. 1 - задний, 0 - полный, -1 - передний

		EngineSoundPreset = -1,
--
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/generic1/generic1_idle.ogg",

		snd_low = "simulated_vehicles/generic1/generic1_low.ogg",
		snd_low_revdown = "simulated_vehicles/generic1/generic1_low.ogg", -- это всё звук
		snd_low_pitch = 0.8,

		snd_mid = "simulated_vehicles/generic1/generic1_mid.ogg",
		snd_mid_gearup = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_geardown = "simulated_vehicles/generic1/generic1_second.ogg",
		snd_mid_pitch = 0.8,

		snd_horn = "vehicles/sim_fphys_lada_samara/horn.ogg",

--
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.2,0.35,0.5,0.65,0.8} -- кол-во передач и "мощность"
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_vaz-2115_pol", V )

if CLIENT then
	hook.Add("Think", "Simfphys_LADA_Samara_Tacho", function()
		for k,v in pairs(ents.FindByClass("gmod_sent_vehicle_fphysics_base")) do
			if v:GetModel() == model1 or v:GetModel() == model2 or v:GetModel() == model3 or v:GetModel() == model4 or v:GetModel() == model5 then
				local rpm = (v:GetRPM() / v:GetLimitRPM())*(237)
				
				if v.CurAngle == nil then v.CurAngle = 0 end
				v.CurAngle = Lerp(0.2,v.CurAngle,-rpm)
				
				v:ManipulateBoneAngles(v:LookupBone("Tacho"), Angle(0,0,v.CurAngle))
				
				local speed = v:GetVelocity():Length()*0.08
				v:ManipulateBoneAngles(v:LookupBone("Speedo"), Angle(0, 0,-speed))		
			end
		end
	end)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
