
function ETQ_Option(_gentype, _radius,_context, _optionName="") constructor {
	
	generatorType = _gentype;
	radius = _radius;
	optionName = _optionName;
	tests = array_create(0);
	
	//can be object or location
	context = _context
	
	function RunTests(items) {
		
		for (var i=0; i < ds_list_size(tests); i++) {
			var test = ds_list_find_value(i);
			//First Filter out failures
			if (test.filterProps != undefined) {
				
				var itr = 0;
				while (itr < ds_list_size(items)) {
					var thisItem = ds_list_find_value(items,itr);
					
					if () {
						
					}
					
				}
			}
				
			//Then Score the survivors
			if (test.ScoringProps != undefined) {
				
			}
		}
	}
	
	function Generate_List(_list) {
		switch(generatorType) {
			case ETQ_GeneratorType.LocalGridPoints:
				var xx,yy;
				
				//if its a vector
				if (is_array(context)) {
					xx = context[0];
					yy = context[1];
				} else if (instance_exists(context)) {
					xx = context.x;
					yy = context.y;
				}
				
				return;
			break;
			case ETQ_GeneratorType.NearbyProjectiles:
			var xx,yy;
				//if its a vector
				if (is_array(context)) {
					xx = context[0];
					yy = context[1];
				} else if (instance_exists(context)) {
					xx = context.x;
					yy = context.y;
				}
				//fill the list with all instances at cente
				collision_circle_list(xx,yy,radius,obj_projectile,false,true,_list,false);
				return;
		}
	}
}

enum ETQ_GeneratorType {
	LocalGridPoints,
	NearbyProjectiles
}
	
	
