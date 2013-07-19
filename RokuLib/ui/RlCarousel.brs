'Represents a simple 2D image carousel that dynamically loads images as it scrolls
function RlCarousel(images as Object) as Object
    this = {
        index: 0
        images: images
        
        Move: RlCarousel_Move
        
    }
    
    return this
end function

'Advances to next item (right) or previous item (left)
'@param direction the direction to move in. 1 for right and 0 for left
function RlCarousel_Move(direction as Integer) as Void
    
end function

'@return the 
function RlCarousel_GetCurrentItem()

end function