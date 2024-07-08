#Requires AutoHotkey v2.0

global SpammerPID := 0
global CardsBuyEnabled := false
global CardsBossFarmEnabled := false
global BrewEnableArtifacts := true
global BrewEnableEquipment := true
global BrewEnableMaterials := true
global BrewEnableCardParts := true
global BrewEnableScrolls := true

fFarmNormalBoss(modecheck) {
    global on9
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    NormalBossSpammerStart()
    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            Log("BossFarm: Exiting as no game.")
            cReload() ; Kill early if no game
            return
        }
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        if ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            ; Log("Kill timerlast " TimerLastCheckStatus " timer cur "
            ; TimerCurrentState " waslong " IsPrevTimerLong
            ; " islong " IsTimerLong)
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
        if (IsAreaResetToGarden()) {
            Log("BossFarm: User killed.")
            ToolTip("Killed by boss", W / 2, H / 2 + WinRelPosLargeH(50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
        }
        ToolTip("Kills: " . Killcount, W / 2 - WinRelPosLargeW(50), H / 2 +
            WinRelPosLargeH(20), 1)
    }
    ToolTip(, , , 1)
}

fFarmNormalBossAndBrew(modecheck) {
    ToolTip()
    global on9
    Killcount := 0
    Travel.OpenAlchemyGeneral()
    IsPrevTimerLong := IsBossTimerLong()
    NormalBossSpammerStart()
    loop {
        If (on9 != modecheck) {
            break
        }
        if (!IsWindowActive()) {
            Log("BossBrew: Exiting as no game.")
            cReload() ; Kill if no game
            break
        }
        if (!IsPanelActive()) {
            Log("BossBrew: Did not find panel. Aborted brewing. Violins active"
            )
            break
        }
        SetTimer(SpamBrewButtons, -5)
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        if ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
        if (IsAreaResetToGarden() && IsSpammerActive()) {
            KillSpammer()
            Log("BossFarm: User killed.")
            ToolTip("Killed by boss", W / 2, H / 2 + WinRelPosLargeH(50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            return
        }
        ToolTip("Brewing on, Kills: " . Killcount, W / 2 - WinRelPosLargeW(150),
            H / 2 + WinRelPosLargeH(20), 1)
    }
    ToolTip(, , , 1)
}

SpamBrewButtons() {
    if (!IsPanelActive()) {
        Log("SpamBrewButtons: Did not find panel. Aborted.")
        return false
    }
    ; Artifacts
    Artifacts := Points.Brew.Tab1.Artifacts
    If (Artifacts.IsButtonActive() && BrewEnableArtifacts) {
        Artifacts.Click()
    }
    ; Equipment
    Equipment := Points.Brew.Tab1.Equipment
    If (Equipment.IsButtonActive() && BrewEnableEquipment) {
        Equipment.Click()
    }
    ; Materials
    Materials := Points.Brew.Tab1.Materials
    If (Materials.IsButtonActive() && BrewEnableMaterials) {
        Materials.Click()
    }
    ; Scrolls
    Scrolls := Points.Brew.Tab1.Scrolls
    If (Scrolls.IsButtonActive() && BrewEnableScrolls) {
        Scrolls.Click()
    }
    ; Card Parts
    CardParts := Points.Brew.Tab1.CardParts
    If (CardParts.IsButtonActive() && BrewEnableCardParts) {
        CardParts.Click()
    }
    ; Card Parts for fontsize 1
    CardPartsFont1 := Points.Brew.Tab1.CardPartsFont1
    If (CardPartsFont1.IsButtonActive() && BrewEnableCardParts) {
        CardPartsFont1.Click()
    }
    return true
}

fNormalBossFarmWithBorbs(modecheck) {
    global bvAutostartDisabled
    ToolTip()
    global on9
    Killcount := 0

    if (!Travel.GotoBorbVFirstTab()) {
        Log("Borbv: Failed to travel, aborting.")
        ToolTip("Failed to open Borbv, exiting.", W / 2, H / 2 +
            WinRelPosLargeH(50), 5)
        SetTimer(ToolTip.Bind(, , , 5), -3000)
        return
    }

    NormalBossSpammerStart()
    bvAutostartDisabled := false
    if (IsBVAutoStartOn()) {
        ; TODO move point to Points
        fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
        bvAutostartDisabled := true
    }
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            Log("BossBorbs: Exiting as no game.")
            cReload()
            return
        }
        if (!IsPanelActive()) {
            Log("BossBorbs: Did not find panel. Aborted.")
            return
        }
        if (IsAreaResetToGarden() && IsSpammerActive()) {
            KillSpammer()
            Log("BossBorbs: User killed.")
            ToolTip("Killed by boss", W / 2, H / 2 + WinRelPosLargeH(50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            return
        }
        ToolTip("Borbfarm on, Kills: " . Killcount, W / 2 - WinRelPosLargeW(150
        ), H / 1.2, 4)
        BVMainLoop()
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        if ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
    }
    if (bvAutostartDisabled = true && !IsBVAutoStartOn()) {
        ; TODO move point to Points
        fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
    }
    ToolTip(, , , 4)
}

fNormalBossFarmWithCards(modecheck) {
    ToolTip(, , , 4)
    ToolTip()
    global HadToHideNotifs, W, H, X, Y, on9
    Killcount := 0

    if (IsNotificationActive()) {
        Log("Card opening: Found notification covering button and hid"
            " notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := true
    }

    if (!GotoCardsFirstTab()) {
        ; We still failed to travel
        Log("BossCards: Failed to open cards first tab")
        return
    }

    NormalBossSpammerStart()
    IsPrevTimerLong := IsBossTimerLong()
    loop {
        If (on9 != modecheck) {
            return
        }
        if (!IsWindowActive()) {
            Log("BossCards: Exiting as no game.")
            cReload() ; Kill if no game
            return
        }
        if (!IsPanelActive()) {
            Log("BossCards: Did not find panel. Aborted.")
            break
        }
        if (IsNotificationActive()) {
            Log("BossCards: Found notification covering button and hid"
                " notifications.")
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := true
        }
        if (!CardButtonsActive()) {
            Log("BossCards: Exiting.")
            return
        }
        ToolTip("Boss farm with cards active", W / 2 - WinRelPosLargeW(150), H /
            2 + WinRelPosLargeH(320), 9)
        if (CardsBuyEnabled) {
            Log("BossCards buy: Loop starting.")
            CardBuyLoop()
        } else {
            Log("BossCards buy: Disabled.")
        }
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        if ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
        Log("BossCards Opening: Loop starting.")
        loop {
            if (!CardsOpenSinglePass()) {
                Log("BossCards Opening: Loop finishing.")
                break
            }
            if (IsAreaResetToGarden() && IsSpammerActive()) {
                KillSpammer()
                Log("BossCards: User killed.")
                ToolTip("Killed by boss", W / 2, H / 2 + WinRelPosLargeH(50), 2
                )
                SetTimer(ToolTip.Bind(, , , 2), -3000)
                return
            }
            IsTimerLong := IsBossTimerLong()
            ; if state of timer has changed and is now off, we killed
            if ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
                ; If the timer is longer, killed too quick to get a gap
                Killcount++
            }
            IsPrevTimerLong := IsTimerLong
            ToolTip("Cardfarm on, Kills: " . Killcount, W / 2 - WinRelPosLargeW(
                150), H / 1.2, 4)
        }
    }
    ToolTip(, , , 4)
    ToolTip()
    if (HadToHideNotifs) {
        Log("BossCards: Reenabling notifications.")
        Points.Misc.NotifArrow.Click(17)
        HadToHideNotifs := false
    }
    ResetModifierKeys() ; Cleanup incase of broken loop
    Log("BossCards: Stopped.")
    ToolTip("Card opening aborted`nFound no active buttons.`nF3 to remove note",
        W / 2 - WinRelPosLargeH(170), H / 2)
    SetTimer(ToolTip, -500)

}