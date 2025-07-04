#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheInnerCursedPyramid class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheInnerCursedPyramid extends Zone {
    ; The name of the zone for display purposes
    Name := "The Inner Cursed Pyramid"
    ; The colour of the TheInnerCursedPyramid pixel for the zone
    ZoneColour := this.GetColourByName("The Inner Cursed Pyramid")
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
        Sleep(delay)
        ;Travel.ScrollResetToTop()
        this.ScrollAmountDown(21, scrolldelay)
        Sleep(delay + extradelay)
        If (!cLBRButton(1663, 936).IsButton()) {
            /** @type {cLBRButton} */
            Local Btn := cLBRButton(1865, 942)
        } Else {
            /** @type {cLBRButton} */
            Local Btn := cLBRButton(1663, 936)
        }
        If (Btn.IsButtonActive()) {
            Btn.ClickButtonActive(, , delay + extradelay)
        } Else {
            If (Btn.IsButtonInactive()) {
                Out.I("Button inactive when trying to travel.")
            } Else {
                Out.I("The Inner Cursed Pyramid not found while trying to travel. "
                    Btn.ColourIdent(Btn.GetColour()))
            }
        }
        Sleep(delay + extradelay)
        Return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }
}
