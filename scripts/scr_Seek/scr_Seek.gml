
//Returns an array for the velocity vector
function sb_Seek(_targX,_targY, _weight) : SteeringBehavior(_weight) constructor {
	
	targX = _targX;
	targY = _targY;
	
	getVelocity = function() {
		var dist = point_distance(x,y,targX,targY);
		
		var velVec = array_create(2);
		velVec[0] = ((targX-x/dist) * maxSpeed) * Hsp;
		velVec[1] = ((targY-y/dist) * maxSpeed) * Vsp;
		
		return velVec;
	}
	
}

