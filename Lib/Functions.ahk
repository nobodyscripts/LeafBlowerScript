#Requires AutoHotkey v2.0

; ------------------- Functions -------------------

; Convert positions from 1278*664 client resolution to current resolution
WinRelPosW(PosW)
{
    return PosW / 1278 * W
}

WinRelPosH(PosH)
{
    return PosH / 664 * H
}

; Convert positions from 2560*1396 client resolution to current resolution to
; allow higher accuracy
WinRelPosLargeW(PosW2)
{
    return PosW2 / 2560 * W
}

WinRelPosLargeH(PosH2)
{
    return PosH2 / 1369 * H
}

; Default clicking function, uses relative locations
fSlowClick(x, y, delay := 34)
{
    MouseClick "left", WinRelPosW(x), WinRelPosH(y), , , "D"
    Sleep delay ; Must be higher than 16.67 which is a single frame of 60fps,
    ; set to slightly higher than 2 frames for safety
    ; If clicking isn't reliable increase this sleep value
    MouseClick "left", WinRelPosW(x), WinRelPosH(y), , , "U"
}

; Custom clicking function, swap the above to this if you want static coords
; that are more easily changed
fCustomClick(x, y, delay := 34)
{
    MouseClick "left", x, y, , , "D"
    Sleep delay
    /* Must be higher than 16.67 which is a single frame of 60fps,
    set to slightly higher than 2 frames for safety
    If clicking isn't reliable increase this sleep value */
    MouseClick "left", x, y, , , "U"
}

ResetModifierKeys() {
    ; Cleanup incase still held, lbr/ahk like to get stuck with them held and
    ; getkeystate shows them not down
    ;if GetKeyState("Control")
    ControlSend "{Control up}", , "Leaf Blower Revolution"
    ;if GetKeyState("Alt")
    ControlSend "{Alt up}", , "Leaf Blower Revolution"
    ;if GetKeyState("Shift")
    ControlSend "{Shift up}", , "Leaf Blower Revolution"
}

IsButtonActive(screenX, screenY) {
    ; Position less important as just checking if not background X2120
    try {
        targetColour := PixelGetColor(screenX, screenY)
        ;ToolTip(targetColour, screenX, screenY)
        If (targetColour = "0xFFF1D2" || targetColour = "0xFDD28A") {
            return true
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
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
        MsgBox ("Could not conduct the search due to the following error:`n"
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
        MsgBox ("Could not conduct the search due to the following error:`n"
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
        MsgBox ("Could not conduct the search due to the following error:`n"
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
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

IsAreaResetToGarden() {
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1240), WinRelPosLargeH(5),
            WinRelPosLargeW(1280), WinRelPosLargeH(40), "0x4A9754", 0)
        ; Timer pixel search
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

ResetAreaScroll() {
    ; Double up due to notifications
    fSlowClick(200, 574, 72) ; Click Favourites
    fSlowClick(200, 574, 72) ; Click Favourites
    Sleep 72
    fSlowClick(315, 574, 72) ; Click Back to default page to reset the scroll
    fSlowClick(315, 574, 72) ; Click Back to default page to reset the scroll
    Sleep 72
}

ScrollAmountDown(amount := 1) {
    while amount > 0 {
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                amount := 0
        } Else {
            ControlClick(, "Leaf Blower Revolution", , "WheelDown")
            Sleep 102
            amount := amount - 1
        }
    }
}

ScrollAmountUp(amount := 1) {
    while amount > 0 {
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                amount := 0
        } Else {
            ControlClick(, "Leaf Blower Revolution", , "WheelUp")
            Sleep 102
            amount := amount - 1
        }
    }
}

GoToHomeGarden() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    Sleep 150
    OpenAreas() ; Open areas
    Sleep 150
    ResetAreaScroll()

    ; Open home garden
    fSlowClick(830, 158, 100)
    Sleep 50
    if (!IsAreaResetToGarden()) {
        MsgBox("Error: Tried to set home garden but failed to confirm")
    }

}

IsPanelTransparent() {
    try {
        targetColour := PixelGetColor(WinRelPosW(1095), WinRelPosH(94))
        If (targetColour = "0x97714A") {
            ; Found background colour
            return false
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return true
}

CheckForTransparentPanels() {
    If (IsPanelTransparent()) {
        MsgBox("Error: It appears you are using menu transparency, please set to 100% then F2 to reload.`nSee Readme.md for other required settings.")
        ClosePanel()
        Sleep 150
        ClosePanel() ; Settings
        Sleep 150
        ; Set to graphics tab
        fSlowClick(443, 572)
        sleep 100
        ;MouseMove(W / 2, H / 2)
        sleep 100
        ScrollAmountDown(32)
        return true
    } Else {
        ToolTip("No transparency detected", W / 2 - WinRelPosW(50), H / 2)
        SetTimer(ToolTip, -3000)
        return false
    }
}

CheckForTransparentPanelsSilent() {
    If (IsPanelTransparent()) {
        MsgBox("Error: It appears you are using menu transparency, please set to 100% then F2 to reload.`nSee Readme.md for other required settings.")
        ClosePanel()
        Sleep 150
        ClosePanel() ; Settings
        Sleep 150
        ; Set to graphics tab
        fSlowClick(443, 572)
        sleep 100
        ;MouseMove(W / 2, H / 2)
        sleep 100
        ScrollAmountDown(32)
        return true
    } Else {
        return false
    }
}


LineGetColourInstances(x1, y1, x2, y2, colour) {
    try {
        ; 1855 276 top left 1440 res
        ; 1855 1073 bottom right
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1855), WinRelPosLargeH(276),
            WinRelPosLargeW(1855), WinRelPosLargeH(1073), "0xFFF1D2", 0)
        If (!found || OutX = 0) {
            found := PixelSearch(&OutX, &OutY,
                WinRelPosLargeW(1855), WinRelPosLargeH(276),
                WinRelPosLargeW(1855), WinRelPosLargeH(1073), "0xFDD28A", 0)
            If (!found || OutX = 0) {
                return false
            }
        }

    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return [OutX, OutY]
}

OpenEventsAreasPanel() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas
    ; is opened it doesn't close
    Sleep 150
    OpenAreas() ; Open areas
    Sleep 150
    fSlowClick(1049, 572) ; Click the event tab
    Sleep 150
    ControlClick(, "Leaf Blower Revolution", , "WheelUp") ; Align the page
    Sleep 150
}