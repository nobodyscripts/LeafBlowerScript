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
global NavigateTime := 150

fMineMaintainer() {
    if (IsPanelActive()) {
        ClosePanel()
        Sleep(NavigateTime)
    }
    OpenMining()
    loop {
        if (MinerEnableVeins) {
            EnhanceVeins()
        }
        if (MinerEnableMineRemoval) {
            
        }
        if (MinerEnableTransmute) {
            
        }
        if (MinerEnableFreeRefuel) {
            
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

}

CollectFreeDrillFuel() {

}
