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

currentState = eSoulAIState.IDLE;
currentStage = eBHVRStages.ENTER;

stateScripts = array_create(eSoulAIState.LEN,pointer_null);
stateScripts[eSoulAIState.IDLE] = func_Idle_Def;
stateScripts[eSoulAIState.SPECIAL] = func_Special_Def;
stateScripts[eSoulAIState.DODGE] = func_Dodge_Def;



//Manual Input Vars-----------------------
useManualInput = false;
