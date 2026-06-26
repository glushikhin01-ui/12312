
player_manager.AddValidModel( "Merriweather 1","models/kerry/player/merriweather/male_01.mdl" )
list.Set( "PlayerOptionsModel","Merriweather 1","models/kerry/player/merriweather/male_01.mdl" )

player_manager.AddValidModel( "Merriweather 2","models/kerry/player/merriweather/male_02.mdl" )
list.Set( "PlayerOptionsModel","Merriweather 2","models/kerry/player/merriweather/male_02.mdl" )

player_manager.AddValidModel( "Merriweather 3","models/kerry/player/merriweather/male_03.mdl" )
list.Set( "PlayerOptionsModel","Merriweather 3","models/kerry/player/merriweather/male_03.mdl" )

player_manager.AddValidModel( "Merriweather 4","models/kerry/player/merriweather/male_04.mdl" )
list.Set( "PlayerOptionsModel","Merriweather 4","models/kerry/player/merriweather/male_04.mdl" )

player_manager.AddValidModel( "Merriweather 5","models/kerry/player/merriweather/male_05.mdl" )
list.Set( "PlayerOptionsModel","Merriweather 5","models/kerry/player/merriweather/male_05.mdl" )

player_manager.AddValidModel( "Merriweather 6","models/kerry/player/merriweather/male_06.mdl" )
list.Set( "PlayerOptionsModel","Merriweather 6","models/kerry/player/merriweather/male_06.mdl" )

player_manager.AddValidModel( "Merriweather 7","models/kerry/player/merriweather/male_07.mdl" )
list.Set( "PlayerOptionsModel","Merriweather 7","models/kerry/player/merriweather/male_07.mdl" )

player_manager.AddValidModel( "Merriweather 8","models/kerry/player/merriweather/male_08.mdl" )
list.Set( "PlayerOptionsModel","Merriweather 8","models/kerry/player/merriweather/male_08.mdl" )

player_manager.AddValidModel( "Merriweather 9","models/kerry/player/merriweather/male_09.mdl" )
list.Set( "PlayerOptionsModel","Merriweather 9","models/kerry/player/merriweather/male_09.mdl" )



local Category = "Merriweather NPCs"
local NPC = { 	Name = "Merriweather Frend", 
				Class = "npc_citizen",
				Model = "models/katy/npc/merriweather/male_01_friend.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "merriweather_1", NPC )

local Category = "Merriweather NPCs"
local NPC = { 	Name = "Merriweather Hostile", 
				Class = "npc_combine_s",
				Model = "models/katy/npc/merriweather/male_01_enemy.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "merriweather_2", NPC )



