#Requires AutoHotkey v2.0

global cardBuyOffset := 5
global cardBuyCommonButtonX := 455
global cardBuyCommonButtonY := 934

global cardBuyRareButtonX := 1015
global cardBuyRareButtonY := 934

global cardBuyLegButtonX := 1575
global cardBuyLegButtonY := 934

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
        fSlowClick(32, 596, 101)
        HadToHideNotifs := true
        OpenCards()
        Sleep(101)
    }
    switch CardsBuyStyle {
        case "FocusLegend":
            state := CardBuyLegFirst()
        case "FocusRare":
            state := CardBuyRareFirst()
        case "FocusRare2":
            state := CardBuyRare2First()
        case "FocusCommon":
            state := CardBuyCommonFirst()
        case "RoundRobin":
            state := CardBuyRoundRobin()
        case "RoundRobin2":
            state := CardBuyRoundRobin2()
        default:
            state := CardBuyRoundRobin()
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
            fSlowClick(32, 596, 101)
            HadToHideNotifs := true
            OpenCards()
            Sleep(101)
        }
        switch CardsBuyStyle {
            case "FocusLegend":
                if (Debug) Log("FocusLegend Mode")
                    state := CardBuyLegFirst()
            case "FocusRare":
                if (Debug) Log("FocusRare Mode")
                    state := CardBuyRareFirst()
            case "FocusRare2":
                if (Debug) Log("FocusRare2 Mode")
                    state := CardBuyRare2First()
            case "FocusCommon":
                if (Debug) Log("FocusCommon Mode")
                    state := CardBuyCommonFirst()
            case "RoundRobin":
                if (Debug) Log("RoundRobin Mode")
                    state := CardBuyRoundRobin()
            case "RoundRobin2":
                if (Debug) Log("RoundRobin2 Mode")
                    state := CardBuyRoundRobin2()
            default:
                if (Debug) Log("Default Mode")
                    state := CardBuyRoundRobin()
        }
        if (!state) {
            break
        }
        Sleep(CardsSleepBuyAmount)
    }
    Sleep(72)
}

CardBuyRoundRobin() {
    ; Return false if nothing left to buy
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg) {
        LegButtonActive := CardBuyerRel(cardBuyLegButtonX, cardBuyLegButtonY,
            cardBuyOffset, CardsLegBuyAmount)
    } else {
        ; If disabled mark inactive
        LegButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare) {
        RareButtonActive := CardBuyerRel(cardBuyRareButtonX, cardBuyRareButtonY,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons) {
        CommonButtonActive := CardBuyerRel(cardBuyCommonButtonX, cardBuyCommonButtonY,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }

    If (!CommonButtonActive && !RareButtonActive &&
        !LegButtonActive) {
            return false
    }
    return true
}

CardBuyRoundRobin2() {
    ; Return false if nothing left to buy
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons) {
        CommonButtonActive := CardBuyerRel(cardBuyCommonButtonX, cardBuyCommonButtonY,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare) {
        RareButtonActive := CardBuyerRel(cardBuyRareButtonX, cardBuyRareButtonY,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg) {
        LegButtonActive := CardBuyerRel(cardBuyLegButtonX, cardBuyLegButtonY,
            cardBuyOffset, CardsLegBuyAmount)
    } else {
        ; If disabled mark inactive
        LegButtonActive := false
    }
    If (!CommonButtonActive && !RareButtonActive &&
        !LegButtonActive) {
            return false
    }
    return true
}

CardBuyLegFirst() {
    ; Return false if nothing left to buy
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg) {
        LegButtonActive := CardBuyerRel(cardBuyLegButtonX, cardBuyLegButtonY,
            cardBuyOffset, CardsLegBuyAmount)
    } else {
        ; If disabled mark inactive
        if (Debug) {
            Log("Leg Disabled ")
            if (CardsDontBuyLeg == "true") {
                Log("Is string")
            }
        }
        LegButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare && !LegButtonActive) {
        RareButtonActive := CardBuyerRel(cardBuyRareButtonX, cardBuyRareButtonY,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        if (Debug) {
            Log("Rare Disabled")
        }
        RareButtonActive := false
    }
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons && !LegButtonActive && !RareButtonActive) {
        CommonButtonActive := CardBuyerRel(cardBuyCommonButtonX, cardBuyCommonButtonY,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        if (Debug) {
            Log("Commons Disabled")
        }
        CommonButtonActive := false
    }

    If (!CommonButtonActive && !RareButtonActive &&
        !LegButtonActive) {
            if (Debug) {
                Log("All inactive")
            }
            return false
    }
    return true
}

CardBuyRareFirst() {
    ; Return false if nothing left to buy
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare) {
        RareButtonActive := CardBuyerRel(cardBuyRareButtonX, cardBuyRareButtonY,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons && !RareButtonActive) {
        CommonButtonActive := CardBuyerRel(cardBuyCommonButtonX, cardBuyCommonButtonY,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg && !RareButtonActive && !CommonButtonActive) {
        LegButtonActive := CardBuyerRel(cardBuyLegButtonX, cardBuyLegButtonY,
            cardBuyOffset, CardsLegBuyAmount)
    } else {
        ; If disabled mark inactive
        LegButtonActive := false
    }

    If (!CommonButtonActive && !RareButtonActive &&
        !LegButtonActive) {
            return false
    }
    return true
}

CardBuyRare2First() {
    ; Return false if nothing left to buy
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare) {
        RareButtonActive := CardBuyerRel(cardBuyRareButtonX, cardBuyRareButtonY,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg && !RareButtonActive) {
        LegButtonActive := CardBuyerRel(cardBuyLegButtonX, cardBuyLegButtonY,
            cardBuyOffset, CardsLegBuyAmount)
    } else {
        ; If disabled mark inactive
        LegButtonActive := false
    }
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons && !RareButtonActive && !LegButtonActive) {
        CommonButtonActive := CardBuyerRel(cardBuyCommonButtonX, cardBuyCommonButtonY,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }

    If (!CommonButtonActive && !RareButtonActive &&
        !LegButtonActive) {
            return false
    }
    return true
}

CardBuyCommonFirst() {
    ; Return false if nothing left to buy
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons) {
        CommonButtonActive := CardBuyerRel(cardBuyCommonButtonX, cardBuyCommonButtonY,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare && !CommonButtonActive) {
        RareButtonActive := CardBuyerRel(cardBuyRareButtonX, cardBuyRareButtonY,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg && !CommonButtonActive && !RareButtonActive) {
        LegButtonActive := CardBuyerRel(cardBuyLegButtonX, cardBuyLegButtonY,
            cardBuyOffset, CardsLegBuyAmount)
    } else {
        ; If disabled mark inactive
        LegButtonActive := false
    }

    If (!CommonButtonActive && !RareButtonActive &&
        !LegButtonActive) {
            return false
    }
    return true
}