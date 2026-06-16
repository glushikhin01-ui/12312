-- bazooka ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_BZKA.Ext", {"weapons/tfa_codww2/bazooka/wpn_bzka_tail_01.wav", "weapons/tfa_codww2/bazooka/wpn_bzka_tail_02.wav"}, false, ")")
TFA.AddFireSound("TFA_CODWW2_BZKA.Shoot", {"weapons/tfa_codww2/bazooka/wpn_bzka_shot_01.wav", "weapons/tfa_codww2/bazooka/wpn_bzka_shot_02.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_BZKA.Body", {"weapons/tfa_codww2/bazooka/wpn_bzka_body_01.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_BZKA.Low", {"weapons/tfa_codww2/bazooka/wpn_bzka_low_01.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_BZKA.Metal", {"weapons/tfa_codww2/bazooka/wpn_bzka_metal_01.wav", "weapons/tfa_codww2/bazooka/wpn_bzka_metal_02.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_BZKA.Snap", {"weapons/tfa_codww2/bazooka/wpn_bzka_snap_01.wav"}, true, ")")

TFA.AddWeaponSound("TFA_CODWW2_BZKA.Rattle", "weapons/tfa_codww2/bazooka/wpn_bazooka_reload_rattles.wav")
TFA.AddWeaponSound("TFA_CODWW2_BZKA.RocketIn", "weapons/tfa_codww2/bazooka/wpn_bazooka_reload_rocketin.wav")

TFA.AddWeaponSound("TFA_CODWW2_BZKA.Inspect1", "weapons/tfa_codww2/bazooka/wpn_bazooka_inspect_stndrd_pt_01.wav")
TFA.AddWeaponSound("TFA_CODWW2_BZKA.Inspect2", "weapons/tfa_codww2/bazooka/wpn_bazooka_inspect_stndrd_pt_02.wav")
TFA.AddWeaponSound("TFA_CODWW2_BZKA.EpicInspect1", "weapons/tfa_codww2/bazooka/wpn_bazooka_inspect_epic_pt_01.wav")
TFA.AddWeaponSound("TFA_CODWW2_BZKA.EpicInspect2", "weapons/tfa_codww2/bazooka/wpn_bazooka_inspect_epic_pt_02.wav")

-- betty ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_BETTY.Boom", {"weapons/tfa_codww2/smi44_betty/wpn_betty_boom_lyr_01.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_boom_lyr_02.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_boom_lyr_03.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_BETTY.Exp", {"weapons/tfa_codww2/smi44_betty/wpn_betty_exp_01.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_exp_02.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_exp_03.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_exp_04.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_exp_05.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_BETTY.Low", {"weapons/tfa_codww2/smi44_betty/wpn_betty_low_lyr.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_BETTY.UrFucked", {"weapons/tfa_codww2/smi44_betty/wpn_betty_activate_01.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_activate_02.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_activate_03.wav"}, true, ")")

TFA.AddWeaponSound("TFA_CODWW2_BETTY.Land", {"weapons/tfa_codww2/smi44_betty/wpn_bouncing_betty_land_default_01.wav", "weapons/tfa_codww2/smi44_betty/wpn_bouncing_betty_land_default_02.wav", "weapons/tfa_codww2/smi44_betty/wpn_bouncing_betty_land_default_03.wav"})
TFA.AddWeaponSound("TFA_CODWW2_BETTY.PullPin", {"weapons/tfa_codww2/smi44_betty/wpn_bouncing_betty_pull_out_01.wav", "weapons/tfa_codww2/smi44_betty/wpn_bouncing_betty_pull_out_02.wav", "weapons/tfa_codww2/smi44_betty/wpn_bouncing_betty_pull_out_03.wav"})

sound.Add(
{
    name = "TFA_CODWW2_BETTY.Sharpnel",
    channel = CHAN_STATIC,
    volume = 1,
    soundlevel = 175,
    sound = {"weapons/tfa_codww2/smi44_betty/wpn_betty_shrapnel_01.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_shrapnel_02.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_shrapnel_03.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_shrapnel_04.wav", "weapons/tfa_codww2/smi44_betty/wpn_betty_shrapnel_05.wav"}, 
})

-- concussion ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_FLASHBANG.Exp", {"weapons/tfa_codww2/flashbang/wpn_conc_grenade_01.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_02.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_03.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_04.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_FLASHBANG.Dist", {"weapons/tfa_codww2/flashbang/wpn_conc_grenade_dist_01.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_dist_02.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_FLASHBANG.Lyr2", {"weapons/tfa_codww2/flashbang/wpn_conc_grenade_lyr2_01.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_lyr2_02.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_lyr2_03.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_lyr2_04.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_FLASHBANG.Lyr3", {"weapons/tfa_codww2/flashbang/wpn_conc_grenade_lyr3_01.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_lyr3_02.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_lyr3_03.wav", "weapons/tfa_codww2/flashbang/wpn_conc_grenade_lyr3_04.wav"}, true, ")")

-- crossbow ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_CROSSBOW.Shoot", {"weapons/tfa_codww2/crossbow/wpn_crossbow_shot_01.wav", "weapons/tfa_codww2/crossbow/wpn_crossbow_shot_02.wav", "weapons/tfa_codww2/crossbow/wpn_crossbow_shot_03.wav"}, true, ")")

TFA.AddWeaponSound("TFA_CODWW2_CROSSBOW.FPO", "weapons/tfa_codww2/crossbow/wpn_crossbow_fpo_charge.wav")

TFA.AddWeaponSound("TFA_CODWW2_CROSSBOW.BoltIn", "weapons/tfa_codww2/crossbow/wpn_crossbow_load_boltin.wav")
TFA.AddWeaponSound("TFA_CODWW2_CROSSBOW.Charge", "weapons/tfa_codww2/crossbow/wpn_crossbow_load_charge.wav")

TFA.AddWeaponSound("TFA_CODWW2_CROSSBOW.Inspect1", "weapons/tfa_codww2/crossbow/wpn_crossbow_inspect_stndrd_pt_01.wav")
TFA.AddWeaponSound("TFA_CODWW2_CROSSBOW.Inspect2", "weapons/tfa_codww2/crossbow/wpn_crossbow_inspect_stndrd_pt_02.wav")
TFA.AddWeaponSound("TFA_CODWW2_CROSSBOW.EpicInspect1", "weapons/tfa_codww2/crossbow/wpn_crossbow_inspect_epic_pt_01.wav")
TFA.AddWeaponSound("TFA_CODWW2_CROSSBOW.EpicInspect2", "weapons/tfa_codww2/crossbow/wpn_crossbow_inspect_epic_pt_02.wav")

-- dynamite ------------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_CODWW2_DYNAMITE.Twist", {"weapons/tfa_codww2/dynamite/dynamite_plant_foley_02.wav", "weapons/tfa_codww2/dynamite/dynamite_plant_foley_03.wav", "weapons/tfa_codww2/dynamite/dynamite_plant_foley_04.wav"})
TFA.AddWeaponSound("TFA_CODWW2_DYNAMITE.Switch", {"weapons/tfa_codww2/dynamite/dynamite_plant_foley_05.wav"})
TFA.AddWeaponSound("TFA_CODWW2_DYNAMITE.Plant", {"weapons/tfa_codww2/dynamite/dynamite_plant_foley_06.wav"})
TFA.AddWeaponSound("TFA_CODWW2_DYNAMITE.Draw", {"weapons/tfa_codww2/dynamite/dynamite_plant_foley_01.wav"})

TFA.AddFireSound("TFA_CODWW2_DYNAMITE.Tick", {"weapons/tfa_codww2/dynamite/mp_s2_obj_timer_tick_1s.wav"}, true, ")")

-- flamethrower ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_M2FT.Loop", {"weapons/tfa_codww2/flamethrower/wpn_flamethrower_loop.wav"}, false, ")")
TFA.AddFireSound("TFA_CODWW2_M2FT.Start", {"weapons/tfa_codww2/flamethrower/wpn_flamethrower_start_01.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_M2FT.Stop", {"weapons/tfa_codww2/flamethrower/wpn_flamethrower_stop_01.wav"}, false, ")")

-- flare ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_FLARE.Exp", {"weapons/tfa_codww2/flare/wpn_flare_exp.wav"}, true, ")")

TFA.AddWeaponSound("TFA_CODWW2_FLARE.Pullpin", {"weapons/tfa_codww2/flare/wpn_flare_equip.wav"})
TFA.AddWeaponSound("TFA_CODWW2_FLARE.Throw", {"weapons/tfa_codww2/flare/wpn_gen_equipment_throw.wav"})

sound.Add(
{
    name = "TFA_CODWW2_FLARE.Burn",
    channel = CHAN_ITEM,
    volume = 0.1,
    soundlevel = 15,
    sound = {"weapons/tfa_codww2/flare/emt_flare_tacinsert_burn.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_FLARE.Burn2",
    channel = CHAN_ITEM,
    volume = 0.15,
    soundlevel = 15,
    sound = {"weapons/tfa_codww2/flare/emt_flare_tacinsert_burn_end.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_FLARE.Fizzle",
    channel = CHAN_ITEM,
    volume = 0.3,
    soundlevel = 15,
    sound = {"weapons/tfa_codww2/flare/emt_flare_tacinsert_fizzle.wav"}, 
})

-- gas ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_TABUNGAS.Thump", {"weapons/tfa_codww2/tabun_gas/wpn_gas_grenade_thump.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_TABUNGAS.Boom", {"weapons/tfa_codww2/tabun_gas/wpn_gas_grenade_boom.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_TABUNGAS.Low", {"weapons/tfa_codww2/tabun_gas/wpn_gas_grenade_low.wav"}, true, ")")

TFA.AddWeaponSound("TFA_CODWW2_TABUNGAS.Hiss", {"weapons/tfa_codww2/tabun_gas/wpn_gas_grenade_hiss.wav"})

-- grenade ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_GRENADE.Accent", {"weapons/tfa_codww2/grenade/grenade_accent_01.wav", "weapons/tfa_codww2/grenade/grenade_accent_02.wav", "weapons/tfa_codww2/grenade/grenade_accent_03.wav", "weapons/tfa_codww2/grenade/grenade_accent_04.wav", "weapons/tfa_codww2/grenade/grenade_accent_05.wav", "weapons/tfa_codww2/grenade/grenade_accent_06.wav", "weapons/tfa_codww2/grenade/grenade_accent_07.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_GRENADE.Low", {"weapons/tfa_codww2/grenade/grenade_low_01.wav", "weapons/tfa_codww2/grenade/grenade_low_02.wav", "weapons/tfa_codww2/grenade/grenade_low_03.wav", "weapons/tfa_codww2/grenade/grenade_low_04.wav", "weapons/tfa_codww2/grenade/grenade_low_05.wav", "weapons/tfa_codww2/grenade/grenade_low_06.wav", "weapons/tfa_codww2/grenade/grenade_low_07.wav", "weapons/tfa_codww2/grenade/grenade_low_08.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_GRENADE.Dist", {"weapons/tfa_codww2/grenade/wpn_grenade_dist_01.wav", "weapons/tfa_codww2/grenade/wpn_grenade_dist_02.wav", "weapons/tfa_codww2/grenade/wpn_grenade_dist_03.wav", "weapons/tfa_codww2/grenade/wpn_grenade_dist_04.wav", "weapons/tfa_codww2/grenade/wpn_grenade_dist_05.wav", "weapons/tfa_codww2/grenade/wpn_grenade_dist_06.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_GRENADE.Trans", {"weapons/tfa_codww2/grenade/wpn_frag_trans_01.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_GRENADE.Sub", {"weapons/tfa_codww2/grenade/wpn_frag_sub_01.wav"}, true, ")")

TFA.AddWeaponSound("TFA_CODWW2_GRENADE.PullPin", {"weapons/tfa_codww2/grenade/wpn_grenade_pull_out_02.wav"})
TFA.AddWeaponSound("TFA_CODWW2_GRENADE.Throw", {"weapons/tfa_codww2/grenade/wpn_grenade_throw_01.wav", "weapons/tfa_codww2/grenade/wpn_grenade_throw_02.wav", "weapons/tfa_codww2/grenade/wpn_grenade_throw_03.wav"})
TFA.AddWeaponSound("TFA_CODWW2_GRENADE.PullPinQuick", {"weapons/tfa_codww2/grenade/wpn_grenade_pull_out_01.wav"})
TFA.AddWeaponSound("TFA_CODWW2_GRENADE.StickPullPin", {"weapons/tfa_codww2/grenade/wpn_stickgren_pull_out_02.wav"})
TFA.AddWeaponSound("TFA_CODWW2_GRENADE.StickThrow", {"weapons/tfa_codww2/grenade/wpn_stickgren_throw_01.wav", "weapons/tfa_codww2/grenade/wpn_stickgren_throw_02.wav", "weapons/tfa_codww2/grenade/wpn_stickgren_throw_03.wav"})

TFA.AddWeaponSound("TFA_CODWW2_GRENADE.Sticky", {"weapons/tfa_codww2/grenade/wpn_sticky_adhere_01.wav", "weapons/tfa_codww2/grenade/wpn_sticky_adhere_02.wav", "weapons/tfa_codww2/grenade/wpn_sticky_adhere_03.wav", "weapons/tfa_codww2/grenade/wpn_sticky_adhere_05.wav"})

TFA.AddWeaponSound("TFA_CODWW2_TRIPWIRE.Pin", {"weapons/tfa_codww2/tripwire/grenade_pin_frag.wav"})

sound.Add(
{
    name = "TFA_CODWW2_GRENADE.Bounce",
    channel = CHAN_WEAPON,
    volume = 1,
    soundlevel = 75,
    sound = {"weapons/tfa_codww2/grenade/grenade_bounce_default_01.wav", "weapons/tfa_codww2/grenade/grenade_bounce_default_02.wav", "weapons/tfa_codww2/grenade/grenade_bounce_default_03.wav", "weapons/tfa_codww2/grenade/grenade_bounce_default_04.wav", "weapons/tfa_codww2/grenade/grenade_bounce_default_05.wav", "weapons/tfa_codww2/grenade/grenade_bounce_default_06.wav", "weapons/tfa_codww2/grenade/grenade_bounce_default_07.wav", "weapons/tfa_codww2/grenade/grenade_bounce_default_08.wav", "weapons/tfa_codww2/grenade/grenade_bounce_default_09.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_GRENADE.StickBounce",
    channel = CHAN_WEAPON,
    volume = 1,
    soundlevel = 75,
    sound = {"weapons/tfa_codww2/grenade/stick_gren_land_default_01.wav", "weapons/tfa_codww2/grenade/stick_gren_land_default_02.wav", "weapons/tfa_codww2/grenade/stick_gren_land_default_03.wav", "weapons/tfa_codww2/grenade/stick_gren_land_default_04.wav", "weapons/tfa_codww2/grenade/stick_gren_land_default_05.wav", "weapons/tfa_codww2/grenade/stick_gren_land_default_06.wav", "weapons/tfa_codww2/grenade/stick_gren_land_default_07.wav", "weapons/tfa_codww2/grenade/stick_gren_land_default_08.wav", "weapons/tfa_codww2/grenade/stick_gren_land_default_09.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_GRENADE.Main",
    channel = CHAN_STATIC,
    volume = 1,
    soundlevel = 175,
    sound = {"weapons/tfa_codww2/grenade/grenade_main_01.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_GRENADE.Debris",
    channel = CHAN_STATIC,
    volume = 1,
    soundlevel = 175,
    sound = {"weapons/tfa_codww2/grenade/grenade_debris_01.wav", "weapons/tfa_codww2/grenade/grenade_debris_04.wav", "weapons/tfa_codww2/grenade/grenade_debris_05.wav", "weapons/tfa_codww2/grenade/grenade_debris_06.wav", "weapons/tfa_codww2/grenade/grenade_debris_07.wav", "weapons/tfa_codww2/grenade/grenade_debris_08.wav", "weapons/tfa_codww2/grenade/grenade_debris_09.wav", "weapons/tfa_codww2/grenade/grenade_debris_10.wav", "weapons/tfa_codww2/grenade/grenade_debris_11.wav", "weapons/tfa_codww2/grenade/grenade_debris_12.wav", "weapons/tfa_codww2/grenade/grenade_debris_13.wav", "weapons/tfa_codww2/grenade/grenade_debris_14.wav", "weapons/tfa_codww2/grenade/grenade_debris_15.wav"}, 
})

-- m1a1 ------------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_CODWW2_M1MINE.Land", {"weapons/tfa_codww2/m1a1/wpn_m1a1_mine_land_default_01.wav", "weapons/tfa_codww2/m1a1/wpn_m1a1_mine_land_default_02.wav", "weapons/tfa_codww2/m1a1/wpn_m1a1_mine_land_default_03.wav"})
TFA.AddWeaponSound("TFA_CODWW2_M1MINE.Pullout", {"weapons/tfa_codww2/m1a1/wpn_m1a1_mine_pull_out_01.wav", "weapons/tfa_codww2/m1a1/wpn_m1a1_mine_pull_out_02.wav", "weapons/tfa_codww2/m1a1/wpn_m1a1_mine_pull_out_03.wav", "weapons/tfa_codww2/m1a1/wpn_m1a1_mine_pull_out_04.wav", "weapons/tfa_codww2/m1a1/wpn_m1a1_mine_pull_out_05.wav"})
TFA.AddWeaponSound("TFA_CODWW2_M1MINE.Throw", {"weapons/tfa_codww2/m1a1/wpn_m1a1_mine_throw_01.wav", "weapons/tfa_codww2/m1a1/wpn_m1a1_mine_throw_02.wav", "weapons/tfa_codww2/m1a1/wpn_m1a1_mine_throw_03.wav"})

-- molotov ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_MOLOTOV.Shatter", {"weapons/tfa_codww2/molotov/mp_ks_molotov_exp_shatter_01.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_exp_shatter_02.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_exp_shatter_03.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_MOLOTOV.Explode", {"weapons/tfa_codww2/molotov/mp_ks_molotov_exp_fire_01.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_exp_fire_02.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_exp_fire_03.wav"}, true, ")")

sound.Add(
{
    name = "TFA_CODWW2_MOLOTOV.CSGO_IDLE_LOOP",
    channel = CHAN_WEAPON,
    volume = 2,
    level = 100,
    sound = "weapons/tfa_codww2/molotov/fire_idle_loop_1.wav"
    --sound = {"weapons/tfa_codww2/molotov/mp_ks_molotov_hold_01.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_02.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_03.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_04.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_05.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_06.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_07.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_MOLOTOV.Loop",
    channel = CHAN_ITEM,
    volume = 0.6,
    soundlevel = 75,
	pitch = {100},
    sound = {"weapons/tfa_codww2/molotov/molotov_burn_loop.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_MOLOTOV.Hold",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 75,
	pitch = {100},
    sound = {"weapons/tfa_codww2/molotov/mp_ks_molotov_hold_01.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_02.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_03.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_04.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_05.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_06.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_hold_07.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_MOLOTOV.Bounce",
    channel = CHAN_STATIC,
    volume = 0.5,
    soundlevel = 75,
    sound = {"weapons/tfa_codww2/molotov/glass_bottle_impact_hard_01.wav", "weapons/tfa_codww2/molotov/glass_bottle_impact_hard_02.wav", "weapons/tfa_codww2/molotov/glass_bottle_impact_hard_03.wav", "weapons/tfa_codww2/molotov/glass_bottle_impact_soft_01.wav", "weapons/tfa_codww2/molotov/glass_bottle_impact_soft_02.wav", "weapons/tfa_codww2/molotov/glass_bottle_impact_soft_03.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_MOLOTOV.End",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 75,
	pitch = {100},
    sound = {"weapons/tfa_codww2/molotov/mp_ks_molotov_fire_stop_01.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_fire_stop_02.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_fire_stop_03.wav"}, 
})

TFA.AddWeaponSound("TFA_CODWW2_MOLOTOV.Pullback", {"weapons/tfa_codww2/molotov/mp_ks_molotov_pullback_01.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_pullback_02.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_pullback_03.wav"})
TFA.AddWeaponSound("TFA_CODWW2_MOLOTOV.Raise", {"weapons/tfa_codww2/molotov/mp_ks_molotov_raise_01.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_raise_02.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_raise_03.wav"})
TFA.AddWeaponSound("TFA_CODWW2_MOLOTOV.Holster", {"weapons/tfa_codww2/molotov/mp_ks_molotov_holster_01.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_holster_02.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_holster_03.wav"})
TFA.AddWeaponSound("TFA_CODWW2_MOLOTOV.Throw", {"weapons/tfa_codww2/molotov/mp_ks_molotov_throw_01.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_throw_02.wav", "weapons/tfa_codww2/molotov/mp_ks_molotov_throw_03.wav"})

-- panzer ------------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_CODWW2_PANZER.Rattle", "weapons/tfa_codww2/panzer/wpn_pzschreck_reload_rattles.wav")
TFA.AddWeaponSound("TFA_CODWW2_PANZER.RocketIn", "weapons/tfa_codww2/panzer/wpn_pzschreck_reload_rocketin.wav")

TFA.AddWeaponSound("TFA_CODWW2_PANZER.Inspect1", "weapons/tfa_codww2/panzer/wpn_pnzr_inspect_stndrd_pt_01.wav")
TFA.AddWeaponSound("TFA_CODWW2_PANZER.Inspect2", "weapons/tfa_codww2/panzer/wpn_pnzr_inspect_stndrd_pt_02.wav")
TFA.AddWeaponSound("TFA_CODWW2_PANZER.EpicInspect1", "weapons/tfa_codww2/panzer/wpn_pnzr_inspect_epic_pt_01.wav")
TFA.AddWeaponSound("TFA_CODWW2_PANZER.EpicInspect2", "weapons/tfa_codww2/panzer/wpn_pnzr_inspect_epic_pt_02.wav")

-- rocket ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_ROCKET.Thump", {"weapons/tfa_codww2/rocket/wpn_rocket_thump_01.wav", "weapons/tfa_codww2/rocket/wpn_rocket_thump_02.wav", "weapons/tfa_codww2/rocket/wpn_rocket_thump_04.wav", "weapons/tfa_codww2/rocket/wpn_rocket_thump_05.wav", "weapons/tfa_codww2/rocket/wpn_rocket_thump_06.wav", "weapons/tfa_codww2/rocket/wpn_rocket_thump_07.wav", "weapons/tfa_codww2/rocket/wpn_rocket_thump_08.wav", "weapons/tfa_codww2/rocket/wpn_rocket_thump_09.wav", "weapons/tfa_codww2/rocket/wpn_rocket_thump_10.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_ROCKET.Trans", {"weapons/tfa_codww2/rocket/wpn_rocket_trans_01.wav", "weapons/tfa_codww2/rocket/wpn_rocket_trans_02.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_ROCKET.Lfe", {"weapons/tfa_codww2/rocket/wpn_rocket_lfe_01.wav", "weapons/tfa_codww2/rocket/wpn_rocket_lfe_02.wav", "weapons/tfa_codww2/rocket/wpn_rocket_lfe_04.wav", "weapons/tfa_codww2/rocket/wpn_rocket_lfe_05.wav", "weapons/tfa_codww2/rocket/wpn_rocket_lfe_07.wav"}, true, ")")

sound.Add(
{
    name = "TFA_CODWW2_ROCKET.Debris",
    channel = CHAN_STATIC,
    volume = 1,
    soundlevel = 175,
    sound = {"weapons/tfa_codww2/rocket/wpn_rocket_debris_01.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_ROCKET.Dust",
    channel = CHAN_STATIC,
    volume = 1,
    soundlevel = 175,
    sound = {"weapons/tfa_codww2/rocket/wpn_rocket_dust_01.wav", "weapons/tfa_codww2/rocket/wpn_rocket_dust_02.wav", "weapons/tfa_codww2/rocket/wpn_rocket_dust_03.wav", "weapons/tfa_codww2/rocket/wpn_rocket_dust_04.wav", "weapons/tfa_codww2/rocket/wpn_rocket_dust_05.wav", "weapons/tfa_codww2/rocket/wpn_rocket_dust_06.wav"}, 
})

-- smokegrenade ------------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_CODWW2_SMOKE.Thump", {"weapons/tfa_codww2/smokegrenade/wpn_smk_gren_thump_01.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_SMOKE.Blast", {"weapons/tfa_codww2/smokegrenade/wpn_smk_gren_blast.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_SMOKE.Explode", {"weapons/tfa_codww2/smokegrenade/morale_smoke_exp.wav"}, true, ")")
TFA.AddFireSound("TFA_CODWW2_SMOKE.Hiss", {"weapons/tfa_codww2/smokegrenade/morale_smoke_throw_hiss.wav"}, true, ")")

TFA.AddWeaponSound("TFA_CODWW2_SMOKE.PullPin", {"weapons/tfa_codww2/smokegrenade/wpn_smoke_pull_out_01.wav"})
TFA.AddWeaponSound("TFA_CODWW2_SMOKE.Gas", {"weapons/tfa_codww2/smokegrenade/wpn_smk_gren_gas_rls.wav"})

sound.Add(
{
    name = "TFA_CODWW2_SMOKE.GasOn",
    channel = CHAN_STATIC,
    volume = 0.3,
    soundlevel = 75,
    sound = {"weapons/tfa_codww2/smokegrenade/mp_smoke_grenade_gas_on_01.wav", "weapons/tfa_codww2/smokegrenade/mp_smoke_grenade_gas_on_02.wav", "weapons/tfa_codww2/smokegrenade/mp_smoke_grenade_gas_on_03.wav", "weapons/tfa_codww2/smokegrenade/mp_smoke_grenade_gas_on_04.wav"}, 
})

-- t43 ------------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_CODWW2_T43MINE.Land", {"weapons/tfa_codww2/t43_mine/wpn_teller_mine_land_default_01.wav", "weapons/tfa_codww2/t43_mine/wpn_teller_mine_land_default_02.wav", "weapons/tfa_codww2/t43_mine/wpn_teller_mine_land_default_03.wav"})
TFA.AddWeaponSound("TFA_CODWW2_T43MINE.Throw", {"weapons/tfa_codww2/t43_mine/wpn_teller_mine_throw_01.wav", "weapons/tfa_codww2/t43_mine/wpn_teller_mine_throw_02.wav", "weapons/tfa_codww2/t43_mine/wpn_teller_mine_throw_03.wav"})

-- thermite ------------------------------------------------------------------------------------------------------------
sound.Add(
{
    name = "TFA_CODWW2_THERMITE.Ignite",
    channel = CHAN_STATIC,
    volume = 1,
    soundlevel = 75,
    sound = {"weapons/tfa_codww2/thermite/ndy_gpf_thermite_ignite.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_THERMITE.Burn",
    channel = CHAN_WEAPON,
    volume = 1,
    soundlevel = 75,
    sound = {"weapons/tfa_codww2/thermite/ndy_gpf_thermite_burn.wav"}, 
})

sound.Add(
{
    name = "TFA_CODWW2_THERMITE.Fizzle",
    channel = CHAN_WEAPON,
    volume = 1,
    soundlevel = 75,
    sound = {"weapons/tfa_codww2/thermite/ndy_gpf_thermite_fizzle.wav"}, 
})

-- satchel charge ------------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_CODWW2_CHARGE.Land", {"weapons/tfa_codww2/satchel_charge/wpn_tnt_drop.wav"})
TFA.AddWeaponSound("TFA_CODWW2_CHARGE.Plunge", {"weapons/tfa_codww2/satchel_charge/wpn_tnt_detonator.wav"})

-- healthkit ------------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_CODWW2_HEALTHKIT.Use", {"weapons/tfa_codww2/healthkit/foley_health_pack_use_01.wav", "weapons/tfa_codww2/healthkit/foley_health_pack_use_02.wav"})
TFA.AddWeaponSound("TFA_CODWW2_PICKUP.Healthkit", {"weapons/tfa_codww2/healthkit/foley_health_pack_stealth_pickup_01.wav", "weapons/tfa_codww2/healthkit/foley_health_pack_stealth_pickup_02.wav", "weapons/tfa_codww2/healthkit/foley_health_pack_stealth_pickup_03.wav"})
TFA.AddWeaponSound("TFA_CODWW2_HEALTHKIT.Bandage", {"weapons/tfa_codww2/healthkit/foley_health_pack_bandage_01.wav", "weapons/tfa_codww2/healthkit/foley_health_pack_bandage_02.wav"})

-- search and destroy bomb ------------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_CODWW2_SNDBOMB.Arm", {"weapons/tfa_codww2/sndbomb/snd_bomb_arm.wav"})
TFA.AddWeaponSound("TFA_CODWW2_SNDBOMB.Wheels", {"weapons/tfa_codww2/sndbomb/snd_bomb_arm_wheels_01.wav", "weapons/tfa_codww2/sndbomb/snd_bomb_arm_wheels_02.wav", "weapons/tfa_codww2/sndbomb/snd_bomb_arm_wheels_03.wav", "weapons/tfa_codww2/sndbomb/snd_bomb_arm_wheels_04.wav"})
TFA.AddWeaponSound("TFA_CODWW2_SNDBOMB.Armed", {"weapons/tfa_codww2/sndbomb/snd_bomb_armed.wav"})
TFA.AddWeaponSound("TFA_CODWW2_SNDBOMB.Drop", {"weapons/tfa_codww2/sndbomb/snd_bomb_drop.wav"})
TFA.AddWeaponSound("TFA_CODWW2_SNDBOMB.Putaway", {"weapons/tfa_codww2/sndbomb/snd_bomb_interrupt_putaway.wav"})
TFA.AddWeaponSound("TFA_CODWW2_SNDBOMB.Pickup", {"weapons/tfa_codww2/sndbomb/snd_bomb_pickup.wav"})
