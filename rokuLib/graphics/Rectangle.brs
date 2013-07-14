'Rectangle represents a rectangle in 2D space
'@param x 
'@param y
'@param width
'@param height
'@param rgba a 32-bit value in the form &hXXXXXXXX specifying the rgb color and alpha
'@return the Rectangle object
Function Rectangle(x as Float, y as Float, width as Float, height as Float, rgba as Integer) as Object
    this = {
        type: "Rectangle"
        x: x
        y: y
        width: width
        height: height
        rgba: rgba
        
        Draw: Rectangle_Draw
    }
    
    return this
End Function

'Draws this Rectangle to the specified screen
'@param screen a roScreen object
'@return true if successful
Function Rectangle_Draw(screen) As Boolean
    return screen.DrawRect(m.x, m.y, m.width, m.height, m.rgba)
End Function
