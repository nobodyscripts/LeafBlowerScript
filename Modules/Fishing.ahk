#Requires AutoHotkey v2.0
#Include ../Lib/cRects.ahk
#Include ..\Lib\cLBRButton.ahk

; TODO Add travel to fishing zone
; TODO Fix pond search if no rod applied at start
; TODO Fix rod application to pond if all rods are in use
; TODO Detect cast/reel with more careful checks
; TODO Detect % progress
; TODO Check shop and tourney for changes that cause issues (autowin/new items/tourney cancel)

S.AddSetting("Fishing", "FishCatchingDelay", 8, "int")
S.AddSetting("Fishing", "FishCatchingSearch", true, "bool")
S.AddSetting("Fishing", "FishEnableShopUpgrade", true, "bool")
S.AddSetting("Fishing", "FishEnableUpgradeRods", true, "bool")
S.AddSetting("Fishing", "FishEnableTourneyPass", true, "bool")
S.AddSetting("Fishing", "FishEnableUpgradeTourneyRods", true, "bool")
S.AddSetting("Fishing", "FishEnableTransmute", true, "bool")
S.AddSetting("Fishing", "FishEnableJourneyCollect", true, "bool")
S.AddSetting("Fishing", "FishTimerShopUpgrade", 60, "int")
S.AddSetting("Fishing", "FishTimerUpgradeRods", 60, "int")
S.AddSetting("Fishing", "FishTimerTourneyPass", 60, "int")
S.AddSetting("Fishing", "FishTimerUpgradeTourneyRods", 60, "int")
S.AddSetting("Fishing", "FishTimerTransmute", 60, "int")
S.AddSetting("Fishing", "FishTimerJourneyCollect", 60, "int")
S.AddSetting("Fishing", "FishTransmuteTtoFC", false, "bool")
S.AddSetting("Fishing", "FishTransmuteFCtoCry", false, "bool")
S.AddSetting("Fishing", "FishTransmuteCrytoA", false, "bool")
S.AddSetting("Fishing", "FishTransmuteFCtoA", false, "bool")
S.AddSetting("Fishing", "FishTransmuteFCtoT", false, "bool")
S.AddSetting("Fishing", "FishTransmuteCrytoFC", false, "bool")
S.AddSetting("Fishing", "FishTransmuteAtoCry", false, "bool")
S.AddSetting("Fishing", "FishTransmuteAtoFC", false, "bool")
S.AddSetting("Fishing", "FishNovice", false, "bool")
S.AddSetting("Fishing", "FishIntermediate", false, "bool")
S.AddSetting("Fishing", "FishExpert", false, "bool")
S.AddSetting("Fishing", "FishLegend", false, "bool")
S.AddSetting("Fishing", "FishNoviceAttack", 1, "int")
S.AddSetting("Fishing", "FishIntermediateAttack", 1, "int")
S.AddSetting("Fishing", "FishExpertAttack", 1, "int")
S.AddSetting("Fishing", "FishLegendAttack", 1, "int")

;@region Points
;@region FishingTabs
/**
 * Points class to contain points of the tabs in fishing screen
 * @module FishingTabs
 */
Class FishingTabs {
    /** @type {cLBRButton} Pond (main fishing) tab button */
    Pond := cLBRButton(287, 1168)
    /** @type {cLBRButton} Shop tab button */
    Shop := cLBRButton(1440, 1165),
    /** @type {cLBRButton} Rods tab button */
    Rods := cLBRButton(660, 1164),
    /** @type {cLBRButton} Journey tab button */
    Journey := cLBRButton(1635, 1164),
    /** @type {cLBRButton} Transmute tab button */
    Transmute := cLBRButton(2231, 1164),
    /** @type {cLBRButton} Tourney Tab */
    Tourney := cLBRButton(1835, 1166),
    /** @type {cLBRButton} Tourney Rod tab */
    TourneyRod := cLBRButton(1856, 1163)
}
;@endregion

;@region FishingPonds
/**
 * Points class to contain points of the ponds screen
 * @module FishingPonds
 */
Class FishingPonds {
    /** @type {cLBRButton} Lure button top left corner */
    Lure := cLBRButton(858, 314)
    /** @type {cLBRButton} Cancel pond confirm button */
    ConfirmCancel := cLBRButton(1395, 556)
    /** @type {cLBRButton} Search button top left corner */
    Search := cLBRButton(524, 313)

    IsOnTab() {
        If (this.Lure.IsButton() && this.Search.IsButton()) {
            Return true
        }
        Return false
    }
}
;@endregion

;@region FishingRods
/**
 * Points class to contain points of the Fishing rods screen
 * @module FishingRods
 */
Class FishingRods {
    /** @type {cLBRButton} First rod icon point +65 x per */
    FirstRod := cLBRButton(350, 555)
    /** @type {cLBRButton} Second rod icon point */
    SecondRod := cLBRButton(415, 555)
    /** @type {cLBRButton} Third rod icon point */
    ThirdRod := cLBRButton(480, 555)
    /** @type {cLBRButton} Fourth rod icon point */
    FourthRod := cLBRButton(545, 555)
    /** @type {cLBRButton} Fifth rod icon point */
    FifthRod := cLBRButton(610, 555)
    /** @type {cLBRButton} Sixth rod icon point */
    SixthRod := cLBRButton(675, 555)
    /** @type {cLBRButton} Seventh rod icon point */
    SeventhRod := cLBRButton(740, 555)

    /** @type {cLBRButton} Rod crafting button */
    Craft := cLBRButton(617, 314)
    /** @type {cLBRButton} Rod fish length upgrade */
    Length := cLBRButton(1449, 602)
    /** @type {cLBRButton} Rod quality upgrade */
    Quality := cLBRButton(1450, 732)
    /** @type {cLBRButton} Rod tier ascend upgrade */
    Ascend := cLBRButton(1450, 863)
    /** @type {cLBRButton} Rod fish length upgrade */
    Length2 := cLBRButton(1448, 615)
    /** @type {cLBRButton} Rod quality upgrade */
    Quality2 := cLBRButton(1448, 745)
    /** @type {cLBRButton} Rod tier ascend upgrade */
    Ascend2 := cLBRButton(1447, 874)

    IsOnTab() {
        ;Out.D(this.FirstRod.ColourToUserString() " " this.Craft.ColourToUserString())
        If (!this.FirstRod.IsBackground() && this.Craft.IsButton()) {
            Return true
        }
        Return false
    }
}
;@endregion

;@region FishingShop
/**
 * Points class to contain points of the shop in fishing screen
 * @module FishingShop
 * @property {cLBRButton} BuySpot Buy fishing spot button
 */
Class FishingShop {
    /** First rod icon for checks if on tab
     * @type {cLBRButton} */
    RodIcon := cLBRButton(332, 315)
    /** Second rod icon for checks if on tab
     * @type {cLBRButton} */
    RodIcon2 := cLBRButton(340, 449)

    /** 1 Auto fish purchase button
     * @type {cLBRButton} */
    Auto := cLBRButton(1571, 292)
    /** 2 Auto fish threshold purchase button
     * @type {cLBRButton} */
    AutoThreshold := cLBRButton(1570, 434)
    /** 3 Auto fish speed max purchase button
     * @type {cLBRButton} */
    FasterAuto := cLBRButton(1730, 578)
    /** 4 Buy fishing spot max button
     * @type {cLBRButton} */
    BuySpot := cLBRButton(1730, 718)
    /** 5 Buy minimum line max button
     * @type {cLBRButton} */
    MinLine := cLBRButton(1730, 860)
    /** 6 Buy maximum line max button
     * @type {cLBRButton} */
    MaxLine := cLBRButton(1730, 1001)

    /** 7 Rod recharge duration max button, shift wheel down one
     * @type {cLBRButton} */
    RodRecharge := cLBRButton(1730, 657)
    /** 8 Fishing credit amount max button, shift wheel down one
     * @type {cLBRButton} */
    CreditsUpgrade := cLBRButton(1730, 815)
    /** 9 Fishing rod amount max button, shift wheel down one
     * @type {cLBRButton} */
    MaxRods := cLBRButton(1731, 940)

    /** 10 Fishing rarity max button, shift wheel down two
     * @type {cLBRButton} */
    Rarity := cLBRButton(1729, 595)
    /** 11 Fishing spots rarity max button, shift wheel down two
     * @type {cLBRButton} */
    SpotRarity := cLBRButton(1729, 739)
    /** 12 Tide crystal chance max button, shift wheel down two
     * @type {cLBRButton} */
    CrystalChance := cLBRButton(1728, 880)

    /** 13 Fish bait unlock button, shift wheel down three
     * @type {cLBRButton} */
    BaitUnlock := cLBRButton(1570, 536)
    /** 14 */
    /** 15 */
    /** 16 */

    /** 17 Tourney unlock button, shift wheel down four
     * @type {cLBRButton} */
    TourneyUnlock := cLBRButton(1570, 900)

    IsOnTab() {
        If (!this.RodIcon.IsButton() && !this.RodIcon.IsBackground() &&
        !this.RodIcon2.IsButton() && !this.RodIcon2.IsBackground()) {
            Return true
        }
        Return false
    }
}
;@endregion

;@region FishingJourney
/**
 * Points class to contain points of the fishing journey screen
 * @module FishingJourney
 */
Class FishingJourney {
    /** Journey claim all button
     * @type {cLBRButton} */
    ClaimAll := cLBRButton(548, 601)
    /** Collect reset bonus
     * @type {cLBRButton} */
    Complete := cLBRButton(1243, 836)

    IsOnTab() {
        If (this.ClaimAll.IsButton()) {
            Return true
        }
        Return false
    }
}
;@endregion

;@region FishingTourneyRod
/**
 * Points class to contain points of the fishing tourney rod upgrade screen
 * @module FishingTourneyRod
 */
Class FishingTourneyRod {
    /** @type {cLBRButton} Upgrade rod tip */
    Tip := cLBRButton(2025, 289)
    /** @type {cLBRButton} Upgrade rod handle */
    Handle := cLBRButton(2025, 421)
    /** @type {cLBRButton} Upgrade rod shaft */
    Shaft := cLBRButton(2025, 553)

    IsOnTab() {
        If (this.Tip.IsButton() && (this.Handle.IsButton() || this.Handle.IsBackground()) || (this.Shaft.IsButton() &&
        this.Shaft.IsBackground())) {
            Return true
        }
        Return false
    }
}
;@endregion

;@region FishingTransmute
/**
 * Points class to contain points of the fishing transmute screen
 * @module FishingTransmute
 */
Class FishingTransmute {
    /** @type {cLBRButton} Max Transmute Trash to Fish Credits */
    TrashToCreditsMax := cLBRButton(719, 288)
    /** @type {cLBRButton} Max Transmute Fish Credits to Tide Crystal */
    CreditsToCrystalMax := cLBRButton(719, 416)
    /** @type {cLBRButton} Max Transmute Tide Crystal to Advanced Tide Crystal  */
    CrystalToAdvancedMax := cLBRButton(723, 545)
    /** @type {cLBRButton} Max Transmute Fish Credits to Advanced Tide Crystal */
    CreditsToAdvancedMax := cLBRButton(719, 676)

    /** @type {cLBRButton} Max Transmute Fish Credits to Trash */
    CreditsToTrashMax := cLBRButton(1759, 289)
    /** @type {cLBRButton} Max Transmute Tide Crystal to Fish Credits */
    CrystalToCreditsMax := cLBRButton(1761, 418)
    /** @type {cLBRButton} Max Transmute Advanced Tide Crystal to Tide Crystal */
    AdvancedToCrystalMax := cLBRButton(1759, 542)
    /** @type {cLBRButton} Max Transmute Advanced Tide Crystal to Fish Credits */
    AdvancedToCreditsMax := cLBRButton(1759, 676)

    IsOnTab() {
        If (this.TrashToCreditsMax.IsButton() && this.CreditsToCrystalMax.IsButton() && this.CreditsToTrashMax.IsButton()) {
            Return true
        }
        Return false
    }
}
;@endregion
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
    fFishAutoCatch() {
        FishCatchingDelay := S.Get("FishCatchingDelay")
        FishCatchingSearch := S.Get("FishCatchingSearch")
        FishTimerJourneyCollect := S.Get("FishTimerJourneyCollect")
        FishTimerTransmute := S.Get("FishTimerTransmute")
        FishEnableUpgradeRods := S.Get("FishEnableUpgradeRods")
        FishTimerUpgradeRods := S.Get("FishTimerUpgradeRods")
        FishEnableShopUpgrade := S.Get("FishEnableShopUpgrade")
        FishTimerShopUpgrade := S.Get("FishTimerShopUpgrade")
        FishEnableUpgradeTourneyRods := S.Get("FishEnableUpgradeTourneyRods")
        FishTimerUpgradeTourneyRods := S.Get("FishTimerUpgradeTourneyRods")
        FishEnableTourneyPass := S.Get("FishEnableTourneyPass")
        FishTimerTourneyPass := S.Get("FishTimerTourneyPass")

        Window.StartOrReload()

        StartTime := A_TickCount - (FishCatchingDelay * 1000)
        Time1 := StartTime
        Time2 := StartTime
        Time3 := StartTime
        Time4 := StartTime
        If (FishCatchingSearch) {
            Out.I("Started fishing with search")
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
            If (FishCatchingSearch) {
                If (this.Ponds.Search.IsButtonActive()) {
                    ; Search if the buttons active because a slot is empty
                    this.Ponds.Search.ClickButtonActive()
                    Out.I("Pond searched")
                }
                this.PondQualityUpgrade()
            }
            this.EnsureAllPondsHaveRods()
            this.FishPonds(&Time1, &Time2, &Time3, &Time4)
            If (FishTimerJourneyCollect &&
                DateDiff(A_Now, JourneyTime, "S") > FishTimerJourneyCollect) {
                this.JourneyCollect()
                JourneyTime := A_Now
                LogToggle := true
            }
            If (FishTimerTransmute &&
                DateDiff(A_Now, TransmuteTime, "S") > FishTimerTransmute) {
                this.UserSelectedTransmute()
                TransmuteTime := A_Now
                LogToggle := true
            }
            If (FishEnableUpgradeRods &&
                DateDiff(A_Now, RodsTime, "S") > FishTimerUpgradeRods) {
                this.UpgradeRods()
                RodsTime := A_Now
                LogToggle := true
            }
            If (FishEnableShopUpgrade &&
                DateDiff(A_Now, ShopTime, "S") > FishTimerShopUpgrade) {
                this.ShopUpgrade()
                ShopTime := A_Now
                LogToggle := true
            }
            If (FishEnableUpgradeTourneyRods &&
                DateDiff(A_Now, TourneyRodTime, "S") > FishTimerUpgradeTourneyRods) {
                this.TourneyRodUpgrade()
                TourneyRodTime := A_Now
                LogToggle := true
            }
            If (FishEnableTourneyPass &&
                DateDiff(A_Now, TourneyTime, "S") > FishTimerTourneyPass) {
                this.TourneySinglePass()
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
        If (this.Journey.ClaimAll.IsButton()) {
            this.Journey.ClaimAll.WaitUntilButtonS(1)
            this.Journey.ClaimAll.ClickButtonActive()
            this.Journey.ClaimAll.ClickButtonActive()
        }
        If (this.Journey.Complete.IsButtonActive()) {
            this.Journey.Complete.ClickButtonActive()
            this.Journey.Complete.ClickButtonActive()
        }
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
        FishTransmuteTtoFC := S.Get("FishTransmuteTtoFC")
        FishTransmuteFCtoCry := S.Get("FishTransmuteFCtoCry")
        FishTransmuteCrytoA := S.Get("FishTransmuteCrytoA")
        FishTransmuteFCtoA := S.Get("FishTransmuteFCtoA")
        FishTransmuteFCtoT := S.Get("FishTransmuteFCtoT")
        FishTransmuteCrytoFC := S.Get("FishTransmuteCrytoFC")
        FishTransmuteAtoCry := S.Get("FishTransmuteAtoCry")
        FishTransmuteAtoFC := S.Get("FishTransmuteAtoFC")
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
        If (FishTransmuteFCtoA) {
            this.Transmute.CreditsToAdvancedMax.ClickButtonActive()
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
        If (FishTransmuteAtoFC) {
            this.Transmute.AdvancedToCreditsMax.ClickButtonActive()
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
        FishChlTransmuteTtoFC := S.Get("FishChlTransmuteTtoFC")
        FishChlTransmuteFCtoCry := S.Get("FishChlTransmuteFCtoCry")
        FishChlTransmuteCrytoA := S.Get("FishChlTransmuteCrytoA")
        FishChlTransmuteFCtoA := S.Get("FishChlTransmuteFCtoA")
        FishChlTransmuteFCtoT := S.Get("FishChlTransmuteFCtoT")
        FishChlTransmuteCrytoFC := S.Get("FishChlTransmuteCrytoFC")
        FishChlTransmuteAtoCry := S.Get("FishChlTransmuteAtoCry")
        FishChlTransmuteAtoFC := S.Get("FishChlTransmuteAtoFC")
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
        If (FishChlTransmuteFCtoA) {
            this.Transmute.CreditsToAdvancedMax.ClickButtonActive()
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
        If (FishChlTransmuteAtoFC) {
            this.Transmute.AdvancedToCreditsMax.ClickButtonActive()
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
        FishTourTransmuteTtoFC := S.Get("FishTourTransmuteTtoFC")
        FishTourTransmuteFCtoCry := S.Get("FishTourTransmuteFCtoCry")
        FishTourTransmuteCrytoA := S.Get("FishTourTransmuteCrytoA")
        FishTourTransmuteFCtoA := S.Get("FishTourTransmuteFCtoA")
        FishTourTransmuteFCtoT := S.Get("FishTourTransmuteFCtoT")
        FishTourTransmuteCrytoFC := S.Get("FishTourTransmuteCrytoFC")
        FishTourTransmuteAtoCry := S.Get("FishTourTransmuteAtoCry")
        FishTourTransmuteAtoFC := S.Get("FishTourTransmuteAtoFC")
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
        If (FishTourTransmuteFCtoA) {
            this.Transmute.CreditsToAdvancedMax.ClickButtonActive()
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
        If (FishTourTransmuteAtoFC) {
            this.Transmute.AdvancedToCreditsMax.ClickButtonActive()
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
            NewPond := this.Shop.BuySpot.ClickButtonActive()
            Travel.ScrollAmountDown(7)
            this.Shop.CreditsUpgrade.ClickButtonActive()
            this.Shop.MaxRods.ClickButtonActive()
            Travel.ScrollAmountDown(21)
            this.Shop.TourneyUnlock.ClickButtonActive()
            ; Low importance items
            Travel.ScrollResetToTop()
            this.Shop.BuySpot.ClickButtonActive()
            this.Shop.MinLine.ClickButtonActive()
            this.Shop.MaxLine.ClickButtonActive()
            this.Shop.Auto.ClickButtonActive()
            this.Shop.AutoThreshold.ClickButtonActive()
            this.Shop.FasterAuto.ClickButtonActive()

            Travel.ScrollAmountDown(7)
            this.Shop.RodRecharge.ClickButtonActive()
            Return NewPond
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
        Out.D("Detected: Shaft " this.TourneyRod.Shaft.ColourToUserString() ", Handle " this.TourneyRod.Handle.ColourToUserString() ", Tip " this
        .TourneyRod.Tip.ColourToUserString())
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
    FishPonds(&Time1, &Time2, &Time3, &Time4, isTourney := false, isChallenge := false) {
        FishCatchingDelay := S.Get("FishCatchingDelay")
        FishChlCatchingDelay := S.Get("FishChlCatchingDelay")
        FishTourCatchingDelay := S.Get("FishTourCatchingDelay")
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
        Sleep(17)
        If (isTourney) {
            If (this.Ponds.Lure.IsButtonActive() && (A_TickCount - Time1) / 1000 < FishTourCatchingDelay) {
                this.Ponds.Lure.ClickButtonActive()
            }
        } Else If (isChallenge) {
            If (this.Ponds.Lure.IsButtonActive() && (A_TickCount - Time1) / 1000 < FishChlCatchingDelay) {
                this.Ponds.Lure.ClickButtonActive()
            }
        } Else {
            If (this.Ponds.Lure.IsButtonActive() && (A_TickCount - Time1) / 1000 < FishCatchingDelay) {
                this.Ponds.Lure.ClickButtonActive()
            }
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
            Out.E("Pond rarity upgrade failed to get a pond to upgrade")
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
            Out.E("Unknown pond provided for removal " WeakestLink)
            Return false
        }
        If (!returned) {
            Return false
        }
        this.Ponds.Search.WaitUntilActiveButtonS(3)
        this.Ponds.Search.ClickButtonActive()
        Switch (this.PondCount()) {
        Case 1:
            this.Pond1.Rod1.WaitUntilActiveButtonS(3)
            this.Pond1.Rod1.ClickButtonActive()
            this.Pond1.BaitIcon.ClickButtonActive()
        Case 2:
            this.Pond2.Rod1.WaitUntilActiveButtonS(3)
            this.Pond2.Rod1.ClickButtonActive()
            this.Pond2.BaitIcon.ClickButtonActive()
        Case 3:
            this.Pond3.Rod1.WaitUntilActiveButtonS(3)
            this.Pond3.Rod1.ClickButtonActive()
            this.Pond3.BaitIcon.ClickButtonActive()
        Case 4:
            this.Pond4.Rod1.WaitUntilActiveButtonS(3)
            this.Pond4.Rod1.ClickButtonActive()
            this.Pond4.Rod2.ClickButtonActive()
            this.Pond4.Rod3.ClickButtonActive()
            this.Pond4.BaitIcon.ClickButtonActive()

        default:
        }
        Out.I("Pond upgrade complete")
        Return true
    }
    ;@endregion

    ;@region AddNewPond()
    /**
     * Description
     */
    AddNewPond() {
        While (this.Ponds.Search.IsButtonActive()) {
            this.Ponds.Search.ClickButtonActive()
        }
        Switch (this.PondCount()) {
        Case 2:
            this.Pond2.Rod1.ClickButtonActive()
            this.Pond2.BaitIcon.ClickButtonActive()
        Case 3:
            this.Pond3.Rod1.ClickButtonActive()
            this.Pond3.BaitIcon.ClickButtonActive()
        Case 4:
            this.Pond4.Rod1.ClickButtonActive()
            this.Pond4.BaitIcon.ClickButtonActive()
        default:
        }
        Out.I("Pond Added")
        Return
    }
    ;@endregion

    ;@region PondCount()
    PondCount() {
        count := 1
        If (!this.Pond2.CastRod.IsBackground()) {
            count++
        }
        If (!this.Pond3.CastRod.IsBackground()) {
            count++
        }
        If (!this.Pond4.CastRod.IsBackground()) {
            count++
        }
        Return count
    }
    ;@endregion

    ;@region UpgradeRods()
    /**
     * Upgrade fishing rods to max available rotating between all of them
     */
    UpgradeRods(TotalPonds := 1, TotalRods := 1, Challenge := false) {
        Out.I("Upgrade Rods")
        Rod1 := Rod2 := Rod3 := Rod4 := Rod5 := Rod6 := Rod7 := false
        While (!this.Rods.IsOnTab()) {
            this.Tabs.Rods.ClickButtonActive(, 5)
        }
        count := 0
        While (Challenge && TotalRods < TotalPonds && this.Rods.Craft.IsButtonActive()) {
            this.Rods.Craft.ClickButtonActive()
            count++
        }
        While (!Challenge && this.Rods.Craft.IsButtonActive()) {
            this.Rods.Craft.ClickButtonActive()
            count++
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
            ; Out.D(Rod1 " " Rod2 " " Rod3 " " Rod4 " " Rod5 " " Rod6 " " Rod7)
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
        Return count
    }
    ;@endregion

    ;@region UpgradeSingleRod()
    /**
     * Upgrade a single rod based on id
     */

    UpgradeSingleRod(id) {
        Out.I("Rod upgrade pass on " id)
        /** @type {cLBRButton} */
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
            ;Out.D("No rod on button " id)
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
            ;Out.D("Rod not selected " id)
            Return false
        }
        If (!this.IsRodUpgradeAvailable()) {
            ;Out.D("No rod upgrades " id)
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

    ;@region ActiveRodCount()
    /**
     * Description
     */
    ActiveRodCount() {
        count := 0
        If (!this.Pond1.Rod1.IsButton() && !this.Pond1.Rod1.IsBackground() && !this.Pond1.Rod1.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond1.Rod2.IsButton() && !this.Pond1.Rod2.IsBackground() && !this.Pond1.Rod2.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond1.Rod3.IsButton() && !this.Pond1.Rod3.IsBackground() && !this.Pond1.Rod3.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond2.Rod1.IsButton() && !this.Pond2.Rod1.IsBackground() && !this.Pond2.Rod1.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond2.Rod2.IsButton() && !this.Pond2.Rod2.IsBackground() && !this.Pond2.Rod2.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond2.Rod3.IsButton() && !this.Pond2.Rod3.IsBackground() && !this.Pond2.Rod3.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond3.Rod1.IsButton() && !this.Pond3.Rod1.IsBackground() && !this.Pond3.Rod1.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond3.Rod2.IsButton() && !this.Pond3.Rod2.IsBackground() && !this.Pond3.Rod2.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond3.Rod3.IsButton() && !this.Pond3.Rod3.IsBackground() && !this.Pond3.Rod3.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond4.Rod1.IsButton() && !this.Pond4.Rod1.IsBackground() && !this.Pond4.Rod1.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond4.Rod2.IsButton() && !this.Pond4.Rod2.IsBackground() && !this.Pond4.Rod2.IsColour("0x8A6743")) {
            count++
        }
        If (!this.Pond4.Rod3.IsButton() && !this.Pond4.Rod3.IsBackground() && !this.Pond4.Rod3.IsColour("0x8A6743")) {
            count++
        }
        Return count
    }
    ;@endregion

    ;@region EnsureAllPondsHaveRods()
    /**
     * 
     */
    EnsureAllPondsHaveRods() {
        If (this.Pond1.Rod1.IsButtonActive()) {
            this.Pond1.Rod1.ClickButtonActive()
        }
        If (this.Pond2.Rod1.IsButtonActive()) {
            this.Pond2.Rod1.ClickButtonActive()
        }
        If (this.Pond3.Rod1.IsButtonActive()) {
            this.Pond3.Rod1.ClickButtonActive()
        }
        If (this.Pond4.Rod1.IsButtonActive()) {
            this.Pond4.Rod1.ClickButtonActive()
        }
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
    /** Rarity left bar point
     *  @type {cLBRButton} */
    Rarity := false
    /** Cast/Reel button location
     * @type {cLBRButton} */
    CastRod := ""
    /** Bait button to check rarity
     * @type {cLBRButton} */
    Bait := ""
    /** Bait button icon to check rarity
     * @type {cLBRButton} */
    BaitIcon := ""
    /** Cancel pond to delete it
     * @type {cLBRButton} */
    Cancel := ""
    /** Progress % text check location entire area
     * @type {cRect} */
    Progress := ""
    /** Progress check area
     * @type {cRect} */
    CooldownSuffix := ""
    /** Confirmation for canceling a pond
     * @type {cLBRButton} */
    ConfirmCancel := cLBRButton(1395, 556)
    /** First rod for this pond
     * @type {cLBRButton} */
    Rod1 := ""
    /** Second rod for this pond
     * @type {cLBRButton} */
    Rod2 := ""
    /** Third rod for this pond
     * @type {cLBRButton} */
    Rod3 := ""

    id := 0

    __New(id := 0) {
        Switch (id) {
        Case 1:
            this.Rarity := cLBRButton(305, 709)
            this.CastRod := cLBRButton(541, 677)
            this.Progress := cRect(400, 717, 500, 740)
            this.CooldownSuffix := cRect(464, 717, 500, 740)
            this.Cancel := cLBRButton(803, 495)
            this.Bait := cLBRButton(800, 681)
            this.BaitIcon := cLBRButton(826, 666)
            this.Rod1 := cLBRButton(359, 590)
            this.Rod2 := cLBRButton(442, 590)
            this.Rod3 := cLBRButton(520, 590)
        Case 2:
            this.Rarity := cLBRButton(914, 709)
            this.CastRod := cLBRButton(946, 674) ; Shifted to avoid tooltip in tourney mode
            this.Progress := cRect(1005, 717, 1108, 740)
            this.CooldownSuffix := cRect(1073, 717, 1108, 740)
            this.Cancel := cLBRButton(1411, 495)
            this.Bait := cLBRButton(1407, 681)
            this.BaitIcon := cLBRButton(1433, 666)
            this.Rod1 := cLBRButton(968, 590)
            this.Rod2 := cLBRButton(1047, 590)
            this.Rod3 := cLBRButton(1128, 590)
        Case 3:
            this.Rarity := cLBRButton(305, 1007)
            this.CastRod := cLBRButton(542, 972)
            this.Progress := cRect(396, 1001, 500, 1031)
            this.CooldownSuffix := cRect(465, 1004, 500, 1031)
            this.Cancel := cLBRButton(803, 787)
            this.Bait := cLBRButton(799, 983)
            this.BaitIcon := cLBRButton(826, 964)
            this.Rod1 := cLBRButton(360, 889)
            this.Rod2 := cLBRButton(440, 889)
            this.Rod3 := cLBRButton(521, 889)
        Case 4:
            this.Rarity := cLBRButton(914, 1007)
            this.CastRod := cLBRButton(1150, 972)
            this.Progress := cRect(1001, 1002, 1106, 1030)
            this.CooldownSuffix := cRect(1071, 1006, 1106, 1030)
            this.Cancel := cLBRButton(1409, 786)
            this.Bait := cLBRButton(1407, 980)
            this.BaitIcon := cLBRButton(1434, 964)
            this.Rod1 := cLBRButton(967, 890)
            this.Rod2 := cLBRButton(1048, 890)
            this.Rod3 := cLBRButton(1128, 890)
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
            Out.E("Pond " this.id " colour could not be matched " colour)
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
            Out.E("Pond " this.id " bait colour could not be matched " this.Bait.GetColour())
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
        FishCatchingDelay := S.Get("FishCatchingDelay")
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
            If (!this.ConfirmCancel.WaitUntilActiveButtonS(2)) {
                Out.I("No confirm cancel, assuming failed to cancel")
                Return false
            }
            While (window.IsActive() && this.ConfirmCancel.IsButtonActive()) {
                this.ConfirmCancel.ClickButtonActive()
            }
            Out.I("Canceled pond " this.id)
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
