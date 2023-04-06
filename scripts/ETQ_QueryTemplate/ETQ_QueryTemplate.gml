// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ETQ_Query(_contextObj) constructor {
	
	ContextObject = _contextObj;
	ds_itemList = ds_list_create();
	optionsArray = array_create();
	
	static RunQuery = function() {
		
		for (var i = 0; i < array_length(optionsArray); i++){
			var option = optionsArray[i];
			
			ds_list_clear(ds_itemList);
			option.Generate_List(ds_itemList);
			
			//if there's nothing that came from this option's generator then move on 
			if (ds_list_empty(ds_itemList)) continue;
			
			//Run Tests on all things
			var testArr = option.tests;
			for (var j = 0; j < array_length(tests); j++) {
				var test = option.tests[j];
				
				
				
				
			
				
			}
			
			
			//Add up weights
			
			//return success
			return true;
		}
		
	}
	
	
}