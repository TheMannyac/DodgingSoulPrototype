

//Uses A* to find the best path between two points; returns whether it was successful or not.
function wg_find_path(weightGrid,path,startX,startY,endX,endY) {
	
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
		var closedGrid = array_create_ext(ds_grid_width(ds_myGrid),
			function(){array_create(ds_grid_height(ds_myGrid),noone)} );
		
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
			var i;
			for (i=0;i<ds_list_size(openList);i++) {
				if (openList[|i].fCost() <= currentNode.fCost()) {
					currentNode = openList[|i];
				}
			}
			
			//If Path Found...
			if (currentNode == endNode) {
				
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
				return true;
			}
			
			//Remove from the open and add to the closed set
			ds_list_delete(openList,currentNode);
			closedGrid[# currentNode.x,currentNode.y] = currentNode;
			
			//Find the Neighbors of the current node
			var neighbors = GetNeighbors(currentNode.gridX,currentNode.gridY);
			for (var i=0; i<array_length(neighbors);i++) 
			{
				//Get Array containing data about neighbor cell
				var neighbor = neighbors[i];
				var myGridX = neighbor[GridNode.gridX], myGridY = neighbor[GridNode.gridY];
				
				//Check if node wrapper struct for this struct already exists in the closed grid
				var wrapper = closedGrid[myGridX][myGridY]
				if (wrapper != noone){
					continue;
				}
				
				//Check if a node wrapper already exists for this node in the Open list, create one and add it to the list
				wrapper = getNodeFromOpenList(openList,neighbor);
				if (wrapper == noone) {
					
					wrapper = new NodeWrapper(neighbor);
					wrapper.hCost = point_distance(wrapper.x,wrapper.y,endNode.x,endNode.y);
					//since we haven't found it in either the closed grid or the 
					ds_list_add(openList,wrapper);
				} 
				
				//Calculate the hypothetical gCost of traveling to this neighbor from the current node
				var newCostToNeighbor = currentNode.gCost + point_distance(currentNode.x,currentNode.y,wrapper.x,wrapper.y);		
				
				//If its smaller than the neighbor's current gCost, then set its new parent to be the current node
				if (newCostToNeighbor < wrapper.gCost) {
					
					wrapper.gCost = newCostToNeighbor;
					wrapper.parentNode = currentNode;
				}
			}
		}
		
		//cleanup
		ds_list_destroy(openList);
		
		//return failure
		return false;
	}
}
	
	
function NodeWrapper(nodeArray,_parentNode=noone,walkable=true,_hCost=0,_gCost=infinity) constructor{
		
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
		
	parentNode = _parentNode
	hCost = _hCost;
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
		if (gridX != ndWrapper.gridY or gridY != ndWrapper) {
			return false
		}
			
		return true;
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
	
	return undefined
	
}