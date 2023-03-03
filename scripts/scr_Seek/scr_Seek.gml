
//Returns an array for the velocity vector
function sb_Seek(_targetPointX,_targetPointY, _weight) : SteeringBehavior(_targetPointX,_targetPointY,_weight) constructor {
	
	
	getVelocity = function() {
		var xx = agentID.x;
		var yy = agentID.y;
		//var dist = point_distance(xx,yy,targetPointX,targetPointY);
		
		var velVec = vector2_normalize_2arg(targetPointX-xx,targetPointY-yy);
		velVec[0] = ( velVec[0] * agentID.maxSpeed) - agentID.Hsp;
		velVec[1] = ( velVec[1] * agentID.maxSpeed) - agentID.Vsp;
		
		return velVec;
	}
	
}

