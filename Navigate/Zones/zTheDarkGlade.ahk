#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheDarkGlade class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheDarkGlade extends Zone {
    ; The name of the zone for display purposes
    Name := "The Dark Glade"
    ; The colour of the TheDarkGlade pixel for the zone
    ZoneColour := this.GetColourByName("The Dark Glade")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreas(true, extradelay)
        this.ScrollAmountDown(28, scrolldelay)
        Sleep(delay + extradelay)
        /** @type {cLBRButton} */
        Btn := cLBRButton(1686, 793)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Cursed Kokkaupunki not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
