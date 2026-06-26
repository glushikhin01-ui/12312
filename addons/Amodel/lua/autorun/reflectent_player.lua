if SERVER then
    resource.AddFile( "models/player/group01/reflect.mdl" )
    resource.AddFile( "models/player/group01/reflect.dx80.vtx" )
    resource.AddFile( "models/player/group01/reflect.dx90.vtx" )
    resource.AddFile( "models/player/group01/reflect.sw.vtx" )
    resource.AddFile( "models/player/group01/reflect.vvd" )
    resource.AddFile( "models/player/group01/reflect.phy" )
end

player_manager.AddValidModel( "Reflectent", 		"models/player/group01/reflect.mdl" )
list.Set( "PlayerOptionsModel",  "Reflectent", 		"models/Player/group01/reflect.mdl" )
