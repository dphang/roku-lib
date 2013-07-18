'Represents a focusable (whether by selection, or just highlighted) element
function RlFocusable(defaultBitmap as Dynamic, focusedBitmap as Dynamic, x as Integer, y as Integer, width = invalid as Dynamic, height = invalid as Dynamic) as Object
    this = {
        defaultImage: RlImage(defaultBitmap, x, y, width, height)
        focusedImage: RlImage(focusedBitmap, x, y, width, height)
        x: x
        y: y
        width: width
        height: height
        
        focused: false
        
        Draw: RlFocusable_Draw
    }
    
    return this
end function

'Draws this RlFocusable object to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlFocusable_Draw(component as Object) as Boolean
    if m.focused
        image = m.focusedImage
    else
        image = m.defaultImage
    end if
    
    success = image.Draw(component)
    
    if success
        'Update the width and height of this object
        m.width = image.width
        m.height = image.height
    end if
    
    return success
end function