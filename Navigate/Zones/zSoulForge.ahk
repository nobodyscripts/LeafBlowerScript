#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * SoulForge class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class SoulForge extends Zone {
    ; The name of the zone for display purposes
    Name := "Soul Forge"
    ; The colour of the SoulForge pixel for the zone
    ZoneColour := this.GetColourByName("Soul Forge")
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
        Local Btn := cLBRButton(1858, 865)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Soul Forge not found while trying to travel.")
        }
    }
}
