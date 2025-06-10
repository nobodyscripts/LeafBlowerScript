#Requires AutoHotkey v2.0

Button_Click_ShadowCrystal(thisGui, info) {

    SCAdvanceReplace := S.Get("SCAdvanceReplace")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Shadow Crystal Fight Settings")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()

    If (SCAdvanceReplace = true) {
        MyGui.Add("CheckBox", "vSCAdvanceReplace checked",
            "Use custom SC advancing")
    } Else {
        MyGui.Add("CheckBox", "vSCAdvanceReplace",
            "Use custom SC advancing")
    }
    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run")
    .OnEvent("Click", RunShadowCrystal)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run")
    .OnEvent("Click",
        RunSaveShadowCrystal)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save")
    .OnEvent("Click",
        ProcessShadowCrystalSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel")
    .OnEvent("Click",
        CloseShadowCrystalSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessShadowCrystalSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        ShadowCrystalSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunShadowCrystal(*) {
        MyGui.Hide()
        fShadowCrystalStart()
    }

    RunSaveShadowCrystal(*) {
        ShadowCrystalSave()
        MyGui.Hide()
        fShadowCrystalStart()
    }

    CloseShadowCrystalSettings(*) {
        MyGui.Hide()
    }

    ShadowCrystalSave() {
        values := MyGui.Submit()
        S.Set("SCAdvanceReplace", values.SCAdvanceReplace)
        S.SaveCurrentSettings()
    }
}
