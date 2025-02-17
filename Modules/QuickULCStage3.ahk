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
    If (LegBtn.IsButtonActive()) {
        LegBtn.MouseMove()
        Sleep(50)
        MouseMove(1, 1, 5, "R")
        Sleep(50)
        LegBtn.ClickOffsetWhileColour(LegBtn.GetColour())
        Sleep(50)
    }
    If (ComBtn.IsButtonActive()) {
        ComBtn.MouseMove()
        Sleep(50)
        MouseMove(1, 1, 5, "R")
        Sleep(50)
        ComBtn.ClickOffsetWhileColour(ComBtn.GetColour())
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
    /** @type {cPoint} */
    SelectedIcon := cPoint(1788, 540)

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
    For (rid, rvalue IN Rows) {
        For (cid, cvalue IN Columns) {
            /** @type cPoint */
            btn := cPoint(cvalue, rvalue)
            If (!btn.IsBackground()) {
                btn.ClickOffset()
                Sleep(50)
                AmountToModifier(25000)
                Sleep(50)
                If (IsItemCraftable()) {
                    CraftBtn.Click()
                    Sleep(50)
                    ResetModifierKeys()
                    Sleep(50)
                }
            }
        }
    }
    ResetModifierKeys()
    IsItemCraftable() {
        ; Weirdly colour and point match for candy and random item
        If (CraftBtn.IsButtonActive() && SelectedIcon.GetColour() != "0xAB5A53") {
            Return true
        } Else {
            Return false
        }
    }
    IsItemBlocked(r, c) {

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
    LegBtn := Points.Borbventures.PacksBuyLegendary

    Shops.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.PacksTab.Click()
    Sleep(100)
    AmountToModifier(25000)
    Sleep(50)
    If (ComBtn.IsButtonActive()) {
        ComBtn.MouseMove()
        Sleep(50)
        MouseMove(1, 1, 5, "R")
        Sleep(50)
        ComBtn.ClickOffsetWhileColour(ComBtn.GetColour())
        Sleep(50)
        ComBtn.GreedyModifierClick()
    }
    /*
    If (LegBtn.IsButtonActive()) {
        LegBtn.MouseMove()
        Sleep(20)
        MouseMove(1, 1, 5, "R")
        Sleep(50)
        LegBtn.ClickOffsetWhileColour(LegBtn.GetColour())
        Sleep(50)
        ;LegBtn.GreedyModifierClick()
    } */
    ResetModifierKeys()
}
;@endregion
