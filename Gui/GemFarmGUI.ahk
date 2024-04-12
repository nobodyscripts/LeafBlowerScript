#Requires AutoHotkey v2.0

Button_Click_GemFarm(thisGui, info) {
    global Settings, GemFarmSleepAmount

    optionsGUI := Gui(, "Gem Suitcase Farm Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    optionsGUI.Add("Text", "ccfcfcf", "Delay between refreshes (ms):")
    optionsGUI.AddEdit()
    If (IsInteger(GemFarmSleepAmount) && GemFarmSleepAmount > 0) {
        optionsGUI.Add("UpDown", "vGemFarmSleepAmount Range1-9999",
        GemFarmSleepAmount)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vGemFarmSleepAmount Range1-9999",
                settings.defaultNobodySettings.GemFarmSleepAmount)
        } else {
            optionsGUI.Add("UpDown", "vGemFarmSleepAmount Range1-9999",
                settings.defaultSettings.GemFarmSleepAmount)
        }
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunGemFarm)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click", ProcessGemFarmSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseGemFarmSettings)

    optionsGUI.Show("w300")

    ProcessGemFarmSettings(*) {
        values := optionsGUI.Submit()
        GemFarmSleepAmount := values.GemFarmSleepAmount
        settings.SaveCurrentSettings()
    }

    RunGemFarm(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fGemFarmStart()
        optionsGUI.Hide()
    }

    CloseGemFarmSettings(*) {
        optionsGUI.Hide()
    }
}
