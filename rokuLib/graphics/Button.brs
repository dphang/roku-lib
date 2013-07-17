'Button represents a selectable button with text
'@param text the text to be displayed on the button
'@param action a {@link String} representing the Button's action
'@return a Button object
'@see TextBox
function rlButton(text as String, font as Object, rgba as Integer, action as String, defaultBitmap as Object, focusedBitmap as Object, x as Float, y as Float) as Object
    this = {
        type: "rlButton"
        text: text
        font: font
        rgba: rgba
        action: action
        x: x
        y: y
        defaultImage: rlImage(defaultBitmap, x, y)
        focusedImage: rlImage(focusedBitmap, x, y)
        
        focused: false
        
        Draw: Button_Draw
        SetFocused: Button_SetFocused
    }

    return this
end function

'Draws this Button to the specified component
'@param screen a roScreen/roBitmap/roRegion component
'@return true if successful
function Button_Draw(component as Object) as Boolean
    if m.focused
        image = m.focusedImage
    else
        image = m.defaultImage
    end if
    
    toDraw = [image, m.textLine]
    
    max = toDraw.Count() - 1
    for i = 0 to max
        item = toDraw[i]
        if not item.Draw(component)
            return false
        end if
    end for
    
    return true
end function
