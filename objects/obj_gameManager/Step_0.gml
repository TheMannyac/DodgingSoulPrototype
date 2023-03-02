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

if (mouse_check_button_pressed(mb_left)) {
	if (instance_exists(marker)) 
		instance_destroy(marker);

	marker = instance_create_layer(mouse_x,mouse_y,"Markers",obj_navMarker);

	show_debug_message("Marker Spawned");
}