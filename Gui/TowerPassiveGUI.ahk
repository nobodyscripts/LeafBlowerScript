#Requires AutoHotkey v2.0

Button_Click_TowerPassive(thisGui, info) {
    TowerPassiveBanksEnabled := S.Get("TowerPassiveBanksEnabled")
    TowerPassiveCraftEnabled := S.Get("TowerPassiveCraftEnabled")
    TowerPassiveTravelEnabled := S.Get("TowerPassiveTravelEnabled")
    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Tower Passive Mode Settings")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()

    If (TowerPassiveBanksEnabled = true) {
        MyGui.Add("CheckBox", "vTowerPassiveBanksEnabled checked",
            "Enable Banks")
    } Else {
        MyGui.Add("CheckBox", "vTowerPassiveBanksEnabled",
            "Enable Banks")
    }

    If (TowerPassiveCraftEnabled = true) {
        MyGui.Add("CheckBox", "vTowerPassiveCraftEnabled checked",
            "Enable Crafting")
    } Else {
        MyGui.Add("CheckBox", "vTowerPassiveCraftEnabled",
            "Enable Crafting")
    }

    If (TowerPassiveTravelEnabled = true) {
        MyGui.Add("CheckBox", "vTowerPassiveTravelEnabled checked",
            "Enable Travel to zone")
    } Else {
        MyGui.Add("CheckBox", "vTowerPassiveTravelEnabled",
            "Enable Travel to zone")
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunTowerPassive
    )
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessTowerPassiveSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseTowerPassiveSettings)

    MyGui.AddText("w180 h1", "")

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessTowerPassiveSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        values := MyGui.Submit()
        S.Set("TowerPassiveBanksEnabled", values.TowerPassiveBanksEnabled)
        S.Set("TowerPassiveCraftEnabled", values.TowerPassiveCraftEnabled)
        S.Set("TowerPassiveTravelEnabled", values.TowerPassiveTravelEnabled)
        S.SaveCurrentSettings()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunTowerPassive(*) {
        MyGui.Hide()
        fTowerPassiveStart()
    }

    CloseTowerPassiveSettings(*) {
        MyGui.Hide()
    }
}
