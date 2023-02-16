/// @description Input,AI, and Movement

//Clearing Old Inputs
Hspeed = 0;
Vspeed = 0;

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
			currentStage = eBHVRStages.ENTER
			break;
	}
	
} else {
	//Take Manual Input
	inputArray = Get_Player_Input_Array();
	//Convert and Store Raw Inputs
	moveX = inputArray[ePlayerInput.RIGHT] - inputArray[ePlayerInput.LEFT];
	moveY = inputArray[ePlayerInput.DOWN] - inputArray[ePlayerInput.UP];

}

//Horizontal Movement
	Hspeed = TopDown_Movement_Horizontal(moveX,Hspeed,accelRate,decelRate,maxSpeed);
	x += Hspeed;
	//Vertical Movement
	Vspeed = TopDown_Movement_Vertical(moveY,Vspeed,accelRate,decelRate,maxSpeed);
	y += Vspeed;

