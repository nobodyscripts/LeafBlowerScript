#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheCelestialPlane class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheCelestialPlane extends Zone {
    ; The name of the zone for display purposes
    Name := "The Celestial Plane"
    ; The colour of the TheCelestialPlane pixel for the zone
    ZoneColour := this.GetColourByName("The Celestial Plane")
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
        ;Points.Areas.LeafGalaxy.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local TheCelestialPlaneLeaf := this.FindTheCelestialPlaneZone()
        If (TheCelestialPlaneLeaf) {
            this.ClickTravelButton(TheCelestialPlaneLeaf, delay + extradelay)
        } Else {
            Out.I("The Celestial Plane leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindTheCelestialPlaneZone() {
        ; Change this if used
        ;return Rects.LeafG.TheCelestialPlaneTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to The Celestial Plane
        ;Button := Points.Areas.LeafGalaxy.TheCelestialPlane
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("The Celestial Plane travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
