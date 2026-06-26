if SERVER then
    resource.AddFile( "models/wick_chapter2/wick_chapter2.mdl" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2.dx80.vtx" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2.dx90.vtx" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2.sw.vtx" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2.vvd" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2.phy" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2_c_arms.mdl" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2_c_arms.dx80.vtx" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2_c_arms.dx90.vtx" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2_c_arms.sw.vtx" )
    resource.AddFile( "models/wick_chapter2/wick_chapter2_c_arms.vvd" )
end

player_manager.AddValidModel( "Wick Chapter 2", "models/wick_chapter2/wick_chapter2.mdl" );
list.Set( "PlayerOptionsModel", "Wick Chapter 2", "models/wick_chapter2/wick_chapter2.mdl" );
player_manager.AddValidHands( "Wick Chapter 2", "models/wick_chapter2/wick_chapter2_c_arms.mdl", 0, "00000000" )
