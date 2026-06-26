if SERVER then
    resource.AddFile( "models/player/tuxmale_01npc.mdl" )
    resource.AddFile( "models/player/tuxmale_01npc.dx80.vtx" )
    resource.AddFile( "models/player/tuxmale_01npc.dx90.vtx" )
    resource.AddFile( "models/player/tuxmale_01npc.sw.vtx" )
    resource.AddFile( "models/player/tuxmale_01npc.vvd" )
    resource.AddFile( "models/player/tuxmale_01npc.phy" )
    resource.AddFile( "models/player/tuxmale_02npc.mdl" )
    resource.AddFile( "models/player/tuxmale_02npc.dx80.vtx" )
    resource.AddFile( "models/player/tuxmale_02npc.dx90.vtx" )
    resource.AddFile( "models/player/tuxmale_02npc.sw.vtx" )
    resource.AddFile( "models/player/tuxmale_02npc.vvd" )
    resource.AddFile( "models/player/tuxmale_02npc.phy" )
    resource.AddFile( "models/player/tuxmale_03npc.mdl" )
    resource.AddFile( "models/player/tuxmale_03npc.dx80.vtx" )
    resource.AddFile( "models/player/tuxmale_03npc.dx90.vtx" )
    resource.AddFile( "models/player/tuxmale_03npc.sw.vtx" )
    resource.AddFile( "models/player/tuxmale_03npc.vvd" )
    resource.AddFile( "models/player/tuxmale_03npc.phy" )
    resource.AddFile( "models/player/tuxmale_04npc.mdl" )
    resource.AddFile( "models/player/tuxmale_04npc.dx80.vtx" )
    resource.AddFile( "models/player/tuxmale_04npc.dx90.vtx" )
    resource.AddFile( "models/player/tuxmale_04npc.sw.vtx" )
    resource.AddFile( "models/player/tuxmale_04npc.vvd" )
    resource.AddFile( "models/player/tuxmale_04npc.phy" )
    resource.AddFile( "models/player/tuxmale_05npc.mdl" )
    resource.AddFile( "models/player/tuxmale_05npc.dx80.vtx" )
    resource.AddFile( "models/player/tuxmale_05npc.dx90.vtx" )
    resource.AddFile( "models/player/tuxmale_05npc.sw.vtx" )
    resource.AddFile( "models/player/tuxmale_05npc.vvd" )
    resource.AddFile( "models/player/tuxmale_05npc.phy" )
    resource.AddFile( "models/player/tuxmale_06npc.mdl" )
    resource.AddFile( "models/player/tuxmale_06npc.dx80.vtx" )
    resource.AddFile( "models/player/tuxmale_06npc.dx90.vtx" )
    resource.AddFile( "models/player/tuxmale_06npc.sw.vtx" )
    resource.AddFile( "models/player/tuxmale_06npc.vvd" )
    resource.AddFile( "models/player/tuxmale_06npc.phy" )
    resource.AddFile( "models/player/tuxmale_07npc.mdl" )
    resource.AddFile( "models/player/tuxmale_07npc.dx80.vtx" )
    resource.AddFile( "models/player/tuxmale_07npc.dx90.vtx" )
    resource.AddFile( "models/player/tuxmale_07npc.sw.vtx" )
    resource.AddFile( "models/player/tuxmale_07npc.vvd" )
    resource.AddFile( "models/player/tuxmale_07npc.phy" )
    resource.AddFile( "models/player/tuxmale_08npc.mdl" )
    resource.AddFile( "models/player/tuxmale_08npc.dx80.vtx" )
    resource.AddFile( "models/player/tuxmale_08npc.dx90.vtx" )
    resource.AddFile( "models/player/tuxmale_08npc.sw.vtx" )
    resource.AddFile( "models/player/tuxmale_08npc.vvd" )
    resource.AddFile( "models/player/tuxmale_08npc.phy" )
    resource.AddFile( "models/player/tuxmale_09npc.mdl" )
    resource.AddFile( "models/player/tuxmale_09npc.dx80.vtx" )
    resource.AddFile( "models/player/tuxmale_09npc.dx90.vtx" )
    resource.AddFile( "models/player/tuxmale_09npc.sw.vtx" )
    resource.AddFile( "models/player/tuxmale_09npc.vvd" )
    resource.AddFile( "models/player/tuxmale_09npc.phy" )
end

local Category = "Mafia II DLC"
local NPC = { 	Name = "Tuxedo Male01 (Enemy)",
				Class = "npc_combine_s",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_01npc.mdl",
				Health = "100",
				Numgrenades = "4",
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male01E", NPC )
local NPC = { 	Name = "Tuxedo Male01 (Friendly)",
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_01npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male01F", NPC )
local NPC = { 	Name = "Tuxedo Male02 (Enemy)",
				Class = "npc_combine_s",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_02npc.mdl",
				Health = "100",
				Numgrenades = "4",
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male02E", NPC )
local NPC = { 	Name = "Tuxedo Male02 (Friendly)",
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_02npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male02F", NPC )
local NPC = { 	Name = "Tuxedo Male03 (Enemy)",
				Class = "npc_combine_s",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_03npc.mdl",
				Health = "100",
				Numgrenades = "4",
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male03E", NPC )
local NPC = { 	Name = "Tuxedo Male03 (Friendly)",
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_03npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male03F", NPC )
local NPC = { 	Name = "Tuxedo Male04 (Enemy)",
				Class = "npc_combine_s",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_04npc.mdl",
				Health = "100",
				Numgrenades = "4",
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male04E", NPC )
local NPC = { 	Name = "Tuxedo Male04 (Friendly)",
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_04npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male04F", NPC )
local NPC = { 	Name = "Tuxedo Male05 (Enemy)",
				Class = "npc_combine_s",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_05npc.mdl",
				Health = "100",
				Numgrenades = "4",
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male05E", NPC )
local NPC = { 	Name = "Tuxedo Male05 (Friendly)",
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_05npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male05F", NPC )
local NPC = { 	Name = "Tuxedo Male06 (Enemy)",
				Class = "npc_combine_s",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_06npc.mdl",
				Health = "100",
				Numgrenades = "4",
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male06E", NPC )
local NPC = { 	Name = "Tuxedo Male06 (Friendly)",
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_06npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male06F", NPC )
local NPC = { 	Name = "Tuxedo Male07 (Enemy)",
				Class = "npc_combine_s",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_07npc.mdl",
				Health = "100",
				Numgrenades = "4",
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male07E", NPC )
local NPC = { 	Name = "Tuxedo Male07 (Friendly)",
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_07npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male07F", NPC )
local NPC = { 	Name = "Tuxedo Male08 (Enemy)",
				Class = "npc_combine_s",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_08npc.mdl",
				Health = "100",
				Numgrenades = "4",
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male08E", NPC )
local NPC = { 	Name = "Tuxedo Male08 (Friendly)",
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_08npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male08F", NPC )
local NPC = { 	Name = "Tuxedo Male09 (Enemy)",
				Class = "npc_combine_s",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_09npc.mdl",
				Health = "100",
				Numgrenades = "4",
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male09E", NPC )
local NPC = { 	Name = "Tuxedo Male09 (Friendly)",
				Class = "npc_citizen",
				Weapons = { "weapon_smg1" },
				Model = "models/player/tuxmale_09npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }
list.Set( "NPC", "npc_Tuxedo Male09F", NPC )
