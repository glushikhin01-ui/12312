player_manager.AddValidModel( "MotoMoto", "models/a_thing/madagascar/motomoto_pm.mdl" );

list.Set( "PlayerOptionsModel", "MotoMoto", "models/a_thing/madagascar/motomoto_pm.mdl" );


local Category = "Madagascar"

local NPC = {   
        Name = "MotoMoto Enemy", 
        Class = "npc_combine_s", 
        Model = "models/a_thing/madagascar/motomoto_pm.mdl",                 
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "MotoMoto Enemy"
}

list.Set( "NPC", "npc_MotoMoto_enemy", NPC ) 

local NPC = {   
        Name = "MotoMoto Friend", 
        Class = "npc_citizen", 
        Model = "models/a_thing/madagascar/motomoto_pm.mdl",                 
        Health = "100",                 
        KeyValues = { citizentype = 4 },                 
        Category = Category,
        Squadname = "MotoMoto Friend"
}

list.Set( "NPC", "npc_MotoMoto_Friend", NPC ) 


