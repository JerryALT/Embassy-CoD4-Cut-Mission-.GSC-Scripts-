/****************************************************************************
Level: 		Immediate Action (SAS Hostage Rescue)
Campaign: 	SAS
****************************************************************************/

#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");

main()
{
	setExpFog(200, 13000, 209/255, 216/255, 222/255, 0);
	
 	//globals
 	level.maxfriendlies = 6;
	level.friendlywave_thread = ::putOnChain;
	level.followmax = 2;
	level.followmin = -1;
 	level.stopwatch = .5;											//Default time to complete objective, in minutes
	level.missionFailedQuote = &"EMBASSY_MISSION_FAILED_GENERIC";	//Generic failure message
	level.usetimer = true;	
	
	//script_origin used for all helicopter animations
	level.heliNode = getent("helicopter_origin_main", "targetname");
	level.passengers = 0;

	//Skip to vars
	//setdvar("debug_mode","1");
	//setdvar("start","");
	//setdvar("start","southoffices");
	//setdvar("start","northoffices");
	//setdvar("start","conferencehall");
	//setdvar("start","mezzanine");
	//setdvar("start","reception");
	//setdvar("start","libhall");
	//setdvar("start","end");
			
	level.debug_mode = false;		
	if ( getdvar("debug_mode") == "1" )
		level.debug_mode = true;
	
	setupPrecache();
	maps\embassy_fx::main();
	maps\_blackhawk::main("vehicle_blackhawk");
	maps\_load::main();
	maps\embassy_anim::main();
	level thread maps\embassy_amb::main();
	setupPlayer();
	setupCharacters();
	hideAll();
	level_think();
	
 	level thread debugMethod1();
 	level thread debugMethod2();
 	
 	//Open any doors that should be initially open
 	level thread open_all_doors_in_level();
 	
 	level thread battlechatter_off("allies");
	level thread battlechatter_off("axis");
	
 	//flags: objectives
 	flag_init("obj_insert_complete");
 	//flag_init("obj_window_breach_complete");
 	flag_init("obj_hostage_secure_office_1_complete");
 	flag_init("obj_nav_office_north_complete");
 	flag_init("obj_hostage_secure_office_2_complete");
  	flag_init("obj_hostage_secure_banquet_complete");
 	//flag_init("obj_banquet_hall_regroup_complete");
 	flag_init("obj_bravo_rv_complete");
 	flag_init("obj_reception_clear_complete");
 	flag_init("obj_skylight_breach_complete");
 	flag_init("obj_courtyard_cover_complete");
 	flag_init("obj_library_breach_complete");	
 	flag_init("obj_sniper_assault_complete");
 	flag_init("obj_final_boss_complete");
 	
 	//flags: navigation
 	
 	//Rooftop insertion
 	flag_init("rooftop_ai_is_ready");
 	flag_init("team_ready_to_rappel_to_roof");
 	flag_init("heli_fastrope_in_progress");
 	flag_init("helicopter_has_been_hit");
 	flag_init("player_landed_on_rooftop");
 	flag_init("rappel_point_reached");
 	flag_init("jack_has_reached_rappel_point");	
 	flag_init("gaz_has_reached_rappel_point");	
 	flag_init("jack_is_on_balcony");
 	flag_init("gaz_is_on_balcony");
 	flag_init("player_has_started_balcony_absail");
 	flag_init("window_frame_charges_placed");
 	flag_init("all_teams_start_initial_breach"); 	
 	flag_init("embassy_breached");
 	//South offices
 	flag_init("officeA_cleared");
 	flag_init("officeB1_breached");
 	flag_init("officeB1_cleared");
 	flag_init("human_shield_office_c_dead");
 	flag_init("officeD_breached");
 	flag_init("officeD_cleared");
  	flag_init("south_office_exit_reached");
  	flag_init("player_has_looked_at_south_office_door");
 	flag_init("player_has_looked_at_trig_lookat_hostage_evac_facadehall");
 	//North offices
 	flag_init("player_approaching_north_offices");
 	flag_init("player_has_looked_at_trig_lookat_sniper_sequence");
 	flag_init("officeF_breached");
 	flag_init("officeF_cleared");
 	flag_init("officeG_door_open");
 	flag_init("obj_balcony_flank_given");
 	flag_init("officeG_reached");
 	flag_init("office_H_cleared");
 	flag_init("flanking_balcony_office_reached");
 	flag_init("flanking_balcony_reached");
	flag_init("player_is_approaching_conf_hall_door");	
	flag_init("conf_hall_door_is_open");
	//Banquet hall	
	flag_init("nav_banquet_hall_complete");	
 	flag_init("banquet_reception_cleared");
 	flag_init("banquet_doors_barricaded");
 	flag_init("banquet_wall_first_explosive_planted");
 	flag_init("banquet_wall_second_explosive_planted");
 	flag_init("kitchen_door_breached");
 	//Drawing room and Reception
 	flag_init("stairwell_reached");
 	flag_init("drawaing_room_exit_breached");
 	flag_init("skylight_access_door_reached");
 	flag_init("skylight_rooftop_reached");
 	flag_init("all_guys_ready_to_rappel_at_skylight");	
 	flag_init("skylight_breach_command_given");
 	flag_init("courtyard_cover_navigate_complete");
 	flag_init("all_guys_ready_at_elevator");
 	flag_init("elevator_ready_to_be_pried_open");
 	flag_init("elevator_shaft_reached");
 	flag_init("elevator_rooftop_reached");
 	//Library
 	flag_init("library_foyer_reached");
	flag_init("player_approaching_foyer_sidedoor");
	flag_init("player_approaching_foyer_frontdoor");
 	flag_init("library_foyer_cleared");
 	flag_init("library_breach_objective_given");
 	flag_init("library_breached");
 	flag_init("library_final_humanshield_spawned");
 	flag_init("player_on_library_floor");
 	//Sniper
 	flag_init("jack_ready_by_roof_access");
 	flag_init("player_has_sniper_rifle");
 	flag_init("stairwell_ladder_reached");
 	flag_init("vent_entrance_reached");
 	flag_init("sniper_position_reached");
 	flag_init("sniper_order_given");
 	flag_init ("player_killed_correct_sniper");
 		  	
 	//flags: other
 	flag_init("timer_expired");
 	  
 	//skip to a point in the level
 	skipToString = getdvar("start");
 	if ( (skipToString == "start") || (skipToString == "") )
 	{
 		AA_level_start_init();
 	}
 	else
 	{
 		level thread skipWarp(skipToString); 		
 	}
 		 
}

/****************************************************/
/**************** LEVEL START (ROOFTOP) FUNCTIONS****/
/****************************************************/
AA_level_start_init()
{
	level thread maps\_introscreen::introscreen_delay(&"EMBASSY_TITLE", &"EMBASSY_INFO", &"EMBASSY_PLACE", &"EMBASSY_DATE", 2, 2, 1);
	
	//level thread ambient_rooftop_negotiator_conversation();
	level thread rooftop_character_setup();
	level thread body_dump();	
	level thread helicopter_ride();	
	level thread heli_rappel();
	level thread fastrope_heli_think();
	//level thread rooftop_hostile();
	level thread trigger_roof_reach();
	level thread trigger_balcony_1();
	level thread trigger_balcony_2();
	level thread trigger_balcony_3();
	level thread balcony_rappel_gaz();
	level thread balcony_rappel_jack();
	level thread trigger_use_fastrope_roof_think();
	level thread group_absail_sequence();
	level thread setup_enemies_office_a();
}

rooftop_character_setup()
{
	//setup chopper guys
	level.aIntro_chopper_dudes = level spawnGroup(getEntArray("friendlies_heli_intro", "targetname"));
	level.pilot = getDudeFromArray(level.aIntro_chopper_dudes, "heli_intro_pilot");
	level.pilot.animname = "pilot";
	level.copilot = getDudeFromArray(level.aIntro_chopper_dudes, "heli_intro_copilot");
	level.copilot.animname = "copilot";
		
	level.gammaSquad = getentarray("gammaSquad", "targetname");
	level.zetaSquad = getentarray("zetaSquad", "targetname"); 
	
	//add other chopper dudes to other rappelling squads
	aGammaDudes = getDudesFromArray(level.aIntro_chopper_dudes, "gammaSquad");
	aZetaDudes = getDudesFromArray(level.aIntro_chopper_dudes, "zetaSquad");
	for(i=0;i<aGammaDudes.size;i++)
		level.gammaSquad = array_add(level.gammaSquad, aGammaDudes[i]);
	for(i=0;i<aZetaDudes.size;i++)
		level.zetaSquad = array_add(level.zetaSquad, aZetaDudes[i]);	
	
	array_thread(level.gammaSquad, ::invulnerable,true);
	array_thread(level.zetaSquad, ::invulnerable,true);

	flag_set("rooftop_ai_is_ready");
}




body_dump()
{
	wait(1.5);
	//sierra
	//"Body is being..they are dumping the body out of the front window."
	level thread dialogue_radio_thread ("embassy_sierra_bodybeingdumped");	
	
	wait(2.5);

	//crowd
	//"<sound of crowd screaming and sobbing>"
	level thread dialogue_radio_thread ("embassy_crowd_screams");	
	
	wait(1);
	//jack
	//"Bloody christ, they've killed a hostage"
	level.jack thread queue_anim("embassy_jack_theykilledahostage");	

	wait(2);
	//cmd
	//"Roger, Sierra One. Hold your fire. We have clearance to execute IA. All call signs, I have control. Commence your run in."
	dialogue_radio_thread("embassy_cmd_clearencetoexecute");	
				
	//gaz
	//"Right, that's in then. Stand to, lads. We?ll be assaulting the middle floor."
	//level.gaz dialogue_thread("embassy_gaz_herewegolads");	
	
	wait(1);
	//gaz
	//Alpha One going dark. 2 seconds.	
	level.gaz thread queue_anim("embassy_gaz_goingdark");	
	
	//wait(1);
	//gaz
	//"Andy, you're going to be first man into every room. Take the flashbangs. You'll be the one making noise."
	//level.gaz thread dialogue_thread ("embassy_gaz_helibreachinstruct1");	

	//sierra
	//"I may have visual on X Ray One."
	//dialogue_radio_thread ("embassy_sierra_visualofxrayone");	
	
	//sierra
	//"Confirmed. That was X Ray One at the window. Male...approximately 6?2...fifteen stone..."
	//dialogue_radio_thread("embassy_sierra_thatwasxray1");		
}

helicopter_ride()
{
	flag_wait("rooftop_ai_is_ready");
	
	//setup helicopter
	eHeli_intro = blackhawk_spawn("heli_intro_start");
	//eHeli_intro = getent("heli_intro", "targetname");
	
	eHeli_intro useAnimTree(#animtree);
	eHeli_intro.animname = "blackhawk";			
	vStartingPosition = getstartorigin( level.heliNode.origin, level.heliNode.angles, level.scr_anim["blackhawk"]["heli_intro_start"]);
	aStartingAngles = getstartangles( level.heliNode.origin, level.heliNode.angles, level.scr_anim["blackhawk"]["heli_intro_start"]);
	eHeli_intro.origin = vStartingPosition;
	eHeli_intro.angles = aStartingAngles;
	
	
	level.heliNode thread anim_loop_solo (eHeli_intro, "heli_intro_start_loop", undefined, "stop_idle");
	
	//put player in chopper
	
	//vPlayerSeat = eHeli_intro getTagOrigin("tag_guy7");
	//vPlayerAngles = eHeli_intro getTagAngles("tag_guy7");
	//level.player setorigin(vPlayerSeat);
	//level.player setplayerangles(vPlayerAngles);
//	level.player playerlinktodelta( <linkto entity>, <tag>, <viewpercentag fraction>, <right arc>, <left arc>, <top arc>, <bottom arc> )
	level.player playerlinktodelta(eHeli_intro, "tag_guy7", 1, 55, 55, 5, 28);
	wait .1;
	level.player setplayerangles((30, 45, 0));	
	//level.player setorigin(level.player.origin + (0,0,100));


	level thread playerWeaponTempRemove();	
	level.player allowLean(false);
	level.player allowStand(false);
	
	//put guys on tags
	level.gaz thread putDudeOnHeliTag(eHeli_intro, "tag_detach");
	level.jack thread putDudeOnHeliTag(eHeli_intro, "tag_detach");
	for(i=0;i<level.aIntro_chopper_dudes.size;i++)
		level.aIntro_chopper_dudes[i] thread putDudeOnHeliTag(eHeli_intro, "tag_detach");
		
	
	wait(4);	
	
	//helicopter move in
	level.heliNode notify ("stop_idle");	
	level.heliNode thread anim_single_solo (eHeli_intro, "heli_intro_start");
	
	//wait till heli reaches roof, then hover	
	eHeli_intro waittillmatch("single anim", "end");
	
	flag_set("team_ready_to_rappel_to_roof");
	
	level.heliNode thread anim_loop_solo (eHeli_intro, "heli_intro_idle", undefined, "stop_idle");
	
	flag_wait("player_landed_on_rooftop");
	
	level.heliNode notify ("stop_idle");
	level.heliNode anim_single_solo (eHeli_intro, "heli_intro_end");

	eHeli_intro delete();
}

putDudeOnHeliTag(eHeli, sTagName)
{

	org = eHeli getTagOrigin(sTagName);
	angles = eHeli getTagangles(sTagName);
	self teleport( org, angles );
	self linkto(eHeli, sTagName, (0,0,0), (0,0,0));
	
	//give different animname if it's the pilot or copilot
	if (!isdefined(self.animname))
	{
		level.passengers ++;
		self.animname = "passenger" + level.passengers;	
	}
		
	eHeli thread anim_loop_solo(self, "heli_seat_idle", sTagName, "stop_idle");
	
	self waittill ("rappelling");
	
	eHeli notify ("stop_idle");
	
}	

heli_rappel()
{
	flag_wait("team_ready_to_rappel_to_roof");
	//gaz
	//"Command. This is Alpha One at the insertion point."
	//level.gaz dialogue_thread("embassy_gaz_atinsertionpoint");
	
	autosave_by_name ("heli ride complete");
	
	//cmd
	//All call signs standby. Standby...Go! Go! Go!"	
	dialogue_radio_thread("embassy_cmd_insertiongo");

	level thread obj_insert();
	
	//gaz
	//"Go! Get those ropes out!"
	//level.gaz thread dialogue_thread("embassy_gaz_getropesout");
	
	level notify ("team_ready_to_rappel_from_heli");
	
	flag_set("heli_fastrope_in_progress");	
}

fastrope_heli_think()
{
	level waittill ("team_ready_to_rappel_from_heli");
	
	//squad rappels
	level.aIntro_chopper_dudes = array_add(level.aIntro_chopper_dudes, level.gaz);
	level.aIntro_chopper_dudes = array_add(level.aIntro_chopper_dudes, level.jack);

	for(i=0;i<level.aIntro_chopper_dudes.size;i++)
		level.aIntro_chopper_dudes[i] thread heli_rappel_think();

	wait(1.4);
		
	//show fastrope and USE trigger
	trigger_use_fastrope = getent("trigger_use_fastrope", "targetname");
	trigger_use_fastrope show();
	trigger_use_fastrope trigger_on();
	trigger_use_fastrope setHintString( &"EMBASSY_HINTSTR_FASTROPE");
	
	//wait until hits "use" key
	trigger_use_fastrope waittill("trigger");
	trigger_use_fastrope trigger_off();
	
	level.player unlink();		
	eWarp = getent("origin_fastrope_start", "targetname");
	level.player setorigin (eWarp.origin);
	level.player setplayerangles (eWarp.angles);
	level.player linkto(eWarp);
	
	wait(.5);
	
	fMoveTime = 3.8;
	eEndRappelPoint = getent("origin_fastrope_end", "targetname");
	eWarp moveto( eEndRappelPoint.origin, fMoveTime, .5, .5 );
	wait (fMoveTime);
	
	level.player unlink();
	level.player notify ("restore_player_weapons");
	level.player allowLean(true);
	level.player allowStand(true);	
	
}

heli_rappel_think()
{
	self endon ("death");
	
	wait(randomfloatrange(.5,4.5));
	
	if (!isdefined (self))
		return;
		
	if(!isalive(self))
		return;	
	
	//stop looping idle anim and fastrope in
	self unlink();
	self notify  ("rappelling");
	
	self set_animname ("guy");	
	//self thread anim_loop_solo(self, "fastrope_loop", undefined, "stop_idle");

	//wait(3);

	//self notify ("stop_idle");
	
	//self anim_single_solo (self, "fastrope_land");	 
	self anim_single_solo (self, "fastrope_full");	 
	
	
	
	self reset_animname();	
}

ambient_rooftop_negotiator_conversation()
{
	flag_wait("helicopter_has_been_hit");
	
	wait(3);
	
	//cmd
	//"All call signs, keep it quiet until insertion is complete."	
	dialogue_radio_thread("embassy_cmd_keepitquiet");

	//neg
	//"We don?t want a bloodbath here, Salim, so let?s...let?s just talk about"	
	dialogue_radio_thread("embassy_neg_nobloodbath");	

	//mbg
	//"What is that sound? <foreign language telling other terrorist to go investigate>"	
	dialogue_radio_thread("embassy_mbg_whatisthatsound");	

	//neg
	//"Now...Salim...tell me exactly what you need...we do not want any more hostages to be harmed"
	dialogue_radio_thread("embassy_neg_tellmewhatyouneed");	

	//mbg
	//"There is...we hear sound coming from the roof..."	
	dialogue_radio_thread("embassy_mbg_soundsonroof");	

	//neg
	//"Salim...there is nothing on the rooftop. Salim...(off microphone) blast, we?ve lost radio contact"	
	dialogue_radio_thread("embassy_neg_nosoundsonroof");	
}


trigger_roof_reach()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trigger_roof_reach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	
	//gaz
	//"Let's move. They're getting our ropes setup at the last balcony."
	level.gaz thread queue_anim("embassy_gaz_gettoropes");
	
	//Force gaz and jack to fastrope area near balcony
	flag_set("player_landed_on_rooftop");
		
	wait(3);
	
	//cmd
	//"This is command. Alpha One, your LOE is balcony three-three."
	dialogue_radio_thread("embassy_cmd_locationofentry");	
	
}

balcony_rappel_gaz()
{
	flag_wait("player_landed_on_rooftop");
	
	// Have guy go to rappel point and wait
	level.gaz goToNode("nodes_squad_roof_gaz");

	level.gaz waittill ("goal");
	flag_set ("gaz_has_reached_rappel_point");	
	
	// Wait till player starts rappeling, then have friendly go down
	flag_wait("player_has_started_balcony_absail");

	
	level.gaz thread rappel_balcony("origin_rappel_balcony_3a");
	
	//gaz
	//"Remember, weapons hold until my signal. No firing until we've breached the building."
	level.gaz thread queue_anim("embassy_gaz_weaponsholdtillbreach");	
	flag_set("gaz_is_on_balcony");
}

balcony_rappel_jack()
{
	flag_wait("player_landed_on_rooftop");
	
	// Have guy go to rappel point and wait
	level.jack goToNode("nodes_squad_roof_jack");

	level.jack waittill ("goal");
	flag_set ("jack_has_reached_rappel_point");	
	
	// Wait till player starts rappeling, then have friendly go down
	flag_wait("player_has_started_balcony_absail");
	
	wait(.5);
	level.jack thread rappel_balcony("origin_rappel_balcony_3b");
	
	level.jack waittill ("balcony_rappel_finished");
	flag_set("jack_is_on_balcony");
}

trigger_balcony_1()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trigger_balcony_1", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//play a random line of reminder dialogue
	
	//frnd
	//"You're with Gaz's team, you're at the last set of ropes to the south."	
	guy = get_closest_ally();
	if (isdefined(guy))
		guy thread queue_anim("embassy_frnd_gettoropes1");	
}

trigger_balcony_2()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trigger_balcony_2", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//play a random line of reminder dialogue
	
	//frnd
	//"Get back with your team. Last set of ropes to the south. Get into position, mate, the clock's ticking!"
	guy = get_closest_ally();
	if (isdefined(guy))
		guy thread queue_anim("embassy_frnd_gettoropes2");	
}

trigger_balcony_3()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trigger_balcony_3", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	flag_set("rappel_point_reached");
	
	//jack
	//"Grab the rope, Andy. We'll absail down to the balcony below."	
	level.jack thread queue_anim("embassy_jack_grabtherope1");	
		
	// Remind the player to grab the rope if he hasn't gone yet
	wait(8);	
	
	//jack
	//"Get on the bloody rope Andy, we haven't much time."
	if (!flag("player_has_started_balcony_absail"))
		level.jack thread queue_anim("embassy_jack_grabtherope2");		
}


setup_enemies_office_a()
{
	flag_wait("rappel_point_reached");
	//spawn hostiles in office A
	level.spawned_hostiles_office_a = level spawnGroup(getEntArray("hostiles_office_a", "targetname"));
	array_thread(level.spawned_hostiles_office_a, ::setCQBbehavior, true);	
	
	level.spawned_hostages_office_a = level spawnGroup(getEntArray("hostages_office_a", "targetname"));
		
	//Have everyone ignore eachother
	ignoreEverybody(true);
}


trigger_use_fastrope_roof_think()
{
	trigger_use_fastrope_roof = getEnt( "trigger_use_fastrope_roof", "targetname" ); 
	trigger_use_fastrope_roof show();
	trigger_use_fastrope_roof trigger_on();
	trigger_use_fastrope_roof setHintString( &"EMBASSY_HINTSTR_FASTROPE");

	//wait until hits "use" key
	trigger_use_fastrope_roof waittill("trigger");
	trigger_use_fastrope_roof trigger_off();
	
	flag_set("player_has_started_balcony_absail");	
	
	//Take player weapons away
	level thread playerWeaponTempRemove();
	
	eWarp = getent("origin_rappel_balcony_start", "targetname");
	level.player setorigin (eWarp.origin);
	level.player setplayerangles (eWarp.angles);
	level.player linkto(eWarp);
	
	wait(.5);
	
	fMoveTime = 1.8;
	eEndRappelPoint = getent("origin_rappel_balcony_end", "targetname");
	eWarp moveto( eEndRappelPoint.origin, fMoveTime, .5, .5 );
	wait (fMoveTime);
	
	level.player unlink();
	level.player notify ("restore_player_weapons");

}

group_absail_sequence()
{
	flag_wait("player_has_started_balcony_absail");
	
	level thread AA_southOffices_init();
	
	//Make 3 guys from Gamma and 3 guys from Zeta rappel
	level thread group_rappel(level.gammasquad, "origin_rappel_balcony_1_");
	level thread group_rappel(level.zetasquad, "origin_rappel_balcony_2_");
}

group_rappel(aArrayOfDudes, sPrefixOfOrigin)
{
	// loop through 3 times
	for(i=0;i<3;i++)
	{
		//find the origin they will be rappeling from
		sRappelOrigin = sPrefixOfOrigin + i;
				
		wait (randomfloatrange(.25,1.5));
		
		assertEx(isdefined(aArrayOfDudes[i]), "Rappeling guy doesn't exist.");
		
		aArrayOfDudes[i] thread rappel_balcony(sRappelOrigin);
		
	}
}


/****************************************************/
/**************** SOUTH OFFICES FUNCTIONS**************/
/****************************************************/
AA_southOffices_init()
{
	level thread trig_enter_balcony();
	level thread frnd_plants_explosives();
	level thread gaz_takes_cover();
	level thread all_teams_breach_embassy();
	level thread officeA_fight_start();
	level thread trig_enter_officeA();
	level thread trig_exit_officeA();
	level thread trig_enter_officeB1();
	level thread trig_enter_officeB2();
	level thread trig_officeC_approach();
	level thread trig_office_south_exit_approach();	
	level thread proceed_to_north_offices();	
}

trig_enter_balcony()
{
	
	//wait for trigger, then disable it
	trigger = getEnt( "trig_enter_balcony", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//level.gaz dialogue_thread("embassy_gaz_framechargewindow");	
	
	//level thread obj_window_breach();
	
	flag_wait("window_frame_charges_placed");
		
	dialogue_radio_thread("embassy_cmd_executeia");	
	
	//gaz
	//"Blow it!"
	level.gaz queue_anim("embassy_gaz_blowwindow");	
	
	
	//level thread window_breach_think();	
	//blow the window and update objectives
	level thread window_breach_explosion();
	//flag_set ("obj_window_breach_complete");
	
	flag_set("obj_insert_complete");
	autosave_by_name ("insertion complete");
	wait(1);
	
	flag_set("all_teams_start_initial_breach");
	
	//delete all guys left behind on roof
	level thread npcDelete("volume_rooftop_offices_south", "all");	
	
	wait(1);
	
	level thread obj_hostage_secure_office_1();	
}

gaz_takes_cover()
{
	flag_wait("gaz_is_on_balcony");
	//Gaz goes to other nodes away from window
	
	level.gaz thread goToNode("balcony_cover_1");
}
frnd_plants_explosives()
{
	level endon ("embassy_breached");
	
	flag_wait("jack_is_on_balcony");
	
	eOrg = getent("origin_windowbreach_officeA_2", "targetname");
	level.jack thread set_explosives(eOrg, undefined, false, 1);
	level.jack waittill ("explosives_set");
	
//	eOrg = getent("origin_windowbreach_officeA_1", "targetname");
//	level.jack thread set_explosives(eOrg, undefined, false, 1);
//	level.jack waittill ("explosives_set");	
			
	level.jack thread goToNode("balcony_cover_2");
	
	flag_set("window_frame_charges_placed");
	
	//warn player to get the hell away from windows
	iprintlnbold (&"EMBASSY_EXPLOSIVES_PLANTED");
//	eTrig_expl_danger_balcony = getent("trig_expl_danger_balcony", "targetname");
//	while (true)
//	{
//		wait(0.05);
//		if ( level.player isTouching(eTrig_expl_danger_balcony) )
//		{
//			
//		}	
//		else
//			iprintlnbold ("");
//	}	
}


all_teams_breach_embassy()
{
	flag_wait("all_teams_start_initial_breach");
	
	//Just have dudes enter, then delete them, will respawn later
	
	level thread blow_window("officeC");
	
	array_thread(level.zetasquad, ::goToNodeAndDelete, "node_volume_officeC");
	wait(1);
	level thread blow_window("officeD");	
	array_thread(level.gammasquad, ::goToNodeAndDelete, "node_volume_officeD");
	
}

blow_window(sRoomName)
{
	aWindowExploder = getentarray("exploder_window_" + sRoomName, "targetname");	
	assert(isdefined(aWindowExploder));
	iExploderNumber = aWindowExploder[0].script_exploder;
	
	maps\_utility::exploder(iExploderNumber);	
	aWindowExploder[0] thread play_sound_in_space("rocket_explode_default");		
}

//window_breach_think()
//{
//	//setup hint trigger 	
//	trig_use_window_breach = getent("trig_use_window_breach", "targetname");
//	trig_use_window_breach trigger_on();
//	trig_use_window_breach setHintString( &"EMBASSY_HINTSTR_DETONATE");
//	trig_use_window_breach usetriggerrequirelookat();
//
//	//wait until hits "use" key
//	trig_use_window_breach waittill("trigger");
//	trig_use_window_breach trigger_off();
//
//	//blow the window and update objectives
//	level thread window_breach_explosion();
//	flag_set ("obj_window_breach_complete");
//
//}

window_breach_explosion()
{
	//spawn and kill a couple dudes by the windows
	//level spawnGroup(getEntArray("hostiles_office_a_dead", "targetname"));
	level thread blow_window("officeA");
	earthquake (0.6, 2, level.player.origin, 1000);
	level notify ("embassy_breached");
	flag_set ("embassy_breached");
}

trig_enter_officeA()
{
	//wait for trigger, then disable it
	trigger = getEnt("trig_enter_officeA", "targetname"); trigger waittill ( "trigger" ); trigger trigger_off();
	
}

officeA_fight_start()
{

	flag_wait ("embassy_breached");
	//flag_wait ("obj_window_breach_complete");
	
	//remove clip brush to allow entry by mantle
	blockerEnable(getent("blocker_balcony_entry", "targetname"), 0);
	
	//Gaz
	//Weapons free!
	level.gaz thread queue_anim("embassy_gaz_weaponsfree");	
	
	ignoreEverybody(false);
	
	//Have enemies get surprised
	aHostiles = getAIarrayTouchingVolume("axis", "volume_officeA");
	array_thread( aHostiles, ::enemy_surprised );

	
	//wait till all hostiles dead
	waittill_aigroupcleared("hostiles_office_a");
	level.gaz thread queue_anim("embassy_gaz_allclearmoveon3");
	
	flag_set("officeA_cleared");

	//kill all the friendlies in office C & D...just to make sure
	level thread npcDelete("volume_officeC", "allies");
	level thread npcDelete("volume_officeD", "allies");	
	
	//spawn a guy in the hallway and have him chill
	level.friendly_window_southoffices01_buddy = level spawnDude(getEnt("friendly_window_southoffices01_buddy", "script_noteworthy"));

	//Hostiles in next office
	spawned_hostiles_office_b = level spawnGroup(getEntArray("hostiles_office_b", "targetname"));
	hostages_office_b = level spawnGroup(getEntArray("hostages_office_b", "targetname"));
	array_thread(spawned_hostiles_office_b, ::setCQBbehavior, true);
	
	//open door to hallway
	level.gaz thread door_NPC_open("door_officeA", 1, 2);
	level.jack thread goToNode("node_door_officeA");
	
	level.gaz waittill("door_kicked");
	level.jack thread goToNode("friendlychain_exterior_officeB1");

	//frnd
	//"Let's move it along gentlemen. Take this office back here."
	level.friendly_window_southoffices01_buddy.animname = "guy";
	level.friendly_window_southoffices01_buddy thread queue_anim("embassy_frnd_letsmoveoffices");
	
	level.gaz waittill ("door_has_been_opened");	
	

	
	level.jack notify ("goal");	
	//Setup breach of the next room
	aFriendlies = [];
	aFriendlies[0] = level.gaz;
	aFriendlies[1] = level.jack;
	

		
	level thread breach_room("officeB1", aFriendlies, 0);
}

trig_exit_officeA()
{
	//wait for trigger, then disable it
	trigger = getEnt("trig_exit_officeA", "targetname"); trigger waittill ( "trigger" ); trigger trigger_off();

	//Guy crashes through window
	friendly_window_southoffices01 = spawnDude(getEnt("friendly_window_southoffices01", "script_noteworthy"));
	friendly_window_southoffices01 thread window_rappel_smash("window_southoffices01");	
	
	friendly_window_southoffices01 waittill ("window_rappel_finished");
	
	//have the two guys go into office A to evac the hostages
	aFriendlies = [];
	aFriendlies[0] = level.friendly_window_southoffices01_buddy;
	aFriendlies[1] = friendly_window_southoffices01;
	level thread hostage_evac("officeA", aFriendlies);
}


officeB1_fight()	//Called from the global breach function
{	
	//wait for all hostiles dead
	waittill_aigroupcleared("hostiles_office_b");	
	
	level.gaz thread queue_anim("embassy_gaz_allclearmoveon1");
	
	flag_set("officeB1_cleared");
}

trig_enter_officeB1()
{
	//wait for trigger, then disable it
	trigger = getEnt("trig_enter_officeB1", "targetname"); trigger waittill ( "trigger" ); trigger trigger_off();
}

trig_enter_officeB2()
{
	//wait for trigger, then disable it
	trigger = getEnt("trig_enter_officeB2", "targetname"); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//spawn dude in hallway who will eventually block the way past the human shield
	level.eFriendly_soutoffices_blocker = spawnDude(getent("friendly_soutoffices_blocker", "targetname"));
	level.eFriendly_soutoffices_blocker invulnerable(true);
	level.eFriendly_soutoffices_blocker thread NPC_Blocker("node_blocker_southoffices_1");	
		
	//Office C: Dead friendlies and hostiles
	level spawnGroup(getEntArray("hostiles_office_c", "targetname"));
	level spawnGroup(getEntArray("friendlies_office_c", "targetname"));	

}



trig_officeC_approach()
{
	flag_wait ("officeB1_cleared");	
	
	//wait for trigger, then disable it
	trigger = getEnt( "trig_officeC_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();


	//Office C: Human shield pair
	level thread human_shield_spawn("humanshield_southoffices_1");

	wait(0.05);
	eDoor = getent("door_officeC", "targetname");
	eDoor thread door_open(1);
	
	level waittill("human_shield_terrorist_dead");	
	
	//guy leaves blocker and guys setup for next breach
	level.eFriendly_soutoffices_blocker notify ("stop_blocking");
	
	aFriendlies = [];
	aFriendlies[0] = level.gaz;
	aFriendlies[1] = level.jack;
		
	level thread breach_room("officeD", aFriendlies, 0);	


	//spawn guys in next room
	//Office D: Dead friendlies, hostages and hostiles
	spawned_friendlies_office_d = level spawnGroup(getEntArray("friendlies_office_d", "targetname"));
	aHostages_office_d = level spawnGroup(getEntArray("hostages_office_d", "targetname"));
	spawned_hostiles_office_d = level spawnGroup(getEntArray("hostiles_office_d", "targetname"));
	array_thread(spawned_hostiles_office_d, ::setCQBbehavior, true);			
	
	//Friendly comes out of doorway to tell player to carry on		
	//eDoorGuyOfficeC = getDudeFromArray(level.spawned_friendlies_office_c, "office_c_door_guy");
	//assert(isdefined(eDoorGuyOfficeC));
	//eDoorGuyOfficeC thread door_NPC_open("door_officeC", 2, 2);
	
	//eDoorGuyOfficeC waittill ("door_has_been_opened");
	
	// Make guy block door and execute line of dialogue
	//eDoorGuyOfficeC.animname = "guy";
	
	//eDoorGuyOfficeC holdPosition(true);
	//eDoorGuyOfficeC thread queue_anim("embassy_frnd_teamisdown");	
	//eDoorGuyOfficeC holdPosition(false);
	
}

officeD_fight()	//Called from the global breach function
{	
	
	//wait for all hostiles dead
	waittill_aigroupcleared("hostiles_office_d");
	level.jack thread queue_anim("embassy_gaz_allclearmoveon3");
	
	flag_set("officeD_cleared");		
}


proceed_to_north_offices()	
{
	flag_wait("officeD_cleared");
	
	flag_set ("obj_hostage_secure_office_1_complete");
	
	
	
	//Have everyone ignore eachother
	ignoreEverybody(true);	
	
	
	//Color nodes
	triggerActivate("trig_colornodes_southhall");	



	//Gaz
	//"Command, this is Alpha One. South offices secure."	
	level.gaz queue_anim("embassy_gaz_southofficesecure");
	
	//Cmd
	//Roger that, Alpha One. RV with teams in North offices. Additional reinforcements inserting at your position.
	level thread dialogue_radio_thread("embassy_cmd_proceedtonorth");
	
	autosave_by_name ("south offices complete");
	
	AA_northOffices_init();
}

trig_lookat_southofficedoor()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_lookat_southofficedoor", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("player_has_looked_at_south_office_door");
}

trig_office_south_exit_approach()
{
	flag_wait("officeD_cleared");
		
	//wait for trigger, then disable it
	trigger = getEnt( "trig_office_south_exit_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	
	//Wait for player to look at door
	level thread trig_lookat_southofficedoor();
	flag_wait("player_has_looked_at_south_office_door");
	
	//spawn hostiles coming through door
	hostiles_south_office_exit = level spawnGroup(getEntArray("hostiles_south_office_exit", "targetname"));	
	eHostage_south_office_exit_door = level spawnDude(getEnt("hostage_south_office_exit_door", "targetname"));

	//make hostile go to lounge then retreat
	doorHostile = hostiles_south_office_exit[0];
	doorHostile thread sprayKitchen();

	
	tempDoorHide(getent("door_office_south_exit", "targetname"));
	
	//hostage
	//"Don't shoot!"
	eHostage_south_office_exit_door thread queue_anim("embassy_hos_dontshoot");

	


	wait(1.5);
	
	//frnd
	//"Hostile! Take him out!"
	eGuy = get_closest_ally();
	if (isdefined(eGuy))
		eGuy thread queue_anim("embassy_frnd_takehimout");
	
	waittill_aigroupcleared("hostiles_south_office_exit");
	
	//force squad to next positions asap
	level.gaz thread forceToNode("squad_north_offices_start_1");
	level.jack thread forceToNode("squad_north_offices_start_2");
}

sprayKitchen()
{
	self endon ("death");
	self.animname = "guy";
	self.ignoreme = true;
	self.ignoresuppression = true;

	self animscripts\shared::putGunInHand ("none");


	eNode = getnode("node_office_south_exit_lounge", "targetname");
	//anim_single_solo (guy, anime, tag, node, tag_entity)
	self anim_reach_solo (self, "terrorist_fakeout", undefined, eNode);
	self anim_single_solo (self, "terrorist_fakeout", undefined, eNode);
	
	level thread teamIgnoreMe("allies", false);
	self stopanimscripted();
	self animscripts\shared::putGunInHand ("right");
	
	wait(1.5);
	
	self.ignoreme = false;
}


/****************************************************/
/**************** NORTH OFFICES FUNCTIONS************/
/****************************************************/
AA_northOffices_init()
{
	level thread obj_nav_office_north();
	level thread trig_south_office_exit_door();
	level thread trig_facadehall_enter();
	level thread trig_lookat_hostage_evac_facadehall();
	level thread trig_facadehall_approach();
	level thread trig_office_north_setup();
	level thread trig_north_office_approach();
	level thread trig_office_north_reached();
	level thread trig_sniper_sequence();
	level thread sniper_door_sequence();
	level thread trig_enter_officeF();
	level thread trig_exit_officeF();
	level thread trig_officeG_approach();
	level thread trig_delete_leftover_ai();
	level thread trig_enter_officeG();
	level thread office_I_breach_and_flank();
	level thread trig_flanking_balcony_approach();
	level thread trig_flanking_balcony_reached();
	level thread office_I_breach();
	level thread trig_conf_door_setup();
	level thread trig_conferenceHall_door_approach();
}


trig_south_office_exit_door()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_south_office_exit_door", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	
	flag_set("south_office_exit_reached");
	
	//spawn hostage evac friendlies in facade hall
	aSpawned_friendlies_hostage_evac_facadehall = level spawnGroup(getEntArray("friendlies_hostage_evac_facadehall", "targetname"));
	aHostages_evac_facadehall  = level spawnGroup(getEntArray("hostages_evac_facadehall", "targetname"));
		
	//wait till player looks at trigger, then have them do their thing
	flag_wait("player_has_looked_at_trig_lookat_hostage_evac_facadehall");
	
	array_thread(aSpawned_friendlies_hostage_evac_facadehall, ::goToNodeAndDelete, "node_delete_facade_hallway_1");
	array_thread(aHostages_evac_facadehall, ::goToNodeAndDelete, "node_delete_facade_hallway_1");	
	
	//frnd
	//"This way people. Let's move."	
	guy = aSpawned_friendlies_hostage_evac_facadehall[0];
	guy.animname = "guy";
	guy thread queue_anim("embassy_frnd_thiswayletsmove");
		
}

trig_facadehall_approach()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_facadehall_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	

	friendly_window_facadetransition01 = spawnDude(getEnt("friendly_window_facadetransition01", "script_noteworthy"));
	node = getnode(friendly_window_facadetransition01.target, "targetname");
	friendly_window_facadetransition01 thread window_rappel_smash("window_facadetran01", node);		
}
trig_lookat_hostage_evac_facadehall()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_lookat_hostage_evac_facadehall", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("player_has_looked_at_trig_lookat_hostage_evac_facadehall");

}

trig_facadehall_enter()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_facadehall_enter", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	

	level thread npcDelete("volume_southoffices", "all");	
	
	//Guys smash through windows
	friendly_window_facadetransition03 = spawnDude(getEnt("friendly_window_facadetransition03", "script_noteworthy"));
	node = getnode(friendly_window_facadetransition03.target, "targetname");
	friendly_window_facadetransition03 thread window_rappel_smash("window_facadetran03", node);		
	wait(.5);
	
	friendly_window_facadetransition02 = spawnDude(getEnt("friendly_window_facadetransition02", "script_noteworthy"));
	node = getnode(friendly_window_facadetransition02.target, "targetname");
	friendly_window_facadetransition02 thread window_rappel_smash("window_facadetran02", node);	

	wait(1);
	
	friendly_window_facadetransition04 = spawnDude(getEnt("friendly_window_facadetransition04", "script_noteworthy"));
	node = getnode(friendly_window_facadetransition04.target, "targetname");
	friendly_window_facadetransition04 thread window_rappel_smash("window_facadetran04", node);	

}

trig_office_north_setup()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_office_north_setup", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();		
	
	//ignoreEverybody(true);
}

trig_north_office_approach()
{
	trigger = getEnt( "trig_north_office_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("player_approaching_north_offices");
}
trig_office_north_reached()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_office_north_reached", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	

	//start scripted ambient sequence across barricades
	//level thread north_offices_ambient_battle();
	
	//Setup breach of the next room
	aFriendlies = [];
	aFriendlies[0] = level.gaz;
	aFriendlies[1] = level.jack;
	
	level.spawned_hostiles_office_f = level spawnGroup(getEntArray("hostiles_office_f", "targetname"));	
	array_thread(level.spawned_hostiles_office_f, ::setCQBbehavior, true);
	aHostages_office_f = level spawnGroup(getEntArray("hostages_office_f", "targetname"));	
	
	//have retreaters hold position for now
	//array_Thread(level.spawned_hostiles_office_f, ::goToVolume, "volume_officeF");
	
	level thread breach_room("officeF", aFriendlies, 0);		
	
	//update objectives
	flag_set ("obj_nav_office_north_complete");
	
	autosave_by_name ("north offices navigation complete");

	wait(2);
	level thread obj_hostage_secure_office_2();
}

trig_sniper_sequence()
{
	trigger = getEnt( "trig_sniper_sequence", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	//sets the flag in case the player still hasn't looked at it
	
	flag_set ("player_has_looked_at_trig_lookat_sniper_sequence");		
}

sniper_door_sequence()
{
		//Setup Friendly
		friendly_sniper_door_sequence = spawnDude(getent("friendly_sniper_door_sequence", "targetname"));
		friendly_sniper_door_sequence.animname= "guy";
		//Setup Terrorist
		hostile_door_sniper = spawnDude(getent("hostile_door_sniper", "targetname")); 
		hostile_door_sniper.animname = "guy";
		hostile_door_sniper invulnerable(true);
		hostile_door_sniper.ignoreme = true;
		hostile_door_sniper setFlashbangImmunity( true );
		//Setup Door
		eDoor = getent("door_officeE", "targetname");
		eAnimEnt = spawn( "script_origin", eDoor.origin);
		eAnimEnt.angles = eDoor.angles;
		//Setup Hostages
		aHostages_office_e = level spawnGroup(getEntArray("hostages_office_e", "targetname"));	
		
		//get terrorist into position to play anim
		
		eAnimEnt thread anim_reach_solo (hostile_door_sniper, "blow_back");
			
		flag_wait ("player_approaching_north_offices");
		
		//sierra 
		//"I have a confirmed X Ray at window three-two."
		level dialogue_radio_thread ("embassy_sierra_taketheshot");
		
		level thread trig_lookat_sniper_sequence();
		flag_wait ("player_has_looked_at_trig_lookat_sniper_sequence");
		
		//cmd "Take the shot, Sierra One."
		level thread dialogue_radio_thread ("embassy_cmd_taketheshot");
				
		wait(.6);
		eDoor playsound ("bullet_impact_headshot");
		eDoor thread door_open(1);
		
		wait(.19);
		//Sniper is blown through door
		eAnimEnt anim_single_solo (hostile_door_sniper, "blow_back");
		
		
		eAnimEnt thread anim_loop_solo(hostile_door_sniper, "blow_back_dead", undefined, "stop_idle");
		wait(1);
		hostile_door_sniper killEntity();		
		
		//Frnd
		//"that?s a confirmed kill, Sierra One."
		friendly_sniper_door_sequence thread queue_anim("embassy_frnd_confirmedkill");
		
		//Friendly and other idiots go into room to evac hostages
		aFriendlies = [];
		aAllFriendlies = getaiarray("allies");
		for(i=0;i<aAllFriendlies.size;i++)			//Create an array of everyone except player squad and delta team
		{
			if (isdefined(aAllFriendlies[i].script_noteworthy) && ((aAllFriendlies[i].script_noteworthy == "delta_squad") || (aAllFriendlies[i].script_noteworthy == "gaz") || (aAllFriendlies[i].script_noteworthy == "jack")))
				continue;
			else
				aFriendlies[aFriendlies.size] = aAllFriendlies[i];
		}
		
		level thread hostage_evac("officeE", aFriendlies);
}

trig_lookat_sniper_sequence()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_lookat_sniper_sequence", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set ("player_has_looked_at_trig_lookat_sniper_sequence");	
}


officeF_fight()		//called from the global breach function once door is breached
{


	//Have some hostiles retreat to hallway behind
	aRetreaters = getDudesFromArray(level.spawned_hostiles_office_f, "officeF_retreaters");
	level thread retreatToNodes(aRetreaters, "nodes_officeF_retreat");
	
	waittill_aigroupcleared("hostiles_office_f");
	
	level.gaz thread queue_anim("embassy_gaz_allclearmoveon3");
	
	flag_set("officeF_cleared");
	
	//have friendlies go to nodes and yell at human shield guy
	level thread human_shield_friendlies("nodes_frnd_humanshield_northoffices_1");

	triggerEnable("trig_officeG_approach", true);
}

trig_enter_officeF()
{
	trigger = getEnt( "trig_enter_officeF", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	

}

trig_exit_officeF()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_exit_officeF", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
}


trig_delete_leftover_ai()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_delete_leftover_ai", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	level thread npcDelete("volume_northoffices_1", "all");	
	
	
}
trig_officeG_approach()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_officeG_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	
	//Office G: Human shield pair
	level thread human_shield_spawn("humanshield_northoffices_1");
	wait(0.05);
	eDoor = getent("door_officeG", "targetname");
	eDoor thread door_open(1);
	
	level waittill("human_shield_terrorist_dead");		
	
	//colornodes
	triggerActivate("trig_colornodes_officeG");
	
	//spawn hostiles across the way	
	level spawnGroup(getEntArray("hostiles_officeH", "targetname"));
	
	waittill_aigroupcleared("hostiles_officeH");
	
	flag_set("office_H_cleared");
	
	//friendlies go setup ex
	
	// dude opens door
//	friendly_officeG_doorguy = spawnDude(getent("friendly_officeG_doorguy", "targetname"));
//	friendly_officeG_doorguy invulnerable(true);
//	friendly_officeG_doorguy.ignoreme = true;
//	friendly_officeG_doorguy.animname = "guy";
//	friendly_officeG_doorguy thread door_NPC_open("door_officeG", 2);

	//Jack
	//Hold your fire!	
	//level.jack thread queue_anim("embassy_jack_holdyourfire");
	
//	friendly_officeG_doorguy waittill ("door_has_been_opened");
//	
//	
//	friendly_officeG_doorguy holdPosition(true);
//	
//	//frnd
//	//Just in time, chaps.
//	friendly_officeG_doorguy queue_anim("embassy_frnd_yourejustintimechaps");
//	
//	//frnd
//	//"We've got a group across the hall pinning us down. I need a man to assist a flanking maneuver from the balcony"
//	friendly_officeG_doorguy queue_anim("embassy_frnd_pinneddown");
//
//	//gaz
//	//"You're up Andy"	
//	level.gaz queue_anim("embassy_gaz_youreup");	


	
	//level thread obj_balcony_flank();
	//flag_set("obj_balcony_flank_given");
	
	//friendly_officeG_doorguy holdPosition(false);
	//friendly_officeG_doorguy thread goToNode("node_officeG_doorcover");
	
	//flag_set("officeG_door_open");
	
	//flag_wait("officeG_reached");

	//frnd
	//"Get moving! We'll cover you while you cross the hallway"	
	//friendly_officeG_doorguy queue_anim("embassy_frnd_coverwhilecrosshall");
	
	//wait(1);
	
	//frnd
	//"Go! Go! Go! Get to the balcony"
	//friendly_officeG_doorguy queue_anim("embassy_frnd_gettothebalcony");		
}

trig_enter_officeG()
{
	//wait for trigger, then disable it
	trigger = getEnt( "trig_enter_officeG", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
}

north_offices_ambient_battle()
{
	flag_wait("officeG_reached");
}

friendlies_go_to_conf_hall_door()
{
	level.gaz thread goToNode("node_conf_hall_door_1");
	level.jack thread goToNode("node_conf_hall_door_2");
}

trig_flanking_balcony_approach()
{
	trigger = getEnt( "trig_flanking_balcony_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	flag_set("flanking_balcony_office_reached");	
	
	flag_wait("office_H_cleared");
	
	//window spawners
	level spawnGroup(getEntArray("friendlies_officeH", "targetname"));
	
}

office_I_breach_and_flank()
{
	flag_wait("office_H_cleared");
	
	level thread obj_balcony_flank();
	
	blockerEnable(getent("blocker_balconyflank_1", "targetname"), 0);
	
	level.gaz thread forceToNode("node_officeI_breach_1");
	level.jack thread set_explosives(getent("origin_northoffice_breach", "targetname"), undefined, true, 0);
	level.jack waittill ("explosives_set");
	level.jack thread forceToNode("node_officeI_breach_2");
}


trig_flanking_balcony_reached()
{
	trigger = getEnt( "trig_flanking_balcony_reached", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	flag_set("flanking_balcony_reached");	
	
	flag_wait("office_H_cleared");

	
}

office_I_breach()
{
	flag_wait("flanking_balcony_reached");	

	//spawn hostiles in office I
	level.hostiles_office_i = level spawnGroup(getEntArray("hostiles_office_i", "targetname"));
	aHostages_office_i = level spawnGroup(getEntArray("hostages_office_i", "targetname"));
	
	ignoreEverybody(false);

	//wait for player to look at wall
	trigger = getEnt( "trig_lookat_office_i_breach", "targetname" ); 
	trigger waittill ( "trigger" ); 
	trigger trigger_off();	
	
	//blow the wall
	maps\_utility::exploder(16);	
	getent("origin_northoffice_breach","targetname") thread play_sound_in_space("rocket_explode_default");
	earthquake (0.6, 2, level.player.origin, 1000);
	
	//blow the door
	eDoor = getent("door_officeI", "targetname");
	eDoor thread door_open(1);	
	
	//damage any guys within the radius
	
	
	
	//colornodes
	triggerActivate("trig_colornodes_office_i");
			
	waittill_aigroupcleared("hostiles_office_i");	

	//update objectives
	flag_set ("obj_hostage_secure_office_2_complete");	

	//have friendlies move to next door and await player
	level thread friendlies_go_to_conf_hall_door();
	
	//gaz
	//"Command, this is Alpha One. North offices have been secured."	
	level.gaz queue_anim("embassy_gaz_northofficessecured");
	
	//cmd
	//"Roger Alpha One. Proceed to the Banquet Hall and secure remaining hostages."	
	dialogue_radio_thread("embassy_cmd_gettobanquet");
			
	autosave_by_name ("north offices complete");
		
	triggerEnable("trig_conferenceHall_door_approach", true);	
	
	wait(2);
	level thread obj_hostage_secure_banquet();	
}

//
//balcony_ladder_dude_think()
//{
//	self endon ("death");
//	
//	self.animname = "guy";
//	self holdPosition(true);
//	
//	
//	flag_wait("flanking_balcony_office_reached");	
//
//	//frnd
//	//(whispered) Over here, Andy!	
//	self queue_anim("embassy_frnd_balconyoverhere");
//	
//	flag_wait("flanking_balcony_reached");
//
//	//frnd
//	//"Alright mate, lead the way and keep low."	
//	self queue_anim("embassy_frnd_balconyleadtheway");
//	
//	self holdPosition(false);
//	
//}


trig_conf_door_setup()
{
	trigger = getEnt( "trig_conf_door_setup", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//Setup guy who will kick down the door to conference area
	friendly_conf_door_kicker = spawnDude(getent("friendly_conf_door_kicker", "script_noteworthy"));
	friendly_conf_door_kicker.animname = "guy";
	friendly_conf_door_kicker holdPosition(true);
		
	flag_wait("player_is_approaching_conf_hall_door");
	
	//gaz
	//"Let's move."
	level.gaz thread queue_anim("embassy_gaz_letsmove");
	
	friendly_conf_door_kicker holdPosition(false);
	
	friendly_conf_door_kicker thread door_NPC_open("door_conf_hall", 1, 2);
	
	friendly_conf_door_kicker waittill ("door_has_been_opened");
			
	flag_set("conf_hall_door_is_open");
	
	//frnd
	//"They're retreating! Take them out!"	
	friendly_conf_door_kicker.animname = "guy";
	friendly_conf_door_kicker thread queue_anim("embassy_frnd_banquetretreat");
	
}

trig_conferenceHall_door_approach()
{
	trigger = getEnt( "trig_conferenceHall_door_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//delete npcs from all previous areas
	level thread npcDelete("volume_all_up_to_confhall", "all", false);
		
	flag_set("player_is_approaching_conf_hall_door");
		
	level thread AA_banquet_reception_init();

	
	//Wait till friendlies breach door
	
	flag_wait("conf_hall_door_is_open");
	
	//Window friendlies
	level spawnDude(getEnt("friendly_window_confhall01", "script_noteworthy"));
	wait(.6);	
	level spawnDude(getEnt("friendly_window_confhall02", "script_noteworthy"));
}

/****************************************************/
/**************** BANQUET RECEPTION FUNCTIONS****************/
/****************************************************/
AA_banquet_reception_init()
{
	level thread trig_conferenceHall_advance_1();
	level thread trig_conferenceHall_advance_2();
	level thread trig_conferenceHall_advance_3();
	level thread hostiles_retreat_to_banquet_hall();
	level thread trig_enter_banquet_reception();
	level thread trig_approach_banquet_reception_stairs();
	level thread trig_enter_banquet_reception_floor();
	level thread trig_barricade_banquet_door();
	level thread banquet_wall_breach();
	level thread trig_enter_banquet_breach();
	level thread trig_enter_banquet_halfway();
	level thread trig_enter_banquet_stairway();
	level thread trig_enter_banquet_upper_level_left();
	level thread trig_enter_banquet_upper_level_right();
}

trig_conferenceHall_advance_1()
{
	trigger = getEnt( "trig_conferenceHall_advance_1", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	

}

trig_conferenceHall_advance_2()
{
	trigger = getEnt( "trig_conferenceHall_advance_2", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//Window friendlies
	level spawnDude(getEnt("friendly_window_confhall03", "script_noteworthy"));
	wait(1);
	level spawnDude(getEnt("friendly_window_confhall04", "script_noteworthy"));
	
	//frnd
	//"Watch your fire, watch your fire. We still have hostages unaccounted for."	
	eGuy = get_closest_ally();
	if (isdefined(eGuy))
		eGuy thread queue_anim("embassy_frnd_watchyourfire");	
}

trig_conferenceHall_advance_3()
{
	trigger = getEnt( "trig_conferenceHall_advance_3", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//spawn a window guy
	level spawnDude(getEnt("friendly_window_confhall06", "script_noteworthy"));
}


hostiles_retreat_to_banquet_hall()
{
	spawned_hostiles_conference_hall = level spawnGroup(getEntArray("hostiles_conference_hall", "targetname"));
	spawned_hostiles_conference_hall_retreat = level spawnGroup(getEntArray("hostiles_conference_hall_retreat", "targetname"));
	
	level thread retreatToVolume(spawned_hostiles_conference_hall_retreat, "volume_banquet_lower");	
}

trig_enter_banquet_reception()
{
	trigger = getEnt( "trig_enter_banquet_reception", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
		

		
	flag_set("nav_banquet_hall_complete");

	//frnd
	//"Get down there! Don't let them get that door shut!"
	eGuy = get_closest_ally();
	if (isdefined(eGuy))
		eGuy thread queue_anim("embassy_frnd_dontletdoorshut");	
	

	
	spawned_hostiles_banquet_reception = level spawnGroup(getEntArray("hostiles_banquet_reception", "targetname"));	
	spawned_hostiles_banquet_reception_retreat = level spawnGroup(getEntArray("hostiles_banquet_reception_retreat", "targetname"));	
	
	level thread retreatToVolume(spawned_hostiles_banquet_reception_retreat, "volume_banquet_lower");
	
	//Wait until there are no more hostiles
	aHostilesLower = getAIarrayTouchingVolume("axis", "volume_banquet_reception_lower");
	waittill_dead(aHostilesLower);
	
	aHostilesUpper = getAIarrayTouchingVolume("axis", "volume_banquet_reception_upper");
	waittill_dead(aHostilesUpper);
	
	flag_set("banquet_reception_cleared");	
	
	//activate the trigger to close banquet doors	
	if ( !flag( "banquet_doors_barricaded" ) )
	{
		trig = getent("trig_barricade_banquet_door", "targetname");
		trig notify("trigger");		
	}


}

trig_approach_banquet_reception_stairs()
{
	trigger = getEnt( "trig_approach_banquet_reception_stairs", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	

}


trig_barricade_banquet_door()
{
	trigWait("trig_barricade_banquet_door");
	
	flag_set("banquet_doors_barricaded");
	
	door = getent("door_banquet_hall", "targetname");
	door show();
	door solid();
	if (door.spawnflags & 1)
		door disconnectpaths();
		
	

	//delete all the hostiles inside the banquet hall
	level thread npcDelete("volume_banquet_upper", "all", false);
	level thread npcDelete("volume_banquet_lower", "all", false);

	//frnd
	//"They've barricaded themselves in, sir."
	eGuy = get_closest_ally();
	if (isdefined(eGuy))
		eGuy thread queue_anim("embassy_frnd_banquetbarricaded");			
	
}

trig_enter_banquet_reception_floor()
{
	trigger = getEnt( "trig_enter_banquet_reception_floor", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//kill all the hostiles left behind in the conference hall (if any)
	level thread npcDelete("volume_conference_hall", "all", true);
}

banquet_wall_breach()
{
	flag_wait("banquet_reception_cleared");	
	flag_wait("banquet_doors_barricaded");
	

	// Jack goes to check door
	eDoor = getent("origin_door_banquet_hall", "targetname");
	level.jack thread door_check(eDoor, 3);
	
	
	level.gaz thread forceToNode("node_banquet_door");
	
	wait(1);	
	
	//Gaz
	//Jack, check the door. Get that fiberoptic under there and tell me what's what.
	//level.gaz thread dialogue_thread("embassy_gaz_checkbanquetdoor");

	//gaz
	//"They'll be expecting us up the middle. Get charges on either side of the main door."	
	level.gaz thread queue_anim("embassy_gaz_placecharges");	
	level thread banquet_breach_dudes();
	
	level.jack waittill ("door_check_reached");
	
	
	wait(2);
	level.jack notify ("door_check_signal");	
	
	level.jack waittill ("door_check_signals_complete");


	
	level.jack notify ("door_check_stop");
}
	
banquet_breach_dudes()
{
	//Get 2 dudes who are not Gaz or Jack
	aExcluders = [];
	aExcluders[0] = level.jack;
	aExcluders[1] = level.gaz;	
	eBreach_Guy_01 = get_closest_ai_exclude (level.player getorigin(), "allies", aExcluders);
	aExcluders = [];
	aExcluders[0] = level.jack;
	aExcluders[1] = level.gaz;
	aExcluders[2] = eBreach_Guy_01;
	eBreach_Guy_02 = get_closest_ai_exclude (level.player getorigin(), "allies", aExcluders);
	assert(isdefined(eBreach_Guy_01));
	assert(isdefined(eBreach_Guy_02));
	
	//Have each guy go plant explosives on breach points
	level thread banquet_breach_1(eBreach_Guy_01);
	level thread banquet_breach_2(eBreach_Guy_02);

	flag_wait("banquet_wall_first_explosive_planted");
	flag_wait("banquet_wall_second_explosive_planted");
	
	//spawn guys inside banquet hall
	spawned_hostiles_banquet_hall = level spawnGroup(getEntArray("hostiles_banquet_hall", "targetname"));
		
	wait(2);
	
	//jack
	//"Stand back everyone. Three, two one."
	level.jack queue_anim("embassy_jack_standbackbanquet");

	//blow up the breaches
	maps\_utility::exploder(2);	
	earthquake (0.6, 2, level.player.origin, 1000);
	getent("origin_breach_banquet_hall_r","targetname") thread play_sound_in_space("rocket_explode_default");

	maps\_utility::exploder(3);
	getent("origin_breach_banquet_hall_l","targetname") thread play_sound_in_space("rocket_explode_default");

	badplace_delete("badplace_banquet_r");
	badplace_delete("badplace_banquet_l");
	
	level thread banquet_hall_fight();	
}	


banquet_breach_1(eGuy)
{
	eGuy thread set_explosives(getent("origin_breach_banquet_hall_r", "targetname"), "badplace_banquet_r", true, 0);
	eGuy waittill ("explosives_set");
 	flag_set("banquet_wall_first_explosive_planted");
}
banquet_breach_2(eGuy)
{
	eGuy thread set_explosives(getent("origin_breach_banquet_hall_l", "targetname"), "badplace_banquet_l", true, 0);
	eGuy waittill ("explosives_set");
 	flag_set("banquet_wall_second_explosive_planted");
}

banquet_hall_fight()
{


	//gaz
	//"Move! Move! Move!"	
	level.gaz thread queue_anim("embassy_gaz_movemovemove");	
	
	//Update colornodes
	triggerActivate("trig_colornodes_banquethall");
}


trig_enter_banquet_breach()
{
	trigger = getEnt( "trig_enter_banquet_breach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	
	//stop spawning dudes and wait for all ai to be dead
	wait(4);
	aHostilesLower = getAIarrayTouchingVolume("axis", "volume_banquet_lower");
	waittill_dead (aHostilesLower);
	
	aHostilesUpper = getAIarrayTouchingVolume("axis", "volume_banquet_upper");
	waittill_dead (aHostilesUpper);
	
	flag_set ("obj_hostage_secure_banquet_complete");
	
	level thread AA_kitchen_stairwell_init();	
}

trig_enter_banquet_halfway()
{
	trigWait("trig_enter_banquet_halfway");
	
	//cmd
	//"This is Command. Additional reinforcements inserting at your position."
	level thread dialogue_radio_thread("embassy_cmd_additionalforces1");
	
	//spawn reinforcements from skylight
	level spawnDude(getEnt("friendly_skylight_banquet01", "script_noteworthy"));
	wait(.75);
	level spawnDude(getEnt("friendly_skylight_banquet02", "script_noteworthy"));
	wait(1.75);
	level spawnDude(getEnt("friendly_skylight_banquet03", "script_noteworthy"));	
}
	
trig_enter_banquet_stairway()
{
	trigWait("trig_enter_banquet_stairway");

}

trig_enter_banquet_upper_level_left()
{
	trigWait("trig_enter_banquet_upper_level_left");
	triggerEnable("trig_enter_banquet_upper_level_right", false);
	
	//spawn reinforcements from windows
	spawnDude(getEnt("friendly_window_banquet01", "script_noteworthy"));
	wait(.5);
	spawnDude(getEnt("friendly_window_banquet02", "script_noteworthy"));
}

trig_enter_banquet_upper_level_right()
{
	trigWait("trig_enter_banquet_upper_level_right");
	triggerEnable("trig_enter_banquet_upper_level_left", false);
	
	//spawn reinforcements from windows
	spawnDude(getEnt("friendly_window_banquet03", "script_noteworthy"));
	wait(.75);
	spawnDude(getEnt("friendly_window_banquet04", "script_noteworthy"));		
}

/****************************************************/
/**************** KITCHEN STAIRWELL FUNCTIONS****************/
/****************************************************/
AA_kitchen_stairwell_init()
{
	level thread banquet_briefing();
	level thread trig_kitchen_door_approach();
	level thread trig_enter_hallway_kitchen();
	level thread trig_enter_stairwell_kitchen();
	level thread trig_enter_stairwell_area_1();
	level thread trig_approach_mezzanine_door();

}

banquet_briefing()
{
	//Have all guys school circle near stairs
//	aSoldiers = getaiarray("allies");
//	level thread schoolcircle("banquet", aSoldiers, level.gaz);
//
//	wait(1);
	
//	level thread obj_banquet_hall_regroup();
//	level thread trig_banquet_hall_regroup();
	//gaz
	
//	//"Good work lads. We?ve got a heli coming in to evacuate the Yanks."
//	level.gaz dialogue_thread("embassy_gaz_helievaccoming");
//	
//	//Gaz
//	//Regroup on me, lads. Come on let's move.
//	level.gaz dialogue_thread("embassy_gaz_banquetregroup");	
	
	//flag_wait ("obj_banquet_hall_regroup_complete");	


	//colornodes
	triggerActivate("trig_colornodes_banquethall_after");
	
	autosave_by_name ("banquet complete");

	//gaz
	//"Command, this is Alpha One. All hostages secured in banquet hall and kitchen. Zero X Rays taken prisoner."	
	level.gaz queue_anim("embassy_gaz_banquetcleared");	

	//cmd
	//"Understood, Alpha One. Bravo One, what is your status?"	
	dialogue_radio_thread("embassy_cmd_bravowhatsyourstatus1");	

//	wait(2);
//	
//	//cmd
//	//"Bravo One, what is your status? Come in Bravo One."
//	dialogue_radio_thread("embassy_cmd_bravowhatsyourstatus2");	
	
	level thread explosion_rocks_building();

	wait(1);
	
	//brv1
	//"This is Bravo One. Hostage reception is blocked. We?re pinned down with a dozen or so hostages in tow...we cannot effectively return fire. Receiving heavy rpg fire."
	dialogue_radio_thread("embassy_brv1_receptionblocked");	

	//cmd
	//"Roger that. Alpha One, you are to RV immediately with Bravo One. Proceed to the drawing room area opposite hostage reception. Eliminate all X Rays to allow Bravo to proceed with exfil."
	dialogue_radio_thread("embassy_cmd_gettodrawingroom");

	level thread obj_bravo_rv();	

	//gaz
	//"Alright lads, you heard the man, let's get a move on."
	level.gaz thread queue_anim("embassy_gaz_letsgettodrawingroom");		

	level thread breachSetup("kitchenhall");
	level waittill ("kitchenhall_ready_to_be_breached");
	
	triggerEnable("trig_kitchen_door_approach", true);			
}

//trig_banquet_hall_regroup()
//{
//	trigger = getEnt( "trig_banquet_hall_regroup", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
//	
//	flag_set ("obj_banquet_hall_regroup_complete");	
//	
//}

//schoolcircle(sArea, aSoldiers, eLeader)
//{
//	aCircleNodes = getnodearray("node_schoolcircle_" + sArea, "targetname");
//	
//	eLeader thread forceToNode ("node_schoolcircle_speaker_" + sArea);
//	
//	for(i=0;i<aSoldiers.size;i++)
//	{
//		aSoldiers[i] setgoalnode(aCircleNodes[i]);
//	}
//}

explosion_rocks_building()
{
	earthquake (0.6, 2, level.player.origin, 1000);
	getent("volume_drawing_room","targetname") thread play_sound_in_space("rocket_explode_default");

}

trig_kitchen_door_approach()
{
	trigger = getEnt( "trig_kitchen_door_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	
	spawned_hostiles_kitchen_hall = level spawnGroup(getEntArray("hostiles_kitchen_hall", "targetname"));

	//gaz
	//"Remember lads, check those corners"
	level.gaz thread queue_anim("embassy_gaz_checkcorners1");
	
	tempDoorHide(getent("door_kitchenhall", "targetname"));
	ignoreEverybody(false);
	flag_set("kitchen_door_breached");	
	

}
trig_enter_hallway_kitchen()
{
	trigger = getEnt( "trig_enter_hallway_kitchen", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	

}
trig_enter_stairwell_kitchen()
{
	trigger = getEnt( "trig_enter_stairwell_kitchen", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	

	
	//jack
	//"Check your corners. Check your corners"
	level.jack thread queue_anim("embassy_jack_checkcorners1");	
	
	//delete all inside the banquet hall
	level thread npcDelete("volume_banquet_upper", "all", false);
	level thread npcDelete("volume_banquet_lower", "all", false);	
	
}

trig_enter_stairwell_area_1()
{
	trigger = getEnt( "trig_enter_stairwell_area_1", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("stairwell_reached");

	spawned_hostiles_stairwell = level spawnGroup(getEntArray("hostiles_stairwell", "targetname"));
}

trig_approach_bravo()
{

	trigWait("trig_approach_bravo");
	
	
}

trig_approach_mezzanine_door()
{
	trigger = getEnt( "trig_approach_mezzanine_door", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	


	
	level thread ai_setup_drawing_room();		
	level thread AA_bravo_area_init();
	
	level waittill ("ai_setup_drawing_room_complete");	
	
	
	
	level.bravo_stairwell holdPosition(false);	
	wait(.5);
	
	
	level.bravo_stairwell thread door_NPC_open("door_mezzanine", 2, 2);
	level.bravo_stairwell waittill ("door_has_been_opened");
	
	//kill remaining hostiles in stairwell
	level thread npcDelete("volume_stairwell", "axis", true);
	
	level.bravo_stairwell holdPosition(true);	
	
	level.player.ignoreme = true;	
	
	//brv2
	//"Glad to see you boys. Come with me, Bravo can?t exfil until we take out that RPG. Let's move."
	level.bravo_stairwell queue_anim("embassy_brv2_gladtoseeyou");	
	
	level.bravo_stairwell holdPosition(false);	

	flag_set("obj_bravo_rv_complete");
	
	//activate next trigger to update friendly color nodes
	wait(.5);
	triggerActivate("trig_enter_mezzanine");
	
	autosave_by_name ("bravo rv complete");
	
	wait(2);

	level thread obj_reception_clear();
}

ai_setup_drawing_room()
{
	//spwan bravo team
	level.aFriendlies_bravo = level spawnGroup(getEntArray("friendlies_bravo", "targetname"));
	array_thread(level.aFriendlies_bravo, ::makeUnaware,true);
	array_thread(level.aFriendlies_bravo, ::invulnerable,true);
	level.bravo_courtyard = getDudeFromArray(level.aFriendlies_bravo, "bravo_courtyard");
	level.bravo_leader = getDudeFromArray(level.aFriendlies_bravo, "bravo_leader");
	level.bravo_leader.animname = "brv1";
		
	//spawn bravo guys at mezzanine level
	level.bravo_stairwell = level spawnDude(getEnt("bravo_stairwell", "targetname"));
	level.bravo_stairwell invulnerable(true);
	level.bravo_stairwell.animname = "guy";
	//level.bravo_stairwell holdPosition(true);	
	
//	level.bravo_backdraft = level spawnDude(getEnt("bravo_backdraft", "targetname"));
//	level.bravo_backdraft.animname = "guy";
//	level.bravo_backdraft makeUnaware(true);
//	level.bravo_backdraft invulnerable(true);
//	level.bravo_backdraft holdPosition(true);	
	
	level.bravo_mezzanine_1 = level spawnDude(getEnt("bravo_mezzanine_1", "targetname"));	
	level.bravo_mezzanine_1 invulnerable(true);
	
	//have squad be unaware and ignored for the time being
	aSquad = getSquadArray();
	array_thread(aSquad, ::makeUnaware,true);
	
	//spawn hostiles on other side of courtyard
	flood_spawn(getEntArray("hostiles_reception", "targetname"));
	
	level notify ("ai_setup_drawing_room_complete");
}
/****************************************************/
/**************** BRAVO AREA FUNCTIONS***************/
/****************************************************/

AA_bravo_area_init()
{
	level thread trig_bravo_approach();
	level thread trig_drawing_room_statue();
	level thread trig_mezzanine_to_roof_door_approach();
	level thread trig_courtyard_hallway_enter();
	level thread trig_rooftop_door_approach();
	level thread trig_rooftop_door_exit();
	level thread trig_rooftop_reached();
	level thread trig_reception_floor_entered();
}

trig_bravo_approach()
{
	trigWait("trig_bravo_approach");
	
	//brv 1
	//Get back with your team and take out those RPGs!	
	level.bravo_leader thread queue_anim("embassy_brv1_gettoreception");
	
}
trig_drawing_room_statue()
{
	trigWait("trig_drawing_room_statue");
	
	//statue blows up from RPG hit
	maps\_utility::exploder(30);	
	level.player play_sound_in_space("rocket_explode_default");
	earthquake (0.6, 2, level.player.origin, 1000);
	
}

trig_mezzanine_to_roof_door_approach()
{
	trigger = getEnt( "trig_mezzanine_to_roof_door_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//brv3
	//"This way, gents."
//	level.bravo_backdraft holdPosition(false);
//	level.bravo_backdraft thread dialogue_thread("embassy_brv3_thiswaydoorexplode");	
//	level.bravo_backdraft thread forceToNode("node_backdraft_door");
	//wait(1);
	
	//brv2
	//"Hold up Fatboy, we need to check the door for explosives!"
	//level.bravo_stairwell thread dialogue_thread("embassy_brv2_holdupcheckthedoor");		
	
	//level.bravo_backdraft waittill ("goal");
	
	//maps\_utility::exploder(5);	
	//earthquake (0.6, 2, level.player.origin, 1000);
	//getent("door_backdraft","targetname") thread play_sound_in_space("rocket_explode_default");	
	
	//level.bravo_backdraft invulnerable(false);
	//level.bravo_backdraft thread killEntity();
		
	//Jack goes in first so he can check the next door
	eDoor = getent("door_roof_access", "targetname");
	level.jack thread door_check(eDoor, 4);
			
	wait(1);
	//Gaz
	// Bloody Christ. Booby trap. Jack, get a camera under the next door. 
	//level.gaz thread dialogue_thread("embassy_gaz_checkthenextdoor");
		

	level.jack waittill ("door_check_reached");
	
	wait(2);
	flag_wait("skylight_access_door_reached");
	
	level.jack notify ("door_check_signal");	
	level.jack waittill ("door_check_signals_complete");

	//jack
	//"Door is clear."
	level.jack thread queue_anim("embassy_jack_doorisclear");
	level.jack notify ("door_check_stop");
	level.jack waittill ("door_check_complete");
	
	//Jack kicks in the door
	level.jack thread door_NPC_open("door_roof_access", 0, 2);
	level.jack waittill ("door_has_been_opened");

	
	//Have everyone go to the skylight and get in place
	level.guysReadyAtSkylight = 0;
	aSquad = getSquadArray();
	aRappelPoints = getentarray("origin_skylight_breach_1", "targetname");
	iSquadRappelIndex = 0;
	
	
	for(i=0;i<aSquad.size;i++)
	{
		
		if ( (isdefined(aSquad[i].script_noteworthy)) && (aSquad[i].script_noteworthy == "gaz") )
		{
			eRappelPoint = getent("origin_skylight_breach_gaz", "targetname");

		}
		else
		{
			eRappelPoint = aRappelPoints[iSquadRappelIndex];
			iSquadRappelIndex ++;
		}

		
		aSquad[i] thread skylight_rappel(eRappelPoint);
		aSquad[i] thread guysReadyAtSkylight_monitor();
	}		
}

guysReadyAtSkylight_monitor()
{
	self waittill ("ready_to_rappel_at_skylight");
	
	level.guysReadyAtSkylight ++;
	
	if (level.guysReadyAtSkylight == 4)
		flag_set("all_guys_ready_to_rappel_at_skylight");	
}


skylight_rappel(eAnimEnt)
{
	self endon ("death");	
	
	self set_animname ("guy");	
	self.ignoreme = true;	
	self pushplayer(true);
	
	ender = "stop_idle";
	
	// Get to the skylight and wait
	self setFlashbangImmunity( true );
	eAnimEnt anim_reach_solo(self, "rappel_skylight_mount");
	self notify ("ready_to_rappel_at_skylight");
	
	eAnimEnt thread anim_loop_solo (self, "rappel_skylight_idle", undefined, ender);
		
	flag_wait("skylight_breach_command_given");
	
	wait (randomfloatrange(.25,1.75));
	
	eAnimEnt notify (ender);
	eAnimEnt thread anim_single_solo (self, "rappel_skylight_drop");	
	self waittillmatch("single anim", "end");
	
	self reset_animname();	
	self.ignoreme = false;	
	self pushplayer(false);
}



trig_courtyard_hallway_enter()
{
	trigger = getEnt( "trig_courtyard_hallway_enter", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("drawaing_room_exit_breached");
}

trig_rooftop_door_approach()
{
	trigger = getEnt( "trig_rooftop_door_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("skylight_access_door_reached");

}

trig_rooftop_door_exit()
{
	trigger = getEnt( "trig_rooftop_door_exit", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
}

trig_rooftop_reached()
{
	trigger = getEnt( "trig_rooftop_reached", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("skylight_rooftop_reached");
	
	level thread obj_skylight_breach();

	//Gaz
	//Right. Grab a rope and get into position. Andy, you're over here near me.	
	level.gaz thread queue_anim("embassy_gaz_skylightgetready1");	
	
	level thread trig_use_skylight_get_into_position_think();
}


trig_use_skylight_get_into_position_think()
{
	triggerEnable("trig_use_skylight_get_into_position", true);
	
	//setup hint trigger 	
	trig_use_skylight_get_into_position = getent("trig_use_skylight_get_into_position", "targetname");
	trig_use_skylight_get_into_position setHintString( &"EMBASSY_HINTSTR_ROPE_GRAB");
	trig_use_skylight_get_into_position usetriggerrequirelookat();

	//wait until hits "use" key
	trig_use_skylight_get_into_position waittill("trigger");
	trig_use_skylight_get_into_position trigger_off();	
	
	//Take player weapons away
	level thread playerWeaponTempRemove();
	
	//Put player into position
	eWarp = getent("origin_obj_skylight_breach", "targetname");
	level.player setorigin (eWarp.origin);
	level.player setplayerangles (eWarp.angles);
	level.player linkto(eWarp);
	
	//Move to rappel point
	level.eSkylightRappelStart = getent("origin_obj_skylight_breach_drop", "targetname");
	fMoveTime = .5;
	eWarp moveto( level.eSkylightRappelStart.origin, fMoveTime, .1, .1 );
	wait (fMoveTime);
	level.player unlink();
	level.player linkto(level.eSkylightRappelStart);
	
	//Gaz
	//Right, on three. One....two....3	
	level.gaz queue_anim("embassy_gaz_skylightonthree");	

	//Allow player to press the use trigger 
	level thread trig_use_skylight_breach_think();
	
	//Gaz
	//Go! Go! Go!
	level.gaz thread queue_anim("embassy_gaz_skylightgogogo");	
	
	//blow the window and update objectives
	maps\_utility::exploder(6);	
	earthquake (0.6, 2, level.player.origin, 1000);
	getent("origin_obj_skylight_breach","targetname") thread play_sound_in_space("rocket_explode_default");
	
	flag_set("skylight_breach_command_given");
	
	flag_set ("obj_skylight_breach_complete");
	
	level thread reception_shootout();	
}

trig_use_skylight_breach_think()
{

	triggerEnable("trig_use_skylight_breach", true);
	
	//setup hint trigger 	
	trig_use_skylight_breach = getent("trig_use_skylight_breach", "targetname");
	trig_use_skylight_breach setHintString( &"EMBASSY_HINTSTR_ROPE_RAPPEL");

	//wait until hits "use" key
	trig_use_skylight_breach waittill("trigger");
	trig_use_skylight_breach trigger_off();	
	
	// HACK - make the user rappel
	fMoveTime = 1.8;
	eEndRappelPoint = getent("origin_obj_skylight_breach_end", "targetname");
	level.eSkylightRappelStart moveto( eEndRappelPoint.origin, fMoveTime, .5, .5 );
	wait (fMoveTime);
	
	level.player unlink();
	level.player notify ("restore_player_weapons");
	
	level.player.ignoreme = false;	
}

reception_shootout()
{
	
	aSquad = getSquadArray();
	array_thread(aSquad, ::makeUnaware,false);
}

trig_reception_floor_entered()
{
	trigger = getEnt( "trig_reception_floor_entered", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	
	//wait for remaining ai to be dead
	aHostiles = getAIarrayTouchingVolume("axis", "volume_reception");
	waittill_dead (aHostiles);
	
	flag_set("obj_reception_clear_complete");
		
	autosave_by_name ("reception assault complete");
	
	level thread AA_elevator_assault_init();	
}
/****************************************************/
/**************** ELEVATOR ASSAULT FUNCTIONS ****************/
/****************************************************/

AA_elevator_assault_init()
{
	level thread courtyard_sniper_sequence();
	level thread trig_courtyard_cover();
	level thread trig_enter_elevator_shaft();
	level thread trig_ladder_dismount();
	level thread trig_enter_elevator_rooftop();
	level thread trig_squad_advance_rooftop_1();
	level thread trig_squad_advance_rooftop_2();
	level thread trig_squad_advance_rooftop_3();
	level thread trig_enter_library_foyer();
	level thread foyer_door_slam();
	level thread trig_approach_library_sidehall();
	level thread trig_foyer_frontdoor_approach();
	level thread trig_foyer_sidedoor_approach();
}

courtyard_sniper_sequence()
{
	//brv1
	//"Thanks, Alpha. We owe you boys a pint."
	dialogue_radio_thread("embassy_brv1_weoweyouapint");

	//Gaz
	//Hold up, Bravo, we'll cover your crossing from here. 
	triggerActivate("trig_colornodes_courtyard_cover");	
	level.gaz queue_anim("embassy_gaz_courtyardcover");	
//	
//	//Gaz
//	//Andy, get into position and keep your eyes peeled for hostiles
//	level.gaz thread dialogue_thread("embassy_gaz_covercommand1");
//	
//	
//	
//	level notify("courtyard_objective_given");
//	level thread obj_courtyard_cover();
//	
//	level courtyard_cover_nag();
//
//	//Player is in position
//	flag_set("courtyard_cover_navigate_complete");
//	
//	// Bravo begins navigating across
//	for(i=0;i<level.aFriendlies_bravo.size;i++)
//	{
//		wait (randomfloatrange(0.5, 1.5));
//		level.aFriendlies_bravo[i] thread goToNode("node_courtyard");
//	}
//	
	//Spawn dudes on roof
	flood_spawn(getEntArray("hostiles_library_roof", "targetname"));

	wait(1);
	aHostiles_library_roof = getAIarrayTouchingVolume("axis", "volume_library_roof");
	for(i=0;i<aHostiles_library_roof.size;i++)
	{
		aHostiles_library_roof[i].favoriteenemy =  level.bravo_courtyard;
		aHostiles_library_roof[i].ignoreme = true;
	} 
		
	//Jack 
	//Movement! Upper rooftop!
	level.jack thread queue_anim("embassy_jack_movementupper");	
	
	wait(1);
	
	//gaz
	//"Sniper! Upper floor!"
	level.gaz thread queue_anim("embassy_gaz_sniperupperfloor");		
	wait(1);
	
	//jack
	//"Everyone! Take cover!"
	level.jack thread queue_anim("embassy_jack_takecover");	

//	wait(.75);
//	//Gaz
//	//Abort Bravo! Go back! Go back!
//	level.gaz thread dialogue_thread("emabssy_gaz_abortbravo");	
//
//	//Bravo heads back
//	for(i=0;i<level.aFriendlies_bravo.size;i++)
//	{
//		level.aFriendlies_bravo[i] notify ("goal");
//		wait (randomfloatrange(0.5, 1.5));
//		level.aFriendlies_bravo[i] thread goToNodeAndDelete("node_courtyard_retreat");
//	}
//		
//	//gaz
//	//"Command, this is Alpha One, we have men down. Sniper in upper offices above the courtyard."
//	level.gaz dialogue_thread("embassy_gaz_sniperinupperoffices");	
//	
//	//cmd
//	//"Roger, Alpha One. Sierra group does not have a view. Repeat, snipers cannot pinpoint enemy location. Proceed immediately to flush out hostiles in upper offices."
//	dialogue_radio_thread("embassy_cmd_proceedtolibrary");	
//	
//	flag_set("obj_courtyard_cover_complete");	
	
	wait(4);
	
	//gaz
	//"Right, our jobs not done yet, lads. 
	//level.gaz dialogue_thread("embassy_gaz_jobsnotdone");	
	
	//gaz
	//Bravo won?t be able to exfil these hostages through that courtyard with a sniper hanging about. 
	level.gaz queue_anim("embassy_gaz_mustfindsniper");
	
	//gaz
	//Let?s get up there and have a look. Get these elevator doors open."
	level.gaz thread queue_anim("embassy_gaz_elevatorcmd");		
	
	autosave_by_name ("elevator ascent");
		
	level thread obj_sniper_assault();
	
	level thread elevator_door_open();	
	
	
	flag_wait("elevator_rooftop_reached");
	aHostiles_library_roof = getAIarrayTouchingVolume("axis", "volume_library_roof");
	for(i=0;i<aHostiles_library_roof.size;i++)
	{
		if (!isalive(aHostiles_library_roof[i]))
			return;
		aHostiles_library_roof[i].favoriteenemy =  level.player;
		aHostiles_library_roof[i].ignoreme = false;
	} 
}

courtyard_cover_nag()
{
	level endon ("courtyard_cover_navigate_complete");
	
	//Gaz nags player till he gets his ass in gear
	i = 2;
	while ( !flag("courtyard_cover_navigate_complete") )
	{
		level.gaz thread queue_anim("embassy_gaz_covercommand" + i);
		i++;
		if (i > 3)
			i = 2;
		wait (randomfloatrange(6.3, 10));		
	}
}


trig_courtyard_cover()
{
	level waittill("courtyard_objective_given");
	trigger = getEnt( "trig_courtyard_cover", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	flag_set("courtyard_cover_navigate_complete");
	level notify ("courtyard_cover_navigate_complete");
	
}
elevator_door_open()
{
	level thread elevator_doors_think();
	
	
	level.guysAtElevator = 0;
	aElevatorGuys = [];
	aElevatorGuys[0] = level.gaz;
	aElevatorGuys[1] = level.bravo_stairwell;
	aElevatorGuys[2] = level.jack;
	
	for(i=0;i<aElevatorGuys.size;i++)
	{
		aElevatorGuys[i] thread elevator_door_open_think();
		aElevatorGuys[i] thread guysReadyAtElevator_monitor();
	}
	
	flag_wait ("elevator_ready_to_be_pried_open");
	
	
	level waittill ("elevator_sequence_complete");
	
	//jack
	//"Got it!"	
	level.jack thread queue_anim("embassy_jack_elevatordooropen");	
	
		
	//colornodes
	triggerEnable("trig_colornodes_roof", true);
	triggerActivate("trig_colornodes_roof");
		
	level waittill ("elevator_doors_open");	
	
	//brv
	//"Right!, up the elevator shaft, let's go! Let's go!"
	level.bravo_stairwell thread queue_anim("embassy_brv_getuptheshaft");	
	
}

elevator_doors_think()
{
	eDoorLeft = getent("door_elevator_l", "targetname");
	eDoorRight = getent("door_elevator_r", "targetname");
	eDoorLeftOrigin = getent(eDoorLeft.target, "targetname");
	eDoorRightOrigin = getent(eDoorRight.target, "targetname");
	eDoorLeftOriginEnd = getent(eDoorLeftOrigin.target, "targetname");
	eDoorRightOriginEnd = getent(eDoorRightOrigin.target, "targetname");
	
	//Link doors to respective origins
	eDoorLeft linkto (eDoorLeftOrigin);
	eDoorRight linkto (eDoorRightOrigin);
	
	// Wait till guys in position AND player is looking over there
	flag_wait ("all_guys_ready_at_elevator");
	waittill_trigger_look("trig_lookat_elevator");
	
	flag_set("elevator_ready_to_be_pried_open");
	wait(1);
	//Open door halfway and move back
	eDoorLeftOrigin movex( -14, 1.5, .5, .5 );
	eDoorRightOrigin movex( 14, 1.5, .5, .5 );
	wait(1.5);
	eDoorLeftOrigin movex( 14, .5, 0, 0 );
	eDoorRightOrigin movex( -14, .5, 0, 0 );
	
	level waittill ("elevator_sequence_complete");
	
	wait(3.5);
	
	eDoorLeftOrigin movex( -64, 3, .5, .5 );
	eDoorRightOrigin movex( 64, 3, .5, .5 );
	
	wait(3);

	eDoorLeft connectpaths();
	eDoorRight connectpaths();
		
	level notify ("elevator_doors_open");
}

guysReadyAtElevator_monitor()
{
	self waittill ("ready_to_open_elevator");
	
	level.guysAtElevator ++;
	
	if (level.guysAtElevator == 3)
		flag_set("all_guys_ready_at_elevator");	
}

waittill_trigger_look(sTrigger)
{
	eTrig = getent(sTrigger, "targetname");assert(isdefined(eTrig));
	eTrig waittill ( "trigger" ); eTrig trigger_off();
}

elevator_door_open_think()
{
	self endon ("death");
	
	eAnimEnt = getent("origin_elevator_middle", "targetname");
	
	self setFlashbangImmunity( true );
	eAnimEnt anim_reach_solo(self, "elevator_pry_idle_start");
	self notify ("ready_to_open_elevator");
	
	eAnimEnt thread anim_loop_solo (self, "elevator_pry_idle", undefined, "stop_idle");
	
	flag_wait ("elevator_ready_to_be_pried_open");
	
	eAnimEnt notify ("stop_idle");
	eAnimEnt thread anim_single_solo (self, "elevator_pry");
	
	self waittillmatch("single anim", "end");
	
	level notify ("elevator_sequence_complete");		
}

trig_enter_elevator_shaft()
{
	trigger = getEnt( "trig_enter_elevator_shaft", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("elevator_shaft_reached");
}
	
//trigger_use_ladder_dismount()
//{
//	//setup hint trigger 	
//	trigger_use_ladder_dismount = getEnt( "trigger_use_ladder_dismount", "targetname" ); 
//	trigger_use_ladder_dismount setHintString( &"EMBASSY_HINTSTR_LADDER_DISMOUNT");
//
//	//wait until hits "use" key
//	trigger_use_ladder_dismount waittill("trigger");
//	trigger_use_ladder_dismount trigger_off();
//	
//	//custom animation of player moving to rooftop
//	//teleport squad up to roof
//	aSquadNodes = getnodearray("squadWarp_library", "targetname");
//	level thread skipWarpSquad("library");
//	
//	//delete bravo back in drawing room for now in case any left
//	level thread npcDelete("volume_drawing_room", "allies");	
//	
//	//delete barricade so they can exfil later
//	eBarricade_reception_1 = getent("barricade_reception_1", "targetname");
//	eBarricade_reception_1 hideMe();
//	
//	//create death trigger at bottom of shaft and delete ladder
//	eElevator_ladder = getent("elevator_ladder", "targetname");
//	eElevator_ladder hideMe();
//	eTrig_hurt_elevator = getent("trig_hurt_elevator", "targetname");
//	eTrig_hurt_elevator trigger_on();
//	
//}

trig_ladder_dismount()
{
	trigger = getEnt( "trig_ladder_dismount", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	
	//delete bravo back in drawing room for now in case any left
	level thread npcDelete("volume_drawing_room", "allies");	

	//delete barricade so they can exfil later
	eBarricade_reception_1 = getent("barricade_reception_1", "targetname");
	eBarricade_reception_1 hideMe();
	
	//create death trigger at bottom of shaft and delete ladder
//	eElevator_ladder = getent("elevator_ladder", "targetname");
//	eElevator_ladder hideMe();
//	eTrig_hurt_elevator = getent("trig_hurt_elevator", "targetname");
//	eTrig_hurt_elevator trigger_on();
	
}


trig_enter_elevator_rooftop()
{
	trigger = getEnt( "trig_enter_elevator_rooftop", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("elevator_rooftop_reached");
	
	flood_spawn(getentarray("hostiles_library_foyer", "targetname"));
	
	//Make other dudes vulnerable, but give them a fair amount of health
	level.bravo_stairwell.health = 500;
	level.bravo_mezzanine_1.health = 500;
	level.bravo_stairwell invulnerable(false);
	level.bravo_mezzanine_1 invulnerable(false);
	
}

trig_squad_advance_rooftop_1()
{
	trigger = getEnt( "trig_squad_advance_rooftop_1", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
}

trig_squad_advance_rooftop_2()
{
	trigger = getEnt( "trig_squad_advance_rooftop_2", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
}

trig_squad_advance_rooftop_3()
{
	trigger = getEnt( "trig_squad_advance_rooftop_3", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();

	//setip C4 in bathroom
	eC4trigger = getent("trig_use_foyer_c4", "targetname");
	eC4trigger thread c4_think();
	
	flood_spawn(getentarray("hostiles_library_foyer2", "targetname"));
}

trig_enter_library_foyer()
{
	trigger = getEnt( "trig_enter_library_foyer", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("library_foyer_reached");
}

trig_foyer_frontdoor_approach()
{
	
	trigger = getEnt( "trig_foyer_frontdoor_approach", "targetname" );
	trigger trigger_on();
	trigger waittill ( "trigger" ); 
	trigger trigger_off();
	
	
	flag_set("player_approaching_foyer_frontdoor");
	
	level thread door_close("door_libraryfoyer");
}
trig_foyer_sidedoor_approach()
{
	trigger = getEnt( "trig_foyer_sidedoor_approach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	flag_set("player_approaching_foyer_sidedoor");
}

foyer_door_slam()
{
	// Wait till all ai dead, or player is really close to door
	while ( (!flag("library_foyer_cleared")) && (!flag("player_approaching_foyer_sidedoor")) )
	{
		wait (0.05);
	}
	
	level thread door_close("door_libraryhallway");
	
	
}

trig_approach_library_sidehall()
{
	trigger = getEnt( "trig_approach_library_sidehall", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//spawn guys running across hall to library
	aHostiles_library_door = level spawnGroup(getEntArray("hostiles_library_door", "targetname"));
	array_thread(aHostiles_library_door, ::goToNodeAndDelete, "node_library_delete");	
	
	flag_wait("player_approaching_foyer_sidedoor");
	wait(.5);
	npcDelete("volume_library", "all");	
	
	//stop spawning dudes and wait for all ai to be dead
	aHostiles = getAIarrayTouchingVolume("axis", "volume_library_and_foyer");
	waittill_dead (aHostiles);
		
	flag_set("library_foyer_cleared");

	level thread AA_lib_assault_init();

}

/****************************************************************************
    LIBRARY ASSAULT
****************************************************************************/
	
AA_lib_assault_init()
{	
	level thread library_door_breach();
	level thread library_shootout();	
	level thread trig_enter_library_breach();
	level thread trig_lib_advance_1();
}

library_door_breach()
{
	
//	//Send jack to check door and get friendlies to proper positions
//	triggerActivate("trig_colornodes_foyerbreach");
//	
//	eDoor = getent("origin_library_camera_check", "targetname");
//	level.jack thread door_check(eDoor, 4);
//	level.jack waittill ("door_check_reached");
//	wait(2);
//	flag_wait("player_approaching_foyer_sidedoor");
//	level.jack notify ("door_check_signal");	
//	level.jack waittill ("door_check_signals_complete");
//	level.jack notify ("door_check_stop");
//	level.jack waittill ("door_check_complete");
//	
//	//jack
//	//"Can?t tell if it?s booby-trapped. However I do see 3 bad guys clustered right around the corner there."	
//	level.jack dialogue_thread("embassy_jack_librarydoorbreach");
	
	
	//gaz
	//"Andy, get a charge on that position."
	level.gaz queue_anim("embassy_gaz_breachlibrarywall2");	
	flag_set("library_breach_objective_given");
	level thread obj_library_breach();
	
	
	//spawn guys inside library and have them stay put
	level thread ai_setup_library_interior();
	
	//setup C4 on wall
	eC4trigger = getent("trig_use_library_c4", "targetname");
	eC4trigger thread c4_think();
	
	eC4trigger waittill ("c4_has_been_detonated");

	//Kill the guys at the door
	level.library_breach_dude_1 killEntity();
	level.library_breach_dude_2 killEntity();
	
	flag_set ("obj_library_breach_complete");
	flag_set("library_breached");	
		
	//have friendlies go to nodes and yell at human shield guy
	level thread human_shield_friendlies("nodes_frnd_humanshield_library_1");
	
}

ai_setup_library_interior()
{
	//get names for the 2 guys who will be breach fodder
	level.library_breach_dude_1 = level spawnDude(getEnt("library_breach_dude_1", "script_noteworthy"));
	level.library_breach_dude_2 = level spawnDude(getEnt("library_breach_dude_2", "script_noteworthy"));
	
	//1st Human shield pair
	level thread human_shield_spawn("humanshield_library_1");
	
	level waittill("human_shield_terrorist_dead");
	
	//have friendlies go to nodes and yell at human shield guy
	level thread human_shield_friendlies("nodes_frnd_humanshield_library_2");
	

}

trig_enter_library_breach()
{
	trigger = getEnt( "trig_enter_library_breach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
}

library_shootout()
{
	flag_wait ("library_breached");
	

	
	//wait till last human shield pair is spawned
	flag_wait("library_final_humanshield_spawned");
	
	//Wait until there are no more hostiles
	aHostiles = getAIarrayTouchingVolume("axis", "volume_library");
	waittill_dead(aHostiles);
	
	flag_set ("obj_sniper_assault_complete");
	
	autosave_by_name ("library assault complete");
	
	level thread AA_final_battle_init();
}

trig_lib_advance_1()
{
	trigger = getEnt( "trig_lib_advance_1", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	
	//spawn next human shield pair
	level thread human_shield_spawn("humanshield_library_2");	
	
	//wait till this terrorist dies, then activate next trigger/thread
	level waittill ("human_shield_terrorist_dead");
	
	//colornodes
	triggerActivate("trig_lib_advance_2");
	
	//gaz
	//"Sniper is on the upper balcony. Get up there and sort him out, Andy."
	level.gaz thread queue_anim("embassy_gaz_gettoupperbalcony");
	
	//Last human shield pair
	level thread human_shield_spawn("humanshield_library_3");	
	flag_set("library_final_humanshield_spawned");
	
	//last hostiles
	level spawnGroup(getEntArray("hostiles_library_wave1", "targetname"));	
}

/****************************************************/
/**************** FINAL BATTLE FUNCTIONS ************/
/****************************************************/


AA_final_battle_init()
{
	level thread library_aftermath();
	level thread exit_library();
	level thread trigger_library_floor();
	level thread trig_exit_library_door();
	level thread trig_exit_library_breach();
	level thread trig_approach_library_stairwell();
	//level thread trig_use_sniperrifle_think();
	level thread trig_stairwell_roofaccess_reached();
	level thread trig_enter_vent_roof();
	level thread trig_enter_vent();
	level thread trig_enter_vent_section_1();
	level thread trig_enter_vent_sniper_section();
}

library_aftermath()
{

	//spawn some more friendlies outside in the foyer
	aFriendlies_reinforcements_library = level spawnGroup(getEntArray("friendlies_reinforcements_library", "targetname"));	
	
	//make Gaz go to stairwell and Jack by doorway	
	level thread jack_goes_to_stairwell();
	level.gaz thread forceToNode("node_gaz_library");
			
	//gaz
	//"This is Alpha One, Bravo One you are all clear for Exfil."	
	level.gaz queue_anim("embassy_gaz_bravoonecleartoexfil");	
	
	level thread bravo_exfil();
	
	//brv1
	//"Thanks, Alpha One. Proceeding across courtyard to hostage reception."
	dialogue_radio_thread("embassy_brv1_thanksalpha");

	//gaz
	//"That?s Bravo One exfiling to you, Command."	
	level.gaz queue_anim("embassy_gaz_bravoexfiling");	


	iprintlnbold (&"EMBASSY_HINTSTR_LEVELEND");

	
	//cmd
	//"Negotiations with lead X Ray have gone south...standby."
	//dialogue_radio_thread("embassy_cmd_negotiationsgonebad");
	
	//neg
	//"We are trying to accommodate you but..."
	//dialogue_radio_thread("embassy_neg_tryingtohelp");
	
	//mbg
	//"No! Enough! I still have plenty of Americans to execute. You will bring helicopter now!"
	//dialogue_radio_thread("embassy_mbg_bringheli");	
	
	//neg
	//"Calm down. Now let?s just be reasonable..."
	//dialogue_radio_thread("embassy_neg_calmdown");
	
	//mbg
	//"That?s one hostage dead. I will continue to execute one hostage every 60 seconds until the helicopter arrives..."
	//dialogue_radio_thread("embassy_mbg_executehostage");	
	
	//cmd
	//"Alpha One, you are closest to the position. We'll bring in the heli but DO NOT let the X Rays get mobile. Repeat, hostiles must NOT get mobile."
	//dialogue_radio_thread("embassy_cmd_finalsniperinstructions1");	
	
	//gaz
	//"Andy! You?re up! Need your sniper skills! Get over to the stairwell, we need to get topside."
	//level.gaz thread dialogue_thread("embassy_gaz_gettostairwell");		
	//level thread gaz_goes_to_stairwell();
	//level thread obj_final_boss();
}
bravo_exfil()
{
	aFriendlies_bravo = level spawnGroup(getEntArray("friendlies_bravo", "targetname"));
	for(i=0;i<aFriendlies_bravo.size;i++)
	{
		wait(randomfloatrange(.5, 1.9));
		aFriendlies_bravo[i] goToNodeAndDelete("node_delete_reception");
	}
}


trigger_library_floor()
{
	trigger = getEnt( "trigger_library_floor", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	flag_set("player_on_library_floor");
}

trig_exit_library_door()
{
	level endon ("library_exited");
	trigger = getEnt( "trig_exit_library_door", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();
	level notify ("library_exited");
}
trig_exit_library_breach()
{
	level endon ("library_exited");
	trigger = getEnt( "trig_exit_library_breach", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	level notify ("library_exited");	
}

jack_goes_to_stairwell()
{
	//Jack goes to stairwell door and blocks it
	level.jack thread forceToNode("node_bathroom_door");
	level.jack waittill ("goal");
	
	//Make Jack block the door till player takes rifle
	level.jack.dontavoidplayer = true;
	level.jack pushplayer(true);	
	
	flag_set("jack_ready_by_roof_access");
	
	//Wait till player takes rifle, then step aside
	//flag_wait("player_has_sniper_rifle");	
	
	
	level.jack.dontavoidplayer = false;
	level.jack pushplayer(false);	
	//blockerEnable(getent("door_stairwell_top_blocker", "targetname"), 0);

	level.jack goToNode("node_bathroom_door2");
}

gaz_goes_to_stairwell()
{
	level.gaz thread door_NPC_open("door_libraryfoyer_2", 1, 1);
	level.gaz waittill ("door_has_been_opened");
	level.gaz thread forceToNode("node_bathroom_vent1");
	

	
	level.gaz waittill ("goal");
	triggerEnable("trig_approach_library_stairwell", true);
}	


trig_approach_library_stairwell()
{
	trigger = getEnt( "trig_approach_library_stairwell", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();

	//jack
	//"Better take this."
	level.jack thread queue_anim("embassy_jack_takesniperrifle");	
	
	
}

trig_use_sniperrifle_think()
{
	flag_wait("jack_ready_by_roof_access");
	
	//turn on trigger and wait for user to hit "use" key
	eTrig_use_sniperrifle = getent("trig_use_sniperrifle", "targetname");	
	eTrig_use_sniperrifle trigger_on();
	eTrig_use_sniperrifle setHintString(&"EMBASSY_HINTSTR_TAKERIFLE");
	eTrig_use_sniperrifle waittill("trigger");
	eTrig_use_sniperrifle trigger_off();

	level.player takeallweapons();	
	level.player giveWeapon("m14_scoped");
	level.player giveWeapon("beretta");
	level.player switchToWeapon("m14_scoped");	
	
	flag_set("player_has_sniper_rifle");		
}

exit_library()
{
	level waittill ("library_exited");
}


trig_stairwell_roofaccess_reached()
{
	trigger = getEnt( "trig_stairwell_roofaccess_reached", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	

	flag_set("stairwell_ladder_reached");
		
	//Gaz heads into vent
	tempDoorHide(getent("door_vent_bathroom", "targetname"));	
	level.gaz setPosture("crouch");
	level.gaz thread forceToNode("node_friendly_sniper_position");	
	
	//gaz
	//"Right, Andy, Lets get up to the roof and see what we can see"
	level.gaz thread queue_anim("embassy_gaz_letsgettoroof");

	//flag_wait("vent_entrance_reached");

	//gaz
	//"Ok, this is what we want. Follow me."
	//level.gaz thread dialogue_thread("embassy_gaz_ventbash");		
	
	
	//level.gaz thread forceToNode("node_friendly_sniper_position");
	level.gaz waittill ("goal");
	
	level.gaz setPosture("prone");
	
}

trig_enter_vent_roof()
{
	trigger = getEnt( "trig_enter_vent_roof", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("vent_entrance_reached");
}

trig_enter_vent()
{
	trigger = getEnt( "trig_enter_vent", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	
	//cmd
	//"We?ll only have one chance here, Alpha One. Both hostiles need to be taken out at the same time."
	dialogue_radio_thread("embassy_cmd_finalsniperinstructions2");
	
}
trig_enter_vent_section_1()
{
	trigger = getEnt( "trig_enter_vent_section_1", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	

	//gaz
	//"I?ll take up position here and we?ll stay in radio contact. Get into position to get a better angle. We?ll need to hit them at the same time."
	level.gaz thread queue_anim("embassy_gaz_getinposition");	
}
trig_enter_vent_sniper_section()
{
	trigger = getEnt( "trig_enter_vent_sniper_section", "targetname" ); trigger waittill ( "trigger" ); trigger trigger_off();	
	flag_set("sniper_position_reached");

	autosave_by_name ("final sniper sequence");
	wait(1);
	//gaz
	//"Right, don?t fire until I give you the OK. We need to take out both X Rays at the same time otherwise we risk losing hostages"
	level.gaz queue_anim("embassy_gaz_sniperinstruct1");
	
	wait(1.5);
	
	level.hostile_final_snipe_1 = spawnDude(getent("hostile_final_snipe_1", "targetname"));
	level.hostile_final_snipe_1 thread hostile_final_snipe_1_think();
	level.hostile_final_snipe_1 thread door_NPC_open("door_roofend", 1, 2);
	level.hostile_final_snipe_1 waittill ("door_has_been_opened");
	level.hostile_final_snipe_1 thread forceToNode("node_final_snipe_1");
	
	//have everyone ignore eachother 
	ignoreEverybody(true);
	
	//gaz
	//"That?s X Ray One mobile on the rooftop. Hold your fire."
	level.gaz queue_anim("embassy_gaz_sniperinstruct2");	
	
	//start heli on its path
	triggerActivate("trig_heli_end_start");	
	
	wait(2);
	//gaz
	//"Waiting on X Ray Two. Helicopter on approach."
	level.gaz queue_anim("embassy_gaz_sniperinstruct3");	
	
	wait(1.5);
	//gaz
	//"That?s the heli landing on the rooftop. Still no sign of X Ray Two. Hold your fire, Andy."
	level.gaz queue_anim("embassy_gaz_sniperinstruct4");	
	
	wait(3.5);
	//gaz
	//"Bloody hell! He?s shot the pilot. Hold your fire Andy, we need to wait for X Ray Two. Hostage safety is priority One."	
	level.gaz queue_anim("embassy_gaz_sniperinstruct5");	

	wait(2);
	level.hostile_final_snipe_2 = spawnDude(getent("hostile_final_snipe_2", "targetname"));
	level.hostile_final_snipe_2 thread hostile_final_snipe_2_think();

	//have everyone ignore eachother 
	ignoreEverybody(true);
	
	wait(1);
	//gaz
	//"That?s it, Andy. We?ll take them on my signal. You take the one on the right, I?ll take the one on the left."
	level.gaz queue_anim("embassy_gaz_sniperinstruct6");	

	wait(3);
	
	flag_set("sniper_order_given");
	level notify ("sniper_order_given");
	
	//gaz
	//"Now, Andy! Take him out!"
	level.gaz queue_anim("embassy_gaz_takehimoutnow");	
	
	flag_wait ("player_killed_correct_sniper");
	flag_set ("obj_final_boss_complete");
	
	//gaz
	//"Nice one, Andy. Good work... Command, this is Alpha One. All X Rays are down. Zero hostage casualties."
	level.gaz queue_anim("embassy_gaz_snipercomplete");	
	
	//cmd
	//"Roger that, Alpha One. All call signs, evacuate the building. Get back to Incident Control and have a brew. Job well done, lads, job well done."
	dialogue_radio_thread("embassy_cmd_jobwelldone");		
	
}

hostile_final_snipe_1_think()
{
	self thread final_snipe_death_monitor();
	
	level endon ("sniper_order_given");
	
	self waittill ("damage",amount,attacker);
	if (attacker == level.player)
		thread snipe_missionfail(1);
}

hostile_final_snipe_2_think()
{

	self waittill ("damage",amount,attacker);
	
	if (attacker == level.player)
		thread snipe_missionfail(0);
}

final_snipe_death_monitor()
{
	level endon ("mission failed");
	
	flag_wait("sniper_order_given");
	
	self waittillDeathOrPainDeath();
	
	flag_set ("player_killed_correct_sniper");
	
	wait(1);
	
	level.hostile_final_snipe_2 killEntity();	
}


snipe_missionfail(iFailureMessage)
{
	level.player endon ("death");

	level notify ("mission failed");

	aFailureMessage = [];
	aFailureMessage[0]["failure_message"] = "@EMBASSY_MISSION_FAILED_SNIPE_WRONG";	
	aFailureMessage[1]["failure_message"] = "@EMBASSY_MISSION_FAILED_SNIPE_TOO_EARLY";		
	aFailureMessage[2]["failure_message"] = "@EMBASSY_FAILED_SNIPE_WAIT";	
	sFailureMessage	= aFailureMessage[iFailureMessage]["failure_message"];

	setDvar("ui_deadquote", sFailureMessage);
	maps\_utility::missionFailedWrapper();
}


/****************************************************/
/**************** OBJECTIVE FUNCTIONS****************/
/****************************************************/
obj_insert()
{
	objective_number = 0;
	
	//Timed objective
	if (level.usetimer)
	{
		level.stopwatch = 1;
		level thread startTimer();
	}
	
	obj_position = getent ("origin_obj_insertion_point_roof", "targetname");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_INSERT", obj_position.origin);
	objective_current (objective_number);
	
	flag_wait("rappel_point_reached");
	new_position = getent ("origin_obj_insertion_point_balcony", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait ("obj_insert_complete");
	
	objective_state (objective_number, "done");

	if (level.usetimer)
	{
		level thread killTimer();
	}	
}
//obj_window_breach()
//{
//	objective_number = 1;
//
//	
//	obj_position = getent ("origin_obj_window_breach", "targetname");
//	objective_add(objective_number, "active", &"EMBASSY_OBJ_WINDOW_BREACH", obj_position.origin);
//	objective_current (objective_number);
//		
//	flag_wait ("obj_window_breach_complete");
//	
//	objective_state (objective_number, "done");
//		
//}
obj_hostage_secure_office_1()
{
	objective_number = 2;
	
	//Timed objective
	if (level.usetimer)
	{
		level.stopwatch = 1.5;
		level thread startTimer();
	}
	obj_position = getent ("origin_obj_officeA_interior", "targetname");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_HOSTAGE_SECURE_OFFICE_1", obj_position.origin);
	objective_current (objective_number);
	
	flag_wait("officeA_cleared");
	new_position = getent ("origin_obj_officeB_door", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait("officeB1_cleared");
	new_position = getent ("origin_obj_officeD_door", "targetname");
	objective_position(objective_number, new_position.origin);
	
		
	flag_wait ("obj_hostage_secure_office_1_complete");
	
	objective_state (objective_number, "done");
	
	if (level.usetimer)
		level thread killTimer();
}

obj_nav_office_north()
{
	objective_number = 3;
	
	//Timed objective
	if (level.usetimer)
	{
		level.stopwatch = .5;
		level thread startTimer();	
	}
	obj_position = getent ("origin_obj_south_office_exit", "targetname");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_NAV_OFFICE_NORTH", obj_position.origin);
	objective_current (objective_number);
	
	flag_wait("south_office_exit_reached");
	new_position = getent ("origin_obj_north_offices", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait ("obj_nav_office_north_complete");
	
	objective_state (objective_number, "done");
	
	if (level.usetimer)
		level thread killTimer();
}

obj_hostage_secure_office_2()
{
	objective_number = 4;
	
	//Timed objective
	if (level.usetimer)
	{
		level.stopwatch = 2;
		level thread startTimer();
	}
	obj_position = getent ("origin_obj_officeF_door", "targetname"); 
	objective_add(objective_number, "active", &"EMBASSY_OBJ_HOSTAGE_SECURE_OFFICE_2", obj_position.origin);
	objective_current (objective_number);

	flag_wait("officeF_breached");
	new_position = getent ("origin_obj_officeF_interior", "targetname");
	objective_position(objective_number, new_position.origin);
		
	flag_wait("officeF_cleared");
	new_position = getent ("origin_obj_balcony_flank", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait("flanking_balcony_reached");
	new_position = getent ("origin_obj_officeI_interior", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait ("obj_hostage_secure_office_2_complete");
	
	objective_state (objective_number, "done");
	
	if (level.usetimer)
		level thread killTimer();
}

obj_balcony_flank()
{
	objective_number = 5;
	obj_position = getent ("origin_obj_balcony_flank", "targetname");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_BALCONY_FLANK", obj_position.origin);
	objective_current (objective_number);
	
	flag_wait("obj_hostage_secure_office_2_complete");

	objective_state (objective_number, "done");
	
}

//obj_nav_banquet_hall()
//{
//	objective_number = 6;
//	obj_position = getent ("origin_obj_nav_banquet_hall", "targetname");
//	objective_add(objective_number, "active", &"EMBASSY_OBJ_NAV_BANQUET_HALL", obj_position.origin);
//	objective_current (objective_number);
//	
//	flag_wait ("obj_nav_banquet_hall_complete");
//	
//	objective_state (objective_number, "done");
//}

obj_hostage_secure_banquet()
{
	objective_number = 7;
	
	//Timed objective
	if (level.usetimer)
	{
		level.stopwatch = 2;
		level thread startTimer();
	}
	obj_position = getent ("origin_obj_nav_banquet_hall", "targetname");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_HOSTAGE_SECURE_BANQUET", obj_position.origin);	
	
	flag_wait ("nav_banquet_hall_complete");
	
	obj_position = getent ("origin_obj_banquet_reception_interior", "targetname");
	objective_current (objective_number);

	flag_wait("banquet_reception_cleared");
	new_position = getent ("origin_obj_banquet_hall_interior", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait ("obj_hostage_secure_banquet_complete");	
	objective_state (objective_number, "done");
	
	if (level.usetimer)
		level thread killTimer();
}


//obj_banquet_hall_regroup()
//{
//	objective_number = 8;
//	obj_position = getent ("origin_obj_banquet_hall_regroup", "targetname");
//	objective_add(objective_number, "active", &"EMBASSY_OBJ_BANQUET_HALL_REGROUP", obj_position.origin);
//	objective_current (objective_number);
//	
//	flag_wait ("obj_banquet_hall_regroup_complete");	
//	
//	objective_state (objective_number, "done");
//}


obj_bravo_rv()
{
	objective_number = 9;
	
	//Timed objective
	if (level.usetimer)
	{
		level.stopwatch = 1;
		level thread startTimer();
	}
	obj_position = getent ("origin_obj_kitchen_door", "targetname");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_BRAVO_RV", obj_position.origin);
	objective_current (objective_number);

	flag_wait("kitchen_door_breached");
	new_position = getent ("origin_obj_stairwell_kitchen", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait("stairwell_reached");
	new_position = getent ("origin_obj_drawing_room_door", "targetname");
	objective_position(objective_number, new_position.origin);	
		
	flag_wait ("obj_bravo_rv_complete");
	
	objective_state (objective_number, "done");
	
	if (level.usetimer)
		level thread killTimer();
}
obj_reception_clear()
{
	objective_number = 10;
	
	//Timed objective
	if (level.usetimer)
	{
		level.stopwatch = 1;
		level thread startTimer();
	}
	obj_position = getent ("origin_obj_drawing_room_breach_door", "targetname");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_RECEPTION_CLEAR", obj_position.origin);
	objective_current (objective_number);
	
	flag_wait("drawaing_room_exit_breached");
	new_position = getent ("origin_obj_skylight_access_door", "targetname");
	objective_position(objective_number, new_position.origin);

	flag_wait("skylight_access_door_reached");
	new_position = getent ("origin_obj_skylight_roof", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait("skylight_rooftop_reached");
	new_position = getent ("origin_obj_skylight_breach", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait ("obj_skylight_breach_complete");
	new_position = getent ("origin_obj_reception_interior", "targetname");
	objective_position(objective_number, new_position.origin);
	objective_current (objective_number);
	
	flag_wait("obj_reception_clear_complete");
	
	objective_state (objective_number, "done");
	
	if (level.usetimer)
		level thread killTimer();
}
obj_skylight_breach()
{
	objective_number = 11;
	obj_position = getent ("origin_obj_skylight_breach", "targetname");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_SKYLIGHT_BREACH", obj_position.origin);
	objective_current (objective_number);
	
	flag_wait ("obj_skylight_breach_complete");
	
	objective_state (objective_number, "done");
}


obj_courtyard_cover()
{
	objective_number = 12;
	obj_position = getent ("origin_obj_courtyard_cover", "targetname");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_COURTYARD_COVER", obj_position.origin);
	objective_current (objective_number);
	
	flag_wait ("obj_courtyard_cover_complete");
	
	objective_state (objective_number, "done");
}

obj_sniper_assault()
{
	//Timed objective
	if (level.usetimer)
	{
		level.stopwatch = 2.5;
		level thread startTimer();
	}
	objective_number = 13;
	obj_position = getent ("origin_obj_elevator_shaft", "targetname");
	
	objective_add(objective_number, "active", &"EMBASSY_OBJ_SNIPER_ASSAULT", obj_position.origin);
	objective_current (objective_number);

	flag_wait("elevator_shaft_reached");
	new_position = getent ("origin_obj_elevator_rooftop", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait("elevator_rooftop_reached");
	new_position = getent ("origin_obj_library_hallway", "targetname");
	objective_position(objective_number, new_position.origin);

	flag_wait("player_approaching_foyer_frontdoor");
	new_position = getent ("origin_obj_library_sidehall", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait("library_breach_objective_given");
	new_position = getent ("origin_obj_library_breach", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait("library_breached");
	new_position = getent ("origin_obj_library_interior", "targetname");
	objective_position(objective_number, new_position.origin);
	objective_current (objective_number);
		
	flag_wait ("obj_sniper_assault_complete");	
	objective_state (objective_number, "done");
	
	if (level.usetimer)
		level thread killTimer();
}

obj_library_breach()
{
	objective_number = 14;
	obj_position = getent ("origin_obj_library_breach", "targetname");
	flag_set("library_breach_objective_given");
	objective_add(objective_number, "active", &"EMBASSY_OBJ_LIBRARY_BREACH", obj_position.origin);
	objective_current (objective_number);
	
	flag_wait ("obj_library_breach_complete");	
	objective_state (objective_number, "done");
}

obj_final_boss()
{	
	objective_number = 15;
	obj_position = getent ("origin_obj_stairwell_ladder", "targetname");
	
	objective_add(objective_number, "active", &"EMBASSY_OBJ_FINAL_BOSS", obj_position.origin);
	objective_current (objective_number);
	
	flag_wait("stairwell_ladder_reached");
	new_position = getent ("origin_obj_vent_entrance", "targetname");
	objective_position(objective_number, new_position.origin);
	
	flag_wait("vent_entrance_reached");
	new_position = getent ("origin_obj_vent_sniper_position", "targetname");
	objective_position(objective_number, new_position.origin);

	flag_wait("sniper_position_reached");
	new_position = getent ("origin_obj_final_boss", "targetname");
	objective_position(objective_number, new_position.origin);
		
	flag_wait ("obj_final_boss_complete");
	
	objective_state (objective_number, "done");
}

/****************************************************************************
    UTILITY FUNCTIONS
****************************************************************************/
AA_Utility()
{
	//Empty function just for easy access in Ultraedit
}


level_think()
{
	//disable/hide any stuff that needs to be disabled
	//level.eWeapon_sniper_final = getent("weapon_sniper_final", "targetname");
	//level.eWeapon_sniper_final hide();
}

/****************************************************************************
    UTILITY FUNCTIONS: HELICOPTERS
****************************************************************************/
blackhawk_spawn(sStartingAnim)
{
	//get starting location for animation
	vStartingOrigin = getstartorigin( level.heliNode.origin, level.heliNode.angles, level.scr_anim["blackhawk"][sStartingAnim]);
	aStartingAngles = getstartangles( level.heliNode.origin, level.heliNode.angles, level.scr_anim["blackhawk"][sStartingAnim]);
	//spawn the heli and put it in the right place
	eBlackhawk = spawn("script_model", (0,0,0));
	eBlackhawk setmodel("vehicle_blackhawk");
	eBlackhawk.angles = aStartingAngles;
	eBlackhawk.origin = vStartingOrigin;
	eBlackhawk.animnme = "blackhawk";
	
	return eBlackhawk;
}

trigWait(sTrig)
{
	trigger = getEnt(sTrig, "targetname" ); 
	trigger waittill ( "trigger" ); 
	trigger trigger_off();
}

blockerEnable(eBlocker, iBool)
{
	switch(iBool)
	{
	case 0:
		eBlocker hide();
		eBlocker notsolid();
		if (eBlocker.spawnflags & 1)
			eBlocker connectpaths();
		break;
	case 1:
		eBlocker show();
		eBlocker solid();
		if (eBlocker.spawnflags & 1)
			eBlocker disconnectpaths();
		break;		
	}
}

c4_think()
{
	// Variables
	eOrigin = getent(self.target, "targetname");assert(isdefined(eOrigin));
	eExploder = getent(eOrigin.target, "targetname");assert(isdefined(eExploder));
	iExploderNum = eExploder.script_exploder;assert(isdefined(iExploderNum));
	
	//spawn a c4 objective model
	eC4obj = spawn("script_model", eOrigin.origin + (0,0,0));
	eC4obj.angles = eOrigin.angles;
	eC4obj setmodel(level.c4model);	
	
	//turn on the trigger and wait
	self trigger_on();
	self setHintString( &"EMBASSY_HINTSTR_DETONATE");
	self usetriggerrequirelookat();
	self waittill("trigger");
	self trigger_off();	
	
	//swap out obj model with real C4 model - TODO
	
	
	//wait for player to hit detonator - TODO
	
		
	//blow up the exploder
	maps\_utility::exploder(iExploderNum);	
	earthquake (0.6, 2, eOrigin.origin, 1000);
	eOrigin thread play_sound_in_space("rocket_explode_default");
	
	//delete c4 model
	eC4obj delete();
	
	self notify ("c4_has_been_detonated");
		
}

//------------set a guy to never be suppressed and have CQB behavior---------------
setCQBbehavior(bool)
{
	self endon ("death");
	
	self.ignoreSuppression = bool;		
}

getAIarrayTouchingVolume(sTeamName, sVolumeName)
{
	if (sTeamName == "all")
		aTeam = getaiarray();
	else
		aTeam = getaiarray(sTeamName);
	eVolume = getent(sVolumeName, "targetname");
	assertEx(isDefined(eVolume), sVolumeName + " does not exist" );
	
	aGuysTouchingVolume = [];
	for(i=0;i<aTeam.size;i++)
	{
		if (aTeam[i] isTouching(eVolume))
			aGuysTouchingVolume[aGuysTouchingVolume.size] = aTeam[i];
	}
	
	return aGuysTouchingVolume;	
}




rappel_balcony(sAnimEnt, eNode)
{
	self endon ("death");
	
	self setgoalpos(self.origin);
	
	eAnimEnt = getent(sAnimEnt, "targetname");
	assertEx(isDefined(sAnimEnt), "Need to specify a valid script_origin for the rappel sequence");	
	
	self set_animname ("guy");
	
	eAnimEnt thread anim_single_solo (self, "rappel_balcony_1");
	
	self waittillmatch("single anim", "end");
	
	self reset_animname();	
		
	self notify ("balcony_rappel_finished");
	
	//Send the little bastard to a node if one is provided
	if (isdefined(eNode))
	{
		self.goalradius = eNode.radius;
		self setgoalnode(eNode);
	}
	else
		self setgoalpos(self.origin);
		 
}



window_rappel_smash(sWindowName, eNode, bIsBalconyOrSkylight)
{
	
	self endon ("death");
	
	//give a little more health since they are coming in blind
	self.health = 500;
	//make invulnerable until on ground
	self invulnerable(true);
	
	if (!isdefined(bIsBalconyOrSkylight))
		bIsBalconyOrSkylight = false;
	
	self.ignoreme = true;
	
	
	eWindow = undefined;
	eWindow_anim_ent = undefined;
	sAnim = "";
	
	//find window name if it's a window smash
	if (bIsBalconyOrSkylight == false)  //Window tarzaner...will be targeting window, which will target origin
	{
		eWindow = getent(sWindowName, "targetname");
		eWindow_anim_ent = getent(eWindow.target, "targetname");
		assertEx(isDefined(eWindow), "There is no window with this targetname");	
		assertEx(isDefined(eWindow_anim_ent), "Window needs to target a valid script_origin.");			
	}
	else  //Balcony or skylight spawner...will be targeting origin directly
	{
		eWindow_anim_ent = getent(self.target, "targetname");
	}

	
	if ( !isdefined( self.old_animname ) )
		self.old_animname = self.animname;
	self.animname = "guy";	

	if (bIsBalconyOrSkylight == true)
	{
		//decide which anim to play
		if (issubstr(eWindow_anim_ent.script_noteworthy, "skylight_banquet"))
			sAnim = "rappel_skylight_drop";	
		else
			sAnim = "rappel_balcony_1";		
	}
		
	else  //Not a balcony or skylight...play the regular window smash tarzan
		sAnim = "rappel";
	
	
	//Play the damned animation already
	eWindow_anim_ent thread anim_single_solo (self, sAnim);
		
	
	if (bIsBalconyOrSkylight == false)
	{
		self waittillmatch("single anim", "kick");
		eWindow thread window_smash();		
	}

	self waittillmatch("single anim", "end");
	
	self.animname = self.old_animname;
	
	self notify ("window_rappel_finished");
	
	self.ignoreme = false;
	self invulnerable(false);
	
	//Check if the origin is targeting a node
	if ( (!isDefined(eNode)) && (isdefined(eWindow_anim_ent.target)) )
	{
		eNode = getnode(eWindow_anim_ent.target, "targetname");
		assertEx(isDefined(eNode), "The window origin is not targeting a valid node");
	}
	
	//Send the little bastard to a node if one is provided
	if (isdefined(eNode))
	{
		self.goalradius = eNode.radius;
		self setgoalnode(eNode);
	}
}

window_smash()
{
	self playsound ("glass_break");
	self hide();
	self notsolid();
	if (self.spawnflags & 1)
		self connectpaths();

}


// delete all ai touching a given volume - specify 'all' 'axis' 'allies' or 'neutral'
npcDelete(sVolumeName, sNPCtype, boolKill, aExclude)
{
	// For now, always exclude Jack and Gaz just to be sure
	if(!isdefined(aExclude))
	{
		aExclude = [];
		aExclude[0] = level.gaz;
		aExclude[1] = level.jack;
	}
	
	volume = getEnt( sVolumeName, "targetname" );		
	assertEx(isdefined(volume), sVolumeName + " volume does not exist");
	
	if (!isdefined(boolKill))
		boolKill = false;
	
	ai = undefined;
	if (sNPCtype == "all")
		ai = getaiarray();
	else
		ai = getaiarray(sNPCtype);
	assertEx(isdefined(ai), "Need to specify 'all' 'axis' 'allies' or 'neutral' for this function");
	
	//If an array was passed of dudes to exclude, remove them from the array
	if (isdefined(aExclude))
	{
		for(i=0;i<aExclude.size;i++)
		{
		if (is_in_array(ai, aExclude[i]))
			ai = array_remove(ai, aExclude[i]);
		}		
	}
	
	
	for(i=0;i<ai.size;i++)
	{
		if(ai[i] isTouching(volume))
			{
				//regardless of what we do, turn off magic bullet shield
				ai[i] invulnerable(false);
				//decide weather to kill or delete
				if (boolKill == true)
					ai[i] dodamage (ai[i].health + 100, (0,0,0));
				else
					ai[i] delete();
			}
			
	}
}



retreatToVolume(aGuys, sVolumeName)
{
	goalVolume = getEnt( sVolumeName, "targetname" );
	goalNode = getNode( goalVolume.target, "targetname" );
	assert(isDefined(goalVolume));
	assert(isDefined(goalNode));
			
	for(i=0;i<aGuys.size;i++)
	{
		aGuys[i] setGoalNode( goalNode );
		aGuys[i] setGoalVolume( goalVolume );
		aGuys[i].goalradius = goalNode.radius;
	}
}

retreatToNodes(aGuys, sNodes)
{
	aNodes = getnodearray(sNodes, "targetname");
	assert(isdefined(aNodes));
	
	for(i=0;i<aGuys.size;i++)
	{
		if (!isdefined(aGuys[i]))
			return;
		if (!isalive(aGuys[i]))
			return;
		if(isdefined(aNodes[i]))
		{
			aGuys[i] setgoalnode (aNodes[i]);
		}
		else
			assertmsg("not enough nodes for retreaters");
	}
}


getDudeFromArray(aSpawnArray, sScript_Noteworthy)
{
	dude = undefined;
	//loop through the array and find the guy with that script_noteworthy	
	for(i=0;i<aSpawnArray.size;i++)
	{
		if (isDefined(aSpawnArray[i].script_noteworthy) && aSpawnArray[i].script_noteworthy == sScript_Noteworthy)
			dude = aSpawnArray[i];			
	}
	
	assertEX(isdefined(dude), sScript_Noteworthy + " does not exist in this array");
	//Return a reference to the guy
	return dude;
}

getDudesFromArray(aSpawnArray, sScript_Noteworthy)
{
	aDudes = [];
	//loop through the array and find the guy with that script_noteworthy	
	for(i=0;i<aSpawnArray.size;i++)
	{
		if (isDefined(aSpawnArray[i].script_noteworthy) && aSpawnArray[i].script_noteworthy == sScript_Noteworthy)
			aDudes[aDudes.size] = aSpawnArray[i];			
	}

	return aDudes;
}




breachSetup(room)
{
	//get node names on either side of door
	nodeLeft = getNode(room + "_breach_1", "script_noteworthy");
	assertEX(isdefined(nodeLeft), room + "_breach_1 does not exist");
	nodeRight = getNode(room + "_breach_2", "script_noteworthy");
	assertEX(isdefined(nodeRight), room + "_breach_1 does not exist");
	
	//make squad unaware and send them to positions
	aSquad = getSquadArray();
	array_thread(aSquad, ::makeUnaware,true);

	old_goalradius_gaz = level.gaz.goalradius;
	old_goalradius_jack = level.jack.goalradius;
	
	level.gaz.goalradius = 8;
	level.gaz setgoalnode(nodeLeft);
	level.gaz pushplayer(true);

	level.jack.goalradius = 8;
	level.jack setgoalnode(nodeRight);
	level.jack pushplayer(true);
	
	level.gaz waittill("goal");
	level.jack waittill("goal");
	level.gaz pushplayer(false);
	level.jack pushplayer(false);	
		
	array_thread(aSquad, ::makeUnaware,false);	
	level notify (room + "_ready_to_be_breached");
	
	level.gaz.goalradius = old_goalradius_gaz;
	level.jack.goalradius = old_goalradius_jack;	
}





goToNode(sNode)
{
	self endon ("death");
	
	node = getnode(sNode, "targetname");
	assertEx(isdefined(node), sNode + "node does not exist");
	
	self setGoalRadius(node.radius);	
	self setgoalnode(node);
	
	self waittill ("goal");
	self resetGoalRadius();
}

goToNodeAndDelete(sNode)
{
	if (!isdefined(self))
		return;
	if (!isalive(self))
		return;
		
	self endon ("death");
	
	node = getnode(sNode, "targetname");
	assert(isdefined(node));
	
	self setgoalnode(node);
	self setGoalRadius(node.radius);	
	
	self waittill ("goal");
	
	self delete();
}

goToNodeAndWait(sNode)
{
	if (!isdefined(self))
		return;
	if (!isalive(self))
		return;
		
	self endon ("death");
	
	eNode = getnode(sNode, "targetname");
	assert(isdefined(eNode));
	
	self setgoalnode(eNode);
	self setGoalRadius(eNode.radius);	
	
	self waittill ("goal");
	
	self set_animname("guy");
	self holdPosition(true);
	
	self waittill ("stop_waiting_at_node");
	
	self holdPosition(false);
	self resetGoalRadius();
	
}


NPC_Blocker(sNode)
{
	self endon ("death");
	
	eNode = getnode(sNode, "targetname");
	eBlocker = getent(eNode.target, "targetname");
	eNodeAfter = getnode(eBlocker.target, "targetname");
	assert(isdefined(eNode));
	assert(isdefined(eBlocker));

	self setGoalRadius(8);		
	self makeUnaware(true);
	self pushplayer(true);

	self setgoalnode(eNode);
	
	self waittill("goal");
	blockerEnable(eBlocker, 1);
	
	self waittill ("stop_blocking");
	
	blockerEnable(eBlocker, 0);
	self makeUnaware(false);
	self pushplayer(false);
	
	self resetGoalRadius();
	self waittill ("goal");
	
	if (isdefined(eNodeAfter))
		self setgoalnode(eNodeAfter);
}

forceToNode(sNode)
{
	self endon ("death");
	
	self setGoalRadius(8);
		
	node = getnode(sNode, "targetname");
	assertEx(isdefined(node), sNode + "node does not exist");
	self makeUnaware(true);
	self pushplayer(true);

	self setgoalnode(node);
	
	self waittill("goal");
	
	self makeUnaware(false);
	self pushplayer(false);
	
	self resetGoalRadius();

}

triggerEnable(triggerName, bool)
{
	assertEX(isdefined(bool), "Must specify true/false parameter for triggerEnable() function");
	trig = getent(triggername, "targetname");
	assertEx(isDefined(trig), triggerName + " does not exist");
	if (bool == true)
		trig trigger_on();
	else
		trig trigger_off();
}

triggerActivate(sTriggerName)	// Activate a trigger, then delete it
{
	eTrig = getent(sTriggerName, "targetname");
	assert(isdefined(eTrig));
	eTrig notify ("trigger");
	eTrig trigger_off();
	
}

friendlyChainUpdate(chainName)
{
	newChain = getnode(chainName,"targetname");
	assertEx(isDefined(newChain), chainName + " friendlychain does not exist");	
	level.player setFriendlyChain(newChain);
	
	//loop through all spawned ai with the targetname "squad" and put them in an array "aSquad"
	aSquad = getSquadArray();

	//Put the whole squad on the friendlychain	
	array_thread(aSquad, ::putOnChain);
}

getSquadArray()
{
	//loop through all spawned ai with the targetname and script_noteworthy "squad" and put them in an array "aSquad"
	aSquad = [];

	aExistingAllies = getaiarray();		//needs to be all AI since some friendlies may be set to unaware or "neutral"
	for(i=0;i<aExistingAllies.size;i++)
	{
		//check to see that both targetname AND script_noteworthy don't BOTH have "squad
		if (isDefined(aExistingAllies[i].targetname) && isDefined(aExistingAllies[i].script_noteworthy))
		{
			if (aExistingAllies[i].targetname == "squad" && aExistingAllies[i].script_noteworthy == "squad")
				assertmsg("AI cannot have both 'targetname' and 'script_noteworthy' set to 'squad'....it'll screw things up");
		}
			
		//check targetname
		if (isDefined(aExistingAllies[i].targetname) && aExistingAllies[i].targetname == "squad")
			aSquad[aSquad.size] = aExistingAllies[i];
		
		//check script_noteworthy
		else if (isDefined(aExistingAllies[i].script_noteworthy) && aExistingAllies[i].script_noteworthy == "squad")
			aSquad[aSquad.size] = aExistingAllies[i];
		
	}

	return aSquad;
}

putOnChain(guy)
{
	if (!isdefined (guy))
		guy = self;
		
	guy.followmin = level.followmin;
	guy.followmax = level.followmax;
	guy setgoalentity (level.player);
}

makeUnaware(bool)
{
	if (bool == true)
	{
		self set_forcegoal();
		self.grenadeawareness = 0;
		self.ignoreme = true;
		level thread print3Dthread(self, "unaware and ignored");
	}
	else
	{
		self unset_forcegoal();
		self.grenadeawareness = 1;
		self.ignoreme = false;	
		level thread print3Dthread(self, "");	
	}
}

tempDoorHide(door)
{
	assert(isdefined(door));
	door hide();
	door notsolid();
	door connectpaths();
}

/****************************************************************************
    UTILITY FUNCTIONS: HOSTAGE HUMAN SHIELD
****************************************************************************/

human_shield_spawn(sTargetname)
{
	//Spawn pair and get pointers to them
	aShieldPair = level spawnGroup(getEntArray(sTargetname, "targetname"));
	assertEx(aShieldPair.size == 2, "Human shield array must have exactly 2 members");
	eTerrorist = undefined;
	eHostage = undefined;
	
	for(i=0;i<aShieldPair.size;i++)
	{
		aShieldPair[i].ignoreme = true;
		
		if (aShieldPair[i].team == "axis")
			eTerrorist = aShieldPair[i];			
		else
			eHostage = aShieldPair[i];
	}
	//get the node where they will play animations
	eTargetNode = getnode(eTerrorist.target, "targetname");
	
	//Have terrorist and hostage setup and play looping anims
	eHostage thread human_shield_think("hostage", eTargetNode);
	eTerrorist thread human_shield_think("terrorist", eTargetNode);
	
	//deal with player shooting hostage
	eHostage thread kill_hostage_human_shield_mission_fail_think(eTerrorist);
	
	//deal with player shooting terrorist
	eTerrorist thread human_shield_ter_wound_think(eHostage);
	eTerrorist thread human_shield_ter_kill_think(eHostage);
	eTerrorist thread human_shield_ter_death_monitor();
	
	//deal with player approaching terrorist (blindfire)
	eTerrorist thread human_shield_blindfire_think(eHostage, eTargetNode);
	
}

human_shield_blindfire_think(eHostage, eNode)
{
	self endon ("human_shield_over");
	eHostage endon ("human_shield_over");
	
	iDialogueNum = 0;
	
	while (true)
	{
		wait(0.05);
		
		vPlayerOrg = level.player.origin;
		vEnemyOrg = self.origin;
		if (distance (vPlayerOrg, vEnemyOrg) < 200)
		{
			iDialogueNum ++;
			//when player is within range, play blindfire and dialogue			
			//self thread dialogue_thread("embassy_ter_humanshieldbackoff" + iDialogueNum);
			
			self notify("stop_idle");
			self thread anim_single_solo (self, "human_shield_duck_blindfire", undefined, eNode); 
			self.allowdeath = true;
			
			eHostage notify("stop_idle");
			eHostage thread anim_single_solo (eHostage, "human_shield_duck_blindfire", undefined, eNode); 
			self.allowdeath = true;
			
			self waittillmatch("single anim", "end");
			
			//go back to playing looping anim
			self thread anim_loop_solo(self, "human_shield_idle", undefined, "stop_idle", eNode);
			self.allowdeath = true;
			eHostage thread anim_loop_solo(eHostage, "human_shield_idle", undefined, "stop_idle", eNode);
			eHostage.allowdeath = true;
			
			//reset dialogue num to zero if at end
			if (iDialogueNum == 4)
				iDialogueNum = 0;
			
			wait(randomfloatrange(1.5, 3));
		}
	}

}


kill_hostage_human_shield_mission_fail_think(eTerrorist)
{
	self endon ("human_shield_over");
	
	//self = hostage
	level endon ("mission failed");
	
	self waittill ("death", attacker);
	
	self notify ("stop_idle");
	
	if (!isdefined (attacker))
			return;
	if (attacker == level.player)	
	{
		level thread killhostage_missionfail();
		eTerrorist thread human_shield_reset_ai("terrorist", 2); //<----2 is the number that cooresponds to appropriate anim to play b4 restoring normal AI
	}		
}

human_shield_ter_wound_think(eHostage)
{
	self endon ("death");
		
	self waittill ("damage",amount,attacker);
	
	if (!isdefined (self))
		return;
	
	//restore ai on both terrorist and hostage
	self thread human_shield_reset_ai("terrorist", 1); //<----1 is the number that cooresponds to appropriate anim to play b4 restoring normal AI
	eHostage thread human_shield_reset_ai("hostage", 1);
}

human_shield_ter_kill_think(eHostage)
{
	self endon ("human_shield_over");
	
	self waittillDeathOrPainDeath();

	//restore default AI on hostage
	eHostage thread human_shield_reset_ai("hostage", 0);  //<----0 is the number that cooresponds to appropriate anim to play b4 restoring normal AI (running away)		
}

human_shield_ter_death_monitor()
{
	self waittillDeathOrPainDeath();
	
	level notify ("human_shield_terrorist_dead");
}


waittillDeathOrPainDeath()
{
	self endon ("death");
	self waittill ("pain_death"); // pain that ends in death
}

human_shield_think(sAItype, eTargetNode)
{
	//Setup AI of terrorist and hostage and play looping anim
	self endon ("death");
	
	self.pushplayer = true;
	
	switch(sAItype)
	{
	case "hostage":
		self.animname = "hostage";
		self set_deathanim(%hostage_human_shield_host_death);
		self.team = "neutral";
		self.pacifist = 1;
		self.health = 200;	
		self.pathenemyfightdist = 8;
		self.pathenemylookahead = 8;
		self.maxsightdistsqrd = 1;	
		self setFlashbangImmunity( true );
		break;
	case "terrorist":
		self.animname = "guy";
		self set_deathanim(%terrorist_human_shield_ter_death);
		self setFlashbangImmunity( true );
		//self animscripts\shared::putGunInHand ("none");
		
		break;
	}

	//Play looping human shield animation
	self thread anim_loop_solo(self, "human_shield_idle", undefined, "stop_idle", eTargetNode);
	self.allowdeath = true;
	
	
	
	
}


human_shield_flashbang_think()
{
	
}

human_shield_proximity_think()
{
	
}

human_shield_reset_ai(sAItype, iAnim)
{
	self notify ("human_shield_over");
	
	if (!isdefined (self))
		return;
	
	self endon ("death");

	self reset_deathanim();
	self.pushplayer = false;
	
	//Decide which anim to play (if any)
	aAnim = [];
	aAnim[0]["ending_anim"] = "human_shield_ter_death";		//terrorist is dead, hostage runs away (HOSTAGE ONLY)
	aAnim[1]["ending_anim"] = "human_shield_ter_pain";		//terrorist wounded, hostage runs away
	aAnim[2]["ending_anim"] = "human_shield_host_death";	//hostage killed, terrorist recolis    (TERRORIST ONLY)
	sAnim	= aAnim[iAnim]["ending_anim"];
		
	//play the animation if there is one, then go back into normal AI
	if (isdefined(iAnim))
	{
		self notify ("stop_idle");
		self thread anim_single_solo (self, sAnim, undefined);
		self.allowdeath = true;
		self waittillmatch("single anim", "end");
	}
		
	switch(sAItype)
	{
	case "hostage":
		//put hostage-specific stuff here
		self thread kill_hostage_mission_fail_think();
		self setGoalRadius(0);
		self.setGoalPos = self.origin;
		self allowedstances("prone");
		wait(2);
		self allowedstances("crouch","stand","prone");
		break;
	case "terrorist":
		//put terrorist-specific stuff here
		//self.ignoreme = false;
		break;
	}	
}

human_shield_friendlies(sNodeName)
{
	aFriendlies = [];
	aFriendlies[0] = level.gaz;
	aFriendlies[1] = level.jack;
	aNodes = getnodearray(sNodeName, "targetname");
	assert(isdefined(aNodes));
		
	for(i=0;i<aFriendlies.size;i++)
		aFriendlies[i] thread human_shield_frnd_think(aNodes[i]);
	
}

human_shield_frnd_think(eNode)
{
	self setGoalRadius(eNode.radius);	
	self setgoalnode(eNode);
	
	level waittill ("human_shield_terrorist_dead");
	//self waittill ("goal");
		
	self resetGoalRadius(); 
}

/****************************************************************************
    UTILITY FUNCTIONS: HOSTAGES
****************************************************************************/
hostage_think()
{
	self thread kill_hostage_mission_fail_think();
	
	self endon ("death");
	self.animname = "hostage";
	self.team = "neutral";
	self.pacifist = 1;
	self.health = 200;	
	self setFlashbangImmunity( true );
	self.pathenemyfightdist = 8;
	self.pathenemylookahead = 8;
	self.maxsightdistsqrd = 1;

	//self animscripts\shared::PutGunInHand("none");
	//self.hasWeapon = 0;
	
	eTarget = undefined;
	eTargetNode = undefined;
	sAnim_Name = undefined;
	sAnim_Name_Flinch = undefined;
		
	//check to see if hostage is targeting a node or model
	if (isdefined(self.target))
	{
		eTarget = getent(self.target, "targetname");
		eTargetNode = getnode(self.target, "targetname");
	}
	
	// HOSTAGE PATHNODE TARGET: If the hostage is target ing a node, play a looping anim if one is specified
	if ( (isdefined(eTargetNode)) && (isdefined(eTargetNode.script_noteworthy)) )
	{
		// Figure out which anim is in the node (if any)
		switch(eTargetNode.script_noteworthy)
		{
			case "kneel":
				sAnim_Name = "hostage_knees_idle";
				sAnim_Name_Flinch = "hostage_knees_twitch";
				self thread hostage_idle_and_flinch(sAnim_Name, sAnim_Name_Flinch, eTargetNode, true);
				break;
			case "prone":
				sAnim_Name = "hostage_facedown_idle";
				sAnim_Name_Flinch = "hostage_facedown_twitch";
				self thread hostage_idle_and_flinch(sAnim_Name, sAnim_Name_Flinch, eTargetNode, true);
				break;	
			case "fetal":
				sAnim_Name = "hostage_fetal_idle";
				sAnim_Name_Flinch = "hostage_fetal_roll";
				self thread hostage_idle_and_flinch(sAnim_Name, sAnim_Name_Flinch, eTargetNode, true);
				break;	
			case "run_and_cower":
				self thread hostage_run_and_cower(eTargetNode);
				break;
		}		
	}
			

	
	
	// HOSTAGE SCRIPT_MODEL TARGET: If the hostage is targeting a model, play a looping anim if one is specified
	if ( (isdefined(eTarget)) && (eTarget.classname == "script_model") && (isdefined(eTarget.script_noteworthy)) )
	{
		// this ent is needed for animations
		eAnimEnt = spawn( "script_origin", eTarget.origin);
		eAnimEnt.angles = eTarget.angles;
		assert(isdefined(eAnimEnt));
		
		// Figure out what model the hostage is targeting, and play appropriate anim
		switch(eTarget.script_noteworthy)
		{
			case "chair":
				sAnim_Name = "hostage_chair_idle";
				sAnim_Name_Flinch = "hostage_chair_twitch";
				self thread hostage_idle_and_flinch(sAnim_Name, sAnim_Name_Flinch, eAnimEnt);
				break;
			case "table":
				//
				//
				break;	
		}	
		
	}



}



hostage_run_and_cower(eNode)
{
	self endon ("death");
	
	self.goalradius = eNode.radius;
	self setgoalnode(eNode);	
	self waittill ("goal");
	
	self holdPosition(true, "crouch");
}

hostage_idle_and_flinch(sAnim_Name, sAnim_Name_Flinch, eTarget, bIsNode)
{
	self endon ("death");
	
	if (!isdefined(bIsNode))
		bIsNode = false;
	sAnimType = undefined;
	assert(isdefined(eTarget));
	
	if (bIsNode == true)
		self thread anim_loop_solo(self, sAnim_Name, undefined, "stop_idle", eTarget);		

	else
		eTarget thread anim_loop_solo(self, sAnim_Name, undefined, "stop_idle");		

	//	anim_loop_solo( guy, anime, tag, ender, node, tag_entity )

	self.allowdeath = true;
	
	//use int to determine which flinch to play
	iFlinchNumber = 0;
	
	if (isdefined(sAnim_Name_Flinch))
	{
		while (true)
		{
			iFlinchNumber++;			
			
			wait (randomfloatrange(3.5,8));
			if (bIsNode == true)
				self notify ("stop_idle");
			else
				eTarget notify ("stop_idle");
			
			//play either the flinch or the alternate flinch
			if (iFlinchNumber == 1)
				self anim_single_solo (self, sAnim_Name_Flinch);
			else
			{
				self anim_single_solo (self, sAnim_Name_Flinch + "2");
				iFlinchNumber = 0;
			}
			
			self waittillmatch("single anim", "end");
			
			if (bIsNode == true)
				self thread anim_loop_solo(self, sAnim_Name, undefined, "stop_idle", eTarget);
			else 
				eTarget thread anim_loop_solo(self, sAnim_Name, undefined, "stop_idle");	
				
			
		}		
	}

}


kill_hostage_mission_fail_think()
{
	level endon ("mission failed");
	
	self waittill ("death", attacker);
	
	self notify ("stop_idle");
	
	if (!isdefined (attacker))
			return;
	if (attacker == level.player)
		thread killhostage_missionfail();	
}

killhostage_missionfail()
{
	level.player endon ("death");

	level notify ("mission failed");
	
	setDvar("ui_deadquote", "@EMBASSY_MISSION_FAILED_HOSTAGE_KILLED");
	maps\_utility::missionFailedWrapper();
}



/****************************************************************************
    UTILITY FUNCTIONS: SPAWNING
****************************************************************************/
spawned_dead_guy_think()
{
	self endon ("death");
	
	self invulnerable(true);
	self.ignoreme = true;
	self setFlashbangImmunity( true );
	
	eTarget = undefined;
	
	//See if he's targeting a script_origin with animation instructions
	if (isdefined(self.target))
		eTarget = getent(self.target, "targetname");
		
	if ( (isdefined(eTarget)) && (eTarget.classname == "script_origin") && (isdefined(eTarget.script_noteworthy)) )
	{
		
		sAnim = "";
		
		switch(eTarget.script_noteworthy)
		{
			case "window_death":
				sAnim = "death_pose_on_window";
				break;
			case "desk_death":
				sAnim = "death_pose_on_desk";
				break;	
			default:
				assertmsg("this dead guy is targeting a script_origin with no known animation state defined");	
		}
		
		//Make him invincible and play the looping animation
		if (sAnim != "")
		{
			self.animname = "guy";
			eTarget thread anim_loop_solo (self, sAnim, undefined, "stop_idle");
			self.allowdeath = false;	
		}
	
		
	}
	
	
	//Otherwise, just kill the little bastard
	else
		self killEntity();
	
	
	
	
}
spawnDude(eEntToSpawn)
{
	spawnedGuy = eEntToSpawn dospawn();
	spawn_failed( spawnedGuy );
	assert( isDefined( spawnedGuy ) );
	
	//Check to see if this guy is a hostage
	if ( (isdefined(spawnedGuy.script_friendname)) && (spawnedGuy.script_friendname == "Pvt. Hostage") )
		spawnedGuy thread hostage_think();
		
	//Check to see if this guy is an "ambient dead guy" 
	//(kill him as soon as he's spawned for room decor, or have him playing a cool looping death pose
	if ( (isdefined(spawnedGuy.script_noteworthy)) && (spawnedGuy.script_noteworthy == "dead") )
		spawnedGuy thread spawned_dead_guy_think();
		
	//Check to see if he is a window spawner
	if (isdefined(spawnedGuy.target))
	{
		eTarget = getent(spawnedGuy.target, "targetname");
		if ( (isdefined(eTarget)) && (isdefined(eTarget.script_noteworthy)) && (eTarget.script_noteworthy == "window" ) )
			spawnedGuy thread window_rappel_smash(eTarget.targetname);
	}
	
	//Check to see if he is a balcony_rappel spawner
	if (isdefined(spawnedGuy.target))
	{
		eTarget = getent(spawnedGuy.target, "targetname");
		if ( (isdefined(eTarget)) && (isdefined(eTarget.script_noteworthy)) && (eTarget.script_noteworthy == "balcony" ) )
			spawnedGuy thread window_rappel_smash(eTarget.targetname, undefined, true);
	}

	//Check to see if he is a skylight spawner
	if (isdefined(spawnedGuy.target))
	{
		eTarget = getent(spawnedGuy.target, "targetname");
		if ( (isdefined(eTarget)) && (isdefined(eTarget.script_noteworthy)) && (eTarget.script_noteworthy == "skylight_banquet" ) )
			spawnedGuy thread window_rappel_smash(eTarget.targetname, undefined, true);
	}
	
			
	//spawnedGuy.health = 500;
		
	return spawnedGuy;
}

	
spawnGroup(arrayToSpawn)
{
	spawnedGuys = [];
	for (i=0;i<arrayToSpawn.size;i++)
	{
		guy = spawnDude(arrayToSpawn[i]);
		spawnedGuys[spawnedGuys.size] = guy;
		
	}
	//check to ensure all the guys were spawned
	assertEx((arrayToSpawn.size == spawnedGuys.size), "Not all guys were spawned successfully");
	
	//Return an array containing all the spawned guys
	return spawnedGuys;
}




ignoreEverybody(bool)
{
	level thread teamIgnoreMe("axis", bool);
	level thread teamIgnoreMe("allies", bool);
	level.player.ignoreme = bool;	
}

teamIgnoreMe(whichTeam, bool)
{
	team = getaiarray(whichTeam);

	for(i = 0; i < team.size; i++)
		if (bool == true)
		{
			team[i].ignoreme = true;
			level thread print3Dthread(team[i], "ignored");
		}
		else
		{
			team[i].ignoreme = false;	
			level thread print3Dthread(team[i], "");
		}
}

setupPrecache()
{  
	level.c4model = "mil_tntbomb_mp";
	precacheModel(level.c4model);
	
	
	//Models and shaders
	precacheShader("hudStopwatch");
	precacheShader("hudStopwatchNeedle");	
	precacheModel("vehicle_blackhawk");
	
	//Strings: Intro screen
	precacheString(&"EMBASSY_TITLE");
	precacheString(&"EMBASSY_PLACE");
	precacheString(&"EMBASSY_DATE");
	precacheString(&"EMBASSY_INFO");
	
	//Strings: Objectives
	precacheString(&"EMBASSY_OBJ_INSERT");
	precacheString(&"EMBASSY_OBJ_WINDOW_BREACH");
	precacheString(&"EMBASSY_OBJ_HOSTAGE_SECURE_OFFICE_1");
	precacheString(&"EMBASSY_OBJ_HOSTAGE_SECURE_OFFICE_2");
	precacheString(&"EMBASSY_OBJ_BALCONY_FLANK");
	precacheString(&"EMBASSY_OBJ_NAV_BANQUET_HALL");	
	precacheString(&"EMBASSY_OBJ_HOSTAGE_SECURE_BANQUET");
	precacheString(&"EMBASSY_OBJ_BANQUET_HALL_REGROUP");
	precacheString(&"EMBASSY_OBJ_BRAVO_RV");
	precacheString(&"EMBASSY_OBJ_RECEPTION_CLEAR");
	precacheString(&"EMBASSY_OBJ_SKYLIGHT_BREACH");
	precacheString(&"EMBASSY_OBJ_COURTYARD_COVER");
	precacheString(&"EMBASSY_OBJ_SNIPER_ASSAULT");
	precacheString(&"EMBASSY_OBJ_LIBRARY_BREACH");
	precacheString(&"EMBASSY_OBJ_FINAL_BOSS");
	
	//Strings: Hints	
	precacheString(&"EMBASSY_HINTSTR_DETONATE");
	precacheString(&"EMBASSY_HINTSTR_LADDER_DISMOUNT");	
	precacheString(&"EMBASSY_HINTSTR_FASTROPE");	
	precacheString(&"EMBASSY_HINTSTR_TAKERIFLE");	
	precacheString(&"EMBASSY_HINTSTR_FLASHBANG");
	precacheString(&"EMBASSY_HINTSTR_BREACH");
	precacheString(&"EMBASSY_HINTSTR_ROPE_GRAB");
	precacheString(&"EMBASSY_HINTSTR_ROPE_RAPPEL");
	precacheString(&"EMBASSY_EXPLOSIVES_PLANTED");
		
	//Strings: Timer labels
	precacheString(&"EMBASSY_TIMER_LABEL");
	
	//Strings: Mission failure
	precacheString(&"EMBASSY_MISSION_FAILED_GENERIC");
	precacheString(&"EMBASSY_MISSION_FAILED_HOSTAGE_KILLED");
	precacheString(&"EMBASSY_MISSION_FAILED_HOSTAGE_KILLED");
	
	//Dev strings
	precacheString(&"HINTSTR_LEVELEND");
	
}

setupPlayer()
{
	level.player takeallweapons();	
	level.player giveWeapon("flash_grenade");
	level.player giveWeapon("MP5sd");
	level.player giveWeapon("beretta");
	level.player switchToWeapon("MP5sd");
	level.player setOffhandSecondaryClass( "flash" );

	//give unlimited flashbangs for now
	level.player thread unlimitedFlashbangs();
}

unlimitedFlashbangs()
{
    self endon("death");

    while(true)
    {
        level.player giveMaxAmmo("flash_grenade");
        wait(1);
    }	
}



setupCharacters()
{
	level.cmd = level.player;
	level.cmd.animname = "cmd";
	level.sierra = level.player;
	level.sierra.animname = "sierra";
	
	level.gaz = getent("gaz", "script_noteworthy");
	level.gaz.animname = "gaz";
	level.gaz.anim_disablePain = true;
	level.gaz thread maps\_utility::magic_bullet_shield();
	level.gaz.followmax = level.followmax;
	level.gaz setFlashbangImmunity( true );
	//level.gaz.interval = 0;	
	
	level.jack = getent("jack", "script_noteworthy");
	level.jack.animname = "jack";
	level.jack.anim_disablePain = true;
	level.jack thread maps\_utility::magic_bullet_shield();
	level.jack.followmax = level.followmax;
	level.jack setFlashbangImmunity( true );
	//level.jack.interval = 0;	
}

holdPosition(bool, sPostureName)
{	

	self endon ("death");
	
	if (!isdefined(self))
		return;
	if (!isalive(self))
		return;
	if (bool == true)
	{	
		if ( (isdefined(self.holdPos )) && (self.holdPos == true) )
			return;
			
		self.holdPos = true;
//		level thread print3Dthread (self, "holdPos");
//		self set_forcegoal();
//		self setGoalRadius(0);
//		self.setGoalPos = self.origin;
//		if (isdefined(sPostureName))	
//			self allowedStances (sPostureName);
		self.dontavoidplayer = true;
		self pushplayer(true);
		
		self setFlashbangImmunity( true );
		self thread anim_loop_solo (self, "stand_idle", undefined, "stop_hold_pos");
		

	}
	else
	{
		self.holdPos = false;
//		level thread print3Dthread (self, "");
//		self unset_forcegoal();
//		self resetGoalRadius();
//		self allowedStances ("stand", "crouch", "prone");
		self pushplayer(false);
		self.dontavoidplayer = false;	
		
		self notify ("stop_hold_pos");
	
	}
		

}

hideMe()
{
	switch (self.classname)
	{
		case "script_model":		
			self hide();
			break;	

		case "script_brushmodel":		
			self hide();
			self notsolid();
			if (self.spawnflags & 1)
				self connectpaths();
			break;	
	}
}

hideAll(stuffToHide)
{
	//If stuff to hide is not passed, hide everything tagged to be hidden
	if (!isDefined (stuffToHide))
		stuffToHide = getentarray("hide", "script_noteworthy");	
		
	for (i=0;i<stuffToHide.size;i++)
	{
		entity = stuffToHide[i];
		switch (entity.classname)
		{
			case "script_model":		
				entity hide();
				break;	

			case "script_brushmodel":		
				entity hide();
				entity notsolid();
				if (entity.spawnflags & 1)
					entity connectpaths();

				break;	
			
			case "trigger_multiple":
				entity trigger_off();
				break;	
				
			case "trigger_use":
				
				entity hide();
				entity trigger_off();
				break;	
				
			case "trigger_use_touch":
				
				entity hide();
				entity trigger_off();
				break;	

			case "trigger_damage":
				entity trigger_off();
				break;	
				
			case "trigger_hurt":
				entity trigger_off();
				break;	
				
			case "trigger_lookat":
				entity trigger_off();
				break;			
		}
		
	}
}

doorCameraCheck(sDoorName)
{
	sDoorNode = "node_doorCameraCheck_" + sDoorName;
	
	self thread forceToNode(sDoorNode);
	self waittill("goal"); 
	self setPosture("crouch");
	
	wait(2);
	
	level notify ("door_camera_check_complete");
	
	self setPosture("all");	
}


setPosture(posture)
{
	if (posture == "all")
		self allowedStances ("stand", "crouch", "prone");
	else
		self allowedStances (posture);		
		
}

invulnerable(bool)
{
	if (bool == false)
		self notify ("stop magic bullet shield");
	else
		self thread maps\_utility::magic_bullet_shield();	
				
	self.anim_disablePain = bool;
}

killEntity()
{	
	self endon ("death");

	if (!isdefined(self))
		return;
	if (!isalive(self))
		return;	
	
	self.allowdeath = true;
	self invulnerable(false);
	self doDamage (self.health + 1, self.origin);
}	


goToVolume(sVolumeName)
{
	self endon ("death");
	goalVolume = getEnt( sVolumeName, "targetname" );
	goalNode = getNode( goalVolume.target, "targetname" );
	assertEx(isdefined(goalVolume), "Need to specify a valid volume name vor this function");
	assertEx(isdefined(goalNode), "The volume needs to target a node for this function to work properly");
	
	self setGoalNode( goalNode );
	self setGoalVolume( goalVolume );
	self.goalradius = goalNode.radius;
}

hostage_evac(sRoomName, aFriendlies)
{
	//For now, just send to volume, have them stay put and put a message over their heads
	sVolumeName = "volume_" + sRoomName;
	for(i=0;i<aFriendlies.size;i++)
	{
		if(!isalive(aFriendlies[i]))
		{
			aFriendlies[i] thread goToVolume(sVolumeName);
			level thread print3Dthread (aFriendlies[i], "evacuating hostages");
		}
	}
		
	
}


killplayer()
{
	level.player enableHealthShield( false );
	level.player doDamage (level.player.health, level.player.origin);	//killplayer
	level.player enableHealthShield( true );
}


startTimer()
{
	//destroy any prvious timer just in case
	killTimer();

	if ( getdvar("embassy_notimer") == "1" )
		return;
	
	//destroy timer and thread if objectives completed within limit
	level endon ("kill_timer");
	
	level.hudTimerIndex = 20;

	//Timer size and positioning	
	level.timer = newHudElem();
	level.timer.alignX = "left";
	level.timer.alignY = "middle";
	level.timer.horzAlign = "right";
    level.timer.vertAlign = "top";
    if(level.xenon)
	{
		level.timer.fontScale = 2;
		level.timer.x = -225;
	}
	else
	{
		level.timer.fontScale = 1.6;    
		level.timer.x = -180;
	}
	level.timer.y = 100;
	level.timer.label = &"EMBASSY_TIMER_LABEL";
	level.timer setTimer(level.stopwatch*60);

	//Wait until timer expired
	wait (level.stopwatch * 60);
	flag_set("timer_expired");

	//Get rid of HUD element and fail the mission
	level.timer destroy();	
	
	level thread mission_failed_out_of_time();
}


mission_failed_out_of_time()
{
	level.player endon ("death");
	level endon ("kill_timer");

	level notify ("mission failed");	
	setDvar("ui_deadquote", level.missionFailedQuote);
	maps\_utility::missionFailedWrapper();	
}

killTimer()	
{
	level notify ("kill_timer");
	if (isdefined (level.timer))
		level.timer destroy();		
}
	
	
msg(string)
{
	if (level.debug_mode == false)
		return;	
	iprintlnbold(string);
}



dialogue_radio_thread(dialogue)
{
	play_sound_in_space(dialogue, level.player.origin);
	//level.radioorg playsound (sound,"sounddone");
	//level.radioorg waittill ("sounddone");
	
}


get_closest_ally()
{
	excluders = [];
	excluders[0] = level.jack;
	excluders[1] = level.gaz;
	
	guy = get_closest_ai_exclude (level.player getorigin(), "allies", excluders);

	guy.animname = "guy";
	return guy;
}

groupWarp(aGroupToBeWarped, sNodesToWarpTo)
{
	aNodes = getnodearray(sNodesToWarpTo, "targetname");
	assert(isdefined(aNodes));
	
	for(i=0;i<aGroupToBeWarped.size;i++)
	{
		if(isdefined(aNodes[i]))
		{
			aGroupToBeWarped[i] teleport (aNodes[i].origin);
		}		
	}
}

/****************************************************/
/**************** LEVEL SKIPTO FUNCTIONS**************/
/****************************************************/
skipWarp(skipToString)
{

	
	//specific setup for each skipto case

 	if (skipToString == "southoffices")
 	{
 		
 		//warp everyone to proper positions
 		level thread skipWarpSquad(skipToString);	
		rooftop_character_setup();
		level thread group_absail_sequence();
		wait(1);
		level thread balcony_rappel_gaz();
		level thread balcony_rappel_jack();
		flag_set("player_landed_on_rooftop");
		flag_set("player_has_started_balcony_absail");
		flag_set("rappel_point_reached");
		
		level thread setup_enemies_office_a();
		
 		level thread AA_southOffices_init();


 	}	
	
 	if (skipToString == "northoffices")
 	{
 		flag_set("south_office_exit_reached");
 		
		AA_northOffices_init();
		
		// warp player and 2 friendlies to south offices exit stairway
		level thread skipWarpSquad(skipToString);
		
		//force squad to next positions asap
		level.gaz thread forceToNode("squad_north_offices_start_1");
		level.jack thread forceToNode("squad_north_offices_start_2");	
		
		// delete any guys left behind
		level thread npcDelete("volume_rooftop_offices_south", "all");	
		
 	}
  	if (skipToString == "conferencehall")
 	{
 		//Spawn guy who will kick open conf hall door
 		level thread trig_conf_door_setup();
 		trigger = getEnt( "trig_conf_door_setup", "targetname" ); trigger notify ( "trigger" ); trigger trigger_off();
 		
 		//Start thread for approaching conf hall door
 		level thread trig_conferenceHall_door_approach();
 		triggerEnable("trig_conferenceHall_door_approach", true);
 		
 		//Warp Gaz and Jack to proper positions
 		level thread skipWarpSquad(skipToString);
 			
		wait(1);
		// delete any guys left behind
		level thread npcDelete("volume_rooftop_offices_south", "all");	
	
		//squad to positions by door
		level thread friendlies_go_to_conf_hall_door();
 	}
 	
   	if (skipToString == "mezzanine")
 	{	
 		level thread trig_approach_mezzanine_door();
 		
 		level thread skipWarpSquad(skipToString);	 		

		wait(1);
		// delete any guys left behind
		level thread npcDelete("volume_rooftop_offices_south", "all");	
 	}
 	
 	if (skipToString == "reception")
 	{
 		//spawn all guys in drawing room
 		level thread ai_setup_drawing_room();	
 		
 		level waittill ("ai_setup_drawing_room_complete");
 		
 	 	//kill all the hostiles in reception
 		npcDelete("volume_reception", "all", true); 	
 		
		aSquad = getSquadArray();
		for(i=0; i<aSquad.size; i++)
		{
			aSquad[i] holdPosition(false);
			aSquad[i] makeUnaware(false);
		}
 
 		//warp all to proper positions
 		level thread skipWarpSquad(skipToString);	
 		
 		//start the courtyard sniper sequence and all other threads 		
 		level thread AA_elevator_assault_init();
 		
		// delete any guys left behind
		level thread npcDelete("volume_rooftop_offices_south", "all");	
		
		//level.bravo_backdraft holdPosition(false);
		//level.bravo_backdraft killEntity();
		
 	}
  	if (skipToString == "libhall")
 	{		
 		//warp all to proper positions
 		level thread skipWarpSquad(skipToString);	
 		level thread foyer_door_slam();
 		
 		level thread AA_lib_assault_init();
 		
 		wait(1);
		// delete any guys left behind
		level thread npcDelete("volume_rooftop_offices_south", "all");		
		
 		flag_set("library_foyer_cleared");
 		flag_set("player_approaching_foyer_sidedoor");
 		level thread door_close("door_libraryfoyer");
 	} 	
 	
  	if (skipToString == "end")
 	{		
 		//warp all to proper positions
 		level thread skipWarpSquad(skipToString);	
 		
 		level thread AA_final_battle_init();
 		
 		wait(1);
		// delete any guys left behind
		level thread npcDelete("volume_rooftop_offices_south", "all");		
		
 		flag_set("library_foyer_cleared");
 		flag_set("player_approaching_foyer_sidedoor");
 		level thread door_close("door_libraryfoyer");
 	} 	 	
}

skipWarpSquad(skipToString)
{
 	//Warp player and squad	
 	tempPlayerNode = getNode("tempWarp", "targetname");
	playerNode = getNode("playerWarp_" + skipToString, "targetname");
	squadNodes = getnodearray("squadWarp_" + skipToString, "targetname");
	
	assertEx(isDefined(playerNode), "node doesn't exist: playerWarp_" + skipToString);
	assertEx(isDefined(squadNodes), "nodes don't exist: squadWarp_" + skipToString);
	
	//warp player to temp node so he can't see
	level.player setorigin (tempPlayerNode.origin);
	
	wait(0.05);
	//now warp dudes
	squadWarp(squadNodes);
	
	wait(0.5);
	//now warp player to proper place
	level.player setorigin (playerNode.origin);
	level.player setplayerangles (playerNode.angles);
}

squadWarp(aSquadNodes)
{
	aSquad = getSquadArray();
	for(i=0; i<aSquad.size; i++)
	{
		if(isdefined(aSquadNodes[i]))
		{
			aSquad[i] teleport (aSquadNodes[i].origin);
		}
	}		
}

playerWeaponTempRemove()
{
	// Take away all player weapons
	playerWeapon[0] = level.player getweaponslotweapon("primary");
	playerWeapon[1] = level.player getweaponslotweapon("primaryb");
	playerWeapon_Ammo[0] = level.player getweaponslotammo("primary");
	playerWeapon_Ammo[1] = level.player getweaponslotammo("primaryb");
	playerWeapon_ClipAmmo[0] = level.player getweaponslotclipammo("primary");
	playerWeapon_ClipAmmo[1] = level.player getweaponslotclipammo("primaryb");
	playerCurrentWeapon = level.player getcurrentweapon();
	level.player takeWeapon(playerWeapon[0]);
	level.player takeWeapon(playerWeapon[1]);
		
	level.player waittill ("restore_player_weapons");
	
	
	// Restore all player weapons
	if (playerWeapon[0] != "none")
	{
		level.player giveWeapon(playerWeapon[0]);
		level.player setweaponslotammo("primary", playerWeapon_Ammo[0]);
		level.player setweaponslotclipammo("primary", playerWeapon_ClipAmmo[0]);
	}
	
	if (playerWeapon[1] != "none")
	{
		level.player giveWeapon(playerWeapon[1]);
		level.player setweaponslotammo("primaryb", playerWeapon_Ammo[1]);
		level.player setweaponslotclipammo("primaryb", playerWeapon_ClipAmmo[1]);
	}
	
	if (playerWeapon[0] == playerCurrentWeapon)
	{
		if (playerWeapon[0] != "none")
			level.player switchToWeapon(playerWeapon[0]);
	}
	else
	if (playerWeapon[1] == playerCurrentWeapon)
	{
		if (playerWeapon[1] != "none")
			level.player switchToWeapon(playerWeapon[1]);
	}
	
}




/****************************************************/
/**************** BREACH FUNCTIONS ******************/
/****************************************************/

breach_variable_setup(sRoomName, aFriendlies, iBreach_id)
{
	//reset all vars back to undefined
	level.friendliesReadyToBreach = 0;
	level.eTrigger_breach_approach = undefined;
	level.eDoor = undefined;
	level.eTrigger_enter = undefined;
	level.aTrigger_use_breach = undefined;
	level.eBreach_Room_Volume = undefined;

	
	//get all the names of relevant entities
	level.eBreach_Room_Volume = getent("volume_" + sRoomName, "targetname");	
	level.eTrigger_breach_approach = getent("trig_breach_approach_" + sRoomName, "targetname");
	level.eDoor = getent("door_" + sRoomName, "targetname");
	level.eTrigger_enter = getent("trig_enter_" + sRoomName, "targetname");
	level.aTrigger_use_breach = getentarray("trig_use_breach_" + sRoomName, "targetname");
	assertEx(isDefined(level.eBreach_Room_Volume), "Volume doesn't exist: volume_" + sRoomName);
	assertEx(isDefined(level.eTrigger_breach_approach), "You need to create a valid trig_breach_approach_<roomName> for " + sRoomName);
	assertEx(isDefined(level.eDoor), "You need to create a valid door_<roomName> for " + sRoomName);
	assertEx(isDefined(level.eTrigger_enter), "You need to create a valid trigr_enter_<roomName> for " + sRoomName);
	assert(level.aTrigger_use_breach.size == 2);

	// this ent is needed for animations
	level.eDoor.anim_ent = spawn( "script_origin", level.eDoor.origin);
	level.eDoor.anim_ent.angles = level.eDoor.angles;
	assertEx(isDefined(level.eDoor.anim_ent), "The script_origin for the door does not exist");

	// parameters for the different breach versions.
	level.aBreach_type = [];

	level.aBreach_type[0]["breach_anim"] = "door_breach_shoot_and_kick";
	level.aBreach_type[0]["door_open_type"] = 1;

}

breach_room(sRoomName, aFriendlies, iBreach_id)
{
	/*---------------------------------------------
	sRoomName - string name of room to be breached
	aFriendlies - array of 2 friendlies that will perform the breach
	iBreach_Id - integer that indicates whether it's a hinge shoot, generic kick, etc
	/----------------------------------------------*/
	assertEx(isdefined(iBreach_id), "You need to specify a valid iBreach_id");
	
	//reset and setup all variables
	breach_variable_setup(sRoomName, aFriendlies, iBreach_id);
	
	level thread breach_nag();						//thread for breach nagging
	level thread trigger_breach_approach();			//thread for when player approaches room
	level thread trigger_enter_room();				//thread for when player enters room
			
	//have everyone ignore eachother 
	ignoreEverybody(true);
	
	//setup friendlychain for after breach (should be ignored while scripted anims are playing)
	friendlyChainUpdate("friendlychain_exterior_" + sRoomName);	


	//setup animations for main dude and type of door open
	breach_anim		= level.aBreach_type[iBreach_id]["breach_anim"];
	door_open_type	= level.aBreach_type[iBreach_id]["door_open_type"];

	
	//have ai get into position
	level.gaz thread breach_ai_think();
	level.jack thread breach_ai_think();	
	
	level waittill ("door_ready_to_be_breached");	
	
	//Setup the activation triggers
	array_thread( level.aTrigger_use_breach, ::trigger_use_door_breach_think );

	level waittill ("player_has_given_breach_command");	
	
	// opens door on "breach" notify
	level.eDoor thread door_open_breach(door_open_type);
	
	//Have kneeling guy perform the breach		
	//level thread breach_perform(level.breach_firstguy, main_anim);
	level thread breach_perform(level.jack, breach_anim);

	level waittill ("breach");
	
	//Have enemies get freaked out
	aHostiles = getAIarrayTouchingVolume("axis", "volume_" + sRoomName);
	array_thread( aHostiles, ::enemy_surprised );

	
	sRoom_breached_flag = sRoomName + "_breached";
	flag_set(sRoom_breached_flag);
	
	//Run the default thread now that breach is done
	level breach_complete(sRoomName);
	
	level waittill ("breach_ai_back_to_normal");

}

enemy_surprised()
{
	guy = self;
	if (self.spawnflags & 1)
		self waittill("spawn",guy);

	//assert( isdefined(guy.script_animation) );

	guy endon("death");

	//self.old_maxsightdistsqrd = self.maxsightdistsqrd;
	//self.maxsightdistsqrd = (256*256);

	guy.allowdeath = true;
	guy.animname = "surprise_guy";
	
	//pick a random surprised anim from 1 to 3
	sSurprisedAnimName = "surprise_" + randomintrange(1,3);
	
	level thread print3Dthread(guy, "         Surprised!");
	
	guy anim_single_solo (guy, sSurprisedAnimName, undefined);
	guy waittillmatch("single anim", "end");
	
	level thread print3Dthread(guy, "");
}




breach_nag()	//friendlies nag the player if he is not in the approach trigger
{
	level endon ("player_has_entered_breach_trigger");
	level endon ("player_has_entered_breached_room");	
	
	level waittill ("door_ready_to_be_breached");
	
	iWaitTime = randomintrange(10,16);
	while (true)
	{
		wait(iWaitTime);
		
		iDialogueNumber = randomintrange(1,6);
		sDialogueString = "embassy_gaz_getoverhere" + iDialogueNumber;
		level.gaz thread queue_anim(sDialogueString);		
	}
}

breach_complete(sRoomName)
{

	switch(sRoomName)
	{
	case "officeB1":
		level thread officeB1_fight();
		break;
	case "officeD":
		level thread officeD_fight();
		break;
	case "officeF":
		level thread officeF_fight();
		break;
	default:
		assertMsg("need to create a thread to run after breach is done for this room");
		break;
	}
}

trigger_breach_approach()
{
	//wait until guys are in place
	level waittill ("door_ready_to_be_breached");
	
	//wait till trigger is hit	
	level.eTrigger_breach_approach waittill ( "trigger" ); level.eTrigger_breach_approach trigger_off();
	
	level notify ("player_has_entered_breach_trigger");
	
	//Gaz
	//Stack up against the wall, Andy. Get those flashbangs ready
	//level.gaz thread dialogue_thread("embassy_gaz_breachstack1");
	
	array_thread(level.aTrigger_use_breach, ::breach_use_trigger_touch_test);
	
	level waittill ("player_entered_breach_use_trigger"); 
	
	level notify ("player_has_entered_breach_trigger");
	
	//jack
	//"Waiting for your signal, Andy."
	level.jack thread queue_anim("embassy_jack_breachwaitingforsignal1");

}

breach_use_trigger_touch_test()
{
	level endon ("player_entered_breach_use_trigger");
	
	while ( !level.player isTouching(self) )
	{
		wait ( .05 );
	}
	level notify ("player_entered_breach_use_trigger");
}

trigger_enter_room()
{
	level.eTrigger_enter waittill ( "trigger" ); level.eTrigger_enter trigger_off();
	level notify ("player_has_entered_breached_room");	
}

breach_perform(guy, breach_anim)
{
	level endon ("player_has_entered_breached_room");
	
	//stop any looping animations on this guy
	ender = "stop_idle_" + guy getentitynumber();
	level.eDoor.anim_ent notify(ender);	
	
	//play breach animation
	level.eDoor.anim_ent thread anim_single_solo (guy, breach_anim);

	guy waittillmatch("single anim", "kick");
	level notify("breach");			//notifies door to open
	guy waittillmatch("single anim", "end");	
	
	level.player.ignoreme = false;		//have the hostiles see the player, but not other friendlies yet


	ender = "stop_idle_" + guy getentitynumber();
	guy setFlashbangImmunity( true );
	level.eDoor.anim_ent thread anim_loop_solo (guy, "support_idle", undefined, ender);
		
	ignoreEverybody(false);	

	level notify ("player_has_entered_breached_room");
}



trigger_use_door_breach_think()
{
	
	//create trigger, setup hint and wait till used
	trigger_use_door_breach = self;
	trigger_use_door_breach trigger_on();
	trigger_use_door_breach setHintString( &"EMBASSY_HINTSTR_BREACH");
	trigger_use_door_breach waittill("trigger");
	
	//Trigger has been used
	for(i=0;i<level.aTrigger_use_breach.size;i++)
		level.aTrigger_use_breach[i] trigger_off();	//delete all triggers, not just this one
	
	level notify ("player_has_given_breach_command");	
}

breach_ai_think()
{
	//setup temporary values for breach
	self pushplayer(true);
	
	self setGoalRadius(0);
	self setInterval(0);


	//Friendlies go to door and wait for player
	ender = "stop_idle_" + self getentitynumber();
	self setFlashbangImmunity( true );
	level.eDoor anim_reach_solo(self, "support_idle_start");		
	level.eDoor.anim_ent thread maps\_anim::anim_loop_solo (self, "support_idle", undefined, ender);

	level.friendliesReadyToBreach++;
	if (level.friendliesReadyToBreach == 2)
		level notify ("door_ready_to_be_breached");
				
	//wait until door is breached, then reset back to old values
	level waittill ("player_has_entered_breached_room");
	
	//stop guys from doing animations
	//self notify ("stop doing _anim notetracks");
	self stopanimscripted();
	
	ignoreEverybody(false);	
		
	//stop any looping animations and reset default ai
	ender = "stop_idle_" + self getentitynumber();
	level.eDoor.anim_ent notify(ender);	
	
	self pushplayer(false);
	self resetGoalRadius();
	self resetInterval();
	
	level notify ("breach_ai_back_to_normal");	
}





door_NPC_open(sDoorName, iOpenType, iDoorOpenType)
{
	/*----------------
	/ iDoorOpenType 1- fall over
	/ iDoorOpenType 2- swing open
	/ 
	/ 
	/-----------------*/
	assert(isdefined(self));
	self endon ("death");
	
	bDoubleDoors = false;
	
	//setup vars and different open types	
	aOpenType = [];
	aOpenType[0]["open_anim"] = "door_breach_shoot_and_kick";
	aOpenType[1]["open_anim"] = "door_breach_kick_in";
	aOpenType[2]["open_anim"] = "door_bash_and_block";
	breach_anim	= aOpenType[iOpenType]["open_anim"];
	
	eDoor = getent(sDoorName, "targetname");
	assert(isDefined(eDoor));

	eDoor.anim_ent = spawn( "script_origin", eDoor.origin);
	eDoor.anim_ent.angles = eDoor.angles;
	
	//Is it a double door?
	if ( (isdefined(eDoor.script_noteworthy)) && (eDoor.script_noteworthy == "double_door") )
	{
		bDoubleDoors = true;
		eDoor2 = getent(eDoor.targetname + "_2", "targetname");
		assertEx(isdefined(eDoor2), "For double doors, you need to put '_2' on the other door and ensure it is on the left side");
		//move the animation origin a bit to the left
	}
	else
		eDoor2 = undefined;
	
	
	//give the guy a temp animname
	self set_animname("guy");
	self setFlashbangImmunity( true );		
	eDoor.anim_ent anim_reach_solo(self, breach_anim);
	eDoor.anim_ent thread anim_single_solo (self, breach_anim);

	self waittillmatch("single anim", "kick");
	self notify("door_kicked");
	
	// Have door fall down if not specified
	if (!isdefined(iDoorOpenType))
		iDoorOpenType = 1;
		
	eDoor thread door_open(iDoorOpenType);
	
	
	// Make the double door fly open backwards if defined
	if (bDoubleDoors == true)
		eDoor2 thread door_open(3, false);
	
	self waittillmatch("single anim", "end");
	
	self reset_animname();
	
	self notify ("door_has_been_opened");
}

door_open_breach(type)
{
	level waittill("breach");

	self playsound ("wood_door_kick");
	
	switch(type)
	{
		case 1:
			self thread door_fall_over();
			self door_connectpaths();
			break;
		default:
			self rotateyaw(-175, 0.5);
			self door_connectpaths();
			break;
	}
}

open_all_doors_in_level()
{
	// define all the doors in the level you want initially open
	aDoorsToBeOpened = [];
	aDoorsToBeOpened[0] = getent("door_libraryhallway", "targetname");
	aDoorsToBeOpened[1] = getent("door_libraryfoyer", "targetname");
	
	for(i=0;i<aDoorsToBeOpened.size;i++)
	{
		//Is it a double door?
		if ( (isdefined(aDoorsToBeOpened[i].script_noteworthy)) && (aDoorsToBeOpened[i].script_noteworthy == "double_door") )
		{
			eDoor2 = getent(aDoorsToBeOpened[i].targetname + "_2", "targetname");
			assertEx(isdefined(eDoor2), "For double doors, you need to put '_2' on the other door and ensure it is on the left side");
			
			//open this other door in the opposite direction
			eDoor2 thread door_open(3, false);
			
		}
		else
			eDoor2 = undefined;
		
		//Open the door
		aDoorsToBeOpened[i] door_open(2, false);			
	}

}

door_close(sDoorName)
{
	//setup vars and different open types	
	eDoor = getent(sDoorName, "targetname");
	assert(isDefined(eDoor));
	eDoor2 = undefined;
	
	//Is it a double door?
	if ( (isdefined(eDoor.script_noteworthy)) && (eDoor.script_noteworthy == "double_door") )
	{
		bDoubleDoors = true;
		eDoor2 = getent(eDoor.targetname + "_2", "targetname");
		assertEx(isdefined(eDoor2), "For double doors, you need to put '_2' on the other door and ensure it is on the left side");
		//move the animation origin a bit to the left
	}
	else
		eDoor2 = undefined;
		
	eDoor rotateyaw(175, 0.5);
	eDoor door_disconnectpaths();
	
	//do double door as well if specified
	if (isdefined(eDoor2))
	{
		eDoor2 rotateyaw(-175, 0.5);
		eDoor2 door_disconnectpaths();
	}
	
	wait(0.5);
	eDoor playsound ("wood_door_kick");
	
}

door_open(type, bPlaySound)
{
	if (!isDefined(bPlaySound))
		bPlaySound = true;
		
	if (bPlaysound == true)
		self playsound ("wood_door_kick");
	
	switch(type)
	{
		case 1:
			self thread door_fall_over();
			self door_connectpaths();
			break;
		case 2:		//Rotate away from kick
			self rotateyaw(-175, 0.5);
			self door_connectpaths();
			break;
		case 3:		//Double door...opposite rotation
			self rotateyaw(175, 0.5);
			self door_connectpaths();
			break;
		default:
			self rotateyaw(-175, 0.5);
			self door_connectpaths();
			break;
	}
}

door_connectpaths()
{
	if (self.classname == "script_brushmodel")
		self  connectpaths();
	else
	{
		self.blocker = getent(self.target, "targetname");
		assertex( isdefined(self.blocker), "A script_model door needs to target a script_brushmodel that blocks the door.");
		//self.blocker delete();
		self.blocker hide();
		self.blocker notsolid();
		self.blocker connectpaths();		
	}
}

door_disconnectpaths()
{
	if (self.classname == "script_brushmodel")
		self  disconnectpaths();
	else
	{
		self.blocker = getent(self.target, "targetname");
		assertex( isdefined(self.blocker), "A script_model door needs to target a script_brushmodel that blocks the door.");
		self.blocker show();
		self.blocker solid();
		self.blocker disconnectpaths();
	}

}

door_fall_over()
{
	vector = anglestoforward(self.angles);
	dist = (vector[0] * 20, vector[1] * 20, vector[2] * 20);

	self moveto(self.origin + dist, .5, 0 , .5);
	self rotatepitch(90, 0.45, 0.40);
	wait 0.449;
	self rotatepitch(-4, 0.2, 0, 0.2);
	wait 0.2;
	self rotatepitch(4, 0.15, 0.15);
}


set_explosives(eAnimEnt, sBadplaceName, bDialogue, iExplosiveType)
{
	if (!isdefined(bDialogue))
		bDialogue = true;

	
	self endon ("death");
	
	self set_animname ("guy");
	self pushplayer(true);
	
	//figure out explosive type
	sAnim = "";
	switch (iExplosiveType)
	{
		case 0:	//Wall
			sAnim = "explosive_plant_knee";
		case 1:	//Window
			sAnim = "explosive_plant_window";
		default:
			sAnim = "explosive_plant_knee";
	}
	
	
	eAnimEnt anim_reach_solo(self, sAnim);
	eAnimEnt anim_single_solo (self, sAnim);
	
	if (isdefined(sBadplaceName))
		badplace_cylinder(sBadplaceName, -1, eAnimEnt.origin, 32, 200, "allies");
	
	//Guy
	//Charges in place!
	if ( isdefined(bDialogue) && (bDialogue == true) )
	{
//		//select a random "charges placed" line of dialogue
//		i = randomintrange(1,2);
//		if (i == 1)
//			self thread dialogue_thread("embassy_frnd_explosivesplanted1");	
//		else
//			self thread dialogue_thread("embassy_frnd_explosivesplanted2");	
	}
	if (isdefined(bDialogue))
		self thread queue_anim("embassy_frnd_explosivesplanted1");	
		
	
	self reset_animname();	
	self pushplayer(false);	
	
	self notify ("explosives_set");
}

door_check(eDoor, iSignalType, sAnimname)
{
	/*-----------------
	iSignalType 1 = left
	iSignalType 2 = right
	iSignalType 3 = both
	iSignalType 4 = none
	--------------------*/
	self endon ("death");
	
	self set_animname ("guy");
		
	self pushplayer(true);
	
	ender = "stop_idle";
		
	eAnimEnt = spawn( "script_origin", eDoor.origin);
	eAnimEnt.angles = eDoor.angles;
	
	self setFlashbangImmunity( true );
	eAnimEnt anim_reach_solo(self, "stand_2_cam");
	self notify ("door_check_reached");	
	eAnimEnt thread anim_loop_solo (self, "cam_idle", undefined, ender);
	
	self waittill ("door_check_signal");
	
	eAnimEnt notify (ender);

	switch(iSignalType)
	{
		case 1:	//Left signal only
			eAnimEnt thread anim_single_solo (self, "cam_sigL");
			self waittillmatch("single anim", "end");
			break;
		case 2: //Right signal only
			eAnimEnt thread anim_single_solo (self, "cam_sigR");
			self waittillmatch("single anim", "end");
			break;
		case 3: //Both Left & Right signal
			eAnimEnt thread anim_single_solo (self, "cam_sigR");
			self waittillmatch("single anim", "end");
			eAnimEnt thread anim_single_solo (self, "cam_sigL");
			self waittillmatch("single anim", "end");
			break;
		case 4: //No signal
			//do nothing
			break;
		default:
			//do nothing
			break;
	}
	self notify ("door_check_signals_complete");
	
	//Go back to playing looping animation until stopped by notify
	eAnimEnt thread anim_loop_solo (self, "cam_idle", undefined, ender);
	
	self waittill ("door_check_stop");
	
	//Have dude stand back up and reset his default values
	eAnimEnt notify (ender);
	eAnimEnt anim_single_solo (self, "cam_2_stand");
	
	self reset_animname();	
		
	self pushplayer(false);	
	
	self notify ("door_check_complete");
}

set_deathanim(animname)
{
		if ( !isdefined( self.old_deathanim ) )
			self.old_deathanim = self.deathanim;
		self.deathanim = animname;
}

reset_deathanim()
{
		self.deathanim = undefined;
//		if ( isdefined( self.old_deathanim ) )
//			self.deathanim = self.old_deathanim;
//		self.old_deathanim = undefined;
}


set_animname(animname)
{
		if ( !isdefined( self.old_animname ) )
			self.old_animname = self.animname;
		self.animname = animname;
}

reset_animname()
{
		if ( isdefined( self.old_animname ) )
			self.animname = self.old_animname;
		self.old_animname = undefined;
}

setGoalRadius(fRadius)
{
	if ( !isdefined( self.old_goalradius ) )
		self.old_goalradius = self.goalradius;
	self.goalradius = fRadius;
}

resetGoalRadius()
{
	if ( isdefined( self.old_goalradius ) )
		self.goalradius = self.old_goalradius;
	self.old_goalradius = undefined;
}

setInterval(iInterval)
{
	if ( !isdefined( self.old_interval ) )
		self.old_interval = self.interval;
	self.interval = iInterval;
}
resetInterval()
{
	if ( isdefined( self.old_interval ) )
		self.interval = self.old_interval;
	self.old_interval = undefined;
}
/****************************************************/
/**************** DEBUG FUNCTIONS****************/
/****************************************************/

print3Dthread(eEntity, sMessage)
{
	
	if ( level.debug_mode == false )
		return;
		
	level endon (eEntity getentitynumber() + "_stop_3dprint");	//this can be raised by passing an empty string
	if (!isdefined(eEntity))
		return;
		
			
	//No message...just clear and exit
	if (sMessage == "")
	{
		if (!isdefined(eEntity))
			return;
		print3d (eEntity.origin + (0,0,32), sMessage, (1,1,1), 1, 0.5);
		level notify (eEntity getentitynumber() + "_stop_3dprint");
		return;
	}
		
	// We have a message...print it continually
	for (;;)
	{
		if (!isdefined(eEntity))
			return;
		//print3d(<origin>, <text>, <color>, <alpha>, <scale> ...)
		print3d (eEntity.origin + (0,0,32), sMessage, (1,1,1), 1, 0.5);
		wait (0.05);
	}
	
}



debugMethod1()
{
	setdvar("debug1","0");
	while ( true )
	{
		wait (0.05);
		if 	(getdvar("debug1") == "1")
		{
			setdvar("debug1","0"); 
			
			//----PUT DEBUG CODE HERE---//	
			level thread skipWarp("mezzanine");
			msg("****debug 1 was called****");
			
			//----PUT DEBUG CODE HERE---//	
		}
	}
				
}

debugMethod2()
{
	setdvar("debug2","0");
	while ( true )
	{
		wait (0.05);
		if 	(getdvar("debug2") == "1")
		{
			setdvar("debug2","0"); 
			
			//----PUT DEBUG CODE HERE---//	
	
			//----PUT DEBUG CODE HERE---//	
		}
	}
				
}



