player_manager.AddValidModel( "Alley Thug", "models/deepalley/alley_thug.mdl" )
list.Set( "PlayerOptionsModel",  "Alley Thug", "models/deepalley/alley_thug.mdl" )
player_manager.AddValidHands( "Alley Thug", "models/deepalley/alley_thug_arms.mdl", 0, "00000000" )

--Add NPC
local Category = "Criminal"

local NPC = { 	Name = "Alley Thug (Apyr.)", 
				Class = "npc_citizen",
				Model = "models/deepalley/alley_thug.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }

list.Set( "NPC", "alley_thug", NPC )

local NPC = { 	Name = "Alley Thug (Hostile)", 
				Class = "npc_combine_s",
				Model = "models/deepalley/alley_thug.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }

list.Set( "NPC", "alley_thug_hostile", NPC )
