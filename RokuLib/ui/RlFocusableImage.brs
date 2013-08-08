'Represents a focusable (whether by selection, or just highlighted) image object
'@param defaultPath the path to the default bitmap
'@param focusedPath the path to the focused bitmap
'@param x the x coordinate
'@param y the y coordinate
'@param width the width if known. Otherwise, the width will only be iniialized when the bitmap is first allocated.
'@param height the height if known. Otherwise, the height will only be iniialized when the bitmap is first allocated.
function RlFocusableImage(defaultPath as String, focusedPath as String, x as Integer, y as Integer, width as Integer, height as Integer) as Object
    this = {
    	defaultPath: defaultPath
    	focusedPath: focusedPath
    	
        defaultImage: RlImage(defaultPath, x, y, width, height)
        focusedImage: RlImage(focusedPath, x, y, width, height)
        x: x
        y: y
        width: width
        height: height
        
        focused: false
        
        Draw: RlFocusableImage_Draw
        Copy: RlFocusableImage_Copy
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

function RlFocusableImage_Copy() as Object
	return RlFocusableImage(m.defaultPath, m.focusedPath, m.x, m.y, m.width, m.height)
end function