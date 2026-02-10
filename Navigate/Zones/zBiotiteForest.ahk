#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * BiotiteForest class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class BiotiteForest extends Zone {
    ; The name of the zone for display purposes
    Name := "Biotite Forest"
    ; The colour of the BiotiteForest pixel for the zone
    ZoneColour := this.GetColourByName("Biotite Forest")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreasSacredNebula(extradelay)
        Sleep(delay)

        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1860, 311)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Biotite Forest not found while trying to travel.")
        }
    }

}
