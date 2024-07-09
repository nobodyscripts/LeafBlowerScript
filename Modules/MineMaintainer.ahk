#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cRects.ahk
#Include ..\Lib\Spammers.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\Lib\cTimer.ahk
#Include MineMaintainerCaves.ahk

Global MinerEnableVeins := true
Global MinerEnableVeinRemoval := true
Global MinerEnableTransmute := true
Global MinerEnableTransmuteSdia := false
Global MinerEnableTransmuteFuel := false
Global MinerEnableTransmuteSphere := false
Global MinerEnableTransmuteSdiaToCDia := false
Global MinerEnableFreeRefuel := true
Global MinerEnableBanks := true
Global MinerEnableSpammer := true
Global MinerEnableVeinUpgrade := false
Global MinerEnableCaves := true
Global MinerEnableLeafton := true

Global MinerEnableSphereUse := false
Global MinerSphereDelay := 1000
Global MinerSphereCount := 0
Global MinerSphereTimer := 1
Global MinerSphereModifier := 1
Global MinerCaveTimer := 5

Global MinerTransmuteTimer := 10
Global MinerRefuelTimer := 1
Global NavigateTime := 150

Global BankEnableLGDeposit := true
Global BankEnableSNDeposit := true
Global BankEnableEBDeposit := true
Global BankEnableFFDeposit := true
Global BankEnableSRDeposit := true
Global BankEnableQADeposit := true
Global BankDepositTime := 5

Global MinerColourCodeCommon := "0xA0A0A0"
Global MinerColourCodeUncommon := "0x326DAB"
Global MinerColourCodeRare := "0xD3C33F"
Global MinerColourCodeEpic := "0xB3260A"
Global MinerColourCodeMythical := "0x9E10C1"
Global MinerColourCodeLegendary := "0xE1661A"

Global MinerSphereGreedyUse := true

Global MinerEnableBrewing := true
Global MinerBrewCycleTime := 30
Global MinerBrewCutOffTime := 20

fMineMaintainer() {
    Global MinerRefuelTimer, MinerSphereTimer, BankDepositTime
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
    /** @type {cPoint} */
    VeinsTab := Points.Mine.Tab1Vein
    /** @type {cPoint} */
    MinesTab := Points.Mine.Tab2Mines
    /** @type {cPoint} */
    DrillTab := Points.Mine.Tab4Drill
    /** @type {cPoint} */
    ShopTab := Points.Mine.Tab5Shop
    /** @type {cPoint} */
    TransmuteTab := Points.Mine.Tab6Transmute
    /** @type {cPoint} */
    VeinUpgradeButton := Points.Mine.Vein.Upgrade
    /** @type {cPoint} */
    CancelConfirm := Points.Mine.Vein.CancelConfirm
    /** @type {Timer} */
    BrewCycleTimer := Timer()
    /** @type {Timer} */
    BrewCutOffTimer := Timer()

    ToolTip("Mine Maintainer Active", W / 2, WinRelPosLargeH(200), 4)
    ; Log mine settings for remote debugging
    MineLogSettings()
    If (MinerEnableLeafton) {
        LeaftonTaxiSinglePassStart()
        Sleep(NavigateTime)
    } Else If (MinerEnableSpammer) {
        NormalBossSpammerStart()
    }
    Travel.Mine.GoTo()
    Loop {
        ;@region Loop
        If (IsWindowActive() && MinerEnableLeafton) {
            LeaftonTaxiSinglePass()
        }
        If (IsWindowActive() && !IsPanelActive()) {
            Travel.Mine.GoTo()
        }
        ;@region Veins
        If (IsWindowActive() && IsPanelActive() && (MinerEnableVeins ||
            MinerEnableVeinRemoval)) {
            i := 1
            DebugLog("Opening veins tab")
            While (!Travel.Mine.IsOnTabVein() && i <= 4) {
                If (VeinsTab.IsButton()) {
                    VeinsTab.Click(NavigateTime)
                    Sleep(NavigateTime)
                }
                i++
            }
            If (Travel.Mine.IsOnTabVein()) {
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
                Log("Mine: Vein tab click failed")
            }
        }
        ;@endregion

        ;@region Vein upgrade
        If (IsWindowActive() && IsPanelActive() && Travel.Mine.IsOnTabVein() &&
            VeinUpgradeButton.IsButtonActive() && MinerEnableVeinUpgrade) {
            Log("Upgrading vein")
            VeinUpgradeButton.ClickOffset(NavigateTime)
        }
        ;@endregion

        ;@region Transmute
        If (IsWindowActive() && isAnyTransmuteEnabled() && IsPanelActive()) {
            If (Firstpass || DateDiff(A_Now, TransmuteTime, "Seconds") >=
                MinerTransmuteTimer) {
                TransmuteTime := A_Now
                i := 1
                DebugLog("Opening transmute tab")
                While (!Travel.Mine.IsOnTabTrans() && i <= 4) {
                    If (TransmuteTab.IsButton()) {
                        TransmuteTab.Click(NavigateTime)
                        Sleep(NavigateTime)
                    }
                    i++
                }
                If (Travel.Mine.IsOnTabTrans()) {
                    TransmuteAllCoalBars()
                    Log("Mine: Transmuted all bars.")
                    Sleep(NavigateTime)
                } Else {
                    Log("Mine: Transmute tab click failed")
                }
            }
        }
        ;@endregion

        ;@region Fuel
        If (MinerEnableFreeRefuel && IsWindowActive() && IsPanelActive()) {
            If (Firstpass || DateDiff(A_Now, RefuelTime, "Seconds") >=
                MinerRefuelTimer * 60) {
                RefuelTime := A_Now
                i := 1
                DebugLog("Opening drill tab")
                While (!Travel.Mine.IsOnTabDrill() && i <= 4) {
                    If (DrillTab.IsButton()) {
                        DrillTab.Click(NavigateTime)
                        Sleep(NavigateTime)
                    }
                    i++
                }
                If (Travel.Mine.IsOnTabDrill()) {
                    CollectFreeDrillFuel()
                    Log("Mine: Collected free fuel.")
                    Sleep(NavigateTime)
                } Else {
                    Log("Mine: Drill tab click failed")
                }
            }
        }
        ;@endregion

        ;@region Sphere
        If (IsWindowActive() && IsPanelActive() && MinerEnableSphereUse) {
            If (Firstpass || DateDiff(A_Now, SphereTime, "Seconds") >=
                MinerSphereTimer * 60) {
                SphereTime := A_Now
                i := 1
                DebugLog("Opening drill tab")
                While (!Travel.Mine.IsOnTabDrill() && i <= 4) {
                    If (DrillTab.IsButton()) {
                        DrillTab.Click(NavigateTime)
                        Sleep(NavigateTime)
                    }
                    i++
                }
                If (Travel.Mine.IsOnTabDrill()) {
                    Sleep(NavigateTime)
                    Log("Mine: Using spheres.")
                    UseDrillSphereLoop()
                    Sleep(NavigateTime)
                    ResetModifierKeys()
                } Else {
                    Log("Mine: Drill tab click failed")
                }
            }
        }
        ;@endregion

        ;@region Banks
        If (IsWindowActive() && IsPanelActive() && MinerEnableBanks) {
            If (Firstpass || DateDiff(A_Now, BankTime, "Seconds") >=
                BankDepositTime * 60) {
                ToolTip(, , , 4)
                Log("Mine: Bank Maintainer starting.")
                ToolTip("Mine Bank Maintainer Active", W / 2, WinRelPosLargeH(
                    200), 4)
                Sleep(NavigateTime)
                BankSinglePass()
                ToolTip(, , , 4)
                ToolTip("Mine Maintainer Active", W / 2, WinRelPosLargeH(200),
                    4)
                BankTime := A_Now
                ; Single pass does try to close, this is redundancy
                Travel.ClosePanelIfActive()
                Travel.Mine.GoTo()
            }
        }
        ;@endregion

        ;@region Caves
        If (IsWindowActive() && IsPanelActive() && MinerEnableCaves) {
            If (Firstpass || DateDiff(A_Now, CavesTime, "Seconds") >=
                MinerCaveTimer * 60) {
                i := 1
                While (!Travel.Mine.IsOnTabMines() && i <= 4 && IsPanelActive()
                ) {
                    MinesTab.Click(NavigateTime)
                    Sleep(NavigateTime)
                    i++
                }
                If (Travel.Mine.IsOnTabMines()) {
                    Log("Mine: Cave Maintainer starting.")
                    Sleep(NavigateTime)
                    CavesSinglePass()
                    CavesTime := A_Now
                    Sleep(NavigateTime)
                } Else {
                    Log("Mine: Cave tab click failed")
                }
            }
        }
        ;@endregion

        ;@region Brew
        If (IsWindowActive() && MinerEnableBrewing && !BrewCycleTimer.Running) {
            Log("Mine: Brewing")
            If (Travel.OpenAlchemyGeneral()) {
                BrewCutOffTimer.CoolDownS(MinerBrewCutOffTime, &
                    BrewCutOffRunning)
                While (BrewCutOffRunning) {
                    If (!SpamBrewButtons()) {
                        Break
                    }
                }
                BrewCycleTimer.CoolDownS(MinerBrewCycleTime, &BrewCycleRunning)
                Sleep(NavigateTime)
                Travel.ClosePanelIfActive()
            } Else {
                Log("Mine Brew: Travel to Alch general tab failed after 4" .
                    " attempts.")
            }
        }
        Firstpass := false
        ;@endregion
    }
    If (MinerEnableLeafton) {
        LeaftonTaxiSinglePassEnd()
    } Else If (MinerEnableSpammer) {
        KillSpammer()
    }
}

;@region Transmute Functions
isAnyTransmuteEnabled() {
    Return MinerEnableTransmute || MinerEnableTransmuteSdia ||
        MinerEnableTransmuteFuel || MinerEnableTransmuteSphere ||
        MinerEnableTransmuteSdiaToCDia
}

TransmuteAllCoalBars() {
    If (MinerEnableTransmute) {
        TransmuteButton := Points.Mine.Transmute.AllCBarsToCDias
        While (IsWindowActive() && IsPanelActive() && TransmuteButton.IsButtonActive() &&
            Travel.Mine.IsOnTabTrans()) {
            TransmuteButton.ClickOffset()
            DebugLog("Transmuted all coal bars to coal diamonds")
            Sleep(NavigateTime)
        }
    }
    If (MinerEnableTransmuteSdia) {
        SdiaTransmuteButton := Points.Mine.Transmute.AllCDiasToSDias
        While (IsWindowActive() && IsPanelActive() && SdiaTransmuteButton.IsButtonActive() &&
            Travel.Mine.IsOnTabTrans()) {
            SdiaTransmuteButton.ClickOffset()
            DebugLog("Transmuted all coal diamonds to shiny diamonds")
            Sleep(NavigateTime)
        }
    }
    If (MinerEnableTransmuteFuel) {
        FuelTransmuteButton := Points.Mine.Transmute.AllCDiasToFuel
        While (IsWindowActive() && IsPanelActive() && FuelTransmuteButton.IsButtonActive() &&
            Travel.Mine.IsOnTabTrans()) {
            FuelTransmuteButton.ClickOffset()
            DebugLog("Transmuted all coal diamonds to fuel")
            Sleep(NavigateTime)
        }
    }
    If (MinerEnableTransmuteSphere) {
        SphereTransmuteButton := Points.Mine.Transmute.AllCDiasToSpheres
        While (IsWindowActive() && IsPanelActive() && SphereTransmuteButton.IsButtonActive() &&
            Travel.Mine.IsOnTabTrans()) {
            SphereTransmuteButton.ClickOffset()
            DebugLog("Transmuted all coal diamonds to spheres")
            Sleep(NavigateTime)
        }
    }
    If (MinerEnableTransmuteSdiaToCDia) {
        SdiaToCBTransmuteButton := Points.Mine.Transmute.AllSDiasToCDia
        While (IsWindowActive() && IsPanelActive() && SdiaToCBTransmuteButton.IsButtonActive() &&
            Travel.Mine.IsOnTabTrans()) {
            SdiaToCBTransmuteButton.ClickOffset()
            DebugLog("Transmuted all shiny diamonds to coal diamonds")
            Sleep(NavigateTime)
        }
    }
}
;@endregion

;@region Drill Functions
CollectFreeDrillFuel() {
    FuelButton := Points.Mine.FreeFuel
    While (IsWindowActive() && IsPanelActive() && FuelButton.IsButtonActive()) {
        FuelButton.ClickOffset()
        Sleep(NavigateTime)
    }
}

UseDrillSphereLoop() {
    /**
     * @type {cPoint} SphereButton
     */
    SphereButton := Points.Mine.CoalSphere

    /**
     * @type {cPoint} tempCount
     */
    tempCount := MinerSphereCount

    If (MinerSphereCount > 0) {
        While (IsWindowActive() && IsPanelActive() && ;
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
            While (IsWindowActive() && IsPanelActive() && ;
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
}
;@endregion

;@region Vein functions
EnhanceVeins() {
    slot1 := Points.Mine.Vein.Slot1.Enhance
    slot2 := Points.Mine.Vein.Slot2.Enhance
    slot3 := Points.Mine.Vein.Slot3.Enhance
    slot4 := Points.Mine.Vein.Slot4.Enhance
    slot5 := Points.Mine.Vein.Slot5.Enhance
    slot6 := Points.Mine.Vein.Slot6.Enhance
    While (IsWindowActive() && IsPanelActive() && !slot1.IsBackground()) {
        If (slot1.IsButtonActive()) {
            slot1.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (IsWindowActive() && IsPanelActive() && !slot2.IsBackground()) {
        If (slot2.IsButtonActive()) {
            slot2.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (IsWindowActive() && IsPanelActive() && !slot3.IsBackground()) {
        If (slot3.IsButtonActive()) {
            slot3.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (IsWindowActive() && IsPanelActive() && !slot4.IsBackground()) {
        If (slot4.IsButtonActive()) {
            slot4.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (IsWindowActive() && IsPanelActive() && !slot5.IsBackground()) {
        If (slot5.IsButtonActive()) {
            slot5.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    While (IsWindowActive() && IsPanelActive() && !slot6.IsBackground()) {
        If (slot6.IsButtonActive()) {
            slot6.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
}

RemoveSingleVein() {
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
        Log("Found the following veins:")
        ArrDebug(PotentialVeins)
    } */
    LowestPrioritySlot := FindVeinsLowestPriority(PotentialVeins)
    If (LowestPrioritySlot = 0) {
        Return false
    }

    If (VeinTotalCount = 6 && PotentialVeins[1].Active = true &&
        LowestPrioritySlot = 1) {
        Log("Removing slot 1")
        Cancel1.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[2].Active = true &&
        LowestPrioritySlot = 2) {
        Log("Removing slot 2")
        Cancel2.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[3].Active = true &&
        LowestPrioritySlot = 3) {
        Log("Removing slot 3")
        Cancel3.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[4].Active = true &&
        LowestPrioritySlot = 4) {
        Log("Removing slot 4")
        Cancel4.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[5].Active = true &&
        LowestPrioritySlot = 5) {
        Log("Removing slot 5")
        Cancel5.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    If (VeinTotalCount = 6 && PotentialVeins[6].Active = true &&
        LowestPrioritySlot = 6) {
        Log("Removing slot 6")
        Cancel6.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        Return true
    }
    Return false

}

VeinCancelConfirm() {
    CancelConfirm := Points.Mine.Vein.CancelConfirm
    l := 0
    While (!CancelConfirm.IsBackground() && l < 10 && IsWindowActive()) {
        CancelConfirm.ClickOffset()
        Sleep(NavigateTime + 50)
        l++
    }
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
    ;Log("Findveinscount: " results)
    Return results
}

VeinQualityColourToText(value) {
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
    DebugLog("Slot " slotId " value " lowestValue " picked.")
    Return slotId
}
;@endregion

ArrDebug(arr) {
    i := 1
    While (i <= arr.Length) {
        Log(i " Active " arr[i].Active " Quality " arr[i].Quality " Priority " arr[
            i].Priority)
        i++
    }
}

MineLogSettings() {
    DebugLog("Dumping Mine settings to log:"
        "`nMinerEnableVeins: " MinerEnableVeins
        "`nMinerEnableTransmute: " MinerEnableTransmute
        "`nMinerEnableFreeRefuel: " MinerEnableFreeRefuel
        "`nMinerTransmuteTimer: " MinerTransmuteTimer
        "`nMinerRefuelTimer: " MinerRefuelTimer
        "`nMinerEnableSpammer: " MinerEnableSpammer
        "`nMinerEnableBanks: " MinerEnableBanks
        "`nMinerEnableVeinUpgrade: " MinerEnableVeinUpgrade
        "`nMinerEnableVeinRemoval: " MinerEnableVeinRemoval
        "`nMinerEnableCaves: " MinerEnableCaves
        "`nMinerCaveTimer: " MinerCaveTimer
        "`nMinerEnableLeafton: " MinerEnableLeafton
        "`nMinerEnableSphereUse: " MinerEnableSphereUse
        "`nMinerSphereDelay: " MinerSphereDelay
        "`nMinerSphereCount: " MinerSphereCount
        "`nMinerSphereTimer: " MinerSphereTimer
        "`nMinerSphereGreedyUse: " MinerSphereGreedyUse
        "`nMinerSphereModifier: " MinerSphereModifier
        "`nMinerEnableTransmuteSdia: " MinerEnableTransmuteSdia
        "`nMinerEnableTransmuteFuel: " MinerEnableTransmuteFuel
        "`nMinerEnableTransmuteSphere: " MinerEnableTransmuteSphere
        "`nMinerEnableTransmuteSdiaToCDia: " MinerEnableTransmuteSdiaToCDia
        "`nMinerEnableBrewing: " MinerEnableBrewing
        "`nMinerBrewCycleTime: " MinerBrewCycleTime
        "`nMinerBrewCutOffTime: " MinerBrewCutOffTime)
}