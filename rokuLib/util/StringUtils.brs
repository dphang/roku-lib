'General string utilities

'Converts a string into stars (for passwords)
'@text the string to be obscured
'@return an obscured string
function obscureString(text as String) as String
    temp = ""
    
    max = text.Len() - 1
    for i = 0 to max
        temp = temp + "*"
    end for
    
    return temp
end function

'Tokenizes a string into an array of words (delimited by spaces and newlines) while fixing duplicate spaces
'@param text the string to be tokenized
Function stringToWords(text as String) as Object
    r = CreateObject("roRegex", "(\n|\r|\t| )+", "")
    return r.Split(text)
end function

'Converts time in seconds to an HH:MM string
'@param time an integer number of seconds
'@return a string in HH:MM format 
function secondsToString(time as Integer) as String
    minutes = tostr(Int(time / 60))
    seconds = time - minutes * 60
    
    temp = ""
    if seconds < 10
        temp = temp + "0"
    end if

    temp = temp + tostr(seconds)
    
    return minutes + ":" + temp
end function
