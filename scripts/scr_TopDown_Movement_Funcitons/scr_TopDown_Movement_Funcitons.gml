/// @function		func_horizontalMovement(_hInput,_Hspeed,_accelRate,_decelRate,_maxSpeed,useSpriteMask);
/// @param {int}	hInput	A value between -1 and 1 that determines which this object is going horizontally
/// @param {real}	Hspeed			how fast is this object currently traveling horizontally
/// @param {real}	accelRate		rate at which this object accelorate horizontally
/// @param {real}	decelRate		rate at which this object decelorates horizontally
/// @param {real}	maxSpeed		Max speed that this object can travel horizontally
/// @param {bool}	useSpriteMask	Whether this object should use its sprite mask to decide collision; uses position_meeting collision if left false; default is true
/// @return {real}					new Hspeed value
/// @description	A script used to handle top down horizontal movement and collision
function TopDown_Movement_Horizontal(_hInput,_Hspeed,_accelRate,_decelRate,_maxSpeed,useSpriteMask=true){
	
	//Clamp the input 
	_hInput = clamp(_hInput,-1,1);
	
	if (_hInput != 0) { //If our foot is on the gas we need to speed up!
		_Hspeed += _hInput * _accelRate ;
		//Make sure we can't accelorate faster than our max speed
		_Hspeed = clamp(_Hspeed, -_maxSpeed, _maxSpeed);
	} else {// if not, we need to slow down
	
		if (_Hspeed > _decelRate) {
			_Hspeed -= _decelRate
		} else if (_Hspeed < -_decelRate) {
			_Hspeed += _decelRate
		} else {
			_Hspeed = 0;	
		}
	}
	
	//Handle Horizontal Collision
	if (useSpriteMask) {
		if (place_meeting(x + _Hspeed,y,obj_solid)) {
			while (!place_meeting(x + sign(_Hspeed),y,obj_solid )) {
				x += sign(_Hspeed);
			}
			_Hspeed = 0;
		}
	} else {
		if (position_meeting(x + _Hspeed,y,obj_solid)) {
			while (!position_meeting(x + sign(_Hspeed),y,obj_solid )) {
				x += sign(_Hspeed);
			}
			_Hspeed = 0;
		}
	}
	
	return _Hspeed;
}


/// @function		func_verticalMovement(_vInput,Vspeed,_accelRate,_decelRate,_maxSpeed,useSpriteMask);
/// @param {int}	vInput	A value between -1 and 1 that determines which this object is going vertically
/// @param {real}	Vspeed			how fast is this object currently traveling vertically
/// @param {real}	accelRate		rate at which this object accelorate vertically
/// @param {real}	decelRate		rate at which this object decelorates vertically
/// @param {real}	maxSpeed		Max speed that this object can travel vertically
/// @param {bool}	useSpriteMask	Whether this object should use its sprite mask to decide collision; uses position_meeting collision if left false; default is true
/// @return {real}					new Vspeed value
/// @description	A script used to handle top down vertical movement and collision
function TopDown_Movement_Vertical(_vInput,_Vspeed,_accelRate,_decelRate,_maxSpeed, useSpriteMask=true){
	
	//Clamp the input 
	_vInput = clamp(_vInput,-1,1);
	
	if (_vInput != 0) { //If our foot is on the gas we need to speed up!
			_Vspeed += _vInput * _accelRate ;
			//Make sure we can't accelorate faster than our max speed
			_Vspeed = clamp(_Vspeed, -_maxSpeed, _maxSpeed);
		} else {// if not, we need to slow down
	
			if (_Vspeed > _decelRate) {
				_Vspeed -= _decelRate
			} else if (_Vspeed < -_decelRate) {
				_Vspeed += _decelRate
			} else {
				_Vspeed = 0;	
			}
		}
	
		if (useSpriteMask) {
			//Handle Vertical Collision
			if (place_meeting(x,y+_Vspeed,obj_solid)) {
				while (! place_meeting(x,y+sign(_Vspeed),obj_solid)) {
					y += sign(_Vspeed);
				}
				_Vspeed = 0;
			}
		} else {
			//Handle Vertical Collision
			if (position_meeting(x,y+_Vspeed,obj_solid)) {
				while (! position_meeting(x,y+sign(_Vspeed),obj_solid)) {
					y += sign(_Vspeed);
				}
				_Vspeed = 0;
			}
		}
		
		return _Vspeed;
}