/// @description 

cellSize = 16;
updateRate = 1;

//Create Grid 
global.weightGrid = new WeightGrid(0,0,room_width,room_height,cellSize)

//weightGrid = mp_grid_create(0,0,room_width/gridsize,room_height/gridsize,gridsize,gridsize);


alarm_set(0,updateRate);