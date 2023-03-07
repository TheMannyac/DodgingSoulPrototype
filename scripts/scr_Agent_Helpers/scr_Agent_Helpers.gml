
/* !!!!!!!!!WARNING!!!!!!!!

	All of these helper functions assume that they are being called within the scope of an agent (or soul)object.
	I probably need to make this more secure by either enforcing this or refactoring the functions to not require this.
	
	calling these elsewhere will cause weird stuff to happen
*/

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


function Agent_Register_Behavior(_bhStruct) {
	//Ensure that the struct is 
	if (not is_instanceof(_bhStruct, SteeringBehavior)) 
		show_error("Passed Struct is not a steering behavior", false);
	
	with (_bhStruct) 
		agentID = other.id;
	
	//officially add it to the list
	ds_list_add(ds_behaviorList,_bhStruct);
}

//returns reference the first struct of a given constructor type from the behavior list
// if unsuccessful, will return noone
function Agent_Get_Behavior_By_Type(_constructorName) {
	
	for (var i=0; i < ds_list_size(ds_behaviorList); i++) {
		var bh = ds_list_find_value(ds_behaviorList,i);
		
		if (is_instanceof(bh,_constructorName)) {
			return bh;
		}
	}
	
	return noone;
}

function Agent_Unregister_Behavior(_bhRef) {
	
	var i = ds_list_find_index(ds_behaviorList,_bhRef);
	
	ds_list_delete(_bhRef,i);
}

function Agent_Unregister_All_Behaviors() {
	
	ds_list_clear(ds_behaviorList);

}

// Updates the target point coordinates of all registered behaviors
function Agent_Update_Target_Point(xx,yy) {
	
	targX = xx;
	targY = yy;
	
	for (var i=0; i < ds_list_size(ds_behaviorList); i++) {
		var bh = ds_list_find_value(ds_behaviorList,i);
		bh.setTargetPoint(targX,targY);
	}
}

function Agent_Set_Draw_Debug(_debugOn) {
	
	if (not is_bool(_debugOn)) {
		show_error("Passed arg is not bool!", false);
		return;
	}
	
	for (var i=0; i < ds_list_size(ds_behaviorList); i++) {
		var bh = ds_list_find_value(ds_behaviorList,i);
		bh.drawGizmos = _debugOn;
	}
}
