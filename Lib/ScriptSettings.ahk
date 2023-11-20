#Requires AutoHotkey v2.0

; ------------------- Settings -------------------
; Loads UserSettings.ini values for the rest of the script to use

global EnableLogging := false
global CardsCommonAmount, CardsRareAmount, CardsLegendaryAmount
global CardsDontOpenCommons, CardsDontOpenRare, CardsDontOpenLegendary
global CardsSleepAmount, CardsBuyEnabled, CardsBuyStyle
global CardsCommonBuyAmount, CardsRareBuyAmount, CardsLegBuyAmount
global CardsDontBuyCommons, CardsDontBuyRare, CardsDontBuyLeg
global CardsSleepBuyAmount, CardsPermaLoop
global CardsBossFarmEnabled
global GFSSFarmUseGrav, GFSSFarmUseWind, GFToKillPerCycle, SSToKillPerCycle
global GemFarmSleepAmount
global ClawCheckSizeOffset
global BVItemsArr, HaveBorbDLC
global QuarkFarmResetToBoss
global NavigateTime
global DisableZoneChecks, DisableSettingsChecks
global ArtifactSleepAmount
global F9UsesWind, F9UsesWobblyWings, WobblyWingsSleepAmount


class cSettings {
    sFilename := A_ScriptDir "\UserSettings.ini"
    sFileSection := "Default"
    sUseNobody := false
    defaultNobodySettings := {
        EnableLogging: "true",
        HaveBorbDLC: "false",
        CardsCommonAmount: 25000,
        CardsRareAmount: 25000,
        CardsLegendaryAmount: 25000,
        CardsDontOpenCommons: "false",
        CardsDontOpenRare: "false",
        CardsDontOpenLegendary: "false",
        CardsSleepAmount: 860,
        CardsBuyEnabled: "true",
        CardsBuyStyle: "FocusLegend",
        CardsCommonBuyAmount: 25000,
        CardsRareBuyAmount: 25000,
        CardsLegBuyAmount: 25000,
        CardsDontBuyCommons: "false",
        CardsDontBuyRare: "false",
        CardsDontBuyLeg: "false",
        CardsSleepBuyAmount: 17,
        CardsPermaLoop: "true",
        CardsBossFarmEnabled: "true",
        GFSSFarmUseGrav: "true",
        GFSSFarmUseWind: "true",
        GFToKillPerCycle: 2,
        SSToKillPerCycle: 1,
        GemFarmSleepAmount: 72,
        ClawCheckSizeOffset: 0,
        BVItemsArr: "0x018C9C, 0x01D814, 0x0F2A1D, 0x6CD820, 0xC9C9C9",
        QuarkFarmResetToBoss: 3,
        NavigateTime: 101,
        DisableZoneChecks: "false",
        DisableSettingsChecks: "false",
        ArtifactSleepAmount: 74,
        F9UsesWind: "true",
        F9UsesWobblyWings: "false",
        WobblyWingsSleepAmount: 750,
    }
    defaultSettings := {
        EnableLogging: "false",
        HaveBorbDLC: "false",
        CardsCommonAmount: 25000,
        CardsRareAmount: 25000,
        CardsLegendaryAmount: 25000,
        CardsDontOpenCommons: "false",
        CardsDontOpenRare: "false",
        CardsDontOpenLegendary: "false",
        CardsSleepAmount: 860,
        CardsBuyEnabled: "false",
        CardsBuyStyle: "FocusLegend",
        CardsCommonBuyAmount: 25000,
        CardsRareBuyAmount: 25000,
        CardsLegBuyAmount: 25000,
        CardsDontBuyCommons: "false",
        CardsDontBuyRare: "false",
        CardsDontBuyLeg: "false",
        CardsSleepBuyAmount: 72,
        CardsPermaLoop: "false",
        CardsBossFarmEnabled: "true",
        GFSSFarmUseGrav: "true",
        GFSSFarmUseWind: "true",
        GFToKillPerCycle: 8,
        SSToKillPerCycle: 1,
        GemFarmSleepAmount: 101,
        ClawCheckSizeOffset: 0,
        BVItemsArr: "0x01D814, 0xC9C9C9, 0xF91FF6",
        QuarkFarmResetToBoss: 0,
        NavigateTime: 101,
        DisableZoneChecks: "false",
        DisableSettingsChecks: "false",
        ArtifactSleepAmount: 74,
        F9UsesWind: "true",
        F9UsesWobblyWings: "false",
        WobblyWingsSleepAmount: 750,
    }
    loadedSettings := {}
    /*
    __Init() {     } */

    initSettings(secondary := false) {
        if (!secondary) {
            if (FileExist(A_ScriptDir "\..\IsNobody")) {
                this.sUseNobody := true
                OutputDebug("Settings: Using Nobody Defaults")
                Log("Settings: Using Nobody Defaults")
            }
            if (!FileExist(this.sFilename)) {
                OutputDebug("No UserSettings.ini found, writing default file.")
                Log("No UserSettings.ini found, writing default file.")
                this.WriteDefaults()
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
        global EnableLogging, HaveBorbDLC, Debug
        global CardsCommonAmount, CardsRareAmount, CardsLegendaryAmount
        global CardsDontOpenCommons, CardsDontOpenRare, CardsDontOpenLegendary
        global CardsSleepAmount, CardsBuyEnabled, CardsBuyStyle
        global CardsCommonBuyAmount, CardsRareBuyAmount, CardsLegBuyAmount
        global CardsDontBuyCommons, CardsDontBuyRare, CardsDontBuyLeg
        global CardsSleepBuyAmount, CardsPermaLoop
        global CardsBossFarmEnabled
        global GFSSFarmUseGrav, GFSSFarmUseWind, GFToKillPerCycle, SSToKillPerCycle
        global GemFarmSleepAmount
        global ClawCheckSizeOffset
        global BVItemsArr
        global QuarkFarmResetToBoss
        global NavigateTime
        global DisableZoneChecks, DisableSettingsChecks
        global ArtifactSleepAmount
        global F9UsesWind, F9UsesWobblyWings, WobblyWingsSleepAmount
        try {
            EnableLogging := this.loadedSettings.EnableLogging :=
                IniToVar(this.sFilename, this.sFileSection, "EnableLogging")
            HaveBorbDLC := this.loadedSettings.HaveBorbDLC :=
                IniToVar(this.sFilename, this.sFileSection, "HaveBorbDLC")
            CardsCommonAmount := this.loadedSettings.CardsCommonAmount :=
                IniToVar(this.sFilename, this.sFileSection, "CardsCommonAmount")
            CardsRareAmount := this.loadedSettings.CardsRareAmount :=
                IniToVar(this.sFilename, this.sFileSection, "CardsRareAmount")
            CardsLegendaryAmount := this.loadedSettings.CardsLegendaryAmount :=
                IniToVar(this.sFilename, this.sFileSection, "CardsLegendaryAmount")
            CardsDontOpenCommons := this.loadedSettings.CardsDontOpenCommons :=
                IniToVar(this.sFilename, this.sFileSection, "CardsDontOpenCommons")
            CardsDontOpenRare := this.loadedSettings.CardsDontOpenRare :=
                IniToVar(this.sFilename, this.sFileSection, "CardsDontOpenRare")
            CardsDontOpenLegendary := this.loadedSettings.CardsDontOpenLegendary :=
                IniToVar(this.sFilename, this.sFileSection, "CardsDontOpenLegendary")
            CardsSleepAmount := this.loadedSettings.CardsSleepAmount :=
                IniToVar(this.sFilename, this.sFileSection, "CardsSleepAmount")
            CardsBuyEnabled := this.loadedSettings.CardsBuyEnabled :=
                IniToVar(this.sFilename, this.sFileSection, "CardsBuyEnabled")
            CardsBuyStyle := this.loadedSettings.CardsBuyStyle :=
                IniToVar(this.sFilename, this.sFileSection, "CardsBuyStyle")
            CardsCommonBuyAmount := this.loadedSettings.CardsCommonBuyAmount :=
                IniToVar(this.sFilename, this.sFileSection, "CardsCommonBuyAmount")
            CardsRareBuyAmount := this.loadedSettings.CardsRareBuyAmount :=
                IniToVar(this.sFilename, this.sFileSection, "CardsRareBuyAmount")
            CardsLegBuyAmount := this.loadedSettings.CardsLegBuyAmount :=
                IniToVar(this.sFilename, this.sFileSection, "CardsLegBuyAmount")
            CardsDontBuyCommons := this.loadedSettings.CardsDontBuyCommons :=
                IniToVar(this.sFilename, this.sFileSection, "CardsDontBuyCommons")
            CardsDontBuyRare := this.loadedSettings.CardsDontBuyRare :=
                IniToVar(this.sFilename, this.sFileSection, "CardsDontBuyRare")
            CardsDontBuyLeg := this.loadedSettings.CardsDontBuyLeg :=
                IniToVar(this.sFilename, this.sFileSection, "CardsDontBuyLeg")
            CardsSleepBuyAmount := this.loadedSettings.CardsSleepBuyAmount :=
                IniToVar(this.sFilename, this.sFileSection, "CardsSleepBuyAmount")
            CardsPermaLoop := this.loadedSettings.CardsPermaLoop :=
                IniToVar(this.sFilename, this.sFileSection, "CardsPermaLoop")
            CardsBossFarmEnabled := this.loadedSettings.CardsBossFarmEnabled :=
                IniToVar(this.sFilename, this.sFileSection, "CardsBossFarmEnabled")
            GFSSFarmUseGrav := this.loadedSettings.GFSSFarmUseGrav :=
                IniToVar(this.sFilename, this.sFileSection, "GFSSFarmUseGrav")
            GFSSFarmUseWind := this.loadedSettings.GFSSFarmUseWind :=
                IniToVar(this.sFilename, this.sFileSection, "GFSSFarmUseWind")
            GFToKillPerCycle := this.loadedSettings.GFToKillPerCycle :=
                IniToVar(this.sFilename, this.sFileSection, "GFToKillPerCycle")
            SSToKillPerCycle := this.loadedSettings.SSToKillPerCycle :=
                IniToVar(this.sFilename, this.sFileSection, "SSToKillPerCycle")
            GemFarmSleepAmount := this.loadedSettings.GemFarmSleepAmount :=
                IniToVar(this.sFilename, this.sFileSection, "GemFarmSleepAmount")
            ClawCheckSizeOffset := this.loadedSettings.ClawCheckSizeOffset :=
                IniToVar(this.sFilename, this.sFileSection, "ClawCheckSizeOffset")
            BVItemsArr := this.loadedSettings.BVItemsArr :=
                StrSplit(IniToVar(this.sFilename, this.sFileSection, "BVItemsArr"), " ", ",.")
            QuarkFarmResetToBoss := this.loadedSettings.QuarkFarmResetToBoss :=
                IniToVar(this.sFilename, this.sFileSection, "QuarkFarmResetToBoss")
            NavigateTime := this.loadedSettings.NavigateTime :=
                IniToVar(this.sFilename, this.sFileSection, "NavigateTime")
            DisableZoneChecks := this.loadedSettings.DisableZoneChecks :=
                IniToVar(this.sFilename, this.sFileSection, "DisableZoneChecks")
            DisableSettingsChecks := this.loadedSettings.DisableSettingsChecks :=
                IniToVar(this.sFilename, this.sFileSection, "DisableSettingsChecks")
            ArtifactSleepAmount := this.loadedSettings.ArtifactSleepAmount :=
                IniToVar(this.sFilename, this.sFileSection, "ArtifactSleepAmount")
            F9UsesWind := this.loadedSettings.F9UsesWind :=
                IniToVar(this.sFilename, this.sFileSection, "F9UsesWind")
            F9UsesWobblyWings := this.loadedSettings.F9UsesWobblyWings :=
                IniToVar(this.sFilename, this.sFileSection, "F9UsesWobblyWings")
            WobblyWingsSleepAmount := this.loadedSettings.WobblyWingsSleepAmount :=
                IniToVar(this.sFilename, this.sFileSection, "WobblyWingsSleepAmount")

            Debug := IniToVar(this.sFilename, "Debug", "Debug")
        } catch as exc {
            if (exc.Extra) {
                Log("Error 35: LoadSettings failed - " exc.Message "`n" exc.Extra)
            } else {
                Log("Error 35: LoadSettings failed - " exc.Message)
            }
            MsgBox("Could not load settings, making new default UserSettings.ini")
            Log("Attempting to write a new default UserSettings.ini.")
            this.WriteDefaults()
            return false
        }
        return true
    }

    /* saveSettings() {
        IniWrite("this is a new value", this.sFilename, this.sFileSection, "key")
    
    } */

    WriteToIni(key, value, section := this.sFileSection) {
        IniWrite(value, this.sFilename, section, key)
    }

    WriteDefaults() {
        if (this.sUseNobody) {
            this.WriteToIni("EnableLogging", this.defaultNobodySettings.EnableLogging)
            this.WriteToIni("HaveBorbDLC", this.defaultNobodySettings.HaveBorbDLC)
            this.WriteToIni("CardsCommonAmount", this.defaultNobodySettings.CardsCommonAmount)
            this.WriteToIni("CardsRareAmount", this.defaultNobodySettings.CardsRareAmount)
            this.WriteToIni("CardsLegendaryAmount", this.defaultNobodySettings.CardsLegendaryAmount)
            this.WriteToIni("CardsDontOpenCommons", this.defaultNobodySettings.CardsDontOpenCommons)
            this.WriteToIni("CardsDontOpenRare", this.defaultNobodySettings.CardsDontOpenRare)
            this.WriteToIni("CardsDontOpenLegendary", this.defaultNobodySettings.CardsDontOpenLegendary)
            this.WriteToIni("CardsSleepAmount", this.defaultNobodySettings.CardsSleepAmount)
            this.WriteToIni("CardsBuyEnabled", this.defaultNobodySettings.CardsBuyEnabled)
            this.WriteToIni("CardsBuyStyle", this.defaultNobodySettings.CardsBuyStyle)
            this.WriteToIni("CardsCommonBuyAmount", this.defaultNobodySettings.CardsCommonBuyAmount)
            this.WriteToIni("CardsRareBuyAmount", this.defaultNobodySettings.CardsRareBuyAmount)
            this.WriteToIni("CardsLegBuyAmount", this.defaultNobodySettings.CardsLegBuyAmount)
            this.WriteToIni("CardsDontBuyCommons", this.defaultNobodySettings.CardsDontBuyCommons)
            this.WriteToIni("CardsDontBuyRare", this.defaultNobodySettings.CardsDontBuyRare)
            this.WriteToIni("CardsDontBuyLeg", this.defaultNobodySettings.CardsDontBuyLeg)
            this.WriteToIni("CardsSleepBuyAmount", this.defaultNobodySettings.CardsSleepBuyAmount)
            this.WriteToIni("CardsPermaLoop", this.defaultNobodySettings.CardsPermaLoop)
            this.WriteToIni("CardsBossFarmEnabled", this.defaultNobodySettings.CardsBossFarmEnabled)
            this.WriteToIni("GFSSFarmUseGrav", this.defaultNobodySettings.GFSSFarmUseGrav)
            this.WriteToIni("GFSSFarmUseWind", this.defaultNobodySettings.GFSSFarmUseWind)
            this.WriteToIni("GFToKillPerCycle", this.defaultNobodySettings.GFToKillPerCycle)
            this.WriteToIni("SSToKillPerCycle", this.defaultNobodySettings.SSToKillPerCycle)
            this.WriteToIni("GemFarmSleepAmount", this.defaultNobodySettings.GemFarmSleepAmount)
            this.WriteToIni("ClawCheckSizeOffset", this.defaultNobodySettings.ClawCheckSizeOffset)
            this.WriteToIni("BVItemsArr", this.defaultNobodySettings.BVItemsArr)
            this.WriteToIni("QuarkFarmResetToBoss", this.defaultNobodySettings.QuarkFarmResetToBoss)
            this.WriteToIni("NavigateTime", this.defaultNobodySettings.NavigateTime)
            this.WriteToIni("DisableZoneChecks", this.defaultNobodySettings.DisableZoneChecks)
            this.WriteToIni("DisableSettingsChecks", this.defaultNobodySettings.DisableSettingsChecks)
            this.WriteToIni("ArtifactSleepAmount", this.defaultNobodySettings.ArtifactSleepAmount)
            this.WriteToIni("F9UsesWind", this.defaultNobodySettings.F9UsesWind)
            this.WriteToIni("F9UsesWobblyWings", this.defaultNobodySettings.F9UsesWobblyWings)
            this.WriteToIni("WobblyWingsSleepAmount", this.defaultNobodySettings.WobblyWingsSleepAmount)
        } else {
            this.WriteToIni("EnableLogging", this.defaultSettings.EnableLogging)
            this.WriteToIni("HaveBorbDLC", this.defaultSettings.HaveBorbDLC)
            this.WriteToIni("CardsCommonAmount", this.defaultSettings.CardsCommonAmount)
            this.WriteToIni("CardsRareAmount", this.defaultSettings.CardsRareAmount)
            this.WriteToIni("CardsLegendaryAmount", this.defaultSettings.CardsLegendaryAmount)
            this.WriteToIni("CardsDontOpenCommons", this.defaultSettings.CardsDontOpenCommons)
            this.WriteToIni("CardsDontOpenRare", this.defaultSettings.CardsDontOpenRare)
            this.WriteToIni("CardsDontOpenLegendary", this.defaultSettings.CardsDontOpenLegendary)
            this.WriteToIni("CardsSleepAmount", this.defaultSettings.CardsSleepAmount)
            this.WriteToIni("CardsBuyEnabled", this.defaultSettings.CardsBuyEnabled)
            this.WriteToIni("CardsBuyStyle", this.defaultSettings.CardsBuyStyle)
            this.WriteToIni("CardsCommonBuyAmount", this.defaultSettings.CardsCommonBuyAmount)
            this.WriteToIni("CardsRareBuyAmount", this.defaultSettings.CardsRareBuyAmount)
            this.WriteToIni("CardsLegBuyAmount", this.defaultSettings.CardsLegBuyAmount)
            this.WriteToIni("CardsDontBuyCommons", this.defaultSettings.CardsDontBuyCommons)
            this.WriteToIni("CardsDontBuyRare", this.defaultSettings.CardsDontBuyRare)
            this.WriteToIni("CardsDontBuyLeg", this.defaultSettings.CardsDontBuyLeg)
            this.WriteToIni("CardsSleepBuyAmount", this.defaultSettings.CardsSleepBuyAmount)
            this.WriteToIni("CardsPermaLoop", this.defaultSettings.CardsPermaLoop)
            this.WriteToIni("CardsBossFarmEnabled", this.defaultSettings.CardsBossFarmEnabled)
            this.WriteToIni("GFSSFarmUseGrav", this.defaultSettings.GFSSFarmUseGrav)
            this.WriteToIni("GFSSFarmUseWind", this.defaultSettings.GFSSFarmUseWind)
            this.WriteToIni("GFToKillPerCycle", this.defaultSettings.GFToKillPerCycle)
            this.WriteToIni("SSToKillPerCycle", this.defaultSettings.SSToKillPerCycle)
            this.WriteToIni("GemFarmSleepAmount", this.defaultSettings.GemFarmSleepAmount)
            this.WriteToIni("ClawCheckSizeOffset", this.defaultSettings.ClawCheckSizeOffset)
            this.WriteToIni("BVItemsArr", this.defaultSettings.BVItemsArr)
            this.WriteToIni("QuarkFarmResetToBoss", this.defaultSettings.QuarkFarmResetToBoss)
            this.WriteToIni("NavigateTime", this.defaultSettings.NavigateTime)
            this.WriteToIni("DisableZoneChecks", this.defaultSettings.DisableZoneChecks)
            this.WriteToIni("DisableSettingsChecks", this.defaultSettings.DisableSettingsChecks)
            this.WriteToIni("ArtifactSleepAmount", this.defaultSettings.ArtifactSleepAmount)
            this.WriteToIni("F9UsesWind", this.defaultSettings.F9UsesWind)
            this.WriteToIni("F9UsesWobblyWings", this.defaultSettings.F9UsesWobblyWings)
            this.WriteToIni("WobblyWingsSleepAmount", this.defaultSettings.WobblyWingsSleepAmount)

        }
        this.WriteToIni("Debug", "false", "Debug")
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