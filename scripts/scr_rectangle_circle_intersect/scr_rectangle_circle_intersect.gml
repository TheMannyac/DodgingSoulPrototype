/*CREDIT  YelloAfterlife: 
		"Simple intersection checking between 
		rotated rectangles and circles/points"

	https://yal.cc/rot-rect-vs-circle-intersection/
*/

function rectangle_circle_intersect(rectX,rectY,rectWidth,rectHeight,
	circleX,circleY,circleRadius) {
	
	var deltaX = circleX - max(rectX, min(circleX, rectX + rectWidth));
	var deltaY = circleY - max(rectY, min(circleY, rectY + rectHeight));
	return (deltaX * deltaX + deltaY * deltaY) < (circleRadius * circleRadius);
}
