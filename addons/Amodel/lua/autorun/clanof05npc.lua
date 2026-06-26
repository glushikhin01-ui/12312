if SERVER then
    resource.AddFile( "models/humans/clanof05/male_02.mdl" )
    resource.AddFile( "models/humans/clanof05/male_02.dx80.vtx" )
    resource.AddFile( "models/humans/clanof05/male_02.dx90.vtx" )
    resource.AddFile( "models/humans/clanof05/male_02.sw.vtx" )
    resource.AddFile( "models/humans/clanof05/male_02.vvd" )
    resource.AddFile( "models/humans/clanof05/male_02.phy" )
    resource.AddFile( "models/humans/clanof05/male_04.mdl" )
    resource.AddFile( "models/humans/clanof05/male_04.dx80.vtx" )
    resource.AddFile( "models/humans/clanof05/male_04.dx90.vtx" )
    resource.AddFile( "models/humans/clanof05/male_04.sw.vtx" )
    resource.AddFile( "models/humans/clanof05/male_04.vvd" )
    resource.AddFile( "models/humans/clanof05/male_04.phy" )
    resource.AddFile( "models/humans/clanof05/male_05.mdl" )
    resource.AddFile( "models/humans/clanof05/male_05.dx80.vtx" )
    resource.AddFile( "models/humans/clanof05/male_05.dx90.vtx" )
    resource.AddFile( "models/humans/clanof05/male_05.sw.vtx" )
    resource.AddFile( "models/humans/clanof05/male_05.vvd" )
    resource.AddFile( "models/humans/clanof05/male_05.phy" )
    resource.AddFile( "models/humans/clanof05/male_06.mdl" )
    resource.AddFile( "models/humans/clanof05/male_06.dx80.vtx" )
    resource.AddFile( "models/humans/clanof05/male_06.dx90.vtx" )
    resource.AddFile( "models/humans/clanof05/male_06.sw.vtx" )
    resource.AddFile( "models/humans/clanof05/male_06.vvd" )
    resource.AddFile( "models/humans/clanof05/male_06.phy" )
    resource.AddFile( "models/humans/clanof05/male_08.mdl" )
    resource.AddFile( "models/humans/clanof05/male_08.dx80.vtx" )
    resource.AddFile( "models/humans/clanof05/male_08.dx90.vtx" )
    resource.AddFile( "models/humans/clanof05/male_08.sw.vtx" )
    resource.AddFile( "models/humans/clanof05/male_08.vvd" )
    resource.AddFile( "models/humans/clanof05/male_08.phy" )
    resource.AddFile( "models/humans/clanof05/male_09.mdl" )
    resource.AddFile( "models/humans/clanof05/male_09.dx80.vtx" )
    resource.AddFile( "models/humans/clanof05/male_09.dx90.vtx" )
    resource.AddFile( "models/humans/clanof05/male_09.sw.vtx" )
    resource.AddFile( "models/humans/clanof05/male_09.vvd" )
    resource.AddFile( "models/humans/clanof05/male_09.phy" )
end

local Category = "Summer Civilians V6"
local NPC = { 	Name = "Male_02",
				Class = "npc_citizen",
				Model = "models/humans/clanof05/male_02.mdl",
				Health = "200",
				KeyValues = { citizentype = 4 },
				Category = Category	}
list.Set( "NPC", "npc_summer_02_05", NPC )
local NPC = { 	Name = "Male_04",
				Class = "npc_citizen",
				Model = "models/humans/clanof05/male_04.mdl",
				Health = "200",
				KeyValues = { citizentype = 4 },
				Category = Category	}
list.Set( "NPC", "npc_summer_04_05", NPC )
local NPC = { 	Name = "Male_05",
				Class = "npc_citizen",
				Model = "models/humans/clanof05/male_05.mdl",
				Health = "200",
				KeyValues = { citizentype = 4 },
				Category = Category	}
list.Set( "NPC", "npc_summer_05_05", NPC )
local NPC = { 	Name = "Male_06",
				Class = "npc_citizen",
				Model = "models/humans/clanof05/male_06.mdl",
				Health = "200",
				KeyValues = { citizentype = 4 },
				Category = Category	}
list.Set( "NPC", "npc_summer_06_05", NPC )
local NPC = { 	Name = "Male_08",
				Class = "npc_citizen",
				Model = "models/humans/clanof05/male_08.mdl",
				Health = "200",
				KeyValues = { citizentype = 4 },
				Category = Category	}
list.Set( "NPC", "npc_summer_08_05", NPC )
local NPC = { 	Name = "Male_09",
				Class = "npc_citizen",
				Model = "models/humans/clanof05/male_09.mdl",
				Health = "200",
				KeyValues = { citizentype = 4 },
				Category = Category	}
list.Set( "NPC", "npc_summer_09_05", NPC )
