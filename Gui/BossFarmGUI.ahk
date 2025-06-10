#Requires AutoHotkey v2.0

Button_Click_BossFarm(thisGui, info) {
    BossFarmUsesWind := S.Get("BossFarmUsesWind")
    BossFarmUsesWobblyWings := S.Get("BossFarmUsesWobblyWings")
    ArtifactSleepAmount := S.Get("ArtifactSleepAmount")
    WobblyWingsSleepAmount := S.Get("WobblyWingsSleepAmount")
    BossFarmUsesSeeds := S.Get("BossFarmUsesSeeds")
    BossFarmFast := S.Get("BossFarmFast")
    BrewEnableArtifacts := S.Get("BrewEnableArtifacts")
    BrewEnableEquipment := S.Get("BrewEnableEquipment")
    BrewEnableMaterials := S.Get("BrewEnableMaterials")
    BrewEnableScrolls := S.Get("BrewEnableScrolls")
    BrewEnableCardParts := S.Get("BrewEnableCardParts")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Boss Farm Mode Settings")
    MyGui.SetUserFontSettings()

    If (BossFarmUsesWind = true) {
        MyGui.Add("CheckBox", "vBossFarmUsesWind checked",
            "Enable Wind Artifact")
    } Else {
        MyGui.Add("CheckBox", "vBossFarmUsesWind",
            "Enable Wind Artifact")
    }

    If (BossFarmUsesWobblyWings = true) {
        MyGui.Add("CheckBox", "vBossFarmUsesWobblyWings checked",
            "Enable Wobbly Wings Artifact")
    } Else {
        MyGui.Add("CheckBox", "vBossFarmUsesWobblyWings",
            "Enable Wobbly Wings Artifact")
    }

    If (BossFarmUsesSeeds = true) {
        MyGui.Add("CheckBox", "vBossFarmUsesSeeds checked",
            "Enable Seed Bag Artifact")
    } Else {
        MyGui.Add("CheckBox", "vBossFarmUsesSeeds",
            "Enable Seed Bag Artifact")
    }

    If (BossFarmFast = true) {
        MyGui.Add("CheckBox", "vBossFarmFast checked",
            "Enable Fast Artifact Use")
    } Else {
        MyGui.Add("CheckBox", "vBossFarmFast",
            "Enable Fast Artifact Use")
    }

    MyGui.Add("Text", "", "Delay between artifact use (ms):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(ArtifactSleepAmount) && ArtifactSleepAmount > 0) {
        MyGui.Add("UpDown", "vArtifactSleepAmount Range1-9999",
            ArtifactSleepAmount)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vArtifactSleepAmount Range1-9999",
                S.defaultNobodySettings.ArtifactSleepAmount)
        } Else {
            MyGui.Add("UpDown", "vArtifactSleepAmount Range1-9999",
                S.defaultSettings.ArtifactSleepAmount)
        }
    }

    MyGui.Add("Text", "", "Delay between Wobbly Wings use (ms):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(WobblyWingsSleepAmount) && WobblyWingsSleepAmount > 0) {
        MyGui.Add("UpDown", "vWobblyWingsSleepAmount Range1-9999",
            WobblyWingsSleepAmount)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vWobblyWingsSleepAmount Range1-9999",
                S.defaultNobodySettings.WobblyWingsSleepAmount)
        } Else {
            MyGui.Add("UpDown", "vWobblyWingsSleepAmount Range1-9999",
                S.defaultSettings.WobblyWingsSleepAmount)
        }
    }

    If (BrewEnableArtifacts = true) {
        MyGui.Add("CheckBox", "vBrewEnableArtifacts checked",
            "Enable Brew Artifacts")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableArtifacts",
            "Enable Brew Artifacts")
    }

    If (BrewEnableEquipment = true) {
        MyGui.Add("CheckBox", "vBrewEnableEquipment checked",
            "Enable Brew Equipment")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableEquipment",
            "Enable Brew Equipment")
    }

    If (BrewEnableMaterials = true) {
        MyGui.Add("CheckBox", "vBrewEnableMaterials checked",
            "Enable Brew Materials")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableMaterials",
            "Enable Brew Materials")
    }

    If (BrewEnableScrolls = true) {
        MyGui.Add("CheckBox", "vBrewEnableScrolls checked",
            "Enable Brew Scrolls")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableScrolls",
            "Enable Brew Scrolls")
    }

    If (BrewEnableCardParts = true) {
        MyGui.Add("CheckBox", "vBrewEnableCardParts checked",
            "Enable Brew Card Parts")
    } Else {
        MyGui.Add("CheckBox", "vBrewEnableCardParts",
            "Enable Brew Card Parts")
    }

    MyGui.Add("Text", "x10", "Normal boss farm:")
    MyGui.Add("Button", "+Background" GuiBGColour " default x15", "Run").OnEvent("Click", RunBossFarm
    )
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarm)

    MyGui.Add("Text", "x10", "With brew mode:")
    MyGui.Add("Button", "+Background" GuiBGColour " default x15", "Run").OnEvent("Click",
        RunBossFarmBrew)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarmBrew)

    MyGui.Add("Text", "x10", "With borbs mode:")
    MyGui.Add("Button", "+Background" GuiBGColour " default x15", "Run").OnEvent("Click",
        RunBossFarmBorbs)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarmBorbs)

    MyGui.Add("Text", "x10", "With cards mode:")
    MyGui.Add("Button", "+Background" GuiBGColour " default x15", "Run").OnEvent("Click",
        RunBossFarmCards)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBossFarmCards)

    MyGui.Add("Text", "x10", "General:")
    MyGui.Add("Button", "+Background" GuiBGColour " default x15", "Save").OnEvent("Click",
        ProcessBossFarmSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseBossFarmSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessBossFarmSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        BossFarmSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunBossFarm(*) {
        MyGui.Hide()
        fBossFarmStart(0)
    }

    RunSaveBossFarm(*) {
        BossFarmSave()
        RunBossFarm()
    }

    RunBossFarmBrew(*) {
        MyGui.Hide()
        fBossFarmStart(1)
    }

    RunSaveBossFarmBrew(*) {
        BossFarmSave()
        RunBossFarmBrew()
    }

    RunBossFarmBorbs(*) {
        MyGui.Hide()
        fBossFarmStart(2)
    }

    RunSaveBossFarmBorbs(*) {
        BossFarmSave()
        RunBossFarmBorbs()
    }

    RunBossFarmCards(*) {
        MyGui.Hide()
        fBossFarmStart(3)
    }

    RunSaveBossFarmCards(*) {
        BossFarmSave()
        RunBossFarmCards()
    }

    CloseBossFarmSettings(*) {
        MyGui.Hide()
    }

    BossFarmSave() {
        values := MyGui.Submit()
        S.Set("BossFarmUsesWind", values.BossFarmUsesWind)
        S.Set("BossFarmUsesWobblyWings", values.BossFarmUsesWobblyWings)
        S.Set("ArtifactSleepAmount", values.ArtifactSleepAmount)
        S.Set("WobblyWingsSleepAmount", values.WobblyWingsSleepAmount)
        S.Set("BossFarmUsesSeeds", values.BossFarmUsesSeeds)
        S.Set("BossFarmFast", values.BossFarmFast)
        S.Set("BrewEnableArtifacts", values.BrewEnableArtifacts)
        S.Set("BrewEnableEquipment", values.BrewEnableEquipment)
        S.Set("BrewEnableMaterials", values.BrewEnableMaterials)
        S.Set("BrewEnableScrolls", values.BrewEnableScrolls)
        S.Set("BrewEnableCardParts", values.BrewEnableCardParts)
        S.SaveCurrentSettings()
    }
}
