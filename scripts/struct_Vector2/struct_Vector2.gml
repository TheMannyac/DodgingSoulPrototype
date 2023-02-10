function Vector2(_x, _y) constructor
{
    x = _x;
    y = _y;

    static Add = function(_vec2)
    {
        x += _vec2.x;
        y += _vec2.y;
    }
}