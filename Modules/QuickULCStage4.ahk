#Requires AutoHotkey v2.0

S.AddSetting("ULC", "BVInvArr", "", "Array")
S.AddSetting("ULC", "ULCMineStoreToSpheres", true, "Bool")

BVItemColumns := [
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
BVItemRows := [
    502,
    623,
    749,
    877,
    1001
]

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
        LegBtn.ClickOffsetUntilColour(LegBtn.Inactive, 100)
        Sleep(50)
    }
    If (ComBtn.IsButtonActive()) {
        ComBtn.ClickOffset()
    }
    If (ComBtn.IsButtonActive()) {
        ComBtn.ClickOffsetUntilColour(ComBtn.Inactive, 100)
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

    If (S.Get("ULCMineStoreToSpheres")) {
        Points.Mine.Transmute.AllCDiasToSpheres.Click()
        Sleep(50)
        Points.Mine.Transmute.AllCDiasToFuel.Click()
        Sleep(50)
    } Else {
        Points.Mine.Transmute.AllCDiasToFuel.Click()
        Sleep(50)
    }
    Points.Mine.Tab4Drill.ClickButtonActive()
    Sleep(50)
    Points.Mine.FreeFuel.ClickButtonActive()
}
;@endregion

;@region MaxBVItems(*)
/**
 * MaxBVItems Go through each bv item in inventory and try to max it
 */
MaxBVItems(*) {
    /** @type {cLBRButton} */
    CraftBtn := cLBRButton(1585, 630)

    BVInvArr := S.Get("BVInvArr")

    UlcWindow()
    Shops.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    i := 1
    If (BVInvArr.length > 1) {
        Out.D("MaxBVItems: Using scanned locations")
        For (rid, rvalue IN BVItemRows) {
            For (cid, cvalue IN BVItemColumns) {
                If (i <= BVInvArr.Length) {
                    /** @type cLBRButton */
                    btn := cLBRButton(cvalue, rvalue)
                    item := StrLower(BVInvArr[i])
                    If (!btn.IsBackground() &&
                    item != "cape" && item != "candy" && item != "box") {
                        btn.ClickOffset()
                        Sleep(180)
                        AmountToModifier(25000)
                        Sleep(70)
                        If (CraftBtn.IsButtonActive()) {
                            CraftBtn.ClickOffset(, , 50)
                            Sleep(70)
                        }
                        If (CraftBtn.IsButtonActive()) {
                            CraftBtn.ClickOffset(, , 50)
                            Sleep(70)
                        }
                        ResetModifierKeys()
                        Sleep(70)
                    }
                    i++
                }
            }
        }
    } Else {
        Out.D("MaxBVItems: Using manual locations")
        For (rid, rvalue IN BVItemRows) {
            For (cid, cvalue IN BVItemColumns) {
                /** @type cLBRButton */
                btn := cLBRButton(cvalue, rvalue)
                If (!btn.IsBackground()) {
                    btn.ClickOffset()
                    Sleep(180)
                    AmountToModifier(25000)
                    Sleep(70)
                    If (CraftBtn.IsButtonActive() && IsItemCraftable()) {
                        CraftBtn.ClickOffset(, , 50)
                        Sleep(70)
                    }
                    If (CraftBtn.IsButtonActive() && IsItemCraftable()) {
                        CraftBtn.ClickOffset(, , 50)
                        Sleep(70)
                    }
                    ResetModifierKeys()
                    Sleep(70)
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
    /** @type {cLBRButton} */
    CraftBtn := cLBRButton(1585, 630)

    BVInvArr := S.Get("BVInvArr")

    UlcWindow()
    Shops.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    i := 1
    If (BVInvArr.Length > 1) {
        For (rid, rvalue IN BVItemRows) {
            For (cid, cvalue IN BVItemColumns) {
                If (i <= BVInvArr.Length) {
                    /** @type {cLBRButton} */
                    btn := cLBRButton(cvalue, rvalue)
                    item := StrLower(BVInvArr[i])
                    If (item = "sock" && !btn.IsBackground()) {
                        btn.ClickOffset(, , 50)
                        Sleep(180)
                        AmountToModifier(25000)
                        Sleep(70)
                        If (CraftBtn.IsButtonActive()) {
                            Out.D("Clicking sock craft")
                            CraftBtn.ClickOffset(, , 50)
                            Sleep(70)
                        }
                        If (CraftBtn.IsButtonActive()) {
                            Out.D("Clicking sock craft")
                            CraftBtn.ClickOffset(, , 50)
                            Sleep(70)
                        }
                        ResetModifierKeys()
                        Sleep(70)
                    }
                    i++
                }
            }
        }
    } Else {
        For (rid, rvalue IN BVItemRows) {
            For (cid, cvalue IN BVItemColumns) {
                /** @type {cLBRButton} */
                btn := cLBRButton(cvalue, rvalue)
                If (!btn.IsBackground()) {
                    btn.ClickOffset(, , 50)
                    Sleep(150)
                    AmountToModifier(25000)
                    Sleep(70)
                    If (CraftBtn.IsButtonActive() && IsBVSock()) {
                        Out.D("Clicking sock craft with unscanned bv")
                        CraftBtn.ClickOffset(, , 50)
                        Sleep(70)
                    }
                    If (CraftBtn.IsButtonActive() && IsBVSock()) {
                        Out.D("Clicking sock craft with unscanned bv")
                        CraftBtn.ClickOffset(, , 50)
                        Sleep(70)
                    }
                    ResetModifierKeys()
                    Sleep(70)
                }
            }
        }
    }
    ResetModifierKeys()
    Sleep(70)
}
;@endregion

;@region MaxBVItemsJustRings(*)
/**
 * MaxBVItemsJustRings Go through each bv item in inventory and try to 
 * max it if sock
 */
MaxBVItemsJustRings(*) {
    /** @type {cLBRButton} */
    CraftBtn := cLBRButton(1585, 630)
    /** @type {cLBRButton} */
    AscendBtn := cLBRButton(1855, 646)

    BVInvArr := S.Get("BVInvArr")
    UlcWindow()
    Shops.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    i := 1
    If (BVInvArr.Length > 1) {
        For (rid, rvalue IN BVItemRows) {
            For (cid, cvalue IN BVItemColumns) {
                If (i <= BVInvArr.Length) {
                    /** @type {cLBRButton} */
                    btn := cLBRButton(cvalue, rvalue)
                    item := StrLower(BVInvArr[i])
                    If (item = "ring" && !btn.IsBackground()) {
                        btn.ClickOffset(, , 50)
                        Sleep(150)
                        AmountToModifier(25000)
                        Sleep(70)
                        If (CraftBtn.IsButtonActive()) {
                            CraftBtn.ClickOffset(, , 50)
                            Sleep(70)
                        }
                        If (CraftBtn.IsButtonActive()) {
                            CraftBtn.ClickOffset(, , 50)
                            Sleep(70)
                        }
                        ResetModifierKeys()
                        Sleep(70)
                    }
                    i++
                }
            }
        }
    } Else {
        For (rid, rvalue IN BVItemRows) {
            For (cid, cvalue IN BVItemColumns) {
                /** @type {cLBRButton} */
                btn := cLBRButton(cvalue, rvalue)
                If (!btn.IsBackground()) {
                    btn.ClickOffset(, , 50)
                    Sleep(150)
                    AmountToModifier(25000)
                    Sleep(70)
                    If (CraftBtn.IsButtonActive() && IsBVRing()) {
                        CraftBtn.ClickOffset(, , 50)
                        Sleep(70)
                    }
                    If (CraftBtn.IsButtonActive() && IsBVRing()) {
                        CraftBtn.ClickOffset(, , 50)
                        Sleep(70)
                    }
                    ResetModifierKeys()
                    Sleep(70)
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
    /** @type {cLBRButton} */
    CraftBtn := cLBRButton(1585, 630)
    /** @type {cLBRButton} */
    AscendBtn := cLBRButton(1855, 646)
    BVInvArr := S.Get("BVInvArr")

    UlcWindow()
    Shops.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    i := 1
    If (BVInvArr.Length > 1) {
        For (rid, rvalue IN BVItemRows) {
            For (cid, cvalue IN BVItemColumns) {
                If (i <= BVInvArr.Length) {
                    /** @type {cLBRButton} */
                    btn := cLBRButton(cvalue, rvalue)
                    If (!btn.IsBackground() && StrLower(BVInvArr[i]) = "backpack") {
                        btn.ClickOffset(, , 50)
                        Sleep(150)
                        AmountToModifier(25000)
                        Sleep(70)
                        If (CraftBtn.IsButtonActive()) {
                            CraftBtn.ClickOffset(, , 50)
                            Sleep(70)
                        }
                        If (CraftBtn.IsButtonActive()) {
                            CraftBtn.ClickOffset(, , 50)
                            Sleep(70)
                        }
                        ResetModifierKeys()
                        Sleep(70)
                    }
                    i++
                }
            }
        }
    } Else {
        For (rid, rvalue IN BVItemRows) {
            For (cid, cvalue IN BVItemColumns) {
                /** @type {cLBRButton} */
                btn := cLBRButton(cvalue, rvalue)
                If (!btn.IsBackground()) {
                    btn.ClickOffset(, , 50)
                    Sleep(150)
                    AmountToModifier(25000)
                    Sleep(70)
                    If (CraftBtn.IsButtonActive() && IsBVBackPack()) {
                        CraftBtn.ClickOffset(, , 50)
                        Sleep(70)
                    }
                    If (CraftBtn.IsButtonActive() && IsBVBackPack()) {
                        CraftBtn.ClickOffset(, , 50)
                        Sleep(70)
                    }
                    ResetModifierKeys()
                    Sleep(70)
                }
                i++
            }
        }
    }
    ResetModifierKeys()
    Sleep(70)
}
;@endregion

;@region MaxBVItemsJustBags641(*)
/**
 * MaxBVItemsJustBags641 Go through each bv item in inventory and try to 
 * max it if sock
 */
MaxBVItemsJustBags641(*) {
    /** @type {cLBRButton} */
    CraftBtn := cLBRButton(1585, 630)
    /** @type {cLBRButton} */
    AscendBtn := cLBRButton(1855, 646)

    BVInvArr := S.Get("BVInvArr")

    UlcWindow()
    Shops.OpenBorbVentures()
    Sleep(100)
    Points.Borbventures.InvTab.Click()
    Sleep(100)
    Done := 0
    While (Done < 12) {
        i := 1
        If (BVInvArr.Length > 1) {
            For (rid, rvalue IN BVItemRows) {
                For (cid, cvalue IN BVItemColumns) {
                    If (i <= BVInvArr.Length) {
                        /** @type {cLBRButton} */
                        btn := cLBRButton(cvalue, rvalue)
                        If (!btn.IsBackground() && StrLower(BVInvArr[i]) = "backpack") {
                            btn.ClickOffset(, , 50)
                            Sleep(150)
                            If (CraftBtn.IsButtonActive()) {
                                AmountToModifier(25000)
                                Sleep(100)
                                CraftBtn.ClickOffset(, , 50)
                                Sleep(70)
                                If (CraftBtn.IsButtonActive()) {
                                    CraftBtn.ClickOffset(, , 50)
                                    Sleep(70)
                                }
                                ResetModifierKeys()
                                Sleep(70)
                            } Else {
                                Done++
                            }
                        }
                        i++
                    }
                }
            }
        } Else {
            For (rid, rvalue IN BVItemRows) {
                For (cid, cvalue IN BVItemColumns) {
                    /** @type {cLBRButton} */
                    btn := cLBRButton(cvalue, rvalue)
                    If (!btn.IsBackground()) {
                        btn.ClickOffset(, , 50)
                        Sleep(150)
                        If (CraftBtn.IsButtonActive() && IsBVBackPack()) {
                            AmountToModifier(25000)
                            Sleep(100)
                            CraftBtn.ClickOffset(, , 50)
                            Sleep(70)
                            If (CraftBtn.IsButtonActive()) {
                                CraftBtn.ClickOffset(, , 50)
                                Sleep(70)
                            }
                            ResetModifierKeys()
                            Sleep(70)
                        } Else If (!CraftBtn.IsButtonActive() && IsBVBackPack()) {
                            Done++
                        }
                    }
                    i++
                }
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
    /** @type {cLBRButton} */
    ComBtn := Points.Borbventures.PacksBuyCommon
    /** @type {cLBRButton} */
    RareBtn := Points.Borbventures.PacksBuyRare
    /** @type {cLBRButton} */
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
    DiceShop := cLBRButton(253, 1150)
    Travel.ClosePanelIfActive()
    DiceShop.ClickOffset()
    Sleep(50)
    Points.Dice.Tab.Options.ClickButtonActive()
    Sleep(50)
    BasicAutoRoll := cLBRButton(370, 392).ClickButtonActive()
    Sleep(50)
    PowerAutoRoll := cLBRButton(369, 479).ClickButtonActive()
    Sleep(50)
}
;@endregion

;@region ScanBVInventory()
/**
 * ScanBVInventory
 */
ScanBVInventory(*) {

    /** @type {cLBRButton} */
    CraftBtn := cLBRButton(1585, 630)
    UlcWindow()
    Shops.OpenBorbVentures()
    Sleep(150)
    Points.Borbventures.InvTab.Click()
    Points.Borbventures.InvTab.Click()
    Sleep(150)

    BVInvArr := []

    For (rid, rvalue IN BVItemRows) {
        For (cid, cvalue IN BVItemColumns) {
            /** @type cLBRButton */
            btn := cLBRButton(cvalue, rvalue)
            invtype := ""
            If (!btn.IsBackground()) {
                btn.ClickOffset()
                Sleep(250)
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

    S.Set("BVInvArr", BVInvArr)
    S.SaveCurrentSettings()
}
;@endregion

/**
 * 
 */
IsBVBackPack() {
    p1 := cLBRButton(1788, 520).GetColour()
    p2 := cLBRButton(1777, 532).GetColour()
    Return p1 = "0xD79C75" && p2 = "0x0A1423" ? true : false
}

/**
 * 
 */
IsBVRing() {
    p1 := cLBRButton(1788, 520).GetColour()
    p2 := cLBRButton(1777, 532).GetColour()
    Return p1 = "0x14B046" && p2 = "0x97714A" ? true : false
}

/**
 * 
 */
IsBVSock() {
    p1 := cLBRButton(1788, 520).GetColour()
    p2 := cLBRButton(1777, 532).GetColour()
    ;Out.D(p1 " " p2)
    If (p1 = "0x6E8390" && p2 = "0xECEFE9") {
        Return true
    }
    If (p1 = "0x6E8390" && p2 = "0xAEC3BE") {
        Return true
    }
    Return false
}

/**
 * 
 */
IsBVCape() {
    p1 := cLBRButton(1788, 520).GetColour()
    p2 := cLBRButton(1777, 532).GetColour()
    Return p1 = "0x6CD820" && p2 = "0x1D1A29" ? true : false
}

/**
 * 
 */
IsBVCandy() {
    p1 := cLBRButton(1788, 520).GetColour()
    p2 := cLBRButton(1777, 532).GetColour()
    Return p1 = "0xFFE976" && p2 = "0x61233E" ? true : false
}

/**
 * 
 */
IsBVRandomBox() {
    p1 := cLBRButton(1788, 520).GetColour()
    p2 := cLBRButton(1777, 532).GetColour()
    Return p1 = "0xEAB780" && p2 = "0xAB5A53" ? true : false
}

MaxAllShopsAfterWoW(*) {
    UlcWindow()
    BLCMax()
    Shops.MLC.Max()
    Shops.Mulch.Max()
    Shops.Sacred.Max()
    Shops.Biotite.Max()
    Shops.Malachite.Max()
    Shops.Hematite.Max()
    Shops.Plasma.Max()
    Shops.Coal.Max()
    Shops.SoulShop.Max()
    Shops.SoulForge.Max()
}

BLCMax() {
    GameKeys.OpenBLCShop()
    Sleep(150)
    Travel.ScrollResetToTop()
    Travel.ScrollAmountDown(28)
    If (cLBRButton(1865, 743).IsBackground()) {
        ; No button so nothing to increase
        Return
    }
    cLBRButton(1865, 743).ClickButtonActive() ; Buy max leaves
    Sleep(50)
    cLBRButton(1865, 743).ClickButtonActive()
    Sleep(50)

    cLBRButton(720, 89).Click() ; Open artifacts
    Sleep(150)
    Travel.ScrollResetToTop()
    If (Window.IsPanel() && cLBRButton(364, 351).IsButtonActive()) {
        Travel.ScrollAmountDown(35)
        AmountToModifier(25000)
        Sleep(50)
        cLBRButton(1798, 703).ClickButtonActive() ; Use blc
        Sleep(50)
        ResetModifierKeys()
        Sleep(50)
        GameKeys.OpenBLCShop()
        Sleep(150)
        cLBRButton(1865, 743).ClickButtonActive() ; Buy max leaves
        Sleep(50)
        cLBRButton(1865, 743).ClickButtonActive()
        Sleep(50)

        cLBRButton(720, 89).Click() ; Open artifacts
        Sleep(150)
        If (Window.IsPanel() && cLBRButton(364, 704).IsButtonActive()) {
            AmountToModifier(25000)
            Sleep(50)
            cLBRButton(1798, 703).ClickButtonActive() ; Use blc
            Sleep(1000)
            cLBRButton(1798, 703).ClickButtonActive() ; Use blc
            Sleep(1000)
            cLBRButton(1798, 703).ClickButtonActive() ; Use blc
            Sleep(50)
            ResetModifierKeys()
        }
    }
}
