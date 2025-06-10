#Requires AutoHotkey v2.0

#Include ..\ScriptLib\cGUI.ahk

/**
 * UpdatingGUI Description
 * @module UpdatingGUI
 */
Class UpdatingGUI {
    /** @type {cGUI} */
    UpdatingGui := cGui()
    /** @type {GuiControl} */
    Bar := ""

    ;@region Show()
    Show() {
        this.UpdatingGui.MarginX := 15
        this.UpdatingGui.MarginY := 15
        this.UpdatingGui.Opt("-MaximizeBox -MinimizeBox")
        this.UpdatingGui.SetUserFontSettings()
        this.UpdatingGui.AddText("vText", "Updating please wait..")

        this.Bar := this.UpdatingGui.AddProgress("c2363ec vProgBar")
        this.Bar.Value := 0
        SetTimer(this.IncrementSaveProgress.Bind(this), 100)
        this.UpdatingGui.Enabled := true
        this.UpdatingGui.Show()
    }
    ;@endregion

    ;@region Hide()
    Hide() {
        this.UpdatingGui.Hide()
        this.UpdatingGui.Enabled := false
    }
    ;@endregion

    IncrementSaveProgress() {
        If (!this.UpdatingGui.Enabled) {
            SetTimer(, 0)
            Return
        }
        this.UpdatingGui["ProgBar"].value++
        If (this.UpdatingGui["ProgBar"].value >= 100) {
            this.UpdatingGui["ProgBar"].value := 1
        }
    }
}
