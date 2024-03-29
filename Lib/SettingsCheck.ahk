#Requires AutoHotkey v2.0


MakeWindowActive() {
    if (!WinExist(LBRWindowTitle)) {
        Log("Error 14: Window doesn't exist.")
        return false ; Don't check further
    }
    if (!WinActive(LBRWindowTitle)) {
        WinActivate(LBRWindowTitle)
    }
    return true
}

IsWindowActive() {
    if (!WinExist(LBRWindowTitle) ||
        !WinActive(LBRWindowTitle)) {
            Log("Error 1: Window not active or doesn't exist.")
            return false
    }
    return true
}

InitGameWindow() {
    global X, Y, W, H
    if (WinExist(LBRWindowTitle)) {
        WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
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
    ; Check for afk, if it is on, click the corner of the screen
    AFKFix()
    OpenAreasPanel(false)
    ; Cannot check font here as it might not be correct res
    ; Changing res every activation would be annoying
    If (!IsAspectRatioCorrectCheck()) {
        Log("Error 15: Failed settings check at rendering mode.")
        return false
    }
    If (!IsPanelTransparentCorrectCheck()) {
        Log("Error 16: Failed settings check at transparency.")
        return false
    }
    If (!IsPanelSmoothedCheck()) {
        Log("Error 17: Failed settings check at smooth graphics.")
        return false
    }
    If (!IsDarkBackgroundCheck()) {
        Log("Error 18: Failed settings check at dark dialog background.")
        return false
    }
    return true
}

CheckGameSettingsCorrectVerbose() {
    global DisableSettingsChecks
    if (DisableSettingsChecks) {
        return true
    }
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    ; Check for afk, if it is on, click the corner of the screen
    AFKFix()
    OpenAreasPanel(false)
    if (IsAspectRatioCorrectCheck()) {
        Log("Passed Verbose Render Mode check.")
        ToolTip("Good: Correct render mode detected, F2 to dismiss",
            W / 2 - WinRelPosW(200),
            H / 2, 1)
        SetTimer(ToolTip, -3000)
    } else {
        ; If aspect ratio fails, transparency isn't aligned anyway
        return false
    }
    If (IsPanelTransparentCorrectCheck()) {
        Log("Passed Verbose Transparency check.")
        ToolTip("Good: No transparency detected, F2 to dismiss",
            W / 2 - WinRelPosW(200),
            H / 2 - WinRelPosW(20), 2)
        SetTimer(ToolTip, -3000)
    } else {
        return false
    }
    If (IsPanelSmoothedCheck()) {
        Log("Passed Smooth Graphics check.")
        ToolTip("Good: No smooth graphics detected, F2 to dismiss",
            W / 2 - WinRelPosW(200),
            H / 2 - WinRelPosW(40), 3)
        SetTimer(ToolTip, -3000)
    } else {
        return false
    }
    If (IsDarkBackgroundCheck()) {
        Log("Passed Dark Dialog Background check.")
        ToolTip("Good: No Dark Dialog Background detected, F2 to dismiss",
            W / 2 - WinRelPosW(200),
            H / 2 - WinRelPosW(60), 4)
        SetTimer(ToolTip, -3000)
    } else {
        return false
    }
    If (IsTreesSetCheck()) {
        Log("Passed Trees check.")
        ToolTip("Good: No Trees detected, F2 to dismiss",
            W / 2 - WinRelPosW(200),
            H / 2 - WinRelPosW(80), 5)
        SetTimer(ToolTip, -3000)
    } else {
        return false
    }
    return true
}

/**
 * Check for panel being open
 * @returns {number} True/False, True if a main panel is active
 */
IsPanelActive() {
    return !IsPanelTransparent()
}


/**
 * Check for panel being non standard background colour
 * @returns {number} True/False, True if a main panel is transparent
 */
IsPanelTransparent() {
    try {
        targetColour := PixelGetColor(WinRelPosW(1090), WinRelPosH(107))
        ; If its afk mode return as well, let afk check handle
        If (targetColour = "0x97714A" || targetColour = "0x6A4F34") {
            ; Found panel background colour
            return false
        }
    } catch as exc {
        Log("Error 19: Panel transparency check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    Log("Panel transparency check found " targetColour " instead of 0x97714A")
    return true
}

IsPanelTransparentCorrectCheck() {
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    If (IsPanelTransparent()) {
        MsgBox("Error: It appears you may be using menu transparency,"
            " please set to 100% then F2 to reload().`nSee Readme.md"
            " for other required settings.")
        WinActivate(LBRWindowTitle)
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
    try {
        sampleColour := PixelGetColor(WinRelPosLargeW(58),
            WinRelPosLargeH(1323))
        sampleColour2 := PixelGetColor(WinRelPosLargeW(2425),
            WinRelPosLargeH(51))
        If (sampleColour = "0xFFF1D2" || ; Normal
            sampleColour = "0xFDD28A" || ; Mouseover
            sampleColour = "0x837C6C" || ; Dark dialog background normal
            sampleColour = "0x826C47" || ; Dark dialog background mouseover
            sampleColour = "0xB3A993" || ; Afk mode normal
            sampleColour = "0xB29361" &&  ; Afk mode mouseover
            sampleColour = sampleColour2) {
                return true
        }
    } catch as exc {
        Log("Error 20: Render Mode check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    Log("Aspect ratio check found unknown colour " sampleColour)
    return false
}

IsAspectRatioCorrectCheck() {
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    If (!IsAspectRatioCorrect()) {
        Log("Error 21: Alternative rendering check failed.")
        MsgBox("Error: It appears you may be using normal render mode,"
            " please set Alternative on then F2 to reload() at the bottom of"
            " settings.`nSee Readme.md for other required settings.")
        WinActivate(LBRWindowTitle)
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
                WinRelPosLargeW(1461), WinRelPosLargeH(260),
                WinRelPosLargeW(1732), WinRelPosLargeH(1080), image)
            If (found && OutX > 0) {
                Log("Settings: Found user is using alternative font size "
                    (i - 1))
                return i
            }
            i++
        }
    } catch as exc {
        Log("Error 22: WhatFont check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    ; If we didn't match, then its not alternative
    return 0
}

IsFontCorrectCheck() {
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    font := WhatFont()
    If (font = 1 || font = 2) {
        return true
    }
    if (!font) {
        Log("Error 23: Font type check failed, not using alternative")
        MsgBox("Error: It appears you are not using alternative font type,"
            " please set to Alternative then F2 to reload().`nSee Readme.md"
            " for other required settings.")
        WinActivate(LBRWindowTitle)
        OpenPets()
        sleep(150)
        ClosePanel()
        sleep(150)
        ClosePanel() ; Settings
        return false
    }
    Log("Error 24: Font size check failed - size " (font - 1))
    MsgBox("Error: It appears you are using font size " (font - 1)
        ", please set to 0/1 then F2 to reload().`nSee Readme.md"
        " for other required settings.")
    WinActivate(LBRWindowTitle)
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
}

IsPanelSmoothed() {
    try {
        sampleColour := PixelGetColor(WinRelPosW(1095), WinRelPosH(94))
        sampleColour2 := PixelGetColor(WinRelPosW(1095), WinRelPosH(90))
        If (sampleColour != sampleColour2) {
            Log("Smoothed graphics check found " sampleColour " " sampleColour2)
            ; Found smoothing
            return true
        }
    } catch as exc {
        Log("Error 25: Panel smoothing check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

IsPanelSmoothedCheck() {
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    If (!IsPanelSmoothed()) {
        return true
    }
    Log("Error 26: Smooth graphics check failed.")
    MsgBox("Error: It appears you are using Smooth Graphics, please set"
        " to off then F2 to reload().`nSee Readme.md for other required"
        " settings.")
    WinActivate(LBRWindowTitle)
    OpenPets()
    sleep(150)
    ClosePanel()
    sleep(150)
    ClosePanel() ; Settings
    sleep(150)
    ; Set to graphics tab
    fSlowClick(443, 572)
    return false
}

IsDarkBackgroundOn() {
    try {
        sampleColour := PixelGetColor(WinRelPosLargeW(58),
            WinRelPosLargeH(1323))
        sampleColour2 := PixelGetColor(WinRelPosLargeW(2425),
            WinRelPosLargeH(51))
        If (sampleColour = "0x837C6C" || sampleColour2 = "0x837C6C" ||
            sampleColour = "0x826C47" || sampleColour2 = "0x826C47") {
                Log("Corner buttons found with Dark Dialog Background on.")
                ; Found dark mode
                return true
        }
    } catch as exc {
        Log("Error 6: Dark Dialog Background check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

IsDarkBackgroundCheck() {
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    If (!IsDarkBackgroundOn()) {
        return true
    }
    Log("Error 27: Dark Dialog Background check failed.")
    MsgBox("Error: It appears you are using Dark Dialog Background, please"
        " set to off then F2 to reload().`nSee Readme.md for other"
        " required settings.")
    WinActivate(LBRWindowTitle)
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
}

IsTreesSetCheck() {
    OpenAreasPanel(, 300)
    fSlowClick(830, 158, NavigateTime + 300)
    Sleep(NavigateTime + 300)
    if (IsAreaSampleColour("0x4A9754")) {
        return true
    } else {
        Log("Error 28: Trees check failed. " GetAreaSampleColour())
        MsgBox("Error: It appears you are using Trees, please set to"
            " off then F2 to reload().`nSee Readme.md for other"
            " required settings.")
        WinActivate(LBRWindowTitle)
        OpenPets()
        sleep(150)
        ClosePanel()
        sleep(150)
        ClosePanel() ; Settings
        sleep(150)
        ; Set to graphics tab
        fSlowClick(443, 572)
        Sleep(101)
        ScrollAmountDown(5)
        return false
    }

}

IsAFKOn() {
    try {
        sampleColour := PixelGetColor(WinRelPosLargeW(58),
            WinRelPosLargeH(1323))
        sampleColour2 := PixelGetColor(WinRelPosLargeW(2425),
            WinRelPosLargeH(51))
        If (sampleColour = "0xB3A993" || ; Afk mode normal
            sampleColour = "0xB29361" || ; Afk mode mouseover
            sampleColour2 = "0xB3A993" || ; Afk mode normal
            sampleColour2 = "0xB29361"  ; Afk mode mouseover
        ) {
            Log("IsAFKOn: Corner buttons found with AFK on.")
            ; Found dark mode
            return true
        }
    } catch as exc {
        Log("Error 34: AFK check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

AFKFix() {
    if (!IsWindowActive()) {
        return false ; Kill if no game
    }
    If (!IsAFKOn()) {
        return true
    }
    Log("Warning 1: AFK found enabled.")
    fSlowClick(5, 5)
    return false
}