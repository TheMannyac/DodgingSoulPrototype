

function sb_Obstacle_Avoidance(_weight) : SteeringBehavior(0,0,_weight) constructor {
	
	//Minimum length of the 
	static minBoxLength = 30
	
	getVelocity = function() {
		
		var boxLen = get_Detection_Box_Length();
		
		//this will be used to track the distance to the CIB
		var DistToClosestIP = infinity;
		
		//this will record the transformed local coordinates of the CIB
		var localPosOfClosestObstacle;
		
		//array of all projectiles in range
		var projsInRange = collision_circle_list(agentID.x,agentID.y,boxLen,obj_projectile,false,true);
		
		//iterate through the list and 
		for (var i=0; i < array_length(projsInRange); i++) {
			var proj;
			
			with (proj) {
				
			}
		}
		
		
	}
	
	function get_Detection_Box_Length() {
		//will return NaN if maxspeed is set to 0
		return 	minBoxLength + (agentID.currentSpeed/agentID.maxSpeed) * minBoxLength;
	}
	
}