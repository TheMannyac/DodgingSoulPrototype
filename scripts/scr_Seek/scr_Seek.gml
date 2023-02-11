// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_Seek(targetLocX, targetLocY, steerForce){
	var pd = point_direction(x, y, targetLocX, targetLocY)
	var ad = angle_difference(image_angle, pd);
	image_angle -= min(abs(ad), steerForce) * sign(ad);
	
	
}