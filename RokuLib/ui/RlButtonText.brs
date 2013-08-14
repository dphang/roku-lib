'Represents some non-clickable image/button with text next to it (e.g. those used to indicate pressing * brings up info popup)
'The text is always vertically centered to the image
'@param text the text to be shown
'@param image an RlImage to be shown
function RlButtonText(name as String, font as Object, rgba as Integer, image as Object, x as Integer, y as Integer, offset as Integer) as Object
    this = {
        text: RlText(name, font, rgba)
        image: image.Copy()
        x: x
        y: y
        offset: offset
        
        Draw: RlButtonText_Draw
        Set: RlButtonText_Set
        Copy: RlButtonText_Copy
    }
    
    this.Set()
    
    return this
end function

function RlButtonText_Set() as Void
    m.image.x = m.x
    m.image.y = m.y
    
    'Calculate text position
    m.text.x = m.image.x + m.image.width + m.offset
    m.text.y = m.image.y + (m.image.height - m.text.height) / 2 'Vertically centered
    
    'Calculate width
    m.width = m.image.width + m.offset + m.text.width
    m.height = RlMax(m.image.height, m.text.height)
    
end function

function RlButtonText_Draw(screen as Object) as Boolean
    if m.x <> m.image.x or m.y <> m.image.y then m.Set()
    items = [m.image, m.text]
    return RlDrawAll(items, screen)
end function

function RlButtonText_Copy() as Object
	return RlButtonText(m.text.text, m.text.font, m.text.rgba, m.image.Copy(), m.x, m.y, m.offset)
end function