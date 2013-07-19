'Represents a focusable (whether by selection, or just highlighted) image object
'@param defaultBitmap the String or roBitmap to be displayed when not focused
'@param focusedBitmap the String or roBitmap to be displayed when focused
'@param x the x coordinate
'@param y the y coordinate
'@param width the width if known. Otherwise, the width will only be iniialized when the bitmap is first allocated.
'@param height the height if known. Otherwise, the height will only be iniialized when the bitmap is first allocated.
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