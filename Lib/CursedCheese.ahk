#Requires AutoHotkey v2.0

fFarmCheeseBoss() {
    ; Check zone is available
    If (!GoToCheeseBoss()) {
        Log("CheeseBoss: Traveling to Cursed Halloween failed."
            " Cheese season not active.")
        ToolTip("Could not travel to Cheese boss zone`n"
            "Please use the artifact to enable Cheese season",
            W / 2 - WinRelPosW(50),
            H / 2)
        SetTimer(ToolTip, -5000)
        return
    }
    Sleep(101)
    ClosePanel()
    Sleep(101)
    Killcount := 0
    IsInCursedHalloween := false

    loop {
        if (!IsWindowActive()) {
            break ; Kill early if no game
        }
        CurrentAliveState := IsCheeseBossAlive()

        ; if we just started and there is a timer or looped and theres
        ; still a timer, we need to use a violin
        if (!CurrentAliveState && IsBossTimerActive()) {
            if (!IsInCursedHalloween) {
                Log("CheeseBoss: Going to Cursed Halloween to spam violins.")
                ToolTip("Going to Cursed Halloween", W / 2 - WinRelPosW(50), H / 2)
                SetTimer(ToolTip, -250)
                if (!GoToShadowCavern()) {
                    Log("CheeseBoss: Traveling to Cursed Halloween failed.")
                    ToolTip("Traveling to Cursed Halloween failed.",
                        W / 2 - WinRelPosW(50),
                        H / 2)
                    SetTimer(ToolTip, -5000)
                    return
                }
                OpenEventsAreasPanel()
                Killcount++
                IsInCursedHalloween := true

                ToolTip("Kills: " . Killcount,
                    W / 2,
                    H / 2 + WinRelPosLargeH(50))
                SetTimer(ToolTip, -200)
            }
            loop {
                if (!IsWindowActive()) {
                    break ; Kill early if no game
                }
                if (IsCheeseBossTimerActive()) {
                    ToolTip("Using violins", W / 2, H / 2)
                    SetTimer(ToolTip, -250)
                    TriggerViolin()
                    Sleep(71)
                } else {
                    Log("CheeseBoss: Traveling to Cursed Halloween.")
                    ToolTip("Returning to Cursed Halloween", W / 2, H / 2)
                    SetTimer(ToolTip, -250)
                    ; Timers reset send user back
                    If (!GoToCheeseBoss()) {
                        Log("CheeseBoss: Traveling to Cursed Halloween failed."
                            " Cheese season not active.")
                        ToolTip("Could not travel to Cursed Halloween zone`n"
                            "Please use the artifact to enable Nature season",
                            W / 2 - WinRelPosW(50),
                            H / 2)
                        SetTimer(ToolTip, -5000)
                        return
                    }
                    IsInCursedHalloween := false
                    Sleep(101)
                    ClosePanel()
                    Sleep(101)
                    ; boss doesn't appear instantly so we need a manual delay
                    break
                }
            }
        }
        ; If boss killed us not much we can do, on user to address
        if (IsAreaResetToGarden()) {
            Log("CheeseBoss: Killed by boss, aborting farm.")
            ToolTip("Killed by boss, exiting", W / 2, H / 2)
            SetTimer(ToolTip, -3000)
            break
        }
        ToolTip("Kills: " . Killcount, W / 2, H / 2 + WinRelPosLargeH(50))
        SetTimer(ToolTip, -200)
    }
}

IsCheeseBossAlive() {
    return !IsBossTimerActive()
}

IsCheeseBossTimerActive() {
    ; if white is in this area, timer active
    ; ONLY WORKS ON THE AREA SCREEN IN THE EVENT TAB

    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1550), WinRelPosLargeH(345),
            WinRelPosLargeW(1660), WinRelPosLargeH(370), "0xFFFFFF", 0)
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        Log("CheeseBoss: IsCheeseBossTimerActive check failed with error - "
            exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}