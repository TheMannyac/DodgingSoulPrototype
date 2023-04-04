/// @description Insert description here
// You can write your code in this editor

mp_grid_clear_all(grid);
mp_grid_add_instances(grid,obj_projectile,true);

alarm_set(0,updateRate);