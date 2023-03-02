/// @description Input,AI, and Movement

//Clearing Old Inputs
moveX = 0;
moveY = 0;

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
	
	stateTimer += Get_Capped_Delta(); //increment state timer
} else {
	//Take Manual Input
	inputArray = Get_Player_Input_Array();
	//Convert and Store Raw Inputs
	moveX = inputArray[ePlayerInput.RIGHT] - inputArray[ePlayerInput.LEFT];
	moveY = inputArray[ePlayerInput.DOWN] - inputArray[ePlayerInput.UP];
}

var accelX = 0;
var accelY = 0;

//Get the cumulative acceloration of each registered Behavior 
for(var i = 0; i < ds_list_size(ds_behaviorList); i += 1) {
	
	var bh = ds_list_find_value(ds_behaviorList,i);
	
	if ((bh != undefined) && (is_instanceof(bh, SteeringBehavior)) ) {
		var vel = script_execute(bh.getVelocity);
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

//Normalize Vector
var len = sqr(Hsp^2 + Vsp^2);
var nHsp = Hsp/len;
var nVsp = Vsp/len;

//Cap the Speed
if (len > maxSpeed){
	Hsp = nHsp * maxSpeed;
	Vsp = nVsp * maxSpeed;
}

//Apply Acceleration to coordinate position
x += Hsp * global.delta_multiplier;
y += Vsp * global.delta_multiplier;

//Rotate Sprite
if(rotateSprite && len > 0.0001) {
	direction = radtodeg(arctan2(Hsp,Vsp));
	image_angle = direction;
}

/*
//Horizontal Movement
Hsp = TopDown_Movement_Horizontal(moveX,Hsp,accelRate,decelRate,maxSpeed);
x += Hsp * global.delta_multiplier;
//Vertical Movement
Vsp = TopDown_Movement_Vertical(moveY,Vsp,accelRate,decelRate,maxSpeed);
y += Vsp * global.delta_multiplier;
*/

//Move to next stage if next state is undefined
if (nextState != undefined) {
	
	lastState = currentState;
	currentState = nextState;
	nextState = undefined;
	currentStage = eBHVRStages.ENTER;
	stateTimer = 0;
	
	ds_list_clear(ds_behaviorList);
}


