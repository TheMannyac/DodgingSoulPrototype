
//Returns x coordinate of predicted linear position after certain number of seconds
function predict_pos_x(startX,Hspd,seconds) {
	lerp(startX, startX + Hspd, game_get_speed(gamespeed_fps)*seconds);
}

//Returns x coordinate of predicted linear position after certain number of seconds
function predict_pos_y(startY,Vspd,seconds) {
	lerp(startY, startY + Vspd, game_get_speed(gamespeed_fps)*seconds);
}

//takes array of x and y value and returns normalized version
function vector2_normalize(vecArr) {
	var xx = vecArr[0];
	var yy = vecArr[1];
	
	return vector2_normalize_2arg(xx,yy);
}

//same as before but takes two arguments; still returns array vector
function vector2_normalize_2arg(xx,yy) {
	var normVec = array_create(2);
	
	
	var len = vector2_get_length_2arg(xx,yy);
	normVec[0] = xx/len;
	normVec[1] = yy/len;
	
	return normVec
}

function vector2_get_length_2arg(xx,yy) {
	return sqrt(xx*xx + yy*yy);
}

function vector2_to_degrees_2arg(xx,yy) {
	return radtodeg( arctan2(yy,yy));
}

