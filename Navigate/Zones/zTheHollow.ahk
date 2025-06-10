#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheHollow class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheHollow extends Zone {
    ; The name of the zone for display purposes
    Name := "The Hollow"
    ; The colour of the TheHollow pixel for the zone
    ZoneColour := this.GetColourByName("The Hollow")
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

        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1858, 668)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            If (Btn.IsButtonInactive()) {
                Out.I("Button inactive travaling to The Hollow.")
            } Else {
                Out.I("The Hollow not found while trying to travel.")
            }
        }
        Sleep(delay + extradelay)
        Return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
