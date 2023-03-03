

function sb_Arrive(_targetPointX,_targetPointY, _weight,_slowRad=150,_stopRad=100)
: SteeringBehavior(_targetPointX,_targetPointY,_weight) constructor {
	
	//The threashold where the agent begins to slow
	slowRadius = _slowRad;
	//The threashold where the agent stops
	stopRadius = _stopRad;
	
	getVelocity = function() {
		var xx = agentID.x;
		var yy = agentID.y;
		var dist = point_distance(xx,yy,targetPointX,targetPointY);
		
		var desiredVel = vector2_normalize_2arg(targetPointX-xx,targetPointY-yy);

		if (dist < stopRadius) {
			//come to complete stop.
			desiredVel[0] = 0;
			desiredVel[1] = 0;
		} else if (dist < slowRadius) {
			//begin slowing down
			desiredVel[0] = desiredVel[0] * agentID.maxSpeed * ((dist - stopRadius) / (slowRadius - stopRadius));
			desiredVel[1] = desiredVel[1] * agentID.maxSpeed * ((dist - stopRadius) / (slowRadius - stopRadius));
		} else {
			//normal speed
			desiredVel[0] = desiredVel[0] * agentID.maxSpeed;
			desiredVel[1] = desiredVel[1] * agentID.maxSpeed;
		}
		
		
		desiredVel[0] = desiredVel[0] - agentID.Hsp;
		desiredVel[1] = desiredVel[1] - agentID.Vsp;
		
		return desiredVel;
	}
	
	function hasArrived() {
		var xx = agentID.x;
		var yy = agentID.y;
		var dist = point_distance(xx,yy,targetPointX,targetPointY);
		
		if (dist < stopRadius) return true;
		else return false;
	}
	
}