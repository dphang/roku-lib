'General math utilities and functions that aren't native to the Roku SDK
'Author: Daniel Phang

'Returns the ceiling of n, i.e. the smallest integer not less than n
'@param n a float
'@return the ceiling of n
function RlCeil(n as Float) as Integer
    return -int(-n)
end function

'Returns the floor of n, i.e. the largest integer not greater than n
'@param n a float
'@return the floor of n
function RlFloor(n as Float) as Integer
    return int(n)
end function

'Returns the modulo between two integers
'@param a an integer
'@param n an integer
'@return the value of a mod n
function RlModulo(a as Integer, n as Integer) as Integer
    return a - (n * int(a / n))
end function

'@param x the first number
'@param y the second number
'@return the maximum between x and y
function RlMax(x as Float, y as Float) as Float
    if x > y
        return x
    else
        return y
    end if
end function

'@param x the first number
'@param y the second number
'@return the maximum between x and y
function RlMin(x as Float, y as Float) as Float
    if x > y
        return y
    else
        return x
    end if
end function