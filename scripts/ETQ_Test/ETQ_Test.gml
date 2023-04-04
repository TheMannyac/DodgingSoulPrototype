

function ETQ_Test(_testType,_reference,_weight,_testedValue,_isWeightPreference,_isCondition,_isValidityTest,_comparisonType) constructor {
	
	//The kind of test that is being made.
	testType = _testType
	
	//Object Type or instance to compare against (self,obj_projectile, etc.)
	reference = _reference;
	static requireReference = true;
	
	//value to compare against
	_testedValue = _testType;
	
	weight = _weight;
	
	/*flags*/
	static isWeightPreference = _isWeightPreference;
	static isCondition = _isCondition;
	static isValidityTest = _isValidityTest;
	
	/*Methods*/
	static CalculateWeight = function(item) {
		
	}
	
	
	function RunTest(itemList) {
		
		
		if (isCondition) {
			
		}
		
		if (isWeightPreference) {
			
			var itemWeight = CalculateWeight
		}
	}
}

enum ETQ_TestType {
	Distance,
	Reachable
}

enum ETQ_ComparisionType {
	none,
	lessThan,
	greaterThan,
	equalTo,
	notEqualTo
}