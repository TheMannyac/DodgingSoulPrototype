
/*
	A series of functions meant to be used to 
	spatially manipulate the weights of weight grid struct 
*/

function wg_circle_brush (weightGrid,xx,yy,radius,strength,hardness=.8 ){
	
	//Validate Weight Grid struct
	if (not is_instanceof(weightGrid,WeightGrid)) {
		show_error("Invalid Weight Grid reference",false);
		return;	
	}
	
	//There's no point in wasting cycles if we're gonna add/subtract 0
	if (strength == 0) {
		return; 
	}
	
	//Get Node to begin the stroke from
	var originNode = weightGrid.NodeFromWorldPoint();
	var
	
}