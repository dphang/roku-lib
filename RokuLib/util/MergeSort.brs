'Sorts an array using a merge sort
'@param array the array to sort
'@param the comparator to use
function RlMergeSort (array as Object, comparator = invalid as Dynamic)
    if comparator = invalid then comparator = RlMergeSort_DefaultComparator
    
    length = array.Count()
    if length > 1
        left = []
        right = []
        
        middle = int(length / 2)
        
        for i = 0 to middle - 1
            left[i] = array[i]
        end for
        
        for i = middle to length - 1
            right[i - middle] = array[i]
        end for
        
        RlMergeSort(left, comparator)
        RlMergeSort(right, comparator)
        
        i = 0
        j = 0
        k = 0
        
        length1 = left.Count()
        length2 = right.Count()
        
        'Merge arrays
        while length1 <> j and length2 <> k
            if comparator(left[j], right[k]) < 0
                array[i] = left[j]
                i = i + 1
                j = j + 1
            else
                array[i] = right[k]
                i = i + 1
                k = k + 1
            end if
        end while
        
        while length1 <> j
            array[i] = left[j]
            i = i + 1
            j = j + 1
        end while
        
        while length2 <> k
            array[i] = right[k]
            i = i + 1
            k = k + 1
        end while
    end if
    
end function

'Default comparator for two values in an array
function RlMergeSort_DefaultComparator (a as Dynamic, b as Dynamic)
    if a < b
        return -1
    else
        return 1
    end if
end function