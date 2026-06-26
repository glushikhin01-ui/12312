if SERVER then
    resource.AddFile( "models/hoyoverse/furina.mdl" )
    resource.AddFile( "models/hoyoverse/furina.dx80.vtx" )
    resource.AddFile( "models/hoyoverse/furina.dx90.vtx" )
    resource.AddFile( "models/hoyoverse/furina.sw.vtx" )
    resource.AddFile( "models/hoyoverse/furina.vvd" )
    resource.AddFile( "models/hoyoverse/furina.phy" )
    resource.AddFile( "models/weapons/furina_arms_new.mdl" )
    resource.AddFile( "models/weapons/furina_arms_new.dx80.vtx" )
    resource.AddFile( "models/weapons/furina_arms_new.dx90.vtx" )
    resource.AddFile( "models/weapons/furina_arms_new.sw.vtx" )
    resource.AddFile( "models/weapons/furina_arms_new.vvd" )
end

player_manager.AddValidModel("Furina", "models/hoyoverse/furina.mdl")
player_manager.AddValidHands("Furina", "models/weapons/furina_arms_new.mdl", 0, "00000000")
