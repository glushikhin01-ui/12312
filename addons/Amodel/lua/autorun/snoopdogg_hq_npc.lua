if SERVER then
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.mdl" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.dx80.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.dx90.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.sw.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.vvd" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.phy" )
end

local Category = "Voikanaa NPC"
local NPC = {	Name = "Snoop Dogg",
				Class = "npc_citizen",
				Model = "models/player/voikanaa/snoop_dogg_npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
				Weapons = { "weapon_smg1" },
				Category = Category }
list.Set( "NPC", "npc_snoopdogg_hq", NPC )
//
local Category = "Voikanaa NPC"
local NPC = {	Name = "Snoop Dogg Enemy",
				Class = "npc_combine_s",
				Model = "models/player/voikanaa/snoop_dogg_npc.mdl",
				Health = "100",
				Weapons = { "weapon_smg1" },
				Category = Category }
list.Set( "NPC", "npc_snoopdogg_hq_enemy", NPC )
