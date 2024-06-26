#Requires AutoHotkey v2.0

global CardsBuyStyle := "FocusLegend"

global cardBuyOffset := 5

global CardsDontBuyCommons := true
global CardsDontBuyRare := true
global CardsDontBuyLeg := true

CardBuySinglePass() {
    global HadToHideNotifs, W, H, X, Y
    ; Check if lost focus, close or crash and break if so
    if (!IsWindowActive()) {
        return
    }
    WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
    ; Update window size

    if (!IsPanelActive()) {
        Log("Card buying: Did not find panel. Aborted.")
        return
    }

    if (IsNotificationActive()) {
        Log("Card buying: Found notification covering button and hid"
            " notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := true
        Travel.OpenCards()
        Sleep(101)
    }
    switch CardsBuyStyle {
        case "FocusLegend":
            state := CardBuyPattern([3, 2, 1], true)
        case "FocusRare":
            state := CardBuyPattern([2, 1, 3], true)
        case "FocusRare2":
            state := CardBuyPattern([2, 3, 1], true)
        case "FocusCommon":
            state := CardBuyPattern([1, 2, 3], true)
        case "RoundRobin":
            state := CardBuyPattern([3, 2, 1], false)
        case "RoundRobin2":
            state := CardBuyPattern([1, 2, 3], false)
        default:
            state := CardBuyPattern([3, 2, 1], false)
    }
    Sleep(CardsSleepBuyAmount)
}

CardBuyLoop() {
    global HadToHideNotifs, W, H, X, Y, Debug
    loop {
        ; Check if lost focus, close or crash and break if so
        if (!IsWindowActive()) {
            break
        }
        WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
        ; Update window size
        if (!IsPanelActive()) {
            Log("Card buying: Did not find panel. Aborted.")
            return
        }

        if (IsNotificationActive()) {
            Log("Card buying: Found notification covering button and hid"
                " notifications.")
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := true
            Travel.OpenCards()
            Sleep(101)
        }

        switch CardsBuyStyle {
            case "FocusLegend":
                state := CardBuyPattern([3, 2, 1], true)
            case "FocusRare":
                state := CardBuyPattern([2, 1, 3], true)
            case "FocusRare2":
                state := CardBuyPattern([2, 3, 1], true)
            case "FocusCommon":
                state := CardBuyPattern([1, 2, 3], true)
            case "RoundRobin":
                state := CardBuyPattern([3, 2, 1], false)
            case "RoundRobin2":
                state := CardBuyPattern([1, 2, 3], false)
            default:
                state := CardBuyPattern([3, 2, 1], false)
        }
        if (!state) {
            break
        }
        Sleep(CardsSleepBuyAmount)
    }
    Sleep(72)
}

CardBuyPattern(pattern, buyAll) {
    CommonButtonActive := RareButtonActive := LegButtonActive := false
    if (buyAll) {
        for quality in pattern {
            ; Common
            if (quality = 1 && !CardsDontBuyCommons) {
                while (Points.Card.BuyCommon.IsButtonActive()) {
                    CommonButtonActive := CardBuyerRel(1, cardBuyOffset,
                        CardsCommonBuyAmount)
                }
                CommonButtonActive := false
            }

            ; Rare
            if (quality = 2 && !CardsDontBuyRare) {
                while (Points.Card.BuyRare.IsButtonActive()) {
                    RareButtonActive := CardBuyerRel(2, cardBuyOffset, CardsRareBuyAmount)
                }
                RareButtonActive := false
            }

            ; Legendary
            if (quality = 3 && !CardsDontBuyLeg) {
                while (Points.Card.BuyLegend.IsButtonActive()) {
                    LegButtonActive := CardBuyerRel(3, cardBuyOffset, CardsLegBuyAmount)
                }
                LegButtonActive := false
            }
        }
    } else {
        for quality in pattern {
            switch quality {
                case 1:
                    ; Common
                    if (!CardsDontBuyCommons) {
                        CommonButtonActive := CardBuyerRel(1, cardBuyOffset,
                            CardsCommonBuyAmount)
                    } else {
                        ; If disabled mark inactive
                        CommonButtonActive := false
                    }
                case 2:
                    ; Rare
                    if (!CardsDontBuyRare) {
                        RareButtonActive := CardBuyerRel(2, cardBuyOffset, CardsRareBuyAmount)
                    } else {
                        ; If disabled mark inactive
                        RareButtonActive := false
                    }
                case 3:
                    ; Legendary
                    if (!CardsDontBuyLeg) {
                        LegButtonActive := CardBuyerRel(3, cardBuyOffset, CardsLegBuyAmount)
                    } else {
                        ; If disabled mark inactive
                        LegButtonActive := false
                    }
                default:
                    ; Common
                    if (!CardsDontBuyCommons) {
                        CommonButtonActive := CardBuyerRel(1, cardBuyOffset,
                            CardsCommonBuyAmount)
                    } else {
                        ; If disabled mark inactive
                        CommonButtonActive := false
                    }
            }
        }
    }
    ; Return false if nothing left to buy
    If (!CommonButtonActive && !RareButtonActive &&
        !LegButtonActive) {
        return false
    }
    return true
}