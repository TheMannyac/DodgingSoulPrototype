/// @description Debug Display

//Origin of the display
var origX = 0;
var origY = 0;
//Coordinate off of the current Display element
var offX = 0;
var offY = 0;
//Temp Var to hold string display
var str;
//UI Text offset
var inc = 20;

//Draw State Display----------------------------------

//Increment Vertical Offset
offY += inc;

switch(currentState) {
	case eSoulAIState.IDLE:
		str = "IDLE";
		break;
	case eSoulAIState.DODGE:
		str = "DODGE"
		break;
	case eSoulAIState.SPECIAL:
		str = "SPECIAL"
		break;
	case eSoulAIState.DEAD:
		str = "DEAD"
		break;
}

//Draw Text
draw_text(origX+offX,origY+offY,"State: " + str );


//Draw Stage Display-------------------------------------

//Increment Vertical Offset
offY += inc;

switch(currentStage) {
	case eBHVRStages.ENTER:
		str = "ENTER";
		break;
	case eBHVRStages.PROCESS:
		str = "PROCESS"
		break;
	case eBHVRStages.EXIT:
		str = "EXIT"
		break;
}

//Draw Text
draw_text(origX+offX,origY+offY,"State: " + str );


//Draw Stage Display-------------------------------------

//Increment Vertical Offset
offY += inc;

//Draw Text
draw_text(origX+offX,origY+offY,"State Timer: " + string(stateTimer));

