/// @description Update Path


if (mouse_check_button_pressed(mb_middle)) {
	
	target_x = mouse_x;
	target_y = mouse_y;

	if (path_exists(myPath)) {
		path_delete(path);
		path = undefined;
	}

	myPath = path_add();

	if (global.weightGrid == noone) {
		return;
	}

	if (wg_find_path(global.weightGrid,myPath,x,y,target_x,target_y)) {
		path_start(myPath,5,path_action_stop,true);
	}	
}


