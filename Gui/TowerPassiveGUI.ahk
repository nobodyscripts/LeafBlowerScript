#Requires AutoHotkey v2.0

Button_Click_TowerPassive(thisGui, info) {
    Global settings, TowerPassiveBanksEnabled, TowerPassiveCraftEnabled,
        TowerPassiveTravelEnabled

    /** @type {GUI} */
    optionsGUI := Gui(, "Tower Passive Mode Settings")
    optionsGUI.Opt("")
    optionsGUI.BackColor := "0c0018"

    If (TowerPassiveBanksEnabled = true) {
        optionsGUI.Add("CheckBox", "vTowerPassiveBanksEnabled ccfcfcf checked",
            "Enable Banks")
    } Else {
        optionsGUI.Add("CheckBox", "vTowerPassiveBanksEnabled ccfcfcf",
            "Enable Banks")
    }

    If (TowerPassiveCraftEnabled = true) {
        optionsGUI.Add("CheckBox", "vTowerPassiveCraftEnabled ccfcfcf checked",
            "Enable Crafting")
    } Else {
        optionsGUI.Add("CheckBox", "vTowerPassiveCraftEnabled ccfcfcf",
            "Enable Crafting")
    }

    If (TowerPassiveTravelEnabled = true) {
        optionsGUI.Add("CheckBox", "vTowerPassiveTravelEnabled ccfcfcf checked",
            "Enable Travel to zone")
    } Else {
        optionsGUI.Add("CheckBox", "vTowerPassiveTravelEnabled ccfcfcf",
            "Enable Travel to zone")
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunTowerPassive
    )
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessTowerPassiveSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseTowerPassiveSettings)

    optionsGUI.AddText("w180 h1", "")

    ShowGUIPosition(optionsGUI)
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
