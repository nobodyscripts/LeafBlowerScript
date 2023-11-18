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
            return
        }
        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                return ; Kill early if no game
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
                WinRelPosLargeH(50))
            SetTimer(ToolTip, -5000)
            return
        }
        ToolTip("Kills: " . Killcount,
            W / 2 - WinRelPosLargeW(50),
            H / 2 + WinRelPosLargeH(20))
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
    Sleep 150
    fCustomClick(WinRelPosLargeW(512), WinRelPosLargeH(1181))
    Sleep 150
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }
    TimerLastCheckStatus := IsBossTimerActive()
    loop {
        If (on9 != 2) {
            return
        }

        SetTimer(SpamBrewButtons, -5)
        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                return ; Kill early if no game
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
                WinRelPosLargeH(50))
            SetTimer(ToolTip, -5000)
            return
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
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(433))) {
        fCustomClick(WinRelPosW(856), WinRelPosH(433), 34)
    }
    ; Card Parts for fontsize 1
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(448))) {
        fCustomClick(WinRelPosW(856), WinRelPosH(448), 34)
    }
}

fNormalBossFarmWithBorbs() {

    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets() ; Opens or closes another screen so that when areas is opened it
    ; doesn't close
    Sleep 100
    OpenBorbVentures() ; Open BV
    Sleep 100
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }

    fSlowClick(211, 573) ; Select tab
    Sleep 50
    global on9

    loop {
        If (on9 != 3) {
            return
        }

        if (!WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution")) {
                return ; Kill if no game
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
                WinRelPosLargeH(50))
            SetTimer(ToolTip, -5000)
            break
        }
        BVMainLoop()

    }
}

global HadToHideNotifsF9
HadToHideNotifsF9 := false
fNormalBossFarmWithCards() {
    global HadToHideNotifsF9
    global on9
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets()
    ; Opens or closes another screen so that when areas is opened it doesn't
    ; close
    Sleep 100
    OpenCards()
    Sleep 100
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }
    fSlowClick(202, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll

    while (on9 = 4) {
        ; Check if lost focus, close or crash and break if so
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                return
        }
        WinActivate("Leaf Blower Revolution")
        ; Use the window found by WinExist.
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
        ; Update window size
        If (on9 != 4) {
            break
        }
        if (IsBossTimerActive()) {
            TriggerViolin()
            sleep 34
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            ToolTip("Killed by boss, exiting", W / 2, H / 2 +
                WinRelPosLargeH(50))
            SetTimer(ToolTip, -5000)
            break
        }
        ClickOffset := WinRelPosLargeH(2)
        CommonX := WinRelPosLargeW(565)
        CommonY := WinRelPosLargeH(820)
        if (IsCoveredByNotification(CommonX, CommonY)) {
            fSlowClick(32, 596, 34)
            HadToHideNotifsF9 := true
            ; Notifications were blocking, close notifications and reshow
            OpenCards()
            Sleep 100
        }
        CommonButtonActive := IsButtonActive(CommonX, CommonY)
        ; Check if button is active, if not we can skip

        if (CardsDontOpenCommons = false && CommonButtonActive) {
            CardNumberToModifier(CardsCommonAmount)
            fCustomClick(CommonX, CommonY + ClickOffset)
            ; Common pack open
            Sleep CardsSleepAmount
        }

        RareX := WinRelPosLargeW(1130)
        RareY := WinRelPosLargeH(820)
        RareButtonActive := IsButtonActive(RareX, RareY)
        ; Check if button is active, if not we can skip
        if (CardsDontOpenRare = false && RareButtonActive) {
            CardNumberToModifier(CardsRareAmount)
            fCustomClick(RareX, RareY + ClickOffset)
            ; Rare pack open
            Sleep CardsSleepAmount
        }

        LegendaryX := WinRelPosLargeW(1690)
        LegendaryY := WinRelPosLargeH(820)
        LegendaryButtonActive := IsButtonActive(LegendaryX, LegendaryY)
        ; Check if button is active, if not we can skip
        if (CardsDontOpenLegendary = false && LegendaryButtonActive) {
            CardNumberToModifier(CardsLegendaryAmount)
            fCustomClick(LegendaryX, LegendaryY + ClickOffset)
            ; Legendary pack open
            Sleep CardsSleepAmount
        }

        If (!CommonButtonActive && !RareButtonActive && !LegendaryButtonActive)
        {
            ToolTip("Card opening stopped, boss farm continuing`nFound no active buttons.`nF9 to stop",
                W / 2 - WinRelPosLargeH(170), H / 2)
        }
        ResetModifierKeys() ; Cleanup ctrl+shift+alt modifiers
    }
    if (HadToHideNotifsF9 = true) {
        fSlowClick(32, 596, 17)
        HadToHideNotifsF9 := false
    }
    ResetModifierKeys() ; Cleanup incase of broken loop
}