#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk
#Include Spammers.ahk

global MinerEnableVeins := true
global MinerEnableMineRemoval := true
global MinerEnableTransmute := true
global MinerEnableFreeRefuel := true
global MinerVeinsRemoveCommon := false
global MinerVeinsRemoveUncommon := false
global MinerVeinsRemoveRare := false
global MinerVeinsRemoveEpic := false
global MinerVeinsRemoveMythical := false
global MinerVeinsRemoveLegendary := false

global MinerMineRemovalTimer := 1
global MinerTransmuteTimer := 1
global MinerRefuelTimer := 1
global NavigateTime := 150

fMineMaintainer() {
    MineTime := A_Now
    TransmuteTime := A_Now
    RefuelTime := A_Now
    VeinsTab := cMineTabVein()
    MinesTab := cMineTabMines()
    DrillTab := cMineTabDrill()
    ShopTab := cMineTabShop()
    TransmuteTab := cMineTabTransmute()
    CurrentTab := 0
    if (IsPanelActive()) {
        ClosePanel()
        Sleep(NavigateTime)
    }
    OpenMining()
    loop {
        if (MinerEnableVeins) {
            if (CurrentTab != 0) {
                VeinsTab.Click()
                CurrentTab := 0
            }
            Sleep(NavigateTime)
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
        if (DateDiff(A_Now, TransmuteTime, "Seconds") >= MinerTransmuteTimer * 60 &&
            MinerEnableTransmute) {
                TransmuteTime := A_Now
                if (CurrentTab != 6) {
                    TransmuteTab.Click()
                    CurrentTab := 6
                }
                Sleep(NavigateTime)
                TransmuteAllCoalBars()
                Log("Mine: Transmuted all bars.")
                Sleep(NavigateTime)
        }

        if (DateDiff(A_Now, RefuelTime, "Seconds") >= MinerRefuelTimer * 60 &&
            MinerEnableFreeRefuel) {
                RefuelTime := A_Now
                if (CurrentTab != 4) {
                    DrillTab.Click()
                    CurrentTab := 4
                }
                Sleep(NavigateTime)
                CollectFreeDrillFuel()
                Log("Mine: Collected free fuel.")
                Sleep(NavigateTime)
        }
    }
}

EnhanceVeins() {
    slot1 := cMineEnhanceSlot1()
    slot2 := cMineEnhanceSlot2()
    slot3 := cMineEnhanceSlot3()
    slot4 := cMineEnhanceSlot4()
    slot5 := cMineEnhanceSlot5()
    slot6 := cMineEnhanceSlot6()
    while (!slot1.IsBackground()) {
        slot1.ClickOffset()
        Sleep(NavigateTime)
    }
    while (!slot2.IsBackground()) {
        slot2.ClickOffset()
        Sleep(NavigateTime)
    }
    while (!slot3.IsBackground()) {
        slot3.ClickOffset()
        Sleep(NavigateTime)
    }
    while (!slot4.IsBackground()) {
        slot4.ClickOffset()
        Sleep(NavigateTime)
    }
    while (!slot5.IsBackground()) {
        slot5.ClickOffset()
        Sleep(NavigateTime)
    }
    while (!slot6.IsBackground()) {
        slot6.ClickOffset()
        Sleep(NavigateTime)
    }
}

RemoveSingleMine() {

}

TransmuteAllCoalBars() {
    TransmuteButton := cMineTransmuteButton()
    if (TransmuteButton.IsButtonActive()) {
        TransmuteButton.ClickOffset()
        Sleep(NavigateTime)
    }
}

CollectFreeDrillFuel() {
    FuelButton := cMineFreeFuelButton()
    if (FuelButton.IsButtonActive()) {
        FuelButton.ClickOffset()
        Sleep(NavigateTime)
    }
}