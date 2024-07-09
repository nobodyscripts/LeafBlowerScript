#Requires AutoHotkey v2.0

Button_Click_ScriptHotkeys(*) {

    optionsGUI := Gui(, "Script Hotkey Customisation")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"
    i := 1
    first := true
    For (name, key in Scriptkeys.Hotkeys) {
        If (key && key.Name) {
            If (i >= 10) {
                optionsGUI.Add("Text", "ccfcfcf ys", key.Name . ":")
                i := 1
            } Else {
                If (first) {
                    optionsGUI.Add("Text", "ccfcfcf section", key.Name . ":")
                    first := false
                } Else {
                    optionsGUI.Add("Text", "ccfcfcf", key.Name . ":")
                }
            }
            optionsGUI.AddEdit("v" . key.Name . " w140", key.GetValue())
            i++
        }
    }

    optionsGUI.Add("Button", "default xs", "Save").OnEvent("Click",
        SaveScriptHotkeysInput)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseScriptHotkeys)
    optionsGUI.Add("Button", "default yp", "Reset To Defaults").OnEvent("Click",
        ResetScriptHotKeys)

    optionsGUI.Show()


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
        values := optionsGUI.Submit()
        For (name, key in Scriptkeys.Hotkeys) {
            key.SetValue(values.%name%)
        }
        Scriptkeys.SaveCurrentHotkeys()
        cReload()
    }
}