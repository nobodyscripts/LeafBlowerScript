#Requires AutoHotkey v2.0

Button_Click_Mine(thisGui, info) {
    Global Settings, MinerEnableVeins, MinerEnableTransmute,
        MinerEnableFreeRefuel, MinerEnableBanks, MinerEnableSpammer,
        MinerTransmuteTimer, MinerRefuelTimer, MinerEnableVeinUpgrade,
        MinerEnableVeinRemoval, MinerEnableSphereUse, MinerSphereDelay,
        MinerSphereCount, MinerSphereTimer, MinerEnableLeafton,
        MinerEnableCaves, MinerCaveTimer, MinerSphereGreedyUse,
        MinerSphereModifier, MinerEnableTransmuteSdia, MinerEnableTransmuteFuel,
        MinerEnableTransmuteSphere, MinerEnableTransmuteSdiaToCDia,
        MinerEnableBrewing, MinerBrewCycleTime, MinerBrewCutOffTime,
        BrewEnableArtifacts, BrewEnableEquipment, BrewEnableMaterials,
        BrewEnableScrolls, BrewEnableCardParts, BankEnableStorageUpgrade

    /** @type {GUI} */
    optionsGUI := Gui(, "Mine Maintainer Settings")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    ;@region Add controls

    ;@region Vein settings
    If (MinerEnableVeins = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins checked",
            "Enable Coal Veins Enhance")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins",
            "Enable Coal Veins Enhance")
    }

    If (MinerEnableVeinUpgrade = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinUpgrade checked",
            "Enable Vein Level Upgrader")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinUpgrade",
            "Enable Vein Level Upgrader")
    }

    If (MinerEnableVeinRemoval = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinRemoval checked",
            "Enable Removal of 6th Vein")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinRemoval",
            "Enable Removal of 6th Vein")
    }
    ;@endregion

    ;@region Bank settings
    If (MinerEnableBanks = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableBanks checked",
            "Enable Banks")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableBanks", "Enable Banks")
    }

    If (BankEnableStorageUpgrade = true) {
        optionsGUI.Add("CheckBox", "vBankEnableStorageUpgrade checked",
            "Enable Banks Storage Upgrade")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableStorageUpgrade",
            "Enable Banks Storage Upgrade")
    }
    ;@endregion

    ;@region Spammer settings
    If (MinerEnableLeafton) {
        bgMode := 1
    } Else If (MinerEnableSpammer) {
        bgMode := 2
    } Else {
        bgMode := 0
    }
    optionsGUI.Add("Text", "vMinerBackgroundLabel",
        "Background process:")
    Switch bgMode {
    Case 1:
        optionsGUI.Add("DropDownList", "vMinerBackground Choose1", [
            "Leafton Taxi",
            "Boss Spammer",
            "Off"
        ])
    Case 2:
        optionsGUI.Add("DropDownList", "vMinerBackground Choose2", [
            "Leafton Taxi",
            "Boss Spammer",
            "Off"
        ])
    Case 0:
        optionsGUI.Add("DropDownList", "vMinerBackground Choose3", [
            "Leafton Taxi",
            "Boss Spammer",
            "Off"
        ])
    default:
        optionsGUI.Add("DropDownList", "vMinerBackground Choose3", [
            "Leafton Taxi",
            "Boss Spammer",
            "Off"
        ])
    }
    ;@endregion

    ;@region Transmute settings
    If (MinerEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute checked",
            "Enable Coal Bar To Coal Dia Transmute")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute",
            "Enable Coal Bar To Coal Dia Transmute")
    }

    If (MinerEnableTransmuteSdia = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteSdia ccfaf21 checked",
            "Enable Coal Dia To Shiny Dia Transmute")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteSdia ccfaf21",
            "Enable Coal Dia To Shiny Dia Transmute")
    }

    If (MinerEnableTransmuteFuel = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteFuel checked",
            "Enable Coal Dia To Fuel Transmute")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteFuel",
            "Enable Coal Dia To Fuel Transmute")
    }

    If (MinerEnableTransmuteSphere = true) {
        optionsGUI.Add("CheckBox",
            "vMinerEnableTransmuteSphere checked",
            "Enable Coal Dia To Sphere Transmute")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteSphere",
            "Enable Coal Dia To Sphere Transmute")
    }

    If (MinerEnableTransmuteSdiaToCDia = true) {
        optionsGUI.Add("CheckBox",
            "vMinerEnableTransmuteSdiaToCDia ccfaf21 checked",
            "Enable Shiny Dia To Coal Diamond Transmute")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteSdiaToCDia ccfaf21",
            "Enable Shiny Dia To Coal Diamond Transmute")
    }

    optionsGUI.Add("Text", "", "Auto Bars Transmute Timer (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(MinerTransmuteTimer) && MinerTransmuteTimer > 0) {
        optionsGUI.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
            MinerTransmuteTimer)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
                Settings.defaultNobodySettings.MinerTransmuteTimer)
        } Else {
            optionsGUI.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
                Settings.defaultSettings.MinerTransmuteTimer)
        }
    }
    ;@endregion

    ;@region Fuel settings
    If (MinerEnableFreeRefuel = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableFreeRefuel checked",
            "Enable Fuel Collection")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableFreeRefuel",
            "Enable Fuel Collection")
    }
    optionsGUI.Add("Text", "", "Fuel Collection Timer (m):")
    optionsGUI.AddEdit("cDefault")
    If ((IsInteger(MinerRefuelTimer) || IsFloat(MinerRefuelTimer)) &&
    MinerRefuelTimer > 0.15) {
        optionsGUI.Add("UpDown", "vMinerRefuelTimer Range0-9999",
            MinerRefuelTimer)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerRefuelTimer Range0-9999", Settings.defaultNobodySettings
                .MinerRefuelTimer)
        } Else {
            optionsGUI.Add("UpDown", "vMinerRefuelTimer Range0-9999", Settings.defaultSettings
                .MinerRefuelTimer)
        }
    }
    ;@endregion

    ;@region Sphere settings
    If (MinerEnableSphereUse = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableSphereUse checked",
            "Enable Drill Sphere Use")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableSphereUse",
            "Enable Drill Sphere Use")
    }

    If (MinerSphereGreedyUse = true) {
        optionsGUI.Add("CheckBox", "vMinerSphereGreedyUse checked",
            "Enable Greedy Sphere Use").OnEvent("Click", HandleGreedy)
    } Else {
        optionsGUI.Add("CheckBox", "vMinerSphereGreedyUse",
            "Enable Greedy Sphere Use").OnEvent("Click", HandleGreedy)
    }
    optionsGUI.Add("Text", "ccfaf21", "Greedy caps to Amount")
    optionsGUI.Add("Text", "YP+25", "Drill Sphere Use Delay (ms):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(MinerSphereDelay) && MinerSphereDelay > 0) {
        optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999",
            MinerSphereDelay)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999", Settings.defaultNobodySettings
                .MinerSphereDelay)
        } Else {
            optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999", Settings.defaultSettings
                .MinerSphereDelay)
        }
    }

    optionsGUI.Add("Text", "vMinerSphereCountLabel",
        "Drill Sphere Use Count, 0 (infinite):")
    optionsGUI.AddEdit("cDefault vMinerSphereCountEdit")
    If (IsInteger(MinerSphereCount)) {
        optionsGUI.Add("UpDown", "vMinerSphereCount Range0-99999",
            MinerSphereCount)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereCount Range0-99999", Settings
                .defaultNobodySettings.MinerSphereCount)
        } Else {
            optionsGUI.Add("UpDown", "vMinerSphereCount Range0-99999", Settings
                .defaultSettings.MinerSphereCount)
        }
    }

    optionsGUI.Add("Text", "vMinerSphereModifierLabel",
        "Drill Sphere Usage Amount Modifier:")
    Switch MinerSphereModifier {
    Case 1:
        optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose1", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 10:
        optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose2", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25:
        optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose3", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 100:
        optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose4", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 250:
        optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose5", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 1000:
        optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose6", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 2500:
        optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose7", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    Case 25000:
        optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose8", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    default:
        optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose1", [
            "1",
            "10",
            "25",
            "100",
            "250",
            "1000",
            "2500",
            "25000"
        ])
    }

    optionsGUI.Add("Text", "", "Drill Sphere Cycle Timer (m):")
    optionsGUI.AddEdit("cDefault")
    If ((IsInteger(MinerSphereTimer) || IsFloat(MinerSphereTimer)) &&
    MinerSphereTimer > 0.15) {
        optionsGUI.Add("UpDown", "vMinerSphereTimer Range0-9999",
            MinerSphereTimer)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereTimer Range0-9999", Settings.defaultNobodySettings
                .MinerSphereTimer)
        } Else {
            optionsGUI.Add("UpDown", "vMinerSphereTimer Range0-9999", Settings.defaultSettings
                .MinerSphereTimer)
        }
    }
    ;@endregion

    ;@region Cave settings
    If (MinerEnableCaves = true) {
        optionsGUI.Add("CheckBox", "ys vMinerEnableCaves checked",
            "Enable Cave Diamond Drills")
    } Else {
        optionsGUI.Add("CheckBox", "ys vMinerEnableCaves",
            "Enable Cave Diamond Drills")
    }

    optionsGUI.Add("Text", "ccfaf21",
        "Cave Drills unstable at lower resolutions.")
    optionsGUI.Add("Text", "", "Cave Drills Cycle Timer (m):")
    optionsGUI.AddEdit("cDefault")
    If ((IsInteger(MinerCaveTimer) || IsFloat(MinerCaveTimer)) &&
    MinerCaveTimer > 0.15) {
        optionsGUI.Add("UpDown", "vMinerCaveTimer Range0-9999", MinerCaveTimer)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerCaveTimer Range0-9999", Settings.defaultNobodySettings
                .MinerCaveTimer)
        } Else {
            optionsGUI.Add("UpDown", "vMinerCaveTimer Range0-9999", Settings.defaultSettings
                .MinerCaveTimer)
        }
    }
    ;@endregion

    ;@region Brew settings
    If (MinerEnableBrewing = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableBrewing checked",
            "Enable Brewing")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableBrewing",
            "Enable Brewing")
    }

    optionsGUI.Add("Text", "", "Brew Cycle Timer (s):")
    optionsGUI.AddEdit("cDefault")
    If ((IsInteger(MinerBrewCycleTime) || IsFloat(MinerBrewCycleTime)) &&
    MinerBrewCycleTime >= 0) {
        optionsGUI.Add("UpDown", "vMinerBrewCycleTime Range0-9999",
            MinerBrewCycleTime)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerBrewCycleTime Range0-9999",
                Settings.defaultNobodySettings.MinerBrewCycleTime)
        } Else {
            optionsGUI.Add("UpDown", "vMinerBrewCycleTime Range0-9999",
                Settings.defaultSettings.MinerBrewCycleTime)
        }
    }

    optionsGUI.Add("Text", "", "Brew Period Cutoff Timer (s):")
    optionsGUI.AddEdit("cDefault")
    If ((IsInteger(MinerBrewCutOffTime) || IsFloat(MinerBrewCutOffTime)) &&
    MinerBrewCutOffTime >= 0) {
        optionsGUI.Add("UpDown", "vMinerBrewCutOffTime Range0-9999",
            MinerBrewCutOffTime)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerBrewCutOffTime Range0-9999",
                Settings.defaultNobodySettings.MinerBrewCutOffTime)
        } Else {
            optionsGUI.Add("UpDown", "vMinerBrewCutOffTime Range0-9999",
                Settings.defaultSettings.MinerBrewCutOffTime)
        }
    }

    If (BrewEnableArtifacts = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableArtifacts checked",
            "Enable Brew Artifacts")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableArtifacts",
            "Enable Brew Artifacts")
    }

    If (BrewEnableEquipment = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableEquipment checked",
            "Enable Brew Equipment")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableEquipment",
            "Enable Brew Equipment")
    }

    If (BrewEnableMaterials = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableMaterials checked",
            "Enable Brew Materials")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableMaterials",
            "Enable Brew Materials")
    }

    If (BrewEnableScrolls = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableScrolls checked",
            "Enable Brew Scrolls")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableScrolls",
            "Enable Brew Scrolls")
    }

    If (BrewEnableCardParts = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableCardParts checked",
            "Enable Brew Card Parts")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableCardParts",
            "Enable Brew Card Parts")
    }
    ;@endregion

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunMine)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveMine)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessMineSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseMineSettings)

    ;@endregion

    If (MinerSphereGreedyUse) {
        optionsGUI["MinerSphereCount"].Opt("+Disabled")
        optionsGUI["MinerSphereCountEdit"].Opt("+Readonly")
        optionsGUI["MinerSphereCountLabel"].Text := "Disabled with Greedy ON"
        optionsGUI["MinerSphereCountLabel"].Opt("ccfaf21")
    }

    ShowGUIPosition(optionsGUI)
    MakeGUIResizableIfOversize(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessMineSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        MineSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunMine(*) {
        optionsGUI.Hide()
        Window.Activate()
        fMineStart()
    }

    RunSaveMine(*) {
        MineSave()
        optionsGUI.Hide()
        Window.Activate()
        fMineStart()
    }

    CloseMineSettings(*) {
        optionsGUI.Hide()
    }

    MineSave() {
        values := optionsGUI.Submit()
        Switch values.MinerBackground {
        Case "Leafton Taxi":
            MinerEnableLeafton := true
            MinerEnableSpammer := false
        Case "Boss Spammer":
            MinerEnableLeafton := false
            MinerEnableSpammer := true
        default:
            MinerEnableLeafton := false
            MinerEnableSpammer := false
        }
        MinerEnableVeins := values.MinerEnableVeins
        MinerEnableTransmute := values.MinerEnableTransmute
        MinerEnableFreeRefuel := values.MinerEnableFreeRefuel
        MinerEnableBanks := values.MinerEnableBanks
        MinerTransmuteTimer := values.MinerTransmuteTimer
        MinerRefuelTimer := values.MinerRefuelTimer
        MinerEnableVeinUpgrade := values.MinerEnableVeinUpgrade
        MinerEnableVeinRemoval := values.MinerEnableVeinRemoval
        MinerEnableSphereUse := values.MinerEnableSphereUse
        MinerSphereDelay := values.MinerSphereDelay
        MinerSphereCount := values.MinerSphereCount
        MinerSphereTimer := values.MinerSphereTimer
        MinerEnableCaves := values.MinerEnableCaves
        MinerCaveTimer := values.MinerCaveTimer
        MinerSphereGreedyUse := values.MinerSphereGreedyUse
        MinerSphereModifier := values.MinerSphereModifier
        MinerEnableTransmuteSdia := values.MinerEnableTransmuteSdia
        MinerEnableTransmuteFuel := values.MinerEnableTransmuteFuel
        MinerEnableTransmuteSphere := values.MinerEnableTransmuteSphere
        MinerEnableTransmuteSdiaToCDia := values.MinerEnableTransmuteSdiaToCDia
        MinerEnableBrewing := values.MinerEnableBrewing
        MinerBrewCycleTime := values.MinerBrewCycleTime
        MinerBrewCutOffTime := values.MinerBrewCutOffTime
        BrewEnableArtifacts := values.BrewEnableArtifacts
        BrewEnableEquipment := values.BrewEnableEquipment
        BrewEnableMaterials := values.BrewEnableMaterials
        BrewEnableScrolls := values.BrewEnableScrolls
        BrewEnableCardParts := values.BrewEnableCardParts
        BankEnableStorageUpgrade := values.BankEnableStorageUpgrade
        Settings.SaveCurrentSettings()
    }

    HandleGreedy(guiControlObj, info) {
        guiObj := guiControlObj.gui
        If (guiControlObj.Value) {

            guiObj["MinerSphereCountEdit"].Opt("+Readonly")
            guiObj["MinerSphereCountEdit"].Redraw()
            guiObj["MinerSphereCount"].Opt("+Disabled")
            guiObj["MinerSphereCount"].Redraw()
            guiObj["MinerSphereCountLabel"].Text := "Disabled with Greedy ON"
            guiObj["MinerSphereCountLabel"].Opt("ccfaf21")
        } Else {
            guiObj["MinerSphereCountEdit"].Opt("-Readonly")
            guiObj["MinerSphereCountEdit"].Redraw()
            guiObj["MinerSphereCount"].Opt("-Disabled")
            guiObj["MinerSphereCount"].Redraw()
            guiObj["MinerSphereCountLabel"].Text :=
                "Drill Sphere Use Count, 0 (infinite):"
        }
    }
}
