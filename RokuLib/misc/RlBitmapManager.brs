'Bitmap manager which manages and allocates bitmaps as necessary. Also ensures duplicate bitmaps are not created
'(multiple bitmaps created from the same path)
'@return a RlBitmapManager object
function RlBitmapManager() as Object
    this = {
        bitmaps: {}
        
        GetBitmap: RlBitmapManager_GetBitmap
        GetScaledBitmap: RlBitmapManager_GetScaledBitmap
        ClearBitmap: RlBitmapManager_ClearBitmap
        Clear: RlBitmapManager_Clear
    }
        
    return this
end function

'Returns a roBitmap object corresponding to the specified path.
'If no roBitmap at the same path already exists in memory, a new roBitmap is allocated.
'@param path the path to an image file
'@return a roBitmap object
function RlBitmapManager_GetBitmap(path as String) as Dynamic
    if not m.bitmaps.DoesExist(path)
        m.bitmaps[path] = CreateObject("roBitmap", path)
    end if
    
    bitmap = m.bitmaps[path]
    
    if bitmap = invalid
        print "Ran out of memory for bitmap, flushing all existing bitmaps"
        m.Clear()
        m.bitmaps[path] = CreateObject("roBitmap", path)
        bitmap = m.bitmaps[path]
    end if
    
    return bitmap
end function

'Returns a roBitmap object corresponding to the specified path.
'If no roBitmap at the same path already exists in memory, a new roBitmap is allocated.
'@param path the path to an image file
'@param width the width
'@param height the height
'@param scaleMode an integer representing how this image should be initially scaled. 0 = k nearest neighbor. 1 = bilinear scaling.
'@return a roBitmap object
function RlBitmapManager_GetScaledBitmap(path as String, width as Integer, height as Integer, scaleMode as Integer) as Dynamic
    if not m.bitmaps.DoesExist(path)
        m.bitmaps[path] = RlGetScaledImage(path, width, height, scaleMode)
    end if
    
    bitmap = m.bitmaps[path]
    
    if bitmap = invalid
        print "Ran out of memory for scaled bitmap, flushing all existing bitmaps"
        m.Clear()
        m.bitmaps[path] = RlGetScaledImage(path, width, height, scaleMode)
        bitmap = m.bitmaps[path]
    end if
    
    return bitmap
end function

function RlBitmapManager_GetBilinearBitmap(path as String) as Dynamic
    if not m.bitmaps.DoesExist(path)
        m.bitmaps[path] = CreateObject("roBitmap", path)
    end if
    
    bitmap = m.bitmaps[path]
    
    if bitmap = invalid
        print "Ran out of memory for bitmap, flushing all existing bitmaps"
        m.Clear()
        m.bitmaps[path] = CreateObject("roBitmap", path)
        print m.bitmaps
        bitmap = m.bitmaps[path]
    end if
    
    return bitmap
end function

'Clears any roBitmap object allocated for the specified path
'@param path the path to an image file
function RlBitmapManager_ClearBitmap(path as String) as Void
    if m.bitmaps.DoesExist(path)
        m.bitmaps[path] = invalid
        m.bitmaps.Delete(path)
    end if
end function

'Clears all allocated roBitmaps
function RlBitmapManager_Clear() as Void
	for each bitmap in m.bitmaps
		bitmap = invalid
	end for
	m.bitmaps = {}
end function