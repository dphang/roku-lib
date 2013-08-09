'Represents a horizontal list of UI elements.
'@param offset the horizontal offset between each element
'@param x the x coordinate of the first element
'@param y the y coordinate of the first element
'@return a RlHorizontalGroup object
function RlHorizontalGroup(offset = 0 as Integer, x = 0 as Integer, y = 0 as Integer) as Object
    this = {
        offset: offset
        x: x
        y: y
        width: 0
        height: 0
        
        elements: []
        
        Push: RlHorizontalGroup_Push
        Pop: RlHorizontalGroup_Pop
        Append: RlHorizontalGroup_Append
        Clear: RlHorizontalGroup_Clear
        Count: RlHorizontalGroup_Count
        Draw: RlHorizontalGroup_Draw
        Set: RlHorizontalGroup_Set
        SetFocused: RlHorizontalGroup_SetFocused
    }
    
    return this
end function

'Adds a new UI element to the end of this RlHorizontalGroup
'@param element the element to be added
function RlHorizontalGroup_Push(element as Object) as Void
    if m.elements.Count() <> 0
        previous = m.elements.Peek()
        element.x = previous.x + previous.width + m.offset
    else
        element.x = m.x
    end if    
    element.y = m.y
    m.height = RlMax(m.height, element.height)
    m.width = element.x - m.x + element.width
    if element.Init <> invalid then element.Init() 'Reinitialize element
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

'Sets the position of all elements.
function RlHorizontalGroup_Set() as Void
    max = m.elements.Count() - 1
    offset = 0
    for i = 0 to max
    	element = m.elements[i]
    	element.x = m.x + offset
    	element.y = m.y
    	if element.Init <> invalid then element.Init()
    	if element.Set <> invalid then element.Set()
    	offset = offset + element.width + m.offset 
    end for 
end function

function RlHorizontalGroup_SetFocused(index as Integer) as Void
	max = m.elements.Count() - 1
	for i = 0 to max
		element = m.elements[i]
		if element.focused <> invalid
			if i = index
				element.focused = true
			else
				element.focused = false
			end if
		end if
	end for
end function

'Draws this RlHorizontalGroup to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlHorizontalGroup_Draw(component as Object) as Boolean
    return RlDrawAll(m.elements, component)
end function