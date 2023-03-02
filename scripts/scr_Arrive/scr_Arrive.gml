

function sb_Arrive(_targX,_targY, _weight,_slowRad=1,_stopRad=.4) : SteeringBehavior(_weight) constructor {
	
	targX = _targX;
	targY = _targY;
	
	//The threashold where the agent begins to slow
	slowRadius = _slowRad;
	//The threashold where the agent stops
	stopRadius = _stopRad;
	
	getVelocity = function() {

		var dist = point_distance(x,y,targX,targY);
		
		var desiredVel = array_create(2);
		desiredVel[0] = (targX-x/dist);
		desiredVel[1] = (targY-y/dist);
		
		if (dist < stopRadius) {
			desiredVel[0] = 0;
			desiredVel[1] = 0;
		} else if (dist < slowRadius) {
			desiredVel[0] = desiredVel[0] * maxSpeed * ((dist - stopRadius) / (slowRadius - stopRadius));
			desiredVel[1] = desiredVel[1] * maxSpeed * ((dist - stopRadius) / (slowRadius - stopRadius));
		} else {
			desiredVel[0] = desiredVel[0] * maxSpeed;
			desiredVel[1] = desiredVel[1] * maxSpeed;
		}
		
		desiredVel[0] = desiredVel[0] - Hsp;
		desiredVel[1] = desiredVel[1] - Vsp;
		
		return desiredVel;
		
	}
	
}