#Requires AutoHotkey v2.0

Button_Click_GameHotkeys(*) {

    optionsGUI := Gui(, "Game Hotkey Customisation")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"
    i := 1
    first := true
    For (name, key in GameKeys.Hotkeys) {
        If (key && key.Name && key.Name != "ClosePanel") {
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
        SaveGameHotkeysInput)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseGameHotkeys)
    optionsGUI.Add("Button", "default yp", "Reset To Defaults").OnEvent("Click",
        ResetGameHotKeys)
    optionsGUI.Add("Button", "default yp", "Apply To Game").OnEvent("Click",
        ApplyNewHotkeysToGame)

    optionsGUI.Show()


    ResetGameHotKeys(*) {
        If (MsgBox("Are you sure you want to reset Script Hotkeys?",
            "Reset Script Hotkeys?", "0x1 0x100 0x10") = "OK") {
            optionsGUI.Hide()
            ; confirm
            GameKeys.WriteHotkeyDefaults()
            cReload()
        } Else {
            MsgBox("Aborted Game Hotkey Reset.")
        }
    }

    CloseGameHotkeys(*) {
        optionsGUI.Hide()
    }

    SaveGameHotkeysInput(*) {
        values := optionsGUI.Submit()
        For (name, key in GameKeys.Hotkeys) {
            If (name != "ClosePanel") {
                key.SetValue(values.%name%)
            }
        }
        GameKeys.SaveCurrentHotkeys()
        cReload()
    }

    ApplyNewHotkeysToGame(*) {
        If (WinExist(LBRWindowTitle)) {
            MsgBox(
                "CLOSE GAME BEFORE RUNNING APPLY SCRIPT`r`nChanges not saved.")
            Return
        }
        If (MsgBox("Are you sure you want to apply new Game Hotkeys?",
            "Apply Game Hotkeys?", "0x1 0x100 0x10") = "OK") {
            values := optionsGUI.Submit()
            For (name, key in GameKeys.Hotkeys) {
                If (name != "ClosePanel") {
                    key.SetValue(values.%name%)
                }
            }
            GameKeys.SaveCurrentHotkeys()
            fGameSettings()
            cReload()
        } Else {
            MsgBox("Aborted Game Hotkey Apply.")
        }
    }
}