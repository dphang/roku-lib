'Button represents a selectable button with text
'@param text the text to be displayed on the button
'@param action a {@link String} representing the Button's action
'@return a Button object
'@see TextBox
function Button(text as String, font as Object, rgba as Integer, action as String, defaultBitmap as Object, focusedBitmap as Object, x as Float, y as Float) as Object
    this = {
        type: "Button"
        text: text
        font: font
        rgba: rgba
        action: action
        x: x
        y: y
        defaultImage: Image(defaultBitmap, x, y)
        focusedImage: Image(focusedBitmap, x, y)
        
        focused: false
        
        Draw: Button_Draw
        SetFocused: Button_SetFocused
    }
    
    this.textLine = TextLine(this.text, this.font, this.rgba

    return this
end function

'Draws this Button to the specified screen
'@param screen a roScreen object
'@return true if successful
function Button_Draw(screen as Object) as Boolean
    if m.focused
        image = m.focusedImage
    else
        image = m.defaultImage
    end if
    
    toDraw = [image, m.textLine]
    
    for i = 0 to toDraw.Count() - 1
        item = toDraw[i]
        if not item.Draw(screen) then return false
    end for
    
    return true
end Function
