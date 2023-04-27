/// @description Update Path


if (mouse_check_button_pressed(mb_middle)) {
	
	//if no weight grid exists then return 
	if (global.weightGrid == noone) 
		return;
	
	target_x = mouse_x;
	target_y = mouse_y;

	//Delete any old path instances
	if (path_exists(myPath)) {
		path_delete(myPath);
		myPath = undefined;
	}

	//Create new path instance
	myPath = path_add();
	path_set_closed(myPath,false)

	//create marker object instance
	if (instance_exists(marker)) 
		instance_destroy(marker);
	marker = instance_create_layer(mouse_x,mouse_y,"Markers",obj_navMarker);
	
	//garbage collect the old pathfinding results struct
	if(is_struct(pathResults)) {
		delete pathResults;
		pathResults = undefined;
	}
	
	//Attempt to Pathfind
	pathResults = wg_find_path(global.weightGrid,myPath,x,y,target_x,target_y,0,true);
	
	if (pathResults.success == true) {
		path_print_all_points(myPath);
		path_start(myPath,5,path_action_stop,true);
	} else {
		
	}
	
	//pathResults.printLogs();
}


