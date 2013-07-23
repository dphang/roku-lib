'Represents a simple 2D image carousel. Uses background shadow images for loading purposes.
'@param images an array of image file paths
'@param bigShadow a dictionary specifying parameters of the big shadow to be used. Example: {path: "pkg:/shadow.png", offsetX: 10, offsetY: 10, width: 100, height: 100}
'@param smallShadow a dictionary specifying parameters of the small shadow to be used. Example: {path: "pkg:/shadow.png", offsetX: 10, offsetY: 10, width: 100, height: 100}
'@param x the x coordinate of the main image
'@param y the y coordinate of the main image
'@param VISIBLE_IMAGES an Integer array containing two values, which respectively specify the number of images on the left and right of the main image. Default is [3, 3]
function RlCarousel(images as Object, bigShadow as Object, smallShadow as Object, x as Integer, y as Integer, ANIMATION_TIME = 0.0 as Float, VISIBLE_IMAGES = [4, 4] as Object, WRAP_AROUND = false as Boolean) as Object
    this = {
        bigShadow: bigShadow
        smallShadow: smallShadow
        images: images
        x: x
        y: y
        
        moving: false
        direction: 0
        index: 0
        
        'Constants
        ANIMATION_TIME: ANIMATION_TIME 'If the value is 0, then animation is instant
        VISIBLE_IMAGES: VISIBLE_IMAGES
        
        Init: RlCarousel_Init
        Move: RlCarousel_Move
        Draw: RlCarousel_Draw
        Update: RlCarousel_Update
    }
    
    this.Init()
    
    return this
end function

function RlCarousel_Init() as Void
    'Create visible shadows
    m.visibleShadows = []
    
    'Small shadow constants
    smallPath = m.smallShadow.path
    smallOffsetX = m.smallShadow.offsetX
    smallOffsetY = m.smallShadow.offsetY
    smallWidth = m.smallShadow.width
    smallHeight = m.smallShadow.height
    
    'Big shadow constants
    bigPath = m.bigShadow.path
    bigOffsetX = m.bigShadow.offsetX
    bigOffsetY = m.bigShadow.offsetY
    bigWidth = m.bigShadow.width
    bigHeight = m.bigShadow.height
    
    actualX = m.x - bigOffsetX 'Since the main shadow has an offset shadow border
    
    'Initialize small shadows
    max = m.VISIBLE_IMAGES[0] + m.VISIBLE_IMAGES[1] - 1
    for i = 0 to max
        shadow = RlImage(smallPath, actualX + bigWidth + i * smallWidth, m.y + (bigHeight - smallHeight) / 2, smallWidth, smallHeight)
        shadow.moveLeft = 0.0
        m.visibleShadows.Push(shadow)
    end for
    
    'Initialize big shadow
    bigShadow = RlImage(bigPath, actualX, m.y, bigWidth, bigHeight)
    bigShadow.moveLeft = 0.0
    m.visibleShadows.Push(bigShadow)
    m.visibleImages = []
    
    m.wrapLeftX = actualX - (m.VISIBLE_IMAGES[1] - 2) * smallWidth
    m.wrapRightX = actualX + bigWidth + (m.VISIBLE_IMAGES[0] + 1) * smallWidth 
end function

'Set this carousel to start moving to the next item (right) or previous item (left).
'@param direction the direction to move in. 1 for right and -1 for left
function RlCarousel_Move(direction as Integer) as Void
    print "RlCarousel.Move()"
    
    if (direction = -1 and m.index > 0) or (direction = 1 and m.index < 99 - 1)
        m.moving = true
        m.direction = direction        
        
        'Calculate move amounts
        max = m.visibleShadows.Count() - 1
        for i = 0 to max
            shadow = m.visibleShadows[i]
            if shadow.moveLeft > 0 and direction <> m.direction 'Animation interrupted (reversed) direction
                shadow.moveTotal = shadow.moveLeft
            else
                shadow.moveTotal = m.bigShadow.width
            end if
            shadow.moveLeft = shadow.moveTotal
        end for
    end if
    
end function

'Update the carousel, independent of frame rate (since Roku 1/2/3 devices have different max framerates)
function RlCarousel_Update(delta as Float) as Boolean
    if m.moving
        print "RlCarousel.Update()"
        print "Delta: " + tostr(delta)
        max = m.visibleShadows.Count() - 1
        for i = 0 to max
            shadow = m.visibleShadows[i]
            print tostr(shadow.moveLeft)
            if shadow.moveLeft > 0
                if m.ANIMATION_TIME <> 0
                    moveAmount = - m.direction * delta * (shadow.moveTotal / m.ANIMATION_TIME)
                    if abs(moveAmount) > shadow.moveTotal then moveAmount = - m.direction * shadow.moveLeft
                else
                    moveAmount = - m.direction * shadow.moveTotal
                end if
                shadow.x = shadow.x + moveAmount
                'Wrap the shadow to the other side (to seem like it's continuous)
                if shadow.x < m.wrapLeftX
                    shadow.x = m.wrapRightX
                else if shadow.x > m.wrapRightX
                    shadow.x = m.wrapLeftX
                end if
                shadow.moveLeft = shadow.moveLeft - abs(moveAmount)
                m.moving = true
            else
                m.moving = false
            end if
        end for
        return true
    end if
    
    return false
end function

'Draws this RlCarousel to the specified component.
'@param component a roScreen/roBitmap/roRegion object
'@return true if successful
function RlCarousel_Draw(component as Object) as Boolean
    if not RlDrawAll(m.visibleShadows, component) then return false
    return true
end function

