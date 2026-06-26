
local mdl ={ 
			"models/katy/npc/merriweather/male_01_enemy.mdl",
			"models/katy/npc/merriweather/male_02_enemy.mdl",
			"models/katy/npc/merriweather/male_03_enemy.mdl",
			"models/katy/npc/merriweather/male_04_enemy.mdl",
			"models/katy/npc/merriweather/male_05_enemy.mdl",
			"models/katy/npc/merriweather/male_06_enemy.mdl",
			"models/katy/npc/merriweather/male_07_enemy.mdl",
			"models/katy/npc/merriweather/male_08_enemy.mdl",
			"models/katy/npc/merriweather/male_09_enemy.mdl",
			"models/katy/npc/merriweather/male_01_friend.mdl",
			"models/katy/npc/merriweather/male_02_friend.mdl",
			"models/katy/npc/merriweather/male_03_friend.mdl",
			"models/katy/npc/merriweather/male_04_friend.mdl",
			"models/katy/npc/merriweather/male_05_friend.mdl",
			"models/katy/npc/merriweather/male_06_friend.mdl",
			"models/katy/npc/merriweather/male_07_friend.mdl",
			"models/katy/npc/merriweather/male_08_friend.mdl",
			"models/katy/npc/merriweather/male_09_friend.mdl",
			}
			
hook.Add("PlayerSpawnedNPC","RandomBodyGroupMerriweather",function(ply,npc)
	if table.HasValue( mdl, npc:GetModel() ) 					
		then npc:SetSkin( math.random(0,9) )
			npc:SetBodygroup( 2, math.random(0,4) )
			npc:SetBodygroup( 1, math.random(0,3) )
    end
end)

local Merriweather_models_enemy = {"models/katy/npc/merriweather/male_01_enemy.mdl",}
hook.Add("PlayerSpawnedNPC","RandomModel", function(ply,npc) 
	if table.HasValue( Merriweather_models_enemy, npc:GetModel() )					
		then
			npc:SetModel("models/katy/npc/merriweather/male_0"..math.random(1,9).."_enemy.mdl")	
    end
end)

local Merriweather_models_friend = {"models/katy/npc/merriweather/male_01_friend.mdl",}
hook.Add("PlayerSpawnedNPC","RandomModel", function(ply,npc) 
	if table.HasValue( Merriweather_models_friend, npc:GetModel() )					
		then
			npc:SetModel("models/katy/npc/merriweather/male_0"..math.random(1,9).."_friend.mdl")	
    end
end)