/// @description Input,AI, and Movement


//If the "useManualInput" flag is set, then the AI code will not run.
if (not useManualInput) {
	
	var stageFunc = stateScripts[currentState][currentStage]
	//Execute The Specific Stage Script based on current state
	switch (currentStage) {
		
		case eBHVRStages.ENTER:
			script_execute(stageFunc);
			currentStage = eBHVRStages.PROCESS;
			break;
			
		case eBHVRStages.PROCESS:
			//Do the stuff we need to do every tick	
			script_execute(stageFunc);
			break;
			
		case eBHVRStages.EXIT:
			//do any necesary cleanup before we go to next state
			script_execute(stageFunc);
			break;
	}
	
	
	var accelX = 0;
	var accelY = 0;

	//Get the cumulative acceloration of each registered Behavior 
	for(var i = 0; i < ds_list_size(ds_behaviorList); i += 1) {
	
		var bh = ds_list_find_value(ds_behaviorList,i);
	
		if ((bh != undefined) && (is_instanceof(bh, SteeringBehavior)) ) {
			var vel = bh.getVelocity();
			accelX += vel[0] * bh.weight;
			accelY += vel[1] * bh.weight;
		}
	}

	//Divide Acceleration by the mass
	Hsp += accelX / Mass;
	Vsp += accelY / Mass;

	//Apply Friction
	Hsp -= Hsp * Friction; 
	Vsp -= Vsp * Friction;

	//Get magnitude of vector
	currentSpeed = vector2_get_length_2arg(Hsp,Vsp);
	//Normalize Vector
	var normVec = vector2_normalize_2arg(Hsp,Vsp);

	//Cap the Speed
	if (currentSpeed > maxSpeed){
		Hsp = normVec[0] * maxSpeed;
		Vsp = normVec[1] * maxSpeed;
	}

	//Apply Acceleration to coordinate position
	x += Hsp * global.delta_multiplier;
	y += Vsp * global.delta_multiplier;

	//Rotate Sprite
	if(rotateSprite && len > 0.0001) {
		direction = radtodeg(arctan2(Vsp,Hsp));
		image_angle = direction;
	}
	
	//increment state timer
	stateTimer += Get_Capped_Delta(); 

	//Move to next stage if next state is defined
	if (nextState != undefined) {
	
		lastState = currentState;
		currentState = nextState;
		nextState = undefined;
		currentStage = eBHVRStages.ENTER;
		stateTimer = 0;
	
		//unregister all the behaviors
		Agent_Unregister_All_Behaviors();
	
		//de-reference and wipe the state vars
		delete state_vars_struct;
	}	
} 

else {
	
	//Clearing Old Inputs
	moveX = 0;
	moveY = 0;
	
	//Take Manual Input
	inputArray = Get_Player_Input_Array();
	//Convert and Store Raw Inputs
	moveX = inputArray[ePlayerInput.RIGHT] - inputArray[ePlayerInput.LEFT];
	moveY = inputArray[ePlayerInput.DOWN] - inputArray[ePlayerInput.UP];
	
	//Horizontal Movement
	Hsp = TopDown_Movement_Horizontal(moveX,Hsp,accelRate,decelRate,maxSpeed);
	x += Hsp * global.delta_multiplier;
	//Vertical Movement
	Vsp = TopDown_Movement_Vertical(moveY,Vsp,accelRate,decelRate,maxSpeed);
	y += Vsp * global.delta_multiplier;
}
