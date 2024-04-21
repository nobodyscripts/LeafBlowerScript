#Requires AutoHotkey v2.0

; ------------------- Settings -------------------
; Loads UserSettings.ini values for the rest of the script to use

global EnableLogging := false
global Debug := false
global DisableZoneChecks, DisableSettingsChecks

global BossFarmUsesWind := BossFarmUsesWobblyWings := BossFarmUsesSeeds := false
global ArtifactSleepAmount := WobblyWingsSleepAmount := 1

global CardsCommonAmount, CardsRareAmount, CardsLegendaryAmount,
    CardsDontOpenCommons, CardsDontOpenRare, CardsDontOpenLegendary,
    CardsSleepAmount, CardsBuyEnabled, CardsBuyStyle,
    CardsCommonBuyAmount, CardsRareBuyAmount, CardsLegBuyAmount,
    CardsDontBuyCommons, CardsDontBuyRare, CardsDontBuyLeg,
    CardsSleepBuyAmount, CardsPermaLoop,
    CardsBossFarmEnabled

global GFToKillPerCycle, SSToKillPerCycle, GFSSNoReset
global GemFarmSleepAmount
global ClawCheckSizeOffset
global BVItemsArr, HaveBorbDLC, BVBlockMythLeg
global NavigateTime

global HyacinthUseSlot, HyacinthFarmBoss, HyacinthUseFlower,
    HyacinthUseSpheres, HyacinthUseNextAvailableFlower,
    HyacinthBanksEnabled

global BankEnableLGDeposit, BankEnableSNDeposit, BankEnableEBDeposit,
    BankEnableFFDeposit, BankEnableSRDeposit, BankEnableQADeposit,
    BankRunsSpammer, BankDepositTime, BankEnableStorageUpgrade

global LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled,
    LeaftonRunOnceEnabled

global TowerPassiveBanksEnabled, TowerPassiveCraftEnabled

global MinerEnableVeins, MinerEnableTransmute,
    MinerEnableFreeRefuel, MinerTransmuteTimer,
    MinerRefuelTimer, MinerEnableSpammer, MinerEnableBanks,
    MinerEnableVeinUpgrade, MinerEnableVeinRemoval,
    MinerEnableCaves, MinerCaveTimer
global MinerEnableSphereUse, MinerSphereDelay, MinerSphereAmount,
    MinerSphereTimer, MinerSphereGreedyUse

class singleSetting {
    Name := ""
    DefaultValue := 0
    NobodyDefaultValue := 0
    DataType := "bool"
    Category := "Default"
    globalvar := 0

    Create(iName, iDefaultValue := 0, iNobodyDefaultValue := 0,
        iDataType := "bool", iCategory := "Default") {
            this.Name := iName
            this.DefaultValue := iDefaultValue
            this.NobodyDefaultValue := iNobodyDefaultValue
            this.DataType := iDataType
            this.Category := iCategory
            return this
    }

    ValueToString() {
        switch (StrLower(this.DataType)) {
            case "bool":
                return BinaryToStr(%this.Name%)
            case "arrBorbv":
                return ArrToCommaDelimStr(%this.Name%)
            default:
                return %this.Name%
        }
    }

    SetCommaDelimStrToArr(var) {
        %this.Name% := StrSplit(var, " ", ",.")
    }
}

class cSettings {

    sFilename := A_ScriptDir "\UserSettings.ini"
    sFileSection := "Default"
    sUseNobody := false

    initSettings(secondary := false) {
        global Debug
        this.Map := Map()

        this.Map["EnableLogging"] := singleSetting().Create("EnableLogging", false, true, "bool", "Default")
        this.Map["DisableZoneChecks"] := singleSetting().Create("DisableZoneChecks", false, true, "bool", "Default")
        this.Map["DisableSettingsChecks"] := singleSetting().Create("DisableSettingsChecks", false, true, "bool", "Default")
        this.Map["Debug"] := singleSetting().Create("Debug", false, true, "bool", "Debug")
        this.Map["NavigateTime"] := singleSetting().Create("NavigateTime", 101, 101, "int", "Default")
        this.Map["HaveBorbDLC"] := singleSetting().Create("HaveBorbDLC", false, false, "bool", "Borbventures")
        this.Map["BVBlockMythLeg"] := singleSetting().Create("BVBlockMythLeg", true, true, "bool", "Borbventures")
        this.Map["BVItemsArr"] := singleSetting().Create("BVItemsArr", "0x018C9C, 0x01D814, 0x0F2A1D, 0x6CD820, 0xC9C9C9",
            "0x01D814, 0xC9C9C9, 0xF91FF6", "arrBorbv", "Borbventures")
        this.Map["CardsCommonAmount"] := singleSetting().Create("CardsCommonAmount", 25000, 25000, "int", "Cards")
        this.Map["CardsRareAmount"] := singleSetting().Create("CardsRareAmount", 25000, 25000, "int", "Cards")
        this.Map["CardsLegendaryAmount"] := singleSetting().Create("CardsLegendaryAmount", 25000, 25000, "int", "Cards")
        this.Map["CardsDontOpenCommons"] := singleSetting().Create("CardsDontOpenCommons", false, false, "bool", "Cards")
        this.Map["CardsDontOpenRare"] := singleSetting().Create("CardsDontOpenRare", false, false, "bool", "Cards")
        this.Map["CardsDontOpenLegendary"] := singleSetting().Create("CardsDontOpenLegendary", false, false, "bool", "Cards")
        this.Map["CardsSleepAmount"] := singleSetting().Create("CardsSleepAmount", 875, 875, "int", "Cards")
        this.Map["CardsPermaLoop"] := singleSetting().Create("CardsPermaLoop", true, true, "bool", "Cards")
        this.Map["CardsBossFarmEnabled"] := singleSetting().Create("CardsBossFarmEnabled", true, true, "bool", "Cards")
        this.Map["CardsBuyEnabled"] := singleSetting().Create("CardsBuyEnabled", true, true, "bool", "CardsBuy")
        this.Map["CardsBuyStyle"] := singleSetting().Create("CardsBuyStyle", "FocusLegend", "FocusLegend", "text", "CardsBuy")
        this.Map["CardsCommonBuyAmount"] := singleSetting().Create("CardsCommonBuyAmount", 25000, 25000, "int", "CardsBuy")
        this.Map["CardsRareBuyAmount"] := singleSetting().Create("CardsRareBuyAmount", 25000, 25000, "int", "CardsBuy")
        this.Map["CardsLegBuyAmount"] := singleSetting().Create("CardsLegBuyAmount", 25000, 25000, "int", "CardsBuy")
        this.Map["CardsDontBuyCommons"] := singleSetting().Create("CardsDontBuyCommons", false, false, "bool", "CardsBuy")
        this.Map["CardsDontBuyRare"] := singleSetting().Create("CardsDontBuyRare", false, false, "bool", "CardsBuy")
        this.Map["CardsDontBuyLeg"] := singleSetting().Create("CardsDontBuyLeg", false, false, "bool", "CardsBuy")
        this.Map["CardsSleepBuyAmount"] := singleSetting().Create("CardsSleepBuyAmount", 17, 17, "int", "CardsBuy")
        this.Map["GFToKillPerCycle"] := singleSetting().Create("GFToKillPerCycle", 8, 1, "int", "SSFarm")
        this.Map["SSToKillPerCycle"] := singleSetting().Create("SSToKillPerCycle", 1, 1, "int", "SSFarm")
        this.Map["GFSSNoReset"] := singleSetting().Create("GFSSNoReset", false, false, "bool", "CardsBuy")
        this.Map["GemFarmSleepAmount"] := singleSetting().Create("GemFarmSleepAmount", 17, 17, "int", "GemFarm")
        this.Map["ClawCheckSizeOffset"] := singleSetting().Create("ClawCheckSizeOffset", 0, 0, "int", "GemFarm")
        this.Map["ArtifactSleepAmount"] := singleSetting().Create("ArtifactSleepAmount", 17, 17, "int", "BossFarm")
        this.Map["BossFarmUsesWind"] := singleSetting().Create("BossFarmUsesWind", true, true, "bool", "BossFarm")
        this.Map["BossFarmUsesWobblyWings"] := singleSetting().Create("BossFarmUsesWobblyWings", true, true, "bool", "BossFarm")
        this.Map["BossFarmUsesSeeds"] := singleSetting().Create("BossFarmUsesSeeds", true, true, "bool", "BossFarm")
        this.Map["WobblyWingsSleepAmount"] := singleSetting().Create("WobblyWingsSleepAmount", 17, 17, "int", "BossFarm")
        this.Map["HyacinthUseSlot"] := singleSetting().Create("HyacinthUseSlot", "All", "All", "text", "NatureFarm")
        this.Map["HyacinthFarmBoss"] := singleSetting().Create("HyacinthFarmBoss", true, true, "bool", "NatureFarm")
        this.Map["HyacinthUseFlower"] := singleSetting().Create("HyacinthUseFlower", "hyacinth", "hyacinth", "text", "NatureFarm")
        this.Map["HyacinthUseSpheres"] := singleSetting().Create("HyacinthUseSpheres", false, false, "bool", "NatureFarm")
        this.Map["HyacinthUseNextAvailableFlower"] := singleSetting().Create("HyacinthUseNextAvailableFlower", false, false, "bool", "NatureFarm")
        this.Map["HyacinthBanksEnabled"] := singleSetting().Create("HyacinthBanksEnabled", true, true, "bool", "NatureFarm")
        this.Map["BankEnableLGDeposit"] := singleSetting().Create("BankEnableLGDeposit", true, true, "bool", "Bank")
        this.Map["BankEnableSNDeposit"] := singleSetting().Create("BankEnableSNDeposit", true, true, "bool", "Bank")
        this.Map["BankEnableEBDeposit"] := singleSetting().Create("BankEnableEBDeposit", true, true, "bool", "Bank")
        this.Map["BankEnableFFDeposit"] := singleSetting().Create("BankEnableFFDeposit", true, true, "bool", "Bank")
        this.Map["BankEnableSRDeposit"] := singleSetting().Create("BankEnableSRDeposit", true, true, "bool", "Bank")
        this.Map["BankEnableQADeposit"] := singleSetting().Create("BankEnableQADeposit", true, true, "bool", "Bank")
        this.Map["BankEnableStorageUpgrade"] := singleSetting().Create("BankEnableStorageUpgrade", false, false, "bool", "Bank")
        this.Map["BankRunsSpammer"] := singleSetting().Create("BankRunsSpammer", true, true, "bool", "Bank")
        this.Map["BankDepositTime"] := singleSetting().Create("BankDepositTime", 5, 5, "int", "Bank")
        this.Map["LeaftonCraftEnabled"] := singleSetting().Create("LeaftonCraftEnabled", true, true, "bool", "Leafton")
        this.Map["LeaftonSpamsWind"] := singleSetting().Create("LeaftonSpamsWind", true, true, "bool", "Leafton")
        this.Map["LeaftonBanksEnabled"] := singleSetting().Create("LeaftonBanksEnabled", true, true, "bool", "Leafton")
        this.Map["LeaftonRunOnceEnabled"] := singleSetting().Create("LeaftonRunOnceEnabled", false, false, "bool", "Leafton")
        this.Map["TowerPassiveBanksEnabled"] := singleSetting().Create("TowerPassiveBanksEnabled", true, true, "bool", "TowerPassive")
        this.Map["TowerPassiveCraftEnabled"] := singleSetting().Create("TowerPassiveCraftEnabled", true, true, "bool", "TowerPassive")
        this.Map["MinerEnableVeins"] := singleSetting().Create("MinerEnableVeins", true, true, "bool", "Miner")
        this.Map["MinerEnableTransmute"] := singleSetting().Create("MinerEnableTransmute", true, true, "bool", "Miner")
        this.Map["MinerEnableFreeRefuel"] := singleSetting().Create("MinerEnableFreeRefuel", true, true, "bool", "Miner")
        this.Map["MinerEnableBanks"] := singleSetting().Create("MinerEnableBanks", true, true, "bool", "Miner")
        this.Map["MinerEnableSpammer"] := singleSetting().Create("MinerEnableSpammer", true, true, "bool", "Miner")
        this.Map["MinerEnableVeinUpgrade"] := singleSetting().Create("MinerEnableVeinUpgrade", false, false, "bool", "Miner")
        this.Map["MinerEnableVeinRemoval"] := singleSetting().Create("MinerEnableVeinRemoval", false, false, "bool", "Miner")
        this.Map["MinerEnableSphereUse"] := singleSetting().Create("MinerEnableSphereUse", false, false, "bool", "Miner")
        this.Map["MinerEnableCaves"] := singleSetting().Create("MinerEnableCaves", true, true, "bool", "Miner")
        this.Map["MinerSphereGreedyUse"] := singleSetting().Create("MinerSphereGreedyUse", true, true, "bool", "Miner")
        this.Map["MinerSphereDelay"] := singleSetting().Create("MinerSphereDelay", 1000, 1000, "int", "Miner")
        this.Map["MinerSphereAmount"] := singleSetting().Create("MinerSphereAmount", 0, 0, "int", "Miner")
        this.Map["MinerSphereTimer"] := singleSetting().Create("MinerSphereTimer", 1, 1, "int", "Miner")
        this.Map["MinerTransmuteTimer"] := singleSetting().Create("MinerTransmuteTimer", 10, 10, "int", "Miner")
        this.Map["MinerRefuelTimer"] := singleSetting().Create("MinerRefuelTimer", 1, 1, "int", "Miner")
        this.Map["MinerCaveTimer"] := singleSetting().Create("MinerCaveTimer", 5, 5, "int", "Miner")

        if (!secondary) {
            if (FileExist(A_ScriptDir "\IsNobody")) {
                this.sUseNobody := true
                Debug := true
                OutputDebug("Settings: Using Nobody Defaults.`r`n")
                Log("Settings: Using Nobody Defaults")
            }
            if (!FileExist(this.sFilename)) {
                OutputDebug("No UserSettings.ini found, writing default file.`r`n")
                Log("No UserSettings.ini found, writing default file.")
                this.WriteDefaults(this.sUseNobody)
            }
            if (this.loadSettings()) {
                Log("Loaded settings.")
            } else {
                return false
            }
            return true
        } else {
            this.sFilename := A_ScriptDir "\..\UserSettings.ini"
            if (this.loadSettings()) {
                Log("Loaded settings.")
            } else {
                return false
            }
            return true
        }
    }

    loadSettings() {
        global EnableLogging := false
        global Debug := false

        global CardsCommonAmount, CardsRareAmount, CardsLegendaryAmount,
            CardsDontOpenCommons, CardsDontOpenRare, CardsDontOpenLegendary,
            CardsSleepAmount, CardsBuyEnabled, CardsBuyStyle,
            CardsCommonBuyAmount, CardsRareBuyAmount, CardsLegBuyAmount,
            CardsDontBuyCommons, CardsDontBuyRare, CardsDontBuyLeg,
            CardsSleepBuyAmount, CardsPermaLoop,
            CardsBossFarmEnabled

        global GFToKillPerCycle, SSToKillPerCycle, GFSSNoReset
        global GemFarmSleepAmount
        global ClawCheckSizeOffset
        global BVItemsArr, HaveBorbDLC, BVBlockMythLeg
        global NavigateTime
        global DisableZoneChecks, DisableSettingsChecks
        global ArtifactSleepAmount
        global BossFarmUsesWind, BossFarmUsesWobblyWings, WobblyWingsSleepAmount,
            BossFarmUsesSeeds

        global HyacinthUseSlot, HyacinthFarmBoss, HyacinthUseFlower,
            HyacinthUseSpheres, HyacinthUseNextAvailableFlower,
            HyacinthBanksEnabled

        global BankEnableLGDeposit, BankEnableSNDeposit, BankEnableEBDeposit,
            BankEnableFFDeposit, BankEnableSRDeposit, BankEnableQADeposit,
            BankRunsSpammer, BankDepositTime, BankEnableStorageUpgrade

        global LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled,
            LeaftonRunOnceEnabled

        global TowerPassiveBanksEnabled, TowerPassiveCraftEnabled

        global MinerEnableVeins, MinerEnableTransmute,
            MinerEnableFreeRefuel, MinerTransmuteTimer,
            MinerRefuelTimer, MinerEnableSpammer, MinerEnableBanks,
            MinerEnableVeinUpgrade, MinerEnableVeinRemoval,
            MinerEnableCaves, MinerCaveTimer
        global MinerEnableSphereUse, MinerSphereDelay, MinerSphereAmount,
            MinerSphereTimer, MinerSphereGreedyUse
        for (setting in this.Map) {
            try {
                %this.Map[setting].Name% :=
                    IniToVar(this.sFilename, this.Map[setting].Category, this.Map[setting].Name)
            } catch as exc {
                if (exc.Extra) {
                    Log("Error 35: LoadSettings failed - " exc.Message "`n" exc.Extra)
                } else {
                    Log("Error 35: LoadSettings failed - " exc.Message)
                }
                MsgBox("Could not load all settings, making new default UserSettings.ini")
                Log("Attempting to write a new default UserSettings.ini.")
                this.WriteDefaults(this.sUseNobody)
                return false
            }
        }
        return true
    }

    /* saveSettings() {
        IniWrite("this is a new value", this.sFilename, this.sFileSection, "key")
    
    } */

    WriteToIni(key, value, section := this.sFileSection) {
        IniWrite(value, this.sFilename, section, key)
    }

    WriteDefaults(isnobody) {
        if (isnobody) {
            for (setting in this.Map) {
                this.WriteToIni(this.Map[setting].Name,
                    this.Map[setting].NobodyDefaultValue,
                    this.Map[setting].Category)
            }
        } else {
            for (setting in this.Map) {
                this.WriteToIni(this.Map[setting].Name,
                    this.Map[setting].DefaultValue,
                    this.Map[setting].Category)
            }
        }
    }

    SaveCurrentSettings() {
        for (setting in this.Map) {
            this.WriteToIni(this.Map[setting].Name,
                this.Map[setting].ValueToString(),
                this.Map[setting].Category)
        }
    }
}

IniToVar(file, section, name) {
    var := IniRead(file, section, name)
    switch var {
        case "true":
            return true
        case "false":
            return false
        default:
            return var
    }
}

BinaryToStr(var) {
    if (var) {
        return "true"
    }
    return "false"
}

ArrToCommaDelimStr(var) {
    output := ""
    if (var.Length > 1) {
        for text in var {
            if (output != "") {
                output := output ", " text
            } else {
                output := text
            }
        }
        return output
    } else {
        return false
    }
}

CommaDelimStrToArr(var) {
    return StrSplit(var, " ", ",.")
}