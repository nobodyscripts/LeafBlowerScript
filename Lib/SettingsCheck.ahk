#Requires AutoHotkey v2.0

#Include Navigate.ahk

global LBRWindowTitle
global LastWindowNotActiveTimer := A_Now

InitSettingsCheck()

InitSettingsCheck() {
    global LBRWindowTitle, DisableSettingsChecks, ScriptsLogFile
    global X, Y, W, H
    if (!IsSet(LBRWindowTitle)) {
        LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
    }
    if (!IsSet(DisableSettingsChecks)) {
        DisableSettingsChecks := false
    }
    if (!isset(W)) {
        GameWindowExist()
    }
}

MakeWindowActive() {
    if (!GameWindowExist()) {
        Log("Error 14: Window doesn't exist.")
        return false ; Don't check further
    }
    if (!WinActive(LBRWindowTitle)) {
        WinActivate(LBRWindowTitle)
    }
    return true
}

IsWindowActive() {
    global LastWindowNotActiveTimer
    if (!GameWindowExist() ||
        !WinActive(LBRWindowTitle)) {
        ; Because this can be spammed lets limit rate the error log
        if (DateDiff(A_Now, LastWindowNotActiveTimer, "Seconds") >= 10) {
            Log("Error 1: Window not active or doesn't exist.")
            LastWindowNotActiveTimer := A_Now
        }
        return false
    }
    return true
}

/**
 * Fill xywh values and return bool of existance of lbr window
 * @returns {Boolean} Does LBRWindowTitle exist
 */
GameWindowExist() {
    global X, Y, W, H
    if (WinExist(LBRWindowTitle)) {
        try {
            WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
        } catch (error) {
            Log("Game window lost")
            ErrorLog(error)
            return false
        }
        return true
    }
    X := Y := W := H := 0
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
    Travel.OpenAreas()
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
        targetColour := Points.Misc.PanelBG.GetColour()
        ; If its afk mode return as well, let afk check handle
        If (targetColour = Colours().Background || targetColour = Colours().BackgroundAFK) {
            ; Found panel background colour
            return false
        }
        if (targetColour = Colours().BackgroundSpotify) {
            Log("Spotify colour warp detected, please avoid using spotify desktop.")
            return false
        }
    } catch as exc {
        Log("Error 19: Panel transparency check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
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
        return false
    } Else {
        return true
    }
}

IsAspectRatioCorrect() {
    ;54 1328 (lower left of lower left hide button)
    ;2425 51 (top right of top right hide button)
    try {
        sampleColour := Points.Misc.AspectRatio1.GetColour()
        sampleColour2 := Points.Misc.AspectRatio2.GetColour()
        If (Colours().IsButtonOffPanel(sampleColour) ||
            Colours().IsButtonOffPanel(sampleColour2) &&
            sampleColour = sampleColour2) {
            return true
        }
    } catch as exc {
        Log("Error 20: Render Mode check failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    DebugLog("Aspect ratio check found unknown colour " sampleColour)
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
        Travel.OpenSettings() ; Settings
        ; Not trying to click tab and scroll because window is known misaligned
        return false
    } else {
        return true
    }
}

IsPanelSmoothed() {
    try {
        sampleColour := Points.Misc.PanelBG2.GetColour()
        sampleColour2 := Points.Misc.PanelBG3.GetColour()
        If (sampleColour != sampleColour2) {
            DebugLog("Smoothed graphics check found " sampleColour " " sampleColour2)
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
    return false
}

IsDarkBackgroundOn() {
    try {
        sampleColour := Points.Misc.AspectRatio1.GetColour()
        sampleColour2 := Points.Misc.AspectRatio2.GetColour()
        If (Colours().IsButtonDarkened(sampleColour) ||
            Colours().IsButtonDarkened(sampleColour2)) {
            DebugLog("Corner buttons found with Dark Dialog Background on.")
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

    return false
}

IsTreesSetCheck() {
    Travel.OpenAreas(true, 300)
    Points.Areas.LeafG.HomeGarden.Click(NavigateTime + 300)
    Sleep(NavigateTime + 300)
    if (IsAreaSampleColour("0x4A9754")) {
        return true
    } else {
        Log("Error 28: Trees check failed. " GetAreaSampleColour())
        MsgBox("Error: It appears you are using Trees, please set to"
            " off then F2 to reload().`nSee Readme.md for other"
            " required settings.")
        return false
    }

}

IsAFKOn() {
    try {
        sampleColour := Points.Misc.AspectRatio1.GetColour()
        sampleColour2 := Points.Misc.AspectRatio2.GetColour()
        If (Colours().IsButtonAFK(sampleColour) ||
            Colours().IsButtonAFK(sampleColour2)) {
            DebugLog("IsAFKOn: Corner buttons found with AFK on.")
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
    Points.Misc.BlankBG.Click()
    return false
}