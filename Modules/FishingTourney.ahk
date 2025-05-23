#Requires AutoHotkey v2.0
#Include ../Lib/cRects.ahk
#Include ../Lib/cPoints.ahk

Global FishNovice := false
Global FishIntermediate := false
Global FishExpert := false
Global FishLegend := false
Global FishNoviceAttack := 1
Global FishIntermediateAttack := 1
Global FishExpertAttack := 1
Global FishLegendAttack := 1

Global FishTourNovice := false
Global FishTourIntermediate := false
Global FishTourExpert := false
Global FishTourLegend := false
Global FishTourNoviceAttack := 1
Global FishTourIntermediateAttack := 1
Global FishTourExpertAttack := 1
Global FishTourLegendAttack := 1

/**
 * FishingTourney tournament functions to seperate from the main fishing elements
 * @module FishingTourney
 * @property {Type} property Desc
 * @method Name Desc
 */
Class FishingTourney {
    Farm1 := FishTourNovice
    Farm2 := FishTourIntermediate
    Farm3 := FishTourExpert
    Farm4 := FishTourLegend
    Mode := 1

    /** @type {cPoint} */
    Attack1 := cPoint(537, 531)
    /** @type {cPoint} */
    Attack2 := cPoint(935, 528)
    /** @type {cPoint} */
    Attack3 := cPoint(1335, 530)

    /** @type {cPoint} */
    Special1 := cPoint(537, 790)
    /** @type {cPoint} */
    Special2 := cPoint(935, 790)
    /** @type {cPoint} */
    Special3 := cPoint(1335, 790)

    /** @type {cPoint} */
    Collect := cPoint(528, 658)

    /** @type {cPoint} */
    Start1 := cPoint(2061, 315)
    /** @type {cPoint} */
    Start2 := cPoint(2061, 541)
    /** @type {cPoint} */
    Start3 := cPoint(2061, 759)
    /** @type {cPoint} */
    Start4 := cPoint(2061, 984)

    SetModeFishing() {
        this.Mode := 0
        this.Farm1 := FishNovice
        this.Farm2 := FishIntermediate
        this.Farm3 := FishExpert
        this.Farm4 := FishLegend
        Return this
    }
    SetModeTourney() {
        this.Mode := 1
        this.Farm1 := FishTourNovice
        this.Farm2 := FishTourIntermediate
        this.Farm3 := FishTourExpert
        this.Farm4 := FishTourLegend
    }

    IsOnTab() {
        If (this.Start1.IsButton() || this.Start2.IsButton() || this.Start3.IsButton() || this.Start4.IsButton() ||
        this.Attack1.IsButton()) {
            Return true
        }
        Return false
    }

    ;@region Fight()
    /**
     * Main active loop from post 'start', till end
     */
    Fight(difficulty) {
        If (this.Mode) {
            Switch (difficulty) {
            Case 1:
                UseAttack := FishTourNoviceAttack

            Case 2:
                UseAttack := FishTourIntermediateAttack

            Case 3:
                UseAttack := FishTourExpertAttack

            Case 4:
                UseAttack := FishTourLegendAttack

            default:
                UseAttack := 1
            }
        } Else {
            Switch (difficulty) {
            Case 1:
                UseAttack := FishNoviceAttack

            Case 2:
                UseAttack := FishIntermediateAttack

            Case 3:
                UseAttack := FishExpertAttack

            Case 4:
                UseAttack := FishLegendAttack

            default:
                UseAttack := 1
            }
        }
        Switch (UseAttack) {
        Case 1:
            While (Window.IsActive() && !this.Collect.IsButtonActive()) {
                this.Attack1.WaitUntilActiveButton()
                this.Attack1.ClickButtonActive(2, 2)
            }
        Case 2:
            While (Window.IsActive() && !this.Collect.IsButtonActive()) {
                this.Attack2.WaitUntilActiveButton()
                this.Attack2.ClickButtonActive(2, 2)
            }
        Case 3:
            While (Window.IsActive() && !this.Collect.IsButtonActive()) {
                this.Attack3.WaitUntilActiveButton()
                this.Attack3.ClickButtonActive(2, 2)
            }
        default:
            While (Window.IsActive() && !this.Collect.IsButtonActive()) {
                this.Attack1.WaitUntilActiveButton()
                this.Attack1.ClickButtonActive(2, 2)
            }
        }

        While (Window.IsActive() && !this.Start1.IsButton()) {
            this.Collect.WaitUntilActiveButton()
            this.Collect.ClickButtonActive(2, 2)
        }
    }
    ;@endregion

    ;@region StartFight(id)
    /**
     * Start different tourneys based on id
     */
    StartFight(id) {
        Switch (id) {
        Case 1:
            While (Window.IsActive() && !this.Attack1.IsButtonActive()) {
                this.Start1.WaitUntilActiveButton()
                this.Start1.ClickButtonActive(2, 2)
            }
        Case 2:
            While (Window.IsActive() && !this.Attack1.IsButtonActive()) {
                this.Start2.WaitUntilActiveButton()
                this.Start2.ClickButtonActive(2, 2)
            }
        Case 3:
            While (Window.IsActive() && !this.Attack1.IsButtonActive()) {
                this.Start3.WaitUntilActiveButton()
                this.Start3.ClickButtonActive(2, 2)
            }
        Case 4:
            While (Window.IsActive() && !this.Attack1.IsButtonActive()) {
                this.Start4.WaitUntilActiveButton()
                this.Start4.ClickButtonActive(2, 2)
            }
        default:
        }

    }
    ;@endregion

    ;@region IsFightReady(id)
    /**
     * Start different tourneys based on id
     */
    IsFightReady(id) {
        Switch (id) {
        Case 1:
            Return this.Start1.IsButtonActive()
        Case 2:
            Return this.Start2.IsButtonActive()
        Case 3:
            Return this.Start3.IsButtonActive()
        Case 4:
            Return this.Start4.IsButtonActive()
        default:
        }

    }
    ;@endregion

    ;@region Farm()
    /**
     * Start a looped farming of the available tourneys
     */
    Farm() {
        /* FishTourCatchingDelay := values.FishTourCatchingDelay
           FishTourCatchingSearch := values.FishTourCatchingSearch
           FishTourEnableShopUpgrade := values.FishTourEnableShopUpgrade
           FishTourEnableUpgradeRods := values.FishTourEnableUpgradeRods
           FishTourEnableFishingPass := values.FishTourEnableFishingPass
           FishTourEnableUpgradeTourneyRods := values.FishTourEnableUpgradeTourneyRods
           FishTourEnableTransmute := values.FishTourEnableTransmute
           FishTourEnableJourneyCollect := values.FishTourEnableJourneyCollect
           FishTourTimerShopUpgrade := values.FishTourTimerShopUpgrade
           FishTourTimerUpgradeRods := values.FishTourTimerUpgradeRods
           FishTourTimerUpgradeTourneyRods := values.FishTourTimerUpgradeTourneyRods
           FishTourTimerTransmute := values.FishTourTimerTransmute
           FishTourTimerJourneyCollect := values.FishTourTimerJourneyCollect
           FishTourTransmuteTtoFC := values.FishTourTransmuteTtoFC
           FishTourTransmuteFCtoCry := values.FishTourTransmuteFCtoCry
           FishTourTransmuteCrytoA := values.FishTourTransmuteCrytoA
           FishTourTransmuteFCtoT := values.FishTourTransmuteFCtoT
           FishTourTransmuteCrytoFC := values.FishTourTransmuteCrytoFC
           FishTourTransmuteAtoCry := values.FishTourTransmuteAtoCry
           FishTourNovice := values.FishTourNovice
           FishTourIntermediate := values.FishTourIntermediate
           FishTourExpert := values.FishTourExpert
           FishTourLegend := values.FishTourLegend
           FishTourNoviceAttack := values.FishTourNoviceAttack
           FishTourIntermediateAttack := values.FishTourIntermediateAttack
           FishTourExpertAttack := values.FishTourExpertAttack
        FishTourLegendAttack := values.FishTourLegendAttack */
        /** @type {Fishing} */
        cFishing := Fishing()
        StartTime := A_TickCount - (FishCatchingDelay * 1000)
        Time1 := StartTime
        Time2 := StartTime
        Time3 := StartTime
        Time4 := StartTime
        Out.I("Started Tourney Farm")
        JourneyTime := A_Now
        TransmuteTime := A_Now
        RodsTime := A_Now
        ShopTime := A_Now
        TourneyRodTime := A_Now
        LogToggle := true
        While (Window.IsActive()) {
            While (!this.IsOnTab()) {
                cFishing.Tabs.Tourney.ClickButtonActive()
            }
            If (this.Farm1 && this.IsFightReady(1)) {
                gToolTip.CenterDel()
                this.StartFight(1)
                this.Fight(1)
            }
            If (this.Farm2 && this.IsFightReady(2)) {
                gToolTip.CenterDel()
                this.StartFight(2)
                this.Fight(2)
            }
            If (this.Farm3 && this.IsFightReady(3)) {
                gToolTip.CenterDel()
                this.StartFight(3)
                this.Fight(3)
            }
            If (this.Farm4 && this.IsFightReady(4)) {
                gToolTip.CenterDel()
                this.StartFight(4)
                this.Fight(4)
            }
            If (!(this.Farm1 && this.IsFightReady(1)) &&
            !(this.Farm2 && this.IsFightReady(2)) &&
            !(this.Farm3 && this.IsFightReady(3)) &&
            !(this.Farm4 && this.IsFightReady(4))) {
                gToolTip.Center("Waiting on tourney cooldown")
                If (FishTourTimerJourneyCollect &&
                    DateDiff(A_Now, JourneyTime, "S") > FishTourTimerJourneyCollect) {
                    cFishing.JourneyCollect()
                    JourneyTime := A_Now
                    LogToggle := true
                }
                If (FishTourTimerTransmute &&
                    DateDiff(A_Now, TransmuteTime, "S") > FishTourTimerTransmute) {
                    cFishing.UserTourSelectedTransmute()
                    TransmuteTime := A_Now
                    LogToggle := true
                }
                If (FishTourEnableUpgradeRods &&
                    DateDiff(A_Now, RodsTime, "S") > FishTourTimerUpgradeRods) {
                    cFishing.UpgradeRods()
                    RodsTime := A_Now
                    LogToggle := true
                }
                If (FishTourEnableShopUpgrade &&
                    DateDiff(A_Now, ShopTime, "S") > FishTourTimerShopUpgrade) {
                    cFishing.ShopUpgrade()
                    ShopTime := A_Now
                    LogToggle := true
                }
                If (FishTourEnableUpgradeTourneyRods &&
                    DateDiff(A_Now, TourneyRodTime, "S") > FishTourTimerUpgradeTourneyRods) {
                    cFishing.TourneyRodUpgrade()
                    TourneyRodTime := A_Now
                    LogToggle := true
                }

                If (FishTourEnableFishingPass) {
                    While (!cFishing.Ponds.IsOnTab()) {
                        cFishing.Tabs.Pond.ClickButtonActive(, 5)
                    }
                    If (LogToggle) {
                        Out.I("Fishing pass")
                        LogToggle := false
                    }
                    If (FishTourCatchingSearch) {
                        If (cFishing.Ponds.Search.IsButtonActive()) {
                            ; Search if the buttons active because a slot is empty
                            cFishing.Ponds.Search.ClickButtonActive()
                            Out.I("Pond searched")
                        }
                        cFishing.PondQualityUpgrade()
                    }
                    cFishing.FishPonds(&Time1, &Time2, &Time3, &Time4, true)
                }
            }
            Sleep(17)
        }
        Reload()
    }
    ;@endregion

    ;@region FarmSingle()
    /**
     * Start a single pass farm of the available tourneys
     */
    FarmSingle() {
        tooltiptoggle := false
        If (Window.IsActive() && this.IsOnTab()) {
            If (this.Farm1 && this.IsFightReady(1)) {
                this.StartFight(1)
                this.Fight(1)
            }
            If (this.Farm2 && this.IsFightReady(2)) {
                this.StartFight(2)
                this.Fight(2)
            }
            If (this.Farm3 && this.IsFightReady(3)) {
                this.StartFight(3)
                this.Fight(3)
            }
            If (this.Farm4 && this.IsFightReady(4)) {
                this.StartFight(4)
                this.Fight(4)
            }
        }
    }
    ;@endregion
}
