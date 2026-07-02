if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
if A_AM.ActMod.reFix_outfitter then

	if CLIENT then
		local function GetModelNamePath()
		  local model = LocalPlayer():GetModel()
		  if model == nil then model = LocalPlayer():GetModel() end
		  return model
		end

		hook.Add("OutfitApply", "ActMod_OutfitApply", function()
			net.Start("A_AM.ActMod.ClToSv_Tab",true)
			 net.WriteTable( {"ClToSv_aenforce_model",GetModelNamePath() or ""} )
			net.SendToServer()
		end)
	end
	
	A_AM.ActMod.reFix_outfitter_Done = true
end

A_AM.ActMod.reFix_outfitter_OK = true