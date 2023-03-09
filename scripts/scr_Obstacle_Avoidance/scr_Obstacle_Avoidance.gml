
/// @description sb_Obstacle_Avoidance
/// @arg weight
/// @arg minSweepLen
/// @arg avoidObj
/// @arg accuracy
/// @arg get_Step_Size_Method_Var
function sb_Obstacle_Avoidance(_weight,_minSweepLen,_avoiObj,_acc=1,StepMethod=pointer_null) : SteeringBehavior(0,0,_weight) constructor {
	
	//Minimum length of the detection box
	minSweepLength = _minSweepLen
	
	//Defines how far back a sweep will look after detecting a collision
	//Higher = more accurate; lower = more efficient
	accuracy = _acc
	
	//The user can choose to change how this behavior calculates the step size of the sweep
	//by passing in a valid method variable that will be IMMEDIATELY REBOUND to the scope of this struct
	//otherwise, it uses the sprite's scalled width as the default calculation
	if (is_callable(StepMethod)){
		getStepSize = method(self,StepMethod);
	} else {
		getStepSize = function() {
			return agentID.sprite_width/3;
		};
	}
	
	//Object or instance Id to sweep for
	thingToAvoid = _avoiObj;
	
	
	getVelocity = function() {
		var xx = agentID.x, yy = agentID.y,
		var resultVec = [0,0];
		
		//Sweep Collision Prediction Implementatiom
		var sweepLen = get_sweep_length();
		var sweep_end_x = xx + lengthdir_x(sweepLen,agentID.direction);
		var sweep_end_y = yy + lengthdir_y(sweepLen,agentID.direction);
		
		//Sweep func must be done from instance perspective
		with (agentID) {
			var sweepArr = move_contact_obj(x,y,sweep_end_x,sweep_end_y,other.getStepSize(),other.accuracy,other.thingToAvoid);
			
			//if sweep detected collision calculate the steering force and return it
			if (sweepArr[2]) {
				
				var hitX = sweepArr[0], hitY = sweepArr[1], otherHit = sweepArr[5];
				var hitDist = point_distance(x,y,hitX,hitY);
				var hitDir =  point_direction(x,y,hitX,hitY);
				
				var angleDiff = angle_difference(hitDir,direction);
				
				//Calculate turn direction
				var newDir = direction - (turnSpeed * (sign(angleDiff)));
				
				//Calculate vector length after applying braking force
				var brakeLen = currentSpeed - (maxSpeed * brakeFactor) 
				
				//Convert into a velocity vector that is scaled based on the distance from the predicted hit
				resultVec[0] = lengthdir_x(brakeLen,newDir) * (hitDist/sweepLen);
				resultVec[1] = lengthdir_y(brakeLen,newDir) * (hitDist/sweepLen);
			} 
		}
		
		return resultVec;
		
		/*
		Simple implementation. Untested
		
		var collide_obj = collision_circle(x,y,collision_radius,obj_projectile,0,1);
		var count = 0;
	
		//Iterate over
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
		
		*/
		/*
		Mark buckland Detection box implementation unfinished
		
		//boxLen = get_sweep_length(),
			//boxWid = Get_Detection_Box_Width(),
			box_end_x = xx + lengthdir_x(boxLen,agentID.direction),
			box_end_y = yy + lengthdir_y(boxLen,agentID.direction),
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
	
	function get_sweep_length() {
		//will return NaN if maxspeed is set to 0
		return 	minSweepLength + (agentID.currentSpeed/agentID.maxSpeed) * minSweepLength;
	}
	
	drawGizmos = function() {
		
	}
}