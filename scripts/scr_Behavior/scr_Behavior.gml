
function SteeringBehavior(_targetPointX,_targetPointY,_weight=1,_agentID=noone) constructor
{
	targetPointX = _targetPointX;
	targetPointY = _targetPointY;
	weight = _weight;
	agentID = _agentID;
	drawGizmos = false;	
	
	//function that MUST return a vector array
	getVelocity = function() {
		show_error("GetVelocity funciton not implemented",true);
		//return array_create(2,0);
	};
	
	//Called when drawing debug tools; Only call in draw event; most implementations should use this
	onDrawGizmos = function() {
		if (drawGizmos){
			
		}
	}
	
	function setTargetPoint(xx,yy) {
		targetPointX = xx;
		targetPointY = yy;
	}
	
}

	