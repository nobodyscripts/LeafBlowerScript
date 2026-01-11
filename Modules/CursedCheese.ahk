#Requires AutoHotkey v2.0

; TODO Travel and opening review

fFarmCheeseBoss() {
    ; Check zone is available
    If (!GoToCheeseBoss()) {
        Out.I("CheeseBoss: Traveling to Cursed Halloween failed."
            " Cheese season not active.")
        ToolTip("Could not travel to Cheese boss zone`n"
            "Please use the artifact to enable Cheese season", Window.W / 2 -
            Window.RelW(100), Window.H / 2)
        SetTimer(ToolTip, -5000)
        Return
    }
    Sleep(101)
    Travel.ClosePanelIfActive()
    Sleep(101)
    Killcount := 0
    IsInCursedHalloween := false

    Loop {
        If (!Window.IsActive()) {
            Break ; Kill early if no game
        }
        CurrentAliveState := IsCheeseBossAlive()

        ; if we just started and there is a timer or looped and theres
        ; still a timer, we need to use a violin
        If (!CurrentAliveState && IsBossTimerActive()) {
            If (!IsInCursedHalloween) {
                Out.I("CheeseBoss: Going to Cursed Halloween to spam violins.")
                ToolTip("Going to Cursed Halloween", Window.W / 2 - Window.RelW(
                    100), Window.H / 2)
                SetTimer(ToolTip, -250)
                If (!GoToShadowCavern()) {
                    Out.I("CheeseBoss: Traveling to Cursed Halloween failed.")
                    ToolTip("Traveling to Cursed Halloween failed.", Window.W /
                        2 - Window.RelW(100), Window.H / 2)
                    SetTimer(ToolTip, -5000)
                    Return
                }
                Travel.OpenAreasEvents()
                Killcount++
                IsInCursedHalloween := true

                ToolTip("Kills: " . Killcount, Window.W / 2, Window.H / 2 +
                    Window.RelH(50))
                SetTimer(ToolTip, -200)
            }
            Loop {
                If (!Window.IsActive()) {
                    Break ; Kill early if no game
                }
                If (IsCheeseBossTimerActive()) {
                    ToolTip("Using violins", Window.W / 2, Window.H / 2)
                    SetTimer(ToolTip, -250)
                    GameKeys.TriggerViolin()
                    Sleep(71)
                } Else {
                    Out.I("CheeseBoss: Traveling to Cursed Halloween.")
                    ToolTip("Returning to Cursed Halloween", Window.W / 2,
                        Window.H / 2)
                    SetTimer(ToolTip, -250)
                    ; Timers reset send user back
                    If (!GoToCheeseBoss()) {
                        Out.I(
                            "CheeseBoss: Traveling to Cursed Halloween failed."
                            " Cheese season not active.")
                        ToolTip("Could not travel to Cursed Halloween zone`n"
                            "Please use the artifact to enable Nature season",
                            Window.W / 2 - Window.RelW(100), Window.H / 2)
                        SetTimer(ToolTip, -5000)
                        Return
                    }
                    IsInCursedHalloween := false
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
            Out.I("CheeseBoss: Killed by boss, aborting farm.")
            ToolTip("Killed by boss, exiting", Window.W / 2, Window.H / 2)
            SetTimer(ToolTip, -3000)
            Break
        }
        ToolTip("Kills: " . Killcount, Window.W / 2, Window.H / 2 + Window.RelH(
            50))
        SetTimer(ToolTip, -200)
    }
}

IsCheeseBossAlive() {
    Return !IsBossTimerActive()
}

IsCheeseBossTimerActive() {
    ; if white is in this area, timer active
    ; ONLY WORKS ON THE AREA SCREEN IN THE EVENT TAB

    Try {
        found := PixelSearch(&OutX, &OutY, Window.RelW(1550), Window.RelH(345),
            Window.RelW(1660), Window.RelH(370), "0xFFFFFF", 0)
        If (found and OutX != 0) {
            Return true ; Found colour
        }
    } Catch As exc {
        Out.I("CheeseBoss: IsCheeseBossTimerActive check failed with error - " exc
            .Message)
        MsgBox("Could not conduct the search due to the following error:`n" exc
            .Message)
    }
    Return false
}