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


//Horizontal Movement
Hspeed = TopDown_Movement_Horizontal(moveX,Hspeed,accelRate,decelRate,maxSpeed);
x += Hspeed * global.delta_multiplier;
//Vertical Movement
Vspeed = TopDown_Movement_Vertical(moveY,Vspeed,accelRate,decelRate,maxSpeed);
y += Vspeed * global.delta_multiplier;


//Move to next stage if next state is undefined
if (nextState != undefined) {
	lastState = currentState;
	currentState = nextState;
	nextState = undefined;
	currentStage = eBHVRStages.ENTER;
	stateTimer = 0;
}


