#Requires AutoHotkey v2.0

#Include ..\Lib\Logging.ahk
#Include ..\Lib\cZone.ahk
#Include ..\Lib\cTravel.ahk
#Include ..\Lib\cPoint.ahk

/**
 * Dice class for zone travel
 * @memberof module:cTravel
 */
Class sDice extends Zone {
    ; The name of the zone for display purposes
    Name := "FullName"

    ;@region Dice main travel
    ;TODO continue setting up new style of _gotoarea funcs
    /**
     * Go to Dice panel can return on any tab
     * @returns {Boolean} Is panel active
     */
    GoTo() {
        Return this._GoToArea(attempt, check, "Dice Bag Tab")

        attempt(delay, scrolldelay := 0, extradelay := 0) {
            Shops.OpenDice(false)
        }
        check(name) {
            Return this.IsOnDiceBag()
        }
    }
    ;@endregion

    ;@region Dice main travel
    ;TODO continue setting up new style of _gotoarea funcs
    /**
     * Go to Dice panel can return on any tab
     * @returns {Boolean} Is panel active
     */
    GoToDiceBag() {
        Return this._GoToArea(attempt, check, "Dice Bag Tab")

        attempt(delay, scrolldelay := 0, extradelay := 0) {
            Shops.OpenDice(false)
            DiceBagBtn := Points.Dice.Tab.DiceBag
            If (DiceBagBtn.IsButtonActive()) {
                DiceBagBtn.Click()
                Sleep(NavigateTime)
            }
        }
        check(name) {
            Return this.IsOnDiceBag()
        }
    }
    ;@endregion

    IsOnDiceBag() {
        If (Points.Dice.OddsButton.IsButtonActive()) {
            Return true
        }
        Return false
    }

    GoToOptions() {
        If (this.GoTo() && Points.Dice.Options.IsButtonActive()) {
            Points.Dice.Tab.Options.Click()
            Sleep(NavigateTime)
        }
    }
}
