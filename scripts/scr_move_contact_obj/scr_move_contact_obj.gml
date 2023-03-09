///move_contact_object( x1, y1, x2, y2, step, accuracy, object / instance )
//  
//  This function will sweep a line with the instance running this script. If there is a collision
//  along this line, this script will return the (x,y) coordinate of this instance at the point of
//  collision. If no collision is encountered, the script will return (x2,y2,false).
//  
//  Tweak the 5th argument and the 6th argument until you reach satisfactory accuracy and
//  performance. I recommend setting the 5th argument to a third of a sprite's size and the 6th
//  argument to 1 as a starting point.
//  
//  Returns an arry1:
//      return[0] = x coordinate
//      return[1] = y coordinate
//      return[2] = whether a collision was found (boolean)
//      return[3] = x offset to find a collision
//      return[4] = y offset to find a collision (not necessarily the same as above)
//		return[5] = object instance collided
//  
//  
//  Copyright (c) 2016, Julian Adams
//  julian.adams@email.com
//  /u/JujuAdam
//  @jujuadams
//  
//  Permission is herey2 granted, free of charge, to any person obtaining a copy of this software
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
/// @arg returnOther
function move_contact_obj(x1,y1,x2,y2,step,accuracy,obj){
		
		//Default return arry1
		var arry1;
		arry1[0] = x1;		//x coord of running instance at collision 
		arry1[1] = y1;		//y coord of running instance at collision
		arry1[2] = false;	//whether collision was found
		arry1[3] = 0;		//x offset to find a collision
		arry1[4] = 0;		//y offset to find a collision (not necessarily the same as above)
		arry1[5] = noone;	//object instance collided with


		//if there is already a collision at the given position then return
		if ( place_meeting( x1, y1, obj ) ) {
		    arry1[2] = true;
		    return arry1;
		}

		//if the two vectors are the same, return
		if ( x1 == x2 ) and ( y1 == y2 ) return arry1;

		//delta Coords
		var dx = x2 - x1;
		var dy = y2 - y1;
		
		var iIncr = step / max( abs( dx ), abs( dy ) );
		//how uch of the sweep will check per step
		var jIncr = accuracy / max( abs( dx ), abs( dy ) );

		
		var resultX = x1;
		var resultY = y1;
		var i = 0;	//percentage along the distance
		
		//basically functions like lerp
		do {
			//cap i to 1
		    i = min( 1, i + iIncr );
			
			//Find the position of the lerp along sweep line
		    resultX = x1 + i * dx;
		    resultY = y1 + i * dy;
			
			//if there is a collision at that posiiton, find the exact position that the instance was at
			//based on the accuracy
		    if ( place_meeting( resultX, resultY, obj ) ) {
			
				//move back y2 one step before collision happens
		        resultX -= iIncr * dx;
		        resultY -= iIncr * dy;
				
				//The increments at which we will check for the precise colision position
		        var jx = jIncr * dx;
		        var jy = jIncr * dy;
				var otherInst = noone;
			
				//move creep along last step until we get the exact collision position
		        do {
		            resultX += jx;
		            resultY += jy;
					otherInst = instance_place(resultX,resultY,obj);
		        } until ( otherInst != noone);
				
				//move it back one accuracy increment before the collision happens
		        resultX -= jx;
		        resultY -= jy;
				
				//Return the collision Vector
		        arry1[0] = resultX;
		        arry1[1] = resultY;
		        arry1[2] = true;
		        arry1[3] = place_meeting( resultX + jx, resultY, obj ) * jx;
		        arry1[4] = place_meeting( resultX, resultY + jy, obj ) * jy;
				arry1[5] = otherInst;	//object instance collided with
				
		        return arry1;
				
		    }
    
		} until ( i >= 1 );

		arry1[0] = resultX;
		arry1[1] = resultY;
		return arry1;
}