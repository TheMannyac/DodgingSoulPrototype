/// @description Destroy behavior list DS

if (ds_exists(ds_behaviorList,ds_type_list)) {
	
	ds_list_destroy(ds_behaviorList);
}
