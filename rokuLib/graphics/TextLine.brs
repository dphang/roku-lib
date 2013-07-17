'rlTextLine represents a single line of text without alignment.
'@param text a string representing the text to display
'@return a rlTextLine object
function rlTextLine(text as String, font as Object, rgba as Integer, x as Float, y as Float, align as String) as Object
    this = {
        type: "rlTextLine"
        text: text
        font: font
        rgba: rgba
        x: x
        y: y
        
        Draw: TextLine_Draw
    }
    return this
end function

'Draw this rlTextLine to a component, with the top-left corner of the text corresponding to the x and y coordinates of this object
'@param screen a roScreen/roBitmap/roRegion component
'@return true if successful
function TextLine_Draw(component as Object) as Boolean
    return component.DrawText(m.text, m.x, m.y, m.rgba, m.font)
end function
