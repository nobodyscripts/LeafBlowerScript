﻿#Requires AutoHotkey v2.0

#Include ..\Lib\cTravel.ahk

S.AddSetting("GemFarm", "GemFarmSleepAmount", 17, "int")

Global HadToHideNotifs := false
Global TradesAutoRefreshOldState := false
Global TradesDetailedModeOldState := false
Global GemFarmActive := false

fGemFarmSuitcase() {
    Global HadToHideNotifs, TradesAutoRefreshOldState, TradesDetailedModeOldState,
        GemFarmActive
    NavigateTime := S.Get("NavigateTime")
    Debug := S.Get("Debug")
    DetailedToggle := Points.GemFarm.DetailedToggle
    NotifArrow := Points.Misc.NotifArrow
    AutoRefreshToggle := Points.GemFarm.AutoRefreshToggle

    If (!Travel.TheInfernalDesert.GoTo()) {
        If (Debug) {
            MsgBox(
                "GemFarm: Could not find The Infernal Desert area. Aborted travel."
            )
        }
        Out.I(
            "GemFarm: Could not find The Infernal Desert area. Aborted travel."
        )
        ToolTip("Could not find The Infernal Desert area`nUse F4 to finish",
            Window.W / 2 - Window.RelW(100), Window.H / 2, 3)
        Return
    }

    ; Disable notifications while doing bearo and auto refresh check
    If (Window.IsActive() && IsNotificationActive()) {
        Out.I("GemFarm: Found notifications on and toggled off.")
        ; Notifications were blocking, close notifications
        NotifArrow.Click(NavigateTime)
        Sleep(NavigateTime)
        HadToHideNotifs := true
    }

    ; Removes bearo from your pet team if its active
    RemoveBearo()
    Sleep(NavigateTime)

    Window.ActiveOrReload()
    ; We need the trade window now the Bearo and traveling is done
    Shops.OpenTrades()
    Sleep(NavigateTime)
    GameKeys.RefreshTrades()
    ; Need to refresh once otherwise there might be blank trade screen

    ; Disable auto refresh if its on based on timer at top of panel
    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
    If (TradesAutoRefreshOldState && Window.IsActive() && Window.IsPanel()) {
        Out.I("GemFarm: Auto refresh found on. Toggled off.")
        ; Auto refresh button
        AutoRefreshToggle.Click(101)
    }
    ; Notifications are ok now
    If (HadToHideNotifs && Window.IsActive()) {
        Out.I("GemFarm: Reenabling notifications.")
        ; Notification button
        NotifArrow.Click(NavigateTime)
        Sleep(NavigateTime)
        HadToHideNotifs := false
        ; Return to trades as it'll close
        If (!Window.IsPanel()) {
            Shops.OpenTrades()
            Sleep(NavigateTime)
        }
    }
    If (!Window.IsPanel()) {
        Shops.OpenTrades()
        Sleep(NavigateTime)
    }
    Travel.ScrollResetToTop()
    Sleep(NavigateTime)
    ; Detailed mode check, we need it off for alignment of fill trades
    TradesDetailedModeOldState := IsTradeDetailedModeOn()
    If (Window.IsActive() && Window.IsPanel() && IsTradeDetailedModeOn()) {
        Out.I("GemFarm: Detailed mode found on. Toggled off.")
        ; Disable detailed mode if its on based on gap between blue arrows
        Out.V("DetailedToggle")
        DetailedToggle.Click(NavigateTime)
        ToolTip("Toggled off details", Window.W / 2 - Window.RelW(50), Window.H /
        2 + Window.RelH(20), 3)
        SetTimer(ToolTip.Bind(, , , 3), -1000)
    }
    If (!Window.IsActive()) {
        If (Debug) {
            MsgBox("GemFarm: Exiting as no game.")
        }
        Out.I("GemFarm: Exiting as no game.")
        Return
    } Else {
        ; Cancel first trade, so that the first slot cannot be filled
        Out.V("FirstTradeCancel")
        Points.GemFarm.FirstTradeCancel.Click(NavigateTime)
        Sleep(NavigateTime)
        ; Collect first trade
        Out.V("FirstTradeCollect")
        Points.GemFarm.FirstTradeCollect.Click(NavigateTime)
        GameKeys.RefreshTrades()
        ; Leaves the first slot free to use suitcase on
    }

    ; We try to fill trades, if that returns false exit out
    If (Window.IsActive() && Window.IsPanel() && !FillTradeSlots()) {
        If (Debug) {
            MsgBox("GemFarm: Failed to fill trade slots. Exited.")
        }
        Out.I("GemFarm: Failed to fill trade slots. Exited.")
        ToolTip("Failed to fill trade slots, exiting.`nPress F4 to close and "
            "then retry GemFarm.", Window.W / 2 - Window.RelW(100), Window.H /
            2, 5)
        SetTimer(ToolTip.Bind(, , , 5), -1000)
        Return
    }
    MouseMove(Window.W / 2, Window.RelH(800))
    sCount := 0
    fCount := 0
    GemFarmActive := true
    Out.I("GemFarm: Starting main loop.")
    While (GemFarmActive) {
        Window.ActiveOrReload()
        Try {
            ; PixelSearch resolution independant function based on higher
            ; resolution to increase accuracy, using lower res resulted in
            ; drift when scaled up.
            Icon1 := Points.GemFarm.Icon1
            colour := Icon1.GetColour()
            If (colour = "0xFF0044") {
                Sleep(S.Get("GemFarmSleepAmount"))
                colour := Icon1.GetColour()
                If (colour = "0xFF0044") {
                    ; Double check to try and avoid false usage
                    GameKeys.TriggerSuitcase()
                    Sleep(NavigateTime)
                    If (HasSuitCaseBeenUsed()) {
                        sCount++
                    } Else {
                        GameKeys.TriggerSuitcase()
                        Sleep(NavigateTime)
                        If (HasSuitCaseBeenUsed()) {
                            sCount++
                        } Else {
                            fCount++
                        }
                    }
                    ToolTip("Used suitcases " sCount " times.`n"
                        "Failed to use suitcases " fCount " times.", Window.W /
                        2 - Window.RelW(100), Window.H / 2, 15)

                }
            }
        } Catch As exc {
            Out.I("GemFarm: Searching for Gem icon failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        GameKeys.RefreshTrades()
        Sleep(S.Get("GemFarmSleepAmount"))
    }
    ToolTip(, , , 15)
    GemFarmActive := false
}

RemoveBearo() {
    NavigateTime := S.Get("NavigateTime")
    Global HadToHideNotifs, HadToRemoveBearo
    Shops.OpenPets()
    Sleep(NavigateTime)
    coord := Rects.GemFarm.BearoSearch.PixelSearch("0x64747A")
    If (coord) {
        Out.I("GemFarm: Bearo found and removed.")
        ToolTip("Bearo found and removed", Window.W / 2 - Window.RelW(100),
        Window.H / 2 - Window.RelH(140), 16)
        SetTimer(ToolTip.Bind(, , , 16), -1000)
        HadToRemoveBearo := true
        Sleep(NavigateTime)
        cLBRButton(coord[1], coord[2], false).ClickOffset(1, 1, NavigateTime)
        Sleep(NavigateTime)
        Return true
    } Else {
        Out.I("GemFarm: Bearo not found.")
        Return false
    }
}

FillTradeSlots() {
    ; We try to fill up the trade slots 50 times
    ; Could get stuck here if L1 leafscensions are on and no trades available
    ; So capped at trying 50 times
    Button := Points.GemFarm.Start2
    i := 200
    Out.I("GemFarm: Filling trade slots for suitcase farming.")
    ToolTip("Filling trade slots", Window.W / 2 - Window.RelW(140), Window.H /
    2)
    SetTimer(ToolTip, -1000)
    While i > 0 {
        Window.ActiveOrReload()

        If (!Window.IsPanel()) {
            Out.I("GemFarm: Fill Trade slots did not find panel. Aborted.")
            i := 0
            Return false
        }
        ; If we see background instead of a start button we are full
        If (!Button.IsBackground()) {
            ; If the button isn't active, ignore it and don't count it
            If (!Button.IsButtonInactive()) {
                Sleep(50)
                Button.ClickOffset(0, 3)
                Sleep(50)
                i--
            }
            GameKeys.RefreshTrades()
            Sleep(50)
            If (i = 0) {
                Out.I("GemFarm: Filling trades failed, ran out of attempts.")
                MsgBox("Have tried to fill trade slots but no trades "
                    "available`nTry running again or disable L1 Leafscensions."
                )
                Return false
            }
        } Else {
            ; Done? Double check
            GameKeys.RefreshTrades()
            Sleep(72)
            ; Is there any button in the start position
            If (Button.IsBackground()) {
                i := 0
            } Else {
                ; Try again
                i++
            }
        }
    }
    Out.I("GemFarm: Completed filling trade slots.")
    Return true
}

HasSuitCaseBeenUsed() {
    If (Points.GemFarm.FirstTradeCancel.IsBackground() && Points.GemFarm.FirstTradeCollect
    .IsBackground()) {
        Return false
    }
    Return true
}

IsTradeAutoRefreshOn() {
    ; if white is in this area, timer active so it is on
    result := Rects.GemFarm.AutoRefreshTimer.PixelSearch()
    ; Timer pixel search
    If (result) {
        Return true ; Found colour
    }
    Return false
}

IsTradeDetailedModeOn() {
    If (Points.GemFarm.Detailed.IsBackground()) {
        Return true ; Found colour
    }
    Return false
}

ToggleAutoRefresh() {
    Global TradesAutoRefreshOldState
    Shops.OpenTrades()
    Sleep(101)
    ; Disable auto refresh if its on
    Points.GemFarm.AutoRefreshToggle.Click(101)
    Sleep(50)
    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
}

ToggleDetailedMode() {
    Global TradesDetailedModeOldState
    Shops.OpenTrades()
    Sleep(101)
    ; Disable detailed mode if its on
    Points.GemFarm.DetailedToggle.Click(101)
    Sleep(50)
    TradesDetailedModeOldState := IsTradeDetailedModeOn()
}

ResetToPriorAutoRefresh() {
    Global TradesAutoRefreshOldState
    If (IsTradeAutoRefreshOn() != TradesAutoRefreshOldState) {
        Out.I("GemFarm: Auto refresh doesn't match previous setting, toggling."
        )
        ToggleAutoRefresh()
    }
}

ResetToPriorDetailedMode() {
    Global TradesDetailedModeOldState
    If (IsTradeDetailedModeOn() != TradesDetailedModeOldState) {
        Out.I(
            "GemFarm: Detailed mode doesn't match previous setting, toggling.")
        ToggleDetailedMode()
    }
}

TradeForPyramid(*) {
    UlcWindow()
    ; (1252, 397) icon1
    ; Start button cLBRButton(2029, 397) x+777
    ; Cancel button cLBRButton(1742, 397) x+490
    ; Collect button cLBRButton(1990, 397) x+738
    /** @type {cRect} */
    scanArea := cRect(1252, 351, 1253, 1061) ; Scan area 1252, 351/1252, 1061
    Cheese := "0xD98A29"
    Mulch := "0x985046"
    Beer := "0x61233E"
    Borb := "0x60F811"
    amount := 1
    HasCheese := HasMulch := HasBeer := HasBorb := 0
    isLooping := true
    i := 0

    Out.I("Trade For Pyramid")
    CancelAllTrades()
    While ((HasCheese = false || HasMulch = false ||
        HasBeer = false || HasBorb = false) && isLooping) {
        If (i > 500) {
            MsgBox("Could not complete all trades before timing out, please complete and start stage 2.")
            Break
        }
        If (HasCheese < amount) {
            HasCheese += ScanTradesByColour(Cheese)
            If (HasCheese > 0) {
                Out.I("Found cheese")
            }
        }
        If (HasMulch < amount) {
            HasMulch += ScanTradesByColour(Mulch)
            If (HasMulch > 0) {
                Out.I("Found mulch")
            }
        }
        If (HasBeer < amount) {
            HasBeer += ScanTradesByColour(Beer)
            If (HasBeer > 0) {
                Out.I("Found beer")
            }
        }
        If (HasBorb < amount) {
            HasBorb += ScanTradesByColour(Borb)
            If (HasBorb > 0) {
                Out.I("Found borb")
            }
        }
        Sleep(50)
        If (IsPlayerOutOfCheese()) {
            PubTradeForCheese2500()
            Shops.OpenTrades()
        }
        GameKeys.RefreshTrades()
        Sleep(50)
        i++
    }

    ScanTradesByColour(colour) {
        point := scanArea.PixelSearch(colour)
        If (!point) {
            Return false
        }
        ; Start button cLBRButton(2029, 397) x+777
        ; Cancel button cLBRButton(1742, 397) x+490
        ; Collect button cLBRButton(1990, 397) x+738

        /* 1252, 397 icon point ref
        Rect for text area
        1302, 377   50, -20
        1373, 410   121, 13
        */
        Start := cLBRButton(point[1] + Window.RelW(777), point[2], false)
        Cancel := cLBRButton(point[1] + Window.RelW(490), point[2], false)
        Collect := cLBRButton(point[1] + Window.RelW(738), point[2], false)
        ; Is started?
        If (Cancel.IsButtonActive() || Collect.IsButtonActive()) {
            Return false
        }
        ; Is startable?
        If (Start.IsButtonInactive()) {
            Return false
        }
        ; Does area next to icon have text that fits the eXX pattern and thus is
        ; > 1
        /** @type {cRect} check for text beyond amount of 1 for the trade */
        textrect := cRect(point[1] + Window.RelW(50), point[2] - Window.RelH(20),
        point[1] + Window.RelW(121), point[2] + Window.RelH(13),
        false)
        If (textrect.PixelSearch()) {
            Start.ClickButtonActive()
            Sleep(17)
            Start.ClickButtonActive()
            Return 1
        }
        Return false
    }
}

TradeForPyramidJustBeer(*) {
    UlcWindow()
    /** @type {cRect} */
    scanArea := cRect(1252, 351, 1253, 1061) ; Scan area 1252, 351/1252, 1061
    Beer := "0x61233E"
    amount := 1
    i := 0

    Out.I("Trade For any beer")
    /** Grab any possible beer trades even amounts of 1 as backup */
    Loop {
        If (i > 500) {
            MsgBox("Could not fill all trades before timing out, please complete and start stage 2.")
            Break
        }
        ScanTradesJustBeer(Beer)
        Sleep(50)
        If (IsPlayerOutOfCheese()) {
            PubTradeForCheese2500()
            Shops.OpenTrades()
        }
        GameKeys.RefreshTrades()
        Sleep(50)

        If (Points.GemFarm.Start2.IsBackground()) {
            Out.I("Trades full")
            cLBRButton(1530, 1087).ClickButtonActive() ; Boost all
            Break
        }
        i++
    }

    ScanTradesJustBeer(colour) {
        point := scanArea.PixelSearch(colour)
        If (!point) {
            Return false
        }
        Start := cLBRButton(point[1] + Window.RelW(777), point[2], false)
        Cancel := cLBRButton(point[1] + Window.RelW(490), point[2], false)
        Collect := cLBRButton(point[1] + Window.RelW(738), point[2], false)
        ; Is started?
        If (Cancel.IsButtonActive() || Collect.IsButtonActive()) {
            Return false
        }
        ; Is startable?
        If (Start.IsButtonInactive()) {
            Return false
        }
        Start.ClickButtonActive()
        Sleep(17)
        Start.ClickButtonActive()
        Return 1
    }
}

IsPlayerOutOfCheese() {
    /** @type {cLBRButton} */
    point := Points.ZoneSample
    If (cRect(1746, 298, 1750, 1025).PixelSearch(point.Inactive)) {
        Return true
    }
    Return false
}

CancelAllTrades() {
    /** @type {cLBRButton} */
    pointCol := Points.ZoneSample
    point := cRect(1920, 298, 1921, 1025).PixelSearch(pointCol.Active)
    While (point) {
        cLBRButton(point[1], point[2], false).ClickOffset()
        point := cRect(1920, 298, 1921, 1025).PixelSearch(pointCol.Active)
    }
}
