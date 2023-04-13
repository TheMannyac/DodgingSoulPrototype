//Directional Movement
global.input_right	=	vk_right;
global.input_left	=	vk_left;
global.input_up		=	vk_up;
global.input_down	=	vk_down;

//Better Delta_Time=============================================================


// The elapsed time in seconds since the last frame.
global.delta_capped =	Get_Capped_Delta();
// Normalized value that represents how close the delta is to the intended frame rate
global.delta_multiplier = Get_Delta_Modifier();


global.weightGrid = noone;