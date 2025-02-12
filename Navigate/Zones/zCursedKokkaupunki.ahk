#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * CursedKokkaupunki class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class CursedKokkaupunki extends Zone {
    ; The name of the zone for display purposes
    Name := "Cursed Kokkaupunki"
    ; The colour of the CursedKokkaupunki pixel for the zone
    ZoneColour := this.GetColourByName("Cursed Kokkaupunki")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        /** @type {cPoint} */
        Btn := cPoint(1863, 636)
        
        Travel.OpenAreasLeafGalaxy(extradelay)
        this.ScrollAmountDown(28, scrolldelay)
        Sleep(delay + extradelay)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(delay + extradelay)
        } Else {
            Out.I("Cursed Kokkaupunki not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }
}