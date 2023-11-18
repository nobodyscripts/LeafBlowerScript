#Requires AutoHotkey v2.0

; ------------------- Functions -------------------

; Convert positions from 1278*664 client resolution to current resolution
WinRelPosW(PosW) {
    return PosW / 1278 * W
}

WinRelPosH(PosH) {
    return PosH / 664 * H
}

; Convert positions from 2560*1396 client resolution to current resolution to
; allow higher accuracy
WinRelPosLargeW(PosW2) {
    return PosW2 / 2560 * W
}

WinRelPosLargeH(PosH2) {
    return PosH2 / 1369 * H
}

; Default clicking function, uses relative locations
fSlowClick(clickX, clickY, delay := 34) {
    MouseClick("left", WinRelPosW(clickX), WinRelPosH(clickY), , , "D")
    Sleep(delay) ; Must be higher than 16.67 which is a single frame of 60fps,
    ; set to slightly higher than 2 frames for safety
    ; If clicking isn't reliable increase this sleep value
    MouseClick("left", WinRelPosW(clickX), WinRelPosH(clickY), , , "U")
}

; Custom clicking function, swap the above to this if you want static coords
; that are more easily changed
fSlowClickRelL(clickX, clickY, delay := 34) {
    MouseClick("left", WinRelPosLargeW(clickX), WinRelPosLargeH(clickY), , , "D")
    Sleep(delay)
    /* Must be higher than 16.67 which is a single frame of 60fps,
    set to slightly higher than 2 frames for safety
    If clicking isn't reliable increase this sleep value */
    MouseClick("left", WinRelPosLargeW(clickX), WinRelPosLargeH(clickY), , , "U")
}

; Custom clicking function, swap the above to this if you want static coords
; that are more easily changed
fCustomClick(clickX, clickY, delay := 34) {
    MouseClick("left", clickX, clickY, , , "D")
    Sleep(delay)
    /* Must be higher than 16.67 which is a single frame of 60fps,
    set to slightly higher than 2 frames for safety
    If clicking isn't reliable increase this sleep value */
    MouseClick("left", clickX, clickY, , , "U")
}

ResetModifierKeys() {
    ; Cleanup incase still held, ahk cannot tell if the key has been sent as up
    ; getkeystate reports the key, not what lbr has been given

    ControlSend("{Control up}", , "Leaf Blower Revolution")
    ControlSend("{Alt up}", , "Leaf Blower Revolution")
    ControlSend("{Shift up}", , "Leaf Blower Revolution")
}

IsButtonActive(screenX, screenY) {
    ; Position less important as just checking if not background X2120
    try {
        targetColour := PixelGetColor(screenX, screenY)
        ; Active, ActiveMouseOver, AfkActive, AfkActiveMouseover
        If (targetColour = "0xFFF1D2" || targetColour = "0xFDD28A" ||
            targetColour = "0xB3A993" || targetColour = "0xB29361") {
                return true
        }

    } catch as exc {
        Log("Error: IsButtonActive check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

IsButtonInactive(screenX, screenY) {
    try {
        targetColour := PixelGetColor(screenX, screenY)
        If (targetColour = "0xC8BDA5") {
            ; Check button for non background colour
            return true
        }
    } catch as exc {
        Log("Error: IsButtonInactive check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

IsBackground(screenX, screenY) {
    try {
        targetColour := PixelGetColor(screenX, screenY)
        If (targetColour = "0x97714A") {
            ; Found background colour
            return true
        }
    } catch as exc {
        Log("Error: IsBackground check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

IsCoveredByNotification(ScreenX, ScreenY) {
    ; Check for colour not being background, button, mouseover button, inactive button
    try {
        targetColour := PixelGetColor(screenX, screenY)
        ;ToolTip(targetColour, screenX, screenY)
        If (targetColour = "0xFFF1D2" || targetColour = "0xFDD28A" ||
            targetColour = "0x97714A" || targetColour = "0xC8BDA5") {
                ; Check cancel button for non background colour
                return false
        }
    } catch as exc {
        Log("Error: IsCoveredByNotification check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return true
}

IsBossTimerActive() {
    ; if white is in this area, timer active (hopefully no zones have white bg
    ; and text is pure white)
    ; 1240 5
    ; 1280 40
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1240), WinRelPosLargeH(5),
            WinRelPosLargeW(1280), WinRelPosLargeH(40), "0xFFFFFF", 0)
        ; Timer pixel search
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        Log("Error: IsBossTimerActive check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

PixelSearchWrapper(x1, y1, x2, y2, colour) {
    try {
        found := PixelSearch(&OutX, &OutY,
            x1, y1,
            x2, y2, colour, 0)
        If (!found || OutX = 0) {
            return false
        }
    } catch as exc {
        Log("Error: PixelSearchWrapper check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return [OutX, OutY]
}

PixelSearchWrapperRel(x1, y1, x2, y2, colour) {
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(x1), WinRelPosLargeH(y1),
            WinRelPosLargeW(x2), WinRelPosLargeH(y2), colour, 0)
        If (!found || OutX = 0) {
            return false
        }
    } catch as exc {
        Log("Error: PixelSearchWrapperRel check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return [OutX, OutY]
}

LineGetColourInstances(x1, y1, x2, y2) {
    ; Returns array of points and colours {x, y, colour}
    ; Detects when the colour changes to remove redundant entries
    foundArr := []
    try {
        ; if no width, and y has length
        if (x1 = x2 && y1 < y2) {
            ; Starting point
            i := y1
            while (i <= y2) {
                colour := PixelGetColor(x1, i)
                if (foundArr.Length > 0) {
                    if (foundArr[foundArr.Length].colour != colour) {
                        foundArr.Push({ x: x1, y: i, colour: colour })
                    }
                } else {
                    ; No length so no check for previous colour
                    foundArr.Push({ x: x1, y: i, colour: colour })
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
                if (foundArr.Length > 0) {
                    if (foundArr[foundArr.Length].colour != colour) {
                        foundArr.Push({ x: i, y: y1, colour: colour })
                    }
                } else {
                    ; No length so no check for previous colour
                    foundArr.Push({ x: x1, y: i, colour: colour })
                }
                i++
            }
            return foundArr
        }
    } catch as exc {
        Log("Error: LineGetColourInstances check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}


; My god outputting some debug is annoying with tooltips
; Lets try to make this more sane
Log(logmessage, logfile := A_ScriptDir "\LeafBlowerV3.Log") {
    if (EnableLogging) {
        FileAppend(FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) ' - ' logmessage '`r`n', logfile)
    }
}