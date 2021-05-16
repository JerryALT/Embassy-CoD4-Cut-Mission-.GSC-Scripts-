#include maps\_anim;
#using_animtree("generic_human");
main()
{

	level animations_breach();
	level animations_sas();
	level animations_hostages();
	level dialogue();
	level dialogue_generic();
	level dialogue_cycle();
}

animations_breach()
{
	//****************DOOR BREACH ANIMATIONS (GENERIC)*******************************//	
	
	/*-----------------------
	GENERIC KICKS AND SHOOTS
	-------------------------*/		
	level.scr_anim["guy"]["door_breach_shoot_and_kick"]	= (%stack1_shootandkick);	
	level.scr_anim["guy"]["door_breach_kick_in"]	= (%door_kick_in);	
	level.scr_anim["guy"]["door_bash_and_block"]	= (%door_bash_and_block);

	/*-----------------------
	BALCONY BREACH
	-------------------------*/	
	level.scr_anim["price"]["breachbalcony_idle_start_price"]	= (%stack_3_idle);	
	level.scr_anim["price"]["breachbalcony_idle_price"][0]	= (%stack_3_idle);
	level.scr_anim["price"]["breachbalcony_enter_price"]	= (%clear_left);

	level.scr_anim["frnd"]["breachbalcony_idle_start_pos01"]	= (%clear_left_idle);	
	level.scr_anim["frnd"]["breachbalcony_idle_pos01"][0]	= (%clear_left_idle);
	level.scr_anim["frnd"]["breachbalcony_flashbang_pos01"]	= (%corner_crouchr_grenade_alert);
	level.scr_anim["frnd"]["breachbalcony_enter_pos01"]	= (%clear_left);
	
		
	/*-----------------------
	ONE STACKED, SHOTGUN LOCK SHOOT AND KICK (WITH PRICE ON THE SIDE)
	-------------------------*/		
	//idle start (for anim reach solo)
	level.scr_anim["frnd"]["breachshotgunsolo_idle_start_pos01"]	= (%stack1_stand_idle);	
	level.scr_anim["price"]["breachshotgunsolo_idle_start_price"]	= (%shotgunbreach_v1_shotgun_idle);	

	//door idle
	level.scr_anim["frnd"]["breachshotgunsolo_idle_pos01"][0]	= (%stack1_stand_idle);	
	level.scr_anim["price"]["breachshotgunsolo_idle_price"][0]	= (%shotgunbreach_v1_shotgun_idle);

	//breach door
	level.scr_anim["frnd"]["breachshotgunsolo_breach_pos01"]	= (%stack1_shootandkick);		
	addNotetrack_customFunction("frnd", "fire", ::shootGun, "breachshotgunsolo_breach_pos01");

	//enter room
	level.scr_anim["frnd"]["breachshotgunsolo_enter_pos01"]	= (%clear_left);

	/*-----------------------
	TWO STACKED, FRAMECHARGE AND FLASHBANG (WITH PRICE ON THE SIDE)
	-------------------------*/		
	//idle start (for anim reach solo)
	level.scr_anim["frnd"]["breachframe_idle_start_pos01"]	= (%clear_left_idle);	
	level.scr_anim["frnd"]["breachframe_idle_start_pos02"]	= (%stack_3_idle);	
	level.scr_anim["price"]["breachframe_idle_start_price"]	= (%shotgunbreach_v1_shotgun_idle);	

	//door idle
	level.scr_anim["frnd"]["breachframe_idle_pos01"][0]	= (%clear_left_idle);	
	level.scr_anim["frnd"]["breachframe_idle_pos02"][0]	= (%stack_3_idle);	
	level.scr_anim["price"]["breachframe_idle_price"][0] = (%shotgunbreach_v1_shotgun_idle);

	//flashbang throw (pos 01 only)
	level.scr_anim["frnd"]["breachframe_flashbang_pos01"]	= (%corner_crouchr_grenade_alert);

	//enter room
	level.scr_anim["frnd"]["breachframe_enter_pos01"]	= (%clear_left);
	level.scr_anim["frnd"]["breachframe_enter_pos02"]	= (%clear_left);

	/*-----------------------
	TWO STACKED, SHOTGUN AND NO FLASHBANG (WITH PRICE ON THE SIDE)
	-------------------------*/
	//idle start (for anim reach solo)
	level.scr_anim["frnd"]["breachshotgun_idle_start_pos01"]	= (%shotgunbreach_v1_shotgun_idle);	
	level.scr_anim["frnd"]["breachshotgun_idle_start_pos02"]	= (%shotgunbreach_v1_stackA_idle);	
	level.scr_anim["price"]["breachshotgun_idle_start_price"]	= (%stack_3_idle);	

	//door idle
	level.scr_anim["frnd"]["breachshotgun_idle_pos01"][0]	= (%shotgunbreach_v1_shotgun_idle);	
	level.scr_anim["frnd"]["breachshotgun_idle_pos02"][0]	= (%shotgunbreach_v1_stackA_idle);	
	level.scr_anim["price"]["breachshotgun_idle_price"][0]	= (%stack_3_idle);	

	//flashbang throw (pos 01 only)
	//level.scr_anim["frnd"]["breachshotgun_flashbang_pos01"]	= (%XXX);

	//enter room
	level.scr_anim["frnd"]["breachshotgun_enter_pos01"]	= (%shotgunbreach_v1_shotgun);
	addNotetrack_customFunction("frnd", "fire", ::shootGun, "breachshotgun_enter_pos01");
	level.scr_anim["frnd"]["breachshotgun_enter_pos02"]	= (%shotgunbreach_v1_stackA);
	addNotetrack_customFunction("frnd", "fire", ::shootGun, "breachshotgun_enter_pos02");
}

//animations_terrorists()
//{
//	//sniper blown through door
//	level.scr_anim["guy"]["blow_back"] = (%blow_back);
//	level.scr_anim["guy"]["blow_back_dead"][0] = (%blow_back_dead);	
//	
//	//Surrender then shoot
//	level.scr_anim["guy"]["terrorist_fakeout"] = (%terrorist_fakeout);	
//}

//animations_humanshield()	
//{
//	//idle
//	level.scr_anim["human_shield_idle"][0]	= (%hostage_human_shield_idle);	
//	level.scr_anim["guy"]["human_shield_idle"][0]	= (%terrorist_human_shield_idle);	
//	
//	//blindfire
//	level.scr_anim["human_shield_duck_blindfire"]	= (%hostage_human_shield_duck_blindfire);
//	level.scr_anim["guy"]["human_shield_duck_blindfire"]	= (%terrorist_human_shield_duck_blindfire);
//	addNotetrack_customFunction("guy", "fire", ::shootGun, "human_shield_duck_blindfire");
//		
//	//terroist killed immediately, hostage breaks free
//	level.scr_anim["human_shield_ter_death"]	= (%hostage_human_shield_ter_death);
//	level.scr_anim["guy"]["human_shield_ter_death"]	= (%terrorist_human_shield_ter_death);
//		
//	//terrorist wounded, hostage breaks free
//	level.scr_anim["human_shield_ter_pain"]	= (%hostage_human_shield_ter_pain);
//	level.scr_anim["guy"]["human_shield_ter_pain"]	= (%terrorist_human_shield_ter_pain);
//		
//	//hostage killed immediately
//	level.scr_anim["human_shield_host_death"]	= (%hostage_human_shield_host_death);
//	level.scr_anim["guy"]["human_shield_host_death"]	= (%terrorist_human_shield_host_death);
//		
//	//reaction to flashbang
//	level.scr_anim["human_shield_flashbang"]	= (%hostage_human_shield_flashbang);
//	level.scr_anim["guy"]["human_shield_flashbang"]	= (%terrorist_human_shield_flashbang);
//}	

animations_sas()
{
	// Tarzan rappel
	level.scr_anim["frnd"]["rappel"]	= (%rappel);
	
	// balcony rappel
	level.scr_anim["frnd"]["rappel_balcony_1"]	= (%rappel_straightdown);
	
	// Skylight rappel
	level.scr_anim["frnd"]["rappel_skylight_mount"]	= (%rappel_skylight_mount);
	level.scr_anim["frnd"]["rappel_skylight_idle"][0]	= (%rappel_skylight_idle);
	level.scr_anim["frnd"]["rappel_skylight_drop"]	= (%rappel_skylight_drop);
	
//	//generic fastrope loop and land
//	level.scr_anim["frnd"]["fastrope_loop"][0] = (%bh_fastrope_loop);	
//	level.scr_anim["frnd"]["fastrope_land"] = (%bh_fastrope_land);
//	level.scr_anim["frnd"]["fastrope_full"] = (%bh_side01_fastrope_whole_test);	
//	
//	//Helicopter ride
//	level.scr_anim["gaz"]["heli_seat_idle"][0] = (%bh_1_idle);
//	level.scr_anim["jack"]["heli_seat_idle"][0] = (%bh_2_idle);
//	
//	level.scr_anim["passenger1"]["heli_seat_idle"][0] = (%bh_3_idle);
//	level.scr_anim["passenger2"]["heli_seat_idle"][0] = (%bh_4_idle);
//	level.scr_anim["passenger3"]["heli_seat_idle"][0] = (%bh_5_idle);
//	level.scr_anim["passenger4"]["heli_seat_idle"][0] = (%bh_6_idle);
//	level.scr_anim["passenger5"]["heli_seat_idle"][0] = (%bh_7_idle);
//	
//	level.scr_anim["pilot"]["heli_seat_idle"][0] = (%bh_Pilot_idle);
//	level.scr_anim["copilot"]["heli_seat_idle"][0] = (%bh_coPilot_idle);

//	
//	// plant explosives
//	level.scr_anim["guy"]["explosive_plant_knee"] = (%explosive_plant_knee);
//	
//	//plant frame charge
//	level.scr_anim["guy"]["explosive_plant_window"] = (%explosive_plant_knee);
//	
//	// signal_over_shoulder
//	level.scr_anim["guy"]["signal_over_shoulder"] = (%signal_over_shoulder);
//	
//	// Fastrope from chopper
//	level.scr_anim["guy"]["bh_side01_idle01_test"][0] = (%bh_side01_idle01_test);
//	level.scr_anim["guy"]["bh_side01_fastrope_whole_test"] = (%bh_side01_fastrope_whole_test);
//	
//
//	
//	// Fiber optic camera	
//	level.scr_anim["guy"]["stand_2_cam"]	= (%stand_2_cam);
//	level.scr_anim["guy"]["cam_idle"][0]	= (%cam_idle);
//	level.scr_anim["guy"]["cam_2_stand"]	= (%cam_2_stand);
//	level.scr_anim["guy"]["cam_sigL"]	= (%cam_sigL);
//	level.scr_anim["guy"]["cam_sigR"]	= (%cam_sigR);
//	
//	//Elevator door sequence
//	level.scr_anim["jack"]["elevator_pry_idle_start"]	= (%elevator_pry_in_idle);
//	level.scr_anim["gaz"]["elevator_pry_idle_start"]	= (%elevator_pry_L_idle);
//	level.scr_anim["guy"]["elevator_pry_idle_start"]	= (%elevator_pry_R_idle);	
//	
//	level.scr_anim["jack"]["elevator_pry"]	= (%elevator_pry_in);
//	level.scr_anim["gaz"]["elevator_pry"]	= (%elevator_pry_L);
//	level.scr_anim["guy"]["elevator_pry"]	= (%elevator_pry_R);
//	
//	level.scr_anim["jack"]["elevator_pry_idle"][0]	= (%elevator_pry_in_idle);
//	level.scr_anim["gaz"]["elevator_pry_idle"][0]	= (%elevator_pry_L_idle);
//	level.scr_anim["guy"]["elevator_pry_idle"][0]	= (%elevator_pry_R_idle);	
//	
//	//elevator - ladder transfer
//	level.scr_anim["guy"]["elevator_ladder_trans"]	= (%elevator_ladder_trans);
//
//	// Death poses			
//	level.scr_anim["guy"]["death_pose_on_window"][0]	= (%death_pose_on_window);	
//	level.scr_anim["guy"]["death_pose_on_desk"][0]	= (%death_pose_on_desk);	
}


dialogue()
{
	
	//price
	//"get back!"
	level.scr_sound["price"]["embassy_price_balconygetback"]		= "embassy_frnd_shotgunbreach01";

	//price
	//"get back!"
	level.scr_sound["price"]["embassy_price_flashbangsnow"]		= "embassy_frnd_flashbangnow01";



		
	/****************************************************************************
   	 HUMAN SHIELD DIALOGUE
	****************************************************************************/
	
//	//guy
//	//"Stand back!"
//	level.scr_sound["guy"]["embassy_ter_humanshieldbackoff1"]		= "embassy_ter_humanshieldbackoff1";
//	//self thread dialogue_thread("embassy_ter_humanshieldbackoff1");		
//
//	//guy
//	//"Back off!"
//	level.scr_sound["guy"]["embassy_ter_humanshieldbackoff2"]		= "embassy_ter_humanshieldbackoff2";
//	//self thread dialogue_thread("embassy_ter_humanshieldbackoff2");		
//	
//	//guy
//	//"Stay away!"
//	level.scr_sound["guy"]["embassy_ter_humanshieldbackoff3"]		= "embassy_ter_humanshieldbackoff3";
//	//self thread dialogue_thread("embassy_ter_humanshieldbackoff3");		
//
//	//guy
//	//"Back!"
//	level.scr_sound["guy"]["embassy_ter_humanshieldbackoff4"]		= "embassy_ter_humanshieldbackoff4";
//	//self thread dialogue_thread("embassy_ter_humanshieldbackoff4");	


	/****************************************************************************
   	 LEVEL DIALOGUE
	****************************************************************************/
			
	//sierra
	//"Body is being..they are dumping the body out of the front window."
	level.scr_sound["sierra"]["embassy_sierra_bodybeingdumped"]		= "embassy_sierra_bodybeingdumped";
	//level.sierra thread dialogue_thread("embassy_sierra_bodybeingdumped");	
	
	//jack
	//"Bloody christ, they've killed a hostage"
	level.scr_sound["jack"]["embassy_jack_theykilledahostage"]		= "embassy_jack_theykilledahostage";
	//level.jack thread dialogue_thread("embassy_jack_theykilledahostage");	
	
	//sierra
	//"I may have visual on X Ray One."
	level.scr_sound["sierra"]["embassy_sierra_visualofxrayone"]		= "embassy_sierra_visualofxrayone";
	//level.sierra thread dialogue_thread("embassy_sierra_visualofxrayone");	
	
	//crowd
	//"<sound of crowd screaming and sobbing>"
	level.scr_sound["crowd"]["embassy_crowd_screams"]		= "embassy_crowd_screams";
	//level.crowd thread dialogue_thread("embassy_crowd_screams");	
	
	//cmd
	//"Roger, Sierra One. Hold your fire. We have clearance to execute IA. All call signs, I have control. Commence your run in."
	level.scr_sound["cmd"]["embassy_cmd_clearencetoexecute"]		= "embassy_cmd_clearencetoexecute";
	//dialogue_radio_thread("embassy_cmd_clearencetoexecute");	
	
	//gaz
	//"Right, that's in then. Stand to, lads. We?ll be assaulting the middle floor."
	level.scr_sound["gaz"]["embassy_gaz_herewegolads"]		= "embassy_gaz_herewegolads";
	//level.gaz thread dialogue_thread("embassy_gaz_herewegolads");	
	
	//gaz
	//"Alpha One going dark. 2 seconds."
	level.scr_sound["gaz"]["embassy_gaz_goingdark"]		= "embassy_gaz_goingdark";
	//level.gaz thread dialogue_thread("embassy_gaz_goingdark");	
		
	//jack
	//"Let?s get those respirators on." 
	level.scr_sound["jack"]["embassy_jack_putonrespirators"]		= "embassy_jack_putonrespirators";
	//level.jack thread dialogue_thread("embassy_jack_putonrespirators");	
	
	//gaz
	//"Andy, you're going to be first man into every room. Take the flashbangs. You'll be the one making noise."
	level.scr_sound["gaz"]["embassy_gaz_helibreachinstruct1"]		= "embassy_gaz_helibreachinstruct1";
	//level.gaz thread dialogue_thread("embassy_gaz_helibreachinstruct1");	
	
	//sierra
	//"Confirmed. That was X Ray One at the window. Male...approximately 6?2...fifteen stone..."
	level.scr_sound["sierra"]["embassy_sierra_thatwasxray1"]		= "embassy_sierra_thatwasxray1";
	//level.sierra thread dialogue_thread("embassy_sierra_thatwasxray1");	
	
	//gaz
	//"Command. This is Alpha One at the insertion point."
	level.scr_sound["gaz"]["embassy_gaz_atinsertionpoint"]		= "embassy_gaz_atinsertionpoint";
	//level.gaz thread dialogue_thread("embassy_gaz_atinsertionpoint");	
	
	//cmd
	//"Roger Alpha One. All call signs standby. Standby...Go! Go! Go!"
	level.scr_sound["cmd"]["embassy_cmd_insertiongo"]		= "embassy_cmd_insertiongo";
	//dialogue_radio_thread("embassy_cmd_insertiongo");	
	
	//gaz
	//"Go! Get those ropes out!"
	level.scr_sound["gaz"]["embassy_gaz_getropesout"]		= "embassy_gaz_getropesout";
	//level.gaz thread dialogue_thread("embassy_gaz_getropesout");	
	
	//sierra
	//"X Ray on the rooftop. Repeat, hostile active on the rooftop. I do not have a shot."
	level.scr_sound["sierra"]["embassy_sierra_hostileonroof"]		= "embassy_sierra_hostileonroof";
	//level.sierra thread dialogue_thread("embassy_sierra_hostileonroof");	
	
	//jack
	//"Over there, the service stairwell!"
	level.scr_sound["guy"]["embassy_jack_hostileonrooftop"]		= "embassy_jack_hostileonrooftop";
	//level.jack thread dialogue_thread("embassy_jack_hostileonrooftop");	
	
	//pilot
	//"Heli's been hit! Hang on!"
	level.scr_sound["pilot"]["embassy_pilot_helihasbeenhit"]		= "embassy_pilot_helihasbeenhit";
	//level.pilot thread dialogue_thread("embassy_pilot_helihasbeenhit");	
	
	//friendly
	//"Hostile down."
	level.scr_sound["friendly"]["embassy_friendly_hostiledown"]		= "embassy_friendly_hostiledown";
	//level.friendly thread dialogue_thread("embassy_friendly_hostiledown");	
	
	//cmd
	//"All call signs, keep it quiet until insertion is complete."
	level.scr_sound["cmd"]["embassy_cmd_keepitquiet"]		= "embassy_cmd_keepitquiet";
	//dialogue_radio_thread("embassy_cmd_keepitquiet");	
	
	//neg
	//"We don?t want a bloodbath here, Salim, so let?s...let?s just talk about"
	level.scr_sound["neg"]["embassy_neg_nobloodbath"]		= "embassy_neg_nobloodbath";
	//dialogue_radio_thread("embassy_neg_nobloodbath");	
	
	//mbg
	//"What is that sound? <foreign language telling other terrorist to go investigate>"
	level.scr_sound["mbg"]["embassy_mbg_whatisthatsound"]		= "embassy_mbg_whatisthatsound";
	//dialogue_radio_thread("embassy_mbg_whatisthatsound");	
	
	//cmd
	//"This is command. Alpha One, your LOE is balcony three-three."
	level.scr_sound["cmd"]["embassy_cmd_locationofentry"]		= "embassy_cmd_locationofentry";
	//dialogue_radio_thread("embassy_cmd_locationofentry");	
	
	//gaz
	//"Let's move. They're getting our ropes setup at the last balcony."
	level.scr_sound["gaz"]["embassy_gaz_gettoropes"]		= "embassy_gaz_gettoropes";
	//level.gaz thread dialogue_thread("embassy_gaz_gettoropes");	
	
	//frnd
	//"Get to your insertion point!"
	level.scr_sound["guy"]["embassy_frnd_gettoinsertionpoint"]		= "embassy_frnd_gettoinsertionpoint";
	//level.frnd thread dialogue_thread("embassy_frnd_gettoinsertionpoint");	
	
	//neg
	//"Now...Salim...tell me exactly what you need...we do not want any more hostages to be harmed"
	level.scr_sound["neg"]["embassy_neg_tellmewhatyouneed"]		= "embassy_neg_tellmewhatyouneed";
	//dialogue_radio_thread("embassy_neg_tellmewhatyouneed");	
	
	//mbg
	//"There is...we hear sound coming from the roof..."
	level.scr_sound["mbg"]["embassy_mbg_soundsonroof"]		= "embassy_mbg_soundsonroof";
	//dialogue_radio_thread("embassy_mbg_soundsonroof");	
	
	//neg
	//"Salim...there is nothing on the rooftop. Salim...(off microphone) blast, we?ve lost radio contact"
	level.scr_sound["neg"]["embassy_neg_nosoundsonroof"]		= "embassy_neg_nosoundsonroof";
	//dialogue_radio_thread("embassy_neg_nosoundsonroof");	
	
	//frnd
	//"You're with Gaz's team, you're at the last set of ropes to the south."
	level.scr_sound["guy"]["embassy_frnd_gettoropes1"]		= "embassy_frnd_gettoropes1";
	//level.frnd thread dialogue_thread("embassy_frnd_gettoropes1");	
	
	//frnd
	//"Get back with your team. Last set of ropes to the south. Get into position, mate, the clock's ticking!"
	level.scr_sound["guy"]["embassy_frnd_gettoropes2"]		= "embassy_frnd_gettoropes2";
	//level.frnd thread dialogue_thread("embassy_frnd_gettoropes2");	
	
	//jack
	//"Grab the rope, Andy. We'll absail down to the balcony below."
	level.scr_sound["jack"]["embassy_jack_grabtherope1"]		= "embassy_jack_grabtherope1";
	//level.jack thread dialogue_thread("embassy_jack_grabtherope1");	
	
	//jack
	//"Get on the bloody rope Andy, we haven't much time."
	level.scr_sound["jack"]["embassy_jack_grabtherope2"]		= "embassy_jack_grabtherope2";
	//level.jack thread dialogue_thread("embassy_jack_grabtherope2");	
	
	//sierra
	//"Balcony windows are blocked. Security grates and drapes. X Rays cannot see your approach."
	level.scr_sound["sierra"]["embassy_sierra_windowsclosed"]		= "embassy_sierra_windowsclosed";
	//level.sierra thread dialogue_thread("embassy_sierra_windowsclosed");	
	
	//cmd
	//"Roger, Sierra One. All call signs prepare frame charges for your LOE."
	level.scr_sound["cmd"]["embassy_cmd_preparecharges"]		= "embassy_cmd_preparecharges";
	//dialogue_radio_thread("embassy_cmd_preparecharges");	
	
	//jack
	//"Just like the killing house back at Hereford, eh Andy?"
	level.scr_sound["jack"]["embassy_jack_justlikekillinghouse"]		= "embassy_jack_justlikekillinghouse";
	//level.jack thread dialogue_thread("embassy_jack_justlikekillinghouse");	
	
	//gaz
	//"Remember, weapons hold until my signal. No firing until we've breached the building."
	level.scr_sound["guy"]["embassy_gaz_weaponsholdtillbreach"]		= "embassy_gaz_weaponsholdtillbreach";
	//level.gaz thread dialogue_thread("embassy_gaz_weaponsholdtillbreach");	
	
	//gaz
	//"Get a frame charge on there, Andy. And wait for my signal"
	level.scr_sound["gaz"]["embassy_gaz_framechargewindow"]		= "embassy_gaz_framechargewindow";
	//level.gaz thread dialogue_thread("embassy_gaz_framechargewindow");	
	
	//cmd
	//"All call signs, stand by...standby. Go! Go! Go!"
	level.scr_sound["cmd"]["embassy_cmd_executeia"]		= "embassy_cmd_executeia";
	//dialogue_radio_thread("embassy_cmd_executeia");	
	
	//gaz
	//"Blow it!"
	level.scr_sound["gaz"]["embassy_gaz_blowwindow"]		= "embassy_gaz_blowwindow";
	//level.gaz thread dialogue_thread("embassy_gaz_blowwindow");	
	
	//gaz
	//"Weapons free. Weapons free."
	level.scr_sound["gaz"]["embassy_gaz_weaponsfree"]		= "embassy_gaz_weaponsfree";
	//level.gaz thread dialogue_thread("embassy_gaz_weaponsfree");	
	
	//frnd
	//"Let's move it along gentlemen. Take this office back here."
	level.scr_sound["guy"]["embassy_frnd_letsmoveoffices"]		= "embassy_frnd_letsmoveoffices";
	//level.frnd thread dialogue_thread("embassy_frnd_letsmoveoffices");	

	//frnd
	//"Gamma team is unresponsive...get in there and have a look."
	level.scr_sound["guy"]["embassy_frnd_teamisdown"]		= "embassy_frnd_teamisdown";
		
	//frnd
	//"Hostile! Take him out!"
	level.scr_sound["guy"]["embassy_frnd_takehimout"]		= "embassy_frnd_takehimout";
	//level.frnd thread dialogue_thread("embassy_frnd_takehimout");	

	//hostage
	//"Don't shoot!"
	level.scr_sound["embassy_hos_dontshoot"]		= "embassy_hos_dontshoot";
	//guy thread dialogue_thread("embassy_hos_dontshoot");
	
	//Gaz
	//"Command, this is Alpha One. South offices secure."
	level.scr_sound["gaz"]["embassy_gaz_southofficesecure"]		= "embassy_gaz_southofficesecure";
		
	//Cmd
	//Roger that, Alpha One. RV with teams in North offices. Additional reinforcements inserting at your position.
	level.scr_sound["cmd"]["embassy_cmd_proceedtonorth"]		= "embassy_cmd_proceedtonorth";
			
	//cmd
	//"This is Command. Additional reinforcements inserting at your position."
	level.scr_sound["cmd"]["embassy_cmd_additionalforces1"]		= "embassy_cmd_additionalforces1";
	//dialogue_radio_thread("embassy_cmd_additionalforces1");	
	
	//cmd
	//"Alpha One. We've got reinforcements moving into your position."
	level.scr_sound["cmd"]["embassy_cmd_additionalforces2"]		= "embassy_cmd_additionalforces2";
	//dialogue_radio_thread("embassy_cmd_additionalforces2");	
	
	//cmd
	//"This is Command. Sending in additional reinforcements."
	level.scr_sound["cmd"]["embassy_cmd_additionalforces3"]		= "embassy_cmd_additionalforces3";
	//dialogue_radio_thread("embassy_cmd_additionalforces3");	
	
	//frnd
	//"This way people. Let's move."
	level.scr_sound["guy"]["embassy_frnd_thiswayletsmove"]		= "embassy_frnd_thiswayletsmove";
	//level.frnd thread dialogue_thread("embassy_frnd_thiswayletsmove");	
	
	//sierra
	//"I have a confirmed X Ray at window three-two."
	level.scr_sound["sierra"]["embassy_sierra_taketheshot"]		= "embassy_sierra_taketheshot";
	//level.sierra thread dialogue_thread("embassy_sierra_taketheshot");	
	
	//cmd
	//"Take the shot, Sierra One."
	level.scr_sound["cmd"]["embassy_cmd_taketheshot"]		= "embassy_cmd_taketheshot";
	//dialogue_radio_thread("embassy_cmd_taketheshot");	
	
	//frnd
	//"that?s a confirmed kill, Sierra One"
	level.scr_sound["guy"]["embassy_frnd_confirmedkill"]		= "embassy_frnd_confirmedkill";
	//level.frnd thread dialogue_thread("embassy_frnd_confirmedkill");	
	
	//frnd
	//"Easy. Take it easy. We have to do this until we can confirm you?re not a terrorist as well."
	level.scr_sound["guy"]["embassy_frnd_hostageambient1"]		= "embassy_frnd_hostageambient1";
	//level.frnd thread dialogue_thread("embassy_frnd_hostageambient1");	
	
	//frnd
	//"We'll get you out of here as soon as possible."
	level.scr_sound["guy"]["embassy_frnd_hostageambient2"]		= "embassy_frnd_hostageambient2";
	//level.frnd thread dialogue_thread("embassy_frnd_hostageambient2");	
	
	//Jack
	//Hold your fire!
	level.scr_sound["jack"]["embassy_jack_holdyourfire"]		= "embassy_jack_holdyourfire";
		
	//frnd
	//Just in time, chaps.
	level.scr_sound["guy"]["embassy_frnd_yourejustintimechaps"]		= "embassy_frnd_yourejustintimechaps";
		
	//frnd
	//"We've got a group across the hall pinning us down. I need a man to assist a flanking maneuver from the balcony"
	level.scr_sound["guy"]["embassy_frnd_pinneddown"]		= "embassy_frnd_pinneddown";
	level.scr_anim["guy"]["embassy_frnd_pinneddown"] = (%signal_over_shoulder);
	//level.frnd thread dialogue_thread("embassy_frnd_pinneddown");	
	
	//gaz
	//"You're up Andy"
	level.scr_sound["gaz"]["embassy_gaz_youreup"]		= "embassy_gaz_youreup";
	//level.gaz thread dialogue_thread("embassy_gaz_youreup");
	
	//frnd
	//"Get moving! We'll cover you while you cross the hallway"
	level.scr_sound["guy"]["embassy_frnd_coverwhilecrosshall"]		= "embassy_frnd_coverwhilecrosshall";
	//level.frnd thread dialogue_thread("embassy_frnd_coverwhilecrosshall");
	
	//frnd
	//"Go! Go! Go! Get to the balcony"
	level.scr_sound["guy"]["embassy_frnd_gettothebalcony"]		= "embassy_frnd_gettothebalcony";
	//level.frnd thread dialogue_thread("embassy_frnd_gettothebalcony");
	
	//frnd
	//(whispered) Over here, Andy!
	level.scr_sound["guy"]["embassy_frnd_balconyoverhere"]		= "embassy_frnd_balconyoverhere";
		
	//frnd
	//"Alright mate, lead the way and keep low."
	level.scr_sound["guy"]["embassy_frnd_balconyleadtheway"]		= "embassy_frnd_balconyleadtheway";
	//level.frnd thread dialogue_thread("embassy_frnd_balconyleadtheway");	
	
	
	//gaz
	//"Command, this is Alpha One. North offices have been secured."
	level.scr_sound["gaz"]["embassy_gaz_northofficessecured"]		= "embassy_gaz_northofficessecured";
	//level.gaz thread dialogue_thread("embassy_gaz_northofficessecured");
	
	//cmd
	//"Roger Alpha One. Proceed to the Banquet Hall and secure remaining hostages."
	level.scr_sound["cmd"]["embassy_cmd_gettobanquet"]		= "embassy_cmd_gettobanquet";
	//dialogue_radio_thread("embassy_cmd_gettobanquet");	
	
	//frnd
	//"My team will exfil hostages in this area. Get down to the banquet hall and carry on."
	level.scr_sound["guy"]["embassy_frnd_gettobanquet"]		= "embassy_frnd_gettobanquet";
	//level.frnd thread dialogue_thread("embassy_frnd_gettobanquet");
	
	//gaz
	//"Let's move."
	level.scr_sound["gaz"]["embassy_gaz_letsmove"]		= "embassy_gaz_letsmove";
	//level.gaz thread dialogue_thread("embassy_gaz_letsmove");	
	
	//frnd
	//"They're retreating! Take them out!"
	level.scr_sound["guy"]["embassy_frnd_banquetretreat"]		= "embassy_frnd_banquetretreat";
	//level.frnd thread dialogue_thread("embassy_frnd_banquetretreat");	
	
	//frnd
	//"Watch your fire, watch your fire. We still have hostages unaccounted for."
	level.scr_sound["guy"]["embassy_frnd_watchyourfire"]		= "embassy_frnd_watchyourfire";
	//level.frnd thread dialogue_thread("embassy_frnd_watchyourfire");	
	
	//frnd
	//"Get down there! Don't let them get that door shut!"
	level.scr_sound["guy"]["embassy_frnd_dontletdoorshut"]		= "embassy_frnd_dontletdoorshut";
	//level.frnd thread dialogue_thread("embassy_frnd_dontletdoorshut");	
	
	//frnd
	//"They've barricaded themselves in, sir."
	level.scr_sound["guy"]["embassy_frnd_banquetbarricaded"]		= "embassy_frnd_banquetbarricaded";
	//level.frnd thread dialogue_thread("embassy_frnd_banquetbarricaded");	
	
	//Gaz
	//Jack, check the door. Get that fiberoptic under there and tell me what's what.
	level.scr_sound["gaz"]["embassy_gaz_checkbanquetdoor"]		= "embassy_gaz_checkbanquetdoor";
	
	//gaz
	//"They'll be expecting us up the middle. Get charges on either side of the main door."
	level.scr_sound["gaz"]["embassy_gaz_placecharges"]		= "embassy_gaz_placecharges";
	//level.gaz thread dialogue_thread("embassy_gaz_placecharges");	
	
	//Guy
	//Charges in place!
	level.scr_sound["guy"]["embassy_frnd_explosivesplanted1"]		= "embassy_frnd_explosivesplanted1";
	
	//Guy
	//Explosives planted!
	level.scr_sound["guy"]["embassy_frnd_explosivesplanted2"]		= "embassy_frnd_explosivesplanted2";
	
	//jack
	//"Stand back everyone. Three, two one."
	level.scr_sound["jack"]["embassy_jack_standbackbanquet"]		= "embassy_jack_standbackbanquet";
	//level.jack thread dialogue_thread("embassy_jack_standbackbanquet");	
	
	//gaz
	//"Move! Move! Move!"
	level.scr_sound["gaz"]["embassy_gaz_movemovemove"]		= "embassy_gaz_movemovemove";
	//level.gaz thread dialogue_thread("embassy_gaz_movemovemove");	
	
	//gaz
	//"Good work lads. We?ve got a heli coming in to evacuate the Yanks."
	level.scr_sound["gaz"]["embassy_gaz_helievaccoming"]		= "embassy_gaz_helievaccoming";
	//level.gaz thread dialogue_thread("embassy_gaz_helievaccoming");	

	//Gaz
	//Regroup on me, lads. Come on let's move.
	level.scr_sound["gaz"]["embassy_gaz_banquetregroup"]		= "embassy_gaz_banquetregroup";
		
	//gaz
	//"Command, this is Alpha One. All hostages secured in banquet hall and kitchen. Zero X Rays taken prisoner."
	level.scr_sound["gaz"]["embassy_gaz_banquetcleared"]		= "embassy_gaz_banquetcleared";
	//level.gaz thread dialogue_thread("embassy_gaz_banquetcleared");	
	
	//cmd
	//"Understood, Alpha One. Bravo One, what is your status?"
	level.scr_sound["cmd"]["embassy_cmd_bravowhatsyourstatus1"]		= "embassy_cmd_bravowhatsyourstatus1";
	//dialogue_radio_thread("embassy_cmd_bravowhatsyourstatus1");	
	
	//cmd
	//"Bravo One, what is your status? Come in Bravo One."
	level.scr_sound["cmd"]["embassy_cmd_bravowhatsyourstatus2"]		= "embassy_cmd_bravowhatsyourstatus2";
	//dialogue_radio_thread("embassy_cmd_bravowhatsyourstatus2");	
	
	//brv1
	//"This is Bravo One. Hostage reception is blocked. We?re pinned down with a dozen or so hostages in tow...we cannot effectively return fire. Receiving heavy rpg fire."
	level.scr_sound["brv1"]["embassy_brv1_receptionblocked"]		= "embassy_brv1_receptionblocked";
	//level.brv1 thread dialogue_thread("embassy_brv1_receptionblocked");	
	
	//cmd
	//"Roger that. Alpha One, you are to RV immediately with Bravo One. Proceed to the drawing room area opposite hostage reception. Eliminate all X Rays to allow Bravo to proceed with exfil."
	level.scr_sound["cmd"]["embassy_cmd_gettodrawingroom"]		= "embassy_cmd_gettodrawingroom";
	//dialogue_radio_thread("embassy_cmd_gettodrawingroom");	
	
	//gaz
	//"Alright lads, you heard the man, let's get a move on."
	level.scr_sound["gaz"]["embassy_gaz_letsgettodrawingroom"]		= "embassy_gaz_letsgettodrawingroom";
	//level.gaz thread dialogue_thread("embassy_gaz_letsgettodrawingroom");	
	
	//gaz
	//"Remember lads, check those corners"
	level.scr_sound["gaz"]["embassy_gaz_checkcorners1"]		= "embassy_gaz_checkcorners1";
	//level.gaz thread dialogue_thread("embassy_gaz_checkcorners1");	
	
	//jack
	//"Check your corners. Check your corners"
	level.scr_sound["jack"]["embassy_jack_checkcorners1"]		= "embassy_jack_checkcorners1";
	//level.jack thread dialogue_thread("embassy_jack_checkcorners1");	
	
	//gaz
	//"Command! We are pinned down in the service stairwell!"
	level.scr_sound["gaz"]["embassy_gaz_pinneddowninstairwell"]		= "embassy_gaz_pinneddowninstairwell";
	//level.gaz thread dialogue_thread("embassy_gaz_pinneddowninstairwell");	
	
	//brv2
	//"Glad to see you boys. Come with me, Bravo can?t exfil until we take out that RPG. Let's move."
	level.scr_sound["guy"]["embassy_brv2_gladtoseeyou"]		= "embassy_brv2_gladtoseeyou";
	level.scr_anim["guy"]["embassy_brv2_gladtoseeyou"] = (%signal_over_shoulder);
	//level.brv2 thread dialogue_thread("embassy_brv2_gladtoseeyou");	
	
	//brv 1
	//Get back with your team and take out those RPGs!
	level.scr_sound["brv1"]["embassy_brv1_gettoreception"]		= "embassy_brv1_gettoreception";
	
	//brv3
	//"This way, gents."
	level.scr_sound["guy"]["embassy_brv3_thiswaydoorexplode"]		= "embassy_brv3_thiswaydoorexplode";
	//level.brv3 thread dialogue_thread("embassy_brv3_thiswaydoorexplode");	
	
	//brv2
	//"Hold up Fatboy, we need to check the door for explosives!"
	level.scr_sound["guy"]["embassy_brv2_holdupcheckthedoor"]		= "embassy_brv2_holdupcheckthedoor";
	//level.brv2 thread dialogue_thread("embassy_brv2_holdupcheckthedoor");	

	//Gaz
	// Bloody Christ. Booby trap. Jack, get a camera under the next door. 
	level.scr_sound["gaz"]["embassy_gaz_checkthenextdoor"]		= "embassy_gaz_checkthenextdoor";
	//level.gaz thread dialogue_thread("embassy_gaz_checkthenextdoor");	
		
	//jack
	//"Door is clear."
	level.scr_sound["guy"]["embassy_jack_doorisclear"]		= "embassy_jack_doorisclear";
	//level.jack thread dialogue_thread("embassy_jack_doorisclear");	
		
	//Gaz
	//Right. Grab a rope level.scr_sound["gazget into position. Andy, you're over here near me.
	level.scr_sound["guy"]["embassy_gaz_skylightgetready1"]		= "embassy_gaz_skylightgetready1";
	//level.gaz thread dialogue_thread("embassy_gaz_skylightgetready1");	
	
	//Gaz
	//Let's move it Andy! Grab the rope next to me and get into bloody position!
	level.scr_sound["guy"]["embassy_gaz_skylightgetready2"]		= "embassy_gaz_skylightgetready2";
	//level.gaz thread dialogue_thread("embassy_gaz_skylightgetready2");	
		
	//Gaz
	//For christ sake, Andy! Grab the bloody rope! Over here, let's go!
	level.scr_sound["guy"]["embassy_gaz_skylightgetready3"]		= "embassy_gaz_skylightgetready3";
	//level.gaz thread dialogue_thread("embassy_gaz_skylightgetready3");	
		
	//brv2
	//"Looks like there are no hostages down there. Weapons free, gents. Let?s make this quick."
	level.scr_sound["brv2"]["embassy_brv2_weaponsfreereception"]		= "embassy_brv2_weaponsfreereception";
	//level.brv2 thread dialogue_thread("embassy_brv2_weaponsfreereception");	

	//Gaz
	//Right, on three. One....two....3
	level.scr_sound["guy"]["embassy_gaz_skylightonthree"]		= "embassy_gaz_skylightonthree";
	//level.gaz thread dialogue_thread("embassy_gaz_skylightonthree");	
		
	//Gaz
	//Go! Go! Go!
	level.scr_sound["gaz"]["embassy_gaz_skylightgogogo"]		= "embassy_gaz_skylightgogogo";
	//level.gaz thread dialogue_thread("embassy_gaz_skylightgogogo");	
		
	//gaz
	//"Andy, get a frame charge on there and toss in some flashbangs as soon as it's blown"
	level.scr_sound["gaz"]["embassy_gaz_framechargeskylight"]		= "embassy_gaz_framechargeskylight";
	//level.gaz thread dialogue_thread("embassy_gaz_framechargeskylight");	
	
	//gaz
	//"Flashbangs! Now! Get on those ropes!"
	level.scr_sound["gaz"]["embassy_gaz_flashbangsandonropes"]		= "embassy_gaz_flashbangsandonropes";
	//level.gaz thread dialogue_thread("embassy_gaz_flashbangsandonropes");	
	
	//brv1
	//"Thanks, Alpha. We owe you boys a pint."
	level.scr_sound["brv1"]["embassy_brv1_weoweyouapint"]		= "embassy_brv1_weoweyouapint";
	//level.brv1 thread dialogue_thread("embassy_brv1_weoweyouapint");	
	
	//gaz
	//"Hold up Bravo, we'll get these barricades down so you can exfil across the courtyard. Andy! Give us a hand!"
	level.scr_sound["gaz"]["embassy_gaz_takedownbarricades"]		= "embassy_gaz_takedownbarricades";
	//level.gaz thread dialogue_thread("embassy_gaz_takedownbarricades");	

	//Gaz
	//Hold up, Bravo, we'll cover your crossing from here. 
	level.scr_sound["gaz"]["embassy_gaz_courtyardcover"]		= "embassy_gaz_courtyardcover";
	//level.gaz thread dialogue_thread("embassy_gaz_courtyardcover");	
		
	//Gaz
	//Andy, get into position and keep your eyes peeled for hostiles
	level.scr_sound["gaz"]["embassy_gaz_covercommand1"]		= "embassy_gaz_covercommand1";
	//level.gaz thread dialogue_thread("embassy_gaz_covercommand1");	
	
	//Gaz
	//Andy, over here, now!
	level.scr_sound["gaz"]["embassy_gaz_covercommand2"]		= "embassy_gaz_covercommand2";
	//level.gaz thread dialogue_thread("embassy_gaz_covercommand2");	
		
	//Gaz
	//Damnit, Andy! Get into position!
	level.scr_sound["gaz"]["embassy_gaz_covercommand3"]		= "embassy_gaz_covercommand3";
	//level.gaz thread dialogue_thread("embassy_gaz_covercommand3");	
		
	//Jack 
	//Movement! Upper rooftop!
	level.scr_sound["jack"]["embassy_jack_movementupper"]		= "embassy_jack_movementupper";
	//level.jack thread dialogue_thread("embassy_jack_movementupper");	
		
	//Gaz
	//Abort Bravo! Go back! Go back!
	level.scr_sound["gaz"]["emabssy_gaz_abortbravo"]		= "emabssy_gaz_abortbravo";
	//level.gaz thread dialogue_thread("emabssy_gaz_abortbravo");	
		
	//gaz
	//"Sniper! Upper floor!"
	level.scr_sound["gaz"]["embassy_gaz_sniperupperfloor"]		= "embassy_gaz_sniperupperfloor";
	//level.gaz thread dialogue_thread("embassy_gaz_sniperupperfloor");	
	
	//jack
	//"Everyone! Take cover!"
	level.scr_sound["jack"]["embassy_jack_takecover"]		= "embassy_jack_takecover";
	//level.jack thread dialogue_thread("embassy_jack_takecover");	
	
	//gaz
	//"Command, this is Alpha One, we have men down. Sniper in upper offices above the courtyard."
	level.scr_sound["gaz"]["embassy_gaz_sniperinupperoffices"]		= "embassy_gaz_sniperinupperoffices";
	//level.gaz thread dialogue_thread("embassy_gaz_sniperinupperoffices");	
	
	//cmd
	//"Roger, Alpha One. Sierra group does not have a view. Repeat, snipers cannot pinpoint enemy location. Proceed immediately to flush out hostiles in upper offices."
	level.scr_sound["cmd"]["embassy_cmd_proceedtolibrary"]		= "embassy_cmd_proceedtolibrary";
	//dialogue_radio_thread("embassy_cmd_proceedtolibrary");	

	//gaz
	//"Right, our jobs not done yet, lads. 
	level.scr_sound["gaz"]["embassy_gaz_jobsnotdone"]		= "embassy_gaz_jobsnotdone";
	//level.gaz thread dialogue_thread("embassy_gaz_jobsnotdone");	
		
	//gaz
	//Bravo won?t be able to exfil these hostages through that courtyard with a sniper hanging about. 
	level.scr_sound["gaz"]["embassy_gaz_mustfindsniper"]		= "embassy_gaz_mustfindsniper";
	//level.gaz thread dialogue_thread("embassy_gaz_mustfindsniper");	
		
	//gaz
	//Let?s get up there and have a look. Get these elevator doors open."
	level.scr_sound["gaz"]["embassy_gaz_elevatorcmd"]		= "embassy_gaz_elevatorcmd";
	//level.gaz thread dialogue_thread("embassy_gaz_elevatorcmd");	

	//jack
	//"Got it!"
	level.scr_sound["jack"]["embassy_jack_elevatordooropen"]		= "embassy_jack_elevatordooropen";
	//level.jack thread dialogue_thread("embassy_jack_elevatordooropen");	
	
	//brv
	//"Right!, up the elevator shaft, let's go! Let's go!"
	level.scr_sound["guy"]["embassy_brv_getuptheshaft"]		= "embassy_brv_getuptheshaft";
	//level.brv thread dialogue_thread("embassy_brv_getuptheshaft");	
	
	//jack
	//"Can?t tell if it?s booby-trapped. However I do see 3 bad guys clustered right around the corner there. "
	level.scr_sound["jack"]["embassy_jack_librarydoorbreach"]		= "embassy_jack_librarydoorbreach";
	//level.jack thread dialogue_thread("embassy_jack_librarydoorbreach");	
	
	//gaz
	//"Andy, get a charge on that position. Might as well take out a few of them during our entry."
	level.scr_sound["gaz"]["embassy_gaz_breachlibrarywall"]		= "embassy_gaz_breachlibrarywall";
	//level.gaz thread dialogue_thread("embassy_gaz_breachlibrarywall");	
	
	//gaz
	//"Get a charge on that position."
	level.scr_sound["gaz"]["embassy_gaz_breachlibrarywall2"]		= "embassy_gaz_breachlibrarywall2";
	//level.gaz thread dialogue_thread("embassy_gaz_breachlibrarywall2");		
	
	//gaz
	//"Sniper is on the upper balcony. Get up there and sort him out, Andy."
	level.scr_sound["gaz"]["embassy_gaz_gettoupperbalcony"]		= "embassy_gaz_gettoupperbalcony";
	//level.gaz thread dialogue_thread("embassy_gaz_gettoupperbalcony");	
	
	//gaz
	//"This is Alpha One, Bravo One you are all clear for Exfil."
	level.scr_sound["gaz"]["embassy_gaz_bravoonecleartoexfil"]		= "embassy_gaz_bravoonecleartoexfil";
	//level.gaz thread dialogue_thread("embassy_gaz_bravoonecleartoexfil");	
	
	//brv1
	//"Thanks, Alpha One. Proceeding across courtyard to hostage reception."
	level.scr_sound["brv1"]["embassy_brv1_thanksalpha"]		= "embassy_brv1_thanksalpha";
	//level.brv1 thread dialogue_thread("embassy_brv1_thanksalpha");	
	
	//gaz
	//"That?s Bravo One exfiling to you, Command."
	level.scr_sound["gaz"]["embassy_gaz_bravoexfiling"]		= "embassy_gaz_bravoexfiling";
	//level.gaz thread dialogue_thread("embassy_gaz_bravoexfiling");	
	
	//cmd
	//"Negotiations with lead X Ray have gone south...standby."
	level.scr_sound["cmd"]["embassy_cmd_negotiationsgonebad"]		= "embassy_cmd_negotiationsgonebad";
	//dialogue_radio_thread("embassy_cmd_negotiationsgonebad");	
	
	//neg
	//"We are trying to accommodate you but..."
	level.scr_sound["neg"]["embassy_neg_tryingtohelp"]		= "embassy_neg_tryingtohelp";
	//dialogue_radio_thread("embassy_neg_tryingtohelp");	
	
	//mbg
	//"No! Enough! I still have plenty of Americans to execute. You will bring helicopter now!"
	level.scr_sound["mbg"]["embassy_mbg_bringheli"]		= "embassy_mbg_bringheli";
	//dialogue_radio_thread("embassy_mbg_bringheli");	
	
	//neg
	//"Calm down. Now let?s just be reasonable..."
	level.scr_sound["neg"]["embassy_neg_calmdown"]		= "embassy_neg_calmdown";
	//dialogue_radio_thread("embassy_neg_calmdown");	
	
	//mbg
	//"That?s one hostage dead. I will continue to execute one hostage every 60 seconds until the helicopter arrives..."
	level.scr_sound["mbg"]["embassy_mbg_executehostage"]		= "embassy_mbg_executehostage";
	//dialogue_radio_thread("embassy_mbg_executehostage");	
	
	//cmd
	//"Alpha One, you are closest to the position. We'll bring in the heli but DO NOT let the X Rays get mobile. Repeat, hostiles must NOT get mobile."
	level.scr_sound["cmd"]["embassy_cmd_finalsniperinstructions1"]		= "embassy_cmd_finalsniperinstructions1";
	//dialogue_radio_thread("embassy_cmd_finalsniperinstructions1");	
	
	//gaz
	//"Andy! You?re up! Need your sniper skills! Get over to the stairwell, we need to get topside."
	level.scr_sound["gaz"]["embassy_gaz_gettostairwell"]		= "embassy_gaz_gettostairwell";
	//level.gaz thread dialogue_thread("embassy_gaz_gettostairwell");	
	
	//cmd
	//"We?ll only have one chance here, Alpha One. Both hostiles need to be taken out at the same time."
	level.scr_sound["cmd"]["embassy_cmd_finalsniperinstructions2"]		= "embassy_cmd_finalsniperinstructions2";
	//dialogue_radio_thread("embassy_cmd_finalsniperinstructions2");	
	
	//gaz
	//"Right, Andy, Lets get up to the roof and see what we can see"
	level.scr_sound["gaz"]["embassy_gaz_letsgettoroof"]		= "embassy_gaz_letsgettoroof";
	//level.gaz thread dialogue_thread("embassy_gaz_letsgettoroof");	
	
	//jack
	//"Good luck, Andy."
	level.scr_sound["jack"]["embassy_jack_goodluck"]		= "embassy_jack_goodluck";
	//level.jack thread dialogue_thread("embassy_jack_goodluck");	
	
	//jack
	//"Better take this."
	level.scr_sound["jack"]["embassy_jack_takesniperrifle"]		= "embassy_jack_takesniperrifle";
	//level.jack thread dialogue_thread("embassy_jack_takesniperrifle");	
	
	//gaz
	//"Ok, this is what we want. Follow me."
	level.scr_sound["gaz"]["embassy_gaz_ventbash"]		= "embassy_gaz_ventbash";
	//level.gaz thread dialogue_thread("embassy_gaz_ventbash");	
	
	//gaz
	//"I?ll take up position here and we?ll stay in radio contact. Get into position to get a better angle. We?ll need to hit them at the same time."
	level.scr_sound["gaz"]["embassy_gaz_getinposition"]		= "embassy_gaz_getinposition";
	//level.gaz thread dialogue_thread("embassy_gaz_getinposition");	
	
	//gaz
	//"Right, don?t fire until I give you the OK. We need to take out both X Rays at the same time otherwise we risk losing hostages"
	level.scr_sound["gaz"]["embassy_gaz_sniperinstruct1"]		= "embassy_gaz_sniperinstruct1";
	//level.gaz thread dialogue_thread("embassy_gaz_sniperinstruct1");	
	
	//gaz
	//"That?s X Ray One mobile on the rooftop. Hold your fire."
	level.scr_sound["gaz"]["embassy_gaz_sniperinstruct2"]		= "embassy_gaz_sniperinstruct2";
	//level.gaz thread dialogue_thread("embassy_gaz_sniperinstruct2");	
	
	//gaz
	//"Waiting on X Ray Two. Helicopter on approach."
	level.scr_sound["gaz"]["embassy_gaz_sniperinstruct3"]		= "embassy_gaz_sniperinstruct3";
	//level.gaz thread dialogue_thread("embassy_gaz_sniperinstruct3");	
	
	//gaz
	//"That?s the heli landing on the rooftop. Still no sign of X Ray Two. Hold your fire, Andy."
	level.scr_sound["gaz"]["embassy_gaz_sniperinstruct4"]		= "embassy_gaz_sniperinstruct4";
	//level.gaz thread dialogue_thread("embassy_gaz_sniperinstruct4");	
	
	//gaz
	//"Bloody hell! He?s shot the pilot. Hold your fire Andy, we need to wait for X Ray Two. Hostage safety is priority One."
	level.scr_sound["gaz"]["embassy_gaz_sniperinstruct5"]		= "embassy_gaz_sniperinstruct5";
	//level.gaz thread dialogue_thread("embassy_gaz_sniperinstruct5");	
	
	//gaz
	//"That?s it, Andy. We?ll take them on my signal. You take the one on the right, I?ll take the one on the left."
	level.scr_sound["gaz"]["embassy_gaz_sniperinstruct6"]		= "embassy_gaz_sniperinstruct6";
	//level.gaz thread dialogue_thread("embassy_gaz_sniperinstruct6");	
	
	//gaz
	//"Now, Andy! Take him out!"
	level.scr_sound["gaz"]["embassy_gaz_takehimoutnow"]		= "embassy_gaz_takehimoutnow";
	//level.gaz thread dialogue_thread("embassy_gaz_takehimoutnow");	
	
	//gaz
	//"Nice one, Andy. Good work... Command, this is Alpha One. All X Rays are down. Zero hostage casualties."
	level.scr_sound["gaz"]["embassy_gaz_snipercomplete"]		= "embassy_gaz_snipercomplete";
	//level.gaz thread dialogue_thread("embassy_gaz_snipercomplete");	
	
	//cmd
	//"Roger that, Alpha One. All call signs, evacuate the building. Get back to Incident Control and have a brew. Job well done, lads, job well done."
	level.scr_sound["cmd"]["embassy_cmd_jobwelldone"]		= "embassy_cmd_jobwelldone";
	//dialogue_radio_thread("embassy_cmd_jobwelldone");	
}




dialogue_generic()
{
	
	//----------------COMMAND AND CALLSIGNS CHECKING IN------------------//
	//CMD
	//"All teams check in."
	level.scr_sound["cmd"]["embassy_cmd_allteamscheckin"]	= "embassy_cmd_allteamscheckin";
	
	//FRND
	//"Alpha standing by."
	level.scr_sound["frnd"]["embassy_frnd_checkinalpha"]	= "embassy_frnd_checkinalpha";
	
	//FRND
	//"Bravo standing by."
	level.scr_sound["frnd"]["embassy_frnd_checkinbravo"]	= "embassy_frnd_checkinbravo";
	
	//FRND
	//"Charlie good to go."
	level.scr_sound["frnd"]["embassy_frnd_checkincharlie"]	= "embassy_frnd_checkincharlie";
	
	//FRND
	//"Delta checking in."
	level.scr_sound["frnd"]["embassy_frnd_checkindelta"]	= "embassy_frnd_checkindelta";
	
	//FRND
	//"Echo in position."
	level.scr_sound["frnd"]["embassy_frnd_checkinecho"]	= "embassy_frnd_checkinecho";
	
	//FRND
	//"Zulu standing by."
	level.scr_sound["frnd"]["embassy_frnd_checkinzulu"]	= "embassy_frnd_checkinzulu";
	
	//CMD
	//"Roger that. All callsigns I have control. Standby to execute IA. Standby...Standby. Go."
	level.scr_sound["cmd"]["embassy_cmd_standbyandgo"]	= "embassy_cmd_standbyandgo";


	//----------------LEADER DIALOGUE: STAY CLOSE------------------//
	level.embassy_leader_staycloseMAX = 3;
	
	//Price
	//"Stick with me."
	level.scr_sound["price"]["embassy_leader_stayclose01"] = "embassy_leader_stayclose01";
	
	//Price
	//"Stay close."
	level.scr_sound["price"]["embassy_leader_stayclose02"] = "embassy_leader_stayclose02";
	
	//Price
	//"Follow me."
	level.scr_sound["price"]["embassy_leader_stayclose03"] = "embassy_leader_stayclose03";

	//----------------LEADER DIALOGUE: NEXT ROOM!------------------//
	level.embassy_leader_nextroomMAX = 8;
	
	
	//Price
	//"Let's move! Next room! Next Room!"
	level.scr_sound["price"]["embassy_leader_nextroom01"] = "embassy_leader_nextroom01";
	
	//Price
	//"Red team! Next room! Let's go!"
	level.scr_sound["price"]["embassy_leader_nextroom02"] = "embassy_leader_nextroom02";
	
	//Price
	//"Next room! Move! Move!"
	level.scr_sound["price"]["embassy_leader_nextroom03"] = "embassy_leader_nextroom03";
	
	//Price
	//"Move on! Next room!"
	level.scr_sound["price"]["embassy_leader_nextroom04"] = "embassy_leader_nextroom04";
	
	//Price
	//"Next room! Follow me!"
	level.scr_sound["price"]["embassy_leader_nextroom05"] = "embassy_leader_nextroom05";
	
	//Price
	//"Follow me! Next room!"
	level.scr_sound["price"]["embassy_leader_nextroom06"] = "embassy_leader_nextroom06";
	
	//Price
	//"Let's move on! Follow me!"
	level.scr_sound["price"]["embassy_leader_nextroom07"] = "embassy_leader_nextroom07";
	
	//Price
	//"Red Team! Let's move on!"
	level.scr_sound["price"]["embassy_leader_nextroom08"] = "embassy_leader_nextroom08";

	//----------------LEADER DIALOGUE: ROOM NAGS------------------//
	level.embassy_leader_roomnagMAX = 4;
	
	//Price
	//"Over here! Let's go let's go!"
	level.scr_sound["price"]["embassy_leader_roomnag01"] = "embassy_leader_roomnag01";
	
	//Price
	//"Let's move! Over here!"
	level.scr_sound["price"]["embassy_leader_roomnag02"] = "embassy_leader_roomnag02";
	
	//Price
	//"Get into position, let's go! Let's go!"
	level.scr_sound["price"]["embassy_leader_roomnag03"] = "embassy_leader_roomnag03";
	
	//Price
	//"Everyone get into position! Over here!"	
	level.scr_sound["price"]["embassy_leader_roomnag04"] = "embassy_leader_roomnag04";

	//----------------COMMAND - ACKNOWLEDGEMENTS-------------------//
	
	//cmd
	//All teams. Standby to execute IA. 15 seconds
	level.scr_sound["cmd"]["embassy_cmd_allteamsprepare"]		= "embassy_cmd_allteamsprepare";
	//cmd queue_anim("embassy_cmd_allteamsprepare");
	
	//----------------COMMAND/FRIENDLY - HOSTAGES SECURED FLOOR TWO SOUTH -------------------//
	//FRND
	//"Hostages secured in room two-alpha"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02_01"]	= "embassy_frnd_hostagessecured_02_01";
	
	//CMD
	//"Copy, hostages secured in room two-alpha "
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02_01"]	= "embassy_cmd_hostagessecured_02_01";
	
	//FRND
	//"Hostages secured in room two-bravo"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02_02"]	= "embassy_frnd_hostagessecured_02_02";
	
	//CMD
	//"Copy, hostages secured in two-bravo"
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02_02"]	= "embassy_cmd_hostagessecured_02_02";
	
	//FRND
	//"Hostages secured in two-charlie"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02_03"]	= "embassy_frnd_hostagessecured_02_03";
	
	//CMD
	//"Roger that, hostages secured in two-charlie"
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02_03"]	= "embassy_cmd_hostagessecured_02_03";
	
	//FRND
	//"Hostages secured in room two-delta"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02_04"]	= "embassy_frnd_hostagessecured_02_04";
	
	//CMD
	//"Roger, hostages secured in two-delta"
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02_04"]	= "embassy_cmd_hostagessecured_02_04";
	
	//FRND
	//"Hostages secured in two-echo"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02_05"]	= "embassy_frnd_hostagessecured_02_05";
	
	//CMD
	//"Copy, hostages secured in two-echo"
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02_05"]	= "embassy_cmd_hostagessecured_02_05";
	
	//FRND
	//"Hostages secured in two-foxtrot"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02_06"]	= "embassy_frnd_hostagessecured_02_06";
	
	//CMD
	//"Copy that, hostages secured in two-foxtrot"
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02_06"]	= "embassy_cmd_hostagessecured_02_06";
	
	//FRND
	//"Hostages secured in room two-golf"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02_07"]	= "embassy_frnd_hostagessecured_02_07";
	
	//CMD
	//"Roger that, hostages secured in room two-golf"
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02_07"]	= "embassy_cmd_hostagessecured_02_07";
	
	//FRND
	//"Hostages secured in room two-hotel"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02_08"]	= "embassy_frnd_hostagessecured_02_08";
	
	//CMD
	//"Copy, hostages secured in two-hotel"
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02_08"]	= "embassy_cmd_hostagessecured_02_08";
	
	//FRND
	//"Hostages secured in two-india"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02_09"]	= "embassy_frnd_hostagessecured_02_09";
	
	//CMD
	//"Roger, hostages secured in two-india"
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02_09"]	= "embassy_cmd_hostagessecured_02_09";
	
	//FRND
	//"All hostages, floor two south secure"
	level.scr_sound["frnd"]["embassy_frnd_hostagessecured_02south_all"]	= "embassy_frnd_hostagessecured_02south_all";
	
	//CMD
	//"Copy, all hostages secure on floor two south"
	level.scr_sound["cmd"]["embassy_cmd_hostagessecured_02south_all"]	= "embassy_cmd_hostagessecured_02south_all";
	



	//----------------COMMAND - HOSTAGE SECURED -------------------//
	level.embassy_cmd_hostagesecuredMAX = 1;
	//cmd
	//"copy - hostage secured."
	level.scr_sound["cmd"]["embassy_cmd_hostagesecured01"]	= "embassy_cmd_hostagesecured01";
		
	//----------------COMMAND - MAN DOWN -------------------//
	level.embassy_cmd_mandownMAX = 5;
	//cmd
	//"copy - man down."
	level.scr_sound["cmd"]["embassy_cmd_mandown01"]		= "embassy_cmd_mandown01";
	//cmd queue_anim("embassy_cmd_mandown01");
	
	//CMD
	//"Roger, man down"
	level.scr_sound["cmd"]["embassy_cmd_mandown02"]	= "embassy_cmd_mandown02";
	
	//CMD
	//"Got that, man down"
	level.scr_sound["cmd"]["embassy_cmd_mandown03"]	= "embassy_cmd_mandown03";
	
	//CMD
	//"Roger that, man down "
	level.scr_sound["cmd"]["embassy_cmd_mandown04"]	= "embassy_cmd_mandown04";
	
	//CMD
	//"Copy that man down"	
	level.scr_sound["cmd"]["embassy_cmd_mandown05"]	= "embassy_cmd_mandown05";
	
	
	//----------------COMMAND/SAS - TIMER NAGS -------------------//
	level.embassy_cmd_timer_naga_MAX = 4;
	level.embassy_cmd_timer_nagb_MAX = 4;
	level.embassy_cmd_timer_nagc_MAX = 4;
	level.embassy_cmd_timer_nagd_MAX = 4;

	//CMD
	//"Keep moving! Multiple X-rays still active in your sector!"
	level.scr_sound["cmd"]["embassy_cmd_timer_naga_01"]	= "embassy_cmd_timer_naga_01";
	
	//CMD
	//"There are still hostages unaccounted for ? keep moving. "
	level.scr_sound["cmd"]["embassy_cmd_timer_naga_02"]	= "embassy_cmd_timer_naga_02";
	
	//CMD
	//"Get moving! All X-Rays have *not* been neutralized in your area! "
	level.scr_sound["cmd"]["embassy_cmd_timer_naga_03"]	= "embassy_cmd_timer_naga_03";
	
	//CMD
	//"Multiple threats still active in your area. Move! "
	level.scr_sound["cmd"]["embassy_cmd_timer_naga_04"]	= "embassy_cmd_timer_naga_04";
	
	//CMD
	//"Area not secure - I repeat - area *not* secure. Keep moving."
	level.scr_sound["cmd"]["embassy_cmd_timer_nagb_01"]	= "embassy_cmd_timer_nagb_01";
	
	//CMD
	//"Multiple X-Rays still active. Move! "
	level.scr_sound["cmd"]["embassy_cmd_timer_nagb_02"]	= "embassy_cmd_timer_nagb_02";
	
	//CMD
	//"Multiple hostages still unaccounted for."
	level.scr_sound["cmd"]["embassy_cmd_timer_nagb_03"]	= "embassy_cmd_timer_nagb_03";
	
	//CMD
	//"Continue to all rooms in the area. We are still not secure. Get moving! "
	level.scr_sound["cmd"]["embassy_cmd_timer_nagb_04"]	= "embassy_cmd_timer_nagb_04";
	
	//CMD
	//"Area not secure, keep moving! We are running out of time!"
	level.scr_sound["cmd"]["embassy_cmd_timer_nagc_01"]	= "embassy_cmd_timer_nagc_01";
	
	//CMD
	//"We?re running out of time. Go! go! "
	level.scr_sound["cmd"]["embassy_cmd_timer_nagc_02"]	= "embassy_cmd_timer_nagc_02";
	
	//CMD
	//"Hostages are still in danger in your area! "
	level.scr_sound["cmd"]["embassy_cmd_timer_nagc_03"]	= "embassy_cmd_timer_nagc_03";
	
	//CMD
	//"Get moving and clear all remaining offices! "
	level.scr_sound["cmd"]["embassy_cmd_timer_nagc_04"]	= "embassy_cmd_timer_nagc_04";
	
	//CMD
	//"S?t they?re killing the hostages! We have multiple hostages down! Repeat! Multiple hostages down!"
	level.scr_sound["cmd"]["embassy_cmd_timer_nagd_01"]	= "embassy_cmd_timer_nagd_01";
	
	//CMD
	//"Hostages down! Hostages have been executed! "
	level.scr_sound["cmd"]["embassy_cmd_timer_nagd_02"]	= "embassy_cmd_timer_nagd_02";
	
	//CMD
	//"They?re killing the hostages! We have hostages down! "
	level.scr_sound["cmd"]["embassy_cmd_timer_nagd_03"]	= "embassy_cmd_timer_nagd_03";
	
	//CMD
	//"Hostages have been executed! Repeat, hostages have been executed. "
	level.scr_sound["cmd"]["embassy_cmd_timer_nagd_04"]	= "embassy_cmd_timer_nagd_04";


	//----------------FRIENDLY - HOSTAGE SECURED-------------------//
	level.embassy_frnd_hostage_securedMAX = 2;
	//frnd
	//"hostage secured."
	level.scr_sound["frnd"]["embassy_frnd_hostage_secured01"]		= "embassy_frnd_hostage_secured01";
	level.scr_sound["frnd"]["embassy_frnd_hostage_secured02"]		= "embassy_frnd_hostage_secured02";


	//----------------FRIENDLY - AREA CLEARED-------------------//	
	level.embassy_frnd_clear_genericMAX = 3;
	
	//frnd
	//"clear! let's move on!"
	level.scr_sound["frnd"]["embassy_frnd_clear_generic01"]		= "embassy_frnd_clear_generic03";

	//frnd
	//"clear!"
	level.scr_sound["frnd"]["embassy_frnd_clear_generic02"]		= "embassy_frnd_clear_generic03";

	
	//frnd
	//"clear!"
	level.scr_sound["frnd"]["embassy_frnd_clear_generic03"]		= "embassy_frnd_clear_generic03";


	level.embassy_frnd_clear_roomMAX = 1;
	//frnd
	//"this room is clear!"
	level.scr_sound["frnd"]["embassy_frnd_clear_room01"]		= "embassy_frnd_clear_room02";
	
	//frnd
	//"room clear!"
	level.scr_sound["frnd"]["embassy_frnd_clear_room02"]		= "embassy_frnd_clear_room02";


	//----------------FRIENDLY - ENEMY KILLED-------------------//	
	level.embassy_frnd_hostiledownMAX = 8;
	//frnd
	//"hostile down."
	level.scr_sound["frnd"]["embassy_frnd_hostiledown01"]		= "embassy_frnd_hostiledown02";
	
	//frnd
	//"enemy down."
	level.scr_sound["frnd"]["embassy_frnd_hostiledown02"]		= "embassy_frnd_hostiledown02";
	
	//frnd
	//"enemy neutralized."
	level.scr_sound["frnd"]["embassy_frnd_hostiledown03"]		= "embassy_frnd_hostiledown03";
	
	//frnd
	//"x-ray neutralized."
	level.scr_sound["frnd"]["embassy_frnd_hostiledown04"]		= "embassy_frnd_hostiledown04";
	
	//frnd
	//"x-ray down."
	level.scr_sound["frnd"]["embassy_frnd_hostiledown05"]		= "embassy_frnd_hostiledown05";
	
	//frnd
	//"threat neutralized."
	level.scr_sound["frnd"]["embassy_frnd_hostiledown06"]		= "embassy_frnd_hostiledown06";
	
	//frnd
	//"target eliminated."
	level.scr_sound["frnd"]["embassy_frnd_hostiledown07"]		= "embassy_frnd_hostiledown07";
	
	//frnd
	//"target neutralized."
	level.scr_sound["frnd"]["embassy_frnd_hostiledown08"]		= "embassy_frnd_hostiledown08";
	
	
	//----------------FRIENDLY - NEED FRAME CHARGE -------------------//
	level.embassy_frnd_needbreachMAX = 2;
	//frnd
	//"over here! i need a breaching charge!"
	level.scr_sound["frnd"]["embassy_frnd_needbreach01"]		= "embassy_frnd_needbreach01";
	
	//frnd
	//"i need a frame charge over here!"
	level.scr_sound["frnd"]["embassy_frnd_needbreach02"]		= "embassy_frnd_needbreach02";

	//----------------FRIENDLY - SHOTGUN INSTRUCTIONS -------------------//
	level.embassy_frnd_shotgunreadyMAX = 2;
	//frnd
	//"shotgun ready!"
	level.scr_sound["frnd"]["embassy_frnd_shotgunready01"]		= "embassy_frnd_shotgunready01";
	
	//frnd
	//"shotgun standing by!"
	level.scr_sound["frnd"]["embassy_frnd_shotgunready02"]		= "embassy_frnd_shotgunready02";

	level.embassy_frnd_shotgunbreachMAX = 2;
	//frnd
	//"get back!"
	level.scr_sound["frnd"]["embassy_frnd_shotgunbreach01"]		= "embassy_frnd_shotgunbreach01";
	
	//frnd
	//"stand back!"
	level.scr_sound["frnd"]["embassy_frnd_shotgunbreach02"]		= "embassy_frnd_shotgunbreach02";



	
	//----------------FRIENDLY - BREACH INSTRUCT -------------------//
	level.embassy_frnd_breachinstructMAX = 4;
	//frnd
	//"blow the door and wait for my flashbang!"
	level.scr_sound["frnd"]["embassy_frnd_breachinstruct01"]		= "embassy_frnd_breachinstruct01";

	//FRND
	//"Plant a frame charge here! Standby for flashbang! "
	level.scr_sound["frnd"]["embassy_frnd_breachinstruct02"]	= "embassy_frnd_breachinstruct02";
	
	//FRND
	//"Frame charge here! Standby for flashbang! "
	level.scr_sound["frnd"]["embassy_frnd_breachinstruct03"]	= "embassy_frnd_breachinstruct03";
	
	//FRND
	//"Plant a charge here and wait for my flashbang!"
	level.scr_sound["frnd"]["embassy_frnd_breachinstruct04"]	= "embassy_frnd_breachinstruct04";

	//----------------FRIENDLY - BREACH INSTRUCT WITH FLASH-------------------//
	level.embassy_frnd_breachflashinstructMAX = 4;
	//FRND
	//"Blow the door and throw in a flashbang!"
	level.scr_sound["frnd"]["embassy_frnd_breachflashinstruct01"] = "embassy_frnd_breachflashinstruct01";
	
	//FRND
	//"Breach the door, then throw a flashbang!"
	level.scr_sound["frnd"]["embassy_frnd_breachflashinstruct02"] = "embassy_frnd_breachflashinstruct02";
	
	//FRND
	//"Breach and flash! Ready!"
	level.scr_sound["frnd"]["embassy_frnd_breachflashinstruct03"] = "embassy_frnd_breachflashinstruct03";
	
	//FRND
	//"Blow the door then get a flashbang in there!"
	level.scr_sound["frnd"]["embassy_frnd_breachflashinstruct04"] = "embassy_frnd_breachflashinstruct04";


	//----------------FRIENDLY - STANDBY!-------------------//

	level.embassy_frnd_standbyMAX = 1;
	//frnd
	//"standby!"
	level.scr_sound["frnd"]["embassy_frnd_standby01"]		= "embassy_frnd_throwingflash01";	
	
	
	level.embassy_frnd_throwingflashMAX = 1;
	//frnd
	//"standby!"
	level.scr_sound["frnd"]["embassy_frnd_throwingflash01"]		= "embassy_frnd_throwingflash01";

	
	//----------------FRIENDLY - FLASHBANGS -------------------//
	level.embassy_frnd_flashbangnowMAX = 4;
	
	//frnd
	//"flashbang! now!"
	level.scr_sound["frnd"]["embassy_frnd_flashbangnow01"]		= "embassy_frnd_flashbangnow01";
	
	//frnd
	//"flashbangs! now!"
	level.scr_sound["frnd"]["embassy_frnd_flashbangnow02"]		= "embassy_frnd_flashbangnow02";
	
	//frnd
	//"flashbang now!"
	level.scr_sound["frnd"]["embassy_frnd_flashbangnow03"]		= "embassy_frnd_flashbangnow03";
	
	//frnd
	//"flashbang do it!"
	level.scr_sound["frnd"]["embassy_frnd_flashbangnow04"]		= "embassy_frnd_flashbangnow04";
	
	//----------------FRIENDLY - GO GO GO  -------------------//
	level.embassy_frnd_movegomoveMAX = 7;
	//frnd
	//"go! go! go!"
	level.scr_sound["frnd"]["embassy_frnd_movegomove01"]		= "embassy_frnd_movegomove02";
	
	//frnd
	//"move move!"
	level.scr_sound["frnd"]["embassy_frnd_movegomove02"]		= "embassy_frnd_movegomove02";
	
	//frnd
	//"go go go!"
	level.scr_sound["frnd"]["embassy_frnd_movegomove03"]		= "embassy_frnd_movegomove03";
	
	//FRND
	//"In the door! In the door!"
	level.scr_sound["frnd"]["embassy_frnd_movegomove04"]	= "embassy_frnd_movegomove04";
	
	//FRND
	//"Let?s go! Let?s go!"
	level.scr_sound["frnd"]["embassy_frnd_movegomove05"]	= "embassy_frnd_movegomove05";
	
	//FRND
	//"Move! Move!"
	level.scr_sound["frnd"]["embassy_frnd_movegomove06"]	= "embassy_frnd_movegomove06";
	
	//FRND
	//"Move in!!!"	
	level.scr_sound["frnd"]["embassy_frnd_movegomove07"]	= "embassy_frnd_movegomove07";
	
	//----------------FRIENDLY - MAN DOWN -------------------//
	level.embassy_frnd_mandownMAX = 6;
	//frnd
	//"man dowwn!!!"
	level.scr_sound["frnd"]["embassy_frnd_mandown01"]		= "embassy_frnd_mandown01";
	
	//frnd
	//"man down, man down!"
	level.scr_sound["frnd"]["embassy_frnd_mandown02"]		= "embassy_frnd_mandown02";
	
	//frnd
	//"man down!"
	level.scr_sound["frnd"]["embassy_frnd_mandown03"]		= "embassy_frnd_mandown03";

	//FRND
	//"Man down!"
	level.scr_sound["frnd"]["embassy_frnd_mandown04"]	= "embassy_frnd_mandown04";
	
	//FRND
	//"Man down man down!"
	level.scr_sound["frnd"]["embassy_frnd_mandown05"]	= "embassy_frnd_mandown05";
	
	//FRND
	//"We?ve got a man down!"
	level.scr_sound["frnd"]["embassy_frnd_mandown06"]	= "embassy_frnd_mandown06";

	
	//----------------FRIENDLY - BREACH ENTER -------------------//
	level.embassy_frnd_getdownMAX = 10;
	//frnd
	//"get down, get down!"
	level.scr_sound["frnd"]["embassy_frnd_getdown01"]		= "embassy_frnd_getdown01";
	
	//frnd
	//"stay down!!!"
	level.scr_sound["frnd"]["embassy_frnd_getdown02"]		= "embassy_frnd_getdown02";
	
	//frnd
	//"stay on the floor! get down!"
	level.scr_sound["frnd"]["embassy_frnd_getdown03"]		= "embassy_frnd_getdown03";
	
	//frnd
	//"down on the floor now!!!"
	level.scr_sound["frnd"]["embassy_frnd_getdown04"]		= "embassy_frnd_getdown04";
	
	//frnd
	//"get down on the floor!!!"
	level.scr_sound["frnd"]["embassy_frnd_getdown05"]		= "embassy_frnd_getdown05";
	
	//frnd
	//"down on the floor down on the floor!!!!"
	level.scr_sound["frnd"]["embassy_frnd_getdown06"]		= "embassy_frnd_getdown06";

	//FRND
	//"Get down and stay down!"
	level.scr_sound["frnd"]["embassy_frnd_getdown07"]	= "embassy_frnd_getdown07";
	
	//FRND
	//"Everyone! Down on the floor!"
	level.scr_sound["frnd"]["embassy_frnd_getdown08"]	= "embassy_frnd_getdown08";
	
	//FRND
	//"Everyone get down! Get down!"
	level.scr_sound["frnd"]["embassy_frnd_getdown09"]	= "embassy_frnd_getdown09";
	
	//FRND
	//"On the floor now!"
	level.scr_sound["frnd"]["embassy_frnd_getdown10"]	= "embassy_frnd_getdown10";

	//----------------HOSTAGES - RESCUED-------------------//
	level.embassy_hosfem_rescuedMAX = 7;

	//FEMALE
		
	//hosfem
	//"don't leave - please!"
	level.scr_sound["civilian"]["embassy_hosfem_rescued01"]		= "embassy_hosfem_rescued01";
	
	//hosfem
	//"what?s going on get me out of here!"
	level.scr_sound["civilian"]["embassy_hosfem_rescued02"]		= "embassy_hosfem_rescued02";
	
	//hosfem
	//"thank god you?re here!"
	level.scr_sound["civilian"]["embassy_hosfem_rescued03"]		= "embassy_hosfem_rescued03";
	
	//hosfem
	//"get me out of here!"
	level.scr_sound["civilian"]["embassy_hosfem_rescued04"]		= "embassy_hosfem_rescued04";

	//HOSFEM
	//"<Incoherent crying >"
	level.scr_sound["civilian"]["embassy_hosfem_rescued05"]	= "embassy_hosfem_rescued05";
	 
	//HOSFEM
	//"Oh God?is it over? <crying>"
	level.scr_sound["civilian"]["embassy_hosfem_rescued06"]	= "embassy_hosfem_rescued06";
	
	//HOSFEM
	//"Please, I just want to get out of here <crying>"
	level.scr_sound["civilian"]["embassy_hosfem_rescued07"]	= "embassy_hosfem_rescued07";


	//MALE
	level.embassy_hosmale_rescuedMAX = 7;
	//hosmale
	//"don't leave - please!"
	level.scr_sound["civilian"]["embassy_hosmale_rescued01"]		= "embassy_hosmale_rescued07";
	
	//hosmale
	//"what?s going on get me out of here!"
	level.scr_sound["civilian"]["embassy_hosmale_rescued02"]		= "embassy_hosmale_rescued06";

	//hosmale
	//"thank god you?re here!"
	level.scr_sound["civilian"]["embassy_hosmale_rescued03"]		= "embassy_hosmale_rescued05";
	
	//hosmale
	//"get me out of here!"
	level.scr_sound["civilian"]["embassy_hosmale_rescued04"]		= "embassy_hosmale_rescued04";

	//HOSMALE
	//"<Incoherent crying >"
	level.scr_sound["civilian"]["embassy_hosmale_rescued05"]	= "embassy_hosmale_rescued03";
	 
	//HOSMALE
	//"Oh God?is it over? <crying>"
	level.scr_sound["civilian"]["embassy_hosmale_rescued06"]	= "embassy_hosmale_rescued02";
	
	//HOSMALE
	//"Please, I just want to get out of here <crying>"
	level.scr_sound["civilian"]["embassy_hosmale_rescued07"]	= "embassy_hosmale_rescued01";
	

	//----------------HOSTAGES - BREACHED-------------------//
	
	//FEMALE

	level.embassy_hosfem_breachedMAX = 12;
	
	//HOSFEM
	//"Get me out of this place! Nooooo! <very vocal screams>"
	level.scr_sound["civilian"]["embassy_hosfem_breached01"]	= "embassy_hosfem_breached08";
	
	//hosfem
	//"noooo! please nooo!!!"
	level.scr_sound["civilian"]["embassy_hosfem_breached02"]		= "embassy_hosfem_breached01";
	
	//hosfem
	//"don?t kill me please don?t kill me no no please!!!"
	level.scr_sound["civilian"]["embassy_hosfem_breached03"]		= "embassy_hosfem_breached02";
	
	//hosfem
	//"noooo!!! nooo!!! please don?t!!!!"
	level.scr_sound["civilian"]["embassy_hosfem_breached04"]		= "embassy_hosfem_breached03";

	//HOSFEM
	//"<very vocal screaming>"
	level.scr_sound["civilian"]["embassy_hosfem_breached05"]	= "embassy_hosfem_breached07";
	
	//hosfem
	//"-sobbing and wailing-"
	level.scr_sound["civilian"]["embassy_hosfem_breached06"]		= "embassy_hosfem_breached04";
	
	//hosfem
	//"-sobbing and wailing-"
	level.scr_sound["civilian"]["embassy_hosfem_breached07"]		= "embassy_hosfem_breached05";
	
	//hosfem
	//"-sobbing and wailing-"
	level.scr_sound["civilian"]["embassy_hosfem_breached08"]		= "embassy_hosfem_breached06";

	//HOSFEM
	//"Get me out of this place! Nooooo! <very vocal screams>"
	level.scr_sound["civilian"]["embassy_hosfem_breached09"]	= "embassy_hosfem_breached08";
	
	//HOSFEM
	//"No! Help me! I?m not one of them! "
	level.scr_sound["civilian"]["embassy_hosfem_breached10"]	= "embassy_hosfem_breached09";
	
	//HOSFEM
	//"<very vocal screams> Don?t shoot! Don?t shoot!"
	level.scr_sound["civilian"]["embassy_hosfem_breached11"]	= "embassy_hosfem_breached10";
	
	//HOSFEM
	//"<very vocal screaming>"
	level.scr_sound["civilian"]["embassy_hosfem_breached12"]	= "embassy_hosfem_breached07";	
	
	
	
	
	// MALE
	level.embassy_hosmale_breachedMAX = 12;
	//hosmale
	//"noooo! please nooo!!!"
	level.scr_sound["civilian"]["embassy_hosmale_breached01"]		= "embassy_hosmale_breached10";
	
	//hosmale
	//"don?t kill me please don?t kill me no no please!!!"
	level.scr_sound["civilian"]["embassy_hosmale_breached02"]		= "embassy_hosmale_breached09";
	
	//hosmale
	//"noooo!!! nooo!!! please don?t!!!!"
	level.scr_sound["civilian"]["embassy_hosmale_breached03"]		= "embassy_hosmale_breached08";
	
	//HOSMALE
	//"<very vocal screaming>"
	level.scr_sound["civilian"]["embassy_hosmale_breached04"]	= "embassy_hosmale_breached04";
		
	//hosmale
	//"-sobbing and wailing-"
	level.scr_sound["civilian"]["embassy_hosmale_breached05"]		= "embassy_hosmale_breached07";

	//HOSMALE
	//"Get me out of this place! Nooooo! <very vocal screams>"
	level.scr_sound["civilian"]["embassy_hosmale_breached06"]	= "embassy_hosmale_breached03";
		
	//hosmale
	//"-sobbing and wailing-"
	level.scr_sound["civilian"]["embassy_hosmale_breached07"]		= "embassy_hosmale_breached06";

	//hosmale
	//"-sobbing and wailing-"
	level.scr_sound["civilian"]["embassy_hosmale_breached08"]		= "embassy_hosmale_breached05";

	//HOSMALE
	//"<very vocal screaming>"
	level.scr_sound["civilian"]["embassy_hosmale_breached09"]	= "embassy_hosmale_breached04";
	
	//HOSMALE
	//"Get me out of this place! Nooooo! <very vocal screams>"
	level.scr_sound["civilian"]["embassy_hosmale_breached10"]	= "embassy_hosmale_breached03";
	
	//HOSMALE
	//"No! Help me! I?m not one of them! "
	level.scr_sound["civilian"]["embassy_hosmale_breached11"]	= "embassy_hosmale_breached02";
	
	//HOSMALE
	//"<very vocal screams> Don?t shoot! Don?t shoot!"
	level.scr_sound["civilian"]["embassy_hosmale_breached12"]	= "embassy_hosmale_breached01";


	//---------------- TERRORISTS - MUFFLED THREATS-------------------//
	level.embassy_ter_hosthreatmuffleMAX = 6;
	//terrorist
	//"-shut up!!! shut your mouth!!!"
	level.scr_sound["embassy_ter_hosthreatmuffle01"]		= "embassy_ter_hosthreatmuffle01";
	
	//terrorist
	//"-be quiet!!!!"
	level.scr_sound["embassy_ter_hosthreatmuffle02"]		= "embassy_ter_hosthreatmuffle02";
	
	//terrorist
	//"-silence!!!!"
	level.scr_sound["embassy_ter_hosthreatmuffle03"]		= "embassy_ter_hosthreatmuffle03";
	
	//terrorist
	//"-no talking!!!! be silent!!!"
	level.scr_sound["embassy_ter_hosthreatmuffle04"]		= "embassy_ter_hosthreatmuffle04";
	
	//terrorist
	//"-they?re moving in!!!"
	level.scr_sound["embassy_ter_hosthreatmuffle05"]		= "embassy_ter_hosthreatmuffle05";
	
	//terrorist
	//"-move! move!"
	level.scr_sound["embassy_ter_hosthreatmuffle06"]		= "embassy_ter_hosthreatmuffle06";
	
	//---------------- TERRORISTS - EXECUTE -------------------//
	level.embassy_ter_executeMAX = 2;
	//terrorist
	//"-execute him now!"
	level.scr_sound["terrorist"]["embassy_ter_execute01"]		= "embassy_ter_execute01";
	
	//terrorist
	//"-kill the hostage!"
	level.scr_sound["terrorist"]["embassy_ter_execute02"]		= "embassy_ter_execute01";


	//----------------OLD GENERIC FRIENDLY-------------------//
	//guy
	//"Clear!"
	level.scr_sound["guy"]["embassy_frnd_allclearmoveon3"]		= "embassy_frnd_allclearmoveon3";

	//Gaz
	//Stack up against the wall, Andy. Get those flashbangs ready
	level.scr_sound["gaz"]["embassy_gaz_breachstack1"]		= "embassy_gaz_breachstack1";
	
	//Gaz
	//Andy, get close to the wall, then give the order.
	level.scr_sound["gaz"]["embassy_gaz_breachstack2"]		= "embassy_gaz_breachstack2";
	
	//Gaz
	//Get close against the wall and get ready to throw in those flashbangs.
	level.scr_sound["gaz"]["embassy_gaz_breachstack3"]		= "embassy_gaz_breachstack3";
	
	//Gaz
	//Stack up against the wall, Andy.
	level.scr_sound["gaz"]["embassy_gaz_breachstack4"]		= "embassy_gaz_breachstack4";	
	
	//gaz
	//"Ok, listen up. Andy, you give the signal when you are ready and Jack will breach the door."
	level.scr_sound["gaz"]["embassy_gaz_breachinstruct1"]		= "embassy_gaz_breachinstruct1";
	//level.gaz thread dialogue_thread("embassy_gaz_breachinstruct1");	
	
	//gaz
	//"Right, Andy, you'll give the signal and Jack will perform the breach."
	level.scr_sound["gaz"]["embassy_gaz_breachinstruct2"]		= "embassy_gaz_breachinstruct2";
	//level.gaz thread dialogue_thread("embassy_gaz_breachinstruct2");	
	
	//gaz
	//"As soon as the door is open, get a flashbang in there and begin the assault."
	level.scr_sound["gaz"]["embassy_gaz_breachinstruct3"]		= "embassy_gaz_breachinstruct3";
	//level.gaz thread dialogue_thread("embassy_gaz_breachinstruct3");	
	
	//jack
	//"Waiting for your signal, Andy."
	level.scr_sound["jack"]["embassy_jack_breachwaitingforsignal1"]		= "embassy_jack_breachwaitingforsignal1";
	//level.jack thread dialogue_thread("embassy_jack_breachwaitingforsignal1");	
	
	//jack
	//"Let's go, Andy. Waiting on your signal."
	level.scr_sound["jack"]["embassy_jack_breachwaitingforsignal2"]		= "embassy_jack_breachwaitingforsignal2";
	//level.jack thread dialogue_thread("embassy_jack_breachwaitingforsignal2");	
	
	//jack
	//"Give the go ahead, Andy. Waiting on you."
	level.scr_sound["jack"]["embassy_jack_breachwaitingforsignal3"]		= "embassy_jack_breachwaitingforsignal3";
	//level.jack thread dialogue_thread("embassy_jack_breachwaitingforsignal3");	
	
	//gaz
	//"Clear! Let's move on!"
	level.scr_sound["gaz"]["embassy_gaz_allclearmoveon1"]		= "embassy_gaz_allclearmoveon1";
	//level.gaz thread dialogue_thread("embassy_gaz_allclearmoveon1");	
	
	//gaz
	//"This room is clear!"
	level.scr_sound["gaz"]["embassy_gaz_allclearmoveon2"]		= "embassy_gaz_allclearmoveon2";
	//level.gaz thread dialogue_thread("embassy_gaz_allclearmoveon2");	
		
	//gaz
	//"Clear!"
	level.scr_sound["gaz"]["embassy_gaz_allclearmoveon3"]		= "embassy_gaz_allclearmoveon3";
	//level.gaz thread dialogue_thread("embassy_gaz_allclearmoveon3");	
	
	//gaz
	//"Andy, over here let's go! Move! Move! Move!"
	level.scr_sound["gaz"]["embassy_gaz_getoverhere1"]		= "embassy_gaz_getoverhere1";
	//level.gaz thread dialogue_thread("embassy_gaz_getoverhere1");	
	
	//gaz
	//"Andy, over here!"
	level.scr_sound["gaz"]["embassy_gaz_getoverhere2"]		= "embassy_gaz_getoverhere2";
	//level.gaz thread dialogue_thread("embassy_gaz_getoverhere2");	
	
	//gaz
	//"Get over here, Andy! Let's go! Let's Go!"
	level.scr_sound["gaz"]["embassy_gaz_getoverhere3"]		= "embassy_gaz_getoverhere3";
	//level.gaz thread dialogue_thread("embassy_gaz_getoverhere3");	
	
	//gaz
	//"Andy! Let's get a move on! Over here!"
	level.scr_sound["gaz"]["embassy_gaz_getoverhere4"]		= "embassy_gaz_getoverhere4";
	//level.gaz thread dialogue_thread("embassy_gaz_getoverhere4");	
	
	//gaz
	//"Andy! This way!"
	level.scr_sound["gaz"]["embassy_gaz_getoverhere5"]		= "embassy_gaz_getoverhere5";
	//level.gaz thread dialogue_thread("embassy_gaz_getoverhere5");	
	
	//gaz
	//"Andy! This way! We've gotta keep moving!"
	level.scr_sound["gaz"]["embassy_gaz_getoverhere6"]		= "embassy_gaz_getoverhere6";
	//level.gaz thread dialogue_thread("embassy_gaz_getoverhere6");	
	
	//gaz
	//"Get over here, Andy. We?re not done yet."
	level.scr_sound["gaz"]["embassy_gaz_getoverhere7"]		= "embassy_gaz_getoverhere7";
	//level.gaz thread dialogue_thread("embassy_gaz_getoverhere7");	
	
	//gaz
	//"Go! Go! Go!"
	level.scr_sound["gaz"]["embassy_gaz_gogogo"]		= "embassy_gaz_gogogo";
	//level.gaz thread dialogue_thread("embassy_gaz_gogogo");	
	
	//gaz
	//"Andy! Get a flashbang in there!"
	level.scr_sound["gaz"]["embassy_gaz_throwflashbang1"]		= "embassy_gaz_throwflashbang1";
	//level.gaz thread dialogue_thread("embassy_gaz_throwflashbang1");	
	
	//gaz
	//"Andy! Use your flashbangs!"
	level.scr_sound["gaz"]["embassy_gaz_throwflashbang2"]		= "embassy_gaz_throwflashbang2";
	//level.gaz thread dialogue_thread("embassy_gaz_throwflashbang2");	
	
	//gaz
	//"Flashbangs! Now!"
	level.scr_sound["gaz"]["embassy_gaz_throwflashbang3"]		= "embassy_gaz_throwflashbang3";
	//level.gaz thread dialogue_thread("embassy_gaz_throwflashbang3");	
	
	//gaz
	//"Use the flashbangs! Hurry!"
	level.scr_sound["gaz"]["embassy_gaz_throwflashbang4"]		= "embassy_gaz_throwflashbang4";
	//level.gaz thread dialogue_thread("embassy_gaz_throwflashbang4");	
}


shootGun(guy)
{
	guy shoot();
}


//#using_animtree("embassy");
//animations_heli()
//{
//	//player chopper
//	level.scr_anim["blackhawk"]["heli_intro_start_loop"][0]	= 	(%bh_embassy_entry_loop);
//	level.scr_anim["blackhawk"]["heli_intro_start"]	= 	(%bh_embassy_entry);
//	level.scr_anim["blackhawk"]["heli_intro_idle"][0]	= 	(%bh_embassy_idle);
//	level.scr_anim["blackhawk"]["heli_intro_end"]	= 	(%bh_embassy_exit);
//}



dialogue_cycle()
{
	level.dialogueArray = [];
	level thread dialoguecycle("embassy_frnd_flashbangnow", level.embassy_frnd_flashbangnowMAX, "frnd");
	level thread dialoguecycle("embassy_cmd_hostagesecured", level.embassy_cmd_hostagesecuredMAX, "cmd");
	level thread dialoguecycle("embassy_cmd_mandown", level.embassy_cmd_mandownMAX, "cmd");
	level thread dialoguecycle("embassy_cmd_timer_naga_", level.embassy_cmd_timer_naga_MAX, "cmd");
	level thread dialoguecycle("embassy_cmd_timer_nagb_", level.embassy_cmd_timer_nagb_MAX, "cmd");
	level thread dialoguecycle("embassy_cmd_timer_nagc_", level.embassy_cmd_timer_nagc_MAX, "cmd");
	level thread dialoguecycle("embassy_cmd_timer_nagd_", level.embassy_cmd_timer_nagd_MAX, "cmd");
	level thread dialoguecycle("embassy_frnd_hostage_secured", level.embassy_frnd_hostage_securedMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_clear_generic", level.embassy_frnd_clear_genericMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_clear_room", level.embassy_frnd_clear_roomMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_hostiledown", level.embassy_frnd_hostiledownMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_needbreach", level.embassy_frnd_needbreachMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_breachinstruct", level.embassy_frnd_breachinstructMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_breachflashinstruct", level.embassy_frnd_breachflashinstructMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_throwingflash", level.embassy_frnd_throwingflashMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_standby", level.embassy_frnd_standbyMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_flashbangnow", level.embassy_frnd_flashbangnowMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_movegomove", level.embassy_frnd_movegomoveMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_mandown", level.embassy_frnd_mandownMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_getdown", level.embassy_frnd_getdownMAX, "frnd");
	level thread dialoguecycle("embassy_hosfem_rescued", level.embassy_hosfem_rescuedMAX, "civilian");
	level thread dialoguecycle("embassy_hosmale_rescued", level.embassy_hosmale_rescuedMAX, "civilian");
	level thread dialoguecycle("embassy_hosfem_breached", level.embassy_hosfem_breachedMAX, "civilian");
	level thread dialoguecycle("embassy_hosmale_breached", level.embassy_hosmale_breachedMAX, "civilian");
	level thread dialoguecycle("embassy_ter_hosthreatmuffle", level.embassy_ter_hosthreatmuffleMAX);
	level thread dialoguecycle("embassy_ter_execute", level.embassy_ter_executeMAX, "terrorist");
	level thread dialoguecycle("embassy_frnd_shotgunready", level.embassy_frnd_shotgunreadyMAX, "frnd");
	level thread dialoguecycle("embassy_frnd_shotgunbreach", level.embassy_frnd_shotgunbreachMAX, "frnd");
	level thread dialoguecycle("embassy_leader_stayclose", level.embassy_leader_staycloseMAX, "price");
	level thread dialoguecycle("embassy_leader_nextroom", level.embassy_leader_nextroomMAX, "price");
	level thread dialoguecycle("embassy_leader_roomnag", level.embassy_leader_roomnagMAX, "price");
}

dialoguecycle(sLine, iMaxEntries, sSpeaker)
{
	sNotify = "dialogue_" + sLine + "_used";
	
	while (true)
	{
		iCounter = iMaxEntries;
		wait(0.05);
		for(i=0;i<iCounter;i++)
		{
			iDialogueNumber = (i + 1);
			if (iDialogueNumber > 9)
				iDialogueNumber = iDialogueNumber;
			else
				iDialogueNumber = "0" + iDialogueNumber;
			
			sLineToExecute = sLine + iDialogueNumber;
			if (isdefined(sSpeaker))
				assertEx((isdefined(level.scr_sound[sSpeaker][sLineToExecute])), "level.scr_sound " + sLineToExecute + "does not exist for speaker " + sSpeaker);
			else
				assertEx((isdefined(level.scr_sound[sLineToExecute])), "level.scr_sound " + sLineToExecute + "does not exist");
			level.dialogueArray[sLine] = sLineToExecute;
			level waittill (sNotify);
		}
	}
}


animations_hostages()
{
	//CHAIR IDLE: Tied to a chair
	level.scr_anim["civilian"]["hostage_chair_idle"][0]	= (%hostage_chair_idle);
	level.scr_anim["civilian"]["hostage_chair_twitch"]	= (%hostage_chair_twitch);
	level.scr_anim["civilian"]["hostage_chair_twitch2"]	= (%hostage_chair_twitch2);

	//CHAIR SCRIPTED: scripted chair dive
	level.scr_anim["civilian"]["hostage_chair_dive"]	= (%hostage_chair_dive);
	
	//CHAIR FLOOR IDLE
	level.scr_anim["civilian"]["hostage_chair_ground_idle"][0]	= (%hostage_chair_ground_idle);		

	//STAND IDLE: Standing
	level.scr_anim["civilian"]["hostage_stand_idle"][0]	= (%hostage_stand_idle );
	level.scr_anim["civilian"]["hostage_stand_idle"][1]	= (%hostage_stand_idle_2);
	level.scr_anim["civilian"]["hostage_stand_twitch"]	= (%hostage_stand_twitch);
	level.scr_anim["civilian"]["hostage_stand_twitch2"]	= (%hostage_stand_twitch);

	//STAND SCRIPTED - stand to knees
	level.scr_anim["civilian"]["hostage_stand_fall"]	= (%hostage_stand_fall);	
		
	//STAND SCRIPTED - NOT SURE - maybe used for hostage being dragged from behing or from front?
	level.scr_anim["civilian"]["hostage_stand_react_front"]	= (%hostage_stand_react_front);
	level.scr_anim["civilian"]["hostage_stand_react_behind"]	= (%hostage_stand_react_behind);	
	
	//KNEES IDLE: On knees
	level.scr_anim["civilian"]["hostage_knees_idle"][0]	= (%hostage_knees_idle);
	level.scr_anim["civilian"]["hostage_knees_twitch"]	= (%hostage_knees_twitch);
	level.scr_anim["civilian"]["hostage_knees_twitch2"]	= (%hostage_knees_twitch);

	//KNEES SCRIPTED - knees to prone
	level.scr_anim["civilian"]["hostage_knees_fall"]	= (%hostage_knees_fall);
		
	//PRONE IDLE: Prone face down
	level.scr_anim["civilian"]["hostage_facedown_idle"][0]	= (%hostage_facedown_idle);
	level.scr_anim["civilian"]["hostage_facedown_twitch"]	= (%hostage_facedown_twitch);
	level.scr_anim["civilian"]["hostage_facedown_twitch2"]	= (%hostage_facedown_twitch);

	//PRONE IDLE: Prone to fetal
	level.scr_anim["civilian"]["hostage_facedown_roll"]	= (%hostage_facedown_roll);
	
	//FETAL IDLE 1: fetal position 1
	level.scr_anim["civilian"]["hostage_fetal_idle"][0]	= (%hostage_fetal_idle);
	
	//FETAL SCRIPTED: fetal position 1 to 2
	level.scr_anim["civilian"]["hostage_fetal_roll"]	= (%hostage_fetal_roll);
	
	//FETAL IDLE 2: fetal position 2
	level.scr_anim["civilian"]["hostage_fetal2_idle"][0]	= (%hostage_fetal2_idle);
	
	//?????
	//level.scr_anim["civilian"]["hostage_fetal_roll2"]	= (%hostage_fetal_roll);
}