#Requires AutoHotkey v2.0

#Include ..\ScriptLib\cGUI.ahk

/**
 * SavingGUI Description
 * @module SavingGUI
 */
Class SavingGUI {
    /** @type {cGUI} */
    SavingGui := cGui()
    /** @type {GuiControl} */
    Bar := ""

    ;@region Show()
    Show() {
        this.SavingGui.MarginX := 15
        this.SavingGui.MarginY := 15
        this.SavingGui.Opt("-MaximizeBox -MinimizeBox")
        this.SavingGui.SetUserFontSettings()
        this.SavingGui.AddText("vText", "Saving please wait..")

        this.Bar := this.SavingGui.AddProgress("c2363ec vProgBar")
        this.Bar.Value := 0
        SetTimer(this.IncrementSaveProgress.Bind(this), 100)
        this.SavingGui.Enabled := true
        this.SavingGui.Show()
    }
    ;@endregion

    ;@region Hide()
    Hide() {
        this.SavingGui.Hide()
        this.SavingGui.Enabled := false
    }
    ;@endregion

    IncrementSaveProgress() {
        If (!this.SavingGui.Enabled) {
            SetTimer(, 0)
            Return
        }
        this.SavingGui["ProgBar"].value++
        If (this.SavingGui["ProgBar"].value >= 100) {
            this.SavingGui["ProgBar"].value := 1
        }
    }
}
