#Requires AutoHotkey v2.0

/**
 * UpdatingGUI Description
 * @module UpdatingGUI
 */
Class UpdatingGUI {
    /** @type {Gui} */
    UpdatingGui := Gui()
    /** @type {GuiControl} */
    Bar := ""

    ;@region Show()
    Show() {
        this.UpdatingGui.MarginX := 15
        this.UpdatingGui.MarginY := 15
        this.UpdatingGui.Opt("-MaximizeBox -MinimizeBox")
        this.UpdatingGui.SetFont("Q5")
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
        if (!this.UpdatingGui.Enabled) {
            SetTimer(, 0)
            return
        }
        this.UpdatingGui["ProgBar"].value++
        If (this.UpdatingGui["ProgBar"].value >= 100) {
            this.UpdatingGui["ProgBar"].value := 1
        }
    }
}
