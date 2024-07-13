#Requires AutoHotkey v2.0

; ------------------- Settings -------------------
; Loads UserSettings.ini values for the rest of the script to use

;@region Globals definition
Global EnableLogging := false
Global Debug := false
Global Verbose := false
Global DisableZoneChecks := DisableSettingsChecks := false
Global TimestampLogs := true

Global BossFarmUsesWind := BossFarmUsesWobblyWings := BossFarmUsesSeeds :=
    false
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
Global NavigateTime

Global HyacinthUseSlot, HyacinthFarmBoss, HyacinthUseFlower, HyacinthUseSpheres,
    HyacinthUseNextAvailableFlower, HyacinthBanksEnabled

Global BankEnableLGDeposit, BankEnableSNDeposit, BankEnableEBDeposit,
    BankEnableFFDeposit, BankEnableSRDeposit, BankEnableQADeposit,
    BankRunsSpammer, BankDepositTime, BankEnableStorageUpgrade

Global LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled,
    LeaftonRunOnceEnabled, LeaftonEnableBrewing, LeaftonBrewCycleTime,
    LeaftonBrewCutOffTime

Global TowerPassiveBanksEnabled, TowerPassiveCraftEnabled

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
;@endregion

/**
 * Single instance of a script setting object
 * @property Name Name of the setting and global var name
 * @property DefaultValue Default value for non developers
 * @property NobodyDefaultValue Default value for developer
 * @property DataType Internal custom datatype string {bool | int | arrborbv}
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
     * Default value for developer
     * @type {String | Integer | Any} 
     */
    NobodyDefaultValue := 0
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
     * @param {Integer} iNobodyDefaultValue Default value set for developer
     * @param {String} [iDataType="bool"] Internal custom datatype
     * @param {String} [iCategory="Default"] Ini file section heading name
     * @returns {singleSetting} Returns (this)
     */
    __New(iName, iDefaultValue := 0, iNobodyDefaultValue := 0, iDataType :=
        "bool", iCategory := "Default") {
        this.Name := iName
        this.DefaultValue := iDefaultValue
        this.NobodyDefaultValue := iNobodyDefaultValue
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
            Case "arrborbv":
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
 * @property sUseNobody Use developer default settings toggle
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
     * Use developer default settings toggle
     * @type {Boolean}
     */
    sUseNobody := false
    /**
     * Map to store singleSettings objects per global var name
     * @type {Map<string, singleSetting>}
     */
    Map := Map()
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

        this.Map["EnableLogging"] := singleSetting("EnableLogging", false, true,
            "bool", "Default")
        this.Map["TimestampLogs"] := singleSetting("TimestampLogs", true, true,
            "bool", "Default")
        this.Map["DisableZoneChecks"] := singleSetting("DisableZoneChecks",
            false, false, "bool", "Default")
        this.Map["DisableSettingsChecks"] := singleSetting(
            "DisableSettingsChecks", false, false, "bool", "Default")
        this.Map["CheckForUpdatesEnable"] := singleSetting(
            "CheckForUpdatesEnable", true, true, "bool", "Updates")
        this.Map["CheckForUpdatesReleaseOnly"] := singleSetting(
            "CheckForUpdatesReleaseOnly", true, true, "bool", "Updates")
        this.Map["CheckForUpdatesLastCheck"] := singleSetting(
            "CheckForUpdatesLastCheck", 0, 0, "int", "Updates")
        this.Map["Debug"] := singleSetting("Debug", false, true, "bool",
            "Debug")
        this.Map["Verbose"] := singleSetting("Verbose", false, true, "bool",
            "Debug")
        this.Map["NavigateTime"] := singleSetting("NavigateTime", 101, 101,
            "int", "Default")
        this.Map["HaveBorbDLC"] := singleSetting("HaveBorbDLC", false, false,
            "bool", "Borbventures")
        this.Map["BVBlockMythLeg"] := singleSetting("BVBlockMythLeg", false,
            false, "bool", "Borbventures")
        this.Map["BVItemsArr"] := singleSetting("BVItemsArr",
            "0x018C9C, 0x01D814, 0x0F2A1D, 0x6CD820, 0xC9C9C9",
            "0x01D814, 0xC9C9C9, 0xF91FF6", "arrBorbv", "Borbventures")
        this.Map["CardsCommonAmount"] := singleSetting("CardsCommonAmount",
            25000, 1000, "int", "Cards")
        this.Map["CardsRareAmount"] := singleSetting("CardsRareAmount", 25000,
            1000, "int", "Cards")
        this.Map["CardsLegendaryAmount"] := singleSetting(
            "CardsLegendaryAmount", 25000, 1000, "int", "Cards")
        this.Map["CardsGreedyOpen"] := singleSetting("CardsGreedyOpen", false,
            false, "bool", "Cards")
        this.Map["CardsGreedyBuy"] := singleSetting("CardsGreedyBuy", false,
            false, "bool", "Cards")
        this.Map["CardsDontOpenCommons"] := singleSetting(
            "CardsDontOpenCommons", false, false, "bool", "Cards")
        this.Map["CardsDontOpenRare"] := singleSetting("CardsDontOpenRare",
            false, false, "bool", "Cards")
        this.Map["CardsDontOpenLegendary"] := singleSetting(
            "CardsDontOpenLegendary", false, false, "bool", "Cards")
        this.Map["CardsSleepAmount"] := singleSetting("CardsSleepAmount", 875,
            875, "int", "Cards")
        this.Map["CardsPermaLoop"] := singleSetting("CardsPermaLoop", true,
            true, "bool", "Cards")
        this.Map["CardsBossFarmEnabled"] := singleSetting(
            "CardsBossFarmEnabled", true, true, "bool", "Cards")
        this.Map["CardsBuyEnabled"] := singleSetting("CardsBuyEnabled", true,
            true, "bool", "CardsBuy")
        this.Map["CardsBuyStyle"] := singleSetting("CardsBuyStyle",
            "FocusLegend", "FocusLegend", "text", "CardsBuy")
        this.Map["CardsCommonBuyAmount"] := singleSetting(
            "CardsCommonBuyAmount", 25000, 25000, "int", "CardsBuy")
        this.Map["CardsRareBuyAmount"] := singleSetting("CardsRareBuyAmount",
            25000, 25000, "int", "CardsBuy")
        this.Map["CardsLegBuyAmount"] := singleSetting("CardsLegBuyAmount",
            25000, 25000, "int", "CardsBuy")
        this.Map["CardsDontBuyCommons"] := singleSetting("CardsDontBuyCommons",
            false, false, "bool", "CardsBuy")
        this.Map["CardsDontBuyRare"] := singleSetting("CardsDontBuyRare", false,
            false, "bool", "CardsBuy")
        this.Map["CardsDontBuyLeg"] := singleSetting("CardsDontBuyLeg", false,
            false, "bool", "CardsBuy")
        this.Map["CardsSleepBuyAmount"] := singleSetting("CardsSleepBuyAmount",
            17, 17, "int", "CardsBuy")
        this.Map["GFToKillPerCycle"] := singleSetting("GFToKillPerCycle", 8, 1,
            "int", "SSFarm")
        this.Map["SSToKillPerCycle"] := singleSetting("SSToKillPerCycle", 1, 1,
            "int", "SSFarm")
        this.Map["GFSSNoReset"] := singleSetting("GFSSNoReset", false, false,
            "bool", "SSFarm")
        this.Map["GemFarmSleepAmount"] := singleSetting("GemFarmSleepAmount",
            17, 17, "int", "GemFarm")
        this.Map["ClawCheckSizeOffset"] := singleSetting("ClawCheckSizeOffset",
            0, 0, "int", "Claw")
        this.Map["ClawFindAny"] := singleSetting("ClawFindAny", false, false,
            "bool", "Claw")
        this.Map["ArtifactSleepAmount"] := singleSetting("ArtifactSleepAmount",
            17, 17, "int", "BossFarm")
        this.Map["BossFarmUsesWind"] := singleSetting("BossFarmUsesWind", true,
            true, "bool", "BossFarm")
        this.Map["BossFarmUsesWobblyWings"] := singleSetting(
            "BossFarmUsesWobblyWings", true, true, "bool", "BossFarm")
        this.Map["BossFarmUsesSeeds"] := singleSetting("BossFarmUsesSeeds",
            true, true, "bool", "BossFarm")
        this.Map["WobblyWingsSleepAmount"] := singleSetting(
            "WobblyWingsSleepAmount", 17, 17, "int", "BossFarm")
        this.Map["HyacinthUseSlot"] := singleSetting("HyacinthUseSlot", "All",
            "All", "text", "NatureFarm")
        this.Map["HyacinthFarmBoss"] := singleSetting("HyacinthFarmBoss", true,
            true, "bool", "NatureFarm")
        this.Map["HyacinthUseFlower"] := singleSetting("HyacinthUseFlower",
            "hyacinth", "hyacinth", "text", "NatureFarm")
        this.Map["HyacinthUseSpheres"] := singleSetting("HyacinthUseSpheres",
            false, false, "bool", "NatureFarm")
        this.Map["HyacinthUseNextAvailableFlower"] := singleSetting(
            "HyacinthUseNextAvailableFlower", false, false, "bool",
            "NatureFarm")
        this.Map["HyacinthBanksEnabled"] := singleSetting(
            "HyacinthBanksEnabled", true, true, "bool", "NatureFarm")
        this.Map["BankEnableLGDeposit"] := singleSetting("BankEnableLGDeposit",
            true, true, "bool", "Bank")
        this.Map["BankEnableSNDeposit"] := singleSetting("BankEnableSNDeposit",
            true, true, "bool", "Bank")
        this.Map["BankEnableEBDeposit"] := singleSetting("BankEnableEBDeposit",
            true, true, "bool", "Bank")
        this.Map["BankEnableFFDeposit"] := singleSetting("BankEnableFFDeposit",
            true, true, "bool", "Bank")
        this.Map["BankEnableSRDeposit"] := singleSetting("BankEnableSRDeposit",
            true, true, "bool", "Bank")
        this.Map["BankEnableQADeposit"] := singleSetting("BankEnableQADeposit",
            true, true, "bool", "Bank")
        this.Map["BankEnableStorageUpgrade"] := singleSetting(
            "BankEnableStorageUpgrade", false, false, "bool", "Bank")
        this.Map["BankRunsSpammer"] := singleSetting("BankRunsSpammer", true,
            true, "bool", "Bank")
        this.Map["BankDepositTime"] := singleSetting("BankDepositTime", 5, 5,
            "int", "Bank")
        this.Map["LeaftonCraftEnabled"] := singleSetting("LeaftonCraftEnabled",
            true, true, "bool", "Leafton")
        this.Map["LeaftonSpamsWind"] := singleSetting("LeaftonSpamsWind", true,
            true, "bool", "Leafton")
        this.Map["LeaftonBanksEnabled"] := singleSetting("LeaftonBanksEnabled",
            true, true, "bool", "Leafton")
        this.Map["LeaftonRunOnceEnabled"] := singleSetting(
            "LeaftonRunOnceEnabled", false, false, "bool", "Leafton")
        this.Map["LeaftonEnableBrewing"] := singleSetting(
            "LeaftonEnableBrewing", false, false, "bool", "Leafton")
        this.Map["LeaftonBrewCycleTime"] := singleSetting(
            "LeaftonBrewCycleTime", 10, 10, "int", "Leafton")
        this.Map["LeaftonBrewCutOffTime"] := singleSetting(
            "LeaftonBrewCutOffTime", 30, 30, "int", "Leafton")
        this.Map["TowerPassiveBanksEnabled"] := singleSetting(
            "TowerPassiveBanksEnabled", true, true, "bool", "TowerPassive")
        this.Map["TowerPassiveCraftEnabled"] := singleSetting(
            "TowerPassiveCraftEnabled", true, true, "bool", "TowerPassive")
        this.Map["MinerEnableVeins"] := singleSetting("MinerEnableVeins", true,
            true, "bool", "Miner")
        this.Map["MinerEnableTransmute"] := singleSetting(
            "MinerEnableTransmute", true, true, "bool", "Miner")
        this.Map["MinerEnableTransmuteSdia"] := singleSetting(
            "MinerEnableTransmuteSdia", false, false, "bool", "Miner")
        this.Map["MinerEnableTransmuteFuel"] := singleSetting(
            "MinerEnableTransmuteFuel", false, false, "bool", "Miner")
        this.Map["MinerEnableTransmuteSphere"] := singleSetting(
            "MinerEnableTransmuteSphere", false, false, "bool", "Miner")
        this.Map["MinerEnableTransmuteSdiaToCDia"] := singleSetting(
            "MinerEnableTransmuteSdiaToCDia", false, false, "bool", "Miner")
        this.Map["MinerEnableFreeRefuel"] := singleSetting(
            "MinerEnableFreeRefuel", true, true, "bool", "Miner")
        this.Map["MinerEnableBanks"] := singleSetting("MinerEnableBanks", true,
            true, "bool", "Miner")
        this.Map["MinerEnableSpammer"] := singleSetting("MinerEnableSpammer",
            true, true, "bool", "Miner")
        this.Map["MinerEnableLeafton"] := singleSetting("MinerEnableLeafton",
            false, false, "bool", "Miner")
        this.Map["MinerEnableVeinUpgrade"] := singleSetting(
            "MinerEnableVeinUpgrade", false, false, "bool", "Miner")
        this.Map["MinerEnableVeinRemoval"] := singleSetting(
            "MinerEnableVeinRemoval", false, false, "bool", "Miner")
        this.Map["MinerEnableSphereUse"] := singleSetting(
            "MinerEnableSphereUse", false, false, "bool", "Miner")
        this.Map["MinerEnableCaves"] := singleSetting("MinerEnableCaves", true,
            true, "bool", "Miner")
        this.Map["MinerSphereGreedyUse"] := singleSetting(
            "MinerSphereGreedyUse", false, false, "bool", "Miner")
        this.Map["MinerSphereDelay"] := singleSetting("MinerSphereDelay", 1000,
            1000, "int", "Miner")
        this.Map["MinerSphereCount"] := singleSetting("MinerSphereCount", 0, 0,
            "int", "Miner")
        this.Map["MinerSphereTimer"] := singleSetting("MinerSphereTimer", 1, 1,
            "int", "Miner")
        this.Map["MinerSphereModifier"] := singleSetting("MinerSphereModifier",
            1, 1, "int", "Miner")
        this.Map["MinerTransmuteTimer"] := singleSetting("MinerTransmuteTimer",
            10, 10, "int", "Miner")
        this.Map["MinerRefuelTimer"] := singleSetting("MinerRefuelTimer", 1, 1,
            "int", "Miner")
        this.Map["MinerCaveTimer"] := singleSetting("MinerCaveTimer", 5, 5,
            "int", "Miner")
        this.Map["MinerEnableBrewing"] := singleSetting("MinerEnableBrewing",
            true, true, "bool", "Miner")
        this.Map["MinerBrewCycleTime"] := singleSetting("MinerBrewCycleTime",
            30, 30, "int", "Miner")
        this.Map["MinerBrewCutOffTime"] := singleSetting("MinerBrewCutOffTime",
            30, 30, "int", "Miner")
        this.Map["BrewEnableArtifacts"] := singleSetting("BrewEnableArtifacts",
            true, true, "bool", "Brew")
        this.Map["BrewEnableEquipment"] := singleSetting("BrewEnableEquipment",
            true, true, "bool", "Brew")
        this.Map["BrewEnableMaterials"] := singleSetting("BrewEnableMaterials",
            true, true, "bool", "Brew")
        this.Map["BrewEnableScrolls"] := singleSetting("BrewEnableScrolls",
            false, false, "bool", "Brew")
        this.Map["BrewEnableCardParts"] := singleSetting("BrewEnableCardParts",
            true, true, "bool", "Brew")
        ;@endregion

        If (!secondary) {
            If (FileExist(A_ScriptDir "\IsNobody")) {
                this.sUseNobody := true
                Debug := true
                Log("Settings: Using Nobody Defaults")
            }
            If (!FileExist(this.sFilename)) {
                Log("No UserSettings.ini found, writing default file.")
                this.WriteDefaults(this.sUseNobody)
            }
            If (this.loadSettings()) {
                Log("Loaded settings.")
            } Else {
                Return false
            }
            Return true
        } Else {
            this.sFilename := A_ScriptDir "\..\UserSettings.ini"
            If (this.loadSettings()) {
                Log("Loaded settings.")
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
        Global TimestampLogs

        Global CheckForUpdatesEnable, CheckForUpdatesReleaseOnly,
            CheckForUpdatesLastCheck

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
        Global BVItemsArr, HaveBorbDLC, BVBlockMythLeg
        Global NavigateTime
        Global DisableZoneChecks, DisableSettingsChecks
        Global ArtifactSleepAmount
        Global BossFarmUsesWind, BossFarmUsesWobblyWings,
            WobblyWingsSleepAmount, BossFarmUsesSeeds

        Global HyacinthUseSlot, HyacinthFarmBoss, HyacinthUseFlower,
            HyacinthUseSpheres, HyacinthUseNextAvailableFlower,
            HyacinthBanksEnabled

        Global BankEnableLGDeposit, BankEnableSNDeposit, BankEnableEBDeposit,
            BankEnableFFDeposit, BankEnableSRDeposit, BankEnableQADeposit,
            BankRunsSpammer, BankDepositTime, BankEnableStorageUpgrade

        Global LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled,
            LeaftonRunOnceEnabled, LeaftonEnableBrewing, LeaftonBrewCycleTime,
            LeaftonBrewCutOffTime

        Global TowerPassiveBanksEnabled, TowerPassiveCraftEnabled

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
        ;@endregion

        this.UpdateSettings()
        For (setting in this.Map) {
            Try {
                If (this.Map[setting].Name != "BVItemsArr") {
                    %this.Map[setting].Name% := ;
                        this.IniToVar(this.Map[setting].Name, this.Map[setting]
                            .Category)
                } Else {
                    ; special handling for the bv array
                    %this.Map[setting].Name% := CommaDelimStrToArr( ;
                        this.IniToVar(this.Map[setting].Name, this.Map[setting]
                            .Category))
                }
            } Catch As exc {
                If (exc.Extra) {
                    Log("Error 35: LoadSettings failed - " exc.Message "`n" exc
                        .Extra)
                } Else {
                    Log("Error 35: LoadSettings failed - " exc.Message)
                }
                MsgBox("Could not load all settings, making new default " .
                    "UserSettings.ini")
                Log("Attempting to write a new default UserSettings.ini.")
                this.WriteDefaults(this.sUseNobody)
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
                If (!this.sUseNobody) {
                    this.WriteToIni(this.Map[setting].Name, this.Map[setting].ValueToString(
                        this.Map[setting].DefaultValue), this.Map[setting].Category
                    )
                } Else {
                    this.WriteToIni(this.Map[setting].Name, this.Map[setting].ValueToString(
                        this.Map[setting].NobodyDefaultValue), this.Map[setting
                        ].Category)
                }
            }
        }
    }
    ;@endregion

    ;@region WriteDefaults()
    /**
     * Write default settings to ini file, does not wipe other removed settings
     * @param isnobody Flag for developer default settings
     */
    WriteDefaults(isnobody) {
        If (isnobody) {
            For (setting in this.Map) {
                this.WriteToIni(this.Map[setting].Name, this.Map[setting].ValueToString(
                    this.Map[setting].NobodyDefaultValue), this.Map[setting].Category
                )
            }
        } Else {
            For (setting in this.Map) {
                this.WriteToIni(this.Map[setting].Name, this.Map[setting].ValueToString(
                    this.Map[setting].DefaultValue), this.Map[setting].Category
                )
            }
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
        IniWrite(value, this.sFilename, section, key)
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