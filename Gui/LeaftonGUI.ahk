#Requires AutoHotkey v2.0
/**
 * 
 * @param thisGui 
 * @param info 
 */
Button_Click_Leafton(thisGui, info) {

    LeaftonCraftEnabled := S.Get("LeaftonCraftEnabled")
    LeaftonSpamsWind := S.Get("LeaftonSpamsWind")
    LeaftonBanksEnabled := S.Get("LeaftonBanksEnabled")
    LeaftonRunOnceEnabled := S.Get("LeaftonRunOnceEnabled")
    LeaftonEnableBrewing := S.Get("LeaftonEnableBrewing")
    LeaftonBrewCycleTime := S.Get("LeaftonBrewCycleTime")
    LeaftonBrewCutOffTime := S.Get("LeaftonBrewCutOffTime")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Leafton Settings")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()

    If (LeaftonCraftEnabled = true) {
        MyGui.Add("CheckBox", "vLeaftonCraftEnabled checked",
            "Enable Leafton Crafting")
    } Else {
        MyGui.Add("CheckBox", "vLeaftonCraftEnabled",
            "Enable Leafton Crafting")
    }

    If (LeaftonSpamsWind = true) {
        MyGui.Add("CheckBox", "vLeaftonSpamsWind checked",
            "Enable Wind Spammer")
    } Else {
        MyGui.Add("CheckBox", "vLeaftonSpamsWind",
            "Enable Wind Spammer")
    }

    If (LeaftonBanksEnabled = true) {
        MyGui.Add("CheckBox", "vLeaftonBanksEnabled checked",
            "Enable Banks")
    } Else {
        MyGui.Add("CheckBox", "vLeaftonBanksEnabled",
            "Enable Banks")
    }

    If (LeaftonRunOnceEnabled = true) {
        MyGui.Add("CheckBox", "vLeaftonRunOnceEnabled checked",
            "Enable Leafton Run Once")
    } Else {
        MyGui.Add("CheckBox", "vLeaftonRunOnceEnabled",
            "Enable Leafton Run Once")
    }

    If (LeaftonEnableBrewing = true) {
        MyGui.Add("CheckBox", "vLeaftonEnableBrewing checked",
            "Enable Leafton Brewing")
    } Else {
        MyGui.Add("CheckBox", "vLeaftonEnableBrewing",
            "Enable Leafton Brewing")
    }

    MyGui.Add("Text", "", "Leafton Brew Cycle Time (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(LeaftonBrewCycleTime) && LeaftonBrewCycleTime > 0) {
        MyGui.Add("UpDown", "vLeaftonBrewCycleTime Range1-9999",
            LeaftonBrewCycleTime)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vLeaftonBrewCycleTime Range1-9999",
                S.defaultNobodySettings.LeaftonBrewCycleTime)
        } Else {
            MyGui.Add("UpDown", "vLeaftonBrewCycleTime Range1-9999",
                S.defaultSettings.LeaftonBrewCycleTime)
        }
    }

    MyGui.Add("Text", "", "Leafton Brew Period Cutoff (s):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(LeaftonBrewCutOffTime) && LeaftonBrewCutOffTime > 0) {
        MyGui.Add("UpDown", "vLeaftonBrewCutOffTime Range1-9999",
            LeaftonBrewCutOffTime)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vLeaftonBrewCutOffTime Range1-9999",
                S.defaultNobodySettings.LeaftonBrewCutOffTime)
        } Else {
            MyGui.Add("UpDown", "vLeaftonBrewCutOffTime Range1-9999",
                S.defaultSettings.LeaftonBrewCutOffTime)
        }
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunLeafton)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveLeafton)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessLeaftonSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseLeaftonSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessLeaftonSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        LeaftonSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunLeafton(*) {
        MyGui.Hide()
        fLeaftonStart()
    }

    RunSaveLeafton(*) {
        LeaftonSave()
        MyGui.Hide()
        fLeaftonStart()
    }

    CloseLeaftonSettings(*) {
        MyGui.Hide()
    }

    LeaftonSave() {
        values := MyGui.Submit()
        S.Set("LeaftonCraftEnabled", values.LeaftonCraftEnabled)
        S.Set("LeaftonSpamsWind", values.LeaftonSpamsWind)
        S.Set("LeaftonBanksEnabled", values.LeaftonBanksEnabled)
        S.Set("LeaftonRunOnceEnabled", values.LeaftonRunOnceEnabled)
        S.Set("LeaftonEnableBrewing", values.LeaftonEnableBrewing)
        S.Set("LeaftonBrewCycleTime", values.LeaftonBrewCycleTime)
        S.Set("LeaftonBrewCutOffTime", values.LeaftonBrewCutOffTime)
        S.SaveCurrentSettings()
    }
}
