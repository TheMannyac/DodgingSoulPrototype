
//Struct that contains general info about 
function PathfindResults(_success,_weightGrid,_path,_startX,_startY,_endX,_endY) constructor
{
	success = _success
	weightGrid = _weightGrid
	path = _path;
	startX = _startX;
	startY = _startY
	endX = _endX;
	endY = _endY;

}

//Contains a bunch of data and methods for displaying and debugging a pathfinding attempt
function PathfindDebugger(_success,_weightGrid,_path,_startX,_startY,_endX,_endY,_startNode=undefined,_endNode=undefined,_openList,_exploredNodes,_stepLogs=[]) 
	: PathfindResults(_success,_weightGrid,_path,_startX,_startY,_endX,_endY) constructor
{
	startNode = _startNode;
	endNode = _endNode;
	
	//copy open list to array
	discoveredNodes = array_create(ds_list_size(_openList));
	for (var i=0;i<array_length(discoveredNodes);i++) {
		discoveredNodes[i] = _openList[|i];
	}
	
	//Copy over the array of explored nodes
	exploredNodes = _exploredNodes;
	
	//copy over the array of step log strings
	stepLogs = _stepLogs;
	
	
	//returns the total number of iterations the pathfinding took before concluding
	function totalSteps() {
		return array_length(exploredNodes);
	}
	
	//prints all generated string logs to console
	function printLogs() {
		for(var i=0;i<array_length(stepLogs);i++) {
			var logStr = stepLogs[i];
			show_debug_message(logStr);
		}
	}
	
	//draws circles on all the discovered and explored nodes
	function DrawTouchedNodes() {
		
		var col1 = c_green, col2 = c_yellow;
		var cellDiam = weightGrid.cellDiameter;
		
		
		//draw dots on all the discovered Nodes
		draw_set_color(col1);
		for (var i=0;i<array_length(discoveredNodes);i++) {
			var node = discoveredNodes[i];
			
			draw_circle(node.x,node.y,cellDiam/2,false);
			
		}
		
		//draw dots on all the discovered Nodes
		draw_set_color(col2);
		for (var i=0;i<array_length(exploredNodes);i++) {
			var node = exploredNodes[i];
			draw_circle(node.x,node.y,cellDiam/2,false);
		}
		//reset draw color
		draw_set_color(c_white);
	}
	
	
}