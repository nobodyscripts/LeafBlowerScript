#Requires AutoHotkey v2.0

global CardsBuyStyle := "FocusLegend"

global cardBuyOffset := 5
global cardBuyCommonButtonX := 456
global cardBuyCommonButtonY := 935

global cardBuyRareButtonX := 1016
global cardBuyRareButtonY := 935

global cardBuyLegButtonX := 1576
global cardBuyLegButtonY := 935

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
        cPoint(64, 1228).Click(101)
        HadToHideNotifs := true
        Travel.OpenCards()
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
            cPoint(64, 1228).Click(101)
            HadToHideNotifs := true
            Travel.OpenCards()
            Sleep(101)
        }
        switch CardsBuyStyle {
            case "FocusLegend":
                DebugLog("FocusLegend Mode")
                state := CardBuyLegFirst()
            case "FocusRare":
                DebugLog("FocusRare Mode")
                state := CardBuyRareFirst()
            case "FocusRare2":
                DebugLog("FocusRare2 Mode")
                state := CardBuyRare2First()
            case "FocusCommon":
                DebugLog("FocusCommon Mode")
                state := CardBuyCommonFirst()
            case "RoundRobin":
                DebugLog("RoundRobin Mode")
                state := CardBuyRoundRobin()
            case "RoundRobin2":
                DebugLog("RoundRobin2 Mode")
                state := CardBuyRoundRobin2()
            default:
                DebugLog("Default Mode")
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
        DebugLog("Leg Disabled")
        LegButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare && !LegButtonActive) {
        RareButtonActive := CardBuyerRel(cardBuyRareButtonX, cardBuyRareButtonY,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        DebugLog("Rare Disabled")
        RareButtonActive := false
    }
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons && !LegButtonActive && !RareButtonActive) {
        CommonButtonActive := CardBuyerRel(cardBuyCommonButtonX, cardBuyCommonButtonY,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        DebugLog("Commons Disabled")
        CommonButtonActive := false
    }

    If (!CommonButtonActive && !RareButtonActive &&
        !LegButtonActive) {
        DebugLog("All inactive")
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