/// @description 

/* GLOBAL DELTA_TIME SETUP
	This global system allows for any step-based timing code 
	to dynamically adapt to any shift in framerate. 
	This allows for a smooth movement while also removing the need to make such calculations locally
	for every object. In other words
	
	//POTENTIAL ISSUES
	This system will not work if, for some reason, the delta_multiplier value stops being updated every frame.
	Also, synchronization issues can arise if an object is reading 
	the delta_multiplier value is being read before it can be updated, so make sure things are happening in the right order 
*/

global.delta_capped =	Get_Capped_Delta();
global.delta_multiplier = Get_Delta_Modifier();

marker = noone;