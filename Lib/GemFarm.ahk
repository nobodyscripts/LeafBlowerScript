#Requires AutoHotkey v2.0

global TradesAutoRefreshOldState
TradesAutoRefreshOldState := false

fGemFarmSuitcase() {

    global TradesAutoRefreshOldState
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets()
    ; Opens or closes another screen so that when areas is opened it doesn't
    ; close
    Sleep 150
    OpenAreas()
    Sleep 150
    ResetAreaScroll() ; Reset tab and scroll position
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }
    Sleep 150
    MouseMove(WinRelPosW(875), WinRelPosH(313)) ; Move mouse for scrolling
    ; Move the screen up to reset the scroll incase its been changed outside
    ; the script
    ScrollAmountDown(22) ; Scroll down for the zones
    fSlowClick(875, 298) ; Set zone to golden suitcase territory

    OpenPets()
    Sleep 150
    RemoveBearo() ; Removes bearo from your pet team if its active
    Sleep 200

    OpenTrades()
    Sleep 150
    RefreshTrades()
    ; Need to refresh once otherwise there might be blank trade screen

    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
    ; Store old state to reset
    If (TradesAutoRefreshOldState) {
        ; Disable auto refresh if its on based on timer at top of panel
        fCustomClick(WinRelPosLargeW(1000), WinRelPosLargeH(1100), 100)
        ToolTip("Toggled off", WinRelPosLargeW(1000), WinRelPosLargeH(1100))
    }
    Sleep 100
    If (IsTradeDetailedModeOn()) {
        ; Disable auto refresh if its on based on timer at top of panel
        fCustomClick(WinRelPosLargeW(1357), WinRelPosLargeH(1100), 100)
    }
    Sleep 100
    ScrollAmountUp(6)
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
                Sleep 71
                colour := PixelGetColor(WinRelPosLargeW(1252),
                    WinRelPosLargeH(397))
                If (colour = "0xFF0044") {
                    ; Double check to try and avoid false usage
                    TriggerSuitcase()
                    Sleep 34
                }
            }
        } catch as exc {
            MsgBox "Could not conduct the search due to the following error:`n"
            exc.Message
        }
        RefreshTrades()
        Sleep 34
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
            i := 0
        }
    }
    SetTimer(ToolTip, -1)
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
    TradesAutoRefreshOldState := IsTradeAutoRefreshOn()
}