#Requires AutoHotkey v2.0

Button_Click_GFSS(thisGui, info) {
    Global Settings, GFToKillPerCycle, SSToKillPerCycle, GFSSNoReset

    /** @type {GUI} */
    optionsGUI := Gui(, "GF/SS Bossfarm Settings")
    optionsGUI.Opt("")
    optionsGUI.BackColor := "0c0018"

    optionsGUI.Add("Text", "ccfcfcf", "GF To Kill Per Cycle:")
    optionsGUI.AddEdit()
    If (IsInteger(GFToKillPerCycle) && GFToKillPerCycle > 0) {
        optionsGUI.Add("UpDown", "vGFToKillPerCycle Range1-9999",
            GFToKillPerCycle)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vGFToKillPerCycle Range1-9999", Settings.defaultNobodySettings
                .GFToKillPerCycle)
        } Else {
            optionsGUI.Add("UpDown", "vGFToKillPerCycle Range1-9999", Settings.defaultSettings
                .GFToKillPerCycle)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf", "SS To Kill Per Cycle:")
    optionsGUI.AddEdit()
    If (IsInteger(SSToKillPerCycle) && SSToKillPerCycle > 0) {
        optionsGUI.Add("UpDown", "vSSToKillPerCycle Range0-9999",
            SSToKillPerCycle)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vSSToKillPerCycle Range0-9999", Settings.defaultNobodySettings
                .SSToKillPerCycle)
        } Else {
            optionsGUI.Add("UpDown", "vSSToKillPerCycle Range0-9999", Settings.defaultSettings
                .SSToKillPerCycle)
        }
    }

    If (GFSSNoReset = true) {
        optionsGUI.Add("CheckBox", "vGFSSNoReset ccfcfcf checked",
            "Disable resetting kill count")
    } Else {
        optionsGUI.Add("CheckBox", "vGFSSNoReset ccfcfcf",
            "Disable resetting kill count")
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunGFSS)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveGFSS)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessGFSSSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseGFSSSettings)

    ShowGUIPosition(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessGFSSSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        GFSSSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunGFSS(*) {
        optionsGUI.Hide()
        Window.Activate()
        fGFSSStart()
    }

    RunSaveGFSS(*) {
        GFSSSave()
        optionsGUI.Hide()
        Window.Activate()
        fGFSSStart()
    }

    CloseGFSSSettings(*) {
        optionsGUI.Hide()
    }

    GFSSSave() {
        values := optionsGUI.Submit()
        GFToKillPerCycle := values.GFToKillPerCycle
        SSToKillPerCycle := values.SSToKillPerCycle
        GFSSNoReset := values.GFSSNoReset

        Settings.SaveCurrentSettings()
    }
}
