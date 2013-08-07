'Returns a copy of the specified array
function ArrayCopy(array as Object) as Object
    newArray = []
    max = array.Count() - 1
    for i = 0 to max
        newArray[i] = array[i]
    end for
   
   return newArray
end function

'Swaps two elements' positions in an array
function ArraySwap(array as Object, i as Integer, j as Integer) as Void
    temp = array[i]
    array[i] = array[j] 
    array[j] = temp
end function