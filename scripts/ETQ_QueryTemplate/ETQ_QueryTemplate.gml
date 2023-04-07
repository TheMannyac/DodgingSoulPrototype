

function ETQ_Query(_querier) constructor {
	
	querier = _querier;
	itemList = ds_list_create();
	
	optionsArray = array_create(0);
	/*DEFINE OPTIONS ARRAY HERE
		optionsArray[0] = new ETQ_Option(ETQ_GeneratorType.LocalGridPoints,150,,"");
	*/

	static RunQuery = function() {
		
		//Run each 
		for (var i = 0; i < array_length(optionsArray); i++){
			
			ds_list_clear(itemList);
			var option = optionsArray[i];
			
			option.Generate_Item_List(queier,itemList);
			
			//If the option didn't generate anything
			if (ds_list_empty(itemList)) {
				show_debug_message(option.title);
				continue;
			}
			
			//
			if (option.RunTests(querier,itemList)) {
				return true;
			}
		}
		
		//Return False
		ds_list_clear(itemList);
		return false;
	}
}


