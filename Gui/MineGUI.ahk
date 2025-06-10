#Requires AutoHotkey v2.0

Button_Click_Mine(thisGui, info) {

    MinerEnableLeafton := S.Get("MinerEnableLeafton")
    MinerEnableSpammer := S.Get("MinerEnableSpammer")
    MinerEnableVeins := S.Get("MinerEnableVeins")
    MinerEnableTransmute := S.Get("MinerEnableTransmute")
    MinerEnableFreeRefuel := S.Get("MinerEnableFreeRefuel")
    MinerEnableBanks := S.Get("MinerEnableBanks")
    MinerTransmuteTimer := S.Get("MinerTransmuteTimer")
    MinerRefuelTimer := S.Get("MinerRefuelTimer")
    MinerEnableVeinUpgrade := S.Get("MinerEnableVeinUpgrade")
    MinerEnableVeinRemoval := S.Get("MinerEnableVeinRemoval")
    MinerEnableSphereUse := S.Get("MinerEnableSphereUse")
    MinerSphereDelay := S.Get("MinerSphereDelay")
    MinerSphereCount := S.Get("MinerSphereCount")
    MinerSphereTimer := S.Get("MinerSphereTimer")
    MinerEnableCaves := S.Get("MinerEnableCaves")
    MinerCaveTimer := S.Get("MinerCaveTimer")
    MinerSphereGreedyUse := S.Get("MinerSphereGreedyUse")
    MinerSphereModifier := S.Get("MinerSphereModifier")
    MinerEnableTransmuteSdia := S.Get("MinerEnableTransmuteSdia")
    MinerEnableTransmuteFuel := S.Get("MinerEnableTransmuteFuel")
    MinerEnableTransmuteSphere := S.Get("MinerEnableTransmuteSphere")
    MinerEnableTransmuteSdiaToCDia := S.Get("MinerEnableTransmuteSdiaToCDia")
    MinerEnableBrewing := S.Get("MinerEnableBrewing")
    MinerBrewCycleTime := S.Get("MinerBrewCycleTime")
    MinerBrewCutOffTime := S.Get("MinerBrewCutOffTime")
    BrewEnableArtifacts := S.Get("BrewEnableArtifacts")
    BrewEnableEquipment := S.Get("BrewEnableEquipment")
    BrewEnableMaterials := S.Get("BrewEnableMaterials")
    BrewEnableScrolls := S.Get("BrewEnableScrolls")
    BrewEnableCardParts := S.Get("BrewEnableCardParts")
    BankEnableStorageUpgrade := S.Get("BankEnableStorageUpgrade")
    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Mine Maintainer Settings")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()

    ;@region Add controls

    ;@region Vein settings
    If (MinerEnableVeins = true) {
        MyGui.Add("CheckBox", "vMinerEnableVeins checked",
            "Enable Coal Veins Enhance")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableVeins",
            "Enable Coal Veins Enhance")
    }

    If (MinerEnableVeinUpgrade = true) {
        MyGui.Add("CheckBox", "vMinerEnableVeinUpgrade checked",
            "Enable Vein Level Upgrader")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableVeinUpgrade",
            "Enable Vein Level Upgrader")
    }

    If (MinerEnableVeinRemoval = true) {
        MyGui.Add("CheckBox", "vMinerEnableVeinRemoval checked",
            "Enable Removal of 6th Vein")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableVeinRemoval",
            "Enable Removal of 6th Vein")
    }
    ;@endregion

    ;@region Bank settings
    If (MinerEnableBanks = true) {
        MyGui.Add("CheckBox", "vMinerEnableBanks checked",
            "Enable Banks")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableBanks", "Enable Banks")
    }

    If (BankEnableStorageUpgrade = true) {
        MyGui.Add("CheckBox", "vBankEnableStorageUpgrade checked",
            "Enable Banks Storage Upgrade")
    } Else {
        MyGui.Add("CheckBox", "vBankEnableStorageUpgrade",
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
    MyGui.Add("Text", "vMinerBackgroundLabel",
        "Background process:")
    Switch bgMode {
    Case 1:
        MyGui.Add("DropDownList", "vMinerBackground Choose1", [
            "Leafton Taxi",
            "Boss Spammer",
            "Off"
        ])
    Case 2:
        MyGui.Add("DropDownList", "vMinerBackground Choose2", [
            "Leafton Taxi",
            "Boss Spammer",
            "Off"
        ])
    Case 0:
        MyGui.Add("DropDownList", "vMinerBackground Choose3", [
            "Leafton Taxi",
            "Boss Spammer",
            "Off"
        ])
    default:
        MyGui.Add("DropDownList", "vMinerBackground Choose3", [
            "Leafton Taxi",
            "Boss Spammer",
            "Off"
        ])
    }
    ;@endregion

    ;@region Transmute settings
    If (MinerEnableTransmute = true) {
        MyGui.Add("CheckBox", "vMinerEnableTransmute checked",
            "Enable Coal Bar To Coal Dia Transmute")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableTransmute",
            "Enable Coal Bar To Coal Dia Transmute")
    }

    If (MinerEnableTransmuteSdia = true) {
        MyGui.Add("CheckBox", "vMinerEnableTransmuteSdia ccfaf21 checked",
            "Enable Coal Dia To Shiny Dia Transmute")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableTransmuteSdia ccfaf21",
            "Enable Coal Dia To Shiny Dia Transmute")
    }

    If (MinerEnableTransmuteFuel = true) {
        MyGui.Add("CheckBox", "vMinerEnableTransmuteFuel checked",
            "Enable Coal Dia To Fuel Transmute")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableTransmuteFuel",
            "Enable Coal Dia To Fuel Transmute")
    }

    If (MinerEnableTransmuteSphere = true) {
        MyGui.Add("CheckBox",
            "vMinerEnableTransmuteSphere checked",
            "Enable Coal Dia To Sphere Transmute")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableTransmuteSphere",
            "Enable Coal Dia To Sphere Transmute")
    }

    If (MinerEnableTransmuteSdiaToCDia = true) {
        MyGui.Add("CheckBox",
            "vMinerEnableTransmuteSdiaToCDia ccfaf21 checked",
            "Enable Shiny Dia To Coal Diamond Transmute")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableTransmuteSdiaToCDia ccfaf21",
            "Enable Shiny Dia To Coal Diamond Transmute")
    }

    MyGui.Add("Text", "", "Auto Bars Transmute Timer (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(MinerTransmuteTimer) && MinerTransmuteTimer > 0) {
        MyGui.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
            MinerTransmuteTimer)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
                S.defaultNobodySettings.MinerTransmuteTimer)
        } Else {
            MyGui.Add("UpDown", "vMinerTransmuteTimer Range1-9999",
                S.defaultSettings.MinerTransmuteTimer)
        }
    }
    ;@endregion

    ;@region Fuel settings
    If (MinerEnableFreeRefuel = true) {
        MyGui.Add("CheckBox", "vMinerEnableFreeRefuel checked",
            "Enable Fuel Collection")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableFreeRefuel",
            "Enable Fuel Collection")
    }
    MyGui.Add("Text", "", "Fuel Collection Timer (m):")
    MyGui.AddEdit("cDefault")
    If ((IsInteger(MinerRefuelTimer) || IsFloat(MinerRefuelTimer)) &&
    MinerRefuelTimer > 0.15) {
        MyGui.Add("UpDown", "vMinerRefuelTimer Range0-9999",
            MinerRefuelTimer)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vMinerRefuelTimer Range0-9999", S.defaultNobodySettings
                .MinerRefuelTimer)
        } Else {
            MyGui.Add("UpDown", "vMinerRefuelTimer Range0-9999", S.defaultSettings
                .MinerRefuelTimer)
        }
    }
    ;@endregion

    ;@region Sphere settings
    If (MinerEnableSphereUse = true) {
        MyGui.Add("CheckBox", "vMinerEnableSphereUse checked",
            "Enable Drill Sphere Use")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableSphereUse",
            "Enable Drill Sphere Use")
    }

    If (MinerSphereGreedyUse = true) {
        MyGui.Add("CheckBox", "vMinerSphereGreedyUse checked",
            "Enable Greedy Sphere Use").OnEvent("Click", HandleGreedy)
    } Else {
        MyGui.Add("CheckBox", "vMinerSphereGreedyUse",
            "Enable Greedy Sphere Use").OnEvent("Click", HandleGreedy)
    }
    MyGui.Add("Text", "ccfaf21", "Greedy caps to Amount")
    MyGui.Add("Text", "YP+25", "Drill Sphere Use Delay (ms):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(MinerSphereDelay) && MinerSphereDelay > 0) {
        MyGui.Add("UpDown", "vMinerSphereDelay Range1-9999",
            MinerSphereDelay)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vMinerSphereDelay Range1-9999", S.defaultNobodySettings
                .MinerSphereDelay)
        } Else {
            MyGui.Add("UpDown", "vMinerSphereDelay Range1-9999", S.defaultSettings
                .MinerSphereDelay)
        }
    }

    MyGui.Add("Text", "vMinerSphereCountLabel",
        "Drill Sphere Use Count, 0 (infinite):")
    MyGui.AddEdit("cDefault vMinerSphereCountEdit")
    If (IsInteger(MinerSphereCount)) {
        MyGui.Add("UpDown", "vMinerSphereCount Range0-99999",
            MinerSphereCount)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vMinerSphereCount Range0-99999", S
                .defaultNobodySettings.MinerSphereCount)
        } Else {
            MyGui.Add("UpDown", "vMinerSphereCount Range0-99999", S
                .defaultSettings.MinerSphereCount)
        }
    }

    MyGui.Add("Text", "vMinerSphereModifierLabel",
        "Drill Sphere Usage Amount Modifier:")
    Switch MinerSphereModifier {
    Case 1:
        MyGui.Add("DropDownList", "vMinerSphereModifier Choose1", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 10:
        MyGui.Add("DropDownList", "vMinerSphereModifier Choose2", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25:
        MyGui.Add("DropDownList", "vMinerSphereModifier Choose3", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 100:
        MyGui.Add("DropDownList", "vMinerSphereModifier Choose4", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 250:
        MyGui.Add("DropDownList", "vMinerSphereModifier Choose5", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 1000:
        MyGui.Add("DropDownList", "vMinerSphereModifier Choose6", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 2500:
        MyGui.Add("DropDownList", "vMinerSphereModifier Choose7", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    Case 25000:
        MyGui.Add("DropDownList", "vMinerSphereModifier Choose8", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    default:
        MyGui.Add("DropDownList", "vMinerSphereModifier Choose1", [
            "1", "10", "25", "100", "250", "1000", "2500", "25000"
        ])
    }

    MyGui.Add("Text", "", "Drill Sphere Cycle Timer (m):")
    MyGui.AddEdit("cDefault")
    If ((IsInteger(MinerSphereTimer) || IsFloat(MinerSphereTimer)) &&
    MinerSphereTimer > 0.15) {
        MyGui.Add("UpDown", "vMinerSphereTimer Range0-9999",
            MinerSphereTimer)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vMinerSphereTimer Range0-9999", S.defaultNobodySettings
                .MinerSphereTimer)
        } Else {
            MyGui.Add("UpDown", "vMinerSphereTimer Range0-9999", S.defaultSettings
                .MinerSphereTimer)
        }
    }
    ;@endregion

    ;@region Cave settings
    If (MinerEnableCaves = true) {
        MyGui.Add("CheckBox", "ys vMinerEnableCaves checked",
            "Enable Cave Diamond Drills")
    } Else {
        MyGui.Add("CheckBox", "ys vMinerEnableCaves",
            "Enable Cave Diamond Drills")
    }

    MyGui.Add("Text", "ccfaf21",
        "Cave Drills unstable at lower resolutions.")
    MyGui.Add("Text", "", "Cave Drills Cycle Timer (m):")
    MyGui.AddEdit("cDefault")
    If ((IsInteger(MinerCaveTimer) || IsFloat(MinerCaveTimer)) &&
    MinerCaveTimer > 0.15) {
        MyGui.Add("UpDown", "vMinerCaveTimer Range0-9999", MinerCaveTimer)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vMinerCaveTimer Range0-9999", S.defaultNobodySettings
                .MinerCaveTimer)
        } Else {
            MyGui.Add("UpDown", "vMinerCaveTimer Range0-9999", S.defaultSettings
                .MinerCaveTimer)
        }
    }
    ;@endregion

    ;@region Brew settings
    If (MinerEnableBrewing = true) {
        MyGui.Add("CheckBox", "vMinerEnableBrewing checked",
            "Enable Brewing")
    } Else {
        MyGui.Add("CheckBox", "vMinerEnableBrewing",
            "Enable Brewing")
    }

    MyGui.Add("Text", "", "Brew Cycle Timer (s):")
    MyGui.AddEdit("cDefault")
    If ((IsInteger(MinerBrewCycleTime) || IsFloat(MinerBrewCycleTime)) &&
    MinerBrewCycleTime >= 0) {
        MyGui.Add("UpDown", "vMinerBrewCycleTime Range0-9999",
            MinerBrewCycleTime)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vMinerBrewCycleTime Range0-9999",
                S.defaultNobodySettings.MinerBrewCycleTime)
        } Else {
            MyGui.Add("UpDown", "vMinerBrewCycleTime Range0-9999",
                S.defaultSettings.MinerBrewCycleTime)
        }
    }

    MyGui.Add("Text", "", "Brew Period Cutoff Timer (s):")
    MyGui.AddEdit("cDefault")
    If ((IsInteger(MinerBrewCutOffTime) || IsFloat(MinerBrewCutOffTime)) &&
    MinerBrewCutOffTime >= 0) {
        MyGui.Add("UpDown", "vMinerBrewCutOffTime Range0-9999",
            MinerBrewCutOffTime)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vMinerBrewCutOffTime Range0-9999",
                S.defaultNobodySettings.MinerBrewCutOffTime)
        } Else {
            MyGui.Add("UpDown", "vMinerBrewCutOffTime Range0-9999",
                S.defaultSettings.MinerBrewCutOffTime)
        }
    }

    If (BrewEnableArtifacts = true) {
        MyGui.Add("CheckBox", "vBrewEnableArtifacts checked",
            "Enable Brew Artifacts")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableArtifacts",
            "Enable Brew Artifacts")
    }

    If (BrewEnableEquipment = true) {
        MyGui.Add("CheckBox", "vBrewEnableEquipment checked",
            "Enable Brew Equipment")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableEquipment",
            "Enable Brew Equipment")
    }

    If (BrewEnableMaterials = true) {
        MyGui.Add("CheckBox", "vBrewEnableMaterials checked",
            "Enable Brew Materials")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableMaterials",
            "Enable Brew Materials")
    }

    If (BrewEnableScrolls = true) {
        MyGui.Add("CheckBox", "vBrewEnableScrolls checked",
            "Enable Brew Scrolls")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableScrolls",
            "Enable Brew Scrolls")
    }

    If (BrewEnableCardParts = true) {
        MyGui.Add("CheckBox", "vBrewEnableCardParts checked",
            "Enable Brew Card Parts")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableCardParts",
            "Enable Brew Card Parts")
    }
    ;@endregion

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunMine)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveMine)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessMineSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseMineSettings)

    ;@endregion

    If (MinerSphereGreedyUse) {
        MyGui["MinerSphereCount"].Opt("+Disabled")
        MyGui["MinerSphereCountEdit"].Opt("+Readonly")
        MyGui["MinerSphereCountLabel"].Text := "Disabled with Greedy ON"
        MyGui["MinerSphereCountLabel"].Opt("ccfaf21")
    }

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessMineSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        MineSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunMine(*) {
        MyGui.Hide()
        fMineStart()
    }

    RunSaveMine(*) {
        MineSave()
        MyGui.Hide()
        fMineStart()
    }

    CloseMineSettings(*) {
        MyGui.Hide()
    }

    MineSave() {
        values := MyGui.Submit()
        Switch values.MinerBackground {
        Case "Leafton Taxi":
            S.Set("MinerEnableLeafton", true)
            S.Set("MinerEnableSpammer", false)
        Case "Boss Spammer":
            S.Set("MinerEnableLeafton", false)
            S.Set("MinerEnableSpammer", true)
        default:
            S.Set("MinerEnableLeafton", false)
            S.Set("MinerEnableSpammer", false)
        }
        S.Set("MinerEnableVeins", values.MinerEnableVeins)
        S.Set("MinerEnableTransmute", values.MinerEnableTransmute)
        S.Set("MinerEnableFreeRefuel", values.MinerEnableFreeRefuel)
        S.Set("MinerEnableBanks", values.MinerEnableBanks)
        S.Set("MinerTransmuteTimer", values.MinerTransmuteTimer)
        S.Set("MinerRefuelTimer", values.MinerRefuelTimer)
        S.Set("MinerEnableVeinUpgrade", values.MinerEnableVeinUpgrade)
        S.Set("MinerEnableVeinRemoval", values.MinerEnableVeinRemoval)
        S.Set("MinerEnableSphereUse", values.MinerEnableSphereUse)
        S.Set("MinerSphereDelay", values.MinerSphereDelay)
        S.Set("MinerSphereCount", values.MinerSphereCount)
        S.Set("MinerSphereTimer", values.MinerSphereTimer)
        S.Set("MinerEnableCaves", values.MinerEnableCaves)
        S.Set("MinerCaveTimer", values.MinerCaveTimer)
        S.Set("MinerSphereGreedyUse", values.MinerSphereGreedyUse)
        S.Set("MinerSphereModifier", values.MinerSphereModifier)
        S.Set("MinerEnableTransmuteSdia", values.MinerEnableTransmuteSdia)
        S.Set("MinerEnableTransmuteFuel", values.MinerEnableTransmuteFuel)
        S.Set("MinerEnableTransmuteSphere", values.MinerEnableTransmuteSphere)
        S.Set("MinerEnableTransmuteSdiaToCDia", values.MinerEnableTransmuteSdiaToCDia)
        S.Set("MinerEnableBrewing", values.MinerEnableBrewing)
        S.Set("MinerBrewCycleTime", values.MinerBrewCycleTime)
        S.Set("MinerBrewCutOffTime", values.MinerBrewCutOffTime)
        S.Set("BrewEnableArtifacts", values.BrewEnableArtifacts)
        S.Set("BrewEnableEquipment", values.BrewEnableEquipment)
        S.Set("BrewEnableMaterials", values.BrewEnableMaterials)
        S.Set("BrewEnableScrolls", values.BrewEnableScrolls)
        S.Set("BrewEnableCardParts", values.BrewEnableCardParts)
        S.Set("BankEnableStorageUpgrade", values.BankEnableStorageUpgrade)
        S.SaveCurrentSettings()
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
