-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

--Config GUI

local function tfaOptionWW2Server(panel)
	--Here are whatever default categories you want.
	local tfaOptionWW2SV = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_ww2k_server"
	}

	tfaOptionWW2SV.Options["#preset.default"] = {
		sv_tfa_codww2k_flamethrower_regen = "0",
		sv_tfa_codww2k_flamethrower_regendelay = "0.15",
		sv_tfa_codww2k_flamethrower_regendelayPaP = "0.05",
	}

	tfaOptionWW2SV.CVars = table.GetKeys(tfaOptionWW2SV.Options["#preset.default"])

	panel:AddControl("ComboBox", tfaOptionWW2SV)

	--These are the panel controls.  Adding these means that you don't have to go into the console.

	panel:Help("#tfa.settings.ww2k.flame")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.ww2k.flameregen", "sv_tfa_codww2k_flamethrower_regen", 0, 1, 0)
	TFA.NumSliderNet(panel, "#tfa.svsettings.ww2k.regenrate", "sv_tfa_codww2k_flamethrower_regendelay", 0.15, 1, 2)
	TFA.NumSliderNet(panel, "#tfa.svsettings.ww2k.regenratepap", "sv_tfa_codww2k_flamethrower_regendelayPaP", 0.05, 1, 2)
end

local function tfaOptionWW2Client(panel)
	--Here are whatever default categories you want.
	local tfaOptionWW2CL = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_ww2k_client"
	}

	tfaOptionWW2CL.Options["#preset.default"] = {
		cl_tfa_codww2k_dlights = "1",
	}

	tfaOptionWW2CL.CVars = table.GetKeys(tfaOptionWW2CL.Options["#preset.default"])

	panel:AddControl("ComboBox", tfaOptionWW2CL)

	--These are the panel controls.  Adding these means that you don't have to go into the console.
	panel:Help("#tfa.settings.ww2k.misc")
	
	panel:AddControl("CheckBox", {
		Label = "#tfa.clsettings.ww2k.dlight",
		Command = "cl_tfa_codww2k_dlights"
	})
	
end

local function tfaWW2AddOption()
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseWW2Server", "#tfa.smsettings.ww2k.server", "", "", tfaOptionWW2Server)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseWW2Client", "#tfa.smsettings.ww2k.client", "", "", tfaOptionWW2Client)
end

hook.Add("PopulateToolMenu", "tfaWW2AddOption", tfaWW2AddOption)