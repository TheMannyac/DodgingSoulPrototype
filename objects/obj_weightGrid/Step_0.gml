/// @description Weight brushing

/*
	Left Mouse: increases weight by strength each frame
	Right Mouse: decreases weight by strength each frame
	Ensures that both are canceled out if both inputs are held
*/
var wbMod = mouse_check_button(mb_left) - mouse_check_button(mb_right);

if (abs(wbMod) > 0) {
	var cursorX = mouse_x, cursorY = mouse_y;
	//get node that we're gonna paint
	var nd = global.weightGrid.NodeFromWorldPoint(cursorX,cursorY);

	if (not is_undefined(nd)) {
		//calculate the differance
		var weightDiff = nd[GridNode.weight]+( wbStrength * wbMod * global.delta_multiplier);
		weightDiff = clamp(weightDiff,-1,1);
		//add it to the list
		ds_grid_set(global.weightGrid.ds_myGrid,nd[GridNode.gridX],nd[GridNode.gridY],weightDiff);
	}
}
