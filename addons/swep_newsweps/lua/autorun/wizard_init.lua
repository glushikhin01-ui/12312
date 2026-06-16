--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

--howdy! thanks for rooting around in my mod! 
--this file handles initializations for custom resources, sounds, particles, ammo, and killicons
-- -splet

AddCSLuaFile()

if SERVER then
	--make sure we all have the mod lol
	//resource.AddWorkshop("3046835259")
end

--lightning caller custom sounds
util.PrecacheSound("caller/wizardry_thunder.wav")
util.PrecacheSound("caller/wizardry_thunderimpact.wav")

--wizard pistol custom sounds
--these pistol sounds are from the hl2 episodes
util.PrecacheSound("wizpistol/alyx_gun_fire3.wav")
util.PrecacheSound("wizpistol/alyx_gun_fire4.wav")

--wizard movement suite custom sounds
--these HEV suit impact sounds are sourced from Black Mesa and are used in the wizard movement suite
--https://store.steampowered.com/app/362890/Black_Mesa/
--game's good. give it a shot!
util.PrecacheSound("movementsuite/hevimpact1.wav")
util.PrecacheSound("movementsuite/hevimpact2.wav")
util.PrecacheSound("movementsuite/hevimpact3.wav")
util.PrecacheSound("movementsuite/hevimpact4.wav")
util.PrecacheSound("movementsuite/hevimpact5.wav")
util.PrecacheSound("movementsuite/hevimpact6.wav")
util.PrecacheSound("movementsuite/hevimpact7.wav")
util.PrecacheSound("movementsuite/hevimpact8.wav")
util.PrecacheSound("movementsuite/hevimpact9.wav")
util.PrecacheSound("movementsuite/hevimpact10.wav")

--initalize all particles
game.AddParticles( "particles/wizard_particles.pcf" )
--brick blast
PrecacheParticleSystem("brick_tracer")
--wizard guns
PrecacheParticleSystem("wizard_shotgun_pellet")
PrecacheParticleSystem("wizard_blt")
PrecacheParticleSystem("wizard_blt_homing")
--dying neutron star
PrecacheParticleSystem("neutron_star")
PrecacheParticleSystem("star_explosion")
PrecacheParticleSystem("star_explosion_pulsar")
--bloodhounds
PrecacheParticleSystem("bloodhounds_launch")
PrecacheParticleSystem("bloodhounds_seeker")
PrecacheParticleSystem("bloodhounds_impact")
--dissolve fx
PrecacheParticleSystem("neutron_dissolution_dust")
PrecacheParticleSystem("lightning_dissolution_dust")
--wizard movement suite hit fx
PrecacheParticleSystem("wiz_suite_hit")

--ammo factory
game.AddAmmoType( 
	{
		name = "Wizardry_Mana",
		--maybe make mana damage
		dmgtype = DMG_SONIC,	--sonic damage to sidestep wizard resistance w/o weird fx. spells that deal raw mana damage do this
		--always override tracer, damage
		force = 10,
		maxsplash = 1,
		minsplash = 0,
		maxcarry = 100,
	}
)
if CLIENT then 
	language.Add("Wizardry_Mana", "Mana")
end

--killicon assignment conveyor belt
if CLIENT then
	killicon.Add( "wiz_brick_blast", "hud/killicons/wiz_brick_kic.vtf", Color( 255, 255, 255, 255 ))
	killicon.Add( "wiz_brick", "hud/killicons/wiz_brick_kic.vtf", Color( 255, 255, 255, 255 ))
	killicon.Add( "wiz_lightning_caller", "hud/killicons/wiz_caller_kic.vtf", Color( 255, 255, 255, 255 ))
	killicon.Add( "wiz_wizard_shotgun", "hud/killicons/wiz_shotgun_kic.vtf", Color( 255, 255, 255, 255 ))
	killicon.Add( "wiz_wizard_pistol", "hud/killicons/wiz_pistol_kic.vtf", Color( 255, 255, 255, 255 ))
	killicon.Add( "wiz_dying_neutron_star", "hud/killicons/wiz_neutron_kic.vtf", Color( 255, 255, 255, 255 ))
	killicon.Add( "wiz_neutronshard", "hud/killicons/wiz_neutron_kic.vtf", Color( 255, 255, 255, 255 ))
	killicon.Add( "wiz_bloodhound_missile", "hud/killicons/wiz_bloodhound_kic.vtf", Color( 255, 255, 255, 255 ))
end

--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
