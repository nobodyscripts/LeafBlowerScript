#Requires AutoHotkey v2.0

#Include ..\GameSettings.ahk

/**
 * Holds save data and performs checks on save data to return progress 
 * information
 */
Class GameState {

    __New() {
        if(!IsSet(ActiveSavePath)) {
            ActiveSavePath := ""
        }
        this.SaveData := GetGameSettings(ActiveSavePath)
    }

    ; Contains game save data in json obj format
    SaveData := {}

    LoadCurrent() {
        Return {
            BasicLeaf: true
        }
    }

    GetCurrentGameMode() {
        Return "Basic"
    }

    GetUnlockedLeaves() {
        Return []
    }

    GetUnlockedFlasks() {

    }

    IsUnlockedLeaf(type) {
        LeafStates := this.GetUnlockedLeaves()
        For Leaf in LeafStates {

        }
    }

    IsUnlockedPrestige() {

    }

    IsUnlockedBLC() {

    }

    IsUnlockedMLC() {

    }

    IsUnlockedULC() {

    }

    IsUnlockedTokens() {

    }

    IsUnlockedGemLeaves() {

    }

    IsUnlockedEnergy() {

    }

    IsUnlockedAreas() {

    }

    IsUnlockedConverters() {

    }

    IsUnlockedPrinters() {

    }

    IsUnlockedFarming() {

    }

    IsUnlockedMulch() {

    }

    IsUnlockedTrading() {

    }

    IsUnlockedCrafting() {

    }

    IsUnlockedBrewing() {

    }

    IsUnlockedLeafscensions() {

    }

    IsUnlockedBorbventures() {

    }

    IsUnlockedMining() {

    }

    IsUnlockedMiningCaves() {

    }

    IsUnlockedMiningDrill() {

    }

    IsUnlockedSoul() {

    }

    IsUnlockedSoulForge() {

    }

    IsUnlockedBank() {

    }

    IsUnlockedDice() {

    }

    IsUnlockedQuark() {

    }

    IsUnlockedNatureEvent() {

    }

    IsUnlockedHalloweenEvent() {

    }
}