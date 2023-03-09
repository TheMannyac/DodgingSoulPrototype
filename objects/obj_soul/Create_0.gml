/// @description Stats and Script Setup

//Stats--------------------------
soulName = "Jerry"
maxHp = 100;
currentHp = maxHp;

accelRate = 1;
decelRate = accelRate/2;
currenSpeed = 0;
maxSpeed = 3.5;
turnSpeed = 10; //degrees/second
brakeFactor = .2;	//multiplier applied to current speed when manually braking


Mass = 5;
Friction = .05;	//Percent of velocity that is reduced every from

/*	List of registered behavior structs
	Could be a priority queue if needed you would just to to refactor some funcitons
*/
ds_behaviorList = ds_list_create()

/*struct that contains variables that only pertain to a given state
	allows temporary variables to be stored between steps but aren't saved in object scope
	the struct is typically wiped when a state transition happens
	for that reason, this should only be set or accessed in the state method
*/
state_vars_struct = noone;

arriveThreashold = 2;
rotateSprite = true;

//Movement and Input------------------------
inputArray = array_create(4,0);

//The Vector representing the current steering force (unnormalized)
steerVec = [0,0];

//The Current Momentum on each axis
Hsp = 0;
Vsp = 0;

//Target Coordinates
targX = undefined;
targY = undefined;


//AI Parameters---------------------------------


//Scripts---------------------------------
onDamageScript = Soul_OnDamage;
//onDeathScript = Soul_OnDeath;

stateTimer = 0;	//measures how long the current state has lasted

currentState = eSoulAIState.IDLE;
currentStage = eBHVRStages.ENTER;

nextState = undefined;
lastState = undefined;

stateScripts = array_create(eSoulAIState.LEN,pointer_null);

//Idle 
stateScripts[eSoulAIState.IDLE][eBHVRStages.ENTER] = Idle_Start;
stateScripts[eSoulAIState.IDLE][eBHVRStages.PROCESS] = Idle_Process;
stateScripts[eSoulAIState.IDLE][eBHVRStages.EXIT] = Idle_Exit;

//Dodge 
stateScripts[eSoulAIState.DODGE][eBHVRStages.ENTER] = Dodge_Start;
stateScripts[eSoulAIState.DODGE][eBHVRStages.PROCESS] = Dodge_Process;
stateScripts[eSoulAIState.DODGE][eBHVRStages.EXIT] = Dodge_Exit;

//Special
stateScripts[eSoulAIState.SPECIAL][eBHVRStages.ENTER] = Special_Start;
stateScripts[eSoulAIState.SPECIAL][eBHVRStages.PROCESS] = Special_Process;
stateScripts[eSoulAIState.SPECIAL][eBHVRStages.EXIT] = Special_Exit;

//Dead
stateScripts[eSoulAIState.DEAD][eBHVRStages.ENTER] = Dead_Start;
stateScripts[eSoulAIState.DEAD][eBHVRStages.PROCESS] = Dead_Process;
stateScripts[eSoulAIState.DEAD][eBHVRStages.EXIT] = Dead_Exit;

//Manual Input Vars-----------------------
useManualInput = false;
