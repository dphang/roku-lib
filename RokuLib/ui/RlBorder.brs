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

function RlBorder_Draw(component as Object) as Boolean
	if m.top.x <> m.x then m.Init()
	
	items = [m.top, m.bottom, m.left, m.right]
    return RlDrawAll(items, component)
end function 

function RlBorder_Init() as Void
	m.top = RlRectangle(m.x, m.y, m.width, m.thickness, m.rgba)
	m.bottom = RlRectangle(m.x, m.y + m.height - m.thickness, m.width, m.thickness, m.rgba)
	m.left = RlRectangle(m.x, m.y, m.thickness, m.height, m.rgba)
	m.right = RlRectangle(m.x + m.width - m.thickness, m.y, m.thickness, m.height, m.rgba)
end function