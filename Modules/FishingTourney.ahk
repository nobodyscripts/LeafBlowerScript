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
        return this
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

    ;@region StartFight(id)
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
        tooltiptoggle := false
        While (Window.IsActive()) {
            If (this.Farm1 && this.IsFightReady(1)) {
                gToolTip.CenterDel()
                tooltiptoggle := false
                this.StartFight(1)
                this.Fight(1)
            }
            If (this.Farm2 && this.IsFightReady(2)) {
                gToolTip.CenterDel()
                tooltiptoggle := false
                this.StartFight(2)
                this.Fight(2)
            }
            If (this.Farm3 && this.IsFightReady(3)) {
                gToolTip.CenterDel()
                tooltiptoggle := false
                this.StartFight(3)
                this.Fight(3)
            }
            If (this.Farm4 && this.IsFightReady(4)) {
                gToolTip.CenterDel()
                tooltiptoggle := false
                this.StartFight(4)
                this.Fight(4)
            }
            If (!tooltiptoggle) {
                gToolTip.Center("Waiting on tourney cooldown")
                tooltiptoggle := true
            }
            Sleep(500)
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
