﻿#Requires AutoHotkey v2.0

#Include ..\Lib\cTravel.ahk

global GemFarmSleepAmount := 1
global TradesAutoRefreshOldState := false
global TradesDetailedModeOldState := false
global HadToRemoveBearo := false
global GemFarmActive := false

fGemFarmSuitcase() {
    global TradesAutoRefreshOldState
    global TradesDetailedModeOldState
    global GemFarmSleepAmount, HadToHideNotifs, GemFarmActive
    global X, Y, W, H
    DetailedToggle := Points.GemFarm.DetailedToggle
    NotifArrow := Points.Misc.NotifArrow
    AutoRefreshToggle := Points.GemFarm.AutoRefreshToggle

    if (!Travel.Desert.GoTo()) {
        if (Debug) {
            MsgBox("GemFarm: Could not find desert area. Aborted travel.")
        }
        Log("GemFarm: Could not find desert area. Aborted travel.")
        ToolTip("Could not find desert area`nUse F4 to finish",
            W / 2 - WinRelPosLargeW(100),
            H / 2, 3)
        return
    }

    ; Disable notifications while doing bearo and auto refresh check
    if (IsWindowActive() && IsNotificationActive()) {
        Log("GemFarm: Found notifications on and toggled off.")
        ; Notifications were blocking, close notifications
        NotifArrow.Click(NavigateTime)
        Sleep(NavigateTime)
        HadToHideNotifs := true
    }

    ; Removes bearo from your pet team if its active
    RemoveBearo()
    sleep(NavigateTime)
    if (!IsWindowActive()) {
        if (Debug) {
            MsgBox("GemFarm: Exiting as no game.")
        }
        Log("GemFarm: Exiting as no game.")
        return
    } else {
        ; We need the trade window now the Bearo and traveling is done
        Travel.OpenTrades()
        sleep(NavigateTime)
        GameKeys.RefreshTrades()
        ; Need to refresh once otherwise there might be blank trade screen
    }

    ; Disable auto refresh if its on based on timer at top of panel
    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
    If (TradesAutoRefreshOldState && IsWindowActive() && IsPanelActive()) {
        Log("GemFarm: Auto refresh found on. Toggled off.")
        ; Auto refresh button
        AutoRefreshToggle.Click(101)
    }
    ; Notifications are ok now
    if (HadToHideNotifs && IsWindowActive()) {
        Log("GemFarm: Reenabling notifications.")
        ; Notification button
        NotifArrow.Click(NavigateTime)
        sleep(NavigateTime)
        HadToHideNotifs := false
        ; Return to trades as it'll close
        if (!IsPanelActive()) {
            Travel.OpenTrades()
            sleep(NavigateTime)
        }
    }
    if (!IsPanelActive()) {
        Travel.OpenTrades()
        sleep(NavigateTime)
    }
    ScrollAmountUp(6)
    sleep(NavigateTime)
    ; Detailed mode check, we need it off for alignment of fill trades
    TradesDetailedModeOldState := IsTradeDetailedModeOn()
    If (IsWindowActive() && IsPanelActive() && IsTradeDetailedModeOn()) {
        Log("GemFarm: Detailed mode found on. Toggled off.")
        ; Disable detailed mode if its on based on gap between blue arrows
        VerboseLog("DetailedToggle")
        DetailedToggle.Click(NavigateTime)
        ToolTip("Toggled off details", W / 2 - WinRelPosLargeW(50),
            H / 2 + WinRelPosLargeH(20), 3)
        SetTimer(ToolTip.Bind(, , , 3), -1000)
    }
    if (!IsWindowActive()) {
        if (Debug) {
            MsgBox("GemFarm: Exiting as no game.")
        }
        Log("GemFarm: Exiting as no game.")
        return
    } else {
        ; Cancel first trade, so that the first slot cannot be filled
        VerboseLog("FirstTradeCancel")
        Points.GemFarm.FirstTradeCancel.Click(NavigateTime)
        sleep(NavigateTime)
        ; Collect first trade
        VerboseLog("FirstTradeCollect")
        Points.GemFarm.FirstTradeCollect.Click(NavigateTime)
        GameKeys.RefreshTrades()
        ; Leaves the first slot free to use suitcase on
    }

    ; We try to fill trades, if that returns false exit out
    if (IsWindowActive() && IsPanelActive() && !FillTradeSlots()) {
        if (Debug) {
            MsgBox("GemFarm: Failed to fill trade slots. Exited.")
        }
        Log("GemFarm: Failed to fill trade slots. Exited.")
        ToolTip("Failed to fill trade slots, exiting.`nPress F4 to close and "
            "then retry GemFarm.",
            W / 2 - WinRelPosLargeW(100), H / 2, 5)
        SetTimer(ToolTip.Bind(, , , 5), -1000)
        return
    }
    MouseMove(W / 2, WinRelPosLargeH(800))
    sCount := 0
    fCount := 0
    GemFarmActive := true
    Log("GemFarm: Starting main loop.")
    while (GemFarmActive) {
        WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
        ; Update window size

        if (!IsWindowActive()) {
            ToolTip(, , , 15)
            if (Debug) {
                MsgBox("GemFarm: Exiting as no game.")
            }
            Log("GemFarm: Exiting as no game.")
            cReload() ; Kill the loop if the window closes
            return
        }

        if (!IsPanelActive()) {
            ToolTip(, , , 15)
            if (Debug) {
                MsgBox("GemFarm: Did not find panel. Aborted.")
                MakeWindowActive()
            }
            Log("GemFarm: Did not find panel. Aborted.")
            break
        }
        try {
            ; PixelSearch resolution independant function based on higher
            ; resolution to increase accuracy, using lower res resulted in
            ; drift when scaled up.
            Icon1 := Points.GemFarm.Icon1
            colour := Icon1.GetColour()
            If (colour = "0xFF0044") {
                Sleep(GemFarmSleepAmount)
                colour := Icon1.GetColour()
                If (colour = "0xFF0044") {
                    ; Double check to try and avoid false usage
                    Gamekeys.TriggerSuitcase()
                    Sleep(NavigateTime)
                    if (HasSuitCaseBeenUsed()) {
                        sCount++
                    } else {
                        Gamekeys.TriggerSuitcase()
                        Sleep(NavigateTime)
                        if (HasSuitCaseBeenUsed()) {
                            sCount++
                        } else {
                            fCount++
                        }
                    }
                    ToolTip("Used suitcases " sCount " times.`n"
                        "Failed to use suitcases " fCount " times.",
                        W / 2 - WinRelPosLargeW(100), H / 2, 15)

                }
            }
        } catch as exc {
            Log("GemFarm: Searching for Gem icon failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n"
                exc.Message)
        }
        GameKeys.RefreshTrades()
        Sleep(GemFarmSleepAmount)
    }
    ToolTip(, , , 15)
    GemFarmActive := false
}

RemoveBearo() {
    global HadToHideNotifs, HadToRemoveBearo
    Travel.OpenPets()
    Sleep(NavigateTime)
    coord := Rects.GemFarm.BearoSearch.PixelSearch("0x64747A")
    if (coord) {
        Log("GemFarm: Bearo found and removed.")
        ToolTip("Bearo found and removed",
            W / 2 - WinRelPosLargeW(100), H / 2 - WinRelPosLargeH(140), 16)
        SetTimer(Tooltip.Bind(, , , 16), -1000)
        HadToRemoveBearo := true
        Sleep(NavigateTime)
        cPoint(coord[1], coord[2], false).ClickOffset(1, 1, NavigateTime)
        Sleep(NavigateTime)
        return true
    } else {
        Log("GemFarm: Bearo not found.")
        return false
    }
}

FillTradeSlots() {
    ; We try to fill up the trade slots 50 times
    ; Could get stuck here if L1 leafscensions are on and no trades available
    ; So capped at trying 50 times
    Button := Points.GemFarm.Start2
    i := 200
    Log("GemFarm: Filling trade slots for suitcase farming.")
    ToolTip("Filling trade slots", W / 2 - WinRelPosLargeW(140), H / 2)
    SetTimer(ToolTip, -1000)
    While i > 0 {
        if (!IsWindowActive()) {
            Log("GemFarm: Fill trades exiting as no game.")
            cReload() ; Kill the loop if the window closes
            i := 0
            return false
        }

        if (!IsPanelActive()) {
            Log("GemFarm: Fill Trade slots did not find panel. Aborted.")
            i := 0
            return false
        }
        ; If we see background instead of a start button we are full
        if (!Button.IsBackground()) {
            ; If the button isn't active, ignore it and don't count it
            If (!Button.IsButtonInactive()) {
                sleep(50)
                Button.ClickOffset(0, 3)
                sleep(50)
                i--
            }
            GameKeys.RefreshTrades()
            sleep(50)
            If (i = 0) {
                Log("GemFarm: Filling trades failed, ran out of attempts.")
                MsgBox("Have tried to fill trade slots but no trades "
                    "available`nTry running again or disable L1 Leafscensions.")
                return false
            }
        } Else {
            ; Done? Double check
            GameKeys.RefreshTrades()
            Sleep(72)
            ; Is there any button in the start position
            if (Button.IsBackground()) {
                i := 0
            } else {
                ; Try again
                i++
            }
        }
    }
    Log("GemFarm: Completed filling trade slots.")
    return true
}

HasSuitCaseBeenUsed() {
    if (Points.GemFarm.FirstTradeCancel.IsBackground() &&
        Points.GemFarm.FirstTradeCollect.IsBackground()) {
        return false
    }
    return true
}

IsTradeAutoRefreshOn() {
    ; if white is in this area, timer active so it is on
    result := Rects.GemFarm.AutoRefreshTimer.PixelSearch()
    ; Timer pixel search
    If (result) {
        return true ; Found colour
    }
    return false
}

IsTradeDetailedModeOn() {
    If (Points.GemFarm.Detailed.IsBackground()) {
        return true ; Found colour
    }
    return false
}

ToggleAutoRefresh() {
    global TradesAutoRefreshOldState
    Travel.OpenTrades()
    Sleep(101)
    ; Disable auto refresh if its on
    Points.GemFarm.AutoRefreshToggle.Click(101)
    sleep(50)
    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
}

ToggleDetailedMode() {
    global TradesDetailedModeOldState
    Travel.OpenTrades()
    Sleep(101)
    ; Disable detailed mode if its on
    Points.GemFarm.DetailedToggle.Click(101)
    sleep(50)
    TradesDetailedModeOldState := IsTradeDetailedModeOn()
}

ResetToPriorAutoRefresh() {
    global TradesAutoRefreshOldState
    if (IsTradeAutoRefreshOn() != TradesAutoRefreshOldState) {
        Log("GemFarm: Auto refresh doesn't match previous setting, toggling.")
        ToggleAutoRefresh()
    }
}

ResetToPriorDetailedMode() {
    global TradesDetailedModeOldState
    if (IsTradeDetailedModeOn() != TradesDetailedModeOldState) {
        Log("GemFarm: Detailed mode doesn't match previous setting, toggling.")
        ToggleDetailedMode()
    }
}