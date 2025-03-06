#Requires AutoHotkey v2.0

#Include cGameWindow.ahk

/** @type {cToolTip} */
Global gToolTip := cToolTip()

/**
 * cTooltip class for displaying aligned tooltips
 * @module cToolTip
 * @property {String} Text Display text
 * @property {Integer} DisplayMS How long to display for in ms
 * @method Center Display center aligned w/h text tooltip
 * @method CenterMS Display center aligned w/h text tooltip timed
 */
Class cToolTip {

    /** @type {String} Desc */
    Text := ""
    /** @type {Integer} Desc */
    DisplayMS := 0
    /** @type {Integer} Desc */
    _curSeconds := 0
    /** @type {Integer} Desc */
    ID := 1
    /** @type {Bool} Desc */
    _ExitEarly := false

    ;@region Center()
    /**
     * Center(Text)
     */
    Center(Text) {
        CoordMode("Tooltip", "Client")
        ToolTip(Text, , A_ScreenHeight + 100, 15)
        WinGetPos(, , &width, &height, "ahk_class tooltips_class32")
        ToolTip(, , , 15)
        ToolTip(Text, (Window.W - width) / 2, (Window.H - height) / 2, 15)
    }
    ;@endregion

    ;@region CenterMS()
    /**
     * CenterMS(Text, DisplayMS)
     */
    CenterMS(Text, DisplayMS) {
        CoordMode("Tooltip", "Client")
        ToolTip(Text, , A_ScreenHeight + 100, 14)
        WinGetPos(, , &width, &height, "ahk_class tooltips_class32")
        ToolTip(, , , 14)
        ToolTip(Text, (Window.W - width) / 2, (Window.H - height) / 2, 14)
        If (DisplayMS > 0) {
            SetTimer(ToolTip.Bind(, , , 14), -DisplayMS)
        }
    }
    ;@endregion

    ;@region CenterDel()
    /**
     * CenterDel()
     */
    CenterDel() {
        ToolTip(, , , 15)
    }
    ;@endregion

    ;@region CenterMSDel()
    /**
     * CenterMSDel()
     */
    CenterMSDel() {
        SetTimer(ToolTip.Bind(, , , 14), -1)
    }
    ;@endregion

    ;@region CenterCDDel()
    /**
     * CenterCDDel()
     */
    CenterCDDel() {
        SetTimer(this._DisplayCD.Bind(this), 0)
        this._ExitEarly := true
        ToolTip(, , , 13)
    }
    ;@endregion

    ;@region CenterCD()
    /**
     * CenterCD()
     */
    CenterCD(Text, DisplayMS) {
        Out.I("CenterCD: " Text)
        this.Text := Text
        this.DisplayMS := DisplayMS
        this._ExitEarly := false
        this._curSeconds := this.DisplayMS / 1000
        SetTimer(this._DisplayCD.Bind(this), -1)
        SetTimer(this._DisplayCD.Bind(this), 1000)
    }
    ;@endregion

    _DisplayCD() {
        ToolTip(, , , 13)
        Text := this.Text "`r`n" Round(this._curSeconds) "s Remaining."
        CoordMode("Tooltip", "Client")
        ToolTip(Text, , A_ScreenHeight + 100, 13)
        WinGetPos(, , &width, &height, "ahk_class tooltips_class32")
        ToolTip(, , , 13)
        ToolTip(Text, (Window.W - width) / 2, (Window.H - height) / 2, 13)
        If (this._curSeconds <= 0 || this._ExitEarly) {
            ToolTip(, , , 13)
            SetTimer(, 0)
        }
        this._curSeconds -= 1
    }
    /**
     * Display list of tooltips aligned based on top left corner (not overlapping)
     * Aligned to 5, 195, right limit is 280, 195
     */
    TopLeft(Text, DisplayMS, AllowOverlap := true) {
        CoordMode("Tooltip", "Screen")
        ToolTip(this.Text, , A_ScreenHeight + 100, this.ID)
        WinGetPos(, , &width, &height, "ahk_class tooltips_class32")
        ToolTip(, , , 1)
        If (width > Window.RelW(280 - 5)) {
            Out.D("Tooltip may be overlapping")
            If (!AllowOverlap) {
                Return
            }
        }
        ToolTip(this.Text, Window.RelW(5), Window.RelH(195) + (height * (this.id - 1)), 2)
        If (this.DisplayMS > 0) {
            SetTimer(ToolTip.Bind(, , , this.ID), -this.DisplayMS)
        }
        this._IncID()
    }

    _IncID() {
        this.ID++
        If (this.ID >= 14) {
            this.ID := 1
        }
    }
}
