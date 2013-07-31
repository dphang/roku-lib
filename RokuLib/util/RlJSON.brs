'An pseudo-asynchronous JSON parser for Brightscript
'This is achieved by breaking down the parsing into units, so that we do not run parsing continuously until it's done
function RlJSON() as Object
    this = {
    
    }
    
    return this
end function

'Sets the string to be parsed
function RlJSON_Set(json as String) as Void
    m.json = json
end function

function RlJson_Parse() as Void
    if m.json.len() > 0
    
    end if
    
    return invalid
end function

