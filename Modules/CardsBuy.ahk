#Requires AutoHotkey v2.0

S.AddSetting("CardsBuy", "CardsBuyEnabled", true, "bool")
S.AddSetting("CardsBuy", "CardsBuyStyle", "FocusLegend", "text")
S.AddSetting("CardsBuy", "CardsCommonBuyAmount", 25000, "int")
S.AddSetting("CardsBuy", "CardsRareBuyAmount", 25000, "int")
S.AddSetting("CardsBuy", "CardsLegBuyAmount", 25000, "int")
S.AddSetting("CardsBuy", "CardsDontBuyCommons", false, "bool")
S.AddSetting("CardsBuy", "CardsDontBuyRare", false, "bool")
S.AddSetting("CardsBuy", "CardsDontBuyLeg", false, "bool")
S.AddSetting("CardsBuy", "CardsSleepBuyAmount", 17, "int")

CardBuySinglePass() {
    Global HadToHideNotifs
    ; Check if lost focus, close or crash and break if so
    If (!Window.IsActive()) {
        Return
    }

    If (!Window.IsPanel()) {
        Out.I("Card buying: Did not find panel. Aborted.")
        Return
    }

    If (IsNotificationActive()) {
        Out.I("Card buying: Found notification covering button and hid"
            " notifications.")
        Points.Misc.NotifArrow.Click(101)
        HadToHideNotifs := true
        Shops.OpenCards()
        Sleep(101)
    }
    Switch S.Get("CardsBuyStyle") {
    Case "FocusLegend":
        state := CardBuyPattern([
            3,
            2,
            1
        ], true)
    Case "FocusRare":
        state := CardBuyPattern([
            2,
            1,
            3
        ], true)
    Case "FocusRare2":
        state := CardBuyPattern([
            2,
            3,
            1
        ], true)
    Case "FocusCommon":
        state := CardBuyPattern([
            1,
            2,
            3
        ], true)
    Case "RoundRobin":
        state := CardBuyPattern([
            3,
            2,
            1
        ], false)
    Case "RoundRobin2":
        state := CardBuyPattern([
            1,
            2,
            3
        ], false)
    default:
        state := CardBuyPattern([
            3,
            2,
            1
        ], false)
    }
    Sleep(S.Get("CardsSleepBuyAmount"))
}

CardBuyLoop() {
    Global HadToHideNotifs
    Loop {
        ; Check if lost focus, close or crash and break if so
        If (!Window.IsActive()) {
            Break
        }
        If (!Window.IsPanel()) {
            Out.I("Card buying: Did not find panel. Aborted.")
            Return
        }

        If (IsNotificationActive()) {
            Out.I("Card buying: Found notification covering button and hid"
                " notifications.")
            Points.Misc.NotifArrow.Click(101)
            HadToHideNotifs := true
            Shops.OpenCards()
            Sleep(101)
        }

        Switch S.Get("CardsBuyStyle") {
        Case "FocusLegend":
            state := CardBuyPattern([
                3,
                2,
                1
            ], true)
        Case "FocusRare":
            state := CardBuyPattern([
                2,
                1,
                3
            ], true)
        Case "FocusRare2":
            state := CardBuyPattern([
                2,
                3,
                1
            ], true)
        Case "FocusCommon":
            state := CardBuyPattern([
                1,
                2,
                3
            ], true)
        Case "RoundRobin":
            state := CardBuyPattern([
                3,
                2,
                1
            ], false)
        Case "RoundRobin2":
            state := CardBuyPattern([
                1,
                2,
                3
            ], false)
        default:
            state := CardBuyPattern([
                3,
                2,
                1
            ], false)
        }
        If (!state) {
            Break
        }
        Sleep(S.Get("CardsSleepBuyAmount"))
    }
    Sleep(72)
}

CardBuyPattern(pattern, buyAll) {
    cardBuyOffset := 2
    CardsDontBuyCommons := S.Get("CardsDontBuyCommons")
    CardsCommonBuyAmount := S.Get("CardsCommonBuyAmount")
    CardsDontBuyRare := S.Get("CardsDontBuyRare")
    CardsRareBuyAmount := S.Get("CardsRareBuyAmount")
    CardsDontBuyLeg := S.Get("CardsDontBuyLeg")
    CardsLegBuyAmount := S.Get("CardsLegBuyAmount")
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
