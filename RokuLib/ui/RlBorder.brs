'Represents a rectangular border that can be placed around text, etc.
'@param x the x coordinate
'@param y the y coordinate
'@param width the width
'@param height the height
'@param thickness the thickness of the border
'@param rgba the border color
'@return a RlRectangle object
function RlBorder(x as Integer, y as Integer, width as Integer, height as Integer, thickness as Integer, rgba as Integer) as Object
    this = {
    	x: x
    	y: y
    	width: width
    	height: height
    	thickness: thickness
    	rgba: rgba
    	
        Draw: RlBorder_Draw
        Init: RlBorder_Init
    }
    
    this.Init()
    
    return this
end function 

'Draws this RlBorder object to the specified component.
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlBorder_Draw(component as Object) as Boolean
    return RlDrawAll(m.items, component)
end function 

function RlBorder_Init() as Void
	outsideRectangle = RlRectangle(m.x, m.y, m.width, m.height, m.rgba)
	insideRectangle = RlRectangle(m.x + m.thickness, m.y + m.thickness, m.width - 2 * m.thickness, m.height - 2 * m.thickness, &h00000000)
	
	m.items = [outsideRectangle, insideRectangle]
end function