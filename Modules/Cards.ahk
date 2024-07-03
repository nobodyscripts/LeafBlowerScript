#Requires AutoHotkey v2.0

global HadToHideNotifs := false
global HaveWarnedDisplayRewards := false


; Vscode loves to warn me about globals so defining even though loading save
global CardsPermaLoop := false
global CardsDontOpenCommons := 0
global CardsCommonAmount := 1
global CardsCommonBuyAmount := 1
global CardsDontOpenRare := 0
global CardsRareAmount := 1
global CardsRareBuyAmount := 1
global CardsDontOpenLegendary := 0
global CardsLegendaryAmount := 1
global CardsLegBuyAmount := 1
global CardsSleepAmount := 150
global CardsSleepBuyAmount := 150
global CardsGreedyOpen := false
global CardsGreedyBuy := false

fOpenCardLoop() {
    global HadToHideNotifs, W, H, X, Y

    if (IsNotificationActive()) {
        Log("Cards: Found notification covering button and hid"
            " notifications.")
        Points.Misc.NotifArrow.Click(101)
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
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := true
        }
        if (!CardsPermaLoop && !CardButtonsActive()) {
            Log("Cards: Found no active buttons. Exiting.")
            break
        } else if (!CardButtonsActive()) {
            Log("CardsLoop: Found no active buttons. Looping.")
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
        Points.Misc.NotifArrow.Click(101)
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
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := true
        ; Notifications were blocking, close notifications and reshow
        Travel.OpenCards()
        Sleep(101)
    }

    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontOpenCommons) {
        CommonButtonActive := CardOpenerRel(1, 5, CardsCommonAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontOpenRare) {
        RareButtonActive := CardOpenerRel(2, 5, CardsRareAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontOpenLegendary) {
        LegendaryButtonActive := CardOpenerRel(3, 5, CardsLegendaryAmount)
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

CardOpenerRel(quality, offset, amount) {
    global HaveWarnedDisplayRewards, Debug, CardsGreedyOpen
    offset := WinRelPosLargeH(offset)
    switch quality {
        case 1:
            button := Points.Card.OpenCommon
        case 2:
            button := Points.Card.OpenRare
        case 3:
            button := Points.Card.OpenLegend
        default:
            button := Points.Card.OpenCommon
    }
    clickdelay := (CardsSleepAmount > 101) ? 54 : CardsSleepAmount
    if (CardsGreedyOpen) {
        button.GreedyModifierClick(CardsSleepAmount, clickdelay, amount)
        VerboseLog("Greedy opening " CardQualityToStr(quality) " quality card")
        return false
    }
    ; Check if button is active, if not we can skip
    AmountToModifier(amount)
    Sleep(NavigateTime)
    if (button.IsButtonActive() && IsWindowActive()) {
        ; Pack open
        button.ClickOffset(, offset, clickdelay)
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
            Points.Misc.PanelClose.Click(72)
            Sleep(150)
            i++
        }
        VerboseLog("Attempted to open " CardQualityToStr(quality) " type card")
    } else {
        VerboseLog("Could not open " CardQualityToStr(quality) " type card")
    }
    ; Deliberate second check to return new state
    return button.IsButtonActive()
}

; Seperate buyer to have faster turnover
CardBuyerRel(quality, offset, amount) {
    offset := WinRelPosLargeH(offset)
    switch quality {
        case 1:
            button := Points.Card.BuyCommon
        case 2:
            button := Points.Card.BuyRare
        case 3:
            button := Points.Card.BuyLegend
        default:
            button := Points.Card.BuyCommon
    }
    ; Check if button is active, if not we can skip
    if (CardsGreedyBuy) {
        ResetModifierKeys()
        button.GreedyModifierClick(CardsSleepBuyAmount, CardsSleepBuyAmount, amount)
        DebugLog("Greedy buy " CardQualityToStr(quality) " quality card")
        return false
    } else {
        AmountToModifier(amount)
        sleep(CardsSleepBuyAmount)
        if (!button.IsButtonInactive() && IsWindowActive()) {
            button.ClickOffset(, offset, CardsSleepBuyAmount)
            ; Legendary pack open
            Sleep(CardsSleepBuyAmount)
            VerboseLog("Attempting buy " CardQualityToStr(quality) " quality card")
            return true
        } else {
            VerboseLog("Could not buy " CardQualityToStr(quality) " quality card")
            return false
        }
    }
}

CardButtonsActive() {
    ; Common
    if (!CardsGreedyOpen) {
        AmountToModifier(CardsCommonAmount)
    } else {
        ResetModifierKeys()
    }
    Sleep(72)
    if (Points.Card.OpenCommon.IsButtonActive()) {
        return true
    }

    ; Rare
    if (!CardsGreedyOpen) {
        AmountToModifier(CardsRareAmount)
    } else {
        ResetModifierKeys()
    }
    Sleep(72)
    if (Points.Card.OpenRare.IsButtonActive()) {
        return true
    }

    ; Legendary
    if (!CardsGreedyOpen) {
        AmountToModifier(CardsLegendaryAmount)
    } else {
        ResetModifierKeys()
    }
    Sleep(72)
    if (Points.Card.OpenLegend.IsButtonActive()) {
        return true
    }
    if (CardsBuyEnabled) {
        ; Common
        if (!CardsGreedyBuy) {
            AmountToModifier(CardsCommonBuyAmount)
        } else {
            ResetModifierKeys()
        }
        Sleep(72)
        if (Points.Card.BuyCommon.IsButtonActive()) {
            return true
        }

        ; Rare
        if (!CardsGreedyBuy) {
            AmountToModifier(CardsRareBuyAmount)
        } else {
            ResetModifierKeys()
        }
        Sleep(72)
        if (Points.Card.BuyRare.IsButtonActive()) {
            return true
        }

        ; Legendary
        if (!CardsGreedyBuy) {
            AmountToModifier(CardsLegBuyAmount)
        } else {
            ResetModifierKeys()
        }
        Sleep(72)
        if (Points.Card.BuyLegend.IsButtonActive()) {
            return true
        }
    }
    return false
}

CardQualityToStr(var) {
    switch var {
        case 1:
            return "common"
        case 2:
            return "rare"
        case 3:
            return "legendry"
        default:
            return "common"
    }
}