'RlImage represents an image in 2D space. Lazy allocation of bitmap to reduce memory use (only allocated when first drawn).
'@param path a roBitmap/roRegion object or a String specifying an image path
'@param x the x coordinate
'@param y the y coordinate
'@param width the width
'@param height the height
'@return an Image object
function RlImage(path as String, x as Integer, y as Integer, width as Integer, height as Integer, niceScaling = false as Boolean) as Object
    this = {
        type: "RlImage"
        path: path
        bitmapManager: m.bitmapManager
        x: x
        y: y
        width: width
        height: height
        origWidth: width
        origHeight: height
        niceScaling: niceScaling
        
        Draw: RlImage_Draw
        Copy: RlImage_Copy
    }
    
    return this
end function

'Draws this RlImage to the specified component.
'@param component a roScreen/roBitmap/roRegion object
'@param conservative if set to true, the associated roBitmap is immediately deallocated after drawing, if possible
'@return true if successful
function RlImage_Draw(component as Object) as Boolean
    success = true
    if m.path <> ""
        'Lazy allocation
	    if m.niceScaling
	    	bitmap = m.bitmapManager.GetScaledBitmap(m.path, m.width, m.height, 1)
	    else
			bitmap = m.bitmapManager.GetBitmap(m.path)
		end if
	    
	    'Draw image
	    if not m.niceScaling and (m.width <> bitmap.GetWidth() or m.height <> bitmap.GetHeight()) 'Scaled draw
	        scaleX = m.width / bitmap.GetWidth()
	        scaleY = m.height / bitmap.GetHeight()
			success = component.DrawScaledObject(m.x, m.y, scaleX, scaleY, bitmap)
	    else 'Normal draw or nice scaling draw (bitmap returned already at correct width and height)
	        success = component.DrawObject(m.x, m.y, bitmap)
	    end if
	end if
    
    return success
end function

'@return a copy of this RlImage (useful if you need to use multiple images in different areas)
function RlImage_Copy() as Object
	return RlImage(m.path, m.x, m.y, m.width, m.height, m.niceScaling)
end function