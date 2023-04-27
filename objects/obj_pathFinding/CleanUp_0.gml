/// @description Insert description here


//Delete any old path instances
if (path_exists(myPath)) {
	path_delete(myPath);
	myPath = undefined;
}