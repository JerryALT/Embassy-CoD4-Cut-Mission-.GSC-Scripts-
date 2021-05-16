main()
{
	precacheFX();
	exploderFX();
	spawnWorldFX();
	treadFX();
	
}

precacheFX()
{
	level._effect["exp_pack_doorbreach"]			= loadfx("explosions/exp_pack_doorbreach");  																																																																																																																																	
	level._effect["exp_pack_hallway"]	 	= loadfx("explosions/exp_pack_hallway");  																																																																																																												
}

exploderFX()
{
	//wall breach
	maps\_fx::exploderfx(1,"exp_pack_doorbreach",(2120,-2445,200), undefined, (2120,-2445,300), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
	maps\_fx::exploderfx(10,"exp_pack_doorbreach",(2107,-2069,199), undefined, (2107,-2069,299), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
	maps\_fx::exploderfx(16,"exp_pack_doorbreach",(1974,1018,198), undefined, (1988,1116,211), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
	maps\_fx::exploderfx(20,"exp_pack_doorbreach",(2124,-1536,209), undefined, (2124,-1536,309), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
	maps\_fx::exploderfx(3,"exp_pack_doorbreach",(-131,1077,12), undefined, (-131,1077,112), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
	maps\_fx::exploderfx(2,"exp_pack_doorbreach",(-1081,1069,28), undefined, (-1081,1069,128), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
	maps\_fx::exploderfx(6,"exp_pack_doorbreach",(1554,-613,454), undefined, (1554,-613,554), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
	maps\_fx::exploderfx(15,"exp_pack_doorbreach",(-333,251,342), undefined, (-333,251,442), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
	maps\_fx::exploderfx(7,"exp_pack_doorbreach",(-638,-802,364), undefined, (-638,-802,464), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
	maps\_fx::exploderfx(30,"exp_pack_doorbreach",(-384,-544,112), undefined, (-384,-544,112), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);

}

spawnWorldFX()
{

}

treadFX()
{

}

