
/* CREDIT: Skydar
	https://forum.gamemaker.io/index.php?threads/sorting-an-array-of-structs-by-structs-variable.89754/post-538412

*/

function ds_list_struct_sort(_list, _str, _asc) {
    ///@desc    the passed list contains structs, sort the list via the passed struct in the passed order.
    ///            returns the list id if successful, otherwise returns -1 if the passed string is not a valid struct variable
    ///@arg    list       real      ds_list
    ///@arg    str        string    name of struct variable to sort by as a string
    ///@arg    asc        boolen    sort ascending(true) or descending(false)
  
    //put all struct variables into list, and sort it, then loop it and match the name to the struct, placing that back into a list
    var _size = ds_list_size(_list);
    var _dsp_names = ds_priority_create();
    var _dsl_new_list = ds_list_create();
    for (var i = 0; i < _size; ++i) {
        //get next struct
        var _stt = _list[|i];
        //get string from struct if exists
        if variable_struct_exists(_stt, _str) {
            var _text = variable_struct_get(_stt, _str);
        } else {
            ds_priority_destroy(_dsp_names);  
            ds_list_destroy(_dsl_new_list);  
            show_debug_message("ds_list_struct_sort for " + _str + " has failed as string does not exist in passed struct");
            return -1;
        }
		
        ds_priority_add(_dsp_names, i, (is_method(_text)) ? method_call(_text,[]): _text );
    }
  
    //get names in order and place them into list
    _size = ds_priority_size(_dsp_names);
    for (var i = 0; i < _size; ++i) {
        //get the i value from the priority order, and move these to a new list in this new order
        if _asc {
            var _name = ds_priority_find_max(_dsp_names);
            var _index = ds_priority_find_priority(_dsp_names, _name);
            _index = ds_priority_delete_max(_dsp_names);
        } else var _index = ds_priority_delete_min(_dsp_names);
        ds_list_add(_dsl_new_list, _list[|_index]);
    }
  
    //now we can copy and overwrite the original list, with this newly sorted list
    ds_list_copy(_list, _dsl_new_list);
  
    //cleanup
    ds_priority_destroy(_dsp_names);
    ds_list_destroy(_dsl_new_list);
  
    //success
    return _list;
}