if SERVER then
    resource.AddFile( "models/player/bala_pm.mdl" )
    resource.AddFile( "models/player/bala_pm.dx80.vtx" )
    resource.AddFile( "models/player/bala_pm.dx90.vtx" )
    resource.AddFile( "models/player/bala_pm.sw.vtx" )
    resource.AddFile( "models/player/bala_pm.vvd" )
    resource.AddFile( "models/player/bala_pm.phy" )
end

player_manager.AddValidModel( "Bala", "models/player/Bala_pm.mdl" )
list.Set( "PlayerOptionsModel",  "Bala", "models/player/Bala_pm.mdl" )
