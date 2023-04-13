/// @description draw_line_fast
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg [width]
/// @arg [color]
/// @arg [alpha]
function draw_line_fast(_x1,_y1,_x2,_y2,_width=1,_color=draw_get_color(),_alpha=draw_get_alpha()) {

	
	var _pixel=spr_pixel,
	    _dir = point_direction(_x1, _y1, _x2, _y2),
	    _len = point_distance(_x1, _y1, _x2, _y2);


	draw_sprite_ext(_pixel, 0, 
	                _x1+lengthdir_x(_width/2,_dir+90), 
	                _y1+lengthdir_y(_width/2,_dir+90), 
	                _len, _width, _dir, _color, _alpha);

}
