if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.reFix_Base = true

timer.Create( "aa_AuioChn_HandleUpdateAnimationHooks",10,1,function()
	if glue and type(glue.HandleUpdateAnimationHooks) == "function" then
		A_AM.ActMod.reFix_gluehua = true
		include( "actmod/refix/a_gluehua.lua" )
	end
end)

timer.Create( "aa_AuioChn_WoundedLimp",11,1,function()
	if wOS and wOS.WoundedLimp then
		local pth1 = "wos/limping/core/sh_core.lua"
		if file.Exists(pth1, "LUA") and (SERVER and file.Size(pth1, "LUA") > 5 or CLIENT) then
			hook.Remove("CalcMainActivity","wOS" ..".WoundedLimp.AnimationHook")
			local pth2 = "actmod/refix/a_wolimp.lua"
			if file.Exists(pth2, "LUA") and (SERVER and file.Size(pth2, "LUA") > 5 or CLIENT) then
				A_AM.ActMod.reFix_limpg = true
				include( pth2 )
			end
		end
	end
end)

timer.Create( "aa_AuioChn_aoutfitter",12,1,function()
	local pth = "outfitter/sh.lua"
	if file.Exists(pth, "LUA") and (SERVER and file.Size(pth, "LUA") > 5 or CLIENT) then
		A_AM.ActMod.reFix_outfitter = true
		include( "actmod/refix/a_outfitter.lua" )
	end
end)

A_AM.ActMod.reFix_Base_Done = true