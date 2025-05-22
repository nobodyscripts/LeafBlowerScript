#Requires AutoHotkey v2.0

Button_Click_GFSS(thisGui, info) {
    Global Settings, GFToKillPerCycle, SSToKillPerCycle, GFSSNoReset

    /** @type {GUI} */
    optionsGUI := Gui(, "GF/SS Bossfarm Settings")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    optionsGUI.Add("Text", "", "GF To Kill Per Cycle:")
    optionsGUI.AddEdit("cDefault")
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

    optionsGUI.Add("Text", "", "SS To Kill Per Cycle:")
    optionsGUI.AddEdit("cDefault")
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
        optionsGUI.Add("CheckBox", "vGFSSNoReset checked",
            "Disable resetting kill count")
    } Else {
        optionsGUI.Add("CheckBox", "vGFSSNoReset",
            "Disable resetting kill count")
    }

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunGFSS)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveGFSS)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessGFSSSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseGFSSSettings)

    ShowGUIPosition(optionsGUI)
    MakeGUIResizableIfOversize(optionsGUI)
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
