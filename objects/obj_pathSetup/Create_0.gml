/// @description 

gridsize = 16;
updateRate = 1;
grid = mp_grid_create(0,0,room_width/gridsize,room_height/gridsize,gridsize,gridsize);


alarm_set(0,updateRate);
