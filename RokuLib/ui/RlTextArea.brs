'Represents a text area with x, y coordinates and should fit within a width and height
'@param text the text to be shown in the RlTextArea
'@param font the font to be used
'@param x the x coordinate
'@param y the y coordinate
'@param width the maximum width of this RlTextArea
'@param height the maximum height of this RlTextArea
'@param maxLines the maximum number of lines of text that should be displayed
'@param spacing a Float specifying the distance between lines. E.g. 2.0 will result in double spaced lines
'@param return an RlTextArea object
function RlTextArea(text as String, font as Object, rgba as Integer, x as Integer, y as Integer, width as Integer, height as Integer, maxLines as Integer, spacing as Float, align = "left" as String) as Object
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
        SetText: TextArea_setText
    }
    this.initialize() 'Initialize all lines in the RlTextArea
    
    return this
end function

'Draw this RlTextArea object to the specified component
'@param screen a roScreen/roBitmap/roRegion object
'@return true if successful
function TextArea_Draw(component as Object) as Boolean
    for each line in m.lines
        if not line.draw(component)
            return false
        end if
    end for
    return true
end function

'Sets the text of this RlTextArea
'@param text the text to be shown in the RlTextArea
function TextArea_SetText(text as String) as Void
    words = stringToWords(text)
    wordMax = words.Count() - 1
    
    lines = []
    
    ellipses = "..."
    ellipseWidth = font.GetOneLineWidth(ellipses, 9999)
    
    for i = 0 to m.maxLines - 1
        lines[i] = ""
        
        while words.Count() > 0 and font.GetOneLineWidth(words[0], 9999) <= m.width - font.GetOneLineWidth(lines[i], 9999) 'While a word can fit in the remaining width
            if i < maxLines - 1 'Not on last line, just put the word as long as it fits
                lines[i] = lines[i] + words.Shift() + " "
            else if i = m.maxLines - 1 'Special case for the last line (possible ellipses)
                if words.Count() = 1
                    lines[i] = lines[i] + words.Shift()
                else 'Check whether we can fit that word and ellipses in remaining width
                    if font.GetOneLineWidth(words[0], 9999) + ellipseWidth <= m.width - font.GetOneLineWidth(lines[i], 9999)
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
    
    m.lines = []
    iMax = lines.Count() - 1
    
    for i = 0 to iMax
        m.lines = TextLine(lines[i], m.font, m.rgba, m.x, m.y + i * m.spacing * m.font.GetOneLineHeight(), align)
    end for
end function