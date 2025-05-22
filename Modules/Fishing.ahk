#Requires AutoHotkey v2.0
#Include ../Lib/cRects.ahk
#Include ../Lib/cPoints.ahk

Global FishCatchingDelay := 0
Global FishCatchingSearch := false

Global FishEnableShopUpgrade := false
Global FishEnableUpgradeRods := false
Global FishEnableTourneyPass := false
Global FishEnableUpgradeTourneyRods := false
Global FishEnableTransmute := false
Global FishEnableJourneyCollect := false

Global FishTimerShopUpgrade := 1
Global FishTimerUpgradeRods := 1
Global FishTimerTourneyPass := 1
Global FishTimerUpgradeTourneyRods := 1
Global FishTimerTransmute := 1
Global FishTimerJourneyCollect := 1

Global FishTransmuteTtoFC := false
Global FishTransmuteFCtoCry := false
Global FishTransmuteCrytoA := false
Global FishTransmuteFCtoT := false
Global FishTransmuteCrytoFC := false
Global FishTransmuteAtoCry := false

Global FishChlCatchingDelay := 0
Global FishChlCatchingSearch := false

Global FishChlEnableShopUpgrade := false
Global FishChlEnableUpgradeRods := false
Global FishChlEnableTransmute := false
Global FishChlEnableJourneyCollect := false

Global FishChlTimerShopUpgrade := 1
Global FishChlTimerUpgradeRods := 1
Global FishChlTimerTransmute := 1
Global FishChlTimerJourneyCollect := 1

Global FishChlTransmuteTtoFC := false
Global FishChlTransmuteFCtoCry := false
Global FishChlTransmuteCrytoA := false
Global FishChlTransmuteFCtoT := false
Global FishChlTransmuteCrytoFC := false
Global FishChlTransmuteAtoCry := false

Global FishTourCatchingDelay := 0
Global FishTourCatchingSearch := false

Global FishTourEnableShopUpgrade := false
Global FishTourEnableUpgradeRods := false
Global FishTourEnableFishingPass := false
Global FishTourEnableUpgradeTourneyRods := false
Global FishTourEnableTransmute := false
Global FishTourEnableJourneyCollect := false

Global FishTourTimerShopUpgrade := 1
Global FishTourTimerUpgradeRods := 1
Global FishTourTimerUpgradeTourneyRods := 1
Global FishTourTimerTransmute := 1
Global FishTourTimerJourneyCollect := 1

Global FishTourTransmuteTtoFC := false
Global FishTourTransmuteFCtoCry := false
Global FishTourTransmuteCrytoA := false
Global FishTourTransmuteFCtoT := false
Global FishTourTransmuteCrytoFC := false
Global FishTourTransmuteAtoCry := false

;@region Points
/**
 * Points class to contain points of the tabs in fishing screen
 * @module FishingTabs
 */
Class FishingTabs {
    /** @type {cPoint} Pond (main fishing) tab button */
    Pond := cPoint(287, 1163)
    /** @type {cPoint} Shop tab button */
    Shop := cPoint(1440, 1165),
    /** @type {cPoint} Rods tab button */
    Rods := cPoint(660, 1164),
    /** @type {cPoint} Journey tab button */
    Journey := cPoint(1635, 1164),
    /** @type {cPoint} Transmute tab button */
    Transmute := cPoint(2231, 1164),
    /** @type {cPoint} Tourney Tab */
    Tourney := cPoint(1835, 1166),
    /** @type {cPoint} Tourney Rod tab */
    TourneyRod := cPoint(1856, 1163)
}

/**
 * Points class to contain points of the ponds screen
 * @module FishingPonds
 */
Class FishingPonds {
    /** @type {cPoint} */
    Lure := cPoint(858, 314)
    /** @type {cPoint} */
    ConfirmCancel := cPoint(1395, 556)
    /** @type {cPoint} */
    Search := cPoint(524, 313)
    /** @type {cPoint} */
    NewPondRod := cPoint(968, 892)
    /** @type {cPoint} */
    NewPondRod2 := cPoint(1048, 892)
    /** @type {cPoint} */
    NewPondRod3 := cPoint(1128, 892)

    IsOnTab() {
        If (this.Lure.IsButton() && this.Search.IsButton()) {
            Return true
        }
        Return false
    }
}

/**
 * Points class to contain points of the Fishing rods screen
 * @module FishingRods
 */
Class FishingRods {
    /** @type {cPoint} First rod icon point +65 x per */
    FirstRod := cPoint(350, 555)
    /** @type {cPoint} Second rod icon point */
    SecondRod := cPoint(415, 555)
    /** @type {cPoint} Third rod icon point */
    ThirdRod := cPoint(480, 555)
    /** @type {cPoint} Fourth rod icon point */
    FourthRod := cPoint(545, 555)
    /** @type {cPoint} Fifth rod icon point */
    FifthRod := cPoint(610, 555)
    /** @type {cPoint} Sixth rod icon point */
    SixthRod := cPoint(675, 555)
    /** @type {cPoint} Seventh rod icon point */
    SeventhRod := cPoint(740, 555)

    /** @type {cPoint} Rod crafting button */
    Craft := cPoint(617, 314)
    /** @type {cPoint} Rod fish length upgrade */
    Length := cPoint(1449, 602)
    /** @type {cPoint} Rod quality upgrade */
    Quality := cPoint(1450, 732)
    /** @type {cPoint} Rod tier ascend upgrade */
    Ascend := cPoint(1450, 863)
    /** @type {cPoint} Rod fish length upgrade */
    Length2 := cPoint(1448, 615)
    /** @type {cPoint} Rod quality upgrade */
    Quality2 := cPoint(1448, 745)
    /** @type {cPoint} Rod tier ascend upgrade */
    Ascend2 := cPoint(1447, 874)

    IsOnTab() {
        Out.D(this.FirstRod.GetDescription() " " this.Craft.GetDescription())
        If (!this.FirstRod.IsBackground() && this.Craft.IsButton()) {
            Return true
        }
        Return false
    }
}

/**
 * Points class to contain points of the shop in fishing screen
 * @module FishingShop
 * @property {cPoint} BuySpot Buy fishing spot button
 */
Class FishingShop {
    /** First rod icon for checks if on tab
     * @type {cPoint} */
    RodIcon := cPoint(332, 315)
    /** Second rod icon for checks if on tab
     * @type {cPoint} */
    RodIcon2 := cPoint(340, 449)

    /** 1 Auto fish purchase button
     * @type {cPoint} */
    Auto := cPoint(1571, 292)
    /** 2 Auto fish threshold purchase button
     * @type {cPoint} */
    AutoThreshold := cPoint(1570, 434)
    /** 3 Auto fish speed max purchase button
     * @type {cPoint} */
    FasterAuto := cPoint(1730, 578)
    /** 4 Buy fishing spot max button
     * @type {cPoint} */
    BuySpot := cPoint(1730, 718)
    /** 5 Buy minimum line max button
     * @type {cPoint} */
    MinLine := cPoint(1730, 860)
    /** 6 Buy maximum line max button
     * @type {cPoint} */
    MaxLine := cPoint(1730, 1001)

    /** 7 Rod recharge duration max button, shift wheel down one
     * @type {cPoint} */
    RodRecharge := cPoint(1730, 657)
    /** 8 Fishing credit amount max button, shift wheel down one
     * @type {cPoint} */
    CreditsUpgrade := cPoint(1730, 815)
    /** 9 Fishing rod amount max button, shift wheel down one
     * @type {cPoint} */
    MaxRods := cPoint(1731, 940)

    /** 10 Fishing rarity max button, shift wheel down two
     * @type {cPoint} */
    Rarity := cPoint(1729, 595)
    /** 11 Fishing spots rarity max button, shift wheel down two
     * @type {cPoint} */
    SpotRarity := cPoint(1729, 739)
    /** 12 Tide crystal chance max button, shift wheel down two
     * @type {cPoint} */
    CrystalChance := cPoint(1728, 880)

    /** 13 Fish bait unlock button, shift wheel down three
     * @type {cPoint} */
    BaitUnlock := cPoint(1570, 536)
    /** 14 */
    /** 15 */
    /** 16 */

    /** 17 Tourney unlock button, shift wheel down four
     * @type {cPoint} */
    TourneyUnlock := cPoint(1570, 900)

    IsOnTab() {
        If (!this.RodIcon.IsButton() && !this.RodIcon.IsBackground() &&
        !this.RodIcon2.IsButton() && !this.RodIcon2.IsBackground()) {
            Return true
        }
        Return false
    }
}

/**
 * Points class to contain points of the fishing journey screen
 * @module FishingJourney
 */
Class FishingJourney {
    /** Journey claim all button
     * @type {cPoint} */
    ClaimAll := cPoint(548, 601)
    /** Collect reset bonus
     * @type {cPoint} */
    Complete := cPoint(1243, 836)

    IsOnTab() {
        If (this.ClaimAll.IsButton()) {
            Return true
        }
        Return false
    }
}

/**
 * Points class to contain points of the fishing tourney rod upgrade screen
 * @module FishingTourneyRod
 */
Class FishingTourneyRod {
    /** @type {cPoint} Upgrade rod tip */
    Tip := cPoint(2025, 289)
    /** @type {cPoint} Upgrade rod handle */
    Handle := cPoint(2025, 421)
    /** @type {cPoint} Upgrade rod shaft */
    Shaft := cPoint(2025, 553)

    IsOnTab() {
        If (this.Tip.IsButton() && (this.Handle.IsButton() || this.Handle.IsBackground()) || (this.Shaft.IsButton() &&
        this.Shaft.IsBackground())) {
            Return true
        }
        Return false
    }
}

/**
 * Points class to contain points of the fishing transmute screen
 * @module FishingTransmute
 */
Class FishingTransmute {
    /** @type {cPoint} Max Transmute Trash to Fish Credits */
    TrashToCreditsMax := cPoint(719, 288)
    /** @type {cPoint} Max Transmute Fish Credits to Tide Crystal */
    CreditsToCrystalMax := cPoint(719, 416)
    /** @type {cPoint} Max Transmute Tide Crystal to Advanced Tide Crystal  */
    CrystalToAdvancedMax := cPoint(723, 545)

    /** @type {cPoint} Max Transmute Fish Credits to Trash */
    CreditsToTrashMax := cPoint(1759, 289)
    /** @type {cPoint} Max Transmute Tide Crystal to Fish Credits */
    CrystalToCreditsMax := cPoint(1761, 418)
    /** @type {cPoint} Max Transmute Advanced Tide Crystal to Tide Crystal */
    AdvancedToCrystalMax := cPoint(1759, 542)

    IsOnTab() {
        If (this.TrashToCreditsMax.IsButton() && this.CreditsToCrystalMax.IsButton() && this.CreditsToTrashMax.IsButton()) {
            Return true
        }
        Return false
    }
}
;@endregion

/**
 * Fishing Class to contain all fishing related functions
 * @module Fishing
 * @property {Type} property Desc
 * @method Name Desc
 */
Class Fishing {

    ;@region Properties
    /** @type {FishingTabs} */
    Tabs := FishingTabs()
    /** @type {FishingPonds} */
    Ponds := FishingPonds()
    /** @type {FishingRods} */
    Rods := FishingRods()
    /** @type {FishingShop} */
    Shop := FishingShop()
    /** @type {FishingJourney} */
    Journey := FishingJourney()
    /** @type {FishingTourney} */
    Tourney := FishingTourney().SetModeFishing()
    /** @type {FishingJourneyRod} */
    TourneyRod := FishingTourneyRod()
    /** @type {FishingTransmute} */
    Transmute := FishingTransmute()

    /** @type {Pond} */
    Pond1 := Pond(1)
    /** @type {Pond} */
    Pond2 := Pond(2)
    /** @type {Pond} */
    Pond3 := Pond(3)
    /** @type {Pond} */
    Pond4 := Pond(4)

    ;@endregion

    ;@region fFishAutoCatch()
    /**
     * Attempt to auto catch fish (Simple)
     */
    fFishAutoCatch(challenge := false) {
        StartTime := A_TickCount - (FishCatchingDelay * 1000)
        Time1 := StartTime
        Time2 := StartTime
        Time3 := StartTime
        Time4 := StartTime
        If (FishCatchingSearch && !challenge) {
            Out.I("Started fishing with search")
        } Else If (challenge) {
            Out.I("Started fishing challenge")
        } Else {
            Out.I("Started fishing")
        }

        JourneyTime := A_Now
        TransmuteTime := A_Now
        RodsTime := A_Now
        ShopTime := A_Now
        TourneyTime := A_Now
        TourneyRodTime := A_Now
        LogToggle := true
        Loop {
            If (!Window.IsActive()) {
                Break
            }

            While (!this.Ponds.IsOnTab()) {
                this.Tabs.Pond.ClickButtonActive(, 5)
            }
            If (LogToggle) {
                Out.I("Fishing pass")
                LogToggle := false
            }
            If (FishCatchingSearch && !challenge) {
                If (this.Ponds.Search.IsButtonActive()) {
                    ; Search if the buttons active because a slot is empty
                    this.Ponds.Search.ClickButtonActive()
                    Out.I("Pond searched")
                }
                this.PondQualityUpgrade()
            }
            this.FishPonds(&Time1, &Time2, &Time3, &Time4, true)
            If (FishTimerJourneyCollect &&
                DateDiff(A_Now, JourneyTime, "S") > FishTimerJourneyCollect) {
                this.JourneyCollect()
                this.Tabs.Pond.ClickButtonActive()
                JourneyTime := A_Now
                LogToggle := true
            }
            If (FishTimerTransmute &&
                DateDiff(A_Now, TransmuteTime, "S") > FishTimerTransmute) {
                this.UserSelectedTransmute()
                this.Tabs.Pond.ClickButtonActive()
                TransmuteTime := A_Now
                LogToggle := true
            }
            If (FishEnableUpgradeRods &&
                DateDiff(A_Now, RodsTime, "S") > FishTimerUpgradeRods) {
                this.UpgradeRods()
                this.Tabs.Pond.ClickButtonActive()
                RodsTime := A_Now
                LogToggle := true
            }
            If (FishEnableShopUpgrade &&
                DateDiff(A_Now, ShopTime, "S") > FishTimerShopUpgrade) {
                this.ShopUpgrade()
                this.Tabs.Pond.ClickButtonActive()
                ShopTime := A_Now
                LogToggle := true
            }
            If (FishEnableUpgradeTourneyRods &&
                DateDiff(A_Now, TourneyRodTime, "S") > FishTimerUpgradeTourneyRods) {
                this.TourneyRodUpgrade()
                this.Tabs.Pond.ClickButtonActive()
                TourneyRodTime := A_Now
                LogToggle := true
            }
            If (FishEnableTourneyPass &&
                DateDiff(A_Now, TourneyTime, "S") > FishTimerTourneyPass) {
                this.TourneySinglePass()
                this.Tabs.Pond.ClickButtonActive()
                TourneyTime := A_Now
                LogToggle := true
            }

        }
    }
    ;@endregion

    ;@region JourneyCollect()
    /**
     * Description
     */
    JourneyCollect() {
        Out.I("Journey Collect")
        While (!this.Journey.IsOnTab()) {
            this.Tabs.Journey.ClickButtonActive(, 5)
        }
        this.Tabs.Journey.ClickButtonActive()
        this.Journey.ClaimAll.WaitUntilButtonS()
        this.Journey.ClaimAll.ClickButtonActive()
        this.Journey.Complete.WaitUntilButton(20, 17)
        this.Journey.Complete.ClickButtonActive()
    }
    ;@endregion

    ;@region UserSelectedTransmute()
    /**
     * Go to transmute and transmute user selected items
     */
    UserSelectedTransmute() {
        Out.I("User Selected Transmute")
        While (!this.Transmute.IsOnTab()) {
            this.Tabs.Transmute.ClickButtonActive(, 5)
        }
        this.Transmute.TrashToCreditsMax.WaitUntilButtonS()
        If (FishTransmuteTtoFC) {
            this.Transmute.TrashToCreditsMax.ClickButtonActive()
        }
        If (FishTransmuteFCtoCry) {
            this.Transmute.CreditsToCrystalMax.ClickButtonActive()
        }
        If (FishTransmuteCrytoA) {
            this.Transmute.CrystalToAdvancedMax.ClickButtonActive()
        }

        If (FishTransmuteFCtoT) {
            this.Transmute.CreditsToTrashMax.ClickButtonActive()
        }
        If (FishTransmuteCrytoFC) {
            this.Transmute.CrystalToCreditsMax.ClickButtonActive()
        }
        If (FishTransmuteAtoCry) {
            this.Transmute.AdvancedToCrystalMax.ClickButtonActive()
        }
    }
    ;@endregion

    ;@region UserChlSelectedTransmute()
    /**
     * Go to transmute and transmute user selected items (Challenge)
     */
    UserChlSelectedTransmute() {
        Out.I("User Selected Transmute challenge")
        While (!this.Transmute.IsOnTab()) {
            this.Tabs.Transmute.ClickButtonActive(, 5)
        }
        this.Transmute.TrashToCreditsMax.WaitUntilButtonS()
        If (FishChlTransmuteTtoFC) {
            this.Transmute.TrashToCreditsMax.ClickButtonActive()
        }
        If (FishChlTransmuteFCtoCry) {
            this.Transmute.CreditsToCrystalMax.ClickButtonActive()
        }
        If (FishChlTransmuteCrytoA) {
            this.Transmute.CrystalToAdvancedMax.ClickButtonActive()
        }

        If (FishChlTransmuteFCtoT) {
            this.Transmute.CreditsToTrashMax.ClickButtonActive()
        }
        If (FishChlTransmuteCrytoFC) {
            this.Transmute.CrystalToCreditsMax.ClickButtonActive()
        }
        If (FishChlTransmuteAtoCry) {
            this.Transmute.AdvancedToCrystalMax.ClickButtonActive()
        }
    }
    ;@endregion

    ;@region UserTourSelectedTransmute()
    /**
     * Go to transmute and transmute user selected items (Tourney)
     */
    UserTourSelectedTransmute() {
        Out.I("User Selected Transmute tourney")
        While (!this.Transmute.IsOnTab()) {
            this.Tabs.Transmute.ClickButtonActive(, 5)
        }
        this.Transmute.TrashToCreditsMax.WaitUntilButtonS()
        If (FishTourTransmuteTtoFC) {
            this.Transmute.TrashToCreditsMax.ClickButtonActive()
        }
        If (FishTourTransmuteFCtoCry) {
            this.Transmute.CreditsToCrystalMax.ClickButtonActive()
        }
        If (FishTourTransmuteCrytoA) {
            this.Transmute.CrystalToAdvancedMax.ClickButtonActive()
        }

        If (FishTourTransmuteFCtoT) {
            this.Transmute.CreditsToTrashMax.ClickButtonActive()
        }
        If (FishTourTransmuteCrytoFC) {
            this.Transmute.CrystalToCreditsMax.ClickButtonActive()
        }
        If (FishTourTransmuteAtoCry) {
            this.Transmute.AdvancedToCrystalMax.ClickButtonActive()
        }
    }
    ;@endregion

    ;@region ShopUpgrade()
    /**
     * Upgrade fishing shop to max available prioritising important upgrades
     */
    ShopUpgrade(challenge := false) {
        Out.I("Shop Upgrade")
        While (!this.Shop.IsOnTab()) {
            this.Tabs.Shop.ClickButtonActive(, 5)
        }
        If (!challenge) {
            this.Shop.Auto.ClickButtonActive()
            this.Shop.AutoThreshold.ClickButtonActive()
            this.Shop.FasterAuto.ClickButtonActive()
            this.Shop.BuySpot.ClickButtonActive()
            this.Shop.MinLine.ClickButtonActive()
            this.Shop.MaxLine.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.RodRecharge.ClickButtonActive()
            this.Shop.CreditsUpgrade.ClickButtonActive()
            this.Shop.MaxRods.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.Rarity.ClickButtonActive()
            this.Shop.SpotRarity.ClickButtonActive()
            this.Shop.CrystalChance.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.BaitUnlock.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.TourneyUnlock.ClickButtonActive()
        } Else {
            this.Shop.BuySpot.ClickButtonActive()
            this.Shop.MinLine.ClickButtonActive()
            this.Shop.MaxLine.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.CreditsUpgrade.ClickButtonActive()
            this.Shop.MaxRods.ClickButtonActive()
            Travel.ScrollAmountDown(21)
            this.Shop.TourneyUnlock.ClickButtonActive()
            ; Low importance items
            Travel.ScrollResetToTop()
            this.Shop.Auto.ClickButtonActive()
            this.Shop.AutoThreshold.ClickButtonActive()
            this.Shop.FasterAuto.ClickButtonActive()
            this.Shop.BuySpot.ClickButtonActive()
            this.Shop.MinLine.ClickButtonActive()
            this.Shop.MaxLine.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.RodRecharge.ClickButtonActive()
            this.Shop.CreditsUpgrade.ClickButtonActive()
            this.Shop.MaxRods.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.Rarity.ClickButtonActive()
            this.Shop.SpotRarity.ClickButtonActive()
            this.Shop.CrystalChance.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.BaitUnlock.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.TourneyUnlock.ClickButtonActive()
        }
    }
    ;@endregion

    ;@region TourneyRodUpgrade()
    /**
     * Description
     */
    TourneyRodUpgrade() {
        If (!this.Tabs.TourneyRod.IsButtonActive()) {
            Out.E("Tourney Rod tab inactive, feature not available")
            Return
        }
        Out.I("Tourney Rod Upgrade")

        While (!this.TourneyRod.IsOnTab()) {
            this.Tabs.TourneyRod.ClickButtonActive(, 5)
        }
        Out.D("Tourney rod: Ontab " this.TourneyRod.IsOnTab() ", ShaftActive " this.TourneyRod.Shaft.IsButtonActive() ", HandleActive " this
        .TourneyRod.Handle.IsButtonActive() ", TipActive " this.TourneyRod.Tip.IsButtonActive())
        While (this.TourneyRod.Shaft.IsButtonActive() ||
        this.TourneyRod.Handle.IsButtonActive() ||
        this.TourneyRod.Tip.IsButtonActive()) {
            Out.D("Tourney rod: Ontab " this.TourneyRod.IsOnTab() ", ShaftActive " this.TourneyRod.Shaft.IsButtonActive() ", HandleActive " this
            .TourneyRod.Handle.IsButtonActive() ", TipActive " this.TourneyRod.Tip.IsButtonActive())
            this.TourneyRod.Shaft.ClickButtonActive()
            this.TourneyRod.Handle.ClickButtonActive()
            this.TourneyRod.Tip.ClickButtonActive()
        }

    }
    ;@endregion

    ;@region TourneySinglePass()
    /**
     * Single pass of tourney fights
     */
    TourneySinglePass() {
        ; Because isontab for tourney could have 4 bugged buttons (thus nothing)
        ; set a timer as backup
        Out.I("Tourney Single Pass")
        limit := true
        Timer().CoolDownS(1, &limit)
        Out.D(this.Tabs.Tourney.IsButtonActive())
        While (limit && !this.Tourney.IsOnTab()) {
            this.Tabs.Tourney.ClickButtonActive(, 5)
        }
        this.Tourney.FarmSingle()
    }
    ;@endregion

    ;@region FishPonds()
    /**
     * Fish ponds a single time
     */
    FishPonds(&Time1, &Time2, &Time3, &Time4, challenge) {

        If (!this.Pond1.CastRod.IsBackground()) {
            this.Pond1.FishPond(&Time1)
        }
        If (!this.Pond2.CastRod.IsBackground()) {
            this.Pond2.FishPond(&Time2)
        }
        If (!this.Pond3.CastRod.IsBackground()) {
            this.Pond3.FishPond(&Time3)
        }
        If (!this.Pond4.CastRod.IsBackground()) {
            this.Pond4.FishPond(&Time4)
        }
        Sleep (17)
        If (this.Ponds.Lure.IsButtonActive() && (A_TickCount - Time1) / 1000 < FishCatchingDelay) {
            this.Ponds.Lure.ClickButtonActive()
        }
    }
    ;@endregion

    ;@region IsSearchOffCD()
    /**
     * Check if pond search cooldown has reset
     */
    IsSearchOffCD() {
        If (cRect(392, 344, 531, 375).pixelSearch()) {
            Return false
        }
        ;Out.I("Search off cooldown")
        Return true
    }
    ;@endregion

    ;@region AreAllPondsMax()
    /**
     * Check if all ponds are legendary
     */
    AreAllPondsMax() {
        p1 := this.Pond1.GetPondRarity()
        p2 := this.Pond2.GetPondRarity()
        p3 := this.Pond3.GetPondRarity()
        p4 := this.Pond4.GetPondRarity()
        If (p4 > 0 && p1 = 6 && p2 = 6 && p3 = 6 && p4 = 6) {
            ;Out.V("Found 4 legendary ponds")
            Return true
        }
        If (p3 > 0 && p1 = 6 && p2 = 6 && p3 = 6 && p4 = -1) {
            ;Out.V("Found 3 legendary ponds")
            Return true
        }
        If (p2 > 0 && p1 = 6 && p2 = 6 && p3 = -1 && p4 = -1) {
            ;Out.V("Found 2 legendary ponds")
            Return true
        }
        If (p1 = 6 && p2 = -1 && p3 = -1 && p4 = -1) {
            ;Out.V("Found 1 legendary ponds")
            Return true
        } Else {
            Return false
        }
    }
    ;@endregion

    ;@region GetLastPondOfRarity()
    /**
     * Get Last pond where rarity matches var
     */
    GetLastPondOfRarity(var) {
        p1 := this.Pond1.GetPondRarity()
        p2 := this.Pond2.GetPondRarity()
        p3 := this.Pond3.GetPondRarity()
        p4 := this.Pond4.GetPondRarity()
        If (var = p4) {
            Return 4
        }
        If (var = p3) {
            Return 3
        }
        If (var = p2) {
            Return 2
        }
        If (var = p1) {
            Return 1
        }
        Return false
    }
    ;@endregion

    ;@region PondQualityUpgrade()
    /**
     * Check for and attempt to upgrade pond quality to max
     */
    PondQualityUpgrade() {
        returned := false
        If (this.AreAllPondsMax()) {
            ;Out.I("All ponds detected at max")
            Return false
        }
        If (!this.IsSearchOffCD()) {
            ;Out.D("Search not off cooldown")
            Return false
        }
        ;Out.I("Attempting pond upgrade")
        WeakestLink := false
        rarity := 1
        While (!WeakestLink && rarity < 6 && Window.IsActive()) {
            WeakestLink := this.GetLastPondOfRarity(rarity)
            rarity++
        }
        If (!WeakestLink) {
            Out.I("Pond rarity upgrade failed to get a pond to upgrade")
            Return false
        }
        ;Out.I("Weakest pond selected " WeakestLink)
        Switch (WeakestLink) {
        Case 1:
            returned := this.Pond1.CancelPond()
        Case 2:
            returned := this.Pond2.CancelPond()
        Case 3:
            returned := this.Pond3.CancelPond()
        Case 4:
            returned := this.Pond4.CancelPond()
        default:
            Out.D("Unknown pond provided for removal " WeakestLink)
            Return false
        }
        If (!returned) {
            Return false
        }
        this.Ponds.Search.WaitUntilActiveButtonS(3)
        this.Ponds.Search.ClickButtonActive()
        this.Ponds.NewPondRod.WaitUntilActiveButtonS(3)
        this.Ponds.NewPondRod.ClickButtonActive()
        this.Ponds.NewPondRod2.ClickButtonActive()
        this.Ponds.NewPondRod3.ClickButtonActive()
        Out.I("Pond upgrade complete")
        Return true
    }
    ;@endregion

    ;@region UpgradeRods()
    /**
     * Upgrade fishing rods to max available rotating between all of them
     */
    UpgradeRods() {
        Out.I("Upgrade Rods")
        Rod1 := Rod2 := Rod3 := Rod4 := Rod5 := Rod6 := Rod7 := false
        While (!this.Rods.IsOnTab()) {
            this.Tabs.Rods.ClickButtonActive(, 5)
        }
        While (this.Rods.Craft.IsButtonActive()) {
            this.Rods.Craft.ClickButtonActive()
        }
        If (!this.Rods.FirstRod.IsBackground() && !this.Rods.FirstRod.IsButton()) {
            Rod1 := true
        }
        If (!this.Rods.SecondRod.IsBackground() && !this.Rods.SecondRod.IsButton()) {
            Rod2 := true
        }
        If (!this.Rods.ThirdRod.IsBackground() && !this.Rods.ThirdRod.IsButton()) {
            Rod3 := true
        }
        If (!this.Rods.FourthRod.IsBackground() && !this.Rods.FourthRod.IsButton()) {
            Rod4 := true
        }
        If (!this.Rods.FifthRod.IsBackground() && !this.Rods.FifthRod.IsButton()) {
            Rod5 := true
        }
        If (!this.Rods.SixthRod.IsBackground() && !this.Rods.SixthRod.IsButton()) {
            Rod6 := true
        }
        If (!this.Rods.SeventhRod.IsBackground() && !this.Rods.SeventhRod.IsButton()) {
            Rod7 := true
        }
        Loop {
            Out.D(Rod1 " " Rod2 " " Rod3 " " Rod4 " " Rod5 " " Rod6 " " Rod7)
            If (Rod1 && !this.UpgradeSingleRod(1)) {
                Rod1 := false
            }
            If (Rod2 && !this.UpgradeSingleRod(2)) {
                Rod2 := false
            }
            If (Rod3 && !this.UpgradeSingleRod(3)) {
                Rod3 := false
            }
            If (Rod4 && !this.UpgradeSingleRod(4)) {
                Rod4 := false
            }
            If (Rod5 && !this.UpgradeSingleRod(5)) {
                Rod5 := false
            }
            If (Rod6 && !this.UpgradeSingleRod(6)) {
                Rod6 := false
            }
            If (Rod7 && !this.UpgradeSingleRod(7)) {
                Rod7 := false
            }
            If (!Rod1 && !Rod2 && !Rod3 && !Rod4 && !Rod5 && !Rod6 && !Rod7) {
                Break
            }
        }
    }
    ;@endregion

    ;@region UpgradeSingleRod()
    /**
     * Upgrade a single rod based on id
     */

    UpgradeSingleRod(id) {
        Out.D("Rod upgrade pass on " id)
        /** @type {cPoint} */
        RodButton := ""
        Switch id {
        Case 1:
            RodButton := this.Rods.FirstRod
        Case 2:
            RodButton := this.Rods.SecondRod
        Case 3:
            RodButton := this.Rods.ThirdRod
        Case 4:
            RodButton := this.Rods.FourthRod
        Case 5:
            RodButton := this.Rods.FifthRod
        Case 6:
            RodButton := this.Rods.SixthRod
        Case 7:
            RodButton := this.Rods.SeventhRod
        Default:
            RodButton := this.Rods.FirstRod
        }
        If (RodButton.IsBackground() || RodButton.IsButtonActive()) {
            Out.D("Exiting due to no rod on button " id)
            Return false
        }
        RodButton.ClickOffset(3, 3)
        Sleep(50)
        i := 0
        While (!this.IsRodSelectedForUpgrade() && i < 10) {
            RodButton.ClickOffset(3, 3)
            Sleep(50)
            i++
        }
        If (!this.IsRodSelectedForUpgrade()) {
            Out.D("Exiting due to rod not selected " id)
            Return false
        }
        If (!this.IsRodUpgradeAvailable()) {
            Out.D("Exiting due to no rod upgrades " id)
            Return false
        }
        this.Rods.Ascend.ClickButtonActive()
        this.Rods.Length.ClickButtonActive()
        this.Rods.Quality.ClickButtonActive()
        this.Rods.Ascend2.ClickButtonActive()
        this.Rods.Length2.ClickButtonActive()
        this.Rods.Quality2.ClickButtonActive()
        Return true
    }
    ;@endregion

    ;@region IsRodSelectedForUpgrade()
    /**
     * Description
     */
    IsRodSelectedForUpgrade() {
        If (this.Rods.Ascend.IsButton() || this.Rods.Length.IsButton() || this.Rods.Quality.IsButton() || this.Rods.Ascend2
        .IsButton() || this.Rods.Length2.IsButton() || this.Rods.Quality2.IsButton()) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsRodUpgradeAvailable()
    /**
     * Description
     */
    IsRodUpgradeAvailable() {
        If (this.Rods.Ascend.IsButtonActive() || this.Rods.Length.IsButtonActive() || this.Rods.Quality.IsButtonActive() ||
        this.Rods.Ascend2.IsButtonActive() || this.Rods.Length2.IsButtonActive() || this.Rods.Quality2.IsButtonActive()) {
            Return true
        }
        Return false
    }
    ;@endregion
}

/**
 * Pond class type to contain vars used in Fishing
 * @module Pond
 * @property {Type} property Desc
 * @method Name Desc
 */
Class Pond {
    /** @type {cPoint} Rarity point */
    Rarity := false
    /** @type {cPoint} */
    CastRod := ""
    /** @type {cPoint} */
    Bait := ""
    /** @type {cPoint} */
    BaitIcon := ""
    /** @type {cPoint} */
    Cancel := ""
    /** @type {cRect} */
    Progress := ""
    /** @type {cRect} */
    CooldownSuffix := ""
    /** @type {cPoint} */
    ConfirmCancel := cPoint(1395, 556)

    id := 0

    __New(id := 0) {
        Switch (id) {
        Case 1:
            this.Rarity := cPoint(305, 709)
            this.CastRod := cPoint(541, 667)
            this.Progress := cRect(400, 702, 500, 728)
            this.CooldownSuffix := cRect(464, 705, 500, 728)
            this.Cancel := cPoint(803, 485)
            this.Bait := cPoint(800, 681)
            this.BaitIcon := cPoint(826, 666)
        Case 2:
            this.Rarity := cPoint(914, 709)
            this.CastRod := cPoint(1157, 667)
            this.Progress := cRect(1005, 699, 1108, 728)
            this.CooldownSuffix := cRect(1073, 703, 1108, 728)
            this.Cancel := cPoint(1411, 486)
            this.Bait := cPoint(1407, 683)
            this.BaitIcon := cPoint(1433, 665)
        Case 3:
            this.Rarity := cPoint(305, 1007)
            this.CastRod := cPoint(542, 972)
            this.Progress := cRect(396, 1001, 500, 1031)
            this.CooldownSuffix := cRect(465, 1004, 500, 1031)
            this.Cancel := cPoint(803, 787)
            this.Bait := cPoint(799, 983)
            this.BaitIcon := cPoint(826, 964)
        Case 4:
            this.Rarity := cPoint(914, 1007)
            this.CastRod := cPoint(1150, 972)
            this.Progress := cRect(1001, 1002, 1106, 1030)
            this.CooldownSuffix := cRect(1071, 1006, 1106, 1030)
            this.Cancel := cPoint(1409, 786)
            this.Bait := cPoint(1407, 980)
            this.BaitIcon := cPoint(1434, 964)
        default:
        }
        this.id := id
    }

    ;@region GetPondRarity()
    /**
     * Get pond rarity
     */
    GetPondRarity() {
        Return this.PondColourToRarity(this.Rarity.GetColour())
    }
    ;@endregion

    ;@region PondColourToRarity()
    /**
     * Convert colour code of pond rarity to rarity id
     * -1 is background
     * 0 is failure to match
     */
    PondColourToRarity(colour) {
        Switch colour {
        Case "0xA0A0A0":
            Return 1
        Case "0x3B6CA0":
            Return 2
        Case "0x326DAB":
            Return 2
        Case "0xCDBA40":
            Return 3
        Case "0xD3C33F":
            Return 3
        Case "0xB3260A":
            Return 4
        Case "0x9D19B4":
            Return 5
        Case "0x9E10C1":
            Return 5
        Case "0xD9661E":
            Return 6
        Case "0xD9661F":
            Return 6
        Case "0xE1661A":
            Return 6
        Case "0x97714A":
            Return -1
        Default:
            Out.D("Pond " this.id " colour could not be matched " colour)
            Return 0
        }
    }
    ;@endregion

    ;@region GetBaitRarity()
    /**
     * Get the id of the rarity of the bait in use on the pond
     * -2 is no bait
     * -1 is background
     * 0 is failure to match
     */
    GetBaitRarity() {
        Switch this.Bait.GetColour() {
        Case "0xFFF1D2":
            If (this.BaitIcon.GetColour() != "0xFFF1D2") {
                Return 1
            } Else {
                Return -2
            }
        Case "0xFDD898":
            If (this.BaitIcon.GetColour() != "0xFDD898") {
                Return 1
            } Else {
                Return -2
            }
        Case "0x32678D":
            Return 2
        Case "0xD4BC8B":
            Return 2
        Case "0xD3B834":
            Return 3
        Case "0xF5CD79":
            Return 3
        Case "0xB32408":
            Return 4
        Case "0xEEAF70":
            Return 4
        Case "0x9E0F9F":
            Return 5
        Case "0xEAAB8E":
            Return 5
        Case "0xE16015":
            Return 6
        Case "0xF7BB73":
            Return 6
        Case "0x97714A":
            Return -1
        Default:
            Out.D("Pond " this.id " bait colour could not be matched " this.Bait.GetColour())
            Return 0
        }
    }
    ;@endregion

    ;@region FishPond()
    /**
     * Fish ponds a single time
     * @param Time Byref timestamp for seconds since last seen on cooldown
     */
    FishPond(&Time) {
        If (!this.Progress.pixelSearch()) {
            ; Was off cooldown and nothing catching
            this.CastRod.ClickButtonActive()
        }
        If (this.Progress.PixelSearch() && !this.CooldownSuffix.PixelSearch()) {
            ;Out.D("Resetting cd on" this.id)
            Time := A_TickCount
        }
        If (Time && (A_TickCount - Time) / 1000 > FishCatchingDelay) {
            ;Out.D("Casting " this.id)
            this.CastRod.ClickButtonActive()
        }
    }
    ;@endregion

    ;@region CancelPond()
    /**
     * Cancel the pond this object represents
     */
    CancelPond() {
        /*    Limiter := Timer()
            Limiter.CoolDownS(5, &bool)
             While (!this.Cancel.IsButtonActive() && Window.IsActive() && bool) {
                this.CastRod.ClickButtonActive()
                Sleep(50)
        } */
        If (this.Cancel.IsButtonActive()) {
            this.Cancel.ClickButtonActive()
            this.Cancel.ClickButtonActive()
            Out.I("Canceled pond " this.id)

            If (!this.ConfirmCancel.WaitUntilActiveButtonS(1)) {
                Out.I("No confirm cancel, assuming failed to cancel")
                Return false
            }
            this.ConfirmCancel.ClickButtonActive()
            this.ConfirmCancel.ClickButtonActive()
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region SetBait()
    /**
     * Set bait to rarity based on provided rarity
     */
    SetBait(id) {
        If (this.GetBaitRarity() = id) {
            Return true
        }
        If (id > 3) {
            Loop 7 {
                this.Bait.ClickOffsetR()
                If (this.GetBaitRarity() = id) {
                    Return true
                }
            }
        } Else {
            Loop 7 {
                this.Bait.ClickOffset()
                If (this.GetBaitRarity() = id) {
                    Return true
                }
            }
        }
        Return false
    }
    ;@endregion
}
