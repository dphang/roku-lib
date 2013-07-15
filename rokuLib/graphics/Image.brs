'Image represents an image in 2D space
'@param bitmap a roBitmap/roRegion object or a String specifying an image path
'@param x the x coordinate
'@param y the y coordinate
'@param width the width
'@param height the height
'@param alpha whether alpha is enabled
'@return an Image object
function Image(bitmap, x as Float, y as Float, width = invalid, height = invalid, alpha = false as Boolean) as Object
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
        
        Draw: Image_Draw
    }
    
    return this
end Function

'Draw this Image to the specified screen
'@param screen a roScreen object
'@return true if successful
Function Image_Draw(screen as Object) as Boolean
    if m.width <> m.bitmap.GetWidth() or m.height <> m.bitmap.GetHeight() 'Scaled draw
        scaleX = m.width / m.bitmap.GetWidth()
        scaleY = m.height / m.bitmap.GetHeight()
        return screen.DrawScaledObject(m.x, m.y, scaleX, scaleY, m.bitmap)
    else 'Normal draw
        return screen.DrawObject(m.x, m.y, m.bitmap)
    end if
End Function