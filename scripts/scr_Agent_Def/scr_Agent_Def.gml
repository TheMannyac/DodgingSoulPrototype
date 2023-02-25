// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Func structure
// 1) Enter (set up everything, execute once)
// 2) Execute everything per frame, check if exit needs to be called
// 3) Exit, undo anything that needs to be undone, move onto next state


function Idle_Start(){
	show_debug_message("Entering Idle State");
}
function Idle_Process(){
	
	//Wait for target
	if (targX != undefined && targY != undefined) {
		Agent_Change_State(eSoulAIState.DODGE);
	}
	
	
	//Will exit idle after 3 seconds
	//if (stateTimer > 3) {
		//Agent_Change_State(eSoulAIState.DODGE);
	//}
	//show_debug_message("Idling...");
}
function Idle_Exit(){
	show_debug_message("Exiting Idle State");
}



function Dodge_Start(){
	show_debug_message("Entering Dodge State");
}
function Dodge_Process(){
	
	var _dist = point_distance(x,y,targX,targY);
	
	if (_dist < arriveThreashold) {
		//we have arrived
		Agent_Change_State(eSoulAIState.IDLE)
	} else {
		//Steer toward target position
		var _dir = point_direction(x, y, targX, targX);
		var _angleDiff = angle_difference(_dir, direction);
		direction += _angleDiff * 0.3 * global.delta_multiplier; //this natually starts fast and gradually slows
		
		//Move
		
	}
	
	//show_debug_message("Dodging...");
}
function Dodge_Exit(){
	show_debug_message("Exiting Dodge State");
	targX = undefined;
	targY = undefined;
}



function Special_Start(){
	show_debug_message("Entering Speical State");
}
function Special_Process(){
	//show_debug_message("Idling...");
}
function Special_Exit(){
	show_debug_message("Exiting Special State");
}



function Dead_Start(){
	show_debug_message("Entering Idle State");
}
function Dead_Process(){
	//show_debug_message("Idling...");
}
function Dead_Exit(){
	show_debug_message("Exiting Dead State");
}
