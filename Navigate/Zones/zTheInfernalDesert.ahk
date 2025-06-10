#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheInfernalDesert class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheInfernalDesert extends Zone {
    ; The name of the zone for display purposes
    Name := "The Infernal Desert"
    ; The colour of the sample pixel for the zone
    ZoneColour := this.GetColourByName("The Infernal Desert")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreas(true, extradelay)
        this.ScrollAmountDown(21, scrolldelay)
        Sleep(delay + extradelay)
        /** @type {cLBRButton} */
        Local Btn := cLBRButton(1677, 652)
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            Out.I("The Infernal Desert not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
