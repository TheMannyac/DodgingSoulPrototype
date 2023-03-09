
	/// @param id1
	/// @param id2

	//determines the collision point of 2 instances
	//return 0 if no collision point
	//return 1 if collision point
	//you should call it on collision
	//it will work if the 2 instances overlap or if 2 egdes are touching (Better result)
	//so make sure you move them into contact with move contact solid.
	//sets the following instance variables for you to get the region 
	//(Eventually set to about a 1x1 region)
	//__left;
	//__top;
	//__right;
	//__bottom;
	//__x is the average (center of rect)
	//__y is the average (center of rect)
	
	//credit: icuurd12b42
	//hyperlink: https://www.gmlscripts.com/forums/viewtopic.php?id=1569
	
	// I made edits to this code to better fit my programming design language by splitting it into two separate functions



/*
function collision_point_IDs(id1,id2){
	
	if(argument_count > 2)
	{
	    var left,top,right,bottom;
	    left = argument[3];
	    top = argument[4];
	    right = argument[5];
	    bottom = argument[6];
	    if(right-left < 1)
	    if(bottom-top < 1)
	        return 1;
	    if(right-left > bottom-top)
	    {
	        if(collision_rectangle(left,top,(left+right)/2,bottom,argument[0],true,false))
	        if(collision_rectangle(left,top,(left+right)/2,bottom,argument[1],true,false))
	        {
	            __left = left;
	            __top = top;
	            __right = (left+right)/2;
	            __bottom = bottom;
	            __x = (__left+__right)/2;
	            __y = (__top+__bottom)/2;
	            if(CollisionPointIDs(argument[0],argument[1],argument[2],__left,__top,__right,__bottom))
	            {
	                if(__right-__left < 1)
	                if(__bottom-__top < 1)
	                return 1;
	            }
	        }
			
	        if(collision_rectangle((left+right)/2,top,right,bottom,argument[0],true,false))
	        if(collision_rectangle((left+right)/2,top,right,bottom,argument[1],true,false))
	        {
	            __left = (left+right)/2;
	            __top = top;
	            __right = right;
	            __bottom = bottom;
	            __x = (__left+__right)/2;
	            __y = (__top+__bottom)/2;
	            if( CollisionPointIDs(argument[0],argument[1],argument[2],__left,__top,__right,__bottom))
	            {
	                if(__right-__left < 1)
	                if(__bottom-__top < 1)
	                return 1;
	            }
	        }
			
	        return 0;
	    }
	    else
	    {
	        if(collision_rectangle(left,top,right,(top+bottom)/2,argument[0],true,false))
	        if(collision_rectangle(left,top,right,(top+bottom)/2,argument[1],true,false))
	        {
	            __left = left;
	            __top = top;
	            __right = right;
	            __bottom = (top+bottom)/2;
	            __x = (__left+__right)/2;
	            __y = (__top+__bottom)/2;
	            if( CollisionPointIDs(argument[0],argument[1],argument[2],__left,__top,__right,__bottom))
	            {
	                if(__right-__left < 1)
	                if(__bottom-__top < 1)
	                return 1;
	            }
	        }
	        if(collision_rectangle(left,(top+bottom)/2,right,bottom,argument[0],true,false))
	        if(collision_rectangle(left,(top+bottom)/2,right,bottom,argument[1],true,false))
	        {
	            __left = left;
	            __top = (top+bottom)/2;
	            __right = right;
	            __bottom = bottom;
	            __x = (__left+__right)/2;
	            __y = (__top+__bottom)/2;
	            if( CollisionPointIDs(argument[0],argument[1],argument[2],__left,__top,__right,__bottom))
	            {
	                if(__right-__left < 1)
	                if(__bottom-__top < 1)
	                return 1;
	            }
	        }
	        return 0;
	    }
	}
	else
	{
	    var xx,yy,xxx,yyy;
   
	    xx = max(argument[0].bbox_left-1,argument[1].bbox_left-1)
	    yy = max(argument[0].bbox_top-1,argument[1].bbox_top-1)
	    xxx = min(argument[0].bbox_right+1,argument[1].bbox_right+1)
	    yyy = min(argument[0].bbox_bottom+1,argument[1].bbox_bottom+1)
   
	    if(xx>xxx) return 0;
	    if(yy>yyy) return 0;
   
	    __left = xx;
	    __top = yy;
	    __right = xxx;
	    __bottom = yyy;
	    __x = (xx+xxx)/2
	    __y = (yy+yyy)/2
	    return CollisionPointIDs(argument[0],argument[1],1,__left,__top,__right,__bottom);
	}
}
*/
