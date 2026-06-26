if SERVER then
    resource.AddFile( "models/humans/group01/dahlia0o0.mdl" )
    resource.AddFile( "models/humans/group01/dahlia0o0.dx80.vtx" )
    resource.AddFile( "models/humans/group01/dahlia0o0.dx90.vtx" )
    resource.AddFile( "models/humans/group01/dahlia0o0.sw.vtx" )
    resource.AddFile( "models/humans/group01/dahlia0o0.vvd" )
    resource.AddFile( "models/humans/group01/dahlia0o0.phy" )
    resource.AddFile( "models/player/group01/dahlia0o0.mdl" )
    resource.AddFile( "models/player/group01/dahlia0o0.dx80.vtx" )
    resource.AddFile( "models/player/group01/dahlia0o0.dx90.vtx" )
    resource.AddFile( "models/player/group01/dahlia0o0.sw.vtx" )
    resource.AddFile( "models/player/group01/dahlia0o0.vvd" )
    resource.AddFile( "models/player/group01/dahlia0o0.phy" )
end

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
