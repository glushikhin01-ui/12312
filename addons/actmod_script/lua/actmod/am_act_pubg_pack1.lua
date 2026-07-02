if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
if not A_AM.ActMod.AdScrpt then A_AM.ActMod.AdScrpt = {} end

local AAEffect = A_AM.ActMod.aTabDa_RunCyc["AAEffect"]
local AASond = A_AM.ActMod.aTabDa_RunCyc["AASond"]
local aSGetInfoPl = A_AM.ActMod.aTabDa_RunCyc["aSGetInfoPl"]
local aSizeRp = A_AM.ActMod.aTabDa_RunCyc["aSizeRp"]
local aAlight = A_AM.ActMod.aTabDa_RunCyc["aAlight"]
local aTAlight = A_AM.ActMod.aTabDa_RunCyc["aTAlight"]

if CLIENT then
	local avidis = GetConVarNumber("actmod_cl_viewdis")
	local function aDist(pl,taa)
		if pl == LocalPlayer() or LocalPlayer():GetPos():Distance(pl:GetPos()) < taa then
			return true
		end
		return false
	end


	local function GFram(Fram,a1,a2,a3)
		Fram = Fram[4]
		if Fram >= a1 and (a2 and Fram <= a2 or a3 and Fram <= (a1 + a3)) then
			return true
		end
		return false
	end
	
	local function aScrpt(pl,cyc,Fram)
		if not pl.AActNFfct then pl.AActNFfct = 0 end
		if aDist(pl,avidis/6) then
			if GFram(Fram,65,nil,4) then AAEffect( 1,0.4,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_R_Hand"}} ) pl.AActNFfct = 1 end
			if GFram(Fram,78,nil,4) and pl.AActNFfct > 0 then AAEffect( 2,0.4,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_L_Hand"}} ) end
			if GFram(Fram,91,nil,4) and pl.AActNFfct > 0 then AAEffect( 1,0.4,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_R_Hand" ,["PoS"] = {0,0,0,0}} } ) end
			if GFram(Fram,103,nil,4) and pl.AActNFfct > 0 then AAEffect( 2,0.4,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_L_Hand"}} ) end
			if GFram(Fram,200,500) and pl.AActNFfct > 0 then pl.AActNFfct = 2 end
			if GFram(Fram,524,nil,4) and pl.AActNFfct > 1 then AAEffect( 1,0.4,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_R_Hand"}} ) end
			if GFram(Fram,534,nil,4) and pl.AActNFfct > 1 then AAEffect( 2,0.4,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_L_Hand"}} ) end
			if GFram(Fram,547,nil,4) and pl.AActNFfct > 1 then AAEffect( 1,0.4,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_R_Hand" ,["PoS"] = {0,0,0,0}} } ) end
			if GFram(Fram,561,nil,4) and pl.AActNFfct > 1 then AAEffect( 2,0.4,pl,{[1] = {["nam"] = "am_f_kpop_04_e4" ,["Bone"] = "ValveBiped.Bip01_L_Hand"}} ) end
		end
	end
	A_AM.ActMod.AdScrpt["amod_pubg_tocatoca"] = aScrpt
	A_AM.ActMod.AdScrpt["kpop_04"] = aScrpt

end

