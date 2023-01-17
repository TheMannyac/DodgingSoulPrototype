/// @description Input,AI, and Movement

//If the "useManualInput" flag is set, then the AI code will not run.
if (not useManualInput) {
	
	//Sense
	
	//Think
	
	//Act

} else {
	//Take Manual Input
	inputArray = Get_Player_Input_Array();
	//Convert and Store Raw Inputs
	moveX = inputArray[ePlayerInput.right] - inputArray[ePlayerInput.left];
	moveY = inputArray[ePlayerInput.dowm] - inputArray[ePlayerInput.up];
	
	//Horizontal Movement
	Hspeed = TopDown_Movement_Horizontal(moveX,Hspeed,accelRate,decelRate,maxSpeed);
	x += Hspeed;
	//Vertical Movement
	Vspeed = TopDown_Movement_Vertical(moveY,Vspeed,accelRate,decelRate,maxSpeed);
	y += Vspeed;
}



