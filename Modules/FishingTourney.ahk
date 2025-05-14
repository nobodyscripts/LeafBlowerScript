#Requires AutoHotkey v2.0
#Include ../Lib/cRects.ahk
#Include ../Lib/cPoints.ahk

Global FishTourneyNovice := true
Global FishTourneyIntermediate := true
Global FishTourneyExpert := false
Global FishTourneyLegend := false
Global FishTourneyNoviceAttack := 2
Global FishTourneyIntermediateAttack := 2
Global FishTourneyExpertAttack := 2
Global FishTourneyLegendAttack := 2

/**
 * FishingTourney tournament functions to seperate from the main fishing elements
 * @module FishingTourney
 * @property {Type} property Desc
 * @method Name Desc
 */
Class FishingTourney {
    Farm1 := FishTourneyNovice
    Farm2 := FishTourneyIntermediate
    Farm3 := FishTourneyExpert
    Farm4 := FishTourneyLegend

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

    ;@region Fight()
    /**
     * Main active loop from post 'start', till end
     */
    Fight(difficulty) {
        Switch (difficulty) {
        Case 1:
            UseAttack := FishTourneyNoviceAttack

        Case 2:
            UseAttack := FishTourneyIntermediateAttack

        Case 3:
            UseAttack := FishTourneyExpertAttack

        Case 4:
            UseAttack := FishTourneyLegendAttack

        default:
            UseAttack := 1
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
}
