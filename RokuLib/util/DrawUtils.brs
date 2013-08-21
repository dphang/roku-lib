'General drawing / UI utilities

'Draws all objects in the given array, in order, to a component
'@param array a roArray object
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlDrawAll(array as Object, component as Object) as Boolean
    max = array.Count() - 1
    success = true
    for i = 0 to max
        item = array[i]
        if item <> invalid and (item.visible = invalid or item.visible) and not item.Draw(component) then success = false
    end for
    return success
end function

function RlArraySetFocused(array as Object, index as Integer) as Void
    max = array.Count() - 1
    for i = 0 to max
        item = array[i]
        if item.SetFocused <> invalid
            if i = index
                item.SetFocused(true)
            else
                item.SetFocused(false)
            end if
        end if
    end for
end function