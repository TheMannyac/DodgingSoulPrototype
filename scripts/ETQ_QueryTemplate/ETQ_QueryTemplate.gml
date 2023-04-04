// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ETQ_Query(_contextObj) constructor {
	
	ContextObject = _contextObj;
	ds_itemList = ds_list_create();
	ds_optionList = ds_list_create();
	
	static RunQuery = function() {
		
		for (var i = 0; i < ds_list_size(ds_optionList); i++){
			var option = ds_list_find_value(ds_optionList,i);
			
			ds_list_clear(ds_itemList);
			option.Generate_List(ds_itemList);
			
			//if there's nothing that came from this option's generator then move on 
			if (ds_list_empty(ds_itemList)) continue;
			
			var ds_tests = option.ds_testList;
			
			for (var j=0; j < ds_list_size(ds_tests); j++) {
				var test = ds_list_find_value(ds_tests,j);
				
				if ( instance_exists(test.reference) || not test.requireReference ) {
					
					//check for fixed result
					
					// do conditional
					if (test.isCondition) {
							
					}
					
					// calculate weight
					if (test.isWeightPreference) {
						
					}
					
				}
			}
			
			//Add up weights
			
			
		}
		
	}
	
	
}