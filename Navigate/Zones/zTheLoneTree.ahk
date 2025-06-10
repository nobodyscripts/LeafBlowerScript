#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheLoneTree class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheLoneTree extends Zone {
    ; The name of the zone for display purposes
    Name := "The Lone Tree"
    ; The colour of the TheLoneTree pixel for the zone
    ZoneColour := this.GetColourByName("The Lone Tree")
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
        Local Btn := cLBRButton(1856, 899)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("The Lone Tree not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
