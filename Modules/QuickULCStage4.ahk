#Requires AutoHotkey v2.0

;@region BuyMaxCardPacks()
/**
 * Maximises all card packs prefering legendary so the card parts can be stored
 * for ulc reset
 */
BuyMaxCardPacks(*) {
    UlcWindow()
    LegBtn := Points.Card.BuyLegend
    ComBtn := Points.Card.BuyCommon
    Shops.Cards.GoToPacks()
    Sleep(100)
    AmountToModifier(25000)
    Sleep(50)
    ; Need to move the mouse over first for whilecolour
    If (LegBtn.IsButtonActive()) {
        LegBtn.ClickOffset()
    } ; Need to recheck otherwise we could click inactive
    If (LegBtn.IsButtonActive()) {
        LegBtn.ClickOffsetWhileColour(LegBtn.GetColour(), 100)
        Sleep(50)
    }
    If (ComBtn.IsButtonActive()) {
        ComBtn.ClickOffset()
    }
    If (ComBtn.IsButtonActive()) {
        ComBtn.ClickOffsetWhileColour(ComBtn.GetColour(), 100)
        Sleep(50)
    }
    If (LegBtn.IsButtonActive() || ComBtn.IsButtonActive()) {
        LegBtn.GreedyModifierClick()
        ComBtn.GreedyModifierClick()
    }
    ResetModifierKeys()
}
;@endregion

;@region StoreMineCurrency()
/**
 * Maximises all card packs prefering legendary so the card parts can be stored
 * for ulc reset
 */
StoreMineCurrency(*) {
    Shops.Mine.GoToTabTrans()
    Sleep(150)
    Points.Mine.Transmute.AllCBarsToCDias.Click()
    Sleep(50)
    Points.Mine.Transmute.AllSDiasToCDia.Click()
    Sleep(50)

    Points.Mine.Transmute.AllCDiasToSpheres.Click()
    ; or
    ; Points.Mine.Transmute.AllCDiasToFuel.Click()

    Sleep(50)
}
;@endregion

;@region MaxBVItems(*)
/**
 * MaxBVItems Go through each bv item in inventory and try to max it
 */
MaxBVItems(*) {
    /** @type {cPoint} */
    CraftBtn := cPoint(1570, 644)
    /** @type {cPoint} */
    AscendBtn := cPoint(1855, 646)
    /** @type {cPoint} */
    ScrapBtn := cPoint(2136, 646)

    Columns := [
        391,
        463,
        530,
        596,
        665,
        736,
        799,
        868,
        935,
        1010,
        1074,
        1140,
        1206,
        1281,
        1344
    ]
    Rows := [
        502,
        623,
        749,
        877,
        1001
    ]
    UlcWindow()
    Shops.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    AmountToModifier(25000)
    Sleep(70)
    For (rid, rvalue IN Rows) {
        For (cid, cvalue IN Columns) {
            /** @type cPoint */
            btn := cPoint(cvalue, rvalue)
            If (!btn.IsBackground()) {
                btn.ClickOffset()
                Sleep(150)
                If (IsItemCraftable(rid, cid)) {
                    CraftBtn.Click()
                    Sleep(50)
                }
            }
        }
    }
    ResetModifierKeys()
    Sleep(70)

    IsItemCraftable(rid, cid) {
        ; Ignore candy, random box and cape
        /** @type {cPoint} */
        SelectedIconCandy := cPoint(1788, 520) ; 0xFFE976
        /** @type {cPoint} */
        SelectedIconBox := cPoint(1777, 532) ; 0xAB5A53
        If (CraftBtn.IsButtonActive() && !SelectedIconCandy.IsColour("0xFFE976") &&
        !SelectedIconBox.IsColour("0xAB5A53") &&
        !SelectedIconCandy.IsColour("0x6CD820") &&
        !SelectedIconBox.IsColour("0x14B046")) {
            Return true
        } Else {
            ; Out.D("r " rid " c " cid " ignored")
            Return false
        }
    }
}
;@endregion

;@region MaxBVItemsJustSocks(*)
/**
 * MaxBVItemsJustSocks Go through each bv item in inventory and try to 
 * max it if sock
 */
MaxBVItemsJustSocks(*) {
    /** @type {cPoint} */
    CraftBtn := cPoint(1570, 644)
    /** @type {cPoint} */
    AscendBtn := cPoint(1855, 646)
    /** @type {cPoint} */
    ScrapBtn := cPoint(2136, 646)

    Columns := [
        391,
        463,
        530,
        596,
        665,
        736,
        799,
        868,
        935,
        1010,
        1074,
        1140,
        1206,
        1281,
        1344
    ]
    Rows := [
        502,
        623,
        749,
        877,
        1001
    ]
    UlcWindow()
    Shops.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    AmountToModifier(25000)
    Sleep(70)
    For (rid, rvalue IN Rows) {
        For (cid, cvalue IN Columns) {
            /** @type {cPoint} */
            btn := cPoint(cvalue, rvalue)
            If (!btn.IsBackground()) {
                btn.ClickOffset(, , 50)
                Sleep(150)
                If (IsItemCraftable(rid, cid)) {
                    CraftBtn.Click(50)
                    Sleep(50)
                }
            }
        }
    }
    ResetModifierKeys()
    Sleep(70)

    IsItemCraftable(rid, cid) {
        ; Only socks
        /** @type {cPoint} */
        SelectedIconCandy := cPoint(1788, 520) ; 0xFFE976
        /** @type {cPoint} */
        SelectedIconBox := cPoint(1777, 532) ; 0xAB5A53
        /*
        Socks:
        Icon Candy: 0x6E8390
        Icon Box: 0xAEC3BE
        
        Ring:
        Icon Candy: 0x14B046
        Icon Box: 0x97714A
        */
        If (CraftBtn.IsButtonActive() &&
        (
            SelectedIconCandy.IsColour("0x6E8390") &&
            SelectedIconBox.IsColour("0xAEC3BE")
        )) {
            Return true
        } Else {
            ; Out.D("r " rid " c " cid " ignored")
            Return false
        }
    }
}
;@endregion

;@region MaxBVItemsJustBags(*)
/**
 * MaxBVItemsSpecific Go through each bv item in inventory and try to 
 * max it if sock
 */
MaxBVItemsJustBags(*) {
    /** @type {cPoint} */
    CraftBtn := cPoint(1570, 644)
    /** @type {cPoint} */
    AscendBtn := cPoint(1855, 646)
    /** @type {cPoint} */
    ScrapBtn := cPoint(2136, 646)

    Columns := [
        391,
        463,
        530,
        596,
        665,
        736
    ]
    Rows := [
        502
    ]
    UlcWindow()
    Shops.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    AmountToModifier(25000)
    Sleep(70)
    Loop 10 {
        For (rid, rvalue IN Rows) {
            For (cid, cvalue IN Columns) {
                /** @type {cPoint} */
                btn := cPoint(cvalue, rvalue)
                If (!btn.IsBackground()) {
                    btn.ClickOffset(, , 50)
                    Sleep(150)
                    If (IsItemCraftable(rid, cid)) {
                        CraftBtn.Click(50)
                        Sleep(50)
                    }
                }
            }
        }
    }
    ResetModifierKeys()
    Sleep(70)

    IsItemCraftable(rid, cid) {
        ; Only filtering active stuff, filtered item type by slot
        If (CraftBtn.IsButtonActive()) {
            Return true
        } Else {
            ; Out.D("r " rid " c " cid " ignored")
            Return false
        }
    }
}
;@endregion

;@region BuyMaxBVPacks()
/**
 * Maximises amount of ulc gained from sacrificing borbventures by buying as
 * many card packs of any quality as possible (common as cheapest) using all 
 * borb tokens available.
 */
BuyMaxBVPacks(*) {
    UlcWindow()
    ComBtn := Points.Borbventures.PacksBuyCommon
    RareBtn := Points.Borbventures.PacksBuyRare
    LegBtn := Points.Borbventures.PacksBuyLegendary

    Shops.OpenBorbVentures()
    Points.Borbventures.PacksTab.Click(50)
    Sleep(100)
    AmountToModifier(25000)
    Sleep(50)
    ; Need to move the mouse over first for whilecolour
    If (ComBtn.IsButtonActive()) {
        ComBtn.ClickOffset()
    } ; Need to recheck otherwise we could click inactive
    If (ComBtn.IsButtonActive()) { 
        ComBtn.ClickOffsetWhileColour(ComBtn.GetColour(), 45, 5, 5)
        Sleep(50)
    }

    If (RareBtn.IsButtonActive()) {
        RareBtn.ClickOffset()
    }
    If (RareBtn.IsButtonActive()) {
        RareBtn.ClickOffsetWhileColour(RareBtn.GetColour(), 45, 5, 5)
        Sleep(50)
    }

    If (LegBtn.IsButtonActive()) {
        LegBtn.ClickOffset()
    }
    If (LegBtn.IsButtonActive()) {
        LegBtn.ClickOffsetWhileColour(LegBtn.GetColour(), 45, 5, 5)
        Sleep(50)
    }
    ResetModifierKeys()
}
;@endregion

;@region DisableDiceAutos()
/**
 * DisableDiceAutos
 */
DisableDiceAutos(*) {
    Out.D("DisableDiceAutos")
    UlcWindow()
    DiceShop := cPoint(253, 1150)
    Travel.ClosePanelIfActive()
    DiceShop.ClickOffset()
    Sleep(50)
    Points.Dice.Tab.Options.ClickButtonActive()
    Sleep(50)
    BasicAutoRoll := cPoint(370, 392).ClickButtonActive()
    Sleep(50)
    PowerAutoRoll := cPoint(369, 479).ClickButtonActive()
    Sleep(50)
}
;@endregion
