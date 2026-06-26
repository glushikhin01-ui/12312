if SERVER then
    resource.AddFile( "models/player/mechanic.mdl" )
    resource.AddFile( "models/player/mechanic.dx80.vtx" )
    resource.AddFile( "models/player/mechanic.dx90.vtx" )
    resource.AddFile( "models/player/mechanic.sw.vtx" )
    resource.AddFile( "models/player/mechanic.vvd" )
    resource.AddFile( "models/player/mechanic.phy" )
end

player_manager.AddValidModel( "Mechanic", 									"models/player/mechanic.mdl" )
list.Set( "PlayerOptionsModel",  "Mechanic",								"models/player/mechanic.mdl" )
