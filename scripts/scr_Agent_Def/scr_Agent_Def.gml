// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Func structure
// 1) Enter (set up everything, execute once)
// 2) Execute everything per frame, check if exit needs to be called
// 3) Exit, undo anything that needs to be undone, move onto next state

function func_Dodge_Def(){
	
	switch(currentStage) {
		case eBHVRStages.ENTER:
			//run setup code once
			currentStage = eBHVRStages.PROCESS;
			{
				
			}
			break;
		case eBHVRStages.PROCESS:
			//but before that make sure that the stage variable is accurate
			//Do the stuff we need to do every tick	
			{
				
			}
			break;
		case eBHVRStages.EXIT:
			{
				
			}
			//do any necesary cleanup before we go to next state
			break;
	}
	
}

function func_Idle_Def(){
	
}

function func_Special_Def(){
	
}