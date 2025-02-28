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
    Global BVInvArr

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
    i := 1
    If (BVInvArr.length > 1) {
        Out.D("MaxBVItems: Using scanned locations")
        For (rid, rvalue IN Rows) {
            For (cid, cvalue IN Columns) {
                If (i <= BVInvArr.Length) {
                    /** @type cPoint */
                    btn := cPoint(cvalue, rvalue)
                    item := StrLower(BVInvArr[i])
                    If (!btn.IsBackground() &&
                    item != "cape" && item != "candy" && item != "box") {
                        btn.ClickOffset()
                        Sleep(150)
                        If (IsItemCraftable()) {
                            CraftBtn.Click()
                            Sleep(50)
                        }
                    }
                    i++
                }
            }
        }
    } Else {
        Out.D("MaxBVItems: Using manual locations")
        For (rid, rvalue IN Rows) {
            For (cid, cvalue IN Columns) {
                /** @type cPoint */
                btn := cPoint(cvalue, rvalue)
                If (!btn.IsBackground()) {
                    btn.ClickOffset()
                    Sleep(150)
                    If (IsItemCraftable()) {
                        CraftBtn.Click()
                        Sleep(50)
                    }
                }
            }
        }
    }
    ResetModifierKeys()
    Sleep(70)

    IsItemCraftable() {
        ; Ignore candy, random box and cape
        If (CraftBtn.IsButtonActive() && !IsBVCandy() && !IsBVCape() && !IsBVRandomBox()) {
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
    i := 1
    If (BVInvArr.Length > 1) {
        For (rid, rvalue IN Rows) {
            For (cid, cvalue IN Columns) {
                If (i <= BVInvArr.Length) {
                    /** @type {cPoint} */
                    btn := cPoint(cvalue, rvalue)
                    item := StrLower(BVInvArr[i])
                    If (item = "sock" && !btn.IsBackground()) {
                        btn.ClickOffset(, , 50)
                        Sleep(150)
                        If (CraftBtn.IsButtonActive() && IsBVSock()) {
                            CraftBtn.Click(50)
                            Sleep(50)
                        }
                    }
                    i++
                }
            }
        }
    } Else {
        For (rid, rvalue IN Rows) {
            For (cid, cvalue IN Columns) {
                /** @type {cPoint} */
                btn := cPoint(cvalue, rvalue)
                If (!btn.IsBackground()) {
                    btn.ClickOffset(, , 50)
                    Sleep(150)
                    If (CraftBtn.IsButtonActive() && IsBVSock()) {
                        CraftBtn.Click(50)
                        Sleep(50)
                    }
                }
            }
        }
    }
    ResetModifierKeys()
    Sleep(70)
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
    Global BVInvArr

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
    i := 1
    If (BVInvArr.Length > 1) {
        For (rid, rvalue IN Rows) {
            For (cid, cvalue IN Columns) {
                If (i <= BVInvArr.Length) {
                    /** @type {cPoint} */
                    btn := cPoint(cvalue, rvalue)
                    If (!btn.IsBackground() && StrLower(BVInvArr[i]) = "backpack") {
                        btn.ClickOffset(, , 50)
                        Sleep(150)
                        If (CraftBtn.IsButtonActive()) {
                            CraftBtn.Click(50)
                            Sleep(50)
                        }
                    }
                    i++
                }
            }
        }
    } Else {
        For (rid, rvalue IN Rows) {
            For (cid, cvalue IN Columns) {
                /** @type {cPoint} */
                btn := cPoint(cvalue, rvalue)
                If (!btn.IsBackground()) {
                    btn.ClickOffset(, , 50)
                    Sleep(150)
                    If (CraftBtn.IsButtonActive() && IsBVBackPack()) {
                        CraftBtn.Click(50)
                        Sleep(50)
                    }
                }
                i++
            }
        }
    }
    ResetModifierKeys()
    Sleep(70)
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

;@region ScanBVInventory()
/**
 * ScanBVInventory
 */
ScanBVInventory(*) {

    /** @type {cPoint} */
    CraftBtn := cPoint(1570, 644)
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
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    Global BVInvArr := []

    For (rid, rvalue IN Rows) {
        For (cid, cvalue IN Columns) {
            /** @type cPoint */
            btn := cPoint(cvalue, rvalue)
            invtype := ""
            If (!btn.IsBackground()) {
                btn.ClickOffset()
                Sleep(200)
                If (CraftBtn.IsButton()) {
                    Displayed := false
                    If (IsBVCandy()) {
                        Out.D("r " rid " c " cid " Candy")
                        Displayed := true
                        invtype := "Candy"
                    }
                    If (IsBVCape()) {
                        Out.D("r " rid " c " cid " Cape")
                        Displayed := true
                        invtype := "Cape"
                    }
                    If (IsBVSock()) {
                        Out.D("r " rid " c " cid " Sock")
                        Displayed := true
                        invtype := "Sock"
                    }
                    If (IsBVRing()) {
                        Out.D("r " rid " c " cid " Ring")
                        Displayed := true
                        invtype := "Ring"
                    }
                    If (IsBVBackpack()) {
                        Out.D("r " rid " c " cid " Backpack")
                        Displayed := true
                        invtype := "Backpack"
                    }
                    If (IsBVRandomBox()) {
                        Out.D("r " rid " c " cid " Box")
                        Displayed := true
                        invtype := "Box"
                    }
                    /* if(!Displayed) {
                        Out.D("r " rid " c " cid " Other, Candy: " colour1 " Box: " colour2)
                    } */

                }
            }
            BVInvArr.push(invtype)
        }
    }
    Settings.SaveCurrentSettings()
}
;@endregion

/**
 * 
 */
IsBVBackPack() {
    p1 := cPoint(1788, 520).GetColour()
    p2 := cPoint(1777, 532).GetColour()
    Return p1 = "0xD79C75" && p2 = "0x0A1423" ? true : false
}

/**
 * 
 */
IsBVRing() {
    p1 := cPoint(1788, 520).GetColour()
    p2 := cPoint(1777, 532).GetColour()
    Return p1 = "0x14B046" && p2 = "0x97714A" ? true : false
}

/**
 * 
 */
IsBVSock() {
    p1 := cPoint(1788, 520).GetColour()
    p2 := cPoint(1777, 532).GetColour()
    Return p1 = "0x6E8390" && p2 = "0xECEFE9" ? true : false
}

/**
 * 
 */
IsBVCape() {
    p1 := cPoint(1788, 520).GetColour()
    p2 := cPoint(1777, 532).GetColour()
    Return p1 = "0x6CD820" && p2 = "0x1D1A29" ? true : false
}

/**
 * 
 */
IsBVCandy() {
    p1 := cPoint(1788, 520).GetColour()
    p2 := cPoint(1777, 532).GetColour()
    Return p1 = "0xFFE976" && p2 = "0x61233E" ? true : false
}

/**
 * 
 */
IsBVRandomBox() {
    p1 := cPoint(1788, 520).GetColour()
    p2 := cPoint(1777, 532).GetColour()
    Return p1 = "0xEAB780" && p2 = "0xAB5A53" ? true : false
}
