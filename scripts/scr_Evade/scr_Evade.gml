// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//Returns an array for the velocity vector
function sb_Evade(_targetPointX,_targetPointY, _weight,_fleeRad) : SteeringBehavior(_targetPointX,_targetPointY,_weight) constructor {
	
	//the minimum distance from point
	fleeRadius = _fleeRad;
	
	getVelocity = function() {
		var xx = agentID.x;
		var yy = agentID.y;
		var dist = point_distance(xx,yy,targetPointX,targetPointY);
		
		if (dist < fleeRadius) {
			
			var velVec = vector2_normalize_2arg(targetPointX-xx,targetPointY-yy);
			velVec[0] = -1*( (velVec[0] * agentID.maxSpeed) - agentID.Hsp);
			velVec[1] = -1*( (velVec[1] * agentID.maxSpeed) - agentID.Vsp);
			return velVec;
		} else {
			//if not within the flee radius, this behavior has no effect
			return array_create(2,0);
		}
		
	}
	
}