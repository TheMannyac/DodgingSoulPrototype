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

//Scripts---------------------------------
onDamageScript = Soul_OnDamage;
onDeathScript = Soul_OnDeath;

//Manual Input Vars-----------------------
useManualInput = true;
