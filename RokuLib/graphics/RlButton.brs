'RlButton represents a selectable button with text
'@param text the text to be displayed on the button
'@param action a {@link String} representing the RlButton's action
'@return an RlButton object
'@see TextBox
function RlButton(text = invalid as Dynamic, font = invalid as Dynamic, rgba = invalid as Dynamic, action as String, defaultBitmap as Object, focusedBitmap as Object, x as Integer, y as Integer) as Object
    this = {
        type: "RlButton"
        font: font
        rgba: rgba
        action: action
        x: x
        y: y
        defaultImage: RlImage(defaultBitmap, x, y)
        focusedImage: RlImage(focusedBitmap, x, y)
        
        focused: false
        
        Draw: RlButton_Draw
    }

    return this
end function

'Draws this RlButton to the specified component
'@param screen a roScreen/roBitmap/roRegion component
'@return true if successful
function RlButton_Draw(component as Object) as Boolean
    if m.focused
        image = m.focusedImage
    else
        image = m.defaultImage
    end if
    
    image.Draw()
    
    if this.textLine = invalid and text <> invalid and font <> invalid
        this.textLine = RlTextLine(m.text, m.font, m.rgba, m.x + image.width / 2 - GetWidth(), m.y)
    end if
    
    return true
end function
