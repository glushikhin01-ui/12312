player_manager.AddValidModel( "Portal 2: Cave Johnson 70s", "models/Lenoax/CaveJohnson_PM.mdl" )

player_manager.AddValidHands( "Portal 2: Cave Johnson 70s", "models/Lenoax/CaveJohnson_PM_Hands.mdl", 0, 0 )


local NPC =
{
	Name = "Cave Johnson",
	Class = "npc_citizen",
	KeyValues = { citizentype = 4 },
	Model = "models/Lenoax/CaveJohnson_NPC.mdl",
	Category = "Portal 2"
}

list.Set( "NPC", "npc_portal_cavejohnson", NPC )

