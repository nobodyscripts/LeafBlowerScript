#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk
#Include Spammers.ahk

global MinerEnableVeins := true
global MinerEnableMineRemoval := true
global MinerEnableTransmute := true
global MinerEnableFreeRefuel := true
global MinerEnableBanks := true
global MinerEnableSpammer := true
global MinerVeinsRemoveCommon := false
global MinerVeinsRemoveUncommon := false
global MinerVeinsRemoveRare := false
global MinerVeinsRemoveEpic := false
global MinerVeinsRemoveMythical := false
global MinerVeinsRemoveLegendary := false

global MinerMineRemovalTimer := 1
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

fMineMaintainer() {
    Firstpass := true
    MineTime := A_Now
    TransmuteTime := A_Now
    RefuelTime := A_Now
    BankTime := A_Now
    VeinsTab := cMineTabVein()
    MinesTab := cMineTabMines()
    DrillTab := cMineTabDrill()
    ShopTab := cMineTabShop()
    TransmuteTab := cMineTabTransmute()
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

        if (!IsPanelActive()) {
            OpenMining()
            Sleep(NavigateTime)
        }
        if (MinerEnableVeins) {
            if (CurrentTab != 0) {
                VeinsTab.Click()
                Sleep(NavigateTime)
                VeinsTab.Click()
                Sleep(NavigateTime)
                CurrentTab := 0
            }
            EnhanceVeins()
        }
        /*         if (DateDiff(A_Now, MineTime, "Seconds") >= MinerMineRemovalTimer * 60 &&
                    MinerEnableMineRemoval) {
                        MineTime := A_Now
                        if (CurrentTab != 1) {
                            MinesTab.Click()
                            CurrentTab := 1
                        }
                        Sleep(NavigateTime)
                        RemoveSingleMine()
                        Log("Mine: Removed a mine entry")
                        Sleep(NavigateTime)
                }
        */
        if (Firstpass || (DateDiff(A_Now, TransmuteTime, "Seconds") >= MinerTransmuteTimer * 60 &&
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

        if (Firstpass || (DateDiff(A_Now, RefuelTime, "Seconds") >= MinerRefuelTimer * 60 &&
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
        if (Firstpass || (DateDiff(A_Now, BankTime, "Seconds") >= BankDepositTime * 60 &&
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
    while (IsPanelActive() && !slot1.IsBackground()) {
        slot1.ClickOffset()
        Sleep(NavigateTime)
    }
    while (IsPanelActive() && !slot2.IsBackground()) {
        slot2.ClickOffset()
        Sleep(NavigateTime)
    }
    while (IsPanelActive() && !slot3.IsBackground()) {
        slot3.ClickOffset()
        Sleep(NavigateTime)
    }
    while (IsPanelActive() && !slot4.IsBackground()) {
        slot4.ClickOffset()
        Sleep(NavigateTime)
    }
    while (IsPanelActive() && !slot5.IsBackground()) {
        slot5.ClickOffset()
        Sleep(NavigateTime)
    }
    while (IsPanelActive() && !slot6.IsBackground()) {
        slot6.ClickOffset()
        Sleep(NavigateTime)
    }
}

RemoveSingleMine() {

}

TransmuteAllCoalBars() {
    TransmuteButton := cMineTransmuteButton()
    if (IsPanelActive() && TransmuteButton.IsButtonActive()) {
        TransmuteButton.ClickOffset()
        Sleep(NavigateTime)
    }
}

CollectFreeDrillFuel() {
    FuelButton := cMineFreeFuelButton()
    if (IsPanelActive() && FuelButton.IsButtonActive()) {
        FuelButton.ClickOffset()
        Sleep(NavigateTime)
    }
}