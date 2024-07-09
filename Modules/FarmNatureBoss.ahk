#Requires AutoHotkey v2.0

Global on9 := 0

fFarmNatureBoss() {
    ; Check zone is available
    If (!GoToNatureBoss()) {
        Log("NatureBoss: Traveling to The Doomed Tree failed."
            " Nature season not active.")
        ToolTip("Could not travel to nature boss zone`n"
            "Please use the artifact to enable nature season", W / 2 -
            WinRelPosLargeW(100), H / 2)
        SetTimer(ToolTip, -5000)
        Return
    }
    Sleep(101)
    Travel.ClosePanelIfActive()
    Sleep(101)
    Killcount := 0
    IsInShadowCavern := false

    Loop {
        If (!IsWindowActive()) {
            Break ; Kill early if no game
        }
        CurrentAliveState := IsNatureBossAlive()

        ; if we just started and there is a timer or looped and theres
        ; still a timer, we need to use a violin
        If (!CurrentAliveState && IsBossTimerActive()) {
            If (!IsInShadowCavern) {
                Log("NatureBoss: Going to Shadow Cavern to spam violins.")
                ToolTip("Going to Shadow Cavern", W / 2 - WinRelPosLargeW(100),
                    H / 2)
                SetTimer(ToolTip, -250)
                If (!GoToShadowCavern()) {
                    Log("NatureBoss: Traveling to Shadow Cavern failed.")
                    ToolTip("Traveling to Shadow Cavern failed.", W / 2 -
                        WinRelPosLargeW(100), H / 2)
                    SetTimer(ToolTip, -5000)
                    Return
                }
                Travel.OpenAreasEvents()
                Killcount++
                IsInShadowCavern := true

                ToolTip("Kills: " . Killcount, W / 2, H / 2 + WinRelPosLargeH(
                    50))
                SetTimer(ToolTip, -200)
            }
            Loop {
                If (!IsWindowActive()) {
                    Break ; Kill early if no game
                }
                If (IsNatureBossTimerActive()) {
                    ToolTip("Using violins", W / 2, H / 2)
                    SetTimer(ToolTip, -250)
                    GameKeys.TriggerViolin()
                    Sleep(71)
                } Else {
                    Log("NatureBoss: Traveling to The Doomed Tree.")
                    ToolTip("Returning to The Doomed Tree", W / 2, H / 2)
                    SetTimer(ToolTip, -250)
                    ; Timers reset send user back
                    If (!GoToNatureBoss()) {
                        Log("NatureBoss: Traveling to The Doomed Tree failed."
                            " Nature season not active.")
                        ToolTip("Could not travel to The Doomed Tree zone`n"
                            "Please use the artifact to enable nature season",
                            W / 2 - WinRelPosLargeW(100), H / 2)
                        SetTimer(ToolTip, -5000)
                        Return
                    }
                    IsInShadowCavern := false
                    Sleep(101)
                    Travel.ClosePanelIfActive()
                    Sleep(101)
                    ; boss doesn't appear instantly so we need a manual delay
                    Break
                }
            }
        }
        ; If boss killed us not much we can do, on user to address
        If (Travel.HomeGarden.IsAreaGarden()) {
            Log("NatureBoss: Killed by boss, aborting farm.")
            ToolTip("Killed by boss, exiting", W / 2, H / 2)
            SetTimer(ToolTip, -3000)
            Break
        }
        ToolTip("Kills: " . Killcount, W / 2, H / 2 + WinRelPosLargeH(50))
        SetTimer(ToolTip, -200)
    }
}

IsNatureBossAlive() {
    ;2ce8f5
    ; 852 250 (1440)
    If (IsPanelActive()) {
        Log("IsNatureBossAlive: Was checked while panel was active.")
    }
    Try {
        ; TODO Move point to Points
        found := PixelGetColor(WinRelPosLargeW(852), WinRelPosLargeH(250))
        ; Timer pixel search
        If (found = "0x2CE8F5") {
            Return true ; Found colour
        }
        If (IsNatureBossTimerActive()) {
            Return false
        }
    } Catch As exc {
        Log("NatureBoss: IsNatureBossAlive check failed with error - " exc.Message
        )
        MsgBox("Could not conduct the search due to the following error:`n" exc
            .Message)
    }
    Return false
}

IsNatureBossTimerActive() {
    ; if white is in this area, timer active
    ; ONLY WORKS ON THE AREA SCREEN IN THE EVENT TAB

    ; 1883 1004
    ; 2189 1033
    Try {
        ; TODO Move point to Points
        If (!cPoint(1693, 960).IsBackground()) {
            ; font 1
            ; TODO Move rect to Rects
            found := PixelSearch(&OutX, &OutY, WinRelPosLargeW(1574),
                WinRelPosLargeH(965), WinRelPosLargeW(1642), WinRelPosLargeH(
                    1009), "0xFFFFFF", 0)
            If (found and OutX != 0) {
                Return true ; Found colour
            }
        } Else {
            ; font 0
            ; TODO Move rect to Rects
            found := PixelSearch(&OutX, &OutY, WinRelPosLargeW(1525),
                WinRelPosLargeH(965), WinRelPosLargeW(1660), WinRelPosLargeH(
                    985), "0xFFFFFF", 0)
            ; Timer pixel search
            If (found and OutX != 0) {
                Return true ; Found colour
            }
        }
        ; Halloween inactive, nature active
        ; TODO Move point to Points
        If (cPoint(1650, 870).IsButton()) {
            ; TODO Move rect to Rects
            found := cRect(1525, 897, 1660, 922).PixelSearch()
            If (found) {
                Return true
            }
        }
    } Catch As exc {
        Log("NatureBoss: IsNatureBossTimerActive check failed with error - " exc
            .Message)
        MsgBox("Could not conduct the search due to the following error:`n" exc
            .Message)
    }
    Return false
}