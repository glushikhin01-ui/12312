if SERVER then
    resource.AddFile( "models/gatorcreek/el_gator.mdl" )
    resource.AddFile( "models/gatorcreek/el_gator.dx80.vtx" )
    resource.AddFile( "models/gatorcreek/el_gator.dx90.vtx" )
    resource.AddFile( "models/gatorcreek/el_gator.sw.vtx" )
    resource.AddFile( "models/gatorcreek/el_gator.vvd" )
    resource.AddFile( "models/gatorcreek/el_gator.phy" )
    resource.AddFile( "models/gatorcreek/el_gator_arms.mdl" )
    resource.AddFile( "models/gatorcreek/el_gator_arms.dx80.vtx" )
    resource.AddFile( "models/gatorcreek/el_gator_arms.dx90.vtx" )
    resource.AddFile( "models/gatorcreek/el_gator_arms.sw.vtx" )
    resource.AddFile( "models/gatorcreek/el_gator_arms.vvd" )
end

player_manager.AddValidModel( "El gator", "models/gatorcreek/el_gator.mdl" )
list.Set( "PlayerOptionsModel",  "El gator", "models/gatorcreek/el_gator.mdl" )
player_manager.AddValidHands( "El gator", "models/gatorcreek/el_gator_arms.mdl", 0, "00000000" )
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
