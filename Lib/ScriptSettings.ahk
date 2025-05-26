#Requires AutoHotkey v2.0

#Include Logging.ahk

; ------------------- Settings -------------------
; Loads UserSettings.ini values for the rest of the script to use

;@region Globals definition
Global EnableLogging := false
Global Debug := false
Global Verbose := false
Global DebugAll := false
Global DisableZoneChecks := DisableSettingsChecks := false
Global TimestampLogs := true
Global LogBuffer

Global BossFarmFast := BossFarmUsesWind := BossFarmUsesWobblyWings :=
    BossFarmUsesSeeds := false
Global ArtifactSleepAmount := WobblyWingsSleepAmount := 1

Global CheckForUpdatesEnable := true
Global CheckForUpdatesReleaseOnly := true
Global CheckForUpdatesLastCheck := 0

Global CardsCommonAmount, CardsRareAmount, CardsLegendaryAmount,
    CardsDontOpenCommons, CardsDontOpenRare, CardsDontOpenLegendary,
    CardsSleepAmount, CardsBuyEnabled, CardsBuyStyle, CardsCommonBuyAmount,
    CardsRareBuyAmount, CardsLegBuyAmount, CardsDontBuyCommons,
    CardsDontBuyRare, CardsDontBuyLeg, CardsSleepBuyAmount, CardsPermaLoop,
    CardsBossFarmEnabled, CardsGreedyOpen, CardsGreedyBuy

Global GFToKillPerCycle, SSToKillPerCycle, GFSSNoReset
Global GemFarmSleepAmount
Global ClawCheckSizeOffset, ClawFindAny
Global BVItemsArr, HaveBorbDLC, BVBlockMythLeg
/** @type {Array} */
Global BVInvArr := []
Global NavigateTime
Global GuiBGColour, GuiFontBold, GuiFontItalic, GuiFontStrike,
    GuiFontUnderline, GuiFontColour, GuiFontSize, GuiFontWeight,
    GuiFontName

Global HyacinthUseSlot, HyacinthFarmBoss, HyacinthUseFlower, HyacinthUseSpheres,
    HyacinthUseNextAvailableFlower, HyacinthBanksEnabled

Global BankEnableLGDeposit, BankEnableSNDeposit, BankEnableEBDeposit,
    BankEnableFFDeposit, BankEnableSRDeposit, BankEnableQADeposit,
    BankRunsSpammer, BankDepositTime, BankEnableStorageUpgrade

Global LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled,
    LeaftonRunOnceEnabled, LeaftonEnableBrewing, LeaftonBrewCycleTime,
    LeaftonBrewCutOffTime

Global TowerPassiveBanksEnabled, TowerPassiveCraftEnabled,
    TowerPassiveTravelEnabled

Global MinerEnableVeins, MinerEnableTransmute, MinerEnableFreeRefuel,
    MinerTransmuteTimer, MinerRefuelTimer, MinerEnableSpammer, MinerEnableBanks,
    MinerEnableVeinUpgrade, MinerEnableVeinRemoval, MinerEnableCaves,
    MinerCaveTimer, MinerEnableLeafton
Global MinerEnableSphereUse, MinerSphereDelay, MinerSphereCount,
    MinerSphereTimer, MinerSphereGreedyUse, MinerSphereModifier,
    MinerEnableTransmuteSdia, MinerEnableTransmuteFuel,
    MinerEnableTransmuteSphere, MinerEnableTransmuteSdiaToCDia
Global MinerEnableBrewing, MinerBrewCycleTime, MinerBrewCutOffTime

Global BrewEnableArtifacts, BrewEnableEquipment, BrewEnableMaterials,
    BrewEnableScrolls, BrewEnableCardParts

Global SCAdvanceReplace

Global FishCatchingDelay, FishCatchingSearch

Global FishEnableShopUpgrade, FishEnableUpgradeRods, FishEnableTourneyPass,
    FishEnableUpgradeTourneyRods, FishEnableTransmute, FishEnableJourneyCollect

Global FishTimerShopUpgrade, FishTimerUpgradeRods, FishTimerTourneyPass,
    FishTimerUpgradeTourneyRods, FishTimerTransmute, FishTimerJourneyCollect

Global FishTransmuteTtoFC, FishTransmuteFCtoCry, FishTransmuteCrytoA,
    FishTransmuteFCtoT, FishTransmuteCrytoFC, FishTransmuteAtoCry

Global FishNovice, FishIntermediate, FishExpert,
    FishLegend, FishNoviceAttack, FishIntermediateAttack,
    FishExpertAttack, FishLegendAttack

Global FishChlCatchingDelay, FishChlCatchingSearch, FishChlAmount

Global FishChlEnableShopUpgrade, FishChlEnableUpgradeRods,
    FishChlEnableTransmute, FishChlEnableJourneyCollect

Global FishChlTimerShopUpgrade, FishChlTimerUpgradeRods,
    FishChlTimerTransmute, FishChlTimerJourneyCollect

Global FishChlTransmuteTtoFC, FishChlTransmuteFCtoCry,
    FishChlTransmuteCrytoA, FishChlTransmuteFCtoT,
    FishChlTransmuteCrytoFC, FishChlTransmuteAtoCry

Global FishTourCatchingDelay, FishTourCatchingSearch

Global FishTourEnableShopUpgrade, FishTourEnableUpgradeRods,
    FishTourEnableFishingPass, FishTourEnableUpgradeTourneyRods,
    FishTourEnableTransmute, FishTourEnableJourneyCollect

Global FishTourTimerShopUpgrade, FishTourTimerUpgradeRods,
    FishTourTimerUpgradeTourneyRods, FishTourTimerTransmute,
    FishTourTimerJourneyCollect

Global FishTourTransmuteTtoFC, FishTourTransmuteFCtoCry, FishTourTransmuteCrytoA,
    FishTourTransmuteFCtoT, FishTourTransmuteCrytoFC, FishTourTransmuteAtoCry

Global FishTourNovice, FishTourIntermediate, FishTourExpert,
    FishTourLegend, FishTourNoviceAttack, FishTourIntermediateAttack,
    FishTourExpertAttack, FishTourLegendAttack

;@endregion

/**
 * Single instance of a script setting object
 * @property Name Name of the setting and global var name
 * @property DefaultValue Default value for non developers
 * @property DataType Internal custom datatype string {bool | int | array}
 * @property Category Ini file category heading
 * @method __new Constructor
 * @method ValueToString Converts value to file writable string
 * @method SetCommaDelimStrToArr Set global of this.Name to an array of value
 * split by comma
 */
Class singleSetting {
    ;@region Properties
    /**
     * Name of the setting and global var name
     * @type {String} 
     */
    Name := ""
    /**
     * Default value for non developers
     * @type {String | Integer | Any} 
     */
    DefaultValue := 0
    /**
     * Internal custom datatype string
     * @type {String} 
     */
    DataType := "bool"
    /**
     * Ini file category heading
     * @type {String} 
     */
    Category := "Default"
    ;@endregion

    ;@region __new()
    /**
     * Constructs class and provides object back, has defaults for all except 
     * iName
     * @constructor
     * @param iName Name of the setting and global var
     * @param {Integer} iDefaultValue Default value set in script
     * @param {String} [iDataType="bool"] Internal custom datatype
     * @param {String} [iCategory="Default"] Ini file section heading name
     * @returns {singleSetting} Returns (this)
     */
    __New(iName, iDefaultValue := 0, iDataType :=
        "bool", iCategory := "Default") {
        this.Name := iName
        this.DefaultValue := iDefaultValue
        this.DataType := iDataType
        this.Category := iCategory
        Return this
    }
    ;@endregion

    ;@region ValueToString()
    /**
     * Convert value to file writable string
     * @param {Any} value Defaults to getting value of the global variable
     * @returns {String | Integer | Any} 
     */
    ValueToString(value := %this.Name%) {
        Switch (StrLower(this.DataType)) {
        Case "bool":
            Return BinaryToStr(value)
        Case "array":
            Return ArrToCommaDelimStr(value)
        default:
            Return value
        }
    }
    ;@endregion

    ;@region SetCommaDelimStrToArr()
    /**
     * Set global of this.Name to an array of value split by comma
     * @param var Value comma seperated string to split into array
     */
    SetCommaDelimStrToArr(var) {
        %this.Name% := StrSplit(var, " ", ",.")
    }
    ;@endregion
}

/**
 * cSettings - Stores settings data
 * @property sFilename Full file path to ini file for settings
 * @property sFileSection Ini section heading for settings
 * @property Map Map to store singleSettings objects per global var name
 * @method initSettings Load Map with defaults, check if file, load if possible,
 * return loaded state
 * @method loadSettings Load script settings into global vars, runs UpdateSettings
 * first to add missing settings rather than reset to defaults if some settings
 * exist
 * @method UpdateSettings Adds missing settings using defaults if some settings 
 * don't exist
 * @method WriteDefaults Write default settings to ini file, does not wipe other
 * removed settings
 * @method SaveCurrentSettings Save current Map to ini file converting to format
 * safe for storage
 * @method WriteToIni Write (key, value) to ini file within (section) heading
 * @method IniToVar Reads ini value for (name) in (section) from (file) and 
 * returns as string or Boolean
 */
Class cSettings {
    ;@region Properties
    /**
     * Full file path to ini file for settings
     * @type {String} 
     */
    sFilename := A_ScriptDir "\UserSettings.ini"
    /**
     * Ini section heading for settings
     * @type {String}
     */
    sFileSection := "Default"
    /**
     * Map to store singleSettings objects per global var name
     * @type {Map<string, singleSetting>}
     */
    Map := Map()
    /** Contains the defaults held by global var name
     *  @type {Object} */
    defaultSettings := {}
    ;@endregion

    ;@region initSettings()
    /**
     * Load Map with defaults, check if file, load if possible, return loaded 
     * state
     * @param {Integer} secondary Is script the main script or a spammer (for 
     * paths)
     * @returns {Boolean} 
     */
    initSettings(secondary := false) {
        Global Debug

        ;@region Settings map initialization
        this.Map := Map()

        this.Map["EnableLogging"] := singleSetting("EnableLogging", false,
            "bool", "Default")
        this.Map["TimestampLogs"] := singleSetting("TimestampLogs", true,
            "bool", "Default")
        this.Map["DisableZoneChecks"] := singleSetting("DisableZoneChecks",
            false, "bool", "Default")
        this.Map["DisableSettingsChecks"] := singleSetting(
            "DisableSettingsChecks", false, "bool", "Default")
        this.Map["NavigateTime"] := singleSetting("NavigateTime", 101,
            "int", "Default")

        this.Map["GuiBGColour"] := singleSetting("GuiBGColour", "0c0018",
            "string", "GUI")
        this.Map["GuiFontColour"] := singleSetting("GuiFontColour", "cfcfcf",
            "string", "GUI")
        this.Map["GuiFontBold"] := singleSetting(
            "GuiFontBold", false, "bool", "GUI")
        this.Map["GuiFontItalic"] := singleSetting(
            "GuiFontItalic", false, "bool", "GUI")
        this.Map["GuiFontStrike"] := singleSetting(
            "GuiFontStrike", false, "bool", "GUI")
        this.Map["GuiFontUnderline"] := singleSetting(
            "GuiFontUnderline", false, "bool", "GUI")
        this.Map["GuiFontSize"] := singleSetting(
            "GuiFontSize", 9, "int", "GUI")
        this.Map["GuiFontWeight"] := singleSetting(
            "GuiFontWeight", 4, "int", "GUI")
        this.Map["GuiFontName"] := singleSetting(
            "GuiFontName", "", "string", "GUI")

        this.Map["CheckForUpdatesEnable"] := singleSetting(
            "CheckForUpdatesEnable", true, "bool", "Updates")
        this.Map["CheckForUpdatesReleaseOnly"] := singleSetting(
            "CheckForUpdatesReleaseOnly", true, "bool", "Updates")
        this.Map["CheckForUpdatesLastCheck"] := singleSetting(
            "CheckForUpdatesLastCheck", 0, "int", "Updates")

        this.Map["Debug"] := singleSetting("Debug", false, "bool",
            "Debug")
        this.Map["DebugAll"] := singleSetting("DebugAll", false, "bool",
            "Debug")
        this.Map["Verbose"] := singleSetting("Verbose", false, "bool",
            "Debug")
        this.Map["LogBuffer"] := singleSetting("LogBuffer", true, "bool",
            "Debug")

        this.Map["HaveBorbDLC"] := singleSetting("HaveBorbDLC", false,
            "bool", "Borbventures")
        this.Map["BVBlockMythLeg"] := singleSetting("BVBlockMythLeg",
            false, "bool", "Borbventures")
        this.Map["BVItemsArr"] := singleSetting("BVItemsArr",
            "0x018C9C, 0x01D814, 0x0F2A1D, 0x6CD820, 0xC9C9C9",
            "array", "Borbventures")
        this.Map["BVInvArr"] := singleSetting("BVInvArr",
            "", "array", "Borbventures")

        this.Map["CardsCommonAmount"] := singleSetting("CardsCommonAmount",
            25000, "int", "Cards")
        this.Map["CardsRareAmount"] := singleSetting("CardsRareAmount", 25000,
            "int", "Cards")
        this.Map["CardsLegendaryAmount"] := singleSetting(
            "CardsLegendaryAmount", 25000, "int", "Cards")
        this.Map["CardsGreedyOpen"] := singleSetting("CardsGreedyOpen",
            false, "bool", "Cards")
        this.Map["CardsGreedyBuy"] := singleSetting("CardsGreedyBuy",
            false, "bool", "Cards")
        this.Map["CardsDontOpenCommons"] := singleSetting(
            "CardsDontOpenCommons", false, "bool", "Cards")
        this.Map["CardsDontOpenRare"] := singleSetting("CardsDontOpenRare",
            false, "bool", "Cards")
        this.Map["CardsDontOpenLegendary"] := singleSetting(
            "CardsDontOpenLegendary", false, "bool", "Cards")
        this.Map["CardsSleepAmount"] := singleSetting("CardsSleepAmount",
            875, "int", "Cards")
        this.Map["CardsPermaLoop"] := singleSetting("CardsPermaLoop",
            true, "bool", "Cards")
        this.Map["CardsBossFarmEnabled"] := singleSetting(
            "CardsBossFarmEnabled", true, "bool", "Cards")

        this.Map["CardsBuyEnabled"] := singleSetting("CardsBuyEnabled",
            true, "bool", "CardsBuy")
        this.Map["CardsBuyStyle"] := singleSetting("CardsBuyStyle",
            "FocusLegend", "text", "CardsBuy")
        this.Map["CardsCommonBuyAmount"] := singleSetting(
            "CardsCommonBuyAmount", 25000, "int", "CardsBuy")
        this.Map["CardsRareBuyAmount"] := singleSetting("CardsRareBuyAmount",
            25000, "int", "CardsBuy")
        this.Map["CardsLegBuyAmount"] := singleSetting("CardsLegBuyAmount",
            25000, "int", "CardsBuy")
        this.Map["CardsDontBuyCommons"] := singleSetting("CardsDontBuyCommons",
            false, "bool", "CardsBuy")
        this.Map["CardsDontBuyRare"] := singleSetting("CardsDontBuyRare",
            false, "bool", "CardsBuy")
        this.Map["CardsDontBuyLeg"] := singleSetting("CardsDontBuyLeg",
            false, "bool", "CardsBuy")
        this.Map["CardsSleepBuyAmount"] := singleSetting("CardsSleepBuyAmount",
            17, "int", "CardsBuy")

        this.Map["GFToKillPerCycle"] := singleSetting("GFToKillPerCycle", 8,
            "int", "SSFarm")
        this.Map["SSToKillPerCycle"] := singleSetting("SSToKillPerCycle", 1,
            "int", "SSFarm")
        this.Map["GFSSNoReset"] := singleSetting("GFSSNoReset", false,
            "bool", "SSFarm")

        this.Map["GemFarmSleepAmount"] := singleSetting("GemFarmSleepAmount",
            17, "int", "GemFarm")

        this.Map["ClawCheckSizeOffset"] := singleSetting("ClawCheckSizeOffset",
            0, "int", "Claw")
        this.Map["ClawFindAny"] := singleSetting("ClawFindAny", false,
            "bool", "Claw")

        this.Map["ArtifactSleepAmount"] := singleSetting("ArtifactSleepAmount",
            17, "int", "BossFarm")
        this.Map["BossFarmUsesWind"] := singleSetting("BossFarmUsesWind",
            true, "bool", "BossFarm")
        this.Map["BossFarmUsesWobblyWings"] := singleSetting(
            "BossFarmUsesWobblyWings", true, "bool", "BossFarm")
        this.Map["BossFarmUsesSeeds"] := singleSetting("BossFarmUsesSeeds",
            true, "bool", "BossFarm")
        this.Map["BossFarmFast"] := singleSetting("BossFarmFast",
            false, "bool", "BossFarm")
        this.Map["WobblyWingsSleepAmount"] := singleSetting(
            "WobblyWingsSleepAmount", 17, "int", "BossFarm")

        this.Map["HyacinthUseSlot"] := singleSetting("HyacinthUseSlot",
            "All", "text", "NatureFarm")
        this.Map["HyacinthFarmBoss"] := singleSetting("HyacinthFarmBoss",
            true, "bool", "NatureFarm")
        this.Map["HyacinthUseFlower"] := singleSetting("HyacinthUseFlower",
            "hyacinth", "text", "NatureFarm")
        this.Map["HyacinthUseSpheres"] := singleSetting("HyacinthUseSpheres",
            false, "bool", "NatureFarm")
        this.Map["HyacinthUseNextAvailableFlower"] := singleSetting(
            "HyacinthUseNextAvailableFlower", false, "bool",
            "NatureFarm")
        this.Map["HyacinthBanksEnabled"] := singleSetting(
            "HyacinthBanksEnabled", true, "bool", "NatureFarm")

        this.Map["BankEnableLGDeposit"] := singleSetting("BankEnableLGDeposit",
            true, "bool", "Bank")
        this.Map["BankEnableSNDeposit"] := singleSetting("BankEnableSNDeposit",
            true, "bool", "Bank")
        this.Map["BankEnableEBDeposit"] := singleSetting("BankEnableEBDeposit",
            true, "bool", "Bank")
        this.Map["BankEnableFFDeposit"] := singleSetting("BankEnableFFDeposit",
            true, "bool", "Bank")
        this.Map["BankEnableSRDeposit"] := singleSetting("BankEnableSRDeposit",
            true, "bool", "Bank")
        this.Map["BankEnableQADeposit"] := singleSetting("BankEnableQADeposit",
            true, "bool", "Bank")
        this.Map["BankEnableStorageUpgrade"] := singleSetting(
            "BankEnableStorageUpgrade", false, "bool", "Bank")
        this.Map["BankRunsSpammer"] := singleSetting("BankRunsSpammer",
            true, "bool", "Bank")
        this.Map["BankDepositTime"] := singleSetting("BankDepositTime", 5,
            "int", "Bank")

        this.Map["LeaftonCraftEnabled"] := singleSetting("LeaftonCraftEnabled",
            true, "bool", "Leafton")
        this.Map["LeaftonSpamsWind"] := singleSetting("LeaftonSpamsWind",
            true, "bool", "Leafton")
        this.Map["LeaftonBanksEnabled"] := singleSetting("LeaftonBanksEnabled",
            true, "bool", "Leafton")
        this.Map["LeaftonRunOnceEnabled"] := singleSetting(
            "LeaftonRunOnceEnabled", false, "bool", "Leafton")
        this.Map["LeaftonEnableBrewing"] := singleSetting(
            "LeaftonEnableBrewing", false, "bool", "Leafton")
        this.Map["LeaftonBrewCycleTime"] := singleSetting(
            "LeaftonBrewCycleTime", 10, "int", "Leafton")
        this.Map["LeaftonBrewCutOffTime"] := singleSetting(
            "LeaftonBrewCutOffTime", 30, "int", "Leafton")

        this.Map["TowerPassiveBanksEnabled"] := singleSetting(
            "TowerPassiveBanksEnabled", true, "bool", "TowerPassive")
        this.Map["TowerPassiveCraftEnabled"] := singleSetting(
            "TowerPassiveCraftEnabled", true, "bool", "TowerPassive")
        this.Map["TowerPassiveTravelEnabled"] := singleSetting(
            "TowerPassiveTravelEnabled", true, "bool", "TowerPassive")

        this.Map["MinerEnableVeins"] := singleSetting("MinerEnableVeins",
            true, "bool", "Miner")
        this.Map["MinerEnableTransmute"] := singleSetting(
            "MinerEnableTransmute", true, "bool", "Miner")
        this.Map["MinerEnableTransmuteSdia"] := singleSetting(
            "MinerEnableTransmuteSdia", false, "bool", "Miner")
        this.Map["MinerEnableTransmuteFuel"] := singleSetting(
            "MinerEnableTransmuteFuel", false, "bool", "Miner")
        this.Map["MinerEnableTransmuteSphere"] := singleSetting(
            "MinerEnableTransmuteSphere", false, "bool", "Miner")
        this.Map["MinerEnableTransmuteSdiaToCDia"] := singleSetting(
            "MinerEnableTransmuteSdiaToCDia", false, "bool", "Miner")
        this.Map["MinerEnableFreeRefuel"] := singleSetting(
            "MinerEnableFreeRefuel", true, "bool", "Miner")
        this.Map["MinerEnableBanks"] := singleSetting("MinerEnableBanks",
            true, "bool", "Miner")
        this.Map["MinerEnableSpammer"] := singleSetting("MinerEnableSpammer",
            true, "bool", "Miner")
        this.Map["MinerEnableLeafton"] := singleSetting("MinerEnableLeafton",
            false, "bool", "Miner")
        this.Map["MinerEnableVeinUpgrade"] := singleSetting(
            "MinerEnableVeinUpgrade", false, "bool", "Miner")
        this.Map["MinerEnableVeinRemoval"] := singleSetting(
            "MinerEnableVeinRemoval", false, "bool", "Miner")
        this.Map["MinerEnableSphereUse"] := singleSetting(
            "MinerEnableSphereUse", false, "bool", "Miner")
        this.Map["MinerEnableCaves"] := singleSetting("MinerEnableCaves",
            true, "bool", "Miner")
        this.Map["MinerSphereGreedyUse"] := singleSetting(
            "MinerSphereGreedyUse", false, "bool", "Miner")
        this.Map["MinerSphereDelay"] := singleSetting("MinerSphereDelay",
            1000, "int", "Miner")
        this.Map["MinerSphereCount"] := singleSetting("MinerSphereCount", 0,
            "int", "Miner")
        this.Map["MinerSphereTimer"] := singleSetting("MinerSphereTimer", 1,
            "int", "Miner")
        this.Map["MinerSphereModifier"] := singleSetting("MinerSphereModifier",
            1, "int", "Miner")
        this.Map["MinerTransmuteTimer"] := singleSetting("MinerTransmuteTimer",
            10, "int", "Miner")
        this.Map["MinerRefuelTimer"] := singleSetting("MinerRefuelTimer", 1,
            "int", "Miner")
        this.Map["MinerCaveTimer"] := singleSetting("MinerCaveTimer", 5,
            "int", "Miner")
        this.Map["MinerEnableBrewing"] := singleSetting("MinerEnableBrewing",
            true, "bool", "Miner")
        this.Map["MinerBrewCycleTime"] := singleSetting("MinerBrewCycleTime",
            30, "int", "Miner")
        this.Map["MinerBrewCutOffTime"] := singleSetting("MinerBrewCutOffTime",
            30, "int", "Miner")

        this.Map["BrewEnableArtifacts"] := singleSetting("BrewEnableArtifacts",
            true, "bool", "Brew")
        this.Map["BrewEnableEquipment"] := singleSetting("BrewEnableEquipment",
            true, "bool", "Brew")
        this.Map["BrewEnableMaterials"] := singleSetting("BrewEnableMaterials",
            true, "bool", "Brew")
        this.Map["BrewEnableScrolls"] := singleSetting("BrewEnableScrolls",
            false, "bool", "Brew")
        this.Map["BrewEnableCardParts"] := singleSetting("BrewEnableCardParts",
            true, "bool", "Brew")

        this.Map["SCAdvanceReplace"] := singleSetting("SCAdvanceReplace",
            true, "bool", "ShadowCrystal")

        this.Map["FishCatchingDelay"] := singleSetting("FishCatchingDelay",
            8, "int", "Fishing")
        this.Map["FishCatchingSearch"] := singleSetting("FishCatchingSearch",
            true, "bool", "Fishing")
        this.Map["FishEnableShopUpgrade"] := singleSetting("FishEnableShopUpgrade",
            true, "bool", "Fishing")
        this.Map["FishEnableUpgradeRods"] := singleSetting("FishEnableUpgradeRods",
            true, "bool", "Fishing")
        this.Map["FishEnableTourneyPass"] := singleSetting("FishEnableTourneyPass",
            true, "bool", "Fishing")
        this.Map["FishEnableUpgradeTourneyRods"] := singleSetting("FishEnableUpgradeTourneyRods",
            true, "bool", "Fishing")
        this.Map["FishEnableTransmute"] := singleSetting("FishEnableTransmute",
            true, "bool", "Fishing")
        this.Map["FishEnableJourneyCollect"] := singleSetting("FishEnableJourneyCollect",
            true, "bool", "Fishing")
        this.Map["FishTimerShopUpgrade"] := singleSetting("FishTimerShopUpgrade",
            60, "int", "Fishing")
        this.Map["FishTimerUpgradeRods"] := singleSetting("FishTimerUpgradeRods",
            60, "int", "Fishing")
        this.Map["FishTimerTourneyPass"] := singleSetting("FishTimerTourneyPass",
            60, "int", "Fishing")
        this.Map["FishTimerUpgradeTourneyRods"] := singleSetting("FishTimerUpgradeTourneyRods",
            60, "int", "Fishing")
        this.Map["FishTimerTransmute"] := singleSetting("FishTimerTransmute",
            60, "int", "Fishing")
        this.Map["FishTimerJourneyCollect"] := singleSetting("FishTimerJourneyCollect",
            60, "int", "Fishing")
        this.Map["FishTransmuteTtoFC"] := singleSetting("FishTransmuteTtoFC",
            false, "bool", "Fishing")
        this.Map["FishTransmuteFCtoCry"] := singleSetting("FishTransmuteFCtoCry",
            false, "bool", "Fishing")
        this.Map["FishTransmuteCrytoA"] := singleSetting("FishTransmuteCrytoA",
            false, "bool", "Fishing")
        this.Map["FishTransmuteFCtoT"] := singleSetting("FishTransmuteFCtoT",
            false, "bool", "Fishing")
        this.Map["FishTransmuteCrytoFC"] := singleSetting("FishTransmuteCrytoFC",
            false, "bool", "Fishing")
        this.Map["FishTransmuteAtoCry"] := singleSetting("FishTransmuteAtoCry",
            false, "bool", "Fishing")
        this.Map["FishChlCatchingDelay"] := singleSetting("FishChlCatchingDelay",
            8, "int", "FishChallenge")
        this.Map["FishNovice"] := singleSetting("FishNovice",
            false, "bool", "Fishing")
        this.Map["FishIntermediate"] := singleSetting("FishIntermediate",
            false, "bool", "Fishing")
        this.Map["FishExpert"] := singleSetting("FishExpert",
            false, "bool", "Fishing")
        this.Map["FishLegend"] := singleSetting("FishLegend",
            false, "bool", "Fishing")
        this.Map["FishNoviceAttack"] := singleSetting("FishNoviceAttack", 1, "int", "Fishing")
        this.Map["FishIntermediateAttack"] := singleSetting("FishIntermediateAttack", 1, "int", "Fishing")
        this.Map["FishExpertAttack"] := singleSetting("FishExpertAttack", 1, "int", "Fishing")
        this.Map["FishLegendAttack"] := singleSetting("FishLegendAttack", 1, "int", "Fishing")

        this.Map["FishChlCatchingSearch"] := singleSetting("FishChlCatchingSearch",
            true, "bool", "FishChallenge")
        this.Map["FishChlEnableShopUpgrade"] := singleSetting("FishChlEnableShopUpgrade",
            true, "bool", "FishChallenge")
        this.Map["FishChlEnableUpgradeRods"] := singleSetting("FishChlEnableUpgradeRods",
            true, "bool", "FishChallenge")
        this.Map["FishChlEnableTransmute"] := singleSetting("FishChlEnableTransmute",
            true, "bool", "FishChallenge")
        this.Map["FishChlEnableJourneyCollect"] := singleSetting("FishChlEnableJourneyCollect",
            true, "bool", "FishChallenge")
        this.Map["FishChlTimerShopUpgrade"] := singleSetting("FishChlTimerShopUpgrade",
            60, "int", "FishChallenge")
        this.Map["FishChlTimerUpgradeRods"] := singleSetting("FishChlTimerUpgradeRods",
            60, "int", "FishChallenge")
        this.Map["FishChlTimerTransmute"] := singleSetting("FishChlTimerTransmute",
            60, "int", "FishChallenge")
        this.Map["FishChlTimerJourneyCollect"] := singleSetting("FishChlTimerJourneyCollect",
            60, "int", "FishChallenge")
        this.Map["FishChlTransmuteTtoFC"] := singleSetting("FishChlTransmuteTtoFC",
            true, "bool", "FishChallenge")
        this.Map["FishChlTransmuteFCtoCry"] := singleSetting("FishChlTransmuteFCtoCry",
            false, "bool", "FishChallenge")
        this.Map["FishChlTransmuteCrytoA"] := singleSetting("FishChlTransmuteCrytoA",
            false, "bool", "FishChallenge")
        this.Map["FishChlTransmuteFCtoT"] := singleSetting("FishChlTransmuteFCtoT",
            false, "bool", "FishChallenge")
        this.Map["FishChlTransmuteCrytoFC"] := singleSetting("FishChlTransmuteCrytoFC",
            true, "bool", "FishChallenge")
        this.Map["FishChlTransmuteAtoCry"] := singleSetting("FishChlTransmuteAtoCry",
            true, "bool", "FishChallenge")
        this.Map["FishChlAmount"] := singleSetting("FishChlAmount",
            5, "int", "FishChallenge")

        this.Map["FishTourCatchingDelay"] := singleSetting("FishTourCatchingDelay",
            8, "int", "FishTourney")
        this.Map["FishTourCatchingSearch"] := singleSetting("FishTourCatchingSearch",
            true, "bool", "FishTourney")
        this.Map["FishTourEnableShopUpgrade"] := singleSetting("FishTourEnableShopUpgrade",
            true, "bool", "FishTourney")
        this.Map["FishTourEnableUpgradeRods"] := singleSetting("FishTourEnableUpgradeRods",
            true, "bool", "FishTourney")
        this.Map["FishTourEnableFishingPass"] := singleSetting("FishTourEnableFishingPass",
            true, "bool", "FishTourney")
        this.Map["FishTourEnableUpgradeTourneyRods"] := singleSetting("FishTourEnableUpgradeTourneyRods",
            true, "bool", "FishTourney")
        this.Map["FishTourEnableTransmute"] := singleSetting("FishTourEnableTransmute",
            true, "bool", "FishTourney")
        this.Map["FishTourEnableJourneyCollect"] := singleSetting("FishTourEnableJourneyCollect",
            true, "bool", "FishTourney")
        this.Map["FishTourTimerShopUpgrade"] := singleSetting("FishTourTimerShopUpgrade",
            60, "int", "FishTourney")
        this.Map["FishTourTimerUpgradeRods"] := singleSetting("FishTourTimerUpgradeRods",
            60, "int", "FishTourney")
        this.Map["FishTourTimerUpgradeTourneyRods"] := singleSetting("FishTourTimerUpgradeTourneyRods",
            60, "int", "FishTourney")
        this.Map["FishTourTimerTransmute"] := singleSetting("FishTourTimerTransmute",
            60, "int", "FishTourney")
        this.Map["FishTourTimerJourneyCollect"] := singleSetting("FishTourTimerJourneyCollect",
            60, "int", "FishTourney")
        this.Map["FishTourTransmuteTtoFC"] := singleSetting("FishTourTransmuteTtoFC",
            true, "bool", "FishTourney")
        this.Map["FishTourTransmuteFCtoCry"] := singleSetting("FishTourTransmuteFCtoCry",
            false, "bool", "FishTourney")
        this.Map["FishTourTransmuteCrytoA"] := singleSetting("FishTourTransmuteCrytoA",
            false, "bool", "FishTourney")
        this.Map["FishTourTransmuteFCtoT"] := singleSetting("FishTourTransmuteFCtoT",
            false, "bool", "FishTourney")
        this.Map["FishTourTransmuteCrytoFC"] := singleSetting("FishTourTransmuteCrytoFC",
            true, "bool", "FishTourney")
        this.Map["FishTourTransmuteAtoCry"] := singleSetting("FishTourTransmuteAtoCry",
            true, "bool", "FishTourney")
        this.Map["FishTourNovice"] := singleSetting("FishTourNovice",
            true, "bool", "FishTourney")
        this.Map["FishTourNoviceAttack"] := singleSetting("FishTourNoviceAttack",
            1, "int", "FishTourney")
        this.Map["FishTourIntermediate"] := singleSetting("FishTourIntermediate",
            false, "bool", "FishTourney")
        this.Map["FishTourIntermediateAttack"] := singleSetting("FishTourIntermediateAttack",
            1, "int", "FishTourney")
        this.Map["FishTourExpert"] := singleSetting("FishTourExpert",
            false, "bool", "FishTourney")
        this.Map["FishTourExpertAttack"] := singleSetting("FishTourExpertAttack",
            1, "int", "FishTourney")
        this.Map["FishTourLegend"] := singleSetting("FishTourLegend",
            false, "bool", "FishTourney")
        this.Map["FishTourLegendAttack"] := singleSetting("FishTourLegendAttack",
            1, "int", "FishTourney")

        ;@endregion

        If (!secondary) {
            If (DebugAll) {
                Debug := true
            }
            If (!FileExist(this.sFilename)) {
                Out.I("No UserSettings.ini found, writing default file.")
                this.WriteDefaults()
            }
            If (this.loadSettings()) {
                UpdateDebugLevel()
                Out.I("Loaded settings.")
            } Else {
                Return false
            }
            Return true
        } Else {
            this.sFilename := A_ScriptDir "\..\UserSettings.ini"
            If (this.loadSettings()) {
                UpdateDebugLevel()
                Out.I("Loaded settings.")
            } Else {
                Return false
            }
            Return true
        }
    }
    ;@endregion

    ;@region loadSettings()
    /**
     * Load script settings into global vars, runs UpdateSettings first to add
     * missing settings rather than reset to defaults if some settings exist
     * @returns {Boolean} False if error
     */
    loadSettings() {
        ;@region Globals
        Global EnableLogging := false
        Global Debug := false
        Global Verbose := false
        Global DebugAll := false
        Global TimestampLogs, LogBuffer

        Global CheckForUpdatesEnable, CheckForUpdatesReleaseOnly,
            CheckForUpdatesLastCheck

        Global GuiBGColour, GuiFontBold, GuiFontItalic, GuiFontStrike,
            GuiFontUnderline, GuiFontColour, GuiFontSize, GuiFontWeight,
            GuiFontName

        Global CardsCommonAmount, CardsRareAmount, CardsLegendaryAmount,
            CardsDontOpenCommons, CardsDontOpenRare, CardsDontOpenLegendary,
            CardsSleepAmount, CardsBuyEnabled, CardsBuyStyle,
            CardsCommonBuyAmount, CardsRareBuyAmount, CardsLegBuyAmount,
            CardsDontBuyCommons, CardsDontBuyRare, CardsDontBuyLeg,
            CardsSleepBuyAmount, CardsPermaLoop, CardsBossFarmEnabled,
            CardsGreedyOpen, CardsGreedyBuy

        Global GFToKillPerCycle, SSToKillPerCycle, GFSSNoReset
        Global GemFarmSleepAmount
        Global ClawCheckSizeOffset, ClawFindAny
        Global BVItemsArr, HaveBorbDLC, BVBlockMythLeg, BVInvArr
        Global NavigateTime
        Global DisableZoneChecks, DisableSettingsChecks
        Global ArtifactSleepAmount
        Global BossFarmUsesWind, BossFarmUsesWobblyWings,
            WobblyWingsSleepAmount, BossFarmUsesSeeds, BossFarmFast

        Global HyacinthUseSlot, HyacinthFarmBoss, HyacinthUseFlower,
            HyacinthUseSpheres, HyacinthUseNextAvailableFlower,
            HyacinthBanksEnabled

        Global BankEnableLGDeposit, BankEnableSNDeposit, BankEnableEBDeposit,
            BankEnableFFDeposit, BankEnableSRDeposit, BankEnableQADeposit,
            BankRunsSpammer, BankDepositTime, BankEnableStorageUpgrade

        Global LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled,
            LeaftonRunOnceEnabled, LeaftonEnableBrewing, LeaftonBrewCycleTime,
            LeaftonBrewCutOffTime

        Global TowerPassiveBanksEnabled, TowerPassiveCraftEnabled,
            TowerPassiveTravelEnabled

        Global MinerEnableVeins, MinerEnableTransmute, MinerEnableFreeRefuel,
            MinerTransmuteTimer, MinerRefuelTimer, MinerEnableSpammer,
            MinerEnableBanks, MinerEnableVeinUpgrade, MinerEnableVeinRemoval,
            MinerEnableCaves, MinerCaveTimer, MinerEnableLeafton
        Global MinerEnableSphereUse, MinerSphereDelay, MinerSphereCount,
            MinerSphereTimer, MinerSphereGreedyUse, MinerSphereModifier,
            MinerEnableTransmuteSdia, MinerEnableTransmuteFuel,
            MinerEnableTransmuteSphere, MinerEnableTransmuteSdiaToCDia
        Global MinerEnableBrewing, MinerBrewCycleTime, MinerBrewCutOffTime

        Global BrewEnableArtifacts, BrewEnableEquipment, BrewEnableMaterials,
            BrewEnableScrolls, BrewEnableCardParts

        Global SCAdvanceReplace

        Global FishCatchingDelay, FishCatchingSearch

        Global FishEnableShopUpgrade, FishEnableUpgradeRods, FishEnableTourneyPass,
            FishEnableUpgradeTourneyRods, FishEnableTransmute, FishEnableJourneyCollect

        Global FishTimerShopUpgrade, FishTimerUpgradeRods, FishTimerTourneyPass,
            FishTimerUpgradeTourneyRods, FishTimerTransmute, FishTimerJourneyCollect

        Global FishTransmuteTtoFC, FishTransmuteFCtoCry, FishTransmuteCrytoA,
            FishTransmuteFCtoT, FishTransmuteCrytoFC, FishTransmuteAtoCry

        Global FishNovice, FishIntermediate, FishExpert,
            FishLegend, FishNoviceAttack, FishIntermediateAttack,
            FishExpertAttack, FishLegendAttack

        Global FishChlCatchingDelay, FishChlCatchingSearch, FishChlAmount

        Global FishChlEnableShopUpgrade, FishChlEnableUpgradeRods,
            FishChlEnableTransmute, FishChlEnableJourneyCollect

        Global FishChlTimerShopUpgrade, FishChlTimerUpgradeRods,
            FishChlTimerTransmute, FishChlTimerJourneyCollect

        Global FishChlTransmuteTtoFC, FishChlTransmuteFCtoCry,
            FishChlTransmuteCrytoA, FishChlTransmuteFCtoT,
            FishChlTransmuteCrytoFC, FishChlTransmuteAtoCry

        Global FishTourCatchingDelay, FishTourCatchingSearch

        Global FishTourEnableShopUpgrade, FishTourEnableUpgradeRods,
            FishTourEnableFishingPass, FishTourEnableUpgradeTourneyRods,
            FishTourEnableTransmute, FishTourEnableJourneyCollect

        Global FishTourTimerShopUpgrade, FishTourTimerUpgradeRods,
            FishTourTimerUpgradeTourneyRods, FishTourTimerTransmute,
            FishTourTimerJourneyCollect

        Global FishTourTransmuteTtoFC, FishTourTransmuteFCtoCry, FishTourTransmuteCrytoA,
            FishTourTransmuteFCtoT, FishTourTransmuteCrytoFC, FishTourTransmuteAtoCry

        Global FishTourNovice, FishTourIntermediate, FishTourExpert,
            FishTourLegend, FishTourNoviceAttack, FishTourIntermediateAttack,
            FishTourExpertAttack, FishTourLegendAttack
        ;@endregion

        this.UpdateSettings()
        For (setting in this.Map) {
            Try {
                If (StrLower(this.Map[setting].DataType) != "array") {
                    %this.Map[setting].Name% := ;
                        this.IniToVar(this.Map[setting].Name, this.Map[setting]
                            .Category)
                } Else {
                    ; special handling for array datatypes
                    %this.Map[setting].Name% := CommaDelimStrToArr( ;
                        this.IniToVar(this.Map[setting].Name, this.Map[setting]
                            .Category))
                }
            } Catch As exc {
                If (exc.Extra) {
                    Out.I("Error 35: LoadSettings failed - " exc.Message "`n" exc
                        .Extra)
                } Else {
                    Out.I("Error 35: LoadSettings failed - " exc.Message)
                }
                MsgBox("Could not load all settings, making new default " .
                    "UserSettings.ini")
                Out.I("Attempting to write a new default UserSettings.ini.")
                this.WriteDefaults()
                Return false
            }
        }
        Return true
    }
    ;@endregion

    ;@region UpdateSettings()
    /**
     * Adds missing settings using defaults if some settings don't exist
     */
    UpdateSettings() {
        For (setting in this.Map) {
            Try {
                test := this.IniToVar(this.Map[setting].Name, this.Map[setting]
                    .Category)
            } Catch {
                this.WriteToIni(this.Map[setting].Name, this.Map[setting].ValueToString(
                    this.Map[setting].DefaultValue), this.Map[setting
                ].Category)
            }
        }
    }
    ;@endregion

    ;@region WriteDefaults()
    /**
     * Write default settings to ini file, does not wipe other removed settings
     */
    WriteDefaults() {
        For (setting in this.Map) {
            this.WriteToIni(this.Map[setting].Name, this.Map[setting].ValueToString(
                this.Map[setting].DefaultValue), this.Map[setting].Category
            )
        }
    }
    ;@endregion

    ;@region SaveCurrentSettings()
    /**
     * Save current Map to ini file converting to format safe for storage
     */
    SaveCurrentSettings() {
        For (setting in this.Map) {
            this.WriteToIni(this.Map[setting].Name, ;
                this.Map[setting].ValueToString(), this.Map[setting].Category)
        }
    }
    ;@endregion

    ;@region WriteToIni()
    /**
     * Write (key, value) to ini file within (section) heading
     * @param key Name of setting
     * @param value Value of setting
     * @param {String} [section="Default"] 
     */
    WriteToIni(key, value, section := this.sFileSection) {
        Try {
            storedVal := IniRead(this.sFilename, section, key)
        } Catch Error {

        }
        If (!IsSet(storedVal)) {
            IniWrite(value, this.sFilename, section, key)
            Return
        }
        If (storedVal != value) {
            IniWrite(value, this.sFilename, section, key)
        }
    }
    ;@endregion

    ;@region IniToVar()
    /**
     * Reads ini value for (name) in (section) from (file) and returns as 
     * string or Boolean
     * @param name 
     * @param {String} section 
     * @param {String} file 
     * @returns {Integer | String} 
     */
    IniToVar(name, section := this.sFileSection, file := this.sFilename) {
        var := IniRead(file, section, name)
        Switch var {
        Case "true":
            Return true
        Case "false":
            Return false
        default:
            Return var
        }
    }
    ;@endregion
}
