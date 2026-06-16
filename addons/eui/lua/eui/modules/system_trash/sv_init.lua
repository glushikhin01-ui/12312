local ignore_ents = {
  ["keyframe_rope"] = true,
  ["prop_dynamic"] = true,
  ["move_rope"] = true,
}

local models = {
  'models/props_junk/garbage128_composite001a.mdl',
  'models/props_junk/garbage128_composite001b.mdl',
  'models/props_junk/garbage128_composite001c.mdl',
  'models/props_junk/garbage128_composite001d.mdl'
}

timer.Create('gsr_trash_spawn',300,0,function()
  for k,v in pairs(rp.trash_system.position) do
    local entities = ents.FindInSphere(Vector(v.pos), 80)
    local found = false
  
    for a, b in pairs(entities) do
      if b:GetClass() == 'ent_trash' then found = true end
    end
  
    if found then
      continue
    end
  
    local trash = ents.Create"ent_trash"
    trash:SetPos(Vector(v.pos) - Vector(0, 0, 80))
    trash:SetAngles(Angle(v.ang))
    trash:SetModel(models[math.random(1, #models)])
    trash:Spawn()
  end
end)

for k, v in ipairs(ents.GetAll()) do
    if v:GetClass() == 'ent_trash' then v:Remove() end
end
