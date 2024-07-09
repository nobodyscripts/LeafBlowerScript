#Requires AutoHotkey v2.0
/**
 * 
 * @param thisGui 
 * @param info 
 */
Button_Click_Leafton(thisGui, info) {
    Global settings, LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled,
        LeaftonRunOnceEnabled

    optionsGUI := Gui(, "Leafton Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    If (LeaftonCraftEnabled = true) {
        optionsGUI.Add("CheckBox", "vLeaftonCraftEnabled ccfcfcf checked",
            "Enable Leafton Crafting")
    } Else {
        optionsGUI.Add("CheckBox", "vLeaftonCraftEnabled ccfcfcf",
            "Enable Leafton Crafting")
    }

    If (LeaftonSpamsWind = true) {
        optionsGUI.Add("CheckBox", "vLeaftonSpamsWind ccfcfcf checked",
            "Enable Wind Spammer")
    } Else {
        optionsGUI.Add("CheckBox", "vLeaftonSpamsWind ccfcfcf",
            "Enable Wind Spammer")
    }

    If (LeaftonBanksEnabled = true) {
        optionsGUI.Add("CheckBox", "vLeaftonBanksEnabled ccfcfcf checked",
            "Enable Banks")
    } Else {
        optionsGUI.Add("CheckBox", "vLeaftonBanksEnabled ccfcfcf",
            "Enable Banks")
    }

    If (LeaftonRunOnceEnabled = true) {
        optionsGUI.Add("CheckBox", "vLeaftonRunOnceEnabled ccfcfcf checked",
            "Enable Leafton Run Once")
    } Else {
        optionsGUI.Add("CheckBox", "vLeaftonRunOnceEnabled ccfcfcf",
            "Enable Leafton Run Once")
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunLeafton)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveLeafton)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessLeaftonSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseLeaftonSettings)

    optionsGUI.Show("w300")

    ProcessLeaftonSettings(*) {
        LeaftonSave()
    }

    RunLeafton(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fLeaftonStart()
    }

    RunSaveLeafton(*) {
        LeaftonSave()
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
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
        settings.SaveCurrentSettings()
    }
}