/* Currently unused. Structs tend to have a lot of overhead
for accessing data and don't serialize as easily as arrays,
but they have better readability and are easier to pass around
so I might use them at some point... maybe.

*/


function vector(_x,_y) constructor{
	x = _x;
	y = _y;
	
	function set(_x,_y) {
		x = _x;
		y = _y;
	}
	function add(_vector) {
		x += _vector.x;
		y += _vector.y;
	}
	function subtract(_vector) {
		x -= _vector.x;
		y -= _vector.y;
	}
	function multiply (_scalar) {
		x *= _scalar;
		y *= _scalar;
	}
	function divide (_scalar) {
		x /= _scalar;
		y /= _scalar;
	}
}