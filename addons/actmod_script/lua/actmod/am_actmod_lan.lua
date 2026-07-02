aR = aR or {}
aR.Lang = aR.Lang or {["en"] = {},["zh-CN"] = {},["ru"] = {},["de"] = {},["tr"] = {}}
aR.ALang = aR.ALang or "en"

local function addLang(La,Txt,Txl)
	aR.Lang[ La ][ Txt ] = Txl
end

local alang = {["l_en"] = "en" ,["l_ch"] = "zh-CN" ,["l_ru"] = "ru" ,["l_de"] = "de" ,["l_tr"] = "tr"}

local function AA_addlang( ata )
	local files, directories = file.Find( "actmod/lang/*", "LUA" )
	for k, afile in pairs(files) do
		if string.Right(afile,4) == ".lua" and file.Exists( "actmod/lang/".. afile, "LUA") then
			for k1, v1 in pairs(alang) do
				if string.Left(afile,4) == k1 then
					if ata then
						local aaTAB = {}
						local GDfile = include("actmod/lang/".. afile)
						if GDfile and istable(GDfile) then
							for k2, v2 in pairs(GDfile) do
								addLang(v1,k2,v2)
							end
						end
					else
						A_AM.ActMod:Chfg("actmod/lang/".. afile,nil,true)
					end
					break
				end
			end
		end
	end
end
if SERVER then AA_addlang() end

if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.LuaLan = true


AA_addlang(true)



if CLIENT then

	function aR:R_T(lnow,Cr)
		if Cr then
			if !ConVarExists("actmod_cl_lang") then
				CreateClientConVar("actmod_cl_lang", lnow , true, true)
			else
				LocalPlayer():ConCommand("actmod_cl_lang ".. lnow .."\n")
			end
		end

		if lnow == "zh-CN" then
			aR.ALang = lnow
		elseif lnow == "ru" then
			aR.ALang = lnow
		elseif lnow == "de" then
			aR.ALang = lnow
		elseif lnow == "tr" then
			aR.ALang = lnow
		else
			aR.ALang = "en"
		end
	end

	if !ConVarExists("actmod_cl_lang") then
		aR:R_T( GetConVarString( "gmod_language" ) )
	elseif ConVarExists("actmod_cl_lang") then
		aR:R_T( GetConVarString( "actmod_cl_lang" ) )
	end
	cvars.AddChangeCallback( "actmod_cl_lang", function( _, _, newLang ) aR:R_T( newLang ) end )

end

function aR:T(at1,sLang)
	return aR.Lang[sLang or aR.ALang][at1] or at1
end





A_AM.ActMod.tNamsAct = {
	["Fortnite"] = {
		["acrobatic_superhero"] = "Ground Pound"
		,["aerobicchamp"] = "Work It Out"
		,["afrohouse"] = "Bombastic"
		,["armup"] = "Backstroke"
		,["autumntea"] = "Blinding Lights"
		,["aloha"] = "It's a Vibe"
		,["bandofthefort"] = "Best Mates"
		,["bbd"] = "Billy Bounce"
		,["bendi"] = "Zany"
		,["behere"] = "Get Gone"
		,["blowkiss"] = "Kiss Kiss"
		,["boogie_down"] = "Boogie Down"
		,["break_dance"] = "Breakin'"
		,["break_dance_v2"] = "Breakneck"
		,["bring_it_on"] = "Bring It"
		,["bythefire"] = "Hey Now!"
		,["bythefire_leader"] = "Hey Now!"
		,["bythefire_follower"] = "Hey Now!"
		,["cactustpose"] = "Prickly Pose"
		,["calculated"] = "Calculated"
		,["celebration"] = "Jubilation"
		,["chicken"] = "Chicken"
		,["chicken_moves"] = "Cluck Strut"
		,["chug"] = "Go! Go! Go!"
		,["chopstick"] = "Distracted"
		,["conga"] = "Conga"
		,["cool_robot"] = "Overdrive"
		,["cowbell"] = "Llama Bell"
		,["cowboydance"] = "Knee Slapper"
		,["crab_dance"] = "Crabby"
		,["crackshot"] = "Crackdown"
		,["crazyfeet"] = "Crazy Feet"
		,["cross_legs"] = "Criss Cross"
		,["dance_disco_t3"] = "Disco Fever"
		,["dance_off"] = "Dance Off"
		,["dance_shoot"] = "Hype"
		,["dance_swipeit"] = "Swipe It"
		,["dancing_girl"] = "Vivacious"
		,["disagree"] = "Denied"
		,["dj_drop"] = "Drop The Bass"
		,["doublesnap"] = "Revel"
		,["dreamfeet"] = "Dream Feet"
		,["dustoffshoulder"] = "Brush Your Shoulders"
		,["easternbloc"] = "Squat Kick" 
		,["capoeira"] = "Capoeira"
		,["eerie"] = "I Ain't Afraid"
		,["eerie_walk"] = "I Ain't Afraid"
		,["electroshuffle2"] = "Signature Shuffle"
		,["electroswing"] = "Electro Swing"
		,["epic_sax_guy"] = "Phone It In"
		,["facepalm"] = "Face Palm"
		,["fancyfeet"] = "Fancy Feet"
		,["fistpump"] = "Fist Pump"
		,["flamenco"] = "Flamenco"
		,["flex"] = "Gun Show"
		,["flippnsexy"] = "Flippin' Sexy"
		,["floppy_dance"] = "Fandangle"
		,["flossdance"] = "Floss"
		,["fresh"] = "Fresh"
		,["fonzie_pistol"] = "Finger Guns"
		,["funk_time"] = "Get Funky"
		,["gabby_hiphop"] = "Laid Back Shuffle"
		,["glowstickdance"] = "Glowsticks"
		,["golfclap"] = "Slow Clap"
		,["guitar_walk"] = "Guitar Walk"
		,["groovejam"] = "Groove Jam"
		,["happyskipping"] = "Tra La La"
		,["headbanger"] = "Headbanger"
		,["head_bounce"] = "Bobbin'"
		,["heelclick"] = "Click!"
		,["hilowave"] = "Daydream"
		,["hip_hop_s7"] = "Free Flow"
		,["hiphop_01"] = "Freestylin'"
		,["hiptobesquare"] = "Business Hips"
		,["hillbilly_shuffle"] = "Hootenanny"
		,["hooked"] = "On the Hook"
		,["hotstuff"] = "Hot Stuff"
		,["hula"] = "Hula"
		,["i_break_you"] = "Breaking Point"
		,["idontknow"] = "IDK"
		,["indiadance"] = "Lavish"
		,["infinidab"] = "Infinite Dab"
		,["irishjig"] = "Step it Up"
		,["jammin"] = "Clean Groove"
		,["jaywalk"] = "Jaywalking"
		,["jazz_dance"] = "Slick"
		,["jiggle"] = "Jiggle Jiggle"
		,["jumpingjoy_walk"] = "I Like To Move It"
		,["jumpingjoy_static"] = "I Like To Move It"
		,["kitty_cat"] = "Cat Flip"
		,["koreaneagle"] = "Eagle"
		,["kpop_02"] = "Smooth Moves"
		,["livinglarge"] = "Living Lare"
		,["limabean"] = "Distraction Dance"
		,["dance_distraction"] = "Distraction Dance"
		,["littleegg"] = "The Pollo Dance"
		,["look_at_this"] = "Behold!"
		,["loser_dance"] = "Take The L"
		,["luchador"] = "Flippin' Incredible"
		,["lyrical"] = "Wu-tang Is Forever"
		,["make_it_rain_v2"] = "Make It Rain"
		,["makeitrainv2"] = "Raining Doubloons"
		,["marat"] = "Hot Marat"
		,["mello"] = "Marsh Walk"
		,["mime"] = "Mime Time"
		,["mask_off"] = "Orange Justice"
		,["needtopee"] = "It's Go Time!"
		,["nevergonna"] = "Never Gonna"
		,["octopus"] = "Slitherin'"
		,["ohana"] = "U Can't C Me"
		,["og_runningman"] = "Old School"
		,["poplock"] = "Pop Lock"
		,["pump_dance"] = "Pumpernickel"
		,["prance"] = "Jump Around"
		,["rememberme"] = "Forget Me Not"
		,["realm"] = "Imperial March"
		,["robotdance"] = "The Robot"
		,["rocket_rodeo"] = "Rocket Rodeo"
		,["rock_guitar"] = "Rock Out"
		,["running"] = "Running Man"
		,["runningv3"] = "Pick It Up"
		,["salute"] = "Salute"
		,["security_guard"] = "Work It"
		,["shaolin"] = "Shaolin Sit-Up"
		,["showstopper_dance"] = "Showstooper"
		,["sneaky"] = "Very Sneaky"
		,["snap"] = "Snap"
		,["somethingstinks"] = "Something Stinks"
		,["sprinkler"] = "Sprinkler"
		,["spectacleweb"] = "Spider-Man Jump"
		,["smooth_ride"] = "Tidy"
		,["sleek"] = "Freedom Wheels"
		,["statuepose"] = "Statuesque"
		,["swim_dance"] = "Deep End"
		,["taichi"] = "Tai Chi"
		,["tally"] = "Steady"
		,["technozombie"] = "Reanimated"
		,["take_the_w"] = "Savor the W"
		,["thequicksweeper"] = "Jamboree"
		,["the_alien"] = "Extraterrestrial"
		,["thighslapper"] = "Slap Happy"
		,["timeout"] = "Time Out"
		,["touchdown_dance"] = "Spike It"
		,["tonal"] = "Dance Monkey"
		,["tpose"] = "T-Pose"
		,["treadmilldance"] = "Strider"
		,["trex"] = "Rawr"
		,["twist"] = "Twist"
		,["twistdaytona"] = "Rollie"
		,["twisteternity"] = "Last Forever"
		,["twisteternity_ayo"] = "Last Forever"
		,["twisteternity_teo"] = "Last Forever"
		,["wave_dance"] = "Flux"
		,["wackyinflatable"] = "Breezy"
		,["windmillfloss"] = "Windmill Floss"
		,["yayexcited"] = "Yay!"
		,["youre_awesome"] = "You're Awesome"
		,["zest"] = "Maximum Bounce"
		,["zombiewalk"] = "Zombified"
		,["zippy_dance"] = "Rambunctious"
		,["accolades"] = "Accolades"
		,["cerealbox"] = "Flake Shake"
		,["griddle"] = "Get Griddy"
		,["griddle_walk"] = "Get Griddy"
		,["hotpink"] = "Say So"
		,["sunburstdance"] = "The Dance LAROI"
		,["cyclone_headbang"] = "Head Banger"
		,["cyclone"] = "Rage"
		,["walkywalk"] = "Feelin' Jaunty"
		,["walkywalk_walk"] = "Feelin' Jaunty"
		,["julybooks"] = "Out West"
		,["twistwasp"] = "My World"
		,["stringdance"] = "Party Hips"
		,["gasstation"] = "Pull Up"
		,["grooving"] = "Vibin'"
		,["grooving2"] = "Vibrant Vibin'"
		,["devotion"] = "Without You"
		,["chew"] = "Tootsee"
		,["comrade"] = "Rushin' Around"
		,["heavyroardance"] = "Real Slim Shady"
		,["indigoapple"] = "Poki"
		,["zebrascramble"] = "Surfin' Bird"
		,["cottontail"] = "Celebrate Me"
		,["dreadful"] = "Ask Me"
		,["headset"] = "Sypher's Strut"
		,["promenadefollow"] = "Bust a Move"
		,["promenadelead"] = "Bust a Move"
		,["shimmy"] = "Starlit"
		,["speeddial"] = "Popular Vibe"
		,["tourbus"] = "Ninja Style"
		,["adoration"] = "Cupid's Arrow"
		,["jumpstyledance"] = "Springy"
		,["januarybop"] = "Jabba Switchway"
		,["ruckus"] = "The Rick Dance"
		,["sandwichbop"] = "Go Mufasa"
		,["sandwichbop_walk"] = "Go Mufasa"
		,["voidredemption"] = "I'm a Mystery"
		,["vivid"] = "In Da Party"
		,["vivid_walk"] = "In Da Party"
		,["handsup"] = "Planetary Vibe"
		,["twohype"] = "Dirtbike Challenge"
		,["twohype_walk"] = "Dirtbike Challenge"
		,["lilsplit"] = "Do the 'Split"
		,["malleable"] = "Wind Up"
		,["malleable_walk"] = "Wind Up"
		,["abstractmirror"] = "Found you!"
		,["chairtime"] = "Have A Seat"
		,["hoist"] = "Jump Rope Jig"
		,["kpop_dance03"] = "SCENARIO"
		,["snowknight"] = "Flashback Breakdown"
		,["bluephoto"] = "Build Up"
		,["breakfastcoffeedance"] = "Primo Moves"
		,["coping"] = "Copines"
		,["epicsaxguy"] = "Phone It In"
		,["sashimi"] = "KOI DANCE"
		,["marionette1"] = "MASTER OF PUPPETS"
		,["noodles"] = "Chicken Wing It"
		,["pastasauce"] = "Rain Check"
		,["goodbyeupbeat"] = "Jubi Slide"
		,["goodbyeupbeat_walk"] = "Jubi Slide"
		,["sitandspin"] = "Whirlwind"
		,["gothdance"] = "Infectious"
		,["gwaradance"] = "BOLD STANCE"
		,["undead"] = "Evil Plan"
		,["poutyclap"] = "Sad Claps"
		,["papayacommsclap"] = "Clap"
		,["sunlit"] = "Lunar Party"
		,["troops"] = "It's A Trick!"
		,["patpat_intro"] = "Bear Hug"
		,["chilled"] = "Drippin' Flavor"
		,["alien"] = "Extraterrestrial"
		,["iconic"] = "Ma-Ya-Hi"
		,["ringer"] = "back on 74"
		,["ringer_walk"] = "back on 74"
		,["chickenleg"] = "Snare Solo"
		,["snowfall"] = "Board Flair"
		,["selenecobra"] = "MOONLIT MYSTERY"
		,["reign"] = "You're A Winner"
		,["whisk"] = "Classy"
		,["metronome"] = "To The Beat"
		,["justhome"] = "The Renegade"
		,["darling"] = "Boo'd Up Groove"
		,["triumphant"] = "Triumphant"
		,["boomer"] = "Bim Bam Boom"
		,["clamor"] = "Shout!"
		,["hurrah"] = "Hooray"
		,["tollbridge"] = "Company Jig"
		,["bewilder"] = "Point And Strut"
		,["wheresmatt"] = "Where Is Matt?"
		,["wheresmatt_walk"] = "Where Is Matt?"
		,["reverie"] = "Groove Destroyer"
		,["reverie_mirror"] = "Groove Destroyer"
		,["montecarlo"] = "Freemix"
		,["shiverflame"] = "Brite Moves"
		,["canine"] = "Shimmy Wiggle"
		,["dignified"] = "What You Want"
		,["cadaver"] = "Boney Bounce"
		,["intermission"] = "AFK"
		,["harmony_1"] = "Feel It"
		,["rumblefemale"] = "Sakura's Victory Sway"
		,["plasticfork"] = "Nitro Fueled"
		,["plasticfork_walk"] = "Nitro Fueled"
		,["thrive"] = "Serve Stance"
		,["farewell"] = "Bye Bye Bye"
		,["downward"] = "Stuck"
		,["elegantlilycharm"] = "Cairo"
		,["elegantlily"] = "Oki Doki"
		,["nimble"] = "The Quick Style"
		,["vacant"] = "I'm Out"
		,["blazerveil"] = "Crack It"
		,["sillyjumps"] = "Leapin'"
		,["sillyjumps_walk"] = "Leapin'"
		,["dimension"] = "Dimensional"
		,["playereleven"] = "Introducing"
		,["coyotetrail_lead"] = "Warm-Up"
		,["enrapture"] = "Take it Slow"
		,["kelplinen"] = "Lucid Dreams"
		,["mesmerize"] = "Entranced"
		,["jadetowel"] = "Miku Live"
		,["jadetowel_gloss"] = "Miku Miku Beam"
		,["crisscross"] = "Criss Cross"
		,["resonant"] = "Interstellar Bass"
		,["resonant_walk"] = "Interstellar Bass"
		,["lemoncart_walk"] = "Snoop's Walk"
		,["lemoncart_static"] = "Snoop's Walk"
		,["agentsherbert"] = "Count It!"
		,["studs"] = "APT."
		,["sneaky"] = "Very Sneaky"
		,["sneaky_walk"] = "Very Sneaky"
		,["congaline"] = "Conga"
		,["congaline_walk"] = "Conga"
		,["hip_hop"] = "Breakdown"
		,["cry"] = "Waterworks"
		,["ridethepony"] = "Ride the Pony"
		,["ridethepony_walk"] = "Ride the Pony"
		,["dancemoves"] = "Dance Moves"
		,["dancemoves2"] = "Dance Moves"
		,["thumbsup"] = "Thumbs Up"
		,["thumbsdown"] = "Thumbs Down"
		,["kpopdance_04"] = "Glitter"
		,["maskoff"] = "Orange Justice"
		,["mind_blown"] = "Mind Blown"
		,["electroshuffle"] = "Electro Shuffle"
		,["charleston"] = "Flapper"
		,["nottoday"] = "Finger Wag"
		,["stagebow"] = "Gentleman's Dab"
		,["confused"] = "Confused"
		,["lookatthis"] = "Behold!"
		,["cheerleader"] = "Cheer Up"
		,["laugh"] = "Laugh It Up"
		,["myeffort"] = "Leilt Elomr"
	}

	,["MMD"] = {
		["helltaker"] = "Helltaker"
		,["dance_nostalogic"] = "Nostalogic"
		,["dance_gokurakujodo"] = "Gokuraku Jodo"
		,["dance_specialist"] = "Specialist"
		,["theatrical_airline_luk"] = "TricoloreAirline 2020 luk" ,["theatrical_airline_mik"] = "TricoloreAirline 2020 mik" ,["theatrical_airline_rin"] = "TricoloreAirline 2020 rin"
		,["dance_caramelldansen"] = "Caramell Dansen"
		,["dance_daisukeevolution"] = "Daisuke Evolution"
		,["whistle"] = "Whistle"
		,["badbadwater"] = "Bad Bad Water"
		,["king_kanaria"] = "King Kanaria"
		,["sadcatdance"] = "sad cat dance"
		,["dance_tuni-kun"] = "Dance Tuni-Kun"
		,["fiery_sarilang"] = "Fiery Sarilang"
		,["followtheleader"] = "Follow The Leader"
		,["getdown"] = "GetDown"
		,["goodbyedeclaration"] = "GoodBye Declaration"
		,["ponponpon"] = "Pon Pon Pon"
		,["s007"] = "Requiem"
		,["s017"] = "KiLLER LADY"
		,["phao2phuthon_p1"] = "2 Phut Hon"
		,["aoagoodluck"] = "AOA - Good Luck"
		,["blablabla"] = "Bla Bla Bla"
		,["chikichiki"] = "Chiki Chiki Bang Bang"
		,["ghostdance"] = "Ghost Dance"
		,["calisthenics"] = "Calisthenics"
		,["girls"] = "Girls"
		,["hiasobi"] = "HIASOBI"
		,["hiproll"] = "Hip Roll"
		,["mrsaxobeat"] = "Mr. Saxobeat"
		,["nyaarigato"] = "Nya Arigato"
		,["pv120_shi_p1"] = "PV120 - Shake it" ,["pv120_shi_p2"] = "PV120 - Shake it" ,["pv120_shi_p3"] = "PV120 - Shake it"
		,["s001"] = "Forever Like This"
		,["s002"] = "It's Raining"
		,["s003"] = "Raid of Glass"
		,["s004"] = "Rosetta"
		,["s005"] = "Love Will Surely Soar"
		,["s006"] = "Life Reset Button"
		,["s008"] = "The Color of the Next Blossom"
		,["s009"] = "The Trumpet Playing Boy"
		,["s010"] = "Kappas are Boiling Slugs"
		,["s011"] = "VERSUS"
		,["s012"] = "Ten Faced"
		,["s013"] = "I Want to Meet You"
		,["s014"] = "Sky Colored Eyes"
		,["s015"] = "Carnival"
		,["bad_apple_l"] = "Bad Apple"
		,["bad_apple_r"] = "Bad Apple"
		,["gfriendrough"] = "GFRIEND - Rough"
		,["massdestruction"] = "Mass Destruction"
		,["mememe"] = "ME!ME!ME!"
		,["senbonzakura"] = "Senbonzakura"
		,["supermjopping"] = "SuperM - Jopping"
		,["roki_p1"] = "ROKI"
		,["roki_p2"] = "ROKI"
		,["nahoha"] = "HIGHER - Nahoha"
		,["lmfao"] = "LMFAO-Party Rock Anthem"
		,["conqueror"] = "Conqueror - IA"
		,["ch4nge"] = "CH4NGE"
		,["yoidore"] = "Yoidore Sirazu"
		,["dokuhebi"] = "Dokuhebi"
		,["darling"] = "Darling"
		,["dancin"] = "Dancin"
		,["adeepmentality"] = "A Deep Mentality"
		,["gimmexgimme"] = "Gimme×Gimme"
		,["yaosobi-idol"] = "YOASOB - idol"
		,["kwlink"] = "Togen Renka"
		,["adj_1"] = "Loveriver"
		,["kemuthree"] = "Subject three"
		,["imfgood"] = "I’m Feeling Good"
		,["drunkendutterfly"] = "Drunken butterfly"
		,["bibbib"] = "BIBBIBDIBA"
		,["peachbsmile"] = "Peach blossom smile"
		,["bananasong"] = "Banana Song Minions Dubstep"
		,["littleapple"] = "Little Apple"
		,["shiknok"] = "Shiknok"
		,["dancehall_1"] = "Heart Pie Dancehall"
		,["dancehall_2"] = "Heart Pie Dancehall"
		,["zhangshiyao"] = "Qinghai Shake"
		,["pokedance"] = "POKÉDANCE"
		,["beyondtheway_1"] = "Beyond the way"
		,["beyondtheway_2"] = "Beyond the way"
		,["beyondtheway_3"] = "Beyond the way"
		,["beyondtheway_4"] = "Beyond the way"
		,["beyondtheway_5"] = "Beyond the way"
	}

	,["AM4"] = {
		["california_girls"] = "California Girls"
		,["gangnamstyle"] = "Gangnamstyle"
		,["macarena"] = "Dance Macarena"
		,["quagmire"] = "Quagmire"
		,["drip_01"] = "Drip"
		,["levepalestina"] = "Leve Palestina"
		,["drliveseywalk_1"] = "Dr.livesey Phonk W_1"
		,["drliveseywalk_2"] = "Dr.livesey Phonk W_2"
		,["drliveseywalk_3"] = "Dr.livesey Phonk W_3"
		,["runpanicked"] = "Run Panicked"
		,["pitbull_a"] = "International Love"
		,["pitbull_m"] = "International Love"
		,["pitbull_loop"] = "International Love"
		,["poegypt"] = "Prince of Egypt"
		,["spooky_month_dance"] = "Dance Spooky month"
		,["epicsaxguy"] = "Epic Sax guy"
		,["sambadancingfull"] = "Toothless Dancing"
	}
	
	,["Mixamo"] = {
		["situps_01"] = "Situps 01"
		,["pose_maledance_01"] = "Pose Male Dance 01"
		,["pose_femaledance_01"] = "Pose Female Dance 01"
		,["dancing_01"] = "Dancing 01"
		,["dancing_02"] = "Dancing 02"
		,["swingdancing_01"] = "Swing Dancing 01"
		,["swingdancing_02"] = "Swing Dancing 02"
		,["swingdancing_03"] = "Swing Dancing 03"
		,["sambadancing"] = "Samba Dancing"
		,["norsoulspcombo"] = "Northern Soul Spin Combo"
		,["hokeypokey"] = "Hokey Pokey"
	}

	,["PUBG"] = {
		["seetinh"] = "SeeTinh"
		,["2phuthon"] = "2PhutHon"
		,["bboombboom"] = "BBoomBBoom"
		,["victorydance60"] = "VictoryDance60"
		,["victorydance99"] = "VictoryDance99"
		,["victorydance102"] = "VictoryDance102"
		,["victorydance118"] = "VictoryDance118"
		,["samsara"] = "Samsara"
		,["tocatoca"] = "TocaToca"
		,["rollnrock"] = "Roll 'n Rock"
		,["poppy"] = "Poppy"
	}
}

A_AM.ActMod.tmpE = A_AM.ActMod.tmpE or {
	["amod_dance_california_girls"] = {"amod_am4_california_girls","California Girls"}
	,["amod_dance_gangnamstyle"] = {"amod_am4_gangnamstyle","Gangnam Style"}
	,["amod_dance_macarena"] = {"amod_am4_macarena","Dance Macarena"}
	,["amod_drip_01"] = {"amod_am4_drip_01","Drip"}
	,["amod_taunt_quagmire"] = {"amod_am4_quagmire","Quagmire"}
	,["gmod_g_wave"] = {"wave","Wave"}
	,["gmod_g_bow"] = {"bow","Bow"}
	,["gmod_g_agree"] = {"agree","Yes / Agree"}
	,["gmod_g_becon"] = {"becon","Come here"}
	,["gmod_g_disagree"] = {"disagree","No / Disagree"}
	,["gmod_g_salute"] = {"salute","Salute"}
	,["gmod_g_signal_forward"] = {"signal_forward","Signal Forward"}
	,["gmod_g_signal_group"] = {"signal_group","Signal Group"}
	,["gmod_g_signal_halt"] = {"signal_halt","Signal Halt"}
	,["gmod_g_item_drop"] = {"item_drop","Item Drop"}
	,["gmod_g_item_give"] = {"item_give","Item Give"}
	,["gmod_g_item_place"] = {"item_place","Item Place"}
	,["gmod_g_item_throw"] = {"item_throw","Item Throw"}
}

function A_AM.ActMod:ReNameAct(at1)
	if isstring(at1) then
		local aE = A_AM.ActMod.tmpE[string.lower(at1)]
		if aE then return aE[2] end
	end
	local isGetTbl = A_AM.ActMod.tNamsAct[ A_AM.ActMod:TrgmaNams( at1 ) ]
	if istable(isGetTbl) then
		isGetTbl = isGetTbl[ A_AM.ActMod:RvString( at1 ) ]
		if isstring(isGetTbl) then
			return isGetTbl
		end
	end
	if istable(A_AM.ActMod.GTabActO) and A_AM.ActMod.GTabActO[at1] and A_AM.ActMod.GTabActO[at1].GetName then
		return A_AM.ActMod.GTabActO[at1].GetName
	end
	return isstring(at1) and A_AM.ActMod:RvString( at1 ) or ""
end

A_AM.ActMod.LuaLan_Done = true
