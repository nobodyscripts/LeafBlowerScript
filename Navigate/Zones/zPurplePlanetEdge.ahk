#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * PurplePlanetEdge class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class PurplePlanetEdge extends Zone {
    ; The name of the zone for display purposes
    Name := "Purple Planet Edge"
    ; The colour of the PurplePlanetEdge pixel for the zone
    ZoneColour := this.GetColourByName("Purple Planet Edge")
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
        ;Points.Areas.EnergyBelt.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local PurplePlanetEdgeLeaf := this.FindPurplePlanetEdgeZone()
        If (PurplePlanetEdgeLeaf) {
            this.ClickTravelButton(PurplePlanetEdgeLeaf, delay + extradelay)
        } Else {
            Out.I("Purple Planet Edge leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindPurplePlanetEdgeZone() {
        ; Change this if used
        ;return Rects.EnergyB.PurplePlanetEdgeTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Purple Planet Edge
        ;Button := Points.Areas.EnergyBelt.PurplePlanetEdge
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("Purple Planet Edge travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
