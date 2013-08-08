'Represents text that has bold and non-bold parts. Essentially, it's a special case of a horizontal group, consisting of RlText components.
function RlMultiText(text as String, font as Object, rgba as Integer, x = 0 as integer, y = 0 as integer) as Object
    this = RlVerticalGroup(0, x, y)
    
    r = CreateObject("roRegex", "{.+}")
end function