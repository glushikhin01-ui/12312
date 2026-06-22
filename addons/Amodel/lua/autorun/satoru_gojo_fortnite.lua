if SERVER then
    AddCSLuaFile()

    local files = {
        -- Model
        "models/jjk_falko/satoru_gojo_fortnite.mdl",
        "models/jjk_falko/satoru_gojo_fortnite.dx90.vtx",
        "models/jjk_falko/satoru_gojo_fortnite.vvd",
        "models/jjk_falko/satoru_gojo_fortnite.phy",

        -- Materials
        "materials/models/satoru_gojo_fortnite/body.vmt",
        "materials/models/satoru_gojo_fortnite/body.vtf",
        "materials/models/satoru_gojo_fortnite/hair.vmt",
        "materials/models/satoru_gojo_fortnite/hair.vtf",
        "materials/models/satoru_gojo_fortnite/hairsixeyes.vmt",
        "materials/models/satoru_gojo_fortnite/hairsixeyes.vtf",
        "materials/models/satoru_gojo_fortnite/handsbody.vmt",
        "materials/models/satoru_gojo_fortnite/handsbody.vtf",
        "materials/models/satoru_gojo_fortnite/head.vmt",
        "materials/models/satoru_gojo_fortnite/head.vtf",
        "materials/models/satoru_gojo_fortnite/lightwarpshader.vtf",
    }

    for _, path in ipairs(files) do
        if file.Exists(path, "GAME") then
            resource.AddFile(path)
            print("[Satoru Gojo Fortnite] Added: " .. path)
        else
            print("[Satoru Gojo Fortnite] MISSING: " .. path)
        end
    end
end

local modelName = "Satoru Gojo Fortnite"
local modelPath = "models/jjk_falko/satoru_gojo_fortnite.mdl"

player_manager.AddValidModel(modelName, modelPath)
list.Set("PlayerOptionsModel", modelName, modelPath)