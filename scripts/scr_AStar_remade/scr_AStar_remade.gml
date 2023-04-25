

//Uses A* to find the best path between two points; 
// Start and end positions are snapped to node.
//if "return debug tools is set to falsereturns whether it was successful or not.
function wg_find_path_new(weightGrid,path,startX,startY,endX,endY,returnDebugTools=false) {
	
	#region//LOCAL VARS
	
	#endregion
	//////////////////////////////////////////////////////////////////////////////////////////////
	#region//VALIDATION
	
	//Node Wrapper structs that hold pathfinding data for the start and end node
	var startNode, endNode,
	
	//validate passed weight grid
	if (not is_instanceof(weightGrid,WeightGrid)) {
		return PathfindResults(false,weightGrid,path,startX,startY,endX,endY);
	}
	//Find corresponding node for start posiiton
	startNode = NodeFromWorldPoint(startX,startY);
	if (startNode == undefined) 
	{
		show_error(string("Given start position, [{0},{1}], is not within the grid area and cannot be assigned a node",startX,startY),false);
		return PathfindResults(false,weightGrid,path,startX,startY,endX,endY);
	}
	//find node for end posiiton
	endNode = NodeFromWorldPoint(endX,endY);
	if (endNode == undefined) 
	{
		show_error(string("Given end position, [{0},{1}], is not within the grid area and cannot be a assigned node",endX,endY),false);
		return PathfindResult
	}
	#endregion
	//////////////////////////////////////////////////////////////////////////////////////////////
	#region//INITIALIZATION
	
	//structure that holds all the nodes that have been discovered but not explored
	var openQ = ds_priority_create()
	//Struct that storess nodes that have been explored.
	var closedSet = {}
	
	//Wrap Start and End Node (Assumes that both nodes are walkable)
	startNode = new NodeWrapper(startNode,noone,true,0,0);
	endNode = new NodeWrapper(endNode,noone,true,0,0);
	
	//add start node to the priority queue
	ds_priority_add(openQ,startNode,0);
	
	#endregion
	//////////////////////////////////////////////////////////////////////////////////////////////
	#region//MAIN BODY
	while(not ds_priority_empty(openQ)) {
		
		//Get node with highest Fcost
		var currentNode = ds_priority_delete_min(openQ);
		//Store grid position of the current node for readability
		var gX = currentNode.gridX, gY = currentNode.gridY;
		
		//Add current Node to closed set
		closedSet[gX][gY] = true;
		
		//If this is the end node, we're done.
		if (endNode.Equals(currentNode)) {
			
		}
		
		//loop through all neighbor nodes
		var neighborArray = weightGrid.GetNeighbors();
		for(var i=0;i<array_length(neighborArray);i++) {
			
			var neighbor = neighborArray[i];
			var nX = neighbor.gridX, nY = neighbor.gridY;
			
			//check if its in the closed list
			if (closedSet[nX][nY]==true) {
				continue;	
			}
			
			//check to see if there is a better path
			//var notInOpenQ = is_undefined(ds_priority_find_priority(openQ,));
		}
	}
	#endregion
	//////////////////////////////////////////////////////////////////////////////////////////////
	#region//CLEANUP
	
	ds_priority_destroy(openQ);
	
	#endregion
	
	//Cleanup
	
}


