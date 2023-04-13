


function WeightGrid(_xPos,_yPos,_boxWidth,_boxHeight,_cellSize,_defaultWeight=0) constructor{
	
	//XY position of top left corner of grid; the origin
	x = _xPos;
	y = _yPos;
	
	boxWidth = _boxWidth;
	boxHeight = _boxHeight;
	
	//width/height of each cell in pixels 
	cellDiameter = _cellSize;
	
	var gridSizeX = round(boxWidth/cellDiameter);
	var gridSizeY = round(boxHeight/cellDiameter);
	
	ds_myGrid = ds_grid_create(gridSizeX,gridSizeY);
	
	//Set all grid cells to default value
	ds_grid_set_region(ds_myGrid,0,0,gridSizeX-1,gridSizeY-1,_defaultWeight);
		
		
	function NodeFromWorldPoint(pointX,pointY) {
		
		//Return failure if the given point is not within grid area 
		var percentX = (pointX + gridCenterPoint_x()) / boxWidth;
		if ( percentX < 0 or percentX > 1) return undefined;
		
		var percentY = (pointY + gridCenterPoint_y()) / boxHeight;
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
	function gridCenterPoint_x() {return x + (boxWidth/2);}
	function gridCenterPoint_y() {return y + (boxHeight/2);}
	
	//Set the X position of the Grid and all its paths
	function SetX(newX) {
		x = newX;
	}
	
	//Set the X position of the Grid and all its paths
	function SetY(newY) {
		y = newY;
	}
	
	function DrawGrid() {
		
		var grid_w = ds_grid_width(ds_myGrid);
		var grid_h = ds_grid_height(ds_myGrid);
		//y coord of the bottom of the grid box
		//var right = x + boxWidth
		//var bottom = y + boxHeight
		var c1,c2;
		
		//Line Color and width
		c1 = c_ltgray;
		var lineWidth = 1;
		
		//Draw vertical Lines
		for (var i=0;i<grid_w+1;i++) {
			
			var xPos = x+i*cellDiameter;
			draw_line_fast(xPos,y,xPos,y+boxHeight,lineWidth,c1);
		}
		
		//Draw vertical Lines
		for (var i=0;i<grid_h+1;i++) {
			
			var yPos = y+i*cellDiameter;
			draw_line_fast(x,yPos,x+boxWidth,yPos,lineWidth,c1);
		}
		
		//Draw Colored Cells
		c1 = c_lime;
		c2 = c_red;
		var margin = (cellDiameter * .80)/2; 
		
		for (var xx=0;xx<grid_w;xx++) {
			
			var x1 = x + (xx*cellDiameter) //+ margin;
			var x2 = x1 + cellDiameter //- margin;
			
			for (var yy =0; yy<grid_h;yy++) {
				
				var y1 = y + (yy * cellDiameter) //+ margin;
				var y2 = y1 + cellDiameter //- margin;
				
				//calculate fill color percent based on normalized cell weight 
				var weight = ds_grid_get(ds_myGrid,xx,yy);
				var colorPercent = (weight/2 )+.5;
				draw_set_color(merge_color(c1,c2,colorPercent))
				
				//Determine fill alpha by how close the weight is to the 
				
				draw_set_alpha(abs(weight));
				
				//draw rectangle
				draw_rectangle(x1,y1,x2,y2,false);
			}
		}
		
		//reset Color and alpha
		draw_set_color(c_white)
		draw_set_alpha(1);
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