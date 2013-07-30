'RlImage represents an image in 2D space. Lazy allocation of bitmap to reduce memory use (only allocated when first drawn).
'@param path a roBitmap/roRegion object or a String specifying an image path
'@param x the x coordinate
'@param y the y coordinate
'@param width the width
'@param height the height
'@return an Image object
function RlImage(path as String, x = invalid as Dynamic, y = invalid as Dynamic, width = invalid as Dynamic, height = invalid as Dynamic) as Object
    this = {
        type: "RlImage"
        path: path
        bitmapManager: m.bitmapManager
        x: x
        y: y
        width: width
        height: height
        
        Draw: RlImage_Draw
        Deallocate: RlImage_Deallocate
    }
    
    return this
end function

'Draws this RlImage to the specified component.
'@param component a roScreen/roBitmap/roRegion object
'@param conservative if set to true, the associated roBitmap is immediately deallocated after drawing, if possible
'@return true if successful
function RlImage_Draw(component as Object, conservative = false as Boolean) as Boolean
    'Lazy allocation
    bitmap = m.bitmapManager.GetBitmap(m.path)
    
    'Draw image
    if m.width <> bitmap.GetWidth() or m.height <> bitmap.GetHeight() 'Scaled draw
        scaleX = m.width / bitmap.GetWidth()
        scaleY = m.height / bitmap.GetHeight()
        success = component.DrawScaledObject(m.x, m.y, scaleX, scaleY, bitmap)
    else 'Normal draw
        success = component.DrawObject(m.x, m.y, bitmap)
    end if
    
    'Deallocate if on conservative mode
    if conservative
        m.Deallocate()
    end if
    
    bitmap = invalid
    
    return success
end function

'Deletes the reference to the associated roBitmap (may also deallocate other images referencing the same bitmap)
function RlImage_Deallocate() as Void
    m.bitmapManager.ClearBitmap(m.path)
end function