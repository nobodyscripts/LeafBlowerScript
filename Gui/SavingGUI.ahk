#Requires AutoHotkey v2.0

/**
 * SavingGUI Description
 * @module SavingGUI
 */
Class SavingGUI {
    /** @type {Gui} */
    SavingGui := Gui()
    /** @type {GuiControl} */
    Bar := ""

    ;@region Show()
    Show() {
        this.SavingGui.MarginX := 15
        this.SavingGui.MarginY := 15
        this.SavingGui.Opt("-MaximizeBox -MinimizeBox")
        this.SavingGui.BackColor := "0c0018"
        this.SavingGui.AddText("ccfcfcf vText", "Saving please wait..")

        this.Bar := this.SavingGui.AddProgress("c2363ec vProgBar")
        this.Bar.Value := 0
        SetTimer(this.IncrementSaveProgress.Bind(this), 50)
        this.SavingGui.Show()

    }
    ;@endregion

    ;@region Hide()
    Hide() {
        this.SavingGui.Hide()
        SetTimer(this.IncrementSaveProgress.Bind(this), 0)
    }
    ;@endregion

    IncrementSaveProgress() {
        this.SavingGui["ProgBar"].value++
        If (this.SavingGui["ProgBar"].value > 100) {
            this.SavingGui["ProgBar"].value := 0
        }
    }
}
