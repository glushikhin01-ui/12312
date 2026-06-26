if SERVER then
    resource.AddFile( "models/player/valley/pennyworth.mdl" )
    resource.AddFile( "models/player/valley/pennyworth.dx80.vtx" )
    resource.AddFile( "models/player/valley/pennyworth.dx90.vtx" )
    resource.AddFile( "models/player/valley/pennyworth.sw.vtx" )
    resource.AddFile( "models/player/valley/pennyworth.vvd" )
    resource.AddFile( "models/player/valley/pennyworth.phy" )
end

player_manager.AddValidModel( "BAK: Alfred Pennyworth", "models/player/valley/pennyworth.mdl" )
list.Set( "PlayerOptionsModel",  "BAK: Alfred Pennyworth", "models/player/valley/pennyworth.mdl" )
