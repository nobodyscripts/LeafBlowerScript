#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * AnteLeafton class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class AnteLeafton extends Zone {
    ; The name of the zone for display purposes
    Name := "Ante Leafton"
    ; The colour of the AnteLeafton pixel for the zone
    ZoneColour := this.GetColourByName("Ante Leafton")
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
        this.ScrollAmountDown(7)
        Sleep(delay)

        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1853, 729)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Ante Leafton not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        Return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
