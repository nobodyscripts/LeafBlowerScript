#Requires AutoHotkey v2.0

Button_Click_BossFarm(thisGui, info) {
    Global settings, BossFarmUsesWind, BossFarmUsesWobblyWings,
        ArtifactSleepAmount, WobblyWingsSleepAmount, BossFarmUsesSeeds,
        BrewEnableArtifacts, BrewEnableEquipment, BrewEnableMaterials,
        BrewEnableScrolls, BrewEnableCardParts, BossFarmFast

    /** @type {GUI} */
    optionsGUI := Gui(, "Boss Farm Mode Settings")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    If (BossFarmUsesWind = true) {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWind checked",
            "Enable Wind Artifact")
    } Else {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWind",
            "Enable Wind Artifact")
    }

    If (BossFarmUsesWobblyWings = true) {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWobblyWings checked",
            "Enable Wobbly Wings Artifact")
    } Else {
        optionsGUI.Add("CheckBox", "vBossFarmUsesWobblyWings",
            "Enable Wobbly Wings Artifact")
    }

    If (BossFarmUsesSeeds = true) {
        optionsGUI.Add("CheckBox", "vBossFarmUsesSeeds checked",
            "Enable Seed Bag Artifact")
    } Else {
        optionsGUI.Add("CheckBox", "vBossFarmUsesSeeds",
            "Enable Seed Bag Artifact")
    }

    If (BossFarmFast = true) {
        optionsGUI.Add("CheckBox", "vBossFarmFast checked",
            "Enable Fast Artifact Use")
    } Else {
        optionsGUI.Add("CheckBox", "vBossFarmFast",
            "Enable Fast Artifact Use")
    }

    optionsGUI.Add("Text", "", "Delay between artifact use (ms):")
    optionsGUI.AddEdit("cDefault")
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

    optionsGUI.Add("Text", "", "Delay between Wobbly Wings use (ms):")
    optionsGUI.AddEdit("cDefault")
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
        optionsGUI.Add("CheckBox", "vBrewEnableArtifacts checked",
            "Enable Brew Artifacts")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableArtifacts",
            "Enable Brew Artifacts")
    }

    If (BrewEnableEquipment = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableEquipment checked",
            "Enable Brew Equipment")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableEquipment",
            "Enable Brew Equipment")
    }

    If (BrewEnableMaterials = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableMaterials checked",
            "Enable Brew Materials")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableMaterials",
            "Enable Brew Materials")
    }

    If (BrewEnableScrolls = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableScrolls checked",
            "Enable Brew Scrolls")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableScrolls",
            "Enable Brew Scrolls")
    }

    If (BrewEnableCardParts = true) {
        optionsGUI.Add("CheckBox", "vBrewEnableCardParts checked",
            "Enable Brew Card Parts")
    } Else {
        optionsGUI.Add("CheckBox", "vBrewEnableCardParts",
            "Enable Brew Card Parts")
    }

    optionsGUI.Add("Text", "x10", "Normal boss farm:")
    optionsGUI.Add("Button", "+Background" GuiBGColour " default x15", "Run").OnEvent("Click", RunBossFarm
    )
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarm)

    optionsGUI.Add("Text", "x10", "With brew mode:")
    optionsGUI.Add("Button", "+Background" GuiBGColour " default x15", "Run").OnEvent("Click",
        RunBossFarmBrew)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarmBrew)

    optionsGUI.Add("Text", "x10", "With borbs mode:")
    optionsGUI.Add("Button", "+Background" GuiBGColour " default x15", "Run").OnEvent("Click",
        RunBossFarmBorbs)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarmBorbs)

    optionsGUI.Add("Text", "x10", "With cards mode:")
    optionsGUI.Add("Button", "+Background" GuiBGColour " default x15", "Run").OnEvent("Click",
        RunBossFarmCards)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarmCards)

    optionsGUI.Add("Text", "x10", "General:")
    optionsGUI.Add("Button", "+Background" GuiBGColour " default x15", "Save").OnEvent("Click",
        ProcessBossFarmSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseBossFarmSettings)

    ShowGUIPosition(optionsGUI)
    MakeGUIResizableIfOversize(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

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
