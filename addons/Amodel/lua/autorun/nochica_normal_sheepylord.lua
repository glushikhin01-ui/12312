player_manager.AddValidModel("Nochica M", "models/sheepylord/Nochica/Nochica_normal_pm.mdl");
player_manager.AddValidHands("Nochica M", "models/sheepylord/Nochica/Nochica_normal_arms.mdl" , 0, "000000")

local Category = "Nochica"

local NPC = {
    Name = "Nochica M (Friendly)",
    Class = "npc_citizen",
    Model = "models/sheepylord/Nochica/Nochica_normal.mdl",
    Health = "100",
    KeyValues = { citizentype = 4 },
    Weapons = { "weapon_smg1" },
    Category = Category
}

list.Set("NPC", "Nochica_normal_sheepylord_F", NPC)

local NPC = {
    Name = "Nochica M (Enemy)",
    Class = "npc_combine_s",
    Model = "models/sheepylord/Nochica/Nochica_normal.mdl",
    Health = "100",
    Numgrenades = "4",
    Weapons = { "weapon_ar2" },
    Category = Category
}

list.Set("NPC", "Nochica_normal_sheepylord_E", NPC)
