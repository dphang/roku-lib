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

'Inserts a value in an array at the specified index.
function ArrayInsert(array as Object, index as Integer, value as Dynamic) as Object
    temp = []
    for i = 0 to index - 1
        temp.Push(array[i])
    end for
    
    temp.Push(value)
    
    max = array.Count() - 1
    for i = index to max
        temp.Push(array[i])
    end for

    return temp
end function

'Splits an array into several smaller arrays.
Function ArraySplit(array as Object, count as Integer) as Object
    o = []
    if array <> invalid and count <> invalid
        n = 0
        o[n] = []
        max = array.Count() - 1
        for i = 0 to max
            if o[n].Count() >= count
                n = n + 1
                o[n] = []
            end if
            o[n].Push(array[i])
        end for
    end if
    
    return o
End Function