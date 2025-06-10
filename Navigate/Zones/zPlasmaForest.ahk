#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * PlasmaForest class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class PlasmaForest extends Zone {
    ; The name of the zone for display purposes
    Name := "Plasma Forest"
    ; The colour of the PlasmaForest pixel for the zone
    ZoneColour := this.GetColourByName("Plasma Forest")
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

        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1860, 443)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Spark Range not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        Return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
