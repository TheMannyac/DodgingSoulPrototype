// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Execute_Stage(){
	
	switch(currentStage) {
		case eBHVRStages.ENTER:
			//run setup code once
			currentStage = eBHVRStages.PROCESS;
			break;
		case eBHVRStages.PROCESS:
			//but before that make sure that the stage variable is accurate
			//Do the stuff we need to do every tick	
			break;
		case eBHVRStages.EXIT:

			//do any necesary cleanup before we go to next state
			currentStage = eBHVRStages.ENTER
			break;
	}
}