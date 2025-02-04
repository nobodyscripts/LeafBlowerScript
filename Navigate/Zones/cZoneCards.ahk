#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * Cards class for zone travel
 * @memberof module:cTravel
 */
Class cZoneCards extends Zone {
    ; The name of the zone for display purposes
    Name := "FullName"

    ;@region Cards main travel
    ;TODO continue setting up new style of _gotoarea funcs
    /**
     * Go to Cards panel can return on any tab
     * @param {Boolean} [reset=false] Click first tab after travel?
     * @returns {Boolean} Is panel active
     */
    GoToPacks() {
        Return this._GoToArea(attempt, check, "Cards Packs Tab")

        attempt(delay, scrolldelay := 0, extradelay := 0) {
            Travel.OpenCards(false)
            PacksBtn := Points.Card.Tab.Packs
            If (PacksBtn.IsButtonActive()) {
                PacksBtn.Click()
                Sleep(NavigateTime)
            }
        }
        check(name) {
            Return this.IsOnPacks()
        }
    }
    ;@endregion

    IsOnPacks() {
        If (Points.Card.OddsButton.IsButtonActive()) {
            Return true
        }
        Return false
    }

    GoToTranscend() {
        If (this.GoTo() && Points.Cards.Transcend.IsButtonActive()) {
            Points.Card.Tab.Transcend.Click()
            Sleep(NavigateTime)
        }
    }

    GoToCommon() {
        If (this.GoTo() && Points.Cards.Common.IsButtonActive()) {
            Points.Card.Tab.Common.Click()
            Sleep(NavigateTime)
        }
    }

    GoToUncommon() {
        If (this.GoTo() && Points.Cards.Uncommon.IsButtonActive()) {
            Points.Card.Tab.Uncommon.Click()
            Sleep(NavigateTime)
        }
    }

    GoToRare() {
        If (this.GoTo() && Points.Cards.Rare.IsButtonActive()) {
            Points.Card.Tab.Rare.Click()
            Sleep(NavigateTime)
        }
    }

    GoToEpic() {
        If (this.GoTo() && Points.Cards.Epic.IsButtonActive()) {
            Points.Card.Tab.Epic.Click()
            Sleep(NavigateTime)
        }
    }

    GoToMythical() {
        If (this.GoTo() && Points.Cards.Mythical.IsButtonActive()) {
            Points.Card.Tab.Mythical.Click()
            Sleep(NavigateTime)
        }
    }

    GoToLegendary() {
        If (this.GoTo() && Points.Cards.Legendary.IsButtonActive()) {
            Points.Card.Tab.Legendary.Click()
            Sleep(NavigateTime)
        }
    }

    GoToOptions() {
        If (this.GoTo() && Points.Cards.Options.IsButtonActive()) {
            Points.Card.Tab.Options.Click()
            Sleep(NavigateTime)
        }
    }
}
