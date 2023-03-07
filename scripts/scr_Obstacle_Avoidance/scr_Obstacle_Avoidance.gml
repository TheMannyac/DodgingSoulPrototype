

function sb_Obstacle_Avoidance(_weight,_collRad) : SteeringBehavior(0,0,_weight) constructor {
	
	//Minimum length of the detection box
	//static minBoxLength = 30
	
	collisionRadius = _collRad;
	
	
	getVelocity = function() {
		var xx = agentID.x, yy = agentID.y,
		var resultVec = [0,0];
		var collide_obj = collision_circle(x,y,collision_radius,obj_projectile,0,1);
		var count = 0;
	
		//Iterate ove
		while(collide_obj != noone && count < 15){
			count++;
			var avoid_dir = point_direction(x,y,collide_obj.x,collide_obj.y)+180;
			var avoid_x = lengthdir_x(1,avoid_dir);
			var avoid_y = lengthdir_y(1,avoid_dir);
	
			//make sure that this does
			if(!position_meeting(avoid_x, avoid_y, obj_solid)){
				resultVec[0] += avoid_x;
				resultVec[1] += avoid_y;
			}
	
			collide_obj = collision_circle(x,y,collision_radius,obj_projectile,0,1);
		}
		
		return

		
		/*
		//boxLen = Get_Detection_Box_Length(),
			//boxWid = Get_Detection_Box_Width(),
			//box_end_x = xx + lengthdir_x(boxLen,agentID.direction),
			//box_end_y = yy + lengthdir_y(boxLen,agentID.direction),
			//DistToClosestIP = infinity,	//this will be used to track the distance to the CIB
			///closestObj;	//this will record the transformed local coordinates of the CIB
		//array of all projectiles in range
		//Part of mark buckland's original implementation
		//var projsInRange = collision_circle_list(xx,yy,boxLen,obj_projectile,false,true);
		
		//flat with search is slow, change later to be more efficient
		
		with (obj_projectile) {
			//Check if the detection box is colliding with this projectile
			if (collision_line_width(xx,yy,box_end_x,box_end_y,boxWid,self.id)) {
				
			}
		}
		*/
	}
	
	function Get_Detection_Box_Length() {
		//will return NaN if maxspeed is set to 0
		return 	minBoxLength + (agentID.currentSpeed/agentID.maxSpeed) * minBoxLength;
	}
	
	function Get_Detection_Box_Width() {
		return agentID.sprite_width;
	}
	
	drawGizmos = function() {
		
	}
}