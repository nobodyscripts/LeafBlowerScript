#Requires AutoHotkey v2.0

Button_Click_BossFarm(thisGui, info) {
    Global settings, BossFarmUsesWind, BossFarmUsesWobblyWings,
        ArtifactSleepAmount, WobblyWingsSleepAmount, BossFarmUsesSeeds,
        BrewEnableArtifacts, BrewEnableEquipment, BrewEnableMaterials,
        BrewEnableScrolls, BrewEnableCardParts, BossFarmFast

    /** @type {GUI} */
    optionsGUI := Gui(, "Boss Farm Mode Settings")
    optionsGUI.Opt("+MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    If (BossFarmUsesWind = true) {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWind ccfcfcf checked",
            "Enable Wind Artifact")
    } Else {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWind ccfcfcf",
            "Enable Wind Artifact")
    }

    If (BossFarmUsesWobblyWings = true) {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWobblyWings ccfcfcf checked",
            "Enable Wobbly Wings Artifact")
    } Else {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWobblyWings ccfcfcf",
            "Enable Wobbly Wings Artifact")
    }

    If (BossFarmUsesSeeds = true) {
        optionsGUI.Add("CheckBox", "vBossFarmUsesSeeds ccfcfcf checked",
            "Enable Seed Bag Artifact")
    } Else {
        optionsGUI.Add("CheckBox", "vBossFarmUsesSeeds ccfcfcf",
            "Enable Seed Bag Artifact")
    }

    If (BossFarmFast = true) {
        optionsGUI.Add("CheckBox", "vBossFarmFast ccfcfcf checked",
            "Enable Fast Artifact Use")
    } Else {
        optionsGUI.Add("CheckBox", "vBossFarmFast ccfcfcf",
            "Enable Fast Artifact Use")
    }
    
    optionsGUI.Add("Text", "ccfcfcf", "Delay between artifact use (ms):")
    optionsGUI.AddEdit()
    If (IsInteger(ArtifactSleepAmount) && ArtifactSleepAmount > 0) {
        optionsGUI.Add("UpDown", "vArtifactSleepAmount Range1-9999",
            ArtifactSleepAmount)
    } Else {
        If (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vArtifactSleepAmount Range1-9999",
                settings.defaultNobodySettings.ArtifactSleepAmount)
        } Else {
            optionsGUI.Add("UpDown", "vArtifactSleepAmount Range1-9999",
                settings.defaultSettings.ArtifactSleepAmount)
        }
    }

    optionsGUI.Add("Text", "ccfcfcf", "Delay between Wobbly Wings use (ms):")
    optionsGUI.AddEdit()
    If (IsInteger(WobblyWingsSleepAmount) && WobblyWingsSleepAmount > 0) {
        optionsGUI.Add("UpDown", "vWobblyWingsSleepAmount Range1-9999",
            WobblyWingsSleepAmount)
    } Else {
        If (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vWobblyWingsSleepAmount Range1-9999",
                settings.defaultNobodySettings.WobblyWingsSleepAmount)
        } Else {
            optionsGUI.Add("UpDown", "vWobblyWingsSleepAmount Range1-9999",
                settings.defaultSettings.WobblyWingsSleepAmount)
        }
    }

    If (BrewEnableArtifacts = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableArtifacts ccfcfcf checked",
            "Enable Brew Artifacts")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableArtifacts ccfcfcf",
            "Enable Brew Artifacts")
    }

    If (BrewEnableEquipment = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableEquipment ccfcfcf checked",
            "Enable Brew Equipment")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableEquipment ccfcfcf",
            "Enable Brew Equipment")
    }

    If (BrewEnableMaterials = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableMaterials ccfcfcf checked",
            "Enable Brew Materials")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableMaterials ccfcfcf",
            "Enable Brew Materials")
    }

    If (BrewEnableScrolls = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableScrolls ccfcfcf checked",
            "Enable Brew Scrolls")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableScrolls ccfcfcf",
            "Enable Brew Scrolls")
    }

    If (BrewEnableCardParts = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableCardParts ccfcfcf checked",
            "Enable Brew Card Parts")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableCardParts ccfcfcf",
            "Enable Brew Card Parts")
    }

    optionsGUI.Add("Text", "ccfcfcf x10", "Normal boss farm:")
    optionsGUI.Add("Button", "default x15", "Run").OnEvent("Click", RunBossFarm
    )
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarm)

    optionsGUI.Add("Text", "ccfcfcf x10", "With brew mode:")
    optionsGUI.Add("Button", "default x15", "Run").OnEvent("Click",
        RunBossFarmBrew)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarmBrew)

    optionsGUI.Add("Text", "ccfcfcf x10", "With borbs mode:")
    optionsGUI.Add("Button", "default x15", "Run").OnEvent("Click",
        RunBossFarmBorbs)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarmBorbs)

    optionsGUI.Add("Text", "ccfcfcf x10", "With cards mode:")
    optionsGUI.Add("Button", "default x15", "Run").OnEvent("Click",
        RunBossFarmCards)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarmCards)

    optionsGUI.Add("Text", "ccfcfcf x10", "General:")
    optionsGUI.Add("Button", "default x15", "Save").OnEvent("Click",
        ProcessBossFarmSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseBossFarmSettings)

    optionsGUI.Show("w300")

    ProcessBossFarmSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        BossFarmSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunBossFarm(*) {
        optionsGUI.Hide()
        Window.Activate()
        fBossFarmStart(0)
    }

    RunSaveBossFarm(*) {
        BossFarmSave()
        RunBossFarm()
    }

    RunBossFarmBrew(*) {
        optionsGUI.Hide()
        Window.Activate()
        fBossFarmStart(1)
    }

    RunSaveBossFarmBrew(*) {
        BossFarmSave()
        RunBossFarmBrew()
    }

    RunBossFarmBorbs(*) {
        optionsGUI.Hide()
        Window.Activate()
        fBossFarmStart(2)
    }

    RunSaveBossFarmBorbs(*) {
        BossFarmSave()
        RunBossFarmBorbs()
    }

    RunBossFarmCards(*) {
        optionsGUI.Hide()
        Window.Activate()
        fBossFarmStart(3)
    }

    RunSaveBossFarmCards(*) {
        BossFarmSave()
        RunBossFarmCards()
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
        BossFarmFast := values.BossFarmFast
        BrewEnableArtifacts := values.BrewEnableArtifacts
        BrewEnableEquipment := values.BrewEnableEquipment
        BrewEnableMaterials := values.BrewEnableMaterials
        BrewEnableScrolls := values.BrewEnableScrolls
        BrewEnableCardParts := values.BrewEnableCardParts
        settings.SaveCurrentSettings()
    }
}
