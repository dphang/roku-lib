'Image represents an image in 2D space
function Image(bitmap, x as Float, y as Float, width = invalid as Float, height = invalid as Float, alpha = false as Boolean) as Object
    if width = invalid then width = bitmap.GetWidth()
    if height = invalid then height = bitmap.GetHeight()
    
    this = {
        type; "Image"
        x: x
        y: y
        width: width
        height: height
        alpha: alpha
        
        Draw: Image_Draw
    }
    
    return this
end Function

'Draw this image to the specified screen
Function Image_Draw(screen as Object) as Boolean
    if m.width <> bitmap.GetWidth() or m.height <> bitmap.GetHeight() 'Scaled draw
        scaleX = m.width / bitmap.GetWidth()
        scaleY = m.height / bitmap.GetHeight()
        return screen.DrawScaledObject(x, y, scaleX, scaleY, m.bitmap)
    else 'Normal draw
        return screen.DrawObject(x, y, m.bitmap)
    end if
End Function
