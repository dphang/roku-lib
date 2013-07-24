'Bilinear image scaler for raw bitmap data.
function BilinearScale(pixels as Object, width as Float, height as Float, newWidth as Float, newHeight as Float) as Object
    'Get the dimensions of the original pixel array
    width = pixels.Count()
    height = pixels[0].Count()
    
    'Initialize new pixel array
    newPixels = CreateObject("roArray", newWidth * newHeight)
    x_ratio = width / newWidth
    y_ratio = height / newHeight
    
    offset = 0
    
    for i = 0 to newHeight * 4 step 4
        for j = 0 to newWidth * 4 step 4
            x = int(x_ratio * j)
            y = int(y_ratio * i)
            x_diff = (x_ratio * j) - x
            y_diff = (y_ratio * i) - y
            index = y * w + x
            
            
            r = pixels[index]
            g = pixels[index + 1]
            b = pixels[index + 2]
            a = pixels[index + 3]
        end for
    end for
end function