#Requires AutoHotkey v2.0

fClawFarm() {
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
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }
    fSlowClick(315, 574) ; Click the right tab just incase
    Sleep 150
    ResetAreaScroll() ; Reset incase
    Sleep 150
    ScrollAmountDown(46) ; Scroll down
    Sleep 150
    If (IsBackground(WinRelPosW(830), WinRelPosH(359))) {
        ToolTip("Pub area button didn't align, try again",
            W / 2 - WinRelPosW(50), H / 2, 5)
        SetTimer(ToolTip, -5000)
        return
    }
    fSlowClick(830, 359) ; Open pub area
    Sleep 150
    fSlowClick(50, 252) ; Close the area screen
    Sleep 150
    fSlowClick(276, 252) ; Open claw machine
    Sleep 150
    RefreshTrades()
    Sleep 150
    loop {

        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                return ; Kill early if no game
        }
        TargetX := ClawGetPumpkinLocation()
        if (TargetX = 0) {
            ; If no pumpkin try gems
            TargetX := ClawGetGemLocation()
            if (TargetX = 0) {
                ; Still nothing just reset
                ToolTip("Nothing found, resetting",
                    W / 2 - WinRelPosLargeW(50), H / 2, 5)
                SetTimer(ToolTip, -145)
                Sleep 100
                RefreshTrades()
                Sleep 50
            }
        }
        ; Version 3
        HookX := ClawGetHookLocation(TargetX)
        if (HookX != 0 && TargetX != 0) {
            RefreshTrades()
            ToolTip("Trying to catch HookX " . HookX . " PumpX " . TargetX,
                TargetX - WinRelPosLargeW(15),
                WinRelPosLargeH(970), 5)
            SetTimer(ToolTip, -200)
        }


        ; Version 2
        ; Check straight above; going to do multiple checks to account for
        ; skipping locations
        /*ClawCheck(TargetX, 0, 0)
        ClawCheck(TargetX, 3, 0)
        ClawCheck(TargetX, 5, 0)
        ClawCheck(TargetX, 7, 17)
        ClawCheck(TargetX, 10, 17)
        ClawCheck(TargetX, 13, 17)
        ClawCheck(TargetX, 15, 34)
        ClawCheck(TargetX, 17, 34)*/

        ; Version 1
        /*if (TargetX + WinRelPosLargeW(15) >= HookX && TargetX -
            WinRelPosLargeW(15) <= HookX) {
                RefreshTrades()
                ToolTip("Trying to catch HookX " . HookX . " PumpX " . TargetX,
                    TargetX - WinRelPosLargeW(15),
                    WinRelPosLargeH(970), 5)
                SetTimer(ToolTip, -200)
        }
        Sleep 8.35*/
    }

}

ClawGetPumpkinLocation() {
    try {
        ; Pumpkin stem colour 0x6CD820
        ; 406 672 top left pickup area 1440 res
        ; 2070 920 bottom right  pickup area
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(406), WinRelPosLargeH(672),
            WinRelPosLargeW(2070), WinRelPosLargeH(970), "0x6CD820", 0)
        ; Pumpkin stem pixel search
        If (found and OutX != 0) {
            return OutX ; Found colour
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return 0
}


ClawGetGemLocation() {
    try {
        ; Gem colour 0xFF0044
        ; 406 672 top left pickup area 1440 res
        ; 2070 920 bottom right  pickup area
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(406), WinRelPosLargeH(672),
            WinRelPosLargeW(2070), WinRelPosLargeH(970), "0xFF0044", 0)
        ; Gem pixel search
        If (found and OutX != 0) {
            return OutX ; Found colour
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return 0
}

ClawGetHookLocation(ScreenX) {
    ;Hook colour 0x8B9BB4
    ;296 346 top left Hook area 1440
    ;2042 400 bottom right Hook area 1440
    try {
        found := PixelSearch(&OutX, &OutY,
            ScreenX - WinRelPosLargeW(20), WinRelPosLargeH(346),
            ScreenX + WinRelPosLargeW(20), WinRelPosLargeH(400), "0x8B9BB4", 0)
        ; Hook pixel search
        If (found and OutX != 0) {
            return OutX ; Found colour
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return 0
}

IsClawAboveLocation(ScreenX) {
    ;374 height to check
    if (!IsBackground(ScreenX, WinRelPosLargeH(374))) {
        return true
    }
    return false
}

ClawCheck(TargetX, offset := 0, delay := 0) {
    if (IsClawAboveLocation(TargetX - WinRelPosLargeW(offset)) &&
        TargetX != 0) {
            Sleep delay
            RefreshTrades()
            ToolTip("Trying to catch offset " . offset . " Delay " . delay,
                TargetX - WinRelPosLargeW(offset),
                WinRelPosLargeH(970), 5)
            SetTimer(ToolTip, -100)
            return true
    }
    return false
}