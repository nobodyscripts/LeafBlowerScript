#Requires AutoHotkey v2.0


fClawFarm() {
    If (!IsHalloweenEventActive()) {
        Log("Claw: Halloween inactive.")
        ToolTip("Halloween inactive`nPlease use the artifact to enable"
            " halloween event",
            W / 2 - WinRelPosW(50),
            H / 2)
        SetTimer(ToolTip, -5000)
        return
    }
    fSlowClick(315, 574, 101) ; Click the right tab after checking halloween
    sleep(150)
    ResetAreaScroll() ; Reset incase
    sleep(150)
    ScrollAmountDown(46) ; Scroll down
    sleep(150)
    If (IsBackground(WinRelPosW(830), WinRelPosH(359))) {
        Log("Claw: Could not travel to pub.")
        ToolTip("Pub area button didn't align, try again",
            W / 2 - WinRelPosW(50), H / 2)
        SetTimer(ToolTip, -5000)
        return
    }
    fSlowClick(830, 359, 101) ; Open pub area
    sleep(250)
    fSlowClick(50, 252, 101) ; Close the area screen
    sleep(250)
    fSlowClick(276, 252, 101) ; Open claw machine
    sleep(250)
    RefreshTrades()
    sleep(150)
    loop {
        if (!IsWindowActive()) {
            return ; Kill if no game
        }
        if (!IsPanelActive()) {
            Log("Claw: Did not find panel. Aborted. ")
            return
        }
        TargetX := ClawGetPumpkinLocation()
        if (TargetX = 0) {
            ; If no pumpkin try gems
            TargetX := ClawGetGemLocation()
            if (TargetX = 0) {
                ; Still nothing just reset
                Sleep(101)
                RefreshTrades()
                sleep(50)
            }
        }
        ; Version 3
        HookX := ClawGetHookLocation(TargetX)
        if (HookX != 0 && TargetX != 0) {
            RefreshTrades()
        }
    }
}

ClawGetPumpkinLocation() {
    try {
        ; Pumpkin stem colour 0x6CD820 (old) 0x505558 (new)
        ; 406 672 top left pickup area 1440 res
        ; 2070 920 bottom right  pickup area
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(406), WinRelPosLargeH(672),
            WinRelPosLargeW(2070), WinRelPosLargeH(970), "0x505558", 0)
        ; Pumpkin stem pixel search
        If (found and OutX != 0) {
            return OutX ; Found colour
        }
    } catch as exc {
        Log("Claw: ClawGetPumpkinLocation search failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
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
        Log("Claw: ClawGetGemLocation search failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return 0
}

ClawGetHookLocation(ScreenX) {
    global ClawCheckSizeOffset
    ;Hook colour 0x8B9BB4
    ;296 346 top left Hook area 1440
    ;2042 400 bottom right Hook area 1440
    try {
        if (ClawCheckSizeOffset > 0) {
            found := PixelSearch(&OutX, &OutY,
                ScreenX - WinRelPosLargeW(20 + ClawCheckSizeOffset),
                WinRelPosLargeH(371),
                ScreenX + WinRelPosLargeW(20 + ClawCheckSizeOffset),
                WinRelPosLargeH(373), "0x8B9BB4", 0)
        } else {
            found := PixelSearch(&OutX, &OutY,
                ScreenX - WinRelPosLargeW(20), WinRelPosLargeH(346),
                ScreenX + WinRelPosLargeW(20), WinRelPosLargeH(400),
                "0x8B9BB4", 0)
        }
        ; Hook pixel search
        If (found and OutX != 0) {
            return OutX ; Found colour
        }
    } catch as exc {
        Log("Claw: ClawGetHookLocation search failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
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
            Sleep(delay)
            RefreshTrades()
            Log("Trying to catch, Offset " offset " Delay " delay " X "
                TargetX - WinRelPosLargeW(offset))
            return true
    }
    return false
}

IsHalloweenEventActive() {
    OpenEventsAreasPanel()
    if (IsBackground(WinRelPosW(836), WinRelPosH(160))) {
        return false
    }
    return true
}