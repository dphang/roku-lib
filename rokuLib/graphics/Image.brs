'rlImage represents an image in 2D space
'@param bitmap a roBitmap/roRegion object or a String specifying an image path
'@param x the x coordinate
'@param y the y coordinate
'@param width the width
'@param height the height
'@param alpha whether alpha is enabled
'@return an Image object
function rlImage(bitmap as Dynamic, x as Float, y as Float, width = invalid, height = invalid, alpha = false as Boolean) as Object
    if type(bitmap) = "String" 'If bitmap is a path, initialize a new bitmap. Otherwise bitmap should be a roBitmap or roRegion object
        bitmap = CreateObject("roBitmap", bitmap)
    end if

    if width = invalid then width = bitmap.GetWidth()
    if height = invalid then height = bitmap.GetHeight()
    
    this = {
        type: "Image"
        bitmap: bitmap
        x: x
        y: y
        width: width
        height: height
        alpha: alpha
        
        Draw: rlImage_Draw
    }
    
    return this
end function

'Draw this Image to the specified component
'@param component a roScreen/roBitmap/roRegion component
'@return true if successful
function rlImage_Draw(component as Object) as Boolean
    if m.width <> m.bitmap.GetWidth() or m.height <> m.bitmap.GetHeight() 'Scaled draw
        scaleX = m.width / m.bitmap.GetWidth()
        scaleY = m.height / m.bitmap.GetHeight()
        return component.DrawScaledObject(m.x, m.y, scaleX, scaleY, m.bitmap)
    else 'Normal draw
        return component.DrawObject(m.x, m.y, m.bitmap)
    end if
end function