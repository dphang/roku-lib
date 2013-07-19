'Represents a horizontal list of UI elements.
'@param offset the horizontal offset between each element
'@param x the x coordinate of the first element
'@param y the y coordinate of the first element
'@return a RlHorizontalList object
function RlHorizontalList(offset as Integer, x as Integer, y as Integer) as Object
    this = {
        offset: offset
        x: x
        y: y
        
        elements: []
        
        Push: RlHorizontalList_Push
        Pop: RlHorizontalList_Pop
        Append: RlHorizontalList_Append
        Clear: RlHorizontalList_Clear
        Count: RlHorizontalList_Count
        Draw: RlHorizontalList_Draw
    }
    
    return this
end function

'Adds a new UI element to the end of this RlHorizontalList
'@param element the element to be added
function RlHorizontalList_Push(element as Object) as Void
    m.elements.Push(element)
    element.x = m.x + (m.offset + m.elements.Peek().width) * (m.elements.Count() - 1)
    element.y = m.y
end function

'Pops the UI element at the end of this RlHorizontalList
function RlHorizontalList_Pop() as Void
    m.elements.Pop()
end function

'Adds multiple UI elements to the end of this RlHorizontalList
'@param elements an Array of elements
function RlHorizontalList_Append(elements as Object) as Void
    max = elements.Count() - 1
    for i = 0 to max
        m.Push(elements[i])
    end for
end function

'Clears this RlHorizontalList
function RlHorizontalList_Clear() as Void
    m.elements.Clear()
end function

'@return the size of this RlHorizontalList
function RlHorizontalList_Count() as Integer
    return m.elements.Count()
end function

'Draws this RlHorizontalList to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlHorizontalList_Draw(component as Object) as Boolean
    return RlDrawAll(m.elements, component)
end function