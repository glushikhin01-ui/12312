--Add Playermodel
player_manager.AddValidModel( "Doom Slayer - Fortnite", "models/player/doom_fn_pm.mdl" )
player_manager.AddValidHands( "Doom Slayer - Fortnite", "models/weapons/doom_fn_hands.mdl" )
list.Set( "PlayerOptionsModel", "Doom Slayer - Fortnite", "models/player/doom_fn_pm.mdl" )

--Add NPC
local Category = "Fortnite"

--Friendly NPC
local NPC = 
{
    Name = "Doom Slayer - Friendly",
    Class = "npc_citizen",
	Model = "models/player/doom_fn_pm.mdl",
	Health = "100",
	KeyValues = { citizentype = 3 },
	Category = Category
}
list.Set( "NPC", "doom_fn_friendly", NPC )

local Category = "Fortnite"

--Hostile NPC
local NPC = 
{
    Name = "Doom Slayer - Hostile",
	Class = "npc_combine_s",
	Model = "models/player/doom_fn_pm.mdl",
	Health = "100",
	Category = Category
}
list.Set( "NPC", "doom_fn_hostile", NPC )