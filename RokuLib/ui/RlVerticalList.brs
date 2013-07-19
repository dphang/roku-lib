'Represents a vertical list of UI elements.
'@param offset the vertical offset between each element
'@param x the x coordinate of the first element
'@param y the y coordinate of the first element
'@return a RlVerticalList object
function RlVerticalList(offset as Integer, x as Integer, y as Integer) as Object
    this = {
        offset: offset
        x: x
        y: y
        
        elements: []
        
        Push: RlVerticalList_Push
        Pop: RlVerticalList_Pop
        Append: RlVerticalList_Append
        Clear: RlVerticalList_Clear
        Count: RlVerticalList_Count
        Draw: RlVerticalList_Draw
    }
    
    return this
end function

'Adds a new UI element to the end of this RlVerticalList
'@param element the element to be added
function RlVerticalList_Push(element as Object) as Void
    m.elements.Push(element)
    
    element.x = m.x
    element.y = m.y + (m.offset + m.elements.Peek().height) * (m.elements.Count() - 1)
end function

'Pops the UI element at the end of this RlVerticalList
function RlVerticalList_Pop() as Void
    m.elements.Pop()
end function

'Adds multiple UI elements to the end of this RlVerticalList
'@param elements an Array of elements
function RlVerticalList_Append(elements as Object) as Void
    max = elements.Count() - 1
    for i = 0 to max
        m.Push(elements[i])
    end for
end function

'Clears this RlVerticalList
function RlVerticalList_Clear() as Void
    m.elements.Clear()
end function

'@return the size of this RlVerticalList
function RlVerticalList_Count() as Integer
    return m.elements.Count()
end function

'Draws this RlVerticalList to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlVerticalList_Draw(component as Object) as Boolean
    return RlDrawAll(m.elements, component)
end function