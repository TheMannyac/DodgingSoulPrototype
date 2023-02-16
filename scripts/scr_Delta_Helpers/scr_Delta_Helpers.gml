// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Get_Capped_Delta(){
	
	//This ensures that the delta cannot be too large; which prevents errors such as the one regarding the delta and the debugger
	var realDeltaTime = delta_time / 1000000 ;
	var fallBackDeltaTime = game_get_speed(gamespeed_microseconds) /1000000;
	return (realDeltaTime < fallBackDeltaTime) ? realDeltaTime : fallBackDeltaTime;
}

function Get_Delta_Modifier() {
	var deltaInSeconds = global.delta_capped ;
	var targetDelta = 1/game_get_speed(gamespeed_fps);
	
	return deltaInSeconds/targetDelta;
}





