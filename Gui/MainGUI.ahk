#Requires AutoHotkey v2.0

#Include ..\Lib\CheckForUpdates.ahk

#Include GeneralSettingsGUI.ahk

#Include BankGUI.ahk
#Include BorbVenturesGUI.ahk
#Include BossFarmGUI.ahk
#Include CardsGUI.ahk
#Include ClawGUI.ahk
#Include FishingGUI.ahk
#Include FishingChallengeGUI.ahk
#Include FishingTourneyGUI.ahk
#Include GameHotkeysGUI.ahk
#Include GemFarmGUI.ahk
#Include GFSSFarmGUI.ahk
#Include HyacinthFarmGUI.ahk
#Include LeaftonGUI.ahk
#Include MineGUI.ahk
#Include ScriptHotkeysGUI.ahk
#Include ShadowCrystalGUI.ahk
#Include TowerPassiveGUI.ahk

#Include ULCTestGUI.ahk
#Include ..\Modules\Fishing.ahk

Button_Click_Exit(*) {
    fExitApp()
}

Button_Click_Reload(thisGui, info) {
    fReloadApp()
}

Button_Click_TowerBoost(thisGui, info) {
    Window.Activate()
    fTowerBoostStart()
}

Button_Click_NatureBoss(thisGui, info) {
    Window.Activate()
    fNatureBossStart()
}

Button_Click_Resize(thisGui, info) {
    Window.Activate()
    fGameResize()
}

Button_Click_CursedCheese(thisGui, info) {
    Window.Activate()
    fCursedCheeseStart()
}

Button_Click_SuitcaseSpam(thisGui, info) {
    Window.Activate()
    fSuitcaseSpam()
}

Button_Click_PrestigeSpammer(thisGui, info) {
    Window.Activate()
    fPrestigeSpammer()
}

RunGui() {
    Global Updater
    Updater.Init()
    Updater.Check()
    version := Updater.CurrentVersion.Full

    /** @type {GUI} */
    MyGui := Gui(, "LBR NobodyScript " Updater.CurrentVersion.Build)

    SetFontOptions(MyGUI)
    If (Updater.IsNewRelease) {
        MyGui.AddLink("",
            "New Release Available, <a href=`"https://github.com/nobodyscripts/LeafBlowerScript`">Open Main Page</a> or <a href=`"https://github.com/nobodyscripts/LeafBlowerScript/releases`">Releases</a>"
        )
    }
    If (Updater.IsNewBeta) {
        MyGui.Add("Text", "", "New beta update available.")
        MyBtn := MyGui.Add("Button", "+Background" GuiBGColour "", "Update Script Beta")
        MyBtn.OnEvent("Click", Updater.UpdateScriptToNewDev)
    }

    MyGui.Add("Text", "section", Scriptkeys.GetHotkey("Exit"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Exit")
    MyBtn.OnEvent("Click", Button_Click_Exit)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Reload"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Reload/End")
    MyBtn.OnEvent("Click", Button_Click_Reload)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Cards"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Cards Open/Buyer")
    MyBtn.OnEvent("Click", Button_Click_Cards)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("GemFarm"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Gem Suitcase Farm")
    MyBtn.OnEvent("Click", Button_Click_GemFarm)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("TowerBoost"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Tower Boost Usage`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_TowerBoost)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Borbv"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Borbventure Farm")
    MyBtn.OnEvent("Click", Button_Click_BorbVenture)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Claw"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Claw Farm")
    MyBtn.OnEvent("Click", Button_Click_Claw)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("GFSS"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "GFSS Boss Farm")
    MyBtn.OnEvent("Click", Button_Click_GFSS)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("BossFarm"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Boss Farm Mode")
    MyBtn.OnEvent("Click", Button_Click_BossFarm)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("NatureBoss"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Nature Boss`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_NatureBoss)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("AutoClicker") " Autoclicker"
    )

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("GameResize"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Resize Game`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_Resize)

    ; ----------------------

    MyGui.Add("Text", "ys", Scriptkeys.GetHotkey("MineMaintain"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Mine Maintainer")
    MyBtn.OnEvent("Click", Button_Click_Mine)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("HyacinthFarm"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Hyacinth Farm")
    MyBtn.OnEvent("Click", Button_Click_Hyacinth)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Bank"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Bank Maintainer Mode")
    MyBtn.OnEvent("Click", Button_Click_Bank)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("CursedCheese"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Cursed Cheese Mode`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_CursedCheese)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("TowerPassive"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Tower Passive Mode")
    MyBtn.OnEvent("Click", Button_Click_TowerPassive)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("Leafton"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Leafton Mode")
    MyBtn.OnEvent("Click", Button_Click_Leafton)

    MyGui.Add("Text", "", Scriptkeys.GetHotkey("ShadowCrystal"))
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Shadow Crystal Fight")
    MyBtn.OnEvent("Click", Button_Click_ShadowCrystal)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "SuitcaseSpam LE Farm`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_SuitcaseSpam)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Gold Prestige Spam`n(Run)")
    MyBtn.OnEvent("Click", Button_Click_PrestigeSpammer)

    ; ----------------------

    MyGui.Add("Text", "ys", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "ULC TEST")
    MyBtn.OnEvent("Click", Button_Click_ULC)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Fishing")
    MyBtn.OnEvent("Click", Button_Click_Fishing)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Fishing Challenge")
    MyBtn.OnEvent("Click", Button_Click_FishingChallenge)

    MyGui.Add("Text", "", "(no keybind)")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Fishing Tourney")
    MyBtn.OnEvent("Click", Button_Click_FishingTourney)

    MyGui.Add("Text", "", "")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Edit Script Hotkeys")
    MyBtn.OnEvent("Click", Button_Click_ScriptHotkeys)

    MyGui.Add("Text", "", "")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Edit Game Hotkeys")
    MyBtn.OnEvent("Click", Button_Click_GameHotkeys)

    MyGui.Add("Text", "", "")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Update game settings`n"
        "For script use")
    MyBtn.OnEvent("Click", fGameSettings)

    MyGui.Add("Text", "", "General Settings")
    MyBtn := MyGui.Add("Button", "+Background" GuiBGColour " ", "Settings")
    MyBtn.OnEvent("Click", Button_Click_GeneralSettings)

    MyGui.AddText("xs", "")
    MyGui.AddText("xs", "LBR NobodyScript " version)

    ShowGUIPosition(MyGui)
    MakeGUIResizableIfOversize(MyGui)
    MyGui.OnEvent("Close", Button_Click_Exit)
    MyGui.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)
}

ShowGUIPosition(thisGUI) {
    SplitTitle := StrSplit(thisGUI.Title, " ")
    Title := thisGUI.Title
    If (SplitTitle[1] = "LBR") {
        Title := SplitTitle[1] " " SplitTitle[2]
    }
    Try {
        arr := Settings.IniToVar(Title, "GUIPosition")
    } Catch Error As OutputVar {
        If (OutputVar.Message = "The requested key, section or file was not found.") {
            Out.I("No window position stored for " Title)
            thisGUI.Show()
            Return
        }
        Out.E(OutputVar)
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
                thisGUI.Show("x" guiX " y" guiY)
                Return
            }
        } Else {
            If (guiX >= Left && (guiX + 100) <= Right && guiY >= Top && (guiY + 100) <= Bottom) {
                thisGUI.Show("x" guiX " y" guiY)
                Return
            }
        }
        i++
    }
    thisGUI.Show()
}

StorePos(thisGUI, resize := false) {
    Static StorePosLock := false

    If (Type(thisGUI) = "Gui" && !StorePosLock) {
        StorePosLock := true
        WinGetPos(&guiX, &guiY, &guiW, &guiH, thisGUI.Title)
        Sleep(500)
        Global Settings
        If (WinExist(thisGUI.Title)) {
            WinGetPos(&guiX, &guiY, &guiW, &guiH, thisGUI.Title)
        }
        SplitTitle := StrSplit(thisGUI.Title, " ")
        Title := thisGUI.Title
        If (SplitTitle[1] = "LBR") {
            Title := SplitTitle[1] " " SplitTitle[2]
        }
        ;Out.I("Written window pos " thisGUI.Title " X" guiX " Y" guiY)
        ;If (!resize) {
        Settings.WriteToIni(Title, guiX "," guiY, "GUIPosition")
        ;} Else {
        ;    Settings.WriteToIni(Title, guiX "," guiY "," guiW "," guiH, "GUIPosition")
        ;}
        StorePosLock := false
    }
}

SaveGUIPositionOnMove(Wparam, Lparam, Msg, Hwnd) {
    ;Out.D("onmessage " Wparam " " Lparam " " Msg " " Hwnd)
    thisGUI := GuiFromHwnd(Hwnd)
    SetTimer(StorePos.Bind(thisGUI), -500)
}

SaveGUIPositionOnResize(thisGUI, MinMax, Width, Height) {
    SetTimer(StorePos.Bind(thisGUI, true), -500)
}

Global GuiBGColour := "0c0018"
Global GuiFontBold := false
Global GuiFontItalic := false
Global GuiFontStrike := false
Global GuiFontUnderline := false
Global GuiFontColour := "cfcfcf"
Global GuiFontSize := false
Global GuiFontWeight := false
Global GuiFontName := false

SetFontOptions(MyGUI) {
    output := ""
    If (GuiFontBold) {
        output := output . "bold "
    }
    If (GuiFontItalic) {
        output := output . "italic "
    }
    If (GuiFontStrike) {
        output := output . "strike "
    }
    If (GuiFontUnderline) {
        output := output . "underline "
    }
    If (GuiFontColour) {
        output := output . "c" GuiFontColour " "
    }
    If (GuiFontSize) {
        output := output . "s" GuiFontSize " "
    }
    If (GuiFontWeight) {
        output := output . "W" GuiFontWeight "00 "
    }
    output := output . "Q5 "
    If (GuiFontName && output) {
        MyGui.SetFont(output, GuiFontName)
    } Else If (output) {
        MyGui.SetFont(output,)
    }
    If (GuiBGColour) {
        MyGui.BackColor := GuiBGColour
    }
}

MakeGUIResizableIfOversize(MyGui) {
    ;HeightDiff 1440 - 1353
    WinGetClientPos(&OutX, &OutY, &OutWidth, &OutHeight, MyGui.Title)
    If (OutHeight > (A_ScreenHeight - 120)) {
        MyGui.Opt("+Resize +0x200000")
        MyGui.OnEvent("Size", GUIResize)
        ; Credit to https://www.autohotkey.com/boards/viewtopic.php?f=83&t=112708
        OnMessage(0x0115, OnScroll) ; WM_VSCROLL
        ;OnMessage(0x0114, OnScroll) ; WM_HSCROLL
        OnMessage(0x020A, OnWheel)  ; WM_MOUSEWHEEL6
    }
}

GUIResize(GuiObj, MinMax, Width, Height) {
    If (MinMax != 1) {
        UpdateScrollBars(GuiObj)
    }
}

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

OnWheel(W, L, M, H) {
    If !(HWND := WinExist()) || GuiCtrlFromHwnd(H)
        Return
    HT := DllCall("SendMessage", "Ptr", HWND, "UInt", 0x0084, "Ptr", 0, "Ptr", l) ; WM_NCHITTEST = 0x0084
    If (HT = 6) || (HT = 7) { ; HTHSCROLL = 6, HTVSCROLL = 7
        SB := (W & 0x80000000) ? 1 : 0 ; SB_LINEDOWN = 1, SB_LINEUP = 0
        SM := (HT = 6) ? 0x0114 : 0x0115 ;  WM_HSCROLL = 0x0114, WM_VSCROLL = 0x0115
        OnScroll(SB, 0, SM, HWND)
        Return 0
    }
}

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
