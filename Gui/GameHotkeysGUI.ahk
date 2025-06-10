#Requires AutoHotkey v2.0

Button_Click_GameHotkeys(thisGui, *) {

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Game Hotkey Customisation")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()
    i := 1
    first := true
    For (name, key in GameKeys.Hotkeys) {
        If (key && key.Name && key.Name != "ClosePanel") {
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
        SaveGameHotkeysInput)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseGameHotkeys)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Reset To Defaults").OnEvent("Click",
        ResetGameHotKeys)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Apply To Game").OnEvent("Click",
        ApplyNewHotkeysToGame)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ResetGameHotKeys(*) {
        If (MsgBox("Are you sure you want to reset Script Hotkeys?",
            "Reset Script Hotkeys?", "0x1 0x100 0x10") = "OK") {
            MyGui.Hide()
            ; confirm
            GameKeys.WriteHotkeyDefaults()
            Reload()
        } Else {
            MsgBox("Aborted Game Hotkey Reset.")
        }
    }

    CloseGameHotkeys(*) {
        MyGui.Hide()
    }

    SaveGameHotkeysInput(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        values := MyGui.Submit()
        For (name, key in GameKeys.Hotkeys) {
            If (name != "ClosePanel") {
                key.SetValue(values.%name%)
            }
        }
        GameKeys.SaveCurrentHotkeys()
        Reload()
    }

    ApplyNewHotkeysToGame(*) {
        If (Window.Exist()) {
            MsgBox(
                "CLOSE GAME BEFORE RUNNING APPLY SCRIPT`r`nChanges not saved.")
            Return
        }
        If (MsgBox("Are you sure you want to apply new Game Hotkeys?",
            "Apply Game Hotkeys?", "0x1 0x100 0x10") = "OK") {
            values := MyGui.Submit()
            For (name, key in GameKeys.Hotkeys) {
                If (name != "ClosePanel") {
                    key.SetValue(values.%name%)
                }
            }
            GameKeys.SaveCurrentHotkeys()
            fGameSettings()
            Reload()
        } Else {
            MsgBox("Aborted Game Hotkey Apply.")
        }
    }
}
