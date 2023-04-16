/// @description Update Path


if (mouse_check_button_pressed(mb_middle)) {
	
	if (global.weightGrid == noone) 
		return;
	
	target_x = mouse_x;
	target_y = mouse_y;

	if (path_exists(myPath)) {
		path_delete(myPath);
		myPath = undefined;
	}

	myPath = path_add();

	if (instance_exists(marker)) 
		instance_destroy(marker);

	marker = instance_create_layer(mouse_x,mouse_y,"Markers",obj_navMarker);
	
	//garbage collect the old 
	if(is_struct(pathResults)) {
		delete pathResults;
		pathResults = undefined;
	}
	
	//Attempt to Pathfind
	pathResults = wg_find_path(global.weightGrid,myPath,x,y,target_x,target_y,true);
	
	if (pathResults.success == true) {
		path_start(myPath,5,path_action_stop,true);
	}	
}


