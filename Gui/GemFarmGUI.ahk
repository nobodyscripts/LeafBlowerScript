#Requires AutoHotkey v2.0

Button_Click_GemFarm(thisGui, info) {

    GemFarmSleepAmount := S.Get("GemFarmSleepAmount")
    GemFarmCollectArtifacts := S.Get("GemFarmCollectArtifacts")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Gem Suitcase Farm Settings")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()

    MyGui.Add("Text", "", "Delay between refreshes (ms):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(GemFarmSleepAmount) && GemFarmSleepAmount > 0) {
        MyGui.Add("UpDown", "vGemFarmSleepAmount Range1-9999",
            GemFarmSleepAmount)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vGemFarmSleepAmount Range1-9999",
                S.defaultNobodySettings.GemFarmSleepAmount)
        } Else {
            MyGui.Add("UpDown", "vGemFarmSleepAmount Range1-9999",
                S.defaultSettings.GemFarmSleepAmount)
        }
    }
    
    checked := (GemFarmCollectArtifacts) ? " checked" : ""
    MyGui.Add("CheckBox", "vGemFarmCollectArtifacts" checked,
        "Enable Collection of Artifacts")

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunGemFarm)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveGemFarm)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessGemFarmSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseGemFarmSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessGemFarmSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        GemFarmSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunGemFarm(*) {
        MyGui.Hide()
        fGemFarmStart()
    }

    RunSaveGemFarm(*) {
        GemFarmSave()
        MyGui.Hide()
        fGemFarmStart()
    }

    CloseGemFarmSettings(*) {
        MyGui.Hide()
    }

    GemFarmSave() {
        values := MyGui.Submit()
        S.Set("GemFarmSleepAmount", values.GemFarmSleepAmount)
        S.Set("GemFarmCollectArtifacts", values.GemFarmCollectArtifacts)
        S.SaveCurrentSettings()
    }
}
