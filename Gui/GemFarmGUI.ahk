#Requires AutoHotkey v2.0

Button_Click_GemFarm(thisGui, info) {
    Global Settings, GemFarmSleepAmount

    /** @type {GUI} */
    optionsGUI := Gui(, "Gem Suitcase Farm Settings")
    optionsGUI.Opt("+MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"


    optionsGUI.Add("Text", "ccfcfcf", "Delay between refreshes (ms):")
    optionsGUI.AddEdit()
    If (IsInteger(GemFarmSleepAmount) && GemFarmSleepAmount > 0) {
        optionsGUI.Add("UpDown", "vGemFarmSleepAmount Range1-9999",
            GemFarmSleepAmount)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vGemFarmSleepAmount Range1-9999",
                Settings.defaultNobodySettings.GemFarmSleepAmount)
        } Else {
            optionsGUI.Add("UpDown", "vGemFarmSleepAmount Range1-9999",
                Settings.defaultSettings.GemFarmSleepAmount)
        }
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunGemFarm)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveGemFarm)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessGemFarmSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseGemFarmSettings)

    optionsGUI.Show("w300")

    ProcessGemFarmSettings(*) {
        GemFarmSave()
    }

    RunGemFarm(*) {
        optionsGUI.Hide()
        Window.Activate()
        fGemFarmStart()
    }

    RunSaveGemFarm(*) {
        GemFarmSave()
        optionsGUI.Hide()
        Window.Activate()
        fGemFarmStart()
    }

    CloseGemFarmSettings(*) {
        optionsGUI.Hide()
    }

    GemFarmSave() {
        values := optionsGUI.Submit()
        GemFarmSleepAmount := values.GemFarmSleepAmount
        Settings.SaveCurrentSettings()
    }
}