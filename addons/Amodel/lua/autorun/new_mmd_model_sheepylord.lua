if SERVER then AddCSLuaFile() end

player_manager.AddValidModel("New MMD Model", "models/sheepylord/rezero_felix/new_mmd_model_pm.mdl")
player_manager.AddValidHands("New MMD Model", "models/sheepylord/rezero_felix/new_mmd_model_arms.mdl", 0, "000000")

local Category = "Felix Argyle"

local NPC = {
    Name = "New MMD Model (Friendly)",
    Class = "npc_citizen",
    Model = "models/sheepylord/rezero_felix/new_mmd_model.mdl",
    Health = "100",
    KeyValues = { citizentype = 4 },
    Weapons = { "weapon_smg1" },
    Category = Category
}

list.Set("NPC", "New_MMD_Model_sheepylord_F", NPC)

local NPC = {
    Name = "New MMD Model (Enemy)",
    Class = "npc_combine_s",
    Model = "models/sheepylord/rezero_felix/new_mmd_model.mdl",
    Health = "100",
    Numgrenades = "4",
    Weapons = { "weapon_ar2" },
    Category = Category
}

list.Set("NPC", "New_MMD_Model_sheepylord_E", NPC)