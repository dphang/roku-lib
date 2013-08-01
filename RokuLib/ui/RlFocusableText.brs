'Represents a focusable Text object (i.e. different color when focused)
'@param text the String to be displayed
'@param font the roFont object to be used
'@param rgba1 the default color
'@param rgba1 the focused color
'@return a RlFocusableText object
function RlFocusableText(text as String, font as Object, rgba1 as Integer, rgba2 as Integer, x = 0 as Integer, y = 0 as Integer) as Object
    this = {
        defaultText: RlText(text, font, rgba1, x, y)
        focusedText: RlText(text, font, rgba2, x, y)
        x: x
        y: y
        width: font.GetOneLineWidth(text, 1280)
        height: font.GetOneLineHeight()
        
        focused: false
        
        Draw: RlFocusableText_Draw
    }
    
    return this
end function

'Draws this RlFocusableText object to the specified component
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlFocusableText_Draw(component as Object) as Boolean
    if m.focused
        text = m.focusedText
    else
        text = m.defaultText
    end if
    
    text.x = m.x
    text.y = m.y
    
    return text.Draw(component)
end function