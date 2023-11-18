#Requires AutoHotkey v2.0

global cardBuyOffset := 5

CardBuySinglePass() {
    global HadToHideNotifs, W, H, X, Y
    ; Check if lost focus, close or crash and break if so
    if (!IsWindowActive()) {
        return
    }
    WinGetClientPos(&X, &Y, &W, &H, "Leaf Blower Revolution")
    ; Update window size

    CommonX := WinRelPosLargeW(470)
    CommonY := WinRelPosLargeH(950)
    if (!IsPanelTransparent() && IsCoveredByNotification(CommonX, CommonY)) {
        fSlowClick(32, 596, 34)
        HadToHideNotifs := true
        ; Notifications were blocking, close notifications and reshow
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

CardBuyLoop(SpamViolins := false) {
    global HadToHideNotifs, W, H, X, Y
    loop {
        ; Check if lost focus, close or crash and break if so
        if (!IsWindowActive()) {
            break
        }
        WinGetClientPos(&X, &Y, &W, &H, "Leaf Blower Revolution")
        ; Update window size

        if (SpamViolins && IsBossTimerActive()) {
            TriggerViolin()
        }
        CommonX := WinRelPosLargeW(465)
        CommonY := WinRelPosLargeH(950)
        if (!IsPanelTransparent() && IsCoveredByNotification(CommonX, CommonY)) {
            fSlowClick(32, 596, 34)
            HadToHideNotifs := true
            ; Notifications were blocking, close notifications and reshow
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
        LegButtonActive := CardBuyerRel(1711, 950,
            cardBuyOffset, CardsLegBuyAmount)
    } else {
        ; If disabled mark inactive
        LegButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare) {
        RareButtonActive := CardBuyerRel(1155, 950,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons) {
        CommonButtonActive := CardBuyerRel(590, 950,
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
        CommonButtonActive := CardBuyerRel(590, 950,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare) {
        RareButtonActive := CardBuyerRel(1155, 950,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg) {
        LegButtonActive := CardBuyerRel(1711, 950,
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
        LegButtonActive := CardBuyerRel(1711, 950,
            cardBuyOffset, CardsLegBuyAmount)
    } else {
        ; If disabled mark inactive
        LegButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare && !LegButtonActive) {
        RareButtonActive := CardBuyerRel(1155, 950,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons && !LegButtonActive && !RareButtonActive) {
        CommonButtonActive := CardBuyerRel(590, 950,
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

CardBuyRareFirst() {
    ; Return false if nothing left to buy
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare) {
        RareButtonActive := CardBuyerRel(1155, 950,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons && !RareButtonActive) {
        CommonButtonActive := CardBuyerRel(590, 950,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg && !RareButtonActive && !CommonButtonActive) {
        LegButtonActive := CardBuyerRel(1711, 950,
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
        RareButtonActive := CardBuyerRel(1155, 950,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg && !RareButtonActive) {
        LegButtonActive := CardBuyerRel(1711, 950,
            cardBuyOffset, CardsLegBuyAmount)
    } else {
        ; If disabled mark inactive
        LegButtonActive := false
    }
    ; Common
    ; If disabled skip, get active state back
    if (!CardsDontBuyCommons && !RareButtonActive && !LegButtonActive) {
        CommonButtonActive := CardBuyerRel(590, 950,
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
        CommonButtonActive := CardBuyerRel(590, 950,
            cardBuyOffset, CardsCommonBuyAmount)
    } else {
        ; If disabled mark inactive
        CommonButtonActive := false
    }
    ; Rare
    ; If disabled skip, get active state back
    if (!CardsDontBuyRare && !CommonButtonActive) {
        RareButtonActive := CardBuyerRel(1155, 950,
            cardBuyOffset, CardsRareBuyAmount)
    } else {
        ; If disabled mark inactive
        RareButtonActive := false
    }
    ; Legendary
    ; If disabled skip, get active state back
    if (!CardsDontBuyLeg && !CommonButtonActive && !RareButtonActive) {
        LegButtonActive := CardBuyerRel(1711, 950,
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