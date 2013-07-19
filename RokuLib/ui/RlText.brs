'Represents a single line of text without alignment.
'@param text a string to be displayed
'@return a RlText object
function RlText(text as String, font as Object, rgba as Integer, x = invalid, y = invalid) as Object
    this = {
        type: "RlText"
        text: text
        font: font
        rgba: rgba
        x: x
        y: y
        
        Draw: RlText_Draw
    }
    return this
end function

'Draws this RlText to a component, with the top-left corner of the text corresponding to the x and y coordinates of this object
'@param screen a roScreen/roBitmap/roRegion object
'@return true if successful
function RlText_Draw(component as Object) as Boolean
    return component.DrawText(m.text, m.x, m.y, m.rgba, m.font)
end function
