if SERVER then
    resource.AddFile( "models/player/voikanaa/snoop_dogg.mdl" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg.dx80.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg.dx90.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg.sw.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg.vvd" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg.phy" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_arms.mdl" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_arms.dx80.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_arms.dx90.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_arms.sw.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_arms.vvd" )
end

player_manager.AddValidModel( "Snoop Dogg", 		"models/player/voikanaa/snoop_dogg.mdl" );
player_manager.AddValidHands( "Snoop Dogg", 	"models/player/voikanaa/snoop_dogg_arms.mdl", 0, "00000000" )
list.Set( "PlayerOptionsModel", "Snoop Dogg", 	"models/player/voikanaa/snoop_dogg.mdl" );
