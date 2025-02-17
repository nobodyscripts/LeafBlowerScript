#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * SoulCrypt class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class SoulCrypt extends Zone {
    ; The name of the zone for display purposes
    Name := "Soul Crypt"
    ; The colour of the SoulCrypt pixel for the zone
    ZoneColour := this.GetColourByName("Soul Crypt")
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

        /** @type {cPoint} */
        Local Btn := cPoint(1861, 466)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Soul Crypt not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        Return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
