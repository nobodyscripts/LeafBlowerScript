#Requires AutoHotkey v2.0

global HadToHideNotifs, HaveWarnedDisplayRewards
HadToHideNotifs := false
HaveWarnedDisplayRewards := false
global cardOpenCommonButtonX := 547
global cardOpenCommonButtonY := 806

global cardOpenRareButtonX := 1107
global cardOpenRareButtonY := 806

global cardOpenLegButtonX := 1667
global cardOpenLegButtonY := 806


fOpenCardLoop() {
    global HadToHideNotifs, W, H, X, Y

    if (IsNotificationActive()) {
        Log("Cards: Found notification covering button and hid"
            " notifications.")
        fSlowClick(32, 596, 101)
        Sleep(72)
        HadToHideNotifs := true
        ; Notifications were blocking, close notifications and reshow
    }

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
        if (!IsPanelActive()) {
            Log("Card Opening: Did not find panel. Aborted.")
            break
        }
        if (IsNotificationActive()) {
            Log("Card Opening: Found notification covering button and hid"
                " notifications.")
            fSlowClick(32, 596, 101)
            HadToHideNotifs := true
        }
        if (!CardsPermaLoop && !CardButtonsActive()) {
            Log("Cards: Found no active buttons. Exiting.")
            break
        }
        if (CardsBuyEnabled) {
            Log("Card Buy: Loop starting.")
            CardBuyLoop()
        } else {
            Log("Card Buy: Disabled.")
        }
        Log("Card Opening: Loop starting.")
        loop {
            value := CardsOpenSinglePass()
            if (!value) {
                Log("Card Opening: Loop finishing.")
                break
            }
        }
    }
    if (HadToHideNotifs) {
        Log("Cards: Reenabling notifications.")
        fSlowClick(32, 596, 101)
        HadToHideNotifs := false
    }
    ResetModifierKeys() ; Cleanup incase needed
    Log("Cards: Stopped.")
    ToolTip("Card opening aborted`nFound no active buttons.`nF3 to remove note",
        W / 2 - WinRelPosLargeW(170), H / 2)
}

CardsOpenSinglePass() {
    global HadToHideNotifs, W, H, X, Y
    ; Check if lost focus, close or crash and break if so
    if (!IsWindowActive()) {
        Log("Card opening: Did not find game. Aborted.")
        MakeWindowActive()
        ;return false ; Kill if no game
    }
    WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
    ; Update window size

    ; Use the transparent check to make sure we have a panel, otherwise
    ; we'll close notifications for no reason and get into a loop
    if (!IsPanelActive()) {
        Log("Card opening: Did not find panel. Aborted.")
        return false
    }
    ; Close notifications if they are getting in the way
    if (IsNotificationActive()) {
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
        CommonButtonActive := CardOpenerRel(cardOpenCommonButtonX, cardOpenCommonButtonY,
            5, CardsCommonAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontOpenRare) {
        RareButtonActive := CardOpenerRel(cardOpenRareButtonX, cardOpenRareButtonY,
            5, CardsRareAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontOpenLegendary) {
        LegendaryButtonActive := CardOpenerRel(cardOpenLegButtonX, cardOpenLegButtonY,
            5, CardsLegendaryAmount)
    } else {
        ; If disabled mark inactive
        LegendaryButtonActive := false
    }

    If (!CommonButtonActive && !RareButtonActive && !LegendaryButtonActive) {
        Log("Card Opening: No packs to open.")
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
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        case 25:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
        case 100:
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
        case 250:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt up}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        case 1000:
            ControlSend("{Control up}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        case 2500:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift up}", , LBRWindowTitle)
        case 25000:
            ControlSend("{Control down}", , LBRWindowTitle)
            ControlSend("{Alt down}", , LBRWindowTitle)
            ControlSend("{Shift down}", , LBRWindowTitle)
        default:

    }
}

CardOpenerRel(xin, yin, offset, amount) {
    global HaveWarnedDisplayRewards, Debug
    posx := WinRelPosLargeW(xin)
    posy := WinRelPosLargeH(yin)
    offset := WinRelPosLargeH(offset)
    ; Check if button is active, if not we can skip
    CardNumberToModifier(amount)
    Sleep(72)
    if (IsButtonActive(posx, posy) && IsWindowActive()) {
        fCustomClick(posx, posy + offset, 72)
        ; Legendary pack open
        Sleep(CardsSleepAmount)
        local i := 0
        while (IsScrollAblePanelAtTop() && i <= 5) {
            if (!HaveWarnedDisplayRewards) {
                Log("Warning: Found 'Settings/Gameplay/Display "
                    "Reward Dialogs' is on.")
                ToolTip("Warning: Card opening found Settings/Gameplay/Display"
                    " Reward Dialogs is on.`nSpeed up opening by disabling."
                    , W / 2 - WinRelPosLargeW(450),
                    H / 2 - WinRelPosLargeH(70))
                HaveWarnedDisplayRewards := true
            }
            fSlowClick(1110, 94, 72)
            Sleep(150)
            i++
        }
        if (Debug) {
            Log("Attempted to open card at " posx "*" (posy + offset))
        }
    } else {
        if (Debug) {
            Log("Could not open card at " posx "*" (posy + offset))
        }
    }
    ; Deliberate second check to return new state
    return IsButtonActive(posx, posy)
}

; Seperate buyer to have faster turnover
CardBuyerRel(posx, posy, offset, amount) {
    global Debug
    posx := WinRelPosLargeW(posx)
    posy := WinRelPosLargeH(posy)
    offset := WinRelPosLargeH(offset)
    
    if (Debug) {
        Log("Card Buy: at " posx "*" (posy + offset) " x " amount)
    }
    ; Check if button is active, if not we can skip
    CardNumberToModifier(amount)
    sleep(CardsSleepBuyAmount)
    if (!IsButtonInactive(posx, posy) && IsWindowActive()) {
        fCustomClick(posx, posy + offset, CardsSleepBuyAmount)
        ; Legendary pack open
        Sleep(CardsSleepBuyAmount)
        if (Debug) {
            Log("Attempted to buy card at " posx "*" (posy + offset))
        }
        return true
    } else {
        if (Debug) {
            Log("Could not buy card at " posx "*" (posy + offset))
        }
        return false
    }
}

CardButtonsActive() {
    CardNumberToModifier(CardsCommonAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(cardOpenCommonButtonX),
        WinRelPosLargeH(cardOpenCommonButtonY))) {
            return true
    }
    CardNumberToModifier(CardsRareAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(cardOpenRareButtonX),
        WinRelPosLargeH(cardOpenRareButtonY))) {
            return true
    }
    CardNumberToModifier(CardsLegendaryAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(cardOpenLegButtonX),
        WinRelPosLargeH(cardOpenLegButtonY))) {
            return true
    }
    CardNumberToModifier(CardsCommonBuyAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(cardBuyCommonButtonX),
        WinRelPosLargeH(cardBuyCommonButtonY))) {
            return true
    }
    CardNumberToModifier(CardsRareBuyAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(cardBuyRareButtonX),
        WinRelPosLargeH(cardBuyRareButtonY))) {
            return true
    }
    CardNumberToModifier(CardsLegBuyAmount)
    Sleep(72)
    if (IsButtonActive(WinRelPosLargeW(cardBuyLegButtonX),
        WinRelPosLargeH(cardBuyLegButtonY))) {
            return true
    }
    return false
}