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
        ;ToolTip(targetColour, screenX, screenY)
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

InitGameWindow() {
    global X, Y, W, H
    if (IsWindowActive()) {
        WinGetClientPos(&X, &Y, &W, &H, "Leaf Blower Revolution")
        return true
    }
    return false
}

CheckGameSettingsCorrect() {
    global DisableSettingsChecks
    if (DisableSettingsChecks) {
        return true
    }
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    OpenAreasPanel(false)
    ; Cannot check font here as it might not be correct res
    ; Changing res every activation would be annoying
    If (IsAspectRatioCorrectCheck() && IsPanelTransparentCorrectCheck()) {
        return true
    }
    Log("Error: Failed settings check.")
    return false
}

CheckGameSettingsCorrectVerbose() {
    global DisableSettingsChecks
    if (DisableSettingsChecks) {
        return true
    }
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    OpenAreasPanel(false)
    if (IsAspectRatioCorrectCheck()) {
        Log("Passed Verbose Render Mode check.")
        ToolTip("Correct render mode detected, F2 to dismiss",
            W / 2 - WinRelPosW(110),
            H / 2 - WinRelPosW(20), 1)
        SetTimer(ToolTip, -3000)
    } else {
        ; If aspect ratio fails, transparency isn't aligned anyway
        return false
    }
    If (IsPanelTransparentCorrectCheck()) {
        Log("Passed Verbose Transparency check.")
        ToolTip("No transparency detected, F2 to dismiss",
            W / 2 - WinRelPosW(100),
            H / 2, 2)
        SetTimer(ToolTip, -3000)
    } else {
        return false
    }
    return true
}

IsPanelTransparent() {
    try {
        targetColour := PixelGetColor(WinRelPosW(1095), WinRelPosH(94))
        If (targetColour = "0x97714A") {
            ; Found background colour
            return false
        }
    } catch as exc {
        Log("Error: Panel transparency check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return true
}

IsPanelTransparentCorrectCheck() {
    global HaveErroredToSettings
    if (HaveErroredToSettings) {
        return false
    }
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    If (IsPanelTransparent()) {
        HaveErroredToSettings := true
        MsgBox("Error: It appears you may be using menu transparency, please set to 100% then F2 to reload().`nSee Readme.md for other required settings.")
        WinActivate("Leaf Blower Revolution")
        OpenPets()
        sleep(150)
        ClosePanel()
        sleep(150)
        ClosePanel() ; Settings
        sleep(150)
        ; Set to graphics tab
        fSlowClick(443, 572)
        Sleep(101)
        ScrollAmountDown(32)
        return false
    } Else {
        return true
    }
}

IsAspectRatioCorrect() {
    ;54 1328 (lower left of lower left hide button)
    ;2425 51 (top right of top right hide button)
    ;colour1 := PixelGetColor(WinRelPosLargeW(58), WinRelPosLargeH(1323))
    ;colour2 := PixelGetColor(WinRelPosLargeW(2425), WinRelPosLargeH(51))
    ;MsgBox(colour1 . " " . colour2)
    if (IsButtonActive(WinRelPosLargeW(58), WinRelPosLargeH(1323)) &&
        IsButtonActive(WinRelPosLargeW(2425), WinRelPosLargeH(51))) {
            return true
    } else {
        return false
    }
}

IsAspectRatioCorrectCheck() {
    global HaveErroredToSettings
    if (HaveErroredToSettings) {
        return false
    }
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    If (!IsAspectRatioCorrect()) {
        HaveErroredToSettings := true
        Log("Error: Alternative rendering check failed.")
        MsgBox("Error: It appears you may be using normal render mode, please set to Alternative then F2 to reload().`nSee Readme.md for other required settings.")
        WinActivate("Leaf Blower Revolution")
        OpenPets()
        sleep(150)
        ClosePanel()
        sleep(150)
        ClosePanel() ; Settings
        ; Not trying to click tab and scroll because window is known misaligned
        return false
    } else {
        return true
    }
}

WhatFont() {
    OpenPets()
    sleep(150)
    ClosePanel()
    sleep(150)
    ClosePanel() ; Settings
    sleep(150)
    fSlowClick(386, 572, 101)
    sleep(150) ; Resetting tab to make sure scroll is at top
    fSlowClick(443, 572, 101) ; Set to graphics tab
    sleep(150)
    Images := ["Images\AlternativeFontSize0.png",
        "Images\AlternativeFontSize1.png",
        "Images\AlternativeFontSize2.png",
        "Images\AlternativeFontSize3.png",
        "Images\AlternativeFontSize4.png",
        "Images\AlternativeFontSize5.png",
        "Images\AlternativeFontSize6.png",
        "Images\AlternativeFontSize7.png",
        "Images\AlternativeFontSize8.png",
        "Images\AlternativeFontSize9.png",
        "Images\AlternativeFontSize10.png"]
    i := 1
    try {
        for image in Images {
            ; 1480 765 (font size 0, tl)
            ; 1732 822 (font size 0, br)
            ; 1461 755 (font size 10, tl)
            ; 1682 819 (font size 10, br)
            found := ImageSearch(&OutX, &OutY,
                WinRelPosLargeW(1461), WinRelPosLargeH(755),
                WinRelPosLargeW(1732), WinRelPosLargeH(822), image)
            If (found && OutX > 0) {
                Log("Settings: Found user is using alternative font size "
                    (i - 1))
                return i
            }
            i++
        }
    } catch as exc {
        Log("Error: WhatFont check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    ; If we didn't match, then its not alternative
    return 0
}

IsFontCorrectCheck() {
    global HaveErroredToSettings
    if (HaveErroredToSettings) {
        return false
    }
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    font := WhatFont()
    If (font = 1 || font = 2) {
        return true
    }
    HaveErroredToSettings := true
    if (!font) {
        Log("Error: Font type check failed, not using alternative")
        MsgBox("Error: It appears you are not using alternative font type, please set to Alternative then F2 to reload().`nSee Readme.md for other required settings.")
        WinActivate("Leaf Blower Revolution")
        OpenPets()
        sleep(150)
        ClosePanel()
        sleep(150)
        ClosePanel() ; Settings
        return false
    }
    Log("Error: Font size check failed - size " (font - 1))
    MsgBox("Error: It appears you are using font size " . (font - 1) . ", please set to 0/1 then F2 to reload().`nSee Readme.md for other required settings.")
    WinActivate("Leaf Blower Revolution")
    OpenPets()
    sleep(150)
    ClosePanel()
    sleep(150)
    ClosePanel() ; Settings
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

MakeWindowActive() {
    if !WinExist("Leaf Blower Revolution") {
        Log("Error: Window doesn't exist.")
        return false ; Don't check further
    }
    if (!WinActive("Leaf Blower Revolution")) {
        WinActivate("Leaf Blower Revolution")
    }
    return true
}

IsWindowActive() {
    if (!WinExist("Leaf Blower Revolution") ||
        !WinActive("Leaf Blower Revolution")) {
            Log("Error: Window not active or doesn't exist.")
            return false
    }
    return true
}

/*

    if (!IsWindowActive()) {
        return ; Kill if no game
    }
    if (!MakeWindowActive()) {
        return ; Kill early if no game
    }

*/

; My god outputting some debug is annoying with tooltips
; Lets try to make this more sane
Log(logmessage, logfile := A_ScriptDir "\LeafBlowerV3.Log") {
    if (EnableLogging) {
        FileAppend(FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) ' - ' logmessage '`r`n', logfile)
    }
}