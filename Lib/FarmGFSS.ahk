#Requires AutoHotkey v2.0

fFarmGFSS() {

    ResettingGF := false
    loop {
        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                break ; Kill early if no game
        }
        GFKills := 0
        SSKills := 0
        IsInGF := true
        IsInSS := false
        GoToGF()
        If (CheckForTransparentPanelsSilent()) {
            ; Warning is displayed if there is an issue, return to avoid harm
            return
        }
        sleep 100
        ClosePanel()
        TimerLastCheckStatus := IsBossTimerActive()

        while (SSToKillPerCycle != SSKills) {
            if (!WinExist("Leaf Blower Revolution") ||
                !WinActive("Leaf Blower Revolution")) {
                    break ; Kill early if no game
            }
            while (GFToKillPerCycle != GFKills) {
                if (!WinExist("Leaf Blower Revolution") ||
                    !WinActive("Leaf Blower Revolution")) {
                        break ; Kill early if no game
                }
                if (!IsInGF) {
                    GoToGF()
                    sleep 100
                    ClosePanel()
                    IsInGF := true
                    IsInSS := false
                }
                TimerCurrentState := IsBossTimerActive()
                ; if state of timer has changed and is now off, we killed
                if (TimerLastCheckStatus != TimerCurrentState &&
                    TimerCurrentState) {
                        GFKills := GFKills + 1
                }
                ; if we just started and there is a timer or looped and theres
                ; still a timer, we need to use a violin
                if (IsBossTimerActive()) {
                    TriggerViolin()
                    sleep 71
                }
                ; If boss killed us at gf assume we're weak and reset gf
                ; If user set gf kills too high it'll hit this
                if (IsAreaResetToGarden()) {
                    ToolTip("Killed by boss, resetting",
                        W / 2 - WinRelPosLargeW(70),
                        H / 2)
                    SetTimer(ToolTip, -200)
                    ResetGF()
                    ResettingGF := true
                    break
                }
                ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills,
                    W / 2 - WinRelPosLargeW(70),
                    H / 2)
                SetTimer(ToolTip, -200)
                TimerLastCheckStatus := TimerCurrentState
            }
            if (!IsInSS) {
                GoToSS()
                sleep 100
                ClosePanel()
                IsInSS := true
                IsInGF := false
            }
            TimerCurrentState := IsBossTimerActive()
            ; if state of timer has changed and is now off, we killed
            if (TimerLastCheckStatus != TimerCurrentState &&
                TimerCurrentState) {
                    SSKills := SSKills + 1
                    GFKills := 0
            }
            ; if we just started and there is a timer or looped and theres
            ; still a timer, we need to use a violin
            if (IsBossTimerActive()) {
                TriggerViolin()
                sleep 71
            }
            ; if boss killed us exit this loop, then let the master loop
            ; reset
            if (IsAreaResetToGarden() && !ResettingGF) {
                ToolTip("Killed by boss, resetting",
                    W / 2 - WinRelPosLargeW(100),
                    H / 2)
                SetTimer(ToolTip, -200)
                break
            }
            ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills,
                W / 2 - WinRelPosLargeW(70),
                H / 2)
            SetTimer(ToolTip, -200)
            TimerLastCheckStatus := TimerCurrentState

        }
        ; if we're done looping or got killed reset ss
        if (!ResettingGF) {
            ToolTip("Resetting at: GF Kills " . GFKills .
                " SS Kills " . SSKills,
                W / 2 - WinRelPosLargeW(100),
                H / 2)
            SetTimer(ToolTip, -250)
            Sleep 250
            ResetSS()
        }
        ResettingGF := false
    }
}

GoToGF() {
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
    fSlowClick(317, 574, 100)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 150
    fSlowClick(686, 574, 100)
    ; Open Fire Fields tab
    Sleep 200
    fSlowClick(877, 411, 100)
    ; Open Flame Brazier (GF zone)
}

GoToSS() {
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
    fSlowClick(317, 574, 100)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 150
    fSlowClick(686, 574, 100)
    ; Open Fire Fields tab
    Sleep 200
    fSlowClick(877, 516, 100)
    ; Open Flame Universe (SS zone)
}

ResetSS() {
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
    fSlowClick(317, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 150
    fSlowClick(686, 574)
    ; Open Fire Fields tab
    Sleep 150
    fSlowClick(880, 159)
    ; Go to shadow cavern
    Sleep 150
    ClosePanel()
    ; Close the panel to see borb
    Sleep 150
    fSlowClick(880, 180)
    ; Go to Borbiana Jones screen
    Sleep 150
    fSlowClick(517, 245)
    ; Reset SpectralSeeker
}

ResetGF() {
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
    fSlowClick(317, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 150
    fSlowClick(686, 574)
    ; Open Fire Fields tab
    Sleep 150
    fSlowClick(880, 159)
    ; Go to shadow cavern
    Sleep 150
    ClosePanel()
    ; Go to shadow cavern
    Sleep 150
    fSlowClick(880, 180)
    ; Go to Borbiana Jones screen
    Sleep 150
    fSlowClick(280, 245)
    ; Reset Green Flame
}