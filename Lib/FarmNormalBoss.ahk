#Requires AutoHotkey v2.0

global ViolinSleepAmount := 74

fFarmNormalBoss(modecheck) {
    global on9
    Killcount := 0
    TimerLastCheckStatus := IsBossTimerActive()
    SetTimer(SpamViolins, ViolinSleepAmount)
    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            reload() ; Kill early if no game
        }
        TimerCurrentState := IsBossTimerActive()
        ; if state of timer has changed and is now off, we killed
        if (TimerLastCheckStatus != TimerCurrentState &&
            TimerCurrentState) {
                Killcount++
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            Log("BossFarm: User killed. Aborted.")
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

fFarmNormalBossAndBrew(modecheck) {
    ToolTip()
    global on9
    Killcount := 0
    OpenPets()
    sleep(50)
    OpenAlchemy()
    sleep(150)
    fSlowClickRelL(512, 1181)
    sleep(150)
    TimerLastCheckStatus := IsBossTimerActive()
    SetTimer(SpamViolins, ViolinSleepAmount)
    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            reload() ; Kill if no game
        }
        SetTimer(SpamBrewButtons, -5)
        TimerCurrentState := IsBossTimerActive()
        ; if state of timer has changed and is now off, we killed
        if (TimerLastCheckStatus != TimerCurrentState &&
            TimerCurrentState) {
                Killcount++
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            Log("BossBrew: User killed. Aborted.")
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

SpamViolins() {
    if (IsWindowActive() && IsBossTimerActive()) {
        TriggerViolin()
    }
}

SpamBrewButtons() {
    ; Artifacts
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(150))) {
        fSlowClick(856, 150, 34)
    }
    ;Equipment
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(219))) {
        fSlowClick(856, 219, 34)
    }
    ; Materials
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(290))) {
        fSlowClick(856, 290, 34)
    }
    ; Card Parts
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(433))) {
        fSlowClick(856, 433, 34)
    }
    ; Card Parts for fontsize 1
    If (IsButtonActive(WinRelPosW(856), WinRelPosH(448))) {
        fSlowClick(856, 448, 34)
    }
}

fNormalBossFarmWithBorbs(modecheck) {
    ToolTip()
    global on9
    OpenPets() ; Opens or closes another screen so that when areas is opened it
    ; doesn't close
    Sleep(101)
    OpenBorbVentures() ; Open BV
    Sleep(101)
    BVResetScroll()
    SetTimer(SpamViolins, ViolinSleepAmount)
    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            reload()
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            Log("BossBorbs: User killed. Aborted.")
            ToolTip("Killed by boss, exiting", W / 2, H / 2 +
                WinRelPosLargeH(50))
            SetTimer(ToolTip, -5000)
            return
        }
        BVMainLoop()
    }
}

fNormalBossFarmWithCards(modecheck) {
    ToolTip()
    global HadToHideNotifs, W, H, X, Y, on9

    if (!GotoCardsFirstTab()) {
        ; We still failed to travel
        Log("BossCards: Failed to open cards first tab")
        return
    }

    SetTimer(SpamViolins, ViolinSleepAmount)

    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            Log("BossCards: Did not find game. Aborted.")
            reload() ; Kill if no game
        }
        if (!CardButtonsActive() && !CardsPermaLoop) {
            Log("BossCards: Exiting.")
            return
        }
        ToolTip("Boss farm with cards active",
            W / 2 - WinRelPosLargeW(150),
            H / 2 + WinRelPosLargeH(360))
        if (CardsBuyEnabled) {
            Log("BossCards buy: Loop starting.")
            CardBuyLoop()
        }
        Log("BossCards Opening: Loop starting.")
        loop {
            if (!CardsOpenSinglePass()) {
                Log("BossCards Opening: Loop finishing.")
                break
            }
        }
    }
    ToolTip()
    if (HadToHideNotifs) {
        Log("BossCards: Reenabling notifications.")
        fSlowClick(32, 596, 17)
        HadToHideNotifs := false
    }
    ResetModifierKeys() ; Cleanup incase of broken loop
    Log("BossCards: Stopped.")
    ToolTip("Card opening aborted`nFound no active buttons.`nF3 to remove note",
        W / 2 - WinRelPosLargeH(170), H / 2)
    SetTimer(ToolTip, -500)
}
