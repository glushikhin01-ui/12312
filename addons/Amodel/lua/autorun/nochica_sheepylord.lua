player_manager.AddValidModel("Nochica", "models/sheepylord/Nochica/Nochica_pm.mdl");
player_manager.AddValidHands("Nochica", "models/sheepylord/Nochica/Nochica_arms.mdl" , 0, "000000")

local Category = "Nochica"

local NPC = {
    Name = "Nochica (Friendly)",
    Class = "npc_citizen",
    Model = "models/sheepylord/Nochica/Nochica.mdl",
    Health = "100",
    KeyValues = { citizentype = 4 },
    Weapons = { "weapon_smg1" },
    Category = Category
}

list.Set("NPC", "Nochica_sheepylord_F", NPC)

local NPC = {
    Name = "Nochica (Enemy)",
    Class = "npc_combine_s",
    Model = "models/sheepylord/Nochica/Nochica.mdl",
    Health = "100",
    Numgrenades = "4",
    Weapons = { "weapon_ar2" },
    Category = Category
}

list.Set("NPC", "Nochica_sheepylord_E", NPC)
