#Requires AutoHotkey v2.0

#Include Logging.ahk
#Include Spammers.ahk
#Include cPoints.ahk
#Include cRects.ahk

Global LBRWindowTitle

; ------------------- Functions -------------------

; Convert positions from 2560*1369 client resolution to current resolution to
; allow higher accuracy
WinRelPosLargeW(PosW2) {
    Global W
    Return PosW2 / 2560 * W
}

; Convert positions from 2560*1369 client resolution to current resolution to
; allow higher accuracy
WinRelPosLargeH(PosH2) {
    Global H
    Return PosH2 / 1369 * H
}

; Custom clicking function, uses 2560*1369 relative coords
fSlowClickRelL(clickX, clickY, delay := 34) {
    If (!IsWindowActive()) {
        Log("No window found while trying to Lclick at " clickX " * " clickY
            "`n Rel: " WinRelPosLargeW(clickX) " * " WinRelPosLargeH(clickY))
        Return false
    }
    MouseClick("left", WinRelPosLargeW(clickX), WinRelPosLargeH(clickY), , ,
        "D")
    Sleep(delay)
    MouseClick("left", WinRelPosLargeW(clickX), WinRelPosLargeH(clickY), , ,
        "U")
}

; Custom clicking function, uses given coords no relative correction
fCustomClick(clickX, clickY, delay := 34) {
    If (!IsWindowActive()) {
        Log("No window found while trying to click at " clickX " * " clickY)
        Return false
    }
    MouseClick("left", clickX, clickY, , , "D")
    Sleep(delay)
    MouseClick("left", clickX, clickY, , , "U")
    VerboseLog("Clicking at " cPoint(clickX, clickY, false).toStringDisplay())
}

ResetModifierKeys() {
    ; Cleanup incase still held, ahk cannot tell if the key has been sent as up
    ; getkeystate reports the key, not what lbr has been given
    If (IsWindowActive()) {
        ControlSend("{Control up}", , LBRWindowTitle)
        ControlSend("{Alt up}", , LBRWindowTitle)
        ControlSend("{Shift up}", , LBRWindowTitle)
    }
}

AmountToModifier(num) {
    /*
    shift 10
    ctrl 25
    alt 100
    */
    Switch num {
        Case 10:
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        Case 25:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
        Case 100:
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
        Case 250:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        Case 1000:
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        Case 2500:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
        Case 25000:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        default:
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
    }
}

IsNotificationActive() {
    If (!Points.Misc.NotifArrow.IsButtonOffPanel()) {
        Return true
    }
    Return false
}

IsBossTimerActive() {
    If (!Rects.Misc.BossTimer.PixelSearch()) {
        Return false
    }
    Return true
}

IsBossTimerLong() {
    If (!Rects.Misc.BossTimerLong.PixelSearch()) {
        Return false
    }
    Return true
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
        Log("Error 9: LineGetColourInstances check failed - " exc.Message)
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
            ; DebugLog("Found in segment " splitCur " at " result[1] " by " result[2])
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

IsScrollAblePanel() {
    If (Points.Misc.ScrollArrow.IsButtonActive()) {
        ; Up Arrow exists, so scrolling is possible
        Return true
    }
    Return false
}

IsScrollAblePanelAtTop() {
    ; 2220 320 scroll handle
    If (IsScrollAblePanel()) {
        If (Points.Misc.ScrollHandle.IsButtonActive()) {
            ; Is at top
            Return true
        }
    }
    Return false
}

IsBVScrollAblePanelAtTop() {
    ; 2220 258 top scroll arrow button
    ; 2220 320 scroll handle
    If (Points.Misc.ScrollArrow.IsButtonActive()) {
        ; Up Arrow exists, so scrolling is possible
        If (Points.Misc.ScrollHandle.IsButtonActive()) {
            ; Is at top
            Return true
        } Else {
            Return false
        }
    }
    Return true
}

cReload() {
    Reload()
}

ReloadIfNoGame() {
    If (!GameWindowExist() || !IsWindowActive()) {
        cReload() ; Kill if no game
        Return
    }
}

InitScriptHotKey() {
    KillAllSpammers()
    ReloadIfNoGame()
    ResetModifierKeys() ; Cleanup incase needed
}

BinaryToStr(var) {
    If (var) {
        Return "true"
    }
    Return "false"
}

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