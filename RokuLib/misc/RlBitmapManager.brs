<<<<<<< HEAD:RokuLib/misc/RlBitmapManager.brs
'Bitmap manager which manages and allocates bitmaps as necessary. Also ensures duplicate bitmaps are not created
'(multiple bitmaps created from the same path)
'@return a RlBitmapManager object
function RlBitmapManager() as Object
    this = {
        bitmaps: {}
        
        GetBitmap: RlBitmapManager_GetBitmap
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
        print "Bitmap could not be initialized"
        return invalid
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
    m.bitmaps.Clear()
end function