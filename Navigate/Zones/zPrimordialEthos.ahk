#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * PrimordialEthos class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class PrimordialEthos extends Zone {
    ; The name of the zone for display purposes
    Name := "Primordial Ethos"
    ; The colour of the PrimordialEthos pixel for the zone
    ZoneColour := this.GetColourByName("Primordial Ethos")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreasSoulRealm(extradelay)
        Sleep(delay)
        this.ScrollAmountDown(7, scrolldelay)
        Sleep(delay)

        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1858, 840)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Primordial Ethos not found while trying to travel.")
        }
    }
}
