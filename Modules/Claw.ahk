#Requires AutoHotkey v2.0

global ClawCheckSizeOffset := 0
global ClawFindAny := false

fClawFarm() {
    global ClawFindAny

    if (!Travel.CursedHalloween.Goto()) {
        return
    }

    GameKeys.RefreshTrades()
    sleep(150)
    loop {
        if (!IsWindowActive()) {
            return ; Kill if no game
        }
        if (!IsPanelActive()) {
            Log("Claw: Did not find panel. Aborted. ")
            return
        }
        TargetX := ClawGetLocation("0x505558")
        ; Pumpkin stem colour 0x6CD820 (old) 0x505558 (new)
        if (TargetX = 0) {
            ; If no pumpkin try gems
            TargetX := ClawGetLocation("0xFF0044")
            if (TargetX = 0) {
                ; If no pumpkin try gems
                if (ClawFindAny) {
                    TargetX := ClawGetLocation("0xFFFFFF")
                    if (TargetX = 0) {
                        ; Still nothing just reset
                        Sleep(101)
                        GameKeys.RefreshTrades()
                        sleep(50)
                    }
                } else {
                    ; Still nothing just reset
                    Sleep(101)
                    GameKeys.RefreshTrades()
                    sleep(50)
                }
            }
        }
        ; Version 3
        HookX := ClawGetHookLocation(TargetX)
        if (HookX != 0 && TargetX != 0) {
            GameKeys.RefreshTrades()
        }
    }
}

ClawGetLocation(col) {
    found := Rects.Claw.Items.PixelSearch(col)
    if (!found) {
        return 0
    }
    return found[1]
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
    if (!cPoint(ScreenX, WinRelPosLargeH(374), false).IsBackground()) {
        return true
    }
    return false
}

ClawCheck(TargetX, offset := 0, delay := 0) {
    if (IsClawAboveLocation(TargetX - WinRelPosLargeW(offset)) &&
        TargetX != 0) {
        Sleep(delay)
        GameKeys.RefreshTrades()
        Log("Trying to catch, Offset " offset " Delay " delay " X "
            TargetX - WinRelPosLargeW(offset))
        return true
    }
    return false
}