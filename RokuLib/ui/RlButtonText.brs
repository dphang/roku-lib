'Represents some non-clickable image/button with text next to it (e.g. those used to indicate pressing * brings up info popup)
'The text is always vertically centered to the image
'@param text the text to be shown
'@param image an RlImage to be shown
function RlButtonText(name as String, font as Object, rgba as Integer, image as Object, x as Integer, y as Integer, offset as Integer) as Object
    this = {
        text: RlText(name, font, rgba, x, y)
        image: image.copy()
        x: x
        y: y
        
        Draw: RlButtonText_Draw
    }
    
    return this
end function

function RlButtonText_Set() as Void
    m.image.x = m.x
    m.image.y = m.y
    
    'Calculate text position
end function

function RlButtonText_Draw(screen) as Boolean
    if m.x <> m.image.x or m.y <> m.image.y then m.Set()
    return RlDrawAll 
end function