



function context_x(context) {
	//if its a vector
	if (is_array(context)) {
		return context[0];
	} else if (instance_exists(context)) {
		return context.x;
	} else {
		show_error("this context is neither an array nor a valid instance",false)
		return undefined;
	}	
}

function context_y(context) {
	//if its a vector
	if (is_array(context)) {
		return context[1];
	} else if (instance_exists(context)) {
		return context.y;
	} else {
		show_error("this context is neither an array nor a valid instance",false)
		return undefined;
	}	
}

