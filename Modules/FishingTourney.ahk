#Requires AutoHotkey v2.0
#Include ..\Lib\cRects.ahk
#Include ..\Lib\cLBRButton.ahk
#Include ..\Lib\Misc.ahk
#Include ..\Lib\cColours.ahk
#include ..\ScriptLib\cToolTip.ahk

; TODO Travel and opening review
; TODO Detect boosted options

S.AddSetting("FishTourney", "FishTourCatchingDelay", 8, "int")
S.AddSetting("FishTourney", "FishTourCatchingSearch", true, "bool")
S.AddSetting("FishTourney", "FishTourEnableShopUpgrade", true, "bool")
S.AddSetting("FishTourney", "FishTourEnableUpgradeRods", true, "bool")
S.AddSetting("FishTourney", "FishTourEnableFishingPass", true, "bool")
S.AddSetting("FishTourney", "FishTourEnableUpgradeTourneyRods", true, "bool")
S.AddSetting("FishTourney", "FishTourEnableTransmute", true, "bool")
S.AddSetting("FishTourney", "FishTourEnableJourneyCollect", true, "bool")
S.AddSetting("FishTourney", "FishTourTimerShopUpgrade", 60, "int")
S.AddSetting("FishTourney", "FishTourTimerUpgradeRods", 60, "int")
S.AddSetting("FishTourney", "FishTourTimerUpgradeTourneyRods", 60, "int")
S.AddSetting("FishTourney", "FishTourTimerTransmute", 60, "int")
S.AddSetting("FishTourney", "FishTourTimerJourneyCollect", 60, "int")
S.AddSetting("FishTourney", "FishTourTransmuteTtoFC", true, "bool")
S.AddSetting("FishTourney", "FishTourTransmuteFCtoCry", false, "bool")
S.AddSetting("FishTourney", "FishTourTransmuteCrytoA", false, "bool")
S.AddSetting("FishTourney", "FishTourTransmuteFCtoA", false, "bool")
S.AddSetting("FishTourney", "FishTourTransmuteFCtoT", false, "bool")
S.AddSetting("FishTourney", "FishTourTransmuteCrytoFC", true, "bool")
S.AddSetting("FishTourney", "FishTourTransmuteAtoCry", true, "bool")
S.AddSetting("FishTourney", "FishTourTransmuteAtoFC", true, "bool")
S.AddSetting("FishTourney", "FishTourNovice", true, "bool")
S.AddSetting("FishTourney", "FishTourNoviceAttack", 1, "int")
S.AddSetting("FishTourney", "FishTourIntermediate", false, "bool")
S.AddSetting("FishTourney", "FishTourIntermediateAttack", 1, "int")
S.AddSetting("FishTourney", "FishTourExpert", false, "bool")
S.AddSetting("FishTourney", "FishTourExpertAttack", 1, "int")
S.AddSetting("FishTourney", "FishTourLegend", false, "bool")
S.AddSetting("FishTourney", "FishTourLegendAttack", 1, "int")

/**
 * FishingTourney tournament functions to seperate from the main fishing elements
 * @module FishingTourney
 * @property {Type} property Desc
 * @method Name Desc
 */
Class FishingTourney {
    Farm1 := S.Get("FishTourNovice")
    Farm2 := S.Get("FishTourIntermediate")
    Farm3 := S.Get("FishTourExpert")
    Farm4 := S.Get("FishTourLegend")
    Mode := 1

    /** @type {cLBRButton} */
    Attack1 := cLBRButton(537, 531)
    /** @type {cLBRButton} */
    Attack2 := cLBRButton(935, 528)
    /** @type {cLBRButton} */
    Attack3 := cLBRButton(1335, 530)

    /** @type {cLBRButton} */
    Special1 := cLBRButton(537, 790)
    /** @type {cLBRButton} */
    Special2 := cLBRButton(935, 790)
    /** @type {cLBRButton} */
    Special3 := cLBRButton(1335, 790)

    /** @type {cLBRButton} */
    Collect := cLBRButton(528, 658)

    ; No autowin
    /** @type {cLBRButton} */
    Start1 := cLBRButton(2061, 315)
    /** @type {cLBRButton} */
    Start2 := cLBRButton(2061, 541)
    /** @type {cLBRButton} */
    Start3 := cLBRButton(2061, 759)
    /** @type {cLBRButton} */
    Start4 := cLBRButton(2061, 984)

    ; Newest pos
    /** @type {cLBRButton} */
    AWStart1 := cLBRButton(2061, 315)
    /** @type {cLBRButton} */
    AWStart2 := cLBRButton(2061, 561)
    /** @type {cLBRButton} */
    AWStart3 := cLBRButton(2061, 807)
    /** @type {cLBRButton} */
    AWStart4 := cLBRButton(2061, 1051)

    SetModeFishing() {
        this.Mode := 0
        this.Farm1 := S.Get("FishNovice")
        this.Farm2 := S.Get("FishIntermediate")
        this.Farm3 := S.Get("FishExpert")
        this.Farm4 := S.Get("FishLegend")
        Return this
    }

    SetModeTourney() {
        this.Mode := 1
        this.Farm1 := S.Get("FishTourNovice")
        this.Farm2 := S.Get("FishTourIntermediate")
        this.Farm3 := S.Get("FishTourExpert")
        this.Farm4 := S.Get("FishTourLegend")
    }

    IsOnTab() {
        /* Out.D("Is on select fight " (this.Start1.IsButton() || this.Start2.IsButton() ||
        this.Start3.IsButton() || this.Start4.IsButton()))
        Out.D("Is on attack tourney view " (this.Attack1.IsButton() && this.Attack2.IsButton() && this.Attack3.IsButton()))
        Out.D("Collect button detection? " BinToStr(this.Collect.IsButtonActive()))
        */
        If ((this.Start1.IsButton())
        ||
        (this.Attack1.IsButton() && this.Attack2.IsButton() && this.Attack3.IsButton())
        ||
        (this.Collect.IsButtonActive()) && !FishingPonds().isontab()) {
            ;Out.D("Is on tourney tab true")
            Return true
        }
        ;Out.D("Is on tourney tab false")
        Return false
    }

    GetTourneyState() {
        Out.D("Is on tourney tab, collect button detection? " BinToStr(this.Collect.IsButtonActive()))

        If (this.Start1.IsButton()) {
            /** Rect to find buttons in tourney tab as they shift a lot
             * @type {cRect}
             */
            ButtonSearch := cRect(2061, 278, 2061, 1070)
            arr := ButtonSearch.LineGetColourInstances()
            i := 1
            For id, value IN arr {
                If (value.colour == c.Active || value.colour == c.Inactive) {
                    Switch (i) {
                    Case 1:
                        ; First one doesn't move so not needed, also detects
                        ; on cancel tourney button
                        ;this.Start1.Set(value.x, value.y+5)
                    Case 2:
                        Out.D("Setting start 2: " value.x " " value.y)
                        this.Start2.Set(value.x, value.y + 5, false)
                    Case 3:
                        Out.D("Setting start 3: " value.x " " value.y)
                        this.Start3.Set(value.x, value.y + 5, false)
                    Case 4:
                        Out.D("Setting start 4: " value.x " " value.y)
                        this.Start4.Set(value.x, value.y + 5, false)
                    default:
                        Break
                    }
                    i++
                }
            }
            Return 1
        } Else If (this.Attack1.IsButton() && this.Attack2.IsButton() && this.Attack3.IsButton()) {
            Return 2
        } Else If (this.Collect.IsButtonActive()) {
            Return 3
        }
        Return false
    }

    ;@region Fight()
    /**
     * Main active loop from post 'start', till end
     */
    Fight(difficulty) {
        timeout := A_Now
        If (this.Mode) {
            Switch (difficulty) {
            Case 1:
                UseAttack := S.Get("FishTourNoviceAttack")

            Case 2:
                UseAttack := S.Get("FishTourIntermediateAttack")

            Case 3:
                UseAttack := S.Get("FishTourExpertAttack")

            Case 4:
                UseAttack := S.Get("FishTourLegendAttack")

            default:
                UseAttack := 1
            }
        } Else {
            Switch (difficulty) {
            Case 1:
                UseAttack := S.Get("FishNoviceAttack")

            Case 2:
                UseAttack := S.Get("FishIntermediateAttack")

            Case 3:
                UseAttack := S.Get("FishExpertAttack")

            Case 4:
                UseAttack := S.Get("FishLegendAttack")

            default:
                UseAttack := 1
            }
        }
        Switch (UseAttack) {
        Case 1:
            While (Window.IsActive() && !this.Collect.IsButtonActive() && DateDiff(A_now, timeout, "S") < 30) {
                this.Attack1.WaitUntilActiveButton()
                this.Attack1.ClickButtonActive(2, 2)
            }
        Case 2:
            While (Window.IsActive() && !this.Collect.IsButtonActive() && DateDiff(A_now, timeout, "S") < 30) {
                this.Attack2.WaitUntilActiveButton()
                this.Attack2.ClickButtonActive(2, 2)
            }
        Case 3:
            While (Window.IsActive() && !this.Collect.IsButtonActive() && DateDiff(A_now, timeout, "S") < 30) {
                this.Attack3.WaitUntilActiveButton()
                this.Attack3.ClickButtonActive(2, 2)
            }
        default:
            While (Window.IsActive() && !this.Collect.IsButtonActive() && DateDiff(A_now, timeout, "S") < 30) {
                this.Attack1.WaitUntilActiveButton()
                this.Attack1.ClickButtonActive(2, 2)
            }
        }

        While (Window.IsActive() && !this.Start1.IsButton() && DateDiff(A_now, timeout, "S") < 30) {
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
        ; TODO Add await after starting for fight buttons
        timeout := A_Now
        Switch (id) {
        Case 1:
            While (Window.IsActive() && !this.Attack1.IsButtonActive() && DateDiff(A_now, timeout, "S") < 2) {
                this.Start1.WaitUntilActiveButton()
                If (!this.Start1.IsButtonActive()) {
                    Return false
                }
                Return this.Start1.ClickButtonActive(2, 2)
            }
        Case 2:
            While (Window.IsActive() && !this.Attack1.IsButtonActive() && DateDiff(A_now, timeout, "S") < 2) {
                this.Start2.WaitUntilActiveButton()
                If (!this.Start2.IsButtonActive()) {
                    Return false
                }
                Return this.Start2.ClickButtonActive(2, 2)
            }
        Case 3:
            While (Window.IsActive() && !this.Attack1.IsButtonActive() && DateDiff(A_now, timeout, "S") < 2) {
                this.Start3.WaitUntilActiveButton()
                If (!this.Start3.IsButtonActive()) {
                    Return false
                }
                Return this.Start3.ClickButtonActive(2, 2)
            }
        Case 4:
            While (Window.IsActive() && !this.Attack1.IsButtonActive() && DateDiff(A_now, timeout, "S") < 2) {
                this.Start4.WaitUntilActiveButton()
                If (!this.Start4.IsButtonActive()) {
                    Return false
                }
                Return this.Start4.ClickButtonActive(2, 2)
            }
        default:

        }
        Return false
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
        UlcWindow()
        /** @type {Fishing} */
        cFishing := Fishing()
        FishCatchingDelay := S.Get("FishCatchingDelay")
        FishTourTimerJourneyCollect := S.Get("FishTourTimerJourneyCollect")
        FishTourTimerTransmute := S.Get("FishTourTimerTransmute")
        FishTourEnableUpgradeRods := S.Get("FishTourEnableUpgradeRods")
        FishTourTimerUpgradeRods := S.Get("FishTourTimerUpgradeRods")
        FishTourEnableShopUpgrade := S.Get("FishTourEnableShopUpgrade")
        FishTourTimerShopUpgrade := S.Get("FishTourTimerShopUpgrade")
        FishTourEnableUpgradeTourneyRods := S.Get("FishTourEnableUpgradeTourneyRods")
        FishTourTimerUpgradeTourneyRods := S.Get("FishTourTimerUpgradeTourneyRods")
        FishTourEnableFishingPass := S.Get("FishTourEnableFishingPass")
        FishTourCatchingSearch := S.Get("FishTourCatchingSearch")
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
                Out.D("Reset to Tourney tab")
            }
            ; TODO Merge single with looped farm
            ; If not in screen to select a new fight either finish the fight, or collect
            Switch (this.GetTourneyState()) {
            Case 1:
                Out.D("Start tourney view looped")
            Case 2:
                Out.I("Found in progress fight, clearing with attack 1")
                this.Fight(1)
            Case 3:
                timeout := A_Now
                While (Window.IsActive() && !this.Start1.IsButton() && DateDiff(A_now, timeout, "S") < 5) {
                    this.Collect.WaitUntilActiveButton()
                    this.Collect.ClickButtonActive(2, 2)
                }
            default:
            }

            If (this.Farm1 && this.IsFightReady(1)) {
                gToolTip.CenterDel()
                If (this.StartFight(1)) {
                    this.Fight(1)
                } Else {
                    Out.V("Could not start Novice tourney")
                }
            }
            If (this.Farm2 && this.IsFightReady(2)) {
                gToolTip.CenterDel()
                If (this.StartFight(2)) {
                    this.Fight(2)
                } Else {
                    Out.V("Could not start Intermediate tourney")
                }
            }
            If (this.Farm3 && this.IsFightReady(3)) {
                gToolTip.CenterDel()
                If (this.StartFight(3)) {
                    this.Fight(3)
                } Else {
                    Out.V("Could not start Expert tourney")
                }
            }
            If (this.Farm4 && this.IsFightReady(4)) {
                gToolTip.CenterDel()
                If (this.StartFight(4)) {
                    this.Fight(4)
                } Else {
                    Out.V("Could not start Legend tourney")
                }
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
            ; If not in screen to select a new fight either finish the fight, or collect
            Switch (this.GetTourneyState()) {
            Case 1:
                Out.D("Start tourney view")
            Case 2:
                Out.I("Found in progress fight, clearing with attack 1")
                this.Fight(1)
            Case 3:
                timeout := A_Now
                While (Window.IsActive() && !this.Start1.IsButton() && DateDiff(A_now, timeout, "S") < 5) {
                    this.Collect.WaitUntilActiveButton()
                    this.Collect.ClickButtonActive(2, 2)
                }
            default:
            }
            If (this.Farm1 && this.IsFightReady(1)) {
                If (this.StartFight(1)) {
                    this.Fight(1)
                } Else {
                    Out.V("Could not start Novice tourney")
                }
            }
            If (this.Farm2 && this.IsFightReady(2)) {
                If (this.StartFight(2)) {
                    this.Fight(2)
                } Else {
                    Out.V("Could not start Intermediate tourney")
                }
            }
            If (this.Farm3 && this.IsFightReady(3)) {
                If (this.StartFight(3)) {
                    this.Fight(3)
                } Else {
                    Out.V("Could not start Expert tourney")
                }
            }
            If (this.Farm4 && this.IsFightReady(4)) {
                If (this.StartFight(4)) {
                    this.Fight(4)
                } Else {
                    Out.V("Could not start Legend tourney")
                }
            }
        }
    }
    ;@endregion
}
