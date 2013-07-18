'RlButton represents a selectable button with text centered on it
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
        image: RlFocusable(defaultBitmap, focusedBitmap, x, y, width, height)
        
        focused: false
        
        Draw: RlButton_Draw
    }

    return this
end function

'Draws this RlButton to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlButton_Draw(component as Object) as Boolean
    'Draw the focusable image based on whether this button is selected
    image.focused = m.focused
    if not image.Draw(component) then return false
    
    'Initialize the text if not already done, and draw it. Done separately since m.textLine is positioned based on image width and height
    if m.textLine = invalid and text <> invalid and font <> invalid
        m.textLine = RlTextLine(m.text, m.font, m.rgba, m.x + (image.width - m.font.GetOneLineWidth(m.text, 1000)) / 2, m.y + (image.height - m.font.GetOneLineHeight()) / 2)
    end if
    
    if not m.textLine.Draw(component) then return false
    
    return true
end function
