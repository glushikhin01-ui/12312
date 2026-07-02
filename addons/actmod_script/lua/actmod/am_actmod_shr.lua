if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaSha = true


local Ta = {"amod_mixamo_walk_","amod_mixamo_run_"}
A_AM.ActMod.AnimNStp = {Ta[2].."1_forward",Ta[2].."2_forward",Ta[2].."3_forward",Ta[2].."4_forward"
,Ta[1].."0_forward",Ta[1].."1_forward",Ta[1].."2_forward",Ta[1].."3_forward",Ta[1].."4_forward",Ta[1].."5_forward",Ta[1].."6_forward",Ta[1].."7_forward",Ta[1].."8_forward",Ta[1].."9_forward"
,Ta[1].."10_forward",Ta[1].."11_forward",Ta[1].."12_forward",Ta[1].."13_forward",Ta[1].."14_back",Ta[1].."15_forward",Ta[1].."16_forward",Ta[1].."17_forward",Ta[1].."18_forward",Ta[1].."19_forward",Ta[1].."20_forward",Ta[1].."21_forward"
,"zombie_run","zombie_walk_01","amod_mmd_helltaker","amod_mmd_phao2phuthon_p1"} Ta = nil

A_AM.ActMod.ActoldV__v9_1 = {"amod_mmd_dance_specialist","amod_mmd_theatrical_airline_mik","amod_mmd_theatrical_airline_luk","amod_mmd_theatrical_airline_rin"
,"f_acrobatic_superhero","f_armup","f_cool_robot","f_cowboydance","f_funk_time","f_head_bounce","f_idontknow","f_jazz_dance","f_kitty_cat","f_mind_blown"
,"f_octopus","f_octopus","f_running","f_shaolin","f_sprinkler","f_thequicksweeper","f_wave_dance"}

A_AM.ActMod.ActoldV__v9_2 = {"amod_mmd_dance_caramelldansen","amod_mmd_dance_daisukeevolution","amod_mmd_whistle"
,"amod_fortnite_autumntea","amod_fortnite_eerie","amod_fortnite_eerie_walk","amod_fortnite_nevergonna","amod_fortnite_twistdaytona"
,"amod_fortnite_twisteternity_ayo","amod_fortnite_twisteternity_teo","f_doublesnap","f_electroshuffle2","f_floppy_dance"
,"f_indiadance","f_kpop_dance03","f_swim_dance"}

A_AM.ActMod.ActoldV__v9_3 = {"amod_mmd_king_kanaria","amod_mmd_badbadwater","amod_dance_california_girls"
,"amod_mixamo_dead_1","amod_mixamo_dead_2","amod_mixamo_dead_3","amod_mixamo_dead_4","amod_mixamo_entry","amod_mixamo_gesture_1"
,"amod_mixamo_gesture_2","amod_mixamo_gesture_3","amod_mixamo_gesture_4","amod_mixamo_gesture_5","amod_mixamo_gesture_6"
,"amod_mixamo_gesture_7","amod_mixamo_gesture_8","amod_mixamo_gesture_9","amod_mixamo_gesture_10","amod_mixamo_gesture_11"
,"amod_mixamo_gesture_12","amod_mixamo_gesture_13","amod_mixamo_gesture_14","amod_mixamo_gesture_15","amod_mixamo_idle_1"
,"amod_mixamo_idle_2","amod_mixamo_idle_3","amod_mixamo_idle_4","amod_mixamo_idle_5","amod_mixamo_idle_6"
,"amod_mixamo_idle_with_something","amod_mixamo_jump","amod_mixamo_kick_1","amod_mixamo_kick_2","amod_mixamo_kick_3"
,"amod_mixamo_kick_4","amod_mixamo_kick_5","amod_mixamo_run_1_forward","amod_mixamo_run_2_forward","amod_mixamo_run_3_forward"
,"amod_mixamo_sit","amod_mixamo_sit_typing","amod_mixamo_sit_writing","amod_mixamo_taunt_1"
,"amod_mixamo_taunt_2","amod_mixamo_taunt_3","amod_mixamo_taunt_4","amod_mixamo_taunt_5","amod_mixamo_taunt_6","amod_mixamo_taunt_7"
,"amod_mixamo_taunt_8","amod_mixamo_taunt_9","amod_mixamo_taunt_10","amod_mixamo_taunt_11","amod_mixamo_taunt_12","amod_mixamo_on_knees"
,"amod_mixamo_walk_0_forward","amod_mixamo_walk_1_forward","amod_mixamo_walk_2_forward","amod_mixamo_walk_3_forward","amod_mixamo_warming_up"
,"f_dreamfeet","f_gabby_hiphop","f_sneaky" }


local TFm = "amod_mixamo_walk_"
A_AM.ActMod.ActoldV__v9_5 = {"zombie_idle_01","zombie_run","zombie_walk_01"
,"amod_mixamo_catwalk_walk","amod_mixamo_hip_hop_dancing","amod_mixamo_hip_hop_dancing2","amod_mixamo_talking_on_a_cell_phone","amod_mixamo_talking_on_phone"
,TFm.."4_forward",TFm.."5_forward",TFm.."6_forward",TFm.."7_forward",TFm.."8_forward",TFm.."9_forward",TFm.."10_forward",TFm.."11_forward",TFm.."12_forward",TFm.."13_forward"
,TFm.."14_back",TFm.."15_forward",TFm.."16_forward",TFm.."17_forward",TFm.."18_forward",TFm.."19_forward",TFm.."20_forward",TFm.."21_forward","amod_mixamo_run_4_forward"
,"amod_fortnite_cerealbox","amod_fortnite_griddle","amod_fortnite_griddle_walk","amod_fortnite_hotpink","amod_fortnite_sunburstdance","amod_fortnite_cyclone_headbang","amod_fortnite_cyclone","amod_fortnite_walkywalk","amod_fortnite_walkywalk_walk","amod_fortnite_julybooks"
,"amod_mmd_aoagoodluck","amod_mmd_blablabla","amod_mmd_chikichiki","amod_mmd_ghostdance","amod_mmd_girls","amod_mmd_hiasobi","amod_mmd_hiproll","amod_mmd_mrsaxobeat","amod_mmd_caixukun","amod_mmd_calisthenics"
,"amod_mmd_nyaarigato","amod_mmd_pv120_shi_p1","amod_mmd_pv120_shi_p2","amod_mmd_pv120_shi_p3","amod_mmd_s001","amod_mmd_s002","amod_mmd_s003","amod_mmd_s004","amod_mmd_s005","amod_mmd_s006","amod_mmd_s008","amod_mmd_s009","amod_mmd_s010"}
TFm = nil

A_AM.ActMod.ActoldV__v9_6 = {"idle_all_02","idle_all_angry","idle_all_cower","idle_all_scared","idle_suitcase","menu_combine","menu_gman","menu_zombie_01","amod_am4_levepalestina"
,"amod_drip_01","amod_am4_drliveseywalk_1","amod_am4_drliveseywalk_2","amod_am4_drliveseywalk_3","amod_mmd_bad_apple_l","amod_mmd_bad_apple_r","amod_mmd_gfriendrough","amod_mmd_massdestruction","amod_mmd_mememe","amod_mmd_senbonzakura","amod_mmd_supermjopping","amod_mmd_roki_p1","amod_mmd_roki_p2","amod_mmd_nahoha","amod_mmd_lmfao","amod_mmd_kwlink"
,"amod_mmd_conqueror","amod_mmd_ch4nge","amod_mmd_yoidore","amod_mmd_dokuhebi","amod_mmd_darling","amod_mmd_dancin","amod_mmd_adeepmentality","amod_mmd_s011","amod_mmd_s012","amod_mmd_s013","amod_mmd_s014","amod_mmd_s015","amod_mmd_gimmexgimme","amod_mmd_yaosobi-idol","amod_mmd_adj_1","amod_mmd_kemuthree"
,"amod_fortnite_twistwasp","amod_fortnite_stringdance","amod_fortnite_gasstation","amod_fortnite_grooving","amod_fortnite_devotion","amod_fortnite_chew","amod_fortnite_comrade","amod_fortnite_indigoapple","amod_fortnite_heavyroardance","amod_fortnite_zebrascramble"
,"amod_pubg_seetinh","amod_pubg_2phuthon","amod_pubg_bboombboom","amod_pubg_victorydance60","amod_pubg_victorydance99","amod_pubg_victorydance102","amod_pubg_samsara","amod_pubg_tocatoca" }

A_AM.ActMod.ActoldV__v9_7 = {"sit_zen","sit","drive_pd","drive_airboat"
,"amod_am4_runpanicked","amod_am4_poegypt","amod_am4_sambadancingfull","amod_am4_pitbull_a","amod_am4_pitbull_loop","amod_am4_spooky_month_dance","amod_pubg_rollnrock","amod_pubg_poppy","amod_pubg_victorydance118"
,"amod_mixamo_sambadancing","amod_mixamo_situps_01","amod_mixamo_dancing_01","amod_mixamo_dancing_02","amod_mixamo_swingdancing_01","amod_mixamo_swingdancing_02","amod_mixamo_swingdancing_03","amod_mixamo_pose_maledance_01","amod_mixamo_pose_femaledance_01","amod_mixamo_hokeypokey","amod_mixamo_norsoulspcombo"
,"amod_fortnite_adoration","amod_fortnite_dreadful","amod_fortnite_shimmy","amod_fortnite_cottontail","amod_fortnite_headset","amod_fortnite_headset_walk","amod_fortnite_jumpstyledance","amod_fortnite_promenadefollow","amod_fortnite_promenadelead","amod_fortnite_speeddial","amod_fortnite_tourbus","amod_fortnite_agentsherbert"
,"amod_fortnite_sandwichbop","amod_fortnite_sandwichbop_walk","amod_fortnite_januarybop","amod_fortnite_ruckus","amod_fortnite_voidredemption","amod_fortnite_vivid","amod_fortnite_vivid_walk","amod_fortnite_handsup","amod_fortnite_twohype","amod_fortnite_twohype_walk","amod_fortnite_lilsplit","amod_fortnite_noodles","amod_fortnite_pastasauce"
,"amod_fortnite_malleable","amod_fortnite_malleable_walk","amod_fortnite_troops","amod_fortnite_hoist","amod_fortnite_breakfastcoffeedance","amod_fortnite_chairtime","amod_fortnite_snowknight","amod_fortnite_bluephoto","amod_fortnite_coping","amod_fortnite_sashimi","amod_fortnite_marionette1","amod_fortnite_abstractmirror","amod_fortnite_chickenleg"
,"amod_fortnite_goodbyeupbeat","amod_fortnite_goodbyeupbeat_walk","amod_fortnite_sitandspin","amod_fortnite_gothdance","amod_fortnite_gwaradance","amod_fortnite_undead","amod_fortnite_papayacommsclap","amod_fortnite_poutyclap","amod_fortnite_ringer","amod_fortnite_ringer_walk","amod_fortnite_chilled","amod_fortnite_alien","amod_fortnite_iconic"
,"amod_fortnite_snowfall","amod_fortnite_selenecobra","amod_fortnite_reign","amod_fortnite_whisk","amod_fortnite_metronome","amod_fortnite_justhome","amod_fortnite_darling","amod_fortnite_triumphant","amod_fortnite_boomer","amod_fortnite_clamor","amod_fortnite_hurrah","amod_fortnite_tollbridge","amod_fortnite_wheresmatt","amod_fortnite_wheresmatt_walk"
,"amod_fortnite_reverie","amod_fortnite_reverie_mirror","amod_fortnite_montecarlo","amod_fortnite_shiverflame","amod_fortnite_canine","amod_fortnite_dignified","amod_fortnite_cadaver","amod_fortnite_intermission","amod_fortnite_harmony_1","amod_fortnite_rumblefemale","amod_fortnite_plasticfork","amod_fortnite_plasticfork_walk","amod_fortnite_farewell"
,"amod_fortnite_downward","amod_fortnite_elegantlilycharm","amod_fortnite_elegantlily","amod_fortnite_nimble","amod_fortnite_vacant","amod_fortnite_blazerveil","amod_fortnite_sillyjumps","amod_fortnite_sillyjumps_walk","amod_fortnite_dimension","amod_fortnite_playereleven","amod_fortnite_coyotetrail_lead","amod_fortnite_enrapture","amod_fortnite_thrive"
,"amod_fortnite_kelplinen","amod_fortnite_mesmerize","amod_fortnite_jadetowel","amod_fortnite_jadetowel_gloss","amod_fortnite_bewilder","amod_fortnite_resonant","amod_fortnite_resonant_walk","amod_fortnite_lemoncart_static","amod_fortnite_lemoncart_walk","amod_fortnite_studs","amod_fortnite_patpat_intro","amod_fortnite_myeffort"
,"amod_mmd_imfgood","amod_mmd_drunkendutterfly","amod_mmd_aloveit","amod_mmd_bibbib","amod_mmd_peachbsmile","amod_mmd_bananasong","amod_mmd_littleapple","amod_mmd_shiknok","amod_mmd_dancehall_1","amod_mmd_dancehall_2","amod_mmd_zhangshiyao","amod_mmd_pokedance","amod_mmd_ph"
,"amod_mmd_beyondtheway_1","amod_mmd_beyondtheway_2","amod_mmd_beyondtheway_3","amod_mmd_beyondtheway_4","amod_mmd_beyondtheway_5"
}

A_AM.ActMod.ActNewV = {"gmod_g_bow","gmod_g_agree","gmod_g_wave","gmod_g_becon","gmod_g_disagree","gmod_g_salute","gmod_g_signal_forward","gmod_g_signal_group","gmod_g_signal_halt","gmod_g_item_drop","gmod_g_item_give","gmod_g_item_place","gmod_g_item_throw"}

A_AM.ActMod.ActNewVCustom = A_AM.ActMod.ActNewVCustom or {}


A_AM.ActMod.AGetDitN = {
	[1] = "amod_fortnite_dancemoves.png"
	,[2] = "amod_fortnite_epicsaxguy.png"
	,[3] = "amod_mmd_dance_gokurakujodo.png"
	,[4] = "amod_fortnite_crisscross.png"
	,[5] = "taunt_dance.png"
	,[6] = "amod_fortnite_golfclap.png"
	,[7] = "amod_mmd_yoidore.png"
	,[8] = "amod_dance_gangnamstyle.png"
	
	,[9] = "amod_fortnite_dancemoves2.png"
	,[10] = "amod_am4_epicsaxguy.png"
	,[11] = "amod_mmd_dance_specialist.png"
	,[12] = "amod_fortnite_kpopdance_04.png"
	,[13] = "amod_mixamo_dead_2.png"
	,[14] = "amod_pubg_bboombboom.png"
	,[15] = "amod_mmd_dance_tuni-kun.png"
	,[16] = "amod_fortnite_gasstation.png"
	
	,[17] = "amod_mixamo_gesture_13.png"
	,[18] = "taunt_laugh.png"
	,[19] = "amod_fortnite_idontknow.png"
	,[20] = "amod_fortnite_papayacommsclap.png"
	,[21] = "amod_fortnite_abstractmirror.png"
	
	,[70] = "gmod_g_wave.png"
	,[71] = "gmod_g_salute.png"
	,[72] = "gmod_g_agree.png"
	,[73] = "gmod_g_disagree.png"
	,[74] = "gmod_g_bow.png"
	
	,[22] = "amod_am4_drliveseywalk_2.png"
	,[23] = "amod_pubg_victorydance99.png"
	,[24] = "amod_mmd_whistle.png"
	,[25] = "amod_mmd_dancin.png"
	,[26] = "amod_fortnite_prance.png"
	,[27] = "amod_fortnite_nevergonna.png"
	,[28] = "amod_mmd_darling.png"
	,[29] = "amod_am4_levepalestina.png"
	
	,[30] = "amod_fortnite_mind_blown.png"
	,[31] = "idle_all_scared.png"
	,[32] = "amod_fortnite_devotion.png"
	,[33] = "amod_mmd_kwlink.png"
	,[34] = "amod_mmd_s015.png"
	,[35] = "amod_fortnite_aloha.png"
	,[36] = "zombie_walk_01.png"
	,[37] = "idle_all_02.png"
}

for i = 38 , 69 do
	A_AM.ActMod.AGetDitN[i] = "reference.png"
end

A_AM.ActMod.ActGmod = {"idle_all_02","idle_all_angry","idle_all_cower","idle_all_scared","idle_suitcase","menu_combine","menu_gman","menu_zombie_01","taunt_cheer","taunt_dance"
,"taunt_laugh","taunt_muscle","taunt_persistence","taunt_robot","zombie_idle_01","zombie_run","zombie_walk_01","ragdoll","reference","sit_zen","sit","drive_pd","drive_airboat"
,"gmod_g_bow","gmod_g_agree","gmod_g_wave","gmod_g_becon","gmod_g_disagree","gmod_g_salute","gmod_g_signal_forward","gmod_g_signal_group","gmod_g_signal_halt","gmod_g_item_drop","gmod_g_item_give","gmod_g_item_place","gmod_g_item_throw"}
A_AM.ActMod.AcTAM4 = {"amod_taunt_quagmire","amod_taunt_quagmire","amod_drip_01","amod_dance_macarena","amod_dance_gangnamstyle","amod_dance_california_girls","amod_angry_01","amod_am4_spooky_month_dance","amod_am4_sambadancingfull"
,"amod_am4_runpanicked","amod_am4_poegypt","amod_am4_pitbull_loop","amod_am4_pitbull_a","amod_am4_levepalestina","amod_am4_epicsaxguy","amod_am4_drliveseywalk_3","amod_am4_drliveseywalk_2","amod_am4_drliveseywalk_1"}

A_AM.ActMod.LuaSha_Done = true
