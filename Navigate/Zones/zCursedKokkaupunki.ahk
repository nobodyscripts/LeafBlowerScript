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
        Travel.OpenAreas(true, extradelay)
        ;Points.Areas.LeafG.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local CursedKokkaupunkiLeaf := this.FindCursedKokkaupunkiZone()
        If (CursedKokkaupunkiLeaf) {
            this.ClickTravelButton(CursedKokkaupunkiLeaf, delay + extradelay)
        } Else {
            Out.I("Cursed Kokkaupunki leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindCursedKokkaupunkiZone() {
        ; Change this if used
        ;return Rects.LeafG.CursedKokkaupunkiTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Cursed Kokkaupunki
        ;Button := Points.Areas.LeafG.CursedKokkaupunki
        Button := cPoint()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, NavigateTime + delay)) {
            Out.I("Cursed Kokkaupunki travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}