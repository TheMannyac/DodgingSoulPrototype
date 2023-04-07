
function Test_DistanceTo(_filter,_scoring,_reference,_testDescrip="Filter/Score the distance between [item] and [reference]") 
	: ETQ_Test(_filter,_scoring,_reference,_testDescrip) constructor {
	
	static requireReference = true;
	
	
	static TestItem = function (itemStruct) {
		/*validate item data*/
		
		var itemX = context_x( itemStruct.reference);
		var itemY = context_y( itemStruct.reference);
		
		//Return calculated result
		return point_distance(reference.x,reference.y,itemX,itemY);
	}
	
	static FilterResult = function (value) {
		
		if not is_struct(FilterProps) show_error("Filter struct not defined!!",true);
			
		return FilterProps.checkVal(val);
	}
	
	static ScoreResult = function (value) {

		if not is_struct(FilterProps) show_error("Scoring Properties struct not defined!!",true);
		
		/* Assign score using Scoring Properties*/
		
		
		
		return false;
	}
}