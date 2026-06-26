if SERVER then
    resource.AddFile( "models/humans/group01/reflect.mdl" )
    resource.AddFile( "models/humans/group01/reflect.dx80.vtx" )
    resource.AddFile( "models/humans/group01/reflect.dx90.vtx" )
    resource.AddFile( "models/humans/group01/reflect.sw.vtx" )
    resource.AddFile( "models/humans/group01/reflect.vvd" )
    resource.AddFile( "models/humans/group01/reflect.phy" )
end

local Category = "Humans + Resistance"
local NPC = {	Name = "Reflectent",
				Class = "npc_citizen",
				Model = "models/humans/group01/reflect.mdl",
				Health = "150",
				KeyValues = { citizentype = 4 },
				Category = Category }
list.Set( "NPC", "npc_reflectent", NPC )
