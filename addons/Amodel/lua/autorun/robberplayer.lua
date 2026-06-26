if SERVER then
    resource.AddFile( "models/code_gs/robber/robberplayer.mdl" )
    resource.AddFile( "models/code_gs/robber/robberplayer.dx80.vtx" )
    resource.AddFile( "models/code_gs/robber/robberplayer.dx90.vtx" )
    resource.AddFile( "models/code_gs/robber/robberplayer.sw.vtx" )
    resource.AddFile( "models/code_gs/robber/robberplayer.vvd" )
    resource.AddFile( "models/code_gs/robber/robberplayer.phy" )
end

list.Set( "PlayerOptionsModel", "robberplayer", "models/code_gs/robber/robberplayer.mdl" )
player_manager.AddValidModel( "robberplayer", "models/code_gs/robber/robberplayer.mdl" )
player_manager.AddValidHands( "robberplayer", "models/weapons/c_arms_cstrike.mdl", 0, "00000000" )
