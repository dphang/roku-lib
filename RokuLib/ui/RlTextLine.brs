'RlTextLine represents a single line of text without alignment.
'@param text a string representing the text to display
'@return a RlTextLine object
function RlTextLine(text as String, font as Object, rgba as Integer, x as Float, y as Float) as Object
    this = {
        type: "RlTextLine"
        text: text
        font: font
        rgba: rgba
        x: x
        y: y
        
        Draw: RlTextLine_Draw
    }
    return this
end function

'Draw this RlTextLine to a component, with the top-left corner of the text corresponding to the x and y coordinates of this object
'@param screen a roScreen/roBitmap/roRegion object
'@return true if successful
function RlTextLine_Draw(component as Object) as Boolean
    return component.DrawText(m.text, m.x, m.y, m.rgba, m.font)
end function
