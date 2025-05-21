#Requires AutoHotkey v2.0

Button_Click_ShadowCrystal(thisGui, info) {
    Global Settings, SCAdvanceReplace
    ;, SCPercent

    /** @type {GUI} */
    optionsGUI := Gui(, "Shadow Crystal Fight Settings")
    optionsGUI.Opt("+MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    If (SCAdvanceReplace = true) {
        optionsGUI.Add("CheckBox", "vSCAdvanceReplace ccfcfcf checked",
            "Use custom SC advancing")
    } Else {
        optionsGUI.Add("CheckBox", "vSCAdvanceReplace ccfcfcf",
            "Use custom SC advancing")
    }
/*
    optionsGUI.Add("Text", "ccfcfcf", "Percent health remaining:")
    optionsGUI.AddEdit()
    If (IsInteger(SCPercent) && SCPercent > 0) {
        optionsGUI.Add("UpDown", "vSCPercent Range1-9999", SCPercent)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vSCPercent Range1-9999",
                Settings.defaultNobodySettings.SCPercent)
        } Else {
            optionsGUI.Add("UpDown", "vSCPercent Range1-9999",
                Settings.defaultSettings.SCPercent)
        }
    }
*/
    optionsGUI.Add("Button", "default", "Run")
    .OnEvent("Click", RunShadowCrystal)
    optionsGUI.Add("Button", "default yp", "Save and Run")
    .OnEvent("Click",
        RunSaveShadowCrystal)
    optionsGUI.Add("Button", "default yp", "Save")
    .OnEvent("Click",
        ProcessShadowCrystalSettings)
    optionsGUI.Add("Button", "default yp", "Cancel")
    .OnEvent("Click",
        CloseShadowCrystalSettings)

    optionsGUI.Show("w300")

    ProcessShadowCrystalSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        ShadowCrystalSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunShadowCrystal(*) {
        optionsGUI.Hide()
        Window.Activate()
        fShadowCrystalStart()
    }

    RunSaveShadowCrystal(*) {
        ShadowCrystalSave()
        optionsGUI.Hide()
        Window.Activate()
        fShadowCrystalStart()
    }

    CloseShadowCrystalSettings(*) {
        optionsGUI.Hide()
    }

    ShadowCrystalSave() {
        values := optionsGUI.Submit()
        SCAdvanceReplace := values.SCAdvanceReplace
        Settings.SaveCurrentSettings()
    }
}
