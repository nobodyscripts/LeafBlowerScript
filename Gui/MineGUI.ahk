#Requires AutoHotkey v2.0


Button_Click_Mine(thisGui, info) {
    global Settings, MinerEnableVeins, MinerEnableTransmute,
        MinerEnableFreeRefuel, MinerEnableBanks, MinerEnableSpammer,
        MinerTransmuteTimer, MinerRefuelTimer, MinerEnableVeinUpgrade,
        MinerEnableVeinRemoval, MinerEnableSphereUse, MinerSphereDelay,
        MinerSphereCount, MinerSphereTimer, MinerEnableLeafton,
        MinerEnableCaves, MinerCaveTimer, MinerSphereGreedyUse,
        MinerSphereModifier, MinerEnableTransmuteSdia, MinerEnableTransmuteFuel,
        MinerEnableTransmuteSphere, MinerEnableTransmuteSdiaToCDia,
        MinerEnableBrewing, MinerBrewCycleTime, MinerBrewCutOffTime,
        BrewEnableArtifacts, BrewEnableEquipment, BrewEnableMaterials,
        BrewEnableScrolls, BrewEnableCardParts

    optionsGUI := Gui(, "Mine Maintainer Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    ;@region Add controls

    ;@region Vein settings
    if (MinerEnableVeins = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins ccfcfcf checked",
            "Enable Coal Veins Enhance")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins ccfcfcf",
            "Enable Coal Veins Enhance")
    }

    if (MinerEnableVeinUpgrade = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinUpgrade ccfcfcf checked",
            "Enable Vein Level Upgrader")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinUpgrade ccfcfcf",
            "Enable Vein Level Upgrader")
    }

    if (MinerEnableVeinRemoval = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinRemoval ccfcfcf checked",
            "Enable Removal of 6th Vein")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinRemoval ccfcfcf",
            "Enable Removal of 6th Vein")
    }
    ;@endregion

    ;@region Bank settings
    if (MinerEnableBanks = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableBanks ccfcfcf checked",
            "Enable Banks")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableBanks ccfcfcf", "Enable Banks")
    }
    ;@endregion

    ;@region Spammer settings
    if (MinerEnableLeafton) {
        bgMode := 1
    } else if (MinerEnableSpammer) {
        bgMode := 2
    } else {
        bgMode := 0
    }
    optionsGUI.Add("Text", "ccfcfcf vMinerBackgroundLabel",
        "Background process:")
    switch bgMode {
        case 1:
            optionsGUI.Add("DropDownList", "vMinerBackground Choose1", [
                "Leafton Taxi", "Boss Spammer", "Off"])
        case 2:
            optionsGUI.Add("DropDownList", "vMinerBackground Choose2", [
                "Leafton Taxi", "Boss Spammer", "Off"])
        case 0:
            optionsGUI.Add("DropDownList", "vMinerBackground Choose3", [
                "Leafton Taxi", "Boss Spammer", "Off"])
        default:
            optionsGUI.Add("DropDownList", "vMinerBackground Choose3", [
                "Leafton Taxi", "Boss Spammer", "Off"])
    }
    ;@endregion

    ;@region Transmute settings
    if (MinerEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute ccfcfcf checked",
            "Enable Coal Bar To Coal Dia Transmute")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute ccfcfcf",
            "Enable Coal Bar To Coal Dia Transmute")
    }

    if (MinerEnableTransmuteSdia = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteSdia ccfaf21 checked",
            "Enable Coal Dia To Shiny Dia Transmute")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteSdia ccfaf21",
            "Enable Coal Dia To Shiny Dia Transmute")
    }

    if (MinerEnableTransmuteFuel = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteFuel ccfcfcf checked",
            "Enable Coal Dia To Fuel Transmute")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteFuel ccfcfcf",
            "Enable Coal Dia To Fuel Transmute")
    }

    if (MinerEnableTransmuteSphere = true) {
        optionsGUI.Add("CheckBox",
            "vMinerEnableTransmuteSphere ccfcfcf checked",
            "Enable Coal Dia To Sphere Transmute")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteSphere ccfcfcf",
            "Enable Coal Dia To Sphere Transmute")
    }

    if (MinerEnableTransmuteSdiaToCDia = true) {
        optionsGUI.Add("CheckBox",
            "vMinerEnableTransmuteSdiaToCDia ccfaf21 checked",
            "Enable Shiny Dia To Coal Diamond Transmute")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmuteSdiaToCDia ccfaf21",
            "Enable Shiny Dia To Coal Diamond Transmute")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Auto Bars Transmute Timer (s):")
    optionsGUI.AddEdit()
    If (IsInteger(MinerTransmuteTimer) && MinerTransmuteTimer > 0) {
        optionsGUI.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
            MinerTransmuteTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
                settings.defaultNobodySettings.MinerTransmuteTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
                settings.defaultSettings.MinerTransmuteTimer)
        }
    }
    ;@endregion

    ;@region Fuel settings
    if (MinerEnableFreeRefuel = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableFreeRefuel ccfcfcf checked",
            "Enable Fuel Collection")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableFreeRefuel ccfcfcf",
            "Enable Fuel Collection")
    }
    optionsGUI.Add("Text", "ccfcfcf", "Fuel Collection Timer (m):")
    optionsGUI.AddEdit()
    If ((IsInteger(MinerRefuelTimer) || IsFloat(MinerRefuelTimer)) &&
        MinerRefuelTimer > 0.15) {
        optionsGUI.Add("UpDown", "vMinerRefuelTimer Range0-9999",
            MinerRefuelTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerRefuelTimer Range0-9999", settings.defaultNobodySettings
                .MinerRefuelTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerRefuelTimer Range0-9999", settings.defaultSettings
                .MinerRefuelTimer)
        }
    }
    ;@endregion

    ;@region Sphere settings
    if (MinerEnableSphereUse = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableSphereUse ccfcfcf checked",
            "Enable Drill Sphere Use")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableSphereUse ccfcfcf",
            "Enable Drill Sphere Use")
    }

    if (MinerSphereGreedyUse = true) {
        optionsGUI.Add("CheckBox", "vMinerSphereGreedyUse ccfcfcf checked",
            "Enable Greedy Sphere Use").OnEvent("Click", HandleGreedy)
    } else {
        optionsGUI.Add("CheckBox", "vMinerSphereGreedyUse ccfcfcf",
            "Enable Greedy Sphere Use").OnEvent("Click", HandleGreedy)
    }
    optionsGUI.Add("Text", "ccfaf21", "Greedy caps to Amount")
    optionsGUI.Add("Text", "ccfcfcf YP+25", "Drill Sphere Use Delay (ms):")
    optionsGUI.AddEdit()
    If (IsInteger(MinerSphereDelay) && MinerSphereDelay > 0) {
        optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999",
            MinerSphereDelay)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999", settings.defaultNobodySettings
                .MinerSphereDelay)
        } else {
            optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999", settings.defaultSettings
                .MinerSphereDelay)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf vMinerSphereCountLabel",
        "Drill Sphere Use Count, 0 (infinite):")
    optionsGUI.AddEdit("vMinerSphereCountEdit")
    If (IsInteger(MinerSphereCount)) {
        optionsGUI.Add("UpDown", "vMinerSphereCount Range0-99999",
            MinerSphereCount)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereCount Range0-99999", settings
                .defaultNobodySettings.MinerSphereCount)
        } else {
            optionsGUI.Add("UpDown", "vMinerSphereCount Range0-99999", settings
                .defaultSettings.MinerSphereCount)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf vMinerSphereModifierLabel",
        "Drill Sphere Usage Amount Modifier:")
    switch MinerSphereModifier {
        case 1:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose1", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        case 10:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose2", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose3", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        case 100:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose4", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        case 250:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose5", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        case 1000:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose6", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        case 2500:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose7", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        case 25000:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose1", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
    }


    optionsGUI.Add("Text", "ccfcfcf", "Drill Sphere Cycle Timer (m):")
    optionsGUI.AddEdit()
    If ((IsInteger(MinerSphereTimer) || IsFloat(MinerSphereTimer)) &&
        MinerSphereTimer > 0.15) {
        optionsGUI.Add("UpDown", "vMinerSphereTimer Range0-9999",
            MinerSphereTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereTimer Range0-9999", settings.defaultNobodySettings
                .MinerSphereTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerSphereTimer Range0-9999", settings.defaultSettings
                .MinerSphereTimer)
        }
    }
    ;@endregion

    ;@region Cave settings
    if (MinerEnableCaves = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableCaves ccfcfcf checked",
            "Enable Cave Diamond Drills")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableCaves ccfcfcf",
            "Enable Cave Diamond Drills")
    }

    optionsGUI.Add("Text", "ccfaf21",
        "Cave Drills unstable at lower resolutions.")
    optionsGUI.Add("Text", "ccfcfcf", "Cave Drills Cycle Timer (m):")
    optionsGUI.AddEdit()
    If ((IsInteger(MinerCaveTimer) || IsFloat(MinerCaveTimer)) &&
        MinerCaveTimer > 0.15) {
        optionsGUI.Add("UpDown", "vMinerCaveTimer Range0-9999", MinerCaveTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerCaveTimer Range0-9999", settings.defaultNobodySettings
                .MinerCaveTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerCaveTimer Range0-9999", settings.defaultSettings
                .MinerCaveTimer)
        }
    }
    ;@endregion

    ;@region Brew settings
    if (MinerEnableBrewing = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableBrewing ccfcfcf checked",
            "Enable Brewing")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableBrewing ccfcfcf",
            "Enable Brewing")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Brew Cycle Timer (s):")
    optionsGUI.AddEdit()
    If ((IsInteger(MinerBrewCycleTime) || IsFloat(MinerBrewCycleTime)) &&
        MinerBrewCycleTime >= 0) {
        optionsGUI.Add("UpDown", "vMinerBrewCycleTime Range0-9999",
            MinerBrewCycleTime)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerBrewCycleTime Range0-9999",
                settings.defaultNobodySettings.MinerBrewCycleTime)
        } else {
            optionsGUI.Add("UpDown", "vMinerBrewCycleTime Range0-9999",
                settings.defaultSettings.MinerBrewCycleTime)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf", "Brew Period Cutoff Timer (s):")
    optionsGUI.AddEdit()
    If ((IsInteger(MinerBrewCutOffTime) || IsFloat(MinerBrewCutOffTime)) &&
        MinerBrewCutOffTime >= 0) {
        optionsGUI.Add("UpDown", "vMinerBrewCutOffTime Range0-9999",
            MinerBrewCutOffTime)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerBrewCutOffTime Range0-9999",
                settings.defaultNobodySettings.MinerBrewCutOffTime)
        } else {
            optionsGUI.Add("UpDown", "vMinerBrewCutOffTime Range0-9999",
                settings.defaultSettings.MinerBrewCutOffTime)
        }
    }

    if (BrewEnableArtifacts = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableArtifacts ccfcfcf checked",
            "Enable Brew Artifacts")
    } else {
        optionsGUI.Add("CheckBox", "vBrewEnableArtifacts ccfcfcf",
            "Enable Brew Artifacts")
    }

    if (BrewEnableEquipment = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableEquipment ccfcfcf checked",
            "Enable Brew Equipment")
    } else {
        optionsGUI.Add("CheckBox", "vBrewEnableEquipment ccfcfcf",
            "Enable Brew Equipment")
    }

    if (BrewEnableMaterials = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableMaterials ccfcfcf checked",
            "Enable Brew Materials")
    } else {
        optionsGUI.Add("CheckBox", "vBrewEnableMaterials ccfcfcf",
            "Enable Brew Materials")
    }

    if (BrewEnableScrolls = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableScrolls ccfcfcf checked",
            "Enable Brew Scrolls")
    } else {
        optionsGUI.Add("CheckBox", "vBrewEnableScrolls ccfcfcf",
            "Enable Brew Scrolls")
    }

    if (BrewEnableCardParts = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableCardParts ccfcfcf checked",
            "Enable Brew Card Parts")
    } else {
        optionsGUI.Add("CheckBox", "vBrewEnableCardParts ccfcfcf",
            "Enable Brew Card Parts")
    }
    ;@endregion

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunMine)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveMine)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessMineSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseMineSettings)

    ;@endregion

    if (MinerSphereGreedyUse) {
        optionsGUI["MinerSphereCount"].Opt("+Disabled")
        optionsGUI["MinerSphereCountEdit"].Opt("+Readonly")
        optionsGUI["MinerSphereCountLabel"].Text := "Disabled with Greedy ON"
        optionsGUI["MinerSphereCountLabel"].Opt("ccfaf21")
    }

    optionsGUI.Show("w300")

    ProcessMineSettings(*) {
        MineSave()
    }

    RunMine(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fMineStart()
    }

    RunSaveMine(*) {
        MineSave()
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fMineStart()
    }

    CloseMineSettings(*) {
        optionsGUI.Hide()
    }

    MineSave() {
        values := optionsGUI.Submit()
        switch values.MinerBackground {
            case "Leafton Taxi":
                MinerEnableLeafton := true
                MinerEnableSpammer := false
            case "Boss Spammer":
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
        settings.SaveCurrentSettings()
    }

    HandleGreedy(guiControlObj, info) {
        guiObj := guiControlObj.gui
        if (guiControlObj.Value) {

            guiObj["MinerSphereCountEdit"].Opt("+Readonly")
            guiObj["MinerSphereCountEdit"].Redraw()
            guiObj["MinerSphereCount"].Opt("+Disabled")
            guiObj["MinerSphereCount"].Redraw()
            guiObj["MinerSphereCountLabel"].Text := "Disabled with Greedy ON"
            guiObj["MinerSphereCountLabel"].Opt("ccfaf21")
        } else {
            guiObj["MinerSphereCountEdit"].Opt("-Readonly")
            guiObj["MinerSphereCountEdit"].Redraw()
            guiObj["MinerSphereCount"].Opt("-Disabled")
            guiObj["MinerSphereCount"].Redraw()
            guiObj["MinerSphereCountLabel"].Text :=
                "Drill Sphere Use Count, 0 (infinite):"
        }
    }
}