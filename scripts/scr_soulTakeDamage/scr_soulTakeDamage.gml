//Script assumes it is running inside a valid soul object

function Soul_OnDamage(_damageTaken){
	if(_damageTaken < 0) return 0;
	
	var _oldHp = currentHp;
	
	//Apply the damage but cap it at 0)
	currentHp = max(currentHp-_damageTaken,0);
	//Print debug message showing current hp
	show_debug_message(soulName + ": " + string(currentHp) + "/" + string(maxHp) );
	
	if (currentHP <= 0) {
		//check if the death script variable exists in this scope
		if (script_exists(onDeathScript)) script_execute(onDeathScript);
		else show_error(soulName + "'s onDeathScript is not set!!!",true);
	}
		
	return (_oldHp - currentHp) return 0; //return the damage dealt 
}