#Requires AutoHotkey v2.0

; ------------------- Functions -------------------

; Convert positions from 1278*664 client resolution to current resolution
WinRelPosW(PosW) {
    global W
    return PosW / 1278 * W
}

WinRelPosH(PosH) {
    global H
    return PosH / 664 * H
}

; Convert positions from 2560*1396 client resolution to current resolution to
; allow higher accuracy
WinRelPosLargeW(PosW2) {
    global W
    return PosW2 / 2560 * W
}

WinRelPosLargeH(PosH2) {
    global H
    return PosH2 / 1369 * H
}

; Default clicking function, uses relative locations
fSlowClick(clickX, clickY, delay := 34) {
    if (!IsWindowActive()) {
        Log("No window found while trying to Sclick at " clickX " * " clickY
            "`n Rel: " WinRelPosW(clickX) " * " WinRelPosH(clickY))
        return false
    }
    MouseClick("left", WinRelPosW(clickX), WinRelPosH(clickY), , , "D")
    Sleep(delay) ; Must be higher than 16.67 which is a single frame of 60fps,
    ; set to slightly higher than 2 frames for safety
    ; If clicking isn't reliable increase this sleep value
    MouseClick("left", WinRelPosW(clickX), WinRelPosH(clickY), , , "U")
}

; Custom clicking function, swap the above to this if you want static coords
; that are more easily changed
fSlowClickRelL(clickX, clickY, delay := 34) {
    if (!IsWindowActive()) {
        Log("No window found while trying to Lclick at " clickX " * " clickY
            "`n Rel: " WinRelPosLargeW(clickX) " * " WinRelPosLargeH(clickY))
        return false
    }
    MouseClick("left", WinRelPosLargeW(clickX),
        WinRelPosLargeH(clickY), , , "D")
    Sleep(delay)
    /* Must be higher than 16.67 which is a single frame of 60fps,
    set to slightly higher than 2 frames for safety
    If clicking isn't reliable increase this sleep value */
    MouseClick("left", WinRelPosLargeW(clickX),
        WinRelPosLargeH(clickY), , , "U")
}

; Custom clicking function, swap the above to this if you want static coords
; that are more easily changed
fCustomClick(clickX, clickY, delay := 34) {
    if (!IsWindowActive()) {
        Log("No window found while trying to click at " clickX " * " clickY)
        return false
    }
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

    ControlSend("{Control up}", , LBRWindowTitle)
    ControlSend("{Alt up}", , LBRWindowTitle)
    ControlSend("{Shift up}", , LBRWindowTitle)
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
        Log("Error 2: IsButtonActive check failed - " exc.Message)
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
            If (Debug) {
                Log("IsButtonInactive() true: " targetColour " at " screenX "*" screenY)
            }
            return true
        }
        If (Debug) {
            Log("IsButtonInactive() false: " targetColour " at " screenX "*" screenY)
        }
    } catch as exc {
        Log("Error 3: IsButtonInactive check failed - " exc.Message)
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
        Log("Error 3: IsBackground check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

IsCoveredByNotification(ScreenX, ScreenY) {
    ; Check for colour not being background, button, mouseover button,
    ; inactive button
    try {
        targetColour := PixelGetColor(screenX, screenY)
        ;ToolTip(targetColour, screenX, screenY)
        If (targetColour = "0xFFF1D2" || targetColour = "0xFDD28A" ||
            targetColour = "0x97714A" || targetColour = "0xC8BDA5") {
                ; Check cancel button for non background colour
                return false
        }
    } catch as exc {
        Log("Error 4: IsCoveredByNotification check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return true
}

IsNonPanelButtonActive(screenX, screenY) {
    try {
        targetColour := PixelGetColor(screenX, screenY)
        ; Active, ActiveMouseOver, AfkActive, AfkActiveMouseover,
        ; DarkBgActive, DarkBgActiveMouseover
        If (targetColour = "0xFFF1D2" || targetColour = "0xFDD28A" ||
            targetColour = "0xB3A993" || targetColour = "0xB29361" ||
            targetColour = "0x837C6C" || targetColour = "0x826C47") {
                return true
        }

    } catch as exc {
        Log("Error 5: IsButtonActive check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}


IsNotificationActive() {
    if (!IsNonPanelButtonActive(WinRelPosLargeW(69),
        WinRelPosLargeH(1212))) {
            return true
    }
    return false
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
        Log("Error 7: IsBossTimerActive check failed - " exc.Message)
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
        Log("Error 8: PixelSearchWrapper check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return [OutX, OutY]
}

/**
 * Search area for first instance of colour found from top left
 * @param x1 Top left Coordinate (relative 1440)
 * @param y1 Top left Coordinate (relative 1440)
 * @param x2 Bottom Right Coordinate (relative 1440)
 * @param y2 Bottom Right Coordinate (relative 1440)
 * @returns {array|number} returns array of [ x, y ] or false
 */
PixelSearchWrapperRel(x1, y1, x2, y2, colour) {
    /*try {
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
    }*/
    return PixelSearchWrapper(WinRelPosLargeW(x1), WinRelPosLargeH(y1),
        WinRelPosLargeW(x2), WinRelPosLargeH(y2), colour)
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
        result := PixelSearchWrapperRel(x, yTop, x, yBot, colour)
        if (result) {
            if (Debug) {
                ; Log("Found in segment " splitCur " at " result[1] " by " result[2])
            }
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

LineGetColourInstancesOffsetH(x1, y1, x2, y2, offset, colour) {
    PixelSearchWrapper(x1, y1, x2, y2, colour)
}

IsScrollAblePanelAtTop() {
    ; 2220 258 top scroll arrow button
    ; 2220 320 scroll handle
    if (IsButtonActive(WinRelPosLargeW(2220), WinRelPosLargeH(258))) {
        ; Up Arrow exists, so scrolling is possible
        if (IsButtonActive(WinRelPosLargeW(2220), WinRelPosLargeH(320))) {
            ; Is at top
            return true
        }
    }
    return false
}

/**
 * Logger, user disable possible, debugout regardless of setting to vscode.
 * Far more usable than outputting to tooltips or debugging using normal means
 * due to focus changing and hotkeys overwriting
 * @param logmessage 
 * @param {string} logfile Defaults to A_ScriptDir "\LeafBlowerV3.log" but is 
 * overwritable
 */
Log(logmessage, logfile := ScriptsLogFile) {
    static isWritingToLog := false
    message := FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) ' - ' logmessage '`r`n'
    OutputDebug(message)
    if (!EnableLogging) {
        return
    }
    k := 0
    try {
        if (!isWritingToLog) {
            isWritingToLog := true
            Sleep(1)
            FileAppend(message, logfile)
            isWritingToLog := false

        }
    } catch as exc {
        OutputDebug("LogError: Error writing to log - " exc.Message "`r`n")
        ; MsgBox("Error writing to log:`n" exc.Message)
        Sleep(1)
        FileAppend(message, logfile)
        Sleep(1)
        FileAppend(FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) ' - '
            "LogError: Error writing to log - " exc.Message '`r`n', logfile)
    }
}

cReload() {
    if (Debug){
        ExitApp()
    }
    Reload()
}