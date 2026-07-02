if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end

-- if SERVER then return end

A_AM.ActMod.FlexDatabase = A_AM.ActMod.FlexDatabase or {}




A_AM.ActMod.FlexDatabase["Gmod-HL2"] = {

	-- Blink / Eyelids
	["blink"] = {"blink", "eyes_blink", "eye_blink"}
	,["left_lid_closer"] = {"blink_l", "eye_close_l", "left_lid_closer"}
	,["right_lid_closer"] = {"blink_r", "eye_close_r", "right_lid_closer"}
	,["half_closed"] = {"half_closed", "eye_calm", "eyes_calm"}

	-- Eyelid emotion
	,["left_lid_tightener"] = {"left_lid_tightener", "blink_smile_l"}
	,["right_lid_tightener"] = {"right_lid_tightener", "blink_smile_r"}
	,["left_lid_raiser"] = {"eyes_raise_l", "eye_surprised_l"}
	,["right_lid_raiser"] = {"eyes_raise_r", "eye_surprised_r"}

	-- Brows / Forehead
	,["left_inner_raiser"] = {"brow raise l", "brows_up_left"}
	,["right_inner_raiser"] = {"brow raise r", "brows_up_right"}
	,["left_outer_raiser"] = {"brows_happy_left"}
	,["right_outer_raiser"] = {"brows_happy_right"}
	,["left_lowerer"] = {"brows_lower_left", "angry_l"}
	,["right_lowerer"] = {"brows_lower_right", "angry_r"}
	,["wrinkler"] = {"anger", "eyes_angry"}
	,["dilator"] = {"eye_wide", "eyes_surprised"}

	-- Eyes direction
	,["eyes_updown"] = {"eye_up", "eye_down", "eyes_look_up", "eyes_look_down"}
	,["eyes_rightleft"] = {"eye_left", "eye_right", "eyes_look_left", "eyes_look_right"}

	-- Mouth core
	,["jaw_drop"] = {"jaw_drop", "mouth_open", "mouth_u", "mouth_o"}
	,["jaw_clencher"] = {"mouth_widen"}
	,["lower_lip"] = {"lower_lip", "mouth_a", "mouth_lick"}
	,["presser"] = {"mouth_i", "mouth_chi"}
	,["tightener"] = {"mouth_narrow"}

	-- Mouth corners / emotion
	,["smile"] = {"smile", "mouth_smile", "mouth_e", "happy"}
	,["left_corner_puller"] = {"mouth_grin_l"}
	,["right_corner_puller"] = {"mouth_grin_r"}
	,["left_corner_depressor"] = {"mouth_sad_l", "sad_l"}
	,["right_corner_depressor"] = {"mouth_sad_r", "sad_r"}

	-- Extra mouth shaping
	,["left_puckerer"] = {"mouth_o_l"}
	,["right_puckerer"] = {"mouth_o_r"}
	,["left_funneler"] = {"mouth_u_l"}
	,["right_funneler"] = {"mouth_u_r"}

	-- Cheeks / Chin
	,["left_cheek_raiser"] = {"cheek_up_l"}
	,["right_cheek_raiser"] = {"cheek_up_r"}
	,["chin_raiser"] = {"chin"}

}


A_AM.ActMod.FlexDatabase["MMD_v2"] = {
	["blink"] = {"eyes_blink", "eye down", "eyelid_down", "eye_blink"}
	,["eye_blink_happy"] = {"eyes_blink_happy", "eyes_wink", "eyes_happy","eye_happy", "blink_smile"}
	,["eye_blink_happy_left"] = {"left_lid_tightener", "blink_smile_l"}
	,["eye_blink_happy_right"] = {"right_lid_tightener", "blink_smile_r"}
	,["eye_blink_left"] = {"left_lid_closer", "eyes_left", "blink_l", "eye_close_l"}
	,["eye_blink_right"] = {"right_lid_closer", "eyes_right", "blink_r", "eye_close_r"}
	,["eyes_calm"] = {"half_closed", "eye_calm"}
	,["eyes_surprised"] = {"eyes_raise", "eye_surprised", "eye_shocked"}
	,["eyes_stare"] = {"eye_smug", "eye_digusted"}
	,["eyes_anger"] = {"angry eyes", "eyes_angry"}
	,["eyes_staring"] = {"stare"}
	-- ,["eyes_outer_upper"] = {}
	-- ,["eyes_outer_lower"] = {}
	,["eyes_lower_upper"] = {"eyes_funny", "eyes_smug"} -- Mouth
	,["mouth_a"] = {"lower_lip", "a", "ah", "aa", "mouth a", "ah2"}
	,["mouth_i"] = {"presser", "mouth i", "i"}
	,["mouth_u"] = {"jaw_drop", "mouth u", "u"}
	,["mouth_e"] = {"e", "mouth e", "smile"}
	,["mouth_o"] = {"o", "oh", "mouth o", "kuchio"}
	,["mouth_grin"] = {"mouth_smirk"}
	,["mouth_wa"] = {"mouth_open_wide"}
	-- ,["mouth_neutral"] = {}
	,["mouth_ch_1"] = {"mouth_chi", "chi"}
	-- ,["mouth_ch_2"] = {}
	,["mouth_a_2"] = {"mouth_unhappy_open"}
	-- ,["mouth_grin_2"] = {}
	-- ,["mouth_grin_3"] = {}
	,["mouth_cat"] = {"cat"}
	,["mouth_tehheh"] = {"tehheh", "sidelick"}
	,["mouth_lick"] = {"lick", "mouth_tongue_out"}
	,["mouth_smile"] = {"smile", "mouth_happy", "happy", "mouth_happy_open"}
	,["mouth_sad"] = {"bite", "sadness", "mouth_angry","mouth_triangle", "mouth sad","disappointed"}
	,["mouth_widen"] = {"jaw_clencher"}
	,["mouth_narrow"] = {"tightener"}
	-- ,["mouth_narrow_2"] = {}
	-- ,["mouth_tongue_widen"] = {}
	,["brows_serious"] = {"eyebrows_serious"}
	,["brows_worry"] = {"eyebrows_worried", "eyebrow_worry"}
	,["brows_happy"] = {"brows_cheerful"}
	,["brows_angry"] = {"anger", "angry", "eyebrow_angry"}
	,["brows_flat"] = {"flat"}
	,["brows_up"] = {"brow raise"}
	,["brows_lower"] = {"brow drop"}
	-- ,["brows_closer"] = {}
	-- ,["brows_worry_left"] = {}
	-- ,["brows_worry_right"] = {}
	,["brows_happy_left"] = {"left_outer_raiser"}
	,["brows_happy_right"] = {"right_outer_raiser"}
	,["brows_up_left"] = {"left_inner_raiser"}
	,["brows_up_right"] = {"right_inner_raiser"}
	,["brows_lower_left"] = {"left_lowerer"}
	,["brows_lower_right"] = {"right_lowerer"}
	-- ,["brows_closer_left"] = {}
	-- ,["brows_closer_right"] = {}
	,["eyes_look_up"] = {"eyes_updown", "up", "eye_up"}
	,["eyes_look_down"] = {"down", "eye_down"}
	,["eyes_look_left"] = {"eye_left"}
	,["eyes_look_right"] = {"eye_right"}
	,["eyes_look_camera"] = {"camera eyes"}
}


A_AM.ActMod.FlexDatabase["MMD_v1"] = {
	["blink"] = {"eyes_blink","eye down","eyelid_down","eye_blink"}
	,["eye_blink_happy"] = {"eyes_wink", "eyes_happy", "eye_happy", "blink_smile"}
	,["eye_blink_happy_left"] = {"left_lid_tightener", "blink_smile_l"}
	,["eye_blink_happy_right"] = {"right_lid_tightener", "blink_smile_r"}
	,["eye_blink_left"] = {"left_lid_closer", "eyes_left", "blink_l", "eye_close_l"}
	,["eye_blink_right"] = {"right_lid_closer", "eyes_right", "blink_r", "eye_close_r"}
	,["eyes_calm"] = {"half_closed", "eye_calm"}
	,["eyes_surprised"] = {"eyes_raise", "eye_surprised", "eye_shocked"}
	,["eyes_stare"] = {"eye_smug", "eye_digusted"}
	,["brows_sad"] = {"brow_sad"}
	,["eyes_anger"] = {"angry eyes", "eyes_angry"}
	,["eyes_staring"] = {"stare"}
	-- ,["eyes_outer_upper"] = {}
	-- ,["eyes_outer_lower"] = {}
	,["eyes_lower_upper"] = {"eyes_funny", "eyes_smug"}
	,["mouth_a"] = {"lower_lip", "a", "ah", "aa", "mouth a", "ah2"}
	,["mouth_i"] = {"presser", "mouth i", "i"}
	,["mouth_u"] = {"jaw_drop", "mouth u", "u"}
	,["mouth_e"] = {"e", "mouth e"}
	,["mouth_o"] = {"o", "oh", "mouth o", "kuchio"}
	,["mouth_grin"] = {"mouth_smirk"}
	,["mouth_wa"] = {"mouth_open_wide"}
	-- ,["mouth_neutral"] = {}
	,["mouth_ch_1"] = {"mouth_chi", "chi"}
	-- ,["mouth_ch_2"] = {}
	,["mouth_a_2"] = {"mouth_unhappy_open"}
	-- ,["mouth_grin_2"] = {}
	-- ,["mouth_grin_3"] = {}
	,["mouth_cat"] = {"cat"}
	,["mouth_tehheh"] = {"tehheh", "sidelick"}
	,["mouth_lick"] = {"lick", "mouth_tongue_out"}
	,["mouth_smile"] = {"smile", "mouth_happy", "happy", "mouth_happy_open"}
	,["mouth_sad"] = {"bite", "sadness", "mouth_angry", "mouth_triangle", "mouth sad", "disappointed"}
	,["mouth_widen"] = {"jaw_clencher"}
	,["mouth_narrow"] = {"tightener"}
	-- ,["mouth_narrow_2"] = {}
	-- ,["mouth_tongue_widen"] = {}
	,["brows_serious"] = {"eyebrows_serious"}
	,["brows_worry"] = {"eyebrows_worried", "eyebrow_worry"}
	,["brows_happy"] = {"brows_cheerful"}
	,["brows_angry"] = {"anger", "angry", "eyebrow_angry"}
	,["brows_flat"] = {"flat"}
	,["brows_up"] = {"brow raise"}
	,["brows_lower"] = {"brow drop"}
	-- ,["brows_closer"] = {}
	-- ,["brows_worry_left"] = {}
	-- ,["brows_worry_right"] = {}
	,["brows_happy_left"] = {"left_outer_raiser"}
	,["brows_happy_right"] = {"right_outer_raiser"}
	,["brows_up_left"] = {"left_inner_raiser"}
	,["brows_up_right"] = {"right_inner_raiser"}
	,["brows_lower_left"] = {"left_lowerer"}
	,["brows_lower_right"] = {"right_lowerer"}
	-- ,["brows_closer_left"] = {}
	-- ,["brows_closer_right"] = {}
	,["eyes_look_up"] = {"eyes_updown", "up", "eye_up"}
	,["eyes_look_down"] = {"down", "eye_down"}
	,["eyes_look_left"] = {"eye_left"}
	,["eyes_look_right"] = {"eye_right"}
	,["eyes_look_camera"] = {"camera eyes"}
}




// Common
A_AM.ActMod.FlexDatabase["Common"] = {
	["blink"] = {
		"blink","eyes_blink","eye_blink","eyelid_down","lid_close","lid_blink",
		"eyes_blink_left","eyes_blink_right","eye_blink_left","eye_blink_right",
		"blink_l","blink_r"
	}
	,["eyes_up"] = {
		"eyes_up","look_up","up_eyes","eyes_updown","eyes_updown_v",
		"eyes_up_left","eyes_up_right","look_up_left","look_up_right"
	}
	,["eyes_down"] = {
		"eyes_down","look_down","down_eyes","eyes_down_v",
		"eyes_down_left","eyes_down_right","look_down_left","look_down_right"
	}
	,["eyes_left"] = {
		"eyes_left","look_left","left_eyes","eye_left","eyes_left_v",
		"look_left_v","eye_left_v"
	}
	,["eyes_right"] = {
		"eyes_right","look_right","right_eyes","eye_right","eyes_right_v",
		"look_right_v","eye_right_v"
	}
	,["smile"] = {
		"smile","mouth_smile","multi_Smile","smile_big","smile_wide",
		"mouth_smile_left","mouth_smile_right","smile_l","smile_r"
	}
	,["frown"] = {
		"frown","mouth_frown","sad","downturn","mouth_frown_left","mouth_frown_right"
	}
	,["mouth_open"] = {
		"mouth_open","jaw_drop","open_mouth","mouth_o","mouth_open_wide",
		"jaw_open","mouth_open_l","mouth_open_r"
	}
	,["mouth_close"] = {
		"mouth_close","jaw_close","close_mouth"
	}
	,["jaw_forward"] = {
		"jaw_forward","jaw_push","jaw_out","jaw_forward_v"
	}
	,["jaw_left"] = {
		"jaw_left","jaw_left_v","jaw_leftward"
	}
	,["jaw_right"] = {
		"jaw_right","jaw_right_v","jaw_rightward"
	}
	,["brow_up"] = {
		"brow_up","brow_raise","brow_up_left","brow_up_right","brow_raise_l","brow_raise_r"
	}
	,["brow_down"] = {
		"brow_down","brow_lower","brow_down_left","brow_down_right"
	}
	,["cheek_puff"] = {
		"cheek_puff","cheek_puff_left","cheek_puff_right"
	}
	,["cheek_suck"] = {
		"cheek_suck","cheek_suck_left","cheek_suck_right"
	}
	,["tongue_out"] = {
		"tongue_out","tongue_out_long","tongue_out_left","tongue_out_right"
	}
	,["tongue_in"] = {
		"tongue_in","tongue_in_left","tongue_in_right"
	}
	,["nose_sneer"] = {
		"nose_sneer","nose_wrinkle","nose_up","nose_sneer_left","nose_sneer_right"
	}
	,["phoneme_aa"] = {"aa","phoneme_aa","A"}
	,["phoneme_oo"] = {"oh","phoneme_oh","oo","O"}
	,["phoneme_ee"] = {"ee","phoneme_ee","E"}
	,["phoneme_ih"] = {"ih","phoneme_ih","I"}
	,["phoneme_ou"] = {"ou","phoneme_ou"}
	,["phoneme_m"] = {"m","phoneme_m"}
	,["phoneme_f"] = {"f","phoneme_f"}
	,["phoneme_s"] = {"s","phoneme_s"}
	,["phoneme_t"] = {"t","phoneme_t"}
	,["phoneme_r"] = {"r","phoneme_r"}
	,["phoneme_l"] = {"l","phoneme_l"}
}


// HL2 
A_AM.ActMod.FlexDatabase["HL2"] = {
	["blink"] = {"eyes_blink","blink","eye_blink"}
	,["eyes_up"] = {"eyes_up","eyes_updown","eyes_updown_v"}
	,["eyes_down"] = {"eyes_down","eyes_updown","eyes_updown_v"}
	,["eyes_left"] = {"eyes_left","eye_left"}
	,["eyes_right"] = {"eyes_right","eye_right"}
	,["smile"] = {"smile","mouth_smile","multi_Smile"}
	,["frown"] = {"frown","mouth_frown"}
	,["jaw_drop"] = {"jaw_drop","mouth_open"}
	,["jaw_left"] = {"jaw_left"}
	,["jaw_right"] = {"jaw_right"}
	,["brow_up"] = {"brow_up","brow_raise"}
	,["brow_down"] = {"brow_down","brow_lower"}
	,["tongue_out"] = {"tongue_out"}
	,["tongue_in"] = {"tongue_in"}
}


// TF2
A_AM.ActMod.FlexDatabase["TF2"] = {
    ["blink"] = {"blink","eyes_blink","eye_blink","blink_l","blink_r"}
    ,["eyes_up"] = {"eyes_up","eyes_updown","eyes_updown_v"}
    ,["eyes_down"] = {"eyes_down","eyes_updown","eyes_updown_v"}
    ,["eyes_left"] = {"eyes_left","eye_left"}
    ,["eyes_right"] = {"eyes_right","eye_right"}

    ,["brow_in"] = {"brow_in","brow_inner_up","brow_inner_down"}
    ,["brow_out"] = {"brow_out","brow_outer_up","brow_outer_down"}

    ,["jaw_drop"] = {"jaw_drop","jaw_open","mouth_open"}
    ,["jaw_forward"] = {"jaw_forward","jaw_push"}
    ,["jaw_left"] = {"jaw_left"}
    ,["jaw_right"] = {"jaw_right"}

    ,["smile"] = {"smile","mouth_smile","multi_Smile","smile_big"}
    ,["frown"] = {"frown","mouth_frown","sad"}
    ,["mouth_open"] = {"mouth_open","jaw_drop"}
    ,["mouth_close"] = {"mouth_close","jaw_close"}

    ,["phoneme_aa"] = {"aa","phoneme_aa"}
    ,["phoneme_oh"] = {"oh","phoneme_oh"}
    ,["phoneme_ee"] = {"ee","phoneme_ee"}
    ,["phoneme_oo"] = {"oo","phoneme_oo"}
    ,["phoneme_m"] = {"m","phoneme_m"}
    ,["phoneme_f"] = {"f","phoneme_f"}
}


// SFM
A_AM.ActMod.FlexDatabase["SFM"] = {
    ["blink"] = {"blink","eyes_blink","eye_blink","lid_close","eyelid_down"},
    ["eyes_up"] = {"eyes_up","look_up"},
    ["eyes_down"] = {"eyes_down","look_down"},
    ["eyes_left"] = {"eyes_left","look_left"},
    ["eyes_right"] = {"eyes_right","look_right"},

    ["brow_up"] = {"brow_up","brow_raise","brow_inner_up"},
    ["brow_down"] = {"brow_down","brow_lower","brow_inner_down"},

    ["smile"] = {"smile","mouth_smile","smile_big","smile_wide"},
    ["frown"] = {"frown","mouth_frown","sad"},

    ["jaw_drop"] = {"jaw_drop","mouth_open"},
    ["jaw_forward"] = {"jaw_forward","jaw_push"},
    ["jaw_left"] = {"jaw_left"},
    ["jaw_right"] = {"jaw_right"},

    ["tongue_out"] = {"tongue_out"},
    ["tongue_in"] = {"tongue_in"},

    ["phoneme_aa"] = {"aa","phoneme_aa"},
    ["phoneme_oh"] = {"oh","phoneme_oh"},
    ["phoneme_ee"] = {"ee","phoneme_ee"},
    ["phoneme_oo"] = {"oo","phoneme_oo"},
    ["phoneme_m"] = {"m","phoneme_m"},
    ["phoneme_f"] = {"f","phoneme_f"},
}


// HWM
A_AM.ActMod.FlexDatabase["HWM"] = {
    ["blink"] = {"blink","eyes_blink","eye_blink","lid_close","eyelid_down"},
    ["eyes_up"] = {"eyes_up","eyes_updown","look_up"},
    ["eyes_down"] = {"eyes_down","eyes_updown","look_down"},
    ["eyes_left"] = {"eyes_left","look_left"},
    ["eyes_right"] = {"eyes_right","look_right"},

    ["brow_up"] = {"brow_up","brow_raise","brow_inner_up","brow_outer_up"},
    ["brow_down"] = {"brow_down","brow_lower","brow_inner_down","brow_outer_down"},

    ["smile"] = {"smile","mouth_smile","smile_big","smile_wide","smile_left","smile_right"},
    ["frown"] = {"frown","mouth_frown","sad","sad_left","sad_right"},

    ["jaw_drop"] = {"jaw_drop","jaw_open","mouth_open"},
    ["jaw_forward"] = {"jaw_forward","jaw_push"},
    ["jaw_left"] = {"jaw_left"},
    ["jaw_right"] = {"jaw_right"},

    ["mouth_pucker"] = {"mouth_pucker","pucker"},
    ["mouth_suck"] = {"mouth_suck","suck"},
    ["tongue_out"] = {"tongue_out","tongue_out_long"},
    ["tongue_in"] = {"tongue_in"},

    ["phoneme_aa"] = {"aa","phoneme_aa"},
    ["phoneme_oh"] = {"oh","phoneme_oh"},
    ["phoneme_ee"] = {"ee","phoneme_ee"},
    ["phoneme_oo"] = {"oo","phoneme_oo"},
    ["phoneme_m"] = {"m","phoneme_m"},
    ["phoneme_f"] = {"f","phoneme_f"},
}


// MMD
A_AM.ActMod.FlexDatabase["MMD"] = {
    ["blink"] = {"blink","EyeBlink","eyeBlink","blink_L","blink_R","eyeBlinkLeft","eyeBlinkRight"},
    ["smile"] = {"Smile","smile","MouthSmile","mouthSmile","smile_L","smile_R"},
    ["mouth_open"] = {"A","Open","mouthOpen","mouth_open"},
    ["mouth_o"] = {"O","o","mouthO"},
    ["mouth_w"] = {"W","w","mouthW"},
    ["mouth_u"] = {"U","u","mouthU"},
    ["angry"] = {"Angry","angry"},
    ["sad"] = {"Sad","sad"},
    ["surprised"] = {"Surprised","surprised"},
    ["brow_up"] = {"BrowUp","browUp","browUp_L","browUp_R"},
    ["brow_down"] = {"BrowDown","browDown","browDown_L","browDown_R"},
    ["tongue_out"] = {"TongueOut","tongueOut"},
    ["tongue_in"] = {"TongueIn","tongueIn"},
}



// CSGO
A_AM.ActMod.FlexDatabase["CSGO"] = {
    ["blink"] = {"blink","eyes_blink","eye_blink"},
    ["eyes_up"] = {"eyes_up","eyes_updown"},
    ["eyes_down"] = {"eyes_down","eyes_updown"},
    ["eyes_left"] = {"eyes_left"},
    ["eyes_right"] = {"eyes_right"},

    ["brow_up"] = {"brow_up","brow_raise"},
    ["brow_down"] = {"brow_down","brow_lower"},

    ["smile"] = {"smile","mouth_smile","smile_big"},
    ["frown"] = {"frown","mouth_frown","sad"},

    ["jaw_drop"] = {"jaw_drop","jaw_open","mouth_open"},
    ["jaw_forward"] = {"jaw_forward","jaw_push"},
    ["jaw_left"] = {"jaw_left"},
    ["jaw_right"] = {"jaw_right"},

    ["phoneme_aa"] = {"aa","phoneme_aa"},
    ["phoneme_oh"] = {"oh","phoneme_oh"},
    ["phoneme_ee"] = {"ee","phoneme_ee"},
    ["phoneme_oo"] = {"oo","phoneme_oo"},
}


// L4D
A_AM.ActMod.FlexDatabase["L4D"] = {
    ["blink"] = {"blink","eyes_blink","eye_blink"},
    ["eyes_up"] = {"eyes_up","eyes_updown"},
    ["eyes_down"] = {"eyes_down","eyes_updown"},
    ["eyes_left"] = {"eyes_left"},
    ["eyes_right"] = {"eyes_right"},

    ["smile"] = {"smile","mouth_smile","smile_big"},
    ["frown"] = {"frown","mouth_frown"},
    ["jaw_drop"] = {"jaw_drop","jaw_open","mouth_open"},
    ["jaw_left"] = {"jaw_left"},
    ["jaw_right"] = {"jaw_right"},

    ["brow_up"] = {"brow_up","brow_raise"},
    ["brow_down"] = {"brow_down","brow_lower"},

    ["phoneme_aa"] = {"aa","phoneme_aa"},
    ["phoneme_oh"] = {"oh","phoneme_oh"},
    ["phoneme_ee"] = {"ee","phoneme_ee"},
}


// DOTA2
A_AM.ActMod.FlexDatabase["DOTA2"] = {
    ["blink"] = {"blink","eyes_blink"},
    ["eyes_up"] = {"eyes_up"},
    ["eyes_down"] = {"eyes_down"},
    ["eyes_left"] = {"eyes_left"},
    ["eyes_right"] = {"eyes_right"},
    ["jaw_drop"] = {"jaw_drop","mouth_open"},
    ["smile"] = {"smile","mouth_smile"},
    ["frown"] = {"frown","mouth_frown"},
}


// PORTAL
A_AM.ActMod.FlexDatabase["PORTAL"] = {
    ["blink"] = {"blink","eyes_blink"},
    ["eyes_up"] = {"eyes_up"},
    ["eyes_down"] = {"eyes_down"},
    ["eyes_left"] = {"eyes_left"},
    ["eyes_right"] = {"eyes_right"},

    ["smile"] = {"smile","mouth_smile"},
    ["frown"] = {"frown","mouth_frown"},
    ["jaw_drop"] = {"jaw_drop","mouth_open"},
}


// HL1
A_AM.ActMod.FlexDatabase["HL1"] = {
    ["blink"] = {"blink","eyes_blink"},
    ["eyes_up"] = {"eyes_up"},
    ["eyes_down"] = {"eyes_down"},
    ["eyes_left"] = {"eyes_left"},
    ["eyes_right"] = {"eyes_right"},

    ["jaw_drop"] = {"jaw_drop","mouth_open"},
    ["smile"] = {"smile","mouth_smile"},
    ["frown"] = {"frown","mouth_frown"},
}


// SOURCE_GENERIC
A_AM.ActMod.FlexDatabase["SOURCE_GENERIC"] = {
    ["blink"] = {"blink","eyes_blink","eye_blink","eyelid_down"},
    ["eyes_up"] = {"eyes_up","look_up"},
    ["eyes_down"] = {"eyes_down","look_down"},
    ["eyes_left"] = {"eyes_left","look_left"},
    ["eyes_right"] = {"eyes_right","look_right"},

    ["smile"] = {"smile","mouth_smile","multi_Smile"},
    ["frown"] = {"frown","mouth_frown"},
    ["jaw_drop"] = {"jaw_drop","mouth_open"},
    ["jaw_left"] = {"jaw_left"},
    ["jaw_right"] = {"jaw_right"},
    ["brow_up"] = {"brow_up","brow_raise"},
    ["brow_down"] = {"brow_down","brow_lower"},
}
