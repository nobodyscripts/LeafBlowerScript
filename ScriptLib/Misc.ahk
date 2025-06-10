#Requires AutoHotkey v2.0

#Include cLogging.ahk
#Include cGameWindow.ahk
#Include cPoint.ahk
#Include cRect.ahk

; ------------------- Functions -------------------

; Custom clicking function, uses given coords no relative correction
fCustomClick(clickX, clickY, delay := 34) {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to click at " clickX " * " clickY)
        Return false
    }
    MouseClick("left", clickX, clickY, , , "D")
    Sleep(delay)
    MouseClick("left", clickX, clickY, , , "U")
    Out.V("Clicking at " cPoint(clickX, clickY, false).toStringDisplay())
}

ResetModifierKeys() {
    If (Window.Exist() && Window.IsActive()) {
        ControlSend("{Control up}", , Window.Title)
        ControlSend("{Alt up}", , Window.Title)
        ControlSend("{Shift up}", , Window.Title)
    }
}

SetModifierKeys(ctrl := false, alt := false, shift := false) {
    If (Window.Exist() && Window.IsActive()) {
        If (ctrl) {
            ControlSend("{Control down}", , Window.Title)
        }
        If (alt) {
            ControlSend("{Alt down}", , Window.Title)
        }
        If (shift) {
            ControlSend("{Shift down}", , Window.Title)
        }
    }
}

/**
 * For a given 1px wide strip horizontally or vertically, get all blocks
 * of colour from the first point reached.
 * @param x1 Top left Coordinate (non relative)
 * @param y1 Top left Coordinate (non relative)
 * @param x2 Bottom Right Coordinate (non relative)
 * @param y2 Bottom Right Coordinate (non relative)
 * @returns {array|number} returns array of { x, y, colour } or false
 */
LineGetColourInstances(x1, y1, x2, y2) {
    ; Returns array of points and colours {x, y, colour}
    ; Detects when the colour changes to remove redundant entries
    foundArr := []
    lastColour := ""
    Try {
        ; if no width, and y has length
        If (x1 = x2 && y1 < y2) {
            ; Starting point
            i := y1
            While (i <= y2) {
                colour := PixelGetColor(x1, i)
                If (foundArr.Length = 0 || lastColour != colour) {
                    foundArr.Push({
                        x: x1,
                        y: i,
                        colour: colour
                    })
                    lastColour := colour
                }
                i++
            }
            Return foundArr
        }
        ; if no height, and x has length
        If (y1 = y2 && x1 < x2) {
            ; Starting point
            i := x1
            While (i <= x2) {
                colour := PixelGetColor(i, y1)
                If (foundArr.Length = 0 || foundArr[foundArr.Length].colour !=
                    colour) {
                    foundArr.Push({
                        x: i,
                        y: y1,
                        colour: colour
                    })
                }
                i++
            }
            Return foundArr
        }
    } Catch As exc {
        Out.E("LineGetColourInstances check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n" exc
            .Message)
    }
    Return false
}

/**
 * 
 * @param x 
 * @param y1 
 * @param y2 
 * @param colour 
 * @param {number} splitCount 
 * @returns {array|number} false if nothing, array of Y heights if found
 */
LineGetColourInstancesOffsetV(x, y1, y2, colour, splitCount := 20) {
    splitSize := (y2 - y1) / splitCount
    splitCur := 0
    foundArr := []
    found := 0
    ; Because checking every pixel takes 7 seconds, lets split up the line
    ; use pixelsearch and try to find a balance where we don't get overlap
    While splitCur < splitCount {
        yTop := y1 + (splitCur * splitSize)
        yBot := y1 + ((splitCur + 1) * splitSize)
        result := cRect(x, yTop, x, yBot).PixelSearch(colour)
        If (result) {
            ; Out.D("Found in segment " splitCur " at " result[1] " by " result[2])
            found++
            foundArr.Push(result[2])
        }
        splitCur++
    }
    If (found) {
        Return foundArr
    }
    Return false
}


;@region Type functions
ArrToCommaDelimStr(var) {
    output := ""
    If (Type(var) = "String") {
        If (var = "") {
            Return false
        }
        Return var
    }
    If (var.Length > 1) {
        For text in var {
            If (output != "") {
                output := output ", " text
            } Else {
                output := text
            }
        }
        Return output
    } Else {
        Return false
    }
}

CommaDelimStrToArr(var) {
    Return StrSplit(var, " ", ",.")
}

ObjToString(var) {
    output := Type(var) " {`r`n"
    For Name, Value in var.OwnProps() {
        output .= name ": " ObjToString(Value) ",`r`n"
    }
    output .= "}"

}

ToStr(var) {
    Switch (Type(var)) {
    Case "String":
        Return var
    Case "Array":
        Return ArrToCommaDelimStr(var)
    Case "Object":
        Return ObjToString(var)
    Case "Integer":
        Return var
    Case "Float":
        Return var
    default:
        Return ObjToString(var)
    }
}

BinToStr(var) {
    If (var) {
        Return "true"
    }
    Return "false"
}

StrToBin(var) {
    If (var = "false") {
        Return false
    }
    If (var = "true") {
        Return true
    }
    Throw ValueError("Unknown value fed to Boolean setting")
}

IsBool(var) {
    If (IsInteger(var) && (var = 0 || var = 1)) {
        Return true
    }
    Return false
}
;@endregion

;@region HexColToDecCol()
/**
 * Convert hex colour values to base 10 decimal array
 * @param colour 0xFFFFFF
 * @returns {Array} [255,255,255]
 */
HexColToDecCol(colour) {
    returnArr := []
    first := "0x" SubStr(colour, 3, 2)
    second := "0x" SubStr(colour, 5, 2)
    third := "0x" SubStr(colour, 7, 2)
    first *= 1
    second *= 1
    third *= 1

    returnArr.Push(Format("{:d}", first))
    returnArr.Push(Format("{:d}", second))
    returnArr.Push(Format("{:d}", third))
    Return returnArr
}
;@endregion

;@region Diff()
/**
 * Provide two 0xFFFFFF formatted colours and return a difference between them
 * @param cOne 0xFFFFFF
 * @param cTwo 0xFFFFFF
 * @returns {Float} Numeric difference between the two colours
 */
ColourDiff(cOne, cTwo) {
    one := HexColToDecCol(cOne)
    two := HexColToDecCol(cTwo)
    red := (one[1] - two[1]) * (one[1] - two[1])
    blue := (one[2] - two[2]) * (one[2] - two[2])
    green := (one[3] - two[3]) * (one[3] - two[3])
    Out.D("Diffing Colours: " cOne " " cTwo " " Sqrt(red + blue + green))
    Return Sqrt(red + blue + green)
}
;@endregion
