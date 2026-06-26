if SERVER then
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.mdl" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.dx80.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.dx90.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.sw.vtx" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.vvd" )
    resource.AddFile( "models/player/voikanaa/snoop_dogg_npc.phy" )
end

local Snoopdogghq_models = {
							"models/player/voikanaa/snoop_dogg_npc.mdl"
						}
hook.Add("PlayerSpawnedNPC","RandomBodyGroupSnoopdogghq",function(ply,npc)
    if table.HasValue( Snoopdogghq_models, npc:GetModel() )
	       then
         npc:SetBodygroup(1,math.random( 0, 1 ) ) // You need to have this one here or the entire thing gets screwed over
		 npc:SetBodygroup(2,math.random( 0, 1 ) ) // Hats
    end
end)
