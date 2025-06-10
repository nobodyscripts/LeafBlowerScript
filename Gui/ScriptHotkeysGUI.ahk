#Requires AutoHotkey v2.0

Button_Click_ScriptHotkeys(thisGui, info) {

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Script Hotkey Customisation")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()
    i := 1
    first := true
    For (name, key in Scriptkeys.Hotkeys) {
        If (key && key.Name) {
            If (i >= 10) {
                MyGui.Add("Text", "ys", key.Name . ":")
                i := 1
            } Else {
                If (first) {
                    MyGui.Add("Text", "section", key.Name . ":")
                    first := false
                } Else {
                    MyGui.Add("Text", "", key.Name . ":")
                }
            }
            MyGui.AddEdit("cDefault v" . key.Name . " w140", key.GetValue())
            i++
        }
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default xs", "Save").OnEvent("Click",
        SaveScriptHotkeysInput)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseScriptHotkeys)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Reset To Defaults").OnEvent("Click",
        ResetScriptHotKeys)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ResetScriptHotKeys(*) {
        If (MsgBox("Are you sure you want to reset Script Hotkeys?",
            "Reset Script Hotkeys?", "0x1 0x100 0x10") = "OK") {
            MyGui.Hide()
            ; confirm
            Scriptkeys.WriteHotkeyDefaults()
            Reload()
        } Else {
            MsgBox("Aborted Script Hotkey Reset.")
        }
    }

    CloseScriptHotkeys(*) {
        MyGui.Hide()
    }

    SaveScriptHotkeysInput(*) {
        Saving := SavingGUI()
        MyGui.Hide()
        thisGui.Gui.Hide()
        Saving.Show()
        values := MyGui.Submit()
        For (name, key in Scriptkeys.Hotkeys) {
            key.SetValue(values.%name%)
        }
        Scriptkeys.SaveCurrentHotkeys()
        Reload()
    }
}
