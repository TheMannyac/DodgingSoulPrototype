/// @description Pathfinding Debug tools

draw_self()

//Draw Debug

if (is_instanceof(pathResults,PathfindResults))  {
	
	with (pathResults) {
		//Draw all touched nodes 
		draw_set_alpha(.5);
		DrawTouchedNodes();
		
		draw_set_alpha(.8);
		//draw point on Start node position
		var rad = weightGrid.cellDiameter/4;
		draw_circle_color(startNode.x,startNode.y,rad,c_fuchsia,c_fuchsia,false);
		draw_circle_color(endNode.x,endNode.y,rad,c_aqua,c_aqua,false);
		
		draw_set_alpha(1);
	}
}


//Draw Path 
if (path_exists(myPath)) {
	draw_path(myPath,x,y,true);
}


