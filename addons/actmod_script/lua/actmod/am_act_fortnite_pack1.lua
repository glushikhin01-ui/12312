if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
if not A_AM.ActMod.AdScrpt then A_AM.ActMod.AdScrpt = {} end
if SERVER then return end

local s = "actmod/i_act/am4/"
local AAEffect = A_AM.ActMod.aTabDa_RunCyc["AAEffect"]
local AASond = A_AM.ActMod.aTabDa_RunCyc["AASond"]
local aSGetInfoPl = A_AM.ActMod.aTabDa_RunCyc["aSGetInfoPl"]
local aSizeRp = A_AM.ActMod.aTabDa_RunCyc["aSizeRp"]
local aAlight = A_AM.ActMod.aTabDa_RunCyc["aAlight"]
local aTAlight = A_AM.ActMod.aTabDa_RunCyc["aTAlight"]
local aSetSubMat = A_AM.ActMod.aTabDa_RunCyc["aSetSubMat"]

local avidis = GetConVarNumber("actmod_cl_viewdis")
local function aDist(pl,taa)
	if pl == LocalPlayer() or LocalPlayer():GetPos():Distance(pl:GetPos()) < taa then
		return true
	end
	return false
end

A_AM.ActMod.AdScrpt["amod_fortnite_bluephoto"] = function(pl,cyc,Fram)
	if cyc >= 0.65797102451324 and cyc <= 0.80579710006714 and aDist(pl,avidis/6) then
		AAEffect( 1,0.05,pl,{[1] = {["nam"] = "am_f_blueph" ,["Bone"] = "ValveBiped.Bip01_L_Hand",["Entity"] = true}} )
	end
end

A_AM.ActMod.AdScrpt["amod_cumact_fortnite_hi_five_s1"] = function(pl,cyc,Fram)
	if cyc >= 0.401 and cyc <= 0.44 and aDist(pl,avidis/5) then
		AAEffect( 1,1,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_R_Hand",["PoS"] = {4,-2,0,5} ,["Entity"] = pl}} )
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_kpopdance_04"] = function(pl,cyc,Fram)
	if cyc >= 0.02 and cyc <= 0.057677615433931 then AAEffect( 1,0.05,pl,{[1] = {["nam"] = "am_f_kpop_04_e1" ,["Bone"] = "ValveBiped.Bip01_L_Hand"}} ) end
	if cyc >= 0.085943467915058 and cyc <= 0.14935064315796 then AAEffect( 1,0.05,pl,{[1] = {["nam"] = "am_f_kpop_04_e1" ,["Bone"] = "ValveBiped.Bip01_R_Hand"}} ) end
	if cyc >= 0.19213140010834 and cyc <= 0.2158135920763 then AAEffect( 2,0.9,pl,{[1] = {["nam"] = "am_f_kpop_04_e2" ,["Bone"] = "ValveBiped.Bip01_Head1" ,["PoS"] = {0,0,0,28}} } ) end
	if cyc >= 0.25630253553391 and cyc <= 0.29144385457039 then AAEffect( 1,0.05,pl,{[1] = {["nam"] = "am_f_kpop_04_e1" ,["Bone"] = "ValveBiped.Bip01_R_Hand"},[2] = {["nam"] = "am_f_kpop_04_e1" ,["Bone"] = "ValveBiped.Bip01_L_Hand"}} ) end
	if cyc >= 0.45492741465569 and cyc <= 0.49159663915634 then AAEffect( 1,0.02,pl,{[1] = {["nam"] = "am_f_kpop_04_e1" ,["Bone"] = "ValveBiped.Bip01_R_Hand"}} ) end
	if cyc >= 0.55347591638565 and cyc <= 0.58632546663284 then AAEffect( 1,0.05,pl,{[1] = {["nam"] = "am_f_kpop_04_e1" ,["Bone"] = "ValveBiped.Bip01_R_Hand"},[2] = {["nam"] = "am_f_kpop_04_e1" ,["Bone"] = "ValveBiped.Bip01_L_Hand"}} ) end
	if cyc >= 0.72 and cyc <= 0.829 then AAEffect( 1,0.006,pl,{[1] = {["nam"] = "am_f_kpop_04_e3" ,["Bone"] = "ValveBiped.Bip01_R_Hand"}} ) end
	if cyc >= 0.829 and cyc <= 0.85446906089783 then AAEffect( 2,0.7,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_R_Hand" ,["PoS"] = {0,0,0,5}}} ) end
end

A_AM.ActMod.AdScrpt["amod_fortnite_easternbloc"] = function(pl,cyc,Fram)
	if cyc >= 0.44419133663177 and cyc <= 0.44881588220596 then AASond( 3,0.3,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 70 } ) end
	if cyc >= 0.47835990786552 and cyc <= 0.48319327831268 then AASond( 3,0.3,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 70 } ) end
	if cyc >= 0.51252847909927 and cyc <= 0.51604276895523 then AASond( 3,0.3,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 70 } ) end
	if cyc >= 0.82232344150543 and cyc <= 0.82543927431107 then AASond( 3,0.3,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 70 } ) end
	if cyc >= 0.87015944719315 and cyc <= 0.87356758117676 then AASond( 3,0.3,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 70 } ) end
	if cyc >= 0.92255127429962 and cyc <= 0.92551565170288 then AASond( 3,0.3,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 70 } ) end
end

A_AM.ActMod.AdScrpt["amod_fortnite_golfclap"] = function(pl,cyc,Fram)
	Fram = Fram[4]
	if Fram >= 21 and Fram <= 23 then AASond( 3,0.5,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 60 } ) end
	if Fram >= 39 and Fram <= 41 then AASond( 3,0.5,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 60 } ) end
	if Fram >= 59 and Fram <= 61 then AASond( 3,0.5,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 60 } ) end
	if Fram >= 77 and Fram <= 79 then AASond( 3,0.5,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 60 } ) end
	if Fram >= 97 and Fram <= 100 then AASond( 3,0.5,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 60 } ) end
	if Fram >= 114 and Fram <= 115 then AASond( 3,0.5,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 60 } ) end
end

local function aScrpt(pl,cyc,Fram)
	Fram = Fram[4]
	if Fram >= 10 and Fram <= 15 then AASond( 3,0.5,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 60 } ) end
	if Fram >= 71 and Fram <= 76 then AASond( 3,0.5,pl,{["Sound"] = s.."sondclaph.mp3" ,["Volume"] = 60 } ) end
end
A_AM.ActMod.AdScrpt["amod_fortnite_dancemoves"] = aScrpt
A_AM.ActMod.AdScrpt["amod_fortnite_dancemoves2"] = aScrpt

A_AM.ActMod.AdScrpt["amod_fortnite_boomer"] = function(pl,cyc,Fram)
	Fram = Fram[4]
	if not pl.AActNFfct then pl.AActNFfct = 0 end
	if Fram >= 4 and Fram <= 7 and pl.AActNFfct == 0 then AAEffect( 1,0.1,pl,{[1] = { ["nam"] = "am_f_baom_1" ,["Bone"] = "ValveBiped.Bip01_Pelvis" ,["PoS"] = {10,-20,0,15} }} ,avidis/3 ) pl.AActNFfct = 1 end
	if Fram >= 18 and Fram <= 21 and pl.AActNFfct == 1 then AAEffect( 1,0.1,pl,{[1] = { ["nam"] = "am_f_baom_2" ,["Bone"] = "ValveBiped.Bip01_Pelvis" ,["PoS"] = {10,20,0,20} }} ,avidis/3 ) pl.AActNFfct = 2 end
	if Fram >= 35 and Fram <= 38 and pl.AActNFfct == 2 then AAEffect( 1,0.1,pl,{[1] = { ["nam"] = "am_f_baom_3" ,["Bone"] = "ValveBiped.Bip01_Head1" ,["PoS"] = {10,-10,0,10} }} ,avidis/3 ) pl.AActNFfct = 3 end
	if Fram >= 117 and Fram <= 120 and pl.AActNFfct == 3 then AAEffect( 1,0.1,pl,{[1] = { ["nam"] = "am_f_baom_1" ,["Bone"] = "ValveBiped.Bip01_Pelvis" ,["PoS"] = {10,-20,0,15} }} ,avidis/3 ) pl.AActNFfct = 4 end
	if Fram >= 133 and Fram <= 136 and pl.AActNFfct == 4 then AAEffect( 1,0.1,pl,{[1] = { ["nam"] = "am_f_baom_2" ,["Bone"] = "ValveBiped.Bip01_Pelvis" ,["PoS"] = {10,20,0,20} }} ,avidis/3 ) pl.AActNFfct = 5 end
	if Fram >= 152 and Fram <= 155 and pl.AActNFfct == 5 then AAEffect( 1,0.1,pl,{[1] = { ["nam"] = "am_f_baom_3" ,["Bone"] = "ValveBiped.Bip01_Head1" ,["PoS"] = {10,-2,0,15} }} ,avidis/3 ) pl.AActNFfct = 0 end
end

A_AM.ActMod.AdScrpt["amod_fortnite_jadetowel_gloss"] = function(pl,cyc,Fram)
	Fram = Fram[4]
	if not pl.AActNFfct then pl.AActNFfct = 0 end
	if Fram >= 13 and Fram <= 17 and pl.AActNFfct == 0 then AAEffect( 1,0.5,pl,{[1] = { ["nam"] = "am_f_jgloss_num" ,["Mdl"] = pl,["Entity"] = pl ,["Bone"] = "ValveBiped.Bip01_Head1" ,["PoS"] = {0,0,0,21} ,["Scale"] = 1 }} ,avidis/3 ) pl.AActNFfct = 1 end
	if Fram >= 47 and Fram <= 50 and pl.AActNFfct == 1 then AAEffect( 1,0.5,pl,{[1] = { ["nam"] = "am_f_jgloss_num" ,["Mdl"] = pl,["Entity"] = pl ,["Bone"] = "ValveBiped.Bip01_Head1" ,["PoS"] = {0,0,0,21} ,["Scale"] = 2 }} ,avidis/3 ) pl.AActNFfct = 2 end
	if Fram >= 86 and Fram <= 90 and pl.AActNFfct == 2 then AAEffect( 1,0.5,pl,{[1] = { ["nam"] = "am_f_jgloss_num" ,["Mdl"] = pl,["Entity"] = pl ,["Bone"] = "ValveBiped.Bip01_Head1" ,["PoS"] = {0,0,0,21} ,["Scale"] = 3 }} ,avidis/3 ) pl.AActNFfct = 3 end
	if Fram >= 163 and Fram <= 280 and (pl.AActNFfct == 3 or pl.AActNFfct == 4) then AAEffect( 2,0.6,pl,{[1] = { ["nam"] = "am_f_jgloss_wev" ,["Mdl"] = pl,["Entity"] = pl ,["Bone"] = "ValveBiped.Bip01_Pelvis" ,["PoS"] = {0,0,0,15} }} ,avidis/3 ) pl.AActNFfct = 4 end
	if Fram >= 290 and Fram <= 311 and pl.AActNFfct == 4 then pl.AActNFfct = 0 end
end

A_AM.ActMod.AdScrpt["amod_fortnite_metronome"] = function(pl,cyc,Fram)
	Fram = Fram[4]
	if Fram >= 110 and Fram <= 112 then AASond( 3,0.5,pl,{["Sound"] = s.."fortnite/Emote_Metronom_SFX.mp3" ,["Volume"] = 60 } ) end
end

local function aScrpt(pl,cyc,Fram)
	Fram = Fram[4]
	if Fram >= 75 and Fram <= 80 then AASond( 3,1.5,pl,{["Sound"] = s.."fortnite/Emote_Reverie_SFX.mp3" ,["Volume"] = 76 } ) end
end
A_AM.ActMod.AdScrpt["amod_fortnite_reverie"] = aScrpt
A_AM.ActMod.AdScrpt["amod_fortnite_reverie_mirror"] = aScrpt

A_AM.ActMod.AdScrpt["amod_fortnite_triumphant"] = function(pl,cyc,Fram)
	Fram = Fram[4]
	if not pl.aCSound2 and Fram >= 0 and Fram <= 3 then
		AASond( 3,0.5,pl,{["Sound"] = s.."fortnite/Emote_Triumphant_Foley.mp3" ,["Volume"] = 75 } )
		pl.aCSound2 = true
	elseif pl.aCSound2 and Fram >= 50 then
		pl.aCSound2 = nil
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_cerealbox"] = function(pl,cyc,Fram)
	Fram = Fram[3]
	if not pl.AActNFfct then pl.AActNFfct = 0 end
	if Fram >= 13 and Fram <= 15 and pl.AActNFfct == 0 then
		if pl.AAct_mdl1 and IsValid(pl.AAct_mdl1) then AAEffect( 2,0.5,pl,{[1] = {["nam"] = "am_f_cerealbox" ,["Mdl"] = pl.AAct_mdl1 ,["Bone"] = 0 ,["PoS"] = {0,0,0,-5}}} ) end
		pl.AActNFfct = 1
	end
	if pl.AActNFfct == 1 then
		if Fram >= 51 and Fram <= 80 then AAEffect( 1,0.1,pl,{[1] = {["nam"] = "am_f_1cerealbox" ,["Bone"] = "ValveBiped.Bip01_R_Hand" ,["PoS"] = {6,-9,0,0}}} ) end
		if Fram >= 92 and Fram <= 120 then AAEffect( 1,0.3,pl,{[1] = {["nam"] = "am_f_1cerealbox" ,["Bone"] = "ValveBiped.Bip01_Head1" ,["PoS"] = {6,0,0,-2}}} ) end
		if Fram >= 146 and Fram <= 189 then AAEffect( 1,0.2,pl,{[1] = {["nam"] = "am_f_2cerealbox" ,["Bone"] = "ValveBiped.Bip01_R_Hand" ,["PoS"] = {4,-5,8,0}}} ) end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_adoration"] = function(pl,cyc,Fram)
	local model1,model2
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if pl.AAct_mdl2 then model2 = pl.AAct_mdl2 end
	if model1 and model2 then
		local time = pl:SequenceDuration(pl:LookupSequence(pl.actmodstr))
		if not model1.tr_1 then
			model1.tr_1 = 1 model1.tHide = true model2.tHide = true
			model1.tsize = pl.AAct_Tmdl1["size"]
			model2.tsize = pl.AAct_Tmdl2["size"]
			pl.AAct_Tmdl1["size"] = 0.1
			pl.AAct_Tmdl2["size"] = 0.1
		end
		if cyc >= 0.48329958319664 and cyc <= 0.54278075695038 then
			if model1.tr_1 and  model1.tr_1 == 1 then model1.tr_1 = 2
				model1.tHide = nil model2.tHide = nil
				local pos_,px,py,pz = pl:GetBonePosition( pl:LookupBone("ValveBiped.Bip01_L_Hand") ) ,0,0,0
				local ef_ = EffectData() ef_:SetOrigin( pos_ + pl:GetForward()*px + pl:GetRight()*py + pl:GetUp()*pz ) util.Effect("am_f_adoration1",ef_)
			end
			if cyc >= 0.54 then
				if not model1.Eff_1 then model1.Eff_1 = true
					local ef_ = EffectData() ef_:SetEntity(pl) ef_:SetOrigin( pl:GetBonePosition( pl:LookupBone("ValveBiped.Bip01_L_Hand") ) ) util.Effect("am_f_adoration2",ef_)
				else
					if pl.AAct_Tmdl1["size"] > 0.1 then
						pl.AAct_Tmdl1["size"] = pl.AAct_Tmdl1["size"]-model1.tsize*0.05
					end
				end
			else
				pl.AAct_Tmdl1["size"] = math.min(pl.AAct_Tmdl1["size"]+model1.tsize*0.015,model1.tsize)
			end
			if cyc >= 0.5236821770668 then
				model2.tHide = true
				if not model2.Eff_1 then model2.Eff_1 = true
					local ef = EffectData() ef:SetEntity(pl) util.Effect("am_f_adoration3",ef)
				end
			else
				pl.AAct_Tmdl2["size"] = math.min(pl.AAct_Tmdl2["size"]+model2.tsize*0.01,model2.tsize)
			end
		elseif model1 and model2 and cyc >= 0.54278075695038 then
			model1.tHide = true model2.tHide = true
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_chairtime"] = function(pl,cyc,Fram)
	local model1,model2
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if pl.AAct_mdl2 then model2 = pl.AAct_mdl2 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if not model1.ra_1 then model1.ra_1 = true model1:ResetSequence( "Amod_Fortnite_ChairTime" ) end
		model1:SetCycle( cyc )
		if cyc >= 0.0020533881615847 then
			if model2 then
				local bone1 = model1:LookupBone("attack")
				if bone1 then
					local position, angles = model1:GetBonePosition(bone1)
					model2:SetPos( position )
					model2:SetAngles(angles)
				end
				if cyc >= 0.010266940109432 then
					if model2.tr_1 and model2.tr_1 == 1 then model2.tr_1 = 2 model2.tHide = nil model2.tr_S = CurTime()
						AAEffect( 2,0.5,pl,{[1] = {["nam"] = "am_f_poki_e2" ,["Mdl"] = model2 ,["Bone"] = 0 ,["PoS"] = {0,0,0,0}}} )
					end
					if model2.tsize then pl.AAct_Tmdl2["size"] = math.Remap(math.min(cyc-0.010266940109432,0.02),0,0.02,0,model2.tsize) end
				end
			end
		end
		if cyc < 0.01 and model2 and not model2.tr_1 then
			model2.tr_1 = 1 model2.tHide = true
			model2.tsize = pl.AAct_Tmdl2["size"]
			pl.AAct_Tmdl2["size"] = 0.001
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_iconic"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if cyc >= 0.055 then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil model1.tr_S = CurTime()
				AAEffect( 2,0.5,pl,{[1] = {["nam"] = "am_f_poki_e2" ,["Mdl"] = model1 ,["Bone"] = 0 ,["PoS"] = {0,0,0,5}}} )
			end
			if model1.tsize then pl.AAct_Tmdl1["size"] = math.Remap(math.min(cyc-0.055,0.01),0,0.01,model1.tsize*1.1,model1.tsize) end
		elseif cyc >= 0.032 then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil model1.tr_S = CurTime()
				AAEffect( 2,0.5,pl,{[1] = {["nam"] = "am_f_poki_e2" ,["Mdl"] = model1 ,["Bone"] = 0 ,["PoS"] = {0,0,0,5}}} )
			end
			if model1.tsize then pl.AAct_Tmdl1["size"] = math.Remap(math.min(cyc-0.032,0.02),0,0.02,0,model1.tsize*1.1) end
		end
		if cyc < 0.01 and model1 and not model1.tr_1 then
			model1.tr_1 = 1 model1.tHide = true
			model1.tsize = pl.AAct_Tmdl1["size"]
			pl.AAct_Tmdl1["size"] = 0.001
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_indigoapple"] = function(pl,cyc,Fram)
	local model1,model2
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if pl.AAct_mdl2 then model2 = pl.AAct_mdl2 end
	if model1 and model2 then
		if not model1.tr_1 then model1.tHide = true end
		if not model1.ra_1 then model1.ra_1 = true model1:ResetSequence( "emote_PropIndigoApple" ) end
		model1:SetCycle( cyc )
		if cyc >= 0.79793733358383 then
			if model2.tr_1 and model2.tr_1 == 1 then model2.tr_1 = 2 model2.tHide = nil model2.tt_eff_1 = 0 end
			if model2.tt_eff_1 == 0 and cyc >= 0.799 then model2.tt_eff_1 = 1
				AAEffect( 2,0.5,pl,{[1] = {["nam"] = "am_f_poki_e1" ,["Mdl"] = model2 ,["Bone"] = 0 ,["PoS"] = {0,0,0,2}}} )
			end
			if model2.tsize then pl.AAct_Tmdl2["size"] = math.min(pl.AAct_Tmdl2["size"]+model2.tsize*FrameTime()*2,model2.tsize) end
			if cyc < 0.96 then
				local bone1 = model1:LookupBone("attack")
				if bone1 then
					local position, angles = model1:GetBonePosition(bone1)
					model2:SetPos( position )
					model2:SetAngles(angles)
				end
				if model2.tt_eff_1 == 1 and cyc >= 0.89648586511612 and cyc >= 0.92245990037918 and (model1.TrAim or 0) < CurTime() then model2.tt_eff_1 = 2 model1.TrAim = CurTime() + 0.5
					AAEffect( 2,0.5,pl,{[1] = {["nam"] = "am_f_poki_e2" ,["Mdl"] = model2 ,["Bone"] = 0 ,["PoS"] = {-2,1.3,0,3.5}}} )
				end
			else
				if model2.tsize then pl.AAct_Tmdl2["size"] = math.max(pl.AAct_Tmdl2["size"]-model2.tsize*FrameTime()*7,0.01) end
			end
			if model2.tt_eff_1 == 2 and cyc >= 0.95 and (model1.TrAim or 0) < CurTime() then model2.tt_eff_1 = 3 model1.TrAim = CurTime() + 0.7
				AAEffect( 2,0.5,pl,{[1] = {["nam"] = "am_f_poki_e3" ,["Mdl"] = model2 ,["Bone"] = 0 ,["PoS"] = {0,0,0,0}}} )
			end
		else
			if model2.tr_1 and model2.tr_1 == 2 then model2.tr_1 = 1 model2.tHide = true end
		end
		if cyc < 0.01 and model2 and not model2.tr_1 then
			model2.tr_1 = 1 model2.tHide = true
			model2.tsize = pl.AAct_Tmdl2["size"]
			pl.AAct_Tmdl2["size"] = 0.01
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_hoist"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if not model1.ra_1 then model1.ra_1 = true model1:ResetSequence( "Emote_Hoist_CMM_Prop" ) end
		if not model1.tHide then model1:SetCycle( cyc ) else model1:SetCycle( 0 ) end
		if cyc > 0.002 then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil
				A_AM.ActMod:C_StopSond(pl,"3")
				A_AM.ActMod:A_aSond(pl,s.."fortnite/amod_fortnite_hoist_efct.mp3","3",70,"0")
			end
			A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc,0.03),0,0.03,0,1) ,{8,9} )
			if cyc > 0.005 then
				if not model1.tff_1 then model1.tff_1 = true
					A_AM.ActMod:adEfFull( model1,"am_f_poki_e2" ,{8,9} )
				end
			end
			if cyc > 0.022 then
				if not model1.tff_2 then model1.tff_2 = true
					A_AM.ActMod:adEfFull( model1,"am_f_hoist" ,nil,{0,1,2,3,4,8,9} )
				end
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc,0.03),0,0.03,0,1) ,nil,{0,1,2,8,9} )
			end
		end
		if not model1.tr_1 then
			model1.tr_1 = 1 model1.tHide = true
			A_AM.ActMod:cBonesScale( model1,Vector( 0, 0, 0) ,nil,{0,1,2} )
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_troops"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if not model1.ra_1 then model1.ra_1 = true model1:ResetSequence( "Troops_Gadget" ) end
		model1:SetCycle( cyc )
		if cyc > 0.002 then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil
			end
			if cyc > 0.71617162227631 then
				if model1.Aasize then
					A_AM.ActMod:aBonesScale( model1,2,0,0 ,{13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31} )
					if cyc > 0.92409241199493 then
						if model1.tsize and pl.AAct_Tmdl1["size"] > 0.01 then
							pl.AAct_Tmdl1["size"] = math.Remap(math.min(cyc-0.92409241199493,0.02),0,0.02,model1.tsize,0)
						end
					end
				end
				if cyc > 0.9744079709053 and model1.tr_1 and model1.tr_1 == 2 then
					model1.tr_1 = 1 model1.tHide = true
					model1.Aasize = {[1] = 0.001,[2] = 0.001}
					pl.AAct_Tmdl1["size"] = model1.tsize
					A_AM.ActMod:aBonesScale( model1,1,0,-1 ,{1,2,3,4,5,6,7,8,9,10,11,12} )
				end
			else
				if model1.Aasize then
					if cyc > 0.16501650214195 then
						A_AM.ActMod:aBonesScale( model1,2,1,0 ,{13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31} )
					else
						A_AM.ActMod:aBonesScale( model1,2,0,0 ,{13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31} )
					end
					A_AM.ActMod:aBonesScale( model1,1,1,-1 ,nil,{0,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31} )
				end
				if model1.tsize and pl.AAct_Tmdl1["size"] ~= model1.tsize then
					pl.AAct_Tmdl1["size"] = math.min(pl.AAct_Tmdl1["size"]+6*FrameTime()*50,model1.tsize)
				end
			end
		end
		if not model1.tr_1 then
			model1.tr_1 = 1 model1.tHide = true
			model1.Aasize = {[1] = 0.001,[2] = 0.001}
			model1.tsize = pl.AAct_Tmdl1["size"]
			A_AM.ActMod:aBonesScale( model1,1,0,-1 ,{1,2,3,4,5,6,7,8,9,10,11,12} )
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_snowfall"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if not model1.ra_1 then model1.ra_1 = true model1:ResetSequence( "Emote_Snowfall" ) end
		model1:SetCycle( cyc )
		if cyc > 0.005 then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil end
			if cyc > 0.065 and cyc < 0.25 then
				A_AM.ActMod:adEfFull( model1,"am_f_sf_e1" ,{2},nil,nil,math.Round(math.Remap(math.min(cyc-0.065,0.17),0,0.17,10,0)) )
			end
			if cyc > 0.25 and not model1.tff_1 then model1.tff_1 = true
				A_AM.ActMod:adEfFull( model1,"am_f_sf_e2" ,{2} )
			end
			if cyc > 0.818 then
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.818,0.04),0,0.04,1,0) ,{3} )
			elseif cyc > 0.049 then
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.049,0.02),0,0.02,0,1) ,{3} )
			end
		end
		if not model1.tr_1 then
			model1.tr_1 = 1 model1.tHide = true model1.tf_1 = pl.AAct_Tmdl1["size"]
			A_AM.ActMod:cBonesScale( model1,Vector( 0, 0, 0) ,{3} )
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_selenecobra"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if not model1.ra_1 then model1.ra_1 = true
			model1:ResetSequence( "Emote_SeleneCobra" )
			model1:SetMaterial( "models/spawn_effect2" )
			A_AM.ActMod:C_StopSond(pl,"3")
			A_AM.ActMod:A_aSond(pl,s.."fortnite/Emote_SeleneCobr_SFX_Intro.mp3","3",70,"0")
		end
		model1:SetCycle( cyc )
		if cyc > 0.005 then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.ts_1 = 1 model1.tHide = nil end
			if cyc > 0.95867770910263 then
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.95867770910263,0.01),0,0.01,0,1) ,nil,{0,1,2} )
				if cyc > 0.99173551797867 and cyc < 0.9961 then
					A_AM.ActMod:adEfFull( model1,"am_f_poki_e2" ,{15} )
				end
				if model1.ts_1 == 2 then model1.ts_1 = 1 end
				if cyc > 0.9961 then
					if model1.tff_1 then model1.tff_1 = nil
						A_AM.ActMod:adEfFull( model1,"am_f_selene_2" ,{15} )
						A_AM.ActMod:cBonesScale( model1,Vector( 0, 0, 0) ,{14,15} )
					end
					A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.9961,0.01),0,0.01,1,0) ,nil,{0,1,2} )
				end
			elseif cyc > 0.0655 then
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.0655,0.015),0,0.015,1,0) ,nil,{0,1,2,14,15} )
				if model1.ts_1 == 1 then
					model1.ts_1 = 2 model1.tff_1 = nil
					A_AM.ActMod:C_StopSond(pl,"3")
					A_AM.ActMod:A_aSond(pl,s.."fortnite/Emote_SeleneCobra_SFX_Loop.mp3","3",76,"0")
				end
				if cyc < 0.1 and not model1.tff_1 then model1.tff_1 = true
					if model1.tr_1 == 2 then model1.tr_1 = 3 A_AM.ActMod:adEfFull( {model1,true},"am_f_selene_2" ,{15} ) end
					A_AM.ActMod:cBonesScale( model1,Vector( 0, 0, 0) ,{14,15} )
				end
			elseif cyc > 0.060 then
				if cyc > 0.067 then
					A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.067,0.015),0,0.015,1,0) ,nil,{0,1,2,14,15} )
				end
				if cyc > 0.062 and cyc < 0.071 then
					A_AM.ActMod:adEfFull( model1,"am_f_poki_e2" ,{15} )
				end
			elseif cyc > 0.025 then
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.025,0.015),0,0.015,0,1) ,nil,{0,1,2} )
			end
		end
		if cyc > 0.085 and cyc < 0.4 and not model1.tff_1 then model1.tff_1 = true
			A_AM.ActMod:cBonesScale( model1,Vector( 0, 0, 0) ,{14,15} )
		end
		if ((cyc > 0.037 and cyc < 0.075 or cyc > 0.962)) and (model1.aTrff or 0) < CurTime() then
			model1.aTrff = CurTime() + 0.1
			A_AM.ActMod:adEfFull( model1,"am_f_selene_1" ,nil,{0,1,2,3} )
		end
		if not model1.tr_1 then
			model1.tr_1 = 1 model1.tHide = true model1.tf_1 = pl.AAct_Tmdl1["size"]
			A_AM.ActMod:cBonesScale( model1,Vector( 0, 0, 0) ,nil,{0,1,2} )
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_blazerveil"] = function(pl,cyc,Fram)
	local model1,model2
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if pl.AAct_mdl2 then model2 = pl.AAct_mdl2 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if model2 and not model2.tr_1 then model2.tHide = true end
		if not model1.ra_1 then model1.ra_1 = true
			model1:ResetSequence( "BlazerVeil" )
			model1:SetBodygroup( 1, 1 )
			A_AM.ActMod:C_StopSond(pl,"3")
			local au = "ActMod_act_BlazerVeil_".. pl:EntIndex()
			if timer.Exists( au ) then timer.Remove( au ) end
			timer.Create(au,0.05,1,function() if IsValid(pl) then
				A_AM.ActMod:C_StopSond(pl,"3")
				A_AM.ActMod:A_aSond(pl,s.."fortnite/Emote_BlazerVeil_SFX_Intro.mp3","3",70,"0")
			end end)
		end
		model1:SetCycle( cyc )
		if cyc > 0.005 then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.ts_1 = 1 model1.tHide = nil end
			if model2 and model2.tr_1 and model2.tr_1 == 1 then model2.tr_1 = 2 model2.tHide = nil end
			if cyc > 0.025 then
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.025,0.015),0,0.015,0,1) ,nil,{0,1,2,7,8} )
				if cyc > 0.025 and not model1.tff_5 then model1.tff_5 = true A_AM.ActMod:adEfFull( {model1,true},"am_f_blveil_1" ,{3,4,5} ) end
			end
			if cyc > 0.19 then A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.19,0.015),0,0.015,0,1) ,{7} ) end
			if cyc > 0.04 then
				if model2 then A_AM.ActMod:cBonesScale( model2,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.04,0.015),0,0.015,0,1) ,{0} ) end
			end
			if cyc > 0.12 and not model1.sBody_1 then model1.sBody_1 = 1
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1) ,{8} )
				model1:SetBodygroup( 1, 1 )
				if model2 and not model2.sBody_rem then model2.sBody_rem = true
					model2:SetBodygroup( 0, 1 )
				end
			end
			if cyc > 0.125 and cyc < 0.22 and (model1.aTrff or 0) < CurTime() then
				if model1.fTr then model1.fTr = (model1.fTr + 0.1) else model1.fTr = 0 end
				model1.aTrff = CurTime() + (0.5 - math.Clamp(model1.fTr ,0.2,1))
				A_AM.ActMod:adEfFull( {model1,true},"am_f_blveil_2" ,{8} )
			end
			if cyc > 0.22 and model1.sBody_1 and model1.sBody_1 == 1 then model1.sBody_1 = 2
				model1:SetBodygroup( 1, 0 )
				A_AM.ActMod:adEfFull( model1,"am_f_blveil_3" ,{8} )
			end
			if cyc > 0.221 and (model1.afd or 0) < CurTime() then
				model1.afd = CurTime() + 0.55
				if aDist(model1,avidis/10) then
					A_AM.ActMod:adEfFull( {model1,true},"am_f_blveil_4" ,{7} )
				end
				aTAlight(1,0.1,pl,{
					[1] = {["Mdl"] = model1 ,["Bone"] = 7 ,["PoS"] = {7,0,0,0} ,["rgb"] = {math.random(0,255),math.random(0,255),math.random(0,255)} ,["brightness"] = 3 ,["decay"] = 10 ,["size"] = 43 ,["dietime"] = math.random(0.6,1)}
					,[2] = {["Mdl"] = model1 ,["Bone"] = 7 ,["PoS"] = {7,5,0,0} ,["rgb"] = {math.random(0,255),math.random(0,255),math.random(0,255)} ,["brightness"] = 3 ,["decay"] = 10 ,["size"] = 43 ,["dietime"] = math.random(0.6,1)}
					,[3] = {["Mdl"] = model1 ,["Bone"] = 7 ,["PoS"] = {7,-5,0,0} ,["rgb"] = {math.random(0,255),math.random(0,255),math.random(0,255)} ,["brightness"] = 3 ,["decay"] = 10 ,["size"] = 43 ,["dietime"] = math.random(0.6,1)}
				})
			end
			if false and cyc > 0.221 and (model1.afd111 or 0) < CurTime() then
				local propMatrix = model1:GetBoneMatrix(model1:LookupBone("JNT_safe"))
				if propMatrix then
					local Pos_1_RHand ,Ang_1_RHand = pl:GetBonePosition(pl:LookupBone("ValveBiped.Bip01_R_Hand"))
					local Pos_1 ,Ang_1 = pl:GetPos(),Ang_1_RHand
					local posOffset ,angOffset = Vector(0,0,0) ,Angle(0,0,0)
					local offsetPosWorld = Pos_1_RHand + Ang_1:Forward() * posOffset.x
														+ Ang_1:Right() * posOffset.y
														+ Ang_1:Up()    * posOffset.z
					local offsetAngWorld = Angle()
					offsetAngWorld:Set(Ang_1)
					offsetAngWorld:RotateAroundAxis(offsetAngWorld:Forward(), angOffset.pitch)
					offsetAngWorld:RotateAroundAxis(offsetAngWorld:Right(), angOffset.yaw)
					offsetAngWorld:RotateAroundAxis(offsetAngWorld:Up(), angOffset.roll)
					local propOrigin = propMatrix:GetTranslation()
					local propAngles = propMatrix:GetAngles()
					local localPos, localAng = WorldToLocal(offsetPosWorld,offsetAngWorld, propOrigin,propAngles)
					model1:ManipulateBonePosition(3, localPos)
				end
			end
		end
		if not model1.tr_1 and pl.AAct_Tmdl1 then
			model1.tr_1 = 1 model1.tHide = true model1.tf_1 = pl.AAct_Tmdl1["size"]
			A_AM.ActMod:cBonesScale( model1,Vector( 0, 0, 0) ,nil,{0,1,2} )
			A_AM.ActMod:C2BoneAniDistanceFunct( pl,model1 ,nil,nil,nil,nil ,function(entity_1,entity_2)
				if Sc1 then entity_1:SetModelScale( Sc1 ) end if Sc2 then entity_2:SetModelScale( Sc2 ) end
				local saq_1,saq_2,SCycle = "amod_fortnite_blazerveil","BlazerVeil" ,0.1229946538806
				entity_1:SetCycle( SCycle ) entity_1:SetPlaybackRate( 0 )
				entity_2:SetCycle( SCycle ) entity_2:SetPlaybackRate( 0 )
				local seq1_1 = entity_1:LookupSequence( saq_1 )
				local seq1_2 = entity_2:LookupSequence( saq_2 )
				local tab = {}
				if seq1_1 >= 0 and seq1_2 >= 0 then
					entity_1:ResetSequence(seq1_1) entity_1:SetCycle( SCycle ) entity_1:SetPlaybackRate( 0 )
					entity_2:ResetSequence(seq1_2) entity_2:SetCycle( SCycle ) entity_2:SetPlaybackRate( 0 )
					local PP_1_Hand,PP_2_Jsafe = entity_1:LookupBone("ValveBiped.Bip01_L_Hand"),entity_2:LookupBone("JNT_safe")
					local PP_2_Jball,PP_2_Jrmot = entity_2:LookupBone("JNT_discoball"),entity_2:LookupBone("JNT_remote")
					if PP_1_Hand and PP_2_Jsafe and PP_2_Jball and PP_2_Jrmot then
						local Pos_1 ,Ang_1 = entity_1:GetPos(),entity_1:GetAngles()
						local Pos_2 ,Ang_2 = entity_2:GetPos(),entity_2:GetAngles()
						local Pos_1_LHand ,Ang_1_LHand = entity_1:GetBonePosition(PP_1_Hand)
						local Pos_2_Jsafe ,Ang_2_Jsafe = entity_2:GetBonePosition(PP_2_Jsafe)
						local Pos_2_Jball ,Ang_2_Jball = entity_2:GetBonePosition(PP_2_Jball)
						tab["m2_up__JNT_safe"] = Vector(0,0,0):Distance( Vector(0,0,Pos_2_Jsafe.z) )
						tab["m2_right__JNT_safe"] = Vector(0,0,0):Distance( Vector(0,Pos_2_Jsafe.y,0) )
						tab["m1_up__L_Hand"] = Vector(0,0,0):Distance( Vector(0,0,Pos_1_LHand.z) )
						tab["m1_right__L_Hand"] = Vector(0,0,0):Distance( Vector(0,Pos_1_LHand.y,0) )
						tab["m__LHand-Jsafe"] = Pos_1_LHand:Distance( Pos_2_Jsafe )
						tab["m__LHand-Jball"] = Pos_1_LHand:Distance( Pos_2_Jball )
						tab["m_up_LHand-Jball"] = Vector(0,0,Pos_1_LHand.z):Distance( Vector(0,0,Pos_2_Jball.z) )
						if A_AM.ActMod:AA_SubMF( pl,"F" ) then
							tab["m2_up__JNT_safe"] = tab["m2_up__JNT_safe"] - 0.5
						end
						
						if propMatrix then
							local posOffset = Vector(-4,-13.6,-13.4) -- +Pos_b_7_p_1
							local angOffset = Angle(0,0,0)
							local offsetPosWorld = Pos_1_LHand + Ang_2:Forward() * posOffset.x + Ang_2:Right() * posOffset.y + Ang_2:Up() * posOffset.z
							local offsetAngWorld = Angle()
							offsetAngWorld:Set(Ang_2)
							offsetAngWorld:RotateAroundAxis(offsetAngWorld:Forward(), angOffset.pitch)
							offsetAngWorld:RotateAroundAxis(offsetAngWorld:Right(), angOffset.yaw)
							offsetAngWorld:RotateAroundAxis(offsetAngWorld:Up(), angOffset.roll)
							local propOrigin = propMatrix:GetTranslation()
							local propAngles = propMatrix:GetAngles()
							local localPos, localAng = WorldToLocal(offsetPosWorld,offsetAngWorld, propOrigin,propAngles)
							model1:ManipulateBonePosition(3, localPos)
						end
						
						local fixPos_1 = Vector( -tab["m2_right__JNT_safe"]*0.45+tab["m1_right__L_Hand"], -tab["m2_up__JNT_safe"]+tab["m1_up__L_Hand"]*0.738, 0 )
						model1:ManipulateBonePosition( 3, fixPos_1 )
						model1:ManipulateBonePosition( 8, fixPos_1 )
					end
					
				end
			end,nil,nil )
		end
		if model2 and not model2.tr_1 and pl.AAct_Tmdl2 then
			model2.tr_1 = 1 model2.tHide = true model2.tf_1 = pl.AAct_Tmdl2["size"]
			A_AM.ActMod:cBonesScale( model2,Vector( 0, 0, 0) ,nil,{1} )
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_chickenleg"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if not model1.ra_1 then model1.ra_1 = true model1:ResetSequence( "Emote_ChickenLeg" ) end
		model1:SetCycle( cyc )
		if cyc > 0.005 then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil end
			A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.005,0.011),0,0.011,0,1) ,{3} )
			if cyc > 0.014 then
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.014,0.02),0,0.02,0,1) ,{4,5} )
			end
		end
		if not model1.tr_1 then
			model1.tr_1 = 1 model1.tHide = true
			A_AM.ActMod:cBonesScale( model1,Vector( 0, 0, 0) ,{3,4,5} )
			model1:ManipulateBonePosition( 1, Vector( 0, 0, -0.05 ) )
			model1:ManipulateBonePosition( 3, Vector( -0.02, 0, -0.05 ) )
			timer.Create("A_AM.Mdl_2"..pl:EntIndex(),0.0,1,function() if IsValid( pl ) then
				local A_SubMF = A_AM.ActMod:AA_SubMF( pl,"F" )
				local dhRL = A_AM.ActMod:CBoneAniDistance( pl ,pl.actmodstr,0.4 ,"ValveBiped.Bip01_R_Hand","ValveBiped.Bip01_L_Hand" )
				local Tdmax = A_AM.ActMod:CBoneAniDistance( pl ,pl.actmodstr,0.4 ,"ValveBiped.Bip01_R_Hand","Vector()" ,true )
				local Umax = Tdmax["VectorUp_1-0"] or 0
				local Pelvis = A_AM.ActMod:CBoneAniDistance( pl ,pl.actmodstr,0.4 ,"ValveBiped.Bip01_Pelvis","Vector()" ,true )["VectorUp_1-0"] or 0
				local Umax2 = 0
				if pl:LookupBone("ValveBiped.Bip01_Spine1") then
					Umax2 = A_AM.ActMod:CBoneAniDistance( pl ,pl.actmodstr,0.4 ,"ValveBiped.Bip01_R_Hand","ValveBiped.Bip01_Spine1" ) or 0
					if A_SubMF then Umax2 = Umax2-21.262677322407 else Umax2 = Umax2-23.121914408198 end Umax2 = math.Round(Umax2*0.025,5)
				end
				if A_SubMF then
					dhRL = math.Round(dhRL-21.666,3)
					Pelvis = math.Round(Pelvis-33.924610137939,5)
				else
					dhRL = math.Round(dhRL-21.590,3)
					Pelvis = math.Round(Pelvis-34.483993530273,5)
				end
				dhRL = dhRL*0.1
				Pelvis = Pelvis*0.02
				model1:ManipulateBonePosition( 1, Vector( 0, Umax2*0.4+Pelvis, -pl.AAct_Tmdl1["size"]*0.0-(Umax*0.001)-Umax2-dhRL*0.0 ) )
				model1:ManipulateBonePosition( 2, Vector( 0, 0, -pl.AAct_Tmdl1["size"]*0.0182 ) )
			end end)
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_thrive"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if not model1.ra_1 then model1.ra_1 = true model1:ResetSequence( "Emote_Thrive" ) model1:SetCycle( cyc ) model1:SetPlaybackRate(pl:GetPlaybackRate()) end
		model1:SetCycle( cyc )
		if cyc > 0.01 then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil end
			A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.01,0.011),0,0.011,0,1) ,{4} )
			if cyc > 0.02 then
				A_AM.ActMod:cBonesScale( model1,Vector( 1, 1, 1)*math.Remap(math.min(cyc-0.02,0.02),0,0.02,0,1) ,{3} )
			end
		end
		if not model1.tr_1 then
			model1.tr_1 = 1 model1.tHide = true
			A_AM.ActMod:cBonesScale( model1,Vector( 0, 0, 0) ,{3,4} )
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_abstractmirror"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if cyc >= 0.13 then
			if cyc >= 0.717 then
				if model1.tr_1 and model1.tr_1 == 2 and cyc >= 0.839 then model1.tr_1 = 1 model1.tHide = true end
				if model1.tsize then pl.AAct_Tmdl1["size"] = math.Remap(math.min(cyc-0.717,0.08),0,0.08,model1.tsize,0) end
			else
				if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil end
				if model1.tsize then pl.AAct_Tmdl1["size"] = math.Remap(math.min(cyc-0.13,0.05),0,0.05,0,model1.tsize) end
			end
		else
			if not model1.tr_1 then
				model1.tr_1 = 1 model1.tHide = true
				model1.tsize = pl.AAct_Tmdl1["size"]
				pl.AAct_Tmdl1["size"] = 0.01
			end
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_intermission"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.tr_1 then model1.tHide = true end
		if cyc >= 0.02 and model1.tsize then
			if model1.tr_1 and model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil end
			if model1.tsize ~= pl.AAct_Tmdl1["size"] then
				pl.AAct_Tmdl1["size"] = math.Remap(math.min(cyc-0.02,0.02),0,0.02,0,model1.tsize)
				model1:ManipulateBonePosition( 0, Vector( 0, -(model1.tsize-pl.AAct_Tmdl1["size"])*13, 2) )
			end
			if model1.tff_1 then
				model1.tff_1 = false
				A_AM.ActMod:C_StopSond(pl,"3")
				A_AM.ActMod:A_aSond(pl,s.."fortnite/Intermission_SFX_Intro_02.mp3","3",76,"0")
			end
			if model1.tff_2 and cyc >= 0.03 then
				model1.tff_2 = false
				A_AM.ActMod:adEfFull( model1,"am_f_selene_1" )
			end
		else
			if not model1.tr_1 then
				model1.tr_1 = 1 model1.tHide = true
				model1.tff_1 = true model1.tff_2 = true
				model1.tsize = pl.AAct_Tmdl1["size"]
				pl.AAct_Tmdl1["size"] = 0.01
			end
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_handsup"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.ra_1 then model1.ra_1 = true model1:ResetSequence( "HandsUp_Prop" ) end
		if model1.tHide then model1:SetCycle( 0 ) else model1:SetCycle( cyc ) end
		if model1.tr_1 and cyc >= 0.005 then
			if model1.tr_1 == 1 then model1.tr_1 = 2 model1.tHide = nil
				A_AM.ActMod:adEfFull( model1,"am_f_handsup" ,{2,5,6,8} )
			end
			A_AM.ActMod:aBonesScale( model1,1,1,5 ,nil,{0,1} )
		end
		if not model1.tr_1 then
			model1.tr_1 = 1 model1.tHide = true
			model1.Aasize = {[1] = 0.001}
			A_AM.ActMod:aBonesScale( model1,1,0,0 ,nil,{0,1} )
		end
	end
end

A_AM.ActMod.AdScrpt["amod_fortnite_marionette1"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if not model1.ra_1 then model1.ra_1 = true model1:ResetSequence( "LeadGuitar_Prop" ) end
		model1:SetCycle( cyc )
		if not model1.tr_1 then model1.tr_1 = true
			local hmax2 = A_AM.ActMod:HMd( pl,"models/actmod/prop/marionette_lead_guitar_gadget.mdl" ,pl.actmodstr,"LeadGuitar_Prop",0 ,"ValveBiped.Bip01_R_Hand","JNT_global_guitar" )
			model1:ManipulateBonePosition( 3, Vector( 0, 0, (29.818155288696-hmax2[1])*0.01) )
		end
	end
end

local addTimReFClor = CurTime()
A_AM.ActMod.AdScrptPDraw["amod_fortnite_glowstickdance"] = function(pl,cyc ,model1,model2,model3,model4)
	local hue = (CurTime() * 60) % 360
	local Asz = pl:GetModelScale()
	if addTimReFClor < CurTime() then
		addTimReFClor = CurTime() + 0.1
		if model1 and IsValid(model1) and not model1.tHide then
			local mat = Material("models/actmod/glow")
			if mat then
				local t,s = CurTime(),1
				local col = HSVToColor(hue, 1, 1)
				local r = col.r / 255
				local g = col.g / 255
				local b = col.b / 255
				mat:SetVector("$color2", Vector(r, g, b) )
			end
		end
	end
	if not pl.actmod_cl_TmpDtEf or not istable(pl.actmod_cl_TmpDtEf) then pl.actmod_cl_TmpDtEf = {mat = Material("actmod/eff_particle/p_glow_02")} end
	if istable(pl.actmod_cl_TmpDtEf) and pl.actmod_cl_TmpDtEf.mat then
		local col = HSVToColor(hue, 1, 1)
		local r = col.r
		local g = col.g
		local b = col.b
		render.SetMaterial(pl.actmod_cl_TmpDtEf.mat)
		if model1 and IsValid(model1) and not model1.tHide and (pl == LocalPlayer() or LocalPlayer():trueShowMld(pl)) then
			render.DrawSprite(model1:GetPos() + model1:GetForward()*5*Asz, 10*Asz, 10*Asz, Color(r,g,b,150))
			aTAlight(1,0.01,pl,{
				[1] = {["Mdl"] = model1 ,["Bone"] = 7 ,["PoS"] = {5*Asz,0,0,0} ,["rgb"] = {r,g,b} ,["brightness"] = 3 ,["decay"] = 18*Asz ,["size"] = math.max(60*Asz,20) ,["dietime"] = 0.03}
			})
		end
		if model2 and IsValid(model2) and not model2.tHide and (pl == LocalPlayer() or LocalPlayer():trueShowMld(pl)) then
			render.DrawSprite(model2:GetPos() + model2:GetForward()*5*Asz, 10*Asz, 10*Asz, Color(r,g,b,150))
			aTAlight(2,0.01,pl,{
				[1] = {["Mdl"] = model2 ,["Bone"] = 7 ,["PoS"] = {5*Asz,0,0,0} ,["rgb"] = {r,g,b} ,["brightness"] = 3 ,["decay"] = 18*Asz ,["size"] = math.max(60*Asz,20) ,["dietime"] = 0.03}
			})
		end
	end
end

A_AM.ActMod.AdScrptPDraw["amod_cumact_fortnite_peerpencil"] = function(pl,cyc ,model1,model2,model3,model4)
	if model1 and model1.mat_1 and (pl == LocalPlayer() or LocalPlayer():trueShowMld(pl)) then
		local Asz = pl:GetModelScale()
		if model1.DTim_1 then
			if model1.Damv == 1 then
				local timov = math.Clamp( (CurTime() - model1.DTim_1)/0.15 ,0,1 )
				if timov >= 1 then
					model1.Damv = 2
					model1.Dalp_1 = 1
					model1.DTim_1 = CurTime()
				else
					model1.Dalp_1 = timov
				end
			elseif model1.Damv == 2 then
				local timov = math.Clamp( (CurTime() - model1.DTim_1)/0.2 ,1,0 )
				if timov >= 1 then
					model1.Damv = 0
					model1.Dalp_1 = 0
					model1.DTim_1 = nil
					model1.shw_1 = nil
					model1.shw_2 = nil
					model1.shw_3 = nil
					model1.shw_4 = nil
				else
					model1.Dalp_1 = timov
				end
			end
		end
		if model1.Dalp_1 > 0 then
			if model1.shw_1 then
				local PP_pos,PP_ang = model1:GetBonePosition(0)
				-- local a_pos = PP_pos + PP_ang:Forward()*2*Asz
				render.SetMaterial(model1.mat_1)
				render.DrawSprite(PP_pos, 10*Asz, 10*Asz, Color(255, 255, 225,150*model1.Dalp_1))
			end
			if model1.shw_2 and model2 then
				local PP_pos,PP_ang = model2:GetBonePosition(0)
				render.SetMaterial(model1.mat_1)
				render.DrawSprite(PP_pos, 10*Asz, 10*Asz, Color(255, 255, 225,150*model1.Dalp_1))
			end
			if model1.shw_3 and model3 then
				local PP_pos,PP_ang = model3:GetBonePosition(0)
				render.SetMaterial(model1.mat_1)
				render.DrawSprite(PP_pos, 15*Asz, 15*Asz, Color(255, 255, 225,150*model1.Dalp_1))
			end
			if model1.shw_4 and model4 then
				local PP_pos,PP_ang = model4:GetBonePosition(0)
				render.SetMaterial(model1.mat_1)
				render.DrawSprite(PP_pos, 15*Asz, 15*Asz, Color(255, 255, 225,150*model1.Dalp_1))
			end
		end
	end
end

A_AM.ActMod.AdScrpt["amod_cumact_fortnite_baskisle"] = function(pl,cyc,Fram)
	local model1
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if model1 then
		if model1.tr_1 and model1.stbaskisle and model1.Tsize then
			if not model1.FtDone then
				if model1.tHide then model1.tHide = nil end
				if cyc > 0.025 then
					pl.AAct_Tmdl1["size"] = model1.Tsize*math.Remap(math.min(cyc-0.025,0.06),0,0.06,0,1)
					if cyc > 0.025+0.06 then
						pl.AAct_Tmdl1["size"] = model1.Tsize
						model1.FtDone = true
						model1.sC = 0.18881118297577
					end
				end
			end
		end
		if not model1.tr_1 then
			model1.tr_1 = true model1.tHide = true model1.FtDone = false model1.stbaskisle = true
			model1.A_SubMF = A_AM.ActMod:AA_SubMF( pl,"F" )
			local hup = A_AM.ActMod:CBoneAniDistance( pl ,"drive_pd",0 ,"ValveBiped.Bip01_R_Foot","ValveBiped.Bip01_Head1" )
			local hupf = 1
			if model1.A_SubMF then
				hupf = 1+math.Round(hup- 58.49235534668,3)*0.02
			else
				hupf = 1+math.Round(hup- 60.565292358398,3)*0.02
			end
			model1.Tsize = pl.AAct_Tmdl1["size"]*hupf
			model1.A_hupf = hupf
			model1.A_hupfGMScale = hupf*pl:GetModelScale()
			pl.AAct_Tmdl1["size"] = 0
			-- pl.AAct_Tmdl1["pos_fo"] = -1.1
			-- pl.AAct_Tmdl1["pos_ri"] = 1.0
			-- pl.AAct_Tmdl1["pos_up"] = -2.7
			-- pl.AAct_Tmdl1["ang_p"] = -60
			-- pl.AAct_Tmdl1["ang_y"] = 45
			-- pl.AAct_Tmdl1["ang_r"] = 120
			if model1.A_SubMF then
				pl.AAct_Tmdl1.pos_fo = 2.5*model1.A_hupf
				pl.AAct_Tmdl1.pos_ri = -0.9*model1.A_hupf
				pl.AAct_Tmdl1.pos_up = 2*model1.A_hupf
			else
				pl.AAct_Tmdl1.pos_fo = 2.5*model1.A_hupf
				pl.AAct_Tmdl1.pos_ri = -0.6*model1.A_hupf
				pl.AAct_Tmdl1.pos_up = 2*model1.A_hupf
			end
			pl.AAct_Tmdl1.ang_p = 170
			pl.AAct_Tmdl1.ang_y = -15
			pl.AAct_Tmdl1.ang_r = 10
		end
	end
end

A_AM.ActMod.AdScrpt["amod_cumact_fortnite_bangthepan"] = function(pl,cyc,Fram)
	local model1,model2
	if pl.AAct_mdl1 then model1 = pl.AAct_mdl1 end
	if pl.AAct_mdl2 then model2 = pl.AAct_mdl2 end
	if model1 then
		if not model1.tr_1 then
			model1.tr_1 = true
			model1.A_SubMF = A_AM.ActMod:AA_SubMF( pl,"F" )
			local hup = A_AM.ActMod:CBoneAniDistance( pl ,"drive_pd",0 ,"ValveBiped.Bip01_R_Foot","ValveBiped.Bip01_Head1" )
			local hupf = 1
			if model1.A_SubMF then
				hupf = 1+math.Round(hup- 58.49235534668,3)*0.018
			else
				hupf = 1+math.Round(hup- 60.565292358398,3)*0.018
			end
			model1.Tsize = pl.AAct_Tmdl1["size"]*hupf
			model1.A_hupf = hupf
			pl.AAct_Tmdl1["size"] = pl.AAct_Tmdl1["size"]*hupf
			pl.AAct_Tmdl1.ang_p = 50
			pl.AAct_Tmdl1.ang_y = 140
			pl.AAct_Tmdl1.ang_r = 40
		end
		if model1.A_SubMF then
			pl.AAct_Tmdl1.pos_fo = -4*model1.A_hupf
			pl.AAct_Tmdl1.pos_ri = -0.3*model1.A_hupf
			pl.AAct_Tmdl1.pos_up = -2.5*model1.A_hupf
		else
			pl.AAct_Tmdl1.pos_fo = -4*model1.A_hupf
			pl.AAct_Tmdl1.pos_ri = -0.3*model1.A_hupf
			pl.AAct_Tmdl1.pos_up = -2.5*model1.A_hupf
		end
	end
	if model2 then
		if not model2.tr_1 then
			model2.tr_1 = true
			model2.A_SubMF = A_AM.ActMod:AA_SubMF( pl,"F" )
			local hup = A_AM.ActMod:CBoneAniDistance( pl ,"drive_pd",0 ,"ValveBiped.Bip01_R_Foot","ValveBiped.Bip01_Head1" )
			local hupf = 1
			if model2.A_SubMF then
				hupf = 1+math.Round(hup- 58.49235534668,3)*0.018
			else
				hupf = 1+math.Round(hup- 60.565292358398,3)*0.018
			end
			model2.A_hupf = hupf
			pl.AAct_Tmdl2["size"] = pl.AAct_Tmdl2["size"]*hupf
			pl.AAct_Tmdl2.ang_p = -90
			pl.AAct_Tmdl2.ang_y = 0
			pl.AAct_Tmdl2.ang_r = 95
		end
		if model2.A_SubMF then
			pl.AAct_Tmdl2.pos_fo = -1.8*model2.A_hupf
			pl.AAct_Tmdl2.pos_ri = 2.9*model2.A_hupf
			pl.AAct_Tmdl2.pos_up = -1.3*model2.A_hupf
		else
			pl.AAct_Tmdl2.pos_fo = -1.8*model2.A_hupf
			pl.AAct_Tmdl2.pos_ri = 2.9*model2.A_hupf
			pl.AAct_Tmdl2.pos_up = -1.3*model2.A_hupf
		end
	end
end




local function aRemovEff(TParticle)
	if TParticle and istable(TParticle) then
		for k, v in pairs( TParticle ) do v:SetDieTime( 0 ) v:SetLifeTime( 5 ) end
	end
end
local function arunStopE(pl)
	local TParticle = pl.actmod_cl_TParticle
	if istable(TParticle) then
		if TParticle[1] and istable(TParticle[1]) then aRemovEff(TParticle[1]) end
		if TParticle[2] and istable(TParticle[2]) then aRemovEff(TParticle[2]) end
		if TParticle[3] and istable(TParticle[3]) then aRemovEff(TParticle[3]) end
		if TParticle[4] and istable(TParticle[4]) then aRemovEff(TParticle[4]) end
	end
	pl.actmod_cl_TmpDtEf = nil
end
hook.Add("ActMod_RunStopAct", "stopEffectsCL", function(pl) arunStopE(pl) end)
hook.Add("ActMod_cl_RunaPlyEmot", "stopEffectsCL", function(pl) arunStopE(pl) end)
