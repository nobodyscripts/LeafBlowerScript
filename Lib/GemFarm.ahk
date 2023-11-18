#Requires AutoHotkey v2.0

global TradesAutoRefreshOldState
global TradesDetailedModeOldState
TradesAutoRefreshOldState := false
TradesDetailedModeOldState := false

fGemFarmSuitcase() {

    global TradesAutoRefreshOldState
    global TradesDetailedModeOldState
    global GemFarmSleepAmount
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets()
    ; Opens or closes another screen so that when areas is opened it doesn't
    ; close
    Sleep 200
    OpenAreas()
    Sleep 200
    ResetAreaScroll() ; Reset tab and scroll position
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }
    Sleep 200
    ;MouseMove(WinRelPosW(875), WinRelPosH(313)) ; Move mouse for scrolling
    ; Move the screen up to reset the scroll incase its been changed outside
    ; the script
    ;Sleep 150
    ScrollAmountDown(22) ; Scroll down for the zones
    Sleep 200
    DesertLeaf := FindDesertZone()
    if (!DesertLeaf) {
        ToolTip("Could not find desert area`nUse F4 to finish",
            W / 2 - WinRelPosW(50),
            H / 2)
        return
    }
    ButtonX := DesertLeaf[1] + WinRelPosLargeW(225)
    ButtonY := DesertLeaf[2] + WinRelPosLargeW(30)
    if (IsBackground(ButtonX, ButtonY)) {
        ToolTip("Could not find desert area`nUse F4 to finish",
            W / 2 - WinRelPosW(50),
            H / 2)
        return
    }
    fCustomClick(ButtonX, ButtonY, 72) ; Set zone to golden suitcase territory

    Sleep 200
    OpenPets()
    Sleep 200
    RemoveBearo() ; Removes bearo from your pet team if its active
    Sleep 150

    OpenTrades()
    Sleep 150
    RefreshTrades()
    ; Need to refresh once otherwise there might be blank trade screen

    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
    ; Store old state to reset
    If (TradesAutoRefreshOldState) {
        ; Disable auto refresh if its on based on timer at top of panel
        fCustomClick(WinRelPosLargeW(1000), WinRelPosLargeH(1100), 100)
        ToolTip("Toggled off auto refresh", W / 2 - WinRelPosLargeW(50), H / 2, 1)

    }
    ScrollAmountUp(6)
    Sleep 50
    TradesDetailedModeOldState := IsTradeDetailedModeOn()
    If (IsTradeDetailedModeOn()) {
        ; Disable detailed mode if its on based on gap between blue arrows
        fCustomClick(WinRelPosLargeW(1357), WinRelPosLargeH(1100), 100)
        ToolTip("Toggled off details", W / 2 - WinRelPosLargeW(50), H / 2 + WinRelPosLargeH(20))
        SetTimer(ToolTip, -500)
    }
    ; Cancel first trade, so that the first slot cannot be filled
    fCustomClick(WinRelPosLargeW(1920), WinRelPosLargeH(400), 100)
    Sleep 50
    ; Collect first trade
    fCustomClick(WinRelPosLargeW(1990), WinRelPosLargeH(400), 100)
    RefreshTrades()
    FillTradeSlots() ; Leaves the first slot free to use suitcase on

    Loop {
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
        ; Update window size

        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                break ; Kill the loop if the window closes
        }
        try {
            ; PixelSearch resolution independant function based on higher
            ; resolution to increase accuracy, using lower res resulted in
            ; drift when scaled up.
            colour := PixelGetColor(WinRelPosLargeW(1252), WinRelPosLargeH(397))
            If (colour = "0xFF0044") {
                If (GemFarmSleepAmount > 0) {
                    Sleep 71 + GemFarmSleepAmount
                } else {
                    Sleep 71
                }
                colour := PixelGetColor(WinRelPosLargeW(1252),
                    WinRelPosLargeH(397))
                If (colour = "0xFF0044") {
                    ; Double check to try and avoid false usage
                    TriggerSuitcase()
                    If (GemFarmSleepAmount > 0) {
                        Sleep 71 + GemFarmSleepAmount
                    } else {
                        Sleep 71
                    }
                }
            }
        } catch as exc {
            MsgBox "Could not conduct the search due to the following error:`n"
            exc.Message
        }
        RefreshTrades()
        If (GemFarmSleepAmount > 0) {
            Sleep 71 + GemFarmSleepAmount
        } else {
            Sleep 71
        }
    }
}

RemoveBearo() {
    ; Check two points next to the pet buttons, remove notification if possible
    if (!IsBackground(WinRelPosLargeW(647), WinRelPosLargeH(1070))) {
        ; If we find non background we'll click to remove the notification
        fCustomClick(WinRelPosLargeW(647), WinRelPosLargeH(1070))
    }
    if (!IsBackground(WinRelPosLargeW(647), WinRelPosLargeH(1138))) {
        ; If we find non background we'll click to remove the notification
        fCustomClick(WinRelPosLargeW(647), WinRelPosLargeH(1138))
    }
    OutX := 0
    OutY := 0
    try {
        X1 := WinRelPosLargeW(675)
        Y1 := WinRelPosLargeH(1070)
        X2 := WinRelPosLargeW(1494)
        Y2 := WinRelPosLargeH(1138)
        found := PixelSearch(&OutX, &OutY, X1, Y1, X2, Y2, "0x64747A", 0)
        If (found and OutX != 0) {
            ToolTip("Bearo found and removed", OutX, OutY)
            SetTimer(Tooltip, -100)
            Sleep 72
            fCustomClick(OutX, OutY)
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
        return
    }
}

FillTradeSlots() {
    ; We try to fill up the trade slots 50 times
    ; Could get stuck here if L1 leafscensions are on and no trades available
    ; So capped at trying 50 times
    i := 100
    ToolTip("Filling trade slots", W / 2 - 70, H / 2)
    SetTimer(ToolTip, -1000)
    While i > 0 {
        ; If we see background instead of a start button we are full
        if (!IsBackground(WinRelPosW(1040), WinRelPosH(227))) {
            ; If the button isn't active, ignore it and don't count it
            If (!IsButtonInactive(WinRelPosW(1040), WinRelPosH(222))) {
                Sleep 50
                fSlowClick(1040, 230)
                Sleep 50
                i := i - 1
            }
            RefreshTrades()
            Sleep 50
            If (i = 1) {
                MsgBox("Have tried to fill trade slots but no trades available`nTry running again or disable L1 Leafscensions.")
            }
        } Else {
            ; Done? Double check
            RefreshTrades()
            Sleep 72
            if (IsBackground(WinRelPosW(1040), WinRelPosH(227))) {
                i := 0
            } else {
                ; Try again
                i := i + 1
            }
        }
    }
}

IsTradeAutoRefreshOn() {
    ; if white is in this area, timer active so it is on
    ; 615 292
    ; 698 326
    ; Check two points next to the area, remove notification if possible
    if (!IsBackground(WinRelPosLargeW(500), WinRelPosLargeH(292))) {
        ; If we find non background we'll click to remove the notification
        fCustomClick(WinRelPosLargeW(500), WinRelPosLargeH(292))
    }
    if (!IsBackground(WinRelPosLargeW(500), WinRelPosLargeH(326))) {
        ; If we find non background we'll click to remove the notification
        fCustomClick(WinRelPosLargeW(500), WinRelPosLargeH(326))
    }
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(615), WinRelPosLargeH(292),
            WinRelPosLargeW(698), WinRelPosLargeH(326), "0xFFFFFF", 0)
        ; Timer pixel search
        If (found and OutX != 0) {
            return true ; Found colour
        }
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
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
    Sleep 100
    OpenTrades()
    Sleep 100
    ; Disable auto refresh if its on based on timer at top of panel
    fCustomClick(WinRelPosLargeW(1000), WinRelPosLargeH(1100), 100)
    sleep 50
    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
}

ToggleDetailedMode() {
    global TradesDetailedModeOldState
    OpenPets()
    Sleep 100
    OpenTrades()
    Sleep 100
    ; Disable auto refresh if its on based on timer at top of panel
    fCustomClick(WinRelPosLargeW(1357), WinRelPosLargeH(1100), 100)
    sleep 50
    TradesDetailedModeOldState := IsTradeDetailedModeOn()
}

FindDesertZone() {
    try {
        found := PixelSearch(&OutX, &OutY,
            WinRelPosLargeW(1433), WinRelPosLargeH(278),
            WinRelPosLargeW(1472), WinRelPosLargeH(1072), "0x4A4429", 0)
        ; Leaf pixel search (sand in the third slot)
        If (!found || OutX = 0) {
            ; Not found
            return false
        }
        return [Outx, OutY]
    } catch as exc {
        MsgBox ("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
}

ResetToPriorAutoRefresh() {
    global TradesAutoRefreshOldState
    if (IsTradeAutoRefreshOn() != TradesAutoRefreshOldState) {
        ToggleAutoRefresh()
    }
}

ResetToPriorDetailedMode() {
    global TradesDetailedModeOldState
    if (IsTradeDetailedModeOn() != TradesDetailedModeOldState) {
        ToggleDetailedMode()
    }
}