#Requires AutoHotkey v2.0

Button_Click_Claw(thisGui, info) {
    global settings, ClawCheckSizeOffset, ClawFindAny

    optionsGUI := Gui(, "Claw Farm Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    optionsGUI.Add("Text", "ccfcfcf", "Claw Area Check Size Offset (px):")
    optionsGUI.AddEdit()
    If (IsInteger(ClawCheckSizeOffset) || IsFloat(ClawCheckSizeOffset)) {
        optionsGUI.Add("UpDown", "vClawCheckSizeOffset Range-999-999",
            ClawCheckSizeOffset)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vClawCheckSizeOffset Range-999-9999",
                settings.defaultNobodySettings.ClawCheckSizeOffset)
        } else {
            optionsGUI.Add("UpDown", "vClawCheckSizeOffset Range-999-9999",
                settings.defaultSettings.ClawCheckSizeOffset)
        }
    }

    if (ClawFindAny = true) {
        optionsGUI.Add("CheckBox", "vClawFindAny ccfcfcf checked", "Enable Find any fallback")
    } else {
        optionsGUI.Add("CheckBox", "vClawFindAny ccfcfcf", "Enable Find any fallback")
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunClaw)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click", RunSaveClaw)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click", ProcessClawSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseClawSettings)

    optionsGUI.Show("w300")

    ProcessClawSettings(*) {
        ClawSave()
    }

    RunClaw(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fClawStart()
    }

    RunSaveClaw(*) {
        ClawSave()
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
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