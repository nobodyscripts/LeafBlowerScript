#Requires AutoHotkey v2.0

Button_Click_Claw(thisGui, info) {
    Global settings, ClawCheckSizeOffset, ClawFindAny

    /** @type {GUI} */
    optionsGUI := Gui(, "Claw Farm Settings")
    optionsGUI.Opt("+MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    optionsGUI.Add("Text", "ccfcfcf", "Claw Area Check Size Offset (px):")
    optionsGUI.AddEdit()
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
        optionsGUI.Add("CheckBox", "vClawFindAny ccfcfcf checked",
            "Enable Find any fallback")
    } Else {
        optionsGUI.Add("CheckBox", "vClawFindAny ccfcfcf",
            "Enable Find any fallback")
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunClaw)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveClaw)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessClawSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseClawSettings)

    optionsGUI.Show("w300")

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
