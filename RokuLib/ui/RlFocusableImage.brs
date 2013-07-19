'Represents a focusable (whether by selection, or just highlighted) image object
function RlFocusableImage(defaultBitmap as Dynamic, focusedBitmap as Dynamic, x as Integer, y as Integer, width = invalid as Dynamic, height = invalid as Dynamic) as Object
    this = {
        defaultImage: RlImage(defaultBitmap, x, y, width, height)
        focusedImage: RlImage(focusedBitmap, x, y, width, height)
        x: x
        y: y
        width: width
        height: height
        
        focused: false
        
        Draw: RlFocusableImage_Draw
    }
    
    return this
end function

'Draws this RlFocusableImage object to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlFocusableImage_Draw(component as Object) as Boolean
    if m.focused
        image = m.focusedImage
    else
        image = m.defaultImage
    end if
    
    image.x = m.x
    image.y = m.y
    
    success = image.Draw(component)
    
    if success
        'Update the width and height of this object
        m.width = image.width
        m.height = image.height
    end if
    
    return success
end function