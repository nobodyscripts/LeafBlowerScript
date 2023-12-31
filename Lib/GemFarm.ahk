﻿#Requires AutoHotkey v2.0

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
    if (!GoToDesert()) {
        Log("GemFarm: Could not find desert area. Aborted travel.")
        ToolTip("Could not find desert area`nUse F4 to finish",
            W / 2 - WinRelPosW(50),
            H / 2, 3)
        return
    }

    ; Disable notifications while doing bearo and auto refresh check
    if (IsWindowActive() && IsNotificationActive()) {
        Log("GemFarm: Found notifications on and toggled off.")
        ; Notifications were blocking, close notifications
        fSlowClick(32, 596, 72)
        Sleep(101)
        HadToHideNotifs := true
    }

    ; Removes bearo from your pet team if its active
    RemoveBearo()
    sleep(150)
    if (!IsWindowActive()) {
        Log("GemFarm: Exiting as no game.")
        return
    } else {
        ; We need the trade window now the Bearo and traveling is done
        OpenTrades()
        sleep(150)
        RefreshTrades()
        ; Need to refresh once otherwise there might be blank trade screen
    }

    ; Disable auto refresh if its on based on timer at top of panel
    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
    If (TradesAutoRefreshOldState && IsWindowActive() && IsPanelActive()) {
        Log("GemFarm: Auto refresh found on. Toggled off.")
        ; Auto refresh button
        fCustomClick(WinRelPosLargeW(1000), WinRelPosLargeH(1100), 101)
    }
    ; Notifications are ok now
    if (HadToHideNotifs && IsWindowActive()) {
        Log("GemFarm: Reenabling notifications.")
        ; Notification button
        fSlowClick(32, 596, 72)
        sleep(72)
        HadToHideNotifs := false
        ; Return to trades as it'll close
        if (!IsPanelActive()) {
            OpenTrades()
            sleep(72)
        }
    }
    if (!IsPanelActive()) {
        OpenTrades()
        sleep(72)
    }
    ScrollAmountUp(6)
    sleep(50)
    ; Detailed mode check, we need it off for alignment of fill trades
    TradesDetailedModeOldState := IsTradeDetailedModeOn()
    If (IsWindowActive() && IsPanelActive() && IsTradeDetailedModeOn()) {
        Log("GemFarm: Detailed mode found on. Toggled off.")
        ; Disable detailed mode if its on based on gap between blue arrows
        fCustomClick(WinRelPosLargeW(1357), WinRelPosLargeH(1100), 101)
        ToolTip("Toggled off details", W / 2 - WinRelPosLargeW(50),
            H / 2 + WinRelPosLargeH(20), 3)
        SetTimer(ToolTip.Bind(, , , 3), -1000)
    }
    if (!IsWindowActive()) {
        Log("GemFarm: Exiting as no game.")
        return
    } else {
        ; Cancel first trade, so that the first slot cannot be filled
        fCustomClick(WinRelPosLargeW(1920), WinRelPosLargeH(400), 101)
        sleep(50)
        ; Collect first trade
        fCustomClick(WinRelPosLargeW(1990), WinRelPosLargeH(400), 101)
        RefreshTrades()
        ; Leaves the first slot free to use suitcase on
    }

    ; We try to fill trades, if that returns false exit out
    if (IsWindowActive() && IsPanelActive() && !FillTradeSlots()) {
        Log("GemFarm: Failed to fill trade slots. Exited.")
        ToolTip("Failed to fill trade slots, exiting.`nPress F4 to close and "
            "then retry GemFarm.",
            W / 2 - WinRelPosLargeW(100), H / 2, 5)
        SetTimer(ToolTip.Bind(, , , 5), -1000)
        return
    }
    MouseMove(W/2, WinRelPosH(400))
    sCount := 0
    fCount := 0
    GemFarmActive := true
    Log("GemFarm: Starting main loop.")
    while (GemFarmActive) {
        WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
        ; Update window size

        if (!IsWindowActive()) {
            ToolTip(, , , 15)
            Log("GemFarm: Exiting as no game.")
            cReload() ; Kill the loop if the window closes
            return
        }

        if (!IsPanelActive()) {
            ToolTip(, , , 15)
            Log("GemFarm: Did not find panel. Aborted.")
            break
        }
        try {
            ; PixelSearch resolution independant function based on higher
            ; resolution to increase accuracy, using lower res resulted in
            ; drift when scaled up.
            colour := PixelGetColor(WinRelPosLargeW(1252), WinRelPosLargeH(397))
            If (colour = "0xFF0044") {
                Sleep(GemFarmSleepAmount)
                colour := PixelGetColor(WinRelPosLargeW(1252),
                    WinRelPosLargeH(397))
                If (colour = "0xFF0044") {
                    ; Double check to try and avoid false usage
                    TriggerSuitcase()
                    Sleep(GemFarmSleepAmount)
                    if (HasSuitCaseBeenUsed()) {
                        sCount++
                    } else {
                        fCount++
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
        RefreshTrades()
        Sleep(GemFarmSleepAmount)
    }
    ToolTip(, , , 15)
    GemFarmActive := false
}

RemoveBearo() {
    global HadToHideNotifs, HadToRemoveBearo
    OpenPets()
    Sleep(101)
    OutX := 0
    OutY := 0
    try {
        X1 := WinRelPosLargeW(675)
        Y1 := WinRelPosLargeH(1070)
        X2 := WinRelPosLargeW(1494)
        Y2 := WinRelPosLargeH(1138)
        found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, "0x64747A")
        If (found and OutX != 0) {
            Log("GemFarm: Bearo found and removed.")
            ToolTip("Bearo found and removed",
                W / 2 - WinRelPosW(50), H / 2 - WinRelPosH(70), 16)
            SetTimer(Tooltip.Bind(, , , 16), -1000)
            HadToRemoveBearo := true
            Sleep(72)
            fCustomClick(OutX, OutY, 72)
            Sleep(72)
            return true
        }
    } catch as exc {
        Log("GemFarm: Searching for Bearo failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    Log("GemFarm: Bearo not found.")
    return false
}

FillTradeSlots() {
    ; We try to fill up the trade slots 50 times
    ; Could get stuck here if L1 leafscensions are on and no trades available
    ; So capped at trying 50 times
    i := 200
    Log("GemFarm: Filling trade slots for suitcase farming.")
    ToolTip("Filling trade slots", W / 2 - WinRelPosW(70), H / 2)
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
        if (!IsBackground(WinRelPosW(1040), WinRelPosH(227))) {
            ; If the button isn't active, ignore it and don't count it
            If (!IsButtonInactive(WinRelPosW(1040), WinRelPosH(222))) {
                sleep(50)
                fSlowClick(1040, 230)
                sleep(50)
                i--
            }
            RefreshTrades()
            sleep(50)
            If (i = 0) {
                Log("GemFarm: Filling trades failed, ran out of attempts.")
                MsgBox("Have tried to fill trade slots but no trades "
                    "available`nTry running again or disable L1 Leafscensions.")
                return false
            }
        } Else {
            ; Done? Double check
            RefreshTrades()
            Sleep(72)
            ; Is there any button in the start position
            if (IsBackground(WinRelPosW(1040), WinRelPosH(227))) {
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
    if (IsBackground(WinRelPosW(960), WinRelPosH(195)) &&
        IsBackground(WinRelPosW(997), WinRelPosH(195))) {
            return false
    }
    return true
}

IsTradeAutoRefreshOn() {
    ; if white is in this area, timer active so it is on
    ; 615 292
    ; 698 326
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(615), WinRelPosLargeH(292),
            WinRelPosLargeW(698), WinRelPosLargeH(326), "0xFFFFFF", 0)
        ; Timer pixel search
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        Log("GemFarm: Searching for Auto Refresh state failed - " exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }

    return false
}

IsTradeDetailedModeOn() {
    If (IsBackground(WinRelPosLargeW(1186), WinRelPosLargeH(456))) {
        return true ; Found colour
    }
    return false
}

ToggleAutoRefresh() {
    global TradesAutoRefreshOldState
    OpenPets()
    Sleep(101)
    OpenTrades()
    Sleep(101)
    ; Disable auto refresh if its on based on timer at top of panel
    fCustomClick(WinRelPosLargeW(1000), WinRelPosLargeH(1100), 101)
    sleep(50)
    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
}

ToggleDetailedMode() {
    global TradesDetailedModeOldState
    OpenPets()
    Sleep(101)
    OpenTrades()
    Sleep(101)
    ; Disable auto refresh if its on based on timer at top of panel
    fCustomClick(WinRelPosLargeW(1357), WinRelPosLargeH(1100), 101)
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