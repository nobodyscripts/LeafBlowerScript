#Requires AutoHotkey v2.0

Global CardsBuyStyle := "FocusLegend"

Global cardBuyOffset := 5

Global CardsDontBuyCommons := true
Global CardsDontBuyRare := true
Global CardsDontBuyLeg := true

CardBuySinglePass() {
    Global HadToHideNotifs, W, H, X, Y
    ; Check if lost focus, close or crash and break if so
    If (!IsWindowActive()) {
        Return
    }
    WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
    ; Update window size

    If (!IsPanelActive()) {
        Log("Card buying: Did not find panel. Aborted.")
        Return
    }

    If (IsNotificationActive()) {
        Log("Card buying: Found notification covering button and hid"
            " notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := true
        Travel.OpenCards()
        Sleep(101)
    }
    Switch CardsBuyStyle {
        Case "FocusLegend":
            state := CardBuyPattern([3, 2, 1], true)
        Case "FocusRare":
            state := CardBuyPattern([2, 1, 3], true)
        Case "FocusRare2":
            state := CardBuyPattern([2, 3, 1], true)
        Case "FocusCommon":
            state := CardBuyPattern([1, 2, 3], true)
        Case "RoundRobin":
            state := CardBuyPattern([3, 2, 1], false)
        Case "RoundRobin2":
            state := CardBuyPattern([1, 2, 3], false)
        default:
            state := CardBuyPattern([3, 2, 1], false)
    }
    Sleep(CardsSleepBuyAmount)
}

CardBuyLoop() {
    Global HadToHideNotifs, W, H, X, Y, Debug
    Loop {
        ; Check if lost focus, close or crash and break if so
        If (!IsWindowActive()) {
            Break
        }
        WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
        ; Update window size
        If (!IsPanelActive()) {
            Log("Card buying: Did not find panel. Aborted.")
            Return
        }

        If (IsNotificationActive()) {
            Log("Card buying: Found notification covering button and hid"
                " notifications.")
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := true
            Travel.OpenCards()
            Sleep(101)
        }

        Switch CardsBuyStyle {
            Case "FocusLegend":
                state := CardBuyPattern([3, 2, 1], true)
            Case "FocusRare":
                state := CardBuyPattern([2, 1, 3], true)
            Case "FocusRare2":
                state := CardBuyPattern([2, 3, 1], true)
            Case "FocusCommon":
                state := CardBuyPattern([1, 2, 3], true)
            Case "RoundRobin":
                state := CardBuyPattern([3, 2, 1], false)
            Case "RoundRobin2":
                state := CardBuyPattern([1, 2, 3], false)
            default:
                state := CardBuyPattern([3, 2, 1], false)
        }
        If (!state) {
            Break
        }
        Sleep(CardsSleepBuyAmount)
    }
    Sleep(72)
}

CardBuyPattern(pattern, buyAll) {
    CommonButtonActive := RareButtonActive := LegButtonActive := false
    If (buyAll) {
        For quality in pattern {
            ; Common
            If (quality = 1 && !CardsDontBuyCommons) {
                While (Points.Card.BuyCommon.IsButtonActive()) {
                    CommonButtonActive := CardBuyerRel(1, cardBuyOffset,
                        CardsCommonBuyAmount)
                }
                CommonButtonActive := false
            }

            ; Rare
            If (quality = 2 && !CardsDontBuyRare) {
                While (Points.Card.BuyRare.IsButtonActive()) {
                    RareButtonActive := CardBuyerRel(2, cardBuyOffset,
                        CardsRareBuyAmount)
                }
                RareButtonActive := false
            }

            ; Legendary
            If (quality = 3 && !CardsDontBuyLeg) {
                While (Points.Card.BuyLegend.IsButtonActive()) {
                    LegButtonActive := CardBuyerRel(3, cardBuyOffset,
                        CardsLegBuyAmount)
                }
                LegButtonActive := false
            }
        }
    } Else {
        For quality in pattern {
            Switch quality {
                Case 1:
                    ; Common
                    If (!CardsDontBuyCommons) {
                        CommonButtonActive := CardBuyerRel(1, cardBuyOffset,
                            CardsCommonBuyAmount)
                    } Else {
                        ; If disabled mark inactive
                        CommonButtonActive := false
                    }
                Case 2:
                    ; Rare
                    If (!CardsDontBuyRare) {
                        RareButtonActive := CardBuyerRel(2, cardBuyOffset,
                            CardsRareBuyAmount)
                    } Else {
                        ; If disabled mark inactive
                        RareButtonActive := false
                    }
                Case 3:
                    ; Legendary
                    If (!CardsDontBuyLeg) {
                        LegButtonActive := CardBuyerRel(3, cardBuyOffset,
                            CardsLegBuyAmount)
                    } Else {
                        ; If disabled mark inactive
                        LegButtonActive := false
                    }
                default:
                    ; Common
                    If (!CardsDontBuyCommons) {
                        CommonButtonActive := CardBuyerRel(1, cardBuyOffset,
                            CardsCommonBuyAmount)
                    } Else {
                        ; If disabled mark inactive
                        CommonButtonActive := false
                    }
            }
        }
    }
    ; Return false if nothing left to buy
    If (!CommonButtonActive && !RareButtonActive && !LegButtonActive) {
        Return false
    }
    Return true
}