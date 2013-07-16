'Represents a text area with x, y coordinates and should fit within a width and height
'@param text the text to be shown in the TextArea
'@param font the font to be used
'@param x the x coordinate
'@param y the y coordinate
'@param width the maximum width of this TextArea
'@param height the maximum height of this TextArea
'@param maxLines the maximum number of lines of text that should be displayed
'@param spacing a float specifying the distance between lines. E.g. 2.0 will result in double spaced lines
'@param return a TextArea object
Function TextArea(text as String, font as Object, x as Float, y as Float, width as Float, height as Float, maxLines as Integer, spacing as Float, align = "left" as String) As Object
    this = {
        type: "TextArea" 
        text: text
        x: x
        y: y
        width: width
        height: height
        maxLines: maxLines
        spacing: spacing
        
        draw: TextArea_draw
        setText: TextArea_setText
    }
    this.initialize() 'Initialize all lines in the TextArea
    
    return this
End Function

'Draw this TextArea object to the specified screen
'@param screen a roScreen object
Function TextArea_draw(screen as Object) As Void
    for each line in m.lines
        line.draw(screen)
    end for
End Function

'Sets the text of this TextArea
'@param text the text to be shown in the TextArea
Function TextArea_setText(text as String) As Void
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
        m.lines = TextLine(lines[i], m.font, m.color, m.x, m.y + i * m.spacing * m.font.GetOneLineHeight(), align)
    end for
End Function