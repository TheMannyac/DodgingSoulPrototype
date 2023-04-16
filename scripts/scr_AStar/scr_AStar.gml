

//Uses A* to find the best path between two points; returns whether it was successful or not.
function wg_find_path(weightGrid,path,startX,startY,endX,endY) {
	
	show_debug_message("Begin A* Pathfinding from start point {0},{1} to end point {2},{3}",startX,startY,endX,endY);
	
	//validate
	if (not is_instanceof(weightGrid,WeightGrid)) {
		return false;
	}
	
	with (weightGrid) {
		//Find corresponding node for start posiiton
		var startNode = NodeFromWorldPoint(startX,startY);
		if (startNode == undefined) 
		{
			show_error(string("Given start position, [{0},{1}], is not within the grid area and cannot be assigned a node",startX,startY),false);
			return false	
		}
		//find node for end posiiton
		var endNode = NodeFromWorldPoint(endX,endY);
		if (endNode == undefined) 
		{
			show_error(string("Given end position, [{0},{1}], is not within the grid area and cannot be a assigned node",endX,endY),false);
			return false	
		}
		
		//Create Open and closed Set
		//var openList = ds_priority_create();
		var openList = ds_list_create();
		var closedGrid = array_create(ds_grid_width(ds_myGrid),
			array_create(ds_grid_height(ds_myGrid),undefined) );
			
		//Create an array for containing all the nodes that have been added to the closed list
		var closedArr = [];
		
		//Wrap Start and End Node (Assumes that both nodes are walkable)
		startNode = new NodeWrapper(startNode,noone,true,0,0);
		endNode = new NodeWrapper(endNode,noone,true,0,0);
		
		//Add first node to the open list
		//ds_priority_add(openList,startNode,0)
		ds_list_add(openList,startNode);
		
		//Loop while there are still nodes in the open set
		while ( not ds_list_empty(openList)) {
			
			//Node with the lowest fCost (the first time I only have one...)
			//var currentNode = ds_priorit_delete_max(openList);
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
				
				//cleanup
				ds_list_destroy(openList);
				//Return success
				show_debug_message("Pathfinding Success!! Path:");
				return true;
			}
			
			//Remove from the open and add to the closed set
			ds_list_delete(openList,nodePos);
			
			
			closedGrid [currentNode.gridX][currentNode.gridY] = currentNode;
			
			//add current node to debug list for ease of printing and debugging later; REMOVE THIS WHEN NOT NEEDED
			array_push(closedArr,currentNode);
			
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
				
				var myGridX = neighbor[GridNode.gridX], myGridY = neighbor[GridNode.gridY];
				
				//Check if node wrapper struct for this struct already exists in the closed grid
				var wrapper = closedGrid[myGridX][myGridY]
				if (wrapper != undefined){
					continue;
				}
				
				//Check if a node wrapper already exists for this node in the Open list, create one and add it to the list
				wrapper = getNodeFromOpenList(openList,neighbor);
				if (wrapper == undefined) {
					
					wrapper = new NodeWrapper(neighbor);
					wrapper.hCost = GetDistance_Euclidean(wrapper,endNode);
					//Add this to open list after we're done
					newNodes[newNodeNum] = wrapper;
					newNodeNum++;
				} 
				
				//Calculate the hypothetical gCost of traveling to this neighbor from the current node
				var newCostToNeighbor = currentNode.gCost + GetDistance_Euclidean(currentNode,wrapper);		
				
				//If its smaller than the neighbor's current gCost, then set its new parent to be the current node
				if (newCostToNeighbor < wrapper.gCost) {
					
					wrapper.gCost = newCostToNeighbor;
					wrapper.parentNode = currentNode;
				}
			}
			
			//Once We're done, add all new nodes to open list
			for (var i=0;i<newNodeNum;i++) {
				ds_list_add(openList,newNodes[i]);
			}
			
			//print this step
			show_debug_message(print_pathfinding_step(currentNode,openList,closedArr));
			show_debug_message("");
		}
		
		//cleanup
		ds_list_destroy(openList);
		
		//return failure
		show_debug_message("Pathfinding Failed!");
		return false;
	}
}
	
	
function NodeWrapper(nodeArray,_parentNode=undefined,walkable=true,_hCost=0,_gCost=infinity) constructor{
		
	//Node Weight
	weight = nodeArray[GridNode.weight];
	//Owning Weight Grid Struct
	parentWeightGrid = nodeArray[GridNode.owner];
	//World Position
	x = nodeArray[GridNode.xPos];
	y = nodeArray[GridNode.yPos];
	//Grid Location
	gridX = nodeArray[GridNode.gridX];
	gridY = nodeArray[GridNode.gridY];
	
	parentNode = _parentNode;
	//the estimate cost to get from this node to the target
	hCost = _hCost;
	//The cumulative cost to get here using the current parent path 
	gCost = _gCost;
		
	function fCost() {
		return (hCost + gCost)
	}
		
	//evaluates whether or not two node wrappers are equal
	function Equals(ndWrapper) {

		//Check if the passed struct is actually a 
		if (not is_instanceof(ndWrapper,NodeWrapper)) {
			return false;
		}			
		//check if they reference the same Weight Grid Struct;
		if (parentWeightGrid != ndWrapper.parentWeightGrid) {
			return false
		}
		//Check if they have the same grid position
		if (gridX != ndWrapper.gridY or gridY != ndWrapper.gridY) {
			return false
		}
			
		return true;
	}
	
	toString = function() {
		
		
		var myGridPos = string ("Grid Position: [{0},{1}]",gridX,gridY),
			myWorldPos = string ("Room Position: [{0},{1}]",x,y),
			myWeight = string("Weight: {0}", weight),
			myHCost = string("hCost: {0}", hCost),
			myGCost = string("gCost: {0}", gCost),
			myFCost = string("F-COST: {0}",fCost())
			
			var myParent;
			if (is_instanceof(parentNode,NodeWrapper)) {
				myParent = string ("Parent: [{0},{1}]",parentNode.gridX,parentNode.gridY);
			} else {
				myParent = string("Parent: UNDEFINED");
			}
			

		return myGridPos +"\t" + myWorldPos +"\t"+ myParent +"\t"+ myWeight +"\t"+ myHCost +"\t"+ myGCost+ "\t\t"+ myFCost;
		
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
	return abs((goalNode.x - beginNode.x)^2 + (beginNode.y - goalNode.y)^2);
}