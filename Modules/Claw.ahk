#Requires AutoHotkey v2.0

Global ClawCheckSizeOffset := 0
Global ClawFindAny := false

fClawFarm() {
    Global ClawFindAny

    If (!Travel.CursedHalloween.Goto()) {
        Return
    }

    GameKeys.RefreshTrades()
    Sleep(150)
    Loop {
        If (!Window.IsActive()) {
            Return ; Kill if no game
        }
        If (!Window.IsPanel()) {
            Log("Claw: Did not find panel. Aborted. ")
            Return
        }
        TargetX := ClawGetLocation("0x505558")
        ; Pumpkin stem colour 0x6CD820 (old) 0x505558 (new)
        If (TargetX = 0) {
            ; If no pumpkin try gems
            TargetX := ClawGetLocation("0xFF0044")
            If (TargetX = 0) {
                ; If no pumpkin try gems
                If (ClawFindAny) {
                    TargetX := ClawGetLocation("0xFFFFFF")
                    If (TargetX = 0) {
                        ; Still nothing just reset
                        Sleep(101)
                        GameKeys.RefreshTrades()
                        Sleep(50)
                    }
                } Else {
                    ; Still nothing just reset
                    Sleep(101)
                    GameKeys.RefreshTrades()
                    Sleep(50)
                }
            }
        }
        ; Version 3
        HookX := ClawGetHookLocation(TargetX)
        If (HookX != 0 && TargetX != 0) {
            GameKeys.RefreshTrades()
        }
    }
}

ClawGetLocation(col) {
    found := Rects.Claw.Items.PixelSearch(col)
    If (!found) {
        Return 0
    }
    Return found[1]
}

ClawGetHookLocation(ScreenX) {
    Global ClawCheckSizeOffset
    ;Hook colour 0x8B9BB4
    ;296 346 top left Hook area 1440
    ;2042 400 bottom right Hook area 1440
    Try {
        If (ClawCheckSizeOffset > 0) {
            found := PixelSearch(&OutX, &OutY, ScreenX - Window.RelW(20 +
                ClawCheckSizeOffset), Window.RelH(371), ScreenX + Window.RelW(
                    20 + ClawCheckSizeOffset), Window.RelH(373), "0x8B9BB4", 0)
        } Else {
            found := PixelSearch(&OutX, &OutY, ScreenX - Window.RelW(20),
                Window.RelH(346), ScreenX + Window.RelW(20), Window.RelH(400),
                "0x8B9BB4", 0)
        }
        ; Hook pixel search
        If (found and OutX != 0) {
            Return OutX ; Found colour
        }
    } Catch As exc {
        Log("Claw: ClawGetHookLocation search failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n" exc
            .Message)
    }
    Return 0
}

IsClawAboveLocation(ScreenX) {
    ;374 height to check
    If (!cPoint(ScreenX, Window.RelH(374), false).IsBackground()) {
        Return true
    }
    Return false
}

ClawCheck(TargetX, offset := 0, delay := 0) {
    If (IsClawAboveLocation(TargetX - Window.RelW(offset)) && TargetX != 0) {
        Sleep(delay)
        GameKeys.RefreshTrades()
        Log("Trying to catch, Offset " offset " Delay " delay " X " TargetX -
            Window.RelW(offset))
        Return true
    }
    Return false
}