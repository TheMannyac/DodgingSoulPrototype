

function Get_Player_Input_Array(){
	var _inputArray = array_create(4,0);
	
	_inputArray[ePlayerInput.RIGHT]	=	keyboard_check(global.input_right);
	_inputArray[ePlayerInput.LEFT]	=	keyboard_check(global.input_left);
	_inputArray[ePlayerInput.UP]	=	keyboard_check(global.input_up);
	_inputArray[ePlayerInput.DOWN]	=	keyboard_check(global.input_down);
	
	//return whatever inputs that are recorded
	return _inputArray
}