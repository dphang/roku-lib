'TextLine represents a single line of text
'@param text a string representing the text to display
'@return a TextLine object
Function TextLine(text as String, font as Object, rgba as Integer, x as Float, y as Float, align as String) As Object
    this = {
        type: "TextLine"
        text: text
        font: font
        rgba: rgba
        x: x
        y: y
        align: align
        
        draw: TextLine_draw
    }
    return this
End Function

'Draw this TextLine to a screen
'@param screen a roScreen object
'@return true if successful
Function TextLine_draw(screen as Object) As Boolean
    return screen.DrawText(m.text, m.x, m.y, m.rgba, m.font)
End Function
