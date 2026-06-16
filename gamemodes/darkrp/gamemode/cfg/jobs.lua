--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--
-- Misc
--

--
-- CITIZENS
---

local citizen_spawns = {
    rp_downtown_tits_v2 = {
        Vector(-1650.540283, -1352.181885, -131.968750), 
        Vector(-2169.828613, -1331.543213, -131.968750), 
        Vector(-2150.129883, -1804.375366, -131.968750), 
        Vector(-1639.743408, -1793.006348, -131.968750), 
        Vector(-1633.356079, -1441.097534, -131.968750) 
    },
}

TEAM_CITIZEN = rp.addTeam('Гражданин', {
    color = Color(20, 150, 20),
    model = {'models/player/vitalya.mdl', 'models/player/gpd/karin/female_02.mdl', 'models/player/kamenshik.mdl', 'models/tsoy.mdl', 'models/1000shells/professional/professional.mdl', 'models/8mile/playermodels/8mile.mdl', 'models/cmbfdr/rashkinsk/bodrov.mdl', 'models/thebigcube/pm_gopnik_freeman/gopnik_freeman.mdl', 'models/dejtriyev/georgia/sokhumski_makho.mdl', 'models/sandman/russian/male_07_gopnik.mdl', 'models/yariktriplesix/pena/pena.mdl', 'models/player/kavkaz.mdl'},
    weapons = {},
    command = 'citizen',
    max = 0,
    salary = 550,
    spawns = citizen_spawns,
    admin = 0,
    user = true,
    hasLicense = false,
    category = "Гражданские",
    description = 'Это человек, обладающий правами и обязанностями в рамках определенного государства. Эта профессия включает в себя активное участие в жизни общества, соблюдение законов и норм, а также вовлеченность в политические, экономические и социальные процессы. Гражданин имеет право голосовать, избирая своих представителей, и участвовать в общественных заседаниях и инициативах.',
    candemote = false,
})

TEAM_JURNALIST = rp.addTeam('Журналист', {
    color = Color(127, 255, 212),
    model = {'models/panman/borat_cosplayer_09.mdl'},
    weapons = {'passport_korrespondent'},
    command = 'jurnalist',
    max = 1,
    spawns = citizen_spawns,
    salary = 1050,
    playtime = 5200,
    admin = 0,
    user = true,
    hasLicense = false,
    category = "Гражданские",
    description = 'Это человек, который развивает собственное СМИ Агенство. Вы вправе решать, что Вы хотите донести до граждан и помните: "Тот, кто контролирует СМИ, контролирует разум" (У вас имеется специальная команда /addnews для трансляции новостей)',
    candemote = false,
})


TEAM_CINEMA = rp.addTeam('Владелец Кинотеатра', {
    color = Color(34, 139, 34),
    model = 'models/nuzhdin.mdl',
    weapons = {},
    command = 'cinema',
    max = 1,
    salary = 750,
    spawns = citizen_spawns,
    admin = 0,
    user = true,
    hasLicense = false,
    category = "Гражданские",
    description = 'Владелец кинотеатра — это предприниматель, который управляет кинотеатром или сетью кинотеатров, отвечая за все аспекты их функционирования и развития. Эта профессия требует совмещения бизнес-анализа, управления и творческого подхода.',
    candemote = false,
})




--[[
TEAM_CAZINO = rp.addTeam('Владелец казино', {
    color = Color(147, 112, 219),
    model = 'models/winningrook/gtav/dean/dean_baddman.mdl',
    weapons = {},
    command = 'cazino',
    category = "Гражданские",
    max = 3,
    salary = 1150,
    admin = 0,
    description = 'Ты владеешь казино, ты можешь открыть самую крупную сеть казино в городе, где ты(ПОЛЮБОМУ) будешь выигрывать, ведь казино никогда не проигрывает. Перед началом своего успешного бизнес плана прочитай правила. Удачи тебе, владелец казино.',
    hasLicense = false,
    candemote = false,
    vip = true
})
]]


TEAM_WORKER = rp.addTeam('Разнорабочий', {
    color = Color(165, 42, 42),
    model = 'models/snowred/dab9595/hex/odessa.mdl',
    weapons = {'cityworker_pliers', 'cityworker_shovel', 'cityworker_wrench'},
    command = 'work',
    category = "Гражданские",
    max = 4,
    spawns = citizen_spawns,
    salary = 1050,
    admin = 0,
    description = 'Разнорабочий – работник, выполняющий различные физические работы на производстве, стройке или других объектах. Задачи разнорабочего могут включать переноску материалов, уборку рабочих мест, помощь специалистам в выполнении задач. Работа разнорабочего требует физической выносливости, аккуратности и умения выполнять порученные задания в срок. Разнорабочий играет важную роль в обеспечении эффективности работы производства и комфортных условий для других специалистов.',
    hasLicense = false,
    candemote = false
})

TEAM_DVORNIK = rp.addTeam('Дворник', {
    color = Color(154, 205, 50),
    model = 'models/rashkinsk/babka.mdl',
    weapons = {},
    command = 'dvorn',
    category = "Гражданские",
    max = 4,
    spawns = citizen_spawns,
    salary = 750,
    admin = 0,
    description = 'Дворник – специалист по уборке и содержанию чистоты на территории учреждений, домов, скверов, парков и других общественных мест. Обязанности дворника включают уборку мусора, выметание территории, уход за зелеными насаждениями, снегопад и ледяных наледях зимой, обеспечение порядка на улицах. Работа дворника требует ответственности, аккуратности и умения работать на свежем воздухе. Дворник важен для создания комфортной и безопасной обстановки в городе или на территории учреждения.',
    hasLicense = false,
    candemote = false
})

TEAM_COOK = rp.addTeam('Повариха Галя', {
    color = Color(255, 192, 203),
    model = 'models/rashkinsk/staruska.mdl',
    weapons = {},
    command = 'cook',
    max = 3,
    category = "Гражданские",
    salary = 745,
    admin = 0,
    spawns = citizen_spawns,
    description = 'Открой для себя мир вкуса, стань Шефом своей личной кухни и окунись в захватывающий мир гастрономических возможностей. Вы не просто готовите блюда, а создаете настоящие произведения искусства. Выкупите здание и откройте свой ресторан или кафе, где каждое блюдо – это не просто угощение, а настоящее приключение в мире вкуса.',
    candemote = true,
    cook = true
})

--[[
TEAM_ZAVOD = rp.addTeam('Фасовщик', {
    color = Color(240, 230, 140),
    model = 'models/humans/bms_cwork.mdl',
    weapons = {},
    command = 'zavod',
    category = "Гражданские",
    max = 4,
    spawns = {
        rp_russiacity_v1 = {Vector(326.56915283203, -8530.2529296875, 76.03125)}
    },
    playtime = 1500,
    salary = 850,
    admin = 0,
    description = 'Это специалист, занимающийся упаковкой и фасовкой товаров в соответствии с требованиями заказчика. Основные обязанности фасовщика включают подготовку упаковочного материала, фасовку товаров в соответствии с заданными параметрами, контроль качества упаковки, маркировку продукции и подготовку к отправке.',
    hasLicense = false,
    candemote = false
})
--]]

TEAM_GUN = rp.addTeam('Оружейный барон', {
    color = Color(255, 165, 0),
    model = 'models/rashkinsk/sidor.mdl',
    weapons = {},
    command = 'gundealer',
    max = 3,
    salary = 1050,
    admin = 0,
    spawns = citizen_spawns,
    user = true,
    category = "Гражданские",
    description = 'Ты не просто торговец – ты ответственен за безопасность города. Владей лучшим ассортиментом огнестрельного и холодного оружия, удовлетворяя потребности даже самых требовательных клиентов. Продаются оружие большим организациям, мафиям, и обычным гражданам. Твой труд важен для поддержания баланса в городе.',
    canLite = true,
    candemote = true,
    hasLicense = false
})


TEAM_DELIVERY = rp.addTeam('Доставщик еды', {
    color = Color(233, 150, 122),
    model = {'models/player/vitalya.mdl', 'models/player/witness.mdl', 'models/8mile/playermodels/8mile.mdl', 'models/cmbfdr/rashkinsk/bodrov.mdl', 'models/thebigcube/pm_gopnik_freeman/gopnik_freeman.mdl'},
    weapons = {},
    command = 'delivery',
    category = "Гражданские",
    max = 3,
    spawns = citizen_spawns,
    salary = 1050,
    admin = 0,
    description = 'Доставщик еды — это специалист, занимающийся доставкой продуктов питания и блюд из ресторанов или магазинов до адресов клиентов.',
    hasLicense = false,
    candemote = false
})

-- TEAM_TEST = rp.addTeam('TEST', {
--     color = Color(51, 128, 255),
--     model = 'models/player/combine_super_soldier.mdl',
--     weapons = {'weapon_keypadchecker'},
--     command = 'test',
--     max = 0,
--     salary = 0,
--     admin = 1,
--     canHavy = true,
--     category = "Разное",
--     canLite = true,
--     canVzri = true,
--     candemote = false,
--     CannotOwnDoors = true,
--     mayorCanSetSary = false,
--     selldoors = false,
--     customCheck = function(pl) return KylDonate.HasItem(pl, 'Glock18') end,
--     CustomCheckFailMsg = 'Нужно купить предмет',
--     PlayerSpawn = function(pl) pl:SetArmor(100) pl:GodEnable() pl:SetHealth(10000) pl:GiveAmmos(200) end
-- })


TEAM_ADMIN = rp.addTeam('Администрация', {
    color = Color(51, 128, 255),
    model = 'models/death_a_grim_bundle/player_models/death_painted/death_painted_01.mdl',
    weapons = {'weapon_keypadchecker'},
    command = 'staff',
    max = 0,
    salary = 0,
    spawns = {
        rp_downtown_tits_v2 = {Vector(2535.604980, -5887.087891, -134.996429)}
    },
    admin = 1,
    canHavy = true,
    category = "Разное",
    canLite = true,
    canVzri = true,
    candemote = false,
    CannotOwnDoors = true,
    mayorCanSetSary = false,
    selldoors = false,
    customCheck = function(pl) return pl:HasAccess('M') end,
    CustomCheckFailMsg = 'JobNeedsAdmin',
    PlayerSpawn = function(pl) pl:SetArmor(100) pl:GodEnable() pl:SetHealth(10000) pl:GiveAmmos(200) end
})

-- TEAM_INCASS = rp.addTeam('Инкассатор', {
--     color = Color(233, 150, 122),
--     model = {'models/player/guard_pack/guard_04.mdl'},
--     weapons = {},
--     command = 'incassator',
--     category = "Разное",
--     max = 4,
--     salary = 1250,
--     playtime = 11000,
--     admin = 0,
--     description = 'Инкассатор — сотрудник банка или специализированной сторонней организации, в обязанности которого входит сбор и перевозка наличных денежных средств.',
--     hasLicense = false,
--     candemote = false
-- })

--
-- Government
--
local police_spawns = {
    rp_downtown_tits_v2 = {
        Vector(-2338.663330, 109.599403, 84.031250),
        Vector(-2462.270996, 353.760712, 84.031250),
        Vector(-2229.479248, 510.973480, 84.031250)
    },
}

TEAM_MAYOR = rp.addTeam('Мэр', {
    color = Color(240, 0, 0, 255),
    model = 'models/player/putin.mdl',
    weapons = {''},
    spawns = {
        rp_downtown_tits_v2 = {Vector(-655.03216552734, 5975.2939453125, 80.03125) }
    },
    command = 'mayor',
    max = 1,
    salary = 2500,
    vote = true,
    category = "Правительство",
    candemote = false,
    CannotOwnDoors = true,
    selldoors = true,
    description = 'Ты мэр этого города, тебе доступна вся власть, ты главный человек. Ты можешь повышать налоги, увольнять рабочих, командовать гос. служащими. Твои возможности ограничиваются лишь правилами сервера, которые стоит тебе прочитать перед началом игры! Управляй, пиши законы, создавай лотереи. Удачи тебе, глава города.',
    hasLicense = true,
    user = true,
    mayor = true,
    admin = 0
})


TEAM_SUD = rp.addTeam('Судья', {
    color = Color(139, 0, 0),
    model = 'models/rashkinsk/fsin/parad/parad_fem_06.mdl',
    weapons = {'weapon_taser', 'rwp_tfa_pist_mp416rex', 'stun_baton'},
    command = 'sud',
    max = 1,
    spawns = {
        rp_downtown_tits_v2 = {Vector(-655.03216552734, 5975.2939453125, 80.03125) }
    },
    salary = 1800,
    vote = false,
    category = "Правительство",
    candemote = false,
    CannotOwnDoors = true,
    selldoors = true,
    description = 'Это независимый и беспристрастный специалист, который осуществляет правосудие, рассматривая и решая судебные дела. Его основная задача заключается в интерпретации и применении законов, анализе доказательств и вынесении решений на основе фактов и норм права. Судьи ведут процессы в судах, принимают участие в слушаниях, выносят приговоры, а также могут заниматься медиацией в спорах. Работа судьи требует высокой квалификации, знаний в области права, этических норм и способности принимать взвешенные решения, способствующие обеспечению справедливости.',
    hasLicense = true,
    user = true,
    admin = 0
})

TEAM_DEP = rp.addTeam('Депутат', {
    color = Color(178, 34, 34),
    model = 'models/player/rashkinsk/sobyanin.mdl',
    weapons = {''},
    command = 'dep',
    max = 8,
    salary = 1400,
    vote = false,
    category = "Правительство",
    spawns = {
        rp_downtown_tits_v2 = {Vector(-655.03216552734, 5975.2939453125, 80.03125) }
    },
    candemote = false,
    CannotOwnDoors = true,
    selldoors = true,
    description = 'Депутат — это избранный представитель народа в законодательном органе власти, который принимает участие в разработке, обсуждении и принятии законопроектов. Депутаты представляют интересы своих избирателей и политической партии, в которую входят. Их обязанности включают участие в заседаниях, обсуждение актуальных социальных и экономических вопросов, контроль за исполнением бюджета и защиту прав граждан. Депутаты также активно взаимодействуют с общественными организациями и избирателями для учета их мнений и потребностей в процессе законотворчества. Выбор политической партии помогает закрепить идеологическую позицию депутата и определить приоритетные направления его работы.',
    hasLicense = true,
    user = true,
    admin = 0
})

local fsin_spawns = {
    rp_downtown_tits_v2 = {
        Vector(-2159.659180, 168.278091, 84.031250) 
    },
}

TEAM_FBI = rp.addTeam('Надзиратель ФСИН', {
    color = Color(83,83,242),
    model = {'models/rashkinsk/fsin/camo/camo_02.mdl', 'models/rashkinsk/fsin/camo/camo_03.mdl', 'models/rashkinsk/fsin/camo/camo_04.mdl', 'models/rashkinsk/fsin/camo/camo_05.mdl'},
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'arrest_baton', 'unarrest_baton', 'rwp_tfa_pist_gsh18', 'rwp_tfa_assault_vikhr', 'stun_baton', 'door_ram', 'handcuffs', 'weapon_radio', 'weaponchecker'},
    spawns = fsin_spawns,
    command = 'fbi',
    max = 6,
    salary = 1000,
    admin = 0,
    candemote = true,
    canHavy = true,
    canLite = true,
    canVzri = true,
    category = "ФСИН",
    playtime = 5700,
    hasLicense = true,
    description = 'Надзиратель Федеральной службы исполнения наказаний (ФСИН) - специалист, ответственный за поддержание порядка и контроль за заключенными в исправительных учреждениях. Он осуществляет надзор за выполнением режима и правил заключения, обеспечивает безопасность и защиту заключенных, следит за исполнением решений суда и соблюдением прав человека. Надзиратель также проводит инструктажи и воспитательную работу с осужденными, помогая им реабилитироваться и возвращаться в общество.',
    CannotOwnDoors = true,
    candisguise = true,
    selldoors = true,
    police = true,
    PlayerSpawn = function(pl) pl:SetArmor(100) pl:GiveAmmos(200) end
})

TEAM_SFBI = rp.addTeam('Спецназовец ФСИН', {
    color = Color(83,83,242),
    model = {'models/rashkinsk/fsin/spetsnaz/spetsnaz_02.mdl', 'models/rashkinsk/fsin/spetsnaz/spetsnaz_03.mdl', 'models/rashkinsk/fsin/spetsnaz/spetsnaz_04.mdl', 'models/rashkinsk/fsin/spetsnaz/spetsnaz_05.mdl'},
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'arrest_baton', 'unarrest_baton', 'rwp_tfa_pist_tt33', 'rwp_tfa_smg_aks74u', 'stun_baton', 'door_ram', 'handcuffs', 'weapon_radio', 'weaponchecker'},
    spawns = fsin_spawns,
    command = 'sfbi',
    max = 4,
    salary = 1100,
    admin = 0,
    candemote = true,
    canHavy = true,
    canLite = true,
    canVzri = true,
    category = "ФСИН",
    hasLicense = true,
    description = 'Это высококвалифицированный специалист, обученный для выполнения специальных операций, обеспечения безопасности в учреждениях Федеральной службы исполнения наказаний. Имеет навыки вождения, стрельбы, боевых и технических приемов самообороны. Готов к быстрому реагированию на чрезвычайные ситуации и обеспечению порядка в тюрьмах и исправительных колониях.',
    CannotOwnDoors = true,
    candisguise = true,
    selldoors = true,
    playtime = 25700,
    vip = false,
    police = true,
    PlayerSpawn = function(pl) pl:SetArmor(150) pl:GiveAmmos(200) end
})

TEAM_NFBI = rp.addTeam('Начальник ФСИН', {
    color = Color(83,83,242),
    model = {'models/rashkinsk/fsin/parad/parad_07.mdl', 'models/rashkinsk/fsin/parad/parad_08.mdl', 'models/rashkinsk/fsin/parad/parad_fem_01.mdl', 'models/rashkinsk/fsin/parad/parad_fem_02.mdl'},
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'arrest_baton', 'unarrest_baton', 'rwp_tfa_pist_pb', 'rwp_tfa_shotgun_mp153', 'rwp_tfa_assault_val', 'stun_baton', 'door_ram', 'handcuffs', 'weapon_radio', 'weaponchecker'},
    spawns = fsin_spawns,
    command = 'nfbi',
    max = 1,
    salary = 1500,
    admin = 0,
    candemote = true,
    canHavy = true,
    canLite = true,
    canVzri = true,
    category = "ФСИН",
    hasLicense = true,
    description = 'Начальник Федеральной службы исполнения наказаний (ФСИН) — это высокопрофессиональный управленец, отвечающий за организацию и координацию деятельности учреждения, занимающегося исполнением наказаний, включая исправительные колонии и следственные изолятора. В его обязанности входит управление персоналом, обеспечение соблюдения законности и правопорядка, разработка и внедрение программ по реабилитации осужденных, а также взаимодействие с другими государственными и правоохранительными органами. Начальник ФСИН также занимается стратегическим планированием и анализом результатов работы учреждения, обеспечивая эффективность его функционирования.',
    CannotOwnDoors = true,
    candisguise = true,
    selldoors = true,
    vip = false,
    playtime = 43700,
    police = true,
    PlayerSpawn = function(pl) pl:SetArmor(200) pl:GiveAmmos(200) end
})

-------------------

TEAM_CHIEF = rp.addTeam('Начальник ППС', {
    color = Color(60, 80, 255),
    model = 'models/player/kerry/russian_police_snow/male_06_officer_snow.mdl',
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'weapon_finebook', 'arrest_baton', 'unarrest_baton', 'rwp_tfa_pist_mp416rex', 'rwp_tfa_assault_ak74', 'rwp_tfa_shotgun_becas12m', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'chief',
    max = 1,
    salary = 1600,
    admin = 0,
    user = true,
    category = "Полиция",
    candemote = true,
    canHavy = true,
    playtime = 122000,
    canVzri = true,
    description = 'Начальник ППС — это высокопрофильный начальствующий офицер, отвечающий за организацию и контроль работы подразделений полиции. Его обязанности включают разработку и реализацию оперативных планов, управление personnel, обеспечение общественного порядка и безопасности, а также взаимодействие с другими правоохранительными органами и общественностью. Полковник полиции также участвует в стратегическом планировании, анализе криминогенной ситуации и повышении профессиональной подготовки сотрудников. Данная профессия требует опыта, лидерских качеств и глубоких знаний в области правоохранительной деятельности и уголовного законодательства.',
    canLite = true,
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    police = true,
    PlayerSpawn = function(pl) pl:SetArmor(200) pl:GiveAmmos(200) end
})

TEAM_POLICE = rp.addTeam('Рядовой ППС', {
    color = Color(60, 80, 255),
    model = 'models/player/kerry/russian_police_snow/male_01_patrol_snow.mdl',
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'weapon_finebook', 'arrest_baton', 'rwp_tfa_pist_mp443', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'police',
    max = 10,
    salary = 1100,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 23600,
    canHavy = true,
    canLite = true,
    category = "Полиция",
    canVzri = true,
    description = 'Рядовой ППС — это служитель правоохранительных органов, выполняющий обязанности по обеспечению общественного порядка, безопасности граждан и борьбе с преступностью. Он осуществляет патрулирование, реагирует на вызовы, проводит профилактическую работу, а также участвует в задержании правонарушителей. Рядовой полиции должен обладать хорошими физическими и моральными качествами, навыками общения и умением работать в команде. Его работа подразумевает взаимодействие с населением, соблюдение законности и защиту прав граждан. Профессия требует высокого уровня ответственности и готовности к различным ситуациям.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    police = true,
    PlayerSpawn = function(pl) pl:SetArmor(50) pl:GiveAmmos(200) end
})

TEAM_SERGPOLICE = rp.addTeam('Сержант ППС', {
    color = Color(60, 80, 255),
    model = 'models/player/kerry/russian_police_snow/male_05_patrol_snow.mdl',
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'weapon_finebook', 'arrest_baton', 'rwp_tfa_pist_mp443', 'rwp_tfa_smg_pp1901', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'sergpolice',
    max = 6,
    salary = 1100,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 37200,
    canHavy = true,
    canLite = true,
    category = "Полиция",
    canVzri = true,
    description = 'Сержант ППС — это должностное лицо в правоохранительных органах, занимающее промежуточную позицию между обычными полицейскими и офицерами более высокого ранга. Основные обязанности сержанта включают руководство группой патрульных офицеров, координацию действий на местах происшествий, обучение и наставничество младшего персонала, а также контроль за выполнением служебных обязанностей. Сержанты несут ответственность за оперативное руководство, расследование преступлений, составление отчетов и взаимодействие с другими подразделениями правоохранительных органов. Они также участвуют в разработке и реализации профилактических мер по предупреждению преступности в своем районе. Эта профессия требует хороших лидерских навыков, способности принимать быстрые решения в стрессовых ситуациях и высокого уровня физической подготовки. Сержанты полиции играют ключевую роль в обеспечении безопасности общества и поддержании правопорядка.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    police = true,
    PlayerSpawn = function(pl) pl:SetArmor(75) pl:GiveAmmos(200) end
})


TEAM_LEYPOLICE = rp.addTeam('Следственный комитет', {
    color = Color(60, 80, 255),
    model = 'models/player/kerry/police_01_female.mdl',
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'weapon_finebook', 'arrest_baton', 'unarrest_baton', 'rwp_tfa_pist_tt33', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'leypolice',
    max = 2,
    salary = 1800,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 179800,
    canHavy = true,
    canLite = true,
    category = "Полиция",
    canVzri = true,
    description = 'Это государственный орган, занимающийся расследованием преступлений и обеспечением правопорядка в стране. В России Следственный комитет является независимым ведомством, которое осуществляет предварительное следствие по уголовным делам, расследует преступления различной категории сложности и принимает меры к установлению виновных.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    police = true,
    PlayerSpawn = function(pl) pl:SetArmor(225) pl:GiveAmmos(200) end
})

TEAM_KAPPOLICE = rp.addTeam('ОБН', {
    color = Color(70, 130, 180),
    model = 'models/player/wisay/sobr.mdl',
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'arrest_baton', 'rwp_tfa_pist_mp443', 'rwp_tfa_assault_ak12', 'rwp_tfa_heavy_pkm', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'obn',
    max = 2,
    salary = 1300,
    admin = 0,
    user = true,
    candemote = true,
    canHavy = true,
    canLite = true,
    category = "Полиция",
    canVzri = true,
    description = 'Это государственный орган, специализирующийся на противодействии незаконному обороту наркотических средств и психотропных веществ. Отдел по Борьбе с Наркотиками занимается расследованием преступлений, связанных с производством, распространением, хранением и транспортировкой наркотиков, а также пресечением деятельности организованных преступных группировок..',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    police = true,
    PlayerSpawn = function(pl) pl:SetArmor(275) pl:GiveAmmos(200) end
})

TEAM_FSB = rp.addTeam('Оперативник ФСБ', {
    color = Color(255, 215, 0),
    model = 'models/knyaje pack/fsb_rosn/fsb_rosn.mdl', 
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'weapon_finebook', 'arrest_baton', 'rwp_tfa_pist_gsh18', 'rwp_tfa_sniper_vss', 'rwp_tfa_assault_val', 'rwp_tfa_shotgun_saiga20k', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'fsb',
    max = 4,
    salary = 1300,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 560000,
    canHavy = true,
    canLite = true,
    category = "Полиция",
    canVzri = true,
    description = 'Оперативник ФСБ – специалист, занимающийся оперативно-розыскной деятельностью по предотвращению и пресечению противоправных действий в области национальной безопасности. Он осуществляет сбор информации, проведение оперативных мероприятий, арест подозреваемых и обеспечение общественного порядка. Требует высокой профессиональной подготовки, стрессоустойчивости, умения принимать быстрые и правильные решения в сложных ситуациях.',
    CannotOwnDoors = true,
    hasLicense = true,
    candisguise = true,
    selldoors = true,
    police = true,
    vip = false,
    PlayerSpawn = function(pl) pl:SetArmor(250) pl:GiveAmmos(200) end
})


TEAM_HELGA = rp.addTeam('Оперативник "Хельга"', {
    color = Color(65, 105, 225),
    model = 'models/cso2/player/ct_helga_player.mdl',
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'arrest_baton', 'rwp_tfa_pist_pb', 'rwp_tfa_heavy_pkp', 'rwp_tfa_sniper_sv98', 'tfa_scar', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'helga',
    max = 1,
    salary = 1400,
    admin = 0,
    user = true,
    candemote = true,
    canHavy = true,
    canLite = true,
    category = "Полиция",
    canVzri = true,
    description = 'Опытная государственная агент, специализирующаяся на проведении секретных операций и разведывательной работе. Она обладает высоким профессионализмом, навыками стратегического мышления и отличной физической подготовкой. Хельга отличается дисциплинированностью, выдержкой и непреклонностью в достижении поставленных целей.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    police = true,
    vip = true,
    PlayerSpawn = function(pl) pl:SetArmor(350) pl:GiveAmmos(200) end
})

TEAM_SWAT = rp.addTeam('Сотрудник Росгвардии', {
    color = Color(139, 0, 0),
    model = "models/sirris_lvpd1/lvpd1_pm.mdl",
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'rwp_tfa_pist_pm', 'rwp_tfa_smg_aks74u', 'arrest_baton', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'swat',
    max = 6,
    salary = 1300,
    admin = 0,
    playtime = 46700,
    user = true,
    candemote = true,
    canHavy = true,
    canVzri = true,
    description = 'Сотрудник Росгвардии — это военнослужащий или гражданский служащий, работающий в Федеральной службе войск национальной гвардии Российской Федерации. Основные задачи сотрудников включают обеспечение общественной безопасности, борьбу с терроризмом, охрану общественного порядка, защиту государственной собственности и участие в специальных операциях. Они проходят специальную подготовку, обладают физической выносливостью и навыками обращения с оружием. Сотрудники Росгвардии могут выполнять функции по охране важных объектов, сопровождению грузов и обеспечению безопасности массовых мероприятий.',
    category = "Полиция",
    canLite = true,
    hasLicense = true,
    CannotOwnDoors = true,
    police = true,
    selldoors = true,
    vip = false,
    PlayerSpawn = function(pl) pl:SetArmor(120) pl:GiveAmmos(200) pl:SetBodygroup(0, 0) pl:SetBodygroup(1, 6) end
})


TEAM_SWATM = rp.addTeam('Начальник Росгвардии', {
    color = Color(139, 0, 0),
    model = "models/player/wisay/gai_1.mdl",
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'rwp_tfa_pist_mp443', 'rwp_tfa_smg_aks74u', 'rwp_tfa_shotgun_ks23', 'arrest_baton', 'stun_baton', 'med_kit', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'swatm',
    max = 1,
    salary = 1850,
    playtime = 147400,
    admin = 0,
    user = true,
    candemote = true,
    canHavy = true,
    canLite = true,
    canVzri = true,
    category = "Полиция",
    description = 'Начальник Росгвардии — это высокопоставленный офицер, возглавляющий Федеральную службу войск национальной гвардии Российской Федерации. Он отвечает за стратегическое руководство и координацию деятельности Росгвардии, включая обеспечение общественной безопасности, борьбу с терроризмом и охрану правопорядка. Начальник подчиняется Президенту России и осуществляет контроль за выполнением государственных задач, управляя ресурсами и персоналом службы. В его обязанности также входит взаимодействие с другими силовыми структурами и государственными органами.',
    hasLicense = true,
    CannotOwnDoors = true,
    police = true,
    selldoors = true,
    vip = false,
    PlayerSpawn = function(pl) pl:SetArmor(250) pl:GiveAmmos(200) pl:SetBodygroup(0, 0) pl:SetBodygroup(1, 5) end
})



TEAM_SWATOPER = rp.addTeam('ОМОН', {
    color = Color(0, 0, 139),
    model = "models/omon_russian_police_pm2.mdl",
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'rwp_tfa_pist_ot33', 'rwp_tfa_assault_akm', 'arrest_baton', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'swatoper',
    max = 6,
    salary = 1850,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 37400,
    category = "Полиция",
    canHavy = true,
    canVzri = true,
    description = 'Оперативник в ОМОН (Отряд мобильных оперативных новаций) - специализированный боец, который осуществляет защиту и обеспечение безопасности при проведении спецопераций и оперативных мероприятий. Джаггернаут обладает высоким уровнем физической подготовки, тактическими навыками и специальным снаряжением, обеспечивающим защиту от опасностей и угроз в зоне действия. Его задачей является ликвидация опасных угроз, подавление беспорядков и обеспечение безопасности коллег и граждан. Работа Джаггернаута в ОМОН требует высокой концентрации, сплоченности в команде и готовности к оперативному действию в любых условиях.',
    canLite = true,
    hasLicense = true,
    CannotOwnDoors = true,
    police = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(150) pl:GiveAmmos(200) pl:SetBodygroup(0, 0) pl:SetBodygroup(1, 2) end
})

TEAM_JAGGEROMON = rp.addTeam('Джаггернаут ОМОН', {
    color = Color(0, 0, 139),
    model = "models/omonru/riot/riot_ru.mdl",
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'rwp_tfa_pist_ot33', 'rwp_tfa_heavy_pkp', 'rwp_tfa_heavy_rpk74', 'arrest_baton', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'swatoperomon',
    max = 1,
    salary = 1850,
    admin = 0,
    user = true,
    candemote = true,
    category = "Полиция",
    canHavy = true,
    canVzri = true,
    description = 'Джаггернаут ОМОН — это специалист, входящий в состав специальных подразделений правоохранительных органов, таких как ОМОН (Отряд Мобильный Особого Назначения) в России. ',
    canLite = true,
    hasLicense = true,
    CannotOwnDoors = true,
    police = true,
    selldoors = true,
    vip = true,
    PlayerSpawn = function(pl) pl:SetArmor(450) pl:GiveAmmos(200) pl:SetBodygroup(0, 0) pl:SetBodygroup(1, 2) end
})

TEAM_SWATLEAD = rp.addTeam('Капитан ОМОН', {
    color = Color(0, 0, 139),
    model = 'models/omon_russian_police_pm3.mdl',
    CanRaid = 'Рейдить',
    weapons = {'weapon_taser', 'rwp_tfa_pist_ot33', 'rwp_tfa_heavy_rpk74', 'rwp_tfa_heavy_pkp', 'arrest_baton', 'unarrest_baton', 'stun_baton', 'door_ram', 'handcuffs', 'weaponchecker'},
    spawns = police_spawns,
    command = 'swatleader',
    max = 1,
    salary = 2050,
    admin = 0,
    candemote = true,
    canHavy = true,
    canLite = true,
    description = 'Начальник ОМОН — это руководитель специального подразделения милиции или полиции, tasked with обеспечением общественной безопасности, противодействием преступности и выполнением специализированных операций. В его обязанности входят организация работы отряда, координация действий во время операций, подготовка сотрудников и взаимодействие с другими правоохранительными органами. Этот пост требует высокого уровня квалификации, лидерских качеств и физической подготовки. Начальник ОМОН также отвечает за дисциплину и подготовку личного состава.',
    playtime = 153400,
    category = "Полиция",
    canVzri = true,
    hasLicense = true,
    CannotOwnDoors = true,
    police = true,
    selldoors = true,
    vip = false,
    PlayerSpawn = function(pl) pl:SetArmor(350) pl:GiveAmmos(200) pl:SetBodygroup(0, 0) pl:SetBodygroup(1, 8) end
})

---------------

TEAM_MOBBOSS = rp.addTeam('Вор в законе', {
    color = Color(128, 128, 128),
    model = "models/player/zubenko.mdl",
    CanRaid = 'Рейдить',
    CanMug = 'Грабить',
    CanHostage = 'Брать в заложники',
    weapons = {'moneychecker', 'rwp_tfa_pist_mp416rex', 'rwp_tfa_smg_ppsh41'},
    command = 'mobboss',
    max = 1,
    spawns = citizen_spawns,
    salary = 800,
    playtime = 107400,
    admin = 0,
    user = true,
    canHavy = true,
    category = "Криминал",
    description = 'Ты главный мафиозник в этом городе. Ты можешь воровать, майнить, убивать и все преступное. Для начала тебе нужно прочитать правила сервера, чтобы не нарушить их. Чтобы майнить тебе нужны другие мафиозники, так как ты главный, ты можешь создать банду и делать противозаконные дела. Что ж, удачи тебе, это очень прибыльная и интересная профессия для тех, кто любит общение.',
    canVzri = true,
    canLite = true,
    candemote = false,
    PlayerSpawn = function(pl) pl:SetArmor(250) pl:SetHealth(200)  end
})

if SERVER then
    hook("PlayerDeath", "DemoteOnDeathBoss", function(v, k)
        if (v:Team() == TEAM_MOBBOSS) then
            v:ChangeTeam(1, true)
            v:TeamBan(TEAM_MOBBOSS, 180)
            rp.FlashNotifyAll('Новости', term.Get('BossHasDied'))
        end
    end)
end


TEAM_GANGSTER = rp.addTeam('Гопник', {
    color = Color(105, 105, 105),
    model = 'models/half-dead/gopniks/extra/playermodelonly.mdl',
    CanRaid = 'Рейдить',
    CanMug = 'Грабить',
    CanHostage = 'Брать в заложники',
    weapons = {'moneychecker'},
    command = 'gangster1',
    max = 15,
    salary = 550,
    spawns = citizen_spawns,
    admin = 0,
    category = "Криминал",
    description = 'Ты обычный гопник этого города. Ты можешь воровать, майнить, убивать и все преступное. Для начала тебе нужно прочитать правила сервера, чтобы не нарушить их. Чтобы майнить найди себе банду и лягте где нибудь на дне, чтобы полиция вас не нашла, Удачи тебе, мафиозник.',
    user = true,
    canVzri = true,
    canHavy = true,
    canLite = true,
    candemote = true
})

TEAM_GANG1 = rp.addTeam('Криминальный охранник', {
    color = Color(128, 128, 128),
    model = 'models/zhmurki/serega.mdl',
    CanRaid = 'Рейдить',
    CanMug = 'Грабить',
    CanHostage = 'Брать в заложники',
    weapons = {'moneychecker', 'rwp_tfa_pist_pm', 'rwp_tfa_assault_sks'},
    command = 'gangster2',
    max = 1,
    salary = 950,
    admin = 0,
    playtime = 147400,
    spawns = citizen_spawns,
    category = "Криминал",
    description = 'Охраняй своих авторитетов, грабь ради них, помогай им.',
    user = true,
    canVzri = true,
    canHavy = true,
    canLite = true,
    candemote = true,
    PlayerSpawn = function(pl) pl:SetArmor(150) pl:SetMaxHealth(150) pl:SetHealth(150) end
})

TEAM_GANG2 = rp.addTeam('Наёмный убийца', {
    color = Color(128, 128, 128),
   model = 'models/zhmurki/saimon.mdl',
    CanRaid = 'Рейдить',
    CanMug = 'Грабить',
    CanHostage = 'Брать в заложники',
    weapons = {'moneychecker', 'rwp_tfa_pist_pb', 'rwp_tfa_assault_mosin9130'},
    command = 'gangster',
    max = 1,
    salary = 1050,
    admin = 0,
    spawns = citizen_spawns,
    category = "Криминал",
    description = 'Выполняй крупные заказы, доставляй не приятности, работай в команде или в одиночку.',
    user = true,
    canVzri = true,
    canHavy = true,
    canLite = true,
    hitman = true,
    vip = true,
    candemote = true,
    PlayerSpawn = function(pl) pl:SetArmor(250) pl:SetMaxHealth(150) pl:SetHealth(200) end
})

TEAM_GROMILA = rp.addTeam('Громила', {
    color = Color(192, 192, 192),
    model = 'models/kerry/killa_suka_blat/killa_blat.mdl',
    CanRaid = 'Рейдить',
    CanMug = 'Грабить',
    CanHostage = 'Брать в заложники',
    weapons = {'moneychecker', 'rwp_tfa_smg_aks74u', 'rwp_tfa_pist_ot33'},
    command = 'gromila',
    max = 4,
    salary = 750,
    admin = 0,
    spawns = citizen_spawns,
    category = "Криминал",
    description = 'Ты громила этого города. Вы физически хорошо развиты.',
    user = true,
    canVzri = true,
    canHavy = true,
    canLite = true,
    candemote = true,
    vip = true,
    PlayerSpawn = function(pl) pl:SetArmor(200) pl:SetMaxHealth(150) pl:SetHealth(150) end
})

TEAM_METHVARSHIK = rp.addTeam('Варщик мета', {
    color = Color(32, 178, 170),
    model = 'models/jopa_player.mdl',
    weapons = {},
    command = 'varshik',
    max = 3,
    salary = 550,
    admin = 0,
    spawns = citizen_spawns,
    category = "Криминал",
    description = 'Ты варщик мета этого города. Вари с острожностью =)',
    user = true,
    canVzri = true,
    canHavy = true,
    canLite = true,
    candemote = true,
    vip = false,
})

--
-- Selling Classes
--

TEAM_GUN1 = rp.addTeam('Местный Барыга', {
    color = Color(160, 82, 45),
    model = 'models/player/sanya.mdl',
    weapons = {},
    command = 'kontrobandist',
    max = 2,
    salary = 550,
    admin = 0,
    spawns = citizen_spawns,
    canLite = true,
    category = "Криминал",
    description = 'Ты продавец нелегальных предметов, таких как C4, щитов, гранат, поддельных удостоверений и т.п. Чтобы продавать такие вещи тебе не нужно светиться, продавай в подземке или где-нибудь в таком месте.Перед игрой прочитай правила! Удачи тебе, контрабандист.',
    candemote = true,
    hasLicense = false
})

TEAM_CLADMEN = rp.addTeam('Кладмен', {
    color = Color(220, 220, 220),
    model = 'models/kayflife/humans/group02/male_07.mdl',
    weapons = {},
    command = 'cladmen',
    max = 3,
    salary = 450,
    admin = 0,
    spawns = citizen_spawns,
    canLite = true,
    playtime = 10400,
    category = "Криминал",
    description = 'Ты занимаешься распространением запрещённых товаров.. Для своей безопасности избегай людных мест и продавай товары в укромных уголках города, например, в заброшенных зданиях. Помни о правилах сервера перед началом игры! Удачи, мастер теневых сделок.',
    candemote = true,
    hasLicense = false
})


-- TEAM_HITMAN = rp.addTeam('Охотник за головами', {
--     color = Color(112, 128, 144),
--     model = 'models/player/arctic.mdl',
--     weapons = {},
--     command = 'hitman',
--     max = 3,
--     salary = 550,
--     admin = 0,
--     user = true,
--     candemote = true,
--     category = "Криминал",
--     description = 'Ты киллер, убиваешь людей за деньги. Это весьма прибыльный бизнес, если у людей много врагов. Вам стоит работать максимально скрытно, чтобы не сесть в тюрьму или не быть убитым свои же заказом. Работы опасна и трудна. Перед игрой прочитай правила! Удачи тебе, наемный убийца.',
--     canHavy = true,
--     canVzri = true,
--     canLite = true,
--     hitman = true,
--     candisguise = true
-- })

TEAM_VIPHITMAN = rp.addTeam('Ворошиловский стрелок', {
    color = Color(112, 128, 144),
    model = 'models/rashkinsk/ded.mdl',
    weapons = {'rwp_tfa_pist_tt33'},
    command = 'hitmanvip',
    max = 3,
    salary = 750,
    admin = 0,
    spawns = citizen_spawns,
    candemote = false,
    category = "Криминал",
    playtime = 47400,
    description = 'Ты киллер, убиваешь людей за деньги. Это весьма прибыльный бизнес, если у людей много врагов. Вам стоит работать максимально скрытно, чтобы не сесть в тюрьму или не быть убитым свои же заказом. Работы опасна и трудна. Перед игрой прочитай правила! Удачи тебе, наемный убийца.',
    canHavy = true,
    canVzri = true,
    canLite = true,
    hitman = true,
    candisguise = true,
    vip = false,
    PlayerSpawn = function(pl) pl:SetArmor(100) pl:GiveAmmos(200) end
})

TEAM_DRUGMAKER = rp.addTeam('Гровер', {
    color = Color(128, 128, 128),
    model = 'models/player/player_simon_henriksson.mdl',
    weapons = {},
    command = 'drugmaker',
    max = 4,
    category = "Криминал",
    salary = 500,
    spawns = citizen_spawns,
    admin = 0,
    description = 'Ты своего рода фермер, но не совсем обычный, ты выращиваешь марихуану, запрещенную во многих странах. Тебе стоит скорешиться с наркобароном и барменом чтобы открыть бар и продавать людям ваши запрещенные товары. Либо просто сдавать свой чистейшую траву барыге, который даст тебе хороший проценты с продажи. Перед игрой прочитай правила! Удачи тебе, гровер.',
    user = true,
    candemote = true,
    mayorCanSetSaly = false
})

TEAM_BISNES = rp.addTeam('Бизнесмен', {
    color = Color(47,63,118),
        model = {'models/player/magnusson.mdl'},
    weapons = {},
    command = 'bisnes',
    max = 3,
    salary = 750,
    admin = 0,
    spawns = citizen_spawns,
    description = 'Ты маг, создающий процветание в городе. Открой свой офис, магазин или ресторан, создавай бренд и привлекай клиентов. Твой бизнес – это не только источник дохода, но и возможность внести свой вклад в развитие города. Принимай решения, разрабатывай стратегии и создавай торговые империи.',
    user = true,
    category = "Бизнес",
    candemote = false,
    hasLicense = false
})

TEAM_BARTENDER = rp.addTeam('Бармен', {
    color = Color(153, 102, 51, 255),
    model = 'models/player/eli.mdl',
    weapons = {},
    command = 'bartender',
    max = 5,
    spawns = citizen_spawns,
    salary = 550,
    canLite = true,
    description = 'Открой свое уютное заведение и место встречи для многих граждан. Настрой атмосферу под свой вкус, принимай гостей и устраивай зажигательные вечеринки! Ты будешь создавать не только напитки, но и воспоминания для каждого гостя. Будь виртуозом в общении, создавай уют и радость в каждом бокале, и дай городу вкус неповторимого веселья!',
    category = "Бизнес",
    admin = 0,
    user = true,
    candemote = true
})
--
-- Hobos
--

--



TEAM_DOCTOR = rp.addTeam('Санитар Поликлиники', {
    color = Color(0, 128, 128),
    model = 'models/player/sanitar_male_02.mdl',
    weapons = {'med_kit', 'durka_baton'},
    command = 'medic',
    max = 5,
    salary = 1250,
    admin = 0,
    spawns = citizen_spawns,
    category = "Поликлиника",
    description = 'Ты Санитар Поликлиники, приводи буйных пациентов в дурку и получай за них деньги ну и если есть желание лечи людей.',
    user = true,
    candemote = true,
    hasLicense = false,
    medic = true
})

TEAM_glDOCTOR = rp.addTeam('Главный Врач Поликлиники', {
    color = Color(0, 128, 128),
    model = 'models/player/sanitar_cohrt.mdl',
    weapons = {'med_kit', 'durkasl_baton'},
    command = 'glmedic',
    max = 1,
    salary = 1950,
    admin = 0,
    spawns = citizen_spawns,
    category = "Поликлиника",
    description = 'Ты главный врач Поликлиники, руководи своими сотрудниками и построй свою империю здравохранения!',
    user = true,
    candemote = true,
    playtime = 10400,
    hasLicense = false,
    medic = true
})


--
-- Other
--

TEAM_BANNED = rp.addTeam('Забанен', {
    color = Color(255, 0, 0),
    model = 'models/player/soldier_stripped.mdl',
    weapons = {},
    command = 'banned124',
    max = 0,
    salary = 0,
    CannotOwnDoors = true,
    admin = 0,
    hasLicense = false,
    candemote = false,
    category = '';
    customCheck = function(pl) return pl:IsBanned() end,
    CustomCheckFailMsg = 'JobNeedsBanned',
    spawns = {
        rp_bangclaw_easy = {Vector(-4534.6010742188, 2093.169921875, -44.96875)},
        rp_downtown_tits_v2 = {Vector(3654.956299, -4639.027832, -139.968750)}
    }
})

--

--local army_spawns = {
--    rp_bangclaw_easy = {
--       Vector(8497.8671875, 580.22674560547, 0.031253814697266),
--        Vector(8516.85546875, 341.49761962891, 0.03125),
--        Vector(8493.5927734375, 108.09789276123, 0.03125) 
--    },
--}

--[[TEAM_SROCH = rp.addTeam('Срочник', {
    color = Color(0, 128, 0),
    model = 'models/player/kerry/russian_army_2/male_05.mdl',
    CanRaid = 'Рейдить',
    weapons = {'salute'},
    spawns = army_spawns,
    command = 'sroch',
    category = "Военные",
    max = 10,
    salary = 700,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 1200,
    canHavy = true,
    canLite = true,
    canVzri = true,
    description = 'Срочники выполняют разнообразные задачи в зависимости от рода войск и своей специальности. Это может включать участие в учениях, охрану объектов, выполнение задач по поддержанию правопорядка, а также участие в миротворческих миссиях. Срочники проходят обучение, где осваивают военные навыки, тактику, обращение с оружием и технику безопасности.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(35) pl:GiveAmmos(200) end
})

TEAM_EFRETIOR = rp.addTeam('Ефрейтор Армии', {
    color = Color(0, 128, 0),
    model = 'models/player/kerry/russian_army_2/male_05.mdl',
    CanRaid = 'Рейдить',
    weapons = {'rwp_tfa_pist_tt33', 'rwp_tfa_assault_ak74', 'salute'},
    spawns = army_spawns,
    command = 'EFRETIOR',
    max = 5,
    salary = 800,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 21800,
    canHavy = true,
    canLite = true,
    category = "Военные",
    canVzri = true,
    description = 'Ефрейтор — это воинское звание в армии, которое обычно присваивается военнослужащим, прошедшим начальную службу и проявившим себя как ответственные и дисциплинированные солдаты. Ефрейтор является младшим командным составом и выполняет важные функции в рамках своей военной части.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(50) pl:GiveAmmos(200) end
})

TEAM_VOENKOM = rp.addTeam('Военком', {
    color = Color(0, 128, 0),
    model = 'models/kerry/russian_army_officers/male_04.mdl',
    CanRaid = 'Рейдить',
    weapons = {'rwp_tfa_pist_pm', 'rwp_tfa_assault_groza', 'salute', 'voenkom_baton'},
    spawns = army_spawns,
    command = 'VOENKOM',
    max = 1,
    salary = 1200,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 1800,
    canHavy = true,
    canLite = true,
    category = "Военные",
    canVzri = true,
    description = 'Военком (военный комиссар) — это должностное лицо, ответственное за организацию и проведение призыва на военную службу, а также за работу с военнообязанными гражданами в своем районе. Военкомы играют ключевую роль в обеспечении комплектования вооруженных сил и выполнении государственных задач в области обороны.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(100) pl:GiveAmmos(200) end,
    vip = true,
})

TEAM_SERZHANT = rp.addTeam('Сержант Армии', {
    color = Color(0, 128, 0),
    model = 'models/player/kerry/russian_army_2/male_05.mdl',
    CanRaid = 'Рейдить',
    weapons = {'rwp_tfa_pist_tt33', 'rwp_tfa_assault_akm', 'salute'},
    spawns = army_spawns,
    command = 'SERZHANT',
    max = 3,
    salary = 900,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 37800,
    canHavy = true,
    canLite = true,
    category = "Военные",
    canVzri = true,
    description = 'Сержант — это военнослужащий, занимающий должность в младшем командном составе, который отвечает за обучение, руководство и контроль подчиненными солдатами. Сержанты играют ключевую роль в поддержании дисциплины, выполнения приказов и обеспечения выполнения задач подразделения.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(100) pl:GiveAmmos(200) end
})

TEAM_STARSHINA = rp.addTeam('Старшина Армии', {
    color = Color(0, 128, 0),
    model = 'models/player/kerry/russian_army_2/male_05.mdl',
    CanRaid = 'Рейдить',
    weapons = {'rwp_tfa_pist_tt33', 'rwp_tfa_assault_ak12', 'salute'},
    spawns = army_spawns,
    command = 'STARSHINA',
    max = 2,
    salary = 1000,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 59800,
    canHavy = true,
    canLite = true,
    category = "Военные",
    canVzri = true,
    description = 'Старшина — это военнослужащий, занимающий должность в старшем командном составе, который отвечает за организацию и управление подчиненными солдатами. Старшины играют важную роль в поддержании дисциплины, обучении и наставничестве, а также в обеспечении выполнения оперативных задач подразделения.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(100) pl:GiveAmmos(200) end
})

TEAM_PRAPOR = rp.addTeam('Прапорщик Шматко', {
    color = Color(0, 128, 0),
    model = 'models/rashkinsk/shmatko.mdl',
    CanRaid = 'Рейдить',
    weapons = {'rwp_tfa_pist_tt33', 'rwp_tfa_pist_tt33', 'rwp_tfa_smg_ppsh41', 'salute'},
    spawns = army_spawns,
    command = 'PRAPOR',
    max = 1,
    salary = 1200,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 1800,
    canHavy = true,
    canLite = true,
    category = "Военные",
    canVzri = true,
    description = 'Вы Шматко.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(125) pl:GiveAmmos(200) end,
    vip = true
})

TEAM_KAPI = rp.addTeam('Капитан Армии', {
    color = Color(0, 128, 0),
    model = 'models/kerry/russian_army_officers/male_02.mdl',
    CanRaid = 'Рейдить',
    weapons = {'rwp_tfa_pist_mp416rex', 'rwp_tfa_assault_aek971', 'tfa_pkm', 'salute'},
    spawns = army_spawns,
    command = 'KAPI',
    max = 1,
    salary = 1700,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 121800,
    canHavy = true,
    canLite = true,
    category = "Военные",
    canVzri = true,
    description = 'Капитан — это офицер, занимающий командную должность в армии, отвечающий за руководство подразделением, обычно состоящим из роты или эквивалентной единицы. Капитаны играют ключевую роль в планировании, организации и проведении операций, а также в обучении и управлении личным составом.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(205) pl:GiveAmmos(200) end
})

TEAM_PRIGOZHINZHENYA = rp.addTeam('Евгений Пригожин', {
    color = Color(34, 139, 34),
    model = 'models/dejtriyev/dreamybuss/prigozhin.mdl',
    CanRaid = 'Рейдить',
    weapons = {'jin_test_red9', 'rwp_tfa_sniper_sv98', 'rwp_tfa_heavy_pkp', 'rwp_tfa_shotgun_mp153', 'salute'},
    spawns = army_spawns,
    command = 'prigozhin',
    max = 1,
    salary = 1700,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 3600*200,
    canHavy = true,
    canLite = true,
    category = "Военные",
    canVzri = true,
    description = 'Ты тот самый Пригожин.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    vip = true,
    PlayerSpawn = function(pl) pl:SetArmor(305) pl:GiveAmmos(200) end
})

TEAM_VPOLICE = rp.addTeam('Военная полиция', {
    color = Color(0, 128, 0),
    model = 'models/player/kerry/russian_army_2/male_03.mdl',
    CanRaid = 'Рейдить',
    weapons = {'rwp_tfa_pist_tt33', 'rwp_tfa_assault_ak74', 'handcuffs', 'salute'},
    spawns = army_spawns,
    command = 'vpolice',
    max = 2,
    salary = 1200,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 42800,
    canHavy = true,
    canLite = true,
    category = "Военные",
    canVzri = true,
    description = 'Военная полиция — это специализированное подразделение вооруженных сил, основная задача которого заключается в обеспечении правопорядка и безопасности на территории военных объектов, а также в зонах боевых действий. Военная полиция выполняет функции, аналогичные гражданской полиции, но в рамках военной структуры. Военная полиция подчиняется только Начальнику Части.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(200) pl:GiveAmmos(200) end,
})

TEAM_NACH = rp.addTeam('Начальник части', {
    color = Color(0, 128, 0),
    model = 'models/kerry/russian_army_officers/male_02.mdl',
    CanRaid = 'Рейдить',
    weapons = {'rwp_tfa_pist_mp416rex', 'rwp_tfa_heavy_pkp', 'rwp_tfa_heavy_rpk74', 'salute'},
    spawns = army_spawns,
    command = 'NACH',
    max = 1,
    salary = 2000,
    admin = 0,
    user = true,
    candemote = true,
    playtime = 201800,
    canHavy = true,
    canLite = true,
    category = "Военные",
    canVzri = true,
    description = 'Начальник воинской части — это высокопрофессиональный офицер, который отвечает за общее руководство и управление воинской частью, включая ее боевую готовность, организацию и выполнение задач. Эта должность предполагает стратегическое планирование, координацию действий различных подразделений и обеспечение эффективного функционирования части.',
    CannotOwnDoors = true,
    hasLicense = true,
    selldoors = true,
    PlayerSpawn = function(pl) pl:SetArmor(205) pl:GiveAmmos(200) end
})
--]]

-- ██████╗░░█████╗░███╗░░██╗███╗░░██╗███████╗██████╗░
-- ██╔══██╗██╔══██╗████╗░██║████╗░██║██╔════╝██╔══██╗
-- ██████╦╝███████║██╔██╗██║██╔██╗██║█████╗░░██║░░██║
-- ██╔══██╗██╔══██║██║╚████║██║╚████║██╔══╝░░██║░░██║
-- ██████╦╝██║░░██║██║░╚███║██║░╚███║███████╗██████╔╝
-- ╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚══╝╚══════╝╚═════╝░

TEAM_SOPMOD = rp.addTeam('SOPMOD', {
    color = Color(219, 47, 26),
    model = {"models/player/dewobedil/girls_frontline/m4_sopmod_ii/default_p.mdl"},
    weapons = {'blink', 'weapon_ziptie', 'm9k_m4a1_sopmod', 'lockpick', 'keypad_cracker', 'slappers', 'swep_vmaxgun'},
    command = 'sopmod',
    max = 1,
    salary = 10000,
    admin = 0,
    spawns = citizen_spawns,
    hasLicense = true,
    candemote = false,
    category = "Личные профессии",
    keypadcracktime = 10,
    lockpicktime = 10,
    canRob = true,
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(500)
        ply:SetMaxArmor(200)
        ply:SetArmor(200)
        ply:SetHealth(500)
    end
  })

TEAM_BERSERK = rp.addTeam('Берсерк', {
    color = Color(15, 6, 5),
    model = {"models/kerosenn/apex_legends/legends/wraith/playermodel/voidwalker_pm.mdl"},
    weapons = {'weapon_ziptie', 'weapon_shield', 'weapon_mad_dragonslayer'},
    command = 'berserk',
    max = 2,
    salary = 2500,
    admin = 0,
    spawns = citizen_spawns,
    hasLicense = false,
    candemote = false,
    category = "Личные профессии",
    keypadcracktime = 5,
    lockpicktime = 5,
    canRob = true,
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(125)
        ply:SetMaxArmor(150)
        ply:SetArmor(150)
        ply:SetHealth(125)
    end
  })

TEAM_SATORU = rp.addTeam('Сатору Годжо', {
    color = Color(0, 255, 238),
    model = {"models/jjk_falko/satoru_gojo_fortnite.mdl"},
    weapons = {'limitless'},
    command = 'satoru',
    max = 0,
    salary = 5000,
    admin = 0,
    spawns = citizen_spawns,
    hasLicense = true,
    candemote = false,
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(150)
        ply:SetMaxArmor(150)
        ply:SetArmor(150)
        ply:SetHealth(150)
    end
  })



TEAM_TOBI = rp.addTeam('Тоби', {
    color = Color(82, 82, 82),
    model = {"models/player/snowki/tobi.mdl"},
    weapons = {'mangekyou_sharingan_obito', 'weapon_ziptie', 'lockpick', 'keypad_cracker'},
    command = 'tobi',
    max = 2,
    salary = 5000,
    admin = 0,
    hasLicense = false,
    candemote = false,
    spawns = citizen_spawns,
    category = "Личные профессии",
    keypadcracktime = 10,
    lockpicktime = 10,
    canRob = true,
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(250)
        ply:SetMaxArmor(250)
        ply:SetArmor(250)
        ply:SetHealth(250)
    end
  })

TEAM_FURINA = rp.addTeam('Фурина', {
    color = Color(0, 255, 255),
    model = {"models/hoyoverse/Furina.mdl"},
    weapons = {'m9k_minigun', 'orbital_friendship_cannon', 'lockpick', 'keypad_cracker'},
    command = 'furina',
    max = 1,
    salary = 7500,
    admin = 0,
    hasLicense = false,
    candemote = false,
    spawns = citizen_spawns,
    category = "Личные профессии",
	description = 'Фурина: божественная дива и главная звезда города, для которой весь мир является огромным театром. В её задачи входит вершение правосудия и наказание нечестивцев с помощью сокрушительного Орбитального Удара за дерзость или «плохую актерскую игру». Данная роль требует артистизма, соблюдения высоких принципов (исключающих мелкий криминал) и готовности выступать судьей в любых конфликтах. Фурина играет ключевую роль в создании грандиозного спектакля на улицах города, не подчиняясь никому, кроме собственных капризов.',
    keypadcracktime = 10,
    lockpicktime = 10,
    canRob = true,
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(500)
        ply:SetMaxArmor(500)
        ply:SetArmor(150)
        ply:SetHealth(150)
		ply:SetRunSpeed(540)
    end
  })

TEAM_TOJI = rp.addTeam('Toji Zenin', {
    color = Color(103, 97, 81),
    model = {"models/jjk_falko/toji_fushiguro.mdl"},
    weapons = {'heavenlyrestriction', 'weapon_ziptie', 'lockpick', 'keypad_cracker', 'm9k_m92beretta_toji'},
    command = 'toji',
    max = 1,
    salary = 5000,
    admin = 0,
    spawns = citizen_spawns,
    hasLicense = false,
    candemote = false,
    category = "Личные профессии",
    keypadcracktime = 10,
    lockpicktime = 10,
    canRob = true,
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(450)
        ply:SetMaxArmor(150)
        ply:SetArmor(150)
        ply:SetHealth(450)
    end
  })

TEAM_SUKUNA = rp.addTeam('Ryomen Sukuna', {
    color = Color(77, 19, 15),
    model = {"models/moon/Ryomen_Sukuna/Ryomen_Sukuna.mdl"},
    weapons = {'vessel', 'weapon_ziptie', 'lockpick', 'keypad_cracker'},
    command = 'sukuna',
    max = 1,
    salary = 5000,
    admin = 0,
    spawns = citizen_spawns,
    hasLicense = false,
    candemote = false,
    category = "Личные профессии",
    keypadcracktime = 10,
    lockpicktime = 10,
    canRob = true,
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(500)
        ply:SetMaxArmor(200)
        ply:SetArmor(200)
        ply:SetHealth(500)
    end
  })
 
TEAM_BULLDOZER = rp.addTeam('Бульдозер', {
    color = Color(24, 38, 255),
    model = {"models/Killzone Mercenary/Helghast_Police_Trooper/Police_Trooper.mdl"},
    weapons = {'m9k_minigun', 'handcuffs','weaponchecker','arrest_baton','door_ram','salute','stungun','stun_baton','unarrest_baton','weapon_shield','weapon_c4',  'm9k_exile', 'weapon_radio'},
    command = 'bulldoz',
    max = 2,
    salary = 3000,
    admin = 0,
    spawns = fsin_spawns,
    hasLicense = true,
    candemote = false,
    category = "Личные профессии",
    description = [[Вы лучший солдат полиции, можете действовать в одиночку, так и с отрядом. Вам не страшно огромное количество врагов.]],
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(200)
        ply:SetMaxArmor(250)
        ply:SetArmor(250)
        ply:SetHealth(200)
        ply:SetRunSpeed(200)
    end
    
  })

TEAM_ELZA = rp.addTeam('Агент Эльза', {
    color = Color(0, 191, 255),
    model = {"models/player/ElizaCop.mdl"},
    weapons = {'weapon_frag', 'handcuffs','weaponchecker','arrest_baton','door_ram','salute','stungun','stun_baton','unarrest_baton','weapon_shield', 'csgo_talon', 'avenger_xr2', 'weapon_radio'},
    command = 'elza',
    max = 1,
    salary = 1500,
    admin = 0,
    spawns = fsin_spawns,
    hasLicense = true,
    candemote = false,
    description = [[Вы агент полиции, который занимается расследованием преступлений.]],
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(125)
        ply:SetMaxArmor(125)
        ply:SetArmor(125)
        ply:SetHealth(125)
    end
    
  })



TEAM_MUFFLER = rp.addTeam('Muffler', {
    color = Color(102, 0, 255),
    model = {"models/jazzmcfly/muffler/muffler.mdl"},
    weapons = {'weapon_ziptie', 'weapon_shield', 'weapon_c4', 'awp_asiimov', 'csgo_fade_xm1014', 'usual_blink'},
    command = 'muffler',
    max = 3,
    salary = 3000,
    admin = 0,
    hasLicense = false,
    candemote = false,
    canRob = true,
    category = "Личные профессии",
    spawns = citizen_spawns,
    description = [[Вы часть криминального мира. Низкий рост дает преимущество в беге, а телепорт помогает избежать опасности.]],
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(150)
        ply:SetMaxArmor(125)
        ply:SetArmor(125)
        ply:SetHealth(150)
        ply:SetRunSpeed(330)
    end
    
  })

TEAM_HAKU = rp.addTeam('Агент Хаку', {
    color = Color(24, 255, 213),
    model = {"models/mmd/Haku Police.mdl"},
    weapons = {'weapon_frag', 'handcuffs','weaponchecker','arrest_baton','door_ram','salute','stungun','stun_baton','unarrest_baton','weapon_shield', 'csgo_ursus', 'ryry_m9k_ak12', 'weapon_radio'},
    command = 'haku',
    max = 1,
    salary = 1500,
    admin = 0,
    spawns = fsin_spawns,
    hasLicense = true,
    candemote = false,
    description = [[Вы агент полиции, который занимается расследованием преступлений.]],
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(125)
        ply:SetMaxArmor(125)
        ply:SetArmor(125)
        ply:SetHealth(125)
        ply:SetRunSpeed(320)
    end
    
  })

TEAM_ROXY = rp.addTeam('Roxy', {
    color = Color(70, 24, 255),
    model = {"models/mad_roxy.mdl"},
    weapons = {'weapon_ziptie', 'weapon_shield', 'weapon_c4', 'm9k_jackhammer', 'm9k_svu', 'usual_blink'},
    command = 'roxy',
    max = 3,
    salary = 3000,
    admin = 0,
    hasLicense = false,
    candemote = false,
    canRob = true,
    spawns = citizen_spawns,
    description = [[Вы часть криминального мира. Ограбления, рейды, все это вам кажется родным и неотъемлимой частью вашей жизни.]],
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(125)
        ply:SetMaxArmor(150)
        ply:SetArmor(150)
        ply:SetHealth(125)
    end

  })

TEAM_POCO = rp.addTeam('Поко', {
    color = Color(251, 0, 81),
    model = {"models/brawlstars/mexicant/poco_body.mdl"},
    weapons = {'weapon_kiss', 'usual_blink'},
    command = 'poco',
    max = 5,
    salary = 3000,
    admin = 0,
    hasLicense = false,
    candemote = false,
    canRob = false,
    spawns = citizen_spawns,
    description = [[Вы самый добродушный человек. Целуйте своих жертв и заставляйте выполнять их ваши желания]],
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(100)
        ply:SetMaxArmor(150)
        ply:SetArmor(150)
        ply:SetHealth(100)
    end

  })

TEAM_AKOLIT = rp.addTeam('Аколит', {
    color = Color(184, 138, 0),
    model = {"models/indiarp/gang/reper5.mdl"},
    weapons = {'wiz_wizard_pistol'},
    command = 'akolit',
    max = 3,
    salary = 1500,
    admin = 0,
    spawns = citizen_spawns,
    candemote = false,
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(100)
        ply:SetMaxArmor(100)
        ply:SetArmor(100)
        ply:SetHealth(100)
    end
  })

TEAM_KOLDUN = rp.addTeam('Колдун', {
    color = Color(0, 93, 184),
    model = {"models/indiarp/gang/reper4.mdl"},
    weapons = {'wiz_wizard_pistol', 'wiz_bloodhound'},
    command = 'koldun',
    max = 3,
    salary = 2000,
    admin = 0,
    spawns = citizen_spawns,
    candemote = false,
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(150)
        ply:SetMaxArmor(150)
        ply:SetArmor(150)
        ply:SetHealth(150)
    end
  })

TEAM_CHARODEI = rp.addTeam('Чародей', {
    color = Color(179, 26, 0),
    model = {"models/indiarp/gang/reper.mdl"},
    weapons = {'wiz_wizard_pistol', 'wiz_bloodhound'},
    command = 'charodei',
    max = 2,
    salary = 3000,
    admin = 0,
    spawns = citizen_spawns,
    candemote = false,
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(150)
        ply:SetMaxArmor(150)
        ply:SetArmor(150)
        ply:SetHealth(150)
    end
  })

TEAM_CHERNOKNIZH = rp.addTeam('Чернокнижник', {
    color = Color(141, 0, 179),
    model = {"models/indiarp/gang/reper3.mdl"},
    weapons = {'wiz_wizard_pistol', 'wiz_bloodhound', 'wiz_wizard_shotgun'},
    command = 'chernok',
    max = 1,
    salary = 5000,
    admin = 0,
    spawns = citizen_spawns,
    candemote = false,
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(200)
        ply:SetMaxArmor(200)
        ply:SetArmor(200)
        ply:SetHealth(200)
    end
  })

TEAM_ARCHIMAG = rp.addTeam('Архимаг', {
    color = Color(230, 230, 250),
    model = {"models/indiarp/gang/reper2.mdl"},
    weapons = {'wiz_wizard_pistol', 'wiz_bloodhound', 'wiz_wizard_shotgun', 'wiz_lightning_caller', 'wiz_dying_neutron_star'},
    command = 'archimag',
    max = 1,
    salary = 10000,
    admin = 0,
    spawns = citizen_spawns,
    candemote = false,
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(250)
        ply:SetMaxArmor(250)
        ply:SetArmor(250)
        ply:SetHealth(250)
    end
  })

TEAM_SHADOW = rp.addTeam('Тень', {
    color = Color(94, 94, 94),
    model = {"models/garden/shadow.mdl"},
    weapons = {'blink', 'weapon_ziptie', 'lockpick', 'keypad_cracker', 'weapon_shield'},
    command = 'shadow',
    max = 2,
    salary = 5000,
    admin = 0,
    hasLicense = false,
    candemote = false,
    spawns = citizen_spawns,
    category = "Личные профессии",
    keypadcracktime = 10,
    lockpicktime = 10,
    canRob = true,
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(175)
        ply:SetMaxArmor(175)
        ply:SetArmor(175)
        ply:SetHealth(175)
    end
  })

TEAM_SEGUN = rp.addTeam("Сёгун", {
    color = Color(255, 24, 92),
    model = 'models/alejenus/genshinimpact/raidenshogun/shogun.mdl',
    description = [[Вы профессионал своего дела - Сёгун, лучший мечник родом из Японии. Вам пришлось покинуть родные края и переехать в штат Вайб, но тяга к деньгам за убийства людей осталась с вами.]],
    weapons = {'lockpick', 'weapon_c4', 'keypad_cracker', 'weapon_shield', 'climb_swep', 'weapon_irisheartsword', 'weapon_ziptie', 'usual_blink'},
    command = "segun",
    max = 2,
    salary = 0,
    admin = 0,
    spawns = citizen_spawns,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(200)
        ply:SetMaxArmor(200)
        ply:SetArmor(200)
        ply:SetHealth(200)
        ply:SetRunSpeed(330)
        ply:SetJumpPower(150)
        ply:SetGravity(0.7)
    end
 })

TEAM_HRANITEL = rp.addTeam("Хранитель", {
    color = Color(206, 255, 29),
    model = 'models/player/dewobedil/undertale/ff_frisk/default_p.mdl',
    description = [[Вы хранитель этого штата. Можете заниматься криминалом, а можете помогать полиции. Выбирайте свой род деятельности и охраняйте то, что вам дорого!]],
    weapons = {'lockpick', 'weapon_c4', 'keypad_cracker', 'weapon_shield', 'climb_swep', 'weapon_overlord_beam', 'weapon_ziptie', 'usual_blink', 'handcuffs','weaponchecker','arrest_baton','salute', 'door_ram', 'stungun','stun_baton','unarrest_baton', 'weapon_radio'},
    command = "hran",
    max = 2,
    salary = 0,
    admin = 0,
    spawns = citizen_spawns,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(175)
        ply:SetMaxArmor(175)
        ply:SetArmor(175)
        ply:SetHealth(175)
        ply:SetRunSpeed(330)
    end
 })

TEAM_MOTOMOTO = rp.addTeam("Мото мото", {
    color = Color(206, 255, 29),
    model = 'models/a_thing/madagascar/motomoto_pm.mdl',
    description = [[Вы хранитель этого штата. Можете заниматься криминалом, а можете помогать полиции. Выбирайте свой род деятельности и охраняйте то, что вам дорого!]],
    weapons = {'lockpick'},
    command = "motomoto",
    max = 2,
    salary = 0,
    admin = 0,
    spawns = citizen_spawns,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Личные профессии",
    PlayerSpawn = function(ply)
        ply:SetMaxHealth(200)
        ply:SetMaxArmor(100)
        ply:SetArmor(100)
        ply:SetHealth(200)
    end
 })


--
-- Configs
--
-- Group Chat
if TEAM_ANARCHIST and TEAM_GANGSTER and TEAM_PROTHIEF then
    rp.addGroupChat(TEAM_ANARCHIST, TEAM_GANGSTER, TEAM_PROTHIEF)
end
rp.addGroupChat(TEAM_CHIEF, TEAM_POLICE, TEAM_MAYOR, TEAM_SWAT, TEAM_SWATM, TEAM_SWATOPER, TEAM_FSB, TEAM_SWATLEAD, TEAM_HELGA, TEAM_KAPPOLICE)
if TEAM_HOBO and TEAM_HOBOKING then
    rp.addGroupChat(TEAM_HOBO, TEAM_HOBOKING)
end
if TEAM_UMBRELLA16 and TEAM_UMBRELLA1 then
    rp.addGroupChat(TEAM_UMBRELLA16, TEAM_UMBRELLA1, TEAM_UMBRELLA2, TEAM_UMBRELLA3, TEAM_UMBRELLA4, TEAM_UMBRELLA5, TEAM_UMBRELLA6)
end
-- Deault Team
rp.DefaultTeam = TEAM_CITIZEN

-- Police classes
rp.CivilProtection = {
    [TEAM_CHIEF] = true,
    [TEAM_POLICE] = true,
    [TEAM_SWATM] = true,
    [TEAM_SWAT] = true,
    [TEAM_SWATOPER] = true,
    [TEAM_FSB]  = true,
    [TEAM_HELGA]  = true,
    [TEAM_SWATLEAD] = true,
    [TEAM_MAYOR] = true,
    [TEAM_KAPPOLICE] = true
}

-- Mayor
rp.MayorTeam = TEAM_MAYOR

-- Gov classes
rp.Government = {
    [TEAM_MAYOR] = true
}
--[[
mayor_system.militaryLeaders = {
    [TEAM_NACH] = true,
    [TEAM_PRIGOZHINZHENYA] = true,
    [TEAM_KAPI] = true
}
--]]
--[[
mayor_system.militaryTeams = {
    [TEAM_PRAPOR] = true,
    [TEAM_STARSHINA] = true,
    [TEAM_SERZHANT] = true,
    [TEAM_VOENKOM] = true,
    [TEAM_EFRETIOR] = true,
    [TEAM_SROCH] = true,
    [TEAM_NACH] = true,
    [TEAM_PRIGOZHINZHENYA] = true,
    [TEAM_KAPI] = true
}
--]]
--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
