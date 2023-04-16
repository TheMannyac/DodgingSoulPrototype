

function PathfindResults(_success,_weightGrid,_path,_startX,_startY,_endX,_endY) constructor
{
	success = _success
	weightGrid = weightGridID
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
	for (var i=0;i<array_length(discoverdNodes);i++) {
		discoveredNodes[i] = _openList[|i];
	}
	
	//Copy over the array of explored nodes
	exploredNodes = _exploredNo;
	
	//copy over the array of step log strings
	stepLogs = _stepLogs;
	
	
	
	//returns the total number of iterations the pathfinding took before concluding
	function totalSteps() {
		return array_length(exploredNodes);
	}
	
	//
	function DrawTouchedNodes() {
		
		var col1 = c_green, col2 = c_yellow;
		
		//draw dots on all the discovered Nodes
		for (var i=0;i<array_length(discoveredNodes);i++) {
			var node = discoverdNodes[i];
			draw_point_color(node.x,node.y,col2);
		}
		
		//draw dots on all the discovered Nodes
		for (var i=0;i<array_length(exploredNodes);i++) {
			var node = exploredNodes[i];
			draw_point_color(node.x,node.y,col1);
		}
	}
}