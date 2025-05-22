#Requires AutoHotkey v2.0
/**
 * 
 * @param thisGui 
 * @param info 
 */
Button_Click_Leafton(thisGui, info) {
    Global settings, LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled,
        LeaftonRunOnceEnabled, LeaftonEnableBrewing, LeaftonBrewCycleTime,
        LeaftonBrewCutOffTime

    /** @type {GUI} */
    optionsGUI := Gui(, "Leafton Settings")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    If (LeaftonCraftEnabled = true) {
        optionsGUI.Add("CheckBox", "vLeaftonCraftEnabled checked",
            "Enable Leafton Crafting")
    } Else {
        optionsGUI.Add("CheckBox", "vLeaftonCraftEnabled",
            "Enable Leafton Crafting")
    }

    If (LeaftonSpamsWind = true) {
        optionsGUI.Add("CheckBox", "vLeaftonSpamsWind checked",
            "Enable Wind Spammer")
    } Else {
        optionsGUI.Add("CheckBox", "vLeaftonSpamsWind",
            "Enable Wind Spammer")
    }

    If (LeaftonBanksEnabled = true) {
        optionsGUI.Add("CheckBox", "vLeaftonBanksEnabled checked",
            "Enable Banks")
    } Else {
        optionsGUI.Add("CheckBox", "vLeaftonBanksEnabled",
            "Enable Banks")
    }

    If (LeaftonRunOnceEnabled = true) {
        optionsGUI.Add("CheckBox", "vLeaftonRunOnceEnabled checked",
            "Enable Leafton Run Once")
    } Else {
        optionsGUI.Add("CheckBox", "vLeaftonRunOnceEnabled",
            "Enable Leafton Run Once")
    }

    If (LeaftonEnableBrewing = true) {
        optionsGUI.Add("CheckBox", "vLeaftonEnableBrewing checked",
            "Enable Leafton Brewing")
    } Else {
        optionsGUI.Add("CheckBox", "vLeaftonEnableBrewing",
            "Enable Leafton Brewing")
    }

    optionsGUI.Add("Text", "", "Leafton Brew Cycle Time (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(LeaftonBrewCycleTime) && LeaftonBrewCycleTime > 0) {
        optionsGUI.Add("UpDown", "vLeaftonBrewCycleTime Range1-9999",
            LeaftonBrewCycleTime)
    } Else {
        If (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vLeaftonBrewCycleTime Range1-9999",
                settings.defaultNobodySettings.LeaftonBrewCycleTime)
        } Else {
            optionsGUI.Add("UpDown", "vLeaftonBrewCycleTime Range1-9999",
                settings.defaultSettings.LeaftonBrewCycleTime)
        }
    }

    optionsGUI.Add("Text", "", "Leafton Brew Period Cutoff (s):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(LeaftonBrewCutOffTime) && LeaftonBrewCutOffTime > 0) {
        optionsGUI.Add("UpDown", "vLeaftonBrewCutOffTime Range1-9999",
            LeaftonBrewCutOffTime)
    } Else {
        If (settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vLeaftonBrewCutOffTime Range1-9999",
                settings.defaultNobodySettings.LeaftonBrewCutOffTime)
        } Else {
            optionsGUI.Add("UpDown", "vLeaftonBrewCutOffTime Range1-9999",
                settings.defaultSettings.LeaftonBrewCutOffTime)
        }
    }

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunLeafton)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveLeafton)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessLeaftonSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseLeaftonSettings)

    ShowGUIPosition(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessLeaftonSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        LeaftonSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunLeafton(*) {
        optionsGUI.Hide()
        Window.Activate()
        fLeaftonStart()
    }

    RunSaveLeafton(*) {
        LeaftonSave()
        optionsGUI.Hide()
        Window.Activate()
        fLeaftonStart()
    }

    CloseLeaftonSettings(*) {
        optionsGUI.Hide()
    }

    LeaftonSave() {
        values := optionsGUI.Submit()
        LeaftonCraftEnabled := values.LeaftonCraftEnabled
        LeaftonSpamsWind := values.LeaftonSpamsWind
        LeaftonBanksEnabled := values.LeaftonBanksEnabled
        LeaftonRunOnceEnabled := values.LeaftonRunOnceEnabled
        LeaftonEnableBrewing := values.LeaftonEnableBrewing
        LeaftonBrewCycleTime := values.LeaftonBrewCycleTime
        LeaftonBrewCutOffTime := values.LeaftonBrewCutOffTime
        settings.SaveCurrentSettings()
    }
}
