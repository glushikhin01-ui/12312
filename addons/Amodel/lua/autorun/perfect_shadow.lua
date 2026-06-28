player_manager.AddValidModel( "Perfect Shadow", "models/cyanblue/fortnite/perfect_shadow/perfect_shadow.mdl" );
player_manager.AddValidHands( "Perfect Shadow", "models/cyanblue/fortnite/perfect_shadow/arms/perfect_shadow.mdl", 0, "00000000" )

local Category = "Fortnite"

local NPC = { 	Name = "Perfect Shadow", 
				Class = "npc_citizen",
				Model = "models/cyanblue/fortnite/perfect_shadow/npc/perfect_shadow.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
				Category = Category	}

list.Set( "NPC", "npc_perfect_shadow_pm", NPC )