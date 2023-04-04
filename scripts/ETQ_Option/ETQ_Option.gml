
function ETQ_Option(_gentype, _radius,_context) constructor {
	
	generatorType = _gentype;
	radius = _radius;
	ds_testList = ds_list_create();
	
	//can be object or location
	context = _context
	
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
				collision_circle_list(xx,yy,radius,obj_projectile,false,true,_list,false);
				return;
		}
	}
}

enum ETQ_GeneratorType {
	LocalGridPoints,
	NearbyProjectiles
}
	
	
