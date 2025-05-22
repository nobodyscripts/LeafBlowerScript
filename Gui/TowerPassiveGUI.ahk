#Requires AutoHotkey v2.0

Button_Click_TowerPassive(thisGui, info) {
    Global settings, TowerPassiveBanksEnabled, TowerPassiveCraftEnabled,
        TowerPassiveTravelEnabled

    /** @type {GUI} */
    optionsGUI := Gui(, "Tower Passive Mode Settings")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    If (TowerPassiveBanksEnabled = true) {
        optionsGUI.Add("CheckBox", "vTowerPassiveBanksEnabled checked",
            "Enable Banks")
    } Else {
        optionsGUI.Add("CheckBox", "vTowerPassiveBanksEnabled",
            "Enable Banks")
    }

    If (TowerPassiveCraftEnabled = true) {
        optionsGUI.Add("CheckBox", "vTowerPassiveCraftEnabled checked",
            "Enable Crafting")
    } Else {
        optionsGUI.Add("CheckBox", "vTowerPassiveCraftEnabled",
            "Enable Crafting")
    }

    If (TowerPassiveTravelEnabled = true) {
        optionsGUI.Add("CheckBox", "vTowerPassiveTravelEnabled checked",
            "Enable Travel to zone")
    } Else {
        optionsGUI.Add("CheckBox", "vTowerPassiveTravelEnabled",
            "Enable Travel to zone")
    }

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunTowerPassive
    )
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessTowerPassiveSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseTowerPassiveSettings)

    optionsGUI.AddText("w180 h1", "")

    ShowGUIPosition(optionsGUI)
    MakeGUIResizableIfOversize(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessTowerPassiveSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        values := optionsGUI.Submit()
        TowerPassiveBanksEnabled := values.TowerPassiveBanksEnabled
        TowerPassiveCraftEnabled := values.TowerPassiveCraftEnabled
        TowerPassiveTravelEnabled := values.TowerPassiveTravelEnabled
        settings.SaveCurrentSettings()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunTowerPassive(*) {
        optionsGUI.Hide()
        Window.Activate()
        fTowerPassiveStart()
    }

    CloseTowerPassiveSettings(*) {
        optionsGUI.Hide()
    }
}
