--Add Playermodel
player_manager.AddValidModel( "Billy Fortnite", "models/player/billy_fn_pm.mdl" )
player_manager.AddValidHands( "Billy Fortnite", "models/weapons/billy_fn_hands.mdl" )

--Add NPC
local Category = "Fortnite"

--Friendly NPC
local NPC = 
{
    Name = "Billy - Friendly",
    Class = "npc_citizen",
	Model = "models/player/billy_fn_pm.mdl",
	Health = "100",
	KeyValues = { citizentype = 3 },
	Category = Category
}
list.Set( "NPC", "billy_fn_friendly", NPC )

local Category = "Fortnite"

--Hostile NPC
local NPC = 
{
    Name = "Billy - Hostile",
	Class = "npc_combine_s",
	Model = "models/player/billy_fn_pm.mdl",
	Health = "100",
	Category = Category
}
list.Set( "NPC", "billy_fn_hostile", NPC )