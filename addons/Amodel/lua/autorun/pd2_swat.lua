if SERVER then
    resource.AddFile( "models/payday2/units/blue_swat_arms.mdl" )
    resource.AddFile( "models/payday2/units/blue_swat_arms.dx80.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_arms.dx90.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_arms.sw.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_arms.vvd" )
    resource.AddFile( "models/payday2/units/blue_swat_combine.mdl" )
    resource.AddFile( "models/payday2/units/blue_swat_combine.dx80.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_combine.dx90.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_combine.sw.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_combine.vvd" )
    resource.AddFile( "models/payday2/units/blue_swat_combine.phy" )
    resource.AddFile( "models/payday2/units/blue_swat_player.mdl" )
    resource.AddFile( "models/payday2/units/blue_swat_player.dx80.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_player.dx90.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_player.sw.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_player.vvd" )
    resource.AddFile( "models/payday2/units/blue_swat_player.phy" )
    resource.AddFile( "models/payday2/units/blue_swat_rebel.mdl" )
    resource.AddFile( "models/payday2/units/blue_swat_rebel.dx80.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_rebel.dx90.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_rebel.sw.vtx" )
    resource.AddFile( "models/payday2/units/blue_swat_rebel.vvd" )
    resource.AddFile( "models/payday2/units/blue_swat_rebel.phy" )
end

list.Set( "PlayerOptionsAnimations", "PD2_blue_swat", { "idle_suitcase", "menu_combine", "idle_all_01" } )
player_manager.AddValidModel( "PD2_blue_swat", "models/payday2/units/blue_swat_player.mdl" )
player_manager.AddValidHands( "PD2_blue_swat", "models/payday2/units/blue_swat_arms.mdl",	0, "0000000" )
local Category = "PAYDAY 2 NPCs"
local NPC = { 	Name = "PD2 blue SWAT (Enemy)",
				Class = "npc_combine_s",
				Model = "models/payday2/units/blue_swat_combine.mdl",
				Health = "100",
				Squadname = "Killing",
				Numgrenades = "4",
				Weapons = { "weapon_ar2", "weapon_smg1", "weapon_shotgun" },
                                Category = Category    }
list.Set( "NPC", "pd2_blue_swat_combine", NPC )
local NPC = { 	Name = "PD2 blue SWAT (Friendly)",
				Class = "npc_citizen",
				Model = "models/payday2/units/blue_swat_rebel.mdl",
				Health = "300",
				KeyValues = { citizentype = 4 },
				Weapons = { "weapon_ar2", "weapon_smg1", "weapon_shotgun" },
                                Category = Category    }
list.Set( "NPC", "pd2_blue_swat_rebel", NPC )
