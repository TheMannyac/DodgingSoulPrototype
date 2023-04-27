// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function path_print_all_points(pathID){
	for (var i = 0; i < path_get_number(pathID); i++) {
	    var xx = path_get_point_x(pathID, i);
	    var yy = path_get_point_y(pathID, i);
	    show_debug_message("Point " + string(i) + ": x = " + string(xx) + ", y = " + string(yy));
	}
}