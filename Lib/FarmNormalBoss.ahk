#Requires AutoHotkey v2.0

fFarmNormalBoss() {
    global on9
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    Killcount := 0
    TimerLastCheckStatus := IsBossTimerActive()
    loop {
        If (on9 != 1) {
            break
        }
        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                break ; Kill early if no game
        }
        TimerCurrentState := IsBossTimerActive()
        ; if state of timer has changed and is now off, we killed
        if (TimerLastCheckStatus != TimerCurrentState &&
            TimerCurrentState) {
                Killcount := Killcount + 1
        }
        ; if we just started and there is a timer or looped and theres
        ; still a timer, we need to use a violin
        if (IsBossTimerActive()) {
            TriggerViolin()
            sleep 34
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            ToolTip("Killed by boss, exiting", W / 2, H / 2 +
                WinRelPosLargeH(50), 6)
            Sleep 30000
            break
        }
        ToolTip("Kills: " . Killcount,
            W / 2 - WinRelPosLargeW(50),
            H / 2 + WinRelPosLargeH(20), 1)
        SetTimer(ToolTip, -200)
        TimerLastCheckStatus := TimerCurrentState
    }
}

fFarmNormalBossAndBrew() {
    global on9
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    Killcount := 0
    OpenPets()
    Sleep 50
    OpenAlchemy()
    Sleep 50
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }
    TimerLastCheckStatus := IsBossTimerActive()
    loop {
        If (on9 != 2) {
            break
        }

        SetTimer(SpamBrewButtons, -5)
        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                break ; Kill early if no game
        }
        TimerCurrentState := IsBossTimerActive()
        ; if state of timer has changed and is now off, we killed
        if (TimerLastCheckStatus != TimerCurrentState &&
            TimerCurrentState) {
                Killcount := Killcount + 1
        }
        ; if we just started and there is a timer or looped and theres
        ; still a timer, we need to use a violin
        if (IsBossTimerActive()) {
            TriggerViolin()
            sleep 34
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            ToolTip("Killed by boss, exiting", W / 2, H / 2 +
                WinRelPosLargeH(50), 6)
            Sleep 30000
            break
        }
        ToolTip("Brewing on, Kills: " . Killcount,
            W / 2 - WinRelPosLargeW(150),
            H / 2)
        SetTimer(ToolTip, -200)
        TimerLastCheckStatus := TimerCurrentState
    }
}

SpamBrewButtons() {
    ; Artifacts
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(150))) {
        fCustomClick(WinRelPosW(856), WinRelPosH(150), 34)
    }
    ;Equipment
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(219))) {
        fCustomClick(WinRelPosW(856), WinRelPosH(219), 34)
    }
    ; Materials
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(290))) {
        fCustomClick(WinRelPosW(856), WinRelPosH(290), 34)
    }
    ; Card Parts
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(446))) {
        fCustomClick(WinRelPosW(856), WinRelPosH(446), 34)
    }
}