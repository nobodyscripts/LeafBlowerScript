#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * PlanckScope class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class PlanckScope extends Zone {
    ; The name of the zone for display purposes
    Name := "Planck Scope"
    ; The colour of the PlanckScope pixel for the zone
    ZoneColour := this.GetColourByName("Planck Scope")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreasQuark(extradelay)
        Sleep(delay)

        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1861, 974)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Planck Scope not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        Return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
