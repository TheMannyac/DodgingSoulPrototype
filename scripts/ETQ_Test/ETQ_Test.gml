

function ETQ_Test(_filter,_scoring,_reference) constructor {
	
	
	
	if (is_instanceof(_filter,Filter)) {
		FilterProps = _filter;
	} else {
		FilterProps = undefined;	
	}
	
	if (is_instanceof(_scoring,Scoring)) {
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
	
	/*Methods*/
	static RunTest = function (items) {
		//Try to Fail Early
		
	}
	
	static 
	
}

function Filter(_boolToMatch) constructor {
	boolToMatch = _boolToMatch;
	
	static 
}

function FilterFloat(_boolToMatch,_filterType,_minVal=0,_maxVal=1) : Filter(_boolToMatch) constructor {
	filterType = _filterType;
	
	minVal = _minVal;
	maxVal = _maxVal;
}

enum ETQ_FilterType {
	minimum,
	maximum,
	range
}

function Scoring(_scoreFactor,_referenceValue,_relativeNormal,_clampMin=0,_clampMax=0) constructor {
	
}

