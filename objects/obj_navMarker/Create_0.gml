/// @description Tell agent to move here

//on create set the target of the 
with (obj_soul) {
	Agent_Change_State(eSoulAIState.DODGE);
	
	Agent_Update_Target_Point(other.x,other.y);
}
/*
//probably not efficient
for (var i = 0; i < instance_number(obj_soul); ++i;)
{
    var agent = instance_find(obj_soul,i);
	
	with 
	
}
*/