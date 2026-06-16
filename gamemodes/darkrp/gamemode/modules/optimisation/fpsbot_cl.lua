--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

hook.Add( "ChatText", "hideshit", function( index, name, text, typ )
    if ( typ == "joinleave" or typ == "namechange" ) then return true end
end )

local opt = {
	["gmod_mcore_test"] = {"1"},
	["datacachesize"] = {"512"},
	-- ["net_graphshowlatency"] = {"1"},
	-- ["net_graphsolid"] = {"1"},
	-- ["net_graphtext"] = {"1"},
	["r_fastzreject"] = {"-1"},
	["cl_ejectbrass"] = {"1"},
	["Muzzleflash_light"] = {"0"},
	["cl_wpn_sway_interp"] = {"0"},
	["in_usekeyboardsampletime"] = {"0"},
	["rope_wind_dist"] = {"0"},
	["cl_playerspraydisable"] = {"1"},
	["mat_disable_fancy_blending"] = {"0"},
	["r_decals"] = {"70"},
	["rope_shake"] = {"0"},
	-- ["net_graphheight"] = {"60"},
	-- ["net_graphmsecs"] = {"400"},
	["r_dynamic"] = {"1"},
	["r_decal_cullsize"] = {"0"},
	["cl_smooth"] = {"0"},
	["studio_queue_mode"] = {"1"},
	["cl_show_splashes"] = {"0"},
	-- ["net_graphproportionalfont"] = {"0"},
	-- ["net_graphshowinterp"] = {"1"},
	["r_shadows"] = {"1"},
	["mp_decals"] = {"50"},
	["mat_forceaniso"] = {"1"},
	["cl_phys_props_enable"] = {"0"},
	["mat_disable_bloom"] = {"1"},
	["props_break_max_pieces"] = {"0"},
	["violence_agibs"] = {"0"},
	["violence_hgibs"] = {"0"},
	["cl_threaded_client_leaf_system"] = {"1"},
	["r_threaded_client_shadow_manager"] = {"1"},
	["r_threaded_particles"] = {"1"},
	["r_threaded_renderables"] = {"1"},
	["r_queued_ropes"] = {"1"},
	["joystick"] = {"0"},
	["violence_ablood"] = {"1"},
	["violence_hblood"] = {"1"},
	["r_lod"] = {"-1"},
	["cl_threaded_bone_setup"] = {"1"},
	["rope_smooth"] = {"0"},
	["cl_detaildist"] = {"400"},
	["r_3dsky"] = {"0"},
	["mat_hdr_enabled"] = {"0"},
	["mat_hdr_level"] = {"1"},
	["mat_disable_lightwarp"] = {"1"},
	["r_drawmodeldecals"] = {"1"},
	["r_teeth"] = {"0"},
	-- ["fov_desired"] = {"90"},
	["mat_queue_mode"] = {"2"},
	["cl_forcepreload"] = {"1"},
	["voice_recordtofile"] = {"0"},
	["cl_detail_avoid_radius"] = {"30"},
	["net_compressvoice"] = {"1"},
	["r_maxmodeldecal"] = {"50"},
	["r_eyemove"] = {"0"},
	["snd_mix_async"] = {"1"},
	["r_drawflecks"] = {"0"},
	["demo_avellimit"] = {"0"},
	["r_worldlights"] = {"1"}
}

concommand.Add('FPS_BOOST',function()
	for k, v in pairs(opt) do
		RunConsoleCommand(k,v[1])
    end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
