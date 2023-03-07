/// @description draw_line_fast
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg [width]
/// @arg [color]
/// @arg [alpha]
function draw_line_fast() {


	var _pixel=spr_pixel,
	    _x1=argument[0]+1,
	    _y1=argument[1]+1,
	    _x2=argument[2]+1,
	    _y2=argument[3]+1,
	    _width=1,
	    _color=draw_get_color(),
	    _alpha=draw_get_alpha(),
	    _dir = point_direction(_x1, _y1, _x2, _y2),
	    _len = point_distance(_x1, _y1, _x2, _y2);

	//Optional Args
	if(argument_count > 4)
	  _width=argument[4];
	if(argument_count > 5)
	  _color=argument[5];
	if(argument_count > 6)
	  _alpha=argument[6];

	draw_sprite_ext(_pixel, 0, 
	                _x1+lengthdir_x(_width/2,_dir+90), 
	                _y1+lengthdir_y(_width/2,_dir+90), 
	                _len, _width, _dir, _color, _alpha);

}
