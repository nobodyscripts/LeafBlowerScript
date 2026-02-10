#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * VilewoodCemetery class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class VilewoodCemetery extends Zone {
    ; The name of the zone for display purposes
    Name := "Vilewood Cemetery"
    ; The colour of the VilewoodCemetery pixel for the zone
    ZoneColour := this.GetColourByName("Vilewood Cemetery")
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
        Sleep(delay + extradelay)
        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1855, 752)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Vilewood Cemetery not found while trying to travel.")
        }
    }
}
