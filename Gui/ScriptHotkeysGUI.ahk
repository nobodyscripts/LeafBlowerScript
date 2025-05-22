#Requires AutoHotkey v2.0

Button_Click_ScriptHotkeys(thisGui, info) {

    /** @type {GUI} */
    optionsGUI := Gui(, "Script Hotkey Customisation")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)
    i := 1
    first := true
    For (name, key in Scriptkeys.Hotkeys) {
        If (key && key.Name) {
            If (i >= 10) {
                optionsGUI.Add("Text", "ys", key.Name . ":")
                i := 1
            } Else {
                If (first) {
                    optionsGUI.Add("Text", "section", key.Name . ":")
                    first := false
                } Else {
                    optionsGUI.Add("Text", "", key.Name . ":")
                }
            }
            optionsGUI.AddEdit("cDefault v" . key.Name . " w140", key.GetValue())
            i++
        }
    }

    optionsGUI.Add("Button", "+Background" GuiBGColour " default xs", "Save").OnEvent("Click",
        SaveScriptHotkeysInput)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseScriptHotkeys)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Reset To Defaults").OnEvent("Click",
        ResetScriptHotKeys)

    ShowGUIPosition(optionsGUI)
    MakeGUIResizableIfOversize(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ResetScriptHotKeys(*) {
        If (MsgBox("Are you sure you want to reset Script Hotkeys?",
            "Reset Script Hotkeys?", "0x1 0x100 0x10") = "OK") {
            optionsGUI.Hide()
            ; confirm
            Scriptkeys.WriteHotkeyDefaults()
            cReload()
        } Else {
            MsgBox("Aborted Script Hotkey Reset.")
        }
    }

    CloseScriptHotkeys(*) {
        optionsGUI.Hide()
    }

    SaveScriptHotkeysInput(*) {
        Saving := SavingGUI()
        optionsGUI.Hide()
        thisGui.Gui.Hide()
        Saving.Show()
        values := optionsGUI.Submit()
        For (name, key in Scriptkeys.Hotkeys) {
            key.SetValue(values.%name%)
        }
        Scriptkeys.SaveCurrentHotkeys()
        cReload()
    }
}
