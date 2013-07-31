function RlRotatableImage(path as String, x as Integer, y as Integer, width as Dynamic, height as Dynamic, angle = 0.0 as Float) as Object
    super = RlImage(path, x, y, width, height)
    this = {
        angle: angle
        
        Draw: RlRotatableImage_Draw
    }
    
    super.Append(this)
    return super
end function

function RlRotatableImage_Draw(component as Object) as Boolean
    newX = m.x + (m.width - (m.width * Cos(m.angle * .01745329251) + m.width * Sin(m.angle * .01745329251))) / 2 'New x
    newY = m.y + (m.height - (- m.height * Sin(m.angle * .01745329251) + m.height * Cos(m.angle * .01745329251))) / 2 'New y
    
    if m.niceScaling
        bitmap = m.bitmapManager.GetScaledBitmap(m.path, m.width, m.height, 1)
    else
        bitmap = m.bitmapManager.GetBitmap(m.path)
    end if
    
    return component.DrawRotatedObject(newX, newY, m.angle, bitmap)
end function