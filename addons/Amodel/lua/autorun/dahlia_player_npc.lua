player_manager.AddValidModel( "Dahlia", 					"models/player/group01/dahlia0o0.mdl" )

list.Set( "PlayerOptionsModel",  "Dahlia", 					"models/player/group01/dahlia0o0.mdl" )

local Category = "Humans + Resistance"

local NPC = {	Name = "Dahlia",
				Class = "npc_citizen",
				Model = "models/humans/group01/dahlia0o0.mdl",
				Health = "150",
				KeyValues = { citizentype = 4 },
				Category = Category }

list.Set( "NPC", "npc_dahlia", NPC )
