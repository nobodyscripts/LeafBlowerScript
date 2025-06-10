#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheCheesePub class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheCheesePub extends Zone {
    ; The name of the zone for display purposes
    Name := "The Cheese Pub"
    ; The colour of the TheCheesePub pixel for the zone
    ZoneColour := this.GetColourByName("The Cheese Pub")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreasLeafGalaxy(extradelay)
        Sleep(50)
        AmountToModifier(25)
        Sleep(50)
        this.ScrollAmountDown(1, scrolldelay)
        Sleep(50)
        ResetModifierKeys()
        Sleep(delay + extradelay)

        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1663, 722)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("The Cheese Pub leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
