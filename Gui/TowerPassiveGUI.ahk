#Requires AutoHotkey v2.0

Button_Click_TowerPassive(thisGui, info) {
    Global settings, TowerPassiveBanksEnabled, TowerPassiveCraftEnabled

    optionsGUI := Gui(, "Tower Passive Mode Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
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

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunTowerPassive
    )
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessTowerPassiveSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseTowerPassiveSettings)

    optionsGUI.Show("w300")

    ProcessTowerPassiveSettings(*) {
        values := optionsGUI.Submit()
        TowerPassiveBanksEnabled := values.TowerPassiveBanksEnabled
        TowerPassiveCraftEnabled := values.TowerPassiveCraftEnabled
        settings.SaveCurrentSettings()
    }

    RunTowerPassive(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fTowerPassiveStart()
    }

    CloseTowerPassiveSettings(*) {
        optionsGUI.Hide()
    }
}