/// @description Pathfinding Debug tools

//Draw Path 
if (path_exists(myPath)) {
	draw_path(myPath,x,y,true);
}

//Draw Debug
if (is_instanceof(pathResults,PathfindResults))  {
	pathResults.DrawTouchedNodes();
}

draw_self()