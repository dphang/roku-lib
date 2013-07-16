'PNG writer/encoder in BrightScript. Adapted from github.com/jcrocholl/pypng
function PNG(width as Integer, height as Integer, transparent = false as Boolean, background = false as Boolean, gamma = false as Boolean, greyscale = false as Boolean, bytes_per_sample = 1 as Integer) as Object
    this = {
        width: width
        height: height
        transparent: transparent
        background: background
        gamma: gamma
        greyscale: greyscale
        has_alpha: has_alpha
        bytes_per_sample: bytes_per_sample
        compression: compression
        chunk_limit: chunk_limit
        interlaced: interlaced
        
        'Member functions
        Write: PNG_Write
        Write_Chunk: PNG_Write_Chunk
    }
    
    return this
end function

'Write a PNG file to the specified path
'@param path a valid filepath
'@return true if successful
function PNG_Write(path as String) as Boolean
    ba = CreateObject("roByteArray")
    
    'http://www.w3.org/TR/PNG/#5PNG-file-signature
end function

'Write a PNG chunk to the specified byteArray
function PNG_Write_Chunk(byteArray as Object) as Boolean
    
end function