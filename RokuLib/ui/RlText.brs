'Represents a single line of text without alignment.
'@param text a string to be displayed
'@return a RlText object
function RlText(text as String, font as Object, rgba as Integer, x = 0 as integer, y = 0 as integer) as Object
    this = {
        type: "RlText"
        text: text
        font: font
        rgba: rgba
        x: x
        y: y
        
        Draw: RlText_Draw
        Set: RlText_Set
    }
    
    this.Set()
    
    return this
end function

'Sets width and height of this object base on the text. Need to call this after changing the text in order to update its width and height
function RlText_Set() as Void
	m.width = GetFontWidth(m.font, m.text)
	m.height = GetFontHeight(m.font)
end function

'Draws this RlText to a component, with the top-left corner of the text corresponding to the x and y coordinates of this object
'@param screen a roScreen/roBitmap/roRegion object
'@return true if successful
function RlText_Draw(component as Object) as Boolean
    return component.DrawText(m.text, m.x, m.y, m.rgba, m.font)
end function
