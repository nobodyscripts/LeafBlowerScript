#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TerrorGraveyard class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TerrorGraveyard extends Zone {
    ; The name of the zone for display purposes
    Name := "Terror Graveyard"
    ; The colour of the TerrorGraveyard pixel for the zone
    ZoneColour := this.GetColourByName("Terror Graveyard")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreasEnergyBelt(extradelay)
        Sleep(delay)
        Travel.ScrollAmountDown(7)
        Sleep(delay)
        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1863, 771) ; Prev 754
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Terror Graveyard not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        Return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
