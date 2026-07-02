if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaAct_Base = true

local a,f,m,o,p,s = "amod_am4_","amod_fortnite_","amod_mmd_","amod_mixamo_","amod_pubg_","actmod/i_act/am4/"
local cP,cL,aRA,cY,tCA,tTC,nS,MS,mD,rAA,C_a,C_s,T1,T2 = "CamParent","CamInLerp","AutoReAnim","Cycle","tC_TReA","tC_TReA_CycleAni","NoStop","MoveSpeed","MoveDir","RTimeAnim","C_Anim","C_Sound","Time1","Time2"
local aP1,aP2,Jg,sO,MDe,Jf,sC = "ani_pl1","ani_pl2","joining","SoundOne","MaxDistance","joiningFPO","Sync"

A_AM.ActMod.GTabSd_AM4_O = {
	["amod_dance_gangnamstyle"] = { {s.."amod_gangnamstyle_c1.mp3"},nil ,{s.."amod_gangnamstyle_c2.mp3"} }
	,[a.."dancegangnamstyle"] = { {s.."amod_gangnamstyle_c1.mp3"},nil ,{s.."amod_gangnamstyle_c2.mp3"} }
	,["amod_dance_macarena"] = { {s.."amod_dance_macarena.mp3"} }
	,["amod_dance_california_girls"] = { {s.."amod_dance_california_girls_s1.mp3"},nil ,{s.."amod_dance_california_girls_s2.mp3"} }
	,["amod_taunt_quagmire"] = { {s.."amod_taunt_quagmire.mp3"} }
	,["amod_taunt_quagmire_C1"] = { {s.."amod_taunt_quagmire_music.mp3"} }
	,[a.."drliveseywalk_1"] = { {s.."DrLiveseyWalk_loop3.mp3"} }
	,[a.."drliveseywalk_2"] = { {s.."DrLiveseyWalk_loop1.mp3"} }
	,[a.."drliveseywalk_3"] = { {s.."DrLiveseyWalk_loop2.mp3"} }
	,[a.."levepalestina"] = { {s.."amod_LF_1.mp3"},nil ,{s.."amod_LF_2.mp3"} }
	,[a.."pitbull_a"] = { {s.."pitbull_1.mp3"},nil ,{s.."pitbull_2.mp3"} }
	,[a.."pitbull_m"] = { {s.."pitbull_1.mp3"},nil ,{s.."pitbull_2.mp3"} }
	,[a.."pitbull_loop"] = { {s.."pitbull_2.mp3"} }
	,[a.."action1c2"] = { {s.."actin1.mp3"} }
	,[a.."poegypt"] = { {s.."a_prince_of_egypt_1.mp3"} }
	,[a.."spooky_month_dance"] = { {s.."amod_SpookyMDance.mp3"} }
	,[a.."sambadancingfull"] = { {s.."sambadancing_1.mp3"},nil ,{s.."sambadancing_2.mp3"} }
	,[a.."epicsaxguy"] = { {s.."epicsax.mp3"} }
}

A_AM.ActMod.GTabSd_AM4_F = {
	[f.."nevergonna"] = { {s.."fortnite/amod_fortnite_nevergonna_s1.mp3"},nil ,{s.."fortnite/amod_fortnite_nevergonna_s2.mp3"} }
	,[f.."mind_blown"] = { {s.."fortnite/Emote_Mindblown_02.mp3"},0.95 }
	,[f.."dancemoves"] = { {s.."fortnite/dmoves01.mp3"} }
	,[f.."dancemoves2"] = { {s.."fortnite/dmoves03.mp3"} }
	,[f.."flossdance"] = { {s.."fortnite/emote_floss_01.mp3"} }
	,[f.."idontknow"] = { {s.."fortnite/Emote_IDontKnow.mp3"} }
	,[f.."cheerleader"] = { {s.."fortnite/Emote_Music_Cheerleader.mp3"} }
	,[f.."glowstickdance"] = { {s.."fortnite/Emote_Glowstick_Loop_01.mp3"} }
	,[f.."lookatthis"] = { {s.."fortnite/Emote_Look_At_This_No_SPKR.mp3"},0.5 }
	,[f.."boogie_down"] = { {s.."fortnite/emote_boogiedown_2.mp3"},0.7 ,{s.."fortnite/emote_boogiedown_2.mp3"},nil,{s.."fortnite/emote_boogiedown_1.mp3"},0.25 }
	,[f.."stagebow"] = { {s.."fortnite/emote_stagebow.mp3"} }
	,[f.."facepalm"] = { {s.."fortnite/emote_facepalm_foley_01.mp3"},0.75 }
	,[f.."electroshuffle"] = { {s.."fortnite/emote_electroshuffle_01.mp3"} }
	,[f.."confused"] = { {s.."fortnite/Emote_Confused_Steps_Foley.mp3"} }
	,[f.."charleston"] = { {s.."fortnite/emote_flapper_01.mp3"} }
	,[f.."maskoff"] = { {s.."fortnite/Hip_Hop_Good_Vibes_Mix_01.mp3"} }
	,[f.."aloha"] = { {s.."fortnite/amod_fortnite_alohaa.mp3"} }
	,[f.."dance_distraction"] = { {s.."fortnite/amod_fortnite_dance_distraction.mp3"} }
	,[f.."behere"] = { {s.."fortnite/amod_fortnite_behere.mp3"} }
	,[f.."littleegg"] = { {s.."fortnite/amod_fortnite_littleegg.mp3"} }
	,[f.."lyrical"] = { {s.."fortnite/amod_fortnite_lyrical.mp3"} }
	,[f.."ohana"] = { {s.."fortnite/amod_fortnite_ohana.mp3"} }
	,[f.."prance"] = { {s.."fortnite/amod_fortnite_prance.mp3"} }
	,[f.."realm"] = { {s.."fortnite/Emote_Realm_Music_Loop_01.mp3"} }
	,[f.."realm_walk"] = { {s.."fortnite/Emote_Realm_Music_Loop_01.mp3"} }
	,[f.."sleek"] = { {s.."fortnite/amod_fortnite_sleek.mp3"} }
	,[f.."spectacleweb"] = { {s.."fortnite/amod_fortnite_spectacleweb.mp3"} }
	,[f.."tally"] = { {s.."fortnite/amod_fortnite_tally.mp3"} }
	,[f.."tonal"] = { {s.."fortnite/amod_fortnite_tonal.mp3"} }
	,[f.."zest"] = { {s.."fortnite/amod_fortnite_zest.mp3"} }
	,[f.."sunlit"] = { {s.."fortnite/amod_fortnite_sunlit.mp3"} }
	,[f.."laugh"] = { {s.."fortnite/Emote_Laugh_01.mp3"} }
	,[f.."marionette1"] = { {s.."fortnite/amod_fortnite_marionette.mp3"} }
	,[f.."twistdaytona"] = { {s.."fortnite/amod_fortnite_twistdaytona.mp3"} }
	,[f.."hotpink"] = { {s.."fortnite/amod_fortnite_hotpink.mp3"} }
	,[f.."sunburstdance"] = { {s.."fortnite/amod_fortnite_sunburstdance.mp3"} }
	,[f.."cyclone_headbang"] = { {s.."fortnite/amod_fortnite_cyclone_headbang.mp3"} }
	,[f.."cyclone"] = { {s.."fortnite/amod_fortnite_cyclone.mp3"} }
	,[f.."julybooks"] = { {s.."fortnite/amod_fortnite_julybooks.mp3"} }
	,[f.."twistwasp"] = { {s.."fortnite/amod_fortnite_twistwasp.mp3"} }
	,[f.."stringdance"] = { {s.."fortnite/amod_fortnite_stringdance.mp3"} }
	,[f.."gasstation"] = { {s.."fortnite/amod_fortnite_gasstation.mp3"} }
	,[f.."comrade"] = { {s.."fortnite/amod_fortnite_comrade.mp3"} }
	,[f.."grooving"] = { {s.."fortnite/amod_fortnite_grooving1.mp3"} }
	,[f.."grooving2"] = { {s.."fortnite/amod_fortnite_grooving2.mp3"} }
	,[f.."grooving_C1"] = { {s.."fortnite/amod_fortnite_grooving2.mp3"} }
	,[f.."indigoapple"] = { {s.."fortnite/amod_fortnite_indigoapple.mp3"} }
	,[f.."zebrascramble"] = { {s.."fortnite/amod_fortnite_zebrascramble.mp3"} }
	,[f.."heavyroardance"] = { {s.."fortnite/amod_fortnite_heavyroardance_L.mp3"},0.8 ,{s.."fortnite/amod_fortnite_heavyroardance_L.mp3"},nil,{s.."fortnite/amod_fortnite_heavyroardance_i.mp3"},0.1 }
	,[f.."adoration"] = { {s.."fortnite/amod_fortnite_adoration_Loop.mp3"},0.7 ,{s.."fortnite/amod_fortnite_adoration_Loop.mp3"},nil,{s.."fortnite/amod_fortnite_adoration_Intro.mp3"},0.05 }
	,[f.."dreadful"] = { {s.."fortnite/amod_fortnite_dreadful_Loop.mp3"},0.2 ,{s.."fortnite/amod_fortnite_dreadful_Loop.mp3"},nil,{s.."fortnite/amod_fortnite_dreadful_Intro.mp3"} }
	,[f.."shimmy"] = { {s.."fortnite/amod_fortnite_shimmy_Loop.mp3"},0.35 ,{s.."fortnite/amod_fortnite_shimmy_Loop.mp3"},nil,{s.."fortnite/amod_fortnite_shimmy_Intro.mp3"} }
	,[f.."cottontail"] = { {s.."fortnite/amod_fortnite_cottontail.mp3"} }
	,[f.."headset"] = { {s.."fortnite/amod_fortnite_headset_Loop.mp3"} }
	,[f.."headset_walk"] = { {s.."fortnite/amod_fortnite_headset_Loop.mp3"} }
	,[f.."jumpstyledance"] = { {s.."fortnite/amod_fortnite_jumpstyledance.mp3"} }
	,[f.."promenadefollow"] = { {s.."fortnite/amod_fortnite_promenade.mp3"} }
	,[f.."promenadelead"] = { {s.."fortnite/amod_fortnite_promenade.mp3"} }
	,[f.."speeddial"] = { {s.."fortnite/amod_fortnite_speeddial.mp3"} }
	,[f.."tourbus"] = { {s.."fortnite/amod_fortnite_tourbus.mp3"} }
	,[f.."januarybop"] = { {s.."fortnite/amod_fortnite_januarybop.mp3"} }
	,[f.."ruckus"] = { {s.."fortnite/amod_fortnite_ruckus.mp3"} }
	,[f.."sandwichbop"] = { {s.."fortnite/amod_fortnite_sandwichbop.mp3"} }
	,[f.."sandwichbop_walk"] = { {s.."fortnite/amod_fortnite_sandwichbop.mp3"} }
	,[f.."vivid"] = { {s.."fortnite/amod_fortnite_vivid.mp3"} }
	,[f.."vivid_walk"] = { {s.."fortnite/amod_fortnite_vivid.mp3"} }
	,[f.."twohype"] = { {s.."fortnite/amod_fortnite_twohype.mp3"} }
	,[f.."twohype_walk"] = { {s.."fortnite/amod_fortnite_twohype.mp3"} }
	,[f.."voidredemption"] = { {s.."fortnite/amod_fortnite_voidredemption2.mp3"},0.366 ,{s.."fortnite/amod_fortnite_voidredemption2.mp3"},nil,{s.."fortnite/amod_fortnite_voidredemption1.mp3"} }
	,[f.."handsup"] = { {s.."fortnite/amod_fortnite_handsup.mp3"} }
	,[f.."lilsplit"] = { {s.."fortnite/amod_fortnite_lilsplit.mp3"} }
	,[f.."malleable"] = { {s.."fortnite/amod_fortnite_malleable.mp3"} }
	,[f.."malleable_walk"] = { {s.."fortnite/amod_fortnite_malleable.mp3"} }
	,[f.."chairtime"] = { {s.."fortnite/amod_fortnite_chairtime2.mp3"},4.3 ,{s.."fortnite/amod_fortnite_chairtime2.mp3"},0.2,{s.."fortnite/amod_fortnite_chairtime1.mp3"} }
	,[f.."hoist"] = { {s.."fortnite/amod_fortnite_hoist_Loop.mp3"},0.73 ,{s.."fortnite/amod_fortnite_hoist_Loop.mp3"},nil,{s.."fortnite/amod_fortnite_hoist_Intro.mp3"} }
	,[f.."abstractmirror"] = { {s.."fortnite/amod_fortnite_abstractmirror1.mp3"} }
	,[f.."troops"] = { {s.."fortnite/amod_fortnite_troops.mp3"} }
	,[f.."agentsherbert"] = { {s.."fortnite/amod_fortnite_agentsherbert.mp3"} }
	,[f.."breakfastcoffeedance"] = { {s.."fortnite/amod_fortnite_breakfastcoffeedance.mp3"} }
	,[f.."snowknight"] = { {s.."fortnite/amod_fortnite_snowknight.mp3"} }
	,[f.."bluephoto"] = { {s.."fortnite/amod_fortnite_bluephoto_Loop.mp3"},2.2 ,{s.."fortnite/amod_fortnite_bluephoto_Loop.mp3"},nil,{s.."fortnite/amod_fortnite_bluephoto_Intro.mp3"} }
	,[f.."epicsaxguy"] = { {s.."fortnite/amod_fortnite_epicsaxguyl.mp3"},nil ,{s.."fortnite/amod_fortnite_epicsaxguyl.mp3"},nil,{s.."fortnite/amod_fortnite_epicsaxguyi.mp3"} }
	,[f.."sashimi"] = { {s.."fortnite/amod_fortnite_sashimi.mp3"} }
	,[f.."marionette1"] = { {s.."fortnite/Emote_Marionette.mp3"} }
	,[f.."noodles"] = { {s.."fortnite/amod_fortnite_noodles_Loop.mp3"},3.4 ,{s.."fortnite/amod_fortnite_noodles_Loop.mp3"},nil,{s.."fortnite/amod_fortnite_noodles_Intro.mp3"} }
	,[f.."pastasauce"] = { {s.."fortnite/amod_fortnite_pastasauce_Loop.mp3"},2.26667 ,{s.."fortnite/amod_fortnite_pastasauce_Loop.mp3"},nil,{s.."fortnite/amod_fortnite_pastasauce_Intro.mp3"} }
	,[f.."sitandspin"] = { {s.."fortnite/amod_fortnite_sitandspin_Music.mp3"},0.3 ,{s.."fortnite/amod_fortnite_sitandspin_Music.mp3"},nil,{s.."fortnite/amod_fortnite_sitandspin_Intro.mp3"} }
	,[f.."goodbyeupbeat"] = { {s.."fortnite/amod_fortnite_goodbyeupbeat.mp3"} }
	,[f.."goodbyeupbeat_walk"] = { {s.."fortnite/amod_fortnite_goodbyeupbeat.mp3"} }
	,[f.."coping"] = { {s.."fortnite/amod_fortnite_coping01.mp3"} }
	,[f.."gothdance"] = { {s.."fortnite/amod_fortnite_gothdance.mp3"} }
	,[f.."gwaradance"] = { {s.."fortnite/amod_fortnite_gwaradance.mp3"} }
	,[f.."eerie"] = { {s.."fortnite/amod_fortnite_eerie.mp3"} }
	,[f.."eerie_walk"] = { {s.."fortnite/amod_fortnite_eerie.mp3"} }
	,[f.."jiggle"] = { {s.."fortnite/amod_fortnite_jiggle_s2.mp3"},0.7 ,{s.."fortnite/amod_fortnite_jiggle_s2.mp3"},nil,{s.."fortnite/amod_fortnite_jiggle_s1.mp3"} }
	,[f.."autumntea"] = { {s.."fortnite/amod_fortnite_autumn_tea_loop.mp3"},2.82 ,{s.."fortnite/amod_fortnite_autumn_tea_loop.mp3"},nil,{s.."fortnite/amod_fortnite_autumn_tea_intro.mp3"} }
	,[f.."twisteternity_ayo"] = { {s.."fortnite/amod_fortnite_twisteternity.mp3"} }
	,[f.."twisteternity_teo"] = { {s.."fortnite/amod_fortnite_twisteternity.mp3"} }
	,[f.."bythefire_follower"] = { {s.."fortnite/amod_fortnite_bythefire.mp3"} }
	,[f.."bythefire_leader"] = { {s.."fortnite/amod_fortnite_bythefire.mp3"} }
	,[f.."jumpingjoy_walk"] = { {s.."fortnite/amod_fortnite_jumpingjoy.mp3"} }
	,[f.."jumpingjoy_static"] = { {s.."fortnite/amod_fortnite_jumpingjoy.mp3"} }
	,[f.."rememberme"] = { {s.."fortnite/amod_fortnite_rememberme_s2.mp3"},1.45 ,{s.."fortnite/amod_fortnite_rememberme_s2.mp3"},nil,{s.."fortnite/amod_fortnite_rememberme_s1.mp3"},0.5 }
	,[f.."cerealbox"] = { {s.."fortnite/amod_fortnite_cerealbox_t2.mp3"},1.2 ,{s.."fortnite/amod_fortnite_cerealbox_t2.mp3"},nil,{s.."fortnite/amod_fortnite_cerealbox_t1.mp3"} }
	,[f.."chew"] = { {s.."fortnite/amod_fortnite_chew_2.mp3"},3.65 ,{s.."fortnite/amod_fortnite_chew_2.mp3"},nil,{s.."fortnite/amod_fortnite_chew_1.mp3"} }
	,[f.."devotion"] = { {s.."fortnite/amod_fortnite_devotion_2.mp3"},0.45 ,{s.."fortnite/amod_fortnite_devotion_2.mp3"},nil,{s.."fortnite/amod_fortnite_devotion_1.mp3"} }
	,[f.."griddle"] = { {s.."fortnite/amod_fortnite_griddle.mp3"} }
	,[f.."griddle_walk"] = { {s.."fortnite/amod_fortnite_griddle.mp3"} }
	,[f.."walkywalk"] = { {s.."fortnite/amod_fortnite_walkywalk.mp3"} }
	,[f.."walkywalk_walk"] = { {s.."fortnite/amod_fortnite_walkywalk.mp3"} }
	,[f.."kpopdance_04"] = { {s.."fortnite/emote_kpop_04.mp3"} }
	,[f.."papayacommsclap"] = { {s.."fortnite/Emote_Comms_Claps_Loop_01.mp3"} }
	,[f.."undead"] = { {s.."fortnite/Emote_Undead_Loop.mp3"},1.45 ,{s.."fortnite/Emote_Undead_Loop.mp3"},nil,{s.."fortnite/Emote_Undead_Intro.mp3"} }
	,[f.."easternbloc"] = { {s.."fortnite/eastern_bloc_musc_setup_D.mp3"},nil ,{s.."fortnite/eastern_bloc_musc_setup_D.mp3"},nil,{s.."fortnite/eastern_bloc_musc_setup_intro.mp3"} }
	,[f.."poutyclap"] = { {s.."fortnite/Emote_PoutyClap_ClapLoop.mp3"},2.0 ,{s.."fortnite/Emote_PoutyClap_ClapLoop.mp3"},nil,{s.."fortnite/Emote_PoutyClap_Intro.mp3"} }
	,[f.."ringer"] = { {s.."fortnite/Emote_Ringer_Loop.mp3"} }
	,[f.."ringer_walk"] = { {s.."fortnite/Emote_Ringer_Loop.mp3"} }
	,[f.."patpat_intro"] = { {s.."fortnite/Emote_PatPat_Intro_01.mp3"} }
	,[f.."patpat_j1"] = { {s.."fortnite/Emote_PatPat_Join_01.mp3"} }
	,[f.."patpat_j2"] = { {s.."fortnite/Emote_PatPat_JoinM_01.mp3"} }
	,[f.."chilled"] = { {s.."fortnite/Lil_Whip_Emote_Loop.mp3"} }
	,[f.."alien"] = { {s.."fortnite/Emote_Alien_Music_01.mp3"} }
	,[f.."iconic"] = { {s.."fortnite/Emote_Iconic_Loop.mp3"},0.9 ,{s.."fortnite/Emote_Iconic_Loop.mp3"},nil,{s.."fortnite/Emote_Iconic_Intro.mp3"} }
	,[f.."chickenleg"] = { {s.."fortnite/Emote_ChickenLeg_V2.mp3"},0.5 ,{s.."fortnite/Emote_ChickenLeg_V2.mp3"},nil,{s.."fortnite/Emote_ChickenLeg_Intro_V2.mp3"} }
	,[f.."selenecobra"] = { {s.."fortnite/Emote_SeleneCobr_Music_Loop.mp3"},1.133 ,{s.."fortnite/Emote_SeleneCobr_Music_Loop.mp3"},nil,{s.."fortnite/Emote_SeleneCobr_Music_Intro.mp3"} }
	,[f.."snowfall"] = { {s.."fortnite/Emote_Snowfall.mp3"} }
	,[f.."reign"] = { {s.."fortnite/Emote_Reign_Music_Loop.mp3"},0.767 ,{s.."fortnite/Emote_Reign_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Reign_Music_Intro.mp3"},0.05 }
	,[f.."whisk"] = { {s.."fortnite/Emote_Whisk_Loop.mp3"} }
	,[f.."metronome"] = { {s.."fortnite/Emote_Metronom_Loop.mp3"},0.5 ,{s.."fortnite/Emote_Metronom_Loop.mp3"},nil,{s.."fortnite/Emote_Metronom_Intro.mp3"} }
	,[f.."justhome"] = { {s.."fortnite/Emote_Just_Home_Music_Loop.mp3"} }
	,[f.."darling"] = { {s.."fortnite/Emote_Darling_Loop.mp3"},0.667 ,{s.."fortnite/Emote_Darling_Loop.mp3"},nil,{s.."fortnite/Emote_Darling_Intro.mp3"} }
	,[f.."triumphant"] = { {s.."fortnite/Emote_Triumphant_MX_LP.mp3"} }
	,[f.."boomer"] = { {s.."fortnite/Emote_Boomer.mp3"} }
	,[f.."clamor"] = { {s.."fortnite/Emote_Clamor_Full_Loop.mp3"},1.731 ,{s.."fortnite/Emote_Clamor_Full_Loop.mp3"},nil,{s.."fortnite/Emote_Clamor_Intro_V2.mp3"} }
	,[f.."hurrah"] = { {s.."fortnite/Emote_Hurrah_Music_Loop.mp3"},0.933 ,{s.."fortnite/Emote_Hurrah_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Hurrah_Music_Intro.mp3"} }
	,[f.."tollbridge"] = { {s.."fortnite/Emote_TollBridge_Music_Loop.mp3"},0.467 ,{s.."fortnite/Emote_TollBridge_Music_Loop.mp3"},nil,{s.."fortnite/Emote_TollBridge_Music_Intro.mp3"} }
	,[f.."bewilder"] = { {s.."fortnite/Emote_Bewilder_Music_Loop.mp3"},0.467 ,{s.."fortnite/Emote_Bewilder_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Bewilder_Music_Intro.mp3"} }
	,[f.."wheresmatt"] = { {s.."fortnite/Emote_Where_Is_Matt_Mix_01.mp3"} }
	,[f.."wheresmatt_walk"] = { {s.."fortnite/Emote_Where_Is_Matt_Mix_01.mp3"} }
	,[f.."reverie"] = { {s.."fortnite/Emote_Reverie_Music_Loop.mp3"},0.533 ,{s.."fortnite/Emote_Reverie_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Reverie_Music_Intro.mp3"} }
	,[f.."reverie_mirror"] = { {s.."fortnite/Emote_Reverie_Music_Loop.mp3"},0.533 ,{s.."fortnite/Emote_Reverie_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Reverie_Music_Intro.mp3"} }
	,[f.."montecarlo"] = { {s.."fortnite/Emote_MonteCarlo.mp3"} }
	,[f.."shiverflame"] = { {s.."fortnite/Emonte_Shiverflame_Loop.mp3"},0.567 ,{s.."fortnite/Emonte_Shiverflame_Loop.mp3"},nil,{s.."fortnite/Emonte_Shiverflame_Intro.mp3"} }
	,[f.."canine"] = { {s.."fortnite/Emote_Canine_Music_Loop.mp3"},4.033 ,{s.."fortnite/Emote_Canine_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Canine_Music_Intro.mp3"} }
	,[f.."dignified"] = { {s.."fortnite/Emote_Dignified_Music_Loop.mp3"},0.467 ,{s.."fortnite/Emote_Dignified_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Dignified_Music_Intro.mp3"} }
	,[f.."cadaver"] = { {s.."fortnite/Emote_Cadaver_Music_Loop.mp3"},0.333 ,{s.."fortnite/Emote_Cadaver_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Cadaver_Music_Intro.mp3"} }
	,[f.."intermission"] = { {s.."fortnite/Intermission_Music_Loop_01.mp3"},1.33 ,{s.."fortnite/Intermission_Music_Loop_01.mp3"},nil,{s.."fortnite/Intermission_Music_Intro_01.mp3"} }
	,[f.."harmony_1"] = { {s.."fortnite/Emote_Harmony_Music_Loop.mp3"},1.367 ,{s.."fortnite/Emote_Harmony_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Harmony_Music_Intro.mp3"} }
	,[f.."harmony_3"] = { {s.."fortnite/Emote_Harmony_Music_Loop.mp3"},1.367 ,{s.."fortnite/Emote_Harmony_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Harmony_Music_Intro.mp3"} }
	,[f.."rumblefemale"] = { {s.."fortnite/Emote_RumbleFemale_Music_Loop.mp3"},0.1 ,{s.."fortnite/Emote_RumbleFemale_Music_Loop.mp3"},nil,{s.."fortnite/Emote_RumbleFemale_Music_Intro.mp3"} }
	,[f.."plasticfork"] = { {s.."fortnite/Emote_PlasticFork_Music_Loop.mp3"},4.8 ,{s.."fortnite/Emote_PlasticFork_Music_Loop.mp3"},nil,{s.."fortnite/Emote_PlasticFork_Music_Intro.mp3"} }
	,[f.."plasticfork_walk"] = { {s.."fortnite/Emote_PlasticFork_Music_Loop.mp3"},4.8 ,{s.."fortnite/Emote_PlasticFork_Music_Loop.mp3"},nil,{s.."fortnite/Emote_PlasticFork_Music_Intro.mp3"} }
	,[f.."thrive"] = { {s.."fortnite/Emote_Thrive_Loop_short.mp3"},4.733 ,{s.."fortnite/Emote_Thrive_Loop_short.mp3"},nil,{s.."fortnite/Emote_Thrive_Start.mp3"} }
	,[f.."farewell"] = { {s.."fortnite/Emote_Farewell_Music_Loop.mp3"},0.7 ,{s.."fortnite/Emote_Farewell_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Farewell_Music_Intro.mp3"} }
	,[f.."downward"] = { {s.."fortnite/Emote_Downward.mp3"} }
	,[f.."elegantlilycharm"] = { {s.."fortnite/Emote_ElegantLilyCharm_Music_Loop.mp3"},0.56 ,{s.."fortnite/Emote_ElegantLilyCharm_Music_Loop.mp3"},nil,{s.."fortnite/Emote_ElegantLilyCharm_Music_Intro.mp3"} }
	,[f.."elegantlily"] = { {s.."fortnite/Emote_ElegantLily_Music_Loop.mp3"},0.76667 ,{s.."fortnite/Emote_ElegantLily_Music_Loop.mp3"},nil,{s.."fortnite/Emote_ElegantLily_Music_Intro.mp3"} }
	,[f.."nimble"] = { {s.."fortnite/Emote_Nimble_Loop.mp3"} }
	,[f.."vacant"] = { {s.."fortnite/Emote_Vacant_Music_Loop.mp3"},4.93333 ,{s.."fortnite/Emote_Vacant_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Vacant_Music_Intro.mp3"} }
	,[f.."blazerveil"] = { {s.."fortnite/Emote_BlazerVeil_Music_Loop.mp3"},5.05 ,{s.."fortnite/Emote_BlazerVeil_Music_Loop.mp3"},nil,{s.."fortnite/Emote_BlazerVeil_Music_Intro.mp3"},0.055 }
	,[f.."sillyjumps"] = { {s.."fortnite/Emote_Silly_Jump_Music_Loop.mp3"} }
	,[f.."sillyjumps_walk"] = { {s.."fortnite/Emote_Silly_Jump_Music_Loop.mp3"} }
	,[f.."dimension"] = { {s.."fortnite/Emote_Dimension_Music_Loop.mp3"},0.3667 ,{s.."fortnite/Emote_Dimension_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Dimension_Music_Intro.mp3"} }
	,[f.."playereleven"] = { {s.."fortnite/Emote_Player_Eleven_Loop.mp3"} }
	,[f.."coyotetrail_lead"] = { {s.."fortnite/Emote_Coyote_Trail_Loop.mp3"} }
	,[f.."enrapture"] = { {s.."fortnite/Emote_Enrapture_Music_Loop.mp3"},1.53333 ,{s.."fortnite/Emote_Enrapture_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Enrapture_Music_Intro.mp3"} }
	,[f.."kelplinen"] = { {s.."fortnite/Emote_KelpLinen_Music_Loop.mp3"},1.53333 ,{s.."fortnite/Emote_KelpLinen_Music_Loop.mp3"},nil,{s.."fortnite/Emote_KelpLinen_Music_Intro.mp3"} }
	,[f.."mesmerize"] = { {s.."fortnite/Emote_Mesmerize_Music_Loop.mp3"},0.63333 ,{s.."fortnite/Emote_Mesmerize_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Mesmerize_Music_Intro.mp3"} }
	,[f.."jadetowel"] = { {s.."fortnite/Emote_JadeTowel_Music_Loop.mp3"},0.73333 ,{s.."fortnite/Emote_JadeTowel_Music_Loop.mp3"},nil,{s.."fortnite/Emote_JadeTowel_Music_Intro.mp3"} }
	,[f.."jadetowel_gloss"] = { {s.."fortnite/Emote_JadeTowel_Gloss_Music_Loop.mp3"},0.36667 ,{s.."fortnite/Emote_JadeTowel_Gloss_Music_Loop.mp3"},nil,{s.."fortnite/Emote_JadeTowel_Gloss_Music_Intro.mp3"},0.05 }
	,[f.."crisscross"] = { {s.."fortnite/Criss_Cross_Emote_Music_01_Loop.mp3"} }
	,[f.."resonant"] = { {s.."fortnite/Emote_Resonant_Loop.mp3"} }
	,[f.."resonant_walk"] = { {s.."fortnite/Emote_Resonant_Loop.mp3"} }
	,[f.."lemoncart_walk"] = { {s.."fortnite/Emote_LemonCart_Music_Loop.mp3"},0.66667 ,{s.."fortnite/Emote_LemonCart_Music_Loop.mp3"},nil,{s.."fortnite/Emote_LemonCart_Music_Intro.mp3"} }
	,[f.."lemoncart_static"] = { {s.."fortnite/Emote_LemonCart_Music_Loop.mp3"},0.66667 ,{s.."fortnite/Emote_LemonCart_Music_Loop.mp3"},nil,{s.."fortnite/Emote_LemonCart_Music_Intro.mp3"} }
	,[f.."studs"] = { {s.."fortnite/Emote_Studs_Music_Loop.mp3"},0.5 ,{s.."fortnite/Emote_Studs_Music_Loop.mp3"},nil,{s.."fortnite/Emote_Studs_Music_Intro.mp3"} }
	,[f.."sneaky"] = { {s.."fortnite/Athena_Emote_SneakyTraversal_Music.mp3"} }
	,[f.."sneaky_walk"] = { {s.."fortnite/Athena_Emote_SneakyTraversal_Music.mp3"} }
	,[f.."congaline"] = { {s.."fortnite/Emote_Conga_Line_Music_Loop.mp3"} }
	,[f.."congaline_walk"] = { {s.."fortnite/Emote_Conga_Line_Music_Loop.mp3"} }
	,[f.."hip_hop"] = { {s.."fortnite/S5_HipHop_B_Loop.mp3"} }
	,[f.."cry"] = { {s.."fortnite/Emote_Cry_Loop.mp3"},1.1 ,{s.."fortnite/Emote_Cry_Loop.mp3"},nil,{s.."fortnite/Emote_Cry_Start.mp3"} }
	,[f.."ridethepony"] = { {s.."fortnite/emote_ridethepony_music_02.mp3"} }
	,[f.."ridethepony_walk"] = { {s.."fortnite/emote_ridethepony_music_02.mp3"} }
	,[f.."myeffort"] = { {s.."fortnite/Emote_MyEffort.mp3"} }
}

A_AM.ActMod.GTabSd_AM4_P = {
	[p.."samsara"] = { {s.."pubg/amod_pubg_samsara.mp3"},nil ,{s.."pubg/amod_pubg_samsara_loop.mp3"} }
	,[p.."victorydance102"] = { {s.."pubg/amod_pubg_victorydance102.mp3"},nil ,{s.."pubg/amod_pubg_victorydance102_loop.mp3"} }
	,[p.."victorydance99"] = { {s.."pubg/amod_pubg_victorydance99.mp3"},nil ,{s.."pubg/amod_pubg_victorydance99_loop.mp3"} }
	,[p.."seetinh"] = { {s.."pubg/amod_pubg_seetinh.mp3"} }
	,[p.."bboombboom"] = { {s.."pubg/amod_pubg_bboombboom.mp3"} }
	,[p.."victorydance60"] = { {s.."pubg/amod_pubg_victorydance60.mp3"} }
	,[p.."2phuthon"] = { {s.."pubg/amod_pubg_2phuthon.mp3"} }
	,[p.."tocatoca"] = { {s.."pubg/amod_pubg_tocatoca_a.mp3"},nil ,{s.."pubg/amod_pubg_tocatoca_b.mp3"} }
	,[p.."rollnrock"] = { {s.."pubg/PUBG_RollnRockLoop.mp3"} }
	,[p.."poppy"] = { {s.."pubg/amod_pubg_poppy_t2.mp3"},2.167 ,{s.."pubg/amod_pubg_poppy_t2.mp3"},nil,{s.."pubg/amod_pubg_poppy_t1.mp3"} }
	,[p.."victorydance118"] = { {s.."pubg/PUBG_VictoryDance118_2.mp3"},8.03 ,{s.."pubg/PUBG_VictoryDance118_2.mp3"},nil,{s.."pubg/PUBG_VictoryDance118_1.mp3"} }
}

A_AM.ActMod.GTabSd_AM4_MMD = {
	[m.."helltaker"] = { {s.."mmd/amod_mmd_helltaker.mp3"} }
	,[m.."dance_nostalogic"] = { {s.."mmd/amod_mmd_nostalogic.mp3"} }
	,[m.."dance_specialist"] = { {s.."mmd/amod_mmd_specialist.mp3"} }
	,[m.."dance_daisukeevolution"] = { {s.."mmd/amod_mmd_daisukeevolution.mp3"} }
	,[m.."dance_caramelldansen"] = { {s.."mmd/amod_mmd_caramelldansen.mp3"} }
	,[m.."whistle"] = { {s.."mmd/amod_mmd_whistle.mp3"} }
	,[m.."badbadwater"] = { {s.."mmd/amod_mmd_badbadwater.mp3"} }
	,[m.."king_kanaria"] = { {s.."mmd/amod_mmd_king_kanaria.mp3"} }
	,[m.."dance_tuni-kun"] = { {s.."mmd/amod_mmd_dance_tuni-kun.mp3"} }
	,[m.."fiery_sarilang"] = { {s.."mmd/amod_mmd_fiery_sarilang.mp3"} }
	,[m.."followtheleader"] = { {s.."mmd/amod_mmd_followtheleader.mp3"} }
	,[m.."getdown"] = { {s.."mmd/amod_mmd_getdown.mp3"} }
	,[m.."goodbyedeclaration"] = { {s.."mmd/amod_mmd_goodbyedeclaration.mp3"} }
	,[m.."ponponpon"] = { {s.."mmd/amod_mmd_ponponpon.mp3"} }
	,[m.."girls"] = { {s.."mmd/amod_mmd_girls.mp3"} }
	,[m.."mrsaxobeat"] = { {s.."mmd/amod_mmd_mrsaxobeat.mp3"} }
	,[m.."aoagoodluck"] = { {s.."mmd/amod_mmd_aoagoodluck.mp3"} }
	,[m.."nyaarigato"] = { {s.."mmd/amod_mmd_nyaarigato.mp3"} }
	,[m.."ghostdance"] = { {s.."mmd/amod_mmd_ghostdance.mp3"} }
	,[m.."blablabla"] = { {s.."mmd/amod_mmd_blablabla.mp3"} }
	,[m.."hiasobi"] = { {s.."mmd/amod_mmd_hiasobi.mp3"} }
	,[m.."hiproll_loop"] = { {s.."mmd/amod_mmd_hiproll_t2.mp3"} }
	,[m.."hiproll"] = { {s.."mmd/amod_mmd_hiproll_t1.mp3"},nil,{s.."mmd/amod_mmd_hiproll_t2.mp3"} }
	,[m.."chikichiki"] = { {s.."mmd/amod_mmd_chikichiki.mp3"} }
	,[m.."caixukun"] = { {s.."mmd/amod_mmd_caixukun.mp3"} }
	,[m.."calisthenics"] = { {s.."mmd/amod_mmd_calisthenics.mp3"} }
	,[m.."dance_gokurakujodo"] = { {s.."mmd/amod_mmd_gokurakujodo.mp3"} }
	,[m.."dance_gokurakujodo_C1"] = { {s.."mmd/amod_mmd_despacito.mp3"} }
	,[m.."theatrical_airline_luk"] = { {s.."mmd/tricoloreairline2020remake.mp3"} }
	,[m.."theatrical_airline_mik"] = { {s.."mmd/tricoloreairline2020remake.mp3"} }
	,[m.."theatrical_airline_rin"] = { {s.."mmd/tricoloreairline2020remake.mp3"} }
	,[m.."sadcatdance"] = { {s.."mmd/amod_mmd_sadcatdance.mp3"},nil,{s.."mmd/amod_mmd_sadcatdance_loop.mp3"} }
	,[m.."sadcatdance_loop"] = { {s.."mmd/amod_mmd_sadcatdance_loop.mp3"} }
	,[m.."phao2phuthon_p1"] = { {s.."mmd/amod_mmd_phao2phuthon_p1.mp3"} }
	,[m.."phao2phuthon_p2"] = { {s.."mmd/amod_mmd_phao2phuthon_p1.mp3"} }
	,[m.."phao2phuthon_p3"] = { {s.."mmd/amod_mmd_phao2phuthon_p1.mp3"} }
	,[m.."phao2phuthon_p4"] = { {s.."mmd/amod_mmd_phao2phuthon_p1.mp3"} }
	,[m.."phao2phuthon_p5"] = { {s.."mmd/amod_mmd_phao2phuthon_p1.mp3"} }
	,[m.."pv120_shi_p1"] = { {s.."mmd/amod_mmd_pv120_shake_it.mp3"} }
	,[m.."pv120_shi_p2"] = { {s.."mmd/amod_mmd_pv120_shake_it.mp3"} }
	,[m.."pv120_shi_p3"] = { {s.."mmd/amod_mmd_pv120_shake_it.mp3"} }
	,[m.."lmfao"] = { {s.."mmd/amod_mmd_lmfao_s2.mp3"},2.1 ,{s.."mmd/amod_mmd_lmfao_s2.mp3"},nil,{s.."mmd/amod_mmd_lmfao_s1.mp3"} }
	,[m.."s001"] = { {s.."mmd/amod_mmd_s001.mp3"} }
	,[m.."s002"] = { {s.."mmd/amod_mmd_s002.mp3"} }
	,[m.."s003"] = { {s.."mmd/amod_mmd_s003.mp3"} }
	,[m.."s004"] = { {s.."mmd/amod_mmd_s004.mp3"} }
	,[m.."s005"] = { {s.."mmd/amod_mmd_s005.mp3"} }
	,[m.."s006"] = { {s.."mmd/amod_mmd_s006.mp3"} }
	,[m.."s007"] = { {s.."mmd/amod_mmd_s007.mp3"} }
	,[m.."s008"] = { {s.."mmd/amod_mmd_s008.mp3"} }
	,[m.."s009"] = { {s.."mmd/amod_mmd_s009.mp3"} }
	,[m.."s010"] = { {s.."mmd/amod_mmd_s010.mp3"} }
	,[m.."s011"] = { {s.."mmd/amod_mmd_s011.mp3"} }
	,[m.."s012"] = { {s.."mmd/amod_mmd_s012.mp3"} }
	,[m.."s013"] = { {s.."mmd/amod_mmd_s013.mp3"} }
	,[m.."s014"] = { {s.."mmd/amod_mmd_s014.mp3"} }
	,[m.."s015"] = { {s.."mmd/amod_mmd_s015.mp3"} }
	,[m.."s017"] = { {s.."mmd/amod_mmd_s017.mp3"} }
	,[m.."bad_apple_l"] = { {s.."mmd/amod_mmd_bad_apple.mp3"} }
	,[m.."bad_apple_r"] = { {s.."mmd/amod_mmd_bad_apple.mp3"} }
	,[m.."gfriendrough"] = { {s.."mmd/amod_mmd_gfriendrough.mp3"} }
	,[m.."massdestruction"] = { {s.."mmd/amod_mmd_massdestruction.mp3"} }
	,[m.."mememe"] = { {s.."mmd/amod_mmd_mememe.mp3"} }
	,[m.."roki_p1"] = { {s.."mmd/amod_mmd_roki.mp3"} }
	,[m.."roki_p2"] = { {s.."mmd/amod_mmd_roki.mp3"} }
	,[m.."senbonzakura"] = { {s.."mmd/amod_mmd_senbonzakura.mp3"} }
	,[m.."supermjopping"] = { {s.."mmd/amod_mmd_supermjopping.mp3"} }
	,[m.."nahoha"] = { {s.."mmd/amod_mmd_nahoha.mp3"} }
	,[m.."ch4nge"] = { {s.."mmd/amod_mmd_ch4nge.mp3"} }
	,[m.."conqueror"] = { {s.."mmd/amod_mmd_conqueror.mp3"} }
	,[m.."yoidore"] = { {s.."mmd/amod_mmd_yoidore.mp3"} }
	,[m.."dokuhebi"] = { {s.."mmd/amod_mmd_dokuhebii.mp3"} }
	,[m.."darling"] = { {s.."mmd/amod_mmd_darling.mp3"} }
	,[m.."dancin"] = { {s.."mmd/amod_mmd_dancin.mp3"} }
	,[m.."adeepmentality"] = { {s.."mmd/amod_mmd_adeepmentality.mp3"} }
	,[m.."gimmexgimme"] = { {s.."mmd/amod_mmd_gimmexgimme.mp3"} }
	,[m.."yaosobi-idol"] = { {s.."mmd/amod_mmd_yaosobi-idol.mp3"} }
	,[m.."kwlink"] = { {s.."mmd/amod_mmd_kwlink.mp3"} }
	,[m.."adj_1"] = { {s.."mmd/amod_mmd_adj_1.mp3"} }
	,[m.."adj_2"] = { {s.."mmd/amod_mmd_adj_1.mp3"} }
	,[m.."kemuthree"] = { {s.."mmd/amod_mmd_kemuthree.mp3"} }
	,[m.."aloveit"] = { {s.."mmd/amod_mmd_aloveit2.mp3"},1.6 ,{s.."mmd/amod_mmd_aloveit2.mp3"},nil,{s.."mmd/amod_mmd_aloveit1.mp3"} }
	,[m.."imfgood"] = { {s.."mmd/amod_mmd_imfgood.mp3"} }
	,[m.."drunkendutterfly"] = { {s.."mmd/amod_mmd_drunkendutterfly.mp3"} }
	,[m.."bibbib"] = { {s.."mmd/amod_mmd_bibibb.mp3"},0.3 }
	,[m.."peachbsmile"] = { {s.."mmd/mmd_peachblossom.mp3"} }
	,[m.."bananasong"] = { {s.."mmd/amod_mmd_bananasong.mp3"} }
	,[m.."littleapple"] = { {s.."mmd/mmd_littleaapple.mp3"},0.5 }
	,[m.."shiknok"] = { {s.."mmd/mmd_Shikonokonokonokoshtantan_l.mp3"},0.2 ,{s.."mmd/mmd_Shikonokonokonokoshtantan_l.mp3"},nil,{s.."mmd/mmd_Shikonokonokonokoshtantan_i.mp3"} }
	,[m.."dancehall_1"] = { {s.."mmd/mmd_HeartPDancehall.mp3"},0.7 }
	,[m.."dancehall_2"] = { {s.."mmd/mmd_HeartPDancehall.mp3"},0.7 }
	,[m.."zhangshiyao"] = { {s.."mmd/amod_mmd_zhangshiyao.mp3"} }
	,[m.."pokedance"] = { {s.."mmd/amod_MMD_POKEDANCE_l.mp3"},4.5 ,{s.."mmd/amod_MMD_POKEDANCE_l.mp3"},nil,{s.."mmd/amod_MMD_POKEDANCE_I.mp3"} }
	,[m.."beyondtheway_1"] = { {s.."mmd/amod_mmd_Beyond_the_way_feat.mp3"},0.5 }
	,[m.."beyondtheway_2"] = { {s.."mmd/amod_mmd_Beyond_the_way_feat.mp3"},0.5 }
	,[m.."beyondtheway_3"] = { {s.."mmd/amod_mmd_Beyond_the_way_feat.mp3"},0.5 }
	,[m.."beyondtheway_4"] = { {s.."mmd/amod_mmd_Beyond_the_way_feat.mp3"},0.5 }
	,[m.."beyondtheway_5"] = { {s.."mmd/amod_mmd_Beyond_the_way_feat.mp3"},0.6 }
	,[m.."ph"] = { {s.."mmd/mmd_ph.mp3"} }
}






A_AM.ActMod.GTabActO = {
	// Gmod \\
	["taunt_laugh"] = { ["RNAnim"] = "taunt_laugh_base" ,[rAA] = true }
	,["taunt_cheer"] = { ["RNAnim"] = "taunt_cheer_base" ,[rAA] = true }
	,["taunt_muscle"] = { ["RNAnim"] = "taunt_muscle_base" ,[rAA] = true }
	,["taunt_persistence"] = { ["RNAnim"] = "taunt_persistence_base" ,[rAA] = true }
	,["taunt_robot"] = { ["RNAnim"] = "taunt_robot_base" ,[rAA] = true }
	,["taunt_dance"] = { ["RNAnim"] = "taunt_dance_base" ,[rAA] = true ,["ResetAni"] = true ,[nS] = 9 ,["C_"] = {
		[C_a] = { [T2] = 5.854 ,[cY] = 0.38703098893166 } }
	}
	
	
	-- ,["taunt_bow"] = { ["RNAnim"] = "gesture_bow" ,["itsG"] = true ,[nS] = 63 ,["Rate"] = 1.3}
	,["gmod_g_wave"] = { ["RNAnim"] = "gesture_wave" ,[nS] = 63 ,["G_Rate"] = 1.1}
	,["gmod_g_bow"] = { ["RNAnim"] = "gesture_bow" ,[nS] = 63 ,["G_Rate"] = 1.3}
	,["gmod_g_agree"] = { ["RNAnim"] = "gesture_agree" ,[nS] = 63 ,["G_Rate"] = 1.1}
	,["gmod_g_becon"] = { ["RNAnim"] = "gesture_becon" ,[nS] = 63 ,["G_Rate"] = 1.3}
	,["gmod_g_disagree"] = { ["RNAnim"] = "gesture_disagree" ,[nS] = 63 ,["G_Rate"] = 1.1}
	,["gmod_g_salute"] = { ["RNAnim"] = "gesture_salute" ,[nS] = 63 ,["G_Rate"] = 1.1}
	,["gmod_g_signal_forward"] = { ["RNAnim"] = "gesture_signal_forward" ,[nS] = 63 ,["G_Rate"] = 1}
	,["gmod_g_signal_group"] = { ["RNAnim"] = "gesture_signal_group" ,[nS] = 63 ,["G_Rate"] = 1.1}
	,["gmod_g_signal_halt"] = { ["RNAnim"] = "gesture_signal_halt" ,[nS] = 63 ,["G_Rate"] = 1.1}
	,["gmod_g_item_drop"] = { ["RNAnim"] = "gesture_item_drop" ,[nS] = 63 ,["G_Rate"] = 1.2}
	,["gmod_g_item_give"] = { ["RNAnim"] = "gesture_item_give" ,[nS] = 63 ,["G_Rate"] = 1.2}
	,["gmod_g_item_place"] = { ["RNAnim"] = "gesture_item_place" ,[nS] = 63 ,["G_Rate"] = 1.2}
	,["gmod_g_item_throw"] = { ["RNAnim"] = "gesture_item_throw" ,[nS] = 63 ,["G_Rate"] = 1.2}
	
	
	,["idle_all_01"] = { [nS] = 0 }
	,["idle_all_02"] = { [nS] = 0 }
	,["menu_combine"] = { [aRA] = true }
	,["idle_all_cower"] = { [nS] = 0 }
	,["idle_all_angry"] = { [nS] = 0 }
	,["idle_all_scared"] = { [nS] = 0 }
	,["idle_suitcase"] = { [nS] = 0 }
	,["menu_gman"] = { [nS] = 0 }
	,["menu_zombie_01"] = { [nS] = 0 }
	,["ragdoll"] = { [nS] = 0 }
	,["reference"] = { [nS] = 0 }
	,["zombie_walk_01"] = { [nS] = 0 ,[mD] = 8,[MS] = 45
		,["CCAni"] = {
			["CK1"] = {
				[1] = {["GetDir"] = "zombie_walk_01",["SetDir"] = "zombie_walk_02" ,["TimeHold"] = 0.3}
				,[2] = {["GetDir"] = "zombie_walk_02",["SetDir"] = "zombie_walk_03" ,["TimeHold"] = 0.3}
				,[3] = {["GetDir"] = "zombie_walk_03",["SetDir"] = "zombie_walk_04" ,["TimeHold"] = 0.3}
				,[4] = {["GetDir"] = "zombie_walk_04",["SetDir"] = "zombie_walk_05" ,["TimeHold"] = 0.3}
				,[5] = {["GetDir"] = "zombie_walk_05",["SetDir"] = "zombie_walk_06" ,["TimeHold"] = 0.3}
				,[6] = {["GetDir"] = "zombie_walk_06",["SetDir"] = "zombie_walk_01" ,["TimeHold"] = 0.3}
			}
			,["CK2"] = {
				[1] = {["GetDir"] = "zombie_walk_01",["SetDir"] = "zombie_walk_06" ,["TimeHold"] = 0.3}
				,[2] = {["GetDir"] = "zombie_walk_02",["SetDir"] = "zombie_walk_01" ,["TimeHold"] = 0.3}
				,[3] = {["GetDir"] = "zombie_walk_03",["SetDir"] = "zombie_walk_02" ,["TimeHold"] = 0.3}
				,[4] = {["GetDir"] = "zombie_walk_04",["SetDir"] = "zombie_walk_03" ,["TimeHold"] = 0.3}
				,[5] = {["GetDir"] = "zombie_walk_05",["SetDir"] = "zombie_walk_04" ,["TimeHold"] = 0.3}
				,[6] = {["GetDir"] = "zombie_walk_06",["SetDir"] = "zombie_walk_05" ,["TimeHold"] = 0.3}
			}
		}
	}
	,["zombie_run"] = { [nS] = 0 ,[mD] = 8,[MS] = 220
		,["CCAni"] = {
			["CK1"] = {
				[1] = {["GetDir"] = "zombie_run",["SetDir"] = "zombie_run_fast" ,["TimeHold"] = 0.3}
				,[2] = {["GetDir"] = "zombie_run_fast",["SetDir"] = "zombie_run" ,["TimeHold"] = 0.3}
			}
		}
	}
	,["zombie_idle_01"] = { [nS] = 0 ,[mD] = 7
		,["CCAni"] = {
			["CK1"] = {
				[1] = {["GetDir"] = "zombie_idle_01",["SetDir"] = {"zombie_slump_rise_01",true,1,{[cY] = 0,["Rate"] = 0}} ,["TimeHold"] = 3.3 ,[cY] = 0.9,["Rate"] = -1}
				,[2] = {["GetDir"] = "zombie_slump_rise_01",["SetDir"] = {"zombie_slump_rise_01",true,0.9,{["Dir"] = "zombie_idle_01"}} ,["TimeHold"] = 3.3 ,[cY] = 0,["Rate"] = 1}
				,[3] = {["GetDir"] = "zombie_slump_rise_02_fast",["SetDir"] = {"zombie_slump_rise_02_fast",true,1,{["Dir"] = "zombie_idle_01"}} ,["TimeHold"] = 1.8 ,[cY] = 0,["Rate"] = 1}
			}
			,["CK2"] = {
				[1] = {["GetDir"] = "zombie_idle_01",["SetDir"] = {"zombie_slump_rise_02_fast",true,1,{[cY] = 0,["Rate"] = 0}} ,["TimeHold"] = 1.6 ,[cY] = 0.7,["Rate"] = -1}
				,[2] = {["GetDir"] = "zombie_slump_rise_02_fast",["SetDir"] = {"zombie_slump_rise_02_fast",true,0.6,{["Dir"] = "zombie_idle_01"}} ,["TimeHold"] = 1.8 ,[cY] = 0,["Rate"] = 1}
				,[3] = {["GetDir"] = "zombie_slump_rise_01",["SetDir"] = {"zombie_slump_rise_01",true,1,{["Dir"] = "zombie_idle_01"}} ,["TimeHold"] = 3.3 ,[cY] = 0,["Rate"] = 1}
			}
		}
	}
	// v9.7
	,["drive_airboat"] = { [nS] = 0 }
	,["drive_pd"] = { [nS] = 0 }
	,["sit"] = { [nS] = 0 }
	,["sit_zen"] = { [nS] = 0 }
	
	// Fortnite \\
	// old
	,[f.."kpopdance_04"] = { [aRA] = true ,["time*"] = 3 ,[tTC] = {{["_time"] = "Dtime"},3,0} }
	,[f.."epicsaxguy"] = { [aRA] = true ,["time*"] = 2 ,[tTC] = { {["_time"] = "Dtime"} ,1,0} }
	,[f.."easternbloc"] = { [nS] = 9 ,["C_"] = {
		[C_a] = { [T2] = 11.633 ,[cY] = 0.20501138269901 }
		,[C_s] = { [T1] = 14.2 }
		}
	}
	,[f.."thumbsup"] = {}
	,[f.."thumbsdown"] = {}
	,[f.."dancemoves"] = {}
	,[f.."nottoday"] = {}
	,[f.."cheerleader"] = { [aRA] = true }
	,[f.."facepalm"] = { ["THearP"] = true }
	,[f.."stagebow"] = { ["time-"] = 0.4 ,["THearP"] = true }
	,[f.."confused"] = { ["THearP"] = true }
	,[f.."idontknow"] = { ["THearP"] = true }
	,[f.."glowstickdance"] = { [nS] = 9 ,["Cycle_tt"] = 0.60725939273834 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 20 } } }
	,[f.."laugh"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0.18248175084591 ,[T2] = 7.46667 } ,[C_s] = { [T1] = 9.17 } } }
	,[f.."lookatthis"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 3.06667 ,[cY] = 0.22033898532391 } } }
	,[f.."boogie_down"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 4.43333 ,[cY] = 0.13636364042759 } ,[C_s] = { [T1] = 4.43333*4+0.7 ,[T2] = 4.43333*4 } } }
	,[f.."flossdance"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 8.35 } } }
	,[f.."electroshuffle"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 7.56 } } }
	,[f.."charleston"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 7.38 } } }
	,[f.."mind_blown"] = { ["time-"] = 0.5 ,["THearP"] = true }
	,[f.."maskoff"] = { [aRA] = true ,[nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0.084507040679455 ,[T2] = 6.5 } ,[C_s] = { [T1] = 6.5*3 -0.6 } } }
	,[f.."dancemoves2"] = { ["RNAnim"] = f.."dancemoves" ,[rAA] = true }
	,[f.."golfclap"] = { [nS] = 9 ,["C_"] = { [C_a] = { ["time*"] = 1 } } ,["THearP"] = true }
	,[f.."sneaky"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 50 ,["AalowAnim"] = true } ,["C_"] = { [C_s] = { [T1] = 2.83333*16 } } }
	,[f.."sneaky_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 50 } ,["C_"] = { [C_s] = { [T1] = 2.83333*16 } } }
	,[f.."congaline"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 50 ,["AalowAnim"] = true } ,["C_"] = { [C_s] = { [T1] = 7.86667*4 } } }
	,[f.."congaline_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 50 } ,["C_"] = { [C_s] = { [T1] = 7.86667*4 } } }
	,[f.."hip_hop"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 7.26667*2 } } }
	,[f.."cry"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.9 ,[cY] = 0.12222222238779 } ,[C_s] = { [T2] = 7.9 } } ,["THearP"] = true }
	,[f.."ridethepony"] = { [nS] = 9 ,["RNAnim"] = f.."dance_ridethepony_1" ,[tCA] = { ["T"] = 1.06667 ,["RNAnim"] = f.."dance_ridethepony_2" ,[mD] = 5 ,[MS] = 90 ,["AalowAnim"] = true } ,["C_"] = { [C_s] = { [T1] = 6.13 } } }
	,[f.."ridethepony_walk"] = { [nS] = 9 ,["RNAnim"] = f.."dance_ridethepony_1" ,[tCA] = { ["T"] = 1.06667 ,["RNAnim"] = f.."dance_ridethepony_3" ,[mD] = 1 ,[MS] = 90 } ,["C_"] = { [C_s] = { [T1] = 6.13 } } }

	// v9.2
	,[f.."twistdaytona"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { ["r"] = 0 } } }
	,[f.."twisteternity_ayo"] = { [aRA] = true }
	,[f.."twisteternity_teo"] = { [aRA] = true }
	,[f.."behere"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { ["r"] = 0 } } }
	,[f.."autumntea"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 11.2 ,[cY] = 0.20379146933556 } ,[C_s] = { [T2] = 11.2 } } }
	,[f.."eerie"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 32 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 33.33 } } }
	,[f.."eerie_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 32 } ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 33.33 } } }
	,[f.."nevergonna"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 8.4 ,[cY] = 0.15999999642372 } ,[C_s] = { [T1] = 33.6 } } }
	// v9.4
	,[f.."ohana"] = {}
	,[f.."spectacleweb"] = { ["THearP"] = true }
	,[f.."bythefire_leader"] = { [aRA] = true }
	,[f.."bythefire_follower"] = { [aRA] = true }
	,[f.."dance_distraction"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { ["r"] = 0 } } }
	,[f.."zest"] = { [aRA] = true }
	,[f.."prance"] = { [aRA] = true }
	,[f.."tally"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { ["r"] = 0 } } }
	,[f.."sleek"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { ["r"] = 0 } } }
	,[f.."promenadefollow"] = { [aRA] = true }
	,[f.."promenadelead"] = { [aRA] = true }
	,[f.."littleegg"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 19.95 } } }
	,[f.."lyrical"] = { ["time*"] = 2 ,[aRA] = true ,[tTC] = { {["_time"] = "Dtime"} ,1,0} }
	,[f.."tonal"] = { [aRA] = true ,["time*"] = 2 ,[tTC] = { {["_time"] = "Dtime"} ,1,0} }
	,[f.."sunlit"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 30.58 } } }
	,[f.."rememberme"] = { [aRA] = true ,["rres"] = { ["time"] = 8.4 ,[cY] = 0.14864864945412} }
	,[f.."aloha"] = { [nS] = 9 ,[aRA] = true ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 42.5 } } }
	,[f.."jiggle"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 9.567 ,[cY] = 0.077170416712761 } ,[C_s] = { [T2] = 9.567 } } }
	,[f.."realm"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.9 ,[mD] = 5 ,[MS] = 70 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [T2] = 3.36667 ,[cY] = 0.25735294818878 } ,[C_s] = { [T1] = 37.6 } } }
	,[f.."realm_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.7 ,[mD] = 1 ,[MS] = 4 ,["MoveX"] = {7,0.07,10} } ,["C_"] = { [C_a] = { [T2] = 3.36667 ,[cY] = 0.25735294818878 } ,[C_s] = { [T1] = 37.6 } } }
	,[f.."jumpingjoy_static"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 53 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { ["r"] = 0 } } }
	,[f.."jumpingjoy_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 53 } ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { ["r"] = 0 } } }
	// v9.5
	,[f.."twistwasp"] = { [aRA] = true }
	,[f.."sunburstdance"] = { [aRA] = true }
	,[f.."cyclone"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 5.8 } } }
	,[f.."cyclone_headbang"] = { [aRA] = true }
	,[f.."hotpink"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 17.20 } } }
	,[f.."griddle"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 100 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 24.4 } } }
	,[f.."griddle_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 100 } ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 24.4 } } }
	,[f.."walkywalk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 67 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 28.8 } } }
	,[f.."walkywalk_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 67 } ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 28.8 } } }
	,[f.."cerealbox"] = { [nS] = 9 ,["C_"] = {
		[C_a] = { [T2] = 6.367 ,[cY] = 0.19409282505512 }
		,[C_s] = { [T1] = 58.8 ,[T2] = 57.4 }
		}
	}
	,[f.."julybooks"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 27.33 } } }
	// v9.6
	,[f.."gasstation"] = { [aRA] = true }
	,[f.."stringdance"] = { [aRA] = true }
	,[f.."zebrascramble"] = { [nS] = 4 }
	,[f.."heavyroardance"] = { [aRA] = true ,["rres"] = { ["time"] = 9.167 ,[cY] = 0.077181205153465} }
	,[f.."grooving"] = { [nS] = 4 ,["time"] = 24.0 ,["AddC1"] = { [nS] = 4 ,["time"] = 32.0 } }
	,[f.."grooving2"] = { [nS] = 4 ,["RNAnim"] = f.."grooving" ,[rAA] = true ,["time"] = 32.0 }
	,[f.."chew"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 14.43 ,[cY] = 0.19963032007217 } ,[C_s] = { [T2] = 14.43 } } }
	,[f.."devotion"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 11.1 ,[cY] = 0.043103449046612 } ,[C_s] = { [T2] = 11.1 } } }
	,[f.."comrade"] = { [aRA] = true ,["time*"] = 4 ,[tTC] = { {["_time"] = "Dtime"} ,3,0} }
	,[f.."indigoapple"] = { ["time*"] = 4 ,[aRA] = true ,[tTC] = { {["_time"] = "Dtime"} ,3,0} }
	// v9.7
	,[f.."abstractmirror"] = { ["THearP"] = true }
	,[f.."agentsherbert"] = {}
	,[f.."snowfall"] = { ["THearP"] = true }
	,[f.."troops"] = {}
	,[f.."patpat_j1"] = { ["THearP"] = true }
	,[f.."patpat_j2"] = { ["THearP"] = true }
	,[f.."coping"] = { [aRA] = true }
	,[f.."sashimi"] = { [aRA] = true }
	,[f.."cottontail"] = { [aRA] = true }
	,[f.."marionette1"] = { [nS] = 4 ,["time"] = 22.4 }
	,[f.."sitandspin"] = { [nS] = 9 ,["Rate"] = 0.98753086033939 ,["C_"] = { [C_a] = { [T1] = 7.99975 ,[cY] = 0 } ,[C_s] = { [T1] = 31.999+0.3 ,[T2] = 31.999 } } }
	,[f.."snowknight"] = { [nS] = 9 ,["C_"] = { [C_s] = { [T1] = 30.20 } } }
	,[f.."papayacommsclap"] = { [nS] = 4 ,["time"] = 8.4 ,["THearP"] = true }
	,[f.."gwaradance"] = { [nS] = 9 ,["C_"] = { [C_s] = { [T1] = 30.4 } } }
	,[f.."undead"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 5.9 ,[cY] = 0.19909502565861 } ,[C_s] = { [T2] = 5.9 } } }
	,[f.."pastasauce"] = { [aRA] = true ,["rres"] = { ["time"] = 7.8 ,[cY] = 0.22516556084156} }
	,[f.."goodbyeupbeat"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 60 ,["AalowAnim"] = true } ,["C_"] = { [C_s] = { [T1] = 27.6 } } }
	,[f.."goodbyeupbeat_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 60 } ,["C_"] = { [C_s] = { [T1] = 27.6 } } }
	,[f.."hoist"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 9.567 ,[cY] = 0.071197412908077 } ,[C_s] = { [T1] = 19.85 ,[T2] = 19.1 } } }
	,[f.."noodles"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 6.96667 ,[cY] = 0.33012819290161 } ,[C_s] = { [T1] = 13.95+3.3666666666667 ,[T2] = 13.95 } } }
	,[f.."headset"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.55 ,[mD] = 5 ,[MS] = 42 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [T2] = 19.7 ,[cY] = 0.046698871999979 } ,[C_s] = { [T1] = 37.56 } } }
	,[f.."headset_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.5 ,[mD] = 1 ,[MS] = 0 ,["MoveX"] = {7,0.07,6} } ,["C_"] = { [C_a] = { [T2] = 19.7 ,[cY] = 0.046698871999979 } ,[C_s] = { [T1] = 37.56 } } }
	,[f.."shimmy"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 12.3 ,[cY] = 0.02638522349298 } ,[C_s] = { [T2] = 12.3 } } }
	,[f.."dreadful"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 9.4 ,[cY] = 0.01742160320282 } ,[C_s] = { [T2] = 9.4 } } }
	,[f.."adoration"] = { [aRA] = true ,["rres"] = { ["time"] = 26.64 ,[cY] = 0.024420024827123} }
	,[f.."jumpstyledance"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 47.73 } } }
	,[f.."speeddial"] = { [nS] = 9 ,["C_"] = { [C_s] = { [T1] = 9.73 } } }
	,[f.."tourbus"] = { [nS] = 4 }
	,[f.."idle"] = { [nS] = 0 }
	,[f.."sandwichbop"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 48 ,["AalowAnim"] = true } ,["C_"] = { [C_s] = { [T1] = 7.567 } } }
	,[f.."sandwichbop_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 48 } ,["C_"] = { [C_s] = { [T1] = 7.567 } } }
	,[f.."poutyclap"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 5.833 ,[cY] = 0.25213676691055 } ,[C_s] = { [T2] = 5.833 } } ,["THearP"] = true }
	,[f.."januarybop"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.6 ,[cY] = 0.25245901942253 } ,[C_s] = { [T1] = 7.6 } } }
	,[f.."voidredemption"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.333 ,[cY] = 0.047619048506021 } ,[C_s] = { [T1] = 29.3+0.366 ,[T2] = 29.3 } } }
	,[f.."vivid"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 37 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [C_s] = 0 } ,[C_s] = { [T1] = 15.1 } } }
	,[f.."vivid_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 37 } ,["C_"] = { [C_a] = { [C_s] = 0 } ,[C_s] = { [T1] = 15.1 } } }
	,[f.."twohype"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 33 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [T2] = 6.4 ,[cY] = 0.090047396719456 } ,[C_s] = { [T1] = 6.4 } } }
	,[f.."twohype_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 0 ,["MoveX"] = {7,0.07,4.714285714285714} } ,["C_"] = { [C_a] = { [T2] = 6.4 ,[cY] = 0.090047396719456 } ,[C_s] = { [T1] = 6.4 } } }
	,[f.."handsup"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 59.1 } } }
	,[f.."lilsplit"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 25.5 } } }
	,[f.."malleable"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 50 ,["AalowAnim"] = true } ,["C_"] = { [C_s] = { [T1] = 18.6 } } }
	,[f.."malleable_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 50 } ,["C_"] = { [C_s] = { [T1] = 18.6 } } }
	,[f.."gothdance"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 65.8 } } }
	,[f.."breakfastcoffeedance"] = { [nS] = 4 ,["time"] = 57.2 }
	,[f.."chairtime"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 12.3 ,[cY] = 0.24229979515076} ,[C_s] = { [T2] = 12.3 } } ,["THearP"] = true }
	,[f.."bluephoto"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 9.3 ,[cY] = 0.1913043409586} ,[C_s] = { [T1] = 20.7 ,[T2] = 18.6 } } }
	,[f.."ruckus"] = { [aRA] = true ,["time*"] = 2 ,[tTC] = { {["_time"] = "Dtime"} ,1,0} }
	,[f.."ringer"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 48 ,["AalowAnim"] = true } ,["C_"] = { [C_s] = { [T1] = 13.1 } } }
	,[f.."ringer_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 48 } ,["C_"] = { [C_s] = { [T1] = 13.1 } } }
	,[f.."patpat_intro"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 1.833 ,[cY] = 0.53913044929504} } ,["THearP"] = true }
	,[f.."alien"] = { ["time*"] = 2 ,[aRA] = true ,[tTC] = { {["_time"] = "Dtime"} ,1,0} }
	,[f.."chilled"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 26.47 } } }
	,[f.."iconic"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.4 ,[cY] = 0.10843373835087} ,[C_s] = { [T2] = 7.4 } } }
	,[f.."chickenleg"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 12.033 ,[cY] = 0.039893615990877} ,[C_s] = { [T2] = 12.033 } } }
	,[f.."selenecobra"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 15 ,[cY] = 0.070247933268547} ,[C_s] = { [T2] = 15 } } }
	,[f.."reign"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 19.133 ,[cY] = 0.038525961339474} ,[C_s] = { [T2] = 19.133 } } }
	,[f.."whisk"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 10.6 } } }
	,[f.."metronome"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 6.967 ,[cY] = 0.08333333581686} ,[C_s] = { [T1] = 28.45 ,[T2] = 27.868 } } } --14.334
	,[f.."justhome"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 25.80 } } } --14.334
	,[f.."darling"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 8.467 ,[cY] = 0.072992697358131} ,[C_s] = { [T1] = 17.601 ,[T2] = 16.934 } } }
	,[f.."triumphant"] = { ["time*"] = 2 ,[aRA] = true ,[tTC] = { {["_time"] = "Dtime"} ,1,0} }
	,[f.."boomer"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 15.53 } } }
	,[f.."clamor"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 29.067 ,[cY] = 0.056277055293322 } ,[C_s] = { [T2] = 29.067 } } }
	,[f.."hurrah"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 9.6 ,[cY] = 0.088607594370842 } ,[C_s] = { [T2] = 9.6 } } }
	,[f.."tollbridge"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 6.733 ,[cY] = 0.064814813435078 } ,[C_s] = { [T1] = 20.65,[T2] = 20.15 } } }
	,[f.."bewilder"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.367 ,[cY] = 0.059574469923973 } ,[C_s] = { [T2] = 7.367 } } }
	,[f.."wheresmatt"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 70 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 31.5 } } }
	,[f.."wheresmatt_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 60 } ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 31.5 } } }
	,[f.."reverie"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 8.167 ,[cY] = 0.061302680522203 } ,[C_s] = { [T1] = 16.867,[T2] = 16.334 } } }
	,[f.."reverie_mirror"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 8.167 ,[cY] = 0.061302680522203 } ,[C_s] = { [T1] = 16.867,[T2] = 16.334 } } }
	,[f.."montecarlo"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 39.666 } } }
	,[f.."shiverflame"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 6.567 ,[cY] = 0.079439252614975 } ,[C_s] = { [T1] = 26.835,[T2] = 26.268 } } }
	,[f.."canine"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 3.6 ,[cY] = 0.52838426828384 } ,[C_s] = { [T1] = 11.22,[T2] = 7.173 } } }
	,[f.."dignified"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 16.333 ,[cY] = 0.027777777984738 } ,[C_s] = { [T2] = 16.333 } } }
	,[f.."cadaver"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 8.433 ,[cY] = 0.038022812455893 } ,[C_s] = { [T1] = (8.433*2)+0.333 ,[T2] = (8.433*2) } } }
	,[f.."intermission"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 13.667 ,[cY] = 0.10087719559669 } ,[C_s] = { [T1] = 1.33+42.9 ,[T2] = 42.99 } } }
	,[f.."harmony_1"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.967 ,[cY] = 0.14642857015133 } ,[C_s] = { [T1] = 1.367+15.93334 ,[T2] = 15.93334 } } }
	,[f.."harmony_2"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.967 ,[cY] = 0.14642857015133 } ,[C_s] = { [T1] = 1.367+15.93334 ,[T2] = 15.93334 } } }
	,[f.."harmony_3"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.967 ,[cY] = 0.14642857015133 } ,[C_s] = { [T1] = 1.367+15.93334 ,[T2] = 15.93334 } } }
	,[f.."rumblefemale"] = { [nS] = 9 ,["C_"] = { [C_a] = { ["loop"] = true } ,[C_s] = { [T1] = 20.82 ,[T2] = 20.72 } } }
	,[f.."plasticfork"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 85 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [T2] = 9 ,[cY] = 0.34782609343529 } ,[C_s] = { [T1] = 13.42+4.8 ,[T2] = 13.42 } } }
	,[f.."plasticfork_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 0 ,["MoveX"] = {7,0.02,12.14285714285714} } ,["C_"] = { [C_a] = { [T2] = 9 ,[cY] = 0.34782609343529 } ,[C_s] = { [T1] = 13.42+4.8 ,[T2] = 13.42 } } }
	,[f.."thrive"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 8.633 ,[cY] = 0.35411471128464 } ,[C_s] = { [T2] = 8.633 } } ,["THearP"] = true }
	,[f.."farewell"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 11.1 ,[cY] = 0.059322033077478 } ,[C_s] = { [T1] = 22.2+0.7 ,[T2] = 22.2 } } }  --11.1
	,[f.."downward"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 22.9334 } } }
	,[f.."elegantlilycharm"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 8.33333 ,[cY] = 0.070631973445415 } ,[C_s] = { [T1] = (8.33333*2)+0.56 ,[T2] = 8.33333*2 } } }
	,[f.."elegantlily"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 9.06667 ,[cY] = 0.077966101467609 } ,[C_s] = { [T2] = 9.06667 } } }
	,[f.."nimble"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 9.1667*4 } } }
	,[f.."vacant"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 4.23333 ,[cY] = 0.53818184137344 } ,[C_s] = { [T1] = (4.23333*2)+4.93333 ,[T2] = (4.23333*2) } } }
	,[f.."blazerveil"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.46667 ,[cY] = 0.40106952190399 } ,[C_s] = { [T1] = (7.46667*4)+5 ,[T2] = (7.46667*4) } } }
	,[f.."sillyjumps"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 90 ,["AalowAnim"] = true } ,["C_"] = { [C_s] = { [T1] = 40 } } }
	,[f.."sillyjumps_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 0 ,["MoveX"] = {7,0.02,12.85714285714286} } ,["C_"] = { [C_s] = { [T1] = 40 } } }
	,[f.."dimension"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 8.86667 ,[cY] = 0.039711192250252 } ,[C_s] = { [T1] = (8.86667*2)+0.3667 ,[T2] = (8.86667*2) } } }
	,[f.."playereleven"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = (7.63333*3) } } }
	,[f.."coyotetrail_lead"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 25.7 } } }
	,[f.."coyotetrail_follow"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 25.7 } } }
	,[f.."enrapture"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 11.73333 ,[cY] = 0.115577891469 } ,[C_s] = { [T2] = (11.73333*2) } } }
	,[f.."kelplinen"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 11.46667 ,[cY] = 0.11794871836901 } ,[C_s] = { [T1] = (11.46667*2)+1.53333 ,[T2] = (11.46667*2) } } }
	,[f.."mesmerize"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.06667 ,[cY] = 0.082251079380512 } ,[C_s] = { [T1] = (7.06667*2)+0.63333 ,[T2] = (7.06667*2) } } }
	,[f.."jadetowel"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 7.53333 ,[cY] = 0.0887096747756 } ,[C_s] = { [T1] = (7.53333*2)+0.73333 ,[T2] = (7.53333*2) } } }
	,[f.."jadetowel_gloss"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 10 ,[cY] = 0.035369776189327 } ,[C_s] = { [T2] = 10 } } }
	,[f.."crisscross"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 4.74*8 +0.17 } } }
	,[f.."resonant"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 5 ,[MS] = 55.2 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 7.467*2 } } }
	,[f.."resonant_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 55.2 } ,["C_"] = { [C_a] = { [cY] = 0} ,[C_s] = { [T1] = 7.467*2 } } }
	,[f.."lemoncart_static"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.55 ,[mD] = 5 ,[MS] = 11 ,["AalowAnim"] = true } ,["C_"] = { [C_a] = { [T2] = 10.43333 ,[cY] = 0.060060061514378 } ,[C_s] = { [T2] = 10.43333 } } }
	,[f.."lemoncart_walk"] = { [nS] = 9 ,[tCA] = { ["T"] = 0.5 ,[mD] = 1 ,[MS] = 0 ,["MoveX"] = {1,0.05,11} } ,["C_"] = { [C_a] = { [T2] = 10.43333 ,[cY] = 0.060060061514378 } ,[C_s] = { [T2] = 10.43333 } } }
	,[f.."studs"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 12.86667 ,[cY] = 0.037406485527754 } ,[C_s] = { [T1] = (12.86667)*2+0.5 ,[T2] = (12.86667)*2 } } }
	,[f.."myeffort"] = { [nS] = 9 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = (8.4)*2 } } }

	// PUBG \\
	// v9.6
	,[p.."2phuthon"] = { [aRA] = true }
	,[p.."bboombboom"] = {}
	,[p.."seetinh"] = { [aRA] = true }
	,[p.."victorydance60"] = { [aRA] = true }
	,[p.."samsara"] = { [aRA] = true ,["rres"] = { ["time"] = 39.667 ,[cY] = 0.099848717451096} }
	,[p.."victorydance102"] = { [aRA] = true ,["rres"] = { ["time"] = 29.9 ,[cY] = 0.014285714365542} }
	,[p.."victorydance99"] = { [aRA] = true ,["rres"] = { ["time"] = 14.9 ,[cY] = 0.11660078912973} }
	,[p.."tocatoca"] = { [aRA] = true ,["rres"] = { ["time"] = 15.233 ,[cY] = 0.52983540296555} }
	// v9.7
	,[p.."rollnrock"] = { [aRA] = true ,["rres"] = { [cY] = 0 } }
	,[p.."poppy"] = { [aRA] = true ,["rres"] = { ["time"] = 30.467 ,[cY] = 0.066394276916981} }
	,[p.."victorydance118"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 14.86667 ,[cY] = 0.20921985805035 } ,[C_s] = { [T1] = 14.848+8.03 ,[T2] = 14.8495 } } }
	
	// Mixamo \\
	// old   v9.3
	,[o.."catwalk_walk"] = { [aRA] = true }
	,[o.."entry"] = { [aRA] = true }
	,[o.."gesture_1"] = {}
	,[o.."gesture_2"] = {}
	,[o.."gesture_3"] = {}
	,[o.."gesture_4"] = {}
	,[o.."gesture_5"] = {}
	,[o.."gesture_6"] = {}
	,[o.."gesture_7"] = {}
	,[o.."gesture_8"] = {}
	,[o.."gesture_9"] = {}
	,[o.."gesture_10"] = {}
	,[o.."gesture_11"] = {}
	,[o.."gesture_12"] = {}
	,[o.."gesture_13"] = {}
	,[o.."gesture_14"] = {}
	,[o.."gesture_15"] = {}
	,[o.."hip_hop_dancing"] = { [aRA] = true }
	,[o.."hip_hop_dancing2"] = { [aRA] = true }
	,[o.."hip_hop_dancing2"] = { [aRA] = true }
	,[o.."idle_1"] = { [aRA] = true }
	,[o.."idle_2"] = { [aRA] = true }
	,[o.."idle_3"] = { [aRA] = true }
	,[o.."idle_4"] = { [aRA] = true }
	,[o.."idle_5"] = { [aRA] = true }
	,[o.."idle_6"] = { [aRA] = true }
	,[o.."idle_with_something"] = { [aRA] = true }
	,[o.."jump"] = {}
	,[o.."kick_2"] = {}
	,[o.."kick_3"] = {}
	,[o.."kick_4"] = {}
	,[o.."kick_5"] = {}
	,[o.."on_knees"] = { [aRA] = true }
	,[o.."sit_typing"] = { [aRA] = true }
	,[o.."sit_writing"] = { [aRA] = true }
	,[o.."talking_on_a_cell_phone"] = {}
	,[o.."talking_on_phone"] = {}
	,[o.."taunt_1"] = { [aRA] = true }
	,[o.."taunt_2"] = { [aRA] = true }
	,[o.."taunt_3"] = { [aRA] = true }
	,[o.."taunt_4"] = { [aRA] = true }
	,[o.."taunt_5"] = { [aRA] = true }
	,[o.."taunt_6"] = { [aRA] = true }
	,[o.."taunt_7"] = { [aRA] = true ,[mD] = 5 ,[MS] = -44 ,["AalowAnim"] = true }
	,[o.."taunt_8"] = { [aRA] = true }
	,[o.."taunt_9"] = { [aRA] = true }
	,[o.."taunt_10"] = {}
	,[o.."taunt_11"] = {}
	,[o.."taunt_12"] = { [aRA] = true }
	,[o.."warming_up"] = { [aRA] = true }
	,[o.."dead_1"] = { [nS] = 0 ,["CycleAni"] = 0 ,[tCA] = { ["T"] = "Dtime" ,["time-"] = 0.3 ,["RNAnim"] = o.."dead_1_idle" } }
	,[o.."dead_2"] = { [nS] = 0 ,["CycleAni"] = 0 ,[tCA] = { ["T"] = "Dtime" ,["time-"] = 0.3 ,["RNAnim"] = o.."dead_2_idle" } }
	,[o.."dead_3"] = { [nS] = 0 ,["CycleAni"] = 0 ,[tCA] = { ["T"] = "Dtime" ,["time-"] = 0.3 ,["RNAnim"] = o.."dead_3_idle" } }
	,[o.."dead_4"] = { [nS] = 0 ,["CycleAni"] = 0 ,[tCA] = { ["T"] = "Dtime" ,["time-"] = 0.3 ,["RNAnim"] = o.."dead_4_idle" } }
	,[o.."sit"] = { [nS] = 4 ,["RNAnim"] = o.."sit_to_stand_reversed" ,["CycleAni"] = 0 ,[tCA] = { ["T"] = 2.6 ,[mD] = 7 ,["RNAnim"] = o.."sit" }
		,["CCAni"] = {
			["CK1"] = {
				[1] = {["GetDir"] = o.."sit",["SetDir"] = {o.."sit_to_stand",true,1,{["Dir"] = o.."idle_3"}} ,["TimeHold"] = 3,[cY] = 0}
				,[2] = {["GetDir"] = o.."idle_3",["SetDir"] = {o.."sit_to_stand_reversed",true,1,{["Dir"] = o.."sit"}} ,["TimeHold"] = 3,[cY] = 0}
			}
		}
	}
	,[o.."walk_0_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 60 } }
	,[o.."walk_1_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 45 } }
	,[o.."walk_2_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 43 } }
	,[o.."walk_3_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 50 } }
	,[o.."run_1_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 250 } }
	,[o.."run_2_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 200 } }
	,[o.."run_3_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 210 } }
	,[o.."kick_1"] = { [tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 155 } ,["tC_TReA2"] = { ["T"] = 0.8 ,[mD] = 0 ,[MS] = 0 } }
	// v9.5
	,[o.."walk_4_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 50 } }
	,[o.."walk_5_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 12 } }
	,[o.."walk_6_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 55 } }
	,[o.."walk_7_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 65 } }
	,[o.."walk_8_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 38 } }
	,[o.."walk_9_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 63 } }
	,[o.."walk_10_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 75 } }
	,[o.."walk_11_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 35.5 } }
	,[o.."walk_12_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 50 } }
	,[o.."walk_13_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 17 } }
	,[o.."walk_14_back"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 2 ,[MS] = 22 } }
	,[o.."walk_15_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 20 } }
	,[o.."walk_16_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 57 } }
	,[o.."walk_17_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 50 } }
	,[o.."walk_18_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 40 } }
	,[o.."walk_19_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 25 } }
	,[o.."walk_20_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 55 } }
	,[o.."walk_21_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 25 } }
	,[o.."run_4_forward"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 94 } }
	// v9.7
	,[o.."sambadancing"] = { [nS] = 4 ,["time"] = 16.0 }
	,[o.."situps_01"] = { [nS] = 0 ,["RNAnim"] = o.."idle_2" ,["CycleAni"] = 0 ,["tC_TReA2"] = { ["T"] = 0.1 ,["RNAnim"] = o.."situps_s_01",["ResetMainAni"] = true} ,[tCA] = { ["T"] = 3.8 ,[mD] = 7 ,["RNAnim"] = o.."situps_l_01" }
		,["CCAni"] = {
			["CK1"] = {
				[1] = {["GetDir"] = o.."situps_l_01" ,["SetDir"] = {o.."situps_e_01",true,0.9} ,["TimeHold"] = 10 ,[cY] = 0}
			}
		}
	}
	,[o.."dancing_01"] = { [nS] = 0 }
	,[o.."dancing_02"] = { [nS] = 0 }
	,[o.."swingdancing_01"] = { [nS] = 0 }
	,[o.."swingdancing_02"] = { [nS] = 0 }
	,[o.."swingdancing_03"] = { [nS] = 0 }
	,[o.."pose_maledance_01"] = { [nS] = 0 }
	,[o.."pose_femaledance_01"] = { [nS] = 0 }
	,[o.."hokeypokey"] = {}
	,[o.."norsoulspcombo"] = {}
	
	// MMD \\
	// old
	,[m.."calisthenics"] = { [cL] = 0.1 }
	,[m.."getdown"] = { ["Rate"] = 0.5 ,[tCA] = { ["T"] = 0.5 ,["Rate"] = 1 } }
	,[m.."pv120_shi_p1"] = { [cP] = true ,[cL] = 0.42 }
	,[m.."pv120_shi_p2"] = { [cP] = true ,[cL] = 0.42 }
	,[m.."pv120_shi_p3"] = { [cP] = true ,[cL] = 0.42 }
	,[m.."aoagoodluck"] = { ["time+"] = 1.5 ,[cP] = true ,[cL] = 0.6 }
	,[m.."blablabla"] = { [aRA] = true ,[cL] = 0.3 }
	,[m.."chikichiki"] = { [cP] = true ,[cL] = 0.4 }
	,[m.."ghostdance"] = { [aRA] = true ,[cP] = false ,[cL] = 0.7 }
	,[m.."girls"] = { [cP] = true ,[cL] = 0.15 }
	,[m.."hiasobi"] = { [cP] = true ,[cL] = 0.47 }
	,[m.."hiproll"] = { [nS] = 9 ,["time"] = 9.6 ,[cL] = 0.4 ,[tCA] = { ["T"] = 9.5 ,["RNAnim"] = m.."hiproll_loop" } ,["C_"] = { [C_a] = { [T2] = 5.567 ,[cY] = 0 } ,[C_s] = { [T2] = 6.4 } } }
	,[m.."mrsaxobeat"] = { [cP] = true ,[cL] = 0.45 }
	,[m.."nyaarigato"] = { [aRA] = true ,[cL] = 0.7 }
	,[m.."dance_tuni-kun"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."fiery_sarilang"] = { [cP] = true ,[cL] = 0.6 ,["ResetAni"] = true }
	,[m.."followtheleader"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."ponponpon"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."goodbyedeclaration"] = { [cP] = true ,[cL] = 0.5 ,["Rate"] = 0.5 ,[tCA] = { ["T"] = 0.5 ,["Rate"] = 1 } }
	,[m.."phao2phuthon_p1"] = { [nS] = 9 ,[cL] = 0.6 ,[mD] = 7 ,["C_"] = { [C_s] = { [T1] = 93.72 } }
		,["CCAni"] = {
			["CK1"] = {
				[1] = {["GetDir"] = m.."phao2phuthon_p1",["SetDir"] = m.."phao2phuthon_p2" ,["TimeHold"] = 0.3}
				,[2] = {["GetDir"] = m.."phao2phuthon_p2",["SetDir"] = m.."phao2phuthon_p3" ,["TimeHold"] = 0.3}
				,[3] = {["GetDir"] = m.."phao2phuthon_p3",["SetDir"] = m.."phao2phuthon_p4" ,["TimeHold"] = 0.3}
				,[4] = {["GetDir"] = m.."phao2phuthon_p4",["SetDir"] = m.."phao2phuthon_p5" ,["TimeHold"] = 0.3}
				,[5] = {["GetDir"] = m.."phao2phuthon_p5",["SetDir"] = m.."phao2phuthon_p1" ,["TimeHold"] = 0.3}
			}
			,["CK2"] = {
				[1] = {["GetDir"] = m.."phao2phuthon_p1",["SetDir"] = m.."phao2phuthon_p5" ,["TimeHold"] = 0.3}
				,[2] = {["GetDir"] = m.."phao2phuthon_p2",["SetDir"] = m.."phao2phuthon_p1" ,["TimeHold"] = 0.3}
				,[3] = {["GetDir"] = m.."phao2phuthon_p3",["SetDir"] = m.."phao2phuthon_p2" ,["TimeHold"] = 0.3}
				,[4] = {["GetDir"] = m.."phao2phuthon_p4",["SetDir"] = m.."phao2phuthon_p3" ,["TimeHold"] = 0.3}
				,[5] = {["GetDir"] = m.."phao2phuthon_p5",["SetDir"] = m.."phao2phuthon_p4" ,["TimeHold"] = 0.3}
			}
		}
	}
	,[m.."s001"] = { [cP] = true ,[cL] = 0.52 }
	,[m.."s002"] = { [cP] = true ,[cL] = 0.52 }
	,[m.."s003"] = { [cP] = true ,[cL] = 0.52 }
	,[m.."s004"] = { [cP] = true ,[cL] = 0.52 }
	,[m.."s005"] = { [cP] = true ,[cL] = 0.15 }
	,[m.."s006"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."s007"] = { [cP] = true ,[cL] = 0.34 }
	,[m.."s008"] = { [cP] = true ,[cL] = 0.1 }
	,[m.."s009"] = { [cP] = true ,[cL] = 0.5 }
	,[m.."s010"] = { [cP] = true ,[cL] = 0.9 }
	,[m.."s011"] = { [cP] = true ,[cL] = 0.8 }
	,[m.."s012"] = { [cP] = true ,[cL] = 0.6 }
	,[m.."s013"] = { [cP] = true ,[cL] = 0.55 }
	,[m.."s014"] = { [cP] = true ,[cL] = 0.6 }
	,[m.."s015"] = { [cP] = true ,[cL] = 0.12 }
	,[m.."s017"] = { [cP] = true ,[cL] = 0.4 }
	,[m.."helltaker"] = { [nS] = 4 ,["time"] = 226.3 ,[cL] = 0.28 }
	,[m.."dance_gokurakujodo"] = { [cP] = true ,[cL] = 0.6 ,["Rate"] = 0.9 ,["AddC1"] = { ["time"] = 165 } ,[tCA] = { ["T"] = 0.4 ,["Rate"] = 1 } }
	,[m.."dance_nostalogic"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."dance_specialist"] = { [cP] = true ,[cL] = 0.6 }
	,[m.."dance_caramelldansen"] = { [cP] = true ,[cL] = 0.6 }
	,[m.."dance_daisukeevolution"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."whistle"] = { [aRA] = true ,[cL] = 0.3 }
	,[m.."theatrical_airline_luk"] = { [cP] = true ,[cL] = 0.6 }
	,[m.."theatrical_airline_mik"] = { [cP] = true ,[cL] = 0.6 }
	,[m.."theatrical_airline_rin"] = { [cP] = true ,[cL] = 0.6 }
	,[m.."badbadwater"] = { [cP] = true ,[cL] = 0.35 }
	,[m.."king_kanaria"] = { [cP] = true ,[cL] = 0.4 }
	,[m.."caixukun"] = { [cP] = true ,[cL] = 0.5 }
	,[m.."sadcatdance"] = { [nS] = 9 ,[cL] = 0.4 ,[tCA] = { ["T"] = "Dtime" ,["time-"] = 0.4 ,["Rate"] = 0.935 ,["RNAnim"] = m.."sadcatdance_loop" } ,["C_"] = { [C_a] = { [T2] = 13.0 ,[cY] = 0 } ,[C_s] = { [T2] = 13.0 } } }
	,[m.."bad_apple_l"] = { ["time+"] = 1 ,[cP] = true ,[cL] = 0.158 }
	,[m.."bad_apple_r"] = { ["time+"] = 1 ,[cP] = true ,[cL] = 0.158 }
	,[m.."gfriendrough"] = { [cP] = true ,[cL] = 0.3 }
	,[m.."massdestruction"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."mememe"] = { [cL] = 0.6 }
	,[m.."roki_p1"] = { [cP] = true ,[cL] = 0.1 }
	,[m.."roki_p2"] = { [cP] = true ,[cL] = 0.1 }
	,[m.."senbonzakura"] = { [cP] = true ,[cL] = 0.1 }
	,[m.."supermjopping"] = { [cP] = true ,[cL] = 0.17 }
	,[m.."nahoha"] = { [cP] = true ,[cL] = 0.02 }
	,[m.."ch4nge"] = { [cP] = true ,[cL] = 0.45 }
	,[m.."conqueror"] = { [cP] = true ,[cL] = 0.25 }
	,[m.."yoidore"] = { [cP] = true ,[cL] = 0.8 }
	,[m.."dokuhebi"] = { [cP] = true ,[cL] = 0.57 }
	,[m.."darling"] = { [cP] = true ,[cL] = 0.3 }
	,[m.."dancin"] = { [cP] = true ,[cL] = 0.05 }
	,[m.."adeepmentality"] = { [cP] = true ,[cL] = 0.7 }
	,[m.."gimmexgimme"] = { [cP] = true ,[cL] = 1.1 }
	,[m.."yaosobi-idol"] = { [cP] = true ,[cL] = 0.5 }
	,[m.."kwlink"] = { [cP] = true ,[cL] = 0.12 }
	,[m.."lmfao"] = { [aRA] = true ,["rres"] = { ["time"] = 29.85 ,[cY] = 0.060732983052731} }
	,[m.."adj_1"] = { [nS] = 4 ,[cL] = 0.7 ,["time-"] = 0.03 }
	,[m.."adj_2"] = { [nS] = 4 ,[cL] = 0.7 ,["time-"] = 0.03 }
	,[m.."kemuthree"] = { [cL] = 0.7 }
	,[m.."aloveit"] = { [aRA] = true ,["rres"] = { ["time"] = 13.9 ,[cY] = 0.10217390954494} }
	,[m.."imfgood"] = { [cP] = true ,[cL] = 0.42 }
	,[m.."drunkendutterfly"] = { [cP] = true ,[cL] = 0.21 }
	,[m.."ph"] = { [cP] = true ,[cL] = 0.3 }
	// v9.7
	,[m.."bibbib"] = { [cP] = false ,[cL] = 0.72 }
	,[m.."peachbsmile"] = { [cP] = false ,[cL] = 0.6 }
	,[m.."bananasong"] = { [cP] = false ,[cL] = 0.3 }
	,[m.."shiknok"] = { [cP] = false ,[nS] = 9 ,[cL] = 0.4  ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 2.8 ,[T2] = 2.6 } } }
	,[m.."littleapple"] = { [cP] = true ,[cL] = 0.3 }
	,[m.."dancehall_1"] = { [cP] = true ,[cL] = 0.3 }
	,[m.."dancehall_2"] = { [cP] = true ,[cL] = 0.05 }
	,[m.."zhangshiyao"] = { [aRA] = true ,[cL] = 0.5 }
	,[m.."pokedance"] = { [cP] = false ,[cL] = 0.5 ,[nS] = 9 ,[cL] = 0.4  ,["C_"] = { [C_a] = { [T2] = 23.2 ,[cY] = 0.16245487332344 } ,[C_s] = { ["Time1_test"] = "4.5+23.2=27.7" ,[T2] = 23.2 } } }
	,[m.."beyondtheway_1"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."beyondtheway_2"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."beyondtheway_3"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."beyondtheway_4"] = { [cP] = true ,[cL] = 0.2 }
	,[m.."beyondtheway_5"] = { [cP] = true ,[cL] = 0.5 }
	
	// Other \\
	// old
	,["amod_angry_01"] = { [aRA] = true }
	,["amod_dance_gangnamstyle"] = { [aRA] = true }
	,["amod_dance_california_girls"] = { [aRA] = true ,["time-"] = 0.133 ,["rres"] = { ["time"] = 30.667 ,[cY] = 0.1323943734169} }
	,["amod_taunt_quagmire"] = { ["time"] = 5.7 ,["AddC1"] = { [aRA] = true ,["time"] = 9.02 ,["Rate"] = 0.65 ,[tTC] = { 4.6,1,0.11} } }
	,[a.."runpanicked"] = { [nS] = 0 ,[tCA] = { ["T"] = 0.1 ,[mD] = 1 ,[MS] = 210 } }
	,["amod_dance_macarena"] = { [nS] = 9 ,["time"] = 8.73 ,["Rate"] = 0.939 ,[cL] = 0.4 ,["C_"] = { [C_a] = { [cY] = 0 } ,[C_s] = { [T1] = 157.2 } } }
	,[a.."drliveseywalk_1"] = { [nS] = 4 ,["time"] = 15.67 ,[tCA] = { ["T"] = 0.1 ,[mD] = 9 ,[MS] = 85 }
		,["CCAni"] = {
			["CK1"] = {
				[1] = {["GetDir"] = a.."drliveseywalk_1",["SetDir"] = a.."drliveseywalk_2",["TimeHold"] = 0.3}
				,[2] = {["GetDir"] = a.."drliveseywalk_2",["SetDir"] = a.."drliveseywalk_3",["TimeHold"] = 0.3}
				,[3] = {["GetDir"] = a.."drliveseywalk_3",["SetDir"] = a.."drliveseywalk_1",["TimeHold"] = 0.3}
			}
		}
	}
	,[a.."drliveseywalk_2"] = { [nS] = 4 ,["time"] = 31.99 ,[tCA] = { ["T"] = 0.1 ,[mD] = 9 ,[MS] = 85 }
		,["CCAni"] = {
			["CK1"] = {
				[1] = {["GetDir"] = a.."drliveseywalk_2",["SetDir"] = a.."drliveseywalk_3",["TimeHold"] = 0.3}
				,[2] = {["GetDir"] = a.."drliveseywalk_3",["SetDir"] = a.."drliveseywalk_1",["TimeHold"] = 0.3}
				,[3] = {["GetDir"] = a.."drliveseywalk_1",["SetDir"] = a.."drliveseywalk_2",["TimeHold"] = 0.3}
			}
		}
	}
	,[a.."drliveseywalk_3"] = { [nS] = 4 ,["time"] = 63.9 ,[tCA] = { ["T"] = 0.1 ,[mD] = 9 ,[MS] = 85 }
		,["CCAni"] = {
			["CK1"] = {
				[1] = {["GetDir"] = a.."drliveseywalk_3",["SetDir"] = a.."drliveseywalk_1",["TimeHold"] = 0.3}
				,[2] = {["GetDir"] = a.."drliveseywalk_1",["SetDir"] = a.."drliveseywalk_2",["TimeHold"] = 0.3}
				,[3] = {["GetDir"] = a.."drliveseywalk_2",["SetDir"] = a.."drliveseywalk_3",["TimeHold"] = 0.3}
			}
		}
	}
	,[a.."pitbull_loop"] = { [nS] = 4 ,["time"] = 19.93 }
	,["amod_drip_01"] = { [nS] = 0 }
	,[a.."levepalestina"] = { [cP] = true ,[cL] = 0.5 ,[nS] = 9 ,["C_"] = { [C_a] = { [T2] = 20.4 ,[cY] = 0.31964483857155} ,[C_s] = { [T1] = 104.1 ,[T2] = 42.6 } } }
	,[a.."pitbull_a"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 3.7 ,[cY] = 0.75599128007889} ,[C_s] = { [T1] = 27.94 ,[T2] = 19.93 } } }
	,[a.."poegypt"] = { [aRA] = true }
	,[a.."spooky_month_dance"] = { [nS] = 4 ,["time"] = 22.68 ,["Rate"] = 0.8 }
	,[a.."epicsaxguy"] = { [aRA] = true ,["time"] = 7.36667 ,["RNAnim"] = f.."epicsaxguy" ,["Rate"] = 1 }
	,[a.."dancegangnamstyle"] = { [nS] = 9 ,["C_"] = { [C_a] = { [T2] = 13.96 ,[cY] = 0.088772848248482 } ,[C_s] = { [T1] = 35.36 ,[T2] = 30.71 } } }
	,[a.."sambadancingfull"] = { [nS] = 9 ,["RNAnim"] = o.."sambadancingfull" ,[rAA] = true ,["C_"] = { [C_a] = { [T2] = 15.967 ,[cY] = 0.1338155567646} ,[C_s] = { [T2] = 16.0 } } }
}


A_AM.ActMod.GTabActWlk = {
	[f.."griddle"] = { static = f.."griddle", walk = f.."griddle_walk" }
	,[f.."griddle_walk"] = { static = f.."griddle", walk = f.."griddle_walk" }

	,[f.."realm"] = { static = f.."realm", walk = f.."realm_walk" }
	,[f.."realm_walk"] = { static = f.."realm", walk = f.."realm_walk" }

	,[f.."eerie"] = { static = f.."eerie", walk = f.."eerie_walk" }
	,[f.."eerie_walk"] = { static = f.."eerie", walk = f.."eerie_walk" }

	,[f.."jumpingjoy_static"] = { static = f.."jumpingjoy_static", walk = f.."jumpingjoy_walk" }
	,[f.."jumpingjoy_walk"] = { static = f.."jumpingjoy_static", walk = f.."jumpingjoy_walk" }

	,[f.."walkywalk"] = { static = f.."walkywalk", walk = f.."walkywalk_walk" }
	,[f.."walkywalk_walk"] = { static = f.."walkywalk", walk = f.."walkywalk_walk" }

	,[f.."headset"] = { static = f.."headset", walk = f.."headset_walk" }
	,[f.."headset_walk"] = { static = f.."headset", walk = f.."headset_walk" }

	,[f.."sandwichbop"] = { static = f.."sandwichbop", walk = f.."sandwichbop_walk" }
	,[f.."sandwichbop_walk"] = { static = f.."sandwichbop", walk = f.."sandwichbop_walk" }

	,[f.."vivid"] = { static = f.."vivid", walk = f.."vivid_walk" }
	,[f.."vivid_walk"] = { static = f.."vivid", walk = f.."vivid_walk" }

	,[f.."twohype"] = { static = f.."twohype", walk = f.."twohype_walk" }
	,[f.."twohype_walk"] = { static = f.."twohype", walk = f.."twohype_walk" }

	,[f.."goodbyeupbeat"] = { static = f.."goodbyeupbeat", walk = f.."goodbyeupbeat_walk" }
	,[f.."goodbyeupbeat_walk"] = { static = f.."goodbyeupbeat", walk = f.."goodbyeupbeat_walk" }

	,[f.."ringer"] = { static = f.."ringer", walk = f.."ringer_walk" }
	,[f.."ringer_walk"] = { static = f.."ringer", walk = f.."ringer_walk" }

	,[f.."plasticfork"] = { static = f.."plasticfork", walk = f.."plasticfork_walk" }
	,[f.."plasticfork_walk"] = { static = f.."plasticfork", walk = f.."plasticfork_walk" }

	,[f.."sillyjumps"] = { static = f.."sillyjumps", walk = f.."sillyjumps_walk" }
	,[f.."sillyjumps_walk"] = { static = f.."sillyjumps", walk = f.."sillyjumps_walk" }

	,[f.."wheresmatt"] = { static = f.."wheresmatt", walk = f.."wheresmatt_walk" }
	,[f.."wheresmatt_walk"] = { static = f.."wheresmatt", walk = f.."wheresmatt_walk" }

	,[f.."resonant"] = { static = f.."resonant", walk = f.."resonant_walk" }
	,[f.."resonant_walk"] = { static = f.."resonant", walk = f.."resonant_walk" }

	,[f.."malleable"] = { static = f.."malleable", walk = f.."malleable_walk" }
	,[f.."malleable_walk"] = { static = f.."malleable", walk = f.."malleable_walk" }

	,[f.."lemoncart_static"] = { static = f.."lemoncart_static", walk = f.."lemoncart_walk" }
	,[f.."lemoncart_walk"] = { static = f.."lemoncart_static", walk = f.."lemoncart_walk" }

	,[f.."sneaky"] = { static = f.."sneaky", walk = f.."sneaky_walk" }
	,[f.."sneaky_walk"] = { static = f.."sneaky", walk = f.."sneaky_walk" }

	,[f.."congaline"] = { static = f.."congaline", walk = f.."congaline_walk" }
	,[f.."congaline_walk"] = { static = f.."congaline", walk = f.."congaline_walk" }
	
	,[f.."ridethepony"] = { static = f.."dance_ridethepony_2", walk = f.."dance_ridethepony_3" }
	,[f.."ridethepony_walk"] = { static = f.."dance_ridethepony_2", walk = f.."dance_ridethepony_3" }
}


A_AM.ActMod.GTabActCoop = {
	// Coop \\
	[f.."patpat_intro"] = { ["rPos"] = true,["rAng"] = true,["PAng"] = false,["TryFixPos"] = { ["+Forward"] = true ,["*add"] = 1.2,["add+_m"] = 5,["add+_f"] = 3 ,["ShowFix"] = nil
		,["Ani1"] = f.."patpat_j1" ,["Ani2"] = f.."patpat_j2" ,["Cycl"] = 0.5 ,["Bip1"] = "ValveBiped.Bip01_Pelvis" ,["Bip2"] = "ValveBiped.Bip01_Pelvis"
	} ,[aP1] = f.."patpat_j2" ,[aP2] = f.."patpat_j1" ,["r180"] = true ,["rP1"] = true ,["AlPly"] = 1 ,["NoRepetition"] = true ,["all_stop"] = true ,["so_2"] = true }
	,[f.."patpat_j1"] = { ["rPos"] = true,["rAng"] = true } ,[f.."patpat_j2"] = { ["rPos"] = true,["rAng"] = true }
	,[f.."harmony_1"] = { ["rPos"] = true,["rAng"] = true,["PAng"] = false,["TryFixPos"] = { ["+Forward"] = true ,["*add"] = 1.12 ,["ShowFix"] = nil
		,["Ani1"] = f.."harmony_3" ,["Ani2"] = f.."harmony_2" ,["Cycl"] = 0.14642857015133 ,["Bip1"] = "ValveBiped.Bip01_R_Hand" ,["Bip2"] = "ValveBiped.Bip01_L_Hand"
	} ,[aP1] = f.."harmony_2" ,[aP2] = f.."harmony_3" ,["r180"] = true ,["rP1"] = true ,["AlPly"] = 1 ,["AutoRepetition"] = true ,["all_stop"] = true ,[sO] = true }
	,[f.."harmony_2"] = { ["rPos"] = true,["rAng"] = true } ,[f.."harmony_3"] = { ["rPos"] = true,["rAng"] = true }
	,[f.."promenadelead"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Right"] = -52 ,[aP1] = f.."promenadefollow" ,[aP2] = f.."promenadelead" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[f.."promenadefollow"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Right"] = 52 ,[aP1] = f.."promenadelead" ,[aP2] = f.."promenadefollow" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[f.."bythefire_leader"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Right"] = -52 ,[aP1] = f.."bythefire_follower" ,[aP2] = f.."bythefire_leader" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[f.."bythefire_follower"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Right"] = 52 ,[aP1] = f.."bythefire_leader" ,[aP2] = f.."bythefire_follower" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[f.."twisteternity_teo"] = { [aP1] = f.."twisteternity_ayo" ,[aP2] = f.."twisteternity_teo" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[f.."twisteternity_ayo"] = { [aP1] = f.."twisteternity_teo" ,[aP2] = f.."twisteternity_ayo" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[f.."reverie"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Right"] = 65 ,[aP1] = f.."reverie_mirror" ,[aP2] = f.."reverie" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[f.."reverie_mirror"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Right"] = -65 ,[aP1] = f.."reverie" ,[aP2] = f.."reverie_mirror" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[f.."coyotetrail_lead"] = { ["rPos"] = true,["rAng"] = true ,["TryFixPos"] = { ["+Forward"] = true ,["*add"] = 1.4 ,["ShowFix"] = nil
		,["Ani1"] = f.."coyotetrail_lead" ,["Ani2"] = f.."coyotetrail_follow" ,["Cycl"] = 0.32162162661552 ,["Bip1"] = "ValveBiped.Bip01_L_Foot" ,["Bip2"] = "ValveBiped.Bip01_R_Foot"
	} ,[aP1] = f.."coyotetrail_follow" ,[aP2] = f.."coyotetrail_lead" ,["r180"] = true ,["rP1"] = false ,["AlPly"] = 1 ,[sC] = true,[sO] = true }
	,[f.."coyotetrail_follow"] = { ["rPos"] = true,["rAng"] = true }

	,[m.."beyondtheway_1"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."beyondtheway_2" ,[2] = m.."beyondtheway_3" ,[3] = m.."beyondtheway_4" ,[4] = m.."beyondtheway_5"
	} ,[aP2] = m.."beyondtheway_1" ,[sC] = true ,[sO] = true ,["AlPly"] = 5 }
	,[m.."beyondtheway_2"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."beyondtheway_1" ,[2] = m.."beyondtheway_3" ,[3] = m.."beyondtheway_4" ,[4] = m.."beyondtheway_5"
	} ,[aP2] = m.."beyondtheway_2" ,[sC] = true ,[sO] = true ,["AlPly"] = 5 }
	,[m.."beyondtheway_3"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."beyondtheway_1" ,[2] = m.."beyondtheway_2" ,[3] = m.."beyondtheway_4" ,[4] = m.."beyondtheway_5"
	} ,[aP2] = m.."beyondtheway_3" ,[sC] = true ,[sO] = true ,["AlPly"] = 5 }
	,[m.."beyondtheway_4"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."beyondtheway_1" ,[2] = m.."beyondtheway_2" ,[3] = m.."beyondtheway_3" ,[4] = m.."beyondtheway_5"
	} ,[aP2] = m.."beyondtheway_4" ,[sC] = true ,[sO] = true ,["AlPly"] = 5 }
	,[m.."beyondtheway_5"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."beyondtheway_1" ,[2] = m.."beyondtheway_2" ,[3] = m.."beyondtheway_3" ,[4] = m.."beyondtheway_4"
	} ,[aP2] = m.."beyondtheway_5" ,[sC] = true ,[sO] = true ,["AlPly"] = 5 }
	
	,[m.."dancehall_1"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = m.."dancehall_2" ,[aP2] = m.."dancehall_1" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[m.."dancehall_2"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = m.."dancehall_1" ,[aP2] = m.."dancehall_2" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	
	,[m.."bad_apple_r"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = m.."bad_apple_l" ,[aP2] = m.."bad_apple_r" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[m.."bad_apple_l"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = m.."bad_apple_r" ,[aP2] = m.."bad_apple_l" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	
	,[m.."roki_p1"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = m.."roki_p2" ,[aP2] = m.."roki_p1" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	,[m.."roki_p2"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = m.."roki_p1" ,[aP2] = m.."roki_p2" ,[sC] = true ,[sO] = true ,["AlPly"] = 1 }
	
	,[m.."theatrical_airline_mik"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."theatrical_airline_rin" ,[2] = m.."theatrical_airline_luk"
	} ,[aP2] = m.."theatrical_airline_mik" ,[sC] = true ,[sO] = true ,["AlPly"] = 2 }
	,[m.."theatrical_airline_rin"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."theatrical_airline_mik" ,[2] = m.."theatrical_airline_luk"
	} ,[aP2] = m.."theatrical_airline_rin" ,[sC] = true ,[sO] = true ,["AlPly"] = 2 }
	,[m.."theatrical_airline_luk"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."theatrical_airline_mik" ,[2] = m.."theatrical_airline_rin"
	} ,[aP2] = m.."theatrical_airline_luk" ,[sC] = true ,[sO] = true ,["AlPly"] = 2 }
	
	,[m.."pv120_shi_p1"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."pv120_shi_p2" ,[2] = m.."pv120_shi_p3"
	} ,[aP2] = m.."pv120_shi_p1" ,[sC] = true ,[sO] = true ,["AlPly"] = 2 }
	,[m.."pv120_shi_p2"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."pv120_shi_p1" ,[2] = m.."pv120_shi_p3"
	} ,[aP2] = m.."pv120_shi_p2" ,[sC] = true ,[sO] = true ,["AlPly"] = 2 }
	,[m.."pv120_shi_p3"] = { ["rPos"] = true,["rAng"] = true,["Ang_2To1"] = true ,["Forward"] = 0 ,[aP1] = {
		[1] = m.."pv120_shi_p1" ,[2] = m.."pv120_shi_p2"
	} ,[aP2] = m.."pv120_shi_p3" ,[sC] = true ,[sO] = true ,["AlPly"] = 2 }
	
	,["amod_cumact_fortnite_stridemicedeep"] = { [aP1] = {
		[1] = "amod_cumact_fortnite_stridemicedeep_2" ,[2] = {["Ani"] = "amod_cumact_fortnite_stridemicedeep_3" ,["Sync"] = false} ,[3] = {["Ani"] = "amod_cumact_fortnite_stridemicedeep_4" ,["Sync"] = false}
	} ,[aP2] = "amod_cumact_fortnite_stridemicedeep" ,[Jg] = true ,[sC] = true ,[sO] = true ,["AlPly"] = 4 }
	
	// joining \\
	,[f.."dancemoves"] = { [aP1] = f.."dancemoves" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."dancemoves2"] = { [aP1] = f.."dancemoves2" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."farewell"] = { [aP1] = f.."farewell" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."reign"] = { [aP1] = f.."reign" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."clamor"] = { [aP1] = f.."clamor" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."hurrah"] = { [aP1] = f.."hurrah" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."prance"] = { [aP1] = f.."prance" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."dimension"] = { [aP1] = f.."dimension" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."twistwasp"] = { [aP1] = f.."twistwasp" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."plasticfork"] = { [aP1] = f.."plasticfork" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 400 ,[Jf] = true }
	,[f.."plasticfork_walk"] = { [aP1] = f.."plasticfork" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 400 ,[Jf] = true }
	,[f.."enrapture"] = { [aP1] = f.."enrapture" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."mesmerize"] = { [aP1] = f.."mesmerize" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."resonant"] = { [aP1] = f.."resonant" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 320 ,[Jf] = true }
	,[f.."resonant_walk"] = { [aP1] = f.."resonant" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 320 ,[Jf] = true }
	,[f.."jadetowel"] = { [aP1] = f.."jadetowel" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."jadetowel_gloss"] = { [aP1] = f.."jadetowel_gloss" ,[Jg] = true,[sC] = true,[sO] = true,["NoEffectP2"] = true }
	,[f.."lemoncart_static"] = { [aP1] = f.."lemoncart_static" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 150 ,[Jf] = true }
	,[f.."lemoncart_walk"] = { [aP1] = f.."lemoncart_static" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 150 ,[Jf] = true }
	,[f.."vacant"] = { [aP1] = f.."vacant" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."studs"] = { [aP1] = f.."studs" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."elegantlily"] = { [aP1] = f.."elegantlily" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."canine"] = { [aP1] = f.."canine" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."noodles"] = { [aP1] = f.."noodles" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."dignified"] = { [aP1] = f.."dignified" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."pastasauce"] = { [aP1] = f.."pastasauce" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."ringer"] = { [aP1] = f.."ringer" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."ringer_walk"] = { [aP1] = f.."ringer" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."jumpstyledance"] = { [aP1] = f.."jumpstyledance" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."justhome"] = { [aP1] = f.."justhome" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."lilsplit"] = { [aP1] = f.."lilsplit" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."darling"] = { [aP1] = f.."darling" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."goodbyeupbeat"] = { [aP1] = f.."goodbyeupbeat" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."goodbyeupbeat_walk"] = { [aP1] = f.."goodbyeupbeat" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."shiverflame"] = { [aP1] = f.."shiverflame" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."downward"] = { [aP1] = f.."downward" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."snowknight"] = { [aP1] = f.."snowknight" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."speeddial"] = { [aP1] = f.."speeddial" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."nimble"] = { [aP1] = f.."nimble" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."voidredemption"] = { [aP1] = f.."voidredemption" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."congaline"] = { [aP1] = f.."congaline" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."congaline_walk"] = { [aP1] = f.."congaline" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."wheresmatt"] = { [aP1] = f.."wheresmatt" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."wheresmatt_walk"] = { [aP1] = f.."wheresmatt" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."bewilder"] = { [aP1] = f.."bewilder" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."cadaver"] = { [aP1] = f.."cadaver" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."chilled"] = { [aP1] = f.."chilled" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."boomer"] = { [aP1] = f.."boomer" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."kelplinen"] = { [aP1] = f.."kelplinen" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."whisk"] = { [aP1] = f.."whisk" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."undead"] = { [aP1] = f.."undead" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."twohype"] = { [aP1] = f.."twohype" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."twohype_walk"] = { [aP1] = f.."twohype" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."tollbridge"] = { [aP1] = f.."tollbridge" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."sitandspin"] = { [aP1] = f.."sitandspin" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."shimmy"] = { [aP1] = f.."shimmy" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."electroshuffle"] = { [aP1] = f.."electroshuffle" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."charleston"] = { [aP1] = f.."charleston" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."sandwichbop"] = { [aP1] = f.."sandwichbop" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."sandwichbop_walk"] = { [aP1] = f.."sandwichbop" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."sunlit"] = { [aP1] = f.."sunlit" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."hotpink"] = { [aP1] = f.."hotpink" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."jumpingjoy_static"] = { [aP1] = f.."jumpingjoy_static" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."jumpingjoy_walk"] = { [aP1] = f.."jumpingjoy_static" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 280 ,[Jf] = true }
	,[f.."behere"] = { [aP1] = f.."behere" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."selenecobra"] = { [aP1] = f.."selenecobra" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."sleek"] = { [aP1] = f.."sleek" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."twistdaytona"] = { [aP1] = f.."twistdaytona" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."tally"] = { [aP1] = f.."tally" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."dance_distraction"] = { [aP1] = f.."dance_distraction" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."chew"] = { [aP1] = f.."chew" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."autumntea"] = { [aP1] = f.."autumntea" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."aloha"] = { [aP1] = f.."aloha" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."devotion"] = { [aP1] = f.."devotion" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."dreadful"] = { [aP1] = f.."dreadful" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."gasstation"] = { [aP1] = f.."gasstation" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."gothdance"] = { [aP1] = f.."gothdance" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."cottontail"] = { [aP1] = f.."cottontail" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."jiggle"] = { [aP1] = f.."jiggle" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."gwaradance"] = { [aP1] = f.."gwaradance" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."julybooks"] = { [aP1] = f.."julybooks" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."griddle"] = { [aP1] = f.."griddle" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 180 ,[Jf] = true }
	,[f.."griddle_walk"] = { [aP1] = f.."griddle" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 180 ,[Jf] = true }
	,[f.."headset"] = { [aP1] = f.."headset" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 180 ,[Jf] = true }
	,[f.."headset_walk"] = { [aP1] = f.."headset" ,[Jg] = true,[sC] = true,[sO] = true ,[MDe] = 180 ,[Jf] = true }
	,[f.."littleegg"] = { [aP1] = f.."littleegg" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."nevergonna"] = { [aP1] = f.."nevergonna" ,[Jg] = true,[sC] = true,[sO] = true }
	,[f.."glowstickdance"] = { [aP1] = f.."glowstickdance" ,[Jg] = true,[sC] = true,[sO] = true }
}
