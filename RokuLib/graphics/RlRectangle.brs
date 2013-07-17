'RlRectangle represents a RlRectangle in 2D space
'@param x 
'@param y
'@param width
'@param height
'@param rgba a 32-bit value in the form &hXXXXXXXX specifying the rgb color and alpha
'@return an RlRectangle object
function RlRectangle(x as Float, y as Float, width as Float, height as Float, rgba as Integer) as Object
    this = {
        type: "RlRectangle"
        x: x
        y: y
        width: width
        height: height
        rgba: rgba
        
        Draw: RlRectangle_Draw
    }
    
    return this
end function

'Draws this RlRectangle to the specified component
'@param component a roScreen/roBitmap/roRegion component
'@return true if successful
function RlRectangle_Draw(component as Object) as Boolean
    return component.DrawRect(m.x, m.y, m.width, m.height, m.rgba)
end function
