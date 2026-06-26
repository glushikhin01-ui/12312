if SERVER then
    resource.AddFile( "models/player/scientist.mdl" )
    resource.AddFile( "models/player/scientist.dx80.vtx" )
    resource.AddFile( "models/player/scientist.dx90.vtx" )
    resource.AddFile( "models/player/scientist.sw.vtx" )
    resource.AddFile( "models/player/scientist.vvd" )
    resource.AddFile( "models/player/scientist.phy" )
end

player_manager.AddValidModel( "Scientist",							 "models/player/scientist.mdl" );
list.Set( "PlayerOptionsModel", "Scientist",	 		 			 "models/player/scientist.mdl" );
