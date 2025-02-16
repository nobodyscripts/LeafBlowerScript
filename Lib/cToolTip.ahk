#Requires AutoHotkey v2.0

#Include cGameWindow.ahk

/**
 * cTooltip class for displaying aligned tooltips
 * @module cToolTip
 * @property {String} Text Display text
 * @property {Integer} DisplayMS How long to display for in ms
 * @method Center Display center aligned w/h text tooltip
 */
Class cToolTip {

    /** @type {Type} Desc */
    Text := ""
    DisplayMS := 0
    ID := 1

    ;@region Funcname()
    /**
     * 
     */
    Center(Text, DisplayMS) {
        CoordMode("Tooltip", "Screen")
        ToolTip(this.Text, , A_ScreenHeight + 100, 15)
        WinGetPos(, , &width, &height, "ahk_class tooltips_class32")
        ToolTip(, , , 15)
        ToolTip(this.Text, (A_ScreenWidth - width) / 2, (A_ScreenHeight - height) / 2, 2)
        If (this.DisplayMS > 0) {
            SetTimer(ToolTip.Bind(,,,15), -this.DisplayMS)
        }
    }
    ;@endregion

    /**
     * Display list of tooltips aligned based on top left corner (not overlapping)
     * Aligned to 5, 195, right limit is 280, 195
     */
    TopLeft(Text, DisplayMS, AllowOverlap := true) {
        CoordMode("Tooltip", "Screen")
        ToolTip(this.Text, , A_ScreenHeight + 100, this.ID)
        WinGetPos(, , &width, &height, "ahk_class tooltips_class32")
        ToolTip(, , , 1)
        if (width > Window.RelW(280-5)) {
            Out.D("Tooltip may be overlapping")
            if (!AllowOverlap) {
                return
            }
        }
        ToolTip(this.Text, Window.RelW(5), Window.RelH(195) + (height*(this.id -1)), 2)
        If (this.DisplayMS > 0) {
            SetTimer(ToolTip.Bind(,,,this.ID), -this.DisplayMS)
        }
        this._IncID()
    }

    _IncID() {
        this.ID++
        if(this.ID >= 14) {
            this.ID := 1
        }
    }
}
