#Requires AutoHotkey v2.0

Global HadToHideNotifs := false
Global HaveWarnedDisplayRewards := false

; Vscode loves to warn me about globals so defining even though loading save
Global CardsPermaLoop := false
Global CardsDontOpenCommons := 0
Global CardsCommonAmount := 1
Global CardsCommonBuyAmount := 1
Global CardsDontOpenRare := 0
Global CardsRareAmount := 1
Global CardsRareBuyAmount := 1
Global CardsDontOpenLegendary := 0
Global CardsLegendaryAmount := 1
Global CardsLegBuyAmount := 1
Global CardsSleepAmount := 150
Global CardsSleepBuyAmount := 150
Global CardsGreedyOpen := false
Global CardsGreedyBuy := false

fOpenCardLoop() {
    Global HadToHideNotifs

    If (IsNotificationActive()) {
        Out.I("Cards: Found notification covering button and hid"
            " notifications.")
        Points.Misc.NotifArrow.Click(101)
        Sleep(72)
        HadToHideNotifs := true
        ; Notifications were blocking, close notifications and reshow
    }

    If (!GotoCardsFirstTab()) {
        ; We still failed to travel
        Out.I("Cards: Failed to open cards first tab")
        Return
    }

    Loop {
        If (!Window.IsActive()) {
            Out.I("Cards: Did not find game. Aborted.")
            Return ; Kill if no game
        }
        If (!Window.IsPanel()) {
            Out.I("Card Opening: Did not find panel. Aborted.")
            Break
        }
        If (IsNotificationActive()) {
            Out.I("Card Opening: Found notification covering button and hid"
                " notifications.")
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := true
        }
        If (!CardsPermaLoop && !CardButtonsActive()) {
            Out.I("Cards: Found no active buttons. Exiting.")
            Break
        } Else If (!CardButtonsActive()) {
            Out.I("CardsLoop: Found no active buttons. Looping.")
        }
        If (CardsBuyEnabled) {
            Out.I("Card Buy: Loop starting.")
            CardBuyLoop()
        } Else {
            Out.I("Card Buy: Disabled.")
        }
        Out.I("Card Opening: Loop starting.")
        Loop {
            value := CardsOpenSinglePass()
            If (!value) {
                Out.I("Card Opening: Loop finishing.")
                Break
            }
        }
    }
    If (HadToHideNotifs) {
        Out.I("Cards: Reenabling notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := false
    }
    ResetModifierKeys() ; Cleanup incase needed
    Out.I("Cards: Stopped.")
    ToolTip("Card opening aborted`nFound no active buttons.`nF3 to remove note",
        Window.W / 2 - Window.RelW(170), Window.H / 2)
}

CardsOpenSinglePass() {
    Global HadToHideNotifs
    ; Check if lost focus, close or crash and break if so
    If (!Window.IsActive()) {
        Out.I("Card opening: Did not find game. Aborted.")
        Window.Activate()
        ;return false ; Kill if no game
    }

    ; Use the transparent check to make sure we have a panel, otherwise
    ; we'll close notifications for no reason and get into a loop
    If (!Window.IsPanel()) {
        Out.I("Card opening: Did not find panel. Aborted.")
        Return false
    }
    ; Close notifications if they are getting in the way
    If (IsNotificationActive()) {
        Out.I("Card opening: Found notification covering button and hid"
            " notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := true
        ; Notifications were blocking, close notifications and reshow
        Shops.OpenCards()
        Sleep(101)
    }

    ; Common
    ; If disabled skip, get active state back
    If (!CardsDontOpenCommons) {
        CommonButtonActive := CardOpenerRel(1, 5, CardsCommonAmount)
    } Else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    If (!CardsDontOpenRare) {
        RareButtonActive := CardOpenerRel(2, 5, CardsRareAmount)
    } Else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    If (!CardsDontOpenLegendary) {
        LegendaryButtonActive := CardOpenerRel(3, 5, CardsLegendaryAmount)
    } Else {
        ; If disabled mark inactive
        LegendaryButtonActive := false
    }

    If (!CommonButtonActive && !RareButtonActive && !LegendaryButtonActive) {
        Out.I("Card Opening: No packs to open.")
        Return false
    }
    Return true
}

CardOpenerRel(quality, offset, amount) {
    Global HaveWarnedDisplayRewards, Debug, CardsGreedyOpen
    offset := Window.RelH(offset)
    Switch quality {
    Case 1:
        button := Points.Card.OpenCommon
    Case 2:
        button := Points.Card.OpenRare
    Case 3:
        button := Points.Card.OpenLegend
    default:
        button := Points.Card.OpenCommon
    }
    clickdelay := (CardsSleepAmount > 101) ? 54 : CardsSleepAmount
    If (CardsGreedyOpen) {
        button.GreedyModifierClick(CardsSleepAmount, clickdelay, amount)
        Out.V("Greedy opening " CardQualityToStr(quality) " quality card")
        Return false
    }
    ; Check if button is active, if not we can skip
    AmountToModifier(amount)
    Sleep(NavigateTime)
    If (button.IsButtonActive() && Window.IsActive()) {
        ; Pack open
        button.ClickOffset(, offset, clickdelay)
        Sleep(CardsSleepAmount)
        Local i := 0
        While (IsScrollAblePanelAtTop() && i <= 5) {
            If (!HaveWarnedDisplayRewards) {
                Out.I("Warning: Found 'Settings/Gameplay/Display "
                    "Reward Dialogs' is on.")
                ToolTip("Warning: Card opening found Settings/Gameplay/Display"
                    " Reward Dialogs is on.`nSpeed up opening by disabling.",
                    Window.W / 2 - Window.RelW(450), Window.H / 2 - Window.RelH(
                        70))
                HaveWarnedDisplayRewards := true
            }
            Points.Misc.PanelClose.Click(72)
            Sleep(150)
            i++
        }
        Out.V("Attempted to open " CardQualityToStr(quality) " type card")
    } Else {
        Out.V("Could not open " CardQualityToStr(quality) " type card")
    }
    ResetModifierKeys()
    ; Deliberate second check to return new state
    Return button.IsButtonActive()
}

; Seperate buyer to have faster turnover
CardBuyerRel(quality, offset, amount) {
    offset := Window.RelH(offset)
    Switch quality {
    Case 1:
        button := Points.Card.BuyCommon
    Case 2:
        button := Points.Card.BuyRare
    Case 3:
        button := Points.Card.BuyLegend
    default:
        button := Points.Card.BuyCommon
    }
    ; Check if button is active, if not we can skip
    If (CardsGreedyBuy) {
        ResetModifierKeys()
        button.GreedyModifierClick(CardsSleepBuyAmount, CardsSleepBuyAmount,
            amount)
        Out.D("Greedy buy " CardQualityToStr(quality) " quality card")
        Return false
    } Else {
        AmountToModifier(amount)
        Sleep(CardsSleepBuyAmount)
        If (!button.IsButtonInactive() && Window.IsActive()) {
            button.ClickOffset(, offset, CardsSleepBuyAmount)
            ; Legendary pack open
            Sleep(CardsSleepBuyAmount)
            Out.V("Attempting buy " CardQualityToStr(quality) " quality card")
            Return true
        } Else {
            Out.V("Could not buy " CardQualityToStr(quality) " quality card")
            Return false
        }
    }
    ResetModifierKeys()
}

CardButtonsActive() {
    ; Common
    If (!CardsGreedyOpen) {
        AmountToModifier(CardsCommonAmount)
    } Else {
        ResetModifierKeys()
    }
    Sleep(72)
    If (Points.Card.OpenCommon.IsButtonActive()) {
        Return true
    }

    ; Rare
    If (!CardsGreedyOpen) {
        AmountToModifier(CardsRareAmount)
    } Else {
        ResetModifierKeys()
    }
    Sleep(72)
    If (Points.Card.OpenRare.IsButtonActive()) {
        Return true
    }

    ; Legendary
    If (!CardsGreedyOpen) {
        AmountToModifier(CardsLegendaryAmount)
    } Else {
        ResetModifierKeys()
    }
    Sleep(72)
    If (Points.Card.OpenLegend.IsButtonActive()) {
        Return true
    }
    If (CardsBuyEnabled) {
        ; Common
        If (!CardsGreedyBuy) {
            AmountToModifier(CardsCommonBuyAmount)
        } Else {
            ResetModifierKeys()
        }
        Sleep(72)
        If (Points.Card.BuyCommon.IsButtonActive()) {
            Return true
        }

        ; Rare
        If (!CardsGreedyBuy) {
            AmountToModifier(CardsRareBuyAmount)
        } Else {
            ResetModifierKeys()
        }
        Sleep(72)
        If (Points.Card.BuyRare.IsButtonActive()) {
            Return true
        }

        ; Legendary
        If (!CardsGreedyBuy) {
            AmountToModifier(CardsLegBuyAmount)
        } Else {
            ResetModifierKeys()
        }
        Sleep(72)
        If (Points.Card.BuyLegend.IsButtonActive()) {
            Return true
        }
    }
    Return false
}

CardQualityToStr(var) {
    Switch var {
    Case 1:
        Return "common"
    Case 2:
        Return "rare"
    Case 3:
        Return "legendry"
    default:
        Return "common"
    }
}
