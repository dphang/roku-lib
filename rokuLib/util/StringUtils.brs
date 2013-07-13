'General string utilities

'Converts a string into stars (for passwords)
'@text the string to be obscured
'@return an obscured string
Function obscureString(text as String) as String
    temp = ""
    length = text.Len()
    for i = 0 to length - 1
        temp = temp + "*"
    end for
    return temp
End Function

'Tokenizes a string into an array of words (delimited by spaces and newlines) while fixing duplicate spaces
'@param text the string to be tokenized
Function stringToWords(text as String) as Object
    r = CreateObject("roRegex", "(\n|\r|\t| )+", "")
    return r.Split(text)
End Function

'Converts time in seconds to an HH:MM string
'@param time an integer number of seconds
'@return a string in HH:MM format 
Function secondsToString(time as Integer) as String
    minutes = Int(time / 60)
    seconds = time - minutes * 60
    
    if seconds < 10
        temp = "0" + tostr(seconds)
    end if

    temp = temp + tostr(seconds)
    
    return tostr(minutes) + ":" + temp
    
End Function
