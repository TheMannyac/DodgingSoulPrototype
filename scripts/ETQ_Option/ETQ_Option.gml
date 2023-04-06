
function ETQ_Option(_optionName="",_gentype, _radius,_context ) constructor {
	
	generatorType = _gentype;
	radius = _radius;
	optionName = _optionName;
	tests = array_create(0);
	
	//can be object or location
	context = _context
	
	function RunTests(itemList) {
		
		var testNum = array_length(tests);	//shouldn't change
			
		//for each test
		for (var i=0;i<testNum;i++) {
			var test = tests[i];
				
			//try to fail early and move on to next test
			if (test.requireReference && not instance_exists(test.reference)) {
				continue;
			}
				
			//for each item  
			var itr = 0;
			while (itr < ds_list_size(itemList) ) {
				
				var item = itemList[| itr];
				
				//Run tests on item and get results
				var resultVal = test.TestItem(item);
				
				//Filter calculated result and remove it from the item list if it fails (only if test has Filter Properties defined)
				if (is_instanceof(test.FilterProps,FilterSettings)) {
					if (test.FilterResult(resultVal) != test.FilterProps.boolToMatch){
						ds_list_delete(itemList,itr)
						
						//move on to next item; make sure itr stays on next item even after removal.
						continue;
					}
				}
			
				//Give the item a score based on calculated result and save it to the item struct (only if the test has Scoring Properties defined)
				if (is_instanceof(test.ScoringProps,ScoringSettings)) {
					item.testScores[itr] = test.ScoreResult(resultVal);
				}
				
				//Move on to next item.
				itr++;
			}
			
			//if there are any valid items left, begin ranking them.
			if (not ds_list_empty(itemList)) {
				
			}	
		}
		return false;		
	}
	
	function Generate_Item_List(returnList) {
		
		//Get all the item values
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
				
				if (instance_exists(context) ) {
					with (context) {
						collision_circle_list(x,y,other.radius,obj_projectile,false,true,returnList,false);
					}
				}
				break;		
		}
		
		//Put all of them into structs and put them in list
		var itemNum = ds_list_size(returnList);
		var testNum = array_length(tests);
		
		for (var i=0;i<itemNum;i++) {
			//store the item
			var temp = returnList[| i];
			
			//place it into struct
			var myStruct = {
				value : temp,
				testScores : array_create(testNum,0)
			};
			
			//replace the value with the wrapper struct
			ds_list_replace(returnList,i,myStruct);
			
		}
	}
}



enum ETQ_GeneratorType {
	LocalGridPoints,
	NearbyProjectiles
}
	
	
