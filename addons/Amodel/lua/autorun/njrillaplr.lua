if SERVER then
    resource.AddFile( "models/player/ninjuerilla.mdl" )
    resource.AddFile( "models/player/ninjuerilla.dx80.vtx" )
    resource.AddFile( "models/player/ninjuerilla.dx90.vtx" )
    resource.AddFile( "models/player/ninjuerilla.sw.vtx" )
    resource.AddFile( "models/player/ninjuerilla.vvd" )
    resource.AddFile( "models/player/ninjuerilla.phy" )
end

player_manager.AddValidModel( "Ninjuerilla", "models/player/ninjuerilla.mdl" )
list.Set( "PlayerOptionsModel", "Ninjuerilla", "models/player/ninjuerilla.mdl" )
