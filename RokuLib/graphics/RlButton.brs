'RlButton represents a selectable button with text
'@param text the text to be displayed on the button
'@param action a {@link String} representing the RlButton's action
'@return an RlButton object
'@see TextBox
function RlButton(text as String, font as Object, rgba as Integer, action as String, defaultBitmap as Object, focusedBitmap as Object, x as Float, y as Float) as Object
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
'@param screen a roScreen/roBitmap/roRegion component
'@return true if successful
function RlButton_Draw(component as Object) as Boolean
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
