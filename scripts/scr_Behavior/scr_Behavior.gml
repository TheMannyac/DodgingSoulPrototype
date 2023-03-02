
function SteeringBehavior(_weight=1,_agentID) constructor
{
	weight = _weight;
	agentID = _agentID;
	//function that MUST return a vector
	getVelocity = function() {
		show_error("GetVelocity funciton not implemented",true);
		//return array_create(2,0);
	};
	
	
}
	