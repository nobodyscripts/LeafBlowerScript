#Requires AutoHotkey v2.0 

#Include <GameSettings>

global GameSaveLocation

/**
 * Holds save data and performs checks on save data to return progress 
 * information
 */
Class GameProgress {

    __New() {
        This.SaveData := GetGameSettings(GameSaveLocation)
    }

    ; Contains game save data in json obj format
    SaveData := {}

    LoadCurrent() {
        return {}
    }

    GetUnlockedLeaves() {
        return []
    }

    GetUnlockedFlasks() {

    }

    IsUnlockedLeaf(type) {
        LeafStates := this.GetUnlockedLeaves()
        for Leaf in LeafStates {

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