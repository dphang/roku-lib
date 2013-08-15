'Bitmap manager which manages and allocates bitmaps using and LRU cache.
'(multiple bitmaps created from the same path)
'@return a RlBitmapManager object
function RlBitmapManager(size as Integer) as Object
    this = {
    	bitmaps: RlByteCache(size, RlBitmapSize)
        scaledBitmaps: {}
        
        GetBitmap: RlBitmapManager_GetBitmap
        GetScaledBitmap: RlBitmapManager_GetScaledBitmap
        ClearBitmap: RlBitmapManager_ClearBitmap
        Clear: RlBitmapManager_Clear
        ClearScaled: RlBitmapManager_ClearScaled
        Exists: RlBitmapManager_Exists
    }
        
    return this
end function

'Returns a roBitmap object corresponding to the specified path.
'If no roBitmap at the same path already exists in memory, a new roBitmap is allocated.
'@param path the path to an image file
'@return a roBitmap object
function RlBitmapManager_GetBitmap(path as String) as Dynamic
    if not m.bitmaps.Exists(path)
        m.bitmaps.Set(path, CreateObject("roBitmap", path))
    end if
    
    bitmap = m.bitmaps.Get(path)
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
    key = path + "," + tostr(width) + "," + tostr(height)
    bitmap = m.GetBitmap(path) 'Try to get the original bitmap
    
    if not m.bitmaps.Exists(key)
    	m.bitmaps.Set(key, RlGetScaledImage(bitmap, width, height))
	end if
	
    bitmap = m.bitmaps.Get(key)

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

function RlBitmapManager_Exists(path as String) as Boolean
	return m.bitmaps.DoesExist(path)
end function

'Clears a random allocated roBitmaps
function RlBitmapManager_Clear() as Void
    m.bitmaps.Clear()
end function

'Clears a random allocated scaled bitmaps
function RlBitmapManager_ClearScaled() as Void
    m.scaledBitmaps.Clear()
end function