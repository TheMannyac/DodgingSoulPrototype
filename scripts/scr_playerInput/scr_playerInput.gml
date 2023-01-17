

function Get_Player_Input_Array(){
	var _inputArray = array_create(4,0);
	
	_inputArray[ePlayerInput.right]	=	keyboard_check(global.input_right);
	_inputArray[ePlayerInput.left]	=	keyboard_check(global.input_left);
	_inputArray[ePlayerInput.up]	=	keyboard_check(global.input_up);
	_inputArray[ePlayerInput.dowm]	=	keyboard_check(global.input_down);
	
	//return whatever inputs that are recorded
	return _inputArray
}