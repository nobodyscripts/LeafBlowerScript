#Requires AutoHotkey v2.0

fFarmNatureBoss() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    ; Check zone is available

    GoToNatureBoss()
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }
    sleep 100
    ClosePanel()
    sleep 100
    Killcount := 0

    IsInFF := false
    loop {
        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                break ; Kill early if no game
        }
        CurrentAliveState := IsNatureBossAlive()

        ; if we just started and there is a timer or looped and theres
        ; still a timer, we need to use a violin
        if (!CurrentAliveState && IsBossTimerActive()) {
            if (!IsInFF) {
                ToolTip("Going to ff", W / 2, H / 2, 2)
                SetTimer(ToolTip, -250)
                GoToFarmField()
                Killcount := Killcount + 1
                IsInFF := true

                ToolTip("Kills: " . Killcount,
                    W / 2,
                    H / 2 + WinRelPosLargeH(50), 10)
                SetTimer(ToolTip, -200)
            }
            loop {
                if (!WinExist("Leaf Blower Revolution") ||
                    !WinActive("Leaf Blower Revolution")) {
                        break ; Kill early if no game
                }
                if (IsNatureBossTimerActive()) {
                    ToolTip("Using violins", W / 2, H / 2, 4)
                    SetTimer(ToolTip, -250)
                    TriggerViolin()
                    sleep 71
                } else {
                    ToolTip("Returning to boss", W / 2, H / 2, 2)
                    SetTimer(ToolTip, -250)
                    ; Timers reset send user back
                    GoToNatureBoss()
                    IsInFF := false
                    sleep 100
                    ClosePanel()
                    sleep 1000
                    ; boss doesn't appear instantly so we need a manual delay
                    break
                }
            }
        }
        ; If boss killed us not much we can do, on user to address
        if (IsAreaResetToGarden()) {
            ToolTip("Killed by boss, exiting", W / 2, H / 2, 1)
            SetTimer(ToolTip, -3000)
            Sleep 3000
            break
        }
        ToolTip("Kills: " . Killcount, W / 2, H / 2 + WinRelPosLargeH(50), 10)
        SetTimer(ToolTip, -200)
    }
}

IsNatureBossAlive() {
    ;2ce8f5
    ; 852 250 (1440)
    try {
        found := PixelGetColor(WinRelPosLargeW(852), WinRelPosLargeH(250))
        ; Timer pixel search
        If (found = "0x2CE8F5") {
            return true ; Found colour
        }
        if (IsNatureBossTimerActive()) {
            return false
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

IsNatureBossTimerActive() {
    ; if white is in this area, timer active
    ; ONLY WORKS ON THE AREA SCREEN IN THE EVENT TAB

    ; 1883 1004
    ; 2189 1033
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1883), WinRelPosLargeH(1004),
            WinRelPosLargeW(2189), WinRelPosLargeH(1033), "0xFFFFFF", 0)
        ; Timer pixel search
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    return false
}

GoToNatureBoss() {
    OpenEventsAreasPanel()
    fSlowClick(875, 470) ; Open nature boss area
}

GoToFarmField() {
    OpenEventsAreasPanel()
    fSlowClick(875, 260) ; Open farm field
}

OpenEventsAreasPanel() {
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
    fSlowClick(1049, 572) ; Click the event tab
    Sleep 150
    ControlClick(, "Leaf Blower Revolution", , "WheelUp") ; Align the page
    Sleep 150
}