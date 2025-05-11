#Requires AutoHotkey v2.0

Button_Click_FishAutoCatch(thisGui, info) {
    Window.Activate()
    Fishing().fFishAutoCatch()
}

Button_Click_FishAutoCatchChallenge(thisGui, info) {
    Window.Activate()
    Fishing().fFishAutoCatch(true)
}

Button_Click_FishTourneyStart(thisGui, info) {
    Window.Activate()
    FishingTourney().Farm()
}

Button_Click_Fishing(thisGui, info) {
    Global Settings

    optionsGUI := Gui(, "Fishing Settings")
    optionsGUI.Opt("")
    optionsGUI.BackColor := "0c0018"
/* 
    ;@region Add controls

    ;@region Vein settings
    If (MinerEnableVeins = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins ccfcfcf checked",
            "Enable Coal Veins Enhance")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableVeins ccfcfcf",
            "Enable Coal Veins Enhance")
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
    optionsGUI.Add("Text", "ccfcfcf vMinerBackgroundLabel",
        "Background process:")
    Switch bgMode {
        Case 1:
            optionsGUI.Add("DropDownList", "vMinerBackground Choose1", [
                "Leafton Taxi", "Boss Spammer", "Off"])
        Case 2:
            optionsGUI.Add("DropDownList", "vMinerBackground Choose2", [
                "Leafton Taxi", "Boss Spammer", "Off"])
        Case 0:
            optionsGUI.Add("DropDownList", "vMinerBackground Choose3", [
                "Leafton Taxi", "Boss Spammer", "Off"])
        default:
            optionsGUI.Add("DropDownList", "vMinerBackground Choose3", [
                "Leafton Taxi", "Boss Spammer", "Off"])
    }
    ;@endregion

    ;@region Transmute settings
    If (MinerEnableTransmute = true) {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute ccfcfcf checked",
            "Enable Coal Bar To Coal Dia Transmute")
    } Else {
        optionsGUI.Add("CheckBox", "vMinerEnableTransmute ccfcfcf",
            "Enable Coal Bar To Coal Dia Transmute")
    }


    optionsGUI.Add("Text", "ccfcfcf", "Auto Bars Transmute Timer (s):")
    optionsGUI.AddEdit()
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


    ;@region Sphere settings

    optionsGUI.Add("Text", "ccfcfcf vMinerSphereModifierLabel",
        "Drill Sphere Usage Amount Modifier:")
    Switch MinerSphereModifier {
        Case 1:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose1", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 10:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose2", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose3", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 100:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose4", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 250:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose5", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 1000:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose6", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 2500:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose7", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        Case 25000:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose8", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
        default:
            optionsGUI.Add("DropDownList", "vMinerSphereModifier Choose1", ["1",
                "10", "25", "100", "250", "1000", "2500", "25000"])
    }
    ;@endregion

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunFishing)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveFishing)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessFishingSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseFishingSettings)
         */
    optionsGUI.Add("Text", "ccfcfcf", "(no keybind)")
    MyBtn := optionsGUI.Add("Button", "Default w120", "FISH AUTOCATCH TEST")
    MyBtn.OnEvent("Click", Button_Click_FishAutoCatch)

    optionsGUI.Add("Text", "ccfcfcf", "(no keybind)")
    MyBtn := optionsGUI.Add("Button", "Default w120", "FISH CHALLENGE TEST")
    MyBtn.OnEvent("Click", Button_Click_FishAutoCatchChallenge)

    optionsGUI.Add("Text", "ccfcfcf", "(no keybind)")
    MyBtn := optionsGUI.Add("Button", "Default w120", "TOURNEY TEST")
    MyBtn.OnEvent("Click", Button_Click_FishTourneyStart)
    ;@endregion

    optionsGUI.Show()

    ProcessFishingSettings(*) {
        FishingSave()
    }

    RunFishing(*) {
        optionsGUI.Hide()
        Window.Activate()
        fMineStart()
    }

    RunSaveFishing(*) {
        FishingSave()
        optionsGUI.Hide()
        Window.Activate()
        fMineStart()
    }

    CloseFishingSettings(*) {
        optionsGUI.Hide()
    }

    FishingSave() {
        values := optionsGUI.Submit()

        ;MinerEnableVeins := values.MinerEnableVeins

        Settings.SaveCurrentSettings()
    }
}