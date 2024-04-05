#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk
#Include Spammers.ahk

global MinerEnableVeins := true
global MinerEnableVeinRemoval := true
global MinerEnableTransmute := true
global MinerEnableFreeRefuel := true
global MinerEnableBanks := true
global MinerEnableSpammer := true
global MinerEnableVeinUpgrade := false

global MinerEnableSphereUse := false
global MinerSphereDelay := 1000
global MinerSphereAmount := 0
global MinerSphereTimer := 1

global MinerTransmuteTimer := 0.5
global MinerRefuelTimer := 1
global NavigateTime := 150

global BankEnableLGDeposit := true
global BankEnableSNDeposit := true
global BankEnableEBDeposit := true
global BankEnableFFDeposit := true
global BankEnableSRDeposit := true
global BankEnableQADeposit := true
global BankDepositTime := 5

global MinerColourCodeCommon := "0xA0A0A2"
global MinerColourCodeUncommon := "0x336AAA"
global MinerColourCodeRare := "0xD5C53E"
global MinerColourCodeEpic := "0xB3260B"
global MinerColourCodeMythical := "0x9E10C1"
global MinerColourCodeLegendary := "0xD96500"

fMineMaintainer() {
    Firstpass := true
    MineTime := A_Now
    TransmuteTime := A_Now
    RefuelTime := A_Now
    BankTime := A_Now
    SphereTime := A_Now
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
        SpamViolins()
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
            if (CurrentTab != 0) {
                VeinsTab.Click()
                Sleep(NavigateTime)
                VeinsTab.Click()
                Sleep(NavigateTime)
                CurrentTab := 0
            }
            if (MinerEnableVeinRemoval) {
                RemoveSingleVein()
            }
            EnhanceVeins()
        }
        if (IsWindowActive() && CancelConfirm.IsButtonActive()) {
            VeinCancelConfirm()
        }
        if ((Firstpass && MinerEnableTransmute) ||
            (IsWindowActive() && DateDiff(A_Now, TransmuteTime, "Seconds") >= MinerTransmuteTimer * 60 &&
                MinerEnableTransmute)) {
                    TransmuteTime := A_Now
                    if (CurrentTab != 6) {
                        TransmuteTab.Click()
                        Sleep(NavigateTime)
                        TransmuteTab.Click()
                        Sleep(NavigateTime)
                        CurrentTab := 6
                    }
                    TransmuteAllCoalBars()
                    Log("Mine: Transmuted all bars.")
                    Sleep(NavigateTime)
        }

        if ((Firstpass && MinerEnableFreeRefuel) ||
            (IsWindowActive() && DateDiff(A_Now, RefuelTime, "Seconds") >= MinerRefuelTimer * 60 &&
                MinerEnableFreeRefuel)) {
                    RefuelTime := A_Now
                    if (CurrentTab != 4) {
                        DrillTab.Click()
                        Sleep(NavigateTime)
                        DrillTab.Click()
                        Sleep(NavigateTime)
                        CurrentTab := 4
                    }
                    CollectFreeDrillFuel()
                    Log("Mine: Collected free fuel.")
                    Sleep(NavigateTime)
        }

        if ((Firstpass && MinerEnableSphereUse) ||
            (IsWindowActive() && DateDiff(A_Now, SphereTime, "Seconds") >= MinerSphereTimer * 60 &&
                MinerEnableSphereUse)) {
                    SphereTime := A_Now
                    if (CurrentTab != 4) {
                        DrillTab.Click()
                        Sleep(NavigateTime)
                        DrillTab.Click()
                        Sleep(NavigateTime)
                        CurrentTab := 4
                    }
                    Sleep(NavigateTime)
                    Log("Mine: Using spheres.")
                    UseDrillSphereLoop()
                    Sleep(NavigateTime)
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
        if (IsWindowActive() && CurrentTab = 0 &&
            VeinUpgradeButton.IsButtonActive() && MinerEnableVeinUpgrade) {
                VeinUpgradeButton.ClickOffset()
        }
        Firstpass := false
    }
    KillSpammer()
}

EnhanceVeins() {
    slot1 := cMineEnhanceSlot1()
    slot2 := cMineEnhanceSlot2()
    slot3 := cMineEnhanceSlot3()
    slot4 := cMineEnhanceSlot4()
    slot5 := cMineEnhanceSlot5()
    slot6 := cMineEnhanceSlot6()
    while (IsWindowActive() && IsPanelActive() && !slot1.IsBackground()) {
        slot1.ClickOffset(5, 5, 34)
        Sleep(NavigateTime)
    }
    while (IsWindowActive() && IsPanelActive() && !slot2.IsBackground()) {
        slot2.ClickOffset(5, 5, 34)
        Sleep(NavigateTime)
    }
    while (IsWindowActive() && IsPanelActive() && !slot3.IsBackground()) {
        slot3.ClickOffset(5, 5, 34)
        Sleep(NavigateTime)
    }
    while (IsWindowActive() && IsPanelActive() && !slot4.IsBackground()) {
        slot4.ClickOffset(5, 5, 34)
        Sleep(NavigateTime)
    }
    while (IsWindowActive() && IsPanelActive() && !slot5.IsBackground()) {
        slot5.ClickOffset(5, 5, 34)
        Sleep(NavigateTime)
    }
    while (IsWindowActive() && IsPanelActive() && !slot6.IsBackground()) {
        slot6.ClickOffset(5, 5, 34)
        Sleep(NavigateTime)
    }
}

TransmuteAllCoalBars() {
    TransmuteButton := cMineTransmuteButton()
    if (IsWindowActive() && IsPanelActive() && TransmuteButton.IsButtonActive()) {
        TransmuteButton.ClickOffset()
        Sleep(NavigateTime)
    }
}

CollectFreeDrillFuel() {
    FuelButton := cMineFreeFuelButton()
    if (IsWindowActive() && IsPanelActive() && FuelButton.IsButtonActive()) {
        FuelButton.ClickOffset()
        Sleep(NavigateTime)
    }
}

UseDrillSphereLoop() {
    SphereButton := cMineDrillSphereButton()
    tempAmount := MinerSphereAmount

    if (MinerSphereAmount > 0) {
        ;Log(SphereButton.IsButtonActive())
        ;Log(SphereButton.GetColour())
        ;SphereButton.ToolTipAtCoord()
        ;return
        while (IsWindowActive() && IsPanelActive() &&
            SphereButton.IsButtonActive() && tempAmount > 0) {

                SphereButton.ClickOffset()
                Sleep(MinerSphereDelay)
                tempAmount--

        }
    } else {
        while (IsWindowActive() && IsPanelActive() &&
            SphereButton.IsButtonActive()) {

                SphereButton.ClickOffset()
                Sleep(MinerSphereDelay)
                tempAmount--

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
    PotentialVeins := FindVeinsWithBars()

    if (VeinTotalCount = 6 && PotentialVeins[1].Active = true) {
        Log("Removing slot 1")
        Cancel1.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[2].Active = true) {
        Log("Removing slot 2")
        Cancel2.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[3].Active = true) {
        Log("Removing slot 3")
        Cancel3.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[4].Active = true) {
        Log("Removing slot 4")
        Cancel4.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[5].Active = true) {
        Log("Removing slot 5")
        Cancel5.ClickOffset()
        Sleep(NavigateTime)
        VeinCancelConfirm()
        VeinTotalCount := FindVeinsCount()
        return true
    }
    if (VeinTotalCount = 6 && PotentialVeins[6].Active = true) {
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

    results := [{ Active: false, Quality: "common" }, { Active: false, Quality: "common" }, { Active: false, Quality: "common" }, { Active: false, Quality: "common" }, { Active: false, Quality: "common" }, { Active: false, Quality: "common" }
    ]
    if (SampleSlot1.GetColour() = "0x6D758D") {
        qualityText := VeinQualityColourToText(QualitySlot1.GetColour())
        results[1] := { Active: true, Quality: qualityText }
    }
    if (SampleSlot2.GetColour() = "0x6D758D") {
        qualityText := VeinQualityColourToText(QualitySlot2.GetColour())
        results[2] := { Active: true, Quality: qualityText }
    }
    if (SampleSlot3.GetColour() = "0x6D758D") {
        qualityText := VeinQualityColourToText(QualitySlot3.GetColour())
        results[3] := { Active: true, Quality: qualityText }
    }
    if (SampleSlot4.GetColour() = "0x6D758D") {
        qualityText := VeinQualityColourToText(QualitySlot4.GetColour())
        results[4] := { Active: true, Quality: qualityText }
    }
    if (SampleSlot5.GetColour() = "0x6D758D") {
        qualityText := VeinQualityColourToText(QualitySlot5.GetColour())
        results[5] := { Active: true, Quality: qualityText }
    }
    if (SampleSlot6.GetColour() = "0x6D758D") {
        qualityText := VeinQualityColourToText(QualitySlot6.GetColour())
        results[6] := { Active: true, Quality: qualityText }
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
    Log("Findveinscount: " results)
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
            return "common"
    }
}