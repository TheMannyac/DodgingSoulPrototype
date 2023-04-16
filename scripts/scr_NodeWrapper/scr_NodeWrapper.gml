

function NodeWrapper(nodeArray,_parentNode=undefined,walkable=true,_hCost=0,_gCost=infinity) constructor{
		
	//Node Weight
	weight = nodeArray[GridNode.weight];
	//World Position
	x = nodeArray[GridNode.xPos];
	y = nodeArray[GridNode.yPos];
	//Grid Location
	gridX = nodeArray[GridNode.gridX];
	gridY = nodeArray[GridNode.gridY];
	
	parentNode = _parentNode;
	//the estimate cost to get from this node to the target
	hCost = _hCost;
	//The cumulative cost to get here using the current parent path 
	gCost = _gCost;
		
	function fCost() {
		return (hCost + gCost)
	}
		
	//evaluates whether or not two node wrappers are equal
	function Equals(ndWrapper) {

		//Check if the passed struct is actually a 
		if (not is_instanceof(ndWrapper,NodeWrapper)) {
			return false;
		}			
		//check if they reference the same Weight Grid Struct;
		if (parentWeightGrid != ndWrapper.parentWeightGrid) {
			return false
		}
		//Check if they have the same grid position
		if (gridX != ndWrapper.gridY or gridY != ndWrapper.gridY) {
			return false
		}
			
		return true;
	}
	
	toString = function() {
		
		var myGridPos = string ("Grid Position: [{0},{1}]",gridX,gridY),
			myWorldPos = string ("Room Position: [{0},{1}]",x,y),
			myWeight = string("Weight: {0}", weight),
			myHCost = string("hCost: {0}", hCost),
			myGCost = string("gCost: {0}", gCost),
			myFCost = string("F-COST: {0}",fCost())
			
			var myParent;
			if (is_instanceof(parentNode,NodeWrapper)) {
				myParent = string ("Parent: [{0},{1}]",parentNode.gridX,parentNode.gridY);
			} else {
				myParent = string("Parent: UNDEFINED");
			}
			

		return myGridPos +"\t" + myWorldPos +"\t"+ myParent +"\t"+ myWeight +"\t"+ myHCost +"\t"+ myGCost+ "\t\t"+ myFCost;
		
	}
}