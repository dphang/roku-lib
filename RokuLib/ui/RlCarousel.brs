'Represents a simple 2D image carousel. Has an option to place background shadow images (e.g. for loading purposes).
'@param images an RlImage array
'@param shadowImages an RlImage array (shadow to display)
'@param x the x coordinate of the main image
'@param y the y coordinate of the main image
'@param SCALE the scale between main and other images
'@param VISIBLE_IMAGES an Integer array containing two values, which respectively specify the number of images on the left and right of the main image. Default is [3, 3]
function RlCarousel(images as Object, shadowImages as Dynamic, x as Integer, y as Integer, ANIMATION_TIME = 500 as Integer, SCALE = 0.7 as Float, VISIBLE_IMAGES = [3, 3] as Object, WRAP_AROUND = false as Boolean) as Object
    this = {
        shadowImages: shadowImages
        images: images
        x: x
        y: y
        
        'Constants
        SCALE: SCALE
        ANIMATION_TIME: ANIMATION_TIME 'If the value is 0, then animation is instant
        VISIBLE_IMAGES: VISIBLE_IMAGES
        
        Move: RlCarousel_Move
        Draw: RlCarousel_Draw
    }
    
    this.Init()
    
    return this
end function

function RlCarousel_Init() as Void
    m.moving = false
    m.index = 0
    m.visibleImages = []
end function

'Set this carousel to be moving to the next item (right) or previous item (left).
'@param direction the direction to move in. 1 for right and 0 for left
function RlCarousel_Move(direction as Integer) as Void
    if (direction = 0 and m.index) > 0 or (direction = 1 and m.index < images.Count() - 1)
        m.moving = true
        m.direction = direction
    end if
end function

'Move the carousel, independent of frame rate (since Roku 2/3 devices may have different speeds)
function RlCarousel_Update(delta as Float) as Void
    
end function

'Draws this RlCarousel to the specified component.
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlCarousel_Draw(component as Object) as Boolean

end function

