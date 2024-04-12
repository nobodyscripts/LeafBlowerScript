#Requires AutoHotkey v2.0

; ------------------- Settings -------------------
; Loads UserSettings.ini values for the rest of the script to use

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
    MinerEnableVeinUpgrade, MinerEnableVeinRemoval
global MinerEnableSphereUse, MinerSphereDelay, MinerSphereAmount,
    MinerSphereTimer

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
        CardsSleepAmount: 875,
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
        GFToKillPerCycle: 2,
        SSToKillPerCycle: 1,
        GFSSNoReset: "false",
        GemFarmSleepAmount: 72,
        ClawCheckSizeOffset: 0,
        BVItemsArr: "0x018C9C, 0x01D814, 0x0F2A1D, 0x6CD820, 0xC9C9C9",
        BVBlockMythLeg: "true",
        NavigateTime: 101,
        DisableZoneChecks: "false",
        DisableSettingsChecks: "false",
        ArtifactSleepAmount: 17,
        BossFarmUsesWind: "true",
        BossFarmUsesWobblyWings: "true",
        BossFarmUsesSeeds: "true",
        WobblyWingsSleepAmount: 750,
        HyacinthUseSlot: "All",
        HyacinthFarmBoss: "true",
        HyacinthUseFlower: "hyacinth",
        HyacinthUseSpheres: "false",
        HyacinthUseNextAvailableFlower: "false",
        HyacinthBanksEnabled: "true",
        BankEnableLGDeposit: "true",
        BankEnableSNDeposit: "true",
        BankEnableEBDeposit: "true",
        BankEnableFFDeposit: "true",
        BankEnableSRDeposit: "true",
        BankEnableQADeposit: "true",
        BankEnableStorageUpgrade: "false",
        BankRunsSpammer: "true",
        BankDepositTime: "5",
        LeaftonCraftEnabled: "true",
        LeaftonSpamsWind: "true",
        LeaftonBanksEnabled: "true",
        LeaftonRunOnceEnabled: "false",
        TowerPassiveBanksEnabled: "true",
        TowerPassiveCraftEnabled: "true",
        MinerEnableVeins: "true",
        MinerEnableTransmute: "true",
        MinerEnableFreeRefuel: "true",
        MinerEnableBanks: "true",
        MinerEnableSpammer: "true",
        MinerEnableVeinUpgrade: "false",
        MinerEnableVeinRemoval: "false",
        MinerEnableSphereUse: "false",
        MinerSphereDelay: 1000,
        MinerSphereAmount: 0,
        MinerSphereTimer: 1,
        MinerTransmuteTimer: 10,
        MinerRefuelTimer: 1
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
        CardsSleepAmount: 875,
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
        GFToKillPerCycle: 8,
        SSToKillPerCycle: 1,
        GFSSNoReset: "false",
        GemFarmSleepAmount: 101,
        ClawCheckSizeOffset: 0,
        BVItemsArr: "0x01D814, 0xC9C9C9, 0xF91FF6",
        BVBlockMythLeg: "false",
        NavigateTime: 101,
        DisableZoneChecks: "false",
        DisableSettingsChecks: "false",
        ArtifactSleepAmount: 74,
        BossFarmUsesWind: "true",
        BossFarmUsesWobblyWings: "false",
        BossFarmUsesSeeds: "false",
        WobblyWingsSleepAmount: 750,
        HyacinthUseSlot: "All",
        HyacinthFarmBoss: "true",
        HyacinthUseFlower: "hyacinth",
        HyacinthUseSpheres: "false",
        HyacinthUseNextAvailableFlower: "false",
        HyacinthBanksEnabled: "true",
        BankEnableLGDeposit: "true",
        BankEnableSNDeposit: "true",
        BankEnableEBDeposit: "true",
        BankEnableFFDeposit: "true",
        BankEnableSRDeposit: "true",
        BankEnableQADeposit: "true",
        BankEnableStorageUpgrade: "false",
        BankRunsSpammer: "true",
        BankDepositTime: "5",
        LeaftonCraftEnabled: "true",
        LeaftonSpamsWind: "true",
        LeaftonBanksEnabled: "true",
        LeaftonRunOnceEnabled: "false",
        TowerPassiveBanksEnabled: "true",
        TowerPassiveCraftEnabled: "true",
        MinerEnableVeins: "true",
        MinerEnableTransmute: "true",
        MinerEnableFreeRefuel: "true",
        MinerEnableBanks: "true",
        MinerEnableSpammer: "true",
        MinerEnableVeinUpgrade: "false",
        MinerEnableVeinRemoval: "false",
        MinerEnableSphereUse: "false",
        MinerSphereDelay: 1000,
        MinerSphereAmount: 0,
        MinerSphereTimer: 1,
        MinerTransmuteTimer: 10,
        MinerRefuelTimer: 1
    }
    loadedSettings := {}
    /*
    __Init() {     } */

    initSettings(secondary := false) {
        global Debug
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
        global GFToKillPerCycle, SSToKillPerCycle, GFSSNoReset
        global GemFarmSleepAmount
        global ClawCheckSizeOffset
        global BVItemsArr, BVBlockMythLeg
        global NavigateTime
        global DisableZoneChecks, DisableSettingsChecks
        global ArtifactSleepAmount
        global BossFarmUsesWind, BossFarmUsesWobblyWings, WobblyWingsSleepAmount,
            BossFarmUsesSeeds
        global HyacinthUseSlot, HyacinthFarmBoss, HyacinthUseFlower,
            HyacinthUseSpheres, HyacinthUseNextAvailableFlower,
            HyacinthBanksEnabled

        global BankEnableLGDeposit, BankEnableSNDeposit, BankEnableEBDeposit
        global BankEnableFFDeposit, BankEnableSRDeposit, BankEnableQADeposit
        global BankRunsSpammer, BankDepositTime, BankEnableStorageUpgrade
        global LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled
        global LeaftonRunOnceEnabled
        global TowerPassiveBanksEnabled, TowerPassiveCraftEnabled

        global MinerEnableVeins, MinerEnableTransmute,
            MinerEnableFreeRefuel, MinerTransmuteTimer,
            MinerRefuelTimer, MinerEnableSpammer, MinerEnableBanks,
            MinerEnableVeinUpgrade, MinerEnableVeinRemoval
        global MinerEnableSphereUse, MinerSphereDelay,
            MinerSphereAmount, MinerSphereTimer

        try {
            EnableLogging := this.loadedSettings.EnableLogging :=
                IniToVar(this.sFilename, this.sFileSection, "EnableLogging")
            HaveBorbDLC := this.loadedSettings.HaveBorbDLC :=
                IniToVar(this.sFilename, "Borbventures", "HaveBorbDLC")
            CardsCommonAmount := this.loadedSettings.CardsCommonAmount :=
                IniToVar(this.sFilename, "Cards", "CardsCommonAmount")
            CardsRareAmount := this.loadedSettings.CardsRareAmount :=
                IniToVar(this.sFilename, "Cards", "CardsRareAmount")
            CardsLegendaryAmount := this.loadedSettings.CardsLegendaryAmount :=
                IniToVar(this.sFilename, "Cards", "CardsLegendaryAmount")
            CardsDontOpenCommons := this.loadedSettings.CardsDontOpenCommons :=
                IniToVar(this.sFilename, "Cards", "CardsDontOpenCommons")
            CardsDontOpenRare := this.loadedSettings.CardsDontOpenRare :=
                IniToVar(this.sFilename, "Cards", "CardsDontOpenRare")
            CardsDontOpenLegendary := this.loadedSettings.CardsDontOpenLegendary :=
                IniToVar(this.sFilename, "Cards", "CardsDontOpenLegendary")
            CardsSleepAmount := this.loadedSettings.CardsSleepAmount :=
                IniToVar(this.sFilename, "Cards", "CardsSleepAmount")
            CardsBuyEnabled := this.loadedSettings.CardsBuyEnabled :=
                IniToVar(this.sFilename, "CardsBuy", "CardsBuyEnabled")
            CardsBuyStyle := this.loadedSettings.CardsBuyStyle :=
                IniToVar(this.sFilename, "CardsBuy", "CardsBuyStyle")
            CardsCommonBuyAmount := this.loadedSettings.CardsCommonBuyAmount :=
                IniToVar(this.sFilename, "CardsBuy", "CardsCommonBuyAmount")
            CardsRareBuyAmount := this.loadedSettings.CardsRareBuyAmount :=
                IniToVar(this.sFilename, "CardsBuy", "CardsRareBuyAmount")
            CardsLegBuyAmount := this.loadedSettings.CardsLegBuyAmount :=
                IniToVar(this.sFilename, "CardsBuy", "CardsLegBuyAmount")
            CardsDontBuyCommons := this.loadedSettings.CardsDontBuyCommons :=
                IniToVar(this.sFilename, "CardsBuy", "CardsDontBuyCommons")
            CardsDontBuyRare := this.loadedSettings.CardsDontBuyRare :=
                IniToVar(this.sFilename, "CardsBuy", "CardsDontBuyRare")
            CardsDontBuyLeg := this.loadedSettings.CardsDontBuyLeg :=
                IniToVar(this.sFilename, "CardsBuy", "CardsDontBuyLeg")
            CardsSleepBuyAmount := this.loadedSettings.CardsSleepBuyAmount :=
                IniToVar(this.sFilename, "CardsBuy", "CardsSleepBuyAmount")
            CardsPermaLoop := this.loadedSettings.CardsPermaLoop :=
                IniToVar(this.sFilename, "Cards", "CardsPermaLoop")
            CardsBossFarmEnabled := this.loadedSettings.CardsBossFarmEnabled :=
                IniToVar(this.sFilename, "Cards", "CardsBossFarmEnabled")
            GFToKillPerCycle := this.loadedSettings.GFToKillPerCycle :=
                IniToVar(this.sFilename, "SSFarm", "GFToKillPerCycle")
            SSToKillPerCycle := this.loadedSettings.SSToKillPerCycle :=
                IniToVar(this.sFilename, "SSFarm", "SSToKillPerCycle")
            GFSSNoReset := this.loadedSettings.GFSSNoReset :=
                IniToVar(this.sFilename, "SSFarm", "GFSSNoReset")
            GemFarmSleepAmount := this.loadedSettings.GemFarmSleepAmount :=
                IniToVar(this.sFilename, "GemFarm", "GemFarmSleepAmount")
            ClawCheckSizeOffset := this.loadedSettings.ClawCheckSizeOffset :=
                IniToVar(this.sFilename, "Claw", "ClawCheckSizeOffset")
            BVItemsArr := this.loadedSettings.BVItemsArr :=
                StrSplit(IniToVar(this.sFilename, "Borbventures", "BVItemsArr"), " ", ",.")
            BVBlockMythLeg := this.loadedSettings.BVBlockMythLeg :=
                IniToVar(this.sFilename, "Borbventures", "BVBlockMythLeg")
            NavigateTime := this.loadedSettings.NavigateTime :=
                IniToVar(this.sFilename, this.sFileSection, "NavigateTime")
            DisableZoneChecks := this.loadedSettings.DisableZoneChecks :=
                IniToVar(this.sFilename, this.sFileSection, "DisableZoneChecks")
            DisableSettingsChecks := this.loadedSettings.DisableSettingsChecks :=
                IniToVar(this.sFilename, this.sFileSection, "DisableSettingsChecks")
            ArtifactSleepAmount := this.loadedSettings.ArtifactSleepAmount :=
                IniToVar(this.sFilename, "BossFarm", "ArtifactSleepAmount")
            BossFarmUsesWind := this.loadedSettings.BossFarmUsesWind :=
                IniToVar(this.sFilename, "BossFarm", "BossFarmUsesWind")
            BossFarmUsesWobblyWings := this.loadedSettings.BossFarmUsesWobblyWings :=
                IniToVar(this.sFilename, "BossFarm", "BossFarmUsesWobblyWings")
            BossFarmUsesSeeds := this.loadedSettings.BossFarmUsesSeeds :=
                IniToVar(this.sFilename, "BossFarm", "BossFarmUsesSeeds")
            WobblyWingsSleepAmount := this.loadedSettings.WobblyWingsSleepAmount :=
                IniToVar(this.sFilename, "BossFarm", "WobblyWingsSleepAmount")
            HyacinthUseSlot := this.loadedSettings.HyacinthUseSlot :=
                IniToVar(this.sFilename, "NatureFarm", "HyacinthUseSlot")
            HyacinthFarmBoss := this.loadedSettings.HyacinthFarmBoss :=
                IniToVar(this.sFilename, "NatureFarm", "HyacinthFarmBoss")
            HyacinthUseFlower := this.loadedSettings.HyacinthUseFlower :=
                IniToVar(this.sFilename, "NatureFarm", "HyacinthUseFlower")
            HyacinthUseSpheres := this.loadedSettings.HyacinthUseSpheres :=
                IniToVar(this.sFilename, "NatureFarm", "HyacinthUseSpheres")
            HyacinthUseNextAvailableFlower := this.loadedSettings.HyacinthUseNextAvailableFlower :=
                IniToVar(this.sFilename, "NatureFarm", "HyacinthUseNextAvailableFlower")
            HyacinthBanksEnabled := this.loadedSettings.HyacinthBanksEnabled :=
                IniToVar(this.sFilename, "NatureFarm", "HyacinthBanksEnabled")
            BankEnableLGDeposit := this.loadedSettings.BankEnableLGDeposit :=
                IniToVar(this.sFilename, "Bank", "BankEnableLGDeposit")
            BankEnableSNDeposit := this.loadedSettings.BankEnableSNDeposit :=
                IniToVar(this.sFilename, "Bank", "BankEnableSNDeposit")
            BankEnableEBDeposit := this.loadedSettings.BankEnableEBDeposit :=
                IniToVar(this.sFilename, "Bank", "BankEnableEBDeposit")
            BankEnableFFDeposit := this.loadedSettings.BankEnableFFDeposit :=
                IniToVar(this.sFilename, "Bank", "BankEnableFFDeposit")
            BankEnableSRDeposit := this.loadedSettings.BankEnableSRDeposit :=
                IniToVar(this.sFilename, "Bank", "BankEnableSRDeposit")
            BankEnableQADeposit := this.loadedSettings.BankEnableQADeposit :=
                IniToVar(this.sFilename, "Bank", "BankEnableQADeposit")
            BankEnableStorageUpgrade := this.loadedSettings.BankEnableStorageUpgrade :=
                IniToVar(this.sFilename, "Bank", "BankEnableStorageUpgrade")
            BankRunsSpammer := this.loadedSettings.BankRunsSpammer :=
                IniToVar(this.sFilename, "Bank", "BankRunsSpammer")
            BankDepositTime := this.loadedSettings.BankDepositTime :=
                IniToVar(this.sFilename, "Bank", "BankDepositTime")
            LeaftonCraftEnabled := this.loadedSettings.LeaftonCraftEnabled :=
                IniToVar(this.sFilename, "Leafton", "LeaftonCraftEnabled")
            LeaftonSpamsWind := this.loadedSettings.LeaftonSpamsWind :=
                IniToVar(this.sFilename, "Leafton", "LeaftonSpamsWind")
            LeaftonBanksEnabled := this.loadedSettings.LeaftonBanksEnabled :=
                IniToVar(this.sFilename, "Leafton", "LeaftonBanksEnabled")
            LeaftonRunOnceEnabled := this.loadedSettings.LeaftonRunOnceEnabled :=
                IniToVar(this.sFilename, "Leafton", "LeaftonRunOnceEnabled")
            TowerPassiveBanksEnabled := this.loadedSettings.TowerPassiveBanksEnabled :=
                IniToVar(this.sFilename, "TowerPassive", "TowerPassiveBanksEnabled")
            TowerPassiveCraftEnabled := this.loadedSettings.TowerPassiveCraftEnabled :=
                IniToVar(this.sFilename, "TowerPassive", "TowerPassiveCraftEnabled")
            MinerEnableVeins := this.loadedSettings.MinerEnableVeins :=
                IniToVar(this.sFilename, "Miner", "MinerEnableVeins")
            MinerEnableVeinRemoval := this.loadedSettings.MinerEnableVeinRemoval :=
                IniToVar(this.sFilename, "Miner", "MinerEnableVeinRemoval")
            MinerEnableTransmute := this.loadedSettings.MinerEnableTransmute :=
                IniToVar(this.sFilename, "Miner", "MinerEnableTransmute")
            MinerEnableFreeRefuel := this.loadedSettings.MinerEnableFreeRefuel :=
                IniToVar(this.sFilename, "Miner", "MinerEnableFreeRefuel")
            MinerEnableBanks := this.loadedSettings.MinerEnableBanks :=
                IniToVar(this.sFilename, "Miner", "MinerEnableBanks")
            MinerEnableSpammer := this.loadedSettings.MinerEnableSpammer :=
                IniToVar(this.sFilename, "Miner", "MinerEnableSpammer")
            MinerEnableVeinUpgrade := this.loadedSettings.MinerEnableVeinUpgrade :=
                IniToVar(this.sFilename, "Miner", "MinerEnableVeinUpgrade")
            MinerTransmuteTimer := this.loadedSettings.MinerTransmuteTimer :=
                IniToVar(this.sFilename, "Miner", "MinerTransmuteTimer")
            MinerRefuelTimer := this.loadedSettings.MinerRefuelTimer :=
                IniToVar(this.sFilename, "Miner", "MinerRefuelTimer")
            MinerEnableSphereUse := this.loadedSettings.MinerEnableSphereUse :=
                IniToVar(this.sFilename, "Miner", "MinerEnableSphereUse")
            MinerSphereDelay := this.loadedSettings.MinerSphereDelay :=
                IniToVar(this.sFilename, "Miner", "MinerSphereDelay")
            MinerSphereAmount := this.loadedSettings.MinerSphereAmount :=
                IniToVar(this.sFilename, "Miner", "MinerSphereAmount")
            MinerSphereTimer := this.loadedSettings.MinerSphereTimer :=
                IniToVar(this.sFilename, "Miner", "MinerSphereTimer")

            Debug := IniToVar(this.sFilename, "Debug", "Debug")
        } catch as exc {
            if (exc.Extra) {
                Log("Error 35: LoadSettings failed - " exc.Message "`n" exc.Extra)
            } else {
                Log("Error 35: LoadSettings failed - " exc.Message)
            }
            MsgBox("Could not load all settings, making new default UserSettings.ini")
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
        global Debug
        if (this.sUseNobody) {
            this.WriteToIni("EnableLogging", this.defaultNobodySettings.EnableLogging)
            this.WriteToIni("HaveBorbDLC", this.defaultNobodySettings.HaveBorbDLC, "Borbventures")
            this.WriteToIni("CardsCommonAmount", this.defaultNobodySettings.CardsCommonAmount, "Cards")
            this.WriteToIni("CardsRareAmount", this.defaultNobodySettings.CardsRareAmount, "Cards")
            this.WriteToIni("CardsLegendaryAmount", this.defaultNobodySettings.CardsLegendaryAmount, "Cards")
            this.WriteToIni("CardsDontOpenCommons", this.defaultNobodySettings.CardsDontOpenCommons, "Cards")
            this.WriteToIni("CardsDontOpenRare", this.defaultNobodySettings.CardsDontOpenRare, "Cards")
            this.WriteToIni("CardsDontOpenLegendary", this.defaultNobodySettings.CardsDontOpenLegendary, "Cards")
            this.WriteToIni("CardsSleepAmount", this.defaultNobodySettings.CardsSleepAmount, "Cards")
            this.WriteToIni("CardsBuyEnabled", this.defaultNobodySettings.CardsBuyEnabled, "CardsBuy")
            this.WriteToIni("CardsBuyStyle", this.defaultNobodySettings.CardsBuyStyle, "CardsBuy")
            this.WriteToIni("CardsCommonBuyAmount", this.defaultNobodySettings.CardsCommonBuyAmount, "CardsBuy")
            this.WriteToIni("CardsRareBuyAmount", this.defaultNobodySettings.CardsRareBuyAmount, "CardsBuy")
            this.WriteToIni("CardsLegBuyAmount", this.defaultNobodySettings.CardsLegBuyAmount, "CardsBuy")
            this.WriteToIni("CardsDontBuyCommons", this.defaultNobodySettings.CardsDontBuyCommons, "CardsBuy")
            this.WriteToIni("CardsDontBuyRare", this.defaultNobodySettings.CardsDontBuyRare, "CardsBuy")
            this.WriteToIni("CardsDontBuyLeg", this.defaultNobodySettings.CardsDontBuyLeg, "CardsBuy")
            this.WriteToIni("CardsSleepBuyAmount", this.defaultNobodySettings.CardsSleepBuyAmount, "CardsBuy")
            this.WriteToIni("CardsPermaLoop", this.defaultNobodySettings.CardsPermaLoop, "Cards")
            this.WriteToIni("CardsBossFarmEnabled", this.defaultNobodySettings.CardsBossFarmEnabled, "Cards")
            this.WriteToIni("GFToKillPerCycle", this.defaultNobodySettings.GFToKillPerCycle, "SSFarm")
            this.WriteToIni("SSToKillPerCycle", this.defaultNobodySettings.SSToKillPerCycle, "SSFarm")
            this.WriteToIni("GFSSNoReset", this.defaultNobodySettings.GFSSNoReset, "SSFarm")
            this.WriteToIni("GemFarmSleepAmount", this.defaultNobodySettings.GemFarmSleepAmount, "GemFarm")
            this.WriteToIni("ClawCheckSizeOffset", this.defaultNobodySettings.ClawCheckSizeOffset, "Claw")
            this.WriteToIni("BVItemsArr", this.defaultNobodySettings.BVItemsArr, "Borbventures")
            this.WriteToIni("BVBlockMythLeg", this.defaultNobodySettings.BVBlockMythLeg, "Borbventures")
            this.WriteToIni("NavigateTime", this.defaultNobodySettings.NavigateTime)
            this.WriteToIni("DisableZoneChecks", this.defaultNobodySettings.DisableZoneChecks)
            this.WriteToIni("DisableSettingsChecks", this.defaultNobodySettings.DisableSettingsChecks)
            this.WriteToIni("ArtifactSleepAmount", this.defaultNobodySettings.ArtifactSleepAmount, "BossFarm")
            this.WriteToIni("BossFarmUsesWind", this.defaultNobodySettings.BossFarmUsesWind, "BossFarm")
            this.WriteToIni("BossFarmUsesWobblyWings", this.defaultNobodySettings.BossFarmUsesWobblyWings, "BossFarm")
            this.WriteToIni("BossFarmUsesSeeds", this.defaultNobodySettings.BossFarmUsesSeeds, "BossFarm")
            this.WriteToIni("WobblyWingsSleepAmount", this.defaultNobodySettings.WobblyWingsSleepAmount, "BossFarm")
            this.WriteToIni("HyacinthUseSlot", this.defaultNobodySettings.HyacinthUseSlot, "NatureFarm")
            this.WriteToIni("HyacinthFarmBoss", this.defaultNobodySettings.HyacinthFarmBoss, "NatureFarm")
            this.WriteToIni("HyacinthUseFlower", this.defaultNobodySettings.HyacinthUseFlower, "NatureFarm")
            this.WriteToIni("HyacinthUseSpheres", this.defaultNobodySettings.HyacinthUseSpheres, "NatureFarm")
            this.WriteToIni("HyacinthUseNextAvailableFlower", this.defaultNobodySettings.HyacinthUseNextAvailableFlower, "NatureFarm")
            this.WriteToIni("HyacinthBanksEnabled", this.defaultNobodySettings.HyacinthBanksEnabled, "NatureFarm")
            this.WriteToIni("BankEnableLGDeposit", this.defaultNobodySettings.BankEnableLGDeposit, "Bank")
            this.WriteToIni("BankEnableSNDeposit", this.defaultNobodySettings.BankEnableSNDeposit, "Bank")
            this.WriteToIni("BankEnableEBDeposit", this.defaultNobodySettings.BankEnableEBDeposit, "Bank")
            this.WriteToIni("BankEnableFFDeposit", this.defaultNobodySettings.BankEnableFFDeposit, "Bank")
            this.WriteToIni("BankEnableSRDeposit", this.defaultNobodySettings.BankEnableSRDeposit, "Bank")
            this.WriteToIni("BankEnableQADeposit", this.defaultNobodySettings.BankEnableQADeposit, "Bank")
            this.WriteToIni("BankEnableStorageUpgrade", this.defaultNobodySettings.BankEnableStorageUpgrade, "Bank")
            this.WriteToIni("BankRunsSpammer", this.defaultNobodySettings.BankRunsSpammer, "Bank")
            this.WriteToIni("BankDepositTime", this.defaultNobodySettings.BankDepositTime, "Bank")
            this.WriteToIni("LeaftonCraftEnabled", this.defaultNobodySettings.LeaftonCraftEnabled, "Leafton")
            this.WriteToIni("LeaftonSpamsWind", this.defaultNobodySettings.LeaftonSpamsWind, "Leafton")
            this.WriteToIni("LeaftonBanksEnabled", this.defaultNobodySettings.LeaftonBanksEnabled, "Leafton")
            this.WriteToIni("LeaftonRunOnceEnabled", this.defaultNobodySettings.LeaftonRunOnceEnabled, "Leafton")
            this.WriteToIni("TowerPassiveBanksEnabled", this.defaultNobodySettings.TowerPassiveBanksEnabled, "TowerPassive")
            this.WriteToIni("TowerPassiveCraftEnabled", this.defaultNobodySettings.TowerPassiveCraftEnabled, "TowerPassive")
            this.WriteToIni("MinerEnableVeins", this.defaultNobodySettings.MinerEnableVeins, "Miner")
            this.WriteToIni("MinerEnableVeinRemoval", this.defaultNobodySettings.MinerEnableVeinRemoval, "Miner")
            this.WriteToIni("MinerEnableTransmute", this.defaultNobodySettings.MinerEnableTransmute, "Miner")
            this.WriteToIni("MinerEnableFreeRefuel", this.defaultNobodySettings.MinerEnableFreeRefuel, "Miner")
            this.WriteToIni("MinerEnableBanks", this.defaultNobodySettings.MinerEnableBanks, "Miner")
            this.WriteToIni("MinerEnableSpammer", this.defaultNobodySettings.MinerEnableSpammer, "Miner")
            this.WriteToIni("MinerEnableVeinUpgrade", this.defaultNobodySettings.MinerEnableVeinUpgrade, "Miner")
            this.WriteToIni("MinerEnableSphereUse", this.defaultNobodySettings.MinerEnableSphereUse, "Miner")
            this.WriteToIni("MinerSphereDelay", this.defaultNobodySettings.MinerSphereDelay, "Miner")
            this.WriteToIni("MinerSphereAmount", this.defaultNobodySettings.MinerSphereAmount, "Miner")
            this.WriteToIni("MinerSphereTimer", this.defaultNobodySettings.MinerSphereTimer, "Miner")
            this.WriteToIni("MinerTransmuteTimer", this.defaultNobodySettings.MinerTransmuteTimer, "Miner")
            this.WriteToIni("MinerRefuelTimer", this.defaultNobodySettings.MinerRefuelTimer, "Miner")
        } else {
            this.WriteToIni("EnableLogging", this.defaultSettings.EnableLogging)
            this.WriteToIni("HaveBorbDLC", this.defaultSettings.HaveBorbDLC, "Borbventures")
            this.WriteToIni("CardsCommonAmount", this.defaultSettings.CardsCommonAmount, "Cards")
            this.WriteToIni("CardsRareAmount", this.defaultSettings.CardsRareAmount, "Cards")
            this.WriteToIni("CardsLegendaryAmount", this.defaultSettings.CardsLegendaryAmount, "Cards")
            this.WriteToIni("CardsDontOpenCommons", this.defaultSettings.CardsDontOpenCommons, "Cards")
            this.WriteToIni("CardsDontOpenRare", this.defaultSettings.CardsDontOpenRare, "Cards")
            this.WriteToIni("CardsDontOpenLegendary", this.defaultSettings.CardsDontOpenLegendary, "Cards")
            this.WriteToIni("CardsSleepAmount", this.defaultSettings.CardsSleepAmount, "Cards")
            this.WriteToIni("CardsBuyEnabled", this.defaultSettings.CardsBuyEnabled, "CardsBuy")
            this.WriteToIni("CardsBuyStyle", this.defaultSettings.CardsBuyStyle, "CardsBuy")
            this.WriteToIni("CardsCommonBuyAmount", this.defaultSettings.CardsCommonBuyAmount, "CardsBuy")
            this.WriteToIni("CardsRareBuyAmount", this.defaultSettings.CardsRareBuyAmount, "CardsBuy")
            this.WriteToIni("CardsLegBuyAmount", this.defaultSettings.CardsLegBuyAmount, "CardsBuy")
            this.WriteToIni("CardsDontBuyCommons", this.defaultSettings.CardsDontBuyCommons, "CardsBuy")
            this.WriteToIni("CardsDontBuyRare", this.defaultSettings.CardsDontBuyRare, "CardsBuy")
            this.WriteToIni("CardsDontBuyLeg", this.defaultSettings.CardsDontBuyLeg, "CardsBuy")
            this.WriteToIni("CardsSleepBuyAmount", this.defaultSettings.CardsSleepBuyAmount, "CardsBuy")
            this.WriteToIni("CardsPermaLoop", this.defaultSettings.CardsPermaLoop, "Cards")
            this.WriteToIni("CardsBossFarmEnabled", this.defaultSettings.CardsBossFarmEnabled, "Cards")
            this.WriteToIni("GFToKillPerCycle", this.defaultSettings.GFToKillPerCycle, "SSFarm")
            this.WriteToIni("SSToKillPerCycle", this.defaultSettings.SSToKillPerCycle, "SSFarm")
            this.WriteToIni("GFSSNoReset", this.defaultSettings.GFSSNoReset, "SSFarm")
            this.WriteToIni("GemFarmSleepAmount", this.defaultSettings.GemFarmSleepAmount, "GemFarm")
            this.WriteToIni("ClawCheckSizeOffset", this.defaultSettings.ClawCheckSizeOffset, "Claw")
            this.WriteToIni("BVItemsArr", this.defaultSettings.BVItemsArr, "Borbventures")
            this.WriteToIni("BVBlockMythLeg", this.defaultSettings.BVBlockMythLeg, "Borbventures")
            this.WriteToIni("NavigateTime", this.defaultSettings.NavigateTime)
            this.WriteToIni("DisableZoneChecks", this.defaultSettings.DisableZoneChecks)
            this.WriteToIni("DisableSettingsChecks", this.defaultSettings.DisableSettingsChecks)
            this.WriteToIni("ArtifactSleepAmount", this.defaultSettings.ArtifactSleepAmount, "BossFarm")
            this.WriteToIni("BossFarmUsesWind", this.defaultSettings.BossFarmUsesWind, "BossFarm")
            this.WriteToIni("BossFarmUsesWobblyWings", this.defaultSettings.BossFarmUsesWobblyWings, "BossFarm")
            this.WriteToIni("BossFarmUsesSeeds", this.defaultSettings.BossFarmUsesSeeds, "BossFarm")
            this.WriteToIni("WobblyWingsSleepAmount", this.defaultSettings.WobblyWingsSleepAmount, "BossFarm")
            this.WriteToIni("HyacinthUseSlot", this.defaultSettings.HyacinthUseSlot, "NatureFarm")
            this.WriteToIni("HyacinthFarmBoss", this.defaultSettings.HyacinthFarmBoss, "NatureFarm")
            this.WriteToIni("HyacinthUseFlower", this.defaultSettings.HyacinthUseFlower, "NatureFarm")
            this.WriteToIni("HyacinthUseSpheres", this.defaultSettings.HyacinthUseSpheres, "NatureFarm")
            this.WriteToIni("HyacinthUseNextAvailableFlower", this.defaultSettings.HyacinthUseNextAvailableFlower, "NatureFarm")
            this.WriteToIni("HyacinthBanksEnabled", this.defaultSettings.HyacinthBanksEnabled, "NatureFarm")
            this.WriteToIni("BankEnableLGDeposit", this.defaultSettings.BankEnableLGDeposit, "Bank")
            this.WriteToIni("BankEnableSNDeposit", this.defaultSettings.BankEnableSNDeposit, "Bank")
            this.WriteToIni("BankEnableEBDeposit", this.defaultSettings.BankEnableEBDeposit, "Bank")
            this.WriteToIni("BankEnableFFDeposit", this.defaultSettings.BankEnableFFDeposit, "Bank")
            this.WriteToIni("BankEnableSRDeposit", this.defaultSettings.BankEnableSRDeposit, "Bank")
            this.WriteToIni("BankEnableQADeposit", this.defaultSettings.BankEnableQADeposit, "Bank")
            this.WriteToIni("BankEnableStorageUpgrade", this.defaultSettings.BankEnableStorageUpgrade, "Bank")
            this.WriteToIni("BankRunsSpammer", this.defaultSettings.BankRunsSpammer, "Bank")
            this.WriteToIni("BankDepositTime", this.defaultSettings.BankDepositTime, "Bank")
            this.WriteToIni("LeaftonCraftEnabled", this.defaultSettings.LeaftonCraftEnabled, "Leafton")
            this.WriteToIni("LeaftonSpamsWind", this.defaultSettings.LeaftonSpamsWind, "Leafton")
            this.WriteToIni("LeaftonBanksEnabled", this.defaultSettings.LeaftonBanksEnabled, "Leafton")
            this.WriteToIni("LeaftonRunOnceEnabled", this.defaultSettings.LeaftonRunOnceEnabled, "Leafton")
            this.WriteToIni("TowerPassiveBanksEnabled", this.defaultSettings.TowerPassiveBanksEnabled, "TowerPassive")
            this.WriteToIni("TowerPassiveCraftEnabled", this.defaultSettings.TowerPassiveCraftEnabled, "TowerPassive")
            this.WriteToIni("MinerEnableVeins", this.defaultSettings.MinerEnableVeins, "Miner")
            this.WriteToIni("MinerEnableVeinRemoval", this.defaultSettings.MinerEnableVeinRemoval, "Miner")
            this.WriteToIni("MinerEnableTransmute", this.defaultSettings.MinerEnableTransmute, "Miner")
            this.WriteToIni("MinerEnableFreeRefuel", this.defaultSettings.MinerEnableFreeRefuel, "Miner")
            this.WriteToIni("MinerEnableBanks", this.defaultSettings.MinerEnableBanks, "Miner")
            this.WriteToIni("MinerEnableSpammer", this.defaultSettings.MinerEnableSpammer, "Miner")
            this.WriteToIni("MinerEnableVeinUpgrade", this.defaultSettings.MinerEnableVeinUpgrade, "Miner")
            this.WriteToIni("MinerEnableSphereUse", this.defaultSettings.MinerEnableSphereUse, "Miner")
            this.WriteToIni("MinerSphereDelay", this.defaultSettings.MinerSphereDelay, "Miner")
            this.WriteToIni("MinerSphereAmount", this.defaultSettings.MinerSphereAmount, "Miner")
            this.WriteToIni("MinerSphereTimer", this.defaultSettings.MinerSphereTimer, "Miner")
            this.WriteToIni("MinerTransmuteTimer", this.defaultSettings.MinerTransmuteTimer, "Miner")
            this.WriteToIni("MinerRefuelTimer", this.defaultSettings.MinerRefuelTimer, "Miner")
        }
        this.WriteToIni("Debug", BinaryToStr(Debug), "Debug")
    }

    SaveCurrentSettings() {
        global Debug
        this.WriteToIni("EnableLogging", BinaryToStr(EnableLogging))
        this.WriteToIni("HaveBorbDLC", BinaryToStr(HaveBorbDLC), "Borbventures")
        this.WriteToIni("CardsCommonAmount", CardsCommonAmount, "Cards")
        this.WriteToIni("CardsRareAmount", CardsRareAmount, "Cards")
        this.WriteToIni("CardsLegendaryAmount", CardsLegendaryAmount, "Cards")
        this.WriteToIni("CardsDontOpenCommons", BinaryToStr(CardsDontOpenCommons), "Cards")
        this.WriteToIni("CardsDontOpenRare", BinaryToStr(CardsDontOpenRare), "Cards")
        this.WriteToIni("CardsDontOpenLegendary", BinaryToStr(CardsDontOpenLegendary), "Cards")
        this.WriteToIni("CardsSleepAmount", CardsSleepAmount, "Cards")
        this.WriteToIni("CardsBuyEnabled", BinaryToStr(CardsBuyEnabled), "CardsBuy")
        this.WriteToIni("CardsBuyStyle", CardsBuyStyle, "CardsBuy")
        this.WriteToIni("CardsCommonBuyAmount", CardsCommonBuyAmount, "CardsBuy")
        this.WriteToIni("CardsRareBuyAmount", CardsRareBuyAmount, "CardsBuy")
        this.WriteToIni("CardsLegBuyAmount", CardsLegBuyAmount, "CardsBuy")
        this.WriteToIni("CardsDontBuyCommons", BinaryToStr(CardsDontBuyCommons), "CardsBuy")
        this.WriteToIni("CardsDontBuyRare", BinaryToStr(CardsDontBuyRare), "CardsBuy")
        this.WriteToIni("CardsDontBuyLeg", BinaryToStr(CardsDontBuyLeg), "CardsBuy")
        this.WriteToIni("CardsSleepBuyAmount", CardsSleepBuyAmount, "CardsBuy")
        this.WriteToIni("CardsPermaLoop", BinaryToStr(CardsPermaLoop), "Cards")
        this.WriteToIni("CardsBossFarmEnabled", BinaryToStr(CardsBossFarmEnabled), "Cards")
        this.WriteToIni("GFToKillPerCycle", GFToKillPerCycle, "SSFarm")
        this.WriteToIni("SSToKillPerCycle", SSToKillPerCycle, "SSFarm")
        this.WriteToIni("GFSSNoReset", BinaryToStr(GFSSNoReset), "SSFarm")
        this.WriteToIni("GemFarmSleepAmount", GemFarmSleepAmount, "GemFarm")
        this.WriteToIni("ClawCheckSizeOffset", ClawCheckSizeOffset, "Claw")
        this.WriteToIni("BVItemsArr", ArrToCommaDelimStr(BVItemsArr), "Borbventures")
        this.WriteToIni("BVBlockMythLeg", BinaryToStr(BVBlockMythLeg), "Borbventures")
        this.WriteToIni("NavigateTime", NavigateTime)
        this.WriteToIni("DisableZoneChecks", BinaryToStr(DisableZoneChecks))
        this.WriteToIni("DisableSettingsChecks", BinaryToStr(DisableSettingsChecks))
        this.WriteToIni("ArtifactSleepAmount", ArtifactSleepAmount, "BossFarm")
        this.WriteToIni("BossFarmUsesWind", BinaryToStr(BossFarmUsesWind), "BossFarm")
        this.WriteToIni("BossFarmUsesWobblyWings", BinaryToStr(BossFarmUsesWobblyWings), "BossFarm")
        this.WriteToIni("BossFarmUsesSeeds", BinaryToStr(BossFarmUsesSeeds), "BossFarm")
        this.WriteToIni("WobblyWingsSleepAmount", WobblyWingsSleepAmount, "BossFarm")
        this.WriteToIni("HyacinthUseSlot", HyacinthUseSlot, "NatureFarm")
        this.WriteToIni("HyacinthFarmBoss", BinaryToStr(HyacinthFarmBoss), "NatureFarm")
        this.WriteToIni("HyacinthUseFlower", HyacinthUseFlower, "NatureFarm")
        this.WriteToIni("HyacinthUseSpheres", BinaryToStr(HyacinthUseSpheres), "NatureFarm")
        this.WriteToIni("HyacinthUseNextAvailableFlower", BinaryToStr(HyacinthUseNextAvailableFlower), "NatureFarm")
        this.WriteToIni("HyacinthBanksEnabled", BinaryToStr(HyacinthBanksEnabled), "NatureFarm")
        this.WriteToIni("BankEnableLGDeposit", BinaryToStr(BankEnableLGDeposit), "Bank")
        this.WriteToIni("BankEnableSNDeposit", BinaryToStr(BankEnableSNDeposit), "Bank")
        this.WriteToIni("BankEnableEBDeposit", BinaryToStr(BankEnableEBDeposit), "Bank")
        this.WriteToIni("BankEnableFFDeposit", BinaryToStr(BankEnableFFDeposit), "Bank")
        this.WriteToIni("BankEnableSRDeposit", BinaryToStr(BankEnableSRDeposit), "Bank")
        this.WriteToIni("BankEnableQADeposit", BinaryToStr(BankEnableQADeposit), "Bank")
        this.WriteToIni("BankEnableStorageUpgrade", BinaryToStr(BankEnableStorageUpgrade), "Bank")
        this.WriteToIni("BankRunsSpammer", BinaryToStr(BankRunsSpammer), "Bank")
        this.WriteToIni("BankDepositTime", BankDepositTime, "Bank")
        this.WriteToIni("LeaftonCraftEnabled", BinaryToStr(LeaftonCraftEnabled), "Leafton")
        this.WriteToIni("LeaftonSpamsWind", BinaryToStr(LeaftonSpamsWind), "Leafton")
        this.WriteToIni("LeaftonBanksEnabled", BinaryToStr(LeaftonBanksEnabled), "Leafton")
        this.WriteToIni("LeaftonRunOnceEnabled", BinaryToStr(LeaftonRunOnceEnabled), "Leafton")
        this.WriteToIni("TowerPassiveBanksEnabled", BinaryToStr(TowerPassiveBanksEnabled), "TowerPassive")
        this.WriteToIni("TowerPassiveCraftEnabled", BinaryToStr(TowerPassiveCraftEnabled), "TowerPassive")
        this.WriteToIni("MinerEnableVeins", BinaryToStr(MinerEnableVeins), "Miner")
        this.WriteToIni("MinerEnableVeinRemoval", BinaryToStr(MinerEnableVeinRemoval), "Miner")
        this.WriteToIni("MinerEnableTransmute", BinaryToStr(MinerEnableTransmute), "Miner")
        this.WriteToIni("MinerEnableFreeRefuel", BinaryToStr(MinerEnableFreeRefuel), "Miner")
        this.WriteToIni("MinerEnableBanks", BinaryToStr(MinerEnableBanks), "Miner")
        this.WriteToIni("MinerEnableSpammer", BinaryToStr(MinerEnableSpammer), "Miner")
        this.WriteToIni("MinerEnableVeinUpgrade", BinaryToStr(MinerEnableVeinUpgrade), "Miner")
        this.WriteToIni("MinerEnableSphereUse", BinaryToStr(MinerEnableSphereUse), "Miner")
        this.WriteToIni("MinerSphereDelay", MinerSphereDelay, "Miner")
        this.WriteToIni("MinerSphereAmount", MinerSphereAmount, "Miner")
        this.WriteToIni("MinerSphereTimer", MinerSphereTimer, "Miner")
        this.WriteToIni("MinerTransmuteTimer", MinerTransmuteTimer, "Miner")
        this.WriteToIni("MinerRefuelTimer", MinerRefuelTimer, "Miner")
        this.WriteToIni("Debug", BinaryToStr(Debug), "Debug")
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