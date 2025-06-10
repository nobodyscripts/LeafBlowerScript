#Requires AutoHotkey v2.0

Button_Click_GFSS(thisGui, info) {

    GFToKillPerCycle := S.Get("GFToKillPerCycle")
    SSToKillPerCycle := S.Get("SSToKillPerCycle")
    GFSSNoReset := S.Get("GFSSNoReset")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "GF/SS Bossfarm Settings")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()

    MyGui.Add("Text", "", "GF To Kill Per Cycle:")
    MyGui.AddEdit("cDefault")
    If (IsInteger(GFToKillPerCycle) && GFToKillPerCycle > 0) {
        MyGui.Add("UpDown", "vGFToKillPerCycle Range1-9999",
            GFToKillPerCycle)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vGFToKillPerCycle Range1-9999", S.defaultNobodySettings
                .GFToKillPerCycle)
        } Else {
            MyGui.Add("UpDown", "vGFToKillPerCycle Range1-9999", S.defaultSettings
                .GFToKillPerCycle)
        }
    }

    MyGui.Add("Text", "", "SS To Kill Per Cycle:")
    MyGui.AddEdit("cDefault")
    If (IsInteger(SSToKillPerCycle) && SSToKillPerCycle > 0) {
        MyGui.Add("UpDown", "vSSToKillPerCycle Range0-9999",
            SSToKillPerCycle)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vSSToKillPerCycle Range0-9999", S.defaultNobodySettings
                .SSToKillPerCycle)
        } Else {
            MyGui.Add("UpDown", "vSSToKillPerCycle Range0-9999", S.defaultSettings
                .SSToKillPerCycle)
        }
    }

    If (GFSSNoReset = true) {
        MyGui.Add("CheckBox", "vGFSSNoReset checked",
            "Disable resetting kill count")
    } Else {
        MyGui.Add("CheckBox", "vGFSSNoReset",
            "Disable resetting kill count")
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunGFSS)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveGFSS)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessGFSSSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseGFSSSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessGFSSSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        GFSSSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunGFSS(*) {
        MyGui.Hide()
        fGFSSStart()
    }

    RunSaveGFSS(*) {
        GFSSSave()
        MyGui.Hide()
        fGFSSStart()
    }

    CloseGFSSSettings(*) {
        MyGui.Hide()
    }

    GFSSSave() {
        values := MyGui.Submit()
        S.Set("GFToKillPerCycle", values.GFToKillPerCycle)
        S.Set("SSToKillPerCycle", values.SSToKillPerCycle)
        S.Set("GFSSNoReset", values.GFSSNoReset)

        S.SaveCurrentSettings()
    }
}
