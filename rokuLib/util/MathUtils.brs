'General math utilities and functions that aren't native to the Roku SDK
'Author: Daniel Phang

'Returns the ceiling of n, i.e. the smallest integer not less than n
'@param n a float
'@return the ceiling of n
Function ceil(n as Float) As Integer
    return -int(-n)
End Function

'Returns the floor of n, i.e. the largest integer not greater than n
'@param n a float
'@return the floor of n
Function floor(n as Float) As Integer
    return int(n)
End Function

'Returns the modulo between two integers
'@param a an integer
'@param n an integer
'@return the value of a mod n
Function modulo(a as Integer, n as Integer) as Integer
    return a - (n * int(a / n))
End Function