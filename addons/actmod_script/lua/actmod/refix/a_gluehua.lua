if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
if A_AM.ActMod.reFix_gluehua then

	if glue and type(glue.HandleUpdateAnimationHooks) == "function" then
		function glue:HandleUpdateAnimationHooks()
			local aR = "!!!!!!!!!0".. tostring( A_AM.ActMod.Sutep_DoneR )
			local hooks = hook.GetTable()
			for k, v in pairs( hooks.UpdateAnimation ) do
				if k ~= "Glue:UpdateAnimation" and k ~= aR.."ActMod_SlowDownAnim" then
					self.UpdateAnimationStack[k] = hooks.UpdateAnimation[k]
					hook.Remove( "UpdateAnimation", k )
				end
			end
		end
		A_AM.ActMod:RemoveAllhook("UpdateAnimation", "ActionExtension:UpdateAnimation")
	end

	A_AM.ActMod.reFix_gluehua_Done = true
end

A_AM.ActMod.reFix_gluehua_OK = true