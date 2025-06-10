#Requires AutoHotkey v2.0

Button_Click_Claw(thisGui, info) {

    ClawCheckSizeOffset := S.Get("ClawCheckSizeOffset")
    ClawFindAny := S.Get("ClawFindAny")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Claw Farm Settings")
    MyGui.SetUserFontSettings()

    MyGui.Add("Text", "", "Claw Area Check Size Offset (px):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(ClawCheckSizeOffset) || IsFloat(ClawCheckSizeOffset)) {
        MyGui.Add("UpDown", "vClawCheckSizeOffset Range-999-999",
            ClawCheckSizeOffset)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vClawCheckSizeOffset Range-999-9999",
                S.defaultNobodySettings.ClawCheckSizeOffset)
        } Else {
            MyGui.Add("UpDown", "vClawCheckSizeOffset Range-999-9999",
                S.defaultSettings.ClawCheckSizeOffset)
        }
    }

    If (ClawFindAny = true) {
        MyGui.Add("CheckBox", "vClawFindAny checked",
            "Enable Find any fallback")
    } Else {
        MyGui.Add("CheckBox", "vClawFindAny",
            "Enable Find any fallback")
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunClaw)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveClaw)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessClawSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseClawSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessClawSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        ClawSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunClaw(*) {
        MyGui.Hide()
        fClawStart()
    }

    RunSaveClaw(*) {
        ClawSave()
        MyGui.Hide()
        fClawStart()
    }

    CloseClawSettings(*) {
        MyGui.Hide()
    }

    ClawSave() {
        values := MyGui.Submit()
        S.Set("ClawCheckSizeOffset", values.ClawCheckSizeOffset)
        S.Set("ClawFindAny", values.ClawFindAny)
        S.SaveCurrentSettings()
    }
}
