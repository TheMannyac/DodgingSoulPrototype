
function ETQ_Option(_optionName,_context,_gentype, _radius,_testArray) constructor {
	
	title = _optionName;
	generatorType = _gentype;
	radius = _radius;
	tests = _testArray;
	
	//Returns
	function RunTests(querier,returnList) {
		
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
			while (itr < ds_list_size(returnList) ) {
				
				var item = returnList[| itr];
				
				//Run tests on item and get results
				var resultVal = test.TestItem(item);
				
				//Filter calculated result and remove it from the item list if it fails (only if test has Filter Properties defined)
				if (is_instanceof(test.FilterProps,FilterSettings)) {
					if (test.FilterResult(resultVal) != test.FilterProps.boolToMatch){
						ds_list_delete(returnList,itr)
						
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
			if (not ds_list_empty(returnList)) {
				
				ds_list_struct_sort(returnList,"totalScore",false);
				
				return true
			}	
		}
		return false;		
	}
	
	function Generate_Item_List(queier,returnList) {
		
		var xx = context_x(querier);
		var yy = context_y(querier);
		//Get all the item values
		switch(generatorType) {
			case ETQ_GeneratorType.LocalGridPoints:
				
				break;
			
			case ETQ_GeneratorType.NearbyProjectiles:
				collision_circle_list(xx,yy,radius,obj_projectile,false,true,returnList,false);
				break;		
		}
		
		//Put all of them into structs and put them in list
		var itemNum = ds_list_size(returnList);
		var testNum = array_length(tests);
		
		for (var i=0;i<itemNum;i++) {
			
			//replace the value with the wrapper struct
			ds_list_replace(returnList,i,new ETQ_Item(returnList[| i],testNum));
			
		}
	}
}


function ETQ_Item(_ref,_testNum) constructor {
	reference = _ref;
	testScores = array_create(_testNum,0);
	
	static totalScore = function() {
		var testNum = array_length(testScores);
		var total = 0;
		for (var i=0;i<testNum;i++) {
			total += testScores[i];
		}
		return total;
	}
}


enum ETQ_GeneratorType {
	LocalGridPoints,
	NearbyProjectiles
}
	

	
