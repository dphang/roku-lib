'RlButton represents a selectable button with text
'@param text the text to be displayed on the button
'@param action a String representing the RlButton's action
'@return an RlButton object
function RlButton(text as Dynamic, font as Dynamic, rgba as Dynamic, action as String, defaultBitmap as Object, focusedBitmap as Object, x as Integer, y as Integer) as Object
    this = {
        type: "RlButton"
        text: text
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
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlButton_Draw(component as Object) as Boolean
    if m.focused
        image = m.focusedImage
    else
        image = m.defaultImage
    end if
    
    if not image.Draw(component) then return false
    
    if m.textLine = invalid and text <> invalid and font <> invalid
        m.textLine = RlTextLine(m.text, m.font, m.rgba, m.x + (image.width - m.font.GetOneLineWidth(m.text, 1000)) / 2, m.y)
    end if
    
    if not m.textLine.Draw(component) then return false
    
    return true
end function
