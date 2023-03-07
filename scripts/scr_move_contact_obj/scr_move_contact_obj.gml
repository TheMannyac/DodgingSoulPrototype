///scr_move_contact_object( x1, y1, x2, y2, step, accuracy, object / instance )
//  
//  This function will sweep a line with the instance running this script. If there is a collision
//  along this line, this script will return the (x,y) coordinate of this instance at the point of
//  collision. If no collision is encountered, the script will return (x2,y2,false).
//  
//  Tweak the 5th argument and the 6th argument until you reach satisfactory accuracy and
//  performance. I recommend setting the 5th argument to a third of a sprite's size and the 6th
//  argument to 1 as a starting point.
//  
//  Returns an array:
//      return[0] = x coordinate
//      return[1] = y coordinate
//      return[2] = whether a collision was found (boolean)
//      return[3] = x offset to find a collision
//      return[4] = y offset to find a collision (not necessarily the same as above)
//  
//  
//  Copyright (c) 2016, Julian Adams
//  julian.adams@email.com
//  /u/JujuAdam
//  @jujuadams
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//  and associated documentation files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

/// @description collision_line_width
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg step
/// @arg accuracy
/// @arg obj
function move_contact_obj(){
		var ax = argument0;
		var ay = argument1;
		var bx = argument2;
		var by = argument3;
		var step = argument4;
		var accuracy = argument5;
		var obj = argument6;
		
		//Default return array
		var array;
		array[0] = ax;		//x coord
		array[1] = ay;		//y coord
		array[2] = false;	//whether collision was found
		array[3] = 0;		//x offset to find a collision
		array[4] = 0;		//y offset to find a collision (not necessarily the same as above)


		//if there is already a collision at the given position then return
		if ( place_meeting( ax, ay, obj ) ) {
		    array[2] = true;
		    return array;
		}

		//if the two vectors are the same, return
		if ( ax == bx ) and ( ay == by ) return array;

		//delta Coords
		var dx = bx - ax;
		var dy = by - ay;
		
		var iIncr = step / max( abs( dx ), abs( dy ) );
		//how uch of the sweep will check per step
		var jIncr = accuracy / max( abs( dx ), abs( dy ) );

		
		var resultX = ax;
		var resultY = ay;
		var i = 0;	//percentage along the distance
		
		//basically functions like lerp
		do {
			//cap i to 1
		    i = min( 1, i + iIncr );
			//Find the position of the lerp 
		    resultX = ax + i * dx;
		    resultY = ay + i * dy;
    
		    if ( place_meeting( resultX, resultY, obj ) ) {
        
		        resultX -= iIncr * dx;
		        resultY -= iIncr * dy;
        
		        var jx = jIncr * dx;
		        var jy = jIncr * dy;
        
		        do {
		            resultX += jx;
		            resultY += jy;
		        } until ( place_meeting( resultX, resultY, obj ) );
        
		        resultX -= jx;
		        resultY -= jy;
        
		        array[0] = resultX;
		        array[1] = resultY;
		        array[2] = true;
		        array[3] = place_meeting( resultX + jx, resultY, obj ) * jx;
		        array[4] = place_meeting( resultX, resultY + jy, obj ) * jy;
				
        
		        return array;
        
		    }
    
		} until ( i >= 1 );

		array[0] = resultX;
		array[1] = resultY;
		return array;
}