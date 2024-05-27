#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk
#Include ../Lib/Spammers.ahk
#Include MineMaintainerCaves.ahk
#Include ../Navigate/Mines/Travel.ahk

global MinerEnableVeins := true
global MinerEnableVeinRemoval := true
global MinerEnableTransmute := true
global MinerEnableTransmuteSdia := false
global MinerEnableTransmuteFuel := false
global MinerEnableTransmuteSphere := false
global MinerEnableTransmuteSdiaToCB := false
global MinerEnableFreeRefuel := true
global MinerEnableBanks := true
global MinerEnableSpammer := true
global MinerEnableVeinUpgrade := false
global MinerEnableCaves := true

global MinerEnableSphereUse := false
global MinerSphereDelay := 1000
global MinerSphereCount := 0
global MinerSphereTimer := 1
global MinerSphereModifier := 1
global MinerCaveTimer := 5

global MinerTransmuteTimer := 10
global MinerRefuelTimer := 1
global NavigateTime := 150

global BankEnableLGDeposit := true
global BankEnableSNDeposit := true
global BankEnableEBDeposit := true
global BankEnableFFDeposit := true
global BankEnableSRDeposit := true
global BankEnableQADeposit := true
global BankDepositTime := 5

global MinerColourCodeCommon := "0xA0A0A0"
global MinerColourCodeUncommon := "0x326DAB"
global MinerColourCodeRare := "0xD3C33F"
global MinerColourCodeEpic := "0xB3260A"
global MinerColourCodeMythical := "0x9E10C1"
global MinerColourCodeLegendary := "0xE1661A"

Global MinerSphereGreedyUse := true

fMineMaintainer() {
    global MinerRefuelTimer, MinerSphereTimer, BankDepositTime
    if (MinerRefuelTimer = 0) { ; If user set 0 in gui without adding a fraction, make at least 1 second
        MinerRefuelTimer := 0.017
    }
    if (MinerSphereTimer = 0) {
        MinerSphereTimer := 0.017
    }
    if (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    Firstpass := true
    MineTime := A_Now
    TransmuteTime := A_Now
    RefuelTime := A_Now
    BankTime := A_Now
    SphereTime := A_Now
    CavesTime := A_Now
    VeinsTab := cMineTabVein()
    MinesTab := cMineTabMines()
    DrillTab := cMineTabDrill()
    ShopTab := cMineTabShop()
    TransmuteTab := cMineTabTransmute()
    VeinUpgradeButton := cMineVeinUpgradeButton()
    CancelConfirm := cMineVeinCancelConfirmButton()
    CurrentTab := 0
    ToolTip("Mine Maintainer Active", W / 2,
        WinRelPosLargeH(200), 4)
    if (MinerEnableSpammer) {
        NormalBossSpammerStart()
    }
    if (IsPanelActive()) {
        ClosePanel()
        Sleep(NavigateTime)
    }
    OpenMining()
    Sleep(NavigateTime)
    loop {
        /* if (IsWindowActive()) {
            break
        } */
        if (IsWindowActive() && !IsPanelActive()) {
            OpenMining()
            Sleep(NavigateTime)
        }
        if (IsWindowActive() && MinerEnableVeins) {
            if (CurrentTab != 0 || !IsOnMineCoalVeinTab()) {
                VeinsTab.Click()
                Sleep(NavigateTime)
                VeinsTab.Click()
                Sleep(NavigateTime)
                CurrentTab := 0
            }
            if (IsOnMineCoalVeinTab()) {
                if (MinerEnableVeinRemoval) {
                    RemoveSingleVein()
                    Sleep(NavigateTime)
                    if (CancelConfirm.IsButtonActive()) {
                        VeinCancelConfirm()
                    }
                }
                EnhanceVeins()
            } else {
                Log("Mine: Vein tab click failed")
            }
        }
        if ((Firstpass && isAnyTransmuteEnabled()) ||
            (IsWindowActive() && isAnyTransmuteEnabled() &&
                DateDiff(A_Now, TransmuteTime, "Seconds") >= MinerTransmuteTimer)) {
            TransmuteTime := A_Now
            if (CurrentTab != 6 || !IsOnMineTransmuteTab()) {
                TransmuteTab.Click()
                Sleep(NavigateTime)
                TransmuteTab.Click()
                Sleep(NavigateTime)
                CurrentTab := 6
            }
            if (!IsOnMineTransmuteTab()) {
                Log("Mine: Transmute tab click failed")
            } else {
                TransmuteAllCoalBars()
                Log("Mine: Transmuted all bars.")
                Sleep(NavigateTime)
            }
        }

        if ((Firstpass && MinerEnableFreeRefuel) ||
            (IsWindowActive() && DateDiff(A_Now, RefuelTime, "Seconds") >= MinerRefuelTimer * 60 &&
                MinerEnableFreeRefuel)) {
            RefuelTime := A_Now
            if (CurrentTab != 4 || !IsOnMineDrillTab()) {
                DrillTab.Click()
                Sleep(NavigateTime)
                DrillTab.Click()
                Sleep(NavigateTime)
                CurrentTab := 4
            }
            if (IsOnMineDrillTab()) {
                CollectFreeDrillFuel()
                Log("Mine: Collected free fuel.")
                Sleep(NavigateTime)
            } else {
                Log("Mine: Drill tab click failed")
            }
        }

        if ((Firstpass && MinerEnableSphereUse) ||
            (IsWindowActive() && DateDiff(A_Now, SphereTime, "Seconds") >= MinerSphereTimer * 60 &&
                MinerEnableSphereUse)) {
            SphereTime := A_Now
            if (CurrentTab != 4 || !IsOnMineDrillTab()) {
                DrillTab.Click()
                Sleep(NavigateTime)
                DrillTab.Click()
                Sleep(NavigateTime)
                CurrentTab := 4
            }
            if (IsOnMineDrillTab()) {
                Sleep(NavigateTime)
                Log("Mine: Using spheres.")
                UseDrillSphereLoop()
                Sleep(NavigateTime)
                ResetModifierKeys()
            } else {
                Log("Mine: Drill tab click failed")
            }
        }
        if ((Firstpass && MinerEnableBanks) ||
            (IsWindowActive() && DateDiff(A_Now, BankTime, "Seconds") >= BankDepositTime * 60 &&
                MinerEnableBanks)) {
            ToolTip(, , , 4)
            Log("Mine: Bank Maintainer starting.")
            ToolTip("Mine Bank Maintainer Active", W / 2,
                WinRelPosLargeH(200), 4)
            Sleep(NavigateTime)
            BankSinglePass()
            ToolTip(, , , 4)
            ToolTip("Mine Maintainer Active", W / 2,
                WinRelPosLargeH(200), 4)
            BankTime := A_Now
            Sleep(NavigateTime)
            OpenMining()
            Sleep(NavigateTime)
        }

        if ((Firstpass && MinerEnableCaves) ||
            (IsWindowActive() && DateDiff(A_Now, CavesTime, "Seconds") >= MinerCaveTimer * 60 &&
                MinerEnableCaves)) {
            if (CurrentTab != 2) {
                MinesTab.Click()
                Sleep(NavigateTime)
                MinesTab.Click()
                Sleep(NavigateTime)
                CurrentTab := 2
            }
            if (IsOnMineCavesTab()) {
                Log("Mine: Cave Maintainer starting.")
                Sleep(NavigateTime)
                CavesSinglePass()
                CavesTime := A_Now
                Sleep(NavigateTime)
            } else {
                Log("Mine: Cave tab click failed")
            }
        }
        if (IsWindowActive() && IsOnMineCoalVeinTab() &&
            VeinUpgradeButton.IsButtonActive() && MinerEnableVeinUpgrade) {
            Log("Upgrading vein")
            VeinUpgradeButton.ClickOffset()
        }
        Firstpass := false
    }
    KillSpammer()
}

isAnyTransmuteEnabled() {
    return MinerEnableTransmute || MinerEnableTransmuteSdia ||
        MinerEnableTransmuteFuel || MinerEnableTransmuteSphere ||
        MinerEnableTransmuteSdiaToCB
}

EnhanceVeins() {
    slot1 := cMineEnhanceSlot1()
    slot2 := cMineEnhanceSlot2()
    slot3 := cMineEnhanceSlot3()
    slot4 := cMineEnhanceSlot4()
    slot5 := cMineEnhanceSlot5()
    slot6 := cMineEnhanceSlot6()
    while (IsWindowActive() && IsPanelActive() && !slot1.IsBackground()) {
        if (slot1.IsButtonClickable()) {
            slot1.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    while (IsWindowActive() && IsPanelActive() && !slot2.IsBackground()) {
        if (slot2.IsButtonClickable()) {
            slot2.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    while (IsWindowActive() && IsPanelActive() && !slot3.IsBackground()) {
        if (slot3.IsButtonClickable()) {
            slot3.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    while (IsWindowActive() && IsPanelActive() && !slot4.IsBackground()) {
        if (slot4.IsButtonClickable()) {
            slot4.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    while (IsWindowActive() && IsPanelActive() && !slot5.IsBackground()) {
        if (slot5.IsButtonClickable()) {
            slot5.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
    while (IsWindowActive() && IsPanelActive() && !slot6.IsBackground()) {
        if (slot6.IsButtonClickable()) {
            slot6.ClickOffset(5, 5, 34)
            Sleep(NavigateTime)
        }
    }
}

TransmuteAllCoalBars() {
    if (MinerEnableTransmute) {
        TransmuteButton := cMineTransmuteButton()
        while (IsWindowActive() && IsPanelActive() &&
            TransmuteButton.IsButtonClickable() &&
            IsOnMineTransmuteTab()) {
            TransmuteButton.ClickOffset()
            Sleep(NavigateTime)
        }
    }
    if (MinerEnableTransmuteSdia) {
        SdiaTransmuteButton := cMineTransmuteMaxSdia()
        while (IsWindowActive() && IsPanelActive() &&
            SdiaTransmuteButton.IsButtonClickable() &&
            IsOnMineTransmuteTab()) {
            SdiaTransmuteButton.ClickOffset()
            Sleep(NavigateTime)
        }
    }
    if (MinerEnableTransmuteFuel) {
        FuelTransmuteButton := cMineTransmuteMaxFuel()
        while (IsWindowActive() && IsPanelActive() &&
            FuelTransmuteButton.IsButtonClickable() &&
            IsOnMineTransmuteTab()) {
            FuelTransmuteButton.ClickOffset()
            Sleep(NavigateTime)
        }
    }
    if (MinerEnableTransmuteSphere) {
        SphereTransmuteButton := cMineTransmuteMaxSphere()
        while (IsWindowActive() && IsPanelActive() &&
            SphereTransmuteButton.IsButtonClickable() &&
            IsOnMineTransmuteTab()) {
            SphereTransmuteButton.ClickOffset()
            Sleep(NavigateTime)
        }
    }
    if (MinerEnableTransmuteSdiaToCB) {
        SdiaToCBTransmuteButton := cMineTransmuteMaxSdiaToCB()
        while (IsWindowActive() && IsPanelActive() &&
            SdiaToCBTransmuteButton.IsButtonClickable() &&
            IsOnMineTransmuteTab()) {
            SdiaToCBTransmuteButton.ClickOffset()
            Sleep(NavigateTime)
        }
    }
}

CollectFreeDrillFuel() {
    FuelButton := cMineFreeFuelButton()
    while (IsWindowActive() && IsPanelActive() &&
        FuelButton.IsButtonClickable()) {
        FuelButton.ClickOffset()
        Sleep(NavigateTime)
    }
}

UseDrillSphereLoop() {
    SphereButton := cMineDrillSphereButton()
    tempCount := MinerSphereCount

    if (MinerSphereCount > 0) {
        while (IsWindowActive() && IsPanelActive() &&
            SphereButton.IsButtonActive() && tempCount > 0) {
            if (MinerSphereModifier > 1) {
                ; limited count, with modifier
                AmountToModifier(MinerSphereModifier)
                Sleep(34)
                SphereButton.ClickOffset()
                Sleep(MinerSphereDelay)
            } else {
                ; limited count
                SphereButton.ClickOffset()
                Sleep(MinerSphereDelay)
            }
            tempCount--
        }
    } else {
        if (!MinerSphereGreedyUse) {
            ; Inf use, no greedy
            while (IsWindowActive() && IsPanelActive() &&
                SphereButton.IsButtonActive()) {
                if (MinerSphereModifier > 1) {
                    AmountToModifier(MinerSphereModifier)
                    Sleep(34)
                    SphereButton.ClickOffset()
                    Sleep(MinerSphereDelay)
                } else {
                    SphereButton.ClickOffset()
                    Sleep(MinerSphereDelay)
                }
            }
        } else {
            ; Greedy
            SphereButton.GreedyModifierUsageClick(MinerSphereDelay)
            Sleep(MinerSphereDelay)
        }
    }
}

RemoveSingleVein() {
    Cancel1 := cMineVeinCancelSlot1()
    Cancel2 := cMineVeinCancelSlot2()
    Cancel3 := cMineVeinCancelSlot3()
    Cancel4 := cMineVeinCancelSlot4()
    Cancel5 := cMineVeinCancelSlot5()
    Cancel6 := cMineVeinCancelSlot6()

    VeinTotalCount := FindVeinsCount()
    if (VeinTotalCount < 6) {
        return
    }
    PotentialVeins := FindVeinsWithBars()
    /* if (Debug) {
        Log("Found the following veins:")
        ArrDebug(PotentialVeins)
    } */
    LowestPrioritySlot := FindVeinsLowestPriority(PotentialVeins)
    if (LowestPrioritySlot = 0) {
        return false
    }

    if (VeinTotalCount = 6 && PotentialVeins[1].Active = true && LowestPrioritySlot = 1) {
        Log("Removing slot 1")
        Cancel1.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[2].Active = true && LowestPrioritySlot = 2) {
        Log("Removing slot 2")
        Cancel2.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[3].Active = true && LowestPrioritySlot = 3) {
        Log("Removing slot 3")
        Cancel3.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[4].Active = true && LowestPrioritySlot = 4) {
        Log("Removing slot 4")
        Cancel4.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[5].Active = true && LowestPrioritySlot = 5) {
        Log("Removing slot 5")
        Cancel5.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[6].Active = true && LowestPrioritySlot = 6) {
        Log("Removing slot 6")
        Cancel6.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    return false

}

VeinCancelConfirm() {
    CancelConfirm := cMineVeinCancelConfirmButton()
    l := 0
    while (!CancelConfirm.IsBackground() && l < 10 && IsWindowActive()) {
        CancelConfirm.ClickOffset()
        Sleep(NavigateTime + 50)
        l++
    }
}

FindVeinsWithBars() {
    SampleSlot1 := cMineVeinIconSlot1()
    SampleSlot2 := cMineVeinIconSlot2()
    SampleSlot3 := cMineVeinIconSlot3()
    SampleSlot4 := cMineVeinIconSlot4()
    SampleSlot5 := cMineVeinIconSlot5()
    SampleSlot6 := cMineVeinIconSlot6()
    QualitySlot1 := cMineColourSlot1()
    QualitySlot2 := cMineColourSlot2()
    QualitySlot3 := cMineColourSlot3()
    QualitySlot4 := cMineColourSlot4()
    QualitySlot5 := cMineColourSlot5()
    QualitySlot6 := cMineColourSlot6()

    results := [{ Active: false, Quality: "ignored", Priority: 9999 },
        ;
        { Active: false, Quality: "ignored", Priority: 9999 },
            ;
            { Active: false, Quality: "ignored", Priority: 9999 },
            ;
            { Active: false, Quality: "ignored", Priority: 9999 },
            ;
            { Active: false, Quality: "ignored", Priority: 9999 },
            ;
            { Active: false, Quality: "ignored", Priority: 9999 }
    ]
    if (SampleSlot1.GetColour() = "0x6D758D") {
        qualityText1 := VeinQualityColourToText(QualitySlot1.GetColour())
        results[1] := {
            Active: true,
            Quality: qualityText1,
            Priority: VeinQualityToPriority(qualityText1) - 4
        }
    }
    if (SampleSlot2.GetColour() = "0x6D758D") {
        qualityText2 := VeinQualityColourToText(QualitySlot2.GetColour())
        results[2] := {
            Active: true,
            Quality: qualityText2,
            Priority: VeinQualityToPriority(qualityText2) - 2
        }
    }
    if (SampleSlot3.GetColour() = "0x6D758D") {
        qualityText3 := VeinQualityColourToText(QualitySlot3.GetColour())
        results[3] := {
            Active: true,
            Quality: qualityText3,
            Priority: VeinQualityToPriority(qualityText3) - 1
        }
    }
    if (SampleSlot4.GetColour() = "0x6D758D") {
        qualityText4 := VeinQualityColourToText(QualitySlot4.GetColour())
        results[4] := {
            Active: true,
            Quality: qualityText4,
            Priority: VeinQualityToPriority(qualityText4)
        }
    }
    if (SampleSlot5.GetColour() = "0x6D758D") {
        qualityText5 := VeinQualityColourToText(QualitySlot5.GetColour())
        results[5] := {
            Active: true,
            Quality: qualityText5,
            Priority: VeinQualityToPriority(qualityText5)
        }
    }
    if (SampleSlot6.GetColour() = "0x6D758D") {
        qualityText6 := VeinQualityColourToText(QualitySlot6.GetColour())
        results[6] := {
            Active: true,
            Quality: qualityText6,
            Priority: VeinQualityToPriority(qualityText6)
        }
    }
    return results
}

FindVeinsCount() {
    results := 0
    Cancel1 := cMineVeinCancelSlot1()
    Cancel2 := cMineVeinCancelSlot2()
    Cancel3 := cMineVeinCancelSlot3()
    Cancel4 := cMineVeinCancelSlot4()
    Cancel5 := cMineVeinCancelSlot5()
    Cancel6 := cMineVeinCancelSlot6()
    if (Cancel1.IsButtonActive()) {
        results++
    }
    if (Cancel2.IsButtonActive()) {
        results++
    }
    if (Cancel3.IsButtonActive()) {
        results++
    }
    if (Cancel4.IsButtonActive()) {
        results++
    }
    if (Cancel5.IsButtonActive()) {
        results++
    }
    if (Cancel6.IsButtonActive()) {
        results++
    }
    ;Log("Findveinscount: " results)
    return results
}

VeinQualityColourToText(value) {
    switch value {
        case MinerColourCodeCommon:
            return "common"
        case MinerColourCodeUncommon:
            return "uncommon"
        case MinerColourCodeRare:
            return "rare"
        case MinerColourCodeEpic:
            return "epic"
        case MinerColourCodeMythical:
            return "mythical"
        case MinerColourCodeLegendary:
            return "legendary"
        default:
            return "special"
    }
}

VeinQualityToPriority(value) {
    switch value {
        case "common":
            return 1
        case "uncommon":
            return 2
        case "rare":
            return 3
        case "epic":
            return 4
        case "mythical":
            return 5
        case "legendary":
            return 6
        default:
            return 9999
    }
}

FindVeinsLowestPriority(StatusArray) {
    slotId := 0
    lowestValue := 99999

    ; We need to check through the array in reverse order, so that if value
    ; matches, we remove the oldest
    k := StatusArray.Length
    while (k > 0) {
        if (StatusArray[k].Priority <= lowestValue && StatusArray[k].Active) {
            slotId := k
            lowestValue := StatusArray[k].Priority
        }
        k--
    }
    if (Debug) {
        Log("Slot " slotId " value " lowestValue " picked.")
    }
    return slotId
}

ArrDebug(arr) {
    i := 1
    while (i <= arr.Length) {
        Log(i " Active " arr[i].Active " Quality " arr[i].Quality " Priority " arr[i].Priority)
        i++
    }
}