

//Uses A* to find the best path between two points; 
//if "return debug tools is set to falsereturns whether it was successful or not.
function wg_find_path(weightGrid,path,startX,startY,endX,endY,returnDebugTools=false) {
	
	show_debug_message("Begin A* Pathfinding from start point {0},{1} to end point {2},{3}",startX,startY,endX,endY);
	
	//validate passed weight grid
	if (not is_instanceof(weightGrid,WeightGrid)) {
		return PathfindResults(false,weightGrid,path,startX,startY,endX,endY);
	}
	
	with (weightGrid) {
		//Find corresponding node for start posiiton
		var startNode = NodeFromWorldPoint(startX,startY);
		if (startNode == undefined) 
		{
			show_error(string("Given start position, [{0},{1}], is not within the grid area and cannot be assigned a node",startX,startY),false);
			return PathfindResults(false,weightGrid,path,startX,startY,endX,endY);
		}
		//find node for end posiiton
		var endNode = NodeFromWorldPoint(endX,endY);
		if (endNode == undefined) 
		{
			show_error(string("Given end position, [{0},{1}], is not within the grid area and cannot be a assigned node",endX,endY),false);
			return PathfindResults(false,weightGrid,path,startX,startY,endX,endY);
		}
		
		//Create Open and closed Set
		var openList = ds_list_create();
		var closedGrid = array_create(ds_grid_width(ds_myGrid),
			array_create(ds_grid_height(ds_myGrid),undefined) );
			
		//Create an array for containing all the nodes that have been added to the closed list (only used for debug tools)
		var exploredNodes = [];
		//Create an array that holds all the log strings for each step (only used with debug tools)
		var stepLogs = [];
		
		//Wrap Start and End Node (Assumes that both nodes are walkable)
		startNode = new NodeWrapper(startNode,noone,true,0,0);
		endNode = new NodeWrapper(endNode,noone,true,0,0);
		
		//Add first node to the open list
		//ds_priority_add(openList,startNode,0)
		ds_list_add(openList,startNode);
		
		//Loop while there are still nodes in the open set
		while ( not ds_list_empty(openList)) {
			
			//Node with the lowest fCost (the first time I only have one...)
			var currentNode = openList[|0];
			
			//Go through list to find best fCost
			//This data structure is unoptimized; try to find something that can properly sort structs.
			var nodePos = 0;
			for (var i=0;i<ds_list_size(openList);i++) {
				if (openList[|i].fCost() <= currentNode.fCost()) {
					currentNode = openList[|i];
					nodePos = i;
				}
			}
			
			//If Path Found...
			if (endNode.Equals(currentNode)) {
				//Construct the path in reverse
				var nd = currentNode
				while (nd != startNode) 
				{
					path_add_point(path,nd.x,nd.y,100);
					nd = nd.parentNode
				}
				//Reverse the path 
				path_reverse(path);
				
				//Return success
				show_debug_message("Pathfinding Success!! Path:");
				
				//Create Return Struct
				var returnStruct;
				if (returnDebugTools) 
				{
					returnStruct = new PathfindDebugger(true,weightGrid,path,startX,startY,endX,endY,startNode,endNode,openList,exploredNodes,stepLogs);
				} 
				else
				{
					returnStruct = new PathfindResults(true,weightGrid,path,startX,startY,endX,endY);
				}
				//cleanup
				ds_list_destroy(openList);
				return returnStruct
			}
			
			//Remove from the open and add to the closed set
			ds_list_delete(openList,nodePos);
			closedGrid [currentNode.gridX][currentNode.gridY] = currentNode;
			
			//Find the Neighbors of the current node
			var neighbors = GetNeighbors(currentNode.gridX,currentNode.gridY);
			
			//This array will be used to store all the new neighbor node wrapper structs that will be added after we're done assessing the neighbors
			var newNodes = array_create(array_length(neighbors),undefined);
			var newNodeNum = 0;
			for (var i=0; i<array_length(neighbors);i++) 
			{
				//Get Array containing data about neighbor cell
				var neighbor = neighbors[i];
				
				
				if(not is_array(neighbor)) {
					continue;
				}
				
				var myGridX = neighbor[GridNode.gridX];
				var myGridY = neighbor[GridNode.gridY];
				
				//Check if node wrapper struct for this struct already exists in the closed grid
				var wrapper = closedGrid[myGridX][myGridY]
				if (wrapper != undefined){
					continue;
				}
				
				//Check if a node wrapper already exists for this node in the Open list, create one and add it to the list
				wrapper = getNodeFromOpenList(openList,neighbor);
				if (wrapper == undefined) {
					
					wrapper = new NodeWrapper(neighbor);
					wrapper.hCost = weightGrid.GetGridDistance(wrapper.gridX,wrapper.gridY,endNode.gridX,endNode.gridY);//GetDistance_Euclidean(wrapper,endNode);
					//Add this to open list after we're done
					newNodes[newNodeNum] = wrapper;
					newNodeNum++;
				} 
				
				//Calculate the hypothetical gCost of traveling to this neighbor from the current node
				var newCostToNeighbor = currentNode.gCost + weightGrid.GetGridDistance(currentNode.gridX,currentNode.gridY,endNode.gridX,endNode.gridY); //GetDistance_Euclidean(currentNode,wrapper);		
				//If its smaller than the neighbor's current gCost, then set its new parent to be the current node
				if (newCostToNeighbor < wrapper.gCost) {
					
					wrapper.gCost = newCostToNeighbor;
					//wrapper.hCost = GetDistance_Euclidean(wrapper,endNode);
					wrapper.parentNode = currentNode;
				}
			}
			
			//Once We're done, add all new nodes to open list
			for (var i=0;i<newNodeNum;i++) {
				ds_list_add(openList,newNodes[i]);
			}
			
			//Create log for this step.
			if(returnDebugTools) {

				//add current node to debug list for ease of printing and debugging later
				array_push(exploredNodes,currentNode);
				//Create Logs
				var log = print_pathfinding_step(currentNode,openList,exploredNodes)
				//show_debug_message(stepLog);
				array_push(stepLogs,log);
			}
		}
		
		show_debug_message("Pathfinding Failed!");

		//Create Return Struct
		var returnStruct;
		if (returnDebugTools) {
			returnStruct = new PathfindDebugger(false,weightGrid,path,startX,startY,endX,endY,startNode,endNode,openList,exploredNodes,stepLogs);
		} else {
			returnStruct = new PathfindResults(false,weightGrid,path,startX,startY,endX,endY);
		}
		
		//cleanup
		ds_list_destroy(openList);
		
		//return failure
		return returnStruct;
		
	}
}
	

//returns bool saying whether a node with the given grid position currently exists in the passed open set
function getNodeFromOpenList(openList,nodeArray) {
	
	//assumes that all items in open set list are Node Wrapper Structs
	for(var i=0;i<ds_list_size(openList);i++)	
	{
		var struct = openList[|i]
		if (struct.gridX == nodeArray[GridNode.gridX] and struct.gridY == nodeArray[GridNode.gridY]) {
			return struct
		}
	}
	
	return undefined;
	
}

function print_pathfinding_step(currentNode,openList,closedArr) {
	
	var str = "";
	
	//stringify General Info
	str = string("Step {0}",array_length(closedArr));
	
	//stringify current node 
	str = str + string("\nCurrent Node:\n {0}\n",currentNode);
	
	//stringify open List
	str = str + "\nOpen List:\n"
	for(var i=0;i<ds_list_size(openList);i++) {
		str = str + string(openList[|i]) +"\n"; 
	}
	
	//stringify closed list
	str = str + "\Closed List:\n"
	for(var i=0;i<array_length(closedArr);i++) {
		str = str + string(closedArr[i]) +"\n"; 
	}
	
	//print strig to console
	return string_repeat("=",60)+ "\n" + str + "\n";
	
}


function GetDistance_Euclidean(beginNode,goalNode) {
	
	// point_distance(beginNode.x,beginNode.y,goalNode.x,goalNode.y);
	var xDelta =abs( beginNode.x - goalNode.x);
	var yDelta = abs(beginNode.y - goalNode.y);
	return sqrt( (xDelta)^2 + (yDelta)^2);
}
