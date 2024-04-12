#Requires AutoHotkey v2.0

/* GFToKillPerCycle=2
SSToKillPerCycle=1
GFSSNoReset=false */

Button_Click_GFSS(thisGui, info) {
    global Settings, GFToKillPerCycle, SSToKillPerCycle,
    GFSSNoReset

    optionsGUI := Gui(, "GF/SS Bossfarm Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    optionsGUI.Add("Text", "ccfcfcf", "GF To Kill Per Cycle:")
    optionsGUI.AddEdit()
    If (IsInteger(GFToKillPerCycle) && GFToKillPerCycle > 0) {
        optionsGUI.Add("UpDown", "vGFToKillPerCycle Range1-9999",
        GFToKillPerCycle)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vGFToKillPerCycle Range1-9999",
                settings.defaultNobodySettings.GFToKillPerCycle)
        } else {
            optionsGUI.Add("UpDown", "vGFToKillPerCycle Range1-9999",
                settings.defaultSettings.GFToKillPerCycle)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf", "SS To Kill Per Cycle:")
    optionsGUI.AddEdit()
    If (IsInteger(SSToKillPerCycle) && SSToKillPerCycle > 0) {
        optionsGUI.Add("UpDown", "vSSToKillPerCycle Range0-9999",
        SSToKillPerCycle)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vSSToKillPerCycle Range0-9999",
                settings.defaultNobodySettings.SSToKillPerCycle)
        } else {
            optionsGUI.Add("UpDown", "vSSToKillPerCycle Range0-9999",
                settings.defaultSettings.SSToKillPerCycle)
        }
    }

    if (GFSSNoReset = true) {
        optionsGUI.Add("CheckBox", "vGFSSNoReset ccfcfcf checked", "Disable resetting kill count")
    } else {
        optionsGUI.Add("CheckBox", "vGFSSNoReset ccfcfcf", "Disable resetting kill count")
    }


    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunMine)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click", ProcessMineSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseMineSettings)

    optionsGUI.Show("w300")

    ProcessMineSettings(*) {
        values := optionsGUI.Submit()
        GFToKillPerCycle := values.GFToKillPerCycle
        SSToKillPerCycle := values.SSToKillPerCycle
        GFSSNoReset := values.GFSSNoReset
  
        settings.SaveCurrentSettings()
    }

    RunMine(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fGFSSStart()
    }

    CloseMineSettings(*) {
        optionsGUI.Hide()
    }
}