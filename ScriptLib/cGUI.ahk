#Requires AutoHotkey v2.0

#Include cLogging.ahk
#Include cSettings.ahk

S.AddSetting("GUI", "GuiBGColour", "0c0018", "string")
S.AddSetting("GUI", "GuiFontBold", false, "bool")
S.AddSetting("GUI", "GuiFontColour", "cfcfcf", "string")
S.AddSetting("GUI", "GuiFontItalic", false, "bool")
S.AddSetting("GUI", "GuiFontName", "", "string")
S.AddSetting("GUI", "GuiFontSize", 9, "int")
S.AddSetting("GUI", "GuiFontStrike", false, "bool")
S.AddSetting("GUI", "GuiFontUnderline", false, "bool")
S.AddSetting("GUI", "GuiFontWeight", 4, "int")

/**
 * cGui extends GUI Description
 * @module cGui extends GUI
 * @method ResetSettings
 * @method ResetLogs
 * @method ShowGUIPosition
 * @method SaveGUIPositionOnMove
 * @method SaveGUIPositionOnResize
 * @method StorePos
 * @method SetFontOptions
 * @method MakeGUIResizableIfOversize
 * @method OnWheel
 * @method OnScroll
 * @method OnResize
 * @method UpdateScrollBars
 */
Class cGui extends GUI {

    ;@region ResetSettings()
    ResetSettings(*) {
        Out.Disable()
        HasPressed := MsgBox("Remove all ini files? This resets all settings.",
            "Setting Reset?", "0x1 0x100 0x10")
        If (HasPressed = "OK") {
            arr := []
            Loop Files A_ScriptDir "\*", 'F' {
                If (StrLower(A_LoopFileExt) = "ini") {
                    Try {
                        FileDelete(A_LoopFileFullPath)
                        arr.Push(A_LoopFileFullPath)
                    }
                }
            }
            list := ""
            For (value in arr) {
                list .= "Deleted: " value "`n"
            }
            MsgBox("Setting Reset Complete.`n" list)
            Reload()
        }
        Out.Enable()
    }
    ;@endregion

    ;@region ResetLogs()
    ResetLogs(*) {
        Out.Disable()
        HasPressed := MsgBox("Remove all log files? This resets all logs.",
            "Log Reset?", "0x1 0x100 0x10")
        If (HasPressed = "OK") {
            arr := []
            Loop Files A_ScriptDir "\*", 'F' {
                If (StrLower(A_LoopFileExt) = "log") {
                    Try {
                        FileDelete(A_LoopFileFullPath)
                        arr.Push(A_LoopFileFullPath)
                    }
                }
            }
            list := ""
            For (value in arr) {
                list .= "Deleted: " value "`n"
            }
            MsgBox("Log Reset Complete`n" list)
            Reload()
        }
        Out.Enable()
    }
    ;@endregion

    ;@region ShowGUIPosition()
    ShowGUIPosition() {
        SplitTitle := StrSplit(this.Title, " ")
        Title := this.Title
        If (IsInteger(SplitTitle[SplitTitle.Length])) {
            SplitTitle[SplitTitle.Length].Delete()
            For , value in SplitTitle {
                Title .= value " "
            }
            Title := Trim(Title)
        }
        S.AddSetting("GUIPosition", Title, "0,0", "string")
        Try {
            arr := S.IniToVar(Title, "GUIPosition")
        } Catch Error As OutputVar {
            If (OutputVar.Message = "The requested key, section or file was not found.") {
                Out.I("No window position stored for " Title)
            } Else If (OutputVar.Message = "Item has no value.") {
                Out.I("No window position stored for " Title)
            } Else {
                Out.E(OutputVar)
            }
            this.Show()
            Return
        }
        coords := StrSplit(arr, ",", " ")
        MCount := MonitorGetCount()
        i := 1
        IsWindowOnScreen := false
        guiX := coords[1]
        guiY := coords[2]
        If (coords.Length > 2) {
            guiW := coords[3]
            guiH := coords[4]
        }
        While (i <= MCount) {
            MonitorGetWorkArea(i, &Left, &Top, &Right, &Bottom)
            If (coords.Length > 2) {
                If (guiX >= Left && (guiX + guiW) <= Right && guiY >= Top && (guiY + guiH) <= Bottom) {
                    this.Show("x" guiX " y" guiY)
                    Return
                }
            } Else {
                If (guiX >= Left && (guiX + 100) <= Right && guiY >= Top && (guiY + 100) <= Bottom) {
                    this.Show("x" guiX " y" guiY)
                    Return
                }
            }
            i++
        }
        Out.I(this.Title " had to have position reset")
        this.Show()
    }
    ;@endregion

    ;@region SaveGUIPositionOnMove()
    SaveGUIPositionOnMove(Wparam, Lparam, Msg, Hwnd) {
        thisGUI := GuiFromHwnd(Hwnd)
        SetTimer(this.StoreGuiPos.Bind(this, thisGUI), -500)
    }
    ;@endregion

    ;@region SaveGUIPositionOnResize()
    SaveGUIPositionOnResize(thisGUI, MinMax, Width, Height) {
        SetTimer(this.StoreGuiPos.Bind(this, thisGUI, true), -500)
    }
    ;@endregion

    ;@region SetFontOptions()
    SetFontOptions(bold := false, italic := false, strike := false, ul := false, col := false, size := false, weight :=
        false, name := false, bgcol := false) {
        output := ""
        If (bold) {
            output .= "bold "
        }
        If (italic) {
            output .= "italic "
        }
        If (strike) {
            output .= "strike "
        }
        If (ul) {
            output .= "underline "
        }
        If (col) {
            output .= "c" col " "
        }
        If (size) {
            output .= "s" size " "
        }
        If (weight) {
            output .= "W" weight "00 "
        }
        output .= "Q5 "
        If (name) {
            this.SetFont(output, name)
        } Else {
            this.SetFont(output,)
        }
        If (bgcol) {
            this.BackColor := bgcol
        }
    }
    ;@endregion

    ;@region SetUserFontSettings()
    /**
     * Set default font and gui settings based on saved settings
     */
    SetUserFontSettings() {
        bold := S.Get("GuiFontBold")
        italic := S.Get("GuiFontItalic")
        strike := S.Get("GuiFontStrike")
        ul := S.Get("GuiFontUnderline")
        col := S.Get("GuiFontColour")
        size := S.Get("GuiFontSize")
        weight := S.Get("GuiFontWeight")
        name := S.Get("GuiFontName")
        bgcol := S.Get("GuiBGColour")
        this.SetFontOptions(bold, italic, strike, ul, col, size, weight, name, bgcol)
    }
    ;@endregion

    ;@region MakeGUIResizableIfOversize()
    MakeGUIResizableIfOversize() {
        ;HeightDiff 1440 - 1353
        WinGetClientPos(&OutX, &OutY, &OutWidth, &OutHeight, this.Title)
        If (OutHeight > (A_ScreenHeight - 120)) {
            this.Opt("+Resize +0x200000")
            this.OnEvent("Size", this.OnResize)
            ; Credit to https://www.autohotkey.com/boards/viewtopic.php?f=83&t=112708
            OnMessage(0x0115, this.OnScroll.Bind(this)) ; WM_VSCROLL
            ;OnMessage(0x0114, OnScroll) ; WM_HSCROLL
            OnMessage(0x020A, this.OnWheel.Bind(this))  ; WM_MOUSEWHEEL6
        }
    }
    ;@endregion

    ;@region OnWheel()
    OnWheel(W, L, M, H) {
        If !(HWND := WinExist()) || GuiCtrlFromHwnd(H)
            Return
        HT := DllCall("SendMessage", "Ptr", HWND, "UInt", 0x0084, "Ptr", 0, "Ptr", l) ; WM_NCHITTEST = 0x0084
        If (HT = 6) || (HT = 7) { ; HTHSCROLL = 6, HTVSCROLL = 7
            SB := (W & 0x80000000) ? 1 : 0 ; SB_LINEDOWN = 1, SB_LINEUP = 0
            SM := (HT = 6) ? 0x0114 : 0x0115 ;  WM_HSCROLL = 0x0114, WM_VSCROLL = 0x0115
            this.OnScroll(SB, 0, SM, HWND)
            Return 0
        }
    }
    ;@endregion

    ;@region OnScroll()
    OnScroll(WP, LP, M, H) {
        Static SCROLL_STEP := 20
        If !(LP = 0) ; not sent by a standard scrollbar
            Return
        Bar := (M = 0x0115) ; SB_HORZ=0, SB_VERT=1
        SI := Buffer(28, 0)
        NumPut("UInt", 28, "UInt", 0x17, SI) ; cbSize, fMask: SIF_ALL
        If !DllCall("GetScrollInfo", "Ptr", H, "Int", Bar, "Ptr", SI)
            Return
        RC := Buffer(16, 0)
        DllCall("GetClientRect", "Ptr", H, "Ptr", RC)
        NewPos := NumGet(SI, 20, "Int") ; nPos
        MinPos := NumGet(SI, 8, "Int") ; nMin
        MaxPos := NumGet(SI, 12, "Int") ; nMax
        Switch (WP & 0xFFFF) {
        Case 0: NewPos -= SCROLL_STEP ; SB_LINEUP
        Case 1: NewPos += SCROLL_STEP ; SB_LINEDOWN
        Case 2: NewPos -= NumGet(RC, 12, "Int") - SCROLL_STEP ; SB_PAGEUP
        Case 3: NewPos += NumGet(RC, 12, "Int") - SCROLL_STEP ; SB_PAGEDOWN
        Case 4, 5: NewPos := WP >> 16 ; SB_THUMBTRACK, SB_THUMBPOSITION
        Case 6: NewPos := MinPos ; SB_TOP
        Case 7: NewPos := MaxPos ; SB_BOTTOM
        Default: Return
        }
        MaxPos -= NumGet(SI, 16, "Int") ; nPage
        NewPos := Min(NewPos, MaxPos)
        NewPos := Max(MinPos, NewPos)
        OldPos := NumGet(SI, 20, "Int") ; nPos
        X := (Bar = 0) ? OldPos - NewPos : 0
        Y := (Bar = 1) ? OldPos - NewPos : 0
        If (X || Y) {
            ; Scroll contents of window and invalidate uncovered area.
            DllCall("ScrollWindow", "Ptr", H, "Int", X, "Int", Y, "Ptr", 0, "Ptr", 0)
            ; Update scroll bar.
            NumPut("Int", NewPos, SI, 20) ; nPos
            DllCall("SetScrollInfo", "ptr", H, "Int", Bar, "Ptr", SI, "Int", 1)
        }
    }
    ;@endregion

    ;@region OnResize()
    OnResize(GuiObj, MinMax, Width, Height) {
        If (MinMax != 1) {
            this.UpdateScrollBars(GuiObj)
        }
    }
    ;@endregion

    ;@region UpdateScrollBars()
    UpdateScrollBars(GuiObj) {
        ; SIF_RANGE = 0x1, SIF_PAGE = 0x2, SIF_DISABLENOSCROLL = 0x8, SB_HORZ = 0, SB_VERT = 1
        ; Calculate scrolling area.
        WinGetClientPos(, , &GuiW, &GuiH, GuiObj.Hwnd)
        L := T := 2147483647   ; Left, Top
        R := B := -2147483648  ; Right, Bottom
        For CtrlHwnd In WinGetControlsHwnd(GuiObj.Hwnd) {
            ControlGetPos(&CX, &CY, &CW, &CH, CtrlHwnd)
            L := Min(CX, L)
            T := Min(CY, T)
            R := Max(CX + CW, R)
            B := Max(CY + CH, B)
        }
        L -= 8, T -= 8
        R += 8, B += 8
        ScrW := R - L ; scroll width
        ScrH := B - T ; scroll height
        ; Initialize SCROLLINFO.
        SI := Buffer(28, 0)
        NumPut("UInt", 28, "UInt", 3, SI, 0) ; cbSize , fMask: SIF_RANGE | SIF_PAGE
        ; Update horizontal scroll bar.
        NumPut("Int", ScrW, "Int", GuiW, SI, 12) ; nMax , nPage
        DllCall("SetScrollInfo", "Ptr", GuiObj.Hwnd, "Int", 0, "Ptr", SI, "Int", 1) ; SB_HORZ
        ; Update vertical scroll bar.
        ; NumPut("UInt", SIF_RANGE | SIF_PAGE | SIF_DISABLENOSCROLL, SI, 4) ; fMask
        NumPut("Int", ScrH, "UInt", GuiH, SI, 12) ; nMax , nPage
        DllCall("SetScrollInfo", "Ptr", GuiObj.Hwnd, "Int", 1, "Ptr", SI, "Int", 1) ; SB_VERT
        ; Scroll if necessary
        X := (L < 0) && (R < GuiW) ? Min(Abs(L), GuiW - R) : 0
        Y := (T < 0) && (B < GuiH) ? Min(Abs(T), GuiH - B) : 0
        If (X || Y)
            DllCall("ScrollWindow", "Ptr", GuiObj.Hwnd, "Int", X, "Int", Y, "Ptr", 0, "Ptr", 0)
    }
    ;@endregion

    ;@region StorePos()
    StoreGuiPos(gui, resize := false) {
        Static StorePosLock := false
        If ((Type(gui) = "Gui" || Type(gui) = "cGui") && !StorePosLock) {
            If (gui.Title = A_ScriptName) {
                Return
            }
            StorePosLock := true
            If (WinExist(gui.Title)) {
                WinGetPos(&guiX, &guiY, &guiW, &guiH, gui.Title)
            } Else {
                Return
            }
            Sleep(500)
            If (WinExist(gui.Title)) {
                WinGetPos(&guiX, &guiY, &guiW, &guiH, gui.Title)
            }
            SplitTitle := StrSplit(gui.Title, " ")
            Title := gui.Title
            If (IsInteger(SplitTitle[SplitTitle.Length])) {
                SplitTitle[SplitTitle.Length].Delete()
                For , value in SplitTitle {
                    Title .= value " "
                }
                Title := Trim(Title)
            }
            If (!S.IsSetting(Title)) {
                StorePosLock := false
                Return
            }
            S.Set(Title, guiX "," guiY)
            S.SaveCurrentSettings()
            StorePosLock := false
        }
    }
    ;@endregion

}
