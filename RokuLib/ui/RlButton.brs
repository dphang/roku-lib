'RlButton represents a selectable button with text centered on it
'@param text the text to be displayed on the button
'@param action the String representing the RlButton's action
'@return an RlButton object
function RlButton(text as String, font as Object, rgba as Integer, action as String, focusableImage as Object, x as Integer, y as Integer, width = invalid, height = invalid) as Object
    this = {
        type: "RlButton"
        text: text
        font: font
        rgba: rgba
        action: action
        x: x
        y: y
        image: focusableImage
        
        focused: false
        
        Draw: RlButton_Draw
    }

    return this
end function

'Draws this RlButton to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlButton_Draw(component as Object) as Boolean
    'Set the image to be focused based on whether this button is selected
    image.focused = m.focused
    if not image.Draw(component) then return false
    
    'Initialize the text if not already done, and draw it. Done at draw time since m.textLine is positioned based on image width and height, and the image width/height may not be known.
    if m.textLine = invalid
        m.textLine = RlTextArea(m.text, m.font, m.rgba, m.x, m.y, image.width, image.height, 1, 1.0, "center")
    end if
    
    if not m.textLine.Draw(component) then return false
    
    return true
end function

