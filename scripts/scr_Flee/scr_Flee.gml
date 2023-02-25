

//Returns an array for the velocity vector
function sb_Flee(_fleeX,_fleeY, _weight,_fleeRad) : SteeringBehavior(_weight) constructor {
	
	fleeX = _fleeX;
	fleeY = _fleeY;
	
	//the minimum distance from point
	fleeRadius = _fleeRad;
	
	getVelocity = function() {
		var dist = point_distance(x,y,targX,targY);
		
		if (dist < fleeRadius) {
			
			var velVec = array_create(2);
			velVec[0] = -1*((targX-x/dist) * maxSpeed) * Hsp;
			velVec[1] = -1*((targY-y/dist) * maxSpeed) * Vsp;
			return velVec;
		} else {
			return [0,0];
		}
		
	}
	
}
