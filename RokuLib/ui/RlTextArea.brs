'Represents a text area with x, y coordinates and should fit within a width and height. Optional alignment.
'@param text the String to be displayed
'@param font a roFont object
'@param x the x coordinate
'@param y the y coordinate
'@param width the maximum width of this RlTextArea
'@param height the maximum height of this RlTextArea
'@param maxLines the maximum number of lines of text that should be displayed
'@param spacing a Float specifying the distance between lines. E.g. 2.0 will result in double spaced lines
'@param align a String specifing how text should be aligned. Choices are: left, center, right
'@param return an RlTextArea object
function RlTextArea(text as String, font as Object, rgba as Integer, x as Integer, y as Integer, width = 2000 as Integer, height = 2000 as Integer, maxLines = 100 as Integer, spacing = 1.0 as Float, align = "left" as String) as Object
    this = {
        type: "RlTextArea" 
        text: text
        font: font
        rgba: rgba
        x: x
        y: y
        width: width
        height: height
        maxLines: maxLines
        spacing: spacing
        
        Draw: TextArea_draw
        Init: TextArea_setText
    }
    
    this.Init() 'Initialize all lines in the RlTextArea
    
    return this
end function

'Draws this RlTextArea object to the specified component
'@param screen a roScreen/roBitmap/roRegion object
'@return true if successful
function TextArea_Draw(component as Object) as Boolean
    for each line in m.lines
        if not line.Draw(component)
            return false
        end if
    end for
    return true
end function

'Sets the text of this RlTextArea
'@param text the text to be shown in the RlTextArea
function TextArea_Init() as Void
    words = stringToWords(m.text)
    wordMax = words.Count() - 1
    
    lines = []
    
    ellipses = "..."
    ellipseWidth = m.font.GetOneLineWidth(ellipses, 9999)
    
    tempHeight = 0
    for i = 0 to m.maxLines - 1
        'Check that we aren't exceeding the maximum height. Otherwise, simply exit the for loop
        tempHeight = tempHeight + GetFontHeight(m.font)
        if tempHeight > m.height
            exit for
        end if
        
        lines[i] = ""
       
        while words.Count() > 0 and GetFontWidth(m.font, words[0]) <= m.width - GetFontWidth(m.font, lines[i]) 'While a word can fit in the remaining width
            if i < maxLines - 1 'Not on last line, just put the word as long as it fits
                lines[i] = lines[i] + words.Shift() + " "
            else if i = m.maxLines - 1 'Special case for the last line (possible ellipses)
                if words.Count() = 1
                    lines[i] = lines[i] + words.Shift()
                else 'Check whether we can fit that word and ellipses in remaining width
                    if GetFontWidth(m.font, words[0]) + ellipseWidth <= m.width - GetFontWidth(m.font, lines[i])
                        lines[i] = lines[i] + words.Shift() + " "
                    else
                        exit while
                    end if
                end if
            end if
        end while
        
        if i = m.maxLines - 1 and words.Count() > 0 'Remaining words left on last line, put ellipses
            lines[i] = lines[i].Left(lines[i].Len() - 1) + ellipses
        end if
    end for
    
    'Make Text elements for each line
    m.textLines = []
    max = lines.Count() - 1
    for i = 0 to max
        'Calculate correct x coordinate for alignment
        if align = "center"
            tempX = m.x + (m.width - GetFontWidth(m.font, lines[i])) / 2
        else if align = "right"
            tempX = m.x + m.width - GetFontWidth(m.font, lines[i])
        else 'Default alignment is left
            tempX = m.x
        end if
        m.textLines[i] = RlText(lines[i], m.font, m.rgba, tempX, m.y + i * m.spacing * GetFontHeight(m.font))
    end for
end function