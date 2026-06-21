if SERVER then
    resource.AddWorkshop("3086031154")
    resource.AddWorkshop("3745003429")
    resource.AddWorkshop("2907866695")
    resource.AddWorkshop("3003893737")
    resource.AddWorkshop("3337860652")
    resource.AddWorkshop("3743221782")
    resource.AddWorkshop("3036509178")

    local files = {
        -- Furina
        "models/hoyoverse/furina.mdl",
        "models/hoyoverse/furina.dx80.vtx",
        "models/hoyoverse/furina.dx90.vtx",
        "models/hoyoverse/furina.sw.vtx",
        "models/hoyoverse/furina.vvd",
        "models/hoyoverse/furina.phy",

        "models/weapons/furina_arms_new.mdl",
        "models/weapons/furina_arms_new.dx80.vtx",
        "models/weapons/furina_arms_new.dx90.vtx",
        "models/weapons/furina_arms_new.sw.vtx",
        "models/weapons/furina_arms_new.vvd",

        "materials/ruka/ys/ff/basewarp.vtf",
        "materials/ruka/ys/ff/fa.vmt",
        "materials/ruka/ys/ff/fa.vtf",
        "materials/ruka/ys/ff/fa2.vmt",
        "materials/ruka/ys/ff/fa2.vtf",
        "materials/ruka/ys/ff/fa2_n.vtf",
        "materials/ruka/ys/ff/l.vmt",
        "materials/ruka/ys/ff/l.vtf",
        "materials/ruka/ys/ff/ti.vmt",
        "materials/ruka/ys/ff/ti.vtf",
        "materials/ruka/ys/ff/ti_n.vtf",

        -- Felix / Re:Zero
        "models/sheepylord/rezero_felix/new_mmd_model.mdl",
        "models/sheepylord/rezero_felix/new_mmd_model.dx80.vtx",
        "models/sheepylord/rezero_felix/new_mmd_model.dx90.vtx",
        "models/sheepylord/rezero_felix/new_mmd_model.vvd",
        "models/sheepylord/rezero_felix/new_mmd_model.phy",

        "models/sheepylord/rezero_felix/new_mmd_model_pm.mdl",
        "models/sheepylord/rezero_felix/new_mmd_model_pm.dx80.vtx",
        "models/sheepylord/rezero_felix/new_mmd_model_pm.dx90.vtx",
        "models/sheepylord/rezero_felix/new_mmd_model_pm.vvd",
        "models/sheepylord/rezero_felix/new_mmd_model_pm.phy",

        "models/sheepylord/rezero_felix/new_mmd_model_arms.mdl",
        "models/sheepylord/rezero_felix/new_mmd_model_arms.dx80.vtx",
        "models/sheepylord/rezero_felix/new_mmd_model_arms.dx90.vtx",
        "models/sheepylord/rezero_felix/new_mmd_model_arms.vvd",

        "materials/models/sheepylord/new_mmd_model/felix.vmt",
        "materials/models/sheepylord/new_mmd_model/felix.vtf",
        "materials/models/sheepylord/shared/lightwarptexture.vtf",
        "materials/models/sheepylord/shared/normal.vtf",
        "materials/models/sheepylord/shared/phong_exp.vtf",

        "materials/vgui/entities/new_mmd_model_sheepylord_e.vmt",
        "materials/vgui/entities/new_mmd_model_sheepylord_e.vtf",
        "materials/vgui/entities/new_mmd_model_sheepylord_f.vmt",
        "materials/vgui/entities/new_mmd_model_sheepylord_f.vtf",
    }

    for _, path in ipairs(files) do
        resource.AddFile(path)
        print("[FASTDL] AddFile: " .. path)
    end
end