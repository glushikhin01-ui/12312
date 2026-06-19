player_manager.AddValidModel("New MMD Model", "models/sheepylord/Rezero_felix/New_MMD_Model_pm.mdl");
player_manager.AddValidHands("New MMD Model", "models/sheepylord/Rezero_felix/New_MMD_Model_arms.mdl" , 0, "000000")

local Category = "Felix Argyle"

local NPC = {
    Name = "New MMD Model (Friendly)",
    Class = "npc_citizen",
    Model = "models/sheepylord/Rezero_felix/New_MMD_Model.mdl",
    Health = "100",
    KeyValues = { citizentype = 4 },
    Weapons = { "weapon_smg1" },
    Category = Category
}

list.Set("NPC", "New_MMD_Model_sheepylord_F", NPC)

local NPC = {
    Name = "New MMD Model (Enemy)",
    Class = "npc_combine_s",
    Model = "models/sheepylord/Rezero_felix/New_MMD_Model.mdl",
    Health = "100",
    Numgrenades = "4",
    Weapons = { "weapon_ar2" },
    Category = Category
}

list.Set("NPC", "New_MMD_Model_sheepylord_E", NPC)
