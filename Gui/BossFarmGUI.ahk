#Requires AutoHotkey v2.0

Button_Click_BossFarm(thisGui, info) {
    global settings, BossFarmUsesWind, BossFarmUsesWobblyWings,
        ArtifactSleepAmount, WobblyWingsSleepAmount

    optionsGUI := Gui(, "Boss Farm Mode Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    if (BossFarmUsesWind = true) {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWind ccfcfcf checked", "Enable Wind Artifact")
    } else {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWind ccfcfcf", "Enable Wind Artifact")
    }

    if (BossFarmUsesWobblyWings = true) {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWobblyWings ccfcfcf checked", "Enable Wobbly Wings Artifact")
    } else {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWobblyWings ccfcfcf", "Enable Wobbly Wings Artifact")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Delay between artifact use (ms)")
    optionsGUI.AddEdit()
    If (IsInteger(ArtifactSleepAmount) && ArtifactSleepAmount > 0) {
        optionsGUI.Add("UpDown", "vArtifactSleepAmount Range1-9999",
            ArtifactSleepAmount)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vArtifactSleepAmount Range1-9999",
                settings.defaultNobodySettings.ArtifactSleepAmount)
        } else {
            optionsGUI.Add("UpDown", "vArtifactSleepAmount Range1-9999",
                settings.defaultSettings.ArtifactSleepAmount)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf", "Delay between Wobbly Wings use (ms)")
    optionsGUI.AddEdit()
    If (IsInteger(WobblyWingsSleepAmount) && WobblyWingsSleepAmount > 0) {
        optionsGUI.Add("UpDown", "vWobblyWingsSleepAmount Range1-9999",
        WobblyWingsSleepAmount)
    } else {
        if (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vWobblyWingsSleepAmount Range1-9999",
                settings.defaultNobodySettings.WobblyWingsSleepAmount)
        } else {
            optionsGUI.Add("UpDown", "vWobblyWingsSleepAmount Range1-9999",
                settings.defaultSettings.WobblyWingsSleepAmount)
        }
    }
    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunTowerPassive)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click", ProcessTowerPassiveSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseTowerPassiveSettings)

    optionsGUI.Show("w300")

    ProcessTowerPassiveSettings(*) {
        values := optionsGUI.Submit()
        BossFarmUsesWind := values.BossFarmUsesWind
        BossFarmUsesWobblyWings := values.BossFarmUsesWobblyWings
        ArtifactSleepAmount := values.ArtifactSleepAmount
        WobblyWingsSleepAmount := values.WobblyWingsSleepAmount
        settings.SaveCurrentSettings()
    }

    RunTowerPassive(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fBossFarmStart()
    }

    CloseTowerPassiveSettings(*) {
        optionsGUI.Hide()
    }
}