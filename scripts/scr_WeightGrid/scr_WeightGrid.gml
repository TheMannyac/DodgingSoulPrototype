


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
		nodeArray[GridNode.owner] = yy * cellDiameter + (cellDiameter/2);
		
		//Calculate world position of node; should be in center of cell instead of top left corner
		nodeArray[GridNode.xPos] = xx * cellDiameter + (cellDiameter/2);
		nodeArray[GridNode.xPos] = yy * cellDiameter + (cellDiameter/2);

		//Return node's grid position for future retrieval purposes
		nodeArray[GridNode.gridX] = xx * cellDiameter + (cellDiameter/2);
		nodeArray[GridNode.gridY] = yy * cellDiameter + (cellDiameter/2);
		
		return nodeArray;
	}
	
	//Return array of neighbor node arrays from the given grid position
	function GetNeighbors(gridX,gridY) {
		
		//there can never be more than 8 neighbors to any one node so preset it to avoid resizing
		var arr = array_create(8,-1);
		//number of neighbors that have been added to the array
		var i = 0;	
		
		//Iterate through all the neighbor cells at all cardinal directions on grid
		for (var xx=-1; xx<=1; xx++) {
			for (var yy=-1; yy<=1; yy++) {
				
				//don't include the current node at given coords.
				if (xx==0 and yy==0) continue;
				
				var gridSizeX = ds_grid_width(ds_myGrid);
				var gridSizeY = ds_grid_height(ds_myGrid);
				var checkX = gridX + xx;
				var checkY = gridY + xx;
				
				//ensure that the coords aren't out of bounds
				if (checkX>=0 and checkX < gridSizeX and checkY>=0 and checkY < gridSizeY)
				{
					arr[i] = GetNode(checkX,checkY);
					i++;
				}
			}
		}
		
		//Resize array to only contain valid array values
		array_resize(arr,i+1)
		return arr;
	}
	
	
	function GetGridDistance(x1,y1,x2,y2) {
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
	owner,
	weight,
	xPos,
	yPos,
	gridX,
	gridY,
	len
}