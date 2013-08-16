'A generic group of elements without any offset or coordinates
function RlGroup() as Object
    this = {
        elements: []
        
        Push: RlGroup_Push
        Pop: RlGroup_Pop
        Append: RlGroup_Append
        Clear: RlGroup_Clear
        Count: RlGroup_Count
        Draw: RlGroup_Draw
        SetFocused: RlGroup_SetFocused
    }
    
    return this
end function

function RlGroup_Push(element as Object) as Void
    m.elements.Push(element)
end function

'Pops the UI element at the end of this RlGroup
function RlGroup_Pop() as Void
    m.elements.Pop()
end function

'Adds multiple UI elements to the end of this RlGroup
'@param elements an Array of elements
function RlGroup_Append(elements as Object) as Void
    max = elements.Count() - 1
    for i = 0 to max
        m.Push(elements[i])
    end for
end function

function RlGroup_Draw(component as Object) as Boolean
    return RlDrawAll(m.elements, component)
end function

function RlGroup_Clear() as Void
    m.elements.Clear()
end function

function RlGroup_SetFocused(index as Integer) as Void
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

function RlGroup_Count() as Integer
    return m.elements.Count()
end function