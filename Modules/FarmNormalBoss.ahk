#Requires AutoHotkey v2.0

Global SpammerPID := 0
Global CardsBuyEnabled := false
Global CardsBossFarmEnabled := false
Global BrewEnableArtifacts := true
Global BrewEnableEquipment := true
Global BrewEnableMaterials := true
Global BrewEnableCardParts := true
Global BrewEnableScrolls := true

fFarmNormalBoss(modecheck) {
    Global on9
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    NormalBossSpammerStart()
    Loop {
        If (on9 != modecheck) {
            Return
        }
        If (!IsWindowActive()) {
            Log("BossFarm: Exiting as no game.")
            cReload() ; Kill early if no game
            Return
        }
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            ; Log("Kill timerlast " TimerLastCheckStatus " timer cur "
            ; TimerCurrentState " waslong " IsPrevTimerLong
            ; " islong " IsTimerLong)
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
        If (Travel.HomeGarden.IsAreaGarden()) {
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
    Global on9
    Killcount := 0
    Travel.OpenAlchemyGeneral()
    IsPrevTimerLong := IsBossTimerLong()
    NormalBossSpammerStart()
    Loop {
        If (on9 != modecheck) {
            Break
        }
        If (!IsWindowActive()) {
            Log("BossBrew: Exiting as no game.")
            cReload() ; Kill if no game
            Break
        }
        If (!IsPanelActive()) {
            Log("BossBrew: Did not find panel. Aborted brewing. Violins active"
            )
            Break
        }
        SetTimer(SpamBrewButtons, -5)
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
        If (Travel.HomeGarden.IsAreaGarden() && IsSpammerActive()) {
            KillSpammer()
            Log("BossFarm: User killed.")
            ToolTip("Killed by boss", W / 2, H / 2 + WinRelPosLargeH(50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            Return
        }
        ToolTip("Brewing on, Kills: " . Killcount, W / 2 - WinRelPosLargeW(150),
            H / 2 + WinRelPosLargeH(20), 1)
    }
    ToolTip(, , , 1)
}

SpamBrewButtons() {
    If (!IsPanelActive()) {
        Log("SpamBrewButtons: Did not find panel. Aborted.")
        Return false
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
    Return true
}

fNormalBossFarmWithBorbs(modecheck) {
    Global bvAutostartDisabled
    ToolTip()
    Global on9
    Killcount := 0

    If (!Travel.GotoBorbVFirstTab()) {
        Log("Borbv: Failed to travel, aborting.")
        ToolTip("Failed to open Borbv, exiting.", W / 2, H / 2 +
            WinRelPosLargeH(50), 5)
        SetTimer(ToolTip.Bind(, , , 5), -3000)
        Return
    }

    NormalBossSpammerStart()
    bvAutostartDisabled := false
    If (IsBVAutoStartOn()) {
        ; TODO move point to Points
        fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
        bvAutostartDisabled := true
    }
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    Loop {
        If (on9 != modecheck) {
            Return
        }
        If (!IsWindowActive()) {
            Log("BossBorbs: Exiting as no game.")
            cReload()
            Return
        }
        If (!IsPanelActive()) {
            Log("BossBorbs: Did not find panel. Aborted.")
            Return
        }
        If (Travel.HomeGarden.IsAreaGarden() && IsSpammerActive()) {
            KillSpammer()
            Log("BossBorbs: User killed.")
            ToolTip("Killed by boss", W / 2, H / 2 + WinRelPosLargeH(50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            Return
        }
        ToolTip("Borbfarm on, Kills: " . Killcount, W / 2 - WinRelPosLargeW(150
        ), H / 1.2, 4)
        BVMainLoop()
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
    }
    If (bvAutostartDisabled = true && !IsBVAutoStartOn()) {
        ; TODO move point to Points
        fCustomClick(WinRelPosLargeW(591), WinRelPosLargeH(1100), 34)
    }
    ToolTip(, , , 4)
}

fNormalBossFarmWithCards(modecheck) {
    ToolTip(, , , 4)
    ToolTip()
    Global HadToHideNotifs, W, H, X, Y, on9
    Killcount := 0

    If (IsNotificationActive()) {
        Log("Card opening: Found notification covering button and hid"
            " notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := true
    }

    If (!GotoCardsFirstTab()) {
        ; We still failed to travel
        Log("BossCards: Failed to open cards first tab")
        Return
    }

    NormalBossSpammerStart()
    IsPrevTimerLong := IsBossTimerLong()
    Loop {
        If (on9 != modecheck) {
            Return
        }
        If (!IsWindowActive()) {
            Log("BossCards: Exiting as no game.")
            cReload() ; Kill if no game
            Return
        }
        If (!IsPanelActive()) {
            Log("BossCards: Did not find panel. Aborted.")
            Break
        }
        If (IsNotificationActive()) {
            Log("BossCards: Found notification covering button and hid"
                " notifications.")
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := true
        }
        If (!CardButtonsActive()) {
            Log("BossCards: Exiting.")
            Return
        }
        ToolTip("Boss farm with cards active", W / 2 - WinRelPosLargeW(150), H /
            2 + WinRelPosLargeH(320), 9)
        If (CardsBuyEnabled) {
            Log("BossCards buy: Loop starting.")
            CardBuyLoop()
        } Else {
            Log("BossCards buy: Disabled.")
        }
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
        Log("BossCards Opening: Loop starting.")
        Loop {
            If (!CardsOpenSinglePass()) {
                Log("BossCards Opening: Loop finishing.")
                Break
            }
            If (Travel.HomeGarden.IsAreaGarden() && IsSpammerActive()) {
                KillSpammer()
                Log("BossCards: User killed.")
                ToolTip("Killed by boss", W / 2, H / 2 + WinRelPosLargeH(50), 2
                )
                SetTimer(ToolTip.Bind(, , , 2), -3000)
                Return
            }
            IsTimerLong := IsBossTimerLong()
            ; if state of timer has changed and is now off, we killed
            If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
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
    If (HadToHideNotifs) {
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