
//Use to ensure that state change is done correctly
function Agent_Change_State(_nxtState){
	
	//checks if arg is integer
	if (floor(_nxtState) != _nxtState)  
		show_error("argument is not valid integer meaning that it cannot be a valid state ID",true);
	//returns if the argument equals the current state
	if(_nxtState == currentState) return 
	
	currentStage = eBHVRStages.EXIT;
	nextState = _nxtState;
}

