#Requires AutoHotkey v2.0

global SpammerPID := 0

fFarmNormalBoss(modecheck) {
    global on9
    Killcount := 0
    TimerLastCheckStatus := IsBossTimerActive()
    SpamViolins()
    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            Log("BossFarm: Exiting as no game.")
            reload() ; Kill early if no game
            return
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
    SpamViolins()
    loop {
        If (on9 != modecheck) {
            break
        }
        if (!IsWindowActive()) {
            Log("BossBrew: Exiting as no game.")
            reload() ; Kill if no game
            break
        }
        if (!IsPanelActive()) {
            Log("BossBrew: Did not find panel. Aborted brewing. Violins active")
            break
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
            break
        }
        ToolTip("Brewing on, Kills: " . Killcount,
            W / 2 - WinRelPosLargeW(150),
            H / 2)
        SetTimer(ToolTip, -200)
        TimerLastCheckStatus := TimerCurrentState
    }
}

SpamViolins() {
    global SpammerPID
    if (IsWindowActive() && IsBossTimerActive()) {
        ;TriggerViolin()
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\NormalBoss.ahk"',
            , , &OutPid)
        SpammerPID := OutPid
    }
}

KillSpammer() {
    ;F:\Documents\AutoHotkey\LeafBlowerV3\Secondaries\NormalBoss.ahk - AutoHotkey v2.0.4
    if (SpammerPID && ProcessExist(SpammerPID)) {
        ProcessClose(SpammerPID)
        Log("Closed NormalBoss.ahk using pid.")
    } else {
        if (WinExist(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey")) {
            WinClose(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey")
            Log("Closed NormalBoss.ahk using filename.")
        }
        /* if (WinExist("NormalBoss.ahk - AutoHotkey (Workspace) - Visual Studio Code")) {
            WinClose("NormalBoss.ahk - AutoHotkey (Workspace) - Visual Studio Code")
        } */
    }
}

SpamBrewButtons() {
    if (!IsPanelActive()) {
        Log("SpamBrewButtons: Did not find panel. Aborted.")
        return
    }
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
    SpamViolins()
    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            Log("BossBorbs: Exiting as no game.")
            reload()
            return
        }
        if (!IsPanelActive()) {
            Log("BossBorbs: Did not find panel. Aborted.")
            return
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

    if (IsNotificationActive()) {
        Log("Card opening: Found notification covering button and hid"
            " notifications.")
        fSlowClick(32, 596, 101)
        HadToHideNotifs := true
    }

    if (!GotoCardsFirstTab()) {
        ; We still failed to travel
        Log("BossCards: Failed to open cards first tab")
        return
    }

    SpamViolins()

    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            Log("BossCards: Exiting as no game.")
            reload() ; Kill if no game
            return
        }
        if (!IsPanelActive()) {
            Log("BossCards: Did not find panel. Aborted.")
            break
        }
        if (IsNotificationActive()) {
            Log("BossCards: Found notification covering button and hid"
                " notifications.")
            fSlowClick(32, 596, 101)
            HadToHideNotifs := true
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
        } else {
            Log("BossCards buy: Disabled.")
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