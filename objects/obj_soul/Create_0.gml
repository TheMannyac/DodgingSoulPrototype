/// @description Stats and Script Setup

//Stats--------------------------
soulName = "Jerry"
maxHp = 100;
currentHp = maxHp;
accelRate = 1;
decelRate = accelRate/2;
maxSpeed = 3.2;

//Movement and Input------------------------
inputArray = array_create(4,0);
//The Direction Vector that the soul wants to move 
moveX = 0;
moveY = 0;
//The Current Momentum on each axis
Hspeed = 0;
Vspeed = 0;

//AI Parameters---------------------------------


//Scripts---------------------------------
onDamageScript = Soul_OnDamage;
onDeathScript = Soul_OnDeath;

stateTimer = 10;

currentState = eSoulAIState.IDLE;
currentStage = eBHVRStages.ENTER;

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
