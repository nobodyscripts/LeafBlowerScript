#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * TheCursedPyramid class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheCursedPyramid extends Zone {
    ; The name of the zone for display purposes
    Name := "The Cursed Pyramid"
    ; The colour of the TheCursedPyramid pixel for the zone
    ZoneColour := this.GetColourByName("The Cursed Pyramid")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreasLeafGalaxy(extradelay)
        this.ScrollAmountDown(21, scrolldelay)
        Sleep(delay + extradelay)

        /** @type {cPoint} */
        Local Btn := cPoint(1668, 781)
        Btn.WaitUntilActiveButtonS(3)
        Btn.ClickButtonActive(, , delay + extradelay)
        If (!Btn.IsButtonActive()) {
            Out.I("The Cursed Pyramid not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }

}
