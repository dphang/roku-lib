'Represents a vertical list of UI elements.
'@param offset the vertical offset between each element
'@param x the x coordinate of the first element
'@param y the y coordinate of the first element
'@return a RlVerticalGroup object
function RlVerticalGroup(offset as Integer, x as Integer, y as Integer) as Object
    this = {
        offset: offset
        x: x
        y: y
        
        elements: []
        
        Push: RlVerticalGroup_Push
        Pop: RlVerticalGroup_Pop
        Append: RlVerticalGroup_Append
        Clear: RlVerticalGroup_Clear
        Count: RlVerticalGroup_Count
        Draw: RlVerticalGroup_Draw
    }
    
    return this
end function

'Adds a new UI element to the end of this RlVerticalGroup
'@param element the element to be added
function RlVerticalGroup_Push(element as Object) as Void
    count = m.elements.Count()
    if count <> 0
        previous = m.elements.Peek()
        element.y = previous.y + previous.height + m.offset
    else
        element.y = m.y
    end if    
    element.x = m.x
    m.elements.Push(element)
end function

'Pops the UI element at the end of this RlVerticalGroup
function RlVerticalGroup_Pop() as Void
    m.elements.Pop()
end function

'Adds multiple UI elements to the end of this RlVerticalGroup
'@param elements an Array of elements
function RlVerticalGroup_Append(elements as Object) as Void
    max = elements.Count() - 1
    for i = 0 to max
        m.Push(elements[i])
    end for
end function

'Clears this RlVerticalGroup
function RlVerticalGroup_Clear() as Void
    m.elements.Clear()
end function

'@return the size of this RlVerticalGroup
function RlVerticalGroup_Count() as Integer
    return m.elements.Count()
end function

'Draws this RlVerticalGroup to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlVerticalGroup_Draw(component as Object) as Boolean
    return RlDrawAll(m.elements, component)
end function