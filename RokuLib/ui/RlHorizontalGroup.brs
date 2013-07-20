'Represents a horizontal list of UI elements.
'@param offset the horizontal offset between each element
'@param x the x coordinate of the first element
'@param y the y coordinate of the first element
'@return a RlHorizontalGroup object
function RlHorizontalGroup(offset as Integer, x as Integer, y as Integer) as Object
    this = {
        offset: offset
        x: x
        y: y
        
        elements: []
        
        Push: RlHorizontalGroup_Push
        Pop: RlHorizontalGroup_Pop
        Append: RlHorizontalGroup_Append
        Clear: RlHorizontalGroup_Clear
        Count: RlHorizontalGroup_Count
        Draw: RlHorizontalGroup_Draw
    }
    
    return this
end function

'Adds a new UI element to the end of this RlHorizontalGroup
'@param element the element to be added
function RlHorizontalGroup_Push(element as Object) as Void
    count = m.elements.Count()
    if count <> 0
        previous = m.elements.Peek()
        element.x = previous.x + previous.width + m.offset
    else
        element.x = m.x
    end if    
    element.y = m.y
    m.elements.Push(element)
end function

'Pops the UI element at the end of this RlHorizontalGroup
function RlHorizontalGroup_Pop() as Void
    m.elements.Pop()
end function

'Adds multiple UI elements to the end of this RlHorizontalGroup
'@param elements an Array of elements
function RlHorizontalGroup_Append(elements as Object) as Void
    max = elements.Count() - 1
    for i = 0 to max
        m.Push(elements[i])
    end for
end function

'Clears this RlHorizontalGroup
function RlHorizontalGroup_Clear() as Void
    m.elements.Clear()
end function

'@return the size of this RlHorizontalGroup
function RlHorizontalGroup_Count() as Integer
    return m.elements.Count()
end function

'Draws this RlHorizontalGroup to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlHorizontalGroup_Draw(component as Object) as Boolean
    return RlDrawAll(m.elements, component)
end function