if SERVER then
    resource.AddFile( "models/lenoax/cavejohnson_npc.mdl" )
    resource.AddFile( "models/lenoax/cavejohnson_npc.dx80.vtx" )
    resource.AddFile( "models/lenoax/cavejohnson_npc.dx90.vtx" )
    resource.AddFile( "models/lenoax/cavejohnson_npc.sw.vtx" )
    resource.AddFile( "models/lenoax/cavejohnson_npc.vvd" )
    resource.AddFile( "models/lenoax/cavejohnson_npc.phy" )
    resource.AddFile( "models/lenoax/cavejohnson_pm.mdl" )
    resource.AddFile( "models/lenoax/cavejohnson_pm.dx80.vtx" )
    resource.AddFile( "models/lenoax/cavejohnson_pm.dx90.vtx" )
    resource.AddFile( "models/lenoax/cavejohnson_pm.sw.vtx" )
    resource.AddFile( "models/lenoax/cavejohnson_pm.vvd" )
    resource.AddFile( "models/lenoax/cavejohnson_pm.phy" )
    resource.AddFile( "models/lenoax/cavejohnson_pm_hands.mdl" )
    resource.AddFile( "models/lenoax/cavejohnson_pm_hands.dx80.vtx" )
    resource.AddFile( "models/lenoax/cavejohnson_pm_hands.dx90.vtx" )
    resource.AddFile( "models/lenoax/cavejohnson_pm_hands.sw.vtx" )
    resource.AddFile( "models/lenoax/cavejohnson_pm_hands.vvd" )
end

player_manager.AddValidModel( "Portal 2: Cave Johnson 70s", "models/Lenoax/CaveJohnson_PM.mdl" )
player_manager.AddValidHands( "Portal 2: Cave Johnson 70s", "models/Lenoax/CaveJohnson_PM_Hands.mdl", 0, 0 )
local NPC =
{
	Name = "Cave Johnson",
	Class = "npc_citizen",
	KeyValues = { citizentype = 4 },
	Model = "models/Lenoax/CaveJohnson_NPC.mdl",
	Category = "Portal 2"
}
list.Set( "NPC", "npc_portal_cavejohnson", NPC )
