

function ETQ_Query(_contextObj) constructor {
	
	contextObject = _contextObj;
	optionsArray = array_create(0);
	
	/*DEFINE OPTIONS ARRAY HERE

	*/
	optionsArray[0] = new ETQ_Option(ETQ_GeneratorType.LocalGridPoints,150,contextObject,"");
	
	static RunQuery = function() {
		
		for (var i = 0; i < array_length(optionsArray); i++){
			var option = optionsArray[i];
			
			ds_list_clear(ds_itemList);
			option.Generate_Item_List(ds_itemList);
			
			//if there's nothing that came from this option's generator then move on 
			if (ds_list_empty(ds_itemList)) continue;
			
			//Run The Option and all its tests
			option.RunTests();
			
			//return success
			return true;
		}
		
	}
	
	
}