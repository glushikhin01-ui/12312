player_manager.AddValidModel( "El gator", "models/gatorcreek/el_gator.mdl" )
list.Set( "PlayerOptionsModel",  "El gator", "models/gatorcreek/el_gator.mdl" )
player_manager.AddValidHands( "El gator", "models/gatorcreek/el_gator_arms.mdl", 0, "00000000" )
--Add NPC
local Category = "Criminal"

local NPC = { 	Name = "El gator (Apyr.)", 
				Class = "npc_citizen",
				Model = "models/gatorcreek/el_gator.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }

list.Set( "NPC", "el_gator", NPC )

local NPC = { 	Name = "El gator (Hostile)", 
				Class = "npc_combine_s",
				Model = "models/gatorcreek/el_gator.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }

list.Set( "NPC", "el_gator_hostile", NPC )
