if SERVER then
    resource.AddFile( "models/ecott/chefcitizen.mdl" )
    resource.AddFile( "models/ecott/chefcitizen.dx90.vtx" )
    resource.AddFile( "models/ecott/chefcitizen.sw.vtx" )
    resource.AddFile( "models/ecott/chefcitizen.vvd" )
    resource.AddFile( "models/ecott/chefcitizen.phy" )
end

player_manager.AddValidModel( "Citizen chef", 					"models/ecott/chefcitizen.mdl" )
list.Set( "PlayerOptionsModel",  "Citizen chef", 						"models/ecott/chefcitizen.mdl" )
