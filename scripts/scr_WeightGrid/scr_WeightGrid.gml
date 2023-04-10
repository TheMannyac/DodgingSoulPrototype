


function WeightGrid(_xPos,_yPos,_worldWidth,_worldHeight,_cellSize,_defaultWeight=0) constructor{
	
	//XY position of top left corner of grid; the origin
	x = _xPos;
	y = _yPos;
	
	worldWidth = _worldWidth;
	worldHeight = _worldHeight;
	
	//width/height of each cell in world units 
	cellDiameter = _cellSize;
	
	var gridSizeX = round(worldWidth/cellDiameter);
	var gridSizeY = round(worldHeight/cellDiameter);
	
	ds_myGrid = ds_grid_create(gridSizeX,gridSizeY);
	
	//Set all grid cells to default value
	ds_grid_set_region(ds_myGrid,0,0,gridSizeX-1,gridSizeY-1,_defaultWeight);
		
	//Uses A* to find the best path between two points; returns whether it was successful or not.
	function FindPath(path,startX,startY,endX,endY) {
		
		//Find corresponding node for start posiiton
		var startNode = NodeFromWorldPoint(startX,startY);
		if (startNode == undefined) {
			show_error(string("Given start position, [{0},{1}], is not within the grid area and cannot be assigned a node",startX,startY),false);
			return false	
		}
		//find node for end posiiton
		var endNode = NodeFromWorldPoint(endX,endY);
		if (endNode == undefined) {
			show_error(string("Given end position, [{0},{1}], is not within the grid area and cannot be a assigned node",endX,endY),false);
			return false	
		}
		
		//Create Open and closed Set, remember to destroy these later.
		var openSet = ds_list_create();
		var closedSet = ds_list_create();
		var neighborlist = ds_list_create();
		
		//Add first node to the open list
		ds_list_add(openSet,startNode)
		
		//Loop while there are still nodes in the open set
		while ( not ds_list_empty(openSet)) {
			
			//Node with the lowest fCost (the first time I only have one...)
			var currentNode = openSet[|0];
			
			 //Because the data structure is not sorted we have to look through it all..
			 var itr;
			 for (itr=0;itr<ds_list_size(openSet);itr++) {
				 
				 if (openSet[|itr] <= currentNode[GridNode.weight] ) {
					currentNode = openSet[|itr];
				 }
			 }
			 
			 //Remove from the open and add to the closed
			 ds_list_delete(openSet,itr);
			 ds_list_add(closedSet,currentNode);
			 
			//If Path Found...
			if (currentNode[GridNode.gridX] == endNode[GridNode.gridX] and currentNode[GridNode.gridY] == endNode[GridNode.gridY]) {
				
				return true;
			}
			
			//Find the Neighbors of the current node
			ds_list_clear(neighborlist);
			GetNeighbors(currentNode[GridNode.gridX],currentNode[GridNode.gridY],neighborlist);
			
			for (itr=0; itr<ds_list_size(neighborlist);itr++) {
				
				var nb = neighborlist[|itr];
				
				//
				
				//validate neighbor node
				if (ds_list_find_index(nb) == -1) {
				
				}
			}
		}
		
		//cleanup
		ds_list_destroy(openSet);
		ds_list_destroy(closedSet)
		ds_list_destroy(neighborlist);
	}
	
	function NodeFromWorldPoint(pointX,pointY) {
		
		//Return failure if the given point is not within grid area 
		var percentX = (pointX + gridCenterPoint_x());
		if ( percentX < 0 or percentX > 1) return undefined;
		var percentY = (pointY + gridCenterPoint_y());
		if ( percentY < 0 or percentY > 1) return undefined;
		
		//percentX = clamp(percentX,0,1);
		//percentY = clamp(percentY,0,1);
		
		//Use the percent to find the grid posiiton of the node
		var gridSizeX = ds_grid_width(ds_myGrid), gridSizeY = ds_grid_height(ds_myGrid);
		var gridPosX = round((gridSizeX - 1) * percentX);
		var gridPosY = round((gridSizeY - 1) * percentY);
			
		return GetNode(gridPosX,gridPosY);
	}
	
	//returns array containing information about node at given x and y position on grid
	function GetNode(xx,yy) {
		
		var nodeArray = array_create(GridNode.len);
		
		//Get the Weight
		nodeArray[GridNode.weight] = ds_grid_get(ds_myGrid,xx,yy);
		
		//Return parent WeightGrid Struct for future retrieval purposes
		nodeArray[GridNode.parentID] = yy * cellDiameter + (cellDiameter/2);
		
		//Calculate world position of node; should be in center of cell instead of top left corner
		nodeArray[GridNode.xPos] = xx * cellDiameter + (cellDiameter/2);
		nodeArray[GridNode.xPos] = yy * cellDiameter + (cellDiameter/2);

		//Return node's grid position for future retrieval purposes
		nodeArray[GridNode.gridX] = xx * cellDiameter + (cellDiameter/2);
		nodeArray[GridNode.gridY] = yy * cellDiameter + (cellDiameter/2);
		
		return nodeArray;
	}
	
	function GetNeighbors(gridX,gridY,returnList) {
		
		for (var xx=-1; xx<=1; xx++) {
			for (var yy=-1; yy<=1; yy++) {
				
				//don't include the current node.
				if (xx==0 and yy==0) continue;
				
				var gridSizeX = ds_grid_width(ds_myGrid);
				var gridSizeY = ds_grid_height(ds_myGrid);
				var checkX = gridX + xx;
				var checkY = gridY + xx;
				
				if (checkX>=0 and checkX < gridSizeX and checkY>=0 and checkY < gridSizeY)
				{
					ds_list_add(returnList,GetNode(checkX,checkY));
				}
				
			}
		}
		return returnList;
	}
	
	
	function GetDistance(x1,y1,x2,y2) {
		var distX = abs(x1-x2);
		var distY = abs(y1-y2);
		
		if (distX > distY) 
			return 14 * distY + 10 * (distX - distY);
		else 
			return 14 * distX + 10 * (distY - distX);
		
	}
	
	//Finds the world coordinates for the center of the grid
	function gridCenterPoint_x() {return x + (worldWidth/2);}
	function gridCenterPoint_y() {return y + (worldHeight/2);}
	
	//Set the X position of the Grid and all its paths
	function SetX(newX) {
		x = newX;
	}
	
	//Set the X position of the Grid and all its paths
	function SetY(newY) {
		y = newY;
	}
	
	function DrawDebug() {
		
	}
	
	function Cleanup() {
		ds_grid_destroy(ds_myGrid);
	}
	
}

enum GridNode {
	parentID,
	weight,
	xPos,
	yPos,
	gridX,
	gridY,
	len
}