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
    return RlDrawAll(m.items, component)
end function 

function RlBorder_Init() as Void
    outsideRectangle = RlRectangle(m.x, m.y, m.width, m.height, m.rgba)
    insideRectangle = RlRectangle(m.x + m.thickness, m.y + m.thickness, m.width - 2 * m.thickness, m.height - 2 * m.thickness, &h00000000)

    m.items = [outsideRectangle, insideRectangle]
end function