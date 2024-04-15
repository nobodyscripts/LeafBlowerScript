#Requires AutoHotkey v2.0

Button_Click_BossFarm(thisGui, info) {
    global settings, BossFarmUsesWind, BossFarmUsesWobblyWings,
        ArtifactSleepAmount, WobblyWingsSleepAmount, BossFarmUsesSeeds

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

    if (BossFarmUsesSeeds = true) {
        optionsGUI.Add("CheckBox", "vBossFarmUsesSeeds ccfcfcf checked", "Enable Seed Bag Artifact")
    } else {
        optionsGUI.Add("CheckBox", "vBossFarmUsesSeeds ccfcfcf", "Enable Seed Bag Artifact")
    }
    
    optionsGUI.Add("Text", "ccfcfcf", "Delay between artifact use (ms):")
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

    optionsGUI.Add("Text", "ccfcfcf", "Delay between Wobbly Wings use (ms):")
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
    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunBossFarm)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click", RunSaveBossFarm)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click", ProcessBossFarmSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseBossFarmSettings)

    optionsGUI.Show("w300")

    ProcessBossFarmSettings(*) {
        BossFarmSave()
    }

    RunBossFarm(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fBossFarmStart()
    }


    RunSaveBossFarm(*) {
        BossFarmSave()
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fBossFarmStart()
    }

    CloseBossFarmSettings(*) {
        optionsGUI.Hide()
    }

    BossFarmSave() {
        values := optionsGUI.Submit()
        BossFarmUsesWind := values.BossFarmUsesWind
        BossFarmUsesWobblyWings := values.BossFarmUsesWobblyWings
        ArtifactSleepAmount := values.ArtifactSleepAmount
        WobblyWingsSleepAmount := values.WobblyWingsSleepAmount
        BossFarmUsesSeeds := values.BossFarmUsesSeeds
        settings.SaveCurrentSettings()
    }
}