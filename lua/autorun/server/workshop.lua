if SERVER then
    resource.AddWorkshop("3086031154")
    resource.AddWorkshop("3745003429")
    resource.AddWorkshop("2907866695")
    resource.AddWorkshop("3003893737")

    local files = {
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
    }

    for _, path in ipairs(files) do
        resource.AddFile(path)
        print("[FURINA FASTDL] AddFile: " .. path)
    end
end