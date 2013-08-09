'Represents a table of elements (essentially manages several rows of RlHorizontalGroup elements)
function RlTabularGroup(verticalOffset as Integer, horizontalOffset as Integer, x as Integer, y as Integer, width as Integer)
    this = {
        verticalOffset: verticalOffset
        horizontalOffset: horizontalOffset
        x: x
        y: y
        width: width
        
        Init: RlTabularGroup_Init
        Push: RlTabularGroup_Push
        Append: RlTabularGroup_Append
        Draw: RlTabularGroup_Draw
        Center: RlTabularGroup_Center
        SetFocused: RlTabularGroup_SetFocused
        ColCount: RlTabularGroup_ColCount
        RowCount: RlTabularGroup_RowCount
        Get: RlTabularGroup_Get
    }
    
    this.Init()
    
    return this
end function

function RlTabularGroup_Init() as Void
    m.groups = [RlHorizontalGroup(m.horizontalOffset, m.x, m.y)]
end function

function RlTabularGroup_Push(element as Object) as Void
    group = m.groups[m.groups.Count() - 1]
    
    'Check if element exceeds width
    if element.width > m.width
        print "Unable to push element as its width exceed this RlTabularGroup's width"
        return
    end if
    
    'Check if element can fit in current group
    if group.width + group.offset + element.width < m.width
        group.Push(element)
    else
        newGroup = RlHorizontalGroup(m.horizontalOffset, m.x, group.y + group.height + m.verticalOffset)
        newGroup.Push(element)
        m.groups.Push(newGroup)
    end if
end function

function RlTabularGroup_Append(elements as Object) as Void
    max = elements.Count() - 1
    for i = 0 to max
        element = elements[i]
        m.Push(element)
    end for
end function

function RlTabularGroup_Get(rowIndex as Integer, colIndex as Integer) as Dynamic
    return m.groups[rowIndex].elements[colIndex]
end function

'Centers each group vertically
function RlTabularGroup_Center() as Void
    max = m.groups.Count() - 1
    for i = 0 to max
        group = m.groups[i]
        group.x = m.x + (m.width - group.width) / 2
        group.Set()
    end for
end function

function RlTabularGroup_SetFocused(rowIndex as Integer, colIndex as Integer) as Void
    max = m.groups.Count() - 1
    for i = 0 to max
        group = m.groups[i]
        if i = rowIndex
            max = group.Count() - 1
            if colIndex > max then colIndex = max 'Clamp the maximum column value
            group.SetFocused(colIndex)
        else
            group.SetFocused(-1)
        end if
    end for
end function

function RlTabularGroup_Draw(component as Object) as Boolean
    max = m.groups.Count() - 1
    for i = 0 to max
        group = m.groups[i]
        if not group.Draw(component) then return false
    end for
    
    return true
end function

function RlTabularGroup_RowCount() as Integer
    return m.groups.Count()
end function

function RlTabularGroup_ColCount(rowIndex as Integer) as Integer
    return m.groups[rowIndex].Count()
end function