#Requires AutoHotkey v2.0
global HadToHideNotifs
HadToHideNotifs := false

fOpenCardLoop() {
    global HadToHideNotifs, W, H, X, Y

    if (!GotoCardsFirstTab()) {
        ; We still failed to travel
        Log("Cards: Failed to open cards first tab")
        return
    }

    loop {
        if (!IsWindowActive()) {
            Log("Cards: Did not find game. Aborted.")
            return ; Kill if no game
        }
        if (!CardButtonsActive() && !CardsPermaLoop) {
            Log("Cards: Exiting.")
            break
        }
        if (CardsBuyEnabled) {
            Log("Card buy: Loop starting.")
            CardBuyLoop()
        }
        Log("Card Opening: Loop starting.")
        loop {
            if (!CardsOpenSinglePass()) {
                Log("Card Opening: Loop finishing.")
                break
            }
        }
    }
    if (HadToHideNotifs) {
        Log("Cards: Reenabling notifications.")
        fSlowClick(32, 596, 17)
        HadToHideNotifs := false
    }
    ResetModifierKeys() ; Cleanup incase needed
    Log("Cards: Stopped.")
    ToolTip("Card opening aborted`nFound no active buttons.`nF3 to remove note",
        W / 2 - WinRelPosLargeH(170), H / 2)
}

CardsOpenSinglePass() {
    global HadToHideNotifs, W, H, X, Y
    ; Check if lost focus, close or crash and break if so
    if (!IsWindowActive()) {
        Log("Card opening: Did not find game. Aborted.")
        return false ; Kill if no game
    }
    WinGetClientPos(&X, &Y, &W, &H, "Leaf Blower Revolution")
    ; Update window size

    ; Use the transparent check to make sure we have a panel, otherwise
    ; we'll close notifications for no reason and get into a loop
    if (IsPanelTransparent()) {
        Log("Card opening: Did not find panel.")
        return false
    }
    CommonX := WinRelPosLargeW(565)
    CommonY := WinRelPosLargeH(820)
    ; Close notifications if they are getting in the way
    if (!IsPanelTransparent() && IsCoveredByNotification(CommonX, CommonY)) {
        Log("Card opening: Found notification covering button and hid"
            " notifications.")
        fSlowClick(32, 596, 101)
        HadToHideNotifs := true
        ; Notifications were blocking, close notifications and reshow
        OpenCards()
        Sleep(101)
    }

    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontOpenCommons) {
        CommonButtonActive := CardOpenerRel(565, 820,
            5, CardsCommonAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontOpenRare) {
        RareButtonActive := CardOpenerRel(1110, 820,
            5, CardsRareAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontOpenLegendary) {
        LegendaryButtonActive := CardOpenerRel(1673, 820,
            5, CardsLegendaryAmount)
    } else {
        ; If disabled mark inactive
        LegendaryButtonActive := false
    }

    If (!CommonButtonActive && !RareButtonActive && !LegendaryButtonActive)
    {
        Log("Card opening: No packs to open.")
        return false
    }
    return true
}

CardNumberToModifier(num) {
    /*
    shift 10
    ctrl 25
    alt 100
    */
    switch num {
        case 10:
            ControlSend("{Control up}", , "Leaf Blower Revolution")
            ControlSend("{Alt up}", , "Leaf Blower Revolution")
            ControlSend("{Shift down}", , "Leaf Blower Revolution")
        case 25:
            ControlSend("{Control down}", , "Leaf Blower Revolution")
            ControlSend("{Alt up}", , "Leaf Blower Revolution")
            ControlSend("{Shift up}", , "Leaf Blower Revolution")
        case 100:
            ControlSend("{Control up}", , "Leaf Blower Revolution")
            ControlSend("{Alt down}", , "Leaf Blower Revolution")
            ControlSend("{Shift up}", , "Leaf Blower Revolution")
        case 250:
            ControlSend("{Control down}", , "Leaf Blower Revolution")
            ControlSend("{Alt up}", , "Leaf Blower Revolution")
            ControlSend("{Shift down}", , "Leaf Blower Revolution")
        case 1000:
            ControlSend("{Control up}", , "Leaf Blower Revolution")
            ControlSend("{Alt down}", , "Leaf Blower Revolution")
            ControlSend("{Shift down}", , "Leaf Blower Revolution")
        case 2500:
            ControlSend("{Control down}", , "Leaf Blower Revolution")
            ControlSend("{Alt down}", , "Leaf Blower Revolution")
            ControlSend("{Shift up}", , "Leaf Blower Revolution")
        case 25000:
            ControlSend("{Control down}", , "Leaf Blower Revolution")
            ControlSend("{Alt down}", , "Leaf Blower Revolution")
            ControlSend("{Shift down}", , "Leaf Blower Revolution")
        default:

    }
}

CardOpenerRel(x, y, offset, amount) {
    x := WinRelPosLargeW(x)
    y := WinRelPosLargeH(y)
    offset := WinRelPosLargeH(offset)
    ; Check if button is active, if not we can skip
    CardNumberToModifier(amount)
    Sleep(72)
    if (IsButtonActive(x, y) && IsWindowActive()) {
        fCustomClick(x, y + offset, 72)
        ; Legendary pack open
        Sleep(CardsSleepAmount)
    }
    ; Deliberate second check to return new state
    return IsButtonActive(x, y)
}

; Seperate buyer to have faster turnover
CardBuyerRel(posx, posy, offset, amount) {
    posx := WinRelPosLargeW(posx)
    posy := WinRelPosLargeH(posy)
    offset := WinRelPosLargeH(offset)
    ; Check if button is active, if not we can skip
    CardNumberToModifier(amount)
    sleep(CardsSleepBuyAmount)
    if (!IsButtonInactive(posx, posy) && IsWindowActive()) {
        fCustomClick(posx, posy + offset, CardsSleepBuyAmount)
        ; Legendary pack open
        Sleep(CardsSleepBuyAmount)
        return true
    } else {
        return false
    }
}

CardButtonsActive() {
    CardNumberToModifier(CardsCommonAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(565), WinRelPosLargeH(820))) {
        return true
    }
    CardNumberToModifier(CardsRareAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(1110), WinRelPosLargeH(820))) {
        return true
    }
    CardNumberToModifier(CardsLegendaryAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(1673), WinRelPosLargeH(820))) {
        return true
    }
    CardNumberToModifier(CardsCommonBuyAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(590), WinRelPosLargeH(950))) {
        return true
    }
    CardNumberToModifier(CardsRareBuyAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(1155), WinRelPosLargeH(950))) {
        return true
    }
    CardNumberToModifier(CardsLegBuyAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(1711), WinRelPosLargeH(950))) {
        return true
    }
    return false
}