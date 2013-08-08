'Calculates an estimated size of a bitmap, base on the byte array of the bitmap.
function RlBitmapSize(bitmap as Object) as Integer
    return bitmap.GetWidth() * bitmap.GetHeight() * 4
    'return bitmap.GetByteArray(0, 0, bitmap.GetWidth(), bitmap.GetHeight()).Count()
end function

'Hack-ish method to get a scaled image from existing bitmap using bilinear algorithm. For some reason the Roku 1 does not support
'Bilinear scaling from roRegion to roScreen, only roRegion to roRegion
function RlGetScaledImage(bmp1 as Object, width as Integer, height as Integer, scaleMode = 1 as Integer) as Object
    if bmp1 = invalid then return invalid
    bmp2 = CreateObject("roBitmap", {width: width, height: height, alphaEnable: false})
    if bmp2 = invalid then return invalid
    
    'Calculate original width and height
    origWidth = bmp1.GetWidth()
    origHeight = bmp1.GetHeight()
    
    'Calculate scaling factor
    scaleX = width / origWidth
    scaleY = height / origHeight
    
    'Draw from region 1 to region 2 scaled
    rgn1 = CreateObject("roRegion", bmp1, 0, 0, origWidth, origHeight)
    if rgn1 = invalid then return invalid
    rgn1.SetScaleMode(scaleMode)
    
    rgn2 = CreateObject("roRegion", bmp2, 0, 0, width, height)
    if rgn2 = invalid then return invalid
    rgn2.DrawScaledObject(0, 0, scaleX, scaleY, rgn1)
    
    return rgn2.GetBitmap()
end function