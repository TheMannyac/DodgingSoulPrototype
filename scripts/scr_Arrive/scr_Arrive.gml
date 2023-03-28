

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

		switch (getArrivalStatus()) {
			case eArrivalStatus.ARRIVED:
				desiredVel[0] = 0;
				desiredVel[1] = 0;
				break;
			case eArrivalStatus.SLOWING:
				desiredVel[0] = desiredVel[0] * agentID.maxSpeed * ((dist - stopRadius) / (slowRadius - stopRadius));
				desiredVel[1] = desiredVel[1] * agentID.maxSpeed * ((dist - stopRadius) / (slowRadius - stopRadius));
				break;
			case eArrivalStatus.TRAVELING:
				//normal speed
				desiredVel[0] = desiredVel[0] * agentID.maxSpeed;
				desiredVel[1] = desiredVel[1] * agentID.maxSpeed;
				break;
		}

		desiredVel[0] = desiredVel[0] - agentID.Hsp;
		desiredVel[1] = desiredVel[1] - agentID.Vsp;
		
		return desiredVel;
	}
	
	function getArrivalStatus() {
		var xx = agentID.x;
		var yy = agentID.y;
		var dist = point_distance(xx,yy,targetPointX,targetPointY);
		
		if (dist < stopRadius) 
			return eArrivalStatus.ARRIVED;
		else if (dist < slowRadius) 
			return eArrivalStatus.SLOWING;
		else 
			return eArrivalStatus.TRAVELING
	}
	
	
	onDrawGizmos = function() {
		//setup
		var slowColor = c_yellow;
		var stopColor = c_red;
		draw_set_alpha(0.5)
		
		//draw slow radius
		draw_circle_color(targetPointX,targetPointY,slowRadius,slowColor,slowColor,false);
		
		//draw stop radius
		draw_circle_color(targetPointX,targetPointY,stopRadius,stopColor,stopColor,false);
		
		draw_set_alpha(1)
	}
}

enum eArrivalStatus {
	TRAVELING,
	SLOWING,
	ARRIVED
}