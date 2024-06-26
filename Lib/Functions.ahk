#Requires AutoHotkey v2.0

#Include Logging.ahk
#Include Spammers.ahk
#Include cPoints.ahk
#Include cRects.ahk

global LBRWindowTitle

; ------------------- Functions -------------------

; Convert positions from 2560*1369 client resolution to current resolution to
; allow higher accuracy
WinRelPosLargeW(PosW2) {
    global W
    return PosW2 / 2560 * W
}

; Convert positions from 2560*1369 client resolution to current resolution to
; allow higher accuracy
WinRelPosLargeH(PosH2) {
    global H
    return PosH2 / 1369 * H
}

; Custom clicking function, uses 2560*1369 relative coords
fSlowClickRelL(clickX, clickY, delay := 34) {
    if (!IsWindowActive()) {
        Log("No window found while trying to Lclick at " clickX " * " clickY
            "`n Rel: " WinRelPosLargeW(clickX) " * " WinRelPosLargeH(clickY))
        return false
    }
    MouseClick("left", WinRelPosLargeW(clickX),
        WinRelPosLargeH(clickY), , , "D")
    Sleep(delay)
    MouseClick("left", WinRelPosLargeW(clickX),
        WinRelPosLargeH(clickY), , , "U")
}

; Custom clicking function, uses given coords no relative correction
fCustomClick(clickX, clickY, delay := 34) {
    if (!IsWindowActive()) {
        Log("No window found while trying to click at " clickX " * " clickY)
        return false
    }
    MouseClick("left", clickX, clickY, , , "D")
    Sleep(delay)
    MouseClick("left", clickX, clickY, , , "U")
}

ResetModifierKeys() {
    ; Cleanup incase still held, ahk cannot tell if the key has been sent as up
    ; getkeystate reports the key, not what lbr has been given
    if (IsWindowActive()) {
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
    switch num {
        case 10:
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        case 25:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
        case 100:
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
        case 250:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        case 1000:
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        case 2500:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
        case 25000:
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
    if (!Points.Misc.NotifArrow.IsButtonOffPanel()) {
        return true
    }
    return false
}

IsBossTimerActive() {
    if (!Rects.Misc.BossTimer.PixelSearch()) {
        return false
    }
    return true
}

IsBossTimerLong() {
    if (!Rects.Misc.BossTimerLong.PixelSearch()) {
        return false
    }
    return true
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
    try {
        ; if no width, and y has length
        if (x1 = x2 && y1 < y2) {
            ; Starting point
            i := y1
            while (i <= y2) {
                colour := PixelGetColor(x1, i)
                if (foundArr.Length = 0 || lastColour != colour) {
                    foundArr.Push({ x: x1, y: i, colour: colour })
                    lastColour := colour
                }
                i++
            }
            return foundArr
        }
        ; if no height, and x has length
        if (y1 = y2 && x1 < x2) {
            ; Starting point
            i := x1
            while (i <= x2) {
                colour := PixelGetColor(i, y1)
                if (foundArr.Length = 0 || foundArr[foundArr.Length].colour != colour) {
                    foundArr.Push({ x: i, y: y1, colour: colour })
                }
                i++
            }
            return foundArr
        }
    } catch as exc {
        Log("Error 9: LineGetColourInstances check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
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
    while splitCur < splitCount {
        yTop := y1 + (splitCur * splitSize)
        yBot := y1 + ((splitCur + 1) * splitSize)
        result := cRect(x, yTop, x, yBot).PixelSearch(colour)
        if (result) {
            ; DebugLog("Found in segment " splitCur " at " result[1] " by " result[2])
            found++
            foundArr.Push(result[2])
        }
        splitCur++
    }
    if (found) {
        return foundArr
    }
    return false
}

IsScrollAblePanel() {
    if (Points.Misc.ScrollArrow.IsButtonActive()) {
        ; Up Arrow exists, so scrolling is possible
        return true
    }
    return false
}

IsScrollAblePanelAtTop() {
    ; 2220 320 scroll handle
    if (IsScrollAblePanel()) {
        if (Points.Misc.ScrollHandle.IsButtonActive()) {
            ; Is at top
            return true
        }
    }
    return false
}

IsBVScrollAblePanelAtTop() {
    ; 2220 258 top scroll arrow button
    ; 2220 320 scroll handle
    if (Points.Misc.ScrollArrow.IsButtonActive()) {
        ; Up Arrow exists, so scrolling is possible
        if (Points.Misc.ScrollHandle.IsButtonActive()) {
            ; Is at top
            return true
        } else {
            return false
        }
    }
    return true
}

cReload() {
    Reload()
}

ReloadIfNoGame() {
    if (!GameWindowExist() || !IsWindowActive()) {
        cReload() ; Kill if no game
        return
    }
}

InitScriptHotKey() {
    KillAllSpammers()
    ReloadIfNoGame()
    ResetModifierKeys() ; Cleanup incase needed
}

BinaryToStr(var) {
    if (var) {
        return "true"
    }
    return "false"
}

ArrToCommaDelimStr(var) {
    output := ""
    if (Type(var) = "String") {
        if (var = "") {
            return false
        }
        return var
    }
    if (var.Length > 1) {
        for text in var {
            if (output != "") {
                output := output ", " text
            } else {
                output := text
            }
        }
        return output
    } else {
        return false
    }
}

CommaDelimStrToArr(var) {
    return StrSplit(var, " ", ",.")
}