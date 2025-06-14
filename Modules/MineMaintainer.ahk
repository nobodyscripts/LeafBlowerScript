#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cRects.ahk
#Include ..\Lib\Spammers.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\ScriptLib\cTimer.ahk
#Include MineMaintainerCaves.ahk

S.AddSetting("Miner", "MinerEnableVeins", true, "bool")
S.AddSetting("Miner", "MinerEnableTransmute", true, "bool")
S.AddSetting("Miner", "MinerEnableTransmuteSdia", false, "bool")
S.AddSetting("Miner", "MinerEnableTransmuteFuel", false, "bool")
S.AddSetting("Miner", "MinerEnableTransmuteSphere", false, "bool")
S.AddSetting("Miner", "MinerEnableTransmuteSdiaToCDia", false, "bool")
S.AddSetting("Miner", "MinerEnableFreeRefuel", true, "bool")
S.AddSetting("Miner", "MinerEnableBanks", true, "bool")
S.AddSetting("Miner", "MinerEnableSpammer", true, "bool")
S.AddSetting("Miner", "MinerEnableLeafton", false, "bool")
S.AddSetting("Miner", "MinerEnableVeinUpgrade", false, "bool")
S.AddSetting("Miner", "MinerEnableVeinRemoval", false, "bool")
S.AddSetting("Miner", "MinerEnableSphereUse", false, "bool")
S.AddSetting("Miner", "MinerEnableCaves", true, "bool")
S.AddSetting("Miner", "MinerSphereGreedyUse", false, "bool")
S.AddSetting("Miner", "MinerSphereDelay", 1000, "int")
S.AddSetting("Miner", "MinerSphereCount", 0, "int")
S.AddSetting("Miner", "MinerSphereTimer", 1, "int")
S.AddSetting("Miner", "MinerSphereModifier", 1, "int")
S.AddSetting("Miner", "MinerTransmuteTimer", 10, "int")
S.AddSetting("Miner", "MinerRefuelTimer", 1, "int")
S.AddSetting("Miner", "MinerCaveTimer", 5, "int")
S.AddSetting("Miner", "MinerEnableBrewing", true, "bool")
S.AddSetting("Miner", "MinerBrewCycleTime", 30, "int")
S.AddSetting("Miner", "MinerBrewCutOffTime", 30, "int")

fMineMaintainer() {
    MinerEnableVeins := S.Get("MinerEnableVeins")
    MinerEnableTransmute := S.Get("MinerEnableTransmute")
    MinerEnableTransmuteSdia := S.Get("MinerEnableTransmuteSdia")
    MinerEnableTransmuteFuel := S.Get("MinerEnableTransmuteFuel")
    MinerEnableTransmuteSphere := S.Get("MinerEnableTransmuteSphere")
    MinerEnableTransmuteSdiaToCDia := S.Get("MinerEnableTransmuteSdiaToCDia")
    MinerEnableFreeRefuel := S.Get("MinerEnableFreeRefuel")
    MinerEnableBanks := S.Get("MinerEnableBanks")
    MinerEnableSpammer := S.Get("MinerEnableSpammer")
    MinerEnableLeafton := S.Get("MinerEnableLeafton")
    MinerEnableVeinUpgrade := S.Get("MinerEnableVeinUpgrade")
    MinerEnableVeinRemoval := S.Get("MinerEnableVeinRemoval")
    MinerEnableSphereUse := S.Get("MinerEnableSphereUse")
    MinerEnableCaves := S.Get("MinerEnableCaves")
    MinerSphereGreedyUse := S.Get("MinerSphereGreedyUse")
    MinerSphereDelay := S.Get("MinerSphereDelay")
    MinerSphereCount := S.Get("MinerSphereCount")
    MinerSphereTimer := S.Get("MinerSphereTimer")
    MinerSphereModifier := S.Get("MinerSphereModifier")
    MinerTransmuteTimer := S.Get("MinerTransmuteTimer")
    MinerRefuelTimer := S.Get("MinerRefuelTimer")
    MinerCaveTimer := S.Get("MinerCaveTimer")
    MinerEnableBrewing := S.Get("MinerEnableBrewing")
    MinerBrewCycleTime := S.Get("MinerBrewCycleTime")
    MinerBrewCutOffTime := S.Get("MinerBrewCutOffTime")
    BankDepositTime := S.Get("BankDepositTime")
    NavigateTime := S.Get("NavigateTime")
    If (MinerRefuelTimer = 0) { ; If user set 0 in gui without adding a fraction, make at least 1 second
        MinerRefuelTimer := 0.017
    }
    If (MinerSphereTimer = 0) {
        MinerSphereTimer := 0.017
    }
    If (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    Firstpass := true
    MineTime := A_Now
    TransmuteTime := A_Now
    RefuelTime := A_Now
    BankTime := A_Now
    SphereTime := A_Now
    CavesTime := A_Now
    CurrentTab := 0
    /** @type {cLBRButton} */
    VeinsTab := Points.Mine.Tab1Vein
    /** @type {cLBRButton} */
    MinesTab := Points.Mine.Tab2Mines
    /** @type {cLBRButton} */
    DrillTab := Points.Mine.Tab4Drill
    /** @type {cLBRButton} */
    ShopTab := Points.Mine.Tab5Shop
    /** @type {cLBRButton} */
    TransmuteTab := Points.Mine.Tab6Transmute
    /** @type {cLBRButton} */
    VeinUpgradeButton := Points.Mine.Vein.Upgrade
    /** @type {cLBRButton} */
    CancelConfirm := Points.Mine.Vein.CancelConfirm
    /** @type {Timer} */
    BrewCycleTimer := Timer()
    /** @type {Timer} */
    BrewCutOffTimer := Timer()

    ToolTip("Mine Maintainer Active", Window.W / 2, Window.RelH(200), 4)
    ; Log mine settings for remote debugging
    MineLogSettings()
    If (MinerEnableLeafton) {
        LeaftonTaxiSinglePassStart()
        Sleep(NavigateTime)
    } Else If (MinerEnableSpammer) {
        Spammer.NormalBossStart()
    }
    Shops.Mine.GoTo()
    Loop {
        ;@region Loop
        If (Window.IsActive() && MinerEnableLeafton) {
            LeaftonTaxiSinglePass()
        }
        If (Window.IsActive() && !Window.IsPanel()) {
            Shops.Mine.GoTo()
        }
        ;@region Veins
        If (Window.IsActive() && Window.IsPanel() && (MinerEnableVeins ||
            MinerEnableVeinRemoval)) {
            i := 1
            Out.D("Opening veins tab")
            While (!Shops.Mine.IsOnTabVein() && i <= 4) {
                If (VeinsTab.IsButton()) {
                    VeinsTab.ClickOffset(, , NavigateTime)
                    Sleep(NavigateTime)
                }
                i++
            }
            If (Shops.Mine.IsOnTabVein()) {
                If (MinerEnableVeinRemoval) {
                    RemoveSingleVein()
                    Sleep(NavigateTime)
                    If (CancelConfirm.IsButtonActive()) {
                        VeinCancelConfirm()
                    }
                }
                If (MinerEnableVeins) {
                    EnhanceVeins()
                }
            } Else {
                If (!VeinsTab.IsButton()) {
                    VeinCancelConfirm()
                    Out.I("Mine: Found vein removal stuck, removed")
                } Else {
                    Out.I("Mine: Vein tab click failed")
                }
            }
        }
        ;@endregion

        ;@region Vein upgrade
        If (Window.IsActive() && Window.IsPanel() && Shops.Mine.IsOnTabVein() &&
        VeinUpgradeButton.IsButtonActive() && MinerEnableVeinUpgrade) {
            Out.I("Upgrading vein")
            VeinUpgradeButton.ClickOffset(, , NavigateTime)
        }
        ;@endregion

        ;@region Transmute
        If (Window.IsActive() && isAnyTransmuteEnabled() && Window.IsPanel()) {
            If (Firstpass || DateDiff(A_Now, TransmuteTime, "Seconds") >=
            MinerTransmuteTimer) {
                TransmuteTime := A_Now
                i := 1
                Out.D("Opening transmute tab")
                While (!Shops.Mine.IsOnTabTrans() && i <= 4) {
                    If (TransmuteTab.IsButton()) {
                        TransmuteTab.ClickOffset(, , NavigateTime)
                        Sleep(NavigateTime)
                    }
                    i++
                }
                If (Shops.Mine.IsOnTabTrans()) {
                    TransmuteAllCoalBars()
                    Out.I("Mine: Transmuted all bars.")
                    Sleep(NavigateTime)
                } Else {
                    Out.I("Mine: Transmute tab click failed")
                }
            }
        }
        ;@endregion

        ;@region Fuel
        If (MinerEnableFreeRefuel && Window.IsActive() && Window.IsPanel()) {
            If (Firstpass || DateDiff(A_Now, RefuelTime, "Seconds") >=
            MinerRefuelTimer * 60) {
                RefuelTime := A_Now
                i := 1
                Out.D("Opening drill tab")
                While (!Shops.Mine.IsOnTabDrill() && i <= 4) {
                    If (DrillTab.IsButton()) {
                        DrillTab.ClickOffset(, , NavigateTime)
                        Sleep(NavigateTime)
                    }
                    i++
                }
                If (Shops.Mine.IsOnTabDrill()) {
                    CollectFreeDrillFuel()
                    Out.I("Mine: Collected free fuel.")
                    Sleep(NavigateTime)
                } Else {
                    Out.I("Mine: Drill tab click failed")
                }
            }
        }
        ;@endregion

        ;@region Sphere
        If (Window.IsActive() && Window.IsPanel() && MinerEnableSphereUse) {
            If (Firstpass || DateDiff(A_Now, SphereTime, "Seconds") >=
            MinerSphereTimer * 60) {
                SphereTime := A_Now
                i := 1
                Out.D("Opening drill tab")
                While (!Shops.Mine.IsOnTabDrill() && i <= 4) {
                    If (DrillTab.IsButton()) {
                        DrillTab.ClickOffset(, , NavigateTime)
                        Sleep(NavigateTime)
                    }
                    i++
                }
                If (Shops.Mine.IsOnTabDrill()) {
                    Sleep(NavigateTime)
                    Out.I("Mine: Using spheres.")
                    UseDrillSphereLoop()
                    Sleep(NavigateTime)
                    ResetModifierKeys()
                } Else {
                    Out.I("Mine: Drill tab click failed")
                }
            }
        }
        ;@endregion

        ;@region Banks
        If (Window.IsActive() && Window.IsPanel() && MinerEnableBanks) {
            If (Firstpass || DateDiff(A_Now, BankTime, "Seconds") >=
            BankDepositTime * 60) {
                ToolTip(, , , 4)
                Out.I("Mine: Bank Maintainer starting.")
                ToolTip("Mine Bank Maintainer Active", Window.W / 2, Window.RelH(
                    200), 4)
                Sleep(NavigateTime)
                BankSinglePass()
                ToolTip(, , , 4)
                ToolTip("Mine Maintainer Active", Window.W / 2, Window.RelH(200
                ), 4)
                BankTime := A_Now
                ; Single pass does try to close, this is redundancy
                Travel.ClosePanelIfActive()
                Shops.Mine.GoTo()
            }
        }
        ;@endregion

        ;@region Caves
        If (Window.IsActive() && Window.IsPanel() && MinerEnableCaves) {
            If (Firstpass || DateDiff(A_Now, CavesTime, "Seconds") >=
            MinerCaveTimer * 60) {
                i := 1
                While (!Shops.Mine.IsOnTabMines() && i <= 4 && Window.IsPanel()) {
                    MinesTab.ClickOffset(, , NavigateTime)
                    Sleep(NavigateTime)
                    i++
                }
                If (Shops.Mine.IsOnTabMines()) {
                    Out.I("Mine: Cave Maintainer starting.")
                    Sleep(NavigateTime)
                    CavesSinglePass()
                    CavesTime := A_Now
                    Sleep(NavigateTime)
                } Else {
                    Out.I("Mine: Cave tab click failed")
                }
            }
        }
        ;@endregion

        ;@region Brew
        If (Window.IsActive() && MinerEnableBrewing && !BrewCycleTimer.Running) {
            Out.I("Mine: Brewing")
            If (Shops.OpenAlchemyGeneral()) {
                BrewCutOffTimer.CoolDownS(MinerBrewCutOffTime, &
                    BrewCutOffRunning)
                While (BrewCutOffRunning && Shops.IsAlchGeneralTab()) {
                    If (!SpamBrewButtons()) {
                        Break
                    }
                }
                BrewCycleTimer.CoolDownS(MinerBrewCycleTime, &BrewCycleRunning)
                Sleep(NavigateTime)
                Travel.ClosePanelIfActive()
            } Else {
                Out.I("Mine Brew: Travel to Alch general tab failed after 4" .
                    " attempts.")
            }
        }
        Firstpass := false
        ;@endregion
    }
    If (MinerEnableLeafton) {
        LeaftonTaxiSinglePassEnd()
    } Else If (MinerEnableSpammer) {
        Spammer.KillNormalBoss()
    }
}

;@region Transmute Functions
isAnyTransmuteEnabled() {
    Return S.Get("MinerEnableTransmute") || S.Get("MinerEnableTransmuteSdia") ||
    S.Get("MinerEnableTransmuteFuel") || S.Get("MinerEnableTransmuteSphere") ||
    S.Get("MinerEnableTransmuteSdiaToCDia")
}

TransmuteAllCoalBars() {
    NavigateTime := S.Get("NavigateTime")
    If (S.Get("MinerEnableTransmute")) {
        TransmuteButton := Points.Mine.Transmute.AllCBarsToCDias
        While (Window.IsActive() && Window.IsPanel() && TransmuteButton.IsButtonActive() &&
        Shops.Mine.IsOnTabTrans()) {
            TransmuteButton.ClickOffset()
            Out.D("Transmuted all coal bars to coal diamonds")
            Sleep(NavigateTime)
        }
    }
    If (S.Get("MinerEnableTransmuteSdia")) {
        SdiaTransmuteButton := Points.Mine.Transmute.AllCDiasToSDias
        While (Window.IsActive() && Window.IsPanel() && SdiaTransmuteButton.IsButtonActive() &&
        Shops.Mine.IsOnTabTrans()) {
            SdiaTransmuteButton.ClickOffset()
            Out.D("Transmuted all coal diamonds to shiny diamonds")
            Sleep(NavigateTime)
        }
    }
    If (S.Get("MinerEnableTransmuteFuel")) {
        FuelTransmuteButton := Points.Mine.Transmute.AllCDiasToFuel
        While (Window.IsActive() && Window.IsPanel() && FuelTransmuteButton.IsButtonActive() &&
        Shops.Mine.IsOnTabTrans()) {
            FuelTransmuteButton.ClickOffset()
            Out.D("Transmuted all coal diamonds to fuel")
            Sleep(NavigateTime)
        }
    }
    If (S.Get("MinerEnableTransmuteSphere")) {
        SphereTransmuteButton := Points.Mine.Transmute.AllCDiasToSpheres
        While (Window.IsActive() && Window.IsPanel() && SphereTransmuteButton.IsButtonActive() &&
        Shops.Mine.IsOnTabTrans()) {
            SphereTransmuteButton.ClickOffset()
            Out.D("Transmuted all coal diamonds to spheres")
            Sleep(NavigateTime)
        }
    }
    If (S.Get("MinerEnableTransmuteSdiaToCDia")) {
        SdiaToCBTransmuteButton := Points.Mine.Transmute.AllSDiasToCDia
        While (Window.IsActive() && Window.IsPanel() && SdiaToCBTransmuteButton
        .IsButtonActive() && Shops.Mine.IsOnTabTrans()) {
            SdiaToCBTransmuteButton.ClickOffset()
            Out.D("Transmuted all shiny diamonds to coal diamonds")
            Sleep(NavigateTime)
        }
    }
}
;@endregion

;@region Drill Functions
CollectFreeDrillFuel() {
    NavigateTime := S.Get("NavigateTime")
    FuelButton := Points.Mine.FreeFuel
    While (Window.IsActive() && Window.IsPanel() && FuelButton.IsButtonActive()) {
        FuelButton.ClickOffset()
        Sleep(NavigateTime)
    }
}

UseDrillSphereLoop() {
    /**
     * @type {cLBRButton} SphereButton
     */
    SphereButton := Points.Mine.CoalSphere

    /**
     * @type {cLBRButton} tempCount
     */
    MinerSphereCount := tempCount := S.Get("MinerSphereCount")
    MinerSphereDelay := S.Get("MinerSphereDelay")
    MinerSphereModifier := S.Get("MinerSphereModifier")
    MinerSphereGreedyUse := S.Get("MinerSphereGreedyUse")

    If (MinerSphereCount > 0) {
        While (Window.IsActive() && Window.IsPanel() && ;
        SphereButton.IsButtonActive() && tempCount > 0) {
            If (MinerSphereModifier > 1) {
                ; limited count, with modifier
                AmountToModifier(MinerSphereModifier)
                Sleep(72)
                SphereButton.ClickOffset()
                Sleep(MinerSphereDelay)
            } Else {
                ; limited count
                SphereButton.ClickOffset()
                Sleep(MinerSphereDelay)
            }
            tempCount--
        }
    } Else {
        If (!MinerSphereGreedyUse) {
            ; Inf use, no greedy
            While (Window.IsActive() && Window.IsPanel() && ;
            SphereButton.IsButtonActive()) {
                If (MinerSphereModifier > 1) {
                    AmountToModifier(MinerSphereModifier)
                    Sleep(34)
                    SphereButton.ClickOffset()
                    Sleep(MinerSphereDelay)
                } Else {
                    SphereButton.ClickOffset()
                    Sleep(MinerSphereDelay)
                }
            }
        } Else {
            ; Greedy
            SphereButton.GreedyModifierClick(MinerSphereDelay, 72,
                MinerSphereModifier)
            Sleep(MinerSphereDelay)
        }
    }

    ResetModifierKeys()
}
;@endregion

;@region Vein functions
EnhanceVeins() {
    NavigateTime := S.Get("NavigateTime")
    slot1 := Points.Mine.Vein.Slot1.Enhance
    slot2 := Points.Mine.Vein.Slot2.Enhance
    slot3 := Points.Mine.Vein.Slot3.Enhance
    slot4 := Points.Mine.Vein.Slot4.Enhance
    slot5 := Points.Mine.Vein.Slot5.Enhance
    slot6 := Points.Mine.Vein.Slot6.Enhance
    While (Window.IsActive() && Window.IsPanel() && !slot1.IsBackground()) {
        If (slot1.IsButtonActive()) {
            slot1.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (Window.IsActive() && Window.IsPanel() && !slot2.IsBackground()) {
        If (slot2.IsButtonActive()) {
            slot2.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (Window.IsActive() && Window.IsPanel() && !slot3.IsBackground()) {
        If (slot3.IsButtonActive()) {
            slot3.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (Window.IsActive() && Window.IsPanel() && !slot4.IsBackground()) {
        If (slot4.IsButtonActive()) {
            slot4.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (Window.IsActive() && Window.IsPanel() && !slot5.IsBackground()) {
        If (slot5.IsButtonActive()) {
            slot5.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (Window.IsActive() && Window.IsPanel() && !slot6.IsBackground()) {
        If (slot6.IsButtonActive()) {
            slot6.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
}

RemoveSingleVein() {
    NavigateTime := S.Get("NavigateTime")
    Cancel1 := Points.Mine.Vein.Slot1.Cancel
    Cancel2 := Points.Mine.Vein.Slot2.Cancel
    Cancel3 := Points.Mine.Vein.Slot3.Cancel
    Cancel4 := Points.Mine.Vein.Slot4.Cancel
    Cancel5 := Points.Mine.Vein.Slot5.Cancel
    Cancel6 := Points.Mine.Vein.Slot6.Cancel

    VeinTotalCount := FindVeinsCount()
    If (VeinTotalCount < 6) {
        Return
    }
    PotentialVeins := FindVeinsWithBars()
    /* if (Debug) {
        Out.I("Found the following veins:")
        ArrDebug(PotentialVeins)
    } */
    LowestPrioritySlot := FindVeinsLowestPriority(PotentialVeins)
    If (LowestPrioritySlot = 0) {
        Return false
    }

    If (VeinTotalCount = 6 && PotentialVeins[1].Active = true &&
        LowestPrioritySlot = 1) {
        Out.I("Removing slot 1")
        Cancel1.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[2].Active = true &&
        LowestPrioritySlot = 2) {
        Out.I("Removing slot 2")
        Cancel2.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[3].Active = true &&
        LowestPrioritySlot = 3) {
        Out.I("Removing slot 3")
        Cancel3.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[4].Active = true &&
        LowestPrioritySlot = 4) {
        Out.I("Removing slot 4")
        Cancel4.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[5].Active = true &&
        LowestPrioritySlot = 5) {
        Out.I("Removing slot 5")
        Cancel5.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[6].Active = true &&
        LowestPrioritySlot = 6) {
        Out.I("Removing slot 6")
        Cancel6.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    Return false

}

VeinCancelConfirm() {
    NavigateTime := S.Get("NavigateTime")
    CancelConfirm := Points.Mine.Vein.CancelConfirm
    CancelConfirm.WaitUntilButtonS(3)
    CancelConfirm.ClickButtonActive()
    CancelConfirm.ClickButtonActive()
    Sleep(NavigateTime + 50)
}

FindVeinsWithBars() {
    SampleSlot1 := Points.Mine.Vein.Slot1.Icon
    SampleSlot2 := Points.Mine.Vein.Slot2.Icon
    SampleSlot3 := Points.Mine.Vein.Slot3.Icon
    SampleSlot4 := Points.Mine.Vein.Slot4.Icon
    SampleSlot5 := Points.Mine.Vein.Slot5.Icon
    SampleSlot6 := Points.Mine.Vein.Slot6.Icon
    QualitySlot1 := Points.Mine.Vein.Slot1.Colour
    QualitySlot2 := Points.Mine.Vein.Slot2.Colour
    QualitySlot3 := Points.Mine.Vein.Slot3.Colour
    QualitySlot4 := Points.Mine.Vein.Slot4.Colour
    QualitySlot5 := Points.Mine.Vein.Slot5.Colour
    QualitySlot6 := Points.Mine.Vein.Slot6.Colour

    results := [{
        Active: false,
        Quality: "ignored",
        Priority: 9999
    },
    ;
    {
        Active: false,
        Quality: "ignored",
        Priority: 9999
    },
    ;
    {
        Active: false,
        Quality: "ignored",
        Priority: 9999
    },
    ;
    {
        Active: false,
        Quality: "ignored",
        Priority: 9999
    },
    ;
    {
        Active: false,
        Quality: "ignored",
        Priority: 9999
    },
    ;
    {
        Active: false,
        Quality: "ignored",
        Priority: 9999
    }]
    If (SampleSlot1.GetColour() = "0x6D758D") {
        qualityText1 := VeinQualityColourToText(QualitySlot1.GetColour())
        results[1] := {
            Active: true,
            Quality: qualityText1,
            Priority: VeinQualityToPriority(qualityText1) - 4
        }
    }
    If (SampleSlot2.GetColour() = "0x6D758D") {
        qualityText2 := VeinQualityColourToText(QualitySlot2.GetColour())
        results[2] := {
            Active: true,
            Quality: qualityText2,
            Priority: VeinQualityToPriority(qualityText2) - 2
        }
    }
    If (SampleSlot3.GetColour() = "0x6D758D") {
        qualityText3 := VeinQualityColourToText(QualitySlot3.GetColour())
        results[3] := {
            Active: true,
            Quality: qualityText3,
            Priority: VeinQualityToPriority(qualityText3) - 1
        }
    }
    If (SampleSlot4.GetColour() = "0x6D758D") {
        qualityText4 := VeinQualityColourToText(QualitySlot4.GetColour())
        results[4] := {
            Active: true,
            Quality: qualityText4,
            Priority: VeinQualityToPriority(qualityText4)
        }
    }
    If (SampleSlot5.GetColour() = "0x6D758D") {
        qualityText5 := VeinQualityColourToText(QualitySlot5.GetColour())
        results[5] := {
            Active: true,
            Quality: qualityText5,
            Priority: VeinQualityToPriority(qualityText5)
        }
    }
    If (SampleSlot6.GetColour() = "0x6D758D") {
        qualityText6 := VeinQualityColourToText(QualitySlot6.GetColour())
        results[6] := {
            Active: true,
            Quality: qualityText6,
            Priority: VeinQualityToPriority(qualityText6)
        }
    }
    Return results
}

FindVeinsCount() {
    results := 0
    Cancel1 := Points.Mine.Vein.Slot1.Cancel
    Cancel2 := Points.Mine.Vein.Slot2.Cancel
    Cancel3 := Points.Mine.Vein.Slot3.Cancel
    Cancel4 := Points.Mine.Vein.Slot4.Cancel
    Cancel5 := Points.Mine.Vein.Slot5.Cancel
    Cancel6 := Points.Mine.Vein.Slot6.Cancel
    If (Cancel1.IsButtonActive()) {
        results++
    }
    If (Cancel2.IsButtonActive()) {
        results++
    }
    If (Cancel3.IsButtonActive()) {
        results++
    }
    If (Cancel4.IsButtonActive()) {
        results++
    }
    If (Cancel5.IsButtonActive()) {
        results++
    }
    If (Cancel6.IsButtonActive()) {
        results++
    }
    ;Out.I("Findveinscount: " results)
    Return results
}

VeinQualityColourToText(value) {
    MinerColourCodeCommon := "0xA0A0A0"
    MinerColourCodeUncommon := "0x326DAB"
    MinerColourCodeRare := "0xD3C33F"
    MinerColourCodeEpic := "0xB3260A"
    MinerColourCodeMythical := "0x9E10C1"
    MinerColourCodeLegendary := "0xE1661A"
    Switch value {
    Case MinerColourCodeCommon:
        Return "common"
    Case MinerColourCodeUncommon:
        Return "uncommon"
    Case MinerColourCodeRare:
        Return "rare"
    Case MinerColourCodeEpic:
        Return "epic"
    Case MinerColourCodeMythical:
        Return "mythical"
    Case MinerColourCodeLegendary:
        Return "legendary"
    default:
        Return "special"
    }
}

VeinQualityToPriority(value) {
    Switch value {
    Case "common":
        Return 1
    Case "uncommon":
        Return 2
    Case "rare":
        Return 3
    Case "epic":
        Return 4
    Case "mythical":
        Return 5
    Case "legendary":
        Return 6
    default:
        Return 9999
    }
}

FindVeinsLowestPriority(StatusArray) {
    slotId := 0
    lowestValue := 99999

    ; We need to check through the array in reverse order, so that if value
    ; matches, we remove the oldest
    k := StatusArray.Length
    While (k > 0) {
        If (StatusArray[k].Priority <= lowestValue && StatusArray[k].Active) {
            slotId := k
            lowestValue := StatusArray[k].Priority
        }
        k--
    }
    Out.D("Slot " slotId " value " lowestValue " picked.")
    Return slotId
}
;@endregion

ArrDebug(arr) {
    i := 1
    While (i <= arr.Length) {
        Out.I(i " Active " arr[i].Active " Quality " arr[i].Quality " Priority " arr[
            i].Priority)
        i++
    }
}

MineLogSettings() {
    Out.D("Dumping Mine settings to log:"
        "`nMinerEnableVeins: " S.Get("MinerEnableVeins")
        "`nMinerEnableTransmute: " S.Get("MinerEnableTransmute")
        "`nMinerEnableFreeRefuel: " S.Get("MinerEnableFreeRefuel")
        "`nMinerTransmuteTimer: " S.Get("MinerTransmuteTimer")
        "`nMinerRefuelTimer: " S.Get("MinerRefuelTimer")
        "`nMinerEnableSpammer: " S.Get("MinerEnableSpammer")
        "`nMinerEnableBanks: " S.Get("MinerEnableBanks")
        "`nMinerEnableVeinUpgrade: " S.Get("MinerEnableVeinUpgrade")
        "`nMinerEnableVeinRemoval: " S.Get("MinerEnableVeinRemoval")
        "`nMinerEnableCaves: " S.Get("MinerEnableCaves")
        "`nMinerCaveTimer: " S.Get("MinerCaveTimer")
        "`nMinerEnableLeafton: " S.Get("MinerEnableLeafton")
        "`nMinerEnableSphereUse: " S.Get("MinerEnableSphereUse")
        "`nMinerSphereDelay: " S.Get("MinerSphereDelay")
        "`nMinerSphereCount: " S.Get("MinerSphereCount")
        "`nMinerSphereTimer: " S.Get("MinerSphereTimer")
        "`nMinerSphereGreedyUse: " S.Get("MinerSphereGreedyUse")
        "`nMinerSphereModifier: " S.Get("MinerSphereModifier")
        "`nMinerEnableTransmuteSdia: " S.Get("MinerEnableTransmuteSdia")
        "`nMinerEnableTransmuteFuel: " S.Get("MinerEnableTransmuteFuel")
        "`nMinerEnableTransmuteSphere: " S.Get("MinerEnableTransmuteSphere")
        "`nMinerEnableTransmuteSdiaToCDia: " S.Get("MinerEnableTransmuteSdiaToCDia")
        "`nMinerEnableBrewing: " S.Get("MinerEnableBrewing")
        "`nMinerBrewCycleTime: " S.Get("MinerBrewCycleTime")
        "`nMinerBrewCutOffTime: " S.Get("MinerBrewCutOffTime)"))
}
