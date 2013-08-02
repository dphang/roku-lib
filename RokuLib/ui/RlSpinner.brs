'Represents a rotating spinner for use as a loading indicator
function RlSpinner(path, x, y, width, height, rotationPeriod = 0.5 as Float) as Object
    this = {
        image: RlRotatableImage(path, x, y, width, height)
        angle: 0.0
        rotationPeriod: rotationPeriod 'How fast it takes, in seconds to make one full rotation
        visible: true
        
        Draw: RlSpinner_Draw
        Update: RlSpinner_Update
    }
    
    return this
end function

function RlSpinner_Draw(component as Object) as Boolean
    if m.visible
    	return m.image.Draw(component)
	else
		return true
	end if
end function

function RlSpinner_Update(delta as Float) as Void
    m.angle = m.angle - 360.0 * delta / m.rotationPeriod
    if m.angle < 0
        m.angle = m.angle + 360.0
    end if
    
    m.image.angle = m.angle
end function