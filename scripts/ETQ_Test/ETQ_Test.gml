

function ETQ_Test(_filter,_scoring,_reference,_testDescrip="Test Template to build other tests off of") constructor {
	
	testDescrip = _testDescrip;
	
	if (is_instanceof(_filter,FilterSettings)) {
		FilterProps = _filter;
	} else {
		FilterProps = undefined;	
	}
	
	if (is_instanceof(_scoring,ScoringSettings)) {
		ScoringProps = _scoring;
	} else {
		ScoringProps = undefined;	
	}
	
	if (FilterProps == undefined && ScoringProps == undefined) {
		show_error("TEST HAS NEIETHER FILTER OR SCORING",true); 	
	}

	//Object Type or instance to compare against (self,obj_projectile, etc.)
	reference = _reference;
	
	static requireReference = true;
	
	/*Abstract Methdos*/
	static TestItem = function (itemStruct) {
		/*validate item data*/
		
		/* DO STUFF */
		
		//Return calculated result
		show_error("Test's 'TestItem' function not implemented into template",false);
		return undefined;
	}
	
	static FilterResult = function (value) {
		/*validate value*/
		
		/* check result using filter properties*/
		
		//Return bool determining if value passed or not
		show_error("Test's 'FilterItem' function not implemented into template",false);
		return false;
	}
	
	static ScoreResult = function (value) {
		/*validate value*/
		
		/* Assign score using Scoring Properties*/
		
		//Return normalized score value
		show_error("Test's 'ScoreItem' function not implemented into template",false);
		return false;
	}
	
}

function FilterSettings(_boolToMatch) constructor {
	boolToMatch = _boolToMatch;
	
}

function FilterSettings_Float(_boolToMatch,_filterType,_minVal=0,_bMinInclusive=false,_maxVal=1,_bMaxInclusive=false) : FilterSettings(_boolToMatch) constructor {
	filterType = _filterType;
	
	minVal = _minVal;
	bMinInclusive = _bMinInclusive;
	maxVal = _maxVal;
	bMaxInclusive = _bMaxInclusive;
	
	function checkVal(val){
		switch (filterType) {
			case ETQ_FilterType.maximum:
			return isBelowMax(val);
			
			case ETQ_FilterType.minimum:
			return isAboveMin(val);
			
			case ETQ_FilterType.range:
			return (isAboveMin(val) and isBelowMax(val)) == boolToMatch;
		}
	}
	
	function isAboveMin(val) {
		if (bMinInclusive)
			return minVal <= val;
		else
			return minVal < val
	}
	
	function isBelowMax(val) {
		if (bMaxInclusive)
			return maxVal >= val;
		else
			return maxVal > val
	}
}

enum ETQ_FilterType {
	minimum,
	maximum,
	range
}

function ScoringSettings(_scoreFactor,_refVal,_relativeNormal,_clampMin=0,_clampMax=0) constructor {
	scoreFactor = _scoreFactor;
	refVal = _refVal;
	relativeNormal =_relativeNormal;
	clampMax = _clampMax;
	clampMin = _clampMin;
	
	function scoreValue() {
		//nomralize value 
		
		//calculate score
		
		//return result.
	}
}

