#Requires AutoHotkey v2.0
/**
 * 
 * @param thisGui 
 * @param info 
 */
Button_Click_Leafton(thisGui, info) {
    global settings, LeaftonCraftEnabled, LeaftonSpamsWind, LeaftonBanksEnabled,
        LeaftonRunOnceEnabled

    optionsGUI := Gui(, "Leafton Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    if (LeaftonCraftEnabled = true) {
        optionsGUI.Add("CheckBox", "vLeaftonCraftEnabled ccfcfcf checked", "Enable Leafton Crafting")
    } else {
        optionsGUI.Add("CheckBox", "vLeaftonCraftEnabled ccfcfcf", "Enable Leafton Crafting")
    }

    if (LeaftonSpamsWind = true) {
        optionsGUI.Add("CheckBox", "vLeaftonSpamsWind ccfcfcf checked", "Enable Wind Spammer")
    } else {
        optionsGUI.Add("CheckBox", "vLeaftonSpamsWind ccfcfcf", "Enable Wind Spammer")
    }

    if (LeaftonBanksEnabled = true) {
        optionsGUI.Add("CheckBox", "vLeaftonBanksEnabled ccfcfcf checked", "Enable Banks")
    } else {
        optionsGUI.Add("CheckBox", "vLeaftonBanksEnabled ccfcfcf", "Enable Banks")
    }

    if (LeaftonRunOnceEnabled = true) {
        optionsGUI.Add("CheckBox", "vLeaftonRunOnceEnabled ccfcfcf checked", "Enable Leafton Run Once")
    } else {
        optionsGUI.Add("CheckBox", "vLeaftonRunOnceEnabled ccfcfcf", "Enable Leafton Run Once")
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunLeafton)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click", RunSaveLeafton)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click", ProcessLeaftonSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseLeaftonSettings)

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