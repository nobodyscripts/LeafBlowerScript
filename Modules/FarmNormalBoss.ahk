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
    Spammer.NormalBossStart()
    Loop {
        If (on9 != modecheck) {
            Return
        }
        If (!Window.IsActive()) {
            Out.I("BossFarm: Exiting as no game.")
            cReload() ; Kill early if no game
            Return
        }
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            ; Out.I("Kill timerlast " TimerLastCheckStatus " timer cur "
            ; TimerCurrentState " waslong " IsPrevTimerLong
            ; " islong " IsTimerLong)
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
        If (Travel.HomeGarden.IsAreaGarden()) {
            Out.I("BossFarm: User killed.")
            ToolTip("Killed by boss", Window.W / 2, Window.H / 2 + Window.RelH(
                50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
        }
        ToolTip("Kills: " . Killcount, Window.W / 2 - Window.RelW(50), Window.H /
        2 + Window.RelH(20), 1)
    }
    ToolTip(, , , 1)
}

fFarmNormalBossAndBrew(modecheck) {
    ToolTip()
    Global on9
    Killcount := 0
    Shops.OpenAlchemyGeneral()
    IsPrevTimerLong := IsBossTimerLong()
    Spammer.NormalBossStart()
    Loop {
        If (on9 != modecheck) {
            Break
        }
        If (!Window.IsActive()) {
            Out.I("BossBrew: Exiting as no game.")
            cReload() ; Kill if no game
            Break
        }
        If (!Window.IsPanel()) {
            Out.I(
                "BossBrew: Did not find panel. Aborted brewing. Violins active"
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
        If (Travel.HomeGarden.IsAreaGarden() && Spammer.IsNormalBossActive()) {
            Spammer.KillNormalBoss()
            Out.I("BossFarm: User killed.")
            ToolTip("Killed by boss", Window.W / 2, Window.H / 2 + Window.RelH(
                50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            Return
        }
        ToolTip("Brewing on, Kills: " . Killcount, Window.W / 2 - Window.RelW(
            150), Window.H / 2 + Window.RelH(20), 1)
    }
    ToolTip(, , , 1)
}

SpamBrewButtons() {
    If (!Window.IsPanel()) {
        Out.I("SpamBrewButtons: Did not find panel. Aborted.")
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

    If (!Shops.GotoBorbVFirstTab()) {
        Out.I("Borbv: Failed to travel, aborting.")
        ToolTip("Failed to open Borbv, exiting.", Window.W / 2, Window.H / 2 +
            Window.RelH(50), 5)
        SetTimer(ToolTip.Bind(, , , 5), -3000)
        Return
    }

    Spammer.NormalBossStart()
    bvAutostartDisabled := false
    If (IsBVAutoStartOn()) {
        ; TODO move point to Points
        fCustomClick(Window.RelW(591), Window.RelH(1100), 34)
        bvAutostartDisabled := true
    }
    Killcount := 0
    IsPrevTimerLong := IsBossTimerLong()
    Loop {
        If (on9 != modecheck) {
            Return
        }
        If (!Window.IsActive()) {
            Out.I("BossBorbs: Exiting as no game.")
            cReload()
            Return
        }
        If (!Window.IsPanel()) {
            Out.I("BossBorbs: Did not find panel. Aborted.")
            Return
        }
        If (Travel.HomeGarden.IsAreaGarden() && Spammer.IsNormalBossActive()) {
            Spammer.KillNormalBoss()
            Out.I("BossBorbs: User killed.")
            ToolTip("Killed by boss", Window.W / 2, Window.H / 2 + Window.RelH(
                50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            Return
        }
        ToolTip("Borbfarm on, Kills: " . Killcount, Window.W / 2 - Window.RelW(
            150), Window.H / 1.2, 4)
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
        fCustomClick(Window.RelW(591), Window.RelH(1100), 34)
    }
    ToolTip(, , , 4)
}

fNormalBossFarmWithCards(modecheck) {
    ToolTip(, , , 4)
    ToolTip()
    Global HadToHideNotifs, on9
    Killcount := 0

    If (IsNotificationActive()) {
        Out.I("Card opening: Found notification covering button and hid"
            " notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := true
    }

    If (!GotoCardsFirstTab()) {
        ; We still failed to travel
        Out.I("BossCards: Failed to open cards first tab")
        Return
    }

    Spammer.NormalBossStart()
    IsPrevTimerLong := IsBossTimerLong()
    Loop {
        If (on9 != modecheck) {
            Return
        }
        If (!Window.IsActive()) {
            Out.I("BossCards: Exiting as no game.")
            cReload() ; Kill if no game
            Return
        }
        If (!Window.IsPanel()) {
            Out.I("BossCards: Did not find panel. Aborted.")
            Break
        }
        If (IsNotificationActive()) {
            Out.I("BossCards: Found notification covering button and hid"
                " notifications.")
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := true
        }
        If (!CardButtonsActive()) {
            Out.I("BossCards: Exiting.")
            Return
        }
        ToolTip("Boss farm with cards active", Window.W / 2 - Window.RelW(150),
        Window.H / 2 + Window.RelH(320), 9)
        If (CardsBuyEnabled) {
            Out.I("BossCards buy: Loop starting.")
            CardBuyLoop()
        } Else {
            Out.I("BossCards buy: Disabled.")
        }
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
            ; If the timer is longer, killed too quick to get a gap
            Killcount++
        }
        IsPrevTimerLong := IsTimerLong
        Out.I("BossCards Opening: Loop starting.")
        Loop {
            If (!CardsOpenSinglePass()) {
                Out.I("BossCards Opening: Loop finishing.")
                Break
            }
            If (Travel.HomeGarden.IsAreaGarden() && Spammer.IsNormalBossActive()) {
                Spammer.KillNormalBoss()
                Out.I("BossCards: User killed.")
                ToolTip("Killed by boss", Window.W / 2, Window.H / 2 + Window.RelH(
                    50), 2)
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
            ToolTip("Cardfarm on, Kills: " . Killcount, Window.W / 2 - Window.RelW(
                150), Window.H / 1.2, 4)
        }
    }
    ToolTip(, , , 4)
    ToolTip()
    If (HadToHideNotifs) {
        Out.I("BossCards: Reenabling notifications.")
        Points.Misc.NotifArrow.Click(17)
        HadToHideNotifs := false
    }
    ResetModifierKeys() ; Cleanup incase of broken loop
    Out.I("BossCards: Stopped.")
    ToolTip("Card opening aborted`nFound no active buttons.`nF3 to remove note",
        Window.W / 2 - Window.RelH(170), Window.H / 2)
    SetTimer(ToolTip, -500)

}
