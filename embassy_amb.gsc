#include maps\_ambient;

main()
{
	// Set the underlying ambient track
	level.ambient_track ["exterior"] = "ambient_embassy_ext";
	thread maps\_utility::set_ambient("exterior");	
	ambientDelay("exterior", 6.0, 10.0); // Trackname, min and max delay between ambient events
	ambientEvent("exterior", "elm_windgust1",	1.0);
	ambientEvent("exterior", "elm_windgust2",	1.0);
	ambientEvent("exterior", "elm_windgust3",	1.0);
	ambientEvent("exterior", "elm_windgust4",	1.0);
	ambientEvent("exterior", "elm_helicopter_flyover_med",	1.0);
	ambientEvent("exterior", "elm_jet_flyover_med",	1.0);
	ambientEvent("exterior", "elm_jet_flyover_dist",	1.0);
	ambientEvent("exterior", "elm_explosions_dist",	3.0);
	ambientEvent("exterior", "elm_explosions_med",	3.0);
	ambientEvent("exterior", "elm_artillery_med",	3.0);

	ambientEvent("exterior", "null",			0.3);
	
	ambientEventStart("exterior");

	level waittill ("action moment");

	ambientEventStart("action ambient");
}	


	
	