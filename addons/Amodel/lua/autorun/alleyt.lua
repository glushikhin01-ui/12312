if SERVER then
    resource.AddFile( "models/deepalley/alley_thug.mdl" )
    resource.AddFile( "models/deepalley/alley_thug.dx80.vtx" )
    resource.AddFile( "models/deepalley/alley_thug.dx90.vtx" )
    resource.AddFile( "models/deepalley/alley_thug.sw.vtx" )
    resource.AddFile( "models/deepalley/alley_thug.vvd" )
    resource.AddFile( "models/deepalley/alley_thug.phy" )
    resource.AddFile( "models/deepalley/alley_thug_arms.mdl" )
    resource.AddFile( "models/deepalley/alley_thug_arms.dx80.vtx" )
    resource.AddFile( "models/deepalley/alley_thug_arms.dx90.vtx" )
    resource.AddFile( "models/deepalley/alley_thug_arms.sw.vtx" )
    resource.AddFile( "models/deepalley/alley_thug_arms.vvd" )
end

player_manager.AddValidModel( "Alley Thug", "models/deepalley/alley_thug.mdl" )
list.Set( "PlayerOptionsModel",  "Alley Thug", "models/deepalley/alley_thug.mdl" )
player_manager.AddValidHands( "Alley Thug", "models/deepalley/alley_thug_arms.mdl", 0, "00000000" )
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
