#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * MountMoltenfury class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class MountMoltenfury extends Zone {
    ; The name of the zone for display purposes
    Name := "Mount Moltenfury"
    ; The colour of the MountMoltenfury pixel for the zone
    ZoneColour := this.GetColourByName("Mount Moltenfury")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreasFireFields(extradelay)
        Sleep(delay)

        /** @type {cPoint} */
        Local Btn := cPoint(1661, 574)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("Mount Moltenfury not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        Return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }

}
