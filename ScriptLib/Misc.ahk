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
    If (Type(var) != "Array") {
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
