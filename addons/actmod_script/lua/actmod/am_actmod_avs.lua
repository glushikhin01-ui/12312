if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaAvs = true
A_AM.ActMod.savTAVS = A_AM.ActMod.savTAVS or {}
local AGetMapNow = A_AM.ActMod.GGMap


if SERVER then
	local function GeAllO(ply, aai, AvsG, tsxt ,anz)
		if IsValid( ply ) and istable( ply.GetTable_Avs ) then
			if not anz then
				anz = tsxt == "QXZzX2EzXzc=" and 250 or 50
			end
			local tndx = "ActMod_Avs_ai_".. AvsG .."_" .. ply:EntIndex()
			if not ply.ActMod_Avs_ai_T then ply.ActMod_Avs_ai_T = {} end
			if not ply.ActMod_Avs_ai_T[AvsG] then
				ply.ActMod_Avs_ai_T[AvsG] = aai
			else
				ply.ActMod_Avs_ai_T[AvsG] = ply.ActMod_Avs_ai_T[AvsG] + aai
			end
			if timer.Exists( tndx ) then timer.Remove( tndx ) end
			if (ply.GetTable_Avs[AvsG]["ing"] + ply.ActMod_Avs_ai_T[AvsG]) >= anz and ply.GetTable_Avs[AvsG]["ok"] == "no" then
				ply.GetTable_Avs[AvsG]["ing"] = tonumber(ply.GetTable_Avs[AvsG]["ing"] + ply.ActMod_Avs_ai_T[AvsG])
				net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_",tsxt,"n"} ) net.Send(ply)
				ply.ActMod_Avs_ai_T[AvsG] = nil
			else
				timer.Create(tndx, 0.4, 1, function()
					if IsValid(ply) and istable( ply.GetTable_Avs ) and ply.ActMod_Avs_ai_T[AvsG] and ply.GetTable_Avs[AvsG] and ply.GetTable_Avs[AvsG]["ok"] == "no" then
						local ann0 = ply.GetTable_Avs[AvsG]["ing"] or 0
						local aa = ""
						ply.GetTable_Avs[AvsG]["ing"] = tonumber(ply.GetTable_Avs[AvsG]["ing"] + ply.ActMod_Avs_ai_T[AvsG])
						if ply.ActMod_Avs_ai_T[AvsG] and ply.ActMod_Avs_ai_T[AvsG] < anz and isnumber(ply.GetTable_Avs[AvsG]["ing"]) then
							aa = tostring(ply.GetTable_Avs[AvsG]["ing"])
						end
						net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_",tsxt,aa} ) net.Send(ply)
						local ann = ply.ActMod_Avs_ai_T[AvsG] or 1
						ply.ActMod_Avs_ai_T[AvsG] = nil
					end
				end)
			end
		end
	end

	function A_AM.ActMod.ActMod_Avs_SCNG(ply, a1, a2, a3)
		GeAllO(ply, 1, a1, a2, a3)
	end
	
	function A_AM.ActMod.ActMod_Avs_KNPC(npc, ply, inflictor)
		if IsValid( ply ) and ply:IsPlayer() and istable( ply.GetTable_Avs ) and IsValid( npc ) and npc:IsNPC() and inflictor and (IsValid(inflictor) and inflictor:IsPlayer() and inflictor == ply or not inflictor:IsPlayer()) then
			local pgaw = ply:GetActiveWeapon()
			if ply.GetTable_Avs["Avs_a2_3"] and ply.GetTable_Avs["Avs_a2_3"]["ok"] == "no" then
				if npc:GetClass() == "npc_combine_s" and npc:GetPos():Distance(ply:EyePos()) > 1570 and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_pistol" then
					net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EyXzM=","n"} ) net.Send(ply)
				end
			end
			if GetConVar("ai_disabled"):GetInt() == 0 and GetConVar("ai_ignoreplayers"):GetInt() == 0 then
				if ply.GetTable_Avs["Avs_a2_2"] and ply.GetTable_Avs["Avs_a2_2"]["ok"] == "no" then
					if npc:GetClass() == "npc_antlionguard" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_crowbar" then
						net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EyXzI=","n"} ) net.Send(ply)
					end
				end
				if ply.ActMod_TabTSrvr == 0 then
					if ply.GetTable_Avs["Avs_a1_1"] and ply.GetTable_Avs["Avs_a1_1"]["ok"] == "no" and ply.GetTable_Avs["Avs_a1_1"]["ing"] <= 50 then
						if npc:GetClass() == "npc_zombie" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_fists" then
							if ply.GetTable_Avs["Avs_a1_1"]["ing"] >= 50 then
								net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2ExXzE=","nil"} ) net.Send(ply)
							elseif ply.GetTable_Avs["Avs_a1_1"]["ing"] < 50 then
								GeAllO(ply, 1, "Avs_a1_1", "QXZzX2ExXzE=", 50)
							end
						end
					end
					if ply.GetTable_Avs["Avs_a4_2"] and ply.GetTable_Avs["Avs_a4_2"]["ok"] == "no" and ply.GetTable_Avs["Avs_a4_2"]["ing"] <= 100 then
						if npc:GetClass() == "npc_zombie" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_smg1" then
							if ply.GetTable_Avs["Avs_a4_2"]["ing"] >= 100 then
								net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2E0XzI=","nil"} ) net.Send(ply)
							elseif ply.GetTable_Avs["Avs_a4_2"]["ing"] < 100 then
								GeAllO(ply, 1, "Avs_a4_2", "QXZzX2E0XzI=", 100)
							end
						end
					elseif ply.GetTable_Avs["Avs_a3_7"] and ply.GetTable_Avs["Avs_a3_7"]["ok"] == "no" and ply.GetTable_Avs["Avs_a3_7"]["ing"] <= 250 then
						if npc:GetClass() == "npc_zombie" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_smg1" then
							if ply.GetTable_Avs["Avs_a3_7"]["ing"] >= 250 then
								net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EzXzc=","nil"} ) net.Send(ply)
							elseif ply.GetTable_Avs["Avs_a3_7"]["ing"] < 250 then
								GeAllO(ply, 1, "Avs_a3_7", "QXZzX2EzXzc=", 250)
							end
						end
					end
				end
				if ply.GetTable_Avs["Avs_a2_9"] and ply.GetTable_Avs["Avs_a2_9"]["ok"] == "no" and ply.GetTable_Avs["Avs_a2_9"]["ing"] <= 25 then
					if npc:GetClass() == "npc_manhack" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_stunstick" then
						if ply.GetTable_Avs["Avs_a2_9"]["ing"] >= 25 then
							net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EyXzk=","nil"} ) net.Send(ply)
						elseif ply.GetTable_Avs["Avs_a2_9"]["ing"] < 25 then
							GeAllO(ply, 1, "Avs_a2_9", "QXZzX2EyXzk=", 25)
						end
					end
				end
				if ply.GetTable_Avs["Avs_a2_8"] and ply.GetTable_Avs["Avs_a2_8"]["ok"] == "no" and ply.GetTable_Avs["Avs_a2_8"]["ing"] <= 15 then
					if npc:GetClass() == "npc_headcrab" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_physcannon" then
						if ply.GetTable_Avs["Avs_a2_8"]["ing"] >= 15 then
							net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EyXzg=","nil"} ) net.Send(ply)
						elseif ply.GetTable_Avs["Avs_a2_8"]["ing"] < 15 then
							GeAllO(ply, 1, "Avs_a2_8", "QXZzX2EyXzg=", 15)
						end
					end
				end
				if ply.GetTable_Avs["Avs_a3_5"] and ply.GetTable_Avs["Avs_a3_5"]["ok"] == "no" and ply.GetTable_Avs["Avs_a3_5"]["ing"] <= 13 then
					if npc:GetClass() == "npc_poisonzombie" and (inflictor:GetClass() == "npc_tripmine" or inflictor:GetClass() == "npc_satchel") then
						if ply.GetTable_Avs["Avs_a3_5"]["ing"] >= 13 then
							net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EzXzU=","nil"} ) net.Send(ply)
						elseif ply.GetTable_Avs["Avs_a3_5"]["ing"] < 13 then
							GeAllO(ply, 1, "Avs_a3_5", "QXZzX2EzXzU=", 13)
						end
					end
				end
				if ply.GetTable_Avs["Avs_a4_3"] and ply.GetTable_Avs["Avs_a4_3"]["ok"] == "no" and ply.GetTable_Avs["Avs_a4_3"]["ing"] <= 7 then
					if npc:GetClass() == "npc_hunter" and pgaw and IsValid(pgaw) and pgaw:GetClass() == "weapon_357" then
						if ply.GetTable_Avs["Avs_a4_3"]["ing"] >= 7 then
							net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2E0XzM=","nil"} ) net.Send(ply)
						elseif ply.GetTable_Avs["Avs_a4_3"]["ing"] < 7 then
							GeAllO(ply, 1, "Avs_a4_3", "QXZzX2E0XzM=", 7)
						end
					end
				end
			end
		end
	end

	hook.Add("ActMod-Theatrical_MMD_End", "ActMod_Avs__Theatrical_MMD", function(ply,d_nam)
		if IsValid( ply ) and ply:IsPlayer() and istable( ply.GetTable_Avs ) then
			if ply.GetTable_Avs["Avs_a2_6"] and ply.GetTable_Avs["Avs_a2_6"]["ok"] == "no" and d_nam == "Chaos Medley" then
				net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EyXzY=","n"} ) net.Send(ply)
			end
			if ply.GetTable_Avs["Avs_a3_3"] and ply.GetTable_Avs["Avs_a3_3"]["ok"] == "no" and d_nam == "PV120 - Shake it" then
				net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EzXzM=","n"} ) net.Send(ply)
			end
		end
	end)



	local function aCOnInBox(pl,Ps0,aP1,aP2,aP3)
		for id, ent in pairs(ents.FindInBox(Ps0 + Vector(aP1,aP2,aP3), Ps0 + Vector(-aP1,-aP2,-aP3))) do
			if IsValid( ent ) and ent:IsPlayer() and ent == pl then return true end
		end
		return false
	end

	function A_AM.ActMod.ActMod_Sv_Avs()
		if AGetMapNow == "am4-game_lv1" or AGetMapNow == "gm_construct" or AGetMapNow == "gm_flatgrass" then
			for _, ply in pairs(player.GetAll()) do
				if not ply:IsBot() and ply:Alive() and ply.GetTable_Avs then
					if AGetMapNow == "am4-game_lv1" then
						if ply.GetTable_Avs["Avs_a3_1"] and ply.GetTable_Avs["Avs_a3_1"]["ok"] == "no" then
							if !ply.ATmp_Avs_a3_1 then ply.ATmp_Avs_a3_1 = 0 end
							if ply.ATmp_Avs_a3_1 > 2 and aCOnInBox(ply,Vector( -8, -7, 0 ),110,110,55) == true then ply.ATmp_Avs_a3_1 = 1 end
							if ply.ATmp_Avs_a3_1 == 0 and aCOnInBox(ply,Vector( -8, -7, 0 ),110,110,55) == true then ply.ATmp_Avs_a3_1 = 1
							elseif ply.ATmp_Avs_a3_1 == 1 and aCOnInBox(ply,Vector( -12320, 1472, 25 ),200,160,55) == true then ply.ATmp_Avs_a3_1 = 2
							elseif ply.ATmp_Avs_a3_1 == 2 and aCOnInBox(ply,Vector( -1490, 1474, 80 ),150,160,80) == true then ply.ATmp_Avs_a3_1 = 3
							elseif ply.ATmp_Avs_a3_1 == 3 and aCOnInBox(ply,Vector( 11710.49, 1471.97, 40 ),220,170,50) == true then ply.ATmp_Avs_a3_1 = 4
							elseif ply.ATmp_Avs_a3_1 == 4 and aCOnInBox(ply,Vector( 2940, -1304.43, -818 ),400,400,100) == true then ply.ATmp_Avs_a3_1 = nil
								if (ply.AvS_TrAgin or 0) < CurTime() then
									ply.AvS_TrAgin = CurTime() + 1.5
									net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EzXzE=","n"} ) net.Send(ply)
								end
							end
						end
					elseif AGetMapNow == "gm_construct" and (ply.AvS_TrAgin or 0) < CurTime() then
						ply.AvS_TrAgin = CurTime() + 1
						if ply.GetTable_Avs["Avs_a3_2"] and ply.GetTable_Avs["Avs_a3_2"]["ok"] == "no" then
							if aCOnInBox(ply,Vector( -3000 ,-1245 ,-32 ),103,160,62) == true then
								ply.AvS_TrAgin = CurTime() + 0.5
								if ply:A_ActMod_IsActing() and ply:A_ActModString() == "amod_dance_california_girls.png" then
									ply.AvS_TrAgin = CurTime() + 2.5
									net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2EzXzI=","n"} ) net.Send(ply)
								end
							end
						end
					elseif AGetMapNow == "gm_flatgrass" and (ply.AvS_TrAgin or 0) < CurTime() then
						ply.AvS_TrAgin = CurTime() + 1
						if ply.GetTable_Avs["Avs_a4_4"] and ply.GetTable_Avs["Avs_a4_4"]["ok"] == "no" then
							if aCOnInBox(ply,Vector( -704, 0, -12665 ),285,445,100) == true then
								ply.AvS_TrAgin = CurTime() + 0.5
								if ply:A_ActMod_IsActing() and ply:A_ActModString() == "amod_fortnite_charleston.png" then
									ply.AvS_TrAgin = CurTime() + 2.5
									net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"AM_SvToCl_","QXZzX2E0XzQ=","n"} ) net.Send(ply)
								end
							end
						end
					end
				end
			end
		end
		if A_AM.ActMod.HookThinkSv != true then A_AM.ActMod.HookThinkSv = true end
	end

end


if CLIENT then

	A_AM.ActMod.Aptmp = {
		["Avs_a1_1"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "hud/killicons/default" ,["lng"]= "50" }
		,["Avs_a1_2"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "icon16/time.png" ,["lng"]= "LAchievements_a1_m2" }
		,["Avs_a1_3"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "icon64/tool.png" ,["lng"]= "LAchievements_a1_m3" }
		,["Avs_a2_1"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "/amod_mmd_dance_specialist.png" ,["lng"]= "LAchievements_a2_m1" ,["isiAct"]= true }
		,["Avs_a2_2"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "entities/npc_antlionguard.png" ,["lng"]= "LAchievements_a2_m2" }
		,["Avs_a2_3"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "entities/combineelite.png" ,["lng"]= "LAchievements_a2_m3" }
		,["Avs_a2_4"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/GDiva_image.png" ,["lng"]= "LAchievements_a2_m4" }
		,["Avs_a2_5"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/GDiva_image.png" ,["lng"]= "LAchievements_a2_m4" }
		,["Avs_a2_6"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/TheatricalMMD_1.png" ,["lng"]= "LAchievements_a2_m6" }
		,["Avs_a2_7"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/i_thumbsup.png" ,["lng"]= "LAchievements_a2_m7" }
		,["Avs_a2_8"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "entities/npc_headcrab.png" ,["lng"]= "LAchievements_a2_m8" }
		,["Avs_a2_9"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "entities/npc_manhack.png" ,["lng"]= "LAchievements_a2_m9" }
		,["Avs_a3_1"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/amap_gamerenl1.png" ,["lng"]= "LAchievements_a3_m1" }
		,["Avs_a3_2"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/a3_2.png" ,["lng"]= "LAchievements_a3_m2" }
		,["Avs_a3_3"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/TheatricalMMD_2.png" ,["lng"]= "LAchievements_a2_m6" }
		,["Avs_a3_4"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/v_1.png" ,["lng"]= "LAchievements_a3_m4" }
		,["Avs_a3_5"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "entities/npc_poisonzombie.png" ,["lng"]= "LAchievements_a3_m5" }
		,["Avs_a3_6"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "/amod_am4_levepalestina.png" ,["lng"]= "LAchievements_a3_m6" ,["isiAct"]= true }
		,["Avs_a3_7"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "hud/killicons/default" ,["lng"]= "250" }
		,["Avs_a3_8"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/v_fl.png" ,["lng"]= "LAchievements_a3_m8" }
		,["Avs_a3_9"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/GDiva_image.png" ,["lng"]= "LAchievements_a2_m4" }
		,["Avs_a4_1"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/GDiva_image.png" ,["lng"]= "LAchievements_a2_m4" }
		,["Avs_a4_2"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "hud/killicons/default" ,["lng"]= "100" }
		,["Avs_a4_3"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "entities/npc_hunter.png" ,["lng"]= "LAchievements_a4_m3" }
		,["Avs_a4_4"] = { ["ok"]= "no" ,["ing"]= 0 ,["png"]= "actmod/imenu/a4_4.png" ,["lng"]= "LAchievements_a3_m2" }
	}
	timer.Simple(1, function() timer.Simple(0.2, function()
		A_AM.ActMod.Aptmp["Avs_a1_1"]["lng"]= string.format(aR:T("LAchievements_a1_m1"), "50")
		A_AM.ActMod.Aptmp["Avs_a3_7"]["lng"]= string.format(aR:T("LAchievements_a1_m1"), "250")
		A_AM.ActMod.Aptmp["Avs_a4_2"]["lng"]= string.format(aR:T("LAchievements_a1_m1"), "100")
	end) end)

	local kNumw,kNumh = 0,0
	local function AShowB(pl,paa,atxt,tp)
		if GetConVarNumber("actmod_cl_showmsgavs") == 0 then return end
		local ply = LocalPlayer() or pl
		if !file.Exists(A_AM.ActMod:GUniqueFiName(ply), "DATA") then return end
		local atxtt = tostring(paa) .."|".. tostring(atxt) .."|"
		if timer.Exists( atxtt ) then timer.Remove( atxtt ) end
		timer.Create(atxtt,0.1,1,function()
			local agDat ,agok ,aging = A_AM.ActMod:AG_DatA(0) ,"_no_" ,-1
			if istable(agDat) and agDat[paa] and istable(agDat[paa]) then
				agDat = agDat[paa]
				if agDat["ok"] then agok = agDat["ok"] end
				if agDat["ing"] then aging = agDat["ing"] end
			end
			timer.Create(atxtt,0.1,1,function()
				if A_AM.ActMod.savTAVS[paa] and A_AM.ActMod.savTAVS[paa][1] then
					A_AM.ActMod.savTAVS[paa][2] = A_AM.ActMod.savTAVS[paa][2] + 1
				else
					A_AM.ActMod.savTAVS[paa] = {true,1,1,false,1,false,0}
				end
				if A_AM.ActMod.savTAVS[paa][7] ~= A_AM.ActMod.savTAVS[paa][2] and (not tp and agok ~= "no" or tp == 2 and atxt and aging and aging > 0 ) then
					A_AM.ActMod.savTAVS[paa][7] = A_AM.ActMod.savTAVS[paa][2]
					local OAvs = vgui.Create( "ActMod_Avs_Done" )
					local bF = A_AM.ActMod.Settings["IconsActs"]
					OAvs.Typ = tp or 1
					OAvs.GetPly = ply
					if OAvs.Typ == 2 then
						kNumh = (kNumh + 1)%6 else kNumw = (kNumw + 1)%4
					end
					if timer.Exists( "tinReTinWH" ) then timer.Remove( "tinReTinWH" ) end
					timer.Create("tinReTinWH",6.5,1,function() kNumh = 0  kNumw = 0 end)
					OAvs.kNumw = kNumw
					OAvs.kNumh = kNumh
					if A_AM.ActMod.Aptmp[paa] and A_AM.ActMod.Aptmp[paa]["png"] then
						if A_AM.ActMod.Aptmp[paa]["isiAct"] then
							OAvs.pag = bF .. A_AM.ActMod.Aptmp[paa]["png"]
							OAvs.pagT = true
						else
							OAvs.pag = A_AM.ActMod.Aptmp[paa]["png"]
						end
					end
					if A_AM.ActMod.Aptmp[paa] and A_AM.ActMod.Aptmp[paa]["lng"] then
						OAvs.nna = aR:T((paa == "Avs_a2_5" and "LAchievements_a2_m4" or A_AM.ActMod.Aptmp[paa]["lng"]))..(atxt or "")
					end
					if GetConVarNumber("actmod_cl_showmsgavssnd") ~= 0 then
						if OAvs.Typ == 2 then
							surface.PlaySound("actmod/s/swip2.mp3")
						else
							surface.PlaySound("actmod/s/s1.mp3")
						end
					end
					return OAvs
				else
					if tp and tp == 2 then
						A_AM.ActMod.savTAVS[paa][3] = A_AM.ActMod.savTAVS[paa][3] + 1
						if not A_AM.ActMod.savTAVS[paa][4] then
							A_AM.ActMod.savTAVS[paa][4] = true
							chat.AddText(Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"]" ,Color( 255, 200, 100 )," [Achievements]: ",Color( 255, 80, 30 ),"Error ",Color( 255, 140, 80 ),"to Save!" )
							chat.AddText(Color( 255, 200, 100 ),"There is a problem saving progress: ",Color( 255, 255, 200 ),aR:T(tostring(A_AM.ActMod.Aptmp[paa]["lng"])) )
						end
						if A_AM.ActMod.savTAVS[paa][3] > 1 then
							MsgC(Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"]" ,Color( 255, 100, 50 ),"[Achievements]: Error saving achievement progress (r".. tostring(A_AM.ActMod.savTAVS[paa][3]) ..")\n" )
						else
							MsgC(Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"]" ,Color( 255, 200, 100 ),"[Achievements]: Attempt to save progress failed [".. tostring(paa) .."]\n" )
						end
					else
						A_AM.ActMod.savTAVS[paa][5] = A_AM.ActMod.savTAVS[paa][5] + 1
						if not A_AM.ActMod.savTAVS[paa][6] then
							A_AM.ActMod.savTAVS[paa][6] = true
							chat.AddText(Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"]" ,Color( 255, 200, 100 )," [Achievements]: ",Color( 255, 80, 30 ),"Error ",Color( 255, 140, 80 ),"to Save!" )
							chat.AddText(Color( 255, 200, 100 ),"There is a problem completing: ",Color( 255, 255, 200 ),aR:T(tostring(A_AM.ActMod.Aptmp[paa]["lng"])) )
						end
						if A_AM.ActMod.savTAVS[paa][5] > 1 then
							MsgC(Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"]" ,Color( 255, 100, 50 ),"[Achievements]: Error complete the [".. tostring(paa) .."] (r".. tostring(A_AM.ActMod.savTAVS[paa][5]) ..")\n" )
						else
							MsgC(Color( 50, 200, 255 ),"[" ,Color( 100, 255, 255 ),"(ActMod)" ,Color( 50, 200, 255 ),"]" ,Color( 255, 200, 100 ),"[Achievements]: Failed attempt to complete [".. tostring(paa) .."]\n" )
						end
					end
				end
			end)
		end)
	end
	function A_AM.ActMod:AZtxt(zZ,tt)
		local Tmz = 0
		if zZ then
        local Tal = vgui.Create('DLabel') Tal:SetAlpha(0)
        Tal:SetText(zZ) Tal:SetFont(tt) Tal:SizeToContents()
		Tmz = Tal:GetWide()  Tal:Remove()  Tal = nil
		end
	return Tmz
	end
	local function AG_Anyl(ply,txt)
		ply.GetTable_Avs = ply.GetTable_Avs or A_AM.ActMod.Aptmp
		for k, v in pairs(txt) do
			if string.sub(k,1 ,5) == "Avs_a" then
				if ply.GetTable_Avs[k] then
				if ply.GetTable_Avs[k]["ok"] then ply.GetTable_Avs[k]["ok"] = txt[k]["ok"] end
				if ply.GetTable_Avs[k]["ing"] then ply.GetTable_Avs[k]["ing"] = txt[k]["ing"] end
				else
				local atxt,aaing = "no",0
				if txt[k]["ok"] then atxt = txt[k]["ok"] end
				if txt[k]["ing"] then aaing = txt[k]["ing"] end
				ply.GetTable_Avs[k] = { ["ok"]= atxt ,["ing"]= aaing }
				end
			end
		end
		for k, v in pairs(ply.GetTable_Avs) do if txt[k] then if txt[k]["ok"] then v["ok"] = txt[k]["ok"] end if txt[k]["ing"] then v["ing"] = txt[k]["ing"] end end end
		net.Start( "A_AM.ActMod.ClToSv_Tab",true ) net.WriteTable( {"avs_SetTabPly",ply.GetTable_Avs} ) net.SendToServer()
		ply.ErorrTable_Avs = 0
	end
	local function AG_BED(AY,txt) return A_AM.ActMod:A_BED(AY,txt) end
	local function AS_DatA(ty,txt,Aing)
		local A1txt = file.Read(A_AM.ActMod:GUniqueFiName(LocalPlayer()), "DATA")
		local commit = util.JSONToTable(AG_BED(2,A1txt))
		local aok = true
		if ty == "ALL_Avs_a" then
			for k, v in pairs(commit) do if string.sub(k,1 ,5) == "Avs_a" then
				if txt and v["ok"] then v["ok"] = txt end if Aing and v["ing"] then v["ing"] = tonumber(Aing) end
			end end
		else
			if commit[ty] then
				if txt then commit[ty]["ok"] = txt end
				if Aing then commit[ty]["ing"] = tonumber(Aing) end
			else
				aok = false
				local atxt = "no"
				local aaing = 0
				if txt then atxt = txt end
				if Aing then aaing = Aing end
				commit[ty] = { ["ok"]= atxt ,["ing"]= aaing }
				aok = true
			end
		end
		if aok == true then
			file.Write(A_AM.ActMod:GUniqueFiName(LocalPlayer()),AG_BED(1,util.TableToJSON(commit))) A1txt = nil commit = nil
			timer.Simple(0.2,function() if IsValid(LocalPlayer()) then
				AG_Anyl(LocalPlayer(),util.JSONToTable(AG_BED(2,file.Read(A_AM.ActMod:GUniqueFiName(LocalPlayer()), "DATA"))))
			end end)
		end
	end
	local function a_IsNumber(tnbr) return isnumber(tonumber(tnbr)) end
	local function AG_CDet() file.Write(A_AM.ActMod:GUniqueFiName(LocalPlayer()),AG_BED(1,A_AM.ActMod.Aatmp))
	timer.Create("Acl_t1",0.2,1,function() if IsValid(LocalPlayer()) then A_AM.ActMod:A_ReGD() end end) end
	local function AG_Delt(Re) file.Delete(A_AM.ActMod:GUniqueFiName(LocalPlayer()), "DATA") if Re then AG_CDet() end end
	local function AG_DatA(ty,txt,stxt,aing)
		if file.Exists(A_AM.ActMod:GUniqueFiName(LocalPlayer()), "DATA") then
			local tmp = file.Read(A_AM.ActMod:GUniqueFiName(LocalPlayer()), "DATA")
			local commit = util.JSONToTable(AG_BED(2,tmp))
			if !commit then AG_Delt(true) return 0 end
			if AG_BED(1,commit.inopn) ~= "QWN0TW9kIFtBTTRd" then AG_Delt(true) return 0 end
			if !commit.IDPly then AG_Delt(true) return 0 end
			if commit.IDPly ~= LocalPlayer():SteamID64() then AG_Delt(true) return 0 end
			if ty == 6 then return AG_Anyl(LocalPlayer(),commit)
			elseif ty == 5 then
				if commit then
					local ao = 0
					for k, v in pairs(commit) do if v["ok"] == "Done" then ao = ao+1 end end
					return ao
				end
			elseif ty == 1 then AS_DatA(txt,stxt,aing)
			elseif ty == 2 then if commit[txt] then return commit[txt]["ok"] else AS_DatA(txt) end
			elseif ty == 7 then if commit[txt] then if a_IsNumber(commit[txt]["ing"]) == true then return commit[txt]["ing"] else AG_Delt(true) return 0 end end
			elseif ty == 0 then if commit then return commit end
			elseif ty == 20 then
				if commit and commit.IDPly and commit.IDPly == LocalPlayer():SteamID64() then
					return 1
				end
			elseif ty == 11 then if commit then local ao = 0
			for k, v in pairs(commit) do if v["ok"] == "yes" then ao = ao+1 end end
			return ao end
			end
		else
			LocalPlayer().GetTable_Avs = A_AM.ActMod.Aptmp
		end
		return 0
	end
	local function ANo_Avs_ok(ply,txt)
		if txt then return (!ply.GetTable_Avs or (ply.GetTable_Avs and ply.GetTable_Avs["Avs_"..txt] and ply.GetTable_Avs["Avs_"..txt]["ok"] == "no")) end return false
	end

	function A_AM.ActMod:A_ReGD() AG_DatA(6) end
	function A_AM.ActMod:A_GCkFile() return AG_DatA(20) == 1 end
	function A_AM.ActMod:AG_DatA( a1,a2,a3,a4 ) return AG_DatA(a1,a2,a3,a4 and tonumber(a4) or nil) end
	function A_AM.ActMod:AShowB( a1,a2,a3,a4 ) AShowB(a1,a2,a3,a4) end

	function A_AM.ActMod:avsSTC( txt,stxt )
		local ply = LocalPlayer()
		local showB = false
		local txtB = ""
		if string.find(txt, ".show.") then txt = string.Replace(txt,".show.","") showB = true
		if txt == "QXZzX2ExXzM=" then txtB = "  "..string.format(aR:T("LAchievements_a2_i4t"), " ".. stxt .." / 3 ") end
		end
		if stxt and stxt ~= "n" then stxt = tonumber(stxt) end
		if IsValid( ply ) then
			if txt and AG_DatA(2,AG_BED(2,txt)) == "no" then
				if stxt and isnumber(tonumber(stxt)) then
					AG_DatA(1,AG_BED(2,txt),nil,stxt)
					if showB == true then AShowB(ply,AG_BED(2,txt),txtB,2) end
				else
					AG_DatA(1,AG_BED(2,txt),"yes") AShowB(ply,AG_BED(2,txt))
				end
			end
		end
	end

	function A_AM.ActMod.ActMod_Cl_Avs()
		local ply = LocalPlayer()
		if IsValid( ply ) and A_AM.ActMod.svOn == true and (ply.ActMod_Avs_rEtime or 0) < CurTime() and A_AM.ActMod:A_GCkFile() then
			ply.ActMod_Avs_rEtime = CurTime() + 0.4
			if (ply.ActMod_Avs_re_time or 0) < CurTime() then ply.ActMod_Avs_re_time = CurTime() + 7 AG_DatA(6) end
			if ply.GetTable_Avs then
				if ANo_Avs_ok(ply,"a2_1") == true then
					if ply:A_ActMod_IsActing() and AG_BED(1,ply:A_ActModString()) == "YW1vZF9tbWRfZGFuY2Vfc3BlY2lhbGlzdC5wbmc=" then
						if (ply.ActMod_Avs__a2_1_time or 0) < CurTime() then ply.ActMod_Avs__a2_1_time = CurTime() + 1
							if !ply.ActMod_Avs__a2_1_ing then ply.ActMod_Avs__a2_1_ing = 0 end
							if ply.ActMod_Avs__a2_1_ing >= 101 then
								AG_DatA(1,AG_BED(2,"QXZzX2EyXzE="),"yes") AShowB(ply,"Avs_a2_1")
							elseif ply.ActMod_Avs__a2_1_ing < 101 then
								ply.ActMod_Avs__a2_1_ing = ply.ActMod_Avs__a2_1_ing+1
							end
						end
					end
				elseif ply.ActMod_Avs__a2_1_ing then
					ply.ActMod_Avs__a2_1_ing = nil
					ply.ActMod_Avs__a2_1_time = nil
				end
				if ANo_Avs_ok(ply,"a3_6") == true then
					if ply:A_ActMod_IsActing() and AG_BED(1,ply:A_ActModString()) == "YW1vZF9hbTRfbGV2ZXBhbGVzdGluYS5wbmc=" then
						if (ply.ActMod_Avs__a3_6_time or 0) < CurTime() then ply.ActMod_Avs__a3_6_time = CurTime() + 1
							if !ply.ActMod_Avs__a3_6_ing then ply.ActMod_Avs__a3_6_ing = 0 end
							if ply.ActMod_Avs__a3_6_ing >= 45 then
								AG_DatA(1,AG_BED(2,"QXZzX2EzXzY="),"yes") AShowB(ply,"Avs_a3_6")
							elseif ply.ActMod_Avs__a3_6_ing < 45 then
								ply.ActMod_Avs__a3_6_ing = ply.ActMod_Avs__a3_6_ing+1
							end
						end
					end
				elseif ply.ActMod_Avs__a3_6_ing then
					ply.ActMod_Avs__a3_6_ing = nil
					ply.ActMod_Avs__a3_6_time = nil
				end
				if ply.ActMod_TabTSrvr == 0 and ANo_Avs_ok(ply,"a1_2") == true then
					if ply:A_ActMod_IsActing() then
						if (ply.ActMod_Avs__a1_2_time or 0) < CurTime() then
							if ANo_Avs_ok(ply,"a1_2") == false then
								ply.ActMod_Avs__a1_2_time = nil
							else
								ply.ActMod_Avs__a1_2_time = CurTime() + 60
								if AG_DatA(7,"Avs_a1_2") >= 35 then
									AG_DatA(1,AG_BED(2,"QXZzX2ExXzI="),"yes") AShowB(ply,"Avs_a1_2")
								elseif AG_DatA(7,"Avs_a1_2") < 35 then
									if AG_DatA(7,"Avs_a1_2") >= 34 then
										AG_DatA(1,AG_BED(2,"QXZzX2ExXzI="),"yes") AShowB(ply,"Avs_a1_2")
									else
										AG_DatA(1,AG_BED(2,"QXZzX2ExXzI="),nil,AG_DatA(7,"Avs_a1_2")+1)
									end
								end
							end
						end
					end
				end
				if ANo_Avs_ok(ply,"a2_7") == true then
					if ply:A_ActMod_IsActing() and (ply.ActMod_Avs__a2_7_time2 or 0) < CurTime() then
						ply.ActMod_Avs__a2_7_time2 = CurTime() + 0.2
						if (ply.ActMod_Avs__a2_7_time or 0) < CurTime() and table.HasValue({"amod_fortnite_thumbsup","amod_mixamo_gesture_9"},string.lower(ply:GetNWString("A_ActMod.TmpDir",""))) then
							ply.ActMod_Avs__a2_7_time = CurTime() + 0.6
							local aRa = util.TraceHull( { start = ply:EyePos(), endpos = ply:EyePos() + ply:GetForward() * 200, mask = MASK_SHOT, filter = function(ent) if ent:IsWorld() or (ent:IsPlayer() and not ent:IsBot() and ent != ply) then return true end end, mins = Vector( -8, -8, -8 ), maxs = Vector( 8, 8, 8 ) } )
							if !ply.ActMod_Avs__a2_7_ing then ply.ActMod_Avs__a2_7_ing = 0 end
							local tr_C = IsValid(aRa.Entity) and aRa.Entity:IsPlayer() or false
							if tr_C then
								if ply.ActMod_Avs__a2_7_ing >= 2 then
									AG_DatA(1,"Avs_a2_7","yes")
									AShowB(ply,"Avs_a2_7")
									ply.ActMod_Avs__a2_7_ing = 0
								elseif ply.ActMod_Avs__a2_7_ing < 2 then
									ply.ActMod_Avs__a2_7_ing = ply.ActMod_Avs__a2_7_ing+1
								end
							end
						end
					elseif ply.ActMod_Avs__a2_7_ing then
						ply.ActMod_Avs__a2_7_ing = nil
						ply.ActMod_Avs__a2_7_time = nil
					end
				elseif ply.ActMod_Avs__a2_7_ing then
					ply.ActMod_Avs__a2_7_ing = nil
					ply.ActMod_Avs__a2_7_time = nil
				end
			end
		end
	end

	local function AInt1()
		if A_AM.ActMod:GetInfAddon("2896053995") == 3 then
			hook.Add("garrydiva-chartend", "ActMod_Avs_GDiva", function(chart, score, maxscore)
				local ply = LocalPlayer()
				if ANo_Avs_ok(ply,"a4_1") == true then
					if score >= 20000 and AG_DatA(7,"Avs_a4_1") <= 6 then
						AG_DatA(1,AG_BED(2,"QXZzX2E0XzE="),nil,AG_DatA(7,"Avs_a4_1")+1)
						if AG_DatA(7,"Avs_a4_1") >= 6 then
							AG_DatA(1,AG_BED(2,"QXZzX2E0XzE="),"yes")
							AShowB(ply,"Avs_a4_1","GDiva-> [ 20,000 ] ")
						else
							AShowB(ply,"Avs_a4_1","GDiva-> [ 20,000 ]   ".. string.format(aR:T("LAchievements_a2_i4t"), " ".. AG_DatA(7,"Avs_a4_1") .." / 6  "),2)
						end
					end
				end
				if ANo_Avs_ok(ply,"a3_9") == true then
					if score >= 40000 and AG_DatA(7,"Avs_a3_9") <= 3 then
						AG_DatA(1,AG_BED(2,"QXZzX2EzXzk="),nil,AG_DatA(7,"Avs_a3_9")+1)
						if AG_DatA(7,"Avs_a3_9") >= 3 then
							AG_DatA(1,AG_BED(2,"QXZzX2EzXzk="),"yes")
							AShowB(ply,"Avs_a3_9","GDiva-> [ 40,000 ] ")
						else
							AShowB(ply,"Avs_a3_9","GDiva-> [ 40,000 ]   ".. string.format(aR:T("LAchievements_a2_i4t"), " ".. AG_DatA(7,"Avs_a3_9") .." / 3  "),2)
						end
					end
				end
				if ANo_Avs_ok(ply,"a2_4") == true then
					if score >= 100000 and AG_DatA(7,"Avs_a2_4") <= 2 then
						AG_DatA(1,AG_BED(2,"QXZzX2EyXzQ="),nil,AG_DatA(7,"Avs_a2_4")+1)
						if AG_DatA(7,"Avs_a2_4") >= 2 then
							AG_DatA(1,AG_BED(2,"QXZzX2EyXzQ="),"yes")
							AShowB(ply,"Avs_a2_4","GDiva-> [ 100,000 ] ")
						else
							AShowB(ply,"Avs_a2_4","GDiva-> [ 100,000 ]   ".. string.format(aR:T("LAchievements_a2_i4t"), " ".. AG_DatA(7,"Avs_a2_4") .." / 2  "),2)
						end
					end
				end
				if ANo_Avs_ok(ply,"a2_5") == true then
					if score >= 90000 then AG_DatA(1,AG_BED(2,"QXZzX2EyXzU="),"yes") AShowB(ply,AG_BED(2,"QXZzX2EyXzU="),"GDiva-> [ 90,000 ] ") end
				end
			end)
		end
	end AInt1()


	local function aChMap(pl,txt,tmap)
		if game.SinglePlayer() then
			Derma_Query( string.format(aR:T("LAchievements_H0TMap"), txt) , "ActMod :", aR:T("LORTR_No"),function() end
			,aR:T("LORTR_Yes"), function() pl:ConCommand("map ".. tmap .."\n") end)
		elseif !game.SinglePlayer() and pl:IsListenServerHost() then
			Derma_Query( aR:T("LAchievements_H1TMap") .."\n".. string.format(aR:T("LAchievements_H0TMap"), txt) , "ActMod :", aR:T("LORTR_No"),function() end
			,aR:T("LORTR_Yes"), function()
				net.Start( "A_AM.ActMod.ClToSv_Tab" ) net.WriteTable( {"CHangeMap",tmap} ) net.SendToServer()
			end)
		elseif !game.SinglePlayer() and game.MaxPlayers() > 1 then
			Derma_Query( aR:T("LAchievements_H2TMap") .."\n".. string.format(aR:T("LAchievements_H0TMap"), txt) , "ActMod :", aR:T("LORTR_No"),function() end
			,aR:T("LORTR_Yes"), function() RunConsoleCommand("map",tmap) end)
		end
	end
    local function title(list, text)
        local label = list:Add('DLabel')
        if text == "A" then label:SetText("") else label:SetText(text or "") end
        label:SetFont('ActMod_a2')
        label:SetTextColor(color_white)
        label:SetExpensiveShadow(2, color_black)
        label:SetContentAlignment(5)
        label:Dock(TOP)
        label:DockMargin(0, 0, 0, 3)
		if text then local Tmz = 50
		if text != "A" then
        local Tal = vgui.Create('DLabel',label) Tal:SetAlpha(0)
        Tal:SetText(text) Tal:SetFont('ActMod_a2') Tal:SizeToContents()
		Tmz = Tal:GetWide()+20  Tal:Remove()  Tal = nil
		end
		label.Paint = function( ss, w, h )
			if text == "A" then draw.RoundedBox( 5, 0, 0, w, h, Color( 0, 50, 50, 150 ) )
			elseif text then draw.RoundedBox( 5, w/2-Tmz/2, 0, Tmz, h, Color( 0, 50, 50, 150 ) )
			end
		end
		end
        return label
    end
    local function ic_dit(plist,datta,sl)
        local pnl = plist:Add('DButton')
        pnl:SetTall(60)
        pnl:SetText("")
        pnl:Dock(TOP)
        pnl:DockMargin(0, 0, 0, 3)
		pnl.tt = CurTime() + 0.1
		pnl.Alpa = 0
		sl.alltask = sl.alltask+1
        local Think_ing
        local Think_ok = AG_DatA(2,datta.ok)
		local AidW
		local Alpa,Zlpa = 300,0
		if datta.idW then
			local Aags
			if datta.idW == "2580513967" then Aags = true end
			AidW = A_AM.ActMod:GetInfAddon(datta.idW,Aags)
			Aags = nil
		end
        if datta.oning and Think_ok == "no" then Think_ing = AG_DatA(7,datta.ok) end
		pnl.Think = function(ss) if (pnl.tt or 0) < CurTime() then pnl.tt = CurTime() + 0.5 Think_ok = AG_DatA(2,datta.ok) if datta.oning and Think_ok == "no" then Think_ing = AG_DatA(7,datta.ok) end
			if Think_ok == "Done" or Think_ok == "yes" or (Think_ok == "no" and datta.copy ) or (datta.idW and (datta.idW == "2567449282" and AidW == 0 or datta.idW != "2567449282") ) or datta.conntSv or datta.ongame then
				pnl:SetMouseInputEnabled(true)
			else
				pnl:SetMouseInputEnabled(false)
			end
			end
			if Think_ok == "Done" then
				if ss:IsHovered() and ss.Alpa < 255 then ss.Alpa = math.min(255,ss.Alpa + 650*FrameTime())
				elseif !ss:IsHovered() then if ss.Alpa > 0 then ss.Alpa = math.max(0,ss.Alpa - 600*FrameTime())
				else if Zlpa > 0 then Zlpa = 0 end if Alpa != 0 then Alpa = 300 end end
				end
			end
		end
		local uicon,hecode = "",""
		local bF = A_AM.ActMod.Settings["IconsActs"] .."/"
		if A_AM.ActMod.ActLck[datta.ok] then
			uicon = bF.. A_AM.ActMod.ActLck[datta.ok]["T1"]
			if A_AM.ActMod.ActLck[datta.ok]["T2"] != "" then hecode = AG_BED(1,A_AM.ActMod.ActLck[datta.ok]["T2"]..A_AM.ActMod.ActLck[datta.ok]["T1"]) end
		end
		local sln = string.len(bF)+1
		local shv = A_AM.ActMod:ReString(string.sub(uicon,sln-1))
		local si_Gmod_Taunt = (string.find(shv, "taunt_") or string.find(shv, "zombie_")) and !string.find(shv, "amod_") and !string.find(shv, "wos_tf2_")
		local si_AM4_Amod = string.find(shv, "amod_") and !string.find(shv, "amod_pubg_") and !string.find(shv, "amod_mmd_") and !string.find(shv, "amod_fortnite_")
		local si_AM4_pubg = string.find(shv, "amod_pubg_")
		local si_AM4_MMD = string.find(shv, "amod_mmd_")
		local si_AM4_Fortnite = string.find(shv, "amod_fortnite_")
		local si_CTA_MMD = string.find(shv, "original_dance")
		local si_CTA_Fortnite = string.find(shv, "f_") and !string.find(shv, "original_dance") and !string.find(shv, "amod_")
		local si_CTA_TF2 = string.find(shv, "wos_tf2_")
		local NIcon,LIcon
		if si_Gmod_Taunt then LIcon = "actmod/imenu/is_gmod.png"  NIcon = "AM4"
		elseif si_AM4_Amod then LIcon = "actmod/imenu/is_am4.png"  NIcon = "AM4"
		elseif si_AM4_pubg then LIcon = "actmod/imenu/is_pubg.png"  NIcon = "AM4"
		elseif si_AM4_MMD then LIcon = "actmod/imenu/is_mmd2.png"  NIcon = "AM4"
		elseif si_AM4_Fortnite then LIcon = "actmod/imenu/Is_fortnite.png"  NIcon = "AM4"
		elseif si_CTA_MMD then LIcon = "actmod/imenu/is_mmd.png"  NIcon = "CTA"
		elseif si_CTA_Fortnite then LIcon = "actmod/imenu/Is_fortnite.png"  NIcon = "CTA"
		elseif si_CTA_TF2 then LIcon = "actmod/imenu/is_team_fortress2.png"  NIcon = "TF2"
		else LIcon = "icon64/tool.png"  NIcon = "None"
		end

		local eNameAct = A_AM.ActMod:ReNameAct(A_AM.ActMod:ReString(string.sub(uicon,sln)))

        pnl.Paint = function(ss, w, h)
			if Think_ok == "Done" then
			draw.RoundedBox( 4, 0, 0, w, h, Color( 50, 120, 80, 255 ) )
			elseif Think_ok == "yes" then
				local acw = math.max(0,math.min(50, 20+(50*math.sin(CurTime()*7))))
				if ss:IsHovered() then draw.RoundedBox( 4, 0, 0, w, h, ss:IsDown() and Color( 150, 200, 110, 255 ) or Color( 80, 140, 150, 255 ) ) 
				else draw.RoundedBox( 4, 0, 0, w, h, Color( 50+acw*1.1, 120+acw*0.5, 80, 255 ) ) 
				end
			else draw.RoundedBox( 4, 0, 0, w, h, Color( 40, 30, 100, 105 ) )
			end
				surface.SetDrawColor(Color(0,50,150,255)) surface.SetMaterial( Material("gui/gradient") ) surface.DrawTexturedRect(0, 0, w, h)
				surface.SetDrawColor(Color(255,255,255,255))
				surface.SetMaterial( Material(datta.icon, "noclamp smooth") )
				surface.DrawTexturedRect(0, 0, h, h)
				if Think_ok == "Done" then
					surface.SetMaterial( Material("actmod/showeror/ye.png", "noclamp smooth") )
					surface.DrawTexturedRect(w-(h/2+5), 5, h/2, h/2)
				end
			if Think_ok == "yes" then
				draw.SimpleTextOutlined( aR:T("LAchievements_PrsHere"), "ActMod_a1", w-5, 5, Color(255,255,0,255) ,2,0, math.max(0,math.min(2, (5*math.sin(CurTime()*6)))), Color( 255, 255, 255, math.max(0,math.min(255, (255*math.sin(CurTime()*6)))) ) )
			elseif Think_ok == "no" then
				if datta.ongame then
					if datta.ok == "Avs_a1_3" then
						draw.SimpleText( "[ ".. aR:T("LAchievements_PTPlay") .." ]", "ActMod_a4", w-5, 10, Color(200,255,230,200+(55*math.sin(CurTime()*3))) ,2 )
					end
				end
				if AidW == 0 then
					draw.SimpleText( "[ ".. aR:T("LAchievements_NAddon") .." ]", "ActMod_a4", w-5, 10, Color(255,120,40,200+(55*math.sin(CurTime()*3))) ,2 )
				elseif AidW == 1 then
					draw.SimpleText( "[ ".. aR:T("LAchievements_EnAdon") .." ]", "ActMod_a4", w-5, 10, Color(255,200,100,200+(55*math.sin(CurTime()*3))) ,2 )
				elseif AidW == 2 then
					draw.SimpleText( "[ ".. aR:T("LAchievements_ReMGam") .." ]", "ActMod_a4", w-5, 10, Color(225,200,255,200+(55*math.sin(CurTime()*3))) ,2 )
				elseif AidW == 3 then
					if datta.idW == "2896053995" then
						draw.SimpleText( "[ ".. aR:T("LAchievements_PTPlay") .." ]", "ActMod_a4", w-5, 10, Color(200,255,230,200+(55*math.sin(CurTime()*3))) ,2 )
					elseif datta.idW == "2580513967" and AGetMapNow != "am4-game_lv1" then
						draw.SimpleText( "[ ".. aR:T("LAchievements_PGTMap") .." ]", "ActMod_a4", w-5, 10, Color(200,255,230,200+(55*math.sin(CurTime()*3))) ,2 )
					end
				elseif datta.conntSv then
					draw.SimpleText( "[ ".. aR:T("LAchievements_PGTaSv") .." ]", "ActMod_a4", w-5, 10, Color(200,255,230,200+(55*math.sin(CurTime()*3))) ,2 )
				elseif ss:IsHovered() and datta.copy then
					draw.SimpleText( "[ ".. aR:T("LAchievements_CopyNa") .." ]", "ActMod_a4", w-5, 10, Color(200,255,255,200+(55*math.sin(CurTime()*3))) ,2 )
				end
				if datta.oning then
					if datta.ok == "Avs_a1_3" then
						draw.SimpleText( string.format(aR:T("LAchievements_a2_i4t"), tostring(Think_ing) .." / 3 "), "ActMod_a3", w-5, 30, Color(200,200,150,255) ,2 )
					elseif datta.ok == "Avs_a2_4" or datta.ok == "Avs_a3_9" or datta.ok == "Avs_a4_1" then
						draw.SimpleText( string.format(aR:T("LAchievements_a2_i4t"), tostring(Think_ing) .." / ".. datta.oning .." "), "ActMod_a3", w-5, 30, Color(200,200,150,255) ,2 )
					else
						draw.SimpleText( tostring(Think_ing) .." / ".. datta.oning .." ", "ActMod_a3", w-5, 30, Color(200,200,150,255) ,2 )
					end
				end
			end
			draw.SimpleText( datta.nemu, "ActMod_a6", h+5, 5, Color(255,255,215,255) )
			draw.SimpleText( datta.missin, "ActMod_a5", h+5, 35, Color(255,255,215,255) )
			if Think_ok == "Done" and ss.Alpa > 0 then
			local Alpa2 = 255 * ss.Alpa/100
			draw.RoundedBox( 0, 0, 0, w, h, Color(80,20,100,Alpa2) )
			surface.SetDrawColor(Color(50,150,200,ss.Alpa)) surface.SetMaterial( Material("gui/gradient") ) surface.DrawTexturedRect(0, 0, w, h)
				if uicon != "" then
				
				if Alpa > -300 then
				Alpa = math.max(-300,Alpa - 70*FrameTime())
				Zlpa = math.min(h,Zlpa + 70*FrameTime())
				elseif Alpa <= -300 then Alpa = 300 Zlpa = 0
				end
				surface.SetDrawColor(Color(255,255,255,math.max(0,math.min(ss.Alpa,255 * Alpa/255)))) surface.SetMaterial( Material("actmod/eff_particle/p_ring_wave") ) surface.DrawTexturedRect(h/2-Zlpa/2, h/2-Zlpa/2, Zlpa, Zlpa)
				surface.SetDrawColor(Color(255,255,255,math.max(0,math.min(ss.Alpa,(Zlpa*2) * Alpa/150)))) surface.SetMaterial( Material("actmod/eff_particle/p_glow_01") ) surface.DrawTexturedRect(0, 0, h, h)

				surface.SetDrawColor(Color(255,255,255,255 * ss.Alpa/150))
				surface.SetMaterial( Material(uicon, "noclamp smooth") )
				surface.DrawTexturedRect(0, 0, h, h)
				draw.SimpleText( eNameAct , "ActMod_a6", h+5, 5, Color(255,255,215,ss.Alpa) )
				draw.SimpleText( A_AM.ActMod:ReString(string.sub(uicon,sln)), "ActMod_a1", h+6, 36, Color(5,40,50,ss.Alpa) )
				draw.SimpleText( A_AM.ActMod:ReString(string.sub(uicon,sln)), "ActMod_a1", h+5, 35, Color(255,255,215,ss.Alpa) )
				surface.SetDrawColor(Color(255,255,255,ss.Alpa))
				surface.SetMaterial( Material(LIcon, "noclamp smooth") )
				surface.DrawTexturedRect(w-h/1.5-5, h/2-h/3, h/1.5, h/1.5)
				draw.SimpleText( "[ ".. NIcon .." ]", "ActMod_a1", w-h/1.5-10, h/2, Color(255,255,215,ss.Alpa) ,2,1 )
				
				end
			end
       end
	   
		pnl.DoClick = function(p)
			if Think_ok == "yes" then A_AM.ActMod:vShowunLock(1,datta.ok)
			elseif Think_ok == "Done" then
				A_AM.ActMod:Chicon(plist,A_AM.ActMod.ActLck[datta.ok]["T1"],true)
			elseif Think_ok == "no" then
				if AidW == 0 then gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=".. datta.idW)
				elseif AidW == 3 then
					if datta.idW == "2896053995" then if IsValid(sl) then sl:Remove() end LocalPlayer():ConCommand("garrydiva_chartmenu\n")
					elseif datta.idW == "2580513967" and AGetMapNow != "am4-game_lv1" then aChMap(LocalPlayer(),"GameRun Lv1","am4-game_lv1")
					end
				elseif datta.conntSv then
					local ASv_N,ASv_C,ASv_O = "[AM4]",datta.conntSv,"unknown"
					if LocalPlayer().ActMod_TabS1 and LocalPlayer().ActMod_TabS1["SVAM4_On"] then
						if LocalPlayer().ActMod_TabS1["SVAM4_Name"] then ASv_N = LocalPlayer().ActMod_TabS1["SVAM4_Name"] end
						if LocalPlayer().ActMod_TabS1["SVAM4_Connect"] then ASv_C = LocalPlayer().ActMod_TabS1["SVAM4_Connect"] end
						if LocalPlayer().ActMod_TabS1["SVAM4_On"] then ASv_O = LocalPlayer().ActMod_TabS1["SVAM4_On"] end
					end
					Derma_Query( string.format(aR:T("LAchievements_PGToSv"), ASv_N) .."\n\nName : ".. ASv_N .."\nAddress : ".. ASv_C .."\nStatus : ".. ASv_O , "ActMod :", aR:T("LORTR_No"),function() end
					,aR:T("LORTR_Yes"), function() RunConsoleCommand("connect",ASv_C) end)
				elseif datta.ongame then
					if datta.ok == "Avs_a1_3" then
						if IsValid(sl) then sl:Remove() end A_AM.ActMod:MunGam1Box()
					elseif datta.ok == "Avs_a3_4" then
						if IsValid(sl) then sl:Remove() end A_AM.ActMod:MListHlp(103)
					end
				end
			end
		end
		pnl.DoRightClick = function(p)
			if Think_ok == "Done" then
				surface.PlaySound("actmod/s/bell1.mp3")
				local aName = A_AM.ActMod:ReNameAct(A_AM.ActMod:ReString(string.sub(uicon,sln)))
				if hecode != "" then
					Derma_Query( aR:T("LAchievements_shCpl2") .."  ".. aName .."\n".. aR:T("LAchievements_heCode") .."  ".. hecode, aR:T("LAchievements") .." :", aR:T("LReplace_txt_REmott4"),function() end
					,aR:T("LReplace_txt_CopyName"), function() SetClipboardText(aName) end
					,aR:T("LReplace_txt_CopyCode"), function() SetClipboardText(hecode) end)
				else
					Derma_Query( aR:T("LAchievements_shCpl") .."  ".. aName, aR:T("LAchievements") .." :", aR:T("LReplace_txt_REmott4"),function() end
					,aR:T("LReplace_txt_CopyName"), function() SetClipboardText(aName) end)
				end
			elseif datta.copy and Think_ok == "no" then
				surface.PlaySound("actmod/s/copy1.mp3")
				SetClipboardText(datta.copy)
				if IsValid(pnl.txh) then pnl.txh:Remove() end
				pnl.txh = vgui.Create( "DLabel", pnl )
				pnl.txh:SetSize( pnl:GetWide()/2, pnl:GetTall() )
				pnl.txh:SetPos( pnl.txh:GetWide()/2, 0 ) pnl.txh:SetText("") pnl.txh:SetAlpha(255)
				pnl.txh:AlphaTo( 0,0.5,0.3,function(s) if IsValid(pnl.txh) then pnl.txh:Remove() end end )
				pnl.txh.Paint = function ( s, w, h ) draw.RoundedBox( 50, 0, h/3.5, w, h/2, Color(20,90,200,255) )
					draw.SimpleText( aR:T("LReplace_txt_CopyName"), "ActMod_a2", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
			end
		end
	end


function A_AM.ActMod:vShowunLock(sa,SDat)
	local bF = A_AM.ActMod.Settings["IconsActs"]
	local uicon = ""
	local hecode = ""
	local addZ = 0

	if A_AM.ActMod.ActLck[SDat] then
		local reNme
		for k2, v2 in ipairs(file.Find("materials/" .. bF .. "/*", "GAME")) do
			if not reNme and string.find(v2, A_AM.ActMod.ActLck[SDat]["T1"],nil,true) then
				if string.find(v2, "._so_.",nil,true) and string.find(v2, "._ef_.",nil,true) and string.find(v2, "._mo_.",nil,true) then
					reNme = v2
				elseif string.find(v2, "._so_.",nil,true) and string.find(v2, "._ef_.",nil,true) then
					reNme = v2
				elseif string.find(v2, "._so_.",nil,true) then
					reNme = v2
				elseif string.find(v2, "._ef_.",nil,true) then
					reNme = v2
				else
					reNme = v2
				end
			end
		end
		uicon = bF .."/".. reNme
		if A_AM.ActMod.ActLck[SDat]["T2"] != "" then addZ = 60 hecode = AG_BED(1,A_AM.ActMod.ActLck[SDat]["T2"]..A_AM.ActMod.ActLck[SDat]["T1"]) end
	end

	if SDat then AG_DatA(1,SDat,"yes") end
	local A0lpa = 200
	local Alpa = 300
	local Zlpa = 0
	local Zlpa2 = 50
	local StZ = false
	local eNameAct = A_AM.ActMod:ReNameAct(A_AM.ActMod:ReString(A_AM.ActMod.ActLck[SDat]["T1"]))
	
	local rh0 = vgui.Create( "DPanel" )
	rh0:SetSize(ScrW(),ScrH())
	rh0:SetText("") rh0:MakePopup()
	local confetti = {}
	for i = 1, 40 do
		table.insert(confetti, {
			x = math.random(10, rh0:GetWide()-10),
			y = math.random(-rh0:GetTall(), 0),
			speed = math.random(50, 150),
			color = Color(math.random(100,255), math.random(100,255), math.random(100,255)),
			size = math.random(4, 8)
		})
	end
	local confetti2 = {}
	local cenX, cenY = rh0:GetWide() / 2, rh0:GetTall() / 2.6
    local ExplosionConfig = {
        particleCount = 50,
        explosionPower = 350,
        gravity = 250,
        spreadAngle = 240,
        spreadOffset = 2.6,
        centerExpansion = 5
    }
	for i = 1, ExplosionConfig.particleCount do
		local angle = math.rad(math.random(0, ExplosionConfig.spreadAngle)) + ExplosionConfig.spreadOffset
		local speed = math.random(ExplosionConfig.explosionPower * 0.25, ExplosionConfig.explosionPower)
		table.insert(confetti2, {
			x = cenX + math.cos(angle) * ExplosionConfig.centerExpansion,
			y = cenY + math.sin(angle) * ExplosionConfig.centerExpansion,
			vx = math.cos(angle) * speed,
			vy = math.sin(angle) * speed,
			gravity = math.random(ExplosionConfig.gravity*0.5,ExplosionConfig.gravity),
			color = Color(math.random(100,255), math.random(100,255), math.random(100,255)),
			size = math.random(4, 8),
			rot = math.random(0, 360),
			rotspeed = math.random(-180, 180)
		})
	end
	rh0.tAlf = 1
	rh0.tGlAlf = 1
	rh0.tGlAle = 1
	rh0.tGlTim1 = CurTime()
	rh0.Paint = function ( ss, w, h )
		local dt = FrameTime()
		local TAAA = math.Clamp((CurTime() - (ss.tGlTim1+0.2))/0.2,0,1)*ss.tAlf
		if A0lpa > 0 then A0lpa = math.max(0,A0lpa - 80*dt) draw.RoundedBox( 0, 0, 0, w, h, Color(240,245,255,math.Clamp(A0lpa,0,255)) ) end
		draw.RoundedBox( 0, 0, 0, w, h, Color(10,30,50,math.Clamp(255*ss.tAlf,0,200)) )
		if ss.tTim1 then ss.tAlf = math.Clamp((ss.tTim1 - CurTime()),0,1) end
		for _, c in ipairs(confetti) do
			c.color.a = 255*TAAA
			surface.SetDrawColor(c.color)
			surface.DrawRect(c.x, c.y, c.size, c.size)
			c.y = c.y + dt * c.speed
			if c.y > h then table.RemoveByValue( confetti, c ) end
		end
		for _, c in ipairs(confetti2) do
			c.color.a = 255*TAAA
			surface.SetDrawColor(c.color)
			surface.DrawRect(c.x, c.y, c.size, c.size)
			c.x = c.x + c.vx * dt
			c.y = c.y + c.vy * dt
			c.vy = c.vy + c.gravity * dt
			c.vx = c.vx * (1 - dt * 0.1)
			if c.y > h then table.RemoveByValue( confetti2, c ) end
		end
		ss.tGlAlf = math.Clamp((CurTime() - ss.tGlTim1)/0.3,0,1)
		ss.tGlAle = math.Clamp((ss.tGlTim1 - CurTime())/3+1,0,1)
		local aaf = ss.tGlAlf*ss.tGlAle
		if aaf > 0 then
			local Zaa = 200 + (400*aaf)
			surface.SetDrawColor(Color(255,255,255,255*aaf))
			surface.SetMaterial( Material("actmod/eff_particle/p_glow_01") )
			surface.DrawTexturedRect(w/2-Zaa/2, h/2-Zaa/2, Zaa, Zaa)
		end
	end

	local rh = vgui.Create( "DPanel" ,rh0 )
	rh.OnRemove = function( pan ) if IsValid(rh0) then rh0:Remove() end end
	rh:SetSize(200,300+addZ) rh:Center()
	rh:SetText("")
	rh:SetAlpha(0) rh:AlphaTo(255,0.3,0,function(s) if IsValid(rh) then StZ = true end end )
	rh.Done = false
	rh.Paint = function ( s, w, h )
		local TAAA = math.Clamp((CurTime() - (rh0.tGlTim1+0.3))/0.6,0,1)
		draw.RoundedBox( 0, 0, 0, w, h, Color(40,100,120,255) )
		draw.RoundedBox( 10, 5, 5, w-10, h-10, Color(40,100,150,255) )
		surface.SetDrawColor(Color(255,255,255,100))
		surface.SetMaterial( Material("gui/gradient_up") ) surface.DrawTexturedRect(5, 5, w-10, h-10)
		if Alpa > -300 then
			if StZ == true then
				Alpa = math.max(-300,Alpa - 200*FrameTime())
				Zlpa = math.min(s:GetWide(),Zlpa + 380*FrameTime())
			end
		elseif Alpa <= -300 and rh.Done == false then
			Alpa = 300 Zlpa = 0
		end
		if Alpa > 0 then
			Zlpa2 = math.min(s:GetWide(),Zlpa2 + 210*FrameTime())
		elseif Alpa < 0 then
			Zlpa2 = math.max(s:GetWide()/2,Zlpa2 - 70*FrameTime())
		end
		surface.SetDrawColor(Color(255,255,255,math.max(0,math.min(255,255 * Alpa/255)))) surface.SetMaterial( Material("actmod/eff_particle/p_ring_wave") ) surface.DrawTexturedRect(s:GetWide()/2-Zlpa/2, s:GetWide()/2-Zlpa/2, Zlpa, Zlpa)
		surface.SetDrawColor(Color(255,255,255,255)) surface.SetMaterial( Material("actmod/eff_particle/p_glow_01") ) surface.DrawTexturedRect(s:GetWide()/2-Zlpa2/2, s:GetWide()/2-Zlpa2/2, Zlpa2, Zlpa2)
		surface.SetMaterial( Material(uicon, "noclamp smooth") ) surface.DrawTexturedRect(10, 10, s:GetWide()-20, s:GetWide()-20)
		draw.RoundedBox( 10, 20, h-100-addZ, w-40, 50, Color(30,50,60,255*TAAA) )
		draw.SimpleText( aR:T("LAchievements_UnLocked"), "ActMod_a1", s:GetWide()/2, h-85-addZ, Color(255,255,215,255*TAAA) ,1,1 )
		draw.SimpleText( eNameAct, "ActMod_a4", s:GetWide()/2, h-63-addZ, Color(255,255,215,255*TAAA) ,1,1 )
		if addZ != 0 then
			TAAA = math.Clamp((CurTime() - (rh0.tGlTim1+0.6))/0.9,0,1)
			draw.RoundedBox( 10, 20, h-100, w-40, 50, Color(30,50,60,255*TAAA) )
			draw.SimpleText( aR:T("LAchievements_heCode"), "ActMod_a2", 28, h-90, Color(255,255,215,255*TAAA) ,0,1 )
			draw.SimpleText( string.sub(hecode,1,25), "ActMod_a4", s:GetWide()/2, h-72, Color(255,255,215,255*TAAA) ,1,1 )
			draw.SimpleText( string.sub(hecode,26), "ActMod_a4", s:GetWide()/2, h-60, Color(255,255,215,255*TAAA) ,1,1 )
		end
		if rh.Done == true then draw.SimpleText( aR:T("LReplace_txt_Done"), "ActMod_a1", s:GetWide()/2, h-30, Color(255,255,215,255) ,1,1 ) end
	end
	rh.SBut = vgui.Create( "DButton", rh )
	rh.SBut:SetText( aR:T("ALanguage_ok") ) rh.SBut:SetFont("ActMod_a1")
	rh.SBut:SetTextColor( Color( 20, 5, 5 ) ) rh.SBut:SetSize( 100, 25 )
	rh.SBut:SetPos( rh:GetWide()/2-rh.SBut:GetWide()/2, rh:GetTall()-40 )
	rh.SBut:SetCursor( "arrow" ) rh.SBut:SetDisabled( true ) rh.SBut.OnOk = false
	rh.SBut:SetAlpha(0) rh.SBut:AlphaTo(255,1,1.7,function(s) timer.Simple(0.5,function() if IsValid(rh) then rh.SBut:SetDisabled( false ) rh.SBut:SetCursor( "hand" ) end end ) end )
	rh.SBut.tAlf = 1
	rh.SBut.tAle = 1
	rh.SBut.tTim1 = CurTime() + 2.2
	rh.SBut.Paint = function( ss, w, h )
		ss.tAlf = math.Clamp((CurTime() - ss.tTim1),0,1)
		ss.tAle = math.Clamp((ss.tTim1 - CurTime()+1.5),0,1)
		local aaf = ss.tAlf*ss.tAle
		if !ss:IsEnabled() then draw.RoundedBox( 10, 0, 0, w, h, Color( 100, 100, 100, 255 ) ) 
		elseif ss:IsHovered() then draw.RoundedBox( 10, 0, 0, w, h, ss:IsDown() and Color( 70, 120, 180, 255 ) or Color( 70, 180, 100, 255 ) ) 
		else draw.RoundedBox( 10, 0, 0, w, h, Color( 50, 150, 70, 255 ) )
		end
		if aaf > 0 then
			draw.RoundedBox( h/2, 0, 0, w, h, Color( 255, 255, 255, 255*aaf ) )
		end
	end
	rh.SBut.DoClick = function() 
		surface.PlaySound("actmod/s/button21.mp3") rh.Done = true
		rh:AlphaTo(0,0.5,0.2,function(s) if IsValid(rh) then rh:Remove() end end )
		if SDat then AG_DatA(1,SDat,"Done") end
		if IsValid(rh.SBut) then rh.SBut:Remove() end
		if IsValid(rh.CBut) then rh.CBut:Remove() end
		if IsValid(rh.DBut) then rh.CBut:Remove() end
		if IsValid(rh0) then rh0.tTim1 = CurTime() + 0.5 end
	end
	rh.CBut = vgui.Create( "DButton", rh )
	rh.CBut:SetText( "" ) rh.CBut:SetSize( rh:GetWide()-40, 50 )
	rh.CBut:SetPos( 20, rh:GetTall()-100-addZ )
	rh.CBut:SetCursor( "arrow" ) rh.CBut:SetDisabled( true )
	rh.CBut:SetAlpha(0) rh.CBut:AlphaTo(255,0.5,0.5,function(s) if IsValid(rh) then rh.CBut:SetDisabled( false ) rh.CBut:SetCursor( "hand" ) end end )
	rh.CBut.Paint = function( ss, w, h )
		if !ss:IsEnabled() then
		elseif ss:IsHovered() then draw.RoundedBox( 10, 0, 0, w, h, ss:IsDown() and Color( 70, 120, 200, 50 ) or Color( 100, 120, 130, 30 ) ) 
		end
	end
	rh.CBut.DoClick = function() 
		surface.PlaySound("actmod/s/copy1.mp3")
		SetClipboardText(eNameAct)
		if IsValid(rh.txh) then rh.txh:Remove() end
		rh.txh = vgui.Create( "DLabel", rh.CBut )
		rh.txh:SetSize( rh.CBut:GetWide(), rh.CBut:GetTall() )
		rh.txh:SetPos( 0, 0 ) rh.txh:SetText("") rh.txh:SetAlpha(255)
		rh.txh:AlphaTo( 0,0.5,0.5,function(s) if IsValid(rh.txh) then rh.txh:Remove() end end )
		rh.txh.Paint = function ( s, w, h ) draw.RoundedBox( 10, 0, 0, w, h, Color(20,90,200,255) )
		draw.SimpleText( aR:T("LReplace_txt_CopyName"), "ActMod_a2", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end
	if addZ != 0 then
		rh.DBut = vgui.Create( "DButton", rh )
		rh.DBut:SetText( "" ) rh.DBut:SetSize( rh:GetWide()-40, 50 )
		rh.DBut:SetPos( 20, rh:GetTall()-100 )
		rh.DBut:SetCursor( "arrow" ) rh.DBut:SetDisabled( true )
		rh.DBut:SetAlpha(0) rh.DBut:AlphaTo(255,0.5,0.5,function(s) if IsValid(rh) then rh.DBut:SetDisabled( false ) rh.DBut:SetCursor( "hand" ) end end )
		rh.DBut.Paint = function( ss, w, h )
			if !ss:IsEnabled() then
			elseif ss:IsHovered() then draw.RoundedBox( 10, 0, 0, w, h, ss:IsDown() and Color( 70, 120, 200, 50 ) or Color( 100, 120, 130, 30 ) ) 
			end
		end
		rh.DBut.DoClick = function()
			surface.PlaySound("garrysmod/balloon_pop_cute.wav")
			SetClipboardText(hecode)
			if IsValid(rh.txh) then rh.txh:Remove() end
			rh.txh = vgui.Create( "DLabel", rh.DBut )
			rh.txh:SetSize( rh.DBut:GetWide(), rh.DBut:GetTall() )
			rh.txh:SetPos( 0, 0 ) rh.txh:SetText("") rh.txh:SetAlpha(255)
			rh.txh:AlphaTo( 0,0.5,0.5,function(s) if IsValid(rh.txh) then rh.txh:Remove() end end )
			rh.txh.Paint = function ( s, w, h ) draw.RoundedBox( 10, 0, 0, w, h, Color(20,90,200,255) )
			draw.SimpleText( aR:T("LReplace_txt_CopyCode"), "ActMod_a2", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end
	end
	
	timer.Simple(30.5,function() if IsValid(rh) and not rh.Done then
		if IsValid(rh0) then rh0.tTim1 = CurTime() + 0.5 end
		if IsValid(rh.SBut) then rh.SBut:SetDisabled( true ) rh.SBut:SetCursor( "arrow" ) end
		rh:AlphaTo(0,0.5,0.2,function(s) if IsValid(rh) then rh:Remove() end end )
	end end)

	surface.PlaySound("actmod/s/getcart.mp3")
	return rh0
end



	local PANEL = {}
	function PANEL:Init()
	local ply = LocalPlayer()
	local bF = A_AM.ActMod.Settings["IconsActs"]
		if !file.Exists(A_AM.ActMod:GUniqueFiName(LocalPlayer()), "DATA") then AG_CDet() end
		local AisVR = A_AM.ActMod:IsVR(ply)
		self:SetSize(800, math.max(355, math.min(ScrH() / 1.3 ,680)))
		self:Center() self:SetTitle("")
		self:SetAlpha(0) self:AlphaTo(255,0.2,0.1)
		self:MakePopup()
		self:ShowCloseButton(false)
		if AisVR then self:SetPaintedManually(true) end
		self.alltask = 0
		self.tt = CurTime() + 0.7
		self.tta = AG_DatA(5)
		self.tye = AG_DatA(11) or 0
		self.Think = function(s) if (s.tt or 0) < CurTime() then s.tt = CurTime() + 0.7 s.tta = AG_DatA(5) s.tye = AG_DatA(11) end end
		self.OnRemove = function()
			if IsValid(self.aa_self) then self.aa_self:Remove() end
		end
		self.Paint = function( ss, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 70, 120, 160, 255 ) ) 
		draw.RoundedBox( 5, 10, 10, w-20, h-20, Color( 40, 50, 60, 255 ) ) 
		draw.SimpleText( aR:T("LAchievements_yor") .." ActMod ( ".. ss.tta .." / ".. ss.alltask .." )", "ActMod_a6", 90, 30, Color(255,255,215,255) )
		if ss.tye > 0 then local acw = math.max(0,math.min(100, 50+(100*math.sin(CurTime()*7))))
		draw.SimpleText( "* (".. ss.tye ..")", "ActMod_a6", w-80, 30, Color( 100+acw, 200+acw*0.5, 255, 255 ) ,2 ) end
		draw.SimpleText( aR:T("LAchievements_t_ihlp"), "ActMod_e1", ss:GetWide()/2, ss:GetTall()-80, Color(255,255,215,255) ,1 )
		draw.SimpleText( "code ActMod:", "ActMod_a1", 15, ss:GetTall()-50, Color(255,255,215,255) )
		end
		
		self.Pmdl = vgui.Create("DLabel", self)
		self.Pmdl:SetText( "" )
		self.Pmdl:SetPos(15, 10)
		self.Pmdl:SetSize(60, 60)
		self.Pmdl:SetAlpha(0) self.Pmdl:AlphaTo(255,0.2,0.2)	
		
		self.Tmdl = vgui.Create("DModelPanel", self.Pmdl)
		self.Tmdl:Dock(FILL)
		self.Tmdl:SetAlpha(0) self.Tmdl:AlphaTo(255,0.4)
		self.Tmdl:SetModel("models/maxofs2d/logo_gmod_b.mdl")
		self.Tmdl:SetCamPos(Vector(240, 0, 0))
		self.Tmdl:SetLookAt(Vector(0, 0, 0))
		self.Tmdl:SetFOV(40)
		function self.Tmdl:LayoutEntity(ent)
			ent:SetAngles(Angle(0, 40*math.sin(CurTime()*0.5),  0))
		end
			
		self.SBut = vgui.Create( "DButton", self )
		self.SBut:SetText( "X" )
		self.SBut:SetFont("ActMod_a1")
		self.SBut:SetAlpha(0)
		self.SBut:SetTextColor( Color( 20, 5, 5 ) )
		self.SBut:SetPos( self:GetWide()-50, -50 )
		self.SBut:SetSize( 30, 30 )
		self.SBut:AlphaTo(255,0.3,0.5)
		self.SBut:MoveTo( self:GetWide()-50, 20, 0.4,0.3 )
		self.SBut.Paint = function( ss, w, h )
			if ss:IsHovered() then
				draw.RoundedBox( 4, 0, 0, w, h, Color( 160, 100, 85, 255 ) ) 
			else
				draw.RoundedBox( 4, 0, 0, w, h, Color( 120, 70, 70, 255 ) ) 
			end
		end
		self.SBut.DoClick = function() 
			surface.PlaySound("actmod/s/click01.mp3")
			if IsValid(self) then self:Remove() end
		end

		local frame = vgui.Create('DPanel',self)
		frame:SetPos( 20, 70 )
		frame:SetSize(self:GetWide()-40, self:GetTall()-160)
		frame.Paint = function(p, w, h)
		draw.RoundedBox( 5, 0, 0, w, h, Color( 10, 50, 150, 150 ) )
		surface.SetDrawColor(Color(255,255,255,100)) surface.SetMaterial( Material("gui/gradient_down") ) surface.DrawTexturedRect(0, 0, w, h)
		end
		local plist = frame:Add('AM4_DScrollPanel')
		plist:Dock(FILL)
		local OnServ = ply.ActMod_TabTSrvr and ply.ActMod_TabTSrvr == 1
		local txtDTIP = "»!:✓"
		if OnServ then
			title(plist, aR:T("LAchievements_a1_b"))
			ic_dit(plist, {
				icon = "hud/killicons/default" ,ok = "Avs_a1_1" ,oning = 50 ,conntSv = "209.222.97.134:27017"
				,nemu = string.format(aR:T("LAchievements_a1_m1"), "50") ,missin = string.format(aR:T("LAchievements_a1_i1"), "50")
			},self)
			ic_dit(plist, {
				icon = "hud/killicons/default" ,ok = "Avs_a4_2" ,oning = 100 ,conntSv = "209.222.97.134:27017"
				,nemu = string.format(aR:T("LAchievements_a1_m1"), "100") ,missin = string.format(aR:T("LAchievements_a1_i1"), "100")
			},self)
			ic_dit(plist, {
				icon = "hud/killicons/default" ,ok = "Avs_a3_7" ,oning = 250 ,conntSv = "209.222.97.134:27017"
				,nemu = string.format(aR:T("LAchievements_a1_m1"), "250") ,missin = string.format(aR:T("LAchievements_a1_i1"), "250")
			},self)
			ic_dit(plist, {
				icon = "icon16/time.png" ,ok = "Avs_a1_2" ,oning = 35 ,conntSv = "209.222.97.134:27017"
				,nemu = aR:T("LAchievements_a1_m2") ,missin = aR:T("LAchievements_a1_i2")
			},self)
			ic_dit(plist, {
				icon = "icon64/tool.png" ,ok = "Avs_a1_3" ,oning = 3 ,conntSv = "209.222.97.134:27017"
				,nemu = aR:T("LAchievements_a1_m3") ,missin = aR:T("LAchievements_a1_i3")
			},self)
		else
			title(plist, aR:T("LAchievements_a1_b_n1"))
			ic_dit(plist, {
				icon = "entities/npc_zombie.png" ,ok = "Avs_a1_1" ,oning = 50
				,nemu = string.format(aR:T("LAchievements_a1_m1"), "50") .."  +[".. txtDTIP .."]" ,missin = string.format(aR:T("LAchievements_a1_i1_n1"), "50", "Fists (Gmod)")
			},self)
			ic_dit(plist, {
				icon = "entities/npc_zombie.png" ,ok = "Avs_a4_2" ,oning = 100
				,nemu = string.format(aR:T("LAchievements_a1_m1"), "100") .."  +[".. txtDTIP .."]" ,missin = string.format(aR:T("LAchievements_a1_i1_n1"), "100", "SMG")
			},self)
			ic_dit(plist, {
				icon = "entities/npc_zombie.png" ,ok = "Avs_a3_7" ,oning = 250
				,nemu = string.format(aR:T("LAchievements_a1_m1"), "250") .."  +[".. txtDTIP .."]" ,missin = string.format(aR:T("LAchievements_a1_i1_n1"), "250", "SMG")
			},self)
			ic_dit(plist, {
				icon = "icon16/time.png" ,ok = "Avs_a1_2" ,oning = 35 ,nemu = aR:T("LAchievements_a1_m2_n1") ,missin = aR:T("LAchievements_a1_i2_n1")
			},self)
			ic_dit(plist, {
				icon = "icon64/tool.png" ,ok = "Avs_a1_3",oning = 3 ,ongame = true ,nemu = aR:T("LAchievements_a1_m3") ,missin = aR:T("LAchievements_a1_i3_n1")
			},self)
		end
		title(plist,"A") title(plist) title(plist, aR:T("LAchievements_a3_b"))
		ic_dit(plist, {
			icon = "actmod/imenu/amap_gamerenl1.png" ,ok = "Avs_a3_1" ,idW = "2580513967"
			,nemu = aR:T("LAchievements_a3_m1") ,missin = aR:T("LAchievements_a3_i1")
		},self)
		ic_dit(plist, {
			icon = "actmod/imenu/a3_2.png" ,ok = "Avs_a3_2" ,copy = "California Girls"
			,nemu = aR:T("LAchievements_a3_m2") ,missin = aR:T("LAchievements_a3_i2")
		},self)
		ic_dit(plist, {
			icon = "actmod/imenu/a4_4.png" ,ok = "Avs_a4_4" ,copy = "Flapper"
			,nemu = aR:T("LAchievements_a3_m2") ,missin = aR:T("LAchievements_a4_i4")
		},self)
		title(plist,"A") title(plist) title(plist, aR:T("LAchievements_a2_b"))
		if OnServ then
			ic_dit(plist, {
				icon = "actmod/imenu/v_1.png" ,ok = "Avs_a3_4" ,ongame = true
				,nemu = aR:T("LAchievements_a3_m4") ,missin = aR:T("LAchievements_a3_i4")
			},self)
		else
			ic_dit(plist, {
				icon = "actmod/imenu/v_1.png" ,ok = "Avs_a3_4" ,nemu = aR:T("LAchievements_a3_m4") ,missin = aR:T("LAchievements_a3_i4_n1")
			},self)
		end
		ic_dit(plist, {
			icon = "actmod/imenu/v_fl.png" ,ok = "Avs_a3_8"
			,nemu = aR:T("LAchievements_a3_m8") ,missin = aR:T("LAchievements_a3_i8")
		},self)
		ic_dit(plist, {
			icon = bF.. "/amod_am4_levepalestina.png" ,copy = "Leve Palestina" ,ok = "Avs_a3_6"
			,nemu = aR:T("LAchievements_a3_m6") ,missin = aR:T("LAchievements_a3_i6")
		},self)
		ic_dit(plist, {
			icon = bF.. "/amod_mmd_dance_specialist.png" ,copy = "Specialist" ,ok = "Avs_a2_1"
			,nemu = aR:T("LAchievements_a2_m1") ,missin = aR:T("LAchievements_a2_i1")
		},self)
		ic_dit(plist, {
			icon = "actmod/imenu/i_thumbsup.png" ,ok = "Avs_a2_7" ,copy = "Thumbs Up"
			,nemu = aR:T("LAchievements_a2_m7") ,missin = aR:T("LAchievements_a2_i7")
		},self)
		ic_dit(plist, {
			icon = "actmod/imenu/TheatricalMMD_1.png" ,ok = "Avs_a2_6" ,idW = "2567449282"
			,nemu = aR:T("LAchievements_a2_m6") ,missin = string.format(aR:T("LAchievements_a2_i6"), "Theatrical Chaos")
		},self)
		ic_dit(plist, {
			icon = "actmod/imenu/TheatricalMMD_2.png" ,ok = "Avs_a3_3" ,idW = "2567449282"
			,nemu = aR:T("LAchievements_a2_m6") ,missin = string.format(aR:T("LAchievements_a2_i6"), "PV120 - Shake it")
		},self)
		ic_dit(plist, {
			icon = "actmod/imenu/GDiva_image.png" ,ok = "Avs_a4_1" ,oning = 6 ,idW = "2896053995"
			,nemu = aR:T("LAchievements_a2_m4") .."  [ 20,000 ]" ,missin = string.format(aR:T("LAchievements_a2_i4"), "20,000") .."   ".. string.format(aR:T("LAchievements_a2_i4t"), "6")
		},self)
		ic_dit(plist, {
			icon = "actmod/imenu/GDiva_image.png" ,ok = "Avs_a3_9" ,oning = 3 ,idW = "2896053995"
			,nemu = aR:T("LAchievements_a2_m4") .."  [ 40,000 ]" ,missin = string.format(aR:T("LAchievements_a2_i4"), "40,000") .."   ".. string.format(aR:T("LAchievements_a2_i4t"), "3")
		},self)
		ic_dit(plist, {
			icon = "actmod/imenu/GDiva_image.png" ,ok = "Avs_a2_5" ,idW = "2896053995"
			,nemu = aR:T("LAchievements_a2_m4") .."  [ 90,000 ]" ,missin = string.format(aR:T("LAchievements_a2_i4"), "90,000")
		},self)
		ic_dit(plist, {
			icon = "actmod/imenu/GDiva_image.png" ,ok = "Avs_a2_4" ,oning = 2 ,idW = "2896053995"
			,nemu = aR:T("LAchievements_a2_m4") .."  [ 100,000 ]" ,missin = string.format(aR:T("LAchievements_a2_i4"), "100,000") .."   ".. string.format(aR:T("LAchievements_a2_i4t"), "2")
		},self)
		ic_dit(plist, {
			icon = "entities/npc_antlionguard.png" ,ok = "Avs_a2_2" ,nemu = aR:T("LAchievements_a2_m2") .."  +[".. txtDTIP .."]" ,missin = aR:T("LAchievements_a2_i2")
		},self)
		ic_dit(plist, {
			icon = "entities/combineelite.png" ,ok = "Avs_a2_3" ,nemu = aR:T("LAchievements_a2_m3") ,missin = aR:T("LAchievements_a2_i3")
		},self)
		ic_dit(plist, {
			icon = "entities/npc_headcrab.png" ,ok = "Avs_a2_8" ,oning = 15
			,nemu = aR:T("LAchievements_a2_m8") .."  +[".. txtDTIP .."]" ,missin = aR:T("LAchievements_a2_i8")
		},self)
		ic_dit(plist, {
			icon = "entities/npc_manhack.png" ,ok = "Avs_a2_9" ,oning = 25
			,nemu = aR:T("LAchievements_a2_m9") .."  +[".. txtDTIP .."]" ,missin = aR:T("LAchievements_a2_i9")
		},self)
		ic_dit(plist, {
			icon = "entities/npc_poisonzombie.png" ,ok = "Avs_a3_5" ,oning = 13
			,nemu = aR:T("LAchievements_a3_m5") .."  +[".. txtDTIP .."]" ,missin = aR:T("LAchievements_a3_i5")
		},self)
		ic_dit(plist, {
			icon = "entities/npc_hunter.png" ,ok = "Avs_a4_3" ,oning = 7
			,nemu = aR:T("LAchievements_a4_m3") .."  +[".. txtDTIP .."]" ,missin = aR:T("LAchievements_a4_i3")
		},self)
		title(plist,"A")

		self.searchBox = self:Add( "DTextEntry" )
		self.searchBox:SetSize( 500,25 ) self.searchBox:SetFont("ActMod_a5")
		self.searchBox:SetPos( 150,self:GetTall()-48 )
		self.searchBox:SetPlaceholderText( " ".. aR:T("LAchievements_Ecode") )
		
		self.SBut = vgui.Create( "DButton", self )
		self.SBut:SetText( "Enter" ) self.SBut:SetFont("ActMod_a1")
		self.SBut:SetTextColor( Color( 20, 5, 5 ) )
		self.SBut:SetPos( 670, self:GetTall()-50 ) self.SBut:SetSize( 100, 30 )
		self.SBut.Paint = function( ss, w, h )
			if self.searchBox:GetValue() == "" then draw.RoundedBox( 10, 0, 0, w, h, Color( 120, 120, 120, 255 ) )
			elseif ss:IsHovered() then draw.RoundedBox( 10, 0, 0, w, h, ss:IsDown() and Color( 100, 190, 145, 255 ) or Color( 100, 130, 145, 255 ) )
			else draw.RoundedBox( 10, 0, 0, w, h, Color( 150, 140, 80, 255 ) )
			end
		end
		self.SBut.DoClick = function()
			local gTXT = self.searchBox:GetValue()
			gTXT = gTXT:gsub("%s+$", "")
			if gTXT == "" then return end
			local Gt,Gn = "",""
			if ply.GetTable_Avs then
				for k, v in pairs(A_AM.ActMod.ActLck) do
					if v["T2"] != "" and AG_BED(2,gTXT) == v["T2"]..v["T1"] then
						Gt = k  Gn = v["T1"]
					end
				end
				if A_AM.ActMod.ActuLck and istable(A_AM.ActMod.ActuLck) and A_AM.ActMod.ActuLck[AG_BED(2,"QU00X0F2cw==")] then
					for k, v in pairs(A_AM.ActMod.ActuLck) do
						if v != "" and k != AG_BED(2,"QU00X0F2cw==") and AG_BED(2,gTXT) == AG_BED(2,v) then
							Gt = k  Gn = AG_BED(2,AG_BED(2,v))
						end
					end
				end
				if A_AM.ActMod.ActuAck and istable(A_AM.ActMod.ActuAck) and A_AM.ActMod.ActuAck[AG_BED(2,"QU00X0F2cw==")] then
					for k, v in pairs(A_AM.ActMod.ActuAck) do
						if v != "" and k != AG_BED(2,"QU00X0F2cw==") and gTXT == v["Pa"] then
							Gt = k
							Gn = v["Em"]
						end
					end
				end
				if ply.ActMod_TabTSrvr and ply.ActMod_TabTSrvr == 1 then
				else
					if AG_BED(1,gTXT) == "QWhtZWRNYWtlNDAw" then
						Gt = AG_BED(2,"QXZzX2EzXzQ=")
						Gn = AG_BED(2,"YW1vZF9tbWRfaGlhc29iaQ==")
					end
				end
				if AG_BED(1,gTXT) == "TG9uZyBsaXZlIFBhbGVzdGluZQ==" then
					Gt = AG_BED(2,"QXZzX2EzXzg=")
					Gn = AG_BED(2,"YW1vZF9kcmlwXzAx")
				end
				if Gt and Gt != "" and ply.GetTable_Avs[Gt] then
					AG_DatA(6)
					if ply.GetTable_Avs[Gt]["ok"] == "Done" then
						surface.PlaySound("actmod/s/warning.mp3")
						local aName = A_AM.ActMod:ReNameAct(A_AM.ActMod:ReString(Gn))
						Derma_Query( aR:T("LAchievements_coderau") .."  ".. aName, "code ActMod", aR:T("LReplace_txt_ok"),function()
						end, aR:T("LReplace_txt_CopyName"), function() SetClipboardText(aName) end)
					else
						A_AM.ActMod:vShowunLock(1,Gt)
					end
				else
					surface.PlaySound("actmod/s/button19.mp3") Derma_Message( aR:T("LAchievements_codeEr"), "code ActMod", aR:T("LReplace_txt_ok") )
				end
			end
		end
	end

	vgui.Register( "ActMod_Avs", PANEL, "DFrame" )

	local PANEL = {}
	function PANEL:Init()
		local bF = A_AM.ActMod.Settings["IconsActs"]
		local aw,ah = ScrW()/math.Rand(1.5,2.5),ScrH()/math.Rand(1.5,2.5)
		local zw,zh = 200, 50
		local Alpa = 355
		local Alpha_on = false
		local Zitxt,aaz = 100,math.Rand(110,50)
		local Apag = "vgui/notices/hint"
		local Anna = "nil_"
		local Apng = false
		self:MakePopup()
		self:SetMouseInputEnabled(false)
		self:SetKeyboardInputEnabled( false )
		self:SetSize(50, 50) self:SetText("")
		self:SetPos( -self:GetWide()-5, -self:GetTall()-5 )
		self:SetAlpha(0) self:AlphaTo(255,0.2,0.2)
		
		timer.Simple(0.1,function() if IsValid(self) then 
			if self.kNumw and self.kNumh then
				aaz = 50+zh*self.kNumw
				aw = math.Clamp(300+zw*(self.kNumw*0.4)+10,0,ScrW())
				ah = math.Clamp(ScrH()-(80+zh*(self.kNumh*1.1)),0,ScrH()-50)
			end
			if self.pag then Apag = self.pag end
			if self.nna then Anna = self.nna end
			if self.Typ == 2 then
				self:SetPos( -self:GetWide()-5, ah-self:GetTall()/2 )
				self:MoveTo( self:GetWide()/2, ah-self:GetTall()/2, 0.4 )
			else
				self:SetPos( aw-self:GetWide()/2, -self:GetTall()-5 )
				self:MoveTo( aw-self:GetWide()/2, aaz-self:GetTall()/2, 0.4 )
			end
		end end)
		timer.Simple(0.5,function() if IsValid(self) then Alpha_on = true
			if string.find(Apag, ".png") then Apng = true end
			if self.Typ == 2 then
				Zitxt = math.max(160,A_AM.ActMod:AZtxt(Anna,"ActMod_e1") +55) self:MoveTo( 25, ah-self:GetTall()/2, 0.5 )
			else
				Zitxt = math.max(160,A_AM.ActMod:AZtxt(Anna,"ActMod_e1") +93) self:MoveTo( aw-Zitxt/2, aaz-self:GetTall()/2, 0.5 )
			end
			self:SizeTo( Zitxt,zh, 0.5 )
			timer.Simple(3,function() if IsValid(self) then
				if self.Typ == 2 then
					self:MoveTo( -(self:GetWide()+5), ah-self:GetTall()/2, 2.5 )
				else
					self:MoveTo( aw-Zitxt/2, -(self:GetTall()+5), 2.5 )
				end
				self:AlphaTo(0,1.0,1.5,function(s) if IsValid(self) then self:Remove() end end )
			end end)
		end end)
		self.Think = function(p) 
			if Alpha_on == true and Alpa > 0 then
			Alpa = math.max(0,Alpa - 500*FrameTime())
			end
		end
		self.Paint = function ( s, w, h )
			draw.RoundedBox( 5+(h/2*Alpa/255), 0, 0, w, h, Color(80,80,100,255) )
			draw.RoundedBox( h/2*Alpa/255, 5, 5, w-10, h-10, Color(50,100,150,255) )
			if Alpa < 200 then
				surface.SetDrawColor(Color(255,255,255,255))
				if Apng == true then surface.SetMaterial( Material(Apag, "noclamp smooth") )
				else surface.SetMaterial( Material(Apag) ) end
				surface.DrawTexturedRect(5+(5*Alpa/50), 5, h-10, h-10)
				if self.Typ != 2 then
				surface.SetMaterial( Material("actmod/showeror/ye.png", "noclamp smooth") )
				surface.DrawTexturedRect(s:GetWide()-(40+(5*Alpa/50)), 10, h-20, h-20)
				end
				draw.SimpleText( "ActMod :", "ActMod_a4", s:GetWide()/2, 8, Color(255,255,255,255) ,1 )
				draw.SimpleText( Anna, "ActMod_e1", 48, 25, Color(255,255,255,255) )
			end
			if Alpa > 0 then
				draw.RoundedBox( h/2*Alpa/255, 0, 0, w, h, Color(255,255,255,255 * Alpa/255) )
				surface.SetDrawColor(Color(255,255,255,255 * Alpa/255))
				surface.SetMaterial( Material("actmod/showeror/ir.png", "noclamp smooth") )
				surface.DrawTexturedRect(s.Typ == 2 and 0 or s:GetWide()/2-25, 0, 50, 50)
			end
		end
	end
	vgui.Register( "ActMod_Avs_Done", PANEL, "DLabel" )



	
	local function aMeBu( a,aa,aba,az,aN,plst )
		local bF = A_AM.ActMod.Settings["IconsActs"]
		local ply = LocalPlayer()
		local vCs,BZz
		local aO = 0.2
		local aS = 0.2
		local aSi = 30
		local aSi2 = 25
		local aSi3 = -2
		local function getIntercept(x, y, radius, angle, w, h) return (x + (radius * math.sin( angle ))-(w or 0)), (y + (radius * -math.cos( angle ))-(h or 0)) end
		
		if aba then vCs = aba else vCs = A_AM.ActMod.Actoji.Frame end
		if az then BZz = az else BZz = A_AM.ActMod.Actoji.ButtonSize end
		local es = vgui.Create( "DPanel", vCs )
		es:SetSize(BZz, BZz)
		local tx, ty
		if GetConVarNumber("actmod_cl_sortemote") == 2 then
			tx, ty = a,aa
		else
			tx, ty = getIntercept(aba:GetWide()/2, aba:GetTall()/2, aba:GetWide()/3, a, es:GetWide()/2, es:GetTall()/2)
		end
		es:SetPos( tx, ty )
		es:SetSize(BZz, BZz)
		es:SetText("")
		es:SetAlpha(0)
		es.Paint = function ( ste, w, h )
			if (ply.ActMod_TimMenRe or 0) < CurTime() then surface.SetDrawColor(Color(255,255,255,255)) else surface.SetDrawColor(Color(255,100,100,255)) end
			surface.SetMaterial( Material("actmod/sm_hover.png", "noclamp smooth") )
			surface.DrawTexturedRect(0, 0, w, h)
		end
		
		local e = vgui.Create( "DButton", vCs )
		e.OnRemove = function( pan ) if IsValid(es) then es:Remove() end end
		e:SetText("")
		e:SetAlpha(0)
		e:AlphaTo(200,aO)
		e.Slot = aN
		
		local ActojiData_1,ActojiData_2
		local TActData = A_AM.ActMod:GetEmoIcn( aN,A_AM.ActMod:ActaLoed(A_AM.ActMod:ActojTyp(aN),A_AM.ActMod.aNTyp[aN]) )
		if TActData and istable(TActData) and TActData[1] and TActData[2] then
			A_AM.ActMod.Actoji.table[aN] = TActData[2]
			ActojiData_1 = TActData[1]
			ActojiData_2 = TActData[2]
		else
			A_AM.ActMod.Actoji.table[aN] = ""
		end
		
		e.Material = ActojiData_1
		e.Actoji = ActojiData_2
		e.TActoji = ActojiData_2
		e.TActojim = ActojiData_1
		e.N__i = 0  ActojiData_1 = nil  ActojiData_2 = nil
	
		if GetConVar("actmod_sv_avs"):GetInt() > 0 then
			timer.Simple(0.1,function() if IsValid(ply) and IsValid(e) then
				if A_AM.ActMod:LokTabData( ply, A_AM.ActMod.ActLck, A_AM.ActMod:ReString(e.Actoji) ) == true then
					e.GLok = true
				else
					e.GLok = false
				end
			end end)
		end
		
		
		e.DoClick = function ( s ) if !s.Actoji then return end
			surface.PlaySound("garrysmod/ui_click.wav")
			A_AM.ActMod.Actoji.table[aN] = aba.GTTebl_i[1]
			A_AM.ActMod:ReAddEmts("savemots",{A_AM.ActMod:ActojTyp(aN),A_AM.ActMod.aNTyp[aN],aba.GTTebl_i[e.N__i]},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
			e.Material = Material(bF .."/".. A_AM.ActMod.Actoji.table[aN], "noclamp smooth")
			e.Actoji = A_AM.ActMod.Actoji.table[aN]
		end
		e.DoRightClick = function ( s )
			surface.PlaySound("garrysmod/ui_return.wav")
			A_AM.ActMod.Actoji.table[aN] = e.TActoji
			A_AM.ActMod:ReAddEmts("savemots",{A_AM.ActMod:ActojTyp(aN),A_AM.ActMod.aNTyp[aN],e.TActoji},nil,function(t,g) A_AM.ActMod:RCFi(t,g) end)
			e.Material = e.TActojim
			e.Actoji = A_AM.ActMod.Actoji.table[aN]
		end
		
		e.b = false
		e.a = true
		e:SetSize( BZz, BZz )
		local x, y
		if GetConVarNumber("actmod_cl_sortemote") == 2 then
			x, y = a,aa
		else
			x, y = getIntercept(vCs:GetWide()/2, vCs:GetTall()/2, vCs:GetWide()/3, a, e:GetWide()/2, e:GetTall()/2)
		end
		e:SetSize( BZz, BZz )
		e:SizeTo( BZz, BZz, aO,0,-1,function(t,s) s.a = false end )
		e:SetPos( x+5, y+5 )
		e:MoveTo( x, y, aO )
		e.posX = x e.posY = y
		e.Think = function ( s )
			if s:IsHovered() then
				if s.a or e.b then return end s.a = true
				s:AlphaTo(255,aS) es:AlphaTo(255,aS)
				s:MoveTo( s.posX-(aSi/2), s.posY-(aSi/2), aS ) es:MoveTo( s.posX-(aSi2/2), s.posY-(aSi2/2), aS )
				s:SizeTo( BZz+aSi, BZz+aSi, aS,0,-1,function(t,s) s.a = false s.b = true end )
				es:SizeTo( BZz+aSi2, BZz+aSi2, aS,0,-1,function(t,s) s.a = false s.b = true end )
				if IsValid(aba) then aba.aIsHovered = CurTime() + 0.2 end
			else
				if s.a or !s.b then return end s.a = true
				s:AlphaTo(180,aS) es:AlphaTo(0,aS)
				s:MoveTo( s.posX, s.posY, aS ) es:MoveTo( s.posX, s.posY, aS )
				s:SizeTo( BZz, BZz, aS,0,-1,function(t,s) s.a = false s.b = false end )
				es:SizeTo( BZz, BZz, aS,0,-1,function(t,s) s.a = false s.b = false end )
			end
		end
		e.Paint = function ( s, w, h )
			if !s.Material then return end
			surface.SetDrawColor(color_white)
			surface.SetMaterial( s.Material )
			if s:IsHovered() then
				if IsValid(aba) then aba.Afh_atrue = CurTime() + 0.11
				if aba.Afh_StPos then
					aba.Afh_StPos[1] = Lerp(0.2, aba.Afh_StPos[1],s:GetX()+s:GetWide()/2)
					aba.Afh_StPos[2] = Lerp(0.2, aba.Afh_StPos[2],s:GetY()+s:GetTall()/2)
				else
					aba.Afh_StPos = {s:GetX()+s:GetWide()/2,s:GetY()+s:GetTall()/2}
				end
				end
				local asc = 5+(5*math.sin(CurTime()*4))
				surface.DrawTexturedRect(asc/2, asc/2, w-asc, h-asc)
			else
				surface.DrawTexturedRect(0,0, w,h)
			end
		end
		if IsValid(plst) then
			if not istable(plst.TabEmots) then plst.TabEmots = {} end
			plst.TabEmots[aN] = e
		end
		return e
	end
	
	local At = {
		[1] = { [1] = 1 ,[2] = 2 ,[3] = 3 ,[4] = 4 ,[5] = 5 ,[6] = 6 ,[7] = 7 ,[8] = 8 }
		,[2] = { [1] = 9 ,[2] = 10 ,[3] = 11 ,[4] = 12 ,[5] = 13 ,[6] = 14 ,[7] = 15 ,[8] = 16 }
		,[3] = { [1] = 22 ,[2] = 23 ,[3] = 24 ,[4] = 25 ,[5] = 26 ,[6] = 27 ,[7] = 28 ,[8] = 29 }
		,[4] = { [1] = 30 ,[2] = 31 ,[3] = 32 ,[4] = 33 ,[5] = 34 ,[6] = 35 ,[7] = 36 ,[8] = 37 }
		,[5] = { [1] = 38 ,[2] = 39 ,[3] = 40 ,[4] = 41 ,[5] = 42 ,[6] = 43 ,[7] = 44 ,[8] = 45 }
		,[6] = { [1] = 46 ,[2] = 47 ,[3] = 48 ,[4] = 49 ,[5] = 50 ,[6] = 51 ,[7] = 52 ,[8] = 53 }
		,[7] = { [1] = 54 ,[2] = 55 ,[3] = 56 ,[4] = 57 ,[5] = 58 ,[6] = 59 ,[7] = 60 ,[8] = 61 }
		,[8] = { [1] = 62 ,[2] = 63 ,[3] = 64 ,[4] = 65 ,[5] = 66 ,[6] = 67 ,[7] = 68 ,[8] = 69 }
	}
    local function Siqit(plst,aSe)
		local An = 1
		if aSe then
			An = aSe
		else
			if GetConVarNumber("actmod_cl_pageslot") > 7 then
				An = 8
			elseif GetConVarNumber("actmod_cl_pageslot") > 6 then
				An = 7
			elseif GetConVarNumber("actmod_cl_pageslot") > 5 then
				An = 6
			elseif GetConVarNumber("actmod_cl_pageslot") > 4 then
				An = 5
			elseif GetConVarNumber("actmod_cl_pageslot") > 3 then
				An = 4
			elseif GetConVarNumber("actmod_cl_pageslot") > 2 then
				An = 3
			elseif GetConVarNumber("actmod_cl_pageslot") > 1 then
				An = 2
			end
		end
		local GBse,Gzz = plst,50
		if GetConVarNumber("actmod_cl_sortemote") == 2 then
			local GTup = 20
			local Ms = 20
			local GTdo = plst:GetTall()-70
			aMeBu( 20,GTup,GBse,Gzz,At[An][1],plst )
			aMeBu( 55+Ms,GTup,GBse,Gzz,At[An][2],plst )
			aMeBu( 85+Ms*2,GTup,GBse,Gzz,At[An][3],plst )
			aMeBu( 120+Ms*3,GTup,GBse,Gzz,At[An][4],plst )
			aMeBu( 20,GTdo,GBse,Gzz,At[An][5],plst )
			aMeBu( 55+Ms,GTdo,GBse,Gzz,At[An][6],plst )
			aMeBu( 85+Ms*2,GTdo,GBse,Gzz,At[An][7],plst )
			aMeBu( 120+Ms*3,GTdo,GBse,Gzz,At[An][8],plst )
			GTup = nil  Ms = nil  GTdo = nil
		else
			local pi = 3.14159265
			local pr = 8.13
			aMeBu( 0,nil,GBse,Gzz,At[An][1],plst )
			aMeBu( pi/4,nil,GBse,Gzz,At[An][2],plst )
			aMeBu( pi/2,nil,GBse,Gzz,At[An][3],plst )
			aMeBu( pi-pi/4,nil,GBse,Gzz,At[An][4],plst )
			aMeBu( pi,nil,GBse,Gzz,At[An][5],plst )
			aMeBu( pi+pi/4,nil,GBse,Gzz,At[An][6],plst )
			aMeBu( pi*1.5,nil,GBse,Gzz,At[An][7],plst )
			aMeBu( pi*1.5+pi/4,nil,GBse,Gzz,At[An][8],plst )
			pi = nil
		end GTdo = nil GBse = nil
	end
	
	function A_AM.ActMod:Chicon(plist,NIi,fid)
		if IsValid(plist.aMh) then plist.aMh:Remove() end
		local bF = A_AM.ActMod.Settings["IconsActs"]
		plist.aMh = vgui.Create( "DPanel" )
		plist.aMh:SetSize( ScrW(),ScrH() )
		plist.aMh:MakePopup() plist.aMh:SetText("")
		plist.aMh.taa = false
		plist.aMh.Paint = function(p, w, h)
			if p.taa == true and p:IsHovered() then
				if IsValid(p.AAW) then p.AAW:Remove() p:Remove() end
			end
		end
		plist.aMh.AAW = vgui.Create( "DPanel" ,plist.aMh ) plist.aMh.AAW:MakePopup()
		plist.aMh.AAW.OnRemove = function( pan ) if IsValid(plist.aMh) then plist.aMh:Remove() end end
		if GetConVarNumber("actmod_cl_sortemote") == 2 then
			plist.aMh.AAW:SetSize( 250, 230 )
			plist.aMh.AAW.AT = 2
		else
			plist.aMh.AAW:SetSize( 250, 250 )
			plist.aMh.AAW.AT = 1
		end
		plist.aMh.AAW:SetText("") plist.aMh.AAW:SetAlpha(0)
		plist.aMh.AAW:AlphaTo( 255,0.1,0,function(s) if IsValid(plist.aMh) then plist.aMh.taa = true end end )
		plist.aMh.AAW:SetPos( gui.MouseX() - plist.aMh.AAW:GetWide()/2, gui.MouseY() - plist.aMh.AAW:GetTall()/2 )
		if file.Exists("materials/actmod/imenu/arrow.png", "GAME") then
			plist.aMh.AAW.m_arrow = "actmod/imenu/arrow.png"
		else
			plist.aMh.AAW.m_arrow = "gui/arrow"
		end
		local GTTebl_i = {A_AM.ActMod:ReString(NIi) ..".png"}
		local GTTebl_n = 0

		plist.aMh.AAW.GTTebl_i = GTTebl_i
		plist.aMh.AAW.GTTebl_n = GTTebl_n
		plist.aMh.AAW.Afh_a = 0
		plist.aMh.AAW.Afh_atrue = CurTime()
		plist.aMh.AAW.aNIi = NIi
		plist.aMh.AAW.Paint = function ( s, w, h )
			if s.Afh_atrue > CurTime() then
				if s.Afh_a < 255 then
					s.Afh_a = math.min(255,s.Afh_a + 800*FrameTime())
				end
			else
				if s.Afh_a > 0 then
					s.Afh_a = math.max(0,s.Afh_a - 1000*FrameTime())
				end
			end
			
			if s.AT == 1 then
				draw.RoundedBox( h/2, 0, 0, w, h, Color(150,150,50,100) )
				draw.RoundedBox( h/2-10, 10, 10, w-20, h-20, Color(50,255,255,100) )
			else
				draw.RoundedBox( 30, 0, 0, w, h, Color(150,150,50,100) )
				draw.RoundedBox( 30-10, 10, 10, w-20, h-20, Color(50,255,255,100) )
			end
			surface.SetDrawColor(Color(255,255,255,255))
			if fid then
				surface.SetMaterial( Material(bF .."/".. plist.aMh.AAW.GTTebl_i[1], "noclamp smooth") )
			else
				surface.SetMaterial( Material(bF .."/".. NIi ..".png", "noclamp smooth") )
			end
			surface.DrawTexturedRect(w/2-30, h/2-30, 60, 60)
			
			local centerX, centerY = w/2, h/2
			local angle
			if s.Afh_StPos then
				angle = math.pi - math.atan2(
					centerY - s.Afh_StPos[2],
					centerX - s.Afh_StPos[1]
				)
			else
				local mouseX, mouseY = s:LocalCursorPos()
				angle = math.pi - math.atan2(
					centerY - mouseY,
					centerX - mouseX
				)
			end
			local deg = math.deg(angle) - 90
			
			surface.SetDrawColor(Color(255,255,255,math.max(0,math.min(255,s.Afh_a+(s.Afh_a*math.sin(CurTime()*7))))))
			surface.SetMaterial( Material(s.m_arrow, "noclamp smooth") )
			surface.DrawTexturedRectRotated(centerX, centerY, 50, 50, deg)
			
			draw.RoundedBox( 10, 2, 2, 30, 25, Color(50,50,50,230) )
			draw.SimpleText( "( ".. GetConVarNumber("actmod_cl_pageslot") .." )", "ActMod_e1", 5, 5, Color(255,255,255,255) )
		
		end
		plist.aMh.AAW.TabEmots = {}
		function plist.aMh.AAW:OnMouseWheeled(wheelDelta)
			local ply = LocalPlayer()
			if (plist.aMh.AAW:IsHovered() or (plist.aMh.AAW.aIsHovered or 0) < CurTime()) and (ply.ActMod_AddTcic or 0) < CurTime() then
				local Tgnum = GetConVarNumber("actmod_cl_pageslot")
				local gnum = Tgnum
				gnum = gnum + math.Clamp(-wheelDelta,-1,1)
				gnum = math.Clamp(gnum,1,8)
				if gnum ~= Tgnum then
					ply.ActMod_AddTcic = CurTime() + 0.05
					surface.PlaySound("actmod/i_menu/menu_othr_02.mp3")
					local aSe = math.Clamp(tonumber(gnum),1,8)
					ply:ConCommand("actmod_cl_pageslot ".. aSe .."\n")
					if istable(plist.aMh.AAW.TabEmots) then for k,tm in pairs( plist.aMh.AAW.TabEmots ) do if IsValid(tm) then tm:Remove() end end plist.aMh.AAW.TabEmots = {} end
					plist.aMh.AAW.TabEmots = {}
					Siqit(plist.aMh.AAW,aSe)
				end
			end
		end
		GTTebl_i = nil  GTTebl_n = nil
		Siqit(plist.aMh.AAW)
		return plist.aMh
	end

end

A_AM.ActMod.LuaAvs_Done = true
