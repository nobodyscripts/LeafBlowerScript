#Requires AutoHotkey v2.0

Button_Click_Claw(thisGui, info) {
    Global settings, ClawCheckSizeOffset, ClawFindAny

    /** @type {GUI} */
    optionsGUI := Gui(, "Claw Farm Settings")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    optionsGUI.Add("Text", "", "Claw Area Check Size Offset (px):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(ClawCheckSizeOffset) || IsFloat(ClawCheckSizeOffset)) {
        optionsGUI.Add("UpDown", "vClawCheckSizeOffset Range-999-999",
            ClawCheckSizeOffset)
    } Else {
        If (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vClawCheckSizeOffset Range-999-9999",
                settings.defaultNobodySettings.ClawCheckSizeOffset)
        } Else {
            optionsGUI.Add("UpDown", "vClawCheckSizeOffset Range-999-9999",
                settings.defaultSettings.ClawCheckSizeOffset)
        }
    }

    If (ClawFindAny = true) {
        optionsGUI.Add("CheckBox", "vClawFindAny checked",
            "Enable Find any fallback")
    } Else {
        optionsGUI.Add("CheckBox", "vClawFindAny",
            "Enable Find any fallback")
    }

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunClaw)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveClaw)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessClawSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseClawSettings)

    ShowGUIPosition(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessClawSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        ClawSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunClaw(*) {
        optionsGUI.Hide()
        Window.Activate()
        fClawStart()
    }

    RunSaveClaw(*) {
        ClawSave()
        optionsGUI.Hide()
        Window.Activate()
        fClawStart()
    }

    CloseClawSettings(*) {
        optionsGUI.Hide()
    }

    ClawSave() {
        values := optionsGUI.Submit()
        ClawCheckSizeOffset := values.ClawCheckSizeOffset
        ClawFindAny := values.ClawFindAny
        settings.SaveCurrentSettings()
    }
}
