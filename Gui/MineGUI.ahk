#Requires AutoHotkey v2.0


Button_Click_Mine(thisGui, info) {
    global Settings, MinerEnableVeins, MinerEnableTransmute, MinerEnableFreeRefuel,
        MinerEnableBanks, MinerEnableSpammer, MinerTransmuteTimer, MinerRefuelTimer,
        MinerEnableVeinUpgrade, MinerEnableVeinRemoval, MinerEnableSphereUse,
        MinerSphereDelay, MinerSphereAmount, MinerSphereTimer,
        MinerEnableCaves, MinerCaveTimer

    optionsGUI := Gui(, "Mine Maintainer Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    if (MinerEnableVeins = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins ccfcfcf checked", "Enable Coal Veins")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins ccfcfcf", "Enable Coal Veins")
    }

    if (MinerEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute ccfcfcf checked", "Enable Bar Transmute")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute ccfcfcf", "Enable Bar Transmute")
    }

    if (MinerEnableFreeRefuel = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableFreeRefuel ccfcfcf checked", "Enable Fuel Collection")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableFreeRefuel ccfcfcf", "Enable Fuel Collection")
    }

    if (MinerEnableBanks = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableBanks ccfcfcf checked", "Enable Banks")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableBanks ccfcfcf", "Enable Banks")
    }

    if (MinerEnableSpammer = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableSpammer ccfcfcf checked", "Enable Boss Spammer")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableSpammer ccfcfcf", "Enable Boss Spammer")
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

    optionsGUI.Add("Text", "ccfcfcf", "Fuel Collection Timer (m):")
    optionsGUI.AddEdit()
    If ((IsInteger(MinerRefuelTimer) || IsFloat(MinerRefuelTimer)) && MinerRefuelTimer > 0.15) {
        optionsGUI.Add("UpDown", "vMinerRefuelTimer Range0-9999",
            MinerRefuelTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerRefuelTimer Range0-9999",
                settings.defaultNobodySettings.MinerRefuelTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerRefuelTimer Range0-9999",
                settings.defaultSettings.MinerRefuelTimer)
        }
    }

    if (MinerEnableVeinUpgrade = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinUpgrade ccfcfcf checked", "Enable Vein Level Upgrader")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinUpgrade ccfcfcf", "Enable Vein Level Upgrader")
    }

    if (MinerEnableVeinRemoval = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinRemoval ccfcfcf checked", "Enable Removal of 6th Vein")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeinRemoval ccfcfcf", "Enable Removal of 6th Vein")
    }

    if (MinerEnableSphereUse = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableSphereUse ccfcfcf checked", "Enable Drill Sphere Use")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableSphereUse ccfcfcf", "Enable Drill Sphere Use")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Drill Sphere Use Delay (ms):")
    optionsGUI.AddEdit()
    If (IsInteger(MinerSphereDelay) && MinerSphereDelay > 0) {
        optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999",
            MinerSphereDelay)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999",
                settings.defaultNobodySettings.MinerSphereDelay)
        } else {
            optionsGUI.Add("UpDown", "vMinerSphereDelay Range1-9999",
                settings.defaultSettings.MinerSphereDelay)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf", "Drill Sphere Amount, 0 (infinite):")
    optionsGUI.AddEdit()
    If (IsInteger(MinerSphereAmount)) {
        optionsGUI.Add("UpDown", "vMinerSphereAmount Range0-99999",
            MinerSphereAmount)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereAmount Range0-99999",
                settings.defaultNobodySettings.MinerSphereAmount)
        } else {
            optionsGUI.Add("UpDown", "vMinerSphereAmount Range0-99999",
                settings.defaultSettings.MinerSphereAmount)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf", "Drill Sphere Cycle Timer (m):")
    optionsGUI.AddEdit()
    If ((IsInteger(MinerSphereTimer) || IsFloat(MinerSphereTimer)) && MinerSphereTimer > 0.15) {
        optionsGUI.Add("UpDown", "vMinerSphereTimer Range0-9999",
            MinerSphereTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerSphereTimer Range0-9999",
                settings.defaultNobodySettings.MinerSphereTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerSphereTimer Range0-9999",
                settings.defaultSettings.MinerSphereTimer)
        }
    }

    if (MinerEnableCaves = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableCaves ccfcfcf checked", "Enable Cave Diamond Drills")
    } else {
        optionsGUI.Add("CheckBox", "vMinerEnableCaves ccfcfcf", "Enable Cave Diamond Drills")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Cave Drills Cycle Timer (m):")
    optionsGUI.AddEdit()
    If ((IsInteger(MinerCaveTimer) || IsFloat(MinerCaveTimer)) && MinerCaveTimer > 0.15) {
        optionsGUI.Add("UpDown", "vMinerCaveTimer Range0-9999",
            MinerCaveTimer)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vMinerCaveTimer Range0-9999",
                settings.defaultNobodySettings.MinerCaveTimer)
        } else {
            optionsGUI.Add("UpDown", "vMinerCaveTimer Range0-9999",
                settings.defaultSettings.MinerCaveTimer)
        }
    }


    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunMine)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click", RunSaveMine)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click", ProcessMineSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseMineSettings)

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
        MinerEnableVeins := values.MinerEnableVeins
        MinerEnableTransmute := values.MinerEnableTransmute
        MinerEnableFreeRefuel := values.MinerEnableFreeRefuel
        MinerEnableBanks := values.MinerEnableBanks
        MinerEnableSpammer := values.MinerEnableSpammer
        MinerTransmuteTimer := values.MinerTransmuteTimer
        MinerRefuelTimer := values.MinerRefuelTimer
        MinerEnableVeinUpgrade := values.MinerEnableVeinUpgrade
        MinerEnableVeinRemoval := values.MinerEnableVeinRemoval
        MinerEnableSphereUse := values.MinerEnableSphereUse
        MinerSphereDelay := values.MinerSphereDelay
        MinerSphereAmount := values.MinerSphereAmount
        MinerSphereTimer := values.MinerSphereTimer
        MinerEnableCaves := values.MinerEnableCaves
        MinerCaveTimer := values.MinerCaveTimer
        settings.SaveCurrentSettings()
    }
}