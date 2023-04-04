/// @description Spawn Timer


if(instance_exists(obj_soul)) {
	var targ = instance_nearest(x,y,obj_soul);
	var targDir = point_direction(x,y,targ.x,targ.y);
	var xx = lengthdir_x(spawnOffset, targDir);
	var yy = lengthdir_y(spawnOffset, targDir);
	
	var proj = instance_create_layer(x+xx,y+yy,"Instances",objectType);
	
	with (proj) {
		direction = targDir;	
	}
	
}




alarm_set(0,SpawnInterval);