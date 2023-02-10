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
OnDamageScript = Soul_OnDamage;
OnDeathScript = Soul_OnDeath;

stateScripts = array_create(eSoulAIState.LEN,pointer_null);
//stateScripts[eSoulAIState.IDLE] = 
//stateScripts[eSoulAIState.SPECIAL] = 
//stateScripts[eSoulAIState.DODGE] = 

//Manual Input Vars-----------------------
useManualInput = true;