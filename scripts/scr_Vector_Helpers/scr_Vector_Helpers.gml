
//Returns x coordinate of predicted linear position after certain number of seconds
function predict_pos_x(startX,Hspd,seconds) {
	lerp(startX, startX + Hspd, game_get_speed(gamespeed_fps)*seconds);
}

//Returns x coordinate of predicted linear position after certain number of seconds
function predict_pos_y(startY,Vspd,seconds) {
	lerp(startY, startY + Vspd, game_get_speed(gamespeed_fps)*seconds);
}


